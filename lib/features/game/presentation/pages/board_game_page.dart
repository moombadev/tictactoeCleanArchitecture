import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/core/ui/design_system/components/buttons/app_button.dart';
import 'package:tic_tac_toe/core/routing/routes.dart';
import 'package:tic_tac_toe/features/game/domain/entities/player.dart';
import 'package:tic_tac_toe/features/game/presentation/providers/game_provider.dart';
import 'package:tic_tac_toe/features/game/presentation/providers/game_audio_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/game_grid.dart';
import '../widgets/game_header.dart';

class BoardGamePage extends ConsumerStatefulWidget {
  final String startingPlayer;

  const BoardGamePage({
    super.key,
    required this.startingPlayer,
  });

  @override
  ConsumerState<BoardGamePage> createState() => _BoardGamePageState();
}

class _BoardGamePageState extends ConsumerState<BoardGamePage> {
  bool _isInitialized = false;
  late final Player _startingPlayer;

  @override
  void initState() {
    super.initState();
    _startingPlayer = Player.fromString(widget.startingPlayer);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        ref.read(gameControllerProvider.notifier).initializeGame(
          _startingPlayer,
        );
        _isInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(gameAudioControllerProvider);
    
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  const GameHeader(),
                  SizedBox(height: screenHeight * 0.1),
                  const GameGrid(),
                  const Spacer(),



                     AppButton(
                      label: AppLocalizations.of(context)!.restart,
                      onPressed: () {
                        ref.read(gameControllerProvider.notifier).resetGame(
                          startingPlayer: _startingPlayer,
                        );
                      },
                    ),

                ],
              ),
            ),
            Positioned(
              top: 0,
              left: screenWidth * 0.05,
              child: TextButton(
                onPressed: () {
                  AppRoutes.goToChooseSide(context);
                },
                child: Icon(Icons.person_search_outlined, size: screenWidth * 0.08),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

