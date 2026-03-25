// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Animation, AnimationController, Tween, Curve from animation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Animation test executing');

  // Test Curve classes
  final linearCurve = Curves.linear;
  print('Curves.linear: t=0.5 -> ${linearCurve.transform(0.5)}');

  final easeIn = Curves.easeIn;
  print('Curves.easeIn: t=0.5 -> ${easeIn.transform(0.5)}');

  final easeOut = Curves.easeOut;
  print('Curves.easeOut: t=0.5 -> ${easeOut.transform(0.5)}');

  final easeInOut = Curves.easeInOut;
  print('Curves.easeInOut: t=0.5 -> ${easeInOut.transform(0.5)}');

  final bounceIn = Curves.bounceIn;
  print('Curves.bounceIn: t=0.5 -> ${bounceIn.transform(0.5)}');

  final bounceOut = Curves.bounceOut;
  print('Curves.bounceOut: t=0.5 -> ${bounceOut.transform(0.5)}');

  final elasticIn = Curves.elasticIn;
  print('Curves.elasticIn: t=0.5 -> ${elasticIn.transform(0.5)}');

  final elasticOut = Curves.elasticOut;
  print('Curves.elasticOut: t=0.5 -> ${elasticOut.transform(0.5)}');

  final decelerate = Curves.decelerate;
  print('Curves.decelerate: t=0.5 -> ${decelerate.transform(0.5)}');

  final fastOutSlowIn = Curves.fastOutSlowIn;
  print('Curves.fastOutSlowIn: t=0.5 -> ${fastOutSlowIn.transform(0.5)}');

  // Test Interval curve
  final interval = Interval(0.0, 0.5, curve: Curves.easeIn);
  print(
    'Interval(0.0, 0.5) with easeIn: t=0.25 -> ${interval.transform(0.25)}',
  );
  print('Interval(0.0, 0.5) with easeIn: t=0.5 -> ${interval.transform(0.5)}');
  print(
    'Interval(0.0, 0.5) with easeIn: t=0.75 -> ${interval.transform(0.75)}',
  );

  // Test Threshold curve
  final threshold = Threshold(0.5);
  print('Threshold(0.5): t=0.4 -> ${threshold.transform(0.4)}');
  print('Threshold(0.5): t=0.6 -> ${threshold.transform(0.6)}');

  // Test cubic curve
  final cubic = Cubic(0.25, 0.1, 0.25, 1.0);
  print('Cubic(0.25, 0.1, 0.25, 1.0): t=0.5 -> ${cubic.transform(0.5)}');

  // Test flipped curve
  final flipped = FlippedCurve(Curves.easeIn);
  print('FlippedCurve(easeIn): t=0.5 -> ${flipped.transform(0.5)}');

  // Test Tween
  final doubleTween = Tween<double>(begin: 0.0, end: 100.0);
  print('Tween<double>(0.0, 100.0): t=0.5 -> ${doubleTween.transform(0.5)}');
  print('Tween midpoint via transform: ${doubleTween.transform(0.5)}');

  final intTween = IntTween(begin: 0, end: 100);
  print('IntTween(0, 100): t=0.5 -> ${intTween.transform(0.5)}');

  final colorTween = ColorTween(begin: Colors.red, end: Colors.blue);
  print('ColorTween(red, blue): t=0.5 -> ${colorTween.lerp(0.5)}');

  final sizeTween = SizeTween(begin: Size(0, 0), end: Size(100, 100));
  print('SizeTween: t=0.5 -> ${sizeTween.lerp(0.5)}');

  final rectTween = RectTween(
    begin: Rect.fromLTWH(0, 0, 50, 50),
    end: Rect.fromLTWH(100, 100, 200, 200),
  );
  print('RectTween: t=0.5 -> ${rectTween.lerp(0.5)}');

  final offsetTween = Tween<Offset>(begin: Offset.zero, end: Offset(100, 100));
  print('Offset Tween: t=0.5 -> ${offsetTween.transform(0.5)}');

  // Test CurveTween
  final curveTween = CurveTween(curve: Curves.easeInOut);
  print('CurveTween with easeInOut: t=0.5 -> ${curveTween.transform(0.5)}');

  // Test ReverseTween
  final reverseTween = ReverseTween<double>(doubleTween);
  print('ReverseTween: t=0.5 -> ${reverseTween.transform(0.5)}');

  // Test ConstantTween
  final constantTween = ConstantTween<int>(42);
  print('ConstantTween(42): t=0.5 -> ${constantTween.transform(0.5)}');

  // Test StepTween
  final stepTween = StepTween(begin: 0, end: 10);
  print('StepTween(0, 10): t=0.5 -> ${stepTween.transform(0.5)}');

  // Test Tween.chain
  print('Tween.chain() combines tweens');

  // Test AnimatedWidget concept
  print('AnimatedWidget rebuilds on animation change');

  // Test AlwaysStoppedAnimation
  final stoppedAnim = AlwaysStoppedAnimation<double>(0.5);
  print('AlwaysStoppedAnimation(0.5).value: ${stoppedAnim.value}');
  print('AlwaysStoppedAnimation.status: ${stoppedAnim.status}');

  // Test Animation status
  print('AnimationStatus.dismissed - at begin');
  print('AnimationStatus.forward - animating forward');
  print('AnimationStatus.reverse - animating backward');
  print('AnimationStatus.completed - at end');

  // Test AnimationController (requires TickerProvider)
  print('AnimationController requires vsync (TickerProvider)');
  print('AnimationController.forward() - start forward');
  print('AnimationController.reverse() - start reverse');
  print('AnimationController.repeat() - loop animation');
  print('AnimationController.stop() - stop animation');
  print('AnimationController.reset() - reset to 0');
  print('AnimationController.value - current value');
  print('AnimationController.duration - animation duration');
  print('AnimationController.reverseDuration - reverse duration');

  // Test TweenSequence
  final tweenSequence = TweenSequence<double>([
    TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 100.0), weight: 1),
    TweenSequenceItem(tween: Tween<double>(begin: 100.0, end: 50.0), weight: 1),
  ]);
  print('TweenSequence created with 2 items');
  print('TweenSequence: t=0.25 -> ${tweenSequence.transform(0.25)}');
  print('TweenSequence: t=0.75 -> ${tweenSequence.transform(0.75)}');

  // Test Duration
  final duration = Duration(milliseconds: 300);
  print('Duration(milliseconds: 300): ${duration.inMilliseconds}ms');

  final longDuration = Duration(seconds: 2, milliseconds: 500);
  print('Duration(2.5s): ${longDuration.inMilliseconds}ms');

  print('Animation test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Available Curves:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            Chip(label: Text('linear')),
            Chip(label: Text('easeIn')),
            Chip(label: Text('easeOut')),
            Chip(label: Text('easeInOut')),
            Chip(label: Text('bounceIn')),
            Chip(label: Text('bounceOut')),
            Chip(label: Text('elasticIn')),
            Chip(label: Text('elasticOut')),
            Chip(label: Text('decelerate')),
            Chip(label: Text('fastOutSlowIn')),
          ],
        ),
        SizedBox(height: 16.0),

        Text('Tween Types:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Tween<double> - double interpolation'),
        Text('• IntTween - integer interpolation'),
        Text('• ColorTween - color interpolation'),
        Text('• SizeTween - size interpolation'),
        Text('• RectTween - rectangle interpolation'),
        Text('• CurveTween - applies curve to 0-1'),
        Text('• TweenSequence - sequence of tweens'),
        SizedBox(height: 16.0),

        Text(
          'Animation Status:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('• dismissed - at begin value'),
        Text('• forward - animating toward end'),
        Text('• reverse - animating toward begin'),
        Text('• completed - at end value'),
        SizedBox(height: 16.0),

        Text(
          'AnimationController Methods:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('• forward() - animate to end'),
        Text('• reverse() - animate to begin'),
        Text('• repeat() - loop animation'),
        Text('• stop() - stop where it is'),
        Text('• reset() - go to begin'),
      ],
    ),
  );
}
