import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:little_work_space/feature/home/orb_particles/orbit.dart';
import 'package:little_work_space/feature/home/orb_particles/particles_painter.dart';

class OrbParticlesWidget extends StatefulWidget {
  const OrbParticlesWidget({this.child, Key? key}) : super(key: key);
  final Widget? child;

  @override
  State<OrbParticlesWidget> createState() => _OrbParticlesWidgetState();
}

class _OrbParticlesWidgetState extends State<OrbParticlesWidget>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(minutes: 10),
    vsync: this,
  )..addListener(() {
      setState(() {
        for (final orbit in orbits) {
          orbit.update();
        }
      });
    });

  final orbits = <Orbit>[];
  final rand = Random();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      final size = _getWidgetSize();
      if (size != null) setup(size);
    });
  }

  void setup(Size size) {
    _generateParticles(size);
    _controller.forward();
  }

  Size? _getWidgetSize() {
    final obj = context.findRenderObject();
    return obj != null ? (obj as RenderBox).size : null;
  }

  void _generateParticles(Size size) {
    final center = size.center(Offset.zero);
    for (var i = 0; i < 5; i++) {
      orbits.add(Orbit(
        size: Size(
          size.width + rand.nextDouble() * 50 - 25,
          size.height + rand.nextDouble() * 50 - 25,
        ),
        position: center.translate(
          rand.nextDouble() * 50,
          rand.nextDouble() * 50,
        ),
        rotation: -pi / (4 + rand.nextDouble() * 2),
        particleColors: [
          Colors.lightBlueAccent,
          Colors.lightGreenAccent,
          Colors.pinkAccent,
          Colors.white,
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // final size = MediaQuery.of(context).size;
        // if (orbits.isEmpty) setup(size);
        // print('${constraints.maxWidth} X ${constraints.maxHeight} - ${size}');
        return CustomPaint(
          painter: OrbParticlesPainter(
              onPaint: (canvas, _) => drawOrbitParticles(canvas, false)),
          foregroundPainter: OrbParticlesPainter(
              onPaint: (canvas, _) => drawOrbitParticles(canvas, true)),
          child: widget.child,
        );
      },
    );
  }

  void drawOrbitParticles(Canvas canvas, bool isFront) {
    for (final orbit in orbits) {
      orbit.drawParticles(canvas, isFront);
    }
  }
}
