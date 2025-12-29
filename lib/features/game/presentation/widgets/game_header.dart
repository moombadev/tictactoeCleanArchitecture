import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ui/design_system/theme/app_colors.dart';
import '../../../../core/ui/design_system/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/game_provider.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/game_state.dart';

class GameHeader extends ConsumerWidget {
  const GameHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(gameControllerProvider);
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gameAsync.when(
            data: (game) {
              if (game == null) return const SizedBox.shrink();
              
              return switch (game.state) {
                InProgress() || NotStarted() => Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.turnOf,
                      style: AppTextStyles.sideTitle.copyWith(
                        fontSize: 16, 
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      switch (game.currentPlayer) {
                        PlayerX() => AppLocalizations.of(context)!.playerX,
                        PlayerO() => AppLocalizations.of(context)!.playerO,
                      },
                      style: AppTextStyles.sideTitle.copyWith(
                        color:  Colors.white,
                        shadows: [
                          const Shadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Won(:final winner) => RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${AppLocalizations.of(context)!.victory}\n',
                        style: AppTextStyles.title.copyWith(
                          color: Colors.white,
                          height: 1.1,
                          shadows: [
                            const Shadow(
                              color: Colors.black26,
                              offset: Offset(4, 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                      ),
                      TextSpan(
                        text: switch (winner) {
                          PlayerX() => AppLocalizations.of(context)!.xWins,
                          PlayerO() => AppLocalizations.of(context)!.oWins,
                        },
                        style: AppTextStyles.sideTitle,
                        ),
                    ],
                  ),
                ),
                Draw() => Text(
                  AppLocalizations.of(context)!.draw,
                  style: AppTextStyles.title.copyWith(color: Colors.black54),
                ),
              };
            },
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

