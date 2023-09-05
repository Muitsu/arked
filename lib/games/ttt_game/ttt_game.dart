import 'package:flutter/material.dart';

class TttGame extends StatefulWidget {
  final bool isTwoPlayer;
  const TttGame({super.key, this.isTwoPlayer = false});

  @override
  TttGameState createState() => TttGameState();
}

class TttGameState extends State<TttGame> {
  bool oTurn = true;

// 1st player is O
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Player X',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      xScore.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Player O',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(
                      oScore.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 0.25,
            width: size.width * 0.25,
            child: GridView.builder(
                itemCount: 9,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (widget.isTwoPlayer) {
                        _tapped(index);
                      } else {
                        if (!oTurn) return;
                        _tapped(index);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text(
                          board[index],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _clearScoreBoard,
                child: const Text("Clear Score Board"),
              ),
            ],
          ))
        ],
      ),
    );
  }

  void _tapped(int index) async {
    setState(() {
      if (oTurn && board[index] == '') {
        board[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && board[index] == '') {
        board[index] = 'X';
        filledBoxes++;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
    if (!widget.isTwoPlayer) {
      int aiMove = await getAiMove(board);
      setState(() {
        board[aiMove] = 'X';
        filledBoxes++;
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  Future<int> getAiMove(List<String> board) async {
    await Future.delayed(const Duration(milliseconds: 1800));
    List<String> newBoard = List.from(board);
    int bestMove = 0;
    //Simulate
    for (int currentMove = 0; currentMove < board.length; currentMove++) {
      if (board[currentMove].isNotEmpty) continue;
      newBoard[currentMove] = 'X';
      // int newMove = -_aiCheckWinner(newBoard, currentMove);
      // bestMove = newMove;
      // if (newMove > bestMove) {
      //   bestMove = newMove;
      // }
      bestMove = currentMove;
    }
    return bestMove;
  }

  void _checkWinner() {
    // Checking rows
    if (board[0] == board[1] && board[0] == board[2] && board[0] != '') {
      _showWinDialog(board[0]);
    }
    if (board[3] == board[4] && board[3] == board[5] && board[3] != '') {
      _showWinDialog(board[3]);
    }
    if (board[6] == board[7] && board[6] == board[8] && board[6] != '') {
      _showWinDialog(board[6]);
    }

    // Checking Column
    if (board[0] == board[3] && board[0] == board[6] && board[0] != '') {
      _showWinDialog(board[0]);
    }
    if (board[1] == board[4] && board[1] == board[7] && board[1] != '') {
      _showWinDialog(board[1]);
    }
    if (board[2] == board[5] && board[2] == board[8] && board[2] != '') {
      _showWinDialog(board[2]);
    }

    // Checking Diagonal
    if (board[0] == board[4] && board[0] == board[8] && board[0] != '') {
      _showWinDialog(board[0]);
    }
    if (board[2] == board[4] && board[2] == board[6] && board[2] != '') {
      _showWinDialog(board[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" $winner \" is Winner!!!"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        board[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        board[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
