import 'package:hive/hive.dart';
import 'package:vulpack/models/person.dart';

@HiveType(typeId: 1) // Unique typeId (different from Item's typeId: 0)
class Trip extends HiveObject {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final String destination;
  
  @HiveField(2)
  final DateTime fromDate;
  
  @HiveField(3)
  final int amountOfNights;
  
  @HiveField(4)
  final String category;
  
  @HiveField(5)
  final List<Person> persons;
  
  @HiveField(6)
  final List<String> activities;

  Trip({
    required this.title,
    required this.destination,
    required this.fromDate,
    required this.amountOfNights,
    required this.category,
    required this.persons,
    required this.activities,
  });

  // Computed property for end date
  DateTime get toDate => fromDate.add(Duration(days: amountOfNights));

  // Factory constructor for creating Trip from JSON
  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      title: json['title'] ?? '',
      destination: json['destination'] ?? '',
      fromDate: DateTime.parse(json['fromDate']),
      amountOfNights: json['amountOfNights'] ?? 0,
      category: json['category'] ?? '',
      persons: (json['persons'] as List<dynamic>?)
          ?.map((person) => Person.fromJson(person))
          .toList() ?? [],
      activities: (json['activities'] as List<dynamic>?)
          ?.cast<String>() ?? [],
    );
  }

  // Method to convert Trip to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'destination': destination,
      'fromDate': fromDate.toIso8601String(),
      'amountOfNights': amountOfNights,
      'category': category,
      'persons': persons.map((person) => person.toJson()).toList(),
      'activities': activities,
    };
  }

  @override
  String toString() {
    return 'Trip(title: $title, destination: $destination, fromDate: $fromDate, nights: $amountOfNights, persons: ${persons.length})';
  }
}