import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:little_work_space/shared/particle_system/orbit.dart';
import 'package:little_work_space/shared/particle_system/particle_system.dart';
import 'package:little_work_space/shared/resources/ext.dart';
import 'package:little_work_space/shared/resources/random.dart';

class OrbParticlesWidget extends StatefulWidget {
  const OrbParticlesWidget({this.child, Key? key}) : super(key: key);
  final Widget? child;

  @override
  State<OrbParticlesWidget> createState() => _OrbParticlesWidgetState();
}

class _OrbParticlesWidgetState extends State<OrbParticlesWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
        orbitSize: size.enlargeRandom(25),
        position: center.translateRandom(50),
        rotation: -45.toDegree,
        pColors: [
          Colors.lightBlueAccent,
          Colors.lightGreenAccent,
          Colors.amberAccent,
          Colors.pinkAccent,
          Colors.white,
        ],
        pCount: globalRandom.nextInt(i == 0 ? 7 : 25),
        pMinSize: i == 0 ? 100 : 1,
        pRandomRange: i == 0 ? 200 : 4,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // final size = MediaQuery.of(context).size;
        // if (orbits.isEmpty) setup(size);
        // print('${constraints.maxWidth} X ${constraints.maxHeight} - ${size}');
        return CustomPaint(
          painter: ParticlePainter(
            onPaint: (canvas, _) => paintParticles(canvas, false),
          ),
          foregroundPainter: ParticlePainter(
            onPaint: (canvas, _) => paintParticles(canvas, true),
          ),
          child: widget.child,
        );
      },
    );
  }

  void paintParticles(Canvas canvas, bool isForeground) {
    for (final orbit in orbits) {
      for (var particle in orbit.particles) {
        final isFrontParticles = isForeground && (particle.life % 1) > .5;
        final isBackParticles = !isForeground && (particle.life % 1) < .5;
        if (isFrontParticles || isBackParticles) {
          particle.draw(canvas);
        }
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
