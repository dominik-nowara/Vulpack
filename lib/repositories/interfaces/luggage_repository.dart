import '../../models/luggage.dart';

abstract class LuggageRepository {
  // Basic CRUD operations
  Future<String> create(Luggage luggage);
  Future<List<Luggage>> getAll();
  Future<Luggage?> getById(String id);
  Future<void> update(String id, Luggage luggage);
  Future<void> delete(String id);
  Future<void> deleteAll();
  Future<int> count();
  
  // Luggage-specific queries
  Future<List<Luggage>> getByCategory(String category);
  Future<List<Luggage>> getCarryOnAppropriate();
  Future<List<Luggage>> getCheckedOnly();
  Future<List<Luggage>> getWithImages();
  Future<List<Luggage>> searchByTitle(String searchTerm);
  Future<Luggage?> findByTitle(String title);
  Future<bool> existsByTitle(String title);
  Future<void> deleteByTitle(String title);
  Future<bool> updateByTitle(String title, Luggage updatedLuggage);
  
  // Statistics and analytics
  Future<Map<String, dynamic>> getStatistics();
  Future<List<String>> getAllCategories();
  
  // Batch operations
  Future<List<String>> createMultiple(List<Luggage> luggage);
  Future<void> createLuggageFromJson(List<Map<String, dynamic>> jsonList);
  Future<List<Map<String, dynamic>>> exportToJson();
  
  // Reactive streams
  Stream<List<Luggage>> watchAll();
  Stream<Luggage?> watchById(String id);
}