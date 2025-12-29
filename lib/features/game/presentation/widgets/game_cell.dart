import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../../domain/entities/position.dart';
import '../../domain/entities/player.dart';
import '../../../../core/ui/design_system/theme/app_colors.dart';
import '../../../../core/ui/design_system/components/exports.dart';

class GameCell extends ConsumerStatefulWidget {
  final int row;
  final int col;

  const GameCell({
    super.key,
    required this.row,
    required this.col,
  });

  @override
  ConsumerState<GameCell> createState() => _GameCellState();
}

class _GameCellState extends ConsumerState<GameCell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    final player = ref.watch(gameControllerProvider.select(
      (async) => async.value?.board[widget.row][widget.col],
    ));
    

    if (player != null && !_controller.isCompleted && !_controller.isAnimating) {
      _controller.forward();
    } else if (player == null && _controller.isCompleted) {
      _controller.reset();
    }

    return GestureDetector(
      onTap: player == null 
          ? () => ref.read(gameControllerProvider.notifier).makeMove(
                Position(row: widget.row, col: widget.col),
              )
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:  const Color.fromARGB(110, 0, 0, 0),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: player != null 
              ? switch (player) {
                  PlayerX() => GameIconX(
                    size: MediaQuery.of(context).size.width * 0.12,
                    color: AppColors.secondary,
                  ),
                  PlayerO() => GameIconO(
                    size: MediaQuery.of(context).size.width * 0.12,
                    color: const Color.fromARGB(184, 59, 50, 33),
                  ),
                }
              : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

