import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/subway_surfers_game.dart';

void main() {
  runApp(const SubwaySurfersApp());
}

class SubwaySurfersApp extends StatelessWidget {
  const SubwaySurfersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subway Surfers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: GameWidget(game: SubwaySurfersGame()),
      debugShowCheckedModeBanner: false,
    );
  }
}
