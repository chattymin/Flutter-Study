import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/providers/music_player_provider.dart';
import 'package:flutter_study/providers/song_list_provider.dart';
import 'package:go_router/go_router.dart';

class SongListPage extends ConsumerWidget {
  const SongListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songListState = ref.watch(songListProvider);
    final playerState = ref.watch(musicPlayerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('내 음악'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              context.push('/favorites');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: songListState.songs.length,
        itemBuilder: (context, index) {
          final song = songListState.songs[index];
          final isCurrentSong =
              ref.read(musicPlayerProvider).currentSongId == song.id;
          return ListTile(
            leading: Icon(
              isCurrentSong && playerState.isPlaying
                  ? Icons.equalizer
                  : Icons.music_note,
              color: isCurrentSong ? Colors.green : null,
            ),
            title: Text(
              song.title,
              style: TextStyle(
                color: isCurrentSong ? Colors.green : null,
                fontWeight: isCurrentSong ? FontWeight.bold : null,
              ),
            ),
            subtitle: Text(song.artist),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              if (!isCurrentSong) {
                ref
                    .read(musicPlayerProvider.notifier)
                    .setCurrentSongId(song.id);
              }
              context.push('/player/${song.id}');
            },
          );
        },
      ),
    );
  }
}
