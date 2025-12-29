import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
sealed class Player with _$Player {
  const factory Player.x() = PlayerX;
  const factory Player.o() = PlayerO;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  factory Player.fromString(String player) => switch (player.toLowerCase()) {
        'x' => const Player.x(),
        'o' => const Player.o(),
        _ => const Player.x(),
      };
}

