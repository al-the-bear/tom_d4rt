// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SerialTapUpDetails from gestures
// Deep Demo: Visual demonstration of SerialTapUpDetails — the payload
// delivered to SerialTapGestureRecognizer.onSerialTapUp callbacks. Each entry
// in a serial-tap series carries a globalPosition / localPosition, a
// PointerDeviceKind, and an incrementing count (1, 2, 3, ...) until the
// inter-tap interval expires.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapUpDetails Deep Demo executing');

  // ============================================================
  // Palette — slate / teal / coral
  // ============================================================
  final slate = Color(0xFF334155);
  final slateDeep = Color(0xFF0F172A);
  final slateMid = Color(0xFF475569);
  final slateSoft = Color(0xFFE2E8F0);
  final teal = Color(0xFF0D9488);
  final tealDeep = Color(0xFF134E4A);
  final tealSoft = Color(0xFFCCFBF1);
  final coral = Color(0xFFF87171);
  final coralDeep = Color(0xFF991B1B);
  final coralSoft = Color(0xFFFFE4E6);
  final amber = Color(0xFFF59E0B);
  final amberSoft = Color(0xFFFEF3C7);
  final indigo = Color(0xFF4F46E5);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDeep, slate, teal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.55),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
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
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.30),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.touch_app,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SerialTapUpDetails',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: tealSoft,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.0,
            ),
          ),
          child: Text(
            'Payload for SerialTapGestureRecognizer.onSerialTapUp — fired '
            'after each tap-up in a serial-tap sequence with an incrementing '
            'count (1, 2, 3, ...) until the inter-tap interval expires.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title banner ready');

  // ============================================================
  // SECTION 2: Anatomy — globalPosition / localPosition / kind / count
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyFields = [
    {
      'name': 'globalPosition',
      'type': 'Offset',
      'desc': 'Tap-up location in the global coordinate space.',
      'icon': Icons.public,
      'color': teal,
    },
    {
      'name': 'localPosition',
      'type': 'Offset?',
      'desc': 'Local-coordinate variant; defaults to globalPosition.',
      'icon': Icons.crop_free,
      'color': indigo,
    },
    {
      'name': 'kind',
      'type': 'PointerDeviceKind',
      'desc': 'Input device that produced the tap-up.',
      'icon': Icons.devices_other,
      'color': amber,
    },
    {
      'name': 'count',
      'type': 'int',
      'desc': '1, 2, 3, ... while consecutive taps stay inside the window.',
      'icon': Icons.numbers,
      'color': coral,
    },
  ];

  final anatomyCards = <Widget>[];
  for (final field in anatomyFields) {
    final color = field['color'] as Color;
    anatomyCards.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.10),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    field['icon'] as IconData,
                    color: color,
                    size: 22.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    field['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: slateDeep,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: slateDeep,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                field['type'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: tealSoft,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              field['desc'] as String,
              style: TextStyle(
                fontSize: 12.0,
                color: slateMid,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Anatomy cards built: ${anatomyCards.length}');

  // ============================================================
  // SECTION 3: Six instance gallery — varying globalPosition + count
  // ============================================================
  print('=== Section 3: Instance gallery ===');

  final galleryConfigs = [
    {
      'global': Offset(40.0, 60.0),
      'local': Offset(20.0, 30.0),
      'count': 1,
      'label': 'single',
      'note': 'first tap of a series',
    },
    {
      'global': Offset(120.0, 80.0),
      'local': Offset(60.0, 40.0),
      'count': 2,
      'label': 'double',
      'note': 'word-select threshold',
    },
    {
      'global': Offset(180.0, 140.0),
      'local': Offset(80.0, 70.0),
      'count': 3,
      'label': 'triple',
      'note': 'line-select threshold',
    },
    {
      'global': Offset(240.0, 200.0),
      'local': Offset(120.0, 100.0),
      'count': 4,
      'label': 'quadruple',
      'note': 'paragraph-select',
    },
    {
      'global': Offset(300.0, 260.0),
      'local': Offset(150.0, 130.0),
      'count': 5,
      'label': 'quintuple',
      'note': 'document-select',
    },
    {
      'global': Offset(360.0, 320.0),
      'local': Offset(180.0, 160.0),
      'count': 6,
      'label': 'sextuple',
      'note': 'rare — usually capped',
    },
  ];

  final galleryCards = <Widget>[];
  for (final cfg in galleryConfigs) {
    final count = cfg['count'] as int;
    final accent = count.isOdd ? teal : coral;
    galleryCards.add(
      Container(
        width: 230.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.05),
              accent.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: accent, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.32),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.10),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38.0,
                  height: 38.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.5),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cfg['label'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: slateDeep,
                        ),
                      ),
                      Text(
                        cfg['note'] as String,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: slateMid,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _kvLine('global', '${cfg['global']}', accent),
            _kvLine('local', '${cfg['local']}', accent),
            _kvLine('kind', 'PointerDeviceKind.touch', accent),
            _kvLine('count', '$count', accent),
          ],
        ),
      ),
    );
  }
  print('Gallery cards: ${galleryCards.length}');

  // ============================================================
  // SECTION 4: PointerDeviceKind family
  // ============================================================
  print('=== Section 4: PointerDeviceKind family ===');

  final kindFamily = [
    {
      'name': 'touch',
      'icon': Icons.touch_app,
      'color': teal,
      'desc': 'Finger on a touchscreen — most common click-source.',
    },
    {
      'name': 'mouse',
      'icon': Icons.mouse,
      'color': indigo,
      'desc': 'Mouse buttons; serial-tap powers click/drag selection.',
    },
    {
      'name': 'stylus',
      'icon': Icons.edit,
      'color': amber,
      'desc': 'Active pen; stylus taps may differ from finger taps.',
    },
    {
      'name': 'trackpad',
      'icon': Icons.swipe,
      'color': coral,
      'desc': 'Trackpad gestures; some platforms emit touch instead.',
    },
    {
      'name': 'invertedStylus',
      'icon': Icons.swap_vert,
      'color': Color(0xFF8B5CF6),
      'desc': 'Pen flipped to eraser end — rare but supported.',
    },
    {
      'name': 'unknown',
      'icon': Icons.help_outline,
      'color': slateMid,
      'desc': 'Source not classifiable — fallback for unknown devices.',
    },
  ];

  final kindCards = <Widget>[];
  for (final k in kindFamily) {
    final color = k['color'] as Color;
    kindCards.add(
      Container(
        width: 230.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.28),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.08),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(k['icon'] as IconData, color: color, size: 22.0),
                ),
                SizedBox(width: 10.0),
                Text(
                  'PointerDeviceKind',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: slateMid,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              '.${k['name']}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              k['desc'] as String,
              style: TextStyle(
                fontSize: 11.5,
                color: slateMid,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Kind cards: ${kindCards.length}');

  // ============================================================
  // SECTION 5: Count visualization — timing arrows
  // ============================================================
  print('=== Section 5: Count visualization ===');

  final tapSequenceLabels = [
    'single (count=1)',
    'double (count=2)',
    'triple (count=3)',
    'quadruple (count=4)',
    'quintuple (count=5)',
    'sextuple (count=6)',
  ];

  final timelineRows = <Widget>[];
  for (var i = 0; i < tapSequenceLabels.length; i++) {
    final taps = i + 1;
    final dots = <Widget>[];
    for (var t = 0; t < taps; t++) {
      dots.add(
        Container(
          width: 30.0,
          height: 30.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: t == taps - 1 ? coral : teal,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: (t == taps - 1 ? coral : teal).withValues(alpha: 0.45),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            '${t + 1}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
      );
      if (t < taps - 1) {
        dots.add(
          Container(
            width: 22.0,
            alignment: Alignment.center,
            child: Icon(
              Icons.east,
              color: slateMid,
              size: 16.0,
            ),
          ),
        );
      }
    }

    timelineRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: slateSoft, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.07),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 170.0,
              child: Text(
                tapSequenceLabels[i],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: slateDeep,
                  fontSize: 13.0,
                ),
              ),
            ),
            Expanded(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: dots,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: tealSoft,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'fires $taps×',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: tealDeep,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final countViz = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateSoft, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slateSoft, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.10),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Each tap-up fires onSerialTapUp once. The count column is the '
            'value carried inside SerialTapUpDetails.',
            style: TextStyle(
              color: slateMid,
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        ...timelineRows,
      ],
    ),
  );
  print('Count visualization built');

  // ============================================================
  // SECTION 6: Real-world mock — text editor selection mapping
  // ============================================================
  print('=== Section 6: Real-world mock ===');

  final selectionRows = [
    {
      'count': 1,
      'label': 'caret',
      'sample': 'Place caret here|',
      'desc': 'count=1 → place caret at tap location',
      'color': slateMid,
    },
    {
      'count': 2,
      'label': 'word',
      'sample': 'select [word] here',
      'desc': 'count=2 → select word under tap (double-click)',
      'color': teal,
    },
    {
      'count': 3,
      'label': 'line',
      'sample': '[select the entire line]',
      'desc': 'count=3 → select line (triple-click)',
      'color': indigo,
    },
    {
      'count': 4,
      'label': 'paragraph',
      'sample': '[entire paragraph block here]',
      'desc': 'count=4 → select paragraph (quad-click)',
      'color': amber,
    },
    {
      'count': 5,
      'label': 'document',
      'sample': '[ENTIRE DOCUMENT BODY ]',
      'desc': 'count=5 → select all (quint-click on some platforms)',
      'color': coral,
    },
  ];

  final editorMockRows = <Widget>[];
  for (final s in selectionRows) {
    final color = s['color'] as Color;
    editorMockRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: color, width: 4.0),
            top: BorderSide(color: slateSoft, width: 1.0),
            right: BorderSide(color: slateSoft, width: 1.0),
            bottom: BorderSide(color: slateSoft, width: 1.0),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.10),
              blurRadius: 5.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '×${s['count']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: slateDeep,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      s['sample'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        color: color,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    s['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: slateMid,
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

  final editorMock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDeep, slate],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.40),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.30),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, color: tealSoft, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Text editor — selection mapped from count',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...editorMockRows,
      ],
    ),
  );
  print('Editor mock rows: ${editorMockRows.length}');

  // ============================================================
  // SECTION 7: Sibling details comparison table
  // ============================================================
  print('=== Section 7: Sibling comparison ===');

  final comparisonHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: slateDeep,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    child: Row(
      children: [
        _hCell('field', 130.0),
        _hCell('SerialTapDownDetails', 150.0),
        _hCell('SerialTapUpDetails', 150.0),
        _hCell('SerialTapCancelDetails', 150.0),
      ],
    ),
  );

  final comparisonRowsData = [
    [
      'globalPosition',
      'Offset (down)',
      'Offset (up)',
      '— (no position)',
    ],
    [
      'localPosition',
      'Offset?',
      'Offset?',
      '—',
    ],
    [
      'kind',
      'PointerDeviceKind',
      'PointerDeviceKind',
      '—',
    ],
    [
      'count',
      'int (1, 2, 3, ...)',
      'int (matches down)',
      'int (the cancelled one)',
    ],
    [
      'when fires',
      'pointer-down',
      'pointer-up',
      'sequence aborted',
    ],
    [
      'callback',
      'onSerialTapDown',
      'onSerialTapUp',
      'onSerialTapCancel',
    ],
  ];

  final comparisonBody = <Widget>[];
  for (var i = 0; i < comparisonRowsData.length; i++) {
    final row = comparisonRowsData[i];
    final stripe = i.isOdd ? slateSoft : Colors.white;
    comparisonBody.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(color: stripe),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dCell(row[0], 130.0, slateDeep, bold: true),
            _dCell(row[1], 150.0, slateMid),
            _dCell(row[2], 150.0, tealDeep, bold: true),
            _dCell(row[3], 150.0, coralDeep),
          ],
        ),
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: slateMid, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.12),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        comparisonHeader,
        ...comparisonBody,
      ],
    ),
  );
  print('Comparison table built');

  // ============================================================
  // SECTION 8: Code block — onSerialTapUp callback signature
  // ============================================================
  print('=== Section 8: Code block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: slateDeep,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tealDeep, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.30),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: tealSoft, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'onSerialTapUp — typical wiring',
              style: TextStyle(
                color: tealSoft,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _code(
          'final recognizer = SerialTapGestureRecognizer()',
          tealSoft,
        ),
        _code(
          '  ..onSerialTapDown   = (SerialTapDownDetails d)   {}',
          slateSoft,
        ),
        _code(
          '  ..onSerialTapUp     = (SerialTapUpDetails u) {',
          slateSoft,
        ),
        _code(
          '    print(\'tap #\${u.count} at \${u.globalPosition}\');',
          Color(0xFFFCD34D),
        ),
        _code(
          '    if (u.count == 2) selectWord(u.localPosition);',
          Color(0xFF93C5FD),
        ),
        _code(
          '    if (u.count == 3) selectLine(u.localPosition);',
          Color(0xFF93C5FD),
        ),
        _code(
          '    if (u.count == 4) selectParagraph(u.localPosition);',
          Color(0xFF93C5FD),
        ),
        _code(
          '  }',
          slateSoft,
        ),
        _code(
          '  ..onSerialTapCancel = (SerialTapCancelDetails c) {};',
          slateSoft,
        ),
      ],
    ),
  );
  print('Code block built');

  // ============================================================
  // SECTION 9: Lifecycle — 5 numbered steps
  // ============================================================
  print('=== Section 9: Lifecycle ===');

  final lifecycleSteps = [
    {
      'n': 1,
      'title': 'pointer-down',
      'desc': 'Finger / mouse / stylus presses inside the recognizer area.',
      'icon': Icons.south,
      'color': teal,
    },
    {
      'n': 2,
      'title': 'pointer-up',
      'desc': 'Pointer released without exceeding slop tolerance.',
      'icon': Icons.north,
      'color': teal,
    },
    {
      'n': 3,
      'title': 'fire onSerialTapUp(count=1)',
      'desc': 'Recognizer constructs SerialTapUpDetails with count=1 and '
          'invokes the callback.',
      'icon': Icons.bolt,
      'color': coral,
    },
    {
      'n': 4,
      'title': 'next pointer-down within window',
      'desc': 'Another tap arrives before the inter-tap timeout expires; '
          'count is bumped.',
      'icon': Icons.south,
      'color': indigo,
    },
    {
      'n': 5,
      'title': 'fire onSerialTapUp(count=2)',
      'desc': 'New SerialTapUpDetails fires with count=2 — same series, '
          'same recognizer instance.',
      'icon': Icons.bolt,
      'color': coral,
    },
  ];

  final lifecycleCards = <Widget>[];
  for (final step in lifecycleSteps) {
    final color = step['color'] as Color;
    lifecycleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.22),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.06),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.45),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                '${step['n']}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Icon(
              step['icon'] as IconData,
              color: color,
              size: 24.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: slateDeep,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: slateMid,
                      height: 1.35,
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
  print('Lifecycle steps: ${lifecycleCards.length}');

  // ============================================================
  // SECTION 10: Five footgun cards
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = [
    {
      'title': 'count resets on inter-tap timeout',
      'desc': 'If the gap between taps exceeds the recognizer\'s window, '
          'the next tap starts a new series with count=1.',
      'icon': Icons.timer_off,
      'color': coral,
    },
    {
      'title': 'kind defaults vary',
      'desc': 'Always read details.kind from the SerialTapUpDetails — do '
          'not assume PointerDeviceKind.touch on desktop.',
      'icon': Icons.devices,
      'color': amber,
    },
    {
      'title': 'position drift cancels the series',
      'desc': 'Moving more than the slop tolerance between taps emits '
          'SerialTapCancelDetails instead, ending the streak.',
      'icon': Icons.swipe,
      'color': indigo,
    },
    {
      'title': 'localPosition is nullable on the API',
      'desc': 'The constructor accepts Offset?; if you read it via getter '
          'it falls back to globalPosition. Treat it defensively.',
      'icon': Icons.crop_free,
      'color': teal,
    },
    {
      'title': 'count is 1-based, not 0-based',
      'desc': 'Unlike some legacy APIs, SerialTapUpDetails.count starts at '
          '1. count==2 means "double-tap completed".',
      'icon': Icons.exposure_plus_1,
      'color': Color(0xFF8B5CF6),
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    final color = fg['color'] as Color;
    footgunCards.add(
      Container(
        width: 320.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.08),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                fg['icon'] as IconData,
                color: color,
                size: 24.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: slateDeep,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    fg['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: slateMid,
                      height: 1.35,
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
  print('Footgun cards: ${footgunCards.length}');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapBullets = [
    'Carries globalPosition, optional localPosition, kind, count.',
    'count starts at 1 and increments while taps stay inside the window.',
    'Sister to SerialTapDownDetails (down) and SerialTapCancelDetails (abort).',
    'Powers selectable text: caret / word / line / paragraph / document.',
    'Reach for SerialTapGestureRecognizer when DoubleTap is not enough.',
  ];

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealSoft, amberSoft, coralSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: tealDeep, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: coralDeep.withValues(alpha: 0.20),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: tealDeep, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: tealDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final bullet in recapBullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6.0, right: 10.0),
                  width: 9.0,
                  height: 9.0,
                  decoration: BoxDecoration(
                    color: coral,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: coral.withValues(alpha: 0.5),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    bullet,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: slateDeep,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  print('Recap built');

  print('SerialTapUpDetails Deep Demo completed successfully');

  // ============================================================
  // Layout assembly
  // ============================================================
  return Scaffold(
    backgroundColor: slateSoft,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),

          _sectionHeader('1. Anatomy of SerialTapUpDetails', slateDeep, teal),
          Wrap(alignment: WrapAlignment.center, children: anatomyCards),
          SizedBox(height: 28.0),

          _sectionHeader('2. Six instance gallery (count 1..6)', slateDeep,
              coral),
          Wrap(alignment: WrapAlignment.center, children: galleryCards),
          SizedBox(height: 28.0),

          _sectionHeader('3. PointerDeviceKind family', slateDeep, indigo),
          Wrap(alignment: WrapAlignment.center, children: kindCards),
          SizedBox(height: 28.0),

          _sectionHeader('4. count visualization (timing arrows)', slateDeep,
              teal),
          countViz,
          SizedBox(height: 28.0),

          _sectionHeader('5. Real-world: text editor selection', slateDeep,
              coral),
          editorMock,
          SizedBox(height: 28.0),

          _sectionHeader('6. Sibling details comparison', slateDeep, slateMid),
          comparisonTable,
          SizedBox(height: 28.0),

          _sectionHeader('7. onSerialTapUp callback signature', slateDeep,
              tealDeep),
          codeBlock,
          SizedBox(height: 28.0),

          _sectionHeader('8. Lifecycle — five numbered steps', slateDeep,
              indigo),
          ...lifecycleCards,
          SizedBox(height: 28.0),

          _sectionHeader('9. Footguns', slateDeep, coral),
          Wrap(alignment: WrapAlignment.center, children: footgunCards),
          SizedBox(height: 28.0),

          _sectionHeader('10. Recap', slateDeep, amber),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionHeader(String text, Color textColor, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: accent, width: 5.0),
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 19.0,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    ),
  );
}

Widget _kvLine(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 56.0,
          child: Text(
            '$key:',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF334155),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _hCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFFCCFBF1),
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        fontFamily: 'monospace',
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget _dCell(String text, double width, Color color, {bool bold = false}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontFamily: 'monospace',
        height: 1.35,
      ),
    ),
  );
}

Widget _code(String line, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      line,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        color: color,
        height: 1.45,
      ),
    ),
  );
}
