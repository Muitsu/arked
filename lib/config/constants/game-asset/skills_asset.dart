import 'package:muitsu_arked/config/constants/others/assets_icon.dart';

enum SkillsAsset {
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
  const SkillsAsset(
      {required this.img, required this.skillName, required this.skillImg});
}
