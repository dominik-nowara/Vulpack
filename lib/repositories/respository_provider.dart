import '../repositories/interfaces/item_repository.dart';
import '../repositories/interfaces/person_repository.dart';
import '../repositories/interfaces/trip_repository.dart';
import '../repositories/interfaces/luggage_repository.dart';
import '../repositories/hive/hive_item_repository.dart';
import '../repositories/hive/hive_person_repository.dart';
import '../repositories/hive/hive_trip_repository.dart';
import '../repositories/hive/hive_luggage_repository.dart';

class RepositoryProvider {
  static final RepositoryProvider _instance = RepositoryProvider._internal();
  factory RepositoryProvider() => _instance;
  RepositoryProvider._internal();
  
  // Repository instances - can be swapped for different implementations
  late final ItemRepository itemRepository;
  late final PersonRepository personRepository;
  late final TripRepository tripRepository;
  late final LuggageRepository luggageRepository;
  
  void initialize({
    ItemRepository? itemRepo,
    PersonRepository? personRepo,
    TripRepository? tripRepo,
    LuggageRepository? luggageRepo,
  }) {
    // Use provided repositories or default to Hive implementations
    itemRepository = itemRepo ?? HiveItemRepository();
    personRepository = personRepo ?? HivePersonRepository();
    tripRepository = tripRepo ?? HiveTripRepository();
    luggageRepository = luggageRepo ?? HiveLuggageRepository();
  }
}