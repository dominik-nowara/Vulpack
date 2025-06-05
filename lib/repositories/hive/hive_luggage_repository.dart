import 'dart:async';
import 'package:hive/hive.dart';
import '../../models/luggage.dart';
import '../interfaces/luggage_repository.dart';

class HiveLuggageRepository implements LuggageRepository {
  static final HiveLuggageRepository _instance = HiveLuggageRepository._internal();
  factory HiveLuggageRepository() => _instance;
  HiveLuggageRepository._internal();
  
  static const String _boxName = 'luggage';
  
  Future<Box<Luggage>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Luggage>(_boxName);
    }
    return Hive.box<Luggage>(_boxName);
  }
  
  @override
  Future<String> create(Luggage luggage) async {
    final box = await _getBox();
    final key = await box.add(luggage);
    return key.toString();
  }
  
  @override
  Future<List<Luggage>> getAll() async {
    final box = await _getBox();
    return box.values.toList();
  }
  
  @override
  Future<Luggage?> getById(String id) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      return box.getAt(index);
    }
    return null;
  }
  
  @override
  Future<void> update(String id, Luggage luggage) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      await box.putAt(index, luggage);
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
  Future<List<Luggage>> getByCategory(String category) async {
    final luggage = await getAll();
    return luggage.where((item) => item.category.toLowerCase() == category.toLowerCase()).toList();
  }
  
  @override
  Future<List<Luggage>> getCarryOnAppropriate() async {
    final luggage = await getAll();
    return luggage.where((item) => item.carryOnAppropriate).toList();
  }
  
  @override
  Future<List<Luggage>> getCheckedOnly() async {
    final luggage = await getAll();
    return luggage.where((item) => !item.carryOnAppropriate).toList();
  }
  
  @override
  Future<List<Luggage>> getWithImages() async {
    final luggage = await getAll();
    return luggage.where((item) => item.image != null && item.image!.isNotEmpty).toList();
  }
  
  @override
  Future<List<Luggage>> searchByTitle(String searchTerm) async {
    final luggage = await getAll();
    return luggage.where((item) => 
        item.title.toLowerCase().contains(searchTerm.toLowerCase())).toList();
  }
  
  @override
  Future<Luggage?> findByTitle(String title) async {
    final luggage = await getAll();
    try {
      return luggage.firstWhere((item) => item.title.toLowerCase() == title.toLowerCase());
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<bool> existsByTitle(String title) async {
    final luggage = await findByTitle(title);
    return luggage != null;
  }
  
  @override
  Future<void> deleteByTitle(String title) async {
    final box = await _getBox();
    final luggage = box.values.toList();
    
    for (int i = 0; i < luggage.length; i++) {
      if (luggage[i].title.toLowerCase() == title.toLowerCase()) {
        await box.deleteAt(i);
        break;
      }
    }
  }
  
  @override
  Future<bool> updateByTitle(String title, Luggage updatedLuggage) async {
    final box = await _getBox();
    final luggage = box.values.toList();
    
    for (int i = 0; i < luggage.length; i++) {
      if (luggage[i].title.toLowerCase() == title.toLowerCase()) {
        await box.putAt(i, updatedLuggage);
        return true;
      }
    }
    return false;
  }
  
  @override
  Future<Map<String, dynamic>> getStatistics() async {
    final luggage = await getAll();
    
    if (luggage.isEmpty) {
      return {
        'total': 0,
        'carryOnCount': 0,
        'checkedCount': 0,
        'withImagesCount': 0,
        'carryOnPercentage': 0.0,
        'categoryDistribution': <String, int>{},
      };
    }
    
    final carryOnCount = luggage.where((l) => l.carryOnAppropriate).length;
    final checkedCount = luggage.length - carryOnCount;
    final withImagesCount = luggage.where((l) => l.image != null && l.image!.isNotEmpty).length;
    
    final categoryDistribution = <String, int>{};
    for (final item in luggage) {
      categoryDistribution[item.category] = (categoryDistribution[item.category] ?? 0) + 1;
    }
    
    return {
      'total': luggage.length,
      'carryOnCount': carryOnCount,
      'checkedCount': checkedCount,
      'withImagesCount': withImagesCount,
      'carryOnPercentage': (carryOnCount / luggage.length * 100),
      'categoryDistribution': categoryDistribution,
    };
  }
  
  @override
  Future<List<String>> getAllCategories() async {
    final luggage = await getAll();
    return luggage.map((item) => item.category).toSet().toList()..sort();
  }
  
  @override
  Future<List<String>> createMultiple(List<Luggage> luggage) async {
    final box = await _getBox();
    final keys = <String>[];
    for (final item in luggage) {
      final key = await box.add(item);
      keys.add(key.toString());
    }
    return keys;
  }
  
  @override
  Future<void> createLuggageFromJson(List<Map<String, dynamic>> jsonList) async {
    final luggage = jsonList.map((json) => Luggage.fromJson(json)).toList();
    await createMultiple(luggage);
  }
  
  @override
  Future<List<Map<String, dynamic>>> exportToJson() async {
    final luggage = await getAll();
    return luggage.map((item) => item.toJson()).toList();
  }
  
  @override
  Stream<List<Luggage>> watchAll() async* {
    final box = await _getBox();
    yield box.values.toList();
    yield* box.watch().map((event) => box.values.toList());
  }
  
  @override
  Stream<Luggage?> watchById(String id) async* {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null) {
      yield index < box.length ? box.getAt(index) : null;
      yield* box.watch(key: index).map((event) => event.value as Luggage?);
    } else {
      yield null;
    }
  }
}