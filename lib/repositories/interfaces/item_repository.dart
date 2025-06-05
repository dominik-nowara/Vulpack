import '../../models/item.dart';

abstract class ItemRepository {
  // Basic CRUD operations
  Future<String> create(Item item);
  Future<List<Item>> getAll();
  Future<Item?> getById(String id);
  Future<void> update(String id, Item item);
  Future<void> delete(String id);
  Future<void> deleteAll();
  Future<int> count();
  
  // Item-specific queries
  Future<List<Item>> getByCategory(String category);
  Future<List<Item>> getCabinApproved();
  Future<List<Item>> getCheckedOnly();
  Future<List<Item>> searchByName(String searchTerm);
  Future<Item?> findByName(String name);
  Future<List<String>> getAllCategories();
  Future<Map<String, List<Item>>> groupByCategory();
  Future<bool> existsByName(String name);
  Future<void> deleteByName(String name);
  Future<bool> updateByName(String name, Item updatedItem);
  Future<Map<String, dynamic>> getStatistics();
  
  // Batch operations
  Future<List<String>> createMultiple(List<Item> items);
  Future<void> createItemsFromJson(List<Map<String, dynamic>> jsonList);
  Future<List<Map<String, dynamic>>> exportToJson();
  
  // Reactive streams
  Stream<List<Item>> watchAll();
  Stream<Item?> watchById(String id);
}