import 'package:freezed_annotation/freezed_annotation.dart';
import 'player.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

@freezed
sealed class GameState with _$GameState {
  const factory GameState.notStarted() = NotStarted;
  const factory GameState.inProgress() = InProgress;
  const factory GameState.won({required Player winner}) = Won;
  const factory GameState.draw() = Draw;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}