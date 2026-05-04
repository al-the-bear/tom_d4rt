// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unnecessary_import
// D4rt test script: Deep visual demo of SelectionChangedCause from
// package:flutter/services.dart.
//
// SelectionChangedCause is the small enum that Flutter attaches to every
// selection change emitted by an editable text field. When a TextField calls
// its onSelectionChanged callback, or when a TextEditingController surfaces a
// new TextSelection through its value, the framework also reports *why* the
// selection moved: did the user tap, double-tap, long-press, force-press,
// drag with a mouse, hit a keyboard shortcut, choose an item from a
// selection toolbar, or use stylus handwriting (Scribble on iPadOS / Scribe
// on Android)?
//
// The cause matters because different kinds of UX should react differently:
// * a `tap` selection change usually means "place the caret" and is fine to
//   ignore for analytics;
// * a `doubleTap` or `longPress` typically expands a selection to a word and
//   is a great moment to show formatting toolbars;
// * a `keyboard` change comes from arrow keys or the IME and should *not*
//   trigger toolbar popups;
// * a `toolbar` change comes from "Select All" / "Cut" / "Paste" buttons and
//   should not re-open the toolbar that produced it (otherwise you get
//   recursion);
// * `drag` is mouse-driven on desktop / web;
// * `forcePress` is iOS-only and rare;
// * `stylusHandwriting` (formerly `scribble`) is the modern Scribble/Scribe
//   pathway, with `scribble` kept as a deprecated alias.
//
// This file is a static visual catalogue: it does NOT animate, run timers,
// or call any test()/expect(). It only builds widgets so that the d4rt
// flutter AST pipeline can lift it, ship it over HTTP, and re-render it.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('SelectionChangedCause Deep Demo executing');

  // ============================================================
  // SECTION 1: Hero header with enum overview
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E293B),
          Color(0xFF312E81),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.cyan.shade300,
                    Colors.indigo.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.cyan.withValues(alpha: 0.5),
                    blurRadius: 14.0,
                    offset: const Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.text_fields,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'SelectionChangedCause',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: Colors.cyan.shade100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.0,
            ),
          ),
          child: const Text(
            'Why did the selection change? Flutter attaches one of these '
            'eight enum values to every selection update so that text widgets '
            'can react proportionally: place a caret on tap, expand a word on '
            'double-tap, open a toolbar on long-press, etc.',
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _buildHeroChip(
              '${SelectionChangedCause.values.length} values',
              Icons.format_list_numbered,
              Colors.amberAccent,
            ),
            _buildHeroChip('flutter/services', Icons.api, Colors.lightGreenAccent),
            _buildHeroChip('text input', Icons.keyboard, Colors.pinkAccent),
            _buildHeroChip(
              'first: ${SelectionChangedCause.values.first.name}',
              Icons.first_page,
              Colors.cyanAccent,
            ),
            _buildHeroChip(
              'last: ${SelectionChangedCause.values.last.name}',
              Icons.last_page,
              Colors.purpleAccent,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy / enum signature
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomy = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.blueGrey.shade50,
          Colors.blueGrey.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.account_tree, color: Colors.blueGrey.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Enum anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: const Text(
            'enum SelectionChangedCause {\n'
            '  tap,                 // index 0 — cursor placement\n'
            '  doubleTap,           // index 1 — expand to word\n'
            '  longPress,           // index 2 — open selection handles\n'
            '  forcePress,          // index 3 — iOS 3D Touch / haptic\n'
            '  keyboard,            // index 4 — arrow keys / IME\n'
            '  toolbar,             // index 5 — Select All / Cut / Paste\n'
            '  drag,                // index 6 — mouse drag-select\n'
            '  stylusHandwriting,   // index 7 — Scribble / Scribe\n'
            '\n'
            '  @Deprecated(...)\n'
            '  static const scribble = stylusHandwriting;\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.45,
              color: Color(0xFFD4D4D8),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'Reported through TextField.onSelectionChanged(TextSelection, '
          'SelectionChangedCause?). The cause is nullable because programmatic '
          'changes (controller.selection = ...) do not carry user intent.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.blueGrey.shade800,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards for ALL members
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  final List<_CauseSpec> specs = <_CauseSpec>[
    _CauseSpec(
      cause: SelectionChangedCause.tap,
      icon: Icons.touch_app,
      color: Colors.blue,
      gradient: <Color>[Colors.blue.shade100, Colors.blue.shade300],
      headline: 'Single tap',
      description:
          'A single tap on the text. The framework moves the caret to the '
          'tapped offset; no range is selected. This is by far the most '
          'common cause and is usually safe to ignore for toolbar logic.',
      example: '"Hello |world"  (caret placed before w)',
      platforms: const <String>['iOS', 'Android', 'Web', 'Desktop'],
      progress: 0.05,
    ),
    _CauseSpec(
      cause: SelectionChangedCause.doubleTap,
      icon: Icons.ads_click,
      color: Colors.indigo,
      gradient: <Color>[Colors.indigo.shade100, Colors.indigo.shade300],
      headline: 'Double tap (word select)',
      description:
          'Two taps in fast succession. Flutter expands the selection to the '
          'word boundary at the tap location. Great moment to surface a '
          'context toolbar with Cut / Copy / Paste.',
      example: '"Hello [world]"  (word selected)',
      platforms: const <String>['iOS', 'Android', 'Web', 'Desktop'],
      progress: 0.30,
    ),
    _CauseSpec(
      cause: SelectionChangedCause.longPress,
      icon: Icons.front_hand,
      color: Colors.deepPurple,
      gradient: <Color>[Colors.deepPurple.shade100, Colors.deepPurple.shade300],
      headline: 'Long press',
      description:
          'A press-and-hold gesture. On mobile this expands to a word and '
          'opens the platform selection handles + toolbar. The framework '
          'guarantees haptic feedback on Android.',
      example: '"Hello [world] today"  (handles visible)',
      platforms: const <String>['iOS', 'Android'],
      progress: 0.45,
    ),
    _CauseSpec(
      cause: SelectionChangedCause.forcePress,
      icon: Icons.touch_app_outlined,
      color: Colors.pink,
      gradient: <Color>[Colors.pink.shade100, Colors.pink.shade300],
      headline: 'Force press (3D Touch)',
      description:
          'A high-pressure press, historically iOS 3D Touch. Modern hardware '
          'rarely emits this, but Flutter still surfaces it for backwards '
          'compatibility. Treat it like a long-press in most UIs.',
      example: '"Hello [world]"  (peeks preview)',
      platforms: const <String>['iOS (legacy)'],
      progress: 0.55,
    ),
    _CauseSpec(
      cause: SelectionChangedCause.keyboard,
      icon: Icons.keyboard,
      color: Colors.teal,
      gradient: <Color>[Colors.teal.shade100, Colors.teal.shade300],
      headline: 'Keyboard / IME',
      description:
          'Arrow keys, Shift+arrow, Home/End, or an IME (input method). '
          'Accessibility tools such as TalkBack and VoiceOver also report '
          'their cursor moves through this cause. Do NOT open a popup '
          'toolbar here; it would steal focus from the keyboard user.',
      example: '"He|llo world"  (Shift+Right extends)',
      platforms: const <String>['Desktop', 'Web', 'a11y'],
      progress: 0.65,
    ),
    _CauseSpec(
      cause: SelectionChangedCause.toolbar,
      icon: Icons.build,
      color: Colors.orange,
      gradient: <Color>[Colors.orange.shade100, Colors.orange.shade300],
      headline: 'Selection toolbar',
      description:
          'The user tapped a button in the floating toolbar — Select All, '
          'Cut, Copy, Paste, Look Up, Share, Translate, etc. The selection '
          'has been mutated programmatically by Flutter on the user\'s '
          'behalf. Re-opening the toolbar here usually causes recursion.',
      example: '"[Hello world]"  (Select All)',
      platforms: const <String>['iOS', 'Android', 'Web', 'Desktop'],
      progress: 0.75,
    ),
    _CauseSpec(
      cause: SelectionChangedCause.drag,
      icon: Icons.mouse,
      color: Colors.green,
      gradient: <Color>[Colors.green.shade100, Colors.green.shade300],
      headline: 'Mouse drag',
      description:
          'The user dragged the mouse pointer across text while holding the '
          'primary button. Streams continuously while the drag is in '
          'progress, so debounce any expensive listeners that watch this '
          'cause.',
      example: '"He[llo wor]ld"  (drag selection)',
      platforms: const <String>['Desktop', 'Web'],
      progress: 0.85,
    ),
    _CauseSpec(
      cause: SelectionChangedCause.stylusHandwriting,
      icon: Icons.draw,
      color: Colors.purple,
      gradient: <Color>[Colors.purple.shade100, Colors.purple.shade300],
      headline: 'Stylus handwriting',
      description:
          'iPadOS 14+ Scribble or Android API 34+ Scribe converted strokes '
          'into selection edits. The deprecated `scribble` constant is a '
          'static alias of this value — use `stylusHandwriting` going '
          'forward.',
      example: '"Hello world|"  (stylus appended)',
      platforms: const <String>['iPadOS 14+', 'Android 14+'],
      progress: 0.95,
    ),
  ];

  final List<Widget> causeCards = <Widget>[];
  for (final _CauseSpec spec in specs) {
    print(
      'Building card for SelectionChangedCause.${spec.cause.name} '
      '(index ${spec.cause.index})',
    );
    causeCards.add(_buildCauseCard(spec));
  }

  // ============================================================
  // SECTION 4: Mock text-field cause-badge gallery
  // ============================================================
  print('=== Section 4: Mock text-field gallery ===');

  final List<Widget> mockFields = <Widget>[];
  for (final _CauseSpec spec in specs) {
    mockFields.add(_buildMockTextField(spec));
  }

  final mockGallery = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.grey.shade100,
          Colors.blueGrey.shade50,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.preview, color: Colors.blueGrey.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Mock TextField gallery',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Each field below shows what a TextField would emit for one '
          'specific cause: the visible selection range plus a coloured '
          'badge with the cause name. The frames are static — no real '
          'interaction takes place.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.blueGrey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        Column(children: mockFields),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Input-channel diagram
  // ============================================================
  print('=== Section 5: Input-channel diagram ===');

  final inputDiagram = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFFFFFBEB),
          Color(0xFFFEF3C7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.hub, color: Colors.amber.shade900, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Input channels → SelectionChangedCause',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: <Widget>[
            _buildChannelNode(
              'Touch',
              Icons.touch_app,
              Colors.blue,
              <String>['tap', 'doubleTap', 'longPress', 'forcePress'],
            ),
            _buildChannelNode(
              'Mouse',
              Icons.mouse,
              Colors.green,
              <String>['tap', 'drag'],
            ),
            _buildChannelNode(
              'Keyboard',
              Icons.keyboard,
              Colors.teal,
              <String>['keyboard'],
            ),
            _buildChannelNode(
              'Toolbar',
              Icons.build,
              Colors.orange,
              <String>['toolbar'],
            ),
            _buildChannelNode(
              'Stylus',
              Icons.draw,
              Colors.purple,
              <String>['stylusHandwriting'],
            ),
            _buildChannelNode(
              'a11y / IME',
              Icons.accessibility_new,
              Colors.pink,
              <String>['keyboard'],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.amber.shade200, width: 1.0),
          ),
          child: Text(
            'Reading the diagram: each input channel can produce one or more '
            'causes. Mouse drag, for example, produces drag while a single '
            'mouse click produces tap. Keyboard arrow keys, IME composition '
            'updates, and accessibility services all share the keyboard '
            'cause — listen for it carefully when adding analytics.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.amber.shade900,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Recipes
  // ============================================================
  print('=== Section 6: Recipes ===');

  final recipes = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFFEFF6FF),
          Color(0xFFDBEAFE),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Colors.blue.shade800, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Recipes — TextField onSelectionChanged',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildRecipeBlock(
          '1. Open a custom toolbar only on user gestures',
          'TextField(\n'
              '  controller: _ctrl,\n'
              '  onSelectionChanged: (TextSelection sel,\n'
              '                       SelectionChangedCause? cause) {\n'
              '    if (cause == SelectionChangedCause.longPress ||\n'
              '        cause == SelectionChangedCause.doubleTap) {\n'
              '      _showFormattingToolbar(sel);\n'
              '    }\n'
              '  },\n'
              ');',
          Colors.indigo,
        ),
        const SizedBox(height: 12.0),
        _buildRecipeBlock(
          '2. Skip analytics for programmatic / keyboard moves',
          'void _onSel(TextSelection s, SelectionChangedCause? c) {\n'
              '  if (c == null) return;                 // programmatic\n'
              '  if (c == SelectionChangedCause.keyboard) return;\n'
              '  analytics.logSelection(c.name, s);\n'
              '}',
          Colors.teal,
        ),
        const SizedBox(height: 12.0),
        _buildRecipeBlock(
          '3. Differentiate desktop drag-select',
          'switch (cause) {\n'
              '  case SelectionChangedCause.drag:\n'
              '    _liveHighlight(sel);\n'
              '    break;\n'
              '  case SelectionChangedCause.tap:\n'
              '    _placeCaret(sel);\n'
              '    break;\n'
              '  default:\n'
              '    break;\n'
              '}',
          Colors.green,
        ),
        const SizedBox(height: 12.0),
        _buildRecipeBlock(
          '4. Handle stylusHandwriting + legacy scribble alias',
          'final isStylus = cause ==\n'
              '    SelectionChangedCause.stylusHandwriting ||\n'
              '    cause == SelectionChangedCause.scribble; // alias\n'
              'if (isStylus) _captureScribbleSession();',
          Colors.purple,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfalls = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFFFEF2F2),
          Color(0xFFFEE2E2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Common pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildPitfallRow(
          'Treating the cause as non-null',
          'It is `SelectionChangedCause?`. Programmatic changes to a '
              'TextEditingController.selection arrive with a null cause.',
        ),
        _buildPitfallRow(
          'Re-opening a toolbar from the toolbar cause',
          'If you call showSelectionToolbar() inside the handler when '
              'cause == toolbar, you build a recursive loop where every '
              'Select All re-shows the toolbar.',
        ),
        _buildPitfallRow(
          'Stealing focus on keyboard moves',
          'Pop-overs that trigger on every onSelectionChanged break IME '
              'composition for CJK / accessibility users. Filter out '
              'keyboard explicitly.',
        ),
        _buildPitfallRow(
          'Assuming forcePress still fires',
          'Most current iOS hardware does not emit forcePress at all. '
              'Treat it as a graceful long-press fallback rather than a '
              'mandatory case.',
        ),
        _buildPitfallRow(
          'Comparing on .name strings',
          'Use the enum identity (cause == SelectionChangedCause.tap), '
              'not string comparisons; the names are not part of any '
              'public stability contract for analytics serialisation.',
        ),
        _buildPitfallRow(
          'Ignoring drag debouncing',
          'A long mouse drag fires onSelectionChanged on every frame. '
              'Heavy work belongs in onSelectionHandleTapped or in a '
              'debounced micro-task.',
        ),
        _buildPitfallRow(
          'Using `scribble` in new code',
          'It is a deprecated static const aliasing stylusHandwriting. '
              'New code should target stylusHandwriting and accept '
              'scribble only when interoperating with old callers.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Comparison matrix
  // ============================================================
  print('=== Section 8: Comparison matrix ===');

  final matrixHeader = Row(
    children: <Widget>[
      _buildMatrixHeader('Cause', 130.0),
      _buildMatrixHeader('Idx', 40.0),
      _buildMatrixHeader('Touch', 60.0),
      _buildMatrixHeader('Mouse', 60.0),
      _buildMatrixHeader('Keys', 50.0),
      _buildMatrixHeader('Stylus', 60.0),
      _buildMatrixHeader('Toolbar', 70.0),
      _buildMatrixHeader('Range?', 65.0),
    ],
  );

  final List<Widget> matrixRows = <Widget>[];
  matrixRows.add(matrixHeader);
  matrixRows.add(_buildMatrixRow(SelectionChangedCause.tap,
      true, true, false, false, false, false));
  matrixRows.add(_buildMatrixRow(SelectionChangedCause.doubleTap,
      true, false, false, false, false, true));
  matrixRows.add(_buildMatrixRow(SelectionChangedCause.longPress,
      true, false, false, false, true, true));
  matrixRows.add(_buildMatrixRow(SelectionChangedCause.forcePress,
      true, false, false, false, true, true));
  matrixRows.add(_buildMatrixRow(SelectionChangedCause.keyboard,
      false, false, true, false, false, true));
  matrixRows.add(_buildMatrixRow(SelectionChangedCause.toolbar,
      false, false, false, false, true, true));
  matrixRows.add(_buildMatrixRow(SelectionChangedCause.drag,
      false, true, false, false, false, true));
  matrixRows.add(_buildMatrixRow(SelectionChangedCause.stylusHandwriting,
      false, false, false, true, false, true));

  final matrix = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.deepPurple.shade50,
          Colors.indigo.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.grid_on, color: Colors.indigo.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Comparison matrix',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: matrixRows,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Legend: a green check means the input channel can produce that '
          'cause; a faded dash means it cannot. The "Range?" column shows '
          'whether the cause typically results in a non-collapsed selection.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.indigo.shade800,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  print('=== Section 9: ASCII footer ===');

  final footer = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E293B),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.terminal, color: Colors.greenAccent.shade400, size: 18.0),
            const SizedBox(width: 6.0),
            Text(
              'selection_changed_cause.txt',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Colors.greenAccent.shade400,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          '+----------------------------------------------------------+\n'
          '|  TextField       |   onSelectionChanged(sel, cause)      |\n'
          '+------------------+---------------------------------------+\n'
          '|  user touch  --> | tap / doubleTap / longPress / force   |\n'
          '|  mouse       --> | tap / drag                            |\n'
          '|  keyboard    --> | keyboard       (also IME / a11y)      |\n'
          '|  toolbar     --> | toolbar        (Cut/Copy/Paste/All)   |\n'
          '|  stylus      --> | stylusHandwriting (was: scribble)     |\n'
          '|  programmatic--> | null cause                            |\n'
          '+------------------+---------------------------------------+\n'
          '\n'
          '   tap  doubleTap  longPress  forcePress\n'
          '    \\      |          /          /\n'
          '     \\     |         /          /\n'
          '      \\    |        /          /\n'
          '       \\   |       /          /\n'
          '        \\  |      /          /\n'
          '         > TextSelection <\n'
          '        /  |      \\          \\\n'
          '       /   |       \\          \\\n'
          '   keyboard toolbar  drag  stylusHandwriting\n',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.35,
            color: Color(0xFFA7F3D0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Static AlwaysStoppedAnimation<double> '
          '${const AlwaysStoppedAnimation<double>(1.0).value} • '
          'Duration.zero • ${SelectionChangedCause.values.length} enum values',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: Colors.greenAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Diagnostics strip
  // ============================================================
  print('=== Section 10: Diagnostics ===');

  final diagnostics = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.cyan.shade50,
          Colors.lightBlue.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.fact_check, color: Colors.cyan.shade800, size: 20.0),
            const SizedBox(width: 6.0),
            Text(
              'Runtime diagnostics',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final SelectionChangedCause cause
                in SelectionChangedCause.values)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.cyan.shade200, width: 1.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.cyan.withValues(alpha: 0.12),
                      blurRadius: 4.0,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Text(
                  '${cause.index}: ${cause.name}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: Colors.cyan.shade900,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // Reference an AlwaysStoppedAnimation explicitly so motion is provably
  // frozen, and a Duration.zero to satisfy the "no animation" requirement
  // while still demonstrating the pattern.
  const Animation<double> frozen = AlwaysStoppedAnimation<double>(1.0);
  const Duration instant = Duration.zero;
  print('Frozen animation value: ${frozen.value}, duration: $instant');

  print('SelectionChangedCause Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hero,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '2. Anatomy & enum signature',
              Icons.account_tree,
              Colors.blueGrey.shade700,
            ),
            anatomy,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '3. Per-value cards',
              Icons.style,
              Colors.indigo.shade700,
            ),
            ...causeCards,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '4. Mock TextField cause-badge gallery',
              Icons.preview,
              Colors.blueGrey.shade700,
            ),
            mockGallery,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '5. Input-channel diagram',
              Icons.hub,
              Colors.amber.shade800,
            ),
            inputDiagram,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '6. Recipes',
              Icons.menu_book,
              Colors.blue.shade800,
            ),
            recipes,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '7. Pitfalls',
              Icons.warning_amber_rounded,
              Colors.red.shade700,
            ),
            pitfalls,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '8. Comparison matrix',
              Icons.grid_on,
              Colors.indigo.shade700,
            ),
            matrix,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '9. Diagnostics',
              Icons.fact_check,
              Colors.cyan.shade800,
            ),
            diagnostics,
            const SizedBox(height: 18.0),
            _buildSectionTitle(
              '10. ASCII footer',
              Icons.terminal,
              Colors.green.shade700,
            ),
            footer,
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Internal types
// ============================================================

class _CauseSpec {
  _CauseSpec({
    required this.cause,
    required this.icon,
    required this.color,
    required this.gradient,
    required this.headline,
    required this.description,
    required this.example,
    required this.platforms,
    required this.progress,
  });

  final SelectionChangedCause cause;
  final IconData icon;
  final Color color;
  final List<Color> gradient;
  final String headline;
  final String description;
  final String example;
  final List<String> platforms;
  final double progress;
}

// ============================================================
// Helpers
// ============================================================

Widget _buildSectionTitle(String title, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                color.withValues(alpha: 0.15),
                color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHeroChip(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14.0, color: color),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            color: color,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _buildCauseCard(_CauseSpec spec) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: spec.gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: spec.color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spec.color.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: spec.color.withValues(alpha: 0.3),
                    blurRadius: 6.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(spec.icon, size: 26.0, color: spec.color),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    spec.headline,
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      color: spec.color.withValues(alpha: 0.95),
                    ),
                  ),
                  Text(
                    'SelectionChangedCause.${spec.cause.name}  •  '
                    'index ${spec.cause.index}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: spec.color.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: spec.color,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '#${spec.cause.index}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            spec.description,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            spec.example,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFE2E8F0),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        // Static progress bar reflecting where this cause sits on the
        // "user intent" continuum (0.0 = passive caret, 1.0 = strong
        // intent like a long-press or stylus stroke). Driven by an
        // AlwaysStoppedAnimation so motion is provably frozen.
        _buildFrozenProgress(spec.progress, spec.color),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (final String platform in spec.platforms)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: spec.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: spec.color.withValues(alpha: 0.45),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  platform,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: spec.color.withValues(alpha: 0.95),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFrozenProgress(double value, Color color) {
  // Use AlwaysStoppedAnimation<double> + Duration.zero to satisfy the
  // "no motion" rule while still wiring the value through an animation
  // primitive — exactly what offline visual snapshots want.
  const Duration zero = Duration.zero;
  final Animation<double> frozen = AlwaysStoppedAnimation<double>(value);
  return Tooltip(
    waitDuration: zero,
    showDuration: zero,
    message: 'frozen progress = ${(frozen.value * 100).toStringAsFixed(0)}%',
    child: Container(
      height: 8.0,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: frozen.value.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[color.withValues(alpha: 0.7), color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    ),
  );
}

Widget _buildMockTextField(_CauseSpec spec) {
  // Pick a static "selection" range shown by a coloured underline in the
  // mock label. Different causes highlight different chunks to illustrate
  // typical effects (caret vs word vs paragraph).
  final String full = 'The quick brown fox jumps over the lazy dog.';
  late String before;
  late String selected;
  late String after;
  switch (spec.cause) {
    case SelectionChangedCause.tap:
      before = 'The quick brown fox |';
      selected = '';
      after = ' jumps over the lazy dog.';
      break;
    case SelectionChangedCause.doubleTap:
      before = 'The quick brown ';
      selected = 'fox';
      after = ' jumps over the lazy dog.';
      break;
    case SelectionChangedCause.longPress:
      before = 'The quick ';
      selected = 'brown fox';
      after = ' jumps over the lazy dog.';
      break;
    case SelectionChangedCause.forcePress:
      before = 'The quick brown ';
      selected = 'fox jumps';
      after = ' over the lazy dog.';
      break;
    case SelectionChangedCause.keyboard:
      before = 'The quick brown fox ';
      selected = 'jumps';
      after = ' over the lazy dog.';
      break;
    case SelectionChangedCause.toolbar:
      before = '';
      selected = full;
      after = '';
      break;
    case SelectionChangedCause.drag:
      before = 'The quick ';
      selected = 'brown fox jumps over';
      after = ' the lazy dog.';
      break;
    case SelectionChangedCause.stylusHandwriting:
      before = 'The quick brown fox jumps over the lazy ';
      selected = 'dog';
      after = '.';
      break;
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: spec.color.withValues(alpha: 0.4), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spec.color.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(spec.icon, size: 18.0, color: spec.color),
            const SizedBox(width: 6.0),
            Text(
              'TextField — cause: ${spec.cause.name}',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: spec.color,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: spec.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'idx ${spec.cause.index}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: spec.color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: Colors.black87,
                height: 1.4,
              ),
              children: <InlineSpan>[
                TextSpan(text: before),
                TextSpan(
                  text: selected,
                  style: TextStyle(
                    backgroundColor: spec.color.withValues(alpha: 0.25),
                    color: spec.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: after),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildChannelNode(
  String label,
  IconData icon,
  Color color,
  List<String> causes,
) {
  return Container(
    width: 130.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, color: color, size: 26.0),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: color,
          ),
        ),
        const SizedBox(height: 6.0),
        for (final String name in causes)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: color,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _buildRecipeBlock(String title, String code, Color accent) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.restaurant_menu, size: 16.0, color: accent),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.4,
              color: Color(0xFFE2E8F0),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallRow(String title, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.error_outline, color: Colors.red.shade600, size: 18.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.red.shade900,
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

Widget _buildMatrixHeader(String text, double width) {
  return Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade100,
      border: Border(
        bottom: BorderSide(color: Colors.indigo.shade300, width: 1.5),
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.5,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _buildMatrixRow(
  SelectionChangedCause cause,
  bool touch,
  bool mouse,
  bool keys,
  bool stylus,
  bool toolbar,
  bool range,
) {
  return Container(
    decoration: BoxDecoration(
      color: cause.index.isEven
          ? Colors.white
          : Colors.indigo.shade50.withValues(alpha: 0.6),
      border: Border(
        bottom: BorderSide(color: Colors.indigo.shade100, width: 1.0),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              cause.name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40.0,
          child: Text(
            '${cause.index}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.indigo.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        _buildMatrixBool(touch, 60.0),
        _buildMatrixBool(mouse, 60.0),
        _buildMatrixBool(keys, 50.0),
        _buildMatrixBool(stylus, 60.0),
        _buildMatrixBool(toolbar, 70.0),
        _buildMatrixBool(range, 65.0),
      ],
    ),
  );
}

Widget _buildMatrixBool(bool value, double width) {
  return SizedBox(
    width: width,
    child: Icon(
      value ? Icons.check_circle : Icons.remove_circle_outline,
      color: value ? Colors.green.shade600 : Colors.grey.shade400,
      size: 16.0,
    ),
  );
}
