import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:little_work_space/shared/particle_system/orbit.dart';
import 'package:little_work_space/shared/particle_system/particle_system.dart';
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
        orbitSize: Size(
          size.width + rand.nextDouble() * 50 - 25,
          size.height + rand.nextDouble() * 50 - 25,
        ),
        position: center.translate(
          rand.nextDouble() * 50,
          rand.nextDouble() * 50,
        ),
        rotation: -pi / (4 + rand.nextDouble() * 2),
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
          painter: ParticlesPainter(
            onPaint: (canvas, _) => paintParticles(canvas, false),
          ),
          foregroundPainter: ParticlesPainter(
            onPaint: (canvas, _) => paintParticles(canvas, true),
          ),
          child: widget.child,
        );
      },
    );
  }

  void paintParticles(Canvas canvas, bool isFront) {
    for (final orbit in orbits) {
      orbit
        ..update({'isFront': isFront})
        ..draw(canvas);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
