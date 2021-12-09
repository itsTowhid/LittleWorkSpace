import 'package:flutter/material.dart';
import 'package:little_work_space/shared/resources/random.dart';

extension OffsetExt on Offset {
  Offset randomTranslate(double max) => translate(
        globalRandom.nextDouble() * max,
        globalRandom.nextDouble() * max,
      );
}
