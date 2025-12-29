import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ui/design_system/theme/app_colors.dart';
import '../../../../core/ui/design_system/theme/app_text_styles.dart';
import '../../../../core/ui/design_system/components/exports.dart';
import '../../../../core/routing/routes.dart';
import '../../../../l10n/app_localizations.dart';

class ChooseSidePage extends ConsumerStatefulWidget {
  const ChooseSidePage({super.key});

  @override
  ConsumerState<ChooseSidePage> createState() => _ChooseSidePageState();
}

class _ChooseSidePageState extends ConsumerState<ChooseSidePage> {
  String? selectedSide; // null, 'x' ou 'o'

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Text(
                AppLocalizations.of(context)!.whoStarts,
                style: AppTextStyles.sideTitle,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              
              _SideChoiceButton(
                side: 'x',
                selectedSide: selectedSide,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                onTap: () {
                  if (selectedSide == 'x') {
                    AppRoutes.pushGame(context, 'x');
                  } else {
                    setState(() => selectedSide = 'x');
                  }
                },
              ),
              
              SizedBox(height: screenHeight * 0.1),
              
              _SideChoiceButton(
                side: 'o',
                selectedSide: selectedSide,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                onTap: () {
                  if (selectedSide == 'o') {
                    AppRoutes.pushGame(context, 'o');
                  } else {
                    setState(() => selectedSide = 'o');
                  }
                },
              ),
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SideChoiceButton extends StatelessWidget {
  final String side;
  final String? selectedSide;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;

  const _SideChoiceButton({
    required this.side,
    required this.selectedSide,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedSide == side;
    
    return _AnimatedChoice(
      isSelected: isSelected,
      onTap: onTap,
      child:  Center(
          child: side == 'x'
              ? GameIconX(
                  size: screenWidth * 0.5,
                  color:  AppColors.primary,
                )
              : GameIconO(
                  size: screenWidth * 0.5,
                  color:  AppColors.primary,
                ),
        ),
      
    );
  }
}

class _AnimatedChoice extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isSelected;

  const _AnimatedChoice({
    required this.child,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<_AnimatedChoice> createState() => _AnimatedChoiceState();
}

class _AnimatedChoiceState extends State<_AnimatedChoice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(_AnimatedChoice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward();
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}

