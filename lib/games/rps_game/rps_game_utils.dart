// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muitsu_arked/games/rps_game/rps_constants.dart';
import 'package:muitsu_arked/games/rps_game/widgets/rps_notify.dart';

import '../../logout_dialog.dart';

class RpsGameUtils extends ChangeNotifier {
  int player1Hp = 5;
  int player2Hp = 5;
  int player1MaxHp = 5;
  int player2MaxHp = 5;
  Choice player1Choice = Choice.paper;
  Choice player2Choice = Choice.paper;
  RpsGameCharacter charP1 = RpsGameCharacter.greenSlime;
  RpsGameCharacter? charP2;
  bool? isWinning;
  bool isLoading = false;
  bool showMove = false;
  int get getPlayer1Hp => player1Hp;
  int get getPlayer2Hp => player2Hp;
  int get getPlayer1MaxHp => player1MaxHp;
  int get getPlayer2MaxHp => player2MaxHp;
  RpsGameCharacter get getCharP1 => charP1;
  RpsGameCharacter? get getCharP2 => charP2;
  Choice get getPlayer1Choice => player1Choice;
  Choice get getPlayer2Choice => player2Choice;
  bool get isGameLoading => isLoading;
  bool get isShowMove => showMove;

  void startGame(
      {int? initP1Hp, int? initP2Hp, required BuildContext context}) async {
    isLoading = true;
    player1Choice = Choice.paper;
    player2Choice == Choice.paper;
    player1Hp = initP1Hp ?? player1MaxHp;
    player2Hp = initP2Hp ?? player2MaxHp;
    player1MaxHp = initP1Hp ?? player1MaxHp;
    player2MaxHp = initP2Hp ?? player2MaxHp;
    await Future.delayed(const Duration(milliseconds: 900));
    showDialog(
        context: context,
        builder: (context) => const PlayerMoveDialog(msg: 'Player 1 Attack'));
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.pop(context);
    isLoading = false;
    notifyListeners();
  }

  void playerMove({
    required Choice choice,
    required BuildContext context,
    required AnimationController p1Ctrl,
    required AnimationController p2Ctrl,
  }) async {
    if (player1Hp != 0 && player2Hp != 0) {
      isLoading = true;
      showMove = true;
      player1Choice = choice;
      player2Choice = generateComputerChoice();
      await Future.delayed(const Duration(milliseconds: 1500));
      if (player1Choice == player2Choice) {
        isWinning = null;
        RpsNotify.notiShield(context, msg: 'Dodge enemy attack');
      } else if ((player1Choice == Choice.rock &&
              player2Choice == Choice.scissors) ||
          (player1Choice == Choice.paper && player2Choice == Choice.rock) ||
          (player1Choice == Choice.scissors && player2Choice == Choice.paper)) {
        isWinning = true;
        player2Hp--;
        p2Ctrl.forward(from: 0);
        RpsNotify.notiAttack(context, msg: 'Attack Hit');
      } else {
        isWinning = false;
        player1Hp--;
        p1Ctrl.forward(from: 0);
        RpsNotify.notiEnemy(context, msg: 'Enemy Attack');
      }
      showMove = false;
      isLoading = false;
      checkingWinner(context: context);
      notifyListeners();
    } else {
      checkingWinner(context: context);
    }
  }

  void checkingWinner({required BuildContext context}) {
    if (player1Hp <= 0 || player2Hp <= 0) {
      showDialog(context: context, builder: (context) => const LogoutDialog());
    }

    notifyListeners();
  }

  Choice generateComputerChoice() {
    final random = Random();
    const choices = Choice.values;
    notifyListeners();
    return choices[random.nextInt(choices.length)];
  }

  void setPlayer1Hp({required int playerHp}) async {
    player1Hp = playerHp;
    notifyListeners();
  }

  void setPlayer2Hp({required int enemyHp}) async {
    player2Hp = enemyHp;
    notifyListeners();
  }

  void setCharP1({required RpsGameCharacter char}) async {
    charP1 = char;
    notifyListeners();
  }

  void setCharP2({RpsGameCharacter? char}) async {
    charP2 = char;
    notifyListeners();
  }
}

class PlayerMoveDialog extends StatelessWidget {
  final String msg;
  const PlayerMoveDialog({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () {},
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              color: Colors.black,
              height: 80,
              child: Center(
                child: Text(
                  msg,
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
