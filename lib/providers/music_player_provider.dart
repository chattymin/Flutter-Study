import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayerState {
  final bool isPlaying;
  final double musicCurrentSec;
  final int? currentSongId;

  MusicPlayerState({
    required this.isPlaying,
    required this.musicCurrentSec,
    this.currentSongId,
  });

  MusicPlayerState copyWith({
    bool? isPlaying,
    double? musicCurrentSec,
    int? currentSongId,
  }) {
    return MusicPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      musicCurrentSec: musicCurrentSec ?? this.musicCurrentSec,
      currentSongId: currentSongId ?? this.currentSongId,
    );
  }
}

class MusicPlayerNotifier extends Notifier<MusicPlayerState> {
  @override
  MusicPlayerState build() {
    return MusicPlayerState(
      isPlaying: false,
      musicCurrentSec: 0.0,
      currentSongId: null,
    );
  }

  void togglePlay() => state = state.copyWith(isPlaying: !state.isPlaying);
  void seekTo(double position) =>
      state = state.copyWith(musicCurrentSec: position);
  void setCurrentSongId(int songId) =>
      state = state.copyWith(currentSongId: songId, musicCurrentSec: 0);
}

final musicPlayerProvider =
    NotifierProvider<MusicPlayerNotifier, MusicPlayerState>(
      MusicPlayerNotifier.new,
    );
