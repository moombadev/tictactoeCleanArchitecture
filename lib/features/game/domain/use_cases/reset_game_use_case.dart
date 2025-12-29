import 'package:tic_tac_toe/features/game/domain/entities/game.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_toe/features/game/domain/entities/player.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/game_repository.dart';

class ResetGameUseCase {
  final GameRepository gameRepository;

  ResetGameUseCase({required this.gameRepository});

  Future<Game> execute({
    required GameMode mode,
    required Player startingPlayer,
  }) async {
    await gameRepository.clearGame();
    return Game.initial(mode: mode, startingPlayer: startingPlayer);
  }
}