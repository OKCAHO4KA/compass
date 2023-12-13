import 'package:miscelaneos/domain/domain.dart';

import '../models/pokeapi_pokemon_response.dart';

class PokemonMapper {
  static Pokemon pokeApiPokemonToEntity(Map<String, dynamic> json) {
    final pokeApiPokemon = PokemonResponse.fromJson(json);
    return Pokemon(
        name: pokeApiPokemon.name,
        spriteFront: pokeApiPokemon.sprites.frontDefault,
        id: pokeApiPokemon.id);
  }
}
