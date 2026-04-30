// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for miscellaneous advanced dart:ui APIs
// Covers: GestureSettings, PointerData, PointerDataPacket, SemanticsUpdate,
// RootIsolateToken, IsolateNameServer, PluginUtilities
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== dart:ui Miscellaneous Advanced APIs Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: GestureSettings
  // ═══════════════════════════════════════════════════════════════════════════

  final settings1 = ui.GestureSettings(
    physicalTouchSlop: 18.0,
    physicalDoubleTapSlop: 36.0,
  );
  final settings2 = ui.GestureSettings(
    physicalTouchSlop: 18.0,
    physicalDoubleTapSlop: 36.0,
  );
  final settings3 = ui.GestureSettings();

  print('GestureSettings1: $settings1');
  print('  physicalTouchSlop: ${settings1.physicalTouchSlop}');
  print('  physicalDoubleTapSlop: ${settings1.physicalDoubleTapSlop}');
  print('GestureSettings3 (default): $settings3');
  print('  physicalTouchSlop: ${settings3.physicalTouchSlop}');
  print('settings1 == settings2: ${settings1 == settings2}');
  print('settings1 == settings3: ${settings1 == settings3}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: RootIsolateToken
  // ═══════════════════════════════════════════════════════════════════════════

  final rootToken = ui.RootIsolateToken.instance;
  print('RootIsolateToken.instance: $rootToken');
  print('  runtimeType: ${rootToken?.runtimeType}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: IsolateNameServer
  // ═══════════════════════════════════════════════════════════════════════════

  // IsolateNameServer allows port-based cross-isolate communication
  print('IsolateNameServer type: ${ui.IsolateNameServer}');
  print('  lookupPortByName(name) → SendPort?');
  print('  registerPortWithName(port, name) → bool');
  print('  removePortNameMapping(name) → bool');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: PluginUtilities
  // ═══════════════════════════════════════════════════════════════════════════

  print('PluginUtilities type: ${ui.PluginUtilities}');
  print('  getCallbackHandle(callback) → CallbackHandle?');
  print('  getCallbackFromHandle(handle) → Function?');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: PointerData
  // ═══════════════════════════════════════════════════════════════════════════

  final pointer = ui.PointerData(
    embedderId: 0,
    timeStamp: Duration(milliseconds: 100),
    change: ui.PointerChange.down,
    kind: ui.PointerDeviceKind.touch,
    device: 1,
    physicalX: 100.0,
    physicalY: 200.0,
    pressure: 1.0,
    pressureMax: 1.0,
  );
  print('PointerData: $pointer');
  print('  change: ${pointer.change}');
  print('  kind: ${pointer.kind}');
  print('  physicalX: ${pointer.physicalX}, physicalY: ${pointer.physicalY}');
  print('  pressure: ${pointer.pressure}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: PointerDataPacket
  // ═══════════════════════════════════════════════════════════════════════════

  final packet = ui.PointerDataPacket(data: [pointer]);
  print('PointerDataPacket: ${packet.data.length} events');

  print('Miscellaneous advanced demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF004D40), Color(0xFF26A69A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.miscellaneous_services,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Miscellaneous Advanced APIs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'GestureSettings, PointerData, Isolate & Plugin utilities',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: GestureSettings ──
              _sectionTitle('1. GESTURE SETTINGS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _settingsComparison(
                      'physicalTouchSlop',
                      settings1.physicalTouchSlop?.toString() ?? 'null',
                      settings3.physicalTouchSlop?.toString() ?? 'null',
                      Color(0xFF004D40),
                    ),
                    SizedBox(height: 10),
                    _settingsComparison(
                      'physicalDoubleTapSlop',
                      settings1.physicalDoubleTapSlop?.toString() ?? 'null',
                      settings3.physicalDoubleTapSlop?.toString() ?? 'null',
                      Color(0xFF1565C0),
                    ),
                    SizedBox(height: 16),
                    _equalityRow('settings1 == settings2 (same values)', true),
                    _equalityRow('settings1 == settings3 (different)', false),
                    SizedBox(height: 12),
                    _touchSlopVisual(settings1.physicalTouchSlop ?? 18.0),
                  ],
                ),
              ),

              // ── Section 2: PointerData ──
              _sectionTitle('2. POINTER DATA'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _dataField(
                      'change',
                      '${pointer.change}',
                      Color(0xFFBF360C),
                    ),
                    _dataField('kind', '${pointer.kind}', Color(0xFF1565C0)),
                    _dataField(
                      'device',
                      '${pointer.device}',
                      Color(0xFF2E7D32),
                    ),
                    _dataField(
                      'physicalX',
                      '${pointer.physicalX}',
                      Color(0xFF6A1B9A),
                    ),
                    _dataField(
                      'physicalY',
                      '${pointer.physicalY}',
                      Color(0xFF6A1B9A),
                    ),
                    _dataField(
                      'pressure',
                      '${pointer.pressure}',
                      Color(0xFFE65100),
                    ),
                    _dataField(
                      'timeStamp',
                      '${pointer.timeStamp}',
                      Color(0xFF455A64),
                    ),
                    SizedBox(height: 16),
                    _pointerPositionVisual(
                      pointer.physicalX,
                      pointer.physicalY,
                    ),
                  ],
                ),
              ),

              // ── Section 3: PointerDataPacket ──
              _sectionTitle('3. POINTER DATA PACKET'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.touch_app,
                          color: Color(0xFF004D40),
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${packet.data.length} event(s) in packet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ...packet.data.asMap().entries.map((e) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color(0xFF004D40),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${e.key}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${e.value.change} at (${e.value.physicalX}, ${e.value.physicalY})',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // ── Section 4: RootIsolateToken ──
              _sectionTitle('4. ROOT ISOLATE TOKEN'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF6A1B9A).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.key,
                            color: Color(0xFF6A1B9A),
                            size: 22,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RootIsolateToken',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Available: ${rootToken != null ? "Yes" : "No"}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    _infoBox(
                      'Used to pass to background isolates via '
                      'BackgroundIsolateBinaryMessenger.ensureInitialized(token)',
                      Color(0xFF6A1B9A),
                    ),
                  ],
                ),
              ),

              // ── Section 5: IsolateNameServer ──
              _sectionTitle('5. ISOLATE NAME SERVER'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _apiMethod(
                      'lookupPortByName(name)',
                      'SendPort?',
                      'Find a named port across isolates',
                      Color(0xFF1565C0),
                    ),
                    _apiMethod(
                      'registerPortWithName(port, name)',
                      'bool',
                      'Register a SendPort with a name',
                      Color(0xFF2E7D32),
                    ),
                    _apiMethod(
                      'removePortNameMapping(name)',
                      'bool',
                      'Remove a named port mapping',
                      Color(0xFFC62828),
                    ),
                    SizedBox(height: 12),
                    _flowDiagram(),
                  ],
                ),
              ),

              // ── Section 6: PluginUtilities ──
              _sectionTitle('6. PLUGIN UTILITIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _apiMethod(
                      'getCallbackHandle(callback)',
                      'CallbackHandle?',
                      'Serialize a top-level function to a handle',
                      Color(0xFFBF360C),
                    ),
                    _apiMethod(
                      'getCallbackFromHandle(handle)',
                      'Function?',
                      'Deserialize a handle back to a function',
                      Color(0xFF004D40),
                    ),
                    SizedBox(height: 12),
                    _infoBox(
                      'Used for background execution: serialize a callback, '
                      'pass handle to native code, native invokes via handle.',
                      Color(0xFFBF360C),
                    ),
                  ],
                ),
              ),

              // ── Section 7: API Map ──
              _sectionTitle('7. API RELATIONSHIP MAP'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _mapNode(
                      'PlatformDispatcher',
                      'Central hub for platform events',
                      Color(0xFF263238),
                    ),
                    _mapConnector(),
                    Row(
                      children: [
                        Expanded(
                          child: _mapLeaf('GestureSettings', Color(0xFF004D40)),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _mapLeaf('PointerData', Color(0xFFBF360C)),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _mapLeaf(
                            'AccessibilityFeatures',
                            Color(0xFF6A1B9A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _mapNode(
                      'Cross-Isolate Communication',
                      'Background work support',
                      Color(0xFF455A64),
                    ),
                    _mapConnector(),
                    Row(
                      children: [
                        Expanded(
                          child: _mapLeaf(
                            'IsolateNameServer',
                            Color(0xFF1565C0),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _mapLeaf(
                            'RootIsolateToken',
                            Color(0xFF2E7D32),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _mapLeaf('PluginUtilities', Color(0xFFE65100)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _settingsComparison(
  String prop,
  String custom,
  String defVal,
  Color color,
) {
  return Row(
    children: [
      SizedBox(
        width: 140,
        child: Text(
          prop,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          custom,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 8),
      Text('vs', style: TextStyle(fontSize: 10, color: Colors.grey)),
      SizedBox(width: 8),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          defVal,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ),
    ],
  );
}

Widget _equalityRow(String expression, bool result) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Expanded(
          child: Text(
            expression,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            result ? 'true' : 'false',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _touchSlopVisual(double slop) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: slop * 4,
          height: slop * 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF004D40).withValues(alpha: 0.1),
            border: Border.all(color: Color(0xFF004D40).withValues(alpha: 0.4)),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Color(0xFF004D40),
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          bottom: 4,
          child: Text(
            'Touch slop = ${slop}px',
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _dataField(String name, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(
            name,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color),
        ),
      ],
    ),
  );
}

Widget _pointerPositionVisual(double x, double y) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Stack(
      children: [
        Positioned(
          left: (x / 3).clamp(0, 280),
          top: (y / 3).clamp(0, 70),
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFFBF360C),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFBF360C).withValues(alpha: 0.4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 4,
          child: Text(
            '(${x.toInt()}, ${y.toInt()})',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _infoBox(String text, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Text(text, style: TextStyle(fontSize: 11, color: color)),
  );
}

Widget _apiMethod(String name, String returns, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' → $returns',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                ],
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowDiagram() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _flowBox('Isolate A\nregisterPort', Color(0xFF1565C0)),
        Icon(Icons.arrow_forward, color: Colors.grey, size: 18),
        _flowBox('Name Server\n(shared)', Color(0xFF455A64)),
        Icon(Icons.arrow_forward, color: Colors.grey, size: 18),
        _flowBox('Isolate B\nlookupPort', Color(0xFF2E7D32)),
      ],
    ),
  );
}

Widget _flowBox(String text, Color color) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _mapNode(String title, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _mapConnector() {
  return Container(height: 16, width: 2, color: Colors.grey[300]);
}

Widget _mapLeaf(String title, Color color) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color),
    ),
  );
}
