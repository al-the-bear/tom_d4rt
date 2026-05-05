// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: TooltipSemanticsEvent — "Tooltip Mauve" theme.
//
// This file is a hand-authored, deep visual reference for the
// `TooltipSemanticsEvent` class shipped from `package:flutter/semantics.dart`.
// The aesthetic is borrowed from a velvet-lined library reading room: deep
// mauve, whisper saffron highlights, and ink-slate edges. Every section in the
// rendered widget tree mirrors a chapter you might read in a printed manual,
// only with a single `dynamic build(BuildContext context)` entrypoint that
// returns a Scaffold — no main, no runApp, no setState, no animation
// controllers. The script is consumed by the d4rt sandbox, so we keep all
// state immutable and all loops index-based over bridged collections.
//
// The semantic engine in Flutter publishes a small family of `SemanticsEvent`
// subclasses. `TooltipSemanticsEvent` is the one that says: "the tooltip
// overlay just appeared — would the screen reader please read this short
// hint to the user?" The engine forwards a serialized payload to the host
// platform, where iOS VoiceOver and Android TalkBack take over and decide
// how aggressively to interrupt the current speech queue. This demo walks
// through that pipeline visually.
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ------------------------------------------------------------------
  // PALETTE — "Tooltip Mauve" / "Library Velvet" / "Whisper Saffron"
  // ------------------------------------------------------------------
  // Mauve forms the backbone of the page. Saffron is reserved for hints,
  // small icons, and tooltip-message highlights. Slate is the typography
  // and rule color. Cream is the "paper" of cards. Plum is reserved for
  // the hero badge and emphasis chips. Sage is used sparingly for
  // success / accessibility-OK markers.
  final Color mauveDeep = Color(0xFF3B2740);
  final Color mauveMid = Color(0xFF5C3F66);
  final Color mauveSoft = Color(0xFF8E6F9A);
  final Color saffron = Color(0xFFE2B23A);
  final Color saffronSoft = Color(0xFFF6D67A);
  final Color cream = Color(0xFFF7EEDC);
  final Color creamDark = Color(0xFFE8DCC2);
  final Color slate = Color(0xFF2A2330);
  final Color slateSoft = Color(0xFF564B5C);
  final Color plum = Color(0xFF7A2E58);
  final Color sage = Color(0xFF6F8E6A);
  final Color whisper = Color(0xFFEDE3F1);
  final Color ink = Color(0xFF1A121E);
  final Color rule = Color(0xFFB59FBE);

  // ------------------------------------------------------------------
  // CONSOLE NARRATION
  // ------------------------------------------------------------------
  print('=' * 60);
  print(' TooltipSemanticsEvent — Deep Visual Demo (Tooltip Mauve)');
  print('=' * 60);
  print('Palette: mauve | saffron | cream | slate | plum | sage');
  print('Theme  : Library Velvet — printed-manual reading room');
  print('Subject: TooltipSemanticsEvent(message)');
  print('Origin : package:flutter/semantics.dart');
  print('Parent : SemanticsEvent (abstract)');
  print('Carries: a single String payload `message`.');
  print('-' * 60);

  // ------------------------------------------------------------------
  // INSTANCE CONSTRUCTION (wrapped in try/catch per house rules)
  // ------------------------------------------------------------------
  String heroType = 'unknown';
  String heroMessage = 'unknown';
  String heroRuntime = 'unknown';
  Map<String, dynamic> heroMap = <String, dynamic>{};
  String heroError = '';
  try {
    final TooltipSemanticsEvent hero =
        TooltipSemanticsEvent('Save the current document');
    heroType = hero.type;
    heroMessage = hero.message;
    heroRuntime = hero.runtimeType.toString();
    heroMap = hero.toMap();
    print('Hero event constructed.');
    print('  runtimeType : $heroRuntime');
    print('  type        : $heroType');
    print('  message     : "$heroMessage"');
    print('  toMap()     : $heroMap');
  } catch (e) {
    heroError = e.toString();
    print('Hero construction failed: $heroError');
  }

  // A small gallery of additional payloads so we can compare how
  // various message lengths and locales serialise. Each is wrapped in
  // try/catch so a sandbox bridging hiccup never breaks the page.
  String shortType = '-';
  String shortMessage = '-';
  try {
    final TooltipSemanticsEvent e = TooltipSemanticsEvent('Help');
    shortType = e.type;
    shortMessage = e.message;
  } catch (e) {
    shortMessage = 'err: ${e.toString()}';
  }

  String mediumType = '-';
  String mediumMessage = '-';
  try {
    final TooltipSemanticsEvent e =
        TooltipSemanticsEvent('Open the velvet drawer');
    mediumType = e.type;
    mediumMessage = e.message;
  } catch (e) {
    mediumMessage = 'err: ${e.toString()}';
  }

  String longType = '-';
  String longMessage = '-';
  try {
    final TooltipSemanticsEvent e = TooltipSemanticsEvent(
      'Long-press to reveal the saffron-tinted secondary action menu, '
      'which lets you archive, duplicate or annotate the current entry.',
    );
    longType = e.type;
    longMessage = e.message;
  } catch (e) {
    longMessage = 'err: ${e.toString()}';
  }

  String emojiType = '-';
  String emojiMessage = '-';
  try {
    final TooltipSemanticsEvent e =
        TooltipSemanticsEvent('Bookmark this passage');
    emojiType = e.type;
    emojiMessage = e.message;
  } catch (e) {
    emojiMessage = 'err: ${e.toString()}';
  }

  String multiType = '-';
  String multiMessage = '-';
  try {
    final TooltipSemanticsEvent e = TooltipSemanticsEvent(
      'Speichern  •  保存  •  Сохранить  •  حفظ',
    );
    multiType = e.type;
    multiMessage = e.message;
  } catch (e) {
    multiMessage = 'err: ${e.toString()}';
  }

  String emptyType = '-';
  String emptyMessage = '-';
  try {
    final TooltipSemanticsEvent e = TooltipSemanticsEvent('');
    emptyType = e.type;
    emptyMessage = '«empty» (length=${e.message.length})';
  } catch (e) {
    emptyMessage = 'err: ${e.toString()}';
  }

  // ------------------------------------------------------------------
  // SHARED TEXT STYLES
  // ------------------------------------------------------------------
  final TextStyle headerStyle = TextStyle(
    color: cream,
    fontSize: 26,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.6,
  );
  final TextStyle subHeaderStyle = TextStyle(
    color: saffronSoft,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.4,
  );
  final TextStyle sectionTitleStyle = TextStyle(
    color: mauveDeep,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  );
  final TextStyle bodyStyle = TextStyle(
    color: slate,
    fontSize: 13.5,
    height: 1.45,
  );
  final TextStyle bodyEmphStyle = TextStyle(
    color: slate,
    fontSize: 13.5,
    height: 1.45,
    fontWeight: FontWeight.w700,
  );
  final TextStyle codeStyle = TextStyle(
    color: ink,
    fontSize: 12.5,
    fontFamily: 'monospace',
    height: 1.35,
  );
  final TextStyle tableHeaderStyle = TextStyle(
    color: cream,
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
  );
  final TextStyle tableCellStyle = TextStyle(
    color: slate,
    fontSize: 12.5,
    height: 1.4,
  );
  final TextStyle tableCellMonoStyle = TextStyle(
    color: ink,
    fontSize: 12,
    fontFamily: 'monospace',
    height: 1.4,
  );
  final TextStyle chipStyle = TextStyle(
    color: cream,
    fontSize: 11.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );
  final TextStyle pillStyle = TextStyle(
    color: plum,
    fontSize: 11.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );
  final TextStyle glossaryTermStyle = TextStyle(
    color: plum,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.3,
  );
  final TextStyle glossaryDefStyle = TextStyle(
    color: slate,
    fontSize: 12.5,
    height: 1.4,
  );
  final TextStyle asciiStyle = TextStyle(
    color: ink,
    fontSize: 12,
    fontFamily: 'monospace',
    height: 1.3,
  );

  // ==================================================================
  // 1. HERO CARD
  // ==================================================================
  final Widget heroCard = Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(28, 26, 28, 26),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[mauveDeep, mauveMid, plum],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: saffron, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: saffron,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('SEMANTICS  /  EVENT', style: pillStyle),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: cream.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: cream.withValues(alpha: 0.4)),
              ),
              child: Text('flutter/semantics.dart', style: chipStyle),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: sage,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('ACCESSIBLE', style: chipStyle),
            ),
          ],
        ),
        SizedBox(height: 18),
        Text('TooltipSemanticsEvent', style: headerStyle),
        SizedBox(height: 6),
        Text(
          'Whispered hints for the screen reader',
          style: subHeaderStyle,
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ink.withValues(alpha: 0.42),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: saffronSoft.withValues(alpha: 0.45)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'TooltipSemanticsEvent(',
                style: TextStyle(
                  color: saffronSoft,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              Text(
                '  "$heroMessage"',
                style: TextStyle(
                  color: cream,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              Text(
                ');',
                style: TextStyle(
                  color: saffronSoft,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '// runtimeType : $heroRuntime',
                style: TextStyle(
                  color: rule,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
              Text(
                '// type        : $heroType',
                style: TextStyle(
                  color: rule,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
              Text(
                '// toMap       : $heroMap',
                style: TextStyle(
                  color: rule,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        Text(
          'A single-purpose `SemanticsEvent` whose only job is to carry the '
          'human-readable text of a tooltip overlay so the host platform '
          'can announce it to assistive technologies.',
          style: TextStyle(
            color: cream.withValues(alpha: 0.92),
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  // 2. API SURFACE TABLE
  // ==================================================================
  final List<List<String>> apiRows = <List<String>>[
    <String>[
      'TooltipSemanticsEvent(message)',
      'constructor',
      'String message',
      'Builds the event with the given tooltip text.',
    ],
    <String>[
      'message',
      'final field',
      'String',
      'The text the screen reader should announce.',
    ],
    <String>[
      'type',
      'inherited getter',
      'String',
      'Always "tooltip" for this subclass.',
    ],
    <String>[
      'getDataMap()',
      'override',
      'Map<String, dynamic>',
      'Returns {"message": message} for the platform channel.',
    ],
    <String>[
      'toMap()',
      'inherited',
      'Map<String, dynamic>',
      'Wraps type + data map for serialization.',
    ],
    <String>[
      'runtimeType',
      'inherited',
      'Type',
      'Resolves to TooltipSemanticsEvent.',
    ],
    <String>[
      'toString()',
      'inherited',
      'String',
      'Diagnostic description (debug only).',
    ],
  ];

  final List<TableRow> apiTableRows = <TableRow>[];
  apiTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: mauveDeep),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Symbol', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Kind', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Type', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Description', style: tableHeaderStyle),
        ),
      ],
    ),
  );
  for (int i = 0; i < apiRows.length; i = i + 1) {
    final List<String> row = apiRows[i];
    final Color rowColor = (i % 2 == 0) ? cream : creamDark;
    apiTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowColor),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[0], style: tableCellMonoStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[1], style: tableCellStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[2], style: tableCellMonoStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[3], style: tableCellStyle),
          ),
        ],
      ),
    );
  }

  final Widget apiSurface = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: cream,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 6,
              height: 22,
              color: saffron,
            ),
            SizedBox(width: 10),
            Text('API surface', style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Every member exposed by `TooltipSemanticsEvent` and the '
          'parts it inherits from `SemanticsEvent`.',
          style: bodyStyle,
        ),
        SizedBox(height: 14),
        Table(
          columnWidths: <int, TableColumnWidth>{
            0: FlexColumnWidth(2.4),
            1: FlexColumnWidth(1.4),
            2: FlexColumnWidth(2.0),
            3: FlexColumnWidth(3.6),
          },
          border: TableBorder.all(color: rule, width: 0.6),
          children: apiTableRows,
        ),
      ],
    ),
  );

  // ==================================================================
  // 3. RELATED EVENTS CATALOGUE
  // ==================================================================
  final List<List<String>> relatedRows = <List<String>>[
    <String>[
      'TooltipSemanticsEvent',
      'tooltip',
      'message',
      'Reading a tooltip overlay aloud.',
      'Tooltip widget on long-press / hover.',
    ],
    <String>[
      'TapSemanticEvent',
      'tap',
      '—',
      'A "tap" gesture has been performed.',
      'Forwarded after a successful tap intent.',
    ],
    <String>[
      'LongPressSemanticsEvent',
      'longPress',
      '—',
      'A long-press gesture has occurred.',
      'Used for context-menu type interactions.',
    ],
    <String>[
      'AnnounceSemanticsEvent',
      'announce',
      'message + textDirection',
      'Generic announcement to the user.',
      'Use when no widget naturally describes the change.',
    ],
    <String>[
      'FocusSemanticEvent',
      'focus',
      '—',
      'Focus moved to a specific node.',
      'Forces the screen reader to refocus.',
    ],
  ];

  final List<TableRow> relatedTableRows = <TableRow>[];
  relatedTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: plum),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Subclass', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('type', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Payload', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Purpose', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Typical trigger', style: tableHeaderStyle),
        ),
      ],
    ),
  );
  for (int i = 0; i < relatedRows.length; i = i + 1) {
    final List<String> row = relatedRows[i];
    final bool highlight = (row[0] == 'TooltipSemanticsEvent');
    final Color rowColor = highlight
        ? saffronSoft.withValues(alpha: 0.55)
        : ((i % 2 == 0) ? cream : creamDark);
    relatedTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowColor),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              row[0],
              style: highlight ? bodyEmphStyle : tableCellMonoStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[1], style: tableCellMonoStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[2], style: tableCellStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[3], style: tableCellStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[4], style: tableCellStyle),
          ),
        ],
      ),
    );
  }

  final Widget relatedCatalogue = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: whisper,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 6,
              height: 22,
              color: plum,
            ),
            SizedBox(width: 10),
            Text('Related semantics events', style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'TooltipSemanticsEvent is one branch of the SemanticsEvent tree. '
          'These siblings each cover a different conversation between the '
          'engine and the assistive technology.',
          style: bodyStyle,
        ),
        SizedBox(height: 14),
        Table(
          columnWidths: <int, TableColumnWidth>{
            0: FlexColumnWidth(2.4),
            1: FlexColumnWidth(1.2),
            2: FlexColumnWidth(2.0),
            3: FlexColumnWidth(3.0),
            4: FlexColumnWidth(3.0),
          },
          border: TableBorder.all(color: rule, width: 0.6),
          children: relatedTableRows,
        ),
      ],
    ),
  );

  // ==================================================================
  // 4. TOOLTIP-MESSAGE GALLERY
  // ==================================================================
  final List<List<String>> galleryRows = <List<String>>[
    <String>['Short', shortType, shortMessage, '${shortMessage.length} chars'],
    <String>[
      'Medium',
      mediumType,
      mediumMessage,
      '${mediumMessage.length} chars',
    ],
    <String>['Long', longType, longMessage, '${longMessage.length} chars'],
    <String>[
      'Glyph-rich',
      emojiType,
      emojiMessage,
      '${emojiMessage.length} chars',
    ],
    <String>[
      'Multilingual',
      multiType,
      multiMessage,
      '${multiMessage.length} chars',
    ],
    <String>['Empty', emptyType, emptyMessage, '0 chars'],
  ];

  final List<Widget> galleryCards = <Widget>[];
  for (int i = 0; i < galleryRows.length; i = i + 1) {
    final List<String> row = galleryRows[i];
    final Color accent = (i % 2 == 0) ? saffron : plum;
    galleryCards.add(
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(color: accent, width: 5),
            top: BorderSide(color: rule, width: 0.6),
            right: BorderSide(color: rule, width: 0.6),
            bottom: BorderSide(color: rule, width: 0.6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    row[0].toUpperCase(),
                    style: TextStyle(
                      color: cream,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'type=${row[1]}',
                  style: TextStyle(
                    color: slateSoft,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  row[3],
                  style: TextStyle(color: slateSoft, fontSize: 11.5),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(row[2], style: codeStyle),
          ],
        ),
      ),
    );
  }

  final Widget gallery = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: cream,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: saffron),
            SizedBox(width: 10),
            Text('Tooltip-message gallery', style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Six handcrafted payloads ranging from a single-word hint to a '
          'multilingual concatenation. Each shows the resulting `type` '
          'string and the `message` string as recorded by the event.',
          style: bodyStyle,
        ),
        SizedBox(height: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: galleryCards,
        ),
      ],
    ),
  );

  // ==================================================================
  // 5. PLATFORM PROSE — VOICEOVER vs TALKBACK
  // ==================================================================
  final Widget platformPanel = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: whisper,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: mauveMid),
            SizedBox(width: 10),
            Text('iOS VoiceOver vs Android TalkBack',
                style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'The same TooltipSemanticsEvent travels through different host '
          'pipelines. iOS VoiceOver typically queues an "announcement" of '
          'the tooltip text without disturbing the currently focused '
          'element, whereas Android TalkBack tends to weave it directly '
          'into its live region announcement queue. The end-user effect '
          'feels similar, but the timing and interruption semantics '
          'differ in ways that matter for hint length.',
          style: bodyStyle,
        ),
        SizedBox(height: 14),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: rule, width: 0.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.phone_iphone, color: plum, size: 18),
                        SizedBox(width: 6),
                        Text('iOS VoiceOver', style: bodyEmphStyle),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Tooltip text is read after the currently focused '
                      'element finishes its label.\n'
                      '• Long messages are spoken in full at the queued '
                      'speech rate.\n'
                      '• A user can swipe to skip mid-sentence.\n'
                      '• "Speak Hints" must be enabled for tooltips that '
                      'mirror UIKit hints.',
                      style: bodyStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: rule, width: 0.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.android, color: sage, size: 18),
                        SizedBox(width: 6),
                        Text('Android TalkBack', style: bodyEmphStyle),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Tooltip arrives as an Accessibility announcement.\n'
                      '• TalkBack interrupts ongoing speech if the '
                      'announcement is marked assertive.\n'
                      '• On Android 11+, native tooltips also trigger an '
                      '"announce" event from the platform itself.\n'
                      '• Long messages may be truncated by user settings.',
                      style: bodyStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ==================================================================
  // 6. ASCII SEMANTICS TREE
  // ==================================================================
  final List<String> asciiTree = <String>[
    'PipelineOwner',
    '└─ SemanticsOwner',
    '   └─ SemanticsNode (root)',
    '      ├─ SemanticsNode  [AppBar      ]   "Library Velvet"',
    '      ├─ SemanticsNode  [Body        ]',
    '      │  ├─ SemanticsNode  [IconButton  ]   label="bookmark"',
    '      │  │  └─ Tooltip (descendant)',
    '      │  │     │  long-press detected',
    '      │  │     └─ sendSemanticsEvent(',
    '      │  │           TooltipSemanticsEvent("Bookmark this passage"),',
    '      │  │        );',
    '      │  ├─ SemanticsNode  [TextButton  ]   label="save"',
    '      │  │  └─ Tooltip (mouse hover)',
    '      │  │     └─ sendSemanticsEvent(',
    '      │  │           TooltipSemanticsEvent("Save the current document"),',
    '      │  │        );',
    '      │  └─ SemanticsNode  [TextField   ]   value="…"',
    '      │     └─ no tooltip — uses hint instead',
    '      └─ SemanticsNode  [BottomBar   ]',
    '',
    'Engine.dispatchSemanticsAction',
    '  → host platform channel "flutter/accessibility"',
    '    → iOS  : UIAccessibilityPostNotification(announcement, …)',
    '    → Android: AccessibilityNodeInfo.announceForAccessibility(…)',
  ];

  final List<Widget> asciiLines = <Widget>[];
  for (int i = 0; i < asciiTree.length; i = i + 1) {
    asciiLines.add(Text(asciiTree[i], style: asciiStyle));
  }

  final Widget asciiPanel = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: cream,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: mauveDeep),
            SizedBox(width: 10),
            Text('Semantics tree — emission diagram',
                style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Where a TooltipSemanticsEvent enters the semantic tree and how '
          'it leaves the engine on its way to the host platform.',
          style: bodyStyle,
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: creamDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: rule, width: 0.6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: asciiLines,
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  // 7. SCENARIO PANELS
  // ==================================================================
  final List<List<String>> scenarioRows = <List<String>>[
    <String>[
      'Button tooltip',
      'Save',
      '"Save the current document"',
      'Tooltip wraps an IconButton showing a floppy disk. On hover or '
          'long-press the overlay appears for 1.5 s and the engine emits a '
          'TooltipSemanticsEvent. The screen reader narrates the message '
          'and the visual overlay disappears on pointer exit.',
    ],
    <String>[
      'Icon tooltip',
      'Help',
      '"Open the velvet drawer"',
      'A small (?) icon next to a velvet-colored chip. The tooltip is the '
          'primary description for non-sighted users; the visual icon is '
          'mostly decorative. The TooltipSemanticsEvent provides the '
          'whole meaningful payload for the chip.',
    ],
    <String>[
      'Form-field hint',
      'Email',
      '"Use the email you registered with"',
      'A TextFormField with both a hint and a tooltip. The hint guides '
          'sighted users; the tooltip duplicates and extends the hint for '
          'screen-reader users. Both are wired up via Semantics so the '
          'announcement is consistent.',
    ],
    <String>[
      'Toolbar action',
      'Bookmark',
      '"Bookmark this passage"',
      'A bookmark icon in the reader toolbar. The Tooltip widget is used '
          'with a long-press duration of 800 ms to keep parity with iPad '
          'Pencil interactions. Each long-press produces a single event.',
    ],
  ];

  final List<Widget> scenarioCards = <Widget>[];
  for (int i = 0; i < scenarioRows.length; i = i + 1) {
    final List<String> row = scenarioRows[i];
    scenarioCards.add(
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rule, width: 0.7),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: mauveDeep,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(row[0], style: chipStyle),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: saffronSoft,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'label: ${row[1]}',
                    style: TextStyle(
                      color: mauveDeep,
                      fontWeight: FontWeight.w700,
                      fontSize: 11.5,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'tooltip: ${row[2]}',
                    style: TextStyle(
                      color: plum,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(row[3], style: bodyStyle),
          ],
        ),
      ),
    );
  }

  final Widget scenarios = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: whisper,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: plum),
            SizedBox(width: 10),
            Text('Scenario panels', style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Concrete situations where TooltipSemanticsEvent is emitted, '
          'with the corresponding visual label and the message that '
          'flows through the platform channel.',
          style: bodyStyle,
        ),
        SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: scenarioCards,
        ),
      ],
    ),
  );

  // ==================================================================
  // 8. PITFALLS PANEL
  // ==================================================================
  final List<List<String>> pitfalls = <List<String>>[
    <String>[
      'Overly long tooltips',
      'A 200-character tooltip will be read in full by VoiceOver, '
          'blocking the user from interacting until it finishes. '
          'Prefer a short summary; keep details in a dedicated help '
          'screen reachable through a separate semantic action.',
    ],
    <String>[
      'Nested tooltips',
      'Wrapping a Tooltip inside another Tooltip causes overlapping '
          'announcements. Only the outermost Tooltip should typically '
          'speak; the inner widget should rely on label / hint instead.',
    ],
    <String>[
      'Identical tooltip and label',
      'If the tooltip duplicates the visible label verbatim, screen '
          'readers will repeat the same word twice. Use the tooltip for '
          'extra context, never for redundancy.',
    ],
    <String>[
      'Tooltips on disabled controls',
      'Disabled buttons sometimes lose their semantic exposure. Ensure '
          'the Tooltip wrapper is on the parent Semantics node so the '
          'event is still emitted on focus or hover.',
    ],
    <String>[
      'Localisation drift',
      'A tooltip translated by a different team than the visible label '
          'can drift in tone or terminology. Make tooltip text part of '
          'the same translation memory as the label.',
    ],
    <String>[
      'Empty messages',
      'Constructing TooltipSemanticsEvent("") still emits an event with '
          'an empty payload. Most assistive technologies ignore it, but '
          'it generates platform channel traffic for nothing.',
    ],
    <String>[
      'High-frequency emission',
      'Tooltips that follow pointer movement (e.g. on a chart) can flood '
          'the announcement queue. Throttle by emitting at most one '
          'TooltipSemanticsEvent per logical hover episode.',
    ],
  ];

  final List<Widget> pitfallTiles = <Widget>[];
  for (int i = 0; i < pitfalls.length; i = i + 1) {
    final List<String> p = pitfalls[i];
    pitfallTiles.add(
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(color: plum, width: 5),
            top: BorderSide(color: rule, width: 0.6),
            right: BorderSide(color: rule, width: 0.6),
            bottom: BorderSide(color: rule, width: 0.6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.warning_amber_rounded, color: plum, size: 16),
                SizedBox(width: 6),
                Text(
                  'Pitfall ${i + 1} — ${p[0]}',
                  style: bodyEmphStyle,
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(p[1], style: bodyStyle),
          ],
        ),
      ),
    );
  }

  final Widget pitfallsPanel = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: creamDark.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: plum),
            SizedBox(width: 10),
            Text('Pitfalls', style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Things that look correct in code review but silently degrade '
          'the screen-reader experience.',
          style: bodyStyle,
        ),
        SizedBox(height: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: pitfallTiles,
        ),
      ],
    ),
  );

  // ==================================================================
  // 9. GLOSSARY
  // ==================================================================
  final List<List<String>> glossary = <List<String>>[
    <String>[
      'SemanticsEvent',
      'Abstract base class for events sent from the engine to the host '
          'platform via the accessibility channel. Each subclass picks a '
          '`type` string and a payload schema.',
    ],
    <String>[
      'TooltipSemanticsEvent',
      'A SemanticsEvent of type "tooltip" carrying a single `message` '
          'string. Emitted when a Tooltip overlay becomes visible.',
    ],
    <String>[
      'message',
      'The exact text that the screen reader should pronounce. It is '
          'usually identical to the visible tooltip text.',
    ],
    <String>[
      'type',
      'The string discriminator that the host platform reads to dispatch '
          'the event to the correct handler. For TooltipSemanticsEvent '
          'this is the literal "tooltip".',
    ],
    <String>[
      'getDataMap',
      'Returns the type-specific payload (here: {"message": message}). '
          'Combined with `type` to make `toMap`.',
    ],
    <String>[
      'toMap',
      'Final wrapper that produces {"type": type, "data": getDataMap()} '
          'for the platform channel.',
    ],
    <String>[
      'Tooltip',
      'The Material widget that owns the visual overlay and emits the '
          'event. It manages timing, gesture recognition and the call '
          'into `Semantics.sendSemanticsEvent`.',
    ],
    <String>[
      'VoiceOver',
      'Apple\'s screen reader on iOS, iPadOS, and macOS. It receives '
          'tooltip messages as accessibility announcements.',
    ],
    <String>[
      'TalkBack',
      'Google\'s screen reader on Android. It receives tooltip messages '
          'as live region announcements.',
    ],
    <String>[
      'Live region',
      'An accessibility concept where a region of the UI proactively '
          'announces changes to assistive technologies, even if the '
          'user has not focused it.',
    ],
    <String>[
      'Hint vs label',
      'A label names the control; a hint describes what happens when '
          'you act on it. Tooltips usually act as long-form hints.',
    ],
    <String>[
      'Announcement',
      'A one-shot statement sent to the screen reader without changing '
          'focus. Both TooltipSemanticsEvent and AnnounceSemanticsEvent '
          'ultimately become announcements on most platforms.',
    ],
  ];

  final List<Widget> glossaryTiles = <Widget>[];
  for (int i = 0; i < glossary.length; i = i + 1) {
    final List<String> g = glossary[i];
    glossaryTiles.add(
      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: Text(g[0], style: glossaryTermStyle),
            ),
            SizedBox(width: 10),
            Expanded(child: Text(g[1], style: glossaryDefStyle)),
          ],
        ),
      ),
    );
  }

  final Widget glossaryPanel = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: cream,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: mauveSoft),
            SizedBox(width: 10),
            Text('Glossary', style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: glossaryTiles,
        ),
      ],
    ),
  );

  // ==================================================================
  // 10. PALETTE SWATCHES
  // ==================================================================
  final List<List<dynamic>> swatches = <List<dynamic>>[
    <dynamic>['Mauve Deep', mauveDeep, '#3B2740', 'Hero gradient base'],
    <dynamic>['Mauve Mid', mauveMid, '#5C3F66', 'Hero gradient middle'],
    <dynamic>['Mauve Soft', mauveSoft, '#8E6F9A', 'Section accents'],
    <dynamic>['Plum', plum, '#7A2E58', 'Highlights and chips'],
    <dynamic>['Saffron', saffron, '#E2B23A', 'Tooltip-text emphasis'],
    <dynamic>['Saffron Soft', saffronSoft, '#F6D67A', 'Hover halos'],
    <dynamic>['Cream', cream, '#F7EEDC', 'Card body paper'],
    <dynamic>['Cream Dark', creamDark, '#E8DCC2', 'Alt rows'],
    <dynamic>['Whisper', whisper, '#EDE3F1', 'Section backdrop'],
    <dynamic>['Slate', slate, '#2A2330', 'Body text'],
    <dynamic>['Slate Soft', slateSoft, '#564B5C', 'Secondary text'],
    <dynamic>['Sage', sage, '#6F8E6A', 'Accessibility marker'],
    <dynamic>['Ink', ink, '#1A121E', 'Code blocks'],
    <dynamic>['Rule', rule, '#B59FBE', 'Dividers and borders'],
  ];

  final List<Widget> swatchTiles = <Widget>[];
  for (int i = 0; i < swatches.length; i = i + 1) {
    final List<dynamic> s = swatches[i];
    final String name = s[0] as String;
    final Color color = s[1] as Color;
    final String hex = s[2] as String;
    final String role = s[3] as String;
    swatchTiles.add(
      Container(
        width: 200,
        margin: EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: rule, width: 0.6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 38,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(name, style: bodyEmphStyle),
                  SizedBox(height: 2),
                  Text(
                    hex,
                    style: TextStyle(
                      color: slateSoft,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    role,
                    style: TextStyle(color: slateSoft, fontSize: 11.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget palettePanel = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: whisper,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: saffron),
            SizedBox(width: 10),
            Text('Palette swatches — Tooltip Mauve',
                style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Every named color used in this demo, with its hex code and '
          'where it is applied across the page.',
          style: bodyStyle,
        ),
        SizedBox(height: 14),
        Wrap(
          children: swatchTiles,
        ),
      ],
    ),
  );

  // ==================================================================
  // 11. TOOLTIP vs LABEL vs HINT vs VALUE
  // ==================================================================
  final List<List<String>> compareRows = <List<String>>[
    <String>[
      'tooltip',
      'TooltipSemanticsEvent',
      'Transient overlay text shown on hover / long-press.',
      'Read after the focused label; queued.',
      '"Save the current document"',
    ],
    <String>[
      'label',
      'SemanticsProperties.label',
      'Permanent name of the control.',
      'Read first when focused.',
      '"Save"',
    ],
    <String>[
      'hint',
      'SemanticsProperties.hint',
      'What happens when the user activates the control.',
      'Read after label, optional in some platforms.',
      '"Double tap to save"',
    ],
    <String>[
      'value',
      'SemanticsProperties.value',
      'Current state or content of the control.',
      'Read between label and hint.',
      '"unsaved changes"',
    ],
    <String>[
      'announce',
      'AnnounceSemanticsEvent',
      'Generic one-off announcement, not bound to a node.',
      'Read whenever it arrives, may interrupt.',
      '"3 results loaded"',
    ],
  ];

  final List<TableRow> compareTableRows = <TableRow>[];
  compareTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: mauveDeep),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Concept', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Carrier', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Meaning', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('When read', style: tableHeaderStyle),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Example', style: tableHeaderStyle),
        ),
      ],
    ),
  );
  for (int i = 0; i < compareRows.length; i = i + 1) {
    final List<String> row = compareRows[i];
    final bool highlight = (row[0] == 'tooltip');
    final Color rowColor = highlight
        ? saffronSoft.withValues(alpha: 0.55)
        : ((i % 2 == 0) ? cream : creamDark);
    compareTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowColor),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              row[0],
              style: highlight ? bodyEmphStyle : tableCellStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[1], style: tableCellMonoStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[2], style: tableCellStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[3], style: tableCellStyle),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row[4], style: tableCellMonoStyle),
          ),
        ],
      ),
    );
  }

  final Widget comparisonPanel = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: cream,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: mauveDeep),
            SizedBox(width: 10),
            Text('tooltip vs label vs hint vs value',
                style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Five overlapping but distinct ways a control can describe '
          'itself to assistive technologies. TooltipSemanticsEvent owns '
          'the "tooltip" lane.',
          style: bodyStyle,
        ),
        SizedBox(height: 14),
        Table(
          columnWidths: <int, TableColumnWidth>{
            0: FlexColumnWidth(1.4),
            1: FlexColumnWidth(2.2),
            2: FlexColumnWidth(3.0),
            3: FlexColumnWidth(2.4),
            4: FlexColumnWidth(2.2),
          },
          border: TableBorder.all(color: rule, width: 0.6),
          children: compareTableRows,
        ),
      ],
    ),
  );

  // ==================================================================
  // 12. PROGRESS HINT BAR (decorative, AlwaysStoppedAnimation)
  // ==================================================================
  final List<Widget> hintBars = <Widget>[];
  final List<double> hintLevels = <double>[0.15, 0.40, 0.65, 0.85, 1.0];
  final List<String> hintLabels = <String>[
    'short    (4 chars)',
    'medium   (~24 chars)',
    'long     (~120 chars)',
    'verbose  (~180 chars)',
    'extreme  (>=200 chars)',
  ];
  for (int i = 0; i < hintLevels.length; i = i + 1) {
    hintBars.add(
      Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Text(hintLabels[i],
                  style: TextStyle(
                    color: slate,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  )),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: AlwaysStoppedAnimation<double>(hintLevels[i]).value,
                  backgroundColor: creamDark,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    (hintLevels[i] >= 0.85) ? plum : saffron,
                  ),
                  minHeight: 12,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              '${(hintLevels[i] * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: slateSoft,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget hintBarPanel = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: whisper,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(width: 6, height: 22, color: saffron),
            SizedBox(width: 10),
            Text('Tooltip-message length budget',
                style: sectionTitleStyle),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'A rough budget for tooltip text length. Anything past 85% will '
          'visibly slow VoiceOver and TalkBack and probably annoy the user.',
          style: bodyStyle,
        ),
        SizedBox(height: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: hintBars,
        ),
      ],
    ),
  );

  // ==================================================================
  // 13. FOOTER SUMMARY
  // ==================================================================
  final Widget footer = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[mauveDeep, plum],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: saffron, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Summary',
          style: TextStyle(
            color: cream,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'TooltipSemanticsEvent is a small, single-purpose courier. It '
          'wraps a string and a discriminating "tooltip" type, then asks '
          'the host platform to whisper that string to whichever screen '
          'reader is listening. The Material Tooltip widget is its main '
          'caller; everything else (length budgeting, deduplication, '
          'localisation) is the application\'s responsibility.',
          style: TextStyle(
            color: cream.withValues(alpha: 0.94),
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: saffron,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('type = "$heroType"', style: pillStyle),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: cream.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: cream.withValues(alpha: 0.4)),
              ),
              child: Text(
                'message = "$heroMessage"',
                style: chipStyle,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ==================================================================
  // BODY ASSEMBLY
  // ==================================================================
  final List<Widget> bodyChildren = <Widget>[
    heroCard,
    SizedBox(height: 18),
    apiSurface,
    SizedBox(height: 18),
    relatedCatalogue,
    SizedBox(height: 18),
    gallery,
    SizedBox(height: 18),
    platformPanel,
    SizedBox(height: 18),
    asciiPanel,
    SizedBox(height: 18),
    scenarios,
    SizedBox(height: 18),
    pitfallsPanel,
    SizedBox(height: 18),
    hintBarPanel,
    SizedBox(height: 18),
    comparisonPanel,
    SizedBox(height: 18),
    glossaryPanel,
    SizedBox(height: 18),
    palettePanel,
    SizedBox(height: 18),
    footer,
  ];

  final Widget body = SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(22, 22, 22, 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: bodyChildren,
    ),
  );

  print('-' * 60);
  print('Visual demo assembled with ${bodyChildren.length} top-level slots.');
  print('Hero message length : ${heroMessage.length}');
  print('Long  message length: ${longMessage.length}');
  print('Multi message length: ${multiMessage.length}');
  print('=' * 60);
  print(' TooltipSemanticsEvent — demo build complete');
  print('=' * 60);

  return Scaffold(
    backgroundColor: whisper,
    appBar: AppBar(
      backgroundColor: mauveDeep,
      elevation: 0,
      title: Text(
        'TooltipSemanticsEvent — Tooltip Mauve',
        style: TextStyle(
          color: cream,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
      iconTheme: IconThemeData(color: saffron),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: saffron,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('LIBRARY VELVET', style: pillStyle),
            ),
          ),
        ),
      ],
    ),
    body: body,
  );
}
