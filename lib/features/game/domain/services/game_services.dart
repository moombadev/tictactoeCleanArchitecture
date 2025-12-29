import 'package:tic_tac_toe/features/game/domain/entities/player.dart';

class GameServices {

  static final GameServices instance = GameServices._internal();
  
  factory GameServices() => instance;


  GameServices._internal();

  bool boardIsFull(List<List<Player?>> board) {
    return board.every((row) => row.every((cell) => cell != null));
  }

  bool boardIsEmpty(List<List<Player?>> board) {
    return board.every((row) => row.every((cell) => cell == null));
  }

  bool checkRow(List<List<Player?>> board, int row, Player player) {
    return board[row].every((cell) => cell == player);
  }

  bool checkColumn(List<List<Player?>> board, int column, Player player) {
    return board.every((row) => row[column] == player);
  }

  bool checkDiagonal(List<List<Player?>> board, Player player) {
    bool mainDiagonal = true;
    for (int i = 0; i < board.length; i++) {
      if (board[i][i] != player) {
        mainDiagonal = false;
        break;
      }
    }
    if (mainDiagonal) return true;

    bool secondaryDiagonal = true;
    for (int i = 0; i < board.length; i++) {
      if (board[i][board.length - 1 - i] != player) {
        secondaryDiagonal = false;
        break;
      }
    }
    return secondaryDiagonal;
  }

  bool boardIsWin(List<List<Player?>> board, Player player) {
    return checkRow(board, 0, player) ||
        checkRow(board, 1, player) ||
        checkRow(board, 2, player) ||
        checkColumn(board, 0, player) ||
        checkColumn(board, 1, player) ||
        checkColumn(board, 2, player) ||
        checkDiagonal(board, player);
  }

  bool boardIsDraw(List<List<Player?>> board, Player lastPlayer) {
    return boardIsFull(board) && !boardIsWin(board, lastPlayer);
  }
}

