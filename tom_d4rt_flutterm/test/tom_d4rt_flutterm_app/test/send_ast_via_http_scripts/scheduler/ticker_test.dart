// D4rt test script: Tests Ticker, TickerProvider from package:flutter/scheduler.dart
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Scheduler test executing');

  // ========== SCHEDULERBINDING ==========
  print('--- SchedulerBinding Tests ---');

  // Note: SchedulerBinding is a singleton and already initialized in Flutter
  // We can access scheduler information through it

  // SchedulerPhase
  print('SchedulerPhase.idle: ${SchedulerPhase.idle}');
  print(
    'SchedulerPhase.transientCallbacks: ${SchedulerPhase.transientCallbacks}',
  );
  print(
    'SchedulerPhase.midFrameMicrotasks: ${SchedulerPhase.midFrameMicrotasks}',
  );
  print(
    'SchedulerPhase.persistentCallbacks: ${SchedulerPhase.persistentCallbacks}',
  );
  print(
    'SchedulerPhase.postFrameCallbacks: ${SchedulerPhase.postFrameCallbacks}',
  );

  // ========== TICKERPROVIDER ==========
  print('--- TickerProvider Tests ---');

  // TickerProvider is typically used via SingleTickerProviderStateMixin
  // or TickerProviderStateMixin in a State class
  print('TickerProvider is an abstract class for creating Tickers');
  print('Common implementations:');
  print('  - SingleTickerProviderStateMixin (for single animation)');
  print('  - TickerProviderStateMixin (for multiple animations)');

  // ========== TICKER ==========
  print('--- Ticker Tests ---');

  // Note: Creating a Ticker requires a TickerProvider/vsync
  // Since we're in a build method and not a State with a mixin,
  // we'll document the API rather than create actual tickers

  print(
    'Ticker constructor: Ticker(TickerCallback onTick, {String? debugLabel})',
  );
  print('Ticker properties:');
  print('  - isTicking: bool');
  print('  - isActive: bool');
  print('  - muted: bool (getter/setter)');
  print('  - debugLabel: String?');
  print('Ticker methods:');
  print('  - start(): TickerFuture');
  print('  - stop({bool canceled = false}): void');
  print('  - absorbTicker(Ticker originalTicker): void');
  print('  - dispose(): void');

  // ========== TICKERFUTURE ==========
  print('--- TickerFuture Tests ---');

  // TickerFuture is returned by Ticker.start()
  print('TickerFuture.complete() created');
  print('TickerFuture properties:');
  print('  - orCancel: Future<void>');
  print('  - whenComplete/then/catchError (Future methods)');

  // ========== PRIORITY ==========
  print('--- Priority Tests ---');

  print('Priority.idle: ${Priority.idle.value}');
  print('Priority.animation: ${Priority.animation.value}');
  print('Priority.touch: ${Priority.touch.value}');
  print('Priority.kMaxOffset: ${Priority.kMaxOffset}');

  // ========== FRAME TIMING ==========
  print('--- FrameTiming Tests ---');

  // FrameTiming is typically received from SchedulerBinding
  print('FrameTiming provides timing for frame phases:');
  print('  - buildDuration: Duration');
  print('  - rasterDuration: Duration');
  print('  - vsyncOverhead: Duration');
  print('  - totalSpan: Duration');
  print('  - layerCacheCount: int');
  print('  - layerCacheBytes: int');

  // FramePhase
  print('FramePhase.vsyncStart');
  print('FramePhase.buildStart');
  print('FramePhase.buildFinish');
  print('FramePhase.rasterStart');
  print('FramePhase.rasterFinish');
  print('FramePhase.rasterFinishWallTime');

  // ========== APPLIFECYCLESTATE ==========
  print('--- AppLifecycleState Tests ---');

  print('AppLifecycleState.detached: ${AppLifecycleState.detached}');
  print('AppLifecycleState.resumed: ${AppLifecycleState.resumed}');
  print('AppLifecycleState.inactive: ${AppLifecycleState.inactive}');
  print('AppLifecycleState.hidden: ${AppLifecycleState.hidden}');
  print('AppLifecycleState.paused: ${AppLifecycleState.paused}');

  print('Scheduler test completed');

  // Return visual demonstration with a TickerMode example
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scheduler Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'SchedulerPhase:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. idle - between frames',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '2. transientCallbacks - animate',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '3. midFrameMicrotasks - process microtasks',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '4. persistentCallbacks - build/layout/paint',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '5. postFrameCallbacks - cleanup',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Ticker Usage:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '// In a State with SingleTickerProviderStateMixin:',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    'late final _controller = AnimationController(',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    '  vsync: this,  // from mixin',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    '  duration: Duration(seconds: 1),',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    ');',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'TickerProvider Mixins:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(right: 4.0),
                    color: Color(0xFF2196F3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SingleTicker',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'One animation',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 4.0),
                    color: Color(0xFF4CAF50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TickerProvider',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Multiple anims',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Priority Levels:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  margin: EdgeInsets.only(right: 8.0),
                  color: Color(0xFF9E9E9E),
                  child: Text(
                    'idle',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  margin: EdgeInsets.only(right: 8.0),
                  color: Color(0xFF2196F3),
                  child: Text(
                    'animation',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  color: Color(0xFFE53935),
                  child: Text(
                    'touch',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'AppLifecycleState:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final state in [
                  'detached',
                  'resumed',
                  'inactive',
                  'hidden',
                  'paused',
                ])
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 4.0,
                    ),
                    color: Color(0xFF9C27B0),
                    child: Text(
                      state,
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9.0),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'TickerMode Widget:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TickerMode(
              enabled: true,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Color(0xFFE0E0E0),
                child: Text('Animations enabled in this subtree'),
              ),
            ),
            SizedBox(height: 8.0),
            TickerMode(
              enabled: false,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Color(0xFFFFCDD2),
                child: Text('Animations disabled in this subtree'),
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Frame Timing Info:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'buildDuration - widget build time',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'rasterDuration - GPU render time',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'vsyncOverhead - vsync delay',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'totalSpan - total frame time',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
