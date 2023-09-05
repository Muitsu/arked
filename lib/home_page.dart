import 'package:flutter/material.dart';
import 'package:muitsu_arked/constants/assets_color.dart';
import 'package:muitsu_arked/constants/assets_icon.dart';
import 'package:muitsu_arked/digital_watch.dart';
import 'package:muitsu_arked/platform_image.dart';

import 'constants/game_constant.dart';
import 'constants/responsive_size.dart';
import 'custom_page_transition.dart';
import 'darken_edge_filter.dart';
import 'game_selection.dart';
import 'logout_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameConstant> games = GameConstant.values;
  int currInd = 0;
  _logout() {
    showDialog(
        context: context,
        builder: (context) {
          return const LogoutDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        _logout();
        return false;
      },
      child: Scaffold(
        backgroundColor: AssetsColor.blackMatte,
        body: Stack(
          children: [
            PlatformAwareAssetImage(
              asset: games[currInd].bg,
              width: double.infinity,
              height: double.infinity,
            ),
            const DarkenEdgeFilter(),
            const Positioned(
                bottom: 20,
                right: 20,
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(color: AssetsColor.whiteMatte),
                )),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  top: responsiveSize(context, max: 40, mid: 20, min: 16),
                  left: responsiveSize(context, max: 40, mid: 20, min: 16),
                  right: responsiveSize(context, max: 40, mid: 20, min: 16),
                  bottom: responsiveSize(context, max: 50, mid: 26, min: 16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DigitalWatch(),
                        PlatformAwareAssetImage(
                          asset: AssetsIcon.logoWhite,
                          width: 50,
                        )
                      ],
                    ),
                    SizedBox(
                      height:
                          responsiveSize(context, max: 22, mid: 20, min: 16),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              games[currInd].title,
                              style: TextStyle(
                                  color: AssetsColor.whiteMatte,
                                  fontSize: responsiveSize(context,
                                      max: 50, mid: 30, min: 16),
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              games[currInd].desc,
                              style: TextStyle(
                                  color: AssetsColor.whiteMatte,
                                  fontSize: responsiveSize(context,
                                      max: 22, mid: 16, min: 12)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.14,
                          height: MediaQuery.of(context).size.width * 0.05,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CustomPageTransition.fadeToPage(
                                      page: games[currInd].page));
                            },
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16),
                                foregroundColor: AssetsColor.whiteMatte,
                                surfaceTintColor: AssetsColor.whiteMatte,
                                backgroundColor:
                                    AssetsColor.whiteMatte.withOpacity(0.3)),
                            child: Text(
                              'Play',
                              style: TextStyle(
                                  fontSize: responsiveSize(context,
                                      max: 20, mid: 14, min: 8)),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'Choose your poison',
                      style: TextStyle(
                          color: AssetsColor.whiteMatte,
                          fontWeight: FontWeight.bold,
                          fontSize: responsiveSize(context,
                              max: 22, mid: 16, min: 12)),
                    ),
                    SizedBox(
                        height: size.height * 0.3,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: games.length,
                            itemBuilder: (context, index) {
                              return GameSelection(
                                onTap: () => setState(() => currInd = index),
                                isActive: currInd == index,
                                game: games[index].title,
                                icon: games[index].icon,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(width: 6)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
