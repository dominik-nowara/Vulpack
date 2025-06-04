import 'package:vulpack/models/person.dart';

class Trip {
  final String title;
  final String destination;
  final DateTime fromDate;
  final int amountOfNights;
  final String category;
  final List<Person> persons;
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