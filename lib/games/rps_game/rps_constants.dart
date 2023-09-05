import '../../constants/assets_char.dart';
import '../../constants/assets_icon.dart';

enum RpsGameCharacter {
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
  const RpsGameCharacter(
      {required this.name, required this.front, required this.back});
}

enum Choice {
  rock(
      img: AssetsIcon.handRock,
      skillName: 'Rock Meteor',
      skillImg: AssetsIcon.rock),
  paper(
      img: AssetsIcon.handPaper,
      skillName: 'Paper Water',
      skillImg: AssetsIcon.paper),
  scissors(
      img: AssetsIcon.handSiccor,
      skillName: 'Sacred Siccors',
      skillImg: AssetsIcon.siccor);

  final String img;
  final String skillName;
  final String skillImg;
  const Choice(
      {required this.img, required this.skillName, required this.skillImg});
}
