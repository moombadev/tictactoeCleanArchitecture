// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get start => 'Start';

  @override
  String get whoStarts => 'Who Starts?';

  @override
  String get turnOf => 'TURN OF';

  @override
  String get playerX => 'PLAYER X';

  @override
  String get playerO => 'PLAYER O';

  @override
  String get victory => 'VICTORY !';

  @override
  String get xWins => 'X Wins';

  @override
  String get oWins => 'O Wins';

  @override
  String get draw => 'DRAW !';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get cellAlreadyOccupied => 'Cell already occupied';

  @override
  String get gameNotInProgress => 'Game is not in progress';

  @override
  String get restart => 'Restart';
}
