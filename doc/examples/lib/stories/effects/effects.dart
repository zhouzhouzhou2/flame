import 'package:dashbook/dashbook.dart';

import './combined.dart';
import './move.dart';
import './scale.dart';
import './infinite.dart';
import './sequence.dart';

void addEffectsStories(Dashbook dashbook) {
  final story = dashbook.storiesOf('Effects');

  addMoveChapter(story);
  addScaleChapter(story);
  addCombinedChapter(story);
  addInfniteChapter(story);
  addSequenceChapter(story);
}

