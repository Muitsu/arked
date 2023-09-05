import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class RpsNotify {
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

  static notiShield(BuildContext context, {required String msg}) {
    return Flushbar(
      message: msg,
      margin: const EdgeInsets.symmetric(horizontal: 240),
      icon: const Icon(
        Icons.shield_rounded,
        color: Colors.blue,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 1),
      isDismissible: false,
    ).show(context);
  }

  static notiEnemy(BuildContext context, {required String msg}) {
    return Flushbar(
      message: msg,
      icon: const Icon(
        Icons.warning_rounded,
        color: Colors.amber,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 240),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 1),
      isDismissible: false,
    ).show(context);
  }
}
