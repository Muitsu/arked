import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:muitsu_arked/games/rps_game/rps_constants.dart';
import '../../../constants/assets_color.dart';
import '../../../constants/assets_icon.dart';
import '../../../platform_image.dart';

class RpsCharacter extends StatelessWidget {
  final bool isEnemy;
  final bool showMove;
  final String asset;
  final RpsGameCharacter character;
  const RpsCharacter(
      {super.key,
      this.isEnemy = false,
      this.showMove = false,
      this.asset = AssetsIcon.handRock,
      this.character = RpsGameCharacter.rimuru});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Positioned(
        top: -70,
        left: isEnemy ? -40 : 40,
        child: Visibility(
          visible: showMove,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: AssetsColor.darkBlue,
                border: Border.all(color: AssetsColor.whiteMatte, width: 2),
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(16),
                  topLeft: const Radius.circular(16),
                  bottomLeft: Radius.circular(isEnemy ? 16 : 0),
                  bottomRight: Radius.circular(isEnemy ? 0 : 16),
                )),
            child: PlatformAwareAssetImage(
              asset: asset,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: -20,
        left: 10,
        child: Container(
          height: 20,
          width: 60,
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.elliptical(100, 50)),
          ),
        ),
      ),
      PlatformAwareAssetImage(
        width: 80,
        height: 80,
        fit: BoxFit.contain,
        asset: isEnemy ? character.front : character.back,
      )
          .animate(
            onPlay: (controller) => controller.repeat(),
          )
          .shakeY(
              delay: 600.ms,
              duration: const Duration(seconds: 20),
              curve: Curves.linear,
              hz: 1),
    ]);
  }
}
