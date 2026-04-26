import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/pages/song_favorites_list_page.dart';
import 'package:go_router/go_router.dart';
import 'pages/music_player_page.dart';
import 'pages/song_list_page.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SongListPage()),
    GoRoute(
      path: '/player/:songId',
      pageBuilder: (context, state) {
        final songId = state.pathParameters['songId']!;

        return CustomTransitionPage(
          key: state.pageKey,
          child: MusicPlayerPage(songId: songId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => SongFavoritesListPage(),
    ),
  ],
);
