import 'package:flutter/material.dart';
import 'package:muitsu_arked/constants/assets_color.dart';
import 'package:muitsu_arked/games/rps_game/rps_constants.dart';
import 'package:muitsu_arked/games/rps_game/rps_game_utils.dart';
import 'package:muitsu_arked/games/rps_game/rps_random_ai.dart';
import 'package:muitsu_arked/primary_btn.dart';
import 'package:muitsu_arked/trapezium_container.dart';
import 'package:provider/provider.dart';

import '../../back_btn.dart';
import '../../platform_image.dart';

class RpsCharSelect extends StatefulWidget {
  const RpsCharSelect({super.key});

  @override
  State<RpsCharSelect> createState() => _RpsCharSelectState();
}

class _RpsCharSelectState extends State<RpsCharSelect> {
  late RpsGameUtils rpsUtils;
  final characters = RpsGameCharacter.values;
  @override
  void initState() {
    super.initState();
    rpsUtils = Provider.of<RpsGameUtils>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackBtn(
            mainAxisAlignment: MainAxisAlignment.start,
          )),
      backgroundColor: AssetsColor.darkBlue,
      body: Stack(
        children: [
          RpsCharSelectBg(
            char1: context.watch<RpsGameUtils>().getCharP1,
            char2: context.watch<RpsGameUtils>().getCharP2,
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Character Select',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 60,
                  child: Center(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: characters.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              rpsUtils.setCharP1(char: characters[index]);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFDCCFCB),
                                  border: characters[index] ==
                                          context
                                              .watch<RpsGameUtils>()
                                              .getCharP1
                                      ? Border.all(
                                          color: Colors.orange, width: 3)
                                      : null),
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 16 : 0, right: 10),
                              height: 60,
                              width: 100,
                              child: PlatformAwareAssetImage(
                                  fit: BoxFit.contain,
                                  asset: characters[index].front),
                            ),
                          );
                        }),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 6.0, right: 10, top: 6),
                      child: PrimaryButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const RpsRandomAI()));
                          },
                          title: 'Start Game'),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RpsCharSelectBg extends StatelessWidget {
  final RpsGameCharacter? char1;
  final RpsGameCharacter? char2;
  const RpsCharSelectBg({
    super.key,
    this.char1,
    this.char2,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          children: [
            StraightContainer(
                child: Container(
              height: double.infinity,
              width: size.width * 0.38,
              color: const Color(0xFF4C56AF),
            )),
            const Spacer(),
            Transform.flip(
              flipX: true,
              child: StraightContainer(
                  child: Container(
                height: double.infinity,
                width: size.width * 0.38,
                color: const Color(0xFFAF4C4C),
              )),
            )
          ],
        ),
        Positioned(
          top: size.height * .16,
          child: SizedBox(
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .02),
              child: Row(
                children: [
                  char1 != null
                      ? PlatformAwareAssetImage(
                          width: size.width * 0.2,
                          height: size.width * 0.2,
                          fit: BoxFit.contain,
                          asset: char1!.front,
                        )
                      : Icon(
                          Icons.help_outline_rounded,
                          size: size.height * 0.34,
                          color: AssetsColor.blackMatte,
                        ),
                  const Spacer(),
                  char2 != null
                      ? PlatformAwareAssetImage(
                          width: size.width * 0.2,
                          height: size.width * 0.2,
                          fit: BoxFit.contain,
                          asset: char2!.front,
                        )
                      : Icon(
                          Icons.help_outline_rounded,
                          size: size.height * 0.34,
                          color: AssetsColor.blackMatte,
                        ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.48,
          left: size.width * 0.2,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: size.width * 0.25,
                    padding: const EdgeInsets.only(left: 10),
                    color: const Color(0xFF6484DA),
                    child: Row(
                      children: [
                        Text(
                          char1 != null ? char1!.name : '???',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: size.width * 0.1),
                  Container(
                    height: 30,
                    width: size.width * 0.25,
                    padding: const EdgeInsets.only(right: 10),
                    color: const Color(0xFFDA6464),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          char2 != null ? char2!.name : '???',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -10,
                right: size.width * 0.225,
                child: TrapeziumContainer(
                  child: Container(
                    height: 35,
                    width: size.width * 0.15,
                    color: const Color(0xFFFFE1C7),
                    child: const Center(
                        child: Text(
                      'VS',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
