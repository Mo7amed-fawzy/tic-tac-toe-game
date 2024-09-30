import 'package:flutter/material.dart';

class XoUi extends StatefulWidget {
  const XoUi({super.key});

  @override
  State<XoUi> createState() => _XoUiState();
}

class _XoUiState extends State<XoUi> {
  String lastplayes = "X";
  String res = " ";

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
              'itis $lastplayes turn',
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
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Center(
                    child: Text(
                      'فاضيه حليا والله',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          )

// الكونتانر بتاعي عاوز اعمل منو لست فهعمل ليستاوفجينيريت

          // Center(
          //   child: Text(
          //     'X-O $res Game',
          //     style: const TextStyle(
          //       fontSize: 50,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          ,
          const SizedBox(
            height: 140,
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Your button press logic here
            },
            icon: const Icon(Icons.replay_rounded,
                size: 30.0,
                color: Colors.black), // Adjust size and color as needed
            label: const Text(
              'Repeat The Game',
              style: TextStyle(
                fontSize: 20, // Adjust font size to fit
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Adjust padding as needed
            ),
          ),
        ],
      ),
    );
  }
}
