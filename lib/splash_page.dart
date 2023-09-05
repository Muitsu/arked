import 'dart:async';
import 'package:flutter/material.dart';
import 'package:muitsu_arked/constants/assets_color.dart';
import 'package:muitsu_arked/constants/assets_icon.dart';
import 'package:muitsu_arked/custom_page_transition.dart';
import 'package:muitsu_arked/landing_page.dart';
import 'package:muitsu_arked/platform_image.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, CustomPageTransition.fadeToPage(page: const LandingPage()));
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AssetsColor.blackMatte,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AssetsColor.blackMatte,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PlatformAwareAssetImage(
                    asset: AssetsIcon.logoWhite,
                    width: size.width * 0.2,
                  ),
                  const Text(
                    'MuitsuArked',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '©Since 2023, Malaysia',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
