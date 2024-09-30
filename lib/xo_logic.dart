class Players {
  String p1 = "X";
  String p2 = "O";
  static String p3 = "";
}

class Game {
  List<String> board = []; // دي الهملا فيها
  // List<String>? b; // فعلت النل سيفتي

  List<String>? initgame() {
    return List.generate(
        9, (index) => Players.p3); // عشان اكريت لست 9 اماكن فاضيه
  }

  bool winnercheck(int index, String player, List<int> scoreboard) {
    int score = player == "X" ? 1 : -1;

    int row = index ~/ 3; // Integer division يعني منغير كسور عشرية~
    scoreboard[row] += score;

    int col = index % 3; // Column calculation
    scoreboard[3 + col] += score;

    // Check for diagonals
    if (row == col) {
      // Main diagonal
      scoreboard[6] += score;
    }
    if (2 - row == col) {
      // Secondary diagonal
      scoreboard[7] += score;
    }

    // Check if there's a winner
    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }

    return false;
  }
}
