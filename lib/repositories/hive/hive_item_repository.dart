import 'dart:async';
import 'package:hive/hive.dart';
import '../../models/item.dart';
import '../interfaces/item_repository.dart';

class HiveItemRepository implements ItemRepository {
  static final HiveItemRepository _instance = HiveItemRepository._internal();
  factory HiveItemRepository() => _instance;
  HiveItemRepository._internal();
  
  static const String _boxName = 'items';
  
  Future<Box<Item>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Item>(_boxName);
    }
    return Hive.box<Item>(_boxName);
  }
  
  @override
  Future<String> create(Item item) async {
    final box = await _getBox();
    final key = await box.add(item);
    return key.toString();
  }
  
  @override
  Future<List<Item>> getAll() async {
    final box = await _getBox();
    return box.values.toList();
  }
  
  @override
  Future<Item?> getById(String id) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      return box.getAt(index);
    }
    return null;
  }
  
  @override
  Future<void> update(String id, Item item) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      await box.putAt(index, item);
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
  Future<List<Item>> getByCategory(String category) async {
    final items = await getAll();
    return items.where((item) => item.category.toLowerCase() == category.toLowerCase()).toList();
  }
  
  @override
  Future<List<Item>> getCabinApproved() async {
    final items = await getAll();
    return items.where((item) => item.cabinApproved).toList();
  }
  
  @override
  Future<List<Item>> getCheckedOnly() async {
    final items = await getAll();
    return items.where((item) => !item.cabinApproved).toList();
  }
  
  @override
  Future<List<Item>> searchByName(String searchTerm) async {
    final items = await getAll();
    return items.where((item) => 
        item.name.toLowerCase().contains(searchTerm.toLowerCase())).toList();
  }
  
  @override
  Future<Item?> findByName(String name) async {
    final items = await getAll();
    try {
      return items.firstWhere((item) => item.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<String>> getAllCategories() async {
    final items = await getAll();
    return items.map((item) => item.category).toSet().toList()..sort();
  }
  
  @override
  Future<Map<String, List<Item>>> groupByCategory() async {
    final items = await getAll();
    final Map<String, List<Item>> grouped = {};
    
    for (final item in items) {
      if (!grouped.containsKey(item.category)) {
        grouped[item.category] = [];
      }
      grouped[item.category]!.add(item);
    }
    
    return grouped;
  }
  
  @override
  Future<bool> existsByName(String name) async {
    final item = await findByName(name);
    return item != null;
  }
  
  @override
  Future<void> deleteByName(String name) async {
    final box = await _getBox();
    final items = box.values.toList();
    
    for (int i = 0; i < items.length; i++) {
      if (items[i].name.toLowerCase() == name.toLowerCase()) {
        await box.deleteAt(i);
        break;
      }
    }
  }
  
  @override
  Future<bool> updateByName(String name, Item updatedItem) async {
    final box = await _getBox();
    final items = box.values.toList();
    
    for (int i = 0; i < items.length; i++) {
      if (items[i].name.toLowerCase() == name.toLowerCase()) {
        await box.putAt(i, updatedItem);
        return true;
      }
    }
    return false;
  }
  
  @override
  Future<Map<String, dynamic>> getStatistics() async {
    final items = await getAll();
    final cabinApprovedCount = items.where((item) => item.cabinApproved).length;
    final categoryDistribution = <String, int>{};
    
    for (final item in items) {
      categoryDistribution[item.category] = (categoryDistribution[item.category] ?? 0) + 1;
    }
    
    return {
      'total': items.length,
      'cabinApproved': cabinApprovedCount,
      'checkedOnly': items.length - cabinApprovedCount,
      'cabinApprovedPercentage': items.isEmpty ? 0.0 : (cabinApprovedCount / items.length * 100),
      'categoryDistribution': categoryDistribution,
      'categoriesCount': categoryDistribution.length,
    };
  }
  
  @override
  Future<List<String>> createMultiple(List<Item> items) async {
    final box = await _getBox();
    final keys = <String>[];
    for (final item in items) {
      final key = await box.add(item);
      keys.add(key.toString());
    }
    return keys;
  }
  
  @override
  Future<void> createItemsFromJson(List<Map<String, dynamic>> jsonList) async {
    final items = jsonList.map((json) => Item.fromJson(json)).toList();
    await createMultiple(items);
  }
  
  @override
  Future<List<Map<String, dynamic>>> exportToJson() async {
    final items = await getAll();
    return items.map((item) => item.toJson()).toList();
  }
  
  @override
  Stream<List<Item>> watchAll() async* {
    final box = await _getBox();
    yield box.values.toList();
    yield* box.watch().map((event) => box.values.toList());
  }
  
  @override
  Stream<Item?> watchById(String id) async* {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null) {
      yield index < box.length ? box.getAt(index) : null;
      yield* box.watch(key: index).map((event) => event.value as Item?);
    } else {
      yield null;
    }
  }
}
