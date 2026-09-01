import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/asset.dart';
import '../models/maintenance.dart';
import '../models/valuation.dart';

class AssetService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Assets collection reference
  CollectionReference get _assetsCollection => _firestore.collection('assets');
  CollectionReference get _maintenanceCollection =>
      _firestore.collection('maintenance');
  CollectionReference get _valuationsCollection =>
      _firestore.collection('valuations');

  // Create asset
  Future<String> createAsset(Asset asset) async {
    try {
      final docRef = await _assetsCollection.add(asset.toFirestore());
      return docRef.id;
    } catch (e) {
      throw 'Failed to create asset: $e';
    }
  }

  // Get all assets for user
  Stream<List<Asset>> getUserAssets(String userId) {
    return _assetsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Asset.fromFirestore(doc)).toList());
  }

  // Get single asset
  Future<Asset?> getAsset(String assetId) async {
    try {
      final doc = await _assetsCollection.doc(assetId).get();
      if (doc.exists) {
        return Asset.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw 'Failed to get asset: $e';
    }
  }

  // Update asset
  Future<void> updateAsset(String assetId, Asset asset) async {
    try {
      await _assetsCollection
          .doc(assetId)
          .update(asset.copyWith(updatedAt: DateTime.now()).toFirestore());
    } catch (e) {
      throw 'Failed to update asset: $e';
    }
  }

  // Delete asset
  Future<void> deleteAsset(String assetId) async {
    try {
      await _assetsCollection.doc(assetId).delete();
      // Also delete related maintenance and valuations
      final maintenanceDocs = await _maintenanceCollection
          .where('assetId', isEqualTo: assetId)
          .get();
      for (var doc in maintenanceDocs.docs) {
        await doc.reference.delete();
      }
      final valuationDocs = await _valuationsCollection
          .where('assetId', isEqualTo: assetId)
          .get();
      for (var doc in valuationDocs.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw 'Failed to delete asset: $e';
    }
  }

  // Maintenance methods
  Future<String> createMaintenance(Maintenance maintenance) async {
    try {
      final docRef =
          await _maintenanceCollection.add(maintenance.toFirestore());
      return docRef.id;
    } catch (e) {
      throw 'Failed to create maintenance: $e';
    }
  }

  Stream<List<Maintenance>> getAssetMaintenance(String assetId) {
    return _maintenanceCollection
        .where('assetId', isEqualTo: assetId)
        .orderBy('scheduledDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Maintenance.fromFirestore(doc))
            .toList());
  }

  Future<void> updateMaintenance(
      String maintenanceId, Maintenance maintenance) async {
    try {
      await _maintenanceCollection
          .doc(maintenanceId)
          .update(maintenance.toFirestore());
    } catch (e) {
      throw 'Failed to update maintenance: $e';
    }
  }

  // Valuation methods
  Future<String> createValuation(Valuation valuation) async {
    try {
      final docRef =
          await _valuationsCollection.add(valuation.toFirestore());
      return docRef.id;
    } catch (e) {
      throw 'Failed to create valuation: $e';
    }
  }

  Stream<List<Valuation>> getAssetValuations(String assetId) {
    return _valuationsCollection
        .where('assetId', isEqualTo: assetId)
        .orderBy('valuationDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Valuation.fromFirestore(doc))
            .toList());
  }
}
