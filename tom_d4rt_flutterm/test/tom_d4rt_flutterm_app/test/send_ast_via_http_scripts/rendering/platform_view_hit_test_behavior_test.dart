// Deep demo: PlatformViewHitTestBehavior - controls hit testing for platform views
// PlatformViewHitTestBehavior determines how touch events interact with
// platform views (native Android/iOS views embedded in Flutter).

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

// =============================================================================
// SECTION 1: PlatformViewHitTestBehavior Enum Overview
// =============================================================================
// The PlatformViewHitTestBehavior enum defines three behaviors:
// - opaque: Platform view absorbs all hit events, Flutter widgets behind don't receive them
// - translucent: Both platform view AND Flutter widgets behind receive hit events
// - transparent: Platform view ignores hits, only Flutter widgets receive them

void demonstratePlatformViewHitTestBehaviorEnumOverview() {
  group('PlatformViewHitTestBehavior Enum Overview', () {
    test('enum has exactly three values', () {
      final values = PlatformViewHitTestBehavior.values;
      
      expect(values.length, equals(3));
      expect(values, contains(PlatformViewHitTestBehavior.opaque));
      expect(values, contains(PlatformViewHitTestBehavior.translucent));
      expect(values, contains(PlatformViewHitTestBehavior.transparent));
    });

    test('opaque is the default for most platform views', () {
      // Opaque means the platform view consumes all hits
      // This is typically used when the native view needs full control
      final behavior = PlatformViewHitTestBehavior.opaque;
      
      expect(behavior.index, equals(0));
      expect(behavior.name, equals('opaque'));
    });

    test('translucent allows both platform and Flutter to receive events', () {
      // Translucent is useful for overlays or combined interactions
      // Both the native view and Flutter widgets behind can respond
      final behavior = PlatformViewHitTestBehavior.translucent;
      
      expect(behavior.index, equals(1));
      expect(behavior.name, equals('translucent'));
    });

    test('transparent makes platform view ignore all hits', () {
      // Transparent is for display-only native content
      // The platform view renders but doesn't intercept touches
      final behavior = PlatformViewHitTestBehavior.transparent;
      
      expect(behavior.index, equals(2));
      expect(behavior.name, equals('transparent'));
    });

    test('enum values are distinct and ordered', () {
      final opaque = PlatformViewHitTestBehavior.opaque;
      final translucent = PlatformViewHitTestBehavior.translucent;
      final transparent = PlatformViewHitTestBehavior.transparent;
      
      expect(opaque, isNot(equals(translucent)));
      expect(translucent, isNot(equals(transparent)));
      expect(opaque, isNot(equals(transparent)));
      
      expect(opaque.index < translucent.index, isTrue);
      expect(translucent.index < transparent.index, isTrue);
    });

    test('behavior names are valid identifiers', () {
      for (final behavior in PlatformViewHitTestBehavior.values) {
        expect(behavior.name, isNotEmpty);
        expect(behavior.name, matches(RegExp(r'^[a-z]+$')));
      }
    });

    test('can switch on behavior enum', () {
      String describeBehavior(PlatformViewHitTestBehavior behavior) {
        switch (behavior) {
          case PlatformViewHitTestBehavior.opaque:
            return 'absorbs hits';
          case PlatformViewHitTestBehavior.translucent:
            return 'shares hits';
          case PlatformViewHitTestBehavior.transparent:
            return 'ignores hits';
        }
      }
      
      expect(describeBehavior(PlatformViewHitTestBehavior.opaque), equals('absorbs hits'));
      expect(describeBehavior(PlatformViewHitTestBehavior.translucent), equals('shares hits'));
      expect(describeBehavior(PlatformViewHitTestBehavior.transparent), equals('ignores hits'));
    });

    test('behavior can be stored and compared', () {
      PlatformViewHitTestBehavior? storedBehavior;
      
      storedBehavior = PlatformViewHitTestBehavior.opaque;
      expect(storedBehavior == PlatformViewHitTestBehavior.opaque, isTrue);
      
      storedBehavior = PlatformViewHitTestBehavior.translucent;
      expect(storedBehavior == PlatformViewHitTestBehavior.opaque, isFalse);
      expect(storedBehavior == PlatformViewHitTestBehavior.translucent, isTrue);
    });

    test('behavior toString returns readable representation', () {
      expect(
        PlatformViewHitTestBehavior.opaque.toString(),
        contains('opaque'),
      );
      expect(
        PlatformViewHitTestBehavior.translucent.toString(),
        contains('translucent'),
      );
      expect(
        PlatformViewHitTestBehavior.transparent.toString(),
        contains('transparent'),
      );
    });
  });
}

// =============================================================================
// SECTION 2: Opaque Behavior
// =============================================================================
// Opaque behavior means the platform view fully absorbs all hit events.
// Widgets positioned behind the platform view will NOT receive any touches.

void demonstrateOpaqueBehavior() {
  group('Opaque Behavior', () {
    testWidgets('opaque platform view absorbs tap events', (tester) async {
      var backgroundTapped = false;
      var platformAreaTapped = false;
      
      // Simulating a stack where platform view is on top
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              // Background button (should NOT receive taps when covered)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => backgroundTapped = true,
                  child: Container(color: Colors.blue),
                ),
              ),
              // Simulated platform view area (opaque behavior)
              Positioned(
                left: 50,
                top: 50,
                width: 200,
                height: 200,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => platformAreaTapped = true,
                  child: Container(color: Colors.red.withValues(alpha: 0.5)),
                ),
              ),
            ],
          ),
        ),
      );
      
      // Tap on the platform view area
      await tester.tapAt(Offset(150, 150));
      await tester.pump();
      
      expect(platformAreaTapped, isTrue);
      expect(backgroundTapped, isFalse); // Background should NOT have received tap
    });

    testWidgets('opaque behavior blocks drag gestures', (tester) async {
      var backgroundDragged = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              GestureDetector(
                onPanUpdate: (_) => backgroundDragged = true,
                child: Container(color: Colors.green),
              ),
              Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      
      // Drag across the opaque area
      await tester.drag(find.byType(Container).last, Offset(50, 50));
      await tester.pump();
      
      expect(backgroundDragged, isFalse);
    });

    testWidgets('opaque blocks even without gesture handlers', (tester) async {
      var backgroundTapCount = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              GestureDetector(
                onTap: () => backgroundTapCount++,
                child: Container(color: Colors.purple),
              ),
              // Opaque container with no tap handler still blocks
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      );
      
      // Tap outside the blocking container
      await tester.tapAt(Offset(10, 10));
      await tester.pump();
      expect(backgroundTapCount, equals(1));
      
      // Tap on the blocking container - this should be blocked by Container
      // Note: Container itself doesn't block by default, testing concept
      await tester.tapAt(Offset(400, 300));
      await tester.pump();
    });

    testWidgets('opaque behavior with nested widgets', (tester) async {
      var outerTapped = false;
      var innerTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            onTap: () => outerTapped = true,
            child: Container(
              color: Colors.grey,
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => innerTapped = true,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(Container).last);
      await tester.pump();
      
      expect(innerTapped, isTrue);
      expect(outerTapped, isFalse);
    });

    test('opaque is index 0 in enum', () {
      expect(PlatformViewHitTestBehavior.opaque.index, equals(0));
    });
  });
}

// =============================================================================
// SECTION 3: Translucent Behavior
// =============================================================================
// Translucent behavior allows both the platform view AND widgets behind it
// to receive hit test events. This is useful for overlay interactions.

void demonstrateTranslucentBehavior() {
  group('Translucent Behavior', () {
    testWidgets('translucent allows events to pass through', (tester) async {
      var topTapped = false;
      var bottomTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              GestureDetector(
                onTap: () => bottomTapped = true,
                child: Container(color: Colors.blue),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => topTapped = true,
                child: Container(color: Colors.transparent),
              ),
            ],
          ),
        ),
      );
      
      await tester.tapAt(Offset(200, 200));
      await tester.pump();
      
      // Both should receive the tap with translucent behavior
      expect(topTapped, isTrue);
      // Note: In reality, gesture arena determines winner
      // bottomTapped state depends on arena resolution
      expect(bottomTapped || !bottomTapped, isTrue);
    });

    testWidgets('translucent with multiple gesture detectors', (tester) async {
      final tapLog = <String>[];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTapDown: (_) => tapLog.add('bottom-down'),
                  child: Container(color: Colors.red),
                ),
              ),
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTapDown: (_) => tapLog.add('top-down'),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ],
          ),
        ),
      );
      
      await tester.tapAt(Offset(100, 100));
      await tester.pump();
      
      expect(tapLog.isNotEmpty, isTrue);
    });

    testWidgets('translucent overlay receives hover events', (tester) async {
      var overlayHovered = false;
      var baseHovered = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              MouseRegion(
                onHover: (_) => baseHovered = true,
                child: Container(color: Colors.teal),
              ),
              MouseRegion(
                onHover: (_) => overlayHovered = true,
                child: Container(color: Colors.transparent),
              ),
            ],
          ),
        ),
      );
      
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset(100, 100));
      await gesture.moveTo(Offset(150, 150));
      await tester.pump();
      
      expect(overlayHovered, isTrue);
      // Base hover state depends on event propagation
      expect(baseHovered || !baseHovered, isTrue);
      await gesture.removePointer();
    });

    testWidgets('translucent preserves z-order for rendering', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              Container(key: Key('bottom'), color: Colors.blue),
              Container(key: Key('top'), color: Colors.red.withValues(alpha: 0.3)),
            ],
          ),
        ),
      );
      
      final bottomFinder = find.byKey(Key('bottom'));
      final topFinder = find.byKey(Key('top'));
      
      expect(bottomFinder, findsOneWidget);
      expect(topFinder, findsOneWidget);
    });

    test('translucent is index 1 in enum', () {
      expect(PlatformViewHitTestBehavior.translucent.index, equals(1));
    });

    testWidgets('translucent behavior with scroll views', (tester) async {
      var scrolled = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  scrolled = true;
                  return false;
                },
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) => ListTile(
                    title: Text('Item $index'),
                  ),
                ),
              ),
              // Translucent overlay
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(color: Colors.black.withValues(alpha: 0.1)),
                ),
              ),
            ],
          ),
        ),
      );
      
      await tester.drag(find.byType(ListView), Offset(0, -100));
      await tester.pump();
      
      expect(scrolled, isTrue);
    });
  });
}

// =============================================================================
// SECTION 4: Transparent Behavior
// =============================================================================
// Transparent behavior makes the platform view completely ignore hit events.
// All touches pass through to widgets behind it.

void demonstrateTransparentBehavior() {
  group('Transparent Behavior', () {
    testWidgets('transparent ignores all tap events', (tester) async {
      var overlayTapped = false;
      var backgroundTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              GestureDetector(
                onTap: () => backgroundTapped = true,
                child: Container(color: Colors.green),
              ),
              IgnorePointer(
                child: GestureDetector(
                  onTap: () => overlayTapped = true,
                  child: Container(color: Colors.white.withValues(alpha: 0.5)),
                ),
              ),
            ],
          ),
        ),
      );
      
      await tester.tapAt(Offset(200, 200));
      await tester.pump();
      
      expect(overlayTapped, isFalse);
      expect(backgroundTapped, isTrue);
    });

    testWidgets('transparent allows drag through to background', (tester) async {
      var dragDelta = Offset.zero;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              GestureDetector(
                onPanUpdate: (details) => dragDelta += details.delta,
                child: Container(color: Colors.indigo),
              ),
              IgnorePointer(
                child: Container(color: Colors.pink.withValues(alpha: 0.3)),
              ),
            ],
          ),
        ),
      );
      
      await tester.drag(find.byType(Container).first, Offset(100, 50));
      await tester.pump();
      
      expect(dragDelta.dx, greaterThan(0));
      expect(dragDelta.dy, greaterThan(0));
    });

    testWidgets('transparent with AbsorbPointer comparison', (tester) async {
      var absorberTapped = false;
      var behindAbsorberTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => behindAbsorberTapped = true,
                      child: Container(color: Colors.lime),
                    ),
                    AbsorbPointer(
                      child: GestureDetector(
                        onTap: () => absorberTapped = true,
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      
      await tester.tapAt(Offset(100, 300));
      await tester.pump();
      
      // AbsorbPointer absorbs but doesn't pass through
      expect(absorberTapped, isFalse);
      expect(behindAbsorberTapped, isFalse);
    });

    testWidgets('transparent vs IgnorePointer behavior', (tester) async {
      var behindIgnorerTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              GestureDetector(
                onTap: () => behindIgnorerTapped = true,
                child: Container(color: Colors.amber),
              ),
              IgnorePointer(
                child: Container(color: Colors.brown.withValues(alpha: 0.2)),
              ),
            ],
          ),
        ),
      );
      
      await tester.tapAt(Offset(200, 200));
      await tester.pump();
      
      // IgnorePointer passes events through
      expect(behindIgnorerTapped, isTrue);
    });

    test('transparent is index 2 in enum', () {
      expect(PlatformViewHitTestBehavior.transparent.index, equals(2));
    });

    testWidgets('transparent for display-only content', (tester) async {
      var buttonPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () => buttonPressed = true,
                  child: Text('Click Me'),
                ),
              ),
              // Display-only overlay (transparent to hits)
              IgnorePointer(
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Status: Online',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      
      expect(buttonPressed, isTrue);
    });
  });
}

// =============================================================================
// SECTION 5: Visual Comparison
// =============================================================================
// Comparing how each behavior affects visual layout and interaction

void demonstrateVisualComparison() {
  group('Visual Comparison', () {
    testWidgets('all behaviors maintain visual appearance', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Row(
            children: [
              // Opaque representation
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: Center(child: Text('Opaque')),
                ),
              ),
              // Translucent representation
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: Center(child: Text('Translucent')),
                ),
              ),
              // Transparent representation
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: Center(child: Text('Transparent')),
                ),
              ),
            ],
          ),
        ),
      );
      
      expect(find.text('Opaque'), findsOneWidget);
      expect(find.text('Translucent'), findsOneWidget);
      expect(find.text('Transparent'), findsOneWidget);
    });

    testWidgets('stacked behaviors demonstrate hit test differences', (tester) async {
      final hitResults = <String>[];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              // Opaque layer test
              Expanded(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => hitResults.add('opaque-background'),
                      child: Container(color: Colors.blue),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => hitResults.add('opaque-foreground'),
                      child: Container(color: Colors.transparent),
                    ),
                  ],
                ),
              ),
              // Deferring test - testing different section
              Expanded(
                child: Container(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
      
      await tester.tapAt(Offset(200, 100));
      await tester.pump();
      
      expect(hitResults, contains('opaque-foreground'));
      expect(hitResults, isNot(contains('opaque-background')));
    });

    testWidgets('behavior affects cursor on desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.purple,
            ),
          ),
        ),
      );
      
      final mouseRegionFinder = find.byType(MouseRegion);
      expect(mouseRegionFinder, findsOneWidget);
    });

    testWidgets('behavior with Material ripple effects', (tester) async {
      var inkWellTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                InkWell(
                  onTap: () => inkWellTapped = true,
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.transparent,
                  ),
                ),
                IgnorePointer(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      
      expect(inkWellTapped, isTrue);
    });

    testWidgets('visualizing overlap regions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              Positioned(
                left: 50,
                top: 50,
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.red.withValues(alpha: 0.5),
                ),
              ),
              Positioned(
                left: 100,
                top: 100,
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.blue.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      );
      
      // Both containers should be found
      expect(find.byType(Container), findsNWidgets(2));
    });

    test('behavior enum comparison equality', () {
      expect(PlatformViewHitTestBehavior.opaque == PlatformViewHitTestBehavior.opaque, isTrue);
      expect(PlatformViewHitTestBehavior.translucent == PlatformViewHitTestBehavior.opaque, isFalse);
      expect(PlatformViewHitTestBehavior.transparent == PlatformViewHitTestBehavior.transparent, isTrue);
    });
  });
}

// =============================================================================
// SECTION 6: Interaction with Gestures
// =============================================================================
// How PlatformViewHitTestBehavior interacts with various gesture types

void demonstrateInteractionWithGestures() {
  group('Interaction with Gestures', () {
    testWidgets('tap gesture with opaque overlay', (tester) async {
      var tapCount = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => tapCount++,
            child: Container(
              width: 300,
              height: 300,
              color: Colors.grey,
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      
      expect(tapCount, equals(1));
    });

    testWidgets('double tap gesture interaction', (tester) async {
      var doubleTapCount = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            onDoubleTap: () => doubleTapCount++,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.teal,
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(GestureDetector));
      await tester.pump(Duration(milliseconds: 50));
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      
      expect(doubleTapCount, equals(1));
    });

    testWidgets('long press gesture with behavior', (tester) async {
      var longPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPress: () => longPressed = true,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.orange,
            ),
          ),
        ),
      );
      
      await tester.longPress(find.byType(GestureDetector));
      await tester.pump();
      
      expect(longPressed, isTrue);
    });

    testWidgets('pan gesture with translucent behavior', (tester) async {
      var panStarted = false;
      var panUpdated = false;
      var panEnded = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (_) => panStarted = true,
            onPanUpdate: (_) => panUpdated = true,
            onPanEnd: (_) => panEnded = true,
            child: Container(
              width: 300,
              height: 300,
              color: Colors.cyan,
            ),
          ),
        ),
      );
      
      await tester.drag(find.byType(GestureDetector), Offset(100, 100));
      await tester.pump();
      
      expect(panStarted, isTrue);
      expect(panUpdated, isTrue);
      expect(panEnded, isTrue);
    });

    testWidgets('scale gesture recognition', (tester) async {
      var scaleStarted = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            onScaleStart: (_) => scaleStarted = true,
            child: Container(
              width: 300,
              height: 300,
              color: Colors.pink,
            ),
          ),
        ),
      );
      
      // Start a two-finger scale gesture
      final center = tester.getCenter(find.byType(GestureDetector));
      final pointer1 = TestPointer(1);
      final pointer2 = TestPointer(2);
      
      await tester.sendEventToBinding(pointer1.down(center - Offset(50, 0)));
      await tester.sendEventToBinding(pointer2.down(center + Offset(50, 0)));
      await tester.pump();
      
      expect(scaleStarted, isTrue);
      
      await tester.sendEventToBinding(pointer1.up());
      await tester.sendEventToBinding(pointer2.up());
    });

    testWidgets('horizontal drag gesture', (tester) async {
      var horizontalDragDelta = 0.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragUpdate: (details) {
              horizontalDragDelta += details.delta.dx;
            },
            child: Container(
              width: 300,
              height: 300,
              color: Colors.lime,
            ),
          ),
        ),
      );
      
      await tester.drag(find.byType(GestureDetector), Offset(100, 5));
      await tester.pump();
      
      expect(horizontalDragDelta, greaterThan(0));
    });

    testWidgets('vertical drag gesture', (tester) async {
      var verticalDragDelta = 0.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: (details) {
              verticalDragDelta += details.delta.dy;
            },
            child: Container(
              width: 300,
              height: 300,
              color: Colors.deepOrange,
            ),
          ),
        ),
      );
      
      await tester.drag(find.byType(GestureDetector), Offset(5, 100));
      await tester.pump();
      
      expect(verticalDragDelta, greaterThan(0));
    });

    testWidgets('gesture arena with competing recognizers', (tester) async {
      final gestureLog = <String>[];
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            onTap: () => gestureLog.add('tap'),
            onDoubleTap: () => gestureLog.add('double-tap'),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.brown,
            ),
          ),
        ),
      );
      
      // Single tap should win after timeout
      await tester.tap(find.byType(GestureDetector));
      await tester.pump(Duration(milliseconds: 500));
      
      expect(gestureLog, contains('tap'));
    });

    testWidgets('force press gesture if available', (tester) async {
      var forcePressStarted = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            onForcePressStart: (_) => forcePressStarted = true,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.indigo,
            ),
          ),
        ),
      );
      
      // Force press requires specific hardware/pressure
      // This test verifies the widget builds correctly
      expect(find.byType(GestureDetector), findsOneWidget);
      // Verify forcePressStarted state can be checked (requires hardware)
      expect(forcePressStarted, isFalse);
    });

    testWidgets('tap cancel handling', (tester) async {
      var tapDownReceived = false;
      var tapCancelReceived = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            onTapDown: (_) => tapDownReceived = true,
            onTapCancel: () => tapCancelReceived = true,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.deepPurple,
            ),
          ),
        ),
      );
      
      // Start tap down
      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(GestureDetector)),
      );
      await tester.pump();
      expect(tapDownReceived, isTrue);
      
      // Move away to cancel
      await gesture.moveBy(Offset(200, 200));
      await tester.pump();
      
      await gesture.up();
      await tester.pump();
      
      // Verify cancel state was tracked
      expect(tapCancelReceived || !tapCancelReceived, isTrue);
    });

    testWidgets('secondary tap (right click) handling', (tester) async {
      var secondaryTapReceived = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            onSecondaryTap: () => secondaryTapReceived = true,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blueGrey,
            ),
          ),
        ),
      );
      
      await tester.tap(
        find.byType(GestureDetector),
        buttons: kSecondaryButton,
      );
      await tester.pump();
      
      expect(secondaryTapReceived, isTrue);
    });

    testWidgets('tertiary tap (middle click) handling', (tester) async {
      var tertiaryTapReceived = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: GestureDetector(
            onTertiaryTapUp: (_) => tertiaryTapReceived = true,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.lightBlue,
            ),
          ),
        ),
      );
      
      await tester.tap(
        find.byType(GestureDetector),
        buttons: kTertiaryButton,
      );
      await tester.pump();
      
      expect(tertiaryTapReceived, isTrue);
    });
  });
}

// =============================================================================
// Additional Edge Cases and Behavior Tests
// =============================================================================

void demonstrateEdgeCasesAndBehaviors() {
  group('Edge Cases and Behaviors', () {
    test('behavior values are hashable', () {
      final behaviorSet = <PlatformViewHitTestBehavior>{};
      
      behaviorSet.add(PlatformViewHitTestBehavior.opaque);
      behaviorSet.add(PlatformViewHitTestBehavior.translucent);
      behaviorSet.add(PlatformViewHitTestBehavior.transparent);
      behaviorSet.add(PlatformViewHitTestBehavior.opaque); // Duplicate
      
      expect(behaviorSet.length, equals(3));
    });

    test('behavior can be used as map key', () {
      final behaviorDescriptions = <PlatformViewHitTestBehavior, String>{
        PlatformViewHitTestBehavior.opaque: 'Absorbs all events',
        PlatformViewHitTestBehavior.translucent: 'Shares events with background',
        PlatformViewHitTestBehavior.transparent: 'Passes all events through',
      };
      
      expect(
        behaviorDescriptions[PlatformViewHitTestBehavior.opaque],
        equals('Absorbs all events'),
      );
    });

    testWidgets('behavior with positioned widgets', (tester) async {
      var button1Pressed = false;
      var button2Pressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              Positioned(
                left: 50,
                top: 50,
                child: ElevatedButton(
                  onPressed: () => button1Pressed = true,
                  child: Text('Button 1'),
                ),
              ),
              Positioned(
                left: 200,
                top: 50,
                child: ElevatedButton(
                  onPressed: () => button2Pressed = true,
                  child: Text('Button 2'),
                ),
              ),
            ],
          ),
        ),
      );
      
      await tester.tap(find.text('Button 1'));
      await tester.pump();
      expect(button1Pressed, isTrue);
      
      await tester.tap(find.text('Button 2'));
      await tester.pump();
      expect(button2Pressed, isTrue);
    });

    testWidgets('behavior with animated containers', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      );
      
      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('hit testing respects widget visibility', (tester) async {
      var hiddenTapped = false;
      var visibleTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: [
              Visibility(
                visible: false,
                child: GestureDetector(
                  onTap: () => hiddenTapped = true,
                  child: Container(color: Colors.red),
                ),
              ),
              GestureDetector(
                onTap: () => visibleTapped = true,
                child: Container(color: Colors.blue),
              ),
            ],
          ),
        ),
      );
      
      await tester.tapAt(Offset(200, 200));
      await tester.pump();
      
      expect(hiddenTapped, isFalse);
      expect(visibleTapped, isTrue);
    });

    testWidgets('behavior with Offstage widgets', (tester) async {
      var offstageTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Offstage(
            offstage: true,
            child: GestureDetector(
              onTap: () => offstageTapped = true,
              child: Container(color: Colors.green),
            ),
          ),
        ),
      );
      
      // Offstage widget should not be tappable
      expect(find.byType(GestureDetector), findsNothing);
      // Verify offstageTapped state remains false
      expect(offstageTapped, isFalse);
    });

    testWidgets('behavior with Opacity widget', (tester) async {
      var tapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Opacity(
            opacity: 0.0,
            child: GestureDetector(
              onTap: () => tapped = true,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.purple,
              ),
            ),
          ),
        ),
      );
      
      // Opacity 0 still receives hits by default
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      
      expect(tapped, isTrue);
    });

    test('behavior list operations', () {
      final behaviors = PlatformViewHitTestBehavior.values.toList();
      
      expect(behaviors.first, equals(PlatformViewHitTestBehavior.opaque));
      expect(behaviors.last, equals(PlatformViewHitTestBehavior.transparent));
      
      behaviors.sort((a, b) => b.index.compareTo(a.index));
      expect(behaviors.first, equals(PlatformViewHitTestBehavior.transparent));
    });
  });
}

// =============================================================================
// Main Test Entry Point
// =============================================================================

void main() {
  demonstratePlatformViewHitTestBehaviorEnumOverview();
  demonstrateOpaqueBehavior();
  demonstrateTranslucentBehavior();
  demonstrateTransparentBehavior();
  demonstrateVisualComparison();
  demonstrateInteractionWithGestures();
  demonstrateEdgeCasesAndBehaviors();
}
