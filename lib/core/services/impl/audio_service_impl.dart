import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../../features/game/domain/entities/player.dart';
import '../audio_service.dart';

class AudioServiceImpl implements AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound(String soundPath) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
      debugPrint('Erreur lors de la lecture du son $soundPath: $e');
    }
  }

  @override
  Future<void> playErrorSound() async {
    await _playSound('sounds/error.wav');
  }

  @override
  Future<void> playMoveSound(Player player) async {
    debugPrint('Playing move sound for player: $player');
    final soundPath = switch (player) {
      PlayerX() => 'sounds/x_play.wav',
      PlayerO() => 'sounds/o_play.wav',
    };
    await _playSound(soundPath);
  }

  @override
  Future<void> playVictorySound() async {
    await _playSound('sounds/victory.wav');
  }

  @override
  Future<void> playStartSound() async {
    await _playSound('sounds/start.wav');
  }

  @override
  Future<void> playLaunchSound() async {
    await _playSound('sounds/launch.wav');
  }

  @override
  Future<void> playDrawSound() async {
    await _playSound('sounds/error.wav');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
  }
}

