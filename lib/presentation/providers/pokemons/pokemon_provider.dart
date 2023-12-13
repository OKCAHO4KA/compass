import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/domain/domain.dart';

import '../../../infrastructure/infrastructure.dart';

final pokemonsRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonsRepositoryImpl();
});

final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
  final pokemonsRepository = ref.watch(pokemonsRepositoryProvider);
  final (pokemon, error) =
      await pokemonsRepository.getPokemon(id); // record (Pokemons, string)

  if (pokemon != null) return pokemon;
  throw error;
});
