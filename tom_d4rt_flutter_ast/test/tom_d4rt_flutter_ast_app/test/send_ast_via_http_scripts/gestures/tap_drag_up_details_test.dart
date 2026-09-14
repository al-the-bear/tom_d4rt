// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TapDragUpDetails from gestures
// Deep Demo: Visual demonstration of TapDragUpDetails properties and lifecycle
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragUpDetails Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D3B66),
          Color(0xFF1B6CA8),
          Color(0xFF2BB3C0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0D3B66).withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Color(0xFF2BB3C0).withValues(alpha: 0.25),
          blurRadius: 26.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.4,
                ),
              ),
              child: Icon(
                Icons.touch_app,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TapDragUpDetails',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Details payload for BaseTapAndDragGestureRecognizer.onTapUp '
            '— fires when a tap-and-drag recognizer releases as a tap '
            '(no qualifying drag movement was produced).',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withValues(alpha: 0.95),
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _pill('immutable', Color(0xFFFFC857)),
            _pill('callback payload', Color(0xFF2BB3C0)),
            _pill('selectables', Color(0xFFE07A5F)),
            _pill('text fields', Color(0xFF8AC6D1)),
          ],
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE3F6FB),
          Color(0xFFEAF7F0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF1B6CA8).withValues(alpha: 0.3), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1B6CA8).withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Color(0xFF0D3B66), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a TapDragUpDetails',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Five required fields packaged at the moment the pointer lifts.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF1B6CA8),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF2BB3C0), width: 1.4),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D3B66), Color(0xFF1B6CA8)],
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app, color: Colors.white, size: 18.0),
                    SizedBox(width: 8.0),
                    Text(
                      'TapDragUpDetails(...)',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.0),
              _anatomyRow(
                'globalPosition',
                'Offset',
                'Pointer position in the global coordinate space.',
                Icons.public,
                Color(0xFF1B6CA8),
              ),
              _anatomyRow(
                'localPosition',
                'Offset',
                'Position relative to the gesture detector.',
                Icons.crop_free,
                Color(0xFF2BB3C0),
              ),
              _anatomyRow(
                'kind',
                'PointerDeviceKind',
                'Which input device produced the tap.',
                Icons.devices_other,
                Color(0xFFE07A5F),
              ),
              _anatomyRow(
                'consecutiveTapCount',
                'int',
                'Number of taps in this rapid sequence.',
                Icons.repeat,
                Color(0xFFFFC857),
              ),
              _anatomyRow(
                'PositionedGestureDetails',
                'mixin',
                'Implemented interface — exposes globalPosition / localPosition.',
                Icons.extension,
                Color(0xFF6F4E7C),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: Six-instance gallery
  // ============================================================
  print('=== Section 3: Six instance gallery ===');

  final galleryInstances = <TapDragUpDetails>[
    TapDragUpDetails(
      globalPosition: Offset(0.0, 0.0),
      localPosition: Offset(0.0, 0.0),
      kind: PointerDeviceKind.touch,
      consecutiveTapCount: 1,
    ),
    TapDragUpDetails(
      globalPosition: Offset(100.0, 200.0),
      localPosition: Offset(50.0, 100.0),
      kind: PointerDeviceKind.mouse,
      consecutiveTapCount: 2,
    ),
    TapDragUpDetails(
      globalPosition: Offset(1024.0, 768.0),
      localPosition: Offset(412.0, 256.0),
      kind: PointerDeviceKind.stylus,
      consecutiveTapCount: 3,
    ),
    TapDragUpDetails(
      globalPosition: Offset(640.0, 480.0),
      localPosition: Offset(200.0, 120.0),
      kind: PointerDeviceKind.trackpad,
      consecutiveTapCount: 4,
    ),
    TapDragUpDetails(
      globalPosition: Offset(320.0, 240.0),
      localPosition: Offset(64.0, 64.0),
      kind: PointerDeviceKind.invertedStylus,
      consecutiveTapCount: 1,
    ),
    TapDragUpDetails(
      globalPosition: Offset(2560.0, 1440.0),
      localPosition: Offset(800.0, 400.0),
      kind: PointerDeviceKind.unknown,
      consecutiveTapCount: 2,
    ),
  ];

  // Per-instance metadata for display only (not part of TapDragUpDetails).
  final galleryNotes = <String>[
    'origin',
    'double-tap',
    'triple-tap',
    'quad-tap',
    'inverted',
    'high-DPI',
  ];

  final galleryColors = <Color>[
    Color(0xFF1B6CA8),
    Color(0xFF2BB3C0),
    Color(0xFFE07A5F),
    Color(0xFFFFC857),
    Color(0xFF6F4E7C),
    Color(0xFF8AC6D1),
  ];

  final galleryCards = <Widget>[];
  for (var i = 0; i < galleryInstances.length; i++) {
    final d = galleryInstances[i];
    final c = galleryColors[i];
    print(
      'Gallery[$i] global=${d.globalPosition} kind=${d.kind} '
      'count=${d.consecutiveTapCount}',
    );
    galleryCards.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [c.withValues(alpha: 0.08), c.withValues(alpha: 0.22)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: c, width: 1.6),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.3),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '#${i + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Instance ${i + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: c,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _kvRow('global', '${d.globalPosition}', c),
            _kvRow('local', '${d.localPosition}', c),
            _kvRow('kind', d.kind.name, c),
            _kvRow('count', '${d.consecutiveTapCount}', c),
            _kvRow('note', galleryNotes[i], c),
            SizedBox(height: 8.0),
            Container(
              height: 4.0,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${galleryCards.length} gallery cards');

  // ============================================================
  // SECTION 4: PointerDeviceKind family
  // ============================================================
  print('=== Section 4: PointerDeviceKind family ===');

  final kindData = <Map<String, dynamic>>[
    {
      'kind': PointerDeviceKind.touch,
      'icon': Icons.touch_app,
      'color': Color(0xFF1B6CA8),
      'desc': 'Finger on a touch-screen.',
    },
    {
      'kind': PointerDeviceKind.mouse,
      'icon': Icons.mouse,
      'color': Color(0xFF2BB3C0),
      'desc': 'Pointing device with buttons.',
    },
    {
      'kind': PointerDeviceKind.stylus,
      'icon': Icons.edit,
      'color': Color(0xFFE07A5F),
      'desc': 'Pen-style input on digitizer.',
    },
    {
      'kind': PointerDeviceKind.trackpad,
      'icon': Icons.touch_app_outlined,
      'color': Color(0xFFFFC857),
      'desc': 'Indirect glass surface.',
    },
    {
      'kind': PointerDeviceKind.invertedStylus,
      'icon': Icons.swap_vert,
      'color': Color(0xFF6F4E7C),
      'desc': 'Stylus held eraser-side down.',
    },
    {
      'kind': PointerDeviceKind.unknown,
      'icon': Icons.help_outline,
      'color': Color(0xFF7E8B92),
      'desc': 'Source could not be classified.',
    },
  ];

  final kindCards = <Widget>[];
  for (final entry in kindData) {
    final kind = entry['kind'] as PointerDeviceKind;
    final color = entry['color'] as Color;
    final probe = TapDragUpDetails(
      globalPosition: Offset(50.0, 50.0),
      localPosition: Offset(10.0, 10.0),
      kind: kind,
      consecutiveTapCount: 1,
    );
    print('PointerDeviceKind.${kind.name} -> tap probe ${probe.kind}');
    kindCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.12), color.withValues(alpha: 0.28)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.6),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(entry['icon'] as IconData, size: 40.0, color: color),
            SizedBox(height: 8.0),
            Text(
              kind.name,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                entry['desc'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: color, height: 1.3),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'index ${kind.index}',
              style: TextStyle(
                fontSize: 9.0,
                color: color.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${kindCards.length} kind cards');

  // ============================================================
  // SECTION 5: consecutiveTapCount visualization
  // ============================================================
  print('=== Section 5: consecutiveTapCount timeline ===');

  final tapCountTimeline = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF6E0), Color(0xFFFFE9C3)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFFFC857), width: 1.6),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFFC857).withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.repeat, size: 22.0, color: Color(0xFFB8860B)),
            SizedBox(width: 8.0),
            Text(
              'consecutiveTapCount Timeline',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B5E00),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Each rapid tap within the recognizer window increments the count.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF8B5E00),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        for (var n = 1; n <= 4; n++)
          _tapCountRow(
            n,
            <String>['single tap', 'double tap', 'triple tap', 'quadruple tap'][n - 1],
            <String>[
              'cursor placement / selection insertion',
              'word selection',
              'paragraph / line selection',
              'select-all-block',
            ][n - 1],
            <Color>[
              Color(0xFF1B6CA8),
              Color(0xFF2BB3C0),
              Color(0xFFE07A5F),
              Color(0xFF6F4E7C),
            ][n - 1],
          ),
      ],
    ),
  );
  print('Created tap count timeline');

  // ============================================================
  // SECTION 6: Real-world mock — text selection scenario
  // ============================================================
  print('=== Section 6: Real-world mock ===');

  final mockDetails = TapDragUpDetails(
    globalPosition: Offset(312.0, 188.0),
    localPosition: Offset(112.0, 28.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 2,
  );
  print(
    'Mock scenario fires onTapUp with consecutiveTapCount=${mockDetails.consecutiveTapCount}',
  );

  final realWorldMock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE6F6F8), Color(0xFFCFEAF0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF2BB3C0), width: 1.6),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF2BB3C0).withValues(alpha: 0.3),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, color: Color(0xFF0D3B66), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Real-world: Text selection',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Shift+double-click on a TextField that uses TapAndPanGestureRecognizer.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF1B6CA8),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF1B6CA8), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F8FB),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color(0xFF8AC6D1), width: 1.0),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Color(0xFF0D3B66),
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'The quick brown '),
                      TextSpan(
                        text: 'fox',
                        style: TextStyle(
                          backgroundColor: Color(0xFFFFC857),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' jumps over the lazy dog.'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Icon(
                    Icons.arrow_drop_up,
                    color: Color(0xFFE07A5F),
                    size: 20.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'pointer up @ ${mockDetails.localPosition}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: Color(0xFFE07A5F),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _overlayLine('details.globalPosition',
                        '${mockDetails.globalPosition}'),
                    _overlayLine('details.localPosition',
                        '${mockDetails.localPosition}'),
                    _overlayLine('details.kind', mockDetails.kind.name),
                    _overlayLine('details.consecutiveTapCount',
                        '${mockDetails.consecutiveTapCount}'),
                    _overlayLine('runtimeType',
                        '${mockDetails.runtimeType}'),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B6CA8), Color(0xFF2BB3C0)],
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'consecutiveTapCount==2 -> select word at localPosition',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created real-world mock');

  // ============================================================
  // SECTION 7: Sibling details comparison table
  // ============================================================
  print('=== Section 7: Sibling comparison table ===');

  final siblingTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF6F1E8), Color(0xFFEFE3D0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE07A5F), width: 1.6),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFE07A5F).withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Color(0xFF8B3A1C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'TapDrag* sibling details',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B3A1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFFE07A5F).withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _siblingHeader('Type', 130.0),
              _siblingHeader('Callback', 120.0),
              _siblingHeader('Has tapCount', 90.0),
              _siblingHeader('Has velocity', 90.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _siblingRow('TapDragDownDetails', 'onTapDown', true, false),
        _siblingRow('TapDragStartDetails', 'onDragStart', true, false),
        _siblingRow('TapDragUpdateDetails', 'onDragUpdate', true, false),
        _siblingRow('TapDragUpDetails', 'onTapUp', true, false, highlight: true),
        _siblingRow('TapDragEndDetails', 'onDragEnd', true, true),
      ],
    ),
  );
  print('Created sibling comparison table');

  // ============================================================
  // SECTION 8: Code block — onTapUp callback signature
  // ============================================================
  print('=== Section 8: Code block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF0D1B2A),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFF2BB3C0), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'onTapUp callback signature',
              style: TextStyle(
                color: Color(0xFF2BB3C0),
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeLine('typedef ', 'GestureTapDragUpCallback', Color(0xFFFFC857), Color(0xFF8AC6D1)),
        _codeLine('  = void Function(', 'TapDragUpDetails details', Color(0xFFE0E0E0), Color(0xFFFFC857)),
        _codeLine(');', '', Color(0xFFE0E0E0), Color(0xFFE0E0E0)),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF1B2A41),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF2BB3C0).withValues(alpha: 0.4), width: 1.0),
          ),
          child: Text(
            'final recognizer = TapAndPanGestureRecognizer()\n'
            '  ..onTapUp = (TapDragUpDetails details) {\n'
            '    // tap (no qualifying drag) released at\n'
            '    //   details.globalPosition\n'
            '    handleTap(\n'
            '      offset: details.localPosition,\n'
            '      taps: details.consecutiveTapCount,\n'
            '      modifiers: details.keysPressedOnDown,\n'
            '    );\n'
            '  };',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFFCDE7F0),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code block');

  // ============================================================
  // SECTION 9: Lifecycle — 5 numbered steps
  // ============================================================
  print('=== Section 9: Lifecycle ===');

  final lifecycle = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F0F8), Color(0xFFD0E5F0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF1B6CA8), width: 1.6),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1B6CA8).withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Color(0xFF0D3B66), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recognizer lifecycle',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'How a tap-and-drag recognizer arrives at TapDragUpDetails.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF1B6CA8),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        _lifecycleStep(1, 'Pointer down',
            'Recognizer accepts arena, fires onTapDown(TapDragDownDetails).',
            Color(0xFF1B6CA8)),
        _lifecycleStep(2, 'Movement evaluated',
            'Recognizer measures slop; below kPanSlop -> still a tap.',
            Color(0xFF2BB3C0)),
        _lifecycleStep(3, 'Optional onDragStart',
            'If slop exceeded, fires onDragStart(TapDragStartDetails) instead.',
            Color(0xFF8AC6D1)),
        _lifecycleStep(4, 'Pointer up',
            'For taps, fires onTapUp(TapDragUpDetails) — this class.',
            Color(0xFFFFC857)),
        _lifecycleStep(5, 'Counter increments',
            'consecutiveTapCount carries across rapid follow-up taps.',
            Color(0xFFE07A5F)),
      ],
    ),
  );
  print('Created lifecycle');

  // ============================================================
  // SECTION 10: Five footgun cards
  // ============================================================
  print('=== Section 10: Footgun cards ===');

  final footguns = <Map<String, dynamic>>[
    {
      'title': 'kind defaults',
      'icon': Icons.help_outline,
      'color': Color(0xFF8B3A1C),
      'body':
          'kind is required and is never null. Treat PointerDeviceKind.unknown as a real value, not as missing data.',
    },
    {
      'title': 'multi-tap timing',
      'icon': Icons.timer,
      'color': Color(0xFFB8860B),
      'body':
          'consecutiveTapCount only grows while taps land within kDoubleTapTimeout and kDoubleTapSlop. A pause resets to 1.',
    },
    {
      'title': 'modifier keys',
      'icon': Icons.keyboard_alt,
      'color': Color(0xFF6F4E7C),
      'body':
          'keysPressedOnDown is captured at down-time and is nullable. Do NOT compare against the keyboard state at up-time.',
    },
    {
      'title': 'tap vs drag',
      'icon': Icons.compare_arrows,
      'color': Color(0xFF1B6CA8),
      'body':
          'TapDragUpDetails fires only when the gesture stayed within slop. Movement past slop emits onDragEnd(TapDragEndDetails) instead.',
    },
    {
      'title': 'global vs local',
      'icon': Icons.crop_free,
      'color': Color(0xFF2BB3C0),
      'body':
          'localPosition is relative to the gesture detector. Use globalPosition when feeding overlays / popups.',
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    final color = fg['color'] as Color;
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(fg['icon'] as IconData, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['body'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF263238),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap card ===');

  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D3B66),
          Color(0xFF1B6CA8),
          Color(0xFF2BB3C0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0D3B66).withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: Color(0xFFFFC857), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recapBullet('Immutable payload for BaseTapAndDragGestureRecognizer.onTapUp.'),
        _recapBullet('Five required fields: global / local / kind / count / keys.'),
        _recapBullet('Distinct from TapDragEndDetails — only emitted when slop was respected.'),
        _recapBullet('consecutiveTapCount drives multi-tap selection rules.'),
        _recapBullet('keysPressedOnDown captures modifiers from the *down* event.'),
      ],
    ),
  );
  print('Created recap card');

  print('TapDragUpDetails Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF4F8FB),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 26.0),
          _sectionHeader('1. Anatomy', Icons.account_tree),
          anatomyDiagram,
          SizedBox(height: 18.0),
          _sectionHeader('2. Six instance gallery', Icons.grid_view),
          Wrap(alignment: WrapAlignment.center, children: galleryCards),
          SizedBox(height: 18.0),
          _sectionHeader('3. PointerDeviceKind family', Icons.devices_other),
          Wrap(alignment: WrapAlignment.center, children: kindCards),
          SizedBox(height: 18.0),
          _sectionHeader('4. consecutiveTapCount timeline', Icons.repeat),
          tapCountTimeline,
          SizedBox(height: 18.0),
          _sectionHeader('5. Real-world: text selection', Icons.text_fields),
          realWorldMock,
          SizedBox(height: 18.0),
          _sectionHeader('6. Sibling details comparison', Icons.compare_arrows),
          siblingTable,
          SizedBox(height: 18.0),
          _sectionHeader('7. Callback signature', Icons.code),
          codeBlock,
          SizedBox(height: 18.0),
          _sectionHeader('8. Recognizer lifecycle', Icons.timeline),
          lifecycle,
          SizedBox(height: 18.0),
          _sectionHeader('9. Footguns', Icons.warning_amber),
          ...footgunCards,
          SizedBox(height: 18.0),
          _sectionHeader('10. Recap', Icons.bookmark),
          recap,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

Widget _pill(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _sectionHeader(String label, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B6CA8), Color(0xFF2BB3C0)],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B66),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(
  String name,
  String type,
  String desc,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF263238),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 10.0,
              color: accent,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tapCountRow(int count, String name, String useCase, Color color) {
  final dots = <Widget>[];
  for (var i = 0; i < count; i++) {
    dots.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
    ),
    child: Row(
      children: [
        Container(
          width: 50.0,
          padding: EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Text(
            '$count',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: dots),
              SizedBox(height: 6.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                useCase,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF455A64),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _overlayLine(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontFamily: 'monospace', fontSize: 11.0),
        children: <TextSpan>[
          TextSpan(
            text: '$key: ',
            style: TextStyle(color: Color(0xFF1B6CA8), fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: Color(0xFF263238)),
          ),
        ],
      ),
    ),
  );
}

Widget _siblingHeader(String label, double width) {
  return SizedBox(
    width: width,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Color(0xFF8B3A1C),
      ),
    ),
  );
}

Widget _siblingRow(
  String type,
  String callback,
  bool hasTapCount,
  bool hasVelocity, {
  bool highlight = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: highlight
          ? Color(0xFFFFC857).withValues(alpha: 0.35)
          : Colors.transparent,
      border: Border(
        bottom: BorderSide(
          color: Color(0xFFE07A5F).withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            type,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? Color(0xFF8B3A1C) : Color(0xFF263238),
            ),
          ),
        ),
        SizedBox(
          width: 120.0,
          child: Text(
            callback,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Icon(
            hasTapCount ? Icons.check_circle : Icons.cancel,
            color: hasTapCount ? Color(0xFF2BB3C0) : Color(0xFFB0BEC5),
            size: 18.0,
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Icon(
            hasVelocity ? Icons.check_circle : Icons.cancel,
            color: hasVelocity ? Color(0xFF2BB3C0) : Color(0xFFB0BEC5),
            size: 18.0,
          ),
        ),
      ],
    ),
  );
}

Widget _codeLine(String prefix, String highlight, Color prefixColor, Color highlightColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontFamily: 'monospace', fontSize: 13.0, height: 1.5),
        children: <TextSpan>[
          TextSpan(text: prefix, style: TextStyle(color: prefixColor)),
          TextSpan(
            text: highlight,
            style: TextStyle(color: highlightColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget _lifecycleStep(int n, String title, String body, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.6)],
            ),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$n',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF263238),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Color(0xFFFFC857), size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
