import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:little_work_space/feature/home/orb_particles/constants.dart';
import 'package:little_work_space/feature/home/utils/ellipse_utils.dart';
import 'package:little_work_space/shared/resources/random.dart';

class Particle {
  Particle(
    this._radius, {
    this.color = Colors.white,
    this.style = ParticleStyle.solid,
    this.shape = ParticleShape.square,
  }) {
    _life = globalRandom.nextDouble();
    final transparency = _radius > 100
        ? globalRandom.nextDouble() % .03
        : globalRandom.nextDouble();
    _paint
      ..color = color.withOpacity(transparency)
      ..blendMode = BlendMode.srcOver;
    _strokePaint
      ..color = color.withOpacity(_life)
      ..style = PaintingStyle.stroke
      ..strokeWidth = .05;
  }

  final Paint _paint = Paint(), _strokePaint = Paint();
  final Color color;
  final double _radius;
  late Offset _position;
  final ParticleStyle style;
  final ParticleShape shape;
  double _life = 0;

  bool get isLargeParticle => _radius > 100;

  void update(Path orbit) {
    _life += isLargeParticle ? .0001 : .001;
    final sinY = sin(_life * 9) * 100;
    _position = EllipseUtils.pathPositionFromPercent(_life % 1, orbit)
        .translate(0, sinY);

/*    if (isLargeParticle) {
      _paint.shader = RadialGradient(
        colors: [_color.withOpacity(.03), Colors.transparent],
      ).createShader(
        Rect.fromCircle(center: _position, radius: _radius),
      );
    }*/
  }

  void draw(Canvas canvas, bool isFront) {
    final isFrontParticles = isFront && (_life % 1) > .5;
    final isBackParticles = !isFront && (_life % 1) < .5;

    if (isFrontParticles || isBackParticles || isLargeParticle) {
      shape.draw(canvas, _paint, Size.square(_radius), _position);
      if (isLargeParticle) {
        // shape.draw(canvas, _strokePaint, Size.square(_radius), _position);
      }
    }
  }
}
