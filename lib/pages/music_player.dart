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
                const SizedBox(height: 32),
                Image.asset(albumImage, fit: BoxFit.cover),

                // album info
                const SizedBox(height: 32),
                const AlbumInfo(title: "NAN CHUN 난춘", artist: "새소년"),

                // music play slider
                MusicPlayerSlider(
                  musicFullSec: 228,
                  musicCurrentSec: 112,
                  onSliderChanged: (value) {
                    // control music state
                  },
                ),

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
        GestureDetector(
          onTap: onLeftPressed,
          child: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 32,
          ),
        ),

        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        GestureDetector(
          onTap: onLeftPressed,
          child: const Icon(Icons.more_horiz, color: Colors.white, size: 32),
        ),
      ],
    );
  }
}

class AlbumInfo extends StatelessWidget {
  final String title;
  final String artist;

  const AlbumInfo({super.key, required this.title, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              artist,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.favorite_outline, color: Colors.white),
          iconSize: 32,
        ),
      ],
    );
  }
}

class MusicPlayerSlider extends StatelessWidget {
  final int musicFullSec;
  final int musicCurrentSec;
  final void Function(double)? onSliderChanged;

  const MusicPlayerSlider({
    super.key,
    required this.musicFullSec,
    required this.musicCurrentSec,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 5,
            padding: EdgeInsets.only(top: 16),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white24,
            thumbColor: Colors.white,
          ),
          child: Slider(
            value: musicCurrentSec / musicFullSec.toDouble(),
            onChanged: onSliderChanged,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatMillisec(musicCurrentSec),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "-${_formatMillisec(musicFullSec - musicCurrentSec)}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatMillisec(int sec) {
    final minutes = sec ~/ 60;
    final seconds = (sec % 60);
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
