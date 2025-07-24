import 'package:flutter/material.dart';
import 'package:muitsu_arked/config/constants/game-asset/skills_asset.dart';
import 'package:muitsu_arked/config/constants/others/assets_bg.dart';
import 'package:muitsu_arked/config/constants/others/assets_color.dart';
import 'package:muitsu_arked/modules/battle_field_provider.dart';
import 'package:muitsu_arked/components/platform_image.dart';
import 'package:muitsu_arked/modules/battle-field/character/character_widget.dart';
import 'package:muitsu_arked/modules/battle-field/skill_button.dart';
import 'package:provider/provider.dart';

class BattleFieldPage extends StatefulWidget {
  const BattleFieldPage({super.key});

  @override
  BattleFieldPageState createState() => BattleFieldPageState();
}

class BattleFieldPageState extends State<BattleFieldPage>
    with TickerProviderStateMixin {
  late AnimationController p1Ctrl;
  late AnimationController p2Ctrl;

  late BattleFieldProvider rpsUtils;
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

    rpsUtils = Provider.of<BattleFieldProvider>(context, listen: false);
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
            color: Colors.black.withValues(alpha: 0.1),
          ),
          //Player 2 Char
          CharacterWidget(
            playerName: 'Random AI',
            isEnemy: true,
            character: context.watch<BattleFieldProvider>().getCharP2!,
            controller: p2Ctrl,
            maxHp: context.watch<BattleFieldProvider>().getPlayer2MaxHp,
            currHp: context.watch<BattleFieldProvider>().getPlayer2Hp,
            showMove: context.watch<BattleFieldProvider>().isShowMove,
            playerMove:
                context.watch<BattleFieldProvider>().getPlayer2Choice.img,
          ),
          //Player 1 Char
          CharacterWidget(
            playerName: 'Muitsu',
            character: context.watch<BattleFieldProvider>().getCharP1,
            controller: p1Ctrl,
            maxHp: context.watch<BattleFieldProvider>().getPlayer1MaxHp,
            currHp: context.watch<BattleFieldProvider>().getPlayer1Hp,
            showMove: context.watch<BattleFieldProvider>().isShowMove,
            playerMove:
                context.watch<BattleFieldProvider>().getPlayer1Choice.img,
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
                          SkillsAsset.values.length,
                          (index) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: index == 1 ? 60 : 0),
                                child: SkillButton(
                                  skillName:
                                      SkillsAsset.values[index].skillName,
                                  asset: SkillsAsset.values[index].skillImg,
                                  onTap: context
                                          .watch<BattleFieldProvider>()
                                          .isGameLoading
                                      ? null
                                      : () => rpsUtils.playerMove(
                                            choice: SkillsAsset.values[index],
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
