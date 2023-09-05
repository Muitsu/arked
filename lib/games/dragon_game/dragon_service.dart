import 'dart:math';

import 'package:flutter/services.dart';

import 'dragon_character.dart';

class DragonService {
  static final DragonService instance = DragonService._init();
  Random random = Random();
  late Dragon dragon;
  late Point<int> food;
  DragonService._init();

  initGame() {
    dragon = Dragon();
    foodUpdate();
  }

  void foodUpdate() {
    do {
      food = Point(random.nextInt(Constants.canvasSize ~/ Constants.blockSize),
          random.nextInt(Constants.canvasSize ~/ Constants.blockSize));
    } while (dragon.pointOnDragon(food));
  }

  void gameUpdate() {
    if (food == dragon.head) {
      dragon.eatFood();
      foodUpdate();
    } else {
      dragon.update();
    }
    if (dragon.didBiteItself()) {
      initGame();
    }
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
}
