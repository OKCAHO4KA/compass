import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/providers/pokemons/pokemon_list_provider.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PokemonsView(),
    );
  }
}

class _PokemonsView extends ConsumerStatefulWidget {
  @override
  ConsumerState<_PokemonsView> createState() => _PokemonsViewState();
}

class _PokemonsViewState extends ConsumerState<_PokemonsView> {
  final scrollController = ScrollController();

  void infiniteScroll() {
    final currentPokemons = ref.read(pokemonIdsProvider);
    if (currentPokemons.length > 400) {
      scrollController.removeListener(infiniteScroll);
      return;
    }
    if ((scrollController.position.pixels + 200) >
        scrollController.position.maxScrollExtent) {
      ref.read(pokemonIdsProvider.notifier).update((state) => [
            ...state,
            ...List.generate(30, (index) => state.length + index + 1)
          ]);
    }
  }

  @override
  void initState() {
    scrollController.addListener(infiniteScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        _PokemonGrid(),
      ],
    );
  }
}

class _PokemonGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final pokemonId = ref.watch(pokemonIdsProvider);
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemBuilder: (context, index) {
        return GestureDetector(
            child: Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png",
              fit: BoxFit.contain,
            ),
            onTap: () => context.push('/pokemons/${(index + 1).toString()}'));
      },
      itemCount: pokemonId.length,
    );
  }
}
