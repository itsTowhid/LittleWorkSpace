import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:little_work_space/shared/particle_system/constants.dart';
import 'package:little_work_space/shared/particle_system/particle_system.dart';
import 'package:little_work_space/shared/resources/random.dart';
import 'package:little_work_space/shared/utils/ellipse_utils.dart';

class Particle extends BaseParticle {
  Particle(
    double size, {
    Color color = Colors.white,
    ParticleStyle style = ParticleStyle.solid,
    ParticleShape shape = ParticleShape.square,
  }) : super(
          size: Size.square(size),
          color: color,
          style: style,
          shape: shape,
        ) {
    life = globalRandom.nextDouble();
    isLargeParticle = size > 100;
    final transparency =
        globalRandom.nextDouble() % (isLargeParticle ? .03 : 1);
    paint
      ..color = color.withOpacity(transparency)
      ..blendMode = BlendMode.srcOver;
    strokePaint
      ..color = color.withOpacity(.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = .05;
  }

  bool isFront = true;
  bool isLargeParticle = false;

  @override
  void update([Map params = const {}]) {
    isFront = params['isFront'] as bool;
    final orbit = params['orbit'] as Path;
    life += isLargeParticle ? .00005 : .001;
    final sinY = sin(life * 9) * 100;
    position = EllipseUtils.pathPositionFromPercent(life % 1, orbit)
        .translate(0, sinY);

/*    if (isLargeParticle) {
      paint.shader = RadialGradient(
        colors: [color.withOpacity(.03), Colors.transparent],
      ).createShader(
        Rect.fromCircle(center: position, radius: radius),
      );
    }*/
  }

  @override
  void draw(Canvas canvas) {
    final isFrontParticles = isFront && (life % 1) > .5;
    final isBackParticles = !isFront && (life % 1) < .5;

    if (isFrontParticles || isBackParticles || isLargeParticle) {
      shape.draw(canvas, paint, size, position);
      if (isLargeParticle) {
        // shape.draw(canvas, strokePaint, Size.square(radius), position);
      }
    }
  }
}
