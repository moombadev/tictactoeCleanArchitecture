import '../../features/game/domain/entities/player.dart';

abstract class AudioService {
  Future<void> playErrorSound();
  Future<void> playMoveSound(Player player);
  Future<void> playVictorySound();
  Future<void> playStartSound();
  Future<void> playLaunchSound();
  Future<void> playDrawSound();
  
  void dispose();
}

