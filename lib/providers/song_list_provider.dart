import 'package:flutter_riverpod/flutter_riverpod.dart';

class Song {
  final int id;
  final String title;
  final String artist;
  final int duration;
  final String? albumArt;
  final bool isFavorite;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    this.albumArt,
    required this.isFavorite,
  });

  Song copyWith({
    int? id,
    String? title,
    String? artist,
    int? duration,
    String? albumArt,
    bool? isFavorite,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      albumArt: albumArt ?? this.albumArt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

const _songs = [
  Song(
    id: 0,
    title: 'NAN CHUN 난춘',
    artist: '새소년',
    duration: 228,
    isFavorite: false,
  ),
  Song(
    id: 1,
    title: 'Blue',
    artist: '볼빨간사춘기',
    duration: 200,
    isFavorite: false,
  ),
  Song(id: 2, title: 'Butter', artist: 'BTS', duration: 180, isFavorite: false),
  Song(
    id: 3,
    title: 'Super Shy',
    artist: 'NewJeans',
    duration: 160,
    isFavorite: false,
  ),
  Song(
    id: 4,
    title: 'Ditto',
    artist: 'NewJeans',
    duration: 140,
    isFavorite: false,
  ),
];

class SongListState {
  final List<Song> songs;

  SongListState({required this.songs});
}

class SongListNotifier extends Notifier<SongListState> {
  @override
  SongListState build() {
    return SongListState(songs: _songs);
  }

  void toggleFavorite(int songId) {
    state =
        [
              for (final song in state.songs)
                {
                  if (song.id == songId)
                    {song.copyWith(isFavorite: !song.isFavorite!)}
                  else
                    song,
                },
            ]
            as SongListState;
  }
}

final songListProvider = NotifierProvider<SongListNotifier, SongListState>(
  SongListNotifier.new,
);
