import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:little_work_space/shared/particle_system/constants.dart';
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
        for (final orb in [bgOrbit, circleOrbit, squareOrbit]) {
          orb?.update();
        }
      });
    });

  Orbit? bgOrbit, circleOrbit, squareOrbit;
  final colors = [
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.amberAccent,
    Colors.pinkAccent,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _getWidgetSize()?.let(setup);
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
    circleOrbit = _buildOrbit(size, ParticleShape.circle);
    squareOrbit = _buildOrbit(size, ParticleShape.square);

    bgOrbit = Orbit(
      orbitSize: size.enlargeRandom(25),
      position: size.center(Offset.zero).translateRandom(50),
      rotation: (-45 + globalRandom.nextInt(20)).degreeToRadian,
      pColors: colors,
      pCount: globalRandom.nextInt(7),
      pRandomRange: 200,
      pMinSize: 100,
    );

    print('${bgOrbit?.particles.length}, ${circleOrbit?.particles.length}, ${squareOrbit?.particles.length}');
  }

  Orbit _buildOrbit(Size size, ParticleShape shape) => Orbit(
        orbitSize: size.enlargeRandom(25),
        position: size.center(Offset.zero).translateRandom(50),
        rotation: (-45 + globalRandom.nextInt(20)).degreeToRadian,
        pColors: colors,
        shape: shape,
        pCount: globalRandom.nextInt(15) + 10,
        pRandomRange: 4,
        pMinSize: 2,
      );

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
    if (!isForeground) {
      bgOrbit?.draw(canvas);
    }
    for (final orbit in [circleOrbit, squareOrbit]) {
      for (var particle in orbit?.particles ?? []) {
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
