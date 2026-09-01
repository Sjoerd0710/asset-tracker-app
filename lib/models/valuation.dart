import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Valuation extends Equatable {
  final String id;
  final String assetId;
  final double value;
  final DateTime valuationDate;
  final String? appraiser;
  final String? notes;
  final DateTime createdAt;

  const Valuation({
    required this.id,
    required this.assetId,
    required this.value,
    required this.valuationDate,
    this.appraiser,
    this.notes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        assetId,
        value,
        valuationDate,
        appraiser,
        notes,
        createdAt,
      ];

  factory Valuation.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Valuation(
      id: doc.id,
      assetId: data['assetId'] ?? '',
      value: (data['value'] ?? 0).toDouble(),
      valuationDate: (data['valuationDate'] as Timestamp).toDate(),
      appraiser: data['appraiser'],
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'assetId': assetId,
      'value': value,
      'valuationDate': Timestamp.fromDate(valuationDate),
      'appraiser': appraiser,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
