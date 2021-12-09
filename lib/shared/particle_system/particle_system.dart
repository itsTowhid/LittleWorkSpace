import 'package:flutter/material.dart';
import 'package:little_work_space/shared/particle_system/constants.dart';

abstract class BaseParticle {
  BaseParticle({
    this.size = Size.zero,
    this.index = 0,
    this.life = 0,
    this.rotation = 0,
    this.color = Colors.white,
    this.position = Offset.zero,
    this.style = ParticleStyle.solid,
    this.shape = ParticleShape.circle,
  });

  int index;
  Size size;
  Color color;
  double life;
  double rotation;
  Offset position;
  ParticleStyle style;
  ParticleShape shape;
  bool isDead = false;
  late final Paint paint = Paint()..style = PaintingStyle.fill,
      strokePaint = Paint()..style = PaintingStyle.stroke;

  void update([Map<String, dynamic> params = const {}]);

  void draw(Canvas canvas);
}

class ParticlesPainter extends CustomPainter {
  ParticlesPainter({required this.onPaint});

  final void Function(Canvas canvas, Size size) onPaint;

  @override
  void paint(Canvas canvas, Size size) => onPaint.call(canvas, size);

  @override
  bool shouldRepaint(_) => true;
}
