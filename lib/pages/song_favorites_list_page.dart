import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/providers/song_list_provider.dart';
import 'package:go_router/go_router.dart';

class SongFavoritesListPage extends ConsumerWidget {
  static const beginColor = Color.fromARGB(255, 177, 166, 99);
  static const endColor = Color.fromARGB(255, 98, 89, 54);

  const SongFavoritesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songListState = ref.watch(songListProvider);
    final favoriteSongs = songListState.songs
        .where((song) => song.isFavorite)
        .toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [beginColor, endColor],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Favorites Songs'),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (favoriteSongs.isEmpty)
                Text("좋아하는 곡이 없습니다.")
              else
                Flexible(
                  child: ListView.builder(
                    itemCount: favoriteSongs.length,
                    itemBuilder: (context, index) {
                      final song = favoriteSongs[index];
                      return ListTile(
                        title: Text(song.title),
                        subtitle: Text(song.artist),
                        trailing: Icon(
                          song.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: song.isFavorite ? Colors.red : Colors.white,
                        ),
                        onTap: () {
                          context.push('/player/${song.id}');
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
