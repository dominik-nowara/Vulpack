import 'dart:async';
import 'package:hive/hive.dart';
import '../../models/person.dart';
import '../../models/item.dart';
import '../interfaces/person_repository.dart';

class HivePersonRepository implements PersonRepository {
  static final HivePersonRepository _instance = HivePersonRepository._internal();
  factory HivePersonRepository() => _instance;
  HivePersonRepository._internal();
  
  static const String _boxName = 'persons';
  
  Future<Box<Person>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Person>(_boxName);
    }
    return Hive.box<Person>(_boxName);
  }
  
  @override
  Future<String> create(Person person) async {
    final box = await _getBox();
    final key = await box.add(person);
    return key.toString();
  }
  
  @override
  Future<List<Person>> getAll() async {
    final box = await _getBox();
    return box.values.toList();
  }
  
  @override
  Future<Person?> getById(String id) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      return box.getAt(index);
    }
    return null;
  }
  
  @override
  Future<void> update(String id, Person person) async {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null && index >= 0 && index < box.length) {
      await box.putAt(index, person);
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
  Future<Person?> findByName(String name) async {
    final persons = await getAll();
    try {
      return persons.firstWhere((person) => person.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<Person>> getByGender(String gender) async {
    final persons = await getAll();
    return persons.where((person) => person.gender.toLowerCase() == gender.toLowerCase()).toList();
  }
  
  @override
  Future<List<Person>> getByAgeRange(int minAge, int maxAge) async {
    final persons = await getAll();
    return persons.where((person) => person.age >= minAge && person.age <= maxAge).toList();
  }
  
  @override
  Future<List<Person>> getBySweatLevel(String sweatLevel) async {
    final persons = await getAll();
    return persons.where((person) => person.sweat.toLowerCase() == sweatLevel.toLowerCase()).toList();
  }
  
  @override
  Future<List<Person>> getWithImages() async {
    final persons = await getAll();
    return persons.where((person) => person.image != null && person.image!.isNotEmpty).toList();
  }
  
  @override
  Future<List<Person>> searchByName(String searchTerm) async {
    final persons = await getAll();
    return persons.where((person) => 
        person.name.toLowerCase().contains(searchTerm.toLowerCase())).toList();
  }
  
  @override
  Future<List<Person>> getWithEssentialItem(String itemName) async {
    final persons = await getAll();
    return persons.where((person) => 
        person.essentialItems.any((item) => 
            item.name.toLowerCase().contains(itemName.toLowerCase()))).toList();
  }
  
  @override
  Future<List<Person>> getWithCabinApprovedItems() async {
    final persons = await getAll();
    return persons.where((person) => 
        person.essentialItems.any((item) => item.cabinApproved)).toList();
  }
  
  @override
  Future<bool> existsByName(String name) async {
    final person = await findByName(name);
    return person != null;
  }
  
  @override
  Future<void> deleteByName(String name) async {
    final box = await _getBox();
    final persons = box.values.toList();
    
    for (int i = 0; i < persons.length; i++) {
      if (persons[i].name.toLowerCase() == name.toLowerCase()) {
        await box.deleteAt(i);
        break;
      }
    }
  }
  
  @override
  Future<bool> updateByName(String name, Person updatedPerson) async {
    final box = await _getBox();
    final persons = box.values.toList();
    
    for (int i = 0; i < persons.length; i++) {
      if (persons[i].name.toLowerCase() == name.toLowerCase()) {
        await box.putAt(i, updatedPerson);
        return true;
      }
    }
    return false;
  }
  
  @override
  Future<bool> addEssentialItem(String personName, Item item) async {
    final person = await findByName(personName);
    if (person != null) {
      final updatedItems = List<Item>.from(person.essentialItems)..add(item);
      final updatedPerson = Person(
        name: person.name,
        age: person.age,
        gender: person.gender,
        sweat: person.sweat,
        image: person.image,
        essentialItems: updatedItems,
      );
      return await updateByName(personName, updatedPerson);
    }
    return false;
  }
  
  @override
  Future<bool> removeEssentialItem(String personName, String itemName) async {
    final person = await findByName(personName);
    if (person != null) {
      final updatedItems = person.essentialItems
          .where((item) => item.name.toLowerCase() != itemName.toLowerCase())
          .toList();
      final updatedPerson = Person(
        name: person.name,
        age: person.age,
        gender: person.gender,
        sweat: person.sweat,
        image: person.image,
        essentialItems: updatedItems,
      );
      return await updateByName(personName, updatedPerson);
    }
    return false;
  }
  
  @override
  Future<bool> updateEssentialItems(String personName, List<Item> newItems) async {
    final person = await findByName(personName);
    if (person != null) {
      final updatedPerson = Person(
        name: person.name,
        age: person.age,
        gender: person.gender,
        sweat: person.sweat,
        image: person.image,
        essentialItems: newItems,
      );
      return await updateByName(personName, updatedPerson);
    }
    return false;
  }
  
  @override
  Future<Map<String, dynamic>> getStatistics() async {
    final persons = await getAll();
    
    if (persons.isEmpty) {
      return {
        'total': 0,
        'averageAge': 0.0,
        'genderDistribution': <String, int>{},
        'sweatLevelDistribution': <String, int>{},
        'totalEssentialItems': 0,
        'averageEssentialItems': 0.0,
        'personsWithImages': 0,
        'personsWithImagesPercentage': 0.0,
      };
    }
    
    final genderDistribution = <String, int>{};
    final sweatLevelDistribution = <String, int>{};
    int totalEssentialItems = 0;
    int personsWithImages = 0;
    
    for (final person in persons) {
      genderDistribution[person.gender] = (genderDistribution[person.gender] ?? 0) + 1;
      sweatLevelDistribution[person.sweat] = (sweatLevelDistribution[person.sweat] ?? 0) + 1;
      totalEssentialItems += person.essentialItems.length;
      if (person.image != null && person.image!.isNotEmpty) {
        personsWithImages++;
      }
    }
    
    final averageAge = persons.map((p) => p.age).reduce((a, b) => a + b) / persons.length;
    final averageEssentialItems = totalEssentialItems / persons.length;
    
    return {
      'total': persons.length,
      'averageAge': averageAge,
      'genderDistribution': genderDistribution,
      'sweatLevelDistribution': sweatLevelDistribution,
      'totalEssentialItems': totalEssentialItems,
      'averageEssentialItems': averageEssentialItems,
      'personsWithImages': personsWithImages,
      'personsWithImagesPercentage': (personsWithImages / persons.length * 100),
    };
  }
  
  @override
  Future<List<String>> getAllGenders() async {
    final persons = await getAll();
    return persons.map((person) => person.gender).toSet().toList()..sort();
  }
  
  @override
  Future<List<String>> getAllSweatLevels() async {
    final persons = await getAll();
    return persons.map((person) => person.sweat).toSet().toList()..sort();
  }
  
  @override
  Future<List<String>> createMultiple(List<Person> persons) async {
    final box = await _getBox();
    final keys = <String>[];
    for (final person in persons) {
      final key = await box.add(person);
      keys.add(key.toString());
    }
    return keys;
  }
  
  @override
  Future<void> createPersonsFromJson(List<Map<String, dynamic>> jsonList) async {
    final persons = jsonList.map((json) => Person.fromJson(json)).toList();
    await createMultiple(persons);
  }
  
  @override
  Future<List<Map<String, dynamic>>> exportToJson() async {
    final persons = await getAll();
    return persons.map((person) => person.toJson()).toList();
  }
  
  @override
  Stream<List<Person>> watchAll() async* {
    final box = await _getBox();
    yield box.values.toList();
    yield* box.watch().map((event) => box.values.toList());
  }
  
  @override
  Stream<Person?> watchById(String id) async* {
    final box = await _getBox();
    final index = int.tryParse(id);
    if (index != null) {
      yield index < box.length ? box.getAt(index) : null;
      yield* box.watch(key: index).map((event) => event.value as Person?);
    } else {
      yield null;
    }
  }
}