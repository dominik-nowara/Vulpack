import 'dart:async';
import 'package:hive/hive.dart';
import '../../models/trip.dart';
import '../../models/person.dart';
import '../interfaces/trip_repository.dart';

class HiveTripRepository implements TripRepository {
  static final HiveTripRepository _instance = HiveTripRepository._internal();
  factory HiveTripRepository() => _instance;
  HiveTripRepository._internal();
  
  static const String _boxName = 'trips';
  
  Future<Box<Trip>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Trip>(_boxName);
    }
    return Hive.box<Trip>(_boxName);
  }
  
  @override
  Future<String> create(Trip trip) async {
    final box = await _getBox();
    final key = await box.add(trip);
    return key.toString();
  }
  
  @override
  Future<List<Trip>> getAll() async {
    final box = await _getBox();
    return box.values.toList();
  }
  
  @override
  Future<Trip?> getById(String id) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      return box.getAt(index);
    }
    return null;
  }
  
  @override
  Future<void> update(String id, Trip trip) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      await box.putAt(index, trip);
    }
  }
  
  @override
  Future<void> delete(String id) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      await box.deleteAt(index);
    }
  }
  
  @override
  Future<void> deleteAll() async {
    final box = await _getBox();
    await box.clear();
  }
  
  @override
  Future<int> count() async {
    final box = await _getBox();
    return box.length;
  }
  
  @override
  Future<List<Trip>> getByCategory(String category) async {
    final trips = await getAll();
    return trips.where((trip) => trip.category.toLowerCase() == category.toLowerCase()).toList();
  }
  
  @override
  Future<List<Trip>> getByDestination(String destination) async {
    final trips = await getAll();
    return trips.where((trip) => 
        trip.destination.toLowerCase().contains(destination.toLowerCase())).toList();
  }
  
  @override
  Future<List<Trip>> getUpcoming() async {
    final trips = await getAll();
    final now = DateTime.now();
    return trips.where((trip) => trip.fromDate.isAfter(now)).toList()
      ..sort((a, b) => a.fromDate.compareTo(b.fromDate));
  }
  
  @override
  Future<List<Trip>> getPast() async {
    final trips = await getAll();
    final now = DateTime.now();
    return trips.where((trip) => trip.toDate.isBefore(now)).toList()
      ..sort((a, b) => b.fromDate.compareTo(a.fromDate));
  }
  
  @override
  Future<List<Trip>> getCurrent() async {
    final trips = await getAll();
    final now = DateTime.now();
    return trips.where((trip) => 
        trip.fromDate.isBefore(now) && trip.toDate.isAfter(now)).toList();
  }
  
  @override
  Future<List<Trip>> getByDateRange(DateTime startDate, DateTime endDate) async {
    final trips = await getAll();
    return trips.where((trip) => 
        trip.fromDate.isAfter(startDate) && trip.fromDate.isBefore(endDate)).toList()
      ..sort((a, b) => a.fromDate.compareTo(b.fromDate));
  }
  
  @override
  Future<List<Trip>> getByPersonName(String personName) async {
    final trips = await getAll();
    return trips.where((trip) => 
        trip.persons.any((person) => 
            person.name.toLowerCase() == personName.toLowerCase())).toList();
  }
  
  @override
  Future<List<Trip>> getWithActivity(String activity) async {
    final trips = await getAll();
    return trips.where((trip) => 
        trip.activities.any((act) => 
            act.toLowerCase().contains(activity.toLowerCase()))).toList();
  }
  
  @override
  Future<List<Trip>> searchByTitle(String searchTerm) async {
    final trips = await getAll();
    return trips.where((trip) => 
        trip.title.toLowerCase().contains(searchTerm.toLowerCase())).toList();
  }
  
  @override
  Future<Trip?> findByTitle(String title) async {
    final trips = await getAll();
    try {
      return trips.firstWhere((trip) => trip.title.toLowerCase() == title.toLowerCase());
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<Trip>> getByDuration(int minNights, int maxNights) async {
    final trips = await getAll();
    return trips.where((trip) => 
        trip.amountOfNights >= minNights && trip.amountOfNights <= maxNights).toList();
  }
  
  @override
  Future<List<Trip>> getByTravelerCount(int minCount, int maxCount) async {
    final trips = await getAll();
    return trips.where((trip) => 
        trip.persons.length >= minCount && trip.persons.length <= maxCount).toList();
  }
  
  @override
  Future<bool> existsByTitle(String title) async {
    final trip = await findByTitle(title);
    return trip != null;
  }
  
  @override
  Future<void> deleteByTitle(String title) async {
    final box = await _getBox();
    final trips = box.values.toList();
    
    for (int i = 0; i < trips.length; i++) {
      if (trips[i].title.toLowerCase() == title.toLowerCase()) {
        await box.deleteAt(i);
        break;
      }
    }
  }
  
  @override
  Future<bool> updateByTitle(String title, Trip updatedTrip) async {
    final box = await _getBox();
    final trips = box.values.toList();
    
    for (int i = 0; i < trips.length; i++) {
      if (trips[i].title.toLowerCase() == title.toLowerCase()) {
        await box.putAt(i, updatedTrip);
        return true;
      }
    }
    return false;
  }
  
  @override
  Future<bool> addPersonToTrip(String tripTitle, Person person) async {
    final trip = await findByTitle(tripTitle);
    if (trip != null) {
      final updatedPersons = List<Person>.from(trip.persons)..add(person);
      final updatedTrip = Trip(
        title: trip.title,
        destination: trip.destination,
        fromDate: trip.fromDate,
        amountOfNights: trip.amountOfNights,
        category: trip.category,
        persons: updatedPersons,
        activities: trip.activities,
      );
      return await updateByTitle(tripTitle, updatedTrip);
    }
    return false;
  }
  
  @override
  Future<bool> removePersonFromTrip(String tripTitle, String personName) async {
    final trip = await findByTitle(tripTitle);
    if (trip != null) {
      final updatedPersons = trip.persons
          .where((person) => person.name.toLowerCase() != personName.toLowerCase())
          .toList();
      final updatedTrip = Trip(
        title: trip.title,
        destination: trip.destination,
        fromDate: trip.fromDate,
        amountOfNights: trip.amountOfNights,
        category: trip.category,
        persons: updatedPersons,
        activities: trip.activities,
      );
      return await updateByTitle(tripTitle, updatedTrip);
    }
    return false;
  }
  
  @override
  Future<bool> addActivityToTrip(String tripTitle, String activity) async {
    final trip = await findByTitle(tripTitle);
    if (trip != null) {
      final updatedActivities = List<String>.from(trip.activities);
      if (!updatedActivities.contains(activity)) {
        updatedActivities.add(activity);
        final updatedTrip = Trip(
          title: trip.title,
          destination: trip.destination,
          fromDate: trip.fromDate,
          amountOfNights: trip.amountOfNights,
          category: trip.category,
          persons: trip.persons,
          activities: updatedActivities,
        );
        return await updateByTitle(tripTitle, updatedTrip);
      }
    }
    return false;
  }
  
  @override
  Future<bool> removeActivityFromTrip(String tripTitle, String activity) async {
    final trip = await findByTitle(tripTitle);
    if (trip != null) {
      final updatedActivities = trip.activities
          .where((act) => act.toLowerCase() != activity.toLowerCase())
          .toList();
      final updatedTrip = Trip(
        title: trip.title,
        destination: trip.destination,
        fromDate: trip.fromDate,
        amountOfNights: trip.amountOfNights,
        category: trip.category,
        persons: trip.persons,
        activities: updatedActivities,
      );
      return await updateByTitle(tripTitle, updatedTrip);
    }
    return false;
  }
  
  @override
  Future<Map<String, dynamic>> getStatistics() async {
    final trips = await getAll();
    
    if (trips.isEmpty) {
      return {
        'total': 0,
        'upcoming': 0,
        'past': 0,
        'current': 0,
        'averageDuration': 0.0,
        'averageTravelers': 0.0,
        'categoryDistribution': <String, int>{},
        'destinationDistribution': <String, int>{},
        'totalTravelers': 0,
        'totalActivities': 0,
        'averageActivities': 0.0,
      };
    }
    
    final now = DateTime.now();
    final upcoming = trips.where((trip) => trip.fromDate.isAfter(now)).length;
    final past = trips.where((trip) => trip.toDate.isBefore(now)).length;
    final current = trips.where((trip) => 
        trip.fromDate.isBefore(now) && trip.toDate.isAfter(now)).length;
    
    final categoryDistribution = <String, int>{};
    final destinationDistribution = <String, int>{};
    int totalTravelers = 0;
    int totalActivities = 0;
    
    for (final trip in trips) {
      categoryDistribution[trip.category] = (categoryDistribution[trip.category] ?? 0) + 1;
      destinationDistribution[trip.destination] = (destinationDistribution[trip.destination] ?? 0) + 1;
      totalTravelers += trip.persons.length;
      totalActivities += trip.activities.length;
    }
    
    final averageDuration = trips.map((t) => t.amountOfNights).reduce((a, b) => a + b) / trips.length;
    final averageTravelers = totalTravelers / trips.length;
    
    return {
      'total': trips.length,
      'upcoming': upcoming,
      'past': past,
      'current': current,
      'averageDuration': averageDuration,
      'averageTravelers': averageTravelers,
      'categoryDistribution': categoryDistribution,
      'destinationDistribution': destinationDistribution,
      'totalTravelers': totalTravelers,
      'totalActivities': totalActivities,
      'averageActivities': totalActivities / trips.length,
    };
  }
  
  @override
  Future<List<String>> getAllCategories() async {
    final trips = await getAll();
    return trips.map((trip) => trip.category).toSet().toList()..sort();
  }
  
  @override
  Future<List<String>> getAllDestinations() async {
    final trips = await getAll();
    return trips.map((trip) => trip.destination).toSet().toList()..sort();
  }
  
  @override
  Future<List<String>> getAllActivities() async {
    final trips = await getAll();
    final allActivities = <String>{};
    for (final trip in trips) {
      allActivities.addAll(trip.activities);
    }
    return allActivities.toList()..sort();
  }
  
  @override
  Future<List<String>> createMultiple(List<Trip> trips) async {
    final box = await _getBox();
    final keys = <String>[];
    for (final trip in trips) {
      final key = await box.add(trip);
      keys.add(key.toString());
    }
    return keys;
  }
  
  @override
  Future<void> createTripsFromJson(List<Map<String, dynamic>> jsonList) async {
    final trips = jsonList.map((json) => Trip.fromJson(json)).toList();
    await createMultiple(trips);
  }
  
  @override
  Future<List<Map<String, dynamic>>> exportToJson() async {
    final trips = await getAll();
    return trips.map((trip) => trip.toJson()).toList();
  }
  
  @override
  Stream<List<Trip>> watchAll() async* {
    final box = await _getBox();
    yield box.values.toList();
    yield* box.watch().map((event) => box.values.toList());
  }
  
  @override
  Stream<Trip?> watchById(String id) async* {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null) {
      yield index < box.length ? box.getAt(index) : null;
      yield* box.watch(key: index).map((event) => event.value as Trip?);
    } else {
      yield null;
    }
  }
}