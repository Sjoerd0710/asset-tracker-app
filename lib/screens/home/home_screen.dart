import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../services/asset_service.dart';
import '../../models/asset.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final assetService = context.read<AssetService>();
    final currentUser = authService.currentUser;

    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/');
      });
      return const Scaffold();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Assets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              if (mounted) {
                context.go('/');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: StreamBuilder<List<Asset>>(
              stream: assetService.getUserAssets(currentUser.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                final totalValue =
                    snapshot.data!.fold<double>(0, (sum, asset) => sum + asset.currentValue);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Portfolio Value',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '\$${totalValue.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.data!.length} assets',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
          ),
          // Assets list
          Expanded(
            child: StreamBuilder<List<Asset>>(
              stream: assetService.getUserAssets(currentUser.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.folder_open,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        const Text('No assets yet'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.go('/add-asset'),
                          child: const Text('Add Your First Asset'),
                        ),
                      ],
                    ),
                  );
                }

                final assets = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: assets.length,
                  itemBuilder: (context, index) {
                    final asset = assets[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: asset.imageUrls.isNotEmpty
                            ? Image.network(
                                asset.imageUrls.first,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(Icons.image),
                              ),
                        title: Text(asset.name),
                        subtitle: Text(
                          asset.category,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Text(
                          '\$${asset.currentValue.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () => context.go('/asset/${asset.id}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add-asset'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
