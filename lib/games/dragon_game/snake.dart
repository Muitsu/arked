import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  int numberOfSquares = 760;
  Timer? _timer;
  static var randomNumber = Random();
  int food = randomNumber.nextInt(700);
  void generateNewFood() => food = randomNumber.nextInt(700);

  void startGame() {
    snakePosition = [45, 65, 85, 105, 125];
    const duration = Duration(milliseconds: 300);
    _timer = Timer.periodic(duration, (timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        direction = SnakeDirection.down;
        showGameOverScreen();
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  SnakeDirection direction = SnakeDirection.down;
  void updateSnake() {
    setState(() {
      switch (direction) {
        case SnakeDirection.down:
          if (snakePosition.last > 740) {
            snakePosition.add(snakePosition.last + 20 - 760);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;
        case SnakeDirection.up:
          if (snakePosition.last > 740) {
            snakePosition.add(snakePosition.last - 20 + 760);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;
        case SnakeDirection.left:
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 - 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;
        case SnakeDirection.right:
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;
        default:
      }
      if (snakePosition.last == food) {
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void showGameOverScreen() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: Text('You\'re score: ${snakePosition.length}'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    startGame();
                  },
                  child: const Text('Play Again'))
            ],
          );
        });
  }

  void keyHandler(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (direction != SnakeDirection.up) {
        direction = SnakeDirection.down;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (direction != SnakeDirection.down) {
        direction = SnakeDirection.up;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      if (direction != SnakeDirection.left) {
        direction = SnakeDirection.right;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      if (direction != SnakeDirection.right) {
        direction = SnakeDirection.left;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: keyHandler,
      autofocus: true,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != SnakeDirection.up && details.delta.dy > 0) {
                  direction = SnakeDirection.down;
                } else if (direction != SnakeDirection.down &&
                    details.delta.dy < 0) {
                  direction = SnakeDirection.up;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != SnakeDirection.left && details.delta.dx > 0) {
                  direction = SnakeDirection.right;
                } else if (direction != SnakeDirection.right &&
                    details.delta.dx < 0) {
                  direction = SnakeDirection.left;
                }
              },
              child: GridView.builder(
                  itemCount: numberOfSquares,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20),
                  itemBuilder: (context, index) {
                    if (snakePosition.contains(index)) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    if (index == food) {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.green,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.grey.shade900,
                          ),
                        ),
                      );
                    }
                  }),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: startGame,
                    child: const Text('S T A R T'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum SnakeDirection { up, down, left, right }
