// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextEditingDeltaInsertion from services
// Deep Demo: Visual demonstration of IME insertion deltas, anatomy,
// composing ranges, sibling delta types, and apply() flow.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextEditingDeltaInsertion Deep Demo executing');

  // ============================================================
  // Palette
  // ============================================================
  final indigoDeep = Color(0xFF1A237E);
  final indigoMid = Color(0xFF3949AB);
  final indigoSoft = Color(0xFFE8EAF6);
  final tealDeep = Color(0xFF00695C);
  final tealMid = Color(0xFF26A69A);
  final tealSoft = Color(0xFFE0F2F1);
  final cream = Color(0xFFFFF8E1);
  final creamSoft = Color(0xFFFFFDF5);
  final ink = Color(0xFF263238);
  final mute = Color(0xFF607D8B);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigoDeep, indigoMid, tealMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: tealMid.withValues(alpha: 0.25),
          blurRadius: 12.0,
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
                color: cream.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: cream.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.text_fields,
                size: 36.0,
                color: cream,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TextEditingDeltaInsertion',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: cream,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'IME-driven text insertion delta',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: cream.withValues(alpha: 0.85),
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
            border: Border.all(
              color: cream.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.code, size: 16.0, color: tealSoft),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'package:flutter/services.dart  ·  extends TextEditingDelta',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: tealSoft,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Built title banner');

  // ============================================================
  // SECTION 2: Anatomy of TextEditingDeltaInsertion
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyDelta = TextEditingDeltaInsertion(
    oldText: 'Hello',
    textInserted: ' World',
    insertionOffset: 5,
    selection: TextSelection.collapsed(offset: 11),
    composing: TextRange.empty,
  );
  print('Anatomy delta: ${anatomyDelta.runtimeType}');
  print('  oldText="${anatomyDelta.oldText}"');
  print('  textInserted="${anatomyDelta.textInserted}"');
  print('  insertionOffset=${anatomyDelta.insertionOffset}');

  final anatomyCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [creamSoft, cream],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoMid.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigoMid.withValues(alpha: 0.18),
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
            Icon(Icons.account_tree, color: indigoDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of an Insertion Delta',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: indigoDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _anatomyRow(
          'oldText',
          '"${anatomyDelta.oldText}"',
          'Document text BEFORE the insertion',
          Icons.history,
          indigoMid,
        ),
        SizedBox(height: 10.0),
        _anatomyRow(
          'textInserted',
          '"${anatomyDelta.textInserted}"',
          'String produced by the IME / keyboard',
          Icons.text_increase,
          tealDeep,
        ),
        SizedBox(height: 10.0),
        _anatomyRow(
          'insertionOffset',
          '${anatomyDelta.insertionOffset}',
          'UTF-16 index where the inserted text begins',
          Icons.place,
          Color(0xFFD84315),
        ),
        SizedBox(height: 10.0),
        _anatomyRow(
          'selection',
          'collapsed @ ${anatomyDelta.selection.baseOffset}',
          'New caret / range AFTER applying the delta',
          Icons.highlight_alt,
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 10.0),
        _anatomyRow(
          'composing',
          anatomyDelta.composing.isValid
              ? '${anatomyDelta.composing.start}…${anatomyDelta.composing.end}'
              : 'TextRange.empty',
          'Range of in-progress IME composition (underline)',
          Icons.edit_note,
          Color(0xFF00838F),
        ),
      ],
    ),
  );
  print('Built anatomy card');

  // ============================================================
  // SECTION 3: Six instance gallery
  // ============================================================
  print('=== Section 3: Instance Gallery ===');

  final galleryDeltas = <Map<String, dynamic>>[
    {
      'label': 'Empty → "H"',
      'icon': Icons.start,
      'color': indigoDeep,
      'delta': TextEditingDeltaInsertion(
        oldText: '',
        textInserted: 'H',
        insertionOffset: 0,
        selection: TextSelection.collapsed(offset: 1),
        composing: TextRange.empty,
      ),
      'note': 'First keystroke into an empty field',
    },
    {
      'label': '"Hello" → "Hello!"',
      'icon': Icons.priority_high,
      'color': tealDeep,
      'delta': TextEditingDeltaInsertion(
        oldText: 'Hello',
        textInserted: '!',
        insertionOffset: 5,
        selection: TextSelection.collapsed(offset: 6),
        composing: TextRange.empty,
      ),
      'note': 'Append a single punctuation glyph',
    },
    {
      'label': 'Multi-char paste',
      'icon': Icons.content_paste,
      'color': Color(0xFF6A1B9A),
      'delta': TextEditingDeltaInsertion(
        oldText: 'Hi ',
        textInserted: 'there, friend',
        insertionOffset: 3,
        selection: TextSelection.collapsed(offset: 16),
        composing: TextRange.empty,
      ),
      'note': 'Clipboard paste of a long substring',
    },
    {
      'label': 'Emoji insert',
      'icon': Icons.emoji_emotions,
      'color': Color(0xFFEF6C00),
      'delta': TextEditingDeltaInsertion(
        oldText: 'love',
        textInserted: '😀',
        insertionOffset: 4,
        selection: TextSelection.collapsed(offset: 6),
        composing: TextRange.empty,
      ),
      'note': 'Surrogate pair: 1 glyph = 2 UTF-16 units',
    },
    {
      'label': 'IME composing "n"',
      'icon': Icons.translate,
      'color': Color(0xFF00838F),
      'delta': TextEditingDeltaInsertion(
        oldText: '',
        textInserted: 'n',
        insertionOffset: 0,
        selection: TextSelection.collapsed(offset: 1),
        composing: TextRange(start: 0, end: 1),
      ),
      'note': 'Pinyin pre-edit; composing range live',
    },
    {
      'label': 'RTL Hebrew insert',
      'icon': Icons.format_textdirection_r_to_l,
      'color': Color(0xFFC2185B),
      'delta': TextEditingDeltaInsertion(
        oldText: '',
        textInserted: 'שלום',
        insertionOffset: 0,
        selection: TextSelection.collapsed(offset: 4),
        composing: TextRange.empty,
      ),
      'note': 'RTL: logical offsets, visual right-to-left',
    },
  ];

  final galleryCards = <Widget>[];
  for (final entry in galleryDeltas) {
    final delta = entry['delta'] as TextEditingDeltaInsertion;
    final color = entry['color'] as Color;
    print('Gallery: ${entry['label']} insert="${delta.textInserted}" '
        '@${delta.insertionOffset}');
    galleryCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
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
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.55), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.22),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(entry['icon'] as IconData, color: color, size: 20.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    entry['label'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _miniRow('old', '"${delta.oldText}"', mute),
            _miniRow('ins', '"${delta.textInserted}"', color),
            _miniRow('off', '${delta.insertionOffset}', mute),
            _miniRow('sel', '@${delta.selection.baseOffset}', mute),
            _miniRow(
              'cmp',
              delta.composing.isValid
                  ? '${delta.composing.start}-${delta.composing.end}'
                  : 'empty',
              mute,
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                entry['note'] as String,
                style: TextStyle(
                  fontSize: 10.0,
                  color: color,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${galleryCards.length} gallery cards');

  // ============================================================
  // SECTION 4: Insertion offset visualization (caret at 0/2/5)
  // ============================================================
  print('=== Section 4: Offset Visualization ===');

  final offsetCases = <Map<String, dynamic>>[
    {
      'offset': 0,
      'before': 'ABCDE',
      'after': 'XABCDE',
      'note': 'Insert at the very start (before A)',
    },
    {
      'offset': 2,
      'before': 'ABCDE',
      'after': 'ABXCDE',
      'note': 'Insert in the middle (between B and C)',
    },
    {
      'offset': 5,
      'before': 'ABCDE',
      'after': 'ABCDEX',
      'note': 'Insert at the end (after E)',
    },
  ];

  final offsetWidgets = <Widget>[];
  for (final c in offsetCases) {
    final offset = c['offset'] as int;
    final before = c['before'] as String;
    final after = c['after'] as String;
    final delta = TextEditingDeltaInsertion(
      oldText: before,
      textInserted: 'X',
      insertionOffset: offset,
      selection: TextSelection.collapsed(offset: offset + 1),
      composing: TextRange.empty,
    );
    print('Offset ${delta.insertionOffset}: "$before" → "$after"');

    offsetWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [tealSoft, creamSoft],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: tealMid, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: tealMid.withValues(alpha: 0.2),
              blurRadius: 10.0,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: tealDeep,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'offset = $offset',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    c['note'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: tealDeep,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.0),
            _glyphStrip(before, caretAt: offset, highlight: -1),
            SizedBox(height: 8.0),
            Center(
              child: Icon(
                Icons.arrow_downward,
                color: tealDeep,
                size: 22.0,
              ),
            ),
            SizedBox(height: 8.0),
            _glyphStrip(after, caretAt: offset + 1, highlight: offset),
          ],
        ),
      ),
    );
  }
  print('Created ${offsetWidgets.length} offset visualizations');

  // ============================================================
  // SECTION 5: Composing range showcase
  // ============================================================
  print('=== Section 5: Composing Range ===');

  final composingCases = <Map<String, dynamic>>[
    {
      'old': '',
      'inserted': 'n',
      'offset': 0,
      'composing': TextRange(start: 0, end: 1),
      'caption': 'Type "n": composing region begins',
    },
    {
      'old': 'n',
      'inserted': 'i',
      'offset': 1,
      'composing': TextRange(start: 0, end: 2),
      'caption': 'Add "i": composing extends to "ni"',
    },
    {
      'old': 'ni',
      'inserted': '你好',
      'offset': 0,
      'composing': TextRange.empty,
      'caption': 'Commit candidate "你好": composing cleared',
    },
  ];

  final composingWidgets = <Widget>[];
  for (final c in composingCases) {
    final composing = c['composing'] as TextRange;
    final delta = TextEditingDeltaInsertion(
      oldText: c['old'] as String,
      textInserted: c['inserted'] as String,
      insertionOffset: c['offset'] as int,
      selection: TextSelection.collapsed(
        offset: (c['offset'] as int) + (c['inserted'] as String).length,
      ),
      composing: composing,
    );
    final newText = (c['old'] as String).substring(0, c['offset'] as int) +
        (c['inserted'] as String) +
        (c['old'] as String).substring(c['offset'] as int);
    print('Composing step: ins="${delta.textInserted}" '
        'composing=${composing.isValid ? "${composing.start}-${composing.end}" : "empty"}');

    composingWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFB2EBF2).withValues(alpha: 0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: Color(0xFF00838F), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF00838F).withValues(alpha: 0.2),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.translate, color: Color(0xFF00838F), size: 20.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    c['caption'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00838F),
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            _composingStrip(newText, composing),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFF00838F).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'composing = ${composing.isValid ? "TextRange(${composing.start}, ${composing.end})" : "TextRange.empty"}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFF006064),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${composingWidgets.length} composing demos');

  // ============================================================
  // SECTION 6: Sibling delta comparison table
  // ============================================================
  print('=== Section 6: Sibling Comparison ===');

  final siblings = <Map<String, dynamic>>[
    {
      'name': 'Insertion',
      'icon': Icons.add_circle,
      'color': tealDeep,
      'changes': 'Adds text',
      'fields': 'textInserted, insertionOffset',
      'example': '"Hi" + " there" → "Hi there"',
    },
    {
      'name': 'Deletion',
      'icon': Icons.remove_circle,
      'color': Color(0xFFC62828),
      'changes': 'Removes text',
      'fields': 'deletedRange',
      'example': '"Hello!" − "!" → "Hello"',
    },
    {
      'name': 'Replacement',
      'icon': Icons.swap_horiz,
      'color': Color(0xFF6A1B9A),
      'changes': 'Replaces a range',
      'fields': 'replacedRange, replacementText',
      'example': '"cat" → "dog"',
    },
    {
      'name': 'NonTextUpdate',
      'icon': Icons.highlight,
      'color': Color(0xFFEF6C00),
      'changes': 'Selection / composing only',
      'fields': '(no text change)',
      'example': 'Move caret 3 → 6',
    },
  ];

  final siblingTable = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: indigoSoft,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigoMid.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: indigoDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'TextEditingDelta Family',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: indigoDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: indigoMid,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _hCell('Subtype', 130.0),
              _hCell('Effect', 110.0),
              _hCell('Key fields', 170.0),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        for (final s in siblings)
          Container(
            margin: EdgeInsets.symmetric(vertical: 3.0),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: (s['color'] as Color).withValues(alpha: 0.4),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 130.0,
                      child: Row(
                        children: [
                          Icon(
                            s['icon'] as IconData,
                            color: s['color'] as Color,
                            size: 18.0,
                          ),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              s['name'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: s['color'] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 110.0,
                      child: Text(
                        s['changes'] as String,
                        style: TextStyle(fontSize: 11.0, color: ink),
                      ),
                    ),
                    SizedBox(
                      width: 170.0,
                      child: Text(
                        s['fields'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          color: mute,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    'e.g. ${s['example']}',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontStyle: FontStyle.italic,
                      color: mute,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  print('Built sibling table');

  // ============================================================
  // SECTION 7: Real-world mock — chat input with delta log
  // ============================================================
  print('=== Section 7: Chat-style Mock ===');

  final chatDeltas = <TextEditingDeltaInsertion>[
    TextEditingDeltaInsertion(
      oldText: '',
      textInserted: 'H',
      insertionOffset: 0,
      selection: TextSelection.collapsed(offset: 1),
      composing: TextRange.empty,
    ),
    TextEditingDeltaInsertion(
      oldText: 'H',
      textInserted: 'i',
      insertionOffset: 1,
      selection: TextSelection.collapsed(offset: 2),
      composing: TextRange.empty,
    ),
    TextEditingDeltaInsertion(
      oldText: 'Hi',
      textInserted: ' team',
      insertionOffset: 2,
      selection: TextSelection.collapsed(offset: 7),
      composing: TextRange.empty,
    ),
    TextEditingDeltaInsertion(
      oldText: 'Hi team',
      textInserted: '!',
      insertionOffset: 7,
      selection: TextSelection.collapsed(offset: 8),
      composing: TextRange.empty,
    ),
    TextEditingDeltaInsertion(
      oldText: 'Hi team!',
      textInserted: ' 🚀',
      insertionOffset: 8,
      selection: TextSelection.collapsed(offset: 11),
      composing: TextRange.empty,
    ),
  ];

  final logRows = <Widget>[];
  String running = '';
  int idx = 0;
  for (final d in chatDeltas) {
    running = running.substring(0, d.insertionOffset) +
        d.textInserted +
        running.substring(d.insertionOffset);
    print('Chat delta #$idx: ins="${d.textInserted}" → "$running"');
    logRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: idx.isEven
              ? indigoSoft.withValues(alpha: 0.55)
              : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: indigoMid.withValues(alpha: 0.25),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                color: indigoDeep,
                borderRadius: BorderRadius.circular(13.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '$idx',
                style: TextStyle(
                  color: cream,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'insert "${d.textInserted}" @ ${d.insertionOffset}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: ink,
                    ),
                  ),
                  Text(
                    'sel @ ${d.selection.baseOffset}   →   "$running"',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: mute,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    idx++;
  }

  final chatMock = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [creamSoft, indigoSoft.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoMid.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigoMid.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.chat_bubble_outline, color: indigoDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Chat Input  ·  Live Delta Log',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: indigoDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: indigoMid, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: indigoMid.withValues(alpha: 0.18),
                blurRadius: 8.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.mode_edit_outline, color: indigoMid, size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  running,
                  style: TextStyle(fontSize: 14.0, color: ink),
                ),
              ),
              Container(
                width: 2.0,
                height: 18.0,
                color: indigoDeep,
              ),
              SizedBox(width: 10.0),
              Icon(Icons.send, color: tealDeep, size: 18.0),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'Delta stream (DeltaTextInputClient.updateEditingValueWithDeltas)',
          style: TextStyle(
            fontSize: 11.0,
            color: mute,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0),
        ...logRows,
      ],
    ),
  );
  print('Built chat mock');

  // ============================================================
  // SECTION 8: apply() flow — TextEditingValue before/after
  // ============================================================
  print('=== Section 8: apply() Flow ===');

  final applyDelta = TextEditingDeltaInsertion(
    oldText: 'Flutter',
    textInserted: ' ❤',
    insertionOffset: 7,
    selection: TextSelection.collapsed(offset: 9),
    composing: TextRange.empty,
  );
  final beforeText = applyDelta.oldText;
  final afterText =
      beforeText.substring(0, applyDelta.insertionOffset) +
          applyDelta.textInserted +
          beforeText.substring(applyDelta.insertionOffset);
  print('apply(): "$beforeText" → "$afterText"');

  final applyFlow = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealSoft, creamSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealDeep, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.alt_route, color: tealDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'apply(value) — Reconstruction Flow',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: tealDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _valueBlock(
          'BEFORE  ·  TextEditingValue',
          beforeText,
          'selection: collapsed @ ${beforeText.length}',
          'composing: empty',
          indigoMid,
          Icons.history,
        ),
        SizedBox(height: 10.0),
        Center(
          child: Column(
            children: [
              Icon(Icons.arrow_downward, color: tealDeep, size: 26.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: tealDeep,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'delta.apply(value)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: cream,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.arrow_downward, color: tealDeep, size: 26.0),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _valueBlock(
          'AFTER  ·  TextEditingValue',
          afterText,
          'selection: collapsed @ ${applyDelta.selection.baseOffset}',
          'composing: empty',
          tealDeep,
          Icons.check_circle,
        ),
      ],
    ),
  );
  print('Built apply() flow');

  // ============================================================
  // SECTION 9: Code block — DeltaTextInputClient snippet
  // ============================================================
  print('=== Section 9: Code Snippet ===');

  final codeSnippet = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
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
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Color(0xFF10B981),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            SizedBox(width: 14.0),
            Text(
              'delta_text_input_client.dart',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFF94A3B8),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeLine('class', 'class ', 'MyDeltaClient ', Color(0xFFC084FC)),
        _codeLine('impl', '    implements ', 'DeltaTextInputClient {', Color(0xFF38BDF8)),
        _codeLine('blank', '', '', Colors.white),
        _codeLine(
          'comment',
          '  // Called for every IME delta',
          '',
          Color(0xFF64748B),
        ),
        _codeLine(
          'method',
          '  @override\n  void ',
          'updateEditingValueWithDeltas(',
          Color(0xFFFBBF24),
        ),
        _codeLine(
          'param',
          '      List<TextEditingDelta> ',
          'deltas) {',
          Color(0xFF38BDF8),
        ),
        _codeLine(
          'for',
          '    for (',
          'final delta in deltas) {',
          Color(0xFFC084FC),
        ),
        _codeLine(
          'if',
          '      if (',
          'delta is TextEditingDeltaInsertion) {',
          Color(0xFFC084FC),
        ),
        _codeLine(
          'apply',
          '        _value = ',
          'delta.apply(_value);',
          Color(0xFF34D399),
        ),
        _codeLine(
          'log',
          '        debugPrint(',
          "'inserted: \${delta.textInserted}');",
          Color(0xFFFB7185),
        ),
        _codeLine('close1', '      }', '', Colors.white),
        _codeLine('close2', '    }', '', Colors.white),
        _codeLine('close3', '  }', '', Colors.white),
        _codeLine('close4', '}', '', Colors.white),
      ],
    ),
  );
  print('Built code snippet');

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = <Map<String, dynamic>>[
    {
      'icon': Icons.warning,
      'title': 'Composing during insert',
      'body':
          'A non-empty composing range means the IME is mid-composition. '
          'Treat the inserted text as provisional; don\'t persist until '
          'composing becomes empty.',
      'color': Color(0xFFD84315),
    },
    {
      'icon': Icons.straighten,
      'title': 'Offset clamping',
      'body':
          'insertionOffset must satisfy 0 ≤ offset ≤ oldText.length. '
          'Out-of-range values are programmer errors, not silent clamps.',
      'color': Color(0xFF6A1B9A),
    },
    {
      'icon': Icons.format_textdirection_r_to_l,
      'title': 'RTL is logical',
      'body':
          'Offsets are logical positions, NOT visual. For Hebrew/Arabic, '
          'offset N counts code units from logical start, regardless of '
          'right-to-left rendering.',
      'color': Color(0xFFC2185B),
    },
    {
      'icon': Icons.emoji_emotions,
      'title': 'Surrogate pairs',
      'body':
          'Emoji and supplementary plane glyphs occupy 2 UTF-16 units. '
          'A single emoji insertion can advance offset by 2 (or more for ZWJ).',
      'color': Color(0xFFEF6C00),
    },
    {
      'icon': Icons.content_paste,
      'title': 'Paste vs IME stream',
      'body':
          'Paste arrives as one large insertion (or replacement). IME typing '
          'arrives as many small insertions, often with composing ranges. '
          'Don\'t assume one keystroke = one delta.',
      'color': Color(0xFF00838F),
    },
  ];

  final footgunWidgets = <Widget>[];
  for (final f in footguns) {
    final color = f['color'] as Color;
    print('Footgun: ${f['title']}');
    footgunWidgets.add(
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
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(f['icon'] as IconData, color: color, size: 20.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    f['body'] as String,
                    style: TextStyle(fontSize: 11.5, color: ink, height: 1.35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${footgunWidgets.length} footguns');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapPoints = <String>[
    'TextEditingDeltaInsertion describes new text inserted by the IME.',
    'Five fields: oldText, textInserted, insertionOffset, selection, composing.',
    'It is one of four sibling subtypes of TextEditingDelta.',
    'apply() reconstructs the new TextEditingValue.',
    'Use DeltaTextInputClient.updateEditingValueWithDeltas to consume them.',
    'Critical for IME-aware editors: CJK pinyin, autocorrect, smart paste.',
  ];

  final recapCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigoDeep, tealDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.25),
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
            Icon(Icons.summarize, color: cream, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: cream,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (final p in recapPoints)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: cream.withValues(alpha: 0.95),
                  size: 18.0,
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    p,
                    style: TextStyle(
                      color: cream,
                      fontSize: 12.5,
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
  print('Built recap card');

  print('TextEditingDeltaInsertion Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: creamSoft,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),
          _sectionHeader('1. Anatomy', Icons.account_tree, indigoDeep),
          SizedBox(height: 8.0),
          anatomyCard,
          SizedBox(height: 28.0),
          _sectionHeader('2. Instance Gallery', Icons.collections, indigoDeep),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.center, children: galleryCards),
          SizedBox(height: 28.0),
          _sectionHeader('3. Insertion Offset', Icons.place, tealDeep),
          SizedBox(height: 8.0),
          ...offsetWidgets,
          SizedBox(height: 28.0),
          _sectionHeader(
            '4. Composing Range (IME)',
            Icons.translate,
            Color(0xFF00838F),
          ),
          SizedBox(height: 8.0),
          ...composingWidgets,
          SizedBox(height: 28.0),
          _sectionHeader(
            '5. Sibling Delta Family',
            Icons.compare_arrows,
            indigoDeep,
          ),
          SizedBox(height: 8.0),
          siblingTable,
          SizedBox(height: 28.0),
          _sectionHeader(
            '6. Real-World: Chat Input',
            Icons.chat_bubble_outline,
            indigoDeep,
          ),
          SizedBox(height: 8.0),
          chatMock,
          SizedBox(height: 28.0),
          _sectionHeader('7. apply() Flow', Icons.alt_route, tealDeep),
          SizedBox(height: 8.0),
          applyFlow,
          SizedBox(height: 28.0),
          _sectionHeader(
            '8. Code: DeltaTextInputClient',
            Icons.code,
            indigoDeep,
          ),
          SizedBox(height: 8.0),
          codeSnippet,
          SizedBox(height: 28.0),
          _sectionHeader('9. Footguns', Icons.warning_amber, Color(0xFFD84315)),
          SizedBox(height: 8.0),
          ...footgunWidgets,
          SizedBox(height: 28.0),
          recapCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ===================================================================
// Helpers
// ===================================================================

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(
  String name,
  String value,
  String description,
  IconData icon,
  Color color,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(icon, color: color, size: 18.0),
      ),
      SizedBox(width: 12.0),
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
                SizedBox(width: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF607D8B),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _miniRow(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      children: [
        SizedBox(
          width: 28.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Color(0xFF263238),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _glyphStrip(String text, {required int caretAt, required int highlight}) {
  final units = <Widget>[];
  for (int i = 0; i < text.length; i++) {
    final isHighlight = i == highlight;
    if (i == caretAt) {
      units.add(
        Container(
          width: 3.0,
          height: 36.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            color: Color(0xFFD84315),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );
    }
    units.add(
      Container(
        width: 32.0,
        height: 36.0,
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: isHighlight
              ? LinearGradient(
                  colors: [Color(0xFFFFE082), Color(0xFFFFB300)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: isHighlight ? null : Colors.white,
          border: Border.all(
            color: isHighlight ? Color(0xFFFF6F00) : Color(0xFFB0BEC5),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          text[i],
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: isHighlight ? Color(0xFF6D4C00) : Color(0xFF263238),
          ),
        ),
      ),
    );
  }
  if (caretAt == text.length) {
    units.add(
      Container(
        width: 3.0,
        height: 36.0,
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          color: Color(0xFFD84315),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
  return Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: units);
}

Widget _composingStrip(String text, TextRange composing) {
  final units = <Widget>[];
  for (int i = 0; i < text.length; i++) {
    final inComposing = composing.isValid &&
        i >= composing.start &&
        i < composing.end;
    units.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: inComposing
              ? Color(0xFFB2EBF2).withValues(alpha: 0.7)
              : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: inComposing ? Color(0xFF00838F) : Colors.transparent,
              width: 2.5,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Text(
          text[i],
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFF00838F).withValues(alpha: 0.3)),
    ),
    child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: units),
  );
}

Widget _hCell(String t, double w) {
  return SizedBox(
    width: w,
    child: Text(
      t,
      style: TextStyle(
        color: Color(0xFFFFF8E1),
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    ),
  );
}

Widget _valueBlock(
  String title,
  String text,
  String selectionLine,
  String composingLine,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
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
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'text: "$text"',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          selectionLine,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Color(0xFF607D8B),
          ),
        ),
        Text(
          composingLine,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Color(0xFF607D8B),
          ),
        ),
      ],
    ),
  );
}

Widget _codeLine(String tag, String prefix, String body, Color bodyColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: Color(0xFFE2E8F0),
        ),
        children: [
          TextSpan(text: prefix),
          TextSpan(text: body, style: TextStyle(color: bodyColor)),
        ],
      ),
    ),
  );
}
