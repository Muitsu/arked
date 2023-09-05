import 'package:flutter/material.dart';
import '../games/dragon_game/dragon_splash.dart';
import '../games/rps_game/rps_splash.dart';
import '../games/ttt_game/ttt_splash.dart';
import 'assets_bg.dart';
import 'assets_icon.dart';

enum GameConstant {
  rps(
      title: 'Rps Game',
      desc: 'Rock, Paper, Scissors!!, but look epic.',
      page: RpsSplash(),
      bg: AssetsBg.bgRps,
      icon: AssetsIcon.rps),
  dragon(
      title: 'Dragon Game',
      desc: 'Literally a snake game but change to dragon',
      page: DragonSplash(),
      bg: AssetsBg.bgDragon,
      icon: AssetsIcon.dragon),

  ttt(
      title: 'TTT Game',
      desc: 'A Stylized Classic Tic Tac Toe game',
      page: TttSplash(),
      bg: AssetsBg.bgTtt,
      icon: AssetsIcon.ttt),
  ;

  final String title;
  final String desc;
  final String bg;
  final String icon;
  final Widget page;
  const GameConstant(
      {required this.title,
      required this.desc,
      required this.page,
      required this.bg,
      required this.icon});
}
