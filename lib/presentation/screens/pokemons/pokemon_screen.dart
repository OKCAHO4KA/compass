import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

import '../../../domain/domain.dart';

class PokemonScreen extends ConsumerWidget {
  final String pokemonId;
  const PokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return pokemonAsync.when(
        data: (data) => _PokemonView(pokemon: data),
        error: (error, stackTrace) => _ErrorView(error.toString()),
        loading: () => const _LoadingView());
  }
}

class _PokemonView extends StatelessWidget {
  final Pokemon pokemon;
  const _PokemonView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                //link == deeplink
                SharePlugin.shareLink(
                    'https://pokemon-deeplink.up.railway.app/pokemons/${pokemon.id}/',
                    'Mira este pokemon');
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: Center(
        child: Image.network(pokemon.spriteFront,
            fit: BoxFit.contain, width: 240, height: 240),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String msg;
  const _ErrorView(this.msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(msg),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
