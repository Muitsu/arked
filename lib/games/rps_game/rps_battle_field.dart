import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:muitsu_arked/constants/assets_bg.dart';
import 'package:muitsu_arked/constants/assets_color.dart';
import 'package:muitsu_arked/games/rps_game/rps_game_utils.dart';
import 'package:muitsu_arked/games/rps_game/widgets/rps_character.dart';
import 'package:muitsu_arked/games/rps_game/rps_constants.dart';
import 'package:muitsu_arked/games/rps_game/widgets/rps_healthbar.dart';
import 'package:muitsu_arked/games/rps_game/widgets/rps_skill_btn.dart';
import 'package:muitsu_arked/platform_image.dart';
import 'package:provider/provider.dart';

import '../../constants/assets_icon.dart';

class RpsBattleField extends StatefulWidget {
  const RpsBattleField({super.key});

  @override
  RpsBattleFieldState createState() => RpsBattleFieldState();
}

class RpsBattleFieldState extends State<RpsBattleField>
    with TickerProviderStateMixin {
  late AnimationController p1Ctrl;
  late AnimationController p2Ctrl;

  late RpsGameUtils rpsUtils;
  @override
  void initState() {
    super.initState();
    p1Ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    p2Ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    rpsUtils = Provider.of<RpsGameUtils>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      rpsUtils.startGame(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background
          Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: const PlatformAwareAssetImage(
              asset: AssetsBg.stage1,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.1),
          ),
          //Player 1 Char
          RpsPlayer(
            playerName: 'Muitsu',
            character: context.watch<RpsGameUtils>().getCharP1,
            controller: p1Ctrl,
            maxHp: context.watch<RpsGameUtils>().getPlayer1MaxHp,
            currHp: context.watch<RpsGameUtils>().getPlayer1Hp,
            showMove: context.watch<RpsGameUtils>().isShowMove,
            playerMove: context.watch<RpsGameUtils>().getPlayer1Choice.img,
          ),
          //Player 2 Char
          RpsPlayer(
            playerName: 'Random AI',
            isEnemy: true,
            character: context.watch<RpsGameUtils>().getCharP2!,
            controller: p2Ctrl,
            maxHp: context.watch<RpsGameUtils>().getPlayer2MaxHp,
            currHp: context.watch<RpsGameUtils>().getPlayer2Hp,
            showMove: context.watch<RpsGameUtils>().isShowMove,
            playerMove: context.watch<RpsGameUtils>().getPlayer2Choice.img,
          ),
          //skill button
          Positioned(
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 5, bottom: 5, right: 5),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20))),
                  child: const Text(
                    'Player Attack',
                    style: TextStyle(color: AssetsColor.whiteMatte),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                      children: List.generate(
                          Choice.values.length,
                          (index) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: index == 1 ? 60 : 0),
                                child: RpsSkillBtn(
                                  skillName: Choice.values[index].skillName,
                                  asset: Choice.values[index].skillImg,
                                  onTap: context
                                          .watch<RpsGameUtils>()
                                          .isGameLoading
                                      ? null
                                      : () => rpsUtils.playerMove(
                                            choice: Choice.values[index],
                                            context: context,
                                            p1Ctrl: p1Ctrl,
                                            p2Ctrl: p2Ctrl,
                                          ),
                                ),
                              ))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RpsPlayer extends StatefulWidget {
  final bool isEnemy;
  final bool showMove;
  final String playerMove;
  final RpsGameCharacter character;
  final AnimationController controller;
  final int currHp;
  final int maxHp;
  final double? width;
  final double? height;
  final String playerName;
  const RpsPlayer({
    super.key,
    this.isEnemy = false,
    this.showMove = false,
    this.playerMove = AssetsIcon.handRock,
    required this.currHp,
    this.width = 300,
    this.height = 100,
    required this.playerName,
    this.maxHp = 5,
    this.character = RpsGameCharacter.rimuru,
    required this.controller,
  });

  @override
  State<RpsPlayer> createState() => _RpsPlayerState();
}

class _RpsPlayerState extends State<RpsPlayer> {
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
                RpsCharacter(
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
                  child: RpsHealthBar(
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
