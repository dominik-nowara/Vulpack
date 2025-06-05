import '../../../models/person.dart';
import '../../../models/item.dart';

abstract class PersonRepository {
  // Basic CRUD operations
  Future<String> create(Person person);
  Future<List<Person>> getAll();
  Future<Person?> getById(String id);
  Future<void> update(String id, Person person);
  Future<void> delete(String id);
  Future<void> deleteAll();
  Future<int> count();
  
  // Person-specific queries
  Future<Person?> findByName(String name);
  Future<List<Person>> getByGender(String gender);
  Future<List<Person>> getByAgeRange(int minAge, int maxAge);
  Future<List<Person>> getBySweatLevel(String sweatLevel);
  Future<List<Person>> getWithImages();
  Future<List<Person>> searchByName(String searchTerm);
  Future<List<Person>> getWithEssentialItem(String itemName);
  Future<List<Person>> getWithCabinApprovedItems();
  Future<bool> existsByName(String name);
  Future<void> deleteByName(String name);
  Future<bool> updateByName(String name, Person updatedPerson);
  
  // Essential items management
  Future<bool> addEssentialItem(String personName, Item item);
  Future<bool> removeEssentialItem(String personName, String itemName);
  Future<bool> updateEssentialItems(String personName, List<Item> newItems);
  
  // Statistics and analytics
  Future<Map<String, dynamic>> getStatistics();
  Future<List<String>> getAllGenders();
  Future<List<String>> getAllSweatLevels();
  
  // Batch operations
  Future<List<String>> createMultiple(List<Person> persons);
  Future<void> createPersonsFromJson(List<Map<String, dynamic>> jsonList);
  Future<List<Map<String, dynamic>>> exportToJson();
  
  // Reactive streams
  Stream<List<Person>> watchAll();
  Stream<Person?> watchById(String id);
}