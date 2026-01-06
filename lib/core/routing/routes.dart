import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {

  static const String home = '/';
  static const String chooseSide = '/choose-side';
  static const String game = '/game';

  static void goToHome(BuildContext context) {
    context.go(home);
  }
  
  static void goToChooseSide(BuildContext context) {
    context.go(chooseSide);
  }
  
  static void pushChooseSide(BuildContext context) {
    context.push(chooseSide);
  }
  
  static void goToGame(BuildContext context, String player) {
    context.go('$game?player=$player');
  }
  
  static void pushGame(BuildContext context, String player) {
    context.push('$game?player=$player');
  }
}

