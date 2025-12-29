import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/choose_side_page.dart';
import '../../features/game/presentation/pages/board_game_page.dart';
import 'page_transitions.dart';
import 'routes.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => slideToTopPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.chooseSide,
        pageBuilder: (context, state) => slideFromBottomPushTopOut(
          key: state.pageKey,
          child: const ChooseSidePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.game,
        pageBuilder: (context, state) {
          final playerString = state.uri.queryParameters['player'] ?? 'x';
          // Validation du paramètre
          final playerValue = playerString.toLowerCase();
          if (playerValue != 'x' && playerValue != 'o') {
            // Redirection vers home si paramètre invalide
            return slideToTopPage(
              key: state.pageKey,
              child: const HomePage(),
            );
          }
          return slideFromBottomPushTopOut(
            key: state.pageKey,
            child: BoardGamePage(startingPlayer: playerValue),
          );
        },
      ),
    ],
  );
}
