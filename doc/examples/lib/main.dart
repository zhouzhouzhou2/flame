import 'package:flutter/material.dart';
import 'package:dashbook/dashbook.dart';

import './stories/animations/animations.dart';
import './stories/effects/effects.dart';

void main() {
  final dashbook = Dashbook();

  addAnimationStories(dashbook);
  addEffectsStories(dashbook);

  runApp(dashbook);
}
