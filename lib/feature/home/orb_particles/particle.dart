import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:little_work_space/feature/home/utils/ellipse_utils.dart';

class Particle {
  Particle(this._radius, [Color color = Colors.white])
      : _life = Random().nextDouble(),
        _paint = Paint()..color = color.withOpacity(Random().nextDouble())
  // ..blendMode = BlendMode.plus
  ;

  final Paint _paint;
  final double _radius;
  late Offset _position;
  double _life;

  void update(Path orbit) {
    _life += .001;
    final sinY = sin(_life * 9) * 100;
    _position = EllipseUtils.pathPositionFromPercent(_life % 1, orbit)
        .translate(0, sinY);
  }

  void draw(Canvas canvas, bool isFront) {
    final shouldDraw =
        isFront && (_life % 1) > .5 || !isFront && (_life % 1) < .5;

    if (shouldDraw) {
      canvas.drawCircle(_position, _radius, _paint);
    }
  }
}
