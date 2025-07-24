// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muitsu_arked/config/constants/game-asset/character_asset.dart';
import 'package:muitsu_arked/config/constants/game-asset/skills_asset.dart';
import 'package:muitsu_arked/components/skill_notification.dart';

import '../components/logout_dialog.dart';

class BattleFieldProvider extends ChangeNotifier {
  int player1Hp = 5;
  int player2Hp = 5;
  int player1MaxHp = 5;
  int player2MaxHp = 5;
  SkillsAsset player1Choice = SkillsAsset.paper;
  SkillsAsset player2Choice = SkillsAsset.paper;
  CharacterAsset charP1 = CharacterAsset.greenSlime;
  CharacterAsset? charP2;
  bool? isWinning;
  bool isLoading = false;
  bool showMove = false;
  int get getPlayer1Hp => player1Hp;
  int get getPlayer2Hp => player2Hp;
  int get getPlayer1MaxHp => player1MaxHp;
  int get getPlayer2MaxHp => player2MaxHp;
  CharacterAsset get getCharP1 => charP1;
  CharacterAsset? get getCharP2 => charP2;
  SkillsAsset get getPlayer1Choice => player1Choice;
  SkillsAsset get getPlayer2Choice => player2Choice;
  bool get isGameLoading => isLoading;
  bool get isShowMove => showMove;

  void startGame(
      {int? initP1Hp, int? initP2Hp, required BuildContext context}) async {
    isLoading = true;
    player1Choice = SkillsAsset.paper;
    player2Choice == SkillsAsset.paper;
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
    required SkillsAsset choice,
    required BuildContext context,
    required AnimationController p1Ctrl,
    required AnimationController p2Ctrl,
  }) async {
    if (player1Hp != 0 && player2Hp != 0) {
      isLoading = true;
      showMove = true;
      player1Choice = choice;
      player2Choice = _generateComputerChoice();
      await Future.delayed(const Duration(milliseconds: 1500));
      if (player1Choice == player2Choice) {
        isWinning = null;
        await SkillNotification.notiShield(context, msg: 'Dodge enemy attack');
      } else if ((player1Choice == SkillsAsset.rock &&
              player2Choice == SkillsAsset.scissors) ||
          (player1Choice == SkillsAsset.paper &&
              player2Choice == SkillsAsset.rock) ||
          (player1Choice == SkillsAsset.scissors &&
              player2Choice == SkillsAsset.paper)) {
        isWinning = true;
        player2Hp--;
        p2Ctrl.forward(from: 0);
        SkillNotification.notiAttack(context, msg: 'Attack Hit');
      } else {
        isWinning = false;
        player1Hp--;
        p1Ctrl.forward(from: 0);
        await SkillNotification.notiEnemy(context, msg: 'Enemy Attack');
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

  SkillsAsset _generateComputerChoice() {
    final random = Random();
    const choices = SkillsAsset.values;
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

  void setCharP1({required CharacterAsset char}) async {
    charP1 = char;
    notifyListeners();
  }

  void setCharP2({CharacterAsset? char}) async {
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
    return PopScope(
      canPop: true,
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
