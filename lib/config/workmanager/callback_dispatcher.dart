import 'package:miscelaneos/infrastructure/infrastructure.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = 'com.xana.miscelaneos.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey =
    'com.xana.miscelaneos.fetch-background-pokemon';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();
        // print('fetchBackgroundTaskKey');
        break;
      case fetchPeriodicBackgroundTaskKey:
        await loadNextPokemon();
        print('fetchPeriodicBackgroundTaskKey ddddddddddddddd');
        break;
      case Workmanager.iOSBackgroundTask:
        print('iOSBackgroundTask');
        break;
    }
    return true;

    // print(
    //     "Native: called background task: $task"); //simpleTask will be emitted here.
    // return Future.value(true);
  });
}

Future loadNextPokemon() async {
  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryImpl();
  final lastPokemonId = await localDbRepository.pokemonsCount() + 1;

  try {
    final (pokemon, msg) = await pokemonRepository.getPokemon('$lastPokemonId');
    if (pokemon == null) throw msg;
    await localDbRepository.insertPokemon(pokemon);
    print('pokemon inserted ${pokemon.name}');
  } catch (e) {
    print(e);
  }
}
