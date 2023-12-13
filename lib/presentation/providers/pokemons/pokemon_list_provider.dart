import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonIdsProvider =
    StateProvider<List<int>>((ref) => List.generate(30, (index) => index + 1));
