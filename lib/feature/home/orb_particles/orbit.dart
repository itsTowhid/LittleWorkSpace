import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:little_work_space/feature/home/orb_particles/constants.dart';
import 'package:little_work_space/feature/home/orb_particles/particle.dart';
import 'package:little_work_space/feature/home/utils/ellipse_utils.dart';
import 'package:little_work_space/shared/resources/random.dart';

class Orbit {
  Orbit({
    required this.size,
    required this.position,
    required this.rotation,
    int particlesCount = 10,
    int particlesBaseSize = 1,
    double particlesScale = 1,
    List<Color> particleColors = const [Colors.white],
    ParticleStyle particleStyle = ParticleStyle.solid,
    bool isBackgroundParticle = false,
  }) {
    orbit = EllipseUtils.drawEllipsePath(
      size,
      position: position,
      rotation: rotation,
    );

    particles = List.generate(
      particlesCount,
      (_) => Particle(
          isBackgroundParticle
              ? (globalRandom.nextDouble() * 200 + 100)
              : (globalRandom.nextDouble() * 4 + 1),
          color: particleColors[globalRandom.nextInt(particleColors.length)],
          shape: isBackgroundParticle
              ? ParticleShape.circle
              : ParticleShape.square),
    );
  }

  final Size size;
  final Offset position;
  final double rotation;
  late final Path orbit;
  late final List<Particle> particles;
  late final _paint = Paint()
    ..color = Colors.white.withOpacity(.7)
    ..style = PaintingStyle.stroke
    ..strokeWidth = .05;

  void update() {
    for (var particle in particles) {
      particle.update(orbit);
    }
  }

  void drawParticles(Canvas canvas, bool isFront) {
    // canvas.drawPath(orbit, _paint);
    for (var particle in particles) {
      particle.draw(canvas, isFront);
    }
  }
}
