import 'package:flutter/material.dart';
import 'package:little_work_space/shared/resources/random.dart';

extension OffsetExt on Offset {
  Offset translateRandom(double max) => translate(
        globalRandom.nextDouble() * max,
        globalRandom.nextDouble() * max,
      );
}

extension DoubleExt on double {
  double get toDegree => 0.0174533 * this;
}

extension IntExt on int {
  double get degreeToRadian => 0.0174533 * this;
}

extension SizeExt on Size {
  Size enlargeRandom(double max) => Size(
        width + globalRandom.nextDouble() * max,
        height + globalRandom.nextDouble() * max,
      );
}

extension ListExt<T> on List<T> {
  T? get pickRandom => isNotEmpty ? this[globalRandom.nextInt(length)] : null;
}
