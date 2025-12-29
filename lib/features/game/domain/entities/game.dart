import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/core/constants/app_constant.dart';
import 'player.dart';
import 'game_state.dart';
import 'game_mode.dart';
import 'position.dart';
part 'game.freezed.dart';
part 'game.g.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    required List<List<Player?>> board,
    required Player currentPlayer,
    required GameState state,
    required GameMode mode,
    Position? lastMove,
  }) = _Game;

  factory Game.initial({
    required GameMode mode,
    required Player startingPlayer,
  }) => Game(
        board: List.generate(
          boardSize,
          (_) => List.generate(boardSize, (_) => null),
        ),
        currentPlayer: startingPlayer,
        state: const GameState.notStarted(),
        mode: mode,
        lastMove: null,
      );

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

