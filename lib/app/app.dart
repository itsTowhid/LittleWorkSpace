import 'package:flutter/material.dart';
import 'package:little_work_space/feature/home/home_screen.dart';
import 'package:little_work_space/shared/constants/r.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: R.appName,
      theme: ThemeData(fontFamily: 'Ubuntu', brightness: Brightness.dark),
      home: const HomeScreen(),
    );
  }
}
