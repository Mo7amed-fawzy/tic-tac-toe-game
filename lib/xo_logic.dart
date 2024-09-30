class Players {
  String p1 = "X";
  String p2 = "O";
  static String p3 = "";
}

class Game {
  List<String> board = []; // دي الهملا فيها
  List<int> winningLine = []; // لتحديد مواقع الفوز

  List<String>? initgame() {
    return List.generate(
        9, (index) => Players.p3); // عشان اكريت لست 9 اماكن فاضيه
  }

  // تعديل دالة الفحص لتعيد مواقع الفوز
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
      winningLine = _getWinningLine(scoreboard);
      return true;
    }

    return false;
  }

  List<int> _getWinningLine(List<int> scoreboard) {
    // بتشك علي الصفوف
    for (int i = 0; i < 3; i++) {
      if (scoreboard[i].abs() == 3) {
        return [i * 3, i * 3 + 1, i * 3 + 2]; // الخط الأفقي
      }
    }

    // بتشك علي الأعمدة
    for (int i = 0; i < 3; i++) {
      if (scoreboard[3 + i].abs() == 3) {
        return [i, i + 3, i + 6]; // الخط العمودي
      }
    }

    // بتشك علي Main diagonal
    if (scoreboard[6].abs() == 3) {
      return [0, 4, 8]; // القطر الرئيسي
    }

    // بتشك علي  Secondary diagonal
    if (scoreboard[7].abs() == 3) {
      return [2, 4, 6]; // القطر الثانوي
    }

    return [];
  }

  List<int> getWinningLine() {
    return winningLine;
  }
}
