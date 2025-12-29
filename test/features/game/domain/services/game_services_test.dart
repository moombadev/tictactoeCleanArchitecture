import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/player.dart';
import 'package:tic_tac_toe/features/game/domain/services/game_services.dart';

void main() {
  late GameServices gameServices;

  setUp(() {
    gameServices = GameServices();
  });

  group('boardIsFull', () {
    test('should return true when board is completely filled', () {
      final board = [
        [Player.x(), Player.o(), Player.x()],
        [Player.o(), Player.x(), Player.o()],
        [Player.x(), Player.o(), Player.x()],
      ];

      expect(gameServices.boardIsFull(board), isTrue);
    });

    test('should return false when board has empty cells', () {
      final board = [
        [Player.x(), Player.o(), null],
        [Player.o(), Player.x(), Player.o()],
        [Player.x(), Player.o(), Player.x()],
      ];

      expect(gameServices.boardIsFull(board), isFalse);
    });

    test('should return false when board is empty', () {
      final board = [
        [null, null, null],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsFull(board), isFalse);
    });
  });

  group('boardIsEmpty', () {
    test('should return true when board is completely empty', () {
      final board = [
        [null, null, null],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsEmpty(board), isTrue);
    });

    test('should return false when board has at least one filled cell', () {
      final board = [
        [Player.x(), null, null],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsEmpty(board), isFalse);
    });

    test('should return false when board is completely filled', () {
      final board = [
        [Player.x(), Player.o(), Player.x()],
        [Player.o(), Player.x(), Player.o()],
        [Player.x(), Player.o(), Player.x()],
      ];

      expect(gameServices.boardIsEmpty(board), isFalse);
    });
  });

  group('checkRow', () {
    test('should return true when row is completely filled with same player (X)', () {
      final board = [
        [Player.x(), Player.x(), Player.x()],
        [Player.o(), null, null],
        [null, null, null],
      ];

      expect(gameServices.checkRow(board, 0, Player.x()), isTrue);
    });

    test('should return true when row is completely filled with same player (O)', () {
      final board = [
        [Player.x(), null, null],
        [Player.o(), Player.o(), Player.o()],
        [null, null, null],
      ];

      expect(gameServices.checkRow(board, 1, Player.o()), isTrue);
    });

    test('should return false when row has different players', () {
      final board = [
        [Player.x(), Player.o(), Player.x()],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.checkRow(board, 0, Player.x()), isFalse);
    });

    test('should return false when row has empty cells', () {
      final board = [
        [Player.x(), Player.x(), null],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.checkRow(board, 0, Player.x()), isFalse);
    });

    test('should return false when row is empty', () {
      final board = [
        [null, null, null],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.checkRow(board, 0, Player.x()), isFalse);
    });
  });

  group('checkColumn', () {
    test('should return true when column is completely filled with same player (X)', () {
      final board = [
        [Player.x(), Player.o(), null],
        [Player.x(), null, null],
        [Player.x(), null, null],
      ];

      expect(gameServices.checkColumn(board, 0, Player.x()), isTrue);
    });

    test('should return true when column is completely filled with same player (O)', () {
      final board = [
        [Player.x(), Player.o(), null],
        [Player.x(), Player.o(), null],
        [null, Player.o(), null],
      ];

      expect(gameServices.checkColumn(board, 1, Player.o()), isTrue);
    });

    test('should return false when column has different players', () {
      final board = [
        [Player.x(), null, null],
        [Player.o(), null, null],
        [Player.x(), null, null],
      ];

      expect(gameServices.checkColumn(board, 0, Player.x()), isFalse);
    });

    test('should return false when column has empty cells', () {
      final board = [
        [Player.x(), null, null],
        [Player.x(), null, null],
        [null, null, null],
      ];

      expect(gameServices.checkColumn(board, 0, Player.x()), isFalse);
    });

    test('should return false when column is empty', () {
      final board = [
        [null, null, null],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.checkColumn(board, 0, Player.x()), isFalse);
    });
  });

  group('checkDiagonal', () {
    test('should return true when main diagonal is filled with same player (X)', () {
      final board = [
        [Player.x(), Player.o(), null],
        [Player.o(), Player.x(), null],
        [null, null, Player.x()],
      ];

      expect(gameServices.checkDiagonal(board, Player.x()), isTrue);
    });

    test('should return true when secondary diagonal is filled with same player (X)', () {
      final board = [
        [Player.o(), null, Player.x()],
        [null, Player.x(), null],
        [Player.x(), null, null],
      ];

      expect(gameServices.checkDiagonal(board, Player.x()), isTrue);
    });

    test('should return true when secondary diagonal is filled with same player (O)', () {
      final board = [
        [Player.x(), null, Player.o()],
        [null, Player.o(), null],
        [Player.o(), null, null],
      ];

      expect(gameServices.checkDiagonal(board, Player.o()), isTrue);
    });

    test('should return false when main diagonal has different players', () {
      final board = [
        [Player.x(), null, null],
        [null, Player.o(), null],
        [null, null, Player.x()],
      ];

      expect(gameServices.checkDiagonal(board, Player.x()), isFalse);
    });

    test('should return false when main diagonal has empty cells', () {
      final board = [
        [Player.x(), null, null],
        [null, Player.x(), null],
        [null, null, null],
      ];

      expect(gameServices.checkDiagonal(board, Player.x()), isFalse);
    });

    test('should return false when secondary diagonal has different players', () {
      final board = [
        [null, null, Player.x()],
        [null, Player.o(), null],
        [Player.x(), null, null],
      ];

      expect(gameServices.checkDiagonal(board, Player.x()), isFalse);
    });

    test('should return false when no diagonal is complete', () {
      final board = [
        [Player.x(), Player.o(), Player.x()],
        [Player.o(), Player.o(), Player.x()],
        [Player.x(), Player.o(), Player.o()],
      ];

      expect(gameServices.checkDiagonal(board, Player.x()), isFalse);
    });
  });

  group('boardIsWin', () {
    test('should return true when X wins with a row', () {
      final board = [
        [Player.x(), Player.x(), Player.x()],
        [Player.o(), null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.x()), isTrue);
    });

    test('should return true when X wins with a column', () {
      final board = [
        [Player.x(), Player.o(), null],
        [Player.x(), null, null],
        [Player.x(), null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.x()), isTrue);
    });

    test('should return true when X wins with main diagonal', () {
      final board = [
        [Player.x(), Player.o(), null],
        [Player.o(), Player.x(), null],
        [null, null, Player.x()],
      ];

      expect(gameServices.boardIsWin(board, Player.x()), isTrue);
    });

    test('should return true when X wins with secondary diagonal', () {
      final board = [
        [Player.o(), null, Player.x()],
        [null, Player.x(), null],
        [Player.x(), null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.x()), isTrue);
    });

    test('should return true when O wins with a row', () {
      final board = [
        [Player.o(), Player.o(), Player.o()],
        [Player.x(), null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.o()), isTrue);
    });

    test('should return true when O wins with a column', () {
      final board = [
        [Player.o(), Player.x(), null],
        [Player.o(), null, null],
        [Player.o(), null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.o()), isTrue);
    });

    test('should return false when checking for X but O wins', () {
      final board = [
        [Player.o(), Player.o(), Player.o()],
        [Player.x(), null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.x()), isFalse);
    });

    test('should return false when checking for O but X wins', () {
      final board = [
        [Player.x(), Player.x(), Player.x()],
        [Player.o(), null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.o()), isFalse);
    });

    test('should return false when no one wins', () {
      final board = [
        [Player.x(), Player.o(), Player.x()],
        [Player.o(), Player.x(), null],
        [null, null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.x()), isFalse);
      expect(gameServices.boardIsWin(board, Player.o()), isFalse);
    });

    test('should return false when board is empty', () {
      final board = [
        [null, null, null],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsWin(board, Player.x()), isFalse);
      expect(gameServices.boardIsWin(board, Player.o()), isFalse);
    });
  });

  group('boardIsDraw', () {
    test('should return true when board is full and no one wins', () {
      final board = [
        [Player.x(), Player.o(), Player.x()],
        [Player.o(), Player.x(), Player.o()],
        [Player.o(), Player.x(), Player.o()],
      ];

      expect(gameServices.boardIsDraw(board, Player.o()), isTrue);
    });

    test('should return false when board is full but X wins', () {
      final board = [
        [Player.x(), Player.x(), Player.x()],
        [Player.o(), Player.o(), Player.x()],
        [Player.o(), Player.x(), Player.o()],
      ];

      expect(gameServices.boardIsDraw(board, Player.x()), isFalse);
    });

    test('should return false when board is full but O wins', () {
      final board = [
        [Player.o(), Player.o(), Player.o()],
        [Player.x(), Player.x(), Player.o()],
        [Player.x(), Player.o(), Player.x()],
      ];

      expect(gameServices.boardIsDraw(board, Player.o()), isFalse);
    });

    test('should return false when board is not full', () {
      final board = [
        [Player.x(), Player.o(), Player.x()],
        [Player.o(), Player.x(), null],
        [null, null, null],
      ];

      expect(gameServices.boardIsDraw(board, Player.x()), isFalse);
      expect(gameServices.boardIsDraw(board, Player.o()), isFalse);
    });

    test('should return false when board is empty', () {
      final board = [
        [null, null, null],
        [null, null, null],
        [null, null, null],
      ];

      expect(gameServices.boardIsDraw(board, Player.x()), isFalse);
      expect(gameServices.boardIsDraw(board, Player.o()), isFalse);
    });
  });
}

