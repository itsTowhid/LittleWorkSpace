import 'package:flutter/material.dart';

enum ParticleStyle { solid, faded, stroked, transparent }
enum ParticleShape { line, arc, circle, square, triangle, polygon, random }

extension ParticleShapeExt on ParticleShape {
  void draw(Canvas canvas, Paint paint, Size size, Offset position) {
    switch (this) {
      case ParticleShape.line:
        canvas.drawLine(
          position,
          position.translate(size.width, size.height),
          paint,
        );
        break;
      case ParticleShape.arc:
        // TODO: Handle this case.
        break;
      case ParticleShape.circle:
        canvas.drawCircle(position, size.shortestSide, paint);
        break;
      case ParticleShape.square:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCircle(center: position, radius: size.shortestSide),
            Radius.circular(size.shortestSide * .6),
          ),
          paint,
        );
        break;
      case ParticleShape.triangle:
        final path = Path()
          ..moveTo(position.dx, position.dy)
          ..relativeLineTo(size.width / 2, size.height)
          ..relativeLineTo(-size.width, 0)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case ParticleShape.polygon:
        // TODO: Handle this case.
        break;
      case ParticleShape.random:
        // TODO: Handle this case.
        break;
    }
  }
}
