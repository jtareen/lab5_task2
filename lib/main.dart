import 'package:flutter/material.dart';
import 'package:lab5_task2/widgets/explicit_animation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Start/Stop Animation'),
          centerTitle: true,
        ),
        body: Center(
          child: MyExplicitAnimation(),
        ),
      ),
    );
  }
}
