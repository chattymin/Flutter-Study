import 'package:flutter/material.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});
  static const beginColor = Color.fromARGB(255, 177, 166, 99);
  static const endColor = Color.fromARGB(255, 98, 89, 54);
  static const albumImage = 'assets/images/album_nanchun.jpg';

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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                /// top content
                const MusicPlayerTopContents(
                  title: "새소년",
                  onLeftPressed: null,
                  onRightPressed: null,
                ),

                // album image
                SizedBox(height: 32),

                Image.asset('assets/images/album.png', fit: BoxFit.cover),

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

class MusicPlayerTopContents extends StatelessWidget {
  final String title;
  final void Function()? onLeftPressed;
  final void Function()? onRightPressed;

  const MusicPlayerTopContents({
    super.key,
    required this.title,
    required this.onLeftPressed,
    required this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onLeftPressed,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 32),
        ),

        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        IconButton(
          onPressed: onRightPressed,
          icon: Icon(Icons.more_horiz, color: Colors.white, size: 32),
        ),
      ],
    );
  }
}
