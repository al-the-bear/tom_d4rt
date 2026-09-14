// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show PlaceholderSpanIndexSemanticsTag;

// =============================================================================
// PlaceholderSpanIndexSemanticsTag — Deep Demo
// -----------------------------------------------------------------------------
// PlaceholderSpanIndexSemanticsTag is a SemanticsTag (carrying an integer
// `index`) that the framework attaches when a PlaceholderSpan / WidgetSpan is
// laid out as part of a TextSpan tree. Its purpose is to allow the semantics
// layer to map the placeholder character that lives in the text run to the
// inline child widget rendered at that position, so screen readers can refer
// to that specific child instead of the text-level placeholder code unit.
//
// The class is essentially a typed marker. Two instances are equal when their
// `index` is equal. Application code rarely needs to construct one directly —
// users normally interact with it transparently when wrapping inline children
// in WidgetSpans, occasionally reading SemanticsNode tags during integration
// tests or accessibility tooling.
//
// This file exercises the construction, equality, and surrounding feature
// (RichText / Text.rich / WidgetSpan) in a multi-section gallery, suitable
// for visual review on a device or harness.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== PlaceholderSpanIndexSemanticsTag Deep Demo ===');

  // Live-constructed tag instances we will display throughout the gallery.
  const tagA0 = PlaceholderSpanIndexSemanticsTag(0);
  const tagA1 = PlaceholderSpanIndexSemanticsTag(1);
  const tagA2 = PlaceholderSpanIndexSemanticsTag(2);
  const tagA3 = PlaceholderSpanIndexSemanticsTag(3);
  const tagA4 = PlaceholderSpanIndexSemanticsTag(4);
  const tagA5 = PlaceholderSpanIndexSemanticsTag(5);
  const tagDup0 = PlaceholderSpanIndexSemanticsTag(0);

  print('tagA0.toString(): ${tagA0.toString()}');
  print('tagA0 == tagDup0 : ${tagA0 == tagDup0}');
  print('tagA0 == tagA1   : ${tagA0 == tagA1}');
  print('tagA2.index = ${tagA2.index}, tagA3.index = ${tagA3.index}');
  print('tagA4.index = ${tagA4.index}, tagA5.index = ${tagA5.index}');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PlaceholderSpanIndexSemanticsTag Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF1565C0),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('PlaceholderSpanIndexSemanticsTag — Deep Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _section1Hero(),
              const SizedBox(height: 24),
              _section2EqualityAndHash(),
              const SizedBox(height: 24),
              _section3WidgetSpanGallery(),
              const SizedBox(height: 24),
              _section4IndexAwareShowcase(),
              const SizedBox(height: 24),
              _section5SemanticsIntegration(),
              const SizedBox(height: 24),
              _section6UseCasesRecipe(),
              const SizedBox(height: 24),
              _section7AccessibilityNarrative(),
              const SizedBox(height: 24),
              _section8InlineProgress(),
              const SizedBox(height: 24),
              _section9TagIdentityStress(),
              const SizedBox(height: 24),
              _section10ToStringVisualisation(),
              const SizedBox(height: 24),
              _section11DecisionCard(),
              const SizedBox(height: 24),
              _section12ReferenceTable(),
              const SizedBox(height: 24),
              _section13Footer(),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Hero intro
// -----------------------------------------------------------------------------
// Palette: indigo / cobalt blue.
// Communicates the relationship: text run → placeholder slot → inline widget,
// using a CustomPainter diagram that colour-codes each layer.
// =============================================================================

Widget _section1Hero() {
  const palette = _Palette(
    primary: Color(0xFF1A237E),
    accent: Color(0xFF3949AB),
    background: Color(0xFFE8EAF6),
    foreground: Color(0xFF0D1547),
  );
  return _SectionFrame(
    palette: palette,
    title: '1. What this tag is, and what it means',
    subtitle: 'PlaceholderSpan ↔ inline widget child ↔ semantics tag',
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'A SemanticsTag is a typed marker the engine attaches to a '
              'SemanticsNode, allowing tooling and tests to identify the '
              'origin of that node. PlaceholderSpanIndexSemanticsTag is a '
              'specific subclass that records the integer position of an '
              'inline child within a paragraph built from PlaceholderSpan '
              'or WidgetSpan instances.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 12),
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: palette.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: palette.accent),
              ),
              padding: const EdgeInsets.all(12),
              child: CustomPaint(
                painter: _HeroPainter(palette: palette),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const <Widget>[
                _MiniBadge(
                  label: 'PlaceholderSpan',
                  color: Color(0xFF1A237E),
                ),
                _MiniBadge(
                  label: 'WidgetSpan',
                  color: Color(0xFF3949AB),
                ),
                _MiniBadge(
                  label: 'PlaceholderSpanIndexSemanticsTag',
                  color: Color(0xFF5C6BC0),
                ),
                _MiniBadge(
                  label: 'SemanticsNode',
                  color: Color(0xFF7986CB),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              color: palette.background,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(color: palette.foreground, fontSize: 14),
                    children: <InlineSpan>[
                      const TextSpan(text: 'Live example: tap '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.bookmark,
                          size: 18,
                          color: palette.primary,
                        ),
                      ),
                      const TextSpan(text: ' to bookmark, or '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.share,
                          size: 18,
                          color: palette.primary,
                        ),
                      ),
                      const TextSpan(text: ' to share with friends.'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class _HeroPainter extends CustomPainter {
  _HeroPainter({required this.palette});
  final _Palette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = palette.background;
    canvas.drawRect(Offset.zero & size, bg);

    final textPaint = Paint()
      ..color = palette.accent
      ..style = PaintingStyle.fill;

    // Draw a row of "letters" representing the text run, with two slots
    // marked as placeholders.
    const letters = 'TEXT  TEXT  TEXT';
    final letterWidth = size.width / 22;
    final y = size.height * 0.30;

    for (var i = 0; i < letters.length; i++) {
      final ch = letters[i];
      final x = letterWidth * (i + 2);
      if (ch == ' ') continue;
      final r = Rect.fromLTWH(x, y, letterWidth * 0.9, 18);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(3)),
        textPaint,
      );
    }

    // Two placeholder slots (gaps in text).
    final slotPaint = Paint()
      ..color = palette.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final slot1 = Rect.fromLTWH(letterWidth * 6.5, y - 4, 28, 26);
    final slot2 = Rect.fromLTWH(letterWidth * 12.5, y - 4, 28, 26);
    canvas.drawRRect(
      RRect.fromRectAndRadius(slot1, const Radius.circular(4)),
      slotPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(slot2, const Radius.circular(4)),
      slotPaint,
    );

    // Inline widgets below.
    final widgetPaint = Paint()..color = palette.primary;
    final w1 = Rect.fromLTWH(20, size.height * 0.65, 80, 40);
    final w2 = Rect.fromLTWH(140, size.height * 0.65, 80, 40);
    canvas.drawRRect(
      RRect.fromRectAndRadius(w1, const Radius.circular(8)),
      widgetPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(w2, const Radius.circular(8)),
      widgetPaint,
    );

    // Connecting lines slot → widget.
    final linkPaint = Paint()
      ..color = palette.foreground
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(slot1.center.dx, slot1.bottom),
      Offset(w1.center.dx, w1.top),
      linkPaint,
    );
    canvas.drawLine(
      Offset(slot2.center.dx, slot2.bottom),
      Offset(w2.center.dx, w2.top),
      linkPaint,
    );

    // Tag glyphs near the lines.
    final tagPaint = Paint()..color = palette.accent;
    final tag1 = Rect.fromCenter(
      center: Offset(slot1.center.dx + 18, (slot1.bottom + w1.top) / 2),
      width: 50,
      height: 18,
    );
    final tag2 = Rect.fromCenter(
      center: Offset(slot2.center.dx + 18, (slot2.bottom + w2.top) / 2),
      width: 50,
      height: 18,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(tag1, const Radius.circular(9)),
      tagPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(tag2, const Radius.circular(9)),
      tagPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _HeroPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 2 — Equality and hashCode
// -----------------------------------------------------------------------------
// Palette: teal.
// Two PlaceholderSpanIndexSemanticsTag are == iff their `index` is equal.
// Slider picks two indices, live equality indicator updates.
// =============================================================================

Widget _section2EqualityAndHash() {
  const palette = _Palette(
    primary: Color(0xFF00695C),
    accent: Color(0xFF26A69A),
    background: Color(0xFFE0F2F1),
    foreground: Color(0xFF003D33),
  );

  return _SectionFrame(
    palette: palette,
    title: '2. Equality and hashCode',
    subtitle: 'value semantics over the integer `index`',
    child: StatefulBuilder(
      builder: (context, setState) {
        return _EqualityDemoBody(palette: palette);
      },
    ),
  );
}

class _EqualityDemoBody extends StatefulWidget {
  const _EqualityDemoBody({required this.palette});
  final _Palette palette;

  @override
  State<_EqualityDemoBody> createState() => _EqualityDemoBodyState();
}

class _EqualityDemoBodyState extends State<_EqualityDemoBody> {
  double _a = 0;
  double _b = 0;

  @override
  Widget build(BuildContext context) {
    final a = _a.round();
    final b = _b.round();
    final tagA = PlaceholderSpanIndexSemanticsTag(a);
    final tagB = PlaceholderSpanIndexSemanticsTag(b);
    final equal = tagA == tagB;

    final sampleTags = <PlaceholderSpanIndexSemanticsTag>[
      const PlaceholderSpanIndexSemanticsTag(0),
      const PlaceholderSpanIndexSemanticsTag(1),
      const PlaceholderSpanIndexSemanticsTag(2),
      const PlaceholderSpanIndexSemanticsTag(0),
      const PlaceholderSpanIndexSemanticsTag(3),
      const PlaceholderSpanIndexSemanticsTag(1),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Construct two tags by sliding the index controls below. The card '
          'on the right reflects whether the two tags are equal in value.',
          style: TextStyle(color: widget.palette.foreground),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text('index a: $a',
                      style: TextStyle(color: widget.palette.primary)),
                  Slider(
                    value: _a,
                    min: 0,
                    max: 9,
                    divisions: 9,
                    label: a.toString(),
                    activeColor: widget.palette.primary,
                    onChanged: (v) => setState(() => _a = v),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text('index b: $b',
                      style: TextStyle(color: widget.palette.primary)),
                  Slider(
                    value: _b,
                    min: 0,
                    max: 9,
                    divisions: 9,
                    label: b.toString(),
                    activeColor: widget.palette.accent,
                    onChanged: (v) => setState(() => _b = v),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: _ValueCard(
                title: 'tagA',
                lines: <String>[
                  'PlaceholderSpanIndexSemanticsTag($a)',
                  'hashCode: ${tagA.hashCode}',
                  'toString: $tagA',
                ],
                color: widget.palette.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ValueCard(
                title: 'tagB',
                lines: <String>[
                  'PlaceholderSpanIndexSemanticsTag($b)',
                  'hashCode: ${tagB.hashCode}',
                  'toString: $tagB',
                ],
                color: widget.palette.accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: equal ? widget.palette.primary : widget.palette.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.palette.primary),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                equal ? Icons.check_circle : Icons.cancel,
                color: equal ? Colors.white : widget.palette.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  equal
                      ? 'tagA == tagB  →  true (indices are equal)'
                      : 'tagA == tagB  →  false (indices differ)',
                  style: TextStyle(
                    color: equal ? Colors.white : widget.palette.foreground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Pre-built tag instances and pairwise equality:',
          style: TextStyle(color: widget.palette.foreground),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (var i = 0; i < sampleTags.length; i++)
              Chip(
                label: Text('tag$i: idx=${sampleTags[i].index}'),
                backgroundColor: widget.palette.background,
                side: BorderSide(color: widget.palette.primary),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.palette.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.palette.accent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var i = 0; i < sampleTags.length; i++)
                for (var j = i + 1; j < sampleTags.length; j++)
                  Text(
                    'tag$i == tag$j  →  ${sampleTags[i] == sampleTags[j]}',
                    style: TextStyle(
                      color: sampleTags[i] == sampleTags[j]
                          ? widget.palette.primary
                          : widget.palette.foreground,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 3 — WidgetSpan basic gallery
// -----------------------------------------------------------------------------
// Palette: amber / orange.
// Builds Text.rich paragraphs with mixed TextSpan + WidgetSpan combinations.
// =============================================================================

Widget _section3WidgetSpanGallery() {
  const palette = _Palette(
    primary: Color(0xFFEF6C00),
    accent: Color(0xFFFFB74D),
    background: Color(0xFFFFF3E0),
    foreground: Color(0xFF3E2723),
  );
  return _SectionFrame(
    palette: palette,
    title: '3. WidgetSpan gallery',
    subtitle: 'inline widgets in Text.rich; each gets a placeholder index',
    child: StatefulBuilder(
      builder: (context, setState) {
        final examples = <_GalleryExample>[
          _GalleryExample(
            label: 'Inline icons',
            spans: <InlineSpan>[
              const TextSpan(text: 'Press '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.play_arrow, size: 18, color: palette.primary),
              ),
              const TextSpan(text: ' to start, '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.pause, size: 18, color: palette.primary),
              ),
              const TextSpan(text: ' to pause, '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.stop, size: 18, color: palette.primary),
              ),
              const TextSpan(text: ' to stop.'),
            ],
          ),
          _GalleryExample(
            label: 'Inline status badges',
            spans: <InlineSpan>[
              const TextSpan(text: 'Build '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _Pill(
                  label: 'PASSED',
                  color: const Color(0xFF2E7D32),
                ),
              ),
              const TextSpan(text: ' on main and '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _Pill(
                  label: 'FAILED',
                  color: const Color(0xFFC62828),
                ),
              ),
              const TextSpan(text: ' on dev.'),
            ],
          ),
          _GalleryExample(
            label: 'Inline action chips',
            spans: <InlineSpan>[
              const TextSpan(text: 'Tags: '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _Pill(label: 'flutter', color: palette.primary),
              ),
              const TextSpan(text: ' '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _Pill(label: 'semantics', color: palette.primary),
              ),
              const TextSpan(text: ' '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _Pill(label: 'a11y', color: palette.primary),
              ),
            ],
          ),
          _GalleryExample(
            label: 'Mixed avatars + text',
            spans: <InlineSpan>[
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: palette.primary,
                  child: const Text('A',
                      style: TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ),
              const TextSpan(text: ' Alice and '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: palette.accent,
                  child: const Text('B',
                      style: TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ),
              const TextSpan(text: ' Bob commented on the issue.'),
            ],
          ),
          _GalleryExample(
            label: 'Inline switch',
            spans: <InlineSpan>[
              const TextSpan(text: 'Notifications '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: SizedBox(
                  width: 36,
                  height: 18,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Switch(
                      value: true,
                      onChanged: (_) {},
                      activeColor: palette.primary,
                    ),
                  ),
                ),
              ),
              const TextSpan(text: ' enabled by default.'),
            ],
          ),
          _GalleryExample(
            label: 'Inline KBD shortcuts',
            spans: <InlineSpan>[
              const TextSpan(text: 'Press '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _Kbd(label: 'Ctrl'),
              ),
              const TextSpan(text: ' + '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _Kbd(label: 'Shift'),
              ),
              const TextSpan(text: ' + '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _Kbd(label: 'P'),
              ),
              const TextSpan(text: ' to open the command palette.'),
            ],
          ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (final example in examples)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Card(
                  color: palette.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: palette.accent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          example.label,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: palette.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: palette.foreground,
                            ),
                            children: example.spans,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'placeholders: '
                          '${example.spans.whereType<WidgetSpan>().length}',
                          style: TextStyle(
                            fontSize: 11,
                            color: palette.primary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    ),
  );
}

class _GalleryExample {
  _GalleryExample({required this.label, required this.spans});
  final String label;
  final List<InlineSpan> spans;
}

// =============================================================================
// SECTION 4 — Index-aware showcase
// -----------------------------------------------------------------------------
// Palette: deep purple.
// Builds a Text.rich and tabulates each placeholder index, the widget it
// points to, and the corresponding tag instance.
// =============================================================================

Widget _section4IndexAwareShowcase() {
  const palette = _Palette(
    primary: Color(0xFF4527A0),
    accent: Color(0xFF7E57C2),
    background: Color(0xFFEDE7F6),
    foreground: Color(0xFF311B92),
  );

  return _SectionFrame(
    palette: palette,
    title: '4. Index-aware showcase',
    subtitle: 'each WidgetSpan corresponds to PlaceholderSpanIndexSemanticsTag(i)',
    child: StatefulBuilder(
      builder: (context, setState) {
        final placeholders = <_PlaceholderRow>[
          _PlaceholderRow(
            description: 'leading bookmark icon',
            child: Icon(Icons.bookmark, color: palette.primary, size: 18),
          ),
          _PlaceholderRow(
            description: 'inline status pill',
            child: _Pill(label: 'NEW', color: palette.accent),
          ),
          _PlaceholderRow(
            description: 'inline avatar',
            child: CircleAvatar(
              radius: 10,
              backgroundColor: palette.primary,
              child: const Text('Z',
                  style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
          _PlaceholderRow(
            description: 'inline action button',
            child: _Pill(label: 'OPEN', color: palette.primary),
          ),
        ];

        // Build a Text.rich whose WidgetSpans are these placeholders, in order.
        final spans = <InlineSpan>[];
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: placeholders[0].child,
        ));
        spans.add(const TextSpan(text: ' Article: Inline widgets '));
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: placeholders[1].child,
        ));
        spans.add(const TextSpan(text: ' authored by '));
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: placeholders[2].child,
        ));
        spans.add(const TextSpan(text: ' — '));
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: placeholders[3].child,
        ));
        spans.add(const TextSpan(text: ' to read full text.'));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: palette.background,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: palette.foreground,
                      fontSize: 14,
                    ),
                    children: spans,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: palette.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: palette.accent),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: TextStyle(
                    color: palette.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  columns: const <DataColumn>[
                    DataColumn(label: Text('index')),
                    DataColumn(label: Text('description')),
                    DataColumn(label: Text('child')),
                    DataColumn(label: Text('tag instance')),
                  ],
                  rows: <DataRow>[
                    for (var i = 0; i < placeholders.length; i++)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('$i')),
                          DataCell(Text(placeholders[i].description)),
                          DataCell(placeholders[i].child),
                          DataCell(
                            Text(
                              'PlaceholderSpanIndexSemanticsTag($i)',
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class _PlaceholderRow {
  _PlaceholderRow({required this.description, required this.child});
  final String description;
  final Widget child;
}

// =============================================================================
// SECTION 5 — Semantics integration
// -----------------------------------------------------------------------------
// Palette: green.
// Wraps inline widgets in Semantics with explicit labels, simulating what
// the framework would identify via PlaceholderSpanIndexSemanticsTag.
// =============================================================================

Widget _section5SemanticsIntegration() {
  const palette = _Palette(
    primary: Color(0xFF2E7D32),
    accent: Color(0xFF66BB6A),
    background: Color(0xFFE8F5E9),
    foreground: Color(0xFF1B5E20),
  );
  return _SectionFrame(
    palette: palette,
    title: '5. Semantics integration',
    subtitle: 'why each inline widget needs its own semantic identity',
    child: StatefulBuilder(
      builder: (context, setState) {
        final spans = <InlineSpan>[
          const TextSpan(text: 'Press '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Semantics(
              button: true,
              label: 'Subscribe button',
              child: _Pill(label: 'SUBSCRIBE', color: palette.primary),
            ),
          ),
          const TextSpan(text: ' or '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Semantics(
              link: true,
              label: 'Learn more link',
              child: _Pill(label: 'LEARN', color: palette.accent),
            ),
          ),
          const TextSpan(text: ' for the latest weekly updates.'),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: palette.background,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: palette.foreground,
                      fontSize: 14,
                    ),
                    children: spans,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: palette.background,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Why each inline child needs its own semantic identity',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: palette.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'When a paragraph mixes plain text and inline widgets, '
                      'a screen reader needs to announce each interactive '
                      'placeholder distinctly: "Press SUBSCRIBE button" and '
                      '"Press LEARN link". The PlaceholderSpanIndexSemanticsTag '
                      'gives every placeholder a stable, integer-keyed identity '
                      'that survives semantic merging — even when adjacent '
                      'TextSpans collapse, the tag tells tooling which '
                      'inline widget produced the corresponding semantic node.',
                      style: TextStyle(
                        color: palette.foreground,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('index')),
                DataColumn(label: Text('semantic role')),
                DataColumn(label: Text('label')),
              ],
              rows: const <DataRow>[
                DataRow(cells: <DataCell>[
                  DataCell(Text('0')),
                  DataCell(Text('button')),
                  DataCell(Text('Subscribe button')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('1')),
                  DataCell(Text('link')),
                  DataCell(Text('Learn more link')),
                ]),
              ],
            ),
          ],
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 6 — Use cases recipe section
// -----------------------------------------------------------------------------
// Palette: pink/magenta.
// Three real-life uses of inline placeholder widgets.
// =============================================================================

Widget _section6UseCasesRecipe() {
  const palette = _Palette(
    primary: Color(0xFFAD1457),
    accent: Color(0xFFEC407A),
    background: Color(0xFFFCE4EC),
    foreground: Color(0xFF560027),
  );
  return _SectionFrame(
    palette: palette,
    title: '6. Use cases recipe',
    subtitle: 'three real-world inline-widget compositions',
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _RecipeCard(
              palette: palette,
              title: 'Recipe A — Inline icon + label rich text',
              description:
                  'A short instructional sentence with an inline icon. The '
                  'icon is mounted as a WidgetSpan, which causes the engine '
                  'to issue a PlaceholderSpanIndexSemanticsTag(0).',
              spans: <InlineSpan>[
                const TextSpan(text: 'Tap '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child:
                      Icon(Icons.share, size: 18, color: palette.primary),
                ),
                const TextSpan(text: ' to share with friends.'),
              ],
            ),
            const SizedBox(height: 8),
            _RecipeCard(
              palette: palette,
              title: 'Recipe B — Inline status badge in chat bubble',
              description:
                  'A chat bubble containing a status pill inline with a '
                  'reply preview. The pill receives index 0; the timestamp '
                  'icon (if present) receives index 1, etc.',
              spans: <InlineSpan>[
                const TextSpan(text: 'Reply: '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _Pill(
                    label: 'DELIVERED',
                    color: palette.primary,
                  ),
                ),
                const TextSpan(text: ' "See you at 6pm" '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.access_time,
                      size: 14, color: palette.foreground),
                ),
                const TextSpan(text: ' 2 min ago.'),
              ],
            ),
            const SizedBox(height: 8),
            _RecipeCard(
              palette: palette,
              title: 'Recipe C — Inline interactive chip in a paragraph',
              description:
                  'An action chip embedded inside a flowing paragraph. The '
                  'chip is a stand-alone interactive element, but it lives '
                  'inside the same paragraph, so its semantic identity must '
                  'be preserved by tag-index pairing.',
              spans: <InlineSpan>[
                const TextSpan(text: 'You can '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _Pill(
                    label: 'ADD TO CART',
                    color: palette.primary,
                  ),
                ),
                const TextSpan(
                  text: ' the recommended bundle, or browse the catalog.',
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.palette,
    required this.title,
    required this.description,
    required this.spans,
  });
  final _Palette palette;
  final String title;
  final String description;
  final List<InlineSpan> spans;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: palette.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: palette.accent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: palette.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: TextStyle(
                color: palette.foreground,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text.rich(
              TextSpan(
                style: TextStyle(
                  color: palette.foreground,
                  fontSize: 14,
                ),
                children: spans,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — Accessibility narrative
// -----------------------------------------------------------------------------
// Palette: brown / sand.
// Long-text section about screen-reader traversal.
// =============================================================================

Widget _section7AccessibilityNarrative() {
  const palette = _Palette(
    primary: Color(0xFF6D4C41),
    accent: Color(0xFFA1887F),
    background: Color(0xFFEFEBE9),
    foreground: Color(0xFF3E2723),
  );
  return _SectionFrame(
    palette: palette,
    title: '7. Accessibility narrative',
    subtitle: 'how a screen reader traverses mixed text + widget runs',
    child: StatefulBuilder(
      builder: (context, setState) {
        return Card(
          color: palette.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: palette.accent),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'A short story about screen readers and placeholders',
                  style: TextStyle(
                    color: palette.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Imagine a paragraph: "Tap [share-icon] to share, or '
                  '[bookmark-icon] to save for later." When this paragraph '
                  'is rendered as a TextSpan tree containing two WidgetSpans, '
                  'the framework produces a single text run with two '
                  'placeholder code units (U+FFFC OBJECT REPLACEMENT '
                  'CHARACTER). Each placeholder has a position — first '
                  'placeholder = index 0, second = index 1.',
                  style: TextStyle(
                    color: palette.foreground,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'When the semantics layer walks the render tree, it sees '
                  'the text-level placeholders and the widget-level child '
                  'render objects, and it has to connect them. To do that '
                  'it stamps PlaceholderSpanIndexSemanticsTag(i) onto the '
                  'semantic node that originated from the i-th placeholder, '
                  'so when the widget child contributes its own semantic '
                  'node (e.g. a button), the framework can match the two by '
                  'looking for the tag.',
                  style: TextStyle(
                    color: palette.foreground,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The key insight: indices remain stable as long as the '
                  'order of WidgetSpans inside the TextSpan tree is stable. '
                  'If you rebuild the paragraph and reorder the WidgetSpans, '
                  'their tags and the screen-reader traversal order change '
                  'with them. This is normally fine, but it means automated '
                  'a11y tests should not assume tag indices are persistent '
                  'identifiers across builds — they are positional.',
                  style: TextStyle(
                    color: palette.foreground,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 8 — Inline progress
// -----------------------------------------------------------------------------
// Palette: cyan / aqua.
// A sentence with an inline LinearProgressIndicator. Index stays the same
// regardless of progress value.
// =============================================================================

Widget _section8InlineProgress() {
  const palette = _Palette(
    primary: Color(0xFF006064),
    accent: Color(0xFF26C6DA),
    background: Color(0xFFE0F7FA),
    foreground: Color(0xFF004D52),
  );
  return _SectionFrame(
    palette: palette,
    title: '8. Inline progress',
    subtitle: 'placeholder index is independent of widget state changes',
    child: StatefulBuilder(
      builder: (context, setState) {
        return _InlineProgressBody(palette: palette);
      },
    ),
  );
}

class _InlineProgressBody extends StatefulWidget {
  const _InlineProgressBody({required this.palette});
  final _Palette palette;

  @override
  State<_InlineProgressBody> createState() => _InlineProgressBodyState();
}

class _InlineProgressBodyState extends State<_InlineProgressBody> {
  double _progress = 0.4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Card(
          color: widget.palette.background,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: widget.palette.foreground,
                  fontSize: 14,
                ),
                children: <InlineSpan>[
                  const TextSpan(text: 'Sync in progress: '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: 100,
                      child: LinearProgressIndicator(
                        value: _progress,
                        color: widget.palette.primary,
                        backgroundColor: widget.palette.accent,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ' ${(100 * _progress).toStringAsFixed(0)}% done.',
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Slider(
          value: _progress,
          min: 0,
          max: 1,
          divisions: 20,
          label: _progress.toStringAsFixed(2),
          activeColor: widget.palette.primary,
          onChanged: (v) => setState(() => _progress = v),
        ),
        Card(
          color: widget.palette.background,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Note: the progress value above changes the visual rendering of '
              'the inline LinearProgressIndicator, but the placeholder '
              'index — and therefore the value carried by the corresponding '
              'PlaceholderSpanIndexSemanticsTag(0) — is unaffected.',
              style: TextStyle(
                color: widget.palette.foreground,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 9 — Tag identity stress
// -----------------------------------------------------------------------------
// Palette: red / coral.
// Build 50 PlaceholderSpanIndexSemanticsTag(i) instances. Render a
// CustomPainter grid with a green dot at (i, j) iff tags[i] == tags[j].
// Should produce a diagonal.
// =============================================================================

Widget _section9TagIdentityStress() {
  const palette = _Palette(
    primary: Color(0xFFB71C1C),
    accent: Color(0xFFEF5350),
    background: Color(0xFFFFEBEE),
    foreground: Color(0xFF7F0000),
  );

  final tags = <PlaceholderSpanIndexSemanticsTag>[
    for (var i = 0; i < 50; i++) PlaceholderSpanIndexSemanticsTag(i),
  ];
  // Sanity print: count diagonal hits.
  var diagonal = 0;
  for (var i = 0; i < tags.length; i++) {
    if (tags[i] == tags[i]) diagonal++;
  }
  print('Section 9: 50x50 tag identity, diagonal hits = $diagonal');

  return _SectionFrame(
    palette: palette,
    title: '9. Tag identity stress',
    subtitle: '50 instances; equality grid should highlight only the diagonal',
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: palette.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: palette.accent),
              ),
              padding: const EdgeInsets.all(8),
              child: CustomPaint(
                painter: _IdentityGridPainter(
                  tags: tags,
                  palette: palette,
                ),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '50 PlaceholderSpanIndexSemanticsTag instances; each cell (i,j) '
              'is filled when tags[i] == tags[j]. Result is a clean diagonal '
              '— confirming equality is purely index-based.',
              style: TextStyle(
                color: palette.foreground,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                _MiniBadge(
                  label: 'tags.length = ${tags.length}',
                  color: palette.primary,
                ),
                _MiniBadge(
                  label: 'distinct hashCodes ≈ '
                      '${tags.map((t) => t.hashCode).toSet().length}',
                  color: palette.accent,
                ),
                _MiniBadge(
                  label:
                      'tags[0] == tags[0] : ${tags[0] == tags[0]}',
                  color: palette.primary,
                ),
                _MiniBadge(
                  label:
                      'tags[0] == tags[1] : ${tags[0] == tags[1]}',
                  color: palette.accent,
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

class _IdentityGridPainter extends CustomPainter {
  _IdentityGridPainter({required this.tags, required this.palette});
  final List<PlaceholderSpanIndexSemanticsTag> tags;
  final _Palette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final n = tags.length;
    final cell = size.shortestSide / n;
    final emptyPaint = Paint()..color = palette.background;
    final hitPaint = Paint()..color = palette.primary;
    final borderPaint = Paint()
      ..color = palette.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (var i = 0; i < n; i++) {
      for (var j = 0; j < n; j++) {
        final r = Rect.fromLTWH(j * cell, i * cell, cell, cell);
        canvas.drawRect(r, emptyPaint);
        if (tags[i] == tags[j]) {
          canvas.drawRect(r.deflate(cell * 0.18), hitPaint);
        }
        canvas.drawRect(r, borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _IdentityGridPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 10 — toString visualisation
// -----------------------------------------------------------------------------
// Palette: blue-grey.
// Show t.toString() for several indices in a code-style card.
// =============================================================================

Widget _section10ToStringVisualisation() {
  const palette = _Palette(
    primary: Color(0xFF37474F),
    accent: Color(0xFF78909C),
    background: Color(0xFFECEFF1),
    foreground: Color(0xFF263238),
  );

  final samples = <PlaceholderSpanIndexSemanticsTag>[
    const PlaceholderSpanIndexSemanticsTag(0),
    const PlaceholderSpanIndexSemanticsTag(1),
    const PlaceholderSpanIndexSemanticsTag(7),
    const PlaceholderSpanIndexSemanticsTag(42),
    const PlaceholderSpanIndexSemanticsTag(99),
    const PlaceholderSpanIndexSemanticsTag(255),
    const PlaceholderSpanIndexSemanticsTag(1024),
  ];

  return _SectionFrame(
    palette: palette,
    title: '10. toString visualisation',
    subtitle: 'how PlaceholderSpanIndexSemanticsTag prints itself',
    child: StatefulBuilder(
      builder: (context, setState) {
        return Card(
          color: const Color(0xFF1E2227),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: palette.accent),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final t in samples)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      'PlaceholderSpanIndexSemanticsTag(${t.index}).toString() '
                      '=> ${t.toString()}',
                      style: const TextStyle(
                        color: Color(0xFFCFD8DC),
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                const Text(
                  '// equality is value-based on `index`',
                  style: TextStyle(
                    color: Color(0xFF80CBC4),
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
                Text(
                  'samples[0] == samples[0] => ${samples[0] == samples[0]}',
                  style: const TextStyle(
                    color: Color(0xFFCFD8DC),
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
                Text(
                  'samples[0] == samples[1] => ${samples[0] == samples[1]}',
                  style: const TextStyle(
                    color: Color(0xFFCFD8DC),
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 11 — Decision card
// -----------------------------------------------------------------------------
// Palette: gold / yellow.
// When (almost never) should developers hand-roll PlaceholderSpanIndexSemanticsTag?
// =============================================================================

Widget _section11DecisionCard() {
  const palette = _Palette(
    primary: Color(0xFFF57F17),
    accent: Color(0xFFFFD54F),
    background: Color(0xFFFFF8E1),
    foreground: Color(0xFF4F3700),
  );
  return _SectionFrame(
    palette: palette,
    title: '11. When to hand-roll this tag',
    subtitle: 'spoiler: almost never',
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: palette.background,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Default answer: do not.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: palette.primary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Application code rarely constructs '
                      'PlaceholderSpanIndexSemanticsTag manually. The framework '
                      'attaches the tag automatically when laying out '
                      'PlaceholderSpan / WidgetSpan inside a TextSpan tree.',
                      style: TextStyle(
                        color: palette.foreground,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Use this tag directly only when:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: palette.primary,
                      ),
                    ),
                    Text(
                      '\u2022 You are writing custom semantics-tooling that '
                      'introspects SemanticsNode tags from integration tests.',
                      style: TextStyle(color: palette.foreground),
                    ),
                    Text(
                      '\u2022 You are implementing a custom RenderObject that '
                      'mirrors the placeholder/inline-widget contract and need '
                      'to participate in the same identification scheme.',
                      style: TextStyle(color: palette.foreground),
                    ),
                    Text(
                      '\u2022 You are writing a code generator or AST tool that '
                      'inspects the engine\'s placeholder semantics.',
                      style: TextStyle(color: palette.foreground),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: palette.background,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Alternatives for normal app code:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: palette.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('1. Wrap inline widgets in Semantics(...).',
                        style: TextStyle(color: palette.foreground)),
                    Text(
                      '2. Use MergeSemantics around a paragraph + inline '
                      'children when grouping is desired.',
                      style: TextStyle(color: palette.foreground),
                    ),
                    Text(
                      '3. Provide explicit labels via the inline child widget '
                      '(e.g., IconButton(tooltip: ...)).',
                      style: TextStyle(color: palette.foreground),
                    ),
                    Text(
                      '4. For tests, prefer find.bySemanticsLabel and friends '
                      'over inspecting raw tags.',
                      style: TextStyle(color: palette.foreground),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 12 — Reference table
// -----------------------------------------------------------------------------
// Palette: lime / green.
// Member, type, description.
// =============================================================================

Widget _section12ReferenceTable() {
  const palette = _Palette(
    primary: Color(0xFF558B2F),
    accent: Color(0xFFAED581),
    background: Color(0xFFF1F8E9),
    foreground: Color(0xFF33691E),
  );
  return _SectionFrame(
    palette: palette,
    title: '12. Reference table',
    subtitle: 'public surface of PlaceholderSpanIndexSemanticsTag',
    child: StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
            color: palette.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: palette.accent),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: TextStyle(
                color: palette.primary,
                fontWeight: FontWeight.bold,
              ),
              columns: const <DataColumn>[
                DataColumn(label: Text('member')),
                DataColumn(label: Text('type')),
                DataColumn(label: Text('description')),
              ],
              rows: const <DataRow>[
                DataRow(cells: <DataCell>[
                  DataCell(Text('PlaceholderSpanIndexSemanticsTag(int index)')),
                  DataCell(Text('const ctor')),
                  DataCell(Text(
                      'Construct a tag identifying a placeholder by index.')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('index')),
                  DataCell(Text('int')),
                  DataCell(Text(
                      'The placeholder position within its surrounding '
                      'TextSpan tree.')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('operator ==')),
                  DataCell(Text('bool')),
                  DataCell(Text(
                      'Two tags are equal iff their indices are equal.')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('hashCode')),
                  DataCell(Text('int')),
                  DataCell(Text('Hash derived from index.')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('toString()')),
                  DataCell(Text('String')),
                  DataCell(Text(
                      'Class-name + index suitable for debug printing.')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('extends SemanticsTag')),
                  DataCell(Text('-')),
                  DataCell(Text(
                      'Inherits the standard SemanticsTag behaviour and is '
                      'attached by the framework to relevant SemanticsNodes.')),
                ]),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 13 — Footer / refs
// -----------------------------------------------------------------------------
// Palette: neutral grey.
// =============================================================================

Widget _section13Footer() {
  const palette = _Palette(
    primary: Color(0xFF424242),
    accent: Color(0xFF9E9E9E),
    background: Color(0xFFF5F5F5),
    foreground: Color(0xFF212121),
  );
  return _SectionFrame(
    palette: palette,
    title: '13. Related references',
    subtitle: 'further reading inside the Flutter framework',
    child: StatefulBuilder(
      builder: (context, setState) {
        return Card(
          color: palette.background,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _RefRow(
                  symbol: 'SemanticsTag',
                  description: 'Base class — typed marker attached to SemanticsNodes.',
                ),
                _RefRow(
                  symbol: 'PlaceholderSpan',
                  description:
                      'Abstract InlineSpan subclass for placeholder content.',
                ),
                _RefRow(
                  symbol: 'WidgetSpan',
                  description:
                      'PlaceholderSpan subclass that wraps an arbitrary Widget.',
                ),
                _RefRow(
                  symbol: 'RichText / Text.rich',
                  description:
                      'High-level entry points for building TextSpan trees that '
                      'may contain WidgetSpans.',
                ),
                _RefRow(
                  symbol: 'Semantics / MergeSemantics',
                  description:
                      'Higher-level a11y widgets generally preferred over '
                      'manual tag construction.',
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

class _RefRow extends StatelessWidget {
  const _RefRow({required this.symbol, required this.description});
  final String symbol;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(
              symbol,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(child: Text(description)),
        ],
      ),
    );
  }
}

// =============================================================================
// Shared widgets and palette
// =============================================================================

class _Palette {
  const _Palette({
    required this.primary,
    required this.accent,
    required this.background,
    required this.foreground,
  });
  final Color primary;
  final Color accent;
  final Color background;
  final Color foreground;
}

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.palette,
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final _Palette palette;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.accent, width: 1.4),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: palette.primary,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: palette.foreground,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard({
    required this.title,
    required this.lines,
    required this.color,
  });
  final String title;
  final List<String> lines;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          for (final l in lines)
            Text(
              l,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Kbd extends StatelessWidget {
  const _Kbd({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF90A4AE)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
