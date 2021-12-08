import 'package:flutter/material.dart';
import 'package:little_work_space/feature/home/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Ubuntu'),
      home: HomeScreen(),
    );
  }
}
