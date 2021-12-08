import 'package:flutter/material.dart';
import 'package:little_work_space/feature/home/orb_particles/orb_particles_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: OrbParticlesWidget(
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
