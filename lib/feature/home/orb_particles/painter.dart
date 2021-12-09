import 'package:flutter/widgets.dart';

class OrbParticlesPainter extends CustomPainter {
  OrbParticlesPainter({required this.onPaint});

  final void Function(Canvas canvas, Size size) onPaint;

  @override
  void paint(Canvas canvas, Size size) => onPaint.call(canvas, size);

  @override
  bool shouldRepaint(_) => true;
}
