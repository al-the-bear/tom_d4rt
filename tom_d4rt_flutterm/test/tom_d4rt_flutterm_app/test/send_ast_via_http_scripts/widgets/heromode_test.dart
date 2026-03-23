// ignore_for_file: avoid_print
// D4rt test script: Tests HeroMode from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HeroMode test executing');

  // Test HeroMode enabled with Hero
  final heroMode1 = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'test1',
      child: Container(width: 50, height: 50, color: Colors.blue),
    ),
  );
  print('HeroMode(enabled: true, tag: test1) created');

  // Test HeroMode disabled
  final heroMode2 = HeroMode(
    enabled: false,
    child: Hero(
      tag: 'test2',
      child: Container(width: 50, height: 50, color: Colors.green),
    ),
  );
  print('HeroMode(enabled: false, tag: test2) created');

  // Test HeroMode with larger child
  final heroMode3 = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'test3',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        child: Center(child: Text('Hero')),
      ),
    ),
  );
  print('HeroMode(enabled: true, tag: test3) with text child created');

  // Test HeroMode enabled with Icon child
  final heroMode4 = HeroMode(
    enabled: true,
    child: Hero(
      tag: 'test4',
      child: Icon(Icons.star, size: 48, color: Colors.amber),
    ),
  );
  print('HeroMode(enabled: true, tag: test4) with Icon child created');

  print('HeroMode test completed');
  return Column(children: [heroMode1, heroMode2, heroMode3, heroMode4]);
}
