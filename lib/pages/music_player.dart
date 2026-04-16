import 'package:flutter/material.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});
  static const beginColor = Color.fromARGB(255, 177, 166, 99);
  static const endColor = Color.fromARGB(255, 98, 89, 54);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [beginColor, endColor],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                /// top content
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),

                    Text(
                      "새소년",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),

                // album image

                // album info

                // indicator

                // control buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
