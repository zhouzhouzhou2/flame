import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/animation.dart' as flame_animation;
import 'package:flame/components/animation_component.dart';
import 'package:dashbook/dashbook.dart';

import '../../widgets/dashbook_game_container.dart';

void addAsepriteChapter(Story story)  {
  story.add('aseprite', (ctx) {
    return DashbookGameContainer(storyLoader: (size) => MyGame(size).widget);
  });
}

class MyGame extends BaseGame {
  MyGame(Size screenSize) {
    size = screenSize;
    _start();
  }

  void _start() async {
    final animation = await flame_animation.Animation.fromAsepriteData(
        'chopper.png', 'chopper_aseprite_data.json');
    final animationComponent = AnimationComponent(200, 200, animation);

    animationComponent.x = (size.width / 2) - 100;
    animationComponent.y = (size.height / 2) - 100;

    add(animationComponent);
  }
}

