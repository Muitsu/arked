import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:muitsu_arked/components/darken_edge_filter.dart';
import 'package:muitsu_arked/components/modal/custom_dialog.dart';
import 'package:muitsu_arked/config/constants/responsive_size.dart';

class SkillNotification {
  static notiAttack(BuildContext context, {required String msg}) {
    return Flushbar(
      message: msg,
      icon: const Icon(
        Icons.check_circle_outline_rounded,
        color: Colors.green,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 240),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 1),
      isDismissible: false,
    ).show(context);
  }

  static Future notiShield(BuildContext context, {required String msg}) {
    Future.delayed(
        const Duration(milliseconds: 800),
        // ignore: use_build_context_synchronously
        () => Navigator.pop(context));
    return CustomDialog.show(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_) => PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) return;
              },
              child: Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shield,
                            color: Colors.white,
                            size: responsiveSize(context,
                                max: 40, mid: 40, min: 16),
                          ),
                          Text(
                            "Blocked",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsiveSize(context,
                                  max: 40, mid: 20, min: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DarkenEdgeFilter(
                      isDarken: false,
                      colors: [
                        Colors.white.withValues(alpha: .5),
                        Colors.white.withValues(alpha: .1),
                        Colors.white.withValues(alpha: .1),
                        Colors.white.withValues(alpha: .5),
                      ],
                    ),
                  ],
                ),
              ),
            ));
    // return Flushbar(
    //   message: msg,
    //   margin: const EdgeInsets.symmetric(horizontal: 240),
    //   icon: const Icon(
    //     Icons.shield_rounded,
    //     color: Colors.blue,
    //   ),
    //   flushbarPosition: FlushbarPosition.TOP,
    //   borderRadius: BorderRadius.circular(8),
    //   duration: const Duration(seconds: 1),
    //   isDismissible: false,
    // ).show(context);
  }

  static Future notiEnemy(BuildContext context, {required String msg}) async {
    Future.delayed(
        const Duration(milliseconds: 800),
        // ignore: use_build_context_synchronously
        () => Navigator.pop(context));
    return CustomDialog.show(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_) => PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) return;
              },
              child: DarkenEdgeFilter(
                isDarken: false,
                colors: [
                  Colors.red.withValues(alpha: .5),
                  Colors.red.withValues(alpha: .1),
                  Colors.red.withValues(alpha: .1),
                  Colors.red.withValues(alpha: .5),
                ],
              )
                  .animate(autoPlay: true)
                  .shimmer()
                  .shake(hz: 4, curve: Curves.easeInOutCubic)
                  .scaleXY(end: 1.1)
                  .then(delay: 300.ms)
                  .scaleXY(end: 1 / 1.1),
            ));
    // return Flushbar(
    //   message: msg,
    //   icon: const Icon(
    //     Icons.warning_rounded,
    //     color: Colors.amber,
    //   ),
    //   margin: const EdgeInsets.symmetric(horizontal: 240),
    //   flushbarPosition: FlushbarPosition.TOP,
    //   borderRadius: BorderRadius.circular(8),
    //   duration: const Duration(seconds: 1),
    //   isDismissible: false,
    // ).show(context);
  }
}
