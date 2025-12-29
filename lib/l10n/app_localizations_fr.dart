// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get start => 'Commencer';

  @override
  String get whoStarts => 'Qui commence ?';

  @override
  String get turnOf => 'AU TOUR DE';

  @override
  String get playerX => 'JOUEUR X';

  @override
  String get playerO => 'JOUEUR O';

  @override
  String get victory => 'VICTOIRE !';

  @override
  String get xWins => 'Des X';

  @override
  String get oWins => 'Des O';

  @override
  String get draw => 'MATCH NUL !';

  @override
  String error(String error) {
    return 'Erreur: $error';
  }

  @override
  String get cellAlreadyOccupied => 'Case déjà occupée';

  @override
  String get gameNotInProgress => 'La partie n\'est pas en cours';

  @override
  String get restart => 'Recommencer';
}
