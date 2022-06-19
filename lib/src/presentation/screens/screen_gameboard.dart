import 'package:flutter/material.dart';
import 'package:tictactoe/src/presentation/screens/screen_home.dart';

class GameBoardScreen extends StatefulWidget {
  const GameBoardScreen({Key? key}) : super(key: key);

  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  String? firstPlayer,
      secondPlayer,
      firstSide = 'X',
      secondSide = '0',
      currentMove,
      playerToWin;
  int moveCounter = 1;

  var cellBlocks = List.filled(9, '');
  var winingConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  playerMove(index) {
    if (currentMove == null) {
      currentMove = firstSide;
    } else if (currentMove == firstSide) {
      currentMove = secondSide;
    } else if (currentMove == secondSide) {
      currentMove = firstSide;
    }
    if (cellBlocks[index] == '') {
      cellBlocks[index] = currentMove!;
      for (var i = 0; i < winingConditions.length; i++) {
        String symbolEntered = cellBlocks[index];
        if (symbolEntered == firstSide) {
          playerToWin = firstPlayer;
        } else {
          playerToWin = secondPlayer;
        }
        if (symbolEntered == cellBlocks[winingConditions[i][0]] &&
            symbolEntered == cellBlocks[winingConditions[i][1]] &&
            symbolEntered == cellBlocks[winingConditions[i][2]]) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('${cellBlocks[index]}  WINS'),
              content: Image.asset('images/winner.png'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Restart Game",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          );

          break;
        }
      }
      if (moveCounter == 9) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('GAME DRAW'),
            content: Image.asset('images/draw.png'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Restart Game'),
              ),
            ],
          ),
        );
      }
      moveCounter++;
    } else
      return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Player One : $firstSide',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('Player Two : $secondSide',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: cellBlocks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            cellBlocks[index],
                            style: TextStyle(
                                color: cellBlocks[index] == 'X'
                                    ? Colors.blue
                                    : Colors.purpleAccent,
                                fontSize: 48,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        playerMove(index);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                        child: Text(
                      "New Game",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.white),
                    )),
                  ),
                  onTap: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }
}
