import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/infrastructure/infrastructure.dart';

import '../../../domain/domain.dart';

final pokemonDbProvider =
    FutureProvider.autoDispose<List<Pokemon>>((ref) async {
  final localDb = LocalDbRepositoryImpl();
  final pokemons = await localDb.loadPokemons();
  return pokemons;
});
