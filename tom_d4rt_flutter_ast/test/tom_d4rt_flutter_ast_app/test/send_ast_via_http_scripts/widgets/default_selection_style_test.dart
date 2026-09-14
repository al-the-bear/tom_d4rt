// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// DefaultSelectionStyle deep demo.
//
// `DefaultSelectionStyle` is an InheritedWidget that hangs three default
// values on a subtree:
//   * selectionColor   — the rectangle painted under highlighted glyphs
//   * cursorColor      — the blinking caret
//   * mouseCursor      — the system cursor used over selectable text
//   * selectionControls — the desktop / mobile toolbar handles
//
// Anything below it that performs text selection (TextField, EditableText,
// SelectableText, Text.rich with a SelectionRegistrar, etc.) reads those
// defaults via `DefaultSelectionStyle.of(context)`.
//
// The framework wires a default `DefaultSelectionStyle` near the top of every
// MaterialApp/CupertinoApp by reading `Theme.of(context).textSelectionTheme`,
// so most apps inherit a perfectly good base. This file exists to demonstrate
// what happens when callers wrap _their own_ subtrees in a more specific
// `DefaultSelectionStyle` — both via the public default constructor and via
// the `.merge` constructor — and how those overrides interact with theme,
// nested ancestors, mouse cursors, and accessibility.
//
// Layout contract for this file (per the harness): one top-level
// `dynamic build(BuildContext context)` that returns
//   MaterialApp → Scaffold → SafeArea → SingleChildScrollView → Column
// and nothing else. Everything below is built up inside that single Column.
// No widget classes, no helpers, no globals — every piece is hand-authored
// inline so that the AST round-trip stays straightforward.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== DefaultSelectionStyle Deep Demo (hand-authored) ===');
  print('Sections:');
  print('  1. Intro and inheritance diagram');
  print('  2. Baseline (no override)');
  print('  3. Single override');
  print('  4. Nested overrides (warm vs cool palette)');
  print('  5. SelectableText gallery');
  print('  6. DefaultSelectionStyle.merge proof');
  print('  7. Theme integration via TextSelectionTheme');
  print('  8. Mouse cursor variations');
  print('  9. Form / login mockup with brand selection color');
  print(' 10. Live theme switcher (preset palettes)');
  print(' 11. Pitfalls — five caution cards');
  print(' 12. Reference table — related widgets & data classes');

  // Controllers are constructed eagerly. The harness disposes the widget tree
  // when navigating away, so leak-tracking warnings should be limited to the
  // process exit. Using `final` with default text gives us instantly visible
  // selection candidates without the user having to type anything.
  final TextEditingController baselineFirstName =
      TextEditingController(text: 'Marie Curie');
  final TextEditingController baselineEmail =
      TextEditingController(text: 'marie.curie@example.org');
  final TextEditingController baselineNotes = TextEditingController(
    text:
        'Triple-click to select this entire line, or drag across a few words to see the default selection color from your active theme.',
  );

  final TextEditingController singleOrangeOne = TextEditingController(
    text: 'Highlight me — the selection rectangle should be deep-orange tinted.',
  );
  final TextEditingController singleOrangeTwo = TextEditingController(
    text: 'And the caret here should be a bright deep-orange while focused.',
  );
  final TextEditingController singleOrangeThree = TextEditingController(
    text: 'Three sibling fields share one DefaultSelectionStyle ancestor.',
  );

  final TextEditingController nestedOuter = TextEditingController(
    text: 'Outer subtree (warm palette): dragging selects with a sunset red.',
  );
  final TextEditingController nestedInnerA = TextEditingController(
    text: 'Inner subtree A (cool palette): the closer ancestor wins here.',
  );
  final TextEditingController nestedInnerB = TextEditingController(
    text: 'Inner subtree B (cool palette): selection should be a chilly cyan.',
  );

  final TextEditingController mergeOuter = TextEditingController(
    text:
        'OUTER scope: red selectionColor + matching red cursorColor flow down.',
  );
  final TextEditingController mergeInnerKept = TextEditingController(
    text:
        '.merge() with only cursorColor changed — selectionColor must stay RED.',
  );
  final TextEditingController mergeInnerOverridden = TextEditingController(
    text:
        '.merge() with both fields changed — selectionColor here is teal, cursor is teal.',
  );

  final TextEditingController themeIntegrationOne = TextEditingController(
    text: 'Theme.textSelectionTheme drives DefaultSelectionStyle by default.',
  );
  final TextEditingController themeIntegrationTwo = TextEditingController(
    text: 'Wrapping in a `Theme(...)` flips the inherited selection palette.',
  );
  final TextEditingController themeIntegrationThree = TextEditingController(
    text: 'No `DefaultSelectionStyle` ancestor needed — the theme is the source of truth.',
  );

  final TextEditingController mouseCursorText = TextEditingController(
    text:
        'Hover this field — DefaultSelectionStyle.mouseCursor: SystemMouseCursors.text.',
  );
  final TextEditingController mouseCursorGrab = TextEditingController(
    text:
        'Hover this field — DefaultSelectionStyle.mouseCursor: SystemMouseCursors.grab.',
  );
  final TextEditingController mouseCursorHelp = TextEditingController(
    text:
        'Hover this field — DefaultSelectionStyle.mouseCursor: SystemMouseCursors.help.',
  );

  final TextEditingController loginEmail =
      TextEditingController(text: 'ada.lovelace@analyticalengine.io');
  final TextEditingController loginPassword =
      TextEditingController(text: 'difference-engine-1837');
  final TextEditingController signupName =
      TextEditingController(text: 'Augusta Ada King');
  final TextEditingController signupHandle =
      TextEditingController(text: '@enchantress_of_numbers');
  final TextEditingController signupBio = TextEditingController(
    text:
        'Mathematician, writer, and the first computer programmer. I select text to take notes.',
  );

  final TextEditingController switcherOne = TextEditingController(
    text: 'Drag-select me — change the palette above and try again.',
  );
  final TextEditingController switcherTwo = TextEditingController(
    text:
        'The same DefaultSelectionStyle wraps all three switcher fields, live.',
  );
  final TextEditingController switcherThree = TextEditingController(
    text: 'Selection color updates immediately because it is inherited.',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DefaultSelectionStyle deep demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F51B5)),
      // Establishing a baseline TextSelectionTheme. This populates the
      // ambient DefaultSelectionStyle that MaterialApp inserts near the top
      // of the tree, so even sections that do NOT wrap their fields still
      // get a coherent selection look.
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xFF3F51B5),
        selectionColor: Color(0x553F51B5),
        selectionHandleColor: Color(0xFF3F51B5),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DefaultSelectionStyle — deep demo'),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // =================================================================
              // Section 1 — Intro
              // =================================================================
              const Text(
                '1 · Intro — what selection styling actually means',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Selection styling is the visual language a Flutter app uses '
                'to tell users "this character range is currently picked". '
                'There are three distinct visuals at play:',
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 10),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Text(
                        'Three values DefaultSelectionStyle owns',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• selectionColor: the translucent rectangle painted '
                        'under glyphs that are currently part of the active '
                        'TextSelection. Typically a 25–40% opaque tint of the '
                        'primary brand color so glyphs remain readable.',
                      ),
                      SizedBox(height: 6),
                      Text(
                        '• cursorColor: the color of the blinking caret in '
                        'EditableText, TextField, and any other widget that '
                        'paints a caret. Convention: the same hue as the '
                        'selection rectangle, but fully opaque.',
                      ),
                      SizedBox(height: 6),
                      Text(
                        '• mouseCursor: the SystemMouseCursor presented while '
                        'the pointer hovers selectable text. Defaults to '
                        'SystemMouseCursors.text (the I-beam) — but a custom '
                        'demo or read-only viewer can override that.',
                      ),
                      SizedBox(height: 6),
                      Text(
                        '• selectionControls: the toolbar (copy, cut, paste, '
                        'select-all) that pops up around handles on mobile, '
                        'and the desktop variant on macOS / Windows / Linux.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFF6F8FB),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Text(
                        'Inheritance diagram',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'MaterialApp\n'
                        '  └── Theme (seeded from ThemeData.textSelectionTheme)\n'
                        '       └── DefaultSelectionStyle  ◀── implicit, fed by Theme\n'
                        '            └── ...your app...\n'
                        '                 └── DefaultSelectionStyle (optional, your override)\n'
                        '                      └── EditableText / TextField / SelectableText\n'
                        '                           ▲ reads DefaultSelectionStyle.of(context)',
                        style:
                            TextStyle(fontFamily: 'monospace', fontSize: 12.5),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Concretely: every selectable widget calls '
                        'DefaultSelectionStyle.of(context) and uses those '
                        'values UNLESS the widget itself was given an explicit '
                        'cursorColor / selectionColor parameter. Explicit '
                        'parameters always win.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'TL;DR: DefaultSelectionStyle is the "ambient text-selection '
                'theme" for a subtree. Wrap a region of your UI in one to '
                'rebrand selection visuals locally without forking widgets.',
                style: TextStyle(fontSize: 13.5, fontStyle: FontStyle.italic),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 2 — Baseline (no override)
              // =================================================================
              const Text(
                '2 · Baseline — three fields with NO local override',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'These three fields inherit the implicit DefaultSelectionStyle '
                'that MaterialApp installed from ThemeData.textSelectionTheme. '
                'No DefaultSelectionStyle wraps this group — the indigo-tinted '
                'selection rectangle is purely theme-driven.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Try it:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '1. Tap into a field. The caret blinks in indigo.\n'
                        '2. Drag across a word. The selection tint is the '
                        'theme\'s indigo @ 33% alpha (0x55).\n'
                        '3. Triple-click to select the whole line.',
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: baselineFirstName,
                        decoration: const InputDecoration(
                          labelText: 'First name',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: baselineEmail,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: baselineNotes,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Notes (multi-line)',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Expected colors here:\n'
                        '• cursorColor   = #FF3F51B5  (indigo 500)\n'
                        '• selectionColor = #553F51B5  (indigo 500 @ 33%)',
                        style:
                            TextStyle(fontFamily: 'monospace', fontSize: 12.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Take a screenshot of a selected word here. Compare it to the '
                'screenshots in sections 3 and 4. The difference between '
                '"theme default" and "explicitly overridden" is what this '
                'whole demo is about.',
                style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 3 — Single override
              // =================================================================
              const Text(
                '3 · Single override — one DefaultSelectionStyle wraps three fields',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'A single DefaultSelectionStyle ancestor with deep-orange '
                'colors. All three TextFields below inherit the override. '
                'Note: we do NOT pass cursorColor / selectionColor on the '
                'TextFields themselves — the inheritance does the work.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              DefaultSelectionStyle(
                selectionColor: const Color(0x66FF6F00),
                cursorColor: Colors.deepOrange,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xFFFFF8F2),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Scope: deep-orange',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'selectionColor: 0x66FF6F00   — orange-700 @ 40%\n'
                          'cursorColor:    Colors.deepOrange',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 12.5),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: singleOrangeOne,
                          decoration: const InputDecoration(
                            labelText: 'Field A — inherits orange',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: singleOrangeTwo,
                          decoration: const InputDecoration(
                            labelText: 'Field B — inherits orange',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: singleOrangeThree,
                          decoration: const InputDecoration(
                            labelText: 'Field C — inherits orange',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const SelectableText(
                          'A SelectableText sibling — same orange selection.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Why this is useful: branding. Drop a single ancestor at the '
                'top of a feature and every text input below adopts the '
                'feature\'s accent color for selection — without touching '
                'each TextField individually.',
                style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 4 — Nested overrides (closer ancestor wins)
              // =================================================================
              const Text(
                '4 · Nested overrides — closer ancestor wins',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'An OUTER DefaultSelectionStyle uses a warm sunset red. '
                'INSIDE it, one card wraps its own children in a SECOND '
                'DefaultSelectionStyle with a cool cyan palette. The cyan '
                'one is closer to the inner TextFields, so it wins. The '
                'outer field stays red.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              DefaultSelectionStyle(
                selectionColor: const Color(0x66E53935),
                cursorColor: const Color(0xFFC62828),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xFFFFF5F5),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Outer scope (warm)',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'selectionColor: 0x66E53935   cursorColor: 0xFFC62828',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 12.5),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: nestedOuter,
                          decoration: const InputDecoration(
                            labelText: 'Outer field (red wins)',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 14),
                        DefaultSelectionStyle(
                          selectionColor: const Color(0x6600BCD4),
                          cursorColor: const Color(0xFF006064),
                          child: Card(
                            margin: EdgeInsets.zero,
                            color: const Color(0xFFF0FBFE),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const Text(
                                    'Inner scope (cool) — overrides outer',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'selectionColor: 0x6600BCD4   cursorColor: 0xFF006064',
                                    style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 12.5),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: nestedInnerA,
                                    decoration: const InputDecoration(
                                      labelText: 'Inner field A (cyan wins)',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: nestedInnerB,
                                    decoration: const InputDecoration(
                                      labelText: 'Inner field B (cyan wins)',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const SelectableText(
                                    'Inner SelectableText — also cyan.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Rule of nesting:\n'
                          'DefaultSelectionStyle.of(context) walks UP from '
                          'the calling widget and stops at the first '
                          'DefaultSelectionStyle it finds. That is why the '
                          'inner cyan ancestor takes over for the inner '
                          'fields, while the outer red ancestor still '
                          'governs anything not below the cyan one.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Practical use: a "settings" page that lives inside a '
                '"branded" feature can opt-out of the brand color and use '
                'the system default selection instead.',
                style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 5 — SelectableText gallery
              // =================================================================
              const Text(
                '5 · SelectableText gallery — six palettes, six cards',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Each card wraps exactly ONE SelectableText in its own '
                'DefaultSelectionStyle. This is the read-only equivalent of '
                'the TextField scenarios above: SelectableText also reads '
                'DefaultSelectionStyle.of(context).',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              // Palette A — Indigo
              DefaultSelectionStyle(
                selectionColor: const Color(0x553F51B5),
                cursorColor: const Color(0xFF1A237E),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const <Widget>[
                        Text(
                          'Palette A — Indigo',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        SelectableText(
                          'Indigo selection. Drag across this sentence to '
                          'see the indigo @ 33% rectangle and an indigo-900 '
                          'caret blink.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Palette B — Teal
              DefaultSelectionStyle(
                selectionColor: const Color(0x55009688),
                cursorColor: const Color(0xFF004D40),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const <Widget>[
                        Text(
                          'Palette B — Teal',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        SelectableText(
                          'Teal selection. The translucent teal works well '
                          'with both light and dark backgrounds; the cursor '
                          'is teal-900 for contrast.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Palette C — Crimson
              DefaultSelectionStyle(
                selectionColor: const Color(0x55D81B60),
                cursorColor: const Color(0xFF880E4F),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const <Widget>[
                        Text(
                          'Palette C — Crimson',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        SelectableText(
                          'Crimson selection. Use sparingly: high-saturation '
                          'pinks can clash with brand reds.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Palette D — Forest green
              DefaultSelectionStyle(
                selectionColor: const Color(0x552E7D32),
                cursorColor: const Color(0xFF1B5E20),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const <Widget>[
                        Text(
                          'Palette D — Forest green',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        SelectableText(
                          'Forest selection. Friendly to color-vision-deficient '
                          'users; pairs well with cream backgrounds.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Palette E — Slate
              DefaultSelectionStyle(
                selectionColor: const Color(0x55455A64),
                cursorColor: const Color(0xFF263238),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const <Widget>[
                        Text(
                          'Palette E — Slate',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        SelectableText(
                          'Slate selection. The neutral choice when a brand '
                          'has no chromatic accent or wants restraint.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Palette F — Amber
              DefaultSelectionStyle(
                selectionColor: const Color(0x55FFB300),
                cursorColor: const Color(0xFFE65100),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const <Widget>[
                        Text(
                          'Palette F — Amber',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        SelectableText(
                          'Amber selection. Beware: bright amber on light '
                          'backgrounds can lower glyph contrast — see the '
                          'pitfalls section below.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Each card hands the SelectableText a different brand. The '
                'gallery shows that DefaultSelectionStyle scales linearly: '
                'one ancestor per scope, with no per-widget plumbing.',
                style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 6 — DefaultSelectionStyle.merge proof
              // =================================================================
              const Text(
                '6 · DefaultSelectionStyle.merge — only override what you change',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'The `.merge` constructor inherits any field you do NOT '
                'specify from the closest ancestor. Below, the OUTER scope '
                'sets red selection AND red cursor. The first inner subtree '
                'uses `.merge` to ONLY change the cursor — the selection '
                'stays red. The second inner subtree uses `.merge` and '
                'overrides BOTH fields with teal.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              DefaultSelectionStyle(
                selectionColor: const Color(0x66E53935),
                cursorColor: const Color(0xFFB71C1C),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xFFFFFAFA),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'OUTER (red selection + red cursor)',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: mergeOuter,
                          decoration: const InputDecoration(
                            labelText: 'Outer baseline',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: DefaultSelectionStyle.merge(
                                cursorColor: const Color(0xFF1A237E),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  color: const Color(0xFFFAFBFF),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        const Text(
                                          '.merge ⇒ cursor only',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'cursorColor changed → indigo-900\n'
                                          'selectionColor inherited → STILL RED',
                                          style: TextStyle(
                                              fontFamily: 'monospace',
                                              fontSize: 12),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: mergeInnerKept,
                                          decoration: const InputDecoration(
                                            labelText: 'merge: cursor only',
                                            border: OutlineInputBorder(),
                                            isDense: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: DefaultSelectionStyle.merge(
                                selectionColor: const Color(0x66009688),
                                cursorColor: const Color(0xFF004D40),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  color: const Color(0xFFF0FBFA),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        const Text(
                                          '.merge ⇒ both fields',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'selectionColor → teal @ 40%\n'
                                          'cursorColor → teal-900',
                                          style: TextStyle(
                                              fontFamily: 'monospace',
                                              fontSize: 12),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: mergeInnerOverridden,
                                          decoration: const InputDecoration(
                                            labelText: 'merge: full override',
                                            border: OutlineInputBorder(),
                                            isDense: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Mental model:\n'
                          'DefaultSelectionStyle(...)        ≈ SET each field\n'
                          'DefaultSelectionStyle.merge(...)  ≈ PATCH only the\n'
                          '                                  fields you pass',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 12.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Use `.merge` when you only want to tweak ONE knob and let '
                'every other field cascade from above. This is the typical '
                'shape inside reusable widgets that should not stomp the '
                'host app\'s palette.',
                style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 7 — Theme integration
              // =================================================================
              const Text(
                '7 · Theme integration — the source of the implicit default',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'You almost never need to wrap your app in a top-level '
                'DefaultSelectionStyle: MaterialApp does it for you, '
                'reading from ThemeData.textSelectionTheme. The block below '
                'wraps a subtree in a Theme(...) override that flips the '
                'palette to a "warm-paper" theme. The three TextFields '
                'inside have NO DefaultSelectionStyle ancestor of their own; '
                'they pull from the new Theme via the implicit '
                'DefaultSelectionStyle that MaterialApp installed.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Color(0xFF8D6E63),
                    selectionColor: Color(0x558D6E63),
                    selectionHandleColor: Color(0xFF6D4C41),
                  ),
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xFFFBF7F2),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Theme override: warm-paper palette',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'cursorColor:    0xFF8D6E63 (brown 400)\n'
                          'selectionColor: 0x558D6E63 (brown 400 @ 33%)\n'
                          'selectionHandleColor: 0xFF6D4C41 (brown 600)',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 12.5),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: themeIntegrationOne,
                          decoration: const InputDecoration(
                            labelText: 'Theme-fed field 1',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: themeIntegrationTwo,
                          decoration: const InputDecoration(
                            labelText: 'Theme-fed field 2',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: themeIntegrationThree,
                          decoration: const InputDecoration(
                            labelText: 'Theme-fed field 3',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const SelectableText(
                          'Selectable text under the theme override picks '
                          'up the warm-paper palette automatically.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFEFEFEF),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Text(
                        'Precedence (top wins)',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '1. Explicit cursorColor / selectionColor on the '
                        'widget itself (e.g. TextField(cursorColor: ...))\n'
                        '2. Closest DefaultSelectionStyle ancestor\n'
                        '3. ThemeData.textSelectionTheme (via the implicit '
                        'DefaultSelectionStyle MaterialApp installs)\n'
                        '4. Framework defaults (caret = primary; selection = '
                        'primary @ ~33%)',
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 8 — Mouse cursor
              // =================================================================
              const Text(
                '8 · Mouse cursor — DefaultSelectionStyle.mouseCursor',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'On desktop & web, hovering a region usually flips the '
                'pointer to an I-beam over text. DefaultSelectionStyle '
                'lets you change that. Each row below sets a different '
                'mouseCursor and wraps a TextField + a SelectableText.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              DefaultSelectionStyle(
                mouseCursor: SystemMouseCursors.text,
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Cursor: SystemMouseCursors.text (I-beam, default)',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: mouseCursorText,
                          decoration: const InputDecoration(
                            labelText: 'Hover me — I-beam',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SelectableText(
                          'And this SelectableText shows the same I-beam.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DefaultSelectionStyle(
                mouseCursor: SystemMouseCursors.grab,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xFFFFFCF1),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Cursor: SystemMouseCursors.grab (open hand)',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: mouseCursorGrab,
                          decoration: const InputDecoration(
                            labelText: 'Hover me — grab',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SelectableText(
                          'Use the grab cursor when text is also a drag '
                          'handle (rare — but a useful trick for kanban '
                          'card titles).',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DefaultSelectionStyle(
                mouseCursor: SystemMouseCursors.help,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xFFF5FBFF),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Cursor: SystemMouseCursors.help (question mark)',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: mouseCursorHelp,
                          decoration: const InputDecoration(
                            labelText: 'Hover me — help',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SelectableText(
                          'Useful in tutorial UIs where hovering a sample '
                          'value should hint that more info is available.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Note: changing mouseCursor does NOT affect touch users. '
                'It is purely a desktop / web affordance. If your app must '
                'work on phones, treat it as a progressive enhancement.',
                style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 9 — Form / login mockup
              // =================================================================
              const Text(
                '9 · Form / login mockup — one brand selection color',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Realistic compound UI: a login card next to a sign-up card. '
                'Both are wrapped in ONE DefaultSelectionStyle that sets the '
                'product\'s "violet ink" brand selection. Every field, '
                'helper text, and SelectableText hint inherits it.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              DefaultSelectionStyle(
                selectionColor: const Color(0x667E57C2),
                cursorColor: const Color(0xFF4527A0),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xFFFAF7FF),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Brand: Violet Ink',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'selectionColor: 0x667E57C2   cursorColor: 0xFF4527A0',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 12.5),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Login column
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      const Text(
                                        'Sign in',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 4),
                                      const SelectableText(
                                        'Welcome back. Hold shift+arrow to '
                                        'extend a selection.',
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Color(0xFF666666)),
                                      ),
                                      const SizedBox(height: 14),
                                      TextField(
                                        controller: loginEmail,
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                          prefixIcon: Icon(Icons.email_outlined),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: loginPassword,
                                        decoration: const InputDecoration(
                                          labelText: 'Password',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                          prefixIcon: Icon(Icons.lock_outline),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: FilledButton(
                                              onPressed: () {},
                                              child: const Text('Sign in'),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          OutlinedButton(
                                            onPressed: () {},
                                            child: const Text('Forgot?'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Sign-up column
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      const Text(
                                        'Create account',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 4),
                                      const SelectableText(
                                        'New here? It only takes a minute.',
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Color(0xFF666666)),
                                      ),
                                      const SizedBox(height: 14),
                                      TextField(
                                        controller: signupName,
                                        decoration: const InputDecoration(
                                          labelText: 'Full name',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                          prefixIcon: Icon(Icons.person_outline),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: signupHandle,
                                        decoration: const InputDecoration(
                                          labelText: 'Handle',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                          prefixIcon: Icon(Icons.alternate_email),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: signupBio,
                                        maxLines: 3,
                                        decoration: const InputDecoration(
                                          labelText: 'Short bio',
                                          border: OutlineInputBorder(),
                                          alignLabelWithHint: true,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      FilledButton(
                                        onPressed: () {},
                                        child: const Text('Create account'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const SelectableText(
                          'Footer note. Try selecting words across both '
                          'columns: every input inside the violet brand card '
                          'shares the SAME selection look.',
                          style:
                              TextStyle(fontSize: 13, color: Color(0xFF555555)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This is the most common production use of '
                'DefaultSelectionStyle: a single ancestor wraps a feature '
                'shell so brand cohesion happens for free.',
                style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 10 — Live theme switcher
              // =================================================================
              const Text(
                '10 · Live theme switcher — three preset palettes',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'In a real app you would put a SegmentedButton or DropdownMenu '
                'above the input region whose selectedValue feeds a '
                'DefaultSelectionStyle below. The static rendering below '
                'shows all three preset palettes side by side as Cards, so '
                'you can compare them directly without rebuilding state.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 10),
              // Preset 1 — Indigo
              DefaultSelectionStyle(
                selectionColor: const Color(0x553F51B5),
                cursorColor: const Color(0xFF1A237E),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Row(
                          children: <Widget>[
                            Icon(Icons.brush_outlined, color: Color(0xFF3F51B5)),
                            SizedBox(width: 8),
                            Text(
                              'Preset: Indigo',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: switcherOne,
                          decoration: const InputDecoration(
                            labelText: 'Field — Indigo selection',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Preset 2 — Teal
              DefaultSelectionStyle(
                selectionColor: const Color(0x55009688),
                cursorColor: const Color(0xFF004D40),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Row(
                          children: <Widget>[
                            Icon(Icons.brush_outlined, color: Color(0xFF009688)),
                            SizedBox(width: 8),
                            Text(
                              'Preset: Teal',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: switcherTwo,
                          decoration: const InputDecoration(
                            labelText: 'Field — Teal selection',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Preset 3 — Crimson
              DefaultSelectionStyle(
                selectionColor: const Color(0x55D81B60),
                cursorColor: const Color(0xFF880E4F),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Row(
                          children: <Widget>[
                            Icon(Icons.brush_outlined, color: Color(0xFFD81B60)),
                            SizedBox(width: 8),
                            Text(
                              'Preset: Crimson',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: switcherThree,
                          decoration: const InputDecoration(
                            labelText: 'Field — Crimson selection',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFFAFAFA),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Text(
                        'Live-switching pattern (pseudo-code)',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'enum SelPalette { indigo, teal, crimson }\n'
                        '\n'
                        'SelPalette _palette = SelPalette.indigo;\n'
                        '\n'
                        'Color _selFor(SelPalette p) => switch (p) {\n'
                        '  SelPalette.indigo  => const Color(0x553F51B5),\n'
                        '  SelPalette.teal    => const Color(0x55009688),\n'
                        '  SelPalette.crimson => const Color(0x55D81B60),\n'
                        '};\n'
                        '\n'
                        'DefaultSelectionStyle(\n'
                        '  selectionColor: _selFor(_palette),\n'
                        '  cursorColor:    _curFor(_palette),\n'
                        '  child: ...the input region...\n'
                        ')',
                        style:
                            TextStyle(fontFamily: 'monospace', fontSize: 12.5),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Rebuild on setState; everything inherits — no '
                        'per-field rebuild needed.',
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 11 — Pitfalls (5 cards)
              // =================================================================
              const Text(
                '11 · Pitfalls — five caution cards',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFFFF7F7),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.warning_amber_rounded,
                              color: Color(0xFFC62828)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pitfall 1 — TextSelectionTheme precedence',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Symptom: I wrapped the screen in a '
                        'DefaultSelectionStyle but the selection color did '
                        'not change.\n\n'
                        'Cause: an explicit cursorColor / selectionColor on '
                        'the TextField wins over inheritance. Same for '
                        'EditableText.cursorColor.\n\n'
                        'Fix: remove the per-widget overrides, OR set them '
                        'to the same Color value as the ancestor.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFFFFCF1),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.warning_amber_rounded,
                              color: Color(0xFFE65100)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pitfall 2 — Color opacity / readability',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Symptom: my selection rectangle hides the glyphs.\n\n'
                        'Cause: selectionColor was opaque (alpha = 0xFF) or '
                        'high-saturation amber/yellow at high alpha.\n\n'
                        'Fix: aim for alpha 0x40–0x66 (25–40%) and let the '
                        'glyphs shine through. Pick a hue with enough '
                        'contrast against your typical text color.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFF6F8FB),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.warning_amber_rounded,
                              color: Color(0xFF1565C0)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pitfall 3 — Cursor color != Selection color',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Symptom: caret is invisible against the selection '
                        'rectangle when the user keeps typing while a '
                        'selection is active.\n\n'
                        'Cause: cursorColor and selectionColor were set to '
                        'the same hue at high alpha, so the caret blends '
                        'into the selection block.\n\n'
                        'Fix: cursorColor should be the saturated, opaque '
                        'version (e.g. brand 800), and selectionColor the '
                        'translucent variant (brand 500 @ 33%).',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFF6FBF6),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.warning_amber_rounded,
                              color: Color(0xFF2E7D32)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pitfall 4 — Accessibility / contrast',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Symptom: low-vision users report they cannot tell '
                        'what is selected.\n\n'
                        'Cause: selection rectangle alpha is too low or the '
                        'hue is too close to background.\n\n'
                        'Fix: validate selectionColor at WCAG AA non-text '
                        'contrast (≥3:1) against the field background, and '
                        'check both light & dark themes. Provide a high-'
                        'contrast theme variant for users who request it.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFFAF7FF),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.warning_amber_rounded,
                              color: Color(0xFF6A1B9A)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pitfall 5 — Propagating too broadly',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Symptom: a multi-tenant app shows the WRONG brand '
                        'selection color in some panels.\n\n'
                        'Cause: a top-level DefaultSelectionStyle was placed '
                        'above multiple feature areas that belong to '
                        'different brands, overriding their per-feature '
                        'palettes.\n\n'
                        'Fix: lower the ancestor down the tree to the '
                        'narrowest scope that needs the override, OR rely on '
                        'the per-feature Theme(...) so each tenant has its '
                        'own implicit DefaultSelectionStyle.',
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 32),

              // =================================================================
              // Section 12 — Reference table
              // =================================================================
              const Text(
                '12 · Reference table — related widgets & data classes',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      // Row: header
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text('Symbol',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700)),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text('Role',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text('DefaultSelectionStyle',
                                    style: TextStyle(
                                        fontFamily: 'monospace'))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                'InheritedTheme that exposes selection '
                                'defaults to a subtree.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text('DefaultSelectionStyle.merge',
                                    style: TextStyle(
                                        fontFamily: 'monospace'))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                'Constructor variant that patches only the '
                                'fields you pass; everything else is '
                                'inherited from the closest ancestor.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text('TextSelectionTheme',
                                    style: TextStyle(
                                        fontFamily: 'monospace'))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                'InheritedTheme companion to '
                                'TextSelectionThemeData. ThemeData carries '
                                'one of these; MaterialApp pipes it into '
                                'the implicit DefaultSelectionStyle.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text('TextSelectionThemeData',
                                    style: TextStyle(
                                        fontFamily: 'monospace'))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                'Plain data class: cursorColor, '
                                'selectionColor, selectionHandleColor. '
                                'Stored on ThemeData.textSelectionTheme.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text('ThemeData',
                                    style: TextStyle(
                                        fontFamily: 'monospace'))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                'Top-level Material design configuration. '
                                'Carries colorScheme, textTheme, and the '
                                'textSelectionTheme that seeds the implicit '
                                'DefaultSelectionStyle.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text('EditableText',
                                    style: TextStyle(
                                        fontFamily: 'monospace'))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                'Low-level editing primitive used by '
                                'TextField, SelectableText, and forms. '
                                'Reads DefaultSelectionStyle.of(context) '
                                'when no per-widget cursorColor / '
                                'selectionColor is provided.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text('SelectableText',
                                    style: TextStyle(
                                        fontFamily: 'monospace'))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                'Read-only equivalent of TextField. Honors '
                                'DefaultSelectionStyle the same way for '
                                'selectionColor and cursorColor.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text('TextField',
                                    style: TextStyle(
                                        fontFamily: 'monospace'))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                'High-level Material input. If you do NOT '
                                'pass cursorColor / selectionColor, the '
                                'closest DefaultSelectionStyle wins.',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                margin: EdgeInsets.zero,
                color: const Color(0xFFF1F8E9),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Text(
                        'Cheat sheet',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Want to brand selection app-wide?\n'
                        '   → Set ThemeData.textSelectionTheme.\n'
                        'Want to brand selection in ONE feature?\n'
                        '   → Wrap that feature in DefaultSelectionStyle.\n'
                        'Want to tweak only the cursor inside a feature?\n'
                        '   → Use DefaultSelectionStyle.merge(cursorColor: ...).\n'
                        'Want a different mouse cursor on hover?\n'
                        '   → DefaultSelectionStyle(mouseCursor: ...).\n'
                        'Want per-tenant brands?\n'
                        '   → Use Theme(...) per-tenant; the implicit '
                        'DefaultSelectionStyle follows.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'End of demo. Every TextField and SelectableText above is '
                'live; select text in any of them and verify the section\'s '
                'declared colors visually.',
                style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF555555)),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}
