import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  static const beginColor = Color.fromARGB(255, 177, 166, 99);
  static const endColor = Color.fromARGB(255, 98, 89, 54);
  static const albumImage = 'assets/images/album_nanchun.jpg';
  static const title = "난춘";
  static const artist = "새소년";
  static const musicFullSec = 228;

  bool _isLiked = false;
  bool _isPlaying = true;
  int _musicCurrentSec = 112;

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
                  title: artist,
                  onLeftPressed: null,
                  onRightPressed: null,
                ),

                // album image
                const SizedBox(height: 32),
                Image.asset(albumImage, fit: BoxFit.cover),

                // album info
                const SizedBox(height: 32),
                AlbumInfo(
                  title: title,
                  artist: artist,
                  isLiked: _isLiked,
                  onLikePressed: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                ),

                // music play slider
                MusicPlayerSlider(
                  musicFullSec: musicFullSec,
                  musicCurrentSec: _musicCurrentSec,
                  onSliderChanged: (value) {
                    setState(() {
                      _musicCurrentSec = (value * musicFullSec).toInt();
                    });
                  },
                ),

                // music controller
                const SizedBox(height: 12),
                MusicController(
                  isPlaying: _isPlaying,
                  onNextPressed: null,
                  onPreviousPressed: null,
                  onPlayPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                  onRepeatPressed: null,
                  onShufflePressed: null,
                ),
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
  final bool isLiked;
  final void Function()? onLikePressed;

  const AlbumInfo({
    super.key,
    required this.title,
    required this.artist,
    required this.isLiked,
    required this.onLikePressed,
  });

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

        GestureDetector(
          onTap: onLikePressed,
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_outline,
            color: Colors.white,
            size: 32,
          ),
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

class MusicController extends StatelessWidget {
  final bool isPlaying;
  final void Function()? onShufflePressed;
  final void Function()? onPreviousPressed;
  final void Function()? onPlayPressed;
  final void Function()? onNextPressed;
  final void Function()? onRepeatPressed;

  const MusicController({
    super.key,
    required this.isPlaying,
    required this.onShufflePressed,
    required this.onPreviousPressed,
    required this.onPlayPressed,
    required this.onNextPressed,
    required this.onRepeatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onShufflePressed,
          child: const Icon(Icons.shuffle, color: Colors.white24, size: 24),
        ),

        GestureDetector(
          onTap: onPreviousPressed,
          child: const Icon(Icons.skip_previous, color: Colors.white, size: 48),
        ),

        GestureDetector(
          onTap: onPlayPressed,
          child: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            color: Colors.white,
            size: 96,
          ),
        ),

        GestureDetector(
          onTap: onNextPressed,
          child: const Icon(Icons.skip_next, color: Colors.white, size: 48),
        ),

        GestureDetector(
          onTap: onRepeatPressed,
          child: const Icon(Icons.repeat, color: Colors.white24, size: 24),
        ),
      ],
    );
  }
}
