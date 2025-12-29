import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ui/design_system/components/exports.dart';
import '../../../../core/routing/routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../game/presentation/providers/game_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  bool _hasPlayedLaunchSound = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasPlayedLaunchSound) {
        ref.read(audioServiceProvider).playLaunchSound();
        _hasPlayedLaunchSound = true;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const GameIconX(size: 120),
                    const SizedBox(width: 20),
                    const GameIconO(size: 120),
                  ],
                ),
              ),
              const Spacer(),
              FadeTransition(
                opacity: _fadeAnimation,
                child: AppButton(
                  label: AppLocalizations.of(context)!.start,
                  onPressed: () {
                    ref.read(audioServiceProvider).playStartSound();
                    AppRoutes.goToChooseSide(context);
                  },
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

