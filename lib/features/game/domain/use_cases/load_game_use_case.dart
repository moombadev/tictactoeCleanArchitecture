import 'package:tic_tac_toe/features/game/domain/entities/game.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_toe/features/game/domain/entities/player.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/game_repository.dart';

class LoadGameUseCase {
  final GameRepository gameRepository;

  LoadGameUseCase({required this.gameRepository});

  Future<Game> execute({required Player startingPlayer}) async {
    final Game? game = await gameRepository.getGame();
    if (game == null) {
      return Game.initial(
        mode: GameMode.vsPlayer(),
        startingPlayer: startingPlayer,
      );
    }
    return game;
  }
}