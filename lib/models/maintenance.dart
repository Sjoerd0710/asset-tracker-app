import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Maintenance extends Equatable {
  final String id;
  final String assetId;
  final String title;
  final String? description;
  final DateTime scheduledDate;
  final DateTime? completedDate;
  final double? cost;
  final String status; // scheduled, completed, overdue
  final String? vendor;
  final String? notes;
  final DateTime createdAt;

  const Maintenance({
    required this.id,
    required this.assetId,
    required this.title,
    this.description,
    required this.scheduledDate,
    this.completedDate,
    this.cost,
    required this.status,
    this.vendor,
    this.notes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        assetId,
        title,
        description,
        scheduledDate,
        completedDate,
        cost,
        status,
        vendor,
        notes,
        createdAt,
      ];

  factory Maintenance.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Maintenance(
      id: doc.id,
      assetId: data['assetId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'],
      scheduledDate: (data['scheduledDate'] as Timestamp).toDate(),
      completedDate: data['completedDate'] != null
          ? (data['completedDate'] as Timestamp).toDate()
          : null,
      cost: data['cost']?.toDouble(),
      status: data['status'] ?? 'scheduled',
      vendor: data['vendor'],
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'assetId': assetId,
      'title': title,
      'description': description,
      'scheduledDate': Timestamp.fromDate(scheduledDate),
      'completedDate': completedDate != null
          ? Timestamp.fromDate(completedDate!)
          : null,
      'cost': cost,
      'status': status,
      'vendor': vendor,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Maintenance copyWith({
    String? id,
    String? assetId,
    String? title,
    String? description,
    DateTime? scheduledDate,
    DateTime? completedDate,
    double? cost,
    String? status,
    String? vendor,
    String? notes,
    DateTime? createdAt,
  }) {
    return Maintenance(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      completedDate: completedDate ?? this.completedDate,
      cost: cost ?? this.cost,
      status: status ?? this.status,
      vendor: vendor ?? this.vendor,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
