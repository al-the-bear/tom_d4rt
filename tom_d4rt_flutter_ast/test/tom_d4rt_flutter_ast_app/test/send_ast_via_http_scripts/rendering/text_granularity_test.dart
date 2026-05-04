// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextGranularity enum from package:flutter/rendering.dart
// Deep Demo: Visual exploration of selection-extension granularity in Flutter.
//
// TextGranularity is a five-valued enum used by selection and text-edit
// intents to specify how far a caret motion or selection extension should
// reach. The values are ordered from finest (character) to coarsest
// (document):
//
//   character  -> one code-point step
//   word       -> walks to the next/previous word boundary
//   line       -> walks to the next/previous line boundary (visual line)
//   paragraph  -> walks to the next/previous paragraph boundary
//   document   -> walks to the start or end of the document
//
// Editor-level keyboard handling, drag-to-select gestures, and accessibility
// services all consult granularity to decide how much text to move over.
// This demo illustrates each value visually, lists the platform shortcuts
// that typically map to it, calls out pitfalls (line vs paragraph in
// soft-wrapped text, document boundaries across multiple controllers,
// locale-dependent word boundaries), and demonstrates three concrete recipes.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Sample paragraph used by the granularity highlight strip. It is rich
// enough to show meaningful differences between word, line, and paragraph
// granularity. The paragraphs are separated by a blank line in source, and
// soft-wrap inside the editor surface so that "line" and "paragraph"
// actually disagree.
const String kSampleText =
    'The quick brown fox jumps over the lazy dog. '
    'Selection granularity decides how far a caret moves '
    'when an extension intent fires.\n\n'
    'A second paragraph illustrates that paragraph granularity '
    'jumps across blank-line separators, while line granularity '
    'stops at the soft-wrap boundary inferred from the visual layout.\n\n'
    'A short third paragraph closes the demo.';

dynamic build(BuildContext context) {
  print('TextGranularity Deep Demo executing');
  print('Enum values: ${TextGranularity.values.map((g) => g.name).toList()}');
  print('Total values: ${TextGranularity.values.length}');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final heroHeader = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF512DA8),
          Color(0xFFAD1457),
        ],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 40.0,
          offset: const Offset(0.0, 18.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.text_fields,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'TextGranularity',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Selection & extension reach in Flutter editing intents',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            for (final g in TextGranularity.values)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  g.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Concept Primer
  // ============================================================
  print('=== Section 2: Concept primer ===');

  final conceptPrimer = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.12),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.school, color: Colors.blue.shade700, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'What is selection granularity?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'When the user fires an "extend selection" or "move caret" intent, '
          'the framework needs a unit of distance. TextGranularity is that '
          'unit. It does not describe the selection itself; it describes the '
          'step the selection takes when an intent is dispatched.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.blue.shade900,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Text(
            'caret_position + extend(direction, granularity)\n'
            '   -> new_caret_position',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.indigo.shade900,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'In Flutter, GranularlyExtendSelectionEvent and '
          'SelectionEdgeUpdateEvent both carry a TextGranularity. The '
          'underlying SelectionContainer or RenderEditable interprets it '
          'and walks the boundaries it owns.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.blue.shade800,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-Value Cards
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  // Per-granularity metadata: definition, primary keystroke, color band.
  final granularityInfo = <Map<String, dynamic>>[
    {
      'value': TextGranularity.character,
      'icon': Icons.text_format,
      'color': Colors.teal,
      'gradient': [Colors.teal.shade50, Colors.teal.shade100],
      'definition':
          'One Unicode code-point step. The smallest unit; no boundary search.',
      'shortcut': 'Arrow keys (Left / Right)',
      'extendShortcut': 'Shift + Left / Shift + Right',
      'use': 'Default caret motion in any TextField.',
      'highlightStart': 38,
      'highlightEnd': 39,
    },
    {
      'value': TextGranularity.word,
      'icon': Icons.short_text,
      'color': Colors.indigo,
      'gradient': [Colors.indigo.shade50, Colors.indigo.shade100],
      'definition':
          'Walks to the next word boundary using the platform word breaker.',
      'shortcut': 'Ctrl + Left / Ctrl + Right (macOS: Option + arrows)',
      'extendShortcut': 'Ctrl + Shift + Right',
      'use': 'Word-by-word caret motion and double-click-drag selection.',
      'highlightStart': 38,
      'highlightEnd': 41,
    },
    {
      'value': TextGranularity.line,
      'icon': Icons.format_align_left,
      'color': Colors.amber,
      'gradient': [Colors.amber.shade50, Colors.amber.shade100],
      'definition':
          'Walks to the start or end of the visual line (after soft-wrap).',
      'shortcut': 'Home / End (macOS: Cmd + Left / Cmd + Right)',
      'extendShortcut': 'Shift + End',
      'use': 'Jump to line edges; respects soft-wrap, not source newlines.',
      'highlightStart': 33,
      'highlightEnd': 84,
    },
    {
      'value': TextGranularity.paragraph,
      'icon': Icons.notes,
      'color': Colors.deepOrange,
      'gradient': [Colors.deepOrange.shade50, Colors.deepOrange.shade100],
      'definition':
          'Walks to the next paragraph boundary (typically a hard newline).',
      'shortcut': 'Ctrl + Up / Ctrl + Down (macOS: Option + Up / Down)',
      'extendShortcut': 'Ctrl + Shift + Down',
      'use': 'Multi-line jump, ignoring soft-wrap, stopping at \\n\\n.',
      'highlightStart': 0,
      'highlightEnd': 110,
    },
    {
      'value': TextGranularity.document,
      'icon': Icons.article,
      'color': Colors.pink,
      'gradient': [Colors.pink.shade50, Colors.pink.shade100],
      'definition':
          'Walks to the start or end of the entire selectable document.',
      'shortcut': 'Ctrl + Home / Ctrl + End (macOS: Cmd + Up / Cmd + Down)',
      'extendShortcut': 'Ctrl + Shift + End  /  Ctrl + A (select-all)',
      'use': 'Select-all, jump-to-top, jump-to-bottom intents.',
      'highlightStart': 0,
      'highlightEnd': kSampleText.length,
    },
  ];

  final perValueCards = <Widget>[];
  for (final info in granularityInfo) {
    final value = info['value'] as TextGranularity;
    final color = info['color'] as MaterialColor;
    final grad = info['gradient'] as List<Color>;
    print(
      'Granularity ${value.name} (index ${value.index}): '
      'shortcut "${info['shortcut']}"',
    );

    perValueCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: grad,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: color.shade400, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 14.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: color.shade700,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.5),
                        blurRadius: 6.0,
                        offset: const Offset(0.0, 3.0),
                      ),
                    ],
                  ),
                  child: Icon(
                    info['icon'] as IconData,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TextGranularity.${value.name}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: color.shade900,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'index: ${value.index}',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: color.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            Text(
              info['definition'] as String,
              style: TextStyle(
                fontSize: 13.0,
                color: color.shade900,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12.0),
            _buildShortcutRow(
              'Move',
              info['shortcut'] as String,
              color,
              Icons.keyboard,
            ),
            const SizedBox(height: 6.0),
            _buildShortcutRow(
              'Extend',
              info['extendShortcut'] as String,
              color,
              Icons.swipe_right,
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      size: 16.0, color: color.shade700),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      info['use'] as String,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: color.shade900,
                        fontStyle: FontStyle.italic,
                      ),
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

  // ============================================================
  // SECTION 4: Highlight Strip - sample paragraph rendered five times
  // ============================================================
  print('=== Section 4: Highlight strip ===');

  final highlightStrip = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade200],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade400),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.highlight, color: Colors.grey.shade800),
            const SizedBox(width: 8.0),
            Text(
              'Same paragraph, five granularities',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Imagine a caret at offset ~38 (after "fox "). Each card '
          'shows what extending one step in that granularity selects.',
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 14.0),
        for (final info in granularityInfo)
          _buildHighlightCard(
            info['value'] as TextGranularity,
            info['color'] as MaterialColor,
            info['highlightStart'] as int,
            info['highlightEnd'] as int,
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Recipes
  // ============================================================
  print('=== Section 5: Recipes ===');

  final recipesSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book,
                color: Colors.deepPurple.shade700, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildRecipeCard(
          '1. Custom keymap intents',
          'Map a key combination to a granularity-aware extend intent.',
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    SingleActivator(LogicalKeyboardKey.arrowRight,\n'
          '        shift: true, control: true):\n'
          '      ExtendSelectionByCharacterIntent(\n'
          '        forward: true,\n'
          '        granularity: TextGranularity.word,\n'
          '      ),\n'
          '  },\n'
          '  child: Actions(actions: ..., child: editor),\n'
          ')',
          Colors.indigo,
          Icons.keyboard_alt,
        ),
        const SizedBox(height: 12.0),
        _buildRecipeCard(
          '2. Drag-to-select word-by-word',
          'Forward a drag gesture as a granular selection update.',
          'void onDragUpdate(DragUpdateDetails d) {\n'
          '  selectionDelegate.handleSelectionEdgeUpdate(\n'
          '    SelectionEdgeUpdateEvent.forEnd(\n'
          '      globalPosition: d.globalPosition,\n'
          '      granularity: TextGranularity.word,\n'
          '    ),\n'
          '  );\n'
          '}',
          Colors.deepPurple,
          Icons.touch_app,
        ),
        const SizedBox(height: 12.0),
        _buildRecipeCard(
          '3. Document-wide select-all',
          'Synthesize a select-all by extending both ends to document.',
          'void selectAll(SelectionContainerDelegate d) {\n'
          '  d.handleGranularlyExtendSelection(\n'
          '    GranularlyExtendSelectionEvent(\n'
          '      forward: false,\n'
          '      isEnd: false,\n'
          '      granularity: TextGranularity.document,\n'
          '    ),\n'
          '  );\n'
          '  d.handleGranularlyExtendSelection(\n'
          '    GranularlyExtendSelectionEvent(\n'
          '      forward: true,\n'
          '      isEnd: true,\n'
          '      granularity: TextGranularity.document,\n'
          '    ),\n'
          '  );\n'
          '}',
          Colors.purple,
          Icons.select_all,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Platform Mapping Table
  // ============================================================
  print('=== Section 6: Platform mapping ===');

  final platformTable = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.devices,
                color: Colors.blueGrey.shade800, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'Platform shortcut mapping',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade700,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildPlatformHeader('Granularity', 110.0),
              _buildPlatformHeader('macOS', 150.0),
              _buildPlatformHeader('Windows', 130.0),
              _buildPlatformHeader('Linux', 130.0),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        _buildPlatformRow(
          'character',
          'Arrow keys',
          'Arrow keys',
          'Arrow keys',
          Colors.teal,
        ),
        _buildPlatformRow(
          'word',
          'Option + arrows',
          'Ctrl + arrows',
          'Ctrl + arrows',
          Colors.indigo,
        ),
        _buildPlatformRow(
          'line',
          'Cmd + Left/Right',
          'Home / End',
          'Home / End',
          Colors.amber,
        ),
        _buildPlatformRow(
          'paragraph',
          'Option + Up/Down',
          'Ctrl + Up/Down',
          'Ctrl + Up/Down',
          Colors.deepOrange,
        ),
        _buildPlatformRow(
          'document',
          'Cmd + Up/Down',
          'Ctrl + Home/End',
          'Ctrl + Home/End',
          Colors.pink,
        ),
        const SizedBox(height: 8.0),
        Text(
          'Note: extension variants add Shift. Select-all is Cmd+A on macOS '
          'and Ctrl+A on Windows / Linux; both resolve to '
          'TextGranularity.document.',
          style: TextStyle(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: Colors.blueGrey.shade800,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfallsSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber,
                color: Colors.red.shade700, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls and gotchas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildPitfallTile(
          'Line vs paragraph in soft-wrapped text',
          'TextGranularity.line walks visual lines after layout, so a long '
          'paragraph can have many lines. Paragraph granularity ignores '
          'soft-wraps and stops only at hard newlines (\\n). Designers who '
          'expect "End" to jump to the paragraph end will be surprised.',
          Colors.red,
          Icons.wrap_text,
        ),
        _buildPitfallTile(
          'Document granularity in multi-controller editors',
          'When several SelectionContainers compose a screen (e.g. a chat '
          'log of bubbles), TextGranularity.document means "this container", '
          'not "the whole screen". Wrap with a parent SelectionRegistrar '
          'if you want a single document boundary.',
          Colors.deepOrange,
          Icons.layers,
        ),
        _buildPitfallTile(
          'Locale-dependent word boundaries',
          'Word granularity defers to the platform word breaker. Languages '
          'without spaces (Japanese, Thai) produce very different jumps from '
          'English. Test with the locales you actually support before '
          'binding double-click-drag selection.',
          Colors.orange,
          Icons.language,
        ),
        _buildPitfallTile(
          'Index 0 is character, not "none"',
          'TextGranularity has no zero-meaning. Treating index 0 as '
          '"no granularity" is a bug; pick a sentinel via TextGranularity? '
          'and check for null instead.',
          Colors.pink,
          Icons.tag,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Enum Diagnostic Strip
  // ============================================================
  print('=== Section 8: Enum diagnostics ===');

  final diagnosticStrip = Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.cyan.shade300, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Enum diagnostics',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        for (final g in TextGranularity.values)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              children: [
                Container(
                  width: 28.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${g.index}',
                    style: TextStyle(
                      color: Colors.amber.shade300,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'TextGranularity.${g.name}',
                    style: TextStyle(
                      color: Colors.greenAccent.shade100,
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Text(
                  'name="${g.name}"',
                  style: TextStyle(
                    color: Colors.cyan.shade200,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade800),
          ),
          child: Text(
            'TextGranularity.values.length == ${TextGranularity.values.length}\n'
            'TextGranularity.values.first == ${TextGranularity.values.first.name}\n'
            'TextGranularity.values.last  == ${TextGranularity.values.last.name}',
            style: TextStyle(
              color: Colors.lightGreenAccent.shade100,
              fontFamily: 'monospace',
              fontSize: 12.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footer with file path and ASCII box
  // ============================================================
  print('=== Section 9: Footer ===');

  final footer = Container(
    margin: const EdgeInsets.only(top: 24.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade800, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '+--------------------------------------------------------------+\n'
          '|  TextGranularity deep demo                                   |\n'
          '|  Subject : package:flutter/rendering.dart -> TextGranularity |\n'
          '|  Section : rendering / send_ast_via_http_scripts             |\n'
          '|  Values  : character, word, line, paragraph, document        |\n'
          '+--------------------------------------------------------------+',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade100,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'File: tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
          'send_ast_via_http_scripts/rendering/text_granularity_test.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: Colors.cyan.shade200,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Bridge: tom_d4rt_flutter_ast/lib/src/bridges/'
          'rendering_bridges.b.dart (BridgedEnumDefinition<TextGranularity>)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: Colors.cyan.shade200,
          ),
        ),
      ],
    ),
  );

  print('TextGranularity Deep Demo completed successfully');

  // ============================================================
  // Compose the final scrollable layout.
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        const SizedBox(height: 16.0),
        const _SectionTitle('1. Concept primer'),
        conceptPrimer,
        const _SectionTitle('2. Per-value cards'),
        ...perValueCards,
        const _SectionTitle('3. Highlight strip'),
        highlightStrip,
        const _SectionTitle('4. Recipes'),
        recipesSection,
        const _SectionTitle('5. Platform shortcut mapping'),
        platformTable,
        const _SectionTitle('6. Pitfalls'),
        pitfallsSection,
        const _SectionTitle('7. Enum diagnostics'),
        diagnosticStrip,
        const _SectionTitle('8. Footer'),
        footer,
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 6.0,
            height: 24.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade400, Colors.purple.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
        ],
      ),
    );
  }
}

// Render a single shortcut row: label chip + key combination text.
Widget _buildShortcutRow(
  String label,
  String shortcut,
  MaterialColor color,
  IconData icon,
) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: color.shade700,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12.0, color: Colors.white),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          shortcut,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: color.shade900,
          ),
        ),
      ),
    ],
  );
}

// Render the sample paragraph with a coloured highlight band over a slice.
Widget _buildHighlightCard(
  TextGranularity g,
  MaterialColor color,
  int start,
  int end,
) {
  final clampedStart = start.clamp(0, kSampleText.length);
  final clampedEnd = end.clamp(0, kSampleText.length);
  final before = kSampleText.substring(0, clampedStart);
  final mid = kSampleText.substring(clampedStart, clampedEnd);
  final after = kSampleText.substring(clampedEnd);
  print(
    'Highlight card for ${g.name}: '
    '[$clampedStart..$clampedEnd] = ${mid.length} chars',
  );

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: color.shade600,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                g.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              'span [$clampedStart..$clampedEnd]  '
              '(${clampedEnd - clampedStart} chars)',
              style: TextStyle(
                fontSize: 11.0,
                color: color.shade900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey.shade900,
              height: 1.45,
            ),
            children: [
              TextSpan(text: before),
              TextSpan(
                text: mid,
                style: TextStyle(
                  backgroundColor: color.withValues(alpha: 0.35),
                  color: color.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(text: after),
            ],
          ),
        ),
      ],
    ),
  );
}

// Render one recipe card with title, prose, and a code block.
Widget _buildRecipeCard(
  String title,
  String description,
  String code,
  MaterialColor color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.shade600,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: Colors.white, size: 18.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.5,
            color: color.shade900,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: color.shade100,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlatformHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    ),
  );
}

Widget _buildPlatformRow(
  String granularity,
  String macOs,
  String windows,
  String linux,
  MaterialColor color,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            granularity,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            macOs,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: color.shade900),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: Text(
            windows,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: color.shade900),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: Text(
            linux,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: color.shade900),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallTile(
  String title,
  String body,
  MaterialColor color,
  IconData icon,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color.shade800, size: 20.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: color.shade900,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: color.shade900,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
