import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage slideInFromBottom({
  required LocalKey key,
  required Widget child,
  Duration transitionDuration = const Duration(milliseconds: 1500),
  Duration reverseTransitionDuration = const Duration(milliseconds: 1500),
  Curve curve = Curves.easeInOutCubic,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: transitionDuration,
    reverseTransitionDuration: reverseTransitionDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      final slideIn = Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: curve,
        ),
      );


      final slideOut = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.0, -1.0),
      ).animate(
        CurvedAnimation(
          parent: secondaryAnimation,
          curve: curve,
        ),
      );

      return SlideTransition(
        position: slideOut, 
        child: SlideTransition(
          position: slideIn, 
          child: child,
        ),
      );
    },
  );
}


CustomTransitionPage slideOutToTop({
  required LocalKey key,
  required Widget child,
  Duration transitionDuration = const Duration(milliseconds: 1500),
  Duration reverseTransitionDuration = const Duration(milliseconds: 1500),
  Curve curve = Curves.easeInOutCubic,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: transitionDuration,
    reverseTransitionDuration: reverseTransitionDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0.0, -1.0), 
        ).animate(
          CurvedAnimation(
            parent: secondaryAnimation, 
            curve: curve,
          ),
        ),
        child: child,
      );
    },
  );
}
