enum InvalidMoveErrorType {
  cellAlreadyOccupied,
  gameNotInProgress,
}

class InvalidMoveException implements Exception {
  final InvalidMoveErrorType errorType;

  const InvalidMoveException(this.errorType);

  @override
  String toString() => 'InvalidMoveException: $errorType';
}

