import 'package:dashbook/dashbook.dart';

import './default.dart';
import './aseprite.dart';

void addAnimationStories(Dashbook dashbook) {
  final story = dashbook.storiesOf('Animations');
  addDefaultChapter(story);
  addAsepriteChapter(story);
}
