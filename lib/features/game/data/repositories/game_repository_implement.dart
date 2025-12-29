import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/game.dart';
import '../../domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final SharedPreferences _prefs;
  static const _gameKey = 'current_game';

  GameRepositoryImpl(this._prefs);

  @override
  Future<Game?> getGame() async {
    final gameJson = _prefs.getString(_gameKey);
    if (gameJson == null) return null;
    
    try {
      final Map<String, dynamic> gameMap = jsonDecode(gameJson);
      return Game.fromJson(gameMap);
    } catch (e) {
      await clearGame();
      return null;
    }
  }

  @override
  Future<void> saveGame(Game game) async {
    final gameJson = jsonEncode(game.toJson());
    await _prefs.setString(_gameKey, gameJson);
  }

  @override
  Future<void> clearGame() async {
    await _prefs.remove(_gameKey);
  }
}
