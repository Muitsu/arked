import 'package:flutter/material.dart';
import 'package:muitsu_arked/config/constants/others/assets_color.dart';
import 'package:muitsu_arked/games/unused/ttt_game/ttt_game.dart';

import '../../../components/back_btn.dart';
import '../../../config/constants/game_constant.dart';
import '../../../config/constants/responsive_size.dart';
import '../../../components/platform_image.dart';
import '../../../components/primary_btn.dart';

class TttSplash extends StatefulWidget {
  const TttSplash({super.key});

  @override
  State<TttSplash> createState() => _TttSplashState();
}

class _TttSplashState extends State<TttSplash> {
  GameConstant game = GameConstant.ttt;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: BackBtn()),
      body: Stack(
        children: [
          PlatformAwareAssetImage(
            asset: game.bg,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.2),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: responsiveSize(context, max: 40, mid: 15, min: 16),
                  left: responsiveSize(context, max: 50, mid: 30, min: 16),
                  right: responsiveSize(context, max: 40, mid: 20, min: 16),
                  bottom: responsiveSize(context, max: 50, mid: 30, min: 16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      style: TextStyle(
                          color: AssetsColor.whiteMatte,
                          fontSize: responsiveSize(context,
                              max: 50, mid: 35, min: 16),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      game.desc,
                      style: TextStyle(
                          color: AssetsColor.whiteMatte,
                          fontSize: responsiveSize(context,
                              max: 22, mid: 16, min: 12)),
                    ),
                    const Spacer(),
                    PrimaryButton(
                      title: 'Solo',
                      width: size.width * 0.26,
                      height: MediaQuery.of(context).size.width * 0.05,
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const TttGame())),
                    ),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      title: 'Competitive',
                      width: size.width * 0.26,
                      height: MediaQuery.of(context).size.width * 0.05,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TttGame(
                                    isTwoPlayer: true,
                                  ))),
                    ),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      title: 'Credit',
                      width: size.width * 0.26,
                      height: MediaQuery.of(context).size.width * 0.05,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
