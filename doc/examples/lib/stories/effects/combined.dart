import 'package:flame/effects/combined_effect.dart';
import 'package:flame/effects/move_effect.dart';
import 'package:flame/effects/scale_effect.dart';
import 'package:flame/effects/rotate_effect.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:dashbook/dashbook.dart';

import 'dart:math';

import './square.dart';

import '../../widgets/dashbook_game_container.dart';

void addCombinedChapter(Story story) {
  story.add('combined', (ctx) {
    return DashbookGameContainer(storyLoader: (size) => MyGame().widget);
  });
}

class MyGame extends BaseGame with TapDetector {
  Square greenSquare;

  MyGame() {
    final green = Paint()..color = const Color(0xAA338833);
    final red = Paint()..color = const Color(0xAA883333);
    greenSquare = Square(green, 100, 100);
    final redSquare = Square(red, 100, 100);
    add(greenSquare);
    add(redSquare);
  }

  @override
  void onTapUp(TapUpDetails details) {
    final dx = details.localPosition.dx;
    final dy = details.localPosition.dy;
    greenSquare.clearEffects();

    final move = MoveEffect(
      destination: Position(dx, dy),
      speed: 250.0,
      curve: Curves.linear,
      isInfinite: false,
      isAlternating: false,
    );

    final scale = ScaleEffect(
      size: Size(dx, dy),
      speed: 250.0,
      curve: Curves.linear,
      isInfinite: false,
      isAlternating: false,
    );

    final rotate = RotateEffect(
      radians: (dx + dy) % pi,
      speed: 1.5,
      curve: Curves.decelerate,
      isInfinite: false,
      isAlternating: false,
    );

    final combination = CombinedEffect(
      effects: [move, rotate, scale],
      isInfinite: false,
      isAlternating: true,
      offset: 0.5,
      onComplete: () => print("onComplete callback"),
    );
    greenSquare.addEffect(combination);
  }
}

