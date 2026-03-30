// D4rt test script: Tests ConstrainedLayoutBuilder from widgets/layout_builder.dart
// Deep Demo: Visual exploration of ConstrainedLayoutBuilder — the generic
// constraint-aware builder that powers responsive Flutter layouts.
//
// ConstrainedLayoutBuilder<T extends Constraints> is the BASE class behind
// LayoutBuilder. While LayoutBuilder specializes on BoxConstraints,
// ConstrainedLayoutBuilder works with ANY Constraints subtype (box, sliver,
// or custom). Its builder callback fires whenever the parent's constraints
// change, enabling truly constraint-reactive UIs.
//
// Scene 1 — Constraint Anatomy: What constraints look like (tight, loose, bounded, unbounded)
// Scene 2 — Responsive Breakpoint Layouts: switching column count by available width
// Scene 3 — Constraint-Adaptive Child Sizing: children adapt to available space
// Scene 4 — Nested Constraint Propagation: how constraints narrow through ancestors
// Scene 5 — LayoutBuilder in Practice: common responsive patterns (grid, nav, form)
// Scene 6 — Constraint Comparison Gallery: side-by-side constraint scenarios
import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ConstrainedLayoutBuilder Deep Demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────────────────
  // Color palette — indigo / amber / soft grey analytics theme
  // ──────────────────────────────────────────────────────────
  const cIndigo = Color(0xFF283593);       // deep indigo
  const cAmber = Color(0xFFF9A825);        // warm amber
  const cSurface = Color(0xFFF5F5F5);      // light grey surface
  const cTeal = Color(0xFF00695C);         // dark teal accent
  const cRose = Color(0xFFC62828);         // deep rose
  const cSlate = Color(0xFF37474F);        // blue-grey text
  const cMint = Color(0xFF2E7D32);         // green accent
  const cPurple = Color(0xFF6A1B9A);       // purple accent

  // ──────────────────────────────────────────────────────────
  // Shared helper builders
  // ──────────────────────────────────────────────────────────

  Widget sceneTitle(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 32.0, bottom: 14.0),
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.14), color.withValues(alpha: 0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 26.0, color: color),
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: color)),
                SizedBox(height: 2.0),
                Text(subtitle, style: TextStyle(fontSize: 10.5, color: color.withValues(alpha: 0.6))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget notePanel(String text, {Color color = const Color(0xFF37474F)}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: color.withValues(alpha: 0.4), width: 3.0)),
      ),
      child: Text(text, style: TextStyle(fontSize: 12.0, height: 1.5, color: color.withValues(alpha: 0.85))),
    );
  }

  /// A visual gauge showing a constraint dimension range.
  Widget constraintGauge(String label, double minVal, double maxVal, Color color) {
    final isUnbounded = maxVal == double.infinity;
    final displayMax = isUnbounded ? 999.0 : maxVal;
    final fraction = minVal / (displayMax == 0.0 ? 1.0 : displayMax);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 70.0,
            child: Text(label, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: color)),
          ),
          Expanded(
            child: Container(
              height: 18.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: color.withValues(alpha: 0.15)),
              ),
              child: Stack(
                children: [
                  // Min fill
                  FractionallySizedBox(
                    widthFactor: math.min(fraction, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      isUnbounded ? '$minVal → ∞' : '$minVal → $maxVal',
                      style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: color),
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

  /// Small labeled chip.
  Widget labelChip(String text, Color bg, Color fg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(text, style: TextStyle(fontSize: 9.0, color: fg, fontWeight: FontWeight.w600)),
    );
  }

  // ============================================================
  // SCENE 1: Constraint Anatomy
  // ============================================================
  print('\n=== Scene 1: Constraint Anatomy ===');

  // LayoutBuilder (which IS ConstrainedLayoutBuilder<BoxConstraints>) receives
  // the constraints from its parent and passes them to the builder.
  // We illustrate tight, loose, bounded, and unbounded constraint states.

  // Tight constraints: both min and max are equal
  final tightBox = SizedBox(
    width: 200.0,
    height: 80.0,
    child: LayoutBuilder(
      builder: (context, constraints) {
        print('  Tight: ${constraints.minWidth}×${constraints.minHeight} → ${constraints.maxWidth}×${constraints.maxHeight}');
        return Container(
          decoration: BoxDecoration(
            color: cIndigo.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cIndigo.withValues(alpha: 0.2)),
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('TIGHT', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cIndigo, letterSpacing: 1.0)),
              SizedBox(height: 4.0),
              constraintGauge('width', constraints.minWidth, constraints.maxWidth, cIndigo),
              constraintGauge('height', constraints.minHeight, constraints.maxHeight, cIndigo),
            ],
          ),
        );
      },
    ),
  );

  // Loose constraints: min is 0, max is bounded
  final looseBox = ConstrainedBox(
    constraints: BoxConstraints(maxWidth: 250.0, maxHeight: 80.0),
    child: LayoutBuilder(
      builder: (context, constraints) {
        print('  Loose: ${constraints.minWidth}×${constraints.minHeight} → ${constraints.maxWidth}×${constraints.maxHeight}');
        return Container(
          decoration: BoxDecoration(
            color: cAmber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cAmber.withValues(alpha: 0.3)),
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('LOOSE', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cAmber, letterSpacing: 1.0)),
              SizedBox(height: 4.0),
              constraintGauge('width', constraints.minWidth, constraints.maxWidth, cAmber),
              constraintGauge('height', constraints.minHeight, constraints.maxHeight, cAmber),
            ],
          ),
        );
      },
    ),
  );

  // Bounded: min > 0 but min < max
  final boundedBox = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 100.0, maxWidth: 280.0, minHeight: 30.0, maxHeight: 80.0),
    child: LayoutBuilder(
      builder: (context, constraints) {
        print('  Bounded: ${constraints.minWidth}×${constraints.minHeight} → ${constraints.maxWidth}×${constraints.maxHeight}');
        return Container(
          decoration: BoxDecoration(
            color: cTeal.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cTeal.withValues(alpha: 0.2)),
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('BOUNDED', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cTeal, letterSpacing: 1.0)),
              SizedBox(height: 4.0),
              constraintGauge('width', constraints.minWidth, constraints.maxWidth, cTeal),
              constraintGauge('height', constraints.minHeight, constraints.maxHeight, cTeal),
            ],
          ),
        );
      },
    ),
  );

  print('  Three constraint types demonstrated: tight, loose, bounded');

  final scene1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneTitle(
        'Scene 1 — Constraint Anatomy',
        'What BoxConstraints look like: tight, loose, bounded',
        Icons.straighten,
        cIndigo,
      ),
      notePanel(
        'ConstrainedLayoutBuilder<BoxConstraints> — which LayoutBuilder specializes — '
        'receives the constraints from its parent and passes them to the builder callback. '
        'The four values (minWidth, maxWidth, minHeight, maxHeight) determine what sizes '
        'the child can be.\n\n'
        'TIGHT: min == max (exact size forced)\n'
        'LOOSE: min == 0, max > 0 (size up to max, but can be smaller)\n'
        'BOUNDED: 0 < min < max (must be at least min, at most max)',
        color: cIndigo,
      ),

      // Constraint cards
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cIndigo.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Constraint Types', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 12.0),
            tightBox,
            SizedBox(height: 10.0),
            looseBox,
            SizedBox(height: 10.0),
            boundedBox,
          ],
        ),
      ),

      SizedBox(height: 12.0),

      // Explanation of the builder signature
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: cIndigo.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cIndigo.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Generic Signature', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cIndigo)),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'ConstrainedLayoutBuilder<T extends Constraints>(\n'
                '  builder: (BuildContext context, T constraints) {\n'
                '    // constraints = parent\'s constraints\n'
                '    return Widget; // your constraint-aware child\n'
                '  },\n'
                ')',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.greenAccent, height: 1.5),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'LayoutBuilder is just ConstrainedLayoutBuilder<BoxConstraints>. '
              'SliverLayoutBuilder is ConstrainedLayoutBuilder<SliverConstraints>. '
              'The generic parameter controls what constraint type the builder receives.',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, height: 1.3),
            ),
          ],
        ),
      ),

      SizedBox(height: 12.0),

      // Visual comparison: isTight, isNormalized, hasBoundedWidth, etc.
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BoxConstraints Properties Cheat Sheet', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 10.0),
            _propertyRow('isTight', 'min == max on both axes', cIndigo),
            _propertyRow('isNormalized', 'min ≤ max (always true after normalize())', cTeal),
            _propertyRow('hasBoundedWidth', 'maxWidth < ∞', cAmber),
            _propertyRow('hasBoundedHeight', 'maxHeight < ∞', cAmber),
            _propertyRow('hasInfiniteWidth', 'maxWidth == ∞', cRose),
            _propertyRow('hasInfiniteHeight', 'maxHeight == ∞', cRose),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 2: Responsive Breakpoint Layouts
  // ============================================================
  print('\n=== Scene 2: Responsive Breakpoint Layouts ===');

  // Show LayoutBuilder switching between 1, 2, and 3-column layouts
  // based on available width. We simulate different widths using SizedBox.

  Widget responsiveGrid(double availableWidth) {
    return SizedBox(
      width: availableWidth,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final cols = w < 200 ? 1 : (w < 350 ? 2 : 3);
          final breakLabel = w < 200 ? 'NARROW' : (w < 350 ? 'MEDIUM' : 'WIDE');
          final breakColor = w < 200 ? cRose : (w < 350 ? cAmber : cMint);
          print('  Responsive grid: width=$w, cols=$cols ($breakLabel)');

          final items = List.generate(6, (i) {
            return Container(
              margin: EdgeInsets.all(4.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: breakColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: breakColor.withValues(alpha: 0.2)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.widgets, size: 18.0, color: breakColor),
                  SizedBox(height: 2.0),
                  Text('Item ${i + 1}', style: TextStyle(fontSize: 9.0, color: breakColor)),
                ],
              ),
            );
          });

          return Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: breakColor.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    labelChip(breakLabel, breakColor.withValues(alpha: 0.12), breakColor),
                    SizedBox(width: 6.0),
                    Text('${w.toInt()}px → $cols col${cols > 1 ? 's' : ''}',
                        style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
                  ],
                ),
                SizedBox(height: 8.0),
                Wrap(
                  children: items.map((item) {
                    return SizedBox(width: (w - 20) / cols - 8, child: item);
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final scene2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneTitle(
        'Scene 2 — Responsive Breakpoint Layouts',
        'LayoutBuilder switching column count by available width',
        Icons.view_column,
        cAmber,
      ),
      notePanel(
        'The most common use of LayoutBuilder: responsive breakpoints. The builder '
        'reads constraints.maxWidth and decides how many columns to show.\n\n'
        'NARROW (< 200px): 1 column — mobile-phone compact\n'
        'MEDIUM (200-350px): 2 columns — tablet or split view\n'
        'WIDE (≥ 350px): 3 columns — desktop or full width\n\n'
        'Unlike MediaQuery, LayoutBuilder reacts to PARENT constraints, not screen size. '
        'This means a widget in a narrow drawer gets narrow constraints even on a wide screen.',
        color: cAmber,
      ),

      // Three width cards side by side
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cAmber.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Same widget, three parent widths', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 12.0),
            // Narrow
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30.0,
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text('150', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cRose)),
                ),
                Expanded(child: responsiveGrid(150.0)),
              ],
            ),
            SizedBox(height: 14.0),
            // Medium
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30.0,
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text('280', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cAmber)),
                ),
                Expanded(child: responsiveGrid(280.0)),
              ],
            ),
            SizedBox(height: 14.0),
            // Wide
            responsiveGrid(380.0),
          ],
        ),
      ),

      SizedBox(height: 12.0),

      // Breakpoint visual scale
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cAmber.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Breakpoint Scale', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 10.0),
            Container(
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 200,
                      child: Container(
                        color: cRose.withValues(alpha: 0.15),
                        child: Center(child: Text('1 col', style: TextStyle(fontSize: 8.0, color: cRose, fontWeight: FontWeight.bold))),
                      ),
                    ),
                    Container(width: 1.0, color: Colors.grey.shade300),
                    Expanded(
                      flex: 150,
                      child: Container(
                        color: cAmber.withValues(alpha: 0.15),
                        child: Center(child: Text('2 col', style: TextStyle(fontSize: 8.0, color: cAmber, fontWeight: FontWeight.bold))),
                      ),
                    ),
                    Container(width: 1.0, color: Colors.grey.shade300),
                    Expanded(
                      flex: 250,
                      child: Container(
                        color: cMint.withValues(alpha: 0.15),
                        child: Center(child: Text('3 col', style: TextStyle(fontSize: 8.0, color: cMint, fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                Text('0', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500)),
                Expanded(flex: 200, child: SizedBox()),
                Text('200', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500)),
                Expanded(flex: 150, child: SizedBox()),
                Text('350', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500)),
                Expanded(flex: 250, child: SizedBox()),
                Text('600+', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500)),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 3: Constraint-Adaptive Child Sizing
  // ============================================================
  print('\n=== Scene 3: Constraint-Adaptive Child Sizing ===');

  // Children that morph their visual representation based on available space.

  Widget adaptiveProfile(double width) {
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final isCompact = w < 160.0;
          print('  Adaptive profile: width=$w, compact=$isCompact');

          if (isCompact) {
            // Compact: small avatar + name only
            return Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cPurple.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: cPurple.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cPurple.withValues(alpha: 0.15),
                    ),
                    child: Center(child: Text('JD', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cPurple))),
                  ),
                  SizedBox(width: 8.0),
                  Text('J. Doe', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: cPurple)),
                ],
              ),
            );
          }

          // Full: large avatar + name + subtitle + stats
          return Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: cPurple.withValues(alpha: 0.2)),
              boxShadow: [BoxShadow(color: cPurple.withValues(alpha: 0.05), blurRadius: 6.0)],
            ),
            child: Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cPurple.withValues(alpha: 0.12),
                    border: Border.all(color: cPurple.withValues(alpha: 0.3), width: 2.0),
                  ),
                  child: Center(
                    child: Text('JD', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: cPurple)),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Jane Doe', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cSlate)),
                      Text('Senior Engineer', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
                      SizedBox(height: 6.0),
                      Row(
                        children: [
                          _miniStat('42', 'Projects', cPurple),
                          SizedBox(width: 10.0),
                          _miniStat('128', 'Commits', cMint),
                          SizedBox(width: 10.0),
                          _miniStat('4.8', 'Rating', cAmber),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget adaptiveCard(double width) {
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final isNarrow = w < 180.0;
          print('  Adaptive card: width=$w, narrow=$isNarrow');

          if (isNarrow) {
            return Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cTeal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.article, size: 18.0, color: cTeal),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text('Flutter Layout', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: cTeal)),
                  ),
                ],
              ),
            );
          }

          return Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: cTeal.withValues(alpha: 0.2)),
              boxShadow: [BoxShadow(color: cTeal.withValues(alpha: 0.05), blurRadius: 6.0)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.article, size: 24.0, color: cTeal),
                    SizedBox(width: 8.0),
                    Text('Flutter Layout System', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cSlate)),
                  ],
                ),
                SizedBox(height: 6.0),
                Text('Understanding how constraints flow from parent to child and how sizes flow back up.',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, height: 1.3)),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    labelChip('Flutter', cTeal.withValues(alpha: 0.1), cTeal),
                    SizedBox(width: 6.0),
                    labelChip('Layout', cAmber.withValues(alpha: 0.1), cAmber),
                    Spacer(),
                    Text('5 min read', style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final scene3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneTitle(
        'Scene 3 — Constraint-Adaptive Sizing',
        'Children that morph based on available space',
        Icons.auto_awesome,
        cPurple,
      ),
      notePanel(
        'Beyond column switching, LayoutBuilder enables individual widgets to adapt '
        'their OWN appearance. A profile card might show a full layout when wide, '
        'but collapse to just an avatar + name when narrow. An article card might '
        'show description and tags when there is room, but reduce to an icon + title.\n\n'
        'This is component-level responsiveness — each widget independently decides '
        'what to render based on its own constraints, not the screen size.',
        color: cPurple,
      ),

      // Profile component at different widths
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cPurple.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adaptive Profile Card', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cPurple)),
            SizedBox(height: 4.0),
            Text('Same widget at 120px, 200px, and 320px widths',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
            SizedBox(height: 12.0),
            _widthLabel(120.0, cRose),
            adaptiveProfile(120.0),
            SizedBox(height: 10.0),
            _widthLabel(200.0, cAmber),
            adaptiveProfile(200.0),
            SizedBox(height: 10.0),
            _widthLabel(320.0, cMint),
            adaptiveProfile(320.0),
          ],
        ),
      ),

      SizedBox(height: 12.0),

      // Article card at different widths
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cTeal.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adaptive Article Card', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cTeal)),
            SizedBox(height: 4.0),
            Text('Same widget at 130px and 300px',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
            SizedBox(height: 12.0),
            _widthLabel(130.0, cRose),
            adaptiveCard(130.0),
            SizedBox(height: 10.0),
            _widthLabel(300.0, cMint),
            adaptiveCard(300.0),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 4: Nested Constraint Propagation
  // ============================================================
  print('\n=== Scene 4: Nested Constraint Propagation ===');

  // Show how constraints narrow through ancestors:
  // Scaffold → Padding → SizedBox → Card → LayoutBuilder

  Widget constraintWaterfall(String ancestor, double maxW, Widget inner, Color color) {
    return Container(
      width: maxW,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.15), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.arrow_downward, size: 12.0, color: color),
              SizedBox(width: 4.0),
              Text(ancestor, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color)),
              Spacer(),
              Text('max: ${maxW.toInt()}px', style: TextStyle(fontSize: 8.0, color: color.withValues(alpha: 0.6))),
            ],
          ),
          SizedBox(height: 4.0),
          inner,
        ],
      ),
    );
  }

  final waterfallDemo = constraintWaterfall(
    'Scaffold (full width)',
    380.0,
    constraintWaterfall(
      'Padding(16.0)',
      348.0,
      constraintWaterfall(
        'SizedBox(width: 300)',
        300.0,
        constraintWaterfall(
          'Card(margin: 12)',
          276.0,
          LayoutBuilder(
            builder: (context, constraints) {
              print('  Waterfall final constraints: ${constraints.maxWidth}');
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: cIndigo.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: cIndigo, width: 1.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.visibility, size: 20.0, color: cIndigo),
                    SizedBox(height: 4.0),
                    Text('LayoutBuilder sees:', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cIndigo)),
                    Text('maxWidth = ${constraints.maxWidth.toInt()}px',
                        style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: cIndigo)),
                  ],
                ),
              );
            },
          ),
          cSlate,
        ),
        cAmber,
      ),
      cTeal,
    ),
    cRose,
  );

  // Show FractionallySizedBox effect
  final fractionDemo = SizedBox(
    width: 320.0,
    child: FractionallySizedBox(
      widthFactor: 0.6,
      child: LayoutBuilder(
        builder: (context, constraints) {
          print('  FractionallySizedBox(0.6): maxWidth=${constraints.maxWidth}');
          return Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: cMint.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: cMint.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('FractionallySizedBox(widthFactor: 0.6)',
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cMint)),
                Text('Parent: 320px → Builder sees: ${constraints.maxWidth.toInt()}px',
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: cMint)),
              ],
            ),
          );
        },
      ),
    ),
  );

  // Show Flexible in Row
  final flexibleDemo = SizedBox(
    width: 320.0,
    child: Row(
      children: [
        Container(
          width: 80.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: cRose.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: cRose.withValues(alpha: 0.2)),
          ),
          child: Center(child: Text('Fixed\n80px', style: TextStyle(fontSize: 8.0, color: cRose), textAlign: TextAlign.center)),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              print('  Expanded in Row(320): maxWidth=${constraints.maxWidth}');
              return Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: cPurple.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: cPurple.withValues(alpha: 0.2)),
                ),
                child: Center(
                  child: Text(
                    'Expanded → ${constraints.maxWidth.toInt()}px',
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cPurple),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  final scene4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneTitle(
        'Scene 4 — Nested Constraint Propagation',
        'How constraints narrow through ancestor widgets',
        Icons.layers,
        cTeal,
      ),
      notePanel(
        'Constraints flow DOWN the tree: parent → child → grandchild. Each ancestor '
        'may tighten or narrow the constraints (but never widen them beyond its own). '
        'LayoutBuilder reveals the FINAL constraints after all ancestors have applied '
        'their effects.\n\n'
        'Common narrowing ancestors: Padding, SizedBox, ConstrainedBox, FractionallySizedBox, '
        'Expanded (in Flex), and any widget with a fixed size.',
        color: cTeal,
      ),

      // Waterfall
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cTeal.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Constraint Waterfall', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 4.0),
            Text('Watch constraints narrow through 4 ancestor levels',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
            SizedBox(height: 12.0),
            waterfallDemo,
          ],
        ),
      ),

      SizedBox(height: 12.0),

      // FractionallySizedBox + Flexible
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Special Narrowing Widgets', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 12.0),
            Text('FractionallySizedBox:', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cMint)),
            SizedBox(height: 6.0),
            fractionDemo,
            SizedBox(height: 14.0),
            Text('Expanded in Row:', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cPurple)),
            SizedBox(height: 6.0),
            flexibleDemo,
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 5: LayoutBuilder in Practice
  // ============================================================
  print('\n=== Scene 5: LayoutBuilder in Practice ===');

  // Pattern 1: Responsive navigation (rail vs bottom nav)
  Widget navPattern(double width) {
    return SizedBox(
      width: width,
      height: 100.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final useRail = w >= 250.0;
          print('  Nav pattern: width=$w, rail=$useRail');

          if (useRail) {
            return Row(
              children: [
                Container(
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: cIndigo.withValues(alpha: 0.06),
                    border: Border(right: BorderSide(color: cIndigo.withValues(alpha: 0.15))),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.home, size: 20.0, color: cIndigo),
                      Icon(Icons.search, size: 20.0, color: cIndigo.withValues(alpha: 0.4)),
                      Icon(Icons.settings, size: 20.0, color: cIndigo.withValues(alpha: 0.4)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey.withValues(alpha: 0.03),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('NavigationRail', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cIndigo)),
                          Text('Wide layout', style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey.withValues(alpha: 0.03),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('BottomNav', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cAmber)),
                        Text('Narrow layout', style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 36.0,
                decoration: BoxDecoration(
                  color: cAmber.withValues(alpha: 0.06),
                  border: Border(top: BorderSide(color: cAmber.withValues(alpha: 0.2))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.home, size: 18.0, color: cAmber),
                    Icon(Icons.search, size: 18.0, color: cAmber.withValues(alpha: 0.4)),
                    Icon(Icons.settings, size: 18.0, color: cAmber.withValues(alpha: 0.4)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Pattern 2: Responsive form layout
  Widget formPattern(double width) {
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final horizontal = w >= 280.0;
          print('  Form pattern: width=$w, horizontal=$horizontal');

          Widget field(String label, String hint, IconData icon) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 3.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 14.0, color: cSlate.withValues(alpha: 0.5)),
                  SizedBox(width: 6.0),
                  Text(hint, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade400)),
                ],
              ),
            );
          }

          final firstName = field('First', 'First name', Icons.person);
          final lastName = field('Last', 'Last name', Icons.person_outline);

          if (horizontal) {
            return Row(
              children: [
                Expanded(child: firstName),
                SizedBox(width: 8.0),
                Expanded(child: lastName),
              ],
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [firstName, lastName],
          );
        },
      ),
    );
  }

  // Pattern 3: Responsive padding
  Widget paddingPattern(double width) {
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final pad = w < 200 ? 8.0 : (w < 300 ? 16.0 : 32.0);
          print('  Responsive padding: width=$w, padding=$pad');

          return Container(
            padding: EdgeInsets.all(pad),
            decoration: BoxDecoration(
              color: cMint.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: cMint.withValues(alpha: 0.2)),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cMint.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text('Padding: ${pad.toInt()}px', style: TextStyle(fontSize: 10.0, color: cMint, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }

  Widget practiceCard(String name, String desc, List<Widget> demos, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.04), blurRadius: 6.0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 3.0),
          Text(desc, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          SizedBox(height: 10.0),
          ...demos,
        ],
      ),
    );
  }

  final scene5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneTitle(
        'Scene 5 — LayoutBuilder in Practice',
        'Common responsive patterns powered by constraint-aware building',
        Icons.construction,
        cSlate,
      ),
      notePanel(
        'Three production patterns that rely on LayoutBuilder:\n\n'
        '1. Navigation: Switch between side rail and bottom bar\n'
        '2. Form Layout: Stack fields vertically when narrow, horizontally when wide\n'
        '3. Responsive Padding: Increase whitespace as more space becomes available\n\n'
        'Each pattern reads constraints.maxWidth and adjusts its build output — '
        'the same logic that powers Material\'s NavigationRail/NavigationBar switching.',
        color: cSlate,
      ),

      practiceCard(
        'Navigation Rail ↔ Bottom Nav',
        'Switches between side rail (wide) and bottom nav (narrow)',
        [
          _widthLabel(180.0, cAmber),
          navPattern(180.0),
          SizedBox(height: 10.0),
          _widthLabel(320.0, cIndigo),
          navPattern(320.0),
        ],
        cIndigo,
      ),

      practiceCard(
        'Inline ↔ Stacked Form Fields',
        'Fields go side-by-side when wide, stacked when narrow',
        [
          _widthLabel(180.0, cRose),
          formPattern(180.0),
          SizedBox(height: 10.0),
          _widthLabel(320.0, cMint),
          formPattern(320.0),
        ],
        cTeal,
      ),

      practiceCard(
        'Responsive Padding',
        'Padding scales with available width: 8px → 16px → 32px',
        [
          _widthLabel(150.0, cRose),
          paddingPattern(150.0),
          SizedBox(height: 8.0),
          _widthLabel(260.0, cAmber),
          paddingPattern(260.0),
          SizedBox(height: 8.0),
          _widthLabel(380.0, cMint),
          paddingPattern(380.0),
        ],
        cMint,
      ),
    ],
  );

  // ============================================================
  // SCENE 6: Constraint Comparison Gallery
  // ============================================================
  print('\n=== Scene 6: Constraint Comparison Gallery ===');

  // Side-by-side: same content under different constraint wrappers
  Widget constraintSlot(String wrapperName, Widget wrapper, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(wrapperName, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color)),
            SizedBox(height: 6.0),
            wrapper,
          ],
        ),
      ),
    );
  }

  Widget constraintProbe(Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTight = constraints.isTight;
        final hasInfiniteW = constraints.hasInfiniteWidth;
        print('  Probe: tight=$isTight, infW=$hasInfiniteW, maxW=${constraints.maxWidth}');

        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _constraintLine('minW', constraints.minWidth.toString(), color),
              _constraintLine('maxW', constraints.hasInfiniteWidth ? '∞' : constraints.maxWidth.toStringAsFixed(0), color),
              _constraintLine('minH', constraints.minHeight.toString(), color),
              _constraintLine('maxH', constraints.hasInfiniteHeight ? '∞' : constraints.maxHeight.toStringAsFixed(0), color),
              SizedBox(height: 4.0),
              Row(
                children: [
                  if (isTight) labelChip('TIGHT', cRose.withValues(alpha: 0.12), cRose),
                  if (hasInfiniteW) labelChip('∞ WIDTH', cAmber.withValues(alpha: 0.12), cAmber),
                  if (constraints.hasBoundedWidth && !isTight) labelChip('BOUNDED', cMint.withValues(alpha: 0.12), cMint),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Row 1: SizedBox tight vs ConstrainedBox loose
  final compareRow1 = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      constraintSlot(
        'SizedBox(100×60)',
        SizedBox(width: 100.0, height: 60.0, child: constraintProbe(cIndigo)),
        cIndigo,
      ),
      constraintSlot(
        'ConstrainedBox(max)',
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 140.0, maxHeight: 80.0),
          child: constraintProbe(cTeal),
        ),
        cTeal,
      ),
    ],
  );

  // Row 2: UnconstrainedBox vs IntrinsicWidth
  final compareRow2 = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      constraintSlot(
        'Expanded (in Row)',
        SizedBox(
          height: 70.0,
          child: Row(
            children: [
              SizedBox(width: 30.0),
              Expanded(child: constraintProbe(cPurple)),
            ],
          ),
        ),
        cPurple,
      ),
      constraintSlot(
        'FractionallySizedBox(0.5)',
        SizedBox(
          width: 160.0,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: constraintProbe(cAmber),
          ),
        ),
        cAmber,
      ),
    ],
  );

  // Row 3: Align (loosens) vs Center (loosens)
  final compareRow3 = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      constraintSlot(
        'Align(topLeft)',
        SizedBox(
          width: 120.0,
          height: 80.0,
          child: Align(
            alignment: Alignment.topLeft,
            child: constraintProbe(cRose),
          ),
        ),
        cRose,
      ),
      constraintSlot(
        'Center (loosens)',
        SizedBox(
          width: 130.0,
          height: 80.0,
          child: Center(
            child: constraintProbe(cMint),
          ),
        ),
        cMint,
      ),
    ],
  );

  final scene6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneTitle(
        'Scene 6 — Constraint Comparison Gallery',
        'Same probe widget under different constraint wrappers',
        Icons.compare,
        cRose,
      ),
      notePanel(
        'A "constraint probe" — a LayoutBuilder that displays the raw constraints '
        'it receives — placed under different parent widgets. This gallery shows '
        'how each wrapper transforms constraints:\n\n'
        '• SizedBox: makes constraints TIGHT (min == max)\n'
        '• ConstrainedBox: adds bounds (narrows range)\n'
        '• Expanded: fills remaining flex space\n'
        '• FractionallySizedBox: proportion of parent size\n'
        '• Align/Center: LOOSENS constraints (min → 0)',
        color: cRose,
      ),

      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tight vs Bounded', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 6.0),
            compareRow1,
            SizedBox(height: 14.0),
            Text('Expanded vs Fractional', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 6.0),
            compareRow2,
            SizedBox(height: 14.0),
            Text('Loosening: Align vs Center', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 6.0),
            compareRow3,
          ],
        ),
      ),

      SizedBox(height: 10.0),

      // Summary table
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cRose.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Constraint Effect Summary', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 10.0),
            _effectRow('SizedBox', 'Tightens both axes', cIndigo),
            _effectRow('ConstrainedBox', 'Adds min/max bounds', cTeal),
            _effectRow('Expanded', 'Fills remaining flex space', cPurple),
            _effectRow('FractionallySizedBox', 'Proportion of parent', cAmber),
            _effectRow('Align / Center', 'Loosens (min → 0)', cMint),
            _effectRow('Padding', 'Narrows by padding size', cRose),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // BUILD SUMMARY
  // ============================================================
  print('\n=== Build Summary ===');
  print('Scene 1: Constraint Anatomy — tight/loose/bounded + property sheet');
  print('Scene 2: Responsive Breakpoints — 1/2/3-column grid');
  print('Scene 3: Adaptive Sizing — profile card + article card morphing');
  print('Scene 4: Nested Propagation — waterfall + FractionallySizedBox + Expanded');
  print('Scene 5: Practical Patterns — nav rail, form layout, responsive padding');
  print('Scene 6: Comparison Gallery — probe widget under 6 wrappers');
  print('ConstrainedLayoutBuilder Deep Demo completed');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: cIndigo,
      scaffoldBackgroundColor: cSurface,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('ConstrainedLayoutBuilder Deep Demo'),
        centerTitle: true,
        backgroundColor: cIndigo,
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cIndigo.withValues(alpha: 0.12), cAmber.withValues(alpha: 0.06)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: cIndigo.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: cIndigo.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.straighten, size: 34.0, color: cIndigo),
                      ),
                      SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ConstrainedLayoutBuilder', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: cIndigo)),
                            Text('The Constraint-Aware Builder', style: TextStyle(fontSize: 12.0, color: cSlate.withValues(alpha: 0.6))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'ConstrainedLayoutBuilder<T extends Constraints> is the generic base class '
                    'behind LayoutBuilder and SliverLayoutBuilder. It receives the parent\'s constraints '
                    'and invokes a builder callback, allowing the child widget to REACT to its available '
                    'space. This is the foundation of responsive Flutter layout — not MediaQuery-based '
                    'screen-size reactions, but true constraint-based component-level adaptation.\n\n'
                    'LayoutBuilder (its BoxConstraints specialization) is one of the most important '
                    'widgets in Flutter\'s responsive design toolkit.',
                    style: TextStyle(fontSize: 12.0, height: 1.5, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 10.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: [
                      Chip(label: Text('layout_builder.dart'), backgroundColor: cIndigo.withValues(alpha: 0.08)),
                      Chip(label: Text('LayoutBuilder'), backgroundColor: cAmber.withValues(alpha: 0.08)),
                      Chip(label: Text('BoxConstraints'), backgroundColor: cTeal.withValues(alpha: 0.08)),
                      Chip(label: Text('Responsive'), backgroundColor: cMint.withValues(alpha: 0.08)),
                    ],
                  ),
                ],
              ),
            ),

            scene1,
            scene2,
            scene3,
            scene4,
            scene5,
            scene6,

            // Footer
            SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: cIndigo.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: cIndigo.withValues(alpha: 0.15)),
              ),
              child: Column(
                children: [
                  Text('End of ConstrainedLayoutBuilder Deep Demo',
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cIndigo)),
                  SizedBox(height: 4.0),
                  Text(
                    '6 scenes · Constraint anatomy · Responsive breakpoints · Adaptive sizing · '
                    'Nested propagation · Practical patterns · Comparison gallery',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Top-level helper widgets
// ──────────────────────────────────────────────────────────

Widget _propertyRow(String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        SizedBox(
          width: 110.0,
          child: Text(name, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: color)),
        ),
        Expanded(
          child: Text(desc, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600)),
        ),
      ],
    ),
  );
}

Widget _miniStat(String value, String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(value, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: color)),
      Text(label, style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500)),
    ],
  );
}

Widget _widthLabel(double width, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Row(
      children: [
        Icon(Icons.width_normal, size: 12.0, color: color),
        SizedBox(width: 4.0),
        Text('${width.toInt()}px', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color)),
      ],
    ),
  );
}

Widget _constraintLine(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      children: [
        SizedBox(
          width: 32.0,
          child: Text(label, style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: color)),
        ),
        Text(value, style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: color.withValues(alpha: 0.8))),
      ],
    ),
  );
}

Widget _effectRow(String widget, String effect, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        SizedBox(
          width: 130.0,
          child: Text(widget, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(effect, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600)),
        ),
      ],
    ),
  );
}
