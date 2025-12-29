import 'package:tic_tac_toe/features/game/domain/entities/game.dart';

abstract class GameRepository {
  Future<Game?> getGame();
  Future<void> saveGame(Game game);

  Future<void> clearGame();
}