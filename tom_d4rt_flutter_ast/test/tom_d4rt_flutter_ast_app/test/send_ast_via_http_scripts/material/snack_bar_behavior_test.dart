// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Tests SnackBarBehavior enum from package:flutter/material.dart
// Deep Demo: Visual demonstration of SnackBarBehavior values (fixed, floating)
// with mock Scaffold previews, layout diagrams, comparison matrices,
// recipes, and pitfalls.
//
// SnackBarBehavior controls how a SnackBar is positioned by ScaffoldMessenger.
//   - SnackBarBehavior.fixed:    snackbar pinned to bottom of Scaffold,
//                                 spanning full width, sitting *behind* the
//                                 FAB and *under* the BottomAppBar.
//   - SnackBarBehavior.floating: snackbar floats above the BottomAppBar/FAB,
//                                 with margin/insets, allowing rounded shape
//                                 and richer Material 3 styling.
//
// This file is intentionally hand-written (no generators) to exercise the
// d4rt AST + flutter widget pipeline with a substantial widget tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnackBarBehavior Deep Demo executing');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  // The hero header introduces the topic and sets the visual key:
  // SnackBarBehavior is a small enum but it has outsized impact on
  // perceived layout polish. We highlight both values at a glance.
  print('=== Section 1: Hero Header ===');

  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade600,
          Colors.blue.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 18.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.25),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.message_rounded,
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
                    'SnackBarBehavior',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'fixed vs floating  -  layout, anatomy, recipes',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Text(
            'Defined in package:flutter/material.dart. '
            'Controls SnackBar layout: pinned-fullwidth (fixed) or '
            'floating-with-margin (floating). Choose deliberately - it '
            'affects FAB clearance, bottom navigation, and gestures.',
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
  print('Hero header built');

  // ============================================================
  // SECTION 2: Anatomy / Enum Signature
  // ============================================================
  // Show the literal enum signature (informational) and surface the two
  // values with their canonical descriptions. This is the table-of-contents
  // for the rest of the demo.
  print('=== Section 2: Enum Anatomy ===');

  print('SnackBarBehavior values:');
  for (final value in SnackBarBehavior.values) {
    print('  - SnackBarBehavior.${value.name} (index ${value.index})');
  }

  final enumSignature = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
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
            Icon(Icons.code, color: Colors.cyanAccent.shade100, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'enum SnackBarBehavior',
              style: TextStyle(
                color: Colors.cyanAccent.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '/// Defines where a SnackBar should appear within a Scaffold and\n'
          '/// how its location should be adjusted when the scaffold also\n'
          '/// includes a [FloatingActionButton] or a [BottomNavigationBar].\n'
          'enum SnackBarBehavior {\n'
          '  fixed,    // pinned to the bottom of the scaffold body\n'
          '  floating, // floats above the bottom widgets, with margin\n'
          '}',
          style: TextStyle(
            color: Colors.greenAccent.shade100,
            fontFamily: 'monospace',
            fontSize: 12.0,
            height: 1.5,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.cyanAccent.shade100,
                size: 16.0,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Total values: ${SnackBarBehavior.values.length}  -  '
                  'first: ${SnackBarBehavior.values.first.name}  -  '
                  'last: ${SnackBarBehavior.values.last.name}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Enum signature panel built');

  // ============================================================
  // SECTION 3: Mock-app frame for SnackBarBehavior.fixed
  // ============================================================
  // We build a Scaffold-shaped preview (NOT a real Scaffold body, since
  // the build() function already returns one) showing where the snackbar
  // appears when behavior is .fixed: full-bleed, behind FAB, under
  // BottomAppBar, no margins, no rounded corners.
  print('=== Section 4: Fixed mock frame ===');

  final fixedMockFrame = _buildMockPhoneFrame(
    title: 'SnackBarBehavior.fixed',
    accent: Colors.indigo,
    description:
        'Full width. Pinned to the bottom of the Scaffold body. Sits '
        'BEHIND the FloatingActionButton and UNDER any BottomAppBar / '
        'BottomNavigationBar. No margin. No rounded corners.',
    snackBarBuilder: _buildFixedSnackBarPreview,
    showBehindFab: true,
  );
  print('Fixed mock frame built');

  // ============================================================
  // SECTION 4: Mock-app frame for SnackBarBehavior.floating
  // ============================================================
  // The floating mock frame shows the snackbar lifted above the FAB and
  // BottomAppBar, with margin around it, a rounded shape, and a slight
  // shadow - the Material 3 default.
  print('=== Section 5: Floating mock frame ===');

  final floatingMockFrame = _buildMockPhoneFrame(
    title: 'SnackBarBehavior.floating',
    accent: Colors.deepOrange,
    description:
        'Floats above the BottomAppBar and FAB. Has visible margin '
        'on all sides, a rounded RoundedRectangleBorder by default, '
        'and casts a shadow. Required when you want gestures on the '
        'underlying scaffold body to remain visible.',
    snackBarBuilder: _buildFloatingSnackBarPreview,
    showBehindFab: false,
  );
  print('Floating mock frame built');

  // ============================================================
  // SECTION 5: Layout diagram with FAB + BottomAppBar
  // ============================================================
  // ASCII-style boxed diagram side-by-side. We use Container/Row layouts
  // to spell out exactly which Z-stack ordering each behavior produces.
  print('=== Section 6: Layout diagram ===');

  final layoutDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
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
            Icon(
              Icons.layers_outlined,
              color: Colors.teal.shade800,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Z-stack ordering: FAB / BottomAppBar / SnackBar',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildZStackBlock(
                label: 'fixed',
                color: Colors.indigo,
                layers: [
                  ['1', 'Body content', Colors.grey.shade300],
                  ['2', 'SnackBar (full width)', Colors.indigo.shade200],
                  ['3', 'BottomAppBar', Colors.indigo.shade400],
                  ['4', 'FAB (in front)', Colors.indigo.shade700],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _buildZStackBlock(
                label: 'floating',
                color: Colors.deepOrange,
                layers: [
                  ['1', 'Body content', Colors.grey.shade300],
                  ['2', 'BottomAppBar', Colors.deepOrange.shade200],
                  ['3', 'FAB', Colors.deepOrange.shade400],
                  ['4', 'SnackBar (lifted, margin)', Colors.deepOrange.shade700],
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
            'Reading: layer 1 is closest to the body, layer 4 is closest '
            'to the user. Notice that with .fixed the SnackBar is layered '
            'beneath the FAB and BottomAppBar, while with .floating the '
            'SnackBar sits on top.',
            style: TextStyle(fontSize: 11.5, color: Colors.teal.shade900),
          ),
        ),
      ],
    ),
  );
  print('Layout diagram built');

  // ============================================================
  // SECTION 6: Comparison matrix
  // ============================================================
  // Property-by-property side-by-side. Pure data + a small layout helper.
  print('=== Section 7: Comparison matrix ===');

  final comparisonMatrix = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property comparison matrix',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade100, Colors.blueGrey.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          child: Row(
            children: [
              _buildMatrixCell('Property', 140.0, bold: true),
              _buildMatrixCell('fixed', 110.0, bold: true),
              _buildMatrixCell('floating', 110.0, bold: true),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        ..._comparisonRows().map(
          (row) => Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                _buildMatrixCell(row[0], 140.0),
                _buildMatrixCell(row[1], 110.0, color: Colors.indigo),
                _buildMatrixCell(row[2], 110.0, color: Colors.deepOrange),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Comparison matrix built');

  // ============================================================
  // SECTION 7: Action-button overlay gallery
  // ============================================================
  // Multiple snackbar styles rendered side-by-side, including with a
  // SnackBarAction button, to show what each behavior looks like in
  // common configurations. We use AlwaysStoppedAnimation<double> for the
  // (purely decorative) entry-progress strip so the demo stays static.
  print('=== Section 8: Action overlay gallery ===');

  final actionGallery = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Action-button overlay gallery',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Same SnackBarAction("UNDO"), four different behavior + style '
          'combinations. Note how rounded shape only "looks right" with '
          'floating, and how a long action label can wrap content.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.amber.shade900,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        _buildSnackbarSample(
          behavior: SnackBarBehavior.fixed,
          accent: Colors.indigo,
          message: 'Item archived',
          actionLabel: 'UNDO',
          progress: 0.25,
        ),
        SizedBox(height: 10.0),
        _buildSnackbarSample(
          behavior: SnackBarBehavior.fixed,
          accent: Colors.red,
          message: 'Connection lost - retrying',
          actionLabel: 'RETRY',
          progress: 0.65,
        ),
        SizedBox(height: 10.0),
        _buildSnackbarSample(
          behavior: SnackBarBehavior.floating,
          accent: Colors.green,
          message: 'Saved successfully',
          actionLabel: 'VIEW',
          progress: 0.4,
        ),
        SizedBox(height: 10.0),
        _buildSnackbarSample(
          behavior: SnackBarBehavior.floating,
          accent: Colors.purple,
          message: 'Permission required to access camera',
          actionLabel: 'OPEN SETTINGS',
          progress: 0.85,
        ),
      ],
    ),
  );
  print('Action gallery built');

  // ============================================================
  // SECTION 8: Recipes (ScaffoldMessenger.showSnackBar)
  // ============================================================
  // Code snippets the developer can copy-paste. We show the canonical
  // patterns for both behaviors plus theming via SnackBarThemeData.
  print('=== Section 9: Recipes ===');

  final recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Icon(
              Icons.restaurant_menu,
              color: Colors.cyanAccent.shade100,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Recipes: ScaffoldMessenger.showSnackBar',
              style: TextStyle(
                color: Colors.cyanAccent.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecipeBlock(
          title: 'Recipe A - classic fixed snackbar',
          color: Colors.indigo.shade200,
          code:
              'ScaffoldMessenger.of(context).showSnackBar(\n'
              '  const SnackBar(\n'
              '    behavior: SnackBarBehavior.fixed,\n'
              '    content: Text("Item archived"),\n'
              '    duration: Duration(seconds: 3),\n'
              '  ),\n'
              ');',
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          title: 'Recipe B - floating snackbar with action',
          color: Colors.deepOrange.shade200,
          code:
              'ScaffoldMessenger.of(context).showSnackBar(\n'
              '  SnackBar(\n'
              '    behavior: SnackBarBehavior.floating,\n'
              '    margin: const EdgeInsets.all(16),\n'
              '    shape: RoundedRectangleBorder(\n'
              '      borderRadius: BorderRadius.circular(12),\n'
              '    ),\n'
              '    content: const Text("Saved"),\n'
              '    action: SnackBarAction(\n'
              '      label: "UNDO",\n'
              '      onPressed: () { /* revert */ },\n'
              '    ),\n'
              '  ),\n'
              ');',
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          title: 'Recipe C - app-wide default via theme',
          color: Colors.greenAccent.shade100,
          code:
              'MaterialApp(\n'
              '  theme: ThemeData(\n'
              '    snackBarTheme: const SnackBarThemeData(\n'
              '      behavior: SnackBarBehavior.floating,\n'
              '      elevation: 4.0,\n'
              '    ),\n'
              '  ),\n'
              '  home: const MyHome(),\n'
              ');',
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          title: 'Recipe D - dismiss & queue management',
          color: Colors.amberAccent.shade100,
          code:
              'final messenger = ScaffoldMessenger.of(context);\n'
              'messenger.hideCurrentSnackBar();\n'
              'messenger.clearSnackBars();\n'
              'messenger.showSnackBar(\n'
              '  const SnackBar(\n'
              '    behavior: SnackBarBehavior.floating,\n'
              '    content: Text("Latest message wins"),\n'
              '  ),\n'
              ');',
        ),
      ],
    ),
  );
  print('Recipes built');

  // ============================================================
  // SECTION 9: Pitfalls
  // ============================================================
  // The two most common mistakes:
  //   - using margin/width with .fixed (asserts at runtime),
  //   - forgetting that .floating obscures content & needs viewInsets care.
  print('=== Section 10: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
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
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.red.shade700,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & gotchas',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildPitfallTile(
          icon: Icons.error_outline,
          title: 'margin requires SnackBarBehavior.floating',
          body:
              'Setting `margin:` on a SnackBar while behavior is .fixed '
              'asserts at runtime. Margin is meaningful only when the '
              'snackbar is allowed to float. Same constraint applies to '
              '`width:` and any custom `shape:` with rounded corners that '
              'would visibly need insets.',
          color: Colors.red.shade700,
        ),
        SizedBox(height: 8.0),
        _buildPitfallTile(
          icon: Icons.stacked_bar_chart,
          title: '.fixed sits *under* BottomAppBar / NavigationBar',
          body:
              'If your scaffold has a BottomAppBar (or BottomNavigationBar) '
              'and you use SnackBarBehavior.fixed, the snackbar will be '
              'partially obscured. This is the most common reason users '
              'expect .floating - switch behaviors instead of stacking '
              'manual padding.',
          color: Colors.deepOrange.shade700,
        ),
        SizedBox(height: 8.0),
        _buildPitfallTile(
          icon: Icons.touch_app_outlined,
          title: '.floating + soft keyboard',
          body:
              'A floating snackbar is repositioned above the keyboard via '
              'MediaQuery.viewInsets. If you wrap your scaffold in a '
              'SafeArea or apply manual bottom padding, you can end up '
              'with the snackbar floating much higher than expected.',
          color: Colors.purple.shade700,
        ),
        SizedBox(height: 8.0),
        _buildPitfallTile(
          icon: Icons.visibility_off_outlined,
          title: '.floating obscures gesture areas',
          body:
              'A floating snackbar overlays the body. Drag handles, '
              'swipe-to-refresh indicators and bottom sheets near the '
              'lower edge can be visually hidden. Prefer .fixed for '
              'fast-fire confirmations on data-dense screens.',
          color: Colors.indigo.shade700,
        ),
      ],
    ),
  );
  print('Pitfalls built');

  // ============================================================
  // SECTION 10: ASCII footer
  // ============================================================
  // A monospace summary card. Useful for both reading and as a smoke-
  // test that monospace text renders with proper line breaks.
  print('=== Section 11: ASCII footer ===');

  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Text(
      '+----------------------------------------------------+\n'
      '|         SnackBarBehavior - quick reference         |\n'
      '+----------------------------------------------------+\n'
      '|                                                    |\n'
      '|  fixed                                             |\n'
      '|  +--------------------------------------------+    |\n'
      '|  | snackbar (full width, no margin)           |    |\n'
      '|  +--------------------------------------------+    |\n'
      '|  | BottomAppBar                               |    |\n'
      '|  +--------------------------------------------+    |\n'
      '|                                                    |\n'
      '|  floating                                          |\n'
      '|     +--------------------------------------+       |\n'
      '|     | snackbar (margin, rounded, shadow)   |       |\n'
      '|     +--------------------------------------+       |\n'
      '|  +--------------------------------------------+    |\n'
      '|  | BottomAppBar                               |    |\n'
      '|  +--------------------------------------------+    |\n'
      '|                                                    |\n'
      '+----------------------------------------------------+\n'
      '   tom_d4rt_flutter_ast - SnackBarBehavior demo       \n',
      style: TextStyle(
        color: Colors.greenAccent.shade100,
        fontFamily: 'monospace',
        fontSize: 11.5,
        height: 1.25,
      ),
    ),
  );
  print('ASCII footer built');

  print('SnackBarBehavior Deep Demo completed successfully');

  // ============================================================
  // Final assembly inside a single MaterialApp(home: Scaffold(body: ...))
  // ============================================================
  // A single MaterialApp/Scaffold call as required by the host.
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroHeader,
              SizedBox(height: 22.0),
              _sectionTitle('1. Enum anatomy'),
              enumSignature,
              SizedBox(height: 22.0),
              _sectionTitle('2. SnackBarBehavior.fixed - mock app frame'),
              fixedMockFrame,
              SizedBox(height: 22.0),
              _sectionTitle('3. SnackBarBehavior.floating - mock app frame'),
              floatingMockFrame,
              SizedBox(height: 22.0),
              _sectionTitle('4. Layout diagram - FAB / BottomAppBar / SnackBar'),
              layoutDiagram,
              SizedBox(height: 22.0),
              _sectionTitle('5. Comparison matrix'),
              comparisonMatrix,
              SizedBox(height: 22.0),
              _sectionTitle('6. Action-button overlay gallery'),
              actionGallery,
              SizedBox(height: 22.0),
              _sectionTitle('7. Recipes'),
              recipes,
              SizedBox(height: 22.0),
              _sectionTitle('8. Pitfalls'),
              pitfalls,
              SizedBox(height: 22.0),
              _sectionTitle('9. ASCII summary'),
              asciiFooter,
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

// Section title, used between every block. Keeps spacing/typography
// consistent without per-section duplication.
Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0, top: 4.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade700, Colors.deepPurple.shade400],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

// Build a mock phone frame. We do NOT return a real Scaffold here - we
// emulate one via Container layout so this widget can sit inside the
// already-Scaffold-rooted build() return tree without nesting Scaffolds.
Widget _buildMockPhoneFrame({
  required String title,
  required Color accent,
  required String description,
  required Widget Function(Color accent) snackBarBuilder,
  required bool showBehindFab,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accent.withValues(alpha: 0.05), accent.withValues(alpha: 0.18)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
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
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.45),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.phone_android,
                color: Colors.white,
                size: 18.0,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: accent.computeLuminance() < 0.5
                      ? accent
                      : Colors.grey.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade800,
            height: 1.45,
          ),
        ),
        SizedBox(height: 14.0),
        // The phone frame itself
        Container(
          height: 280.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey.shade400, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 8.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Stack(
              children: [
                // App bar mock
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  height: 44.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accent, accent.withValues(alpha: 0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(Icons.menu, color: Colors.white, size: 18.0),
                        SizedBox(width: 10.0),
                        Text(
                          'Mock app',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Body content (just stripes)
                // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #55, P2):
                // The fixed 280-dp phone frame leaves ~156 dp for the body
                // (after 44-dp appbar, 56-dp bottombar, 24-dp padding) but the
                // 4 stripe iterations need 208 dp -> 52-px overflow rounded as
                // 56 px. Wrap the Column in SingleChildScrollView so the
                // overflow becomes scroll content. Two phone frames are built,
                // hence the original 2 errors.
                Positioned(
                  top: 44.0,
                  left: 0.0,
                  right: 0.0,
                  bottom: 56.0,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (var i = 0; i < 4; i++) ...[
                            Container(
                              height: 14.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              height: 14.0,
                              width: 180.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                // BottomAppBar mock
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  height: 56.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1.0,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4.0,
                          offset: Offset(0.0, -2.0),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: Colors.grey.shade700,
                          size: 22.0,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey.shade700,
                          size: 22.0,
                        ),
                        SizedBox(width: 56.0), // FAB notch
                        Icon(
                          Icons.notifications_outlined,
                          color: Colors.grey.shade700,
                          size: 22.0,
                        ),
                        Icon(
                          Icons.person_outline,
                          color: Colors.grey.shade700,
                          size: 22.0,
                        ),
                      ],
                    ),
                  ),
                ),
                // SnackBar (behavior-dependent placement)
                snackBarBuilder(accent),
                // FAB
                Positioned(
                  bottom: 32.0,
                  right: 24.0,
                  child: Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [accent, accent.withValues(alpha: 0.75)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.45),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 4.0),
                        ),
                      ],
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 22.0),
                  ),
                ),
                // Annotation: "FAB in front" vs "snackbar in front"
                Positioned(
                  top: 52.0,
                  right: 8.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      showBehindFab
                          ? 'snackbar BEHIND FAB'
                          : 'snackbar IN FRONT',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Build a fixed-style snackbar overlay inside the mock phone frame.
// Sits at the very bottom, full width, behind the BottomAppBar.
Widget _buildFixedSnackBarPreview(Color accent) {
  return Positioned(
    left: 0.0,
    right: 0.0,
    bottom: 56.0, // sit ON the bottom app bar's top edge -> overlaps slightly
    child: Container(
      height: 44.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 4.0,
            offset: Offset(0.0, -2.0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.white, size: 16.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Item archived',
              style: TextStyle(color: Colors.white, fontSize: 12.5),
            ),
          ),
          Text(
            'UNDO',
            style: TextStyle(
              color: accent.withValues(alpha: 1.0),
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    ),
  );
}

// Build a floating-style snackbar overlay. Lifted, with margin, rounded.
Widget _buildFloatingSnackBarPreview(Color accent) {
  return Positioned(
    left: 16.0,
    right: 16.0,
    bottom: 86.0, // clearly above BottomAppBar (56) + margin
    child: Container(
      height: 44.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade900, Colors.grey.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 8.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.greenAccent,
            size: 16.0,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Saved successfully',
              style: TextStyle(color: Colors.white, fontSize: 12.5),
            ),
          ),
          Text(
            'VIEW',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    ),
  );
}

// Build a Z-stack block for the layout diagram. Each "layer" is a
// horizontal strip with a label and a layer-number badge.
Widget _buildZStackBlock({
  required String label,
  required Color color,
  required List<List<Object>> layers,
}) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SnackBarBehavior.$label',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        for (final layer in layers) ...[
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: layer[2] as Color,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 18.0,
                  height: 18.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    layer[0] as String,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    layer[1] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black.withValues(alpha: 0.78),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.0),
        ],
      ],
    ),
  );
}

// Comparison matrix data. Three-column rows: property / fixed / floating.
List<List<String>> _comparisonRows() {
  return [
    ['Width', 'full width', 'with margin'],
    ['Margin', 'not allowed', 'EdgeInsets allowed'],
    ['Shape', 'rectangular', 'RoundedRectangle ok'],
    ['Z-order vs FAB', 'behind', 'in front'],
    ['Z-order vs BottomBar', 'behind / under', 'above'],
    ['Material 3 default', 'no', 'yes'],
    ['Action button', 'inline right', 'inline right'],
    ['Keyboard handling', 'pinned to body', 'lifted via insets'],
  ];
}

// Matrix cell helper.
Widget _buildMatrixCell(
  String text,
  double width, {
  bool bold = false,
  Color? color,
}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: bold ? FontWeight.bold : FontWeight.w500,
        color: color ?? Colors.grey.shade800,
        fontFamily: bold ? null : 'monospace',
      ),
    ),
  );
}

// Build a single visual snackbar sample for the action gallery. The
// `progress` parameter feeds an AlwaysStoppedAnimation<double> that drives
// a static decorative progress strip on the left edge - exercising the
// AlwaysStoppedAnimation + Duration.zero requirement of the demo without
// introducing real motion.
Widget _buildSnackbarSample({
  required SnackBarBehavior behavior,
  required Color accent,
  required String message,
  required String actionLabel,
  required double progress,
}) {
  final isFloating = behavior == SnackBarBehavior.floating;
  final progressAnim = AlwaysStoppedAnimation<double>(progress);
  // Use Duration.zero for any "transition" surface in this widget so the
  // demo is fully static and renderable without a Ticker.
  final entry = Duration.zero;
  print(
    'sample[${behavior.name}] '
    'progress=${progressAnim.value} '
    'entry=${entry.inMilliseconds}ms',
  );

  return Container(
    padding: EdgeInsets.symmetric(horizontal: isFloating ? 16.0 : 0.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade900, Colors.grey.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(isFloating ? 12.0 : 4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isFloating ? 0.35 : 0.18),
            blurRadius: isFloating ? 8.0 : 3.0,
            offset: Offset(0.0, isFloating ? 4.0 : 2.0),
          ),
        ],
      ),
      child: Row(
        children: [
          // Decorative progress strip driven by AlwaysStoppedAnimation.
          Container(
            width: 4.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: progressAnim.value.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              behavior.name,
              style: TextStyle(
                color: accent.withValues(alpha: 1.0),
                fontFamily: 'monospace',
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 12.5),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: accent.withValues(alpha: 0.5),
                width: 1.0,
              ),
            ),
            child: Text(
              actionLabel,
              style: TextStyle(
                color: accent,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Recipe block - title strip + monospace code body.
Widget _buildRecipeBlock({
  required String title,
  required Color color,
  required String code,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color.withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.white.withValues(alpha: 0.92),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// Pitfall tile - icon + bold title + body.
// D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #55, P5(a)): Flutter forbids
// borderRadius on a Border whose sides have non-uniform colors. The original
// design used an asymmetric Border(left: color, top/right/bottom: grey) with a
// rounded rectangle. We now build the rounded shape with ClipRRect + uniform
// Border.all(grey) and recreate the colored left accent as a 4-dp Container
// inside an IntrinsicHeight Row(stretch).
Widget _buildPitfallTile({
  required IconData icon,
  required String title,
  required String body,
  required Color color,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200, width: 1.0),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4.0, color: color),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: color, size: 22.0),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              body,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey.shade800,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
