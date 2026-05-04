// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for InlineSpanSemanticsInformation from
// package:flutter/painting.dart (re-exported via material).
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('InlineSpanSemanticsInformation Deep Demo executing');

  // Theme palette: semantic-purple + teal accents.
  final purple = Colors.purple;
  final deepPurple = Colors.deepPurple;
  final teal = Colors.teal;
  final amber = Colors.amber;
  final indigo = Colors.indigo;

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          deepPurple.shade700,
          purple.shade500,
          teal.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: teal.withValues(alpha: 0.3),
          blurRadius: 30.0,
          offset: Offset(0.0, 16.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.record_voice_over, size: 56.0, color: Colors.white),
        SizedBox(height: 8.0),
        Text(
          'InlineSpanSemanticsInformation',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.0),
        Text(
          'Accessibility descriptors for InlineSpan trees',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.85),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20.0),
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

  // ============================================================
  // SECTION 2: Anatomy of the descriptor
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyInfo = InlineSpanSemanticsInformation(
    'Read more',
    isPlaceholder: false,
    semanticsLabel: 'Read the full article',
    stringAttributes: <ui.StringAttribute>[],
  );
  print('Anatomy info text: ${anatomyInfo.text}');
  print('Anatomy info label: ${anatomyInfo.semanticsLabel}');

  final anatomyFields = <Map<String, dynamic>>[
    <String, dynamic>{
      'field': 'text',
      'type': 'String',
      'value': "'Read more'",
      'icon': Icons.text_fields,
      'color': purple,
      'desc': 'Visible glyphs of this span',
    },
    <String, dynamic>{
      'field': 'isPlaceholder',
      'type': 'bool',
      'value': 'false',
      'icon': Icons.toggle_off,
      'color': teal,
      'desc': 'true for WidgetSpan inserts',
    },
    <String, dynamic>{
      'field': 'semanticsLabel',
      'type': 'String?',
      'value': "'Read the full article'",
      'icon': Icons.label,
      'color': indigo,
      'desc': 'Override read out by screen readers',
    },
    <String, dynamic>{
      'field': 'stringAttributes',
      'type': 'List<StringAttribute>',
      'value': '<StringAttribute>[]',
      'icon': Icons.format_list_bulleted,
      'color': amber,
      'desc': 'Spell-out / locale per range',
    },
    <String, dynamic>{
      'field': 'recognizer',
      'type': 'GestureRecognizer?',
      'value': 'null',
      'icon': Icons.touch_app,
      'color': Colors.pink,
      'desc': 'Tap target for inline links',
    },
  ];

  final anatomyRows = <Widget>[];
  for (final f in anatomyFields) {
    final color = f['color'] as MaterialColor;
    anatomyRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.shade50,
              color.shade100,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade300, width: 1.0),
        ),
        child: Row(
          children: [
            Icon(f['icon'] as IconData, color: color.shade700, size: 22.0),
            SizedBox(width: 10.0),
            SizedBox(
              width: 130.0,
              child: Text(
                f['field'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: color.shade900,
                ),
              ),
            ),
            SizedBox(
              width: 150.0,
              child: Text(
                f['type'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                f['desc'] as String,
                style: TextStyle(fontSize: 11.0, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final anatomyCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: purple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: purple.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: deepPurple, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Five fields, one descriptor',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...anatomyRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Constructor variants (4 cards)
  // ============================================================
  print('=== Section 3: Constructor Variants ===');

  final plainInfo = InlineSpanSemanticsInformation(
    'Hello world',
    stringAttributes: <ui.StringAttribute>[],
  );
  final labelledInfo = InlineSpanSemanticsInformation(
    'OMG',
    semanticsLabel: 'Oh my goodness',
    stringAttributes: <ui.StringAttribute>[],
  );
  final placeholderInfo = InlineSpanSemanticsInformation(
    '\uFFFC',
    isPlaceholder: true,
    stringAttributes: <ui.StringAttribute>[],
  );
  final tapRecognizer = TapGestureRecognizer();
  final recognizerInfo = InlineSpanSemanticsInformation(
    'Open link',
    recognizer: tapRecognizer,
    stringAttributes: <ui.StringAttribute>[],
  );

  print('plainInfo.text=${plainInfo.text}');
  print('labelledInfo.semanticsLabel=${labelledInfo.semanticsLabel}');
  print('placeholderInfo.isPlaceholder=${placeholderInfo.isPlaceholder}');
  print('recognizerInfo.recognizer != null = '
      '${recognizerInfo.recognizer != null}');

  final variantCards = <Widget>[
    _buildVariantCard(
      'Plain text',
      plainInfo,
      "InlineSpanSemanticsInformation('Hello world')",
      Icons.text_snippet,
      purple,
    ),
    _buildVariantCard(
      'With semanticsLabel',
      labelledInfo,
      "InlineSpanSemanticsInformation(\n  'OMG',\n  semanticsLabel: 'Oh my goodness',\n)",
      Icons.label_important,
      indigo,
    ),
    _buildVariantCard(
      'Placeholder',
      placeholderInfo,
      "InlineSpanSemanticsInformation(\n  '\\uFFFC',\n  isPlaceholder: true,\n)",
      Icons.widgets,
      teal,
    ),
    _buildVariantCard(
      'With recognizer',
      recognizerInfo,
      "InlineSpanSemanticsInformation(\n  'Open link',\n  recognizer: TapGestureRecognizer(),\n)",
      Icons.touch_app,
      Colors.pink,
    ),
  ];

  // ============================================================
  // SECTION 4: The placeholder constant
  // ============================================================
  print('=== Section 4: Placeholder Constant ===');

  final placeholderConst = InlineSpanSemanticsInformation.placeholder;
  print('placeholder.text codeUnit = ${placeholderConst.text.codeUnitAt(0)}');
  print('placeholder.isPlaceholder = ${placeholderConst.isPlaceholder}');

  final placeholderCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [teal.shade100, teal.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: teal.shade700, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: teal.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop_square, color: teal.shade900, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'InlineSpanSemanticsInformation.placeholder',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: teal.shade900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: teal.shade700, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                placeholderConst.text,
                style: TextStyle(
                  fontSize: 40.0,
                  color: teal.shade900,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKv('text', "'\\uFFFC' (object replacement)"),
                  _buildKv(
                    'codeUnit',
                    placeholderConst.text.codeUnitAt(0).toString(),
                  ),
                  _buildKv(
                    'isPlaceholder',
                    placeholderConst.isPlaceholder.toString(),
                  ),
                  _buildKv(
                    'semanticsLabel',
                    '${placeholderConst.semanticsLabel}',
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Each WidgetSpan in a paragraph contributes one '
            'InlineSpanSemanticsInformation whose text is U+FFFC. The text '
            'painter and accessibility tree use this single glyph to reserve '
            'an index inside the run while the actual widget is laid out '
            'separately.',
            style: TextStyle(fontSize: 12.0, color: Colors.black87),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Real getSemanticsInformation() showcase
  // ============================================================
  print('=== Section 5: Real getSemanticsInformation() ===');

  final richSpan = TextSpan(
    children: <InlineSpan>[
      TextSpan(
        text: 'Hello ',
        style: TextStyle(color: deepPurple, fontWeight: FontWeight.bold),
      ),
      WidgetSpan(
        child: Icon(Icons.star, color: amber, size: 16.0),
      ),
      TextSpan(
        text: ' world',
        style: TextStyle(color: teal.shade700),
      ),
    ],
  );

  final List<InlineSpanSemanticsInformation> infos =
      richSpan.getSemanticsInformation();
  print('Got ${infos.length} InlineSpanSemanticsInformation entries');

  final infoRows = <Widget>[];
  for (int i = 0; i < infos.length; i++) {
    final info = infos[i];
    print('  [$i] text=${info.text} isPlaceholder=${info.isPlaceholder}');
    infoRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: info.isPlaceholder ? teal.shade50 : purple.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: info.isPlaceholder ? teal.shade400 : purple.shade300,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: info.isPlaceholder ? teal : purple,
                borderRadius: BorderRadius.circular(14.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '$i',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.isPlaceholder
                        ? 'placeholder (U+FFFC)'
                        : "text: '${info.text}'",
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'isPlaceholder=${info.isPlaceholder} '
                    'len=${info.text.length}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade700,
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

  final richShowcase = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 3.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Live Text.rich(...)',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: indigo.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text.rich(richSpan, style: TextStyle(fontSize: 18.0)),
        ),
        SizedBox(height: 12.0),
        Text(
          'getSemanticsInformation() →',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: indigo.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        ...infoRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: semanticsLabel override
  // ============================================================
  print('=== Section 6: semanticsLabel override ===');

  final emojiRaw = InlineSpanSemanticsInformation(
    '🎉',
    stringAttributes: <ui.StringAttribute>[],
  );
  final emojiLabelled = InlineSpanSemanticsInformation(
    '🎉',
    semanticsLabel: 'celebration',
    stringAttributes: <ui.StringAttribute>[],
  );
  print('emojiRaw.semanticsLabel=${emojiRaw.semanticsLabel}');
  print('emojiLabelled.semanticsLabel=${emojiLabelled.semanticsLabel}');

  final overrideCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amber.shade100, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: amber.shade700, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amber.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.2),
          blurRadius: 16.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.hearing, color: Colors.orange.shade900, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'How a screen reader hears it',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _buildHearingCard(
              'Without label',
              emojiRaw,
              'reads "party popper" or nothing on some platforms',
              Colors.red,
            ),
            _buildHearingCard(
              'With label',
              emojiLabelled,
              'reads "celebration" — author-controlled',
              Colors.green,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: StringAttribute timeline strip
  // ============================================================
  print('=== Section 7: StringAttribute timeline ===');

  final spellAttr = ui.SpellOutStringAttribute(
    range: TextRange(start: 0, end: 3),
  );
  final localeAttr = ui.LocaleStringAttribute(
    range: TextRange(start: 4, end: 11),
    locale: Locale('fr', 'FR'),
  );
  final attrs = <ui.StringAttribute>[spellAttr, localeAttr];
  final attrInfo = InlineSpanSemanticsInformation(
    'IBM bonjour',
    stringAttributes: attrs,
  );
  print('attrInfo.text=${attrInfo.text} attrCount=${attrInfo.stringAttributes.length}');

  final timelineSegments = <Widget>[
    _buildTimelineSegment(
      'IBM',
      'SpellOutStringAttribute',
      '0..3 — read letter by letter',
      Colors.deepOrange,
    ),
    _buildTimelineSegment(
      ' ',
      'no attribute',
      'normal speech',
      Colors.grey,
    ),
    _buildTimelineSegment(
      'bonjour',
      'LocaleStringAttribute',
      '4..11 — fr_FR pronunciation',
      Colors.blue,
    ),
  ];

  final timelineCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: deepPurple.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: deepPurple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              "stringAttributes on 'IBM bonjour'",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: deepPurple.shade900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: timelineSegments,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Indexes are character offsets within InlineSpanSemanticsInformation.text. '
          'Multiple attributes may overlap; each is delivered to the platform '
          'accessibility layer independently.',
          style: TextStyle(fontSize: 11.0, color: Colors.black87),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Pipeline diagram
  // ============================================================
  print('=== Section 8: Pipeline ===');

  final pipelineCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          deepPurple.shade100,
          purple.shade100,
          teal.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: deepPurple.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.3),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: teal.withValues(alpha: 0.2),
          blurRadius: 24.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Accessibility Pipeline',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: deepPurple.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildPipelineStep(
          1,
          'Text / Text.rich',
          'Author writes a TextSpan tree with TextSpan + WidgetSpan children',
          Icons.edit_note,
          purple,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          2,
          'InlineSpan tree',
          'Flutter walks the tree during paragraph layout',
          Icons.account_tree,
          deepPurple,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          3,
          'getSemanticsInformation()',
          'Returns List<InlineSpanSemanticsInformation> in document order',
          Icons.list_alt,
          indigo,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          4,
          'SemanticsNode',
          'RenderParagraph aggregates the list into the SemanticsNode for the run',
          Icons.hub,
          teal,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          5,
          'Platform a11y',
          'TalkBack / VoiceOver / NVDA consume label + attributes + recognizers',
          Icons.accessibility_new,
          Colors.green,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final footguns = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Emoji without semanticsLabel',
      'icon': Icons.emoji_emotions,
      'color': Colors.red,
      'desc':
          "Text('🎉') alone gives screen readers no useful name. Always set "
              "semanticsLabel: 'celebration' or wrap in Semantics(label: ...).",
    },
    <String, dynamic>{
      'title': 'WidgetSpan without isPlaceholder',
      'icon': Icons.widgets_outlined,
      'color': Colors.deepOrange,
      'desc':
          'Custom InlineSpan subclasses that wrap widgets must yield '
              'isPlaceholder: true and text == U+FFFC, otherwise the index alignment '
              'between glyphs and widgets breaks.',
    },
    <String, dynamic>{
      'title': 'StringAttribute range mismatch',
      'icon': Icons.compare_arrows,
      'color': Colors.purple,
      'desc':
          'A StringAttribute range must lie within text.length of THIS '
              'descriptor — not the whole rich text. Off-by-one ranges silently '
              'drop on some platforms.',
    },
    <String, dynamic>{
      'title': 'Recognizer lifecycle leaks',
      'icon': Icons.cleaning_services,
      'color': Colors.teal,
      'desc':
          'TapGestureRecognizer attached via the recognizer field must be '
              'disposed when the owning span is replaced; semantics keeps a '
              'reference until then.',
    },
  ];

  final footgunRows = <Widget>[];
  for (final fg in footguns) {
    final c = fg['color'] as MaterialColor;
    footgunRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [c.shade50, c.shade100],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: c.shade400, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.2),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(fg['icon'] as IconData, color: c.shade700, size: 26.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: c.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['desc'] as String,
                    style: TextStyle(fontSize: 11.0, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 10: Recap
  // ============================================================
  print('=== Section 10: Recap ===');

  final recapCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          deepPurple.shade400,
          purple.shade300,
          teal.shade300,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: deepPurple.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: teal.withValues(alpha: 0.3),
          blurRadius: 28.0,
          offset: Offset(0.0, 16.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Key Takeaways',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildBullet('A descriptor — not a widget. Five fields, no behaviour.'),
        _buildBullet('Always returned in document order from getSemanticsInformation().'),
        _buildBullet('Placeholder entries carry U+FFFC and isPlaceholder=true.'),
        _buildBullet('semanticsLabel is the screen-reader override; prefer it for emoji/icons.'),
        _buildBullet('stringAttributes attach per-range hints (spell-out, locale).'),
        _buildBullet('recognizer wires inline tap targets through the semantics tree.'),
        _buildBullet('Use InlineSpanSemanticsInformation.placeholder for any custom WidgetSpan-like span.'),
      ],
    ),
  );

  print('InlineSpanSemanticsInformation Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 1
          titleBanner,
          SizedBox(height: 24.0),
          // 2
          _buildSectionHeader('1. Anatomy of the descriptor', deepPurple),
          SizedBox(height: 8.0),
          anatomyCard,
          SizedBox(height: 24.0),
          // 3
          _buildSectionHeader('2. Constructor variants', purple),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: variantCards,
          ),
          SizedBox(height: 24.0),
          // 4
          _buildSectionHeader('3. The .placeholder constant', teal),
          SizedBox(height: 8.0),
          placeholderCard,
          SizedBox(height: 24.0),
          // 5
          _buildSectionHeader('4. getSemanticsInformation() in action', indigo),
          SizedBox(height: 8.0),
          richShowcase,
          SizedBox(height: 24.0),
          // 6
          _buildSectionHeader('5. semanticsLabel override', amber),
          SizedBox(height: 8.0),
          overrideCard,
          SizedBox(height: 24.0),
          // 7
          _buildSectionHeader('6. StringAttribute timeline', deepPurple),
          SizedBox(height: 8.0),
          timelineCard,
          SizedBox(height: 24.0),
          // 8
          _buildSectionHeader('7. Accessibility pipeline', purple),
          SizedBox(height: 8.0),
          pipelineCard,
          SizedBox(height: 24.0),
          // 9
          _buildSectionHeader('8. Footguns', Colors.red),
          SizedBox(height: 8.0),
          ...footgunRows,
          SizedBox(height: 24.0),
          // 10
          _buildSectionHeader('9. Recap', deepPurple),
          SizedBox(height: 8.0),
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

Widget _buildSectionHeader(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade700, color.shade400],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _buildVariantCard(
  String title,
  InlineSpanSemanticsInformation info,
  String code,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    width: 230.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, color.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color.shade700, size: 22.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.5,
              color: color.shade100,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        _buildKv('text', "'${info.text}'"),
        _buildKv('isPlaceholder', info.isPlaceholder.toString()),
        _buildKv('semanticsLabel', '${info.semanticsLabel}'),
        _buildKv('recognizer', info.recognizer == null ? 'null' : 'set'),
      ],
    ),
  );
}

Widget _buildKv(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHearingCard(
  String title,
  InlineSpanSemanticsInformation info,
  String hearing,
  MaterialColor color,
) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: color.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(info.text, style: TextStyle(fontSize: 32.0)),
        ),
        SizedBox(height: 8.0),
        _buildKv('text', "'${info.text}'"),
        _buildKv('semanticsLabel', '${info.semanticsLabel}'),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Icon(Icons.volume_up, color: color.shade700, size: 16.0),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(
                hearing,
                style: TextStyle(
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTimelineSegment(
  String text,
  String attrName,
  String range,
  MaterialColor color,
) {
  return Expanded(
    flex: text.isEmpty ? 1 : text.length,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[color.shade100, color.shade300],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.shade700, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "'$text'",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            attrName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            range,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 8.5, color: Colors.black87),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPipelineStep(
  int n,
  String title,
  String desc,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade400, width: 1.5),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[color.shade400, color.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
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
        SizedBox(width: 10.0),
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
              Text(
                desc,
                style: TextStyle(fontSize: 10.5, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipelineArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Icon(
      Icons.arrow_downward,
      color: Colors.deepPurple.shade700,
      size: 20.0,
    ),
  );
}

Widget _buildBullet(String text) {
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
              fontSize: 12.5,
              color: Colors.white,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}
