import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:little_work_space/feature/home/orb_particles/particle.dart';
import 'package:little_work_space/feature/home/utils/ellipse_utils.dart';

class Orbit {
  Orbit({
    required this.size,
    required this.position,
    required this.rotation,
    int particlesCount = 10,
    List<Color> particleColors = const [Colors.white],
  }) {
    orbit = EllipseUtils.drawEllipsePath(
      size,
      position: position,
      rotation: rotation,
    );

    particles = List.generate(
      particlesCount,
      (_) => Particle(
        _rand.nextDouble() * 4 + 1,
        particleColors[_rand.nextInt(particleColors.length)],
      ),
    );
  }

  final Size size;
  final Offset position;
  final double rotation;
  late final Path orbit;
  late final List<Particle> particles;

  final _rand = Random();

  void update() {
    for (var particle in particles) {
      particle.update(orbit);
    }
  }

  void drawParticles(Canvas canvas, bool isFront) {
/*    canvas.drawPath(
      orbit,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = .05,
    );*/
    for (var particle in particles) {
      particle.draw(canvas,isFront);
    }
  }
}
