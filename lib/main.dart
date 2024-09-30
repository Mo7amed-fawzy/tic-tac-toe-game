import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/xo_ui.dart';

void main() {
  runApp(const XOapp());
}

class XOapp extends StatelessWidget {
  const XOapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: XoUi(),
    );
  }
}
