import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/providers/song_list_provider.dart';
import 'package:go_router/go_router.dart';

class SongFavoritesListPage extends ConsumerStatefulWidget {
  static const beginColor = Color.fromARGB(255, 56, 74, 172);
  static const endColor = Colors.black;

  const SongFavoritesListPage({super.key});

  @override
  ConsumerState<SongFavoritesListPage> createState() =>
      _SongFavoritesListPageState();
}

class _SongFavoritesListPageState extends ConsumerState<SongFavoritesListPage> {
  late List<Song> favoriteSongs;

  @override
  void initState() {
    super.initState();
    final songListState = ref.read(songListProvider);
    favoriteSongs = songListState.songs
        .where((song) => song.isFavorite)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final songListState = ref.watch(songListProvider);
    final favoriteMap = {
      for (final s in songListState.songs) s.id: s.isFavorite,
    };

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  SongFavoritesListPage.beginColor,
                  SongFavoritesListPage.endColor,
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 24,
                    color: Colors.white,
                  ),
                  onTap: () {
                    context.pop();
                  },
                ),
                SizedBox(height: 8),
                Text(
                  "Liked Songs",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${favoriteSongs.length} songs",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white60,
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.circle, size: 80, color: Colors.green),
                            Icon(
                              Icons.play_arrow_rounded,
                              size: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.shuffle,
                            size: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (favoriteSongs.isEmpty)
            Text(
              "좋아하는 곡이 없습니다.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            Flexible(
              child: ListView.builder(
                itemCount: favoriteSongs.length,
                itemBuilder: (context, index) {
                  final song = favoriteSongs[index];
                  final isFavorited = favoriteMap[song.id] ?? false;

                  return ListTile(
                    leading: Icon(Icons.abc),
                    title: Text(
                      song.title,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      song.artist,
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        ref
                            .read(songListProvider.notifier)
                            .toggleFavorite(song.id);
                      },
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorited ? Colors.red : Colors.white,
                      ),
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
    );
  }
}
