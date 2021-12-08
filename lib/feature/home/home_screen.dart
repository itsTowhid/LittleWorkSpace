import 'package:flutter/material.dart';
import 'package:little_work_space/feature/home/utils/ellipse.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: CustomPaint(
          painter: OrbParticlesPainter(
              isFront: false, orbSize: const Size(250, 500)),
          foregroundPainter:
              OrbParticlesPainter(isFront: true, orbSize: const Size(250, 500)),
          child: Text(
            'little\nwork.space',
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: .85,
                ),
          ),
        ),
      ),
    );
  }
}

class OrbParticlesPainter extends CustomPainter {
  OrbParticlesPainter({required this.isFront, required this.orbSize});

  final bool isFront;
  final Size orbSize;

  // final double rotation;
  final ellipsePaint = Paint()
    ..strokeWidth = 10
    ..color = Colors.blue
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    canvas.drawPath(
      isFront
          ? EllipseUtils.drawEllipseFrontHalf(orbSize, center: center)
          : EllipseUtils.drawEllipseBackHalf(orbSize, center: center),
      ellipsePaint,
    );
    // canvas.drawCircle(center, 5, Paint()..color = Colors.yellow);
    // canvas.drawCircle(Offset.zero, 5, Paint()..color = Colors.yellow);
  }

  @override
  bool shouldRepaint(_) => true;
}
