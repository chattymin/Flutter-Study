import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/providers/music_player_provider.dart';
import 'package:flutter_study/providers/song_list_provider.dart';
import 'package:go_router/go_router.dart';

class MusicPlayerPage extends ConsumerWidget {
  final String songId;
  const MusicPlayerPage({super.key, required this.songId});

  static const beginColor = Color.fromARGB(255, 177, 166, 99);
  static const endColor = Color.fromARGB(255, 98, 89, 54);
  static const defaultAlbumImage = 'assets/images/album_nanchun.jpg';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicPlayerState = ref.watch(musicPlayerProvider);
    final songListState = ref.watch(songListProvider);
    final song = songListState.songs.firstWhere(
      (song) => song.id == int.parse(songId),
    );

    ref.listen(musicPlayerProvider, (previous, next) {
      if (next.isPlaying) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("재생중")));
      }
    });

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
                MusicPlayerTopContents(
                  title: song.artist,
                  onLeftPressed: () => context.pop(),
                  onRightPressed: null,
                ),

                // album image
                const SizedBox(height: 32),
                Image.asset(
                  song.albumArt ?? defaultAlbumImage,
                  fit: BoxFit.cover,
                ),

                // album info
                const SizedBox(height: 32),
                AlbumInfo(
                  title: song.title,
                  artist: song.artist,
                  isLiked: song.isFavorite,
                  onLikePressed: () {
                    ref.read(songListProvider.notifier).toggleFavorite(song.id);
                  },
                ),

                // music play slider
                MusicPlayerSlider(
                  musicFullSec: song.duration,
                  musicCurrentSec: musicPlayerState.musicCurrentSec,
                  onSliderChanged: (value) {
                    ref
                        .read(musicPlayerProvider.notifier)
                        .seekTo(value * song.duration);
                  },
                ),

                // music controller
                const SizedBox(height: 12),
                MusicController(
                  isPlaying: musicPlayerState.isPlaying,
                  onNextPressed: null,
                  onPreviousPressed: null,
                  onPlayPressed: () {
                    ref.read(musicPlayerProvider.notifier).togglePlay();
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
          onTap: onRightPressed,
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
            color: isLiked ? Colors.red : Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}

class MusicPlayerSlider extends StatelessWidget {
  final int musicFullSec;
  final double musicCurrentSec;
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
            value: musicCurrentSec / musicFullSec,
            onChanged: onSliderChanged,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatAudioTime(musicCurrentSec),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "-${_formatAudioTime(musicFullSec - musicCurrentSec)}",
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

  String _formatAudioTime(double sec) {
    final minutes = sec ~/ 60;
    final seconds = (sec % 60).toInt();
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
