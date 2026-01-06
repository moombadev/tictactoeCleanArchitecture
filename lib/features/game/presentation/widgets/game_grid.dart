import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ui/design_system/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/game_provider.dart';
import 'game_cell.dart';

class GameGrid extends ConsumerWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(gameControllerProvider);

    return gameAsync.when(
      data: (game) {
        if (game == null) return const SizedBox.shrink();
        
        final boardSize = game.board.length;

        return AspectRatio(
          aspectRatio: 1,
          child: GridView.builder(
            padding: const EdgeInsets.all(4),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: boardSize,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: boardSize * boardSize,
            itemBuilder: (context, index) {
              final row = index ~/ boardSize;
              final col = index % boardSize;
              
              return GameCell(
                key: ValueKey('cell_${row}_$col'),
                row: row,
                col: col,
              );
            },
          ),
        );
      },
      loading: () => const AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.secondary),
        ),
      ),
      error: (err, stack) => AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: Text(AppLocalizations.of(context)!.error('Unknown error')),
        ),
      ),
    );
  }
}

