import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = List();
    player2 = List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "0";
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => dialogBox("Game Tied",
                  "Press the reset button to start again.", resetGame));
        } else {
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = List();

// todo : initialize auto-play list by creating a loop
    var random = Random();
    var x = random.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[x];
    int i = buttonsList.indexWhere((index) => index.id == cellID);
    playGame(buttonsList[i]);
  }

  int checkWinner() {
    var winner = -1;
    // todo: add the winning logic here there will be a rows logic , columns logic and diagonal logic.

    if (winner != -1) {
      winner == 1
          ? showDialog(
              context: context,
              builder: (_) => dialogBox("Player 1 Won",
                  "Press the reset button to start again.", resetGame),
            )
          : showDialog(
              context: context,
              builder: (_) => dialogBox("Player 2 Won",
                  "Press the reset button to start again.", resetGame),
            );
    }
    return winner;
  }

  void resetGame() {
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tic Tac Toe"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 9.0),
                itemCount: buttonsList.length,
                itemBuilder: (context, i) => SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () {}, //TODO: add an onPressed function
                    child: Text(
                      '', // todo: display text in the element (x or o)
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: , // todo: add the background colour
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.red,
              padding: const EdgeInsets.all(20.0),
              onPressed: resetGame,
            )
          ],
        ));
  }
}

class GameButton {
  final id;
  String text;
  Color bg;
  bool enabled;

  GameButton(
      {this.id, this.text = "", this.bg = Colors.grey, this.enabled = true});
}

Widget dialogBox(String title, String content, Function callback) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      FlatButton(
        onPressed: callback,
        color: Colors.white,
        child: Text('Reset'),
      )
    ],
  );
}
