import 'package:flutter/material.dart';
import 'package:muitsu_arked/games/rps_game/rps_constants.dart';
import 'package:muitsu_arked/platform_image.dart';

import '../../../constants/assets_color.dart';

class RpsHealthBar extends StatelessWidget {
  const RpsHealthBar(
      {super.key,
      required this.playerHp,
      this.width = 300,
      this.height = 100,
      required this.playerName,
      this.maxHp = 5,
      this.isEnemy = false,
      this.character = RpsGameCharacter.rimuru});

  final int playerHp;
  final bool isEnemy;
  final int maxHp;
  final double? width;
  final double? height;
  final String playerName;
  final RpsGameCharacter character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          // color: AssetsColor.blackMatte.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 76,
            child: Column(
              crossAxisAlignment:
                  isEnemy ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      right: isEnemy ? 8 : 25, left: isEnemy ? 25 : 8),
                  decoration: BoxDecoration(
                    color: AssetsColor.darkBlue,
                    border: Border.all(color: AssetsColor.whiteMatte, width: 0),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(isEnemy ? 0 : 50),
                        topLeft: Radius.circular(isEnemy ? 50 : 0)),
                  ),
                  child: Text(
                    playerName,
                    style: const TextStyle(color: AssetsColor.whiteMatte),
                  ),
                ),
                linearProgressBar(20, 130,
                    value: (playerHp / maxHp).clamp(0, 1)),
                Align(
                  alignment:
                      isEnemy ? Alignment.centerLeft : Alignment.centerRight,
                  child: Text(
                    '${playerHp.clamp(0, maxHp)}/$maxHp',
                    style: const TextStyle(color: AssetsColor.whiteMatte),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: isEnemy ? 0 : null,
            child: Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AssetsColor.whiteMatte, width: 3),
                      shape: BoxShape.circle,
                      color: AssetsColor.darkBlue),
                  child: Center(
                    child: PlatformAwareAssetImage(asset: character.front),
                  ),
                ),
                Visibility(
                  visible: playerHp.clamp(0, maxHp) == 0,
                  child: const Icon(
                    Icons.block,
                    color: Colors.redAccent,
                    size: 80,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  linearProgressBar(double height, double width, {required double value}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: AssetsColor.whiteMatte, width: 2),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(isEnemy ? 0 : 50),
            bottomLeft: Radius.circular(isEnemy ? 50 : 0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(isEnemy ? 0 : 50),
            bottomLeft: Radius.circular(isEnemy ? 50 : 0)),
        child: LinearProgressIndicator(
          value: value,
          color: playerHp == 1
              ? Colors.red
              : playerHp <= 3
                  ? Colors.amberAccent
                  : Colors.green,
          backgroundColor: Colors.grey.shade400,
        ),
      ),
    );
  }
}
