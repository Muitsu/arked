import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../joystick.dart';
import 'dragon_character.dart';

class DragonGame extends StatelessWidget {
  const DragonGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Game(screenSize: size),
      ),
    );
  }
}

class Game extends StatefulWidget {
  final Size screenSize;
  const Game({Key? key, required this.screenSize}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late Dragon dragon;
  late Point<int> food;
  late Timer _timer;
  Random random = Random();

  @override
  void initState() {
    initGame();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (t) {
      gameUpdate();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  initGame() {
    dragon = Dragon();
    foodUpdate();
  }

  void gameUpdate() {
    // update this
    if (food == dragon.head) {
      dragon.eatFood();
      foodUpdate();
    } else {
      dragon.update();
    }
    if (dragon.didBiteItself()) {
      initGame();
    }
    setState(() {});
  }

  void foodUpdate() {
    do {
      food = Point(
          random.nextInt(widget.screenSize.width * 0.2 ~/ Constants.blockSize),
          random.nextInt(widget.screenSize.width * 0.2 ~/ Constants.blockSize));
    } while (dragon.pointOnDragon(food));
  }

  void keyHandler(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (dragon.direction != Constants.up) {
        dragon.direction = Constants.down;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (dragon.direction != Constants.down) {
        dragon.direction = Constants.up;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      if (dragon.direction != Constants.left) {
        dragon.direction = Constants.right;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      if (dragon.direction != Constants.right) {
        dragon.direction = Constants.left;
      }
    }
  }

  void callback(int x, int y) {
    if (x == 0 && y == 0) return;

    if (!x.isNegative && y.isNegative) {
      if (dragon.direction != Constants.up) {
        dragon.direction = Constants.down;
      }
    } else if (x.isNegative && !y.isNegative) {
      if (dragon.direction != Constants.down) {
        dragon.direction = Constants.up;
      }
    } else if (!x.isNegative && !y.isNegative) {
      if (dragon.direction != Constants.left) {
        dragon.direction = Constants.right;
      }
    } else if (x.isNegative && y.isNegative) {
      if (dragon.direction != Constants.right) {
        dragon.direction = Constants.left;
      }
    }
    // atas  - +
    // bawah + -
    // kiri  - -
    // kanan + +
    debugPrint('callback x => $x and y $y');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: keyHandler,
          autofocus: true,
          child: Container(
            width: widget.screenSize.width * 0.2,
            height: widget.screenSize.width * 0.2,
            color: Colors.black,
            child: Stack(
              children: dragon.dragon // Update This
                      .map((e) => Positioned(
                            top: Constants.blockSize * e.y,
                            left: Constants.blockSize * e.x,
                            child: Container(
                              height: Constants.blockSize,
                              width: Constants.blockSize,
                              color: Colors.green,
                            ),
                          ))
                      .toList() +
                  [
                    Positioned(
                      top: Constants.blockSize * food.y,
                      left: Constants.blockSize * food.x,
                      child: Container(
                        height: Constants.blockSize,
                        width: Constants.blockSize,
                        color: Colors.red,
                      ),
                    )
                  ],
            ),
          ),
        ),
        JoyStick(
            radius: widget.screenSize.width * 0.1,
            stickRadius: 20,
            callback: callback),
      ],
    );
  }
}
