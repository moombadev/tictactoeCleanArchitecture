import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../features/game/domain/exceptions/invalid_move_exception.dart';

extension ErrorTranslator on Object {
  String translateError(BuildContext context) {
    if (this is InvalidMoveException) {
      final exception = this as InvalidMoveException;
      final localizations = AppLocalizations.of(context)!;
      
      return switch (exception.errorType) {
        InvalidMoveErrorType.cellAlreadyOccupied => localizations.cellAlreadyOccupied,
        InvalidMoveErrorType.gameNotInProgress => localizations.gameNotInProgress,
      };
    }
    
    return toString();
  }
}

