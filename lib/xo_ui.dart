import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/xo_logic.dart';

class XoUi extends StatefulWidget {
  const XoUi({super.key});

  @override
  State<XoUi> createState() => _XoUiState();
}

class _XoUiState extends State<XoUi> {
  // String lastplayer = "X";
  String res = " ";
  bool gameOver = false;
  Game g = Game();
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];

  List<int> winningLine = []; //  مكان الفوز

  String player1Name = "Player 1";
  String player2Name = "Player 2";
  int turn = 0; //  لتحديد اللاعب الحالي (0 للاعب 1، 1 للاعب 2)

  @override
  void initState() {
    // اول ما افتح يناديلي علي الفنكشن واحلطها لست فاضيه وارجعها فالبورد
    super.initState();
    g.board = g.initgame()!;

    // بدخل اسامي اللاعبين اول مدخل
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPlayerDialog();
    });
  }

  // دالة لعرض Dialog لجمع أسماء اللاعبين
  void _showPlayerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String p1 = player1Name;
        String p2 = player2Name;
        return AlertDialog(
          title: const Text('Enter Player Names'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Player 1 Name'),
                onChanged: (value) {
                  p1 = value; // تحديث اسم اللاعب الأول
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Player 2 Name'),
                onChanged: (value) {
                  p2 = value; // تحديث اسم اللاعب الثاني
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  player1Name =
                      p1.isNotEmpty ? p1 : "Player 1"; // بسيت اللاعب الاول
                  player2Name =
                      p2.isNotEmpty ? p2 : "Player 2"; // بسيت اللاعب التاني
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetPlayerNames() {
    _showPlayerDialog();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: _resetPlayerNames,
          ),
        ],
      ),
      body: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'turn is :',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              ' ${turn % 2 == 0 ? player1Name : player2Name}', // عرض اسم اللاعب الحالي
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: SizedBox(
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
                                g.board[index] = turn % 2 == 0 ? "X" : "O";

                                gameOver = g.winnercheck(index, g.board[index],
                                    scoreboard); // winner=> 3|-3

                                if (gameOver) {
                                  res =
                                      "${turn % 2 == 0 ? player1Name : player2Name} wins!"; // عرض اسم الفائز
                                  winningLine = g.getWinningLine(); //  الفايز
                                } else if (!g.board.contains("")) {
                                  res = "T3aadol...";
                                }

                                // if (lastplayer == "X") {
                                //   lastplayer = "O";
                                // } else {
                                //   lastplayer = "X";
                                // }
                                turn++; // علشان اغير اللاعب
                              });
                            }
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: winningLine.contains(index)
                            ? Colors.green
                            : Colors.deepPurple, // تمييز المربع الفائز
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          g.board[index],
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: g.board[index] == "X"
                                ? Colors.lightBlueAccent
                                : Colors.pinkAccent,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )

// الكونتانر بتاعي عاوز اعمل منو لست فهعمل ليستاوفجينيريت

          ,
          Text(
            res,
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                turn = 0; // إعادة تعيين العداد
                res = " ";
                gameOver = false;
                scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                g.board = g.initgame()!;
                winningLine = []; // إعادة تعيين winningLine إلى قائمة فارغة
              });
            },
            icon:
                const Icon(Icons.replay_rounded, size: 20, color: Colors.black),
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
