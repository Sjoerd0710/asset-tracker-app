import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String category; // car, boat, plane, property, jewelry, etc.
  final String? description;
  final double purchasePrice;
  final double currentValue;
  final DateTime purchaseDate;
  final String? location;
  final List<String> imageUrls;
  final Map<String, dynamic> specifications; // VIN, registration, etc.
  final DateTime createdAt;
  final DateTime updatedAt;

  const Asset({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    this.description,
    required this.purchasePrice,
    required this.currentValue,
    required this.purchaseDate,
    this.location,
    this.imageUrls = const [],
    this.specifications = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        category,
        description,
        purchasePrice,
        currentValue,
        purchaseDate,
        location,
        imageUrls,
        specifications,
        createdAt,
        updatedAt,
      ];

  factory Asset.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Asset(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      description: data['description'],
      purchasePrice: (data['purchasePrice'] ?? 0).toDouble(),
      currentValue: (data['currentValue'] ?? 0).toDouble(),
      purchaseDate: (data['purchaseDate'] as Timestamp).toDate(),
      location: data['location'],
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      specifications: data['specifications'] ?? {},
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'category': category,
      'description': description,
      'purchasePrice': purchasePrice,
      'currentValue': currentValue,
      'purchaseDate': Timestamp.fromDate(purchaseDate),
      'location': location,
      'imageUrls': imageUrls,
      'specifications': specifications,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Asset copyWith({
    String? id,
    String? userId,
    String? name,
    String? category,
    String? description,
    double? purchasePrice,
    double? currentValue,
    DateTime? purchaseDate,
    String? location,
    List<String>? imageUrls,
    Map<String, dynamic>? specifications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Asset(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      currentValue: currentValue ?? this.currentValue,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      location: location ?? this.location,
      imageUrls: imageUrls ?? this.imageUrls,
      specifications: specifications ?? this.specifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
