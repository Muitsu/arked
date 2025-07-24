import 'package:muitsu_arked/config/constants/others/assets_char.dart';

enum Characters {
  rimuru(
      name: 'Rimuru',
      back: AssetsChar.rimuruBack,
      front: AssetsChar.rimuruFront),
  skull(
      name: 'Skull', back: AssetsChar.skullBack, front: AssetsChar.skullFront),
  explorer(
      name: 'Explorer',
      back: AssetsChar.explorerBack,
      front: AssetsChar.explorerFront),
  greenSlime(
      name: 'Green Slime',
      back: AssetsChar.greenSlimeBack,
      front: AssetsChar.greenSlimeFront);

  final String name;
  final String back;
  final String front;

  const Characters({
    required this.name,
    required this.back,
    required this.front,
  });
}
