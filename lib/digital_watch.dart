import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muitsu_arked/constants/assets_color.dart';

class DigitalWatch extends StatefulWidget {
  const DigitalWatch({super.key});

  @override
  DigitalWatchState createState() => DigitalWatchState();
}

class DigitalWatchState extends State<DigitalWatch> {
  String _timeString = '';
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _startTime();
  }

  void _startTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _timeString = DateFormat('hh:mm').format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: const TextStyle(
          color: AssetsColor.whiteMatte,
          fontWeight: FontWeight.w900,
          fontSize: 20),
    );
  }
}
