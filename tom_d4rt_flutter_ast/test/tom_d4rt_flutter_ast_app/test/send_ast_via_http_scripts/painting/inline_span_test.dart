// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InlineSpan from painting
// Deep Demo: Visual demonstration of InlineSpan, TextSpan, WidgetSpan and the
// rich-text composition primitives that drive Text.rich(...) and RichText.
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('InlineSpan Deep Demo executing');

  // Theme palette: indigo / violet for "rich text".
  final indigo = Colors.indigo;
  final violet = Colors.deepPurple;
  final pink = Colors.pink;
  final teal = Colors.teal;
  final amber = Colors.amber;
  final slate = Colors.blueGrey;

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          indigo.shade700,
          violet.shade500,
          pink.withValues(alpha: 0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: violet.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.format_color_text, size: 64.0, color: Colors.white),
        SizedBox(height: 10.0),
        Text(
          'InlineSpan',
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'TextSpan + WidgetSpan + PlaceholderSpan',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white70,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            'package:flutter/painting.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title banner ready');

  // ============================================================
  // SECTION 2: Anatomy — labelled tree diagram of TextSpan
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyTextSpan = TextSpan(
    text: 'Hello ',
    style: TextStyle(
      color: indigo.shade900,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    children: <InlineSpan>[
      TextSpan(
        text: 'beautiful ',
        style: TextStyle(
          color: pink.shade400,
          fontStyle: FontStyle.italic,
        ),
      ),
      TextSpan(
        text: 'world',
        style: TextStyle(
          color: violet.shade700,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
      TextSpan(text: '!'),
    ],
  );

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigo.shade50, violet.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '2. Anatomy of a TextSpan tree',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: indigo.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Text.rich(
          anatomyTextSpan,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: indigo.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _treeLine('TextSpan(root)', 0, indigo.shade800,
                  'text="Hello ", style=indigo/16/bold'),
              _treeLine('├── TextSpan', 1, pink.shade500,
                  'text="beautiful ", italic, pink'),
              _treeLine('├── TextSpan', 1, violet.shade700,
                  'text="world", bold + underline'),
              _treeLine('└── TextSpan', 1, slate.shade700,
                  'text="!" (inherits root style)'),
            ],
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram ready');

  // ============================================================
  // SECTION 3: TextSpan basics — multiple styles in one paragraph
  // ============================================================
  print('=== Section 3: TextSpan basics ===');

  final basicsSpan = TextSpan(
    style: TextStyle(fontSize: 16.0, color: slate.shade900, height: 1.5),
    children: <InlineSpan>[
      TextSpan(text: 'A '),
      TextSpan(
        text: 'TextSpan',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: indigo.shade700,
        ),
      ),
      TextSpan(text: ' is a piece of '),
      TextSpan(
        text: 'styled',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: pink.shade500,
        ),
      ),
      TextSpan(text: ' text. It can mix '),
      TextSpan(
        text: 'colors',
        style: TextStyle(
          color: Colors.white,
          backgroundColor: violet.shade400,
        ),
      ),
      TextSpan(text: ', '),
      TextSpan(
        text: 'sizes',
        style: TextStyle(fontSize: 22.0, color: amber.shade800),
      ),
      TextSpan(text: ', '),
      TextSpan(
        text: 'fonts',
        style: TextStyle(
          fontFamily: 'monospace',
          color: teal.shade700,
        ),
      ),
      TextSpan(text: ', and '),
      TextSpan(
        text: 'decorations',
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: pink.shade400,
          decorationStyle: TextDecorationStyle.wavy,
          color: pink.shade700,
        ),
      ),
      TextSpan(text: ' inside one paragraph.'),
    ],
  );

  final basicsCard = _gradientCard(
    title: '3. TextSpan basics',
    icon: Icons.text_fields,
    color: violet,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(basicsSpan),
        SizedBox(height: 14.0),
        _captionRow('Single shaping pass — all glyphs share one Paragraph.',
            indigo.shade700),
      ],
    ),
  );
  print('Basics card ready');

  // ============================================================
  // SECTION 4: WidgetSpan — chips and avatars in text
  // ============================================================
  print('=== Section 4: WidgetSpan inline use ===');

  final widgetSpanSentence = TextSpan(
    style: TextStyle(fontSize: 16.0, color: slate.shade900, height: 1.6),
    children: <InlineSpan>[
      TextSpan(text: 'On Tuesday, '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _avatar('AK', indigo),
      ),
      TextSpan(
        text: ' Alexis ',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      TextSpan(text: 'shipped '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _miniChip('v1.4.2', violet),
      ),
      TextSpan(text: ' with '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: Icon(Icons.bolt, size: 18.0, color: amber.shade700),
      ),
      TextSpan(
        text: ' performance fixes ',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      TextSpan(text: 'and merged PR '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _miniChip('#412', teal),
      ),
      TextSpan(text: ' '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: Icon(Icons.check_circle, size: 18.0, color: Colors.green),
      ),
      TextSpan(text: '.'),
    ],
  );

  final widgetSpanCard = _gradientCard(
    title: '4. WidgetSpan in flowing text',
    icon: Icons.widgets,
    color: pink,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(widgetSpanSentence),
        SizedBox(height: 12.0),
        _captionRow(
          'WidgetSpan embeds a real Widget into text shaping via PlaceholderSpan.',
          pink.shade700,
        ),
      ],
    ),
  );
  print('WidgetSpan card ready');

  // ============================================================
  // SECTION 5: Nested TextSpan tree — 3 levels deep
  // ============================================================
  print('=== Section 5: Nested tree (3 levels) ===');

  final level3A = TextSpan(
    text: 'deeply ',
    style: TextStyle(
      color: pink.shade600,
      fontWeight: FontWeight.bold,
    ),
  );
  final level3B = TextSpan(
    text: 'nested',
    style: TextStyle(
      color: amber.shade800,
      decoration: TextDecoration.underline,
    ),
  );
  final level2A = TextSpan(
    text: 'this is ',
    style: TextStyle(fontStyle: FontStyle.italic, color: violet.shade600),
    children: <InlineSpan>[level3A, level3B],
  );
  final level2B = TextSpan(
    text: ' content ',
    style: TextStyle(color: teal.shade700),
  );
  final level1Root = TextSpan(
    text: 'Look — ',
    style: TextStyle(
      fontSize: 18.0,
      color: indigo.shade900,
      fontWeight: FontWeight.w600,
    ),
    children: <InlineSpan>[
      level2A,
      level2B,
      TextSpan(
        text: 'in a tree.',
        style: TextStyle(color: slate.shade800),
      ),
    ],
  );

  final nestedCard = _gradientCard(
    title: '5. Nested TextSpan — 3 levels',
    icon: Icons.account_tree,
    color: indigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(level1Root, style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _treeLine('Level 1: TextSpan("Look — ")', 0,
                  indigo.shade800, 'root, indigo bold'),
              _treeLine('├── Level 2: TextSpan("this is ")', 1,
                  violet.shade600, 'italic, violet'),
              _treeLine('│     ├── Level 3: TextSpan("deeply ")', 2,
                  pink.shade500, 'bold, pink'),
              _treeLine('│     └── Level 3: TextSpan("nested")', 2,
                  amber.shade800, 'underline, amber'),
              _treeLine('├── Level 2: TextSpan(" content ")', 1,
                  teal.shade700, 'teal'),
              _treeLine('└── Level 2: TextSpan("in a tree.")', 1,
                  slate.shade800, 'inherits root color'),
            ],
          ),
        ),
      ],
    ),
  );
  print('Nested card ready');

  // ============================================================
  // SECTION 6: Style inheritance — parent style + child override
  // ============================================================
  print('=== Section 6: Style inheritance ===');

  final inheritanceSpan = TextSpan(
    text: 'Parent gives ',
    style: TextStyle(
      color: violet.shade800,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    ),
    children: <InlineSpan>[
      TextSpan(
        text: 'inherited size and spacing ',
        // No style: fully inherits parent.
      ),
      TextSpan(
        text: 'unless ',
        style: TextStyle(color: pink.shade500),
      ),
      TextSpan(
        text: 'a child overrides',
        style: TextStyle(
          color: amber.shade800,
          fontSize: 22.0,
          fontWeight: FontWeight.w900,
        ),
      ),
      TextSpan(text: ' it.'),
    ],
  );

  final inheritanceCard = _gradientCard(
    title: '6. Style inheritance',
    icon: Icons.format_paint,
    color: amber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(inheritanceSpan),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _legendChip('Parent: violet 18 w600', violet),
            _legendChip('Override: amber 22 w900', amber),
            _legendChip('Override: pink', pink),
            _legendChip('Inherit (no style)', slate),
          ],
        ),
      ],
    ),
  );
  print('Inheritance card ready');

  // ============================================================
  // SECTION 7: visitChildren walk-through (illustrative diagram)
  // ============================================================
  print('=== Section 7: visitChildren walk ===');

  final walkChildren = <Widget>[];
  final walkSteps = <Map<String, dynamic>>[
    {'step': 1, 'text': 'visit root: "Look — "', 'color': indigo},
    {'step': 2, 'text': 'visit child: "this is "', 'color': violet},
    {'step': 3, 'text': 'visit child: "deeply "', 'color': pink},
    {'step': 4, 'text': 'visit child: "nested"', 'color': amber},
    {'step': 5, 'text': 'visit child: " content "', 'color': teal},
    {'step': 6, 'text': 'visit child: "in a tree."', 'color': slate},
  ];
  for (final s in walkSteps) {
    final step = s['step'] as int;
    final txt = s['text'] as String;
    final color = s['color'] as MaterialColor;
    walkChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 14.0,
              backgroundColor: color.shade400,
              child: Text(
                '$step',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                txt,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  color: color.shade900,
                ),
              ),
            ),
            Icon(Icons.east, color: color.shade700, size: 18.0),
          ],
        ),
      ),
    );
  }

  final visitCard = _gradientCard(
    title: '7. visitChildren — pre-order walk',
    icon: Icons.directions_walk,
    color: teal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'visitor returns false to abort. Used by hit-testing, semantics, '
          'and computeToPlainText.',
          style: TextStyle(fontSize: 13.0, color: slate.shade700),
        ),
        SizedBox(height: 12.0),
        Column(children: walkChildren),
      ],
    ),
  );
  print('visitChildren card ready');

  // ============================================================
  // SECTION 8: computeToPlainText output examples
  // ============================================================
  print('=== Section 8: computeToPlainText ===');

  final plainTextRows = <Widget>[
    _plainTextRow(
      'Anatomy span',
      anatomyTextSpan.toPlainText(),
      indigo,
    ),
    _plainTextRow(
      'Basics span',
      basicsSpan.toPlainText(),
      violet,
    ),
    _plainTextRow(
      'Nested 3-level',
      level1Root.toPlainText(),
      pink,
    ),
    _plainTextRow(
      'Inheritance',
      inheritanceSpan.toPlainText(),
      amber,
    ),
  ];

  final plainTextCard = _gradientCard(
    title: '8. computeToPlainText / toPlainText',
    icon: Icons.short_text,
    color: slate,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Flattens the entire tree into a single String, preserving order, '
          'ignoring style.',
          style: TextStyle(fontSize: 13.0, color: slate.shade700),
        ),
        SizedBox(height: 12.0),
        Column(children: plainTextRows),
      ],
    ),
  );
  print('PlainText card ready');

  // ============================================================
  // SECTION 9: Semantics — semanticsLabel and computeSemanticsInformation
  // ============================================================
  print('=== Section 9: Semantics ===');

  final priceSpan = TextSpan(
    style: TextStyle(fontSize: 18.0, color: slate.shade900),
    children: <InlineSpan>[
      TextSpan(text: 'Total: '),
      TextSpan(
        text: '\$1,299.00',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: violet.shade700,
        ),
        semanticsLabel: 'one thousand two hundred ninety-nine US dollars',
      ),
      TextSpan(text: ' billed monthly.'),
    ],
  );

  final phoneSpan = TextSpan(
    style: TextStyle(fontSize: 18.0, color: slate.shade900),
    children: <InlineSpan>[
      TextSpan(text: 'Call '),
      TextSpan(
        text: '(415) 555-0117',
        style: TextStyle(
          color: indigo.shade700,
          decoration: TextDecoration.underline,
        ),
        semanticsLabel: 'Call sales: four one five five five five zero one one seven',
      ),
      TextSpan(text: ' for sales.'),
    ],
  );

  final semanticsCard = _gradientCard(
    title: '9. Semantics overrides',
    icon: Icons.accessibility_new,
    color: Colors.green,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(priceSpan),
        SizedBox(height: 8.0),
        _semanticsHint(
          'Screen reader hears: "Total: one thousand two hundred ninety-nine '
          'US dollars billed monthly."',
          violet,
        ),
        SizedBox(height: 14.0),
        Text.rich(phoneSpan),
        SizedBox(height: 8.0),
        _semanticsHint(
          'Screen reader hears the digit-by-digit phone label.',
          indigo,
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Text(
            'computeSemanticsInformation gathers a flat list of '
            'InlineSpanSemanticsInformation, one per leaf — used by SemanticsNode.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.green.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Semantics card ready');

  // ============================================================
  // SECTION 10: Real-world mocks
  // ============================================================
  print('=== Section 10: Real-world mocks ===');

  // 10a. Notification bubble.
  final notificationSpan = TextSpan(
    style: TextStyle(fontSize: 14.0, color: slate.shade900, height: 1.5),
    children: <InlineSpan>[
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _avatar('JD', pink),
      ),
      TextSpan(
        text: '  Jane Doe ',
        style: TextStyle(fontWeight: FontWeight.bold, color: pink.shade700),
      ),
      TextSpan(text: 'replied to your post '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: Icon(Icons.reply, size: 16.0, color: pink.shade400),
      ),
      TextSpan(text: ' "Looks great! Ship it 🚀"  '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _timeBadge('2m', slate),
      ),
    ],
  );

  // 10b. Code with inline buttons.
  final codeSpan = TextSpan(
    style: TextStyle(
      fontFamily: 'monospace',
      fontSize: 14.0,
      color: indigo.shade900,
    ),
    children: <InlineSpan>[
      TextSpan(
        text: 'flutter ',
        style: TextStyle(color: violet.shade700),
      ),
      TextSpan(text: 'run '),
      TextSpan(
        text: '--release ',
        style: TextStyle(color: amber.shade800),
      ),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _inlineButton('copy', Icons.copy, indigo),
      ),
      TextSpan(text: '  '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _inlineButton('run', Icons.play_arrow, Colors.green),
      ),
    ],
  );

  // 10c. News article excerpt with inline pills.
  final newsSpan = TextSpan(
    style: TextStyle(fontSize: 15.0, color: slate.shade900, height: 1.55),
    children: <InlineSpan>[
      TextSpan(
        text: 'BREAKING: ',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: pink.shade700,
          letterSpacing: 1.2,
        ),
      ),
      TextSpan(text: 'The team announced a new release of '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _pill('Tom AI', violet),
      ),
      TextSpan(text: ' bringing improved '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _pill('semantics', teal),
      ),
      TextSpan(text: ' and faster '),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _pill('rich text', indigo),
      ),
      TextSpan(text: ' rendering across mobile and desktop targets.'),
    ],
  );

  // 10d. Emoji + text run.
  final emojiSpan = TextSpan(
    style: TextStyle(fontSize: 18.0, color: slate.shade900, height: 1.6),
    children: <InlineSpan>[
      TextSpan(text: 'Reactions: '),
      TextSpan(text: '👍 12 ', style: TextStyle(color: indigo.shade700)),
      TextSpan(text: '🎉 7 ', style: TextStyle(color: violet.shade600)),
      TextSpan(text: '❤️ 4 ', style: TextStyle(color: pink.shade500)),
      TextSpan(text: '🚀 2 ', style: TextStyle(color: amber.shade800)),
      WidgetSpan(
        alignment: ui.PlaceholderAlignment.middle,
        child: _inlineButton('react', Icons.add, teal),
      ),
    ],
  );

  final realWorldCard = _gradientCard(
    title: '10. Real-world mocks',
    icon: Icons.dashboard_customize,
    color: indigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _mockSection('Notification bubble', notificationSpan, pink),
        SizedBox(height: 14.0),
        _mockSection('Inline code with action buttons', codeSpan, indigo),
        SizedBox(height: 14.0),
        _mockSection('News excerpt with pills', newsSpan, violet),
        SizedBox(height: 14.0),
        _mockSection('Emoji + text run', emojiSpan, amber),
      ],
    ),
  );
  print('Real-world mocks ready');

  // ============================================================
  // SECTION 11: Comparison table — TextSpan vs WidgetSpan vs PlaceholderSpan
  // ============================================================
  print('=== Section 11: Comparison table ===');

  final compRows = <Widget>[
    _compHeader(),
    _compRow('Concrete?', 'yes', 'yes', 'no (abstract)', indigo),
    _compRow('Holds text?', 'yes (text)', 'no', 'no', violet),
    _compRow('Holds Widget?', 'no', 'yes (child)', 'no (interface)', pink),
    _compRow('Has children?', 'yes (List<InlineSpan>)', 'inherits', 'n/a', amber),
    _compRow('Has style?', 'yes', 'yes (text fallback)', 'yes', teal),
    _compRow('Has alignment?', 'no', 'PlaceholderAlignment', 'PlaceholderAlignment', indigo),
    _compRow('In single shaping pass?', 'yes', 'yes (placeholder)', 'yes', violet),
    _compRow('Use case', 'styled runs', 'inline widgets', 'base for placeholders', slate),
  ];

  final comparisonCard = _gradientCard(
    title: '11. TextSpan vs WidgetSpan vs PlaceholderSpan',
    icon: Icons.table_chart,
    color: violet,
    child: Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: violet.shade200),
      ),
      child: Column(children: compRows),
    ),
  );
  print('Comparison table ready');

  // ============================================================
  // SECTION 12: Footguns
  // ============================================================
  print('=== Section 12: Footguns ===');

  final footgun1 = _footgunBlock(
    title: 'Mixing text and children carelessly',
    body: 'TextSpan(text: "Hello", children: [TextSpan(text: "World")]) '
        'renders "HelloWorld". The text is the FIRST run, then children. '
        'Forgetting the order makes layouts that look right by accident.',
    color: pink,
    icon: Icons.warning_amber,
  );
  final footgun2 = _footgunBlock(
    title: 'GestureRecognizer leaks',
    body: 'Every TapGestureRecognizer attached via TextSpan(recognizer:) '
        'must be disposed. Leaking them is the #1 cause of memory growth '
        'in chat / notification feeds.',
    color: amber,
    icon: Icons.touch_app,
  );
  final footgun3 = _footgunBlock(
    title: 'Semantics with nested groups',
    body: 'semanticsLabel applies to a leaf TextSpan only. Wrapping a '
        'parent does NOT override children. Either label leaves '
        'individually, or wrap the whole RichText with Semantics(...).',
    color: indigo,
    icon: Icons.accessibility,
  );
  final footgun4 = _footgunBlock(
    title: 'Performance on huge spans',
    body: 'Building 10k+ children rebuilds the whole Paragraph on every '
        'frame. Cache the root TextSpan, paginate, or render to a '
        'TextPainter offscreen for static content.',
    color: violet,
    icon: Icons.speed,
  );

  final footgunCard = _gradientCard(
    title: '12. Footguns',
    icon: Icons.report_gmailerrorred,
    color: pink,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        footgun1,
        SizedBox(height: 12.0),
        footgun2,
        SizedBox(height: 12.0),
        footgun3,
        SizedBox(height: 12.0),
        footgun4,
      ],
    ),
  );
  print('Footguns card ready');

  // ============================================================
  // SECTION 13: Recap
  // ============================================================
  print('=== Section 13: Recap ===');

  final recapCard = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigo.shade600, violet.shade500, pink.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: violet.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.lightbulb, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              '13. Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recapLine('InlineSpan is the abstract base for rich-text runs.'),
        _recapLine('TextSpan = styled text + optional children + recognizer.'),
        _recapLine('WidgetSpan = inline Widget aligned within a text run.'),
        _recapLine('Children form a tree; styles cascade with overrides.'),
        _recapLine('toPlainText flattens; computeSemanticsInformation labels.'),
        _recapLine('All spans share one Paragraph in a single shaping pass.'),
        _recapLine('Watch recognizers, deep trees, and semantics scope.'),
      ],
    ),
  );
  print('Recap ready');

  // ============================================================
  // Final layout
  // ============================================================
  print('Building final layout');

  final layout = Scaffold(
    backgroundColor: Color(0xFFF5F4FB),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
          SizedBox(height: 18.0),
          anatomyDiagram,
          SizedBox(height: 18.0),
          basicsCard,
          SizedBox(height: 18.0),
          widgetSpanCard,
          SizedBox(height: 18.0),
          nestedCard,
          SizedBox(height: 18.0),
          inheritanceCard,
          SizedBox(height: 18.0),
          visitCard,
          SizedBox(height: 18.0),
          plainTextCard,
          SizedBox(height: 18.0),
          semanticsCard,
          SizedBox(height: 18.0),
          realWorldCard,
          SizedBox(height: 18.0),
          comparisonCard,
          SizedBox(height: 18.0),
          footgunCard,
          SizedBox(height: 18.0),
          recapCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );

  print('InlineSpan Deep Demo finished');
  return layout;
}

// ------------------------------------------------------------
// Helpers
// ------------------------------------------------------------

Widget _gradientCard({
  required String title,
  required IconData icon,
  required MaterialColor color,
  required Widget child,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.shade50,
          color.shade100.withValues(alpha: 0.7),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: color.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.shade400,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

Widget _treeLine(String label, int depth, Color color, String hint) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 16.0, top: 3.0, bottom: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            hint,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _captionRow(String text, Color color) {
  return Row(
    children: <Widget>[
      Icon(Icons.info_outline, size: 14.0, color: color),
      SizedBox(width: 6.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.0,
            color: color,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ],
  );
}

Widget _avatar(String initials, MaterialColor color) {
  return Container(
    width: 28.0,
    height: 28.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color.shade400, color.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.45),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      initials,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _miniChip(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade400, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        color: color.shade900,
        fontWeight: FontWeight.w600,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _legendChip(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.shade300),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color.shade500,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            color: color.shade900,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _plainTextRow(String label, String plain, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '"$plain"',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: color.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _semanticsHint(String text, MaterialColor color) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: color.shade400, width: 4.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.record_voice_over, color: color.shade700, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.0,
              color: color.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _timeBadge(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.0,
        color: color.shade800,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _inlineButton(String label, IconData icon, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color.shade400, color.shade600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 12.0),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _pill(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.shade500,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _mockSection(String title, TextSpan span, MaterialColor color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.10),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: color.shade500,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: color.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text.rich(span),
      ],
    ),
  );
}

Widget _compHeader() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade100,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        _compCell('Property', bold: true, width: 110.0),
        _compCell('TextSpan', bold: true, width: 80.0),
        _compCell('WidgetSpan', bold: true, width: 90.0),
        _compCell('PlaceholderSpan', bold: true, width: 110.0),
      ],
    ),
  );
}

Widget _compRow(
  String prop,
  String text,
  String widget,
  String placeholder,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: color.shade100, width: 1.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _compCell(prop, width: 110.0, bold: true, color: color.shade900),
        _compCell(text, width: 80.0, color: Colors.indigo.shade800),
        _compCell(widget, width: 90.0, color: Colors.deepPurple.shade800),
        _compCell(placeholder, width: 110.0, color: Colors.pink.shade800),
      ],
    ),
  );
}

Widget _compCell(
  String text, {
  required double width,
  bool bold = false,
  Color? color,
}) {
  return SizedBox(
    width: width,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color ?? Colors.black87,
        ),
      ),
    ),
  );
}

Widget _footgunBlock({
  required String title,
  required String body,
  required MaterialColor color,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color.shade500, width: 5.0),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color.shade700, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: color.shade900.withValues(alpha: 0.85),
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

Widget _recapLine(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.check_circle, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
