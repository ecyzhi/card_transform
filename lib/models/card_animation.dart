import 'dart:math' as math;
import 'package:flutter/material.dart';

class CardAnimation {
  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<Offset> translation;

  CardAnimation(
    this.controller,
    this.rotation,
    this.translation,
  );

  CardAnimation.fromDefault(
    this.controller, {
    double deg = 0,
    double x = 0,
    double y = 0,
  })  : rotation = Tween<double>(begin: 0, end: deg / 180 * math.pi)
            .animate(controller),
        translation =
            Tween<Offset>(begin: const Offset(0, 0), end: Offset(x, y))
                .animate(controller);

  static void forward(CardAnimation e) => e.controller.forward();

  static void reverse(CardAnimation e) => e.controller.reverse();
}
