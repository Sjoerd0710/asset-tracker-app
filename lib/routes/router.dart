import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/assets/asset_detail_screen.dart';
import '../screens/assets/add_asset_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add-asset',
      builder: (context, state) => const AddAssetScreen(),
    ),
    GoRoute(
      path: '/asset/:assetId',
      builder: (context, state) => AssetDetailScreen(
        assetId: state.pathParameters['assetId']!,
      ),
    ),
  ],
  redirect: (context, state) {
    // Add auth redirect logic here
    return null;
  },
);
