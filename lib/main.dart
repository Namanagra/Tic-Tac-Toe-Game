import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
// ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;

// 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 220, 207),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'PLAYER X',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 2.0,
                                  offset: Offset(2.0, 2.0),
                                )
                              ],
                              color: Color.fromARGB(255, 61, 34, 24)),
                        ),
                        Text(
                          xScore.toString(),
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 2.0,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                              color: Color.fromARGB(255, 59, 29, 18)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('PLAYER O',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    blurRadius: 2.0,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                                color: Color.fromARGB(255, 61, 31, 20))),
                        Text(
                          oScore.toString(),
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 2.0,
                                  offset: Offset(2.0, 2.0),
                                )
                              ],
                              color: Color.fromARGB(255, 62, 30, 19)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: SizedBox(
                height: 600,
                width: 600,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.orange,
                                    Colors.yellow
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 3, color: Colors.brown)),
                          child: Center(
                            child: Text(
                              displayElement[index],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      blurRadius: 2.0,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                  fontSize: 50),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: _clearScoreBoard,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 71, 37, 24)),
                    ),
                    child: const Text(
                      "Clear Score Board",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 217, 204),
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 2.0,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
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
            title: Text("\" " + winner + " \" is Winner!!!"),
            backgroundColor: const Color.fromARGB(255, 255, 219, 205),
            actions: [
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 67, 32, 19))),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Play Again",
                  style: TextStyle(color: Color.fromARGB(255, 248, 211, 197)),
                ),
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
            backgroundColor: const Color.fromARGB(255, 255, 219, 205),
            actions: [
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 67, 32, 19))),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Play Again",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 212, 197),
                  ),
                ),
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
