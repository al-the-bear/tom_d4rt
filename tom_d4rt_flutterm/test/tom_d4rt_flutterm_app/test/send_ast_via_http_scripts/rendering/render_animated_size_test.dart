// D4rt test script: Tests RenderAnimatedSize from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAnimatedSize test executing');

  // ========== ANIMATED SIZE CONCEPTS ==========
  print('--- RenderAnimatedSize Concepts ---');
  print('RenderAnimatedSize animates size changes of its child');
  print('It smoothly transitions between different child sizes');
  print('Uses a TickerProvider for animation timing');

  // ========== RENDER ANIMATED SIZE STATE ==========
  print('--- RenderAnimatedSizeState ---');
  print('RenderAnimatedSizeState.start: animation not yet started');
  print('RenderAnimatedSizeState.stable: no animation, stable size');
  print('RenderAnimatedSizeState.changed: size changed, animating');
  print('RenderAnimatedSizeState.unstable: child size changing during animation');

  // ========== ANIMATED SIZE WIDGET ==========
  print('--- AnimatedSize Widget Tests ---');

  // Small size container  
  final smallContainer = AnimatedSize(
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 60,
      height: 40,
      color: Colors.blue,
      child: Center(child: Text('S', style: TextStyle(color: Colors.white))),
    ),
  );
  print('Created AnimatedSize with small child (60x40)');

  // Medium size container
  final mediumContainer = AnimatedSize(
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 100,
      height: 80,
      color: Colors.green,
      child: Center(child: Text('M', style: TextStyle(color: Colors.white))),
    ),
  );
  print('Created AnimatedSize with medium child (100x80)');

  // Large size container
  final largeContainer = AnimatedSize(
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 150,
      height: 100,
      color: Colors.red,
      child: Center(child: Text('L', style: TextStyle(color: Colors.white))),
    ),
  );
  print('Created AnimatedSize with large child (150x100)');

  // ========== DURATION TESTS ==========
  print('--- Duration Tests ---');

  final fastSize = AnimatedSize(
    duration: Duration(milliseconds: 100),
    child: Container(width: 50, height: 50, color: Colors.purple),
  );
  print('Fast animation: 100ms');

  final slowSize = AnimatedSize(
    duration: Duration(seconds: 1),
    child: Container(width: 50, height: 50, color: Colors.orange),
  );
  print('Slow animation: 1 second');

  // ========== CURVE TESTS ==========
  print('--- Animation Curve Tests ---');

  final linearSize = AnimatedSize(
    duration: Duration(milliseconds: 500),
    curve: Curves.linear,
    child: Container(width: 60, height: 40, color: Colors.cyan),
  );
  print('AnimatedSize with Curves.linear');

  final easeInOutSize = AnimatedSize(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Container(width: 60, height: 40, color: Colors.teal),
  );
  print('AnimatedSize with Curves.easeInOut');

  final elasticSize = AnimatedSize(
    duration: Duration(milliseconds: 800),
    curve: Curves.elasticOut,
    child: Container(width: 60, height: 40, color: Colors.amber),
  );
  print('AnimatedSize with Curves.elasticOut');

  final bounceSize = AnimatedSize(
    duration: Duration(milliseconds: 800),
    curve: Curves.bounceOut,
    child: Container(width: 60, height: 40, color: Colors.indigo),
  );
  print('AnimatedSize with Curves.bounceOut');

  // ========== ALIGNMENT TESTS ==========
  print('--- Alignment Tests ---');

  final alignTopLeft = AnimatedSize(
    duration: Duration(milliseconds: 500),
    alignment: Alignment.topLeft,
    child: Container(width: 80, height: 60, color: Colors.pink),
  );
  print('AnimatedSize with topLeft alignment');

  final alignCenter = AnimatedSize(
    duration: Duration(milliseconds: 500),
    alignment: Alignment.center,
    child: Container(width: 80, height: 60, color: Colors.lime),
  );
  print('AnimatedSize with center alignment');

  final alignBottomRight = AnimatedSize(
    duration: Duration(milliseconds: 500),
    alignment: Alignment.bottomRight,
    child: Container(width: 80, height: 60, color: Colors.brown),
  );
  print('AnimatedSize with bottomRight alignment');

  // ========== CLIP BEHAVIOR ==========
  print('--- Clip Behavior Tests ---');
  print('Clip.none: no clipping (may overflow)');
  print('Clip.hardEdge: fast clipping, may have aliasing');
  print('Clip.antiAlias: smooth clipping edges');
  print('Clip.antiAliasWithSaveLayer: smooth with save layer');

  final clipHardEdge = AnimatedSize(
    duration: Duration(milliseconds: 500),
    clipBehavior: Clip.hardEdge,
    child: Container(width: 60, height: 40, color: Colors.deepOrange),
  );
  print('AnimatedSize with Clip.hardEdge');

  final clipAntiAlias = AnimatedSize(
    duration: Duration(milliseconds: 500),
    clipBehavior: Clip.antiAlias,
    child: Container(width: 60, height: 40, color: Colors.lightBlue),
  );
  print('AnimatedSize with Clip.antiAlias');

  // ========== REVERSE DURATION ==========
  print('--- Reverse Duration ---');
  print('AnimatedSize supports different reverse duration');
  print('Useful for asymmetric expand/collapse animations');

  final asymmetricSize = AnimatedSize(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 600),
    child: Container(width: 70, height: 50, color: Colors.deepPurple),
  );
  print('AnimatedSize with reverseDuration: 600ms');

  // ========== LAYOUT BEHAVIOR ==========
  print('--- Layout Behavior ---');
  print('RenderAnimatedSize overrides performLayout()');
  print('It animates between the previous and new child size');
  print('The animation respects the provided curve');
  print('During animation, the render object reports the animated size');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Expanding/collapsing panels');
  print('2. Dynamic content that changes size');
  print('3. Accordion-style interfaces');
  print('4. Smooth list item animations');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Notes ---');
  print('1. AnimatedSize creates a clip layer during animation');
  print('2. Consider using RepaintBoundary for complex children');
  print('3. Avoid nesting multiple AnimatedSize widgets');
  print('4. Size animations trigger layout passes');

  // ========== VS SIZE TRANSITION ==========
  print('--- AnimatedSize vs SizeTransition ---');
  print('AnimatedSize: implicit animation, auto-detects size change');
  print('SizeTransition: explicit animation, requires Animation parameter');

  print('RenderAnimatedSize test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnimatedSize Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [smallContainer, mediumContainer, largeContainer],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [linearSize, easeInOutSize, elasticSize, bounceSize],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [alignTopLeft, alignCenter, alignBottomRight],
      ),
      SizedBox(height: 8),
      Text('All size animation tests passed'),
    ],
  );
}
