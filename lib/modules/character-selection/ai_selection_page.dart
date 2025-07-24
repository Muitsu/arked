import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muitsu_arked/components/custom_page_transition.dart';
import 'package:muitsu_arked/config/constants/game-asset/character_asset.dart';
import 'package:muitsu_arked/modules/battle_field_provider.dart';
import 'package:muitsu_arked/modules/battle-field/battle_field_loading_page.dart';
import 'package:provider/provider.dart';

import '../../config/constants/others/assets_color.dart';
import '../../components/platform_image.dart';

class AISelectionPage extends StatefulWidget {
  const AISelectionPage({super.key});

  @override
  State<AISelectionPage> createState() => _AISelectionPageState();
}

class _AISelectionPageState extends State<AISelectionPage> {
  Timer? timer;
  final characters = CharacterAsset.values;
  late BattleFieldProvider rpsUtils;

  @override
  void initState() {
    rpsUtils = Provider.of<BattleFieldProvider>(context, listen: false);
    timer = Timer.periodic(
        const Duration(milliseconds: 200), (Timer t) => _shuffle());
    Future.delayed(const Duration(seconds: 5), () => timer!.cancel()).then(
        (value) => Future.delayed(
            const Duration(milliseconds: 1500),
            () => Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                CustomPageTransition.fadeToPage(
                    page: const BattleFieldLoadingPage()))));

    super.initState();
  }

  void _shuffle() =>
      rpsUtils.setCharP2(char: characters[Random().nextInt(characters.length)]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AssetsColor.darkBlue,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: size.width * 0.3,
              color: const Color(0xFFAF4C4C),
              padding: const EdgeInsets.all(10),
              child: context.watch<BattleFieldProvider>().getCharP2 != null
                  ? PlatformAwareAssetImage(
                      width: size.width * 0.1,
                      height: size.width * 0.1,
                      fit: BoxFit.scaleDown,
                      asset:
                          context.watch<BattleFieldProvider>().getCharP2!.front,
                    )
                  : Icon(
                      Icons.help_outline_rounded,
                      size: size.height * 0.34,
                      color: AssetsColor.blackMatte,
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            color: AssetsColor.blackMatte,
            child: const Column(
              children: [
                Text(
                  'Random AI',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 5),
                Divider(
                  color: Colors.white12,
                  height: 0,
                  indent: 30,
                  endIndent: 30,
                )
              ],
            ),
          ),
          Container(
            color: AssetsColor.blackMatte,
            padding: const EdgeInsets.all(10),
            height: 80,
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: characters.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color(0xFFDCCFCB),
                          border: characters[index] ==
                                  context.watch<BattleFieldProvider>().getCharP2
                              ? Border.all(color: Colors.red, width: 3)
                              : null),
                      margin:
                          EdgeInsets.only(left: index == 0 ? 16 : 0, right: 10),
                      height: 50,
                      width: 100,
                      child: PlatformAwareAssetImage(
                          fit: BoxFit.contain, asset: characters[index].front),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
