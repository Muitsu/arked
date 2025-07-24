import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:muitsu_arked/config/constants/game-asset/character_asset.dart';
import 'package:muitsu_arked/config/constants/others/assets_color.dart';
import 'package:muitsu_arked/config/constants/others/assets_icon.dart';
import 'package:muitsu_arked/modules/battle-field/character/character_image.dart';
import 'package:muitsu_arked/modules/battle-field/character/character_healthbar.dart';

class CharacterWidget extends StatefulWidget {
  final bool isEnemy;
  final bool showMove;
  final String playerMove;
  final CharacterAsset character;
  final AnimationController controller;
  final int currHp;
  final int maxHp;
  final double? width;
  final double? height;
  final String playerName;
  const CharacterWidget({
    super.key,
    this.isEnemy = false,
    this.showMove = false,
    this.playerMove = AssetsIcon.handRock,
    required this.currHp,
    this.width = 300,
    this.height = 100,
    required this.playerName,
    this.maxHp = 5,
    this.character = CharacterAsset.rimuru,
    required this.controller,
  });

  @override
  State<CharacterWidget> createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: widget.isEnemy ? 100 : 60,
            left: widget.isEnemy ? null : 230,
            right: widget.isEnemy ? 260 : null,
            child: Column(
              children: [
                widget.isEnemy
                    ? Column(children: [
                        Text(
                          widget.playerName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        linearProgressBar(10, 80,
                            value: (widget.currHp / widget.maxHp).clamp(0, 1))
                      ])
                        .animate(controller: widget.controller)
                        .shimmer()
                        .shake(hz: 4, curve: Curves.easeInOutCubic)
                        .scaleXY(end: 1.1)
                        .then(delay: 300.ms)
                        .scaleXY(end: 1 / 1.1)
                    : const SizedBox(),
                const SizedBox(height: 5),
                CharacterImage(
                  showMove: widget.showMove,
                  asset: widget.playerMove,
                  character: widget.character,
                  isEnemy: widget.isEnemy,
                ),
              ],
            ),
          ),
          widget.isEnemy
              ? const SizedBox()
              : Positioned(
                  bottom: widget.isEnemy ? null : 10,
                  left: widget.isEnemy ? null : 20,
                  top: widget.isEnemy ? 40 : null,
                  right: widget.isEnemy ? 0 : null,
                  child: CharacterHealthbar(
                    playerName: widget.playerName,
                    maxHp: widget.maxHp,
                    playerHp: widget.currHp,
                    character: widget.character,
                  )
                      .animate(controller: widget.controller)
                      .shimmer()
                      .shake(hz: 4, curve: Curves.easeInOutCubic)
                      .scaleXY(end: 1.1)
                      .then(delay: 300.ms)
                      .scaleXY(end: 1 / 1.1),
                ),
        ],
      ),
    );
  }

  linearProgressBar(double height, double width, {required double value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AssetsColor.whiteMatte, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: value,
              color: widget.currHp == 1
                  ? Colors.red
                  : widget.currHp <= 3
                      ? Colors.amberAccent
                      : Colors.green,
              backgroundColor: Colors.grey.shade400,
            ),
          ),
        ),
        Text(
          '${widget.currHp}/${widget.maxHp}',
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
