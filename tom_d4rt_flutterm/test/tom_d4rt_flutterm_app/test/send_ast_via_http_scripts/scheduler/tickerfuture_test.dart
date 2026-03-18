// D4rt test script: Tests TickerFuture, TickerCanceled from package:flutter/scheduler.dart
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Scheduler ticker future test executing');

  // ========== TICKERFUTURE ==========
  print('--- TickerFuture Tests ---');

  // TickerFuture.complete
  final completedFuture = TickerFuture.complete();
  print('TickerFuture.complete() created');
  print('  runtimeType: ${completedFuture.runtimeType}');

  // orCancel returns a future that completes normally or throws TickerCanceled
  final orCancelFuture = completedFuture.orCancel;
  print('  orCancel: ${orCancelFuture.runtimeType}');

  // whenCompleteOrCancel
  completedFuture.whenCompleteOrCancel(() {
    print('  TickerFuture completed or canceled callback');
  });
  print('  whenCompleteOrCancel callback registered');

  // TickerFuture is typically created by Ticker.start()
  print('TickerFuture is typically created by:');
  print('  Ticker.start() - returns TickerFuture');
  print('  AnimationController.forward() - returns TickerFuture');
  print('  AnimationController.reverse() - returns TickerFuture');
  print('  AnimationController.repeat() - returns TickerFuture');
  print('  AnimationController.animateTo() - returns TickerFuture');

  // ========== TICKERCANCELED ==========
  print('--- TickerCanceled Tests ---');

  // TickerCanceled with ticker
  final canceledNoTicker = TickerCanceled();
  print('TickerCanceled() created');
  print('  runtimeType: ${canceledNoTicker.runtimeType}');
  print('  toString: $canceledNoTicker');

  // TickerCanceled is thrown when a ticker is canceled
  print('TickerCanceled is thrown when:');
  print('  - Ticker.stop(canceled: true) is called');
  print('  - AnimationController is disposed while active');
  print('  - Widget is removed while animation is running');

  // ========== TICKER LIFECYCLE ==========
  print('--- Ticker Lifecycle ---');

  print('Typical Ticker lifecycle:');
  print('  1. Create via TickerProvider (mixin on State)');
  print('  2. Start: TickerFuture = ticker.start()');
  print('  3. Running: onTick callback fires each frame');
  print('  4. Stop: ticker.stop() or dispose()');
  print('  5. Future completes or throws TickerCanceled');

  // ========== SCHEDULERBINDING INTEGRATION ==========
  print('--- SchedulerBinding Integration ---');

  // Access current frame info
  print('SchedulerBinding.instance available');
  print('  currentFrameTimeStamp - time of current frame');
  print('  currentSystemFrameTimeStamp - system time');
  print('  transientCallbackCount - pending callbacks');

  // Frame callbacks
  print('Frame callback types:');
  print('  scheduleFrameCallback - one-shot');
  print('  addTimingsCallback - frame timing');
  print('  addPostFrameCallback - after frame');
  print('  addPersistentFrameCallback - every frame');

  // ========== PRIORITY ==========
  print('--- Priority Tests ---');

  print('Priority.idle: ${Priority.idle.value}');
  print('Priority.animation: ${Priority.animation.value}');
  print('Priority.touch: ${Priority.touch.value}');
  print('Priority.kMaxOffset: ${Priority.kMaxOffset}');

  // ========== RETURN WIDGET ==========
  print('Scheduler ticker future test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scheduler TickerFuture Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• TickerFuture - animation completion future'),
          Text('• TickerCanceled - cancellation exception'),
          Text('• Priority - scheduling priority'),
          SizedBox(height: 16.0),

          Text(
            'Bridge Availability:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF3E5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TickerFuture.complete(): available'),
                Text('TickerCanceled(): available'),
                Text('Priority.idle: ${Priority.idle.value}'),
                Text('Priority.animation: ${Priority.animation.value}'),
                Text('Priority.touch: ${Priority.touch.value}'),
                SizedBox(height: 8.0),
                Text('Note: Full Ticker creation requires'),
                Text('a TickerProvider (State mixin)'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
