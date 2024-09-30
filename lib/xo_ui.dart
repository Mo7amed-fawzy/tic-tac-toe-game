import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/xo_logic.dart';

class XoUi extends StatefulWidget {
  const XoUi({super.key});

  @override
  State<XoUi> createState() => _XoUiState();
}

class _XoUiState extends State<XoUi> {
  String lastplayer = "X";
  String res = " ";
  bool gameOver = false;
  Game g = Game();
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  @override
  void initState() {
    // اول ما افتح يناديلي علي الفنكشن واحلطها لست فاضيه وارجعها فالبورد
    super.initState();
    g.board = g.initgame()!;
  }

  @override
  Widget build(BuildContext context) {
    double boardwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'X-O Game',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'itis $lastplayer turn',
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: boardwidth,
            height: boardwidth,
            child: GridView.count(
              crossAxisCount: 3, // دا عدد العناصر فالروو
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              children: List.generate(9, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null // لو بتروو رجعلي نل
                      : () {
                          if (g.board[index] ==
                              "") // فحال داس علي العلامه الفاضيه
                          {
                            setState(() {
                              g.board[index] = lastplayer;

                              gameOver = g.winnercheck(index, lastplayer,
                                  scoreboard); // winner=> 3|-3
                              if (gameOver) {
                                res = "$lastplayer is the winner!";
                              } else if (!g.board.contains("")) {
                                res = "T3aadol...";
                              }

                              if (lastplayer == "X") {
                                lastplayer = "O";
                              } else {
                                lastplayer = "X";
                              }
                            });
                          }
                        },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Text(
                        g.board[index],
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: g.board[index] == "X"
                                ? Colors.lightBlueAccent
                                : Colors.pinkAccent),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )

// الكونتانر بتاعي عاوز اعمل منو لست فهعمل ليستاوفجينيريت

          ,
          const SizedBox(
            height: 30,
          ),
          Text(
            res,
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                lastplayer = "X";
                res = " ";
                gameOver = false;
                scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                g.board = g.initgame()!;
              });
            },
            icon: const Icon(Icons.replay_rounded,
                size: 30.0, color: Colors.black),
            label: const Text(
              'Repeat The Game',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}
