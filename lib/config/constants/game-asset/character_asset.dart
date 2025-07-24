import 'package:muitsu_arked/config/constants/others/assets_char.dart';

enum CharacterAsset {
  greenSlime(
      name: 'Howdy',
      front: AssetsChar.greenSlimeFront,
      back: AssetsChar.greenSlimeBack),

  explorer(
      name: 'Explora',
      front: AssetsChar.explorerFront,
      back: AssetsChar.explorerBack),
  skull(
      name: 'Angry Skull',
      front: AssetsChar.skullFront,
      back: AssetsChar.skullBack),
  rimuru(
      name: 'Rimuru',
      front: AssetsChar.rimuruFront,
      back: AssetsChar.rimuruBack);

  final String name;
  final String front;
  final String back;
  const CharacterAsset(
      {required this.name, required this.front, required this.back});
}
