import 'package:flutter/material.dart';
import 'package:little_work_space/shared/resources/random.dart';

extension OffsetExt on Offset {
  Offset translateRandom(double max) => translate(
        globalRandom.nextDouble() * max,
        globalRandom.nextDouble() * max,
      );
}

extension ListExt<T> on List<T> {
  T? get pickRandom => isNotEmpty ? this[globalRandom.nextInt(length)] : null;
}
