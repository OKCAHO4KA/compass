import 'package:isar/isar.dart';
part 'pokemon.g.dart';

@collection
class Pokemon {
  Id isarId = Isar.autoIncrement;
  final String name;
  final String spriteFront;
  final int id;

  Pokemon({required this.name, required this.spriteFront, required this.id});
}
