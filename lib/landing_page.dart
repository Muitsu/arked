import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:muitsu_arked/constants/responsive_size.dart';
import 'package:muitsu_arked/home_page.dart';

import 'constants/assets_color.dart';
import 'custom_page_transition.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool canGoNext = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() => canGoNext = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canGoNext
          ? () {
              Navigator.push(context,
                  CustomPageTransition.fadeToPage(page: const HomePage()));
            }
          : null,
      child: Scaffold(
        backgroundColor: AssetsColor.blackMatte,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text('Warning',
                        style: TextStyle(
                            color: AssetsColor.whiteMatte,
                            fontSize: responsiveSize(context,
                                max: 30, mid: 24, min: 16),
                            fontWeight: FontWeight.bold))
                    .animate()
                    .fadeIn(),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                  'This app game is develop by inexperience developer. This may lead users to condemn the poor developer that create this just for fun.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AssetsColor.whiteMatte,
                      fontSize:
                          responsiveSize(context, max: 22, mid: 16, min: 10))),
              const SizedBox(height: 14),
              const SizedBox(height: 14),
              Visibility(
                visible: canGoNext,
                child: Center(
                  child: Text('Press anywhere to continue',
                          style: TextStyle(
                              color: AssetsColor.whiteMatte,
                              fontSize: responsiveSize(context,
                                  max: 22, mid: 16, min: 10)))
                      .animate()
                      .fadeIn()
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .fadeOut(begin: 1, duration: const Duration(seconds: 2)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
