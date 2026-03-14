// D4rt test script: Tests PlatformViewRenderBox from rendering
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('PlatformViewRenderBox test executing');

  // ========== PlatformViewRenderBox via AndroidView ==========
  print('--- PlatformViewRenderBox via AndroidView ---');
  // PlatformViewRenderBox is abstract, test via concrete implementations
  // On Android this would be RenderAndroidView, on iOS RenderUiKitView
  print('  PlatformViewRenderBox is an abstract base class');
  print('  Concrete implementations: RenderAndroidView, RenderUiKitView');

  // ========== Test AndroidView widget (creates PlatformViewRenderBox) ==========
  print('--- AndroidView widget properties ---');
  final androidView = AndroidView(
    viewType: 'test-view-type',
    layoutDirection: TextDirection.ltr,
    creationParams: {'key': 'value'},
    creationParamsCodec: StandardMessageCodec(),
    onPlatformViewCreated: (int id) {
      print('  Platform view created with id: $id');
    },
    hitTestBehavior: PlatformViewHitTestBehavior.opaque,
    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},
  );
  print('  AndroidView created');
  print('  viewType: test-view-type');
  print('  layoutDirection: ${TextDirection.ltr}');
  print('  hitTestBehavior: ${PlatformViewHitTestBehavior.opaque}');

  // ========== Test UiKitView widget ==========
  print('--- UiKitView widget properties ---');
  final uiKitView = UiKitView(
    viewType: 'ios-view-type',
    layoutDirection: TextDirection.rtl,
    creationParams: {'iosKey': 'iosValue'},
    creationParamsCodec: StandardMessageCodec(),
    onPlatformViewCreated: (int id) {
      print('  iOS platform view created with id: $id');
    },
    hitTestBehavior: PlatformViewHitTestBehavior.translucent,
    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},
  );
  print('  UiKitView created');
  print('  viewType: ios-view-type');
  print('  layoutDirection: ${TextDirection.rtl}');
  print('  hitTestBehavior: ${PlatformViewHitTestBehavior.translucent}');

  // ========== PlatformViewHitTestBehavior values ==========
  print('--- PlatformViewHitTestBehavior ---');
  for (final behavior in PlatformViewHitTestBehavior.values) {
    print('  ${behavior.name}: ${behavior.index}');
  }
  print('  Total behaviors: ${PlatformViewHitTestBehavior.values.length}');

  // ========== Different hit test behaviors ==========
  print('--- Hit test behavior comparison ---');
  print('  opaque: blocks all hit tests below');
  print('  translucent: allows hit tests to pass through');
  print('  transparent: ignores hit tests');
  final opaque = PlatformViewHitTestBehavior.opaque;
  final translucent = PlatformViewHitTestBehavior.translucent;
  final transparent = PlatformViewHitTestBehavior.transparent;
  print('  opaque.index: ${opaque.index}');
  print('  translucent.index: ${translucent.index}');
  print('  transparent.index: ${transparent.index}');

  // ========== Gesture recognizer factories ==========
  print('--- Gesture recognizer factories ---');
  final tapFactory = Factory<TapGestureRecognizer>(
    () => TapGestureRecognizer(),
  );
  final longPressFactory = Factory<LongPressGestureRecognizer>(
    () => LongPressGestureRecognizer(),
  );
  final panFactory = Factory<PanGestureRecognizer>(
    () => PanGestureRecognizer(),
  );
  print('  Created TapGestureRecognizer factory');
  print('  Created LongPressGestureRecognizer factory');
  print('  Created PanGestureRecognizer factory');

  // ========== AndroidView with gesture recognizers ==========
  print('--- AndroidView with gestures ---');
  final androidViewWithGestures = AndroidView(
    viewType: 'gesture-view',
    layoutDirection: TextDirection.ltr,
    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
      Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
      Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer()),
    },
  );
  print('  Created AndroidView with tap and long press recognizers');

  // ========== Platform view parameters testing ==========
  print('--- Creation params codec types ---');
  final standardCodec = StandardMessageCodec();
  final jsonCodec = JSONMessageCodec();
  print('  StandardMessageCodec available');
  print('  JSONMessageCodec available');

  // ========== Layout direction options ==========
  print('--- Layout directions ---');
  print('  TextDirection.ltr: ${TextDirection.ltr}');
  print('  TextDirection.rtl: ${TextDirection.rtl}');
  print('  LTR index: ${TextDirection.ltr.index}');
  print('  RTL index: ${TextDirection.rtl.index}');

  print('PlatformViewRenderBox test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PlatformViewRenderBox Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('AndroidView widget created'),
          Text('UiKitView widget created'),
          Text(
            'Hit test behaviors: ${PlatformViewHitTestBehavior.values.length}',
          ),
          Text('Opaque: blocks hit tests'),
          Text('Translucent: passes hit tests'),
          Text('Transparent: ignores hit tests'),
          Text('Gesture recognizers: tap, longPress, pan'),
          Text('Layout directions: LTR, RTL'),
        ],
      ),
    ),
  );
}
