import 'package:meta/meta.dart';

import '../components/position_component.dart';
import 'effects.dart';

class SequenceEffect extends PositionComponentEffect {
  final List<PositionComponentEffect> effects;
  int _currentIndex = 0;
  PositionComponentEffect currentEffect;
  bool _currentWasAlternating;
  double _driftModifier = 0.0;

  SequenceEffect({
    @required this.effects,
    isInfinite = false,
    isAlternating = false,
    Function onComplete,
  }) : super(isInfinite, isAlternating, onComplete: onComplete) {
    assert(
      effects.every((effect) => effect.component == null),
      "No effects can be added to components from the start",
    );
  }

  @override
  void initialize(PositionComponent _comp) {
    super.initialize(_comp);
    _currentIndex = 0;
    final originalSize = _comp.size;
    final originalPosition = _comp.position;
    final originalAngle = _comp.angle;
    effects.forEach((effect) {
      effect.reset();
      _comp.size = endSize;
      _comp.position = endPosition;
      _comp.angle = endAngle;
      effect.initialize(_comp);
      endSize = effect.endSize;
      endPosition = effect.endPosition;
      endAngle = effect.endAngle;
    });
    travelTime = effects.fold(
      0,
      (time, effect) => time + effect.totalTravelTime,
    );
    component.size = originalSize;
    component.position = originalPosition;
    component.angle = originalAngle;
    currentEffect = effects.first;
    _currentWasAlternating = currentEffect.isAlternating;
  }

  @override
  void update(double dt) {
    if (hasFinished()) {
      return;
    }
    super.update(dt);

    currentEffect.update(dt + _driftModifier);
    _driftModifier = 0.0;
    if (currentEffect.hasFinished()) {
      _driftModifier = currentEffect.driftTime;
      currentEffect.isAlternating = _currentWasAlternating;
      _currentIndex++;
      final iterationSize = isAlternating ? effects.length * 2 : effects.length;
      if (_currentIndex != 0 && _currentIndex % iterationSize == 0) {
        isInfinite ? reset() : dispose();
        return;
      }
      final orderedEffects =
          curveDirection.isNegative ? effects.reversed.toList() : effects;
      currentEffect = orderedEffects[_currentIndex % effects.length];
      _currentWasAlternating = currentEffect.isAlternating;
      if (isAlternating &&
          !currentEffect.isAlternating &&
          curveDirection.isNegative) {
        // Make the effect go in reverse
        currentEffect.isAlternating = true;
      }
    }
  }

  @override
  void reset() {
    super.reset();
    initialize(component);
  }
}
