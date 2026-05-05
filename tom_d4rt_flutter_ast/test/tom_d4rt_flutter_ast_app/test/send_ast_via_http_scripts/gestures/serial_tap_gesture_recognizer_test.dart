// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// =====================================================================
// SerialTapGestureRecognizer — visual deep dive
// ---------------------------------------------------------------------
// A single build() entry point renders an extensive scrollable poster
// describing the SerialTapGestureRecognizer class from the Flutter
// gestures library. The recognizer detects an arbitrary-length sequence
// of taps (single, double, triple, quadruple, ...) by combining the
// kDoubleTapTimeout temporal constraint with the kDoubleTapSlop spatial
// constraint between successive taps.
//
// Palette (Aurora Sequence):
//   - Background ink:        #0E1027
//   - Surface depth:         #161A36
//   - Surface elevated:      #1F254A
//   - Border halo:           #2C3568
//   - Accent magenta:        #E84B9C
//   - Accent indigo:         #5C6BFF
//   - Accent cyan:           #34D2D8
//   - Accent amber:          #F0B458
//   - Accent lime:           #9CE07F
//   - Text primary:          #ECEEFF
//   - Text muted:            #9098C2
//
// Sections:
//   1. Hero header (identity + tagline + capability chips)
//   2. Recognizer probe card (live runtime construction + property dump)
//   3. Anatomy timeline (horizontal axis, taps t1..t6 along kDoubleTapTimeout)
//   4. Count cascade grid (1..6 taps -> editor-style intent feedback)
//   5. Comparison table (Tap vs DoubleTap vs SerialTap)
//   6. Code-card section with RawGestureDetector recipe
//   7. Details type cards (Down/Cancel/Up details fields)
//   8. Interaction map (two pointers / two series stacked)
//   9. Edge cases (slop overflow + timeout overflow)
//  10. Constants reference footer
//
// =====================================================================

dynamic build(BuildContext context) {
  print('SerialTapGestureRecognizer visual demo: build start');

  // -------------------------------------------------------------------
  // PALETTE
  // -------------------------------------------------------------------
  const Color inkBackground = Color(0xFF0E1027);
  const Color surfaceDepth = Color(0xFF161A36);
  const Color surfaceElevated = Color(0xFF1F254A);
  const Color borderHalo = Color(0xFF2C3568);
  const Color accentMagenta = Color(0xFFE84B9C);
  const Color accentIndigo = Color(0xFF5C6BFF);
  const Color accentCyan = Color(0xFF34D2D8);
  const Color accentAmber = Color(0xFFF0B458);
  const Color accentLime = Color(0xFF9CE07F);
  const Color textPrimary = Color(0xFFECEEFF);
  const Color textMuted = Color(0xFF9098C2);

  // -------------------------------------------------------------------
  // RUNTIME PROBE — construct a real recognizer, capture metadata,
  // and gracefully fall back if the bridge throws.
  // -------------------------------------------------------------------
  String probeRuntimeType = 'SerialTapGestureRecognizer';
  String probeDebugDescription = '<unknown>';
  String probeStatusLine = 'Constructed cleanly';
  bool probeOk = true;
  int callbackBitmap = 0;
  String onDownState = 'unset';
  String onUpState = 'unset';
  String onCancelState = 'unset';
  String disposeState = 'pending';
  try {
    final SerialTapGestureRecognizer probe = SerialTapGestureRecognizer(
      debugOwner: 'serial_tap_demo',
    );
    probeRuntimeType = probe.runtimeType.toString();
    probeDebugDescription = 'debugOwner=serial_tap_demo';
    onDownState = probe.onSerialTapDown == null ? 'null' : 'set';
    onUpState = probe.onSerialTapUp == null ? 'null' : 'set';
    onCancelState = probe.onSerialTapCancel == null ? 'null' : 'set';
    probe.onSerialTapDown = (SerialTapDownDetails details) {
      callbackBitmap = callbackBitmap | 0x1;
      print('  probe onSerialTapDown count=${details.count}');
    };
    probe.onSerialTapUp = (SerialTapUpDetails details) {
      callbackBitmap = callbackBitmap | 0x2;
      print('  probe onSerialTapUp count=${details.count}');
    };
    probe.onSerialTapCancel = (SerialTapCancelDetails details) {
      callbackBitmap = callbackBitmap | 0x4;
      print('  probe onSerialTapCancel count=${details.count}');
    };
    onDownState = probe.onSerialTapDown == null ? 'null' : 'set';
    onUpState = probe.onSerialTapUp == null ? 'null' : 'set';
    onCancelState = probe.onSerialTapCancel == null ? 'null' : 'set';
    probe.dispose();
    disposeState = 'disposed';
  } catch (e) {
    probeOk = false;
    probeStatusLine = 'Bridge threw: ${e.runtimeType}';
    print('  probe threw: $e');
  }

  // -------------------------------------------------------------------
  // CONSTANTS — reference these directly so the demo also documents the
  // numbers. These are part of the public Flutter API.
  // -------------------------------------------------------------------
  final Duration timeoutValue = kDoubleTapTimeout;
  final double slopValue = kDoubleTapSlop;
  final Duration minTimeValue = kDoubleTapMinTime;
  final double touchSlopValue = kTouchSlop;

  // ===================================================================
  // SECTION 1 — HERO HEADER
  // ===================================================================
  final Widget heroBadge = Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[accentMagenta, accentIndigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(999),
    ),
    child: const Text(
      'package:flutter/gestures.dart',
      style: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    ),
  );

  final Widget heroTitle = const Text(
    'SerialTapGestureRecognizer',
    style: TextStyle(
      color: textPrimary,
      fontSize: 30,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      height: 1.05,
    ),
  );

  final Widget heroSubtitle = const Text(
    'Recognizes a series of N consecutive taps as a single coherent '
    'gesture, up to an unbounded count, by chaining the timeout and '
    'slop constraints together across the entire sequence.',
    style: TextStyle(
      color: textMuted,
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.w400,
    ),
  );

  final List<Widget> capabilityChips = <Widget>[];
  final List<List<String>> chipData = <List<String>>[
    <String>['N taps', 'unbounded count'],
    <String>['series', 'down/up/cancel'],
    <String>['count', 'monotonic int'],
    <String>['timeout', 'kDoubleTapTimeout'],
    <String>['slop', 'kDoubleTapSlop'],
    <String>['arena', 'cooperative win'],
  ];
  for (int i = 0; i < chipData.length; i = i + 1) {
    final List<String> entry = chipData[i];
    capabilityChips.add(
      Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: surfaceElevated,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderHalo, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              entry[0],
              style: const TextStyle(
                color: accentCyan,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              entry[1],
              style: const TextStyle(
                color: textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget heroChipsRow = Wrap(
    direction: Axis.horizontal,
    children: capabilityChips,
  );

  final Widget heroCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: borderHalo, width: 1),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF161A36),
          Color(0xFF1B1F40),
          Color(0xFF221A3A),
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        heroBadge,
        const SizedBox(height: 16),
        heroTitle,
        const SizedBox(height: 12),
        heroSubtitle,
        const SizedBox(height: 18),
        heroChipsRow,
      ],
    ),
  );

  // ===================================================================
  // SECTION 2 — RUNTIME PROBE CARD
  // ===================================================================
  final Color probeStatusColor = probeOk ? accentLime : accentAmber;
  final List<List<String>> probeRows = <List<String>>[
    <String>['runtimeType', probeRuntimeType],
    <String>['debug', probeDebugDescription],
    <String>['onSerialTapDown', onDownState],
    <String>['onSerialTapUp', onUpState],
    <String>['onSerialTapCancel', onCancelState],
    <String>['callback bitmap', '0x${callbackBitmap.toRadixString(16)}'],
    <String>['dispose', disposeState],
    <String>['status', probeStatusLine],
  ];
  final List<Widget> probeRowWidgets = <Widget>[];
  for (int i = 0; i < probeRows.length; i = i + 1) {
    final List<String> row = probeRows[i];
    final Color valueColor = i == probeRows.length - 1
        ? probeStatusColor
        : textPrimary;
    probeRowWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: Text(
                row[0],
                style: const TextStyle(
                  color: textMuted,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[1],
                style: TextStyle(
                  color: valueColor,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget probeCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: probeStatusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Runtime probe',
              style: TextStyle(
                color: textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              probeOk ? 'OK' : 'FALLBACK',
              style: TextStyle(
                color: probeStatusColor,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'A live SerialTapGestureRecognizer is constructed, configured, '
          'queried, and disposed during build(). Values below are sampled '
          'from that instance.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: inkBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderHalo, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: probeRowWidgets,
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 3 — ANATOMY TIMELINE
  // ===================================================================
  // A horizontal time axis with 6 taps. Each tap is rendered as a
  // labelled circle. Below the axis, gap labels show "<= timeout" and
  // "<= slop" annotations to ground the abstraction.
  final List<List<dynamic>> tapMarkers = <List<dynamic>>[
    <dynamic>[0.05, 'tap 1', accentMagenta, 1],
    <dynamic>[0.20, 'tap 2', accentIndigo, 2],
    <dynamic>[0.36, 'tap 3', accentCyan, 3],
    <dynamic>[0.55, 'tap 4', accentLime, 4],
    <dynamic>[0.74, 'tap 5', accentAmber, 5],
    <dynamic>[0.93, 'tap 6', accentMagenta, 6],
  ];

  final List<Widget> markerWidgets = <Widget>[];
  for (int i = 0; i < tapMarkers.length; i = i + 1) {
    final List<dynamic> marker = tapMarkers[i];
    final double pos = marker[0] as double;
    final String label = marker[1] as String;
    final Color color = marker[2] as Color;
    final int countValue = marker[3] as int;
    markerWidgets.add(
      Positioned(
        left: pos * 600 - 18,
        top: 30,
        child: Column(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                '$countValue',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget timelineAxis = Positioned(
    left: 0,
    right: 0,
    top: 46,
    child: Container(
      height: 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            accentMagenta.withValues(alpha: 0.4),
            accentIndigo.withValues(alpha: 0.4),
            accentCyan.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  final List<Widget> gapLabels = <Widget>[];
  for (int i = 0; i < tapMarkers.length - 1; i = i + 1) {
    final double a = tapMarkers[i][0] as double;
    final double b = tapMarkers[i + 1][0] as double;
    final double mid = (a + b) / 2;
    gapLabels.add(
      Positioned(
        left: mid * 600 - 28,
        top: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: inkBackground,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderHalo, width: 1),
          ),
          child: const Text(
            '<= timeout',
            style: TextStyle(
              color: textMuted,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  final Widget timelineStack = SizedBox(
    width: 600,
    height: 140,
    child: Stack(
      children: <Widget>[
        timelineAxis,
        ...markerWidgets,
        ...gapLabels,
      ],
    ),
  );

  final Widget timelineCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Anatomy of a serial tap',
          style: TextStyle(
            color: textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Six consecutive taps along a single time axis. Each circle is '
          'labelled with its 1-based count value emitted by the recognizer.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: timelineStack,
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 4 — COUNT CASCADE GRID
  // ===================================================================
  final List<List<dynamic>> cascadeEntries = <List<dynamic>>[
    <dynamic>[1, 'select word', 'tap on text', accentMagenta],
    <dynamic>[2, 'select sentence', 'two close taps', accentIndigo],
    <dynamic>[3, 'select paragraph', 'classic IDE triple-tap', accentCyan],
    <dynamic>[4, 'select line', 'less common, IDE-only', accentLime],
    <dynamic>[5, 'select block', 'editor power-user', accentAmber],
    <dynamic>[6, 'select all', 'edge of usefulness', accentMagenta],
  ];

  final List<Widget> cascadeCards = <Widget>[];
  for (int i = 0; i < cascadeEntries.length; i = i + 1) {
    final List<dynamic> entry = cascadeEntries[i];
    final int count = entry[0] as int;
    final String action = entry[1] as String;
    final String hint = entry[2] as String;
    final Color color = entry[3] as Color;
    cascadeCards.add(
      Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12, bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color, width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'x$count',
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'count=$count',
                  style: const TextStyle(
                    color: textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              action,
              style: const TextStyle(
                color: textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              hint,
              style: const TextStyle(
                color: textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget cascadeCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Count cascade',
          style: TextStyle(
            color: textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Editor-style intent for each count value. Only the first three '
          'are platform-conventional; values beyond 4 are usually opt-in.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          direction: Axis.horizontal,
          children: cascadeCards,
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 5 — COMPARISON TABLE
  // ===================================================================
  final List<List<String>> comparisonRows = <List<String>>[
    <String>['', 'Tap', 'DoubleTap', 'SerialTap'],
    <String>['max count', '1', '2', 'unbounded'],
    <String>['count exposed', 'no', 'no', 'yes (int)'],
    <String>['onDown', 'onTapDown', 'onDoubleTapDown', 'onSerialTapDown'],
    <String>['onUp', 'onTapUp', 'onDoubleTap', 'onSerialTapUp'],
    <String>['onCancel', 'onTapCancel', '-', 'onSerialTapCancel'],
    <String>['timeout', 'kPressTimeout', 'kDoubleTapTimeout', 'kDoubleTapTimeout'],
    <String>['slop', 'kTouchSlop', 'kDoubleTapSlop', 'kDoubleTapSlop'],
    <String>['typical use', 'button', 'zoom toggle', 'select word/par'],
    <String>['arena win', 'sweep', 'sweep', 'cooperative'],
    <String>['series resets', '-', '-', 'on timeout/slop'],
  ];

  final List<Widget> tableRowWidgets = <Widget>[];
  for (int r = 0; r < comparisonRows.length; r = r + 1) {
    final List<String> cells = comparisonRows[r];
    final bool isHeader = r == 0;
    final List<Widget> cellWidgets = <Widget>[];
    for (int c = 0; c < cells.length; c = c + 1) {
      final String text = cells[c];
      final Color textColor;
      if (isHeader) {
        textColor = textPrimary;
      } else if (c == 0) {
        textColor = textMuted;
      } else if (c == 3) {
        textColor = accentMagenta;
      } else {
        textColor = textPrimary;
      }
      cellWidgets.add(
        Expanded(
          flex: c == 0 ? 3 : 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 9,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w500,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      );
    }
    tableRowWidgets.add(
      Container(
        decoration: BoxDecoration(
          color: isHeader
              ? surfaceElevated
              : (r.isOdd ? inkBackground : surfaceDepth),
          border: Border(
            bottom: BorderSide(color: borderHalo, width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cellWidgets,
        ),
      ),
    );
  }

  final Widget comparisonCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Tap vs DoubleTap vs SerialTap',
          style: TextStyle(
            color: textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Field-by-field contrast of the three tap-family recognizers in '
          'the gestures library.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderHalo, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: tableRowWidgets,
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 6 — CODE-CARD: RawGestureDetector recipe
  // ===================================================================
  final List<List<String>> codeLines = <List<String>>[
    <String>['kw', 'final'],
    <String>['plain', ' detector = RawGestureDetector('],
    <String>['nl', ''],
    <String>['plain', '  gestures: <Type, GestureRecognizerFactory>{'],
    <String>['nl', ''],
    <String>['plain', '    SerialTapGestureRecognizer:'],
    <String>['nl', ''],
    <String>['plain', '      GestureRecognizerFactoryWithHandlers<'],
    <String>['nl', ''],
    <String>['plain', '          SerialTapGestureRecognizer>('],
    <String>['nl', ''],
    <String>['plain', '        () => SerialTapGestureRecognizer(),'],
    <String>['nl', ''],
    <String>['plain', '        (SerialTapGestureRecognizer instance) {'],
    <String>['nl', ''],
    <String>['plain', '          instance.onSerialTapDown = (d) {'],
    <String>['nl', ''],
    <String>['cmt', '            // d.count is 1, 2, 3, ...'],
    <String>['nl', ''],
    <String>['plain', '            switch (d.count) {'],
    <String>['nl', ''],
    <String>['plain', '              case 1: selectWord(); break;'],
    <String>['nl', ''],
    <String>['plain', '              case 2: selectSentence(); break;'],
    <String>['nl', ''],
    <String>['plain', '              case 3: selectParagraph(); break;'],
    <String>['nl', ''],
    <String>['plain', '            }'],
    <String>['nl', ''],
    <String>['plain', '          };'],
    <String>['nl', ''],
    <String>['plain', '          instance.onSerialTapCancel = (c) {'],
    <String>['nl', ''],
    <String>['plain', '            resetSelectionAt(c.count);'],
    <String>['nl', ''],
    <String>['plain', '          };'],
    <String>['nl', ''],
    <String>['plain', '        },'],
    <String>['nl', ''],
    <String>['plain', '      ),'],
    <String>['nl', ''],
    <String>['plain', '  },'],
    <String>['nl', ''],
    <String>['plain', '  child: yourSelectableSurface,'],
    <String>['nl', ''],
    <String>['plain', ');'],
  ];

  final List<Widget> codeRowWidgets = <Widget>[];
  String currentLine = '';
  Color currentColor = textPrimary;
  for (int i = 0; i < codeLines.length; i = i + 1) {
    final List<String> chunk = codeLines[i];
    final String kind = chunk[0];
    final String text = chunk[1];
    if (kind == 'nl') {
      codeRowWidgets.add(
        Text(
          currentLine,
          style: TextStyle(
            color: currentColor,
            fontFamily: 'monospace',
            fontSize: 12,
            height: 1.5,
          ),
        ),
      );
      currentLine = '';
      currentColor = textPrimary;
    } else {
      if (kind == 'kw') {
        currentColor = accentMagenta;
      } else if (kind == 'cmt') {
        currentColor = textMuted;
      }
      currentLine = currentLine + text;
    }
  }
  if (currentLine.isNotEmpty) {
    codeRowWidgets.add(
      Text(
        currentLine,
        style: TextStyle(
          color: currentColor,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }

  final Widget codeCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text(
              'Recipe',
              style: TextStyle(
                color: textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: accentIndigo.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: accentIndigo, width: 1),
              ),
              child: const Text(
                'RawGestureDetector',
                style: TextStyle(
                  color: accentIndigo,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Wire a SerialTapGestureRecognizer through the factory map. The '
          'second callback receives the freshly-created recognizer for '
          'configuration on every rebuild.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: inkBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderHalo, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: codeRowWidgets,
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 7 — DETAILS TYPE CARDS
  // ===================================================================
  final List<List<dynamic>> detailsTypes = <List<dynamic>>[
    <dynamic>[
      'SerialTapDownDetails',
      accentMagenta,
      'Emitted at the start of each tap in the series.',
      <List<String>>[
        <String>['count', 'int', '1-based tap index in the active series'],
        <String>['globalPosition', 'Offset', 'tap location in global coords'],
        <String>['localPosition', 'Offset', 'tap location in local coords'],
        <String>['kind', 'PointerDeviceKind', 'pointer kind (touch/mouse)'],
        <String>['buttons', 'int', 'pointer button bitmask'],
      ],
    ],
    <dynamic>[
      'SerialTapUpDetails',
      accentIndigo,
      'Emitted when a finger lifts and the series is still alive.',
      <List<String>>[
        <String>['count', 'int', 'count of the finishing tap'],
        <String>['globalPosition', 'Offset', 'release location global'],
        <String>['localPosition', 'Offset', 'release location local'],
        <String>['kind', 'PointerDeviceKind', 'pointer kind'],
      ],
    ],
    <dynamic>[
      'SerialTapCancelDetails',
      accentAmber,
      'Emitted when a candidate tap is rejected by the arena.',
      <List<String>>[
        <String>['count', 'int', 'count of the cancelled tap'],
      ],
    ],
  ];

  final List<Widget> detailsTypeCards = <Widget>[];
  for (int i = 0; i < detailsTypes.length; i = i + 1) {
    final List<dynamic> typeEntry = detailsTypes[i];
    final String typeName = typeEntry[0] as String;
    final Color typeColor = typeEntry[1] as Color;
    final String typeDesc = typeEntry[2] as String;
    final List<List<String>> typeFields =
        typeEntry[3] as List<List<String>>;
    final List<Widget> fieldRows = <Widget>[];
    for (int f = 0; f < typeFields.length; f = f + 1) {
      final List<String> field = typeFields[f];
      fieldRows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 110,
                child: Text(
                  field[0],
                  style: TextStyle(
                    color: typeColor,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: 110,
                child: Text(
                  field[1],
                  style: const TextStyle(
                    color: textMuted,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  field[2],
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    detailsTypeCards.add(
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: typeColor.withValues(alpha: 0.5), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 18,
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  typeName,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              typeDesc,
              style: const TextStyle(
                color: textMuted,
                fontSize: 11,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: inkBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderHalo, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: fieldRows,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget detailsCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Details types',
          style: TextStyle(
            color: textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Three concrete payload classes carry information about each '
          'event in the series. All three expose count.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Column(
          children: detailsTypeCards,
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 8 — INTERACTION MAP
  // ===================================================================
  // A 2D Stack with two pointer trails: pointer A produces a triple-tap
  // series in the upper-left; pointer B produces a double-tap series in
  // the lower-right. Each tap is a small crosshair circle with its
  // count label. This illustrates that the recognizer keys series by
  // pointer, not globally.
  final List<List<dynamic>> pointerATrail = <List<dynamic>>[
    <dynamic>[60.0, 50.0, 1, accentMagenta],
    <dynamic>[68.0, 56.0, 2, accentMagenta],
    <dynamic>[63.0, 60.0, 3, accentMagenta],
  ];
  final List<List<dynamic>> pointerBTrail = <List<dynamic>>[
    <dynamic>[420.0, 200.0, 1, accentCyan],
    <dynamic>[428.0, 208.0, 2, accentCyan],
  ];

  final List<Widget> trailMarkers = <Widget>[];
  for (int i = 0; i < pointerATrail.length; i = i + 1) {
    final List<dynamic> marker = pointerATrail[i];
    final double x = marker[0] as double;
    final double y = marker[1] as double;
    final int count = marker[2] as int;
    final Color color = marker[3] as Color;
    trailMarkers.add(
      Positioned(
        left: x,
        top: y,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.22),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            '$count',
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
  for (int i = 0; i < pointerBTrail.length; i = i + 1) {
    final List<dynamic> marker = pointerBTrail[i];
    final double x = marker[0] as double;
    final double y = marker[1] as double;
    final int count = marker[2] as int;
    final Color color = marker[3] as Color;
    trailMarkers.add(
      Positioned(
        left: x,
        top: y,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.22),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            '$count',
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  final Widget pointerLegendA = Positioned(
    left: 16,
    top: 16,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: surfaceDepth,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accentMagenta, width: 1),
      ),
      child: const Text(
        'pointer A — series 1..3',
        style: TextStyle(
          color: accentMagenta,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  final Widget pointerLegendB = Positioned(
    left: 360,
    top: 168,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: surfaceDepth,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accentCyan, width: 1),
      ),
      child: const Text(
        'pointer B — series 1..2',
        style: TextStyle(
          color: accentCyan,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  final List<Widget> gridLines = <Widget>[];
  for (int i = 0; i < 10; i = i + 1) {
    gridLines.add(
      Positioned(
        left: i * 60.0,
        top: 0,
        bottom: 0,
        child: Container(
          width: 1,
          color: borderHalo.withValues(alpha: 0.4),
        ),
      ),
    );
  }
  for (int i = 0; i < 5; i = i + 1) {
    gridLines.add(
      Positioned(
        top: i * 60.0,
        left: 0,
        right: 0,
        child: Container(
          height: 1,
          color: borderHalo.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  final Widget interactionStack = Container(
    height: 260,
    width: 600,
    decoration: BoxDecoration(
      color: inkBackground,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderHalo, width: 1),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: <Widget>[
        ...gridLines,
        pointerLegendA,
        pointerLegendB,
        ...trailMarkers,
      ],
    ),
  );

  final Widget interactionCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Interaction map',
          style: TextStyle(
            color: textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Two pointers, two independent series. The recognizer maintains '
          'state per pointer; series do not interleave across pointers.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: interactionStack,
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 9 — EDGE CASES
  // ===================================================================
  final List<List<String>> edgeCases = <List<String>>[
    <String>[
      'spatial drift > slop',
      'tap 2 lands far enough from tap 1 that the displacement exceeds '
          'kDoubleTapSlop. The active series is broken; tap 2 starts a '
          'new series with count = 1.',
      'reset',
    ],
    <String>[
      'gap > timeout',
      'tap 2 arrives more than kDoubleTapTimeout after tap 1 lifted. '
          'The active series has expired and tap 2 begins a fresh series '
          'with count = 1.',
      'reset',
    ],
    <String>[
      'gap < min time',
      'tap 2 arrives before kDoubleTapMinTime has elapsed. The candidate '
          'is treated as noise rather than a deliberate second tap.',
      'reject',
    ],
    <String>[
      'concurrent recognizers',
      'A nearby DragGestureRecognizer wins the arena before the up '
          'phase completes. SerialTap reports a cancel for the in-flight '
          'tap, including its current count.',
      'cancel',
    ],
    <String>[
      'rapid count climb',
      'A user mashes the surface 8 times within the timeout window. The '
          'count climbs monotonically: 1, 2, 3, 4, 5, 6, 7, 8 — the '
          'recognizer does not cap.',
      'unbounded',
    ],
    <String>[
      'pointer disappears',
      'The pointer is removed mid-tap (e.g. stylus lifted out of '
          'sensor range). Cancel is dispatched with the current count.',
      'cancel',
    ],
  ];

  final List<Widget> edgeCaseCards = <Widget>[];
  for (int i = 0; i < edgeCases.length; i = i + 1) {
    final List<String> entry = edgeCases[i];
    final String title = entry[0];
    final String body = entry[1];
    final String tag = entry[2];
    final Color tagColor;
    if (tag == 'reset') {
      tagColor = accentAmber;
    } else if (tag == 'reject') {
      tagColor = accentMagenta;
    } else if (tag == 'cancel') {
      tagColor = accentIndigo;
    } else {
      tagColor = accentLime;
    }
    edgeCaseCards.add(
      Container(
        width: 290,
        margin: const EdgeInsets.only(right: 12, bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderHalo, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: tagColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: tagColor, width: 1),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: tagColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: const TextStyle(
                color: textMuted,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget edgeCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Edge cases',
          style: TextStyle(
            color: textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Sequences end (or never start) for several reasons. Each card '
          'names the trigger and the resulting recognizer behaviour.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          direction: Axis.horizontal,
          children: edgeCaseCards,
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 10 — CONSTANTS REFERENCE FOOTER
  // ===================================================================
  final List<List<String>> constantRows = <List<String>>[
    <String>[
      'kDoubleTapTimeout',
      '${timeoutValue.inMilliseconds} ms',
      'Maximum gap between successive taps. Exceeding it ends the series.',
    ],
    <String>[
      'kDoubleTapSlop',
      '${slopValue.toStringAsFixed(1)} px',
      'Maximum spatial drift between successive taps before the series '
          'is broken.',
    ],
    <String>[
      'kDoubleTapMinTime',
      '${minTimeValue.inMilliseconds} ms',
      'Minimum gap between successive taps. Faster than this counts as '
          'noise.',
    ],
    <String>[
      'kTouchSlop',
      '${touchSlopValue.toStringAsFixed(1)} px',
      'Movement threshold within a single tap before it converts into a '
          'drag.',
    ],
  ];

  final List<Widget> constantCards = <Widget>[];
  for (int i = 0; i < constantRows.length; i = i + 1) {
    final List<String> row = constantRows[i];
    constantCards.add(
      Container(
        width: 280,
        margin: const EdgeInsets.only(right: 12, bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: surfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderHalo, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    row[0],
                    style: const TextStyle(
                      color: accentCyan,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  row[1],
                  style: const TextStyle(
                    color: accentLime,
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              row[2],
              style: const TextStyle(
                color: textMuted,
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget footerNote = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    margin: const EdgeInsets.only(top: 8),
    decoration: BoxDecoration(
      color: inkBackground,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: const Text(
      'All values are sampled from the live Flutter constants exported '
      'by package:flutter/gestures.dart. They are platform-tuned and '
      'should not be hard-coded into application logic — depend on the '
      'symbols.',
      style: TextStyle(
        color: textMuted,
        fontSize: 11,
        height: 1.5,
      ),
    ),
  );

  final Widget constantsCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: surfaceDepth,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderHalo, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Reference constants',
          style: TextStyle(
            color: textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'The temporal and spatial constants that govern serial-tap '
          'recognition.',
          style: TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          direction: Axis.horizontal,
          children: constantCards,
        ),
        footerNote,
      ],
    ),
  );

  // ===================================================================
  // ASSEMBLY
  // ===================================================================
  final Widget pageBody = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        heroCard,
        const SizedBox(height: 18),
        probeCard,
        const SizedBox(height: 18),
        timelineCard,
        const SizedBox(height: 18),
        cascadeCard,
        const SizedBox(height: 18),
        comparisonCard,
        const SizedBox(height: 18),
        codeCard,
        const SizedBox(height: 18),
        detailsCard,
        const SizedBox(height: 18),
        interactionCard,
        const SizedBox(height: 18),
        edgeCard,
        const SizedBox(height: 18),
        constantsCard,
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surfaceDepth,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderHalo, width: 1),
          ),
          child: const Text(
            'End of poster — SerialTapGestureRecognizer covered across 10 '
            'visual sections. Use the recognizer through RawGestureDetector '
            'and key your behaviour off the count field of the details '
            'objects.',
            style: TextStyle(
              color: textMuted,
              fontSize: 12,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  print('SerialTapGestureRecognizer visual demo: build complete');

  return Scaffold(
    backgroundColor: inkBackground,
    body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: pageBody,
      ),
    ),
  );
}
