// ignore_for_file: avoid_print
// D4rt test script: Deep visual demo of SelectionRect from package:flutter/services.dart
// SelectionRect is dispatched as a list via TextInput.setSelectionRects to inform
// the IME / Autofill stack which screen rectangles correspond to which character
// positions inside an editable text field. The platform uses these rectangles for
// magnifier positioning, voice-control word highlighting, autofill UI alignment,
// and selection-handle rendering. Each SelectionRect carries:
//   bounds:    Rect in screen coordinates (typically global pixels) of one run/char
//   position:  the text offset (UTF-16 code unit index) of that run's first character
//   direction: TextDirection of the run (LTR or RTL) — affects caret affinity and
//              the visual order in which the rects must be sorted before dispatch.
//
// Visual palette: slate / cyan / amber.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('SelectionRect Deep Demo executing');

  // ============================================================
  // PALETTE — slate / cyan / amber
  // ============================================================
  const slateDeep = Color(0xFF1E293B);
  const slateMid = Color(0xFF334155);
  const slateSoft = Color(0xFF64748B);
  const slatePale = Color(0xFFE2E8F0);
  const slateMist = Color(0xFFF1F5F9);
  const cyanDeep = Color(0xFF0E7490);
  const cyanMid = Color(0xFF06B6D4);
  const cyanSoft = Color(0xFF67E8F9);
  const cyanPale = Color(0xFFCFFAFE);
  const amberDeep = Color(0xFFB45309);
  const amberMid = Color(0xFFF59E0B);
  const amberSoft = Color(0xFFFCD34D);
  const amberPale = Color(0xFFFEF3C7);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDeep, slateMid, cyanDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: cyanMid.withValues(alpha: 0.25),
          blurRadius: 36.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 84.0,
          height: 84.0,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [cyanSoft, cyanMid, cyanDeep],
              radius: 0.85,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: cyanMid.withValues(alpha: 0.55),
                blurRadius: 16.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Icon(
            Icons.crop_free,
            size: 44.0,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SelectionRect',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'package:flutter/services.dart',
                style: TextStyle(
                  fontSize: 13.0,
                  color: cyanSoft,
                  fontFamily: 'monospace',
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Per-character screen rectangles dispatched to the IME so that the '
                'platform can position magnifiers, autofill chips, voice-control '
                'word highlights, and selection handles correctly.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: slatePale,
                  height: 1.45,
                ),
              ),
              SizedBox(height: 12.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 6.0,
                children: [
                  _chip('bounds: Rect', cyanMid, Colors.white),
                  _chip('position: int', amberMid, Colors.white),
                  _chip('direction: TextDirection', slateSoft, Colors.white),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram — labelled fields
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateMist, cyanPale],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: cyanMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanMid.withValues(alpha: 0.18),
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
            Icon(Icons.architecture, color: slateDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a SelectionRect',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: slateDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        // The diagram: a fake glyph rect with three labels pointing to the fields
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: slatePale, width: 1.0),
          ),
          child: Stack(
            children: [
              // bounds rectangle
              Positioned(
                left: 200.0,
                top: 70.0,
                child: Container(
                  width: 70.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: cyanMid.withValues(alpha: 0.18),
                    border: Border.all(color: cyanDeep, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 56.0,
                        fontWeight: FontWeight.bold,
                        color: slateDeep,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
              // label: bounds
              Positioned(
                left: 16.0,
                top: 82.0,
                child: _anatomyLabel(
                  'bounds: Rect',
                  'fromLTWH(200, 70, 70, 90)',
                  cyanDeep,
                  Icons.crop_din,
                ),
              ),
              Positioned(
                left: 158.0,
                top: 95.0,
                child: Container(
                  width: 42.0,
                  height: 1.5,
                  color: cyanDeep,
                ),
              ),
              // label: position
              Positioned(
                left: 290.0,
                top: 24.0,
                child: _anatomyLabel(
                  'position: 5',
                  'text offset (UTF-16)',
                  amberDeep,
                  Icons.tag,
                ),
              ),
              Positioned(
                left: 270.0,
                top: 70.0,
                child: Container(
                  width: 1.5,
                  height: 14.0,
                  color: amberDeep,
                ),
              ),
              // label: direction
              Positioned(
                left: 290.0,
                top: 140.0,
                child: _anatomyLabel(
                  'direction: ltr',
                  'visual run direction',
                  slateMid,
                  Icons.arrow_forward,
                ),
              ),
              Positioned(
                left: 270.0,
                top: 150.0,
                child: Container(
                  width: 22.0,
                  height: 1.5,
                  color: slateMid,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: slateDeep,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            "SelectionRect(\n"
            "  bounds: Rect.fromLTWH(200, 70, 70, 90),\n"
            "  position: 5,\n"
            "  direction: TextDirection.ltr,\n"
            ")",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: cyanSoft,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Six instance cards — real SelectionRect objects
  // ============================================================
  print('=== Section 3: Six Instance Cards ===');

  // Build six real SelectionRect instances representing different scenarios.
  final asciiStart = SelectionRect(
    bounds: Rect.fromLTWH(12.0, 100.0, 14.0, 22.0),
    position: 0,
    direction: TextDirection.ltr,
  );
  final midWord = SelectionRect(
    bounds: Rect.fromLTWH(82.0, 100.0, 14.0, 22.0),
    position: 5,
    direction: TextDirection.ltr,
  );
  final lineEnd = SelectionRect(
    bounds: Rect.fromLTWH(180.0, 100.0, 12.0, 22.0),
    position: 12,
    direction: TextDirection.ltr,
  );
  final rtlStart = SelectionRect(
    bounds: Rect.fromLTWH(220.0, 140.0, 18.0, 24.0),
    position: 0,
    direction: TextDirection.rtl,
  );
  final rtlMid = SelectionRect(
    bounds: Rect.fromLTWH(170.0, 140.0, 18.0, 24.0),
    position: 3,
    direction: TextDirection.rtl,
  );
  final mixedScript = SelectionRect(
    bounds: Rect.fromLTWH(300.0, 180.0, 16.0, 22.0),
    position: 7,
    direction: TextDirection.ltr,
  );

  print('Instance 1: ${asciiStart.position} -> ${asciiStart.bounds}');
  print('Instance 2: ${midWord.position} -> ${midWord.bounds}');
  print('Instance 3: ${lineEnd.position} -> ${lineEnd.bounds}');
  print('Instance 4 (RTL): ${rtlStart.position} -> ${rtlStart.bounds}');
  print('Instance 5 (RTL): ${rtlMid.position} -> ${rtlMid.bounds}');
  print('Instance 6 (mixed): ${mixedScript.position} -> ${mixedScript.bounds}');

  final instanceData = <Map<String, dynamic>>[
    {
      'rect': asciiStart,
      'title': 'ASCII char @ offset 0',
      'glyph': 'H',
      'caption': 'Start of an English word (LTR), origin column.',
      'accent': cyanDeep,
      'tint': cyanPale,
    },
    {
      'rect': midWord,
      'title': 'Mid-word char @ offset 5',
      'glyph': 'l',
      'caption': 'Interior glyph of a longer LTR run (e.g. "Hello").',
      'accent': cyanMid,
      'tint': slateMist,
    },
    {
      'rect': lineEnd,
      'title': 'End-of-line @ offset 12',
      'glyph': '!',
      'caption': 'Last visible character before the soft line break.',
      'accent': amberDeep,
      'tint': amberPale,
    },
    {
      'rect': rtlStart,
      'title': 'RTL char @ offset 0',
      'glyph': 'ا',
      'caption': 'Arabic alif — visually right-most despite logical offset 0.',
      'accent': slateMid,
      'tint': slatePale,
    },
    {
      'rect': rtlMid,
      'title': 'RTL mid-line @ offset 3',
      'glyph': 'ب',
      'caption': 'RTL run, leftward visual progression as offset grows.',
      'accent': slateDeep,
      'tint': slateMist,
    },
    {
      'rect': mixedScript,
      'title': 'Mixed script @ offset 7',
      'glyph': 'あ',
      'caption': 'CJK glyph embedded in an LTR paragraph; wider bounds.',
      'accent': amberMid,
      'tint': amberPale,
    },
  ];

  final instanceCards = <Widget>[];
  for (var i = 0; i < instanceData.length; i++) {
    final entry = instanceData[i];
    final rect = entry['rect'] as SelectionRect;
    final accent = entry['accent'] as Color;
    final tint = entry['tint'] as Color;
    instanceCards.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, tint],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: accent, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.22),
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
                    color: accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    '#${i + 1}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    entry['title'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: slateDeep,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Center(
              child: Container(
                width: 78.0,
                height: 90.0,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.10),
                  border: Border.all(color: accent, width: 2.0),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Text(
                    entry['glyph'] as String,
                    style: TextStyle(
                      fontSize: 44.0,
                      fontWeight: FontWeight.bold,
                      color: slateDeep,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            _kv('position', rect.position.toString(), amberDeep),
            _kv('direction', rect.direction.name, slateMid),
            _kv(
              'bounds',
              'L${rect.bounds.left.toStringAsFixed(0)} '
                  'T${rect.bounds.top.toStringAsFixed(0)} '
                  'W${rect.bounds.width.toStringAsFixed(0)} '
                  'H${rect.bounds.height.toStringAsFixed(0)}',
              cyanDeep,
            ),
            SizedBox(height: 8.0),
            Text(
              entry['caption'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: slateSoft,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${instanceCards.length} instance cards');

  // ============================================================
  // SECTION 4: Visual layout — six adjacent character rects
  // ============================================================
  print('=== Section 4: Visual Layout ===');

  // Six adjacent SelectionRects forming the word "Hello!"
  final wordRects = <SelectionRect>[
    SelectionRect(
      bounds: Rect.fromLTWH(0.0, 0.0, 28.0, 44.0),
      position: 0,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(28.0, 0.0, 26.0, 44.0),
      position: 1,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(54.0, 0.0, 18.0, 44.0),
      position: 2,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(72.0, 0.0, 18.0, 44.0),
      position: 3,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(90.0, 0.0, 26.0, 44.0),
      position: 4,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(116.0, 0.0, 14.0, 44.0),
      position: 5,
      direction: TextDirection.ltr,
    ),
  ];
  const wordGlyphs = ['H', 'e', 'l', 'l', 'o', '!'];

  final visualLayout = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateMist, slatePale],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slateSoft, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.10),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Six adjacent SelectionRects → "Hello!"',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: slateDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each glyph contributes one SelectionRect; bounds are screen-space.',
          style: TextStyle(fontSize: 11.0, color: slateSoft),
        ),
        SizedBox(height: 18.0),
        Center(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: cyanMid, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < wordRects.length; i++)
                  _glyphWithRect(
                    wordRects[i],
                    wordGlyphs[i],
                    cyanDeep,
                    cyanMid,
                    amberDeep,
                    slateDeep,
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: slateDeep,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final r in wordRects)
                Text(
                  'SelectionRect(position: ${r.position}, '
                  'bounds: ${_rectShort(r.bounds)}, '
                  'direction: ${r.direction.name})',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: cyanSoft,
                    height: 1.5,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: LTR vs RTL pair
  // ============================================================
  print('=== Section 5: LTR vs RTL ===');

  // Same offsets, two directionalities — render rects as Row children inside
  // Directionality wrappers to show how the visual order reverses.
  final pairRects = <SelectionRect>[
    SelectionRect(
      bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 44.0),
      position: 0,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(30.0, 0.0, 30.0, 44.0),
      position: 1,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(60.0, 0.0, 30.0, 44.0),
      position: 2,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(90.0, 0.0, 30.0, 44.0),
      position: 3,
      direction: TextDirection.ltr,
    ),
  ];

  final ltrRtlPair = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cyanPale, amberPale],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amberMid.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Same positions, different Directionality',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: slateDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A list of SelectionRects must be sorted in *visual* order before the '
          'IME consumes them — RTL flips that order on screen.',
          style: TextStyle(fontSize: 11.0, color: slateSoft, height: 1.4),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _directionalityPanel(
              'TextDirection.ltr',
              TextDirection.ltr,
              pairRects,
              cyanDeep,
              cyanMid,
              slateDeep,
            ),
            _directionalityPanel(
              'TextDirection.rtl',
              TextDirection.rtl,
              pairRects,
              amberDeep,
              amberMid,
              slateDeep,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: IME integration code block
  // ============================================================
  print('=== Section 6: IME Integration Code ===');

  // Real SelectionRect instances feeding a fake setSelectionRects payload.
  final imePayload = <SelectionRect>[
    SelectionRect(
      bounds: Rect.fromLTWH(120.0, 220.0, 14.0, 22.0),
      position: 0,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(134.0, 220.0, 14.0, 22.0),
      position: 1,
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      bounds: Rect.fromLTWH(148.0, 220.0, 14.0, 22.0),
      position: 2,
      direction: TextDirection.ltr,
    ),
  ];
  print('IME payload size: ${imePayload.length}');
  for (final r in imePayload) {
    print('  -> position=${r.position} bounds=${_rectShort(r.bounds)}');
  }

  final imeCodeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0F172A), slateDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // pseudo terminal title bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFF1E293B),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: [
              _dot(Color(0xFFEF4444)),
              SizedBox(width: 6.0),
              _dot(Color(0xFFF59E0B)),
              SizedBox(width: 6.0),
              _dot(Color(0xFF22C55E)),
              SizedBox(width: 12.0),
              Text(
                'TextInput.setSelectionRects',
                style: TextStyle(
                  color: cyanSoft,
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "// Inside an EditableText / TextInputClient implementation:\n"
            "final List<SelectionRect> rects = <SelectionRect>[\n"
            "  SelectionRect(\n"
            "    bounds: Rect.fromLTWH(120, 220, 14, 22),\n"
            "    position: 0,\n"
            "    direction: TextDirection.ltr,\n"
            "  ),\n"
            "  SelectionRect(\n"
            "    bounds: Rect.fromLTWH(134, 220, 14, 22),\n"
            "    position: 1,\n"
            "    direction: TextDirection.ltr,\n"
            "  ),\n"
            "  SelectionRect(\n"
            "    bounds: Rect.fromLTWH(148, 220, 14, 22),\n"
            "    position: 2,\n"
            "    direction: TextDirection.ltr,\n"
            "  ),\n"
            "];\n"
            "\n"
            "TextInput.setSelectionRects(rects);\n"
            "// → IME / Autofill / voice-control now know which screen pixels\n"
            "//   correspond to each character offset.",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: cyanSoft,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Comparison vs TextSelection / Rect / TextRange
  // ============================================================
  print('=== Section 7: Comparison Table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slatePale, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.10),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SelectionRect vs related types',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: slateDeep,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: slateDeep,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _hdrCell('Type', 130.0, Colors.white),
              _hdrCell('Geometry', 110.0, cyanSoft),
              _hdrCell('Logical span', 110.0, amberSoft),
              _hdrCell('Direction', 90.0, Colors.white),
              _hdrCell('Used by', 130.0, Colors.white),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        _tableRow(
          'SelectionRect',
          'Rect (screen)',
          'one offset (int)',
          'yes',
          'IME / Autofill',
          cyanDeep,
        ),
        _tableRow(
          'TextSelection',
          '—',
          'baseOffset → extentOffset',
          'affinity',
          'caret/selection state',
          amberDeep,
        ),
        _tableRow(
          'Rect',
          'left, top, w, h',
          '—',
          'no',
          'painting / hit testing',
          slateMid,
        ),
        _tableRow(
          'TextRange',
          '—',
          'start → end (int range)',
          'no',
          'composing / range slicing',
          slateSoft,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Real-world mock — magnifier, voice highlight, handle
  // ============================================================
  print('=== Section 8: Real-world Mock ===');

  // SelectionRects driving a fake UI moment.
  final hoveredChar = SelectionRect(
    bounds: Rect.fromLTWH(140.0, 60.0, 22.0, 36.0),
    position: 4,
    direction: TextDirection.ltr,
  );
  final voiceHighlight = SelectionRect(
    bounds: Rect.fromLTWH(60.0, 60.0, 78.0, 36.0),
    position: 0,
    direction: TextDirection.ltr,
  );
  final handleAnchor = SelectionRect(
    bounds: Rect.fromLTWH(160.0, 60.0, 4.0, 36.0),
    position: 5,
    direction: TextDirection.ltr,
  );
  print('Magnifier centred on bounds: ${_rectShort(hoveredChar.bounds)}');
  print('Voice highlight bounds: ${_rectShort(voiceHighlight.bounds)}');
  print('Handle anchor bounds: ${_rectShort(handleAnchor.bounds)}');

  final realWorldMock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateMist, cyanPale, amberPale],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: cyanDeep, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: cyanMid.withValues(alpha: 0.20),
          blurRadius: 18.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How the platform uses SelectionRects',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: slateDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The IME / Autofill / a11y subsystem reads bounds + position + direction '
          'from each SelectionRect and renders OS-level UI on top of the field.',
          style: TextStyle(fontSize: 11.0, color: slateSoft, height: 1.45),
        ),
        SizedBox(height: 18.0),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: slatePale, width: 1.0),
          ),
          child: Stack(
            children: [
              // The simulated text line
              Positioned(
                left: 60.0,
                top: 60.0,
                child: Container(
                  height: 36.0,
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    'Hello, world!',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 24.0,
                      color: slateDeep,
                    ),
                  ),
                ),
              ),
              // Voice-command highlight (covers "Hello")
              Positioned(
                left: voiceHighlight.bounds.left,
                top: voiceHighlight.bounds.top,
                child: Container(
                  width: voiceHighlight.bounds.width,
                  height: voiceHighlight.bounds.height,
                  decoration: BoxDecoration(
                    color: amberMid.withValues(alpha: 0.30),
                    border: Border.all(color: amberDeep, width: 1.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              Positioned(
                left: voiceHighlight.bounds.left,
                top: voiceHighlight.bounds.top - 18.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: amberDeep,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'voice highlight',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Selection handle anchored at handleAnchor bounds (caret-thin rect)
              Positioned(
                left: handleAnchor.bounds.left,
                top: handleAnchor.bounds.top,
                child: Container(
                  width: handleAnchor.bounds.width,
                  height: handleAnchor.bounds.height,
                  color: cyanDeep,
                ),
              ),
              Positioned(
                left: handleAnchor.bounds.left - 6.0,
                top: handleAnchor.bounds.bottom,
                child: Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: cyanDeep,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Magnifier hovering above hoveredChar
              Positioned(
                left: hoveredChar.bounds.center.dx - 36.0,
                top: hoveredChar.bounds.top - 70.0,
                child: Container(
                  width: 72.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36.0),
                    border: Border.all(color: cyanDeep, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: cyanDeep.withValues(alpha: 0.30),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'o',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: slateDeep,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: hoveredChar.bounds.center.dx - 4.0,
                top: hoveredChar.bounds.top - 12.0,
                child: Container(
                  width: 8.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: cyanDeep,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              // Legend
              Positioned(
                right: 12.0,
                bottom: 12.0,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: slatePale, width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _legendItem('magnifier', cyanDeep),
                      _legendItem('voice highlight', amberDeep),
                      _legendItem('selection handle', cyanDeep),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Coordinate space
  // ============================================================
  print('=== Section 9: Coordinate Space ===');

  final coordSpaceCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, slateMist],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slateSoft, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_4x4, color: cyanDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Which coordinate space is `bounds` in?',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: slateDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'In Flutter, EditableText reports SelectionRects in **global pixels** — '
          'i.e. coordinates relative to the root render view, after MediaQuery '
          'devicePixelRatio is applied. The rect\'s origin is the top-left of one '
          'rendered glyph cluster (or run) inside the editable. The platform '
          'channel translates these into the embedder\'s native screen space.',
          style: TextStyle(
            fontSize: 12.5,
            color: slateMid,
            height: 1.55,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            color: slateMist,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: slatePale, width: 1.0),
          ),
          child: Stack(
            children: [
              // Origin marker
              Positioned(
                left: 12.0,
                top: 12.0,
                child: Row(
                  children: [
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: amberDeep,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      '(0, 0) global root',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: amberDeep,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              // X axis
              Positioned(
                left: 16.0,
                top: 22.0,
                child: Container(
                  width: 360.0,
                  height: 1.0,
                  color: slateSoft,
                ),
              ),
              // Y axis
              Positioned(
                left: 16.0,
                top: 22.0,
                child: Container(
                  width: 1.0,
                  height: 160.0,
                  color: slateSoft,
                ),
              ),
              // bounds rect
              Positioned(
                left: 140.0,
                top: 90.0,
                child: Container(
                  width: 60.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: cyanMid.withValues(alpha: 0.20),
                    border: Border.all(color: cyanDeep, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      'bounds',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: cyanDeep,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
              // dotted lines from origin to bounds
              Positioned(
                left: 16.0,
                top: 90.0,
                child: Container(
                  width: 124.0,
                  height: 1.0,
                  color: amberMid,
                ),
              ),
              Positioned(
                left: 140.0,
                top: 22.0,
                child: Container(
                  width: 1.0,
                  height: 68.0,
                  color: amberMid,
                ),
              ),
              Positioned(
                left: 70.0,
                top: 76.0,
                child: Text(
                  'bounds.left = 140',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: amberDeep,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Positioned(
                left: 145.0,
                top: 36.0,
                child: Text(
                  'bounds.top = 90',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: amberDeep,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'NOTE: `bounds` is *not* paragraph-local; you cannot offset it by the '
          'editable\'s own position to recover paragraph-local coordinates without '
          'subtracting the editable\'s global top-left first.',
          style: TextStyle(
            fontSize: 11.0,
            color: slateSoft,
            fontStyle: FontStyle.italic,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = <Map<String, String>>[
    {
      'title': 'bounds is screen space',
      'body': 'bounds is in global / screen pixels — not paragraph-local. '
          'Subtract the editable\'s global origin if you need a local rect.',
    },
    {
      'title': 'position is a text offset',
      'body': 'position is the UTF-16 code-unit offset, not a grapheme cluster '
          'index. A flag emoji ✨ may span 2+ code units; ensure your producer '
          'reports the *first* code unit of the cluster.',
    },
    {
      'title': 'direction matters for affinity',
      'body': 'TextDirection.rtl flips visual order. The IME relies on direction '
          'to compute caret affinity at run boundaries — never default to ltr.',
    },
    {
      'title': 'sort by visual order',
      'body': 'TextInput.setSelectionRects(rects) expects the list to already be '
          'sorted in visual order (left-to-right on screen, top-to-bottom by '
          'line). Logical-offset order is *not* guaranteed to match.',
    },
    {
      'title': 'equality covers all three',
      'body': 'SelectionRect == compares bounds, position, AND direction. Two '
          'rects with identical bounds but different direction are NOT equal — '
          'this matters for diffing rect lists between frames.',
    },
  ];

  final footgunCards = <Widget>[];
  for (var i = 0; i < footguns.length; i++) {
    final f = footguns[i];
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [amberPale, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: amberMid, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: amberMid.withValues(alpha: 0.20),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: amberDeep,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: amberDeep.withValues(alpha: 0.40),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '!${i + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f['title']!,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: slateDeep,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    f['body']!,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: slateMid,
                      height: 1.45,
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
  // SECTION 11: Recap
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDeep, cyanDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.40),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: amberSoft, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapLine('SelectionRect = (Rect bounds, int position, TextDirection direction).'),
        _recapLine('bounds: screen-space rectangle of one rendered glyph/run.'),
        _recapLine('position: UTF-16 text offset of that run\'s first code unit.'),
        _recapLine('direction: visual run direction; affects caret affinity.'),
        _recapLine('Dispatched as a List via TextInput.setSelectionRects(...).'),
        _recapLine('Powers magnifier, autofill, voice highlight, selection handles.'),
        _recapLine('List must be pre-sorted in visual order before dispatch.'),
        _recapLine('Equality includes all three fields — diff carefully.'),
      ],
    ),
  );

  print('SelectionRect Deep Demo completed successfully');

  // ============================================================
  // ROOT LAYOUT
  // ============================================================
  return Scaffold(
    backgroundColor: slateMist,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _sectionHeader('1. Anatomy', cyanDeep),
          anatomyDiagram,
          SizedBox(height: 24.0),
          _sectionHeader('2. Six Real Instances', cyanDeep),
          Wrap(alignment: WrapAlignment.center, children: instanceCards),
          SizedBox(height: 24.0),
          _sectionHeader('3. Visual Layout — adjacent rects per character', cyanDeep),
          visualLayout,
          SizedBox(height: 24.0),
          _sectionHeader('4. LTR vs RTL', amberDeep),
          ltrRtlPair,
          SizedBox(height: 24.0),
          _sectionHeader('5. IME Integration', slateDeep),
          imeCodeBlock,
          SizedBox(height: 24.0),
          _sectionHeader('6. Comparison vs related types', slateDeep),
          comparisonTable,
          SizedBox(height: 24.0),
          _sectionHeader('7. Real-world Mock', cyanDeep),
          realWorldMock,
          SizedBox(height: 24.0),
          _sectionHeader('8. Coordinate Space', cyanDeep),
          coordSpaceCard,
          SizedBox(height: 24.0),
          _sectionHeader('9. Footguns', amberDeep),
          ...footgunCards,
          SizedBox(height: 24.0),
          _sectionHeader('10. Recap', slateDeep),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// =============================================================
// Top-level helpers
// =============================================================

Widget _chip(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: bg, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 11.0,
        fontFamily: 'monospace',
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _anatomyLabel(String title, String subtitle, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.20),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14.0),
        SizedBox(width: 6.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 9.0, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _kv(String key, String value, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 10.0,
              color: accent,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 10.0,
              color: Color(0xFF334155),
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _glyphWithRect(
  SelectionRect rect,
  String glyph,
  Color borderColor,
  Color fillColor,
  Color positionColor,
  Color textColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 1.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: rect.bounds.width,
          height: rect.bounds.height,
          decoration: BoxDecoration(
            color: fillColor.withValues(alpha: 0.12),
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Center(
            child: Text(
              glyph,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: positionColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'pos ${rect.position}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'w${rect.bounds.width.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 8.0,
            color: borderColor,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _directionalityPanel(
  String label,
  TextDirection dir,
  List<SelectionRect> rects,
  Color borderColor,
  Color fillColor,
  Color textColor,
) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Directionality(
        textDirection: dir,
        child: Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final r in rects)
                Container(
                  width: 38.0,
                  height: 50.0,
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  decoration: BoxDecoration(
                    color: fillColor.withValues(alpha: 0.18),
                    border: Border.all(color: borderColor, width: 1.0),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Center(
                    child: Text(
                      '${r.position}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Text(
        dir == TextDirection.ltr
            ? 'visual order: 0 → 1 → 2 → 3'
            : 'visual order: 3 ← 2 ← 1 ← 0',
        style: TextStyle(
          fontSize: 10.0,
          color: borderColor,
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _dot(Color c) {
  return Container(
    width: 10.0,
    height: 10.0,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );
}

Widget _hdrCell(String text, double width, Color color) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        fontFamily: 'monospace',
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget _tableRow(
  String typeName,
  String geometry,
  String span,
  String direction,
  String usedBy,
  Color accent,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            typeName,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: accent,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            geometry,
            style: TextStyle(fontSize: 10.5, color: Color(0xFF334155)),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            span,
            style: TextStyle(fontSize: 10.5, color: Color(0xFF334155)),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Text(
            direction,
            style: TextStyle(fontSize: 10.5, color: Color(0xFF334155)),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: Text(
            usedBy,
            style: TextStyle(fontSize: 10.5, color: Color(0xFF334155)),
          ),
        ),
      ],
    ),
  );
}

Widget _legendItem(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: Color(0xFF334155),
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _sectionHeader(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    ),
  );
}

Widget _recapLine(String line) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Color(0xFFFCD34D), size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            line,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

String _rectShort(Rect r) {
  return 'L${r.left.toStringAsFixed(0)} '
      'T${r.top.toStringAsFixed(0)} '
      'W${r.width.toStringAsFixed(0)} '
      'H${r.height.toStringAsFixed(0)}';
}
