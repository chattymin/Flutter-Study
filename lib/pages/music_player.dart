import 'package:flutter/material.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});
  final beginColor = const Color.fromARGB(255, 177, 166, 99);
  final endColor = const Color.fromARGB(255, 98, 89, 54);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [beginColor, endColor],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: const Column(children: [
            
          ],
        ),
      ),
    );
  }
}
