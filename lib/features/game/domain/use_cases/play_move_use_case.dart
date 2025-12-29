import 'package:tic_tac_toe/features/game/domain/entities/game.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe/features/game/domain/entities/player.dart';
import 'package:tic_tac_toe/features/game/domain/entities/position.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe/features/game/domain/services/game_services.dart';
import 'package:tic_tac_toe/features/game/domain/exceptions/invalid_move_exception.dart';

class PlayMoveUseCase {
  final GameRepository gameRepository;
  
  static final _gameServices = GameServices.instance;

  PlayMoveUseCase({
    required this.gameRepository,
  });

  GameState _checkGameState({required List<List<Player?>> board, required Player currentPlayer}) {
    if (_gameServices.boardIsWin(board, currentPlayer)) {
      return GameState.won(winner: currentPlayer);
    }
    if (_gameServices.boardIsDraw(board, currentPlayer)) {
      return GameState.draw();
    }
    return GameState.inProgress();
  }

  List<List<Player?>> _deepCopyBoard(List<List<Player?>> board) {
    return List<List<Player?>>.from(
      board.map((r) => List<Player?>.from(r)),
    );
  }

  Future<Game> execute({required Game game, required Position position}) async {
    if (game.board[position.row][position.col] != null) {
      throw const InvalidMoveException(InvalidMoveErrorType.cellAlreadyOccupied);
    }

    if (switch (game.state) {
          NotStarted() || InProgress() => false,
          Won() || Draw() => true,
        }) {
      throw const InvalidMoveException(InvalidMoveErrorType.gameNotInProgress);
    }

    final newBoard = _deepCopyBoard(game.board);
  
    newBoard[position.row][position.col] = game.currentPlayer;
    final Game newGame = game.copyWith(
      board: newBoard,
      lastMove: position,
      state: _checkGameState(board: newBoard, currentPlayer: game.currentPlayer),
      currentPlayer: game.currentPlayer == Player.x() ? Player.o() : Player.x(),
    );
    
    await gameRepository.saveGame(newGame);
    return newGame;
  }
}
