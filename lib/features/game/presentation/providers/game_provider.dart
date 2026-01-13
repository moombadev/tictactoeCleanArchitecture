import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/features/game/domain/use_cases/reset_game_use_case.dart';
import '../../domain/entities/game.dart';
import '../../domain/entities/game_mode.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/position.dart';
import '../../domain/exceptions/invalid_move_exception.dart';
import '../../domain/use_cases/play_move_use_case.dart';
import '../../domain/use_cases/load_game_use_case.dart';
import '../../domain/repositories/game_repository.dart';
import '../../data/repositories/game_repository_implement.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/services/impl/audio_service_impl.dart';
import '../../../../core/services/shared_preferences_provider.dart';

part 'game_provider.g.dart';

@riverpod
GameRepository gameRepository(Ref ref) => 
    GameRepositoryImpl(ref.watch(sharedPreferencesProvider));

@riverpod
PlayMoveUseCase playMoveUseCase(Ref ref) => 
    PlayMoveUseCase(gameRepository: ref.watch(gameRepositoryProvider));

@riverpod
LoadGameUseCase loadGameUseCase(Ref ref) => 
    LoadGameUseCase(gameRepository: ref.watch(gameRepositoryProvider));

@riverpod
ResetGameUseCase resetGameUseCase(Ref ref) => 
    ResetGameUseCase(gameRepository: ref.watch(gameRepositoryProvider));

@Riverpod(keepAlive: true)
AudioService audioService(Ref ref) {
  final service = AudioServiceImpl();
  ref.onDispose(() => service.dispose());
  return service;
}

@riverpod
class GameController extends _$GameController {
  Player? _startingPlayer;

  @override
  FutureOr<Game?> build() async {
    return null;
  }

  Future<void> initializeGame(Player startingPlayer) async {
    _startingPlayer = startingPlayer;

    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(loadGameUseCaseProvider);
      return await useCase.execute(startingPlayer: startingPlayer);
    });
  }

  Future<void> makeMove(Position position) async {
    final currentGame = state.value;
    if (currentGame == null) return;

    if (currentGame.state is! InProgress && currentGame.state is! NotStarted) {
      ref.read(audioServiceProvider).playErrorSound();
      return;
    }

    try {
      final newGame = await ref.read(playMoveUseCaseProvider).execute(
        game: currentGame,
        position: position,
      );
      state = AsyncData(newGame);
    } on InvalidMoveException {
      ref.read(audioServiceProvider).playErrorSound();
    }
  }

  Future<void> resetGame({Player? startingPlayer}) async {
    final playerToUse = startingPlayer ?? _startingPlayer ?? const Player.x();
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => 
      ref.read(resetGameUseCaseProvider).execute(
        mode: GameMode.vsPlayer(),
        startingPlayer: playerToUse,
      )
    );
  }

}
