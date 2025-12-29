import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_mode.freezed.dart';
part 'game_mode.g.dart';

@freezed
sealed class GameMode with _$GameMode {
  const factory GameMode.vsPlayer() = VsPlayer;
  const factory GameMode.vsAI() = VsAI; // TODO: Implement AI mode
  const factory GameMode.firstPersonShooter() = FirstPersonShooter; // TODO: Implement first person shooter mode

  factory GameMode.fromJson(Map<String, dynamic> json) =>
      _$GameModeFromJson(json);
}

