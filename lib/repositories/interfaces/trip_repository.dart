import '../../../models/trip.dart';
import '../../../models/person.dart';

abstract class TripRepository {
  // Basic CRUD operations
  Future<String> create(Trip trip);
  Future<List<Trip>> getAll();
  Future<Trip?> getById(String id);
  Future<void> update(String id, Trip trip);
  Future<void> delete(String id);
  Future<void> deleteAll();
  Future<int> count();
  
  // Trip-specific queries
  Future<List<Trip>> getByCategory(String category);
  Future<List<Trip>> getByDestination(String destination);
  Future<List<Trip>> getUpcoming();
  Future<List<Trip>> getPast();
  Future<List<Trip>> getCurrent();
  Future<List<Trip>> getByDateRange(DateTime startDate, DateTime endDate);
  Future<List<Trip>> getByPersonName(String personName);
  Future<List<Trip>> getWithActivity(String activity);
  Future<List<Trip>> searchByTitle(String searchTerm);
  Future<Trip?> findByTitle(String title);
  Future<List<Trip>> getByDuration(int minNights, int maxNights);
  Future<List<Trip>> getByTravelerCount(int minCount, int maxCount);
  Future<bool> existsByTitle(String title);
  Future<void> deleteByTitle(String title);
  Future<bool> updateByTitle(String title, Trip updatedTrip);
  
  // Trip management operations
  Future<bool> addPersonToTrip(String tripTitle, Person person);
  Future<bool> removePersonFromTrip(String tripTitle, String personName);
  Future<bool> addActivityToTrip(String tripTitle, String activity);
  Future<bool> removeActivityFromTrip(String tripTitle, String activity);
  
  // Statistics and analytics
  Future<Map<String, dynamic>> getStatistics();
  Future<List<String>> getAllCategories();
  Future<List<String>> getAllDestinations();
  Future<List<String>> getAllActivities();
  
  // Batch operations
  Future<List<String>> createMultiple(List<Trip> trips);
  Future<void> createTripsFromJson(List<Map<String, dynamic>> jsonList);
  Future<List<Map<String, dynamic>>> exportToJson();
  
  // Reactive streams
  Stream<List<Trip>> watchAll();
  Stream<Trip?> watchById(String id);
}