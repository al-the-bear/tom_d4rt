// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo of SingletonFlutterWindow from dart:ui
// SingletonFlutterWindow was the singular window accessor (ui.window) before
// Flutter moved to multi-view architecture. It is deprecated since Flutter 3.7.
// This demo explores the FlutterView/PlatformDispatcher replacement API and
// shows what information the window object exposes about the display.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SingletonFlutterWindow deep demo executing');

  // Gather live data from the current view
  final view = View.of(context);
  final dispatcher = view.platformDispatcher;
  final implicitView = dispatcher.implicitView;
  final mediaQuery = MediaQuery.of(context);
  final gestureSettings = view.gestureSettings;

  // ============================================================
  // SECTION 1: Deprecation Context
  // ============================================================
  print('=== Section 1: Deprecation Context ===');
  print('SingletonFlutterWindow deprecated since Flutter 3.7');
  print('Replaced by FlutterView + PlatformDispatcher');

  Widget swDeprecationBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF455A64), Color(0xFF607D8B)],
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      children: [
        Icon(Icons.warning_amber_rounded, color: Colors.amber.shade300, size: 44.0),
        SizedBox(height: 8.0),
        Text('SingletonFlutterWindow', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade700,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text('DEPRECATED since Flutter 3.7', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox(height: 8.0),
        Text(
          'The single-window API has been replaced by a multi-view architecture. Use FlutterView and PlatformDispatcher instead of WidgetsBinding.instance.window or dart:ui window.',
          style: TextStyle(fontSize: 12.0, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Migration Path
  // ============================================================
  print('=== Section 2: Migration Path ===');

  Widget swMigrationRow(String old, String replacement, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(old, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.red.shade700, decoration: TextDecoration.lineThrough)),
                SizedBox(height: 4.0),
                Text(replacement, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.green.shade700)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward, color: accent, size: 18.0),
        ],
      ),
    );
  }

  final swMigrations = <Widget>[
    swMigrationRow('ui.window', 'View.of(context)', Color(0xFF546E7A)),
    swMigrationRow('ui.window.devicePixelRatio', 'View.of(context).devicePixelRatio', Color(0xFF546E7A)),
    swMigrationRow('ui.window.physicalSize', 'View.of(context).physicalSize', Color(0xFF546E7A)),
    swMigrationRow('ui.window.padding', 'View.of(context).padding', Color(0xFF546E7A)),
    swMigrationRow('ui.window.locale', 'PlatformDispatcher.instance.locale', Color(0xFF546E7A)),
    swMigrationRow('ui.window.textScaleFactor', 'MediaQuery.textScaleFactorOf(context)', Color(0xFF546E7A)),
    swMigrationRow('WidgetsBinding.instance.window', 'View.of(context)', Color(0xFF546E7A)),
  ];
  print('7 migration patterns documented');

  // ============================================================
  // SECTION 3: FlutterView via View.of(context)
  // ============================================================
  print('=== Section 3: FlutterView Access ===');
  print('View runtimeType: ${view.runtimeType}');
  print('is FlutterView: true (FlutterView is the base)');
  print('viewId: ${view.viewId}');

  Widget swViewInfo(String label, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(left: BorderSide(color: color, width: 3.0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 10.0),
          Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0)),
          Spacer(),
          Flexible(child: Text(value, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: color), textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 4: Device Pixel Ratio
  // ============================================================
  print('=== Section 4: Device Pixel Ratio ===');
  final dpr = view.devicePixelRatio;
  print('devicePixelRatio: $dpr');

  Widget swDprSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.aspect_ratio, color: Color(0xFF455A64), size: 22.0),
            SizedBox(width: 8.0),
            Text('Device Pixel Ratio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xFF455A64))),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'The ratio of physical pixels per logical pixel. A DPR of ${dpr.toStringAsFixed(2)} means each logical pixel maps to ${dpr.toStringAsFixed(2)} physical pixels on each axis.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            _SwDprVisual(label: '1x', dpr: 1.0, current: dpr),
            SizedBox(width: 8.0),
            _SwDprVisual(label: '2x', dpr: 2.0, current: dpr),
            SizedBox(width: 8.0),
            _SwDprVisual(label: '3x', dpr: 3.0, current: dpr),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current: ${dpr.toStringAsFixed(2)}x', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Color(0xFF455A64))),
                  SizedBox(height: 2.0),
                  Text('Higher = sharper displays', style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Physical and Logical Size
  // ============================================================
  print('=== Section 5: Physical & Logical Size ===');
  final physSize = view.physicalSize;
  final logicalWidth = physSize.width / dpr;
  final logicalHeight = physSize.height / dpr;
  print('Physical: ${physSize.width.toStringAsFixed(0)} x ${physSize.height.toStringAsFixed(0)}');
  print('Logical: ${logicalWidth.toStringAsFixed(0)} x ${logicalHeight.toStringAsFixed(0)}');

  Widget swSizeComparison = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Screen Dimensions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.purple.shade800)),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: Column(
                  children: [
                    Icon(Icons.grid_4x4, color: Colors.purple.shade400, size: 24.0),
                    SizedBox(height: 4.0),
                    Text('Physical', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.purple.shade700)),
                    Text('${physSize.width.toStringAsFixed(0)} x ${physSize.height.toStringAsFixed(0)}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                    Text('pixels', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Icon(Icons.sync_alt, color: Colors.purple.shade300, size: 20.0),
                  Text('/ ${dpr.toStringAsFixed(1)}', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.purple.shade400)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Column(
                  children: [
                    Icon(Icons.phone_android, color: Colors.blue.shade400, size: 24.0),
                    SizedBox(height: 4.0),
                    Text('Logical', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.blue.shade700)),
                    Text('${logicalWidth.toStringAsFixed(0)} x ${logicalHeight.toStringAsFixed(0)}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                    Text('dp units', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Physical pixels = logical pixels * devicePixelRatio. Flutter layouts work in logical pixels, which are device-independent.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: View Insets (Keyboard)
  // ============================================================
  print('=== Section 6: View Insets ===');
  final insets = view.viewInsets;
  print('viewInsets: L=${insets.left} T=${insets.top} R=${insets.right} B=${insets.bottom}');

  Widget swInsetBar(String label, double value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(width: 55.0, child: Text(label, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500))),
          Expanded(
            child: Container(
              height: 20.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (value / 500.0).clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          SizedBox(width: 50.0, child: Text('${value.toStringAsFixed(0)} px', style: TextStyle(fontFamily: 'monospace', fontSize: 10.0), textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget swInsetsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard, color: Colors.blue.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('View Insets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.blue.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Areas obscured by system UI like the on-screen keyboard. Values are in physical pixels.', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        swInsetBar('Left', insets.left, Colors.blue.shade400),
        swInsetBar('Top', insets.top, Colors.blue.shade500),
        swInsetBar('Right', insets.right, Colors.blue.shade400),
        swInsetBar('Bottom', insets.bottom, Colors.blue.shade600),
        SizedBox(height: 6.0),
        Text('Bottom inset > 0 typically means the keyboard is open.', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: View Padding (Notch / Status Bar)
  // ============================================================
  print('=== Section 7: View Padding ===');
  final vPadding = view.padding;
  print('padding: L=${vPadding.left} T=${vPadding.top} R=${vPadding.right} B=${vPadding.bottom}');
  final viewPadding = view.viewPadding;
  print('viewPadding: L=${viewPadding.left} T=${viewPadding.top} R=${viewPadding.right} B=${viewPadding.bottom}');

  Widget swPaddingSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.padding, color: Colors.orange.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('View Padding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.orange.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Areas partially obscured by system UI (notch, status bar, home indicator).', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('padding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.orange.shade700)),
                  Text('Shrinks when keyboard opens', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                  SizedBox(height: 4.0),
                  Text('T: ${vPadding.top.toStringAsFixed(0)}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                  Text('B: ${vPadding.bottom.toStringAsFixed(0)}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                ],
              ),
            ),
            Container(width: 1, height: 60.0, color: Colors.orange.shade200),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('viewPadding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.deepOrange.shade700)),
                    Text('Stays constant always', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                    SizedBox(height: 4.0),
                    Text('T: ${viewPadding.top.toStringAsFixed(0)}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                    Text('B: ${viewPadding.bottom.toStringAsFixed(0)}', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: System Gesture Insets
  // ============================================================
  print('=== Section 8: System Gesture Insets ===');
  final sysGesture = view.systemGestureInsets;
  print('systemGestureInsets: L=${sysGesture.left} T=${sysGesture.top} R=${sysGesture.right} B=${sysGesture.bottom}');

  Widget swGestureSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swipe, color: Colors.green.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('System Gesture Insets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.green.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Edges where system gestures take priority over app gestures (back swipe, home gesture).', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        swInsetBar('Left', sysGesture.left, Colors.green.shade400),
        swInsetBar('Top', sysGesture.top, Colors.green.shade500),
        swInsetBar('Right', sysGesture.right, Colors.green.shade400),
        swInsetBar('Bottom', sysGesture.bottom, Colors.green.shade600),
        SizedBox(height: 6.0),
        Text('On Android gesture navigation, left/right can be 0-44px for back-swipe.', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Display Features
  // ============================================================
  print('=== Section 9: Display Features ===');
  final features = view.displayFeatures;
  print('Display features: ${features.length}');

  Widget swDisplayFeatures = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.devices_fold, color: Colors.purple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('Display Features', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.purple.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Physical display features like folds, hinges, and cutouts on foldable or multi-screen devices.', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(features.isEmpty ? Icons.check_circle : Icons.info, color: features.isEmpty ? Colors.green : Colors.purple, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                features.isEmpty ? 'No display features (standard flat screen)' : '${features.length} feature(s) detected',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text('Types: DisplayFeatureType.fold, .hinge, .cutout', style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.purple.shade600)),
        Text('States: DisplayFeatureState.unknown, .postureFlat, .postureHalfOpened', style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.purple.shade600)),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: PlatformDispatcher
  // ============================================================
  print('=== Section 10: PlatformDispatcher ===');
  print('Dispatcher: ${dispatcher.runtimeType}');

  Widget swDispatcherSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.hub, color: Colors.deepPurple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('PlatformDispatcher', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.deepPurple.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Central dispatch point for platform events to the engine. Replaces the locale/brightness/etc. accessors that used to be on window.', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        swViewInfo('runtimeType', '${dispatcher.runtimeType}', Icons.code, Colors.deepPurple),
        swViewInfo('locale', '${dispatcher.locale}', Icons.language, Colors.deepPurple),
        swViewInfo('views count', '${dispatcher.views.length}', Icons.grid_view, Colors.deepPurple),
        swViewInfo('semanticsEnabled', '${dispatcher.semanticsEnabled}', Icons.accessibility, Colors.deepPurple),
        swViewInfo('brieflyShowPassword', '${dispatcher.brieflyShowPassword}', Icons.visibility, Colors.deepPurple),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Implicit View
  // ============================================================
  print('=== Section 11: Implicit View ===');

  Widget swImplicitView = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.window, color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('Implicit View', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.indigo.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'The implicit view is the default rendering surface. In single-window mode it is the only view. In multi-window mode it may not exist.',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700),
        ),
        SizedBox(height: 10.0),
        if (implicitView != null) ...[
          swViewInfo('exists', 'true', Icons.check, Colors.green),
          swViewInfo('viewId', '${implicitView.viewId}', Icons.tag, Colors.indigo),
          swViewInfo('same as View.of()', '${view.viewId == implicitView.viewId}', Icons.compare, Colors.indigo),
        ] else
          swViewInfo('exists', 'false (multi-window)', Icons.close, Colors.red),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Gesture Settings
  // ============================================================
  print('=== Section 12: Gesture Settings ===');
  print('physicalTouchSlop: ${gestureSettings.physicalTouchSlop}');
  print('physicalDoubleTapSlop: ${gestureSettings.physicalDoubleTapSlop}');

  Widget swGestureSettingsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: Colors.pink.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('Gesture Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.pink.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('Platform-specific touch slop values that determine gesture recognition thresholds.', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        swViewInfo('physicalTouchSlop', '${gestureSettings.physicalTouchSlop ?? "null"}', Icons.straighten, Colors.pink),
        swViewInfo('physicalDoubleTapSlop', '${gestureSettings.physicalDoubleTapSlop ?? "null"}', Icons.double_arrow, Colors.pink),
        SizedBox(height: 6.0),
        Text('Touch slop: minimum pixels a finger must move before a drag is recognized.', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
      ],
    ),
  );

  // ============================================================
  // SECTION 13: MediaQuery Comparison
  // ============================================================
  print('=== Section 13: MediaQuery Comparison ===');

  Widget swMediaQueryRow(String property, String viewApi, String mqApi, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 80.0, child: Text(property, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: accent))),
          Expanded(child: Text(viewApi, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace'))),
          SizedBox(width: 8.0),
          Expanded(child: Text(mqApi, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace'))),
        ],
      ),
    );
  }

  Widget swMediaQuerySection = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.lightGreen.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.lightGreen.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text('View vs MediaQuery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.lightGreen.shade800)),
          ],
        ),
        SizedBox(height: 4.0),
        Text('MediaQuery provides logical units (already divided by DPR). View returns physical pixels.', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(color: Colors.lightGreen.shade100, borderRadius: BorderRadius.circular(4.0)),
          child: Row(
            children: [
              SizedBox(width: 80.0, child: Text('Property', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold))),
              Expanded(child: Text('View (physical)', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold))),
              SizedBox(width: 8.0),
              Expanded(child: Text('MediaQuery (logical)', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        swMediaQueryRow('width', '${physSize.width.toStringAsFixed(0)} px', '${mediaQuery.size.width.toStringAsFixed(0)} dp', Colors.lightGreen),
        swMediaQueryRow('height', '${physSize.height.toStringAsFixed(0)} px', '${mediaQuery.size.height.toStringAsFixed(0)} dp', Colors.lightGreen),
        swMediaQueryRow('top pad', '${vPadding.top.toStringAsFixed(0)} px', '${mediaQuery.padding.top.toStringAsFixed(0)} dp', Colors.lightGreen),
        swMediaQueryRow('bottom pad', '${vPadding.bottom.toStringAsFixed(0)} px', '${mediaQuery.padding.bottom.toStringAsFixed(0)} dp', Colors.lightGreen),
      ],
    ),
  );

  // ============================================================
  // SECTION 14: Class Hierarchy
  // ============================================================
  print('=== Section 14: Class Hierarchy ===');

  Widget swHierarchyLevel(String className, String role, int indent, Color color, bool deprecated) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 20.0, top: 3.0, bottom: 3.0),
      child: Row(
        children: [
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8.0),
          Text(className, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: deprecated ? Colors.grey : color,
            decoration: deprecated ? TextDecoration.lineThrough : null,
          )),
          SizedBox(width: 6.0),
          Text(role, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 15: Summary Dashboard
  // ============================================================
  print('=== Section 15: Summary Dashboard ===');

  Widget swSummaryTile(String label, String value, Color bg, Color text) {
    return Container(
      width: 100.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: text)),
          SizedBox(height: 2.0),
          Text(label, style: TextStyle(fontSize: 9.5, color: text.withValues(alpha: 0.7)), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  print('SingletonFlutterWindow deep demo completed');

  // ============================================================
  // ASSEMBLE FULL UI
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('SingletonFlutterWindow Deep Demo'),
        backgroundColor: Color(0xFF455A64),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            swDeprecationBanner,

            // Section 2: Migration
            SizedBox(height: 20.0),
            Text('2. Migration Guide', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            Text('Replace deprecated window API with modern alternatives:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            ...swMigrations,

            // Section 3: FlutterView
            SizedBox(height: 20.0),
            Text('3. FlutterView Access', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 8.0),
            swViewInfo('runtimeType', '${view.runtimeType}', Icons.code, Color(0xFF546E7A)),
            swViewInfo('is FlutterView', 'true (always)', Icons.check, Color(0xFF546E7A)),
            swViewInfo('viewId', '${view.viewId}', Icons.tag, Color(0xFF546E7A)),

            // Section 4: DPR
            SizedBox(height: 20.0),
            Text('4. Device Pixel Ratio', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swDprSection,

            // Section 5: Size
            SizedBox(height: 20.0),
            Text('5. Physical & Logical Size', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swSizeComparison,

            // Section 6: Insets
            SizedBox(height: 20.0),
            Text('6. View Insets', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swInsetsSection,

            // Section 7: Padding
            SizedBox(height: 20.0),
            Text('7. View Padding', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swPaddingSection,

            // Section 8: Gesture insets
            SizedBox(height: 20.0),
            Text('8. System Gesture Insets', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swGestureSection,

            // Section 9: Display features
            SizedBox(height: 20.0),
            Text('9. Display Features', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swDisplayFeatures,

            // Section 10: Dispatcher
            SizedBox(height: 20.0),
            Text('10. PlatformDispatcher', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swDispatcherSection,

            // Section 11: Implicit view
            SizedBox(height: 20.0),
            Text('11. Implicit View', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swImplicitView,

            // Section 12: Gesture settings
            SizedBox(height: 20.0),
            Text('12. Gesture Settings', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swGestureSettingsSection,

            // Section 13: MediaQuery
            SizedBox(height: 20.0),
            Text('13. View vs MediaQuery', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            swMediaQuerySection,

            // Section 14: Hierarchy
            SizedBox(height: 20.0),
            Text('14. Class Hierarchy', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 4.0),
            Text('How the window types relate in the Flutter engine:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFFECEFF1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  swHierarchyLevel('FlutterView', 'base class for all views', 0, Colors.blue, false),
                  swHierarchyLevel('SingletonFlutterWindow', 'deprecated single-window accessor', 1, Colors.grey, true),
                  swHierarchyLevel('PlatformDispatcher', 'platform events & settings', 0, Colors.deepPurple, false),
                  swHierarchyLevel('View.of(context)', 'modern context-based access', 0, Colors.green, false),
                  swHierarchyLevel('MediaQuery.of(context)', 'logical units wrapper', 0, Colors.orange, false),
                ],
              ),
            ),

            // Section 15: Summary
            SizedBox(height: 20.0),
            Text('15. Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64))),
            SizedBox(height: 8.0),
            Wrap(
              children: [
                swSummaryTile('DPR', '${dpr.toStringAsFixed(1)}x', Color(0xFFECEFF1), Color(0xFF455A64)),
                swSummaryTile('Width', '${logicalWidth.toStringAsFixed(0)}dp', Color(0xFFE3F2FD), Colors.blue.shade700),
                swSummaryTile('Height', '${logicalHeight.toStringAsFixed(0)}dp', Color(0xFFF3E5F5), Colors.purple.shade700),
                swSummaryTile('Views', '${dispatcher.views.length}', Color(0xFFE8F5E9), Colors.green.shade700),
                swSummaryTile('Features', '${features.length}', Color(0xFFFFF3E0), Colors.orange.shade700),
                swSummaryTile('Sections', '15', Color(0xFFFCE4EC), Colors.pink.shade700),
              ],
            ),

            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

/// Visual representation of device pixel ratio for Section 4
class _SwDprVisual extends StatelessWidget {
  final String label;
  final double dpr;
  final double current;

  const _SwDprVisual({required this.label, required this.dpr, required this.current});

  @override
  Widget build(BuildContext context) {
    final isActive = (current - dpr).abs() < 0.5;
    return Container(
      width: 48.0,
      height: 48.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF455A64) : Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: isActive ? Color(0xFF455A64) : Color(0xFFB0BEC5), width: isActive ? 2.0 : 1.0),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: isActive ? Colors.white : Color(0xFF78909C),
          ),
        ),
      ),
    );
  }
}
