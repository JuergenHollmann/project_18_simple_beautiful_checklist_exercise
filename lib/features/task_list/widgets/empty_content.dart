import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.sentiment_satisfied_alt,
            size: 120,
            color: Colors.yellow,
          ),
          const SizedBox(height: 30),
          /*--------------------------------- Shimmer ---*/
          Shimmer.fromColors(
            period: const Duration(
                milliseconds: 700), // Dauer der Shimmer-Wiederholung
            baseColor: Colors.white,
            highlightColor: const Color.fromRGBO(228, 132, 255, 0.724),
            child: const Text(
              textAlign: TextAlign.center,
              'KEINE Aufgaben\nzu erledigen!',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
          /*--------------------------------- *** ---*/
        ],
      ),
    );
  }
}
