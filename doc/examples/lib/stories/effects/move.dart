import 'package:flutter/material.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/effects/effects.dart';
import 'package:flame/position.dart';
import 'package:dashbook/dashbook.dart';

import './square.dart';

import '../../widgets/dashbook_game_container.dart';

void addMoveChapter(Story story) {
  story.add('move', (ctx) {
    return DashbookGameContainer(storyLoader: (size) => MyGame().widget);
  });
}

class MyGame extends BaseGame with TapDetector {
  Square square;
  MyGame() {
    add(square = Square(
            BasicPalette.white.paint,
            100,
            100,
      ),
    );
  }

  @override
  void onTapUp(details) {
    square.addEffect(MoveEffect(
      destination: Position(
        details.localPosition.dx,
        details.localPosition.dy,
      ),
      speed: 250.0,
      curve: Curves.bounceInOut,
    ));
  }
}
