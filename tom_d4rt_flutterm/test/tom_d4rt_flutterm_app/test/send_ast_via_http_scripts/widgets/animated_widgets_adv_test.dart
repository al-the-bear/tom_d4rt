// D4rt test script: Tests AnimatedSwitcher, AnimatedCrossFade, AnimatedSize,
// AnimatedModalBarrier, AnimatedPositionedDirectional, AnimatedFractionallySizedBox,
// AnimatedSlide, AnimatedRotation
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Animated widgets advanced test executing');

  // ========== AnimatedSwitcher ==========
  print('--- AnimatedSwitcher Tests ---');
  final animatedSwitcher = AnimatedSwitcher(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 300),
    switchInCurve: Curves.easeIn,
    switchOutCurve: Curves.easeOut,
    transitionBuilder: (child, animation) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    },
    layoutBuilder: (currentChild, previousChildren) {
      return Stack(
        alignment: Alignment.center,
        children: [
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      );
    },
    child: Text('Content', key: ValueKey('key1')),
  );
  print('AnimatedSwitcher created');

  // ========== AnimatedCrossFade ==========
  print('--- AnimatedCrossFade Tests ---');
  final crossFade = AnimatedCrossFade(
    firstChild: Container(
      width: 200,
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('First')),
    ),
    secondChild: Container(
      width: 200,
      height: 150,
      color: Colors.red,
      child: Center(child: Text('Second')),
    ),
    crossFadeState: CrossFadeState.showFirst,
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 200),
    firstCurve: Curves.easeIn,
    secondCurve: Curves.easeOut,
    sizeCurve: Curves.easeInOut,
    alignment: Alignment.center,
    excludeBottomFocus: true,
  );
  print('AnimatedCrossFade created');
  print('  CrossFadeState.showFirst: ${CrossFadeState.showFirst}');
  print('  CrossFadeState.showSecond: ${CrossFadeState.showSecond}');

  // ========== AnimatedSize ==========
  print('--- AnimatedSize Tests ---');
  final animatedSize = AnimatedSize(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    alignment: Alignment.center,
    clipBehavior: Clip.hardEdge,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.green,
    ),
  );
  print('AnimatedSize created');

  // ========== AnimatedSlide ==========
  print('--- AnimatedSlide Tests ---');
  final animatedSlide = AnimatedSlide(
    offset: Offset(0, 0),
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.orange,
      child: Center(child: Text('Slide')),
    ),
  );
  print('AnimatedSlide created');

  // ========== AnimatedRotation ==========
  print('--- AnimatedRotation Tests ---');
  final animatedRotation = AnimatedRotation(
    turns: 0.5,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    alignment: Alignment.center,
    filterQuality: FilterQuality.low,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.purple,
      child: Center(child: Text('Rotate')),
    ),
  );
  print('AnimatedRotation created');

  // ========== AnimatedFractionallySizedBox ==========
  print('--- AnimatedFractionallySizedBox Tests ---');
  final animatedFractional = AnimatedFractionallySizedBox(
    widthFactor: 0.8,
    heightFactor: 0.5,
    alignment: Alignment.center,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Container(
      color: Colors.teal,
      child: Center(child: Text('Fractional')),
    ),
  );
  print('AnimatedFractionallySizedBox created');

  // ========== AnimatedPositionedDirectional ==========
  print('--- AnimatedPositionedDirectional Tests ---');
  final animatedPosDir = AnimatedPositionedDirectional(
    start: 10.0,
    top: 10.0,
    width: 100.0,
    height: 100.0,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Container(color: Colors.amber),
  );
  print('AnimatedPositionedDirectional created');

  // ========== AnimatedModalBarrier ==========
  print('--- AnimatedModalBarrier Tests ---');
  final animController = AnimationController(
    vsync: TestVSync(),
    value: 0.5,
  );
  final animatedBarrier = AnimatedModalBarrier(
    color: animController.drive(
      ColorTween(begin: Colors.transparent, end: Colors.black54),
    ),
    dismissible: true,
    semanticsLabel: 'Barrier',
  );
  print('AnimatedModalBarrier created');

  print('All animated widgets advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            animatedSwitcher,
            crossFade,
            animatedSize,
            animatedSlide,
            animatedRotation,
            Container(height: 200, child: animatedFractional),
            SizedBox(
              height: 200,
              child: Stack(children: [animatedPosDir]),
            ),
          ],
        ),
      ),
    ),
  );
}

class TestVSync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
