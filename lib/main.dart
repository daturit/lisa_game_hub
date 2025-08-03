import 'dart:math';

import 'package:flutter/material.dart';
import 'home_screen.dart';

List<List<String>> gridMap = [];
double gridSize = 6.0;
List<Point> touchItems = [];

List<List<Point>> foundMap = [];
List<Color> foundColor = [];
List<String> foundWords = [];
double deviceWidth = 0.0;
bool isSound = false;
bool isTime = false;
bool isRemoveAds = false;
int globalPoint = 0;
int highScore = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
