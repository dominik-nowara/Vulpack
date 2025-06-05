import 'package:hive/hive.dart';

@HiveType(typeId: 3) // Unique typeId (Item: 0, Trip: 1, Person: 2, Luggage: 3)
class Luggage extends HiveObject {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final String? image; // Optional image path/URL
  
  @HiveField(2)
  final bool carryOnAppropriate;
  
  @HiveField(3)
  final String category;

  Luggage({
    required this.title,
    this.image,
    required this.carryOnAppropriate,
    required this.category,
  });

  // Factory constructor for creating Luggage from JSON
  factory Luggage.fromJson(Map<String, dynamic> json) {
    return Luggage(
      title: json['title'] ?? '',
      image: json['image'],
      carryOnAppropriate: json['carryOnAppropriate'] ?? false,
      category: json['category'] ?? '',
    );
  }

  // Method to convert Luggage to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'carryOnAppropriate': carryOnAppropriate,
      'category': category,
    };
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'Luggage(title: $title, category: $category, carryOnAppropriate: $carryOnAppropriate)';
  }
}