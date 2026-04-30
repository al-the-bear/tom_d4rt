// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Hero from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Hero test executing');

  // Test Hero with tag and child
  final heroBasic = Hero(
    tag: 'hero-basic',
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(
        child: Text('Basic Hero', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with tag=hero-basic created');

  // Test Hero with string tag
  final heroString = Hero(
    tag: 'hero-string-tag',
    child: Container(
      width: 120.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Text('String tag', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with string tag created');

  // Test Hero with int tag
  final heroInt = Hero(
    tag: 42,
    child: Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
      child: Center(
        child: Text(
          '42',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    ),
  );
  print('Hero with int tag=42 created');

  // Test Hero with Icon child
  final heroIcon = Hero(
    tag: 'hero-icon',
    child: Icon(Icons.star, size: 64.0, color: Colors.amber),
  );
  print('Hero with Icon child created');

  // Test Hero with Image-like child (using Container with decoration)
  final heroImage = Hero(
    tag: 'hero-image',
    child: Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Center(child: Icon(Icons.image, size: 40.0, color: Colors.white)),
    ),
  );
  print('Hero with image-like child created');

  // Test Hero with createRectTween
  final heroRectTween = Hero(
    tag: 'hero-rect-tween',
    createRectTween: (Rect? begin, Rect? end) {
      print('createRectTween called: begin=$begin, end=$end');
      return MaterialRectCenterArcTween(begin: begin, end: end);
    },
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('RectTween', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with createRectTween created');

  // Test Hero with flightShuttleBuilder
  final heroShuttle = Hero(
    tag: 'hero-shuttle',
    flightShuttleBuilder:
        (
          BuildContext flightContext,
          Animation animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          print('flightShuttleBuilder called, direction=$flightDirection');
          return Container(
            color: Colors.yellow,
            child: Center(child: Text('In flight!')),
          );
        },
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text('Shuttle', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with flightShuttleBuilder created');

  // Test Hero with placeholderBuilder
  final heroPlaceholder = Hero(
    tag: 'hero-placeholder',
    placeholderBuilder: (BuildContext ctx, Size heroSize, Widget child) {
      print('placeholderBuilder called: size=$heroSize');
      return SizedBox(width: heroSize.width, height: heroSize.height);
    },
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Placeholder', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with placeholderBuilder created');

  // Test Hero with Card child
  final heroCard = Hero(
    tag: 'hero-card',
    child: Card(
      elevation: 8.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flight, size: 32.0, color: Colors.blue),
            SizedBox(height: 8.0),
            Text('Hero Card'),
          ],
        ),
      ),
    ),
  );
  print('Hero with Card child created');

  print('Hero test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Hero Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Basic Hero:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroBasic),
        SizedBox(height: 8.0),
        Text('String tag:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroString),
        SizedBox(height: 8.0),
        Text('Int tag (42):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroInt),
        SizedBox(height: 8.0),
        Text('Icon Hero:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroIcon),
        SizedBox(height: 8.0),
        Text('Image-like Hero:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroImage),
        SizedBox(height: 8.0),
        Text(
          'With createRectTween:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: heroRectTween),
        SizedBox(height: 8.0),
        Text(
          'With flightShuttleBuilder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: heroShuttle),
        SizedBox(height: 8.0),
        Text(
          'With placeholderBuilder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: heroPlaceholder),
        SizedBox(height: 8.0),
        Text('Hero Card:', style: TextStyle(fontWeight: FontWeight.bold)),
        heroCard,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Hero animates between routes with matching tags'),
        Text('• tag must be unique within a route'),
        Text('• createRectTween customizes flight path'),
        Text('• flightShuttleBuilder customizes in-flight widget'),
        Text('• placeholderBuilder replaces widget during flight'),
      ],
    ),
  );
}
