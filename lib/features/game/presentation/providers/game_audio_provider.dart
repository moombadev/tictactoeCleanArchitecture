import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/game.dart';
import '../../domain/entities/game_state.dart';
import 'game_provider.dart';

part 'game_audio_provider.g.dart';

@riverpod
class GameAudioController extends _$GameAudioController {
  @override
  void build() {
    ref.listen<AsyncValue<Game?>>(
      gameControllerProvider,
      (previous, next) {
        _handleGameStateChange(previous?.value, next.value);
      },
    );
  }

  void _handleGameStateChange(Game? previousGame, Game? currentGame) {
    if (currentGame == null) return;

    if (previousGame == null && currentGame.state is! NotStarted) return;

    final previousState = previousGame?.state;
    final currentState = currentGame.state;

    if (previousState?.runtimeType != currentState.runtimeType) {
      _handleStateTransition(previousState, currentState);
    }

    if (_hasMoveBeenPlayed(previousGame, currentGame) &&
        currentState is InProgress) {
      _playMoveSound(currentGame);
    }
  }

  Future<void> _handleStateTransition(
    GameState? previousState,
    GameState currentState,
  ) async {
    final audioService = ref.read(audioServiceProvider);

    try {
      await switch (currentState) {
        NotStarted() => Future.value(), 
        Won() => audioService.playVictorySound(),
        Draw() => audioService.playDrawSound(),
        InProgress() => Future.value(), 
      };
    } catch (e) {
      debugPrint('Erreur lors de la lecture du son d\'état: $e');
    }
  }

  Future<void> _playMoveSound(Game currentGame) async {
    try {
      final audioService = ref.read(audioServiceProvider);
      await audioService.playMoveSound(currentGame.currentPlayer);
    } catch (e) {
      debugPrint('Erreur lors de la lecture du son de coup: $e');
    }
  }

  bool _hasMoveBeenPlayed(Game? previousGame, Game currentGame) {
    if (previousGame == null) return false;
    return currentGame.lastMove != null &&
           currentGame.lastMove != previousGame.lastMove;
  }
}

