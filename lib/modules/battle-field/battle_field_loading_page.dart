import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:muitsu_arked/config/constants/game-asset/character_asset.dart';
import 'package:muitsu_arked/config/constants/others/assets_color.dart';
import 'package:muitsu_arked/modules/battle-field/battle_field_page.dart';
import 'package:muitsu_arked/modules/battle_field_provider.dart';
import 'package:provider/provider.dart';
import '../../components/custom_page_transition.dart';
import '../../components/platform_image.dart';

class BattleFieldLoadingPage extends StatefulWidget {
  const BattleFieldLoadingPage({super.key});

  @override
  State<BattleFieldLoadingPage> createState() => _BattleFieldLoadingPageState();
}

class _BattleFieldLoadingPageState extends State<BattleFieldLoadingPage> {
  late BattleFieldProvider rpsUtils;
  double progress = 0.0;
  final characters = CharacterAsset.values;
  @override
  void initState() {
    super.initState();
    rpsUtils = Provider.of<BattleFieldProvider>(context, listen: false);

    _progressCount().then((value) => Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        CustomPageTransition.fadeToPage(page: const BattleFieldPage())));
  }

  Future _progressCount() async {
    for (double i = 0; i <= 1; i = i + 0.1) {
      setState(() => progress = i);
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: AssetsColor.darkBlue,
          body: Center(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: AssetsColor.lightkBlue,
                      borderRadius: BorderRadius.circular(10)),
                  height: size.height * 0.7,
                  width: size.width * 0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: _character(
                              name: 'Player 1',
                              assets: context
                                  .watch<BattleFieldProvider>()
                                  .getCharP1
                                  .front,
                            ),
                          ),
                          const Expanded(
                              child: Center(
                            child: Text(
                              'VS',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _character(
                              name: 'Random AI',
                              assets: context
                                  .watch<BattleFieldProvider>()
                                  .getCharP2!
                                  .front,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Loading...',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      linearProgressBar(10, double.infinity, value: progress)
                    ],
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Note: This is game is all about luck',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _character(
      {required String name,
      required String assets,
      double height = 100,
      double width = 100}) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        PlatformAwareAssetImage(
                width: width,
                height: height,
                fit: BoxFit.contain,
                asset: assets)
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .shakeY(
                delay: 600.ms,
                duration: const Duration(seconds: 20),
                curve: Curves.linear,
                hz: 1),
        Container(
          height: 20,
          width: 90,
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.elliptical(100, 50)),
          ),
        ),
      ],
    );
  }

  linearProgressBar(double height, double width, {required double value}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: value,
          color: AssetsColor.lightGreen,
          backgroundColor: Colors.grey.shade400,
        ),
      ),
    );
  }
}
