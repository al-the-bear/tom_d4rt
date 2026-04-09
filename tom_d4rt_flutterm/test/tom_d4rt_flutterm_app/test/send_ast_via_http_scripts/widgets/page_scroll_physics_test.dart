// ignore_for_file: avoid_print
// D4rt deep demo: PageScrollPhysics — snapping scroll physics for PageView
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Forest / Emerald ──────────────────────────────────────
  const deepForest = Color(0xFF1B5E20);
  const forest = Color(0xFF2E7D32);
  const emerald = Color(0xFF388E3C);
  const softEmerald = Color(0xFF66BB6A);
  const lightForest = Color(0xFFC8E6C9);
  const paleForest = Color(0xFFE8F5E9);
  const whiteForest = Color(0xFFF5FBF5);
  const darkBark = Color(0xFF0D3311);
  const accentAmber = Color(0xFFFF8F00);
  const accentSlate = Color(0xFF37474F);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget heading(String title, String sub, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.72)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (sub.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(sub,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget note(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkBark)),
    );
  }

  Widget kvRow(String key, String val, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(key,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(val,
                style: TextStyle(fontSize: 13, color: darkBark)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Create instances ───────────────────────────────────────────────
  const physics = PageScrollPhysics();
  final chained = const PageScrollPhysics()
      .applyTo(const BouncingScrollPhysics());

  // ── Print diagnostics ──────────────────────────────────────────────
  print('PageScrollPhysics deep demo executing');
  print('=' * 60);

  print('\n--- PageScrollPhysics overview ---');
  print('Extends ScrollPhysics');
  print('Defined in widgets/page_view.dart line 564');
  print('Snaps to page boundaries using spring simulation');

  print('\n--- Instance info ---');
  print('physics: $physics');
  print('physics.parent: ${physics.parent}');
  print('allowImplicitScrolling: ${physics.allowImplicitScrolling}');

  print('\n--- Chained with BouncingScrollPhysics ---');
  print('chained: $chained');
  print('chained.parent: ${chained.parent}');

  print('\n--- Snapping algorithm (pseudocode) ---');
  print('1. Get current fractional page from scroll position');
  print('2. If velocity < -tolerance: page -= 0.5 (go backward)');
  print('3. If velocity > +tolerance: page += 0.5 (go forward)');
  print('4. Round to nearest integer page');
  print('5. Convert page index back to pixel offset');
  print('6. Create ScrollSpringSimulation to that target');

  print('\n${'=' * 60}');
  print('PageScrollPhysics deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title ─────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepForest, forest, emerald],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.swipe, size: 28, color: lightForest),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('PageScrollPhysics',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Scroll physics that cause a PageView to snap to '
                  'page boundaries. When the user releases a scroll '
                  'gesture, PageScrollPhysics calculates the nearest '
                  'page and creates a spring simulation to animate '
                  'the viewport to that exact page position.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('ScrollPhysics', forest, Colors.white),
                tag('page snapping', emerald, Colors.white),
                tag('spring simulation', softEmerald, Colors.white),
                tag('PageView', lightForest, darkBark),
              ]),
            ],
          ),
        ),

        // ── 2. Inheritance chain ─────────────────────────────────────
        heading('1 \u00b7 Inheritance Chain',
            'Where PageScrollPhysics sits in the physics hierarchy',
            deepForest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightForest),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 3; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: [deepForest, forest, emerald][i]
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepForest, forest, emerald][i],
                        width: i == 2 ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: [deepForest, forest, emerald][i],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text([
                              'Object',
                              'ScrollPhysics',
                              'PageScrollPhysics',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: [deepForest, forest, emerald][i])),
                            Text([
                              'Dart base class',
                              'Base class: defines ballistics, clamping, tolerance',
                              'Adds page-snapping behavior via spring simulation',
                            ][i],
                                style: TextStyle(
                                    fontSize: 10, color: darkBark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Icon(Icons.arrow_downward,
                        size: 14, color: softEmerald),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. Constructor ───────────────────────────────────────────
        heading('2 \u00b7 Constructor',
            'Minimal constructor with optional parent chaining',
            forest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: forest.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: forest.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'const PageScrollPhysics({\n'
                    '  ScrollPhysics? parent,\n'
                    '})',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: forest)),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: forest.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                      left: BorderSide(color: forest, width: 3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.link, size: 16, color: forest),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('parent',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: forest)),
                          Text('Optional ScrollPhysics? to chain with. '
                              'When set, this physics delegates boundary '
                              'behavior to the parent while keeping its '
                              'own page-snapping logic.',
                              style: TextStyle(
                                  fontSize: 11, color: darkBark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        note(
          'PageScrollPhysics is const-constructible. It can be created '
          'inline: PageView(physics: const PageScrollPhysics()). The '
          'parent parameter enables composition with other physics '
          'like BouncingScrollPhysics or ClampingScrollPhysics.',
          forest,
          paleForest,
        ),
        const SizedBox(height: 14),

        // ── 4. Snap decision algorithm ───────────────────────────────
        heading('3 \u00b7 Snap Decision Algorithm',
            'How PageScrollPhysics decides which page to snap to',
            deepForest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightForest),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 6; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: [deepForest, forest, emerald, softEmerald, accentAmber, accentSlate][i]
                        .withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepForest, forest, emerald, softEmerald, accentAmber, accentSlate][i]),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: [deepForest, forest, emerald, softEmerald, accentAmber, accentSlate][i],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text([
                              'Read current page position',
                              'Check fling velocity against tolerance',
                              'Adjust page by \u00b10.5 based on velocity direction',
                              'Round to nearest integer page',
                              'Convert page index to pixel offset',
                              'Create ScrollSpringSimulation to target',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: [deepForest, forest, emerald, softEmerald, accentAmber, accentSlate][i])),
                            Text([
                              'Uses _getPage() \u2014 reads fractional page from ScrollMetrics',
                              'Tolerance comes from toleranceFor(position) \u2014 device-specific threshold',
                              'velocity < -tolerance \u2192 page -= 0.5  |  velocity > +tolerance \u2192 page += 0.5',
                              'page.roundToDouble() \u2192 nearest whole page (e.g. 2.7 \u2192 3.0)',
                              'Uses _getPixels() \u2014 page * viewportDimension (or via _PagePosition)',
                              'ScrollSpringSimulation animates from current pixels to target pixels',
                            ][i],
                                style: TextStyle(
                                    fontSize: 9, color: darkBark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 5)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Icon(Icons.arrow_downward,
                        size: 12, color: softEmerald),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Velocity snap scenarios ───────────────────────────────
        heading('4 \u00b7 Velocity-Based Snap Scenarios',
            'How different fling velocities affect page selection',
            forest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('Slow drag to page 1.3', 'velocity \u2248 0', '1.3 \u2192 round \u2192 1.0',
                    'Snaps back to page 1', Icons.pan_tool, forest),
                ('Fast fling forward at page 1.3', 'velocity > +tolerance', '1.3 + 0.5 = 1.8 \u2192 round \u2192 2.0',
                    'Snaps forward to page 2', Icons.arrow_forward, emerald),
                ('Fast fling backward at page 1.8', 'velocity < -tolerance', '1.8 - 0.5 = 1.3 \u2192 round \u2192 1.0',
                    'Snaps backward to page 1', Icons.arrow_back, deepForest),
                ('Exactly at page 2.5, no velocity', 'velocity \u2248 0', '2.5 \u2192 round \u2192 3.0',
                    'Rounds up to page 3 (0.5 rounds up)', Icons.swap_horiz, accentAmber),
                ('Past max extent', 'velocity \u2265 0', 'Defers to parent',
                    'Parent physics handles out-of-range bounce', Icons.undo, accentSlate),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: scenario.$6.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: scenario.$6, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(scenario.$5, size: 16, color: scenario.$6),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(scenario.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: scenario.$6)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      kvRow('Velocity', scenario.$2, scenario.$6),
                      kvRow('Calculation', scenario.$3, scenario.$6),
                      kvRow('Result', scenario.$4, scenario.$6),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Spring simulation visual ──────────────────────────────
        heading('5 \u00b7 Spring Simulation',
            'The animation that carries the page to its target',
            emerald, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: emerald.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: emerald.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'ScrollSpringSimulation(\n'
                    '  spring,         // spring description (stiffness, damping)\n'
                    '  position.pixels, // starting pixel offset\n'
                    '  target,          // target pixel offset (snapped page)\n'
                    '  velocity,        // current fling velocity\n'
                    '  tolerance: tolerance,\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: emerald)),
              ),
              const SizedBox(height: 10),
              // Visual spring curve
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: forest.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: forest.withValues(alpha: 0.2)),
                ),
                child: CustomPaint(
                  painter: _SpringCurvePainter(forest, softEmerald),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('t=0 (release)',
                      style: TextStyle(fontSize: 8, color: softEmerald)),
                  Text('Spring settles at target page',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: forest)),
                  Text('t=end',
                      style: TextStyle(fontSize: 8, color: softEmerald)),
                ],
              ),
            ],
          ),
        ),
        note(
          'The spring simulation provides a natural, physically-based '
          'animation. It uses the scroll physics\' spring description '
          '(stiffness, damping, mass) and the tolerance for determining '
          'when the animation is "close enough" to stop.',
          emerald,
          paleForest,
        ),
        const SizedBox(height: 14),

        // ── 7. applyTo method ────────────────────────────────────────
        heading('6 \u00b7 applyTo and Physics Chaining',
            'Composing physics with parent delegates',
            deepForest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepForest.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepForest.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '@override\n'
                    'PageScrollPhysics applyTo(\n'
                    '    ScrollPhysics? ancestor) {\n'
                    '  return PageScrollPhysics(\n'
                    '    parent: buildParent(ancestor),\n'
                    '  );\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepForest)),
              ),
              const SizedBox(height: 10),
              // Chaining visual
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: emerald.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: emerald, width: 2),
                      ),
                      child: Column(
                        children: [
                          Text('PageScrollPhysics',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: emerald)),
                          Text('Page snapping',
                              style: TextStyle(
                                  fontSize: 9, color: darkBark)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Icons.arrow_forward,
                        size: 14, color: softEmerald),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: forest.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: forest),
                      ),
                      child: Column(
                        children: [
                          Text('BouncingScrollPhysics',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: forest)),
                          Text('iOS-style overscroll',
                              style: TextStyle(
                                  fontSize: 9, color: darkBark)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Icons.arrow_forward,
                        size: 14, color: softEmerald),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentSlate.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentSlate),
                      ),
                      child: Column(
                        children: [
                          Text('Platform default',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: accentSlate)),
                          Text('Boundary behavior',
                              style: TextStyle(
                                  fontSize: 9, color: darkBark)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Page snapping handled first \u2192 out-of-range defers to parent \u2192 parent defers to platform',
                  style: TextStyle(
                      fontSize: 9,
                      fontStyle: FontStyle.italic,
                      color: forest)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. allowImplicitScrolling ────────────────────────────────
        heading('7 \u00b7 allowImplicitScrolling',
            'Why PageScrollPhysics returns false',
            forest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accentAmber.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentAmber, width: 2),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.block, size: 22, color: accentAmber),
                          const SizedBox(height: 4),
                          Text('PageScrollPhysics\nfalse',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: accentAmber)),
                          Text('Pages are discrete \u2014 no '
                              'continuous scrolling',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9, color: darkBark)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: emerald.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: emerald),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle, size: 22, color: emerald),
                          const SizedBox(height: 4),
                          Text('ClampingScrollPhysics\ntrue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: emerald)),
                          Text('Content is continuous \u2014 '
                              'implicit scrolling OK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9, color: darkBark)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        note(
          'allowImplicitScrolling controls whether the Scrollable '
          'accepts accessibility scroll requests. PageScrollPhysics '
          'returns false because pages are discrete items \u2014 '
          'accessibility should use page-level navigation instead.',
          forest,
          paleForest,
        ),
        const SizedBox(height: 14),

        // ── 9. Comparison with other physics ─────────────────────────
        heading('8 \u00b7 Physics Comparison Table',
            'How PageScrollPhysics differs from built-in alternatives',
            deepForest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepForest),
                children: [
                  for (final h in ['Feature', 'PageScroll', 'Clamping', 'Bouncing'])
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(h,
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                ],
              ),
              for (final row in [
                ('Snapping', '\u2713 Pages', '\u2717 Free', '\u2717 Free'),
                ('Overscroll', 'Via parent', 'Clamp', 'Bounce'),
                ('Platform', 'Custom', 'Android', 'iOS'),
                ('Implicit scroll', 'false', 'true', 'true'),
                ('Ballistic sim.', 'Spring', 'Clamping', 'Friction'),
                ('Use case', 'PageView', 'ListView', 'ListView'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: darkBark)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 9,
                              color: row.$2.contains('\u2713') ? emerald : accentAmber)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 9, color: accentSlate)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$4,
                          style: TextStyle(
                              fontSize: 9, color: accentSlate)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. PageView integration ─────────────────────────────────
        heading('9 \u00b7 PageView Integration',
            'How PageView uses PageScrollPhysics internally',
            forest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightForest),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 4; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: [deepForest, forest, emerald, softEmerald][i]
                        .withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepForest, forest, emerald, softEmerald][i]),
                  ),
                  child: Row(
                    children: [
                      Icon([
                        Icons.view_carousel,
                        Icons.gamepad,
                        Icons.auto_fix_high,
                        Icons.play_circle,
                      ][i],
                          size: 18,
                          color: [deepForest, forest, emerald, softEmerald][i]),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text([
                              'PageView created with physics parameter',
                              'PageController creates _PagePosition',
                              'PageScrollPhysics applied via applyTo',
                              'createBallisticSimulation snaps on release',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: [deepForest, forest, emerald, softEmerald][i])),
                            Text([
                              'Default: PageScrollPhysics() \u2014 override via PageView(physics: ...)',
                              '_PagePosition knows viewportFraction for fractional pages',
                              'Chained: PageScrollPhysics \u2192 user physics \u2192 platform physics',
                              'Returns Spring simulation to nearest page, or null if already there',
                            ][i],
                                style: TextStyle(
                                    fontSize: 9, color: darkBark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Icon(Icons.arrow_downward,
                        size: 12, color: softEmerald),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Live PageView demo ───────────────────────────────────
        heading('10 \u00b7 Live PageView with PageScrollPhysics',
            'Interactive snapping demonstration',
            emerald, Colors.white),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightForest),
          ),
          child: PageView(
            physics: const PageScrollPhysics(),
            children: [
              for (var p = 0; p < 5; p++)
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        [deepForest, forest, emerald, softEmerald, accentAmber][p],
                        [deepForest, forest, emerald, softEmerald, accentAmber][p]
                            .withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon([
                          Icons.looks_one,
                          Icons.looks_two,
                          Icons.looks_3,
                          Icons.looks_4,
                          Icons.looks_5,
                        ][p],
                            size: 40, color: Colors.white),
                        const SizedBox(height: 6),
                        Text('Page ${p + 1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        Text('Swipe to snap between pages',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 11)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Out-of-range behavior ────────────────────────────────
        heading('11 \u00b7 Out-of-Range Behavior',
            'What happens when scrolled past boundaries',
            deepForest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepForest.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepForest.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'if ((velocity <= 0 && pixels <= minExtent) ||\n'
                    '    (velocity >= 0 && pixels >= maxExtent)) {\n'
                    '  return super.createBallisticSimulation(...);\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepForest)),
              ),
              const SizedBox(height: 8),
              for (final edge in [
                ('At min, scrolling backward', 'Delegate to parent (e.g. bounce/clamp to first page)',
                    Icons.first_page, accentAmber),
                ('At max, scrolling forward', 'Delegate to parent (e.g. bounce/clamp to last page)',
                    Icons.last_page, accentAmber),
                ('Between pages, in range', 'PageScrollPhysics handles snap to nearest page',
                    Icons.center_focus_strong, emerald),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: edge.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: edge.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(edge.$3, size: 16, color: edge.$4),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(edge.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: edge.$4)),
                            Text(edge.$2,
                                style: TextStyle(
                                    fontSize: 10, color: darkBark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Tolerance ────────────────────────────────────────────
        heading('12 \u00b7 Tolerance',
            'The threshold that separates a drag from a fling',
            forest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Visual tolerance threshold
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: paleForest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: forest),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: accentAmber.withValues(alpha: 0.1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back, size: 14, color: accentAmber),
                              Text('page -= 0.5',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: accentAmber)),
                              Text('(fling backward)',
                                  style: TextStyle(
                                      fontSize: 7, color: darkBark)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      color: forest.withValues(alpha: 0.3),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: forest.withValues(alpha: 0.06),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.pan_tool, size: 14, color: forest),
                              Text('no adjust',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: forest)),
                              Text('(slow drag)',
                                  style: TextStyle(
                                      fontSize: 7, color: darkBark)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      color: forest.withValues(alpha: 0.3),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: emerald.withValues(alpha: 0.1),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_forward, size: 14, color: emerald),
                              Text('page += 0.5',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: emerald)),
                              Text('(fling forward)',
                                  style: TextStyle(
                                      fontSize: 7, color: darkBark)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('-velocity',
                      style: TextStyle(fontSize: 8, color: accentAmber)),
                  Text('\u25c4 tolerance zone \u25ba',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: forest)),
                  Text('+velocity',
                      style: TextStyle(fontSize: 8, color: emerald)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Practical patterns ───────────────────────────────────
        heading('13 \u00b7 Practical Usage Patterns',
            'Common ways to use PageScrollPhysics',
            emerald, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pattern in [
                ('Default PageView', 'PageView(\n  children: pages,\n)\n'
                    '// Uses PageScrollPhysics automatically',
                    Icons.view_carousel, forest,
                    'Physics applied by default via PageView'),
                ('Explicit physics', 'PageView(\n  physics: const PageScrollPhysics(),\n  children: pages,\n)',
                    Icons.tune, emerald,
                    'Explicit for clarity or customization'),
                ('Chained with bounce', 'PageView(\n  physics: const PageScrollPhysics(\n'
                    '    parent: BouncingScrollPhysics(),\n  ),\n  children: pages,\n)',
                    Icons.sports_tennis, deepForest,
                    'iOS-style overscroll when past boundaries'),
                ('NeverScrollable combo', 'PageView(\n  physics: const NeverScrollableScrollPhysics(),\n'
                    '  controller: ctrl,\n  children: pages,\n)\n'
                    '// Programmatic paging only',
                    Icons.lock, accentSlate,
                    'Override snapping with non-scrollable physics'),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: pattern.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: pattern.$4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(pattern.$3, size: 16, color: pattern.$4),
                          const SizedBox(width: 6),
                          Text(pattern.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: pattern.$4)),
                          const Spacer(),
                          Text(pattern.$5,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                  color: pattern.$4)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: pattern.$4.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(pattern.$2,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: pattern.$4)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Performance ──────────────────────────────────────────
        heading('14 \u00b7 Performance',
            'Lightweight and efficient by design',
            deepForest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteForest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Const-constructible', 'Single shared instance across rebuilds '
                    '— no allocation per frame.',
                    Icons.memory, forest),
                ('Minimal computation', 'Snap decision is a few multiplications and '
                    'one round — runs in microseconds.',
                    Icons.speed, emerald),
                ('Returns null when settled', 'No simulation created when already at a '
                    'page boundary — avoids unnecessary animation.',
                    Icons.stop_circle, deepForest),
                ('Spring-based', 'ScrollSpringSimulation converges quickly '
                    'with natural deceleration curve.',
                    Icons.show_chart, softEmerald),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: perf.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: perf.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(perf.$3, size: 16, color: perf.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${perf.$1}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: perf.$4)),
                            TextSpan(
                                text: perf.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkBark)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        heading('15 \u00b7 Summary',
            'Key takeaways', deepForest, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepForest, forest],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends ScrollPhysics to add page-snapping behavior to PageView',
                'Snap algorithm: adjust by \u00b10.5 based on fling velocity, then round to nearest page',
                'Uses ScrollSpringSimulation for natural, physically-based settling animation',
                'Delegates out-of-range behavior to parent physics (bounce, clamp)',
                'allowImplicitScrolling returns false — pages are discrete, not continuous',
                'Const-constructible with optional parent for physics composition',
                'applyTo preserves page-snapping while chaining with ancestor physics',
                'Returns null when already exactly at a page boundary (no animation needed)',
                'Tolerance threshold separates slow drags from fast flings for snap direction',
                'Used by PageView by default — override with custom physics to disable snapping',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightForest,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}

// Simple custom painter for spring curve visualization
class _SpringCurvePainter extends CustomPainter {
  final Color lineColor;
  final Color gridColor;

  _SpringCurvePainter(this.lineColor, this.gridColor);

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = gridColor.withValues(alpha: 0.2)
      ..strokeWidth = 0.5;

    // Draw grid lines
    for (var i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw spring curve (overdamped spring settling)
    final curvePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.85);

    for (var x = 0.0; x < size.width; x += 1) {
      final t = x / size.width;
      // Approximate spring curve: fast rise, slight overshoot, settle
      final y = 1.0 - (1.0 - (1.0 + 0.08 * (1 - t)) * (1 - (1 - t) * (1 - t) * (1 - t)));
      path.lineTo(x, size.height * (1.0 - y * 0.7 + 0.15));
    }

    canvas.drawPath(path, curvePaint);

    // Draw target line
    final targetPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.3)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final dashY = size.height * 0.15;
    canvas.drawLine(Offset(0, dashY), Offset(size.width, dashY), targetPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
