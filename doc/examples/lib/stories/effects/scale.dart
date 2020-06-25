import 'package:flutter/material.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/effects/effects.dart';
import 'package:dashbook/dashbook.dart';

import './square.dart';

import '../../widgets/dashbook_game_container.dart';

void addScaleChapter(Story story) {
  story.add('scale', (ctx) {
    return DashbookGameContainer(storyLoader: (size) => MyGame().widget);
  });
}

class MyGame extends BaseGame with TapDetector {
  Square square;
  bool grow = true;

  MyGame() {
    add(square = Square(
            BasicPalette.white.paint,
            200,
            200,
    ));
  }

  @override
  void onTap() {
    final s = grow ? 300.0 : 100.0;

    grow = !grow;
    square.addEffect(ScaleEffect(
      size: Size(s, s),
      speed: 250.0,
      curve: Curves.bounceInOut,
    ));
  }
}

void main() {
  runApp(MyGame().widget);
}
