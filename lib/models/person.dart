import 'package:hive/hive.dart';
import 'package:vulpack/models/item.dart';

@HiveType(typeId: 2) // Unique typeId (Item: 0, Trip: 1, Person: 2)
class Person extends HiveObject {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final int age;
  
  @HiveField(2)
  final String gender;
  
  @HiveField(3)
  final String sweat; // Assuming this is sweat level or preference
  
  @HiveField(4)
  final String? image; // Optional image path/URL
  
  @HiveField(5)
  final List<Item> essentialItems;

  Person({
    required this.name,
    required this.age,
    required this.gender,
    required this.sweat,
    this.image,
    required this.essentialItems,
  });

  // Factory constructor for creating Person from JSON
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      sweat: json['sweat'] ?? '',
      image: json['image'],
      essentialItems: (json['essentialItems'] as List<dynamic>?)
          ?.map((item) => Item.fromJson(item))
          .toList() ?? [],
    );
  }

  // Method to convert Person to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'sweat': sweat,
      'image': image,
      'essentialItems': essentialItems.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Person(name: $name, age: $age, gender: $gender, sweat: $sweat, essentialItems: ${essentialItems.length} items)';
  }
}