import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:little_work_space/shared/particle_system/constants.dart';
import 'package:little_work_space/shared/particle_system/particle.dart';
import 'package:little_work_space/shared/particle_system/particle_system.dart';
import 'package:little_work_space/shared/resources/ext.dart';
import 'package:little_work_space/shared/resources/random.dart';
import 'package:little_work_space/shared/utils/ellipse_utils.dart';

class Orbit extends BaseParticle {
  Orbit({
    required Size orbitSize,
    required double rotation,
    required Offset position,
    int pCount = 10,
    int pMinSize = 1,
    double pRandomRange = 1,
    List<Color> pColors = const [Colors.white],
    ParticleShape shape = ParticleShape.circle,
  })  : orbit = EllipseUtils.drawEllipsePath(
          orbitSize,
          position: position,
          rotation: rotation,
        ),
        particles = List.generate(
          pCount,
          (_) => Particle(
            globalRandom.nextDouble() * pRandomRange + pMinSize,
            color: pColors.pickRandom!,
            shape: shape,
          ),
        ),
        super(size: orbitSize, rotation: rotation, position: position);

  final Path orbit;
  final List<Particle> particles;

  @override
  void update([Map<String, dynamic> params = const {}]) {
    for (var particle in particles) {
      particle.update({'orbit': orbit});
    }
  }

  @override
  void draw(Canvas canvas) {
    // canvas.drawPath(orbit, strokePaint);
    for (var particle in particles) {
      particle.draw(canvas);
    }
  }
}
