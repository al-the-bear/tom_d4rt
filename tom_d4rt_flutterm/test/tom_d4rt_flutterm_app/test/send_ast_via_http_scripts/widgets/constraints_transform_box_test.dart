// ignore_for_file: avoid_print
// D4rt test script: Tests ConstraintsTransformBox from widgets/basic.dart
// Deep Demo: Visual exploration of ConstraintsTransformBox — the widget that
// intercepts, rewrites, and transforms layout constraints flowing from parent
// to child, enabling a child to lay out under DIFFERENT constraints than the
// parent provides.
//
// ConstraintsTransformBox sits between parent and child like a constraint
// translator. The parent hands down its BoxConstraints, the transform
// function rewrites them, and the child receives the modified version.
// After layout, if the child's size differs from what the parent expects,
// alignment and clip behavior resolve the visual result.
//
// This is one of Flutter's most advanced layout primitives — used whenever
// you need to break free from a parent's constraint regime: loosen tight
// parents, swap width/height, apply minimums the parent didn't request,
// scale constraints proportionally, or clamp to specific ranges.
//
// Scene 1 — Transform Anatomy: before/after constraint visualization
// Scene 2 — Predefined Transform Gallery: unconstrained, widthUnconstrained,
//           heightUnconstrained, maxWidth/maxHeight overrides
// Scene 3 — Overflow & Clipping: what happens when child exceeds parent
// Scene 4 — Alignment Under Transform: how alignment interacts with
//           size mismatches from constraint transforms
// Scene 5 — Custom Transform Functions: bespoke constraint rewriting
// Scene 6 — Practical Patterns: real-world usage examples
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ConstraintsTransformBox Deep Demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────────────────
  // Color palette — teal/rose/warm-sand constraint theme
  // ──────────────────────────────────────────────────────────
  const cTeal = Color(0xFF00695C);        // deep teal - primary
  const cRose = Color(0xFFAD1457);        // rich rose - accent
  const cSand = Color(0xFFFFF3E0);        // warm sand - surface
  const cSlate = Color(0xFF37474F);       // blue-grey slate - text
  const cMint = Color(0xFF00897B);        // mint-teal - success
  const cAmber = Color(0xFFF57F17);       // deep amber - warning
  const cIndigo = Color(0xFF283593);      // deep indigo - info
  const cPurple = Color(0xFF6A1B9A);      // purple - highlight
  const cForest = Color(0xFF2E7D32);      // forest green - positive

  // ──────────────────────────────────────────────────────────
  // Helper builders
  // ──────────────────────────────────────────────────────────

  Widget sceneHeader(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 34.0, bottom: 14.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: color, size: 24.0),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: color.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget constraintLabel(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget constraintCard({
    required String title,
    required String description,
    required Widget child,
    required Color accent,
    double? width,
  }) {
    return Container(
      width: width ?? 280.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11.0),
                topRight: Radius.circular(11.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: cSlate.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget infoBox(String text, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          color: cSlate.withValues(alpha: 0.85),
          height: 1.5,
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // SCENE 1 — Transform Anatomy
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 1: Transform Anatomy ---');
  print('Showing before/after constraint flow through ConstraintsTransformBox');

  final scene1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 1 — Transform Anatomy',
        'How constraints flow through the transform pipeline',
        Icons.architecture,
        cTeal,
      ),
      infoBox(
        'ConstraintsTransformBox intercepts the constraints flowing from '
        'parent to child. It takes the parent BoxConstraints, passes them '
        'through a constraintsTransform function, and delivers the MODIFIED '
        'constraints to its child. This means the child can lay out as if '
        'it had a completely different parent.',
        cTeal,
      ),

      // Anatomy: Three-phase flow diagram
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cSand,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cTeal.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(
              'Constraint Flow Pipeline',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: cTeal,
              ),
            ),
            const SizedBox(height: 16.0),
            // Phase 1: Parent constraints arrive
            Row(
              children: [
                Container(
                  width: 100.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: cIndigo.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cIndigo.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.keyboard_double_arrow_down, color: cIndigo, size: 20.0),
                      Text(
                        'Parent\nConstraints',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0, color: cIndigo, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      constraintLabel('0 ≤ w ≤ 300', cIndigo),
                      const SizedBox(height: 2.0),
                      constraintLabel('0 ≤ h ≤ 200', cIndigo),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Icon(Icons.arrow_forward, color: cSlate.withValues(alpha: 0.5), size: 20.0),
                const SizedBox(width: 8.0),
                // Phase 2: Transform
                Container(
                  width: 120.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: cRose.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cRose.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.transform, color: cRose, size: 20.0),
                      Text(
                        'Transform\nFunction',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0, color: cRose, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      constraintLabel('loosen()', cRose),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Icon(Icons.arrow_forward, color: cSlate.withValues(alpha: 0.5), size: 20.0),
                const SizedBox(width: 8.0),
                // Phase 3: Child receives modified constraints
                Container(
                  width: 100.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: cForest.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cForest.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.child_care, color: cForest, size: 20.0),
                      Text(
                        'Child\nReceives',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0, color: cForest, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      constraintLabel('0 ≤ w ≤ 300', cForest),
                      const SizedBox(height: 2.0),
                      constraintLabel('0 ≤ h ≤ 200', cForest),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'The parent says "be exactly 300×200" (tight).\n'
              'The transform loosens it to "be at most 300×200".\n'
              'The child is free to choose its own size.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.0, color: cSlate.withValues(alpha: 0.7), height: 1.5),
            ),
          ],
        ),
      ),

      // Live comparison: tight parent without/with ConstraintsTransformBox
      const SizedBox(height: 12.0),
      Text(
        'Live Comparison — Tight parent (200×120)',
        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: cSlate),
      ),
      const SizedBox(height: 8.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Without transform — child forced to parent size
          constraintCard(
            title: 'Without ConstraintsTransformBox',
            description: 'Child is forced to exactly 200×120',
            accent: cAmber,
            width: 230.0,
            child: Container(
              width: 200.0,
              height: 120.0,
              color: cAmber.withValues(alpha: 0.08),
              child: Center(
                child: SizedBox(
                  width: 200.0,
                  height: 120.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: cAmber.withValues(alpha: 0.15),
                      border: Border.all(color: cAmber, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Forced\n200×120',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: cAmber,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // With transform — child free to be smaller
          constraintCard(
            title: 'With ConstraintsTransformBox',
            description: 'Loosened: child can be 80×60',
            accent: cForest,
            width: 230.0,
            child: Container(
              width: 200.0,
              height: 120.0,
              color: cForest.withValues(alpha: 0.05),
              child: Center(
                child: ConstraintsTransformBox(
                  constraintsTransform: (BoxConstraints c) => c.loosen(),
                  child: Container(
                    width: 80.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: cForest.withValues(alpha: 0.15),
                      border: Border.all(color: cForest, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Free!\n80×60',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: cForest,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8.0),
      infoBox(
        'Key insight: without ConstraintsTransformBox, a tight parent forces '
        'the child to fill the full area. With it, the constraints are '
        'loosened, so the child picks its natural (or requested) size. '
        'The remaining space is resolved by the alignment property.',
        cForest,
      ),
    ],
  );

  print('Scene 1 built: constraint flow pipeline + tight vs loosened comparison');

  // ════════════════════════════════════════════════════════════
  // SCENE 2 — Predefined Transform Gallery
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 2: Predefined Transform Gallery ---');
  print('Showcasing the built-in transform functions');

  // Prepare a reusable child that WANTS to be 100×70
  Widget desiredChild(String label, Color c) {
    return Container(
      width: 100.0,
      height: 70.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [c.withValues(alpha: 0.2), c.withValues(alpha: 0.35)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c, width: 1.5),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: c),
        ),
      ),
    );
  }

  // Each card uses a SizedBox(width:180, height:120) as the tight parent
  Widget transformDemo({
    required String title,
    required String desc,
    required BoxConstraintsTransform transform,
    required Color color,
    required String childLabel,
  }) {
    print('  Transform demo: $title');
    return Container(
      width: 200.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.06),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: color),
                ),
                Text(desc, style: TextStyle(fontSize: 9.5, color: cSlate.withValues(alpha: 0.6))),
              ],
            ),
          ),
          Container(
            width: 180.0,
            height: 120.0,
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: cSand.withValues(alpha: 0.5),
              border: Border.all(
                color: cSlate.withValues(alpha: 0.15),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ConstraintsTransformBox(
              constraintsTransform: transform,
              alignment: Alignment.center,
              child: desiredChild(childLabel, color),
            ),
          ),
        ],
      ),
    );
  }

  final scene2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 2 — Predefined Transform Gallery',
        'Built-in constraint transforms from BoxConstraintsTransform',
        Icons.grid_view_rounded,
        cRose,
      ),
      infoBox(
        'Flutter provides several predefined transforms on the '
        'BoxConstraintsTransform type alias. Each one rewrites the incoming '
        'constraints in a specific way. All examples below place a child '
        'that wants to be 100×70 inside a tight 180×120 parent.',
        cRose,
      ),
      Wrap(
        children: [
          transformDemo(
            title: 'unconstrained',
            desc: 'Removes all limits entirely',
            transform: ConstraintsTransformBox.unconstrained,
            color: cTeal,
            childLabel: 'Free!\n100×70',
          ),
          transformDemo(
            title: 'widthUnconstrained',
            desc: 'Width free, height from parent',
            transform: ConstraintsTransformBox.widthUnconstrained,
            color: cIndigo,
            childLabel: 'Width\nfree',
          ),
          transformDemo(
            title: 'heightUnconstrained',
            desc: 'Height free, width from parent',
            transform: ConstraintsTransformBox.heightUnconstrained,
            color: cPurple,
            childLabel: 'Height\nfree',
          ),
          transformDemo(
            title: 'maxHeightUnconstrained',
            desc: 'Max-height removed, rest stays',
            transform: ConstraintsTransformBox.maxHeightUnconstrained,
            color: cAmber,
            childLabel: 'Max-H\nremoved',
          ),
          transformDemo(
            title: 'maxWidthUnconstrained',
            desc: 'Max-width removed, rest stays',
            transform: ConstraintsTransformBox.maxWidthUnconstrained,
            color: cForest,
            childLabel: 'Max-W\nremoved',
          ),
          transformDemo(
            title: 'unmodified',
            desc: 'No change — passthrough baseline',
            transform: ConstraintsTransformBox.unmodified,
            color: cSlate,
            childLabel: 'Forced\n180×120',
          ),
        ],
      ),
      const SizedBox(height: 8.0),
      infoBox(
        'Notice how "unmodified" forces the child to be 180×120 (the parent '
        'size), while "unconstrained" lets it be its natural 100×70. '
        'The partial variants (widthUnconstrained, heightUnconstrained) only '
        'free one axis while keeping the other constrained.',
        cIndigo,
      ),
    ],
  );

  print('Scene 2 built: 6 predefined transform demonstrations');

  // ════════════════════════════════════════════════════════════
  // SCENE 3 — Overflow & Clipping
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 3: Overflow & Clipping ---');
  print('Demonstrating clipBehavior with oversized children');

  Widget overflowDemo({
    required String title,
    required Clip clipBehavior,
    required double childWidth,
    required double childHeight,
    required Color accent,
    required String clipLabel,
  }) {
    print('  Clip demo: $title ($clipLabel)');
    return Container(
      width: 200.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: accent),
                ),
                constraintLabel('Clip.$clipLabel', accent),
              ],
            ),
          ),
          Container(
            width: 150.0,
            height: 100.0,
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: cSand.withValues(alpha: 0.3),
              border: Border.all(color: cSlate.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: ConstraintsTransformBox(
              constraintsTransform: ConstraintsTransformBox.unconstrained,
              clipBehavior: clipBehavior,
              alignment: Alignment.center,
              child: Container(
                width: childWidth,
                height: childHeight,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.2),
                  border: Border.all(color: accent, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    '${childWidth.toStringAsFixed(0)}×${childHeight.toStringAsFixed(0)}\nin 150×100',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: accent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final scene3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 3 — Overflow & Clipping',
        'What happens when the child is bigger than the parent box',
        Icons.crop,
        cAmber,
      ),
      infoBox(
        'When constraintsTransform frees a child from its parent constraints, '
        'the child might become BIGGER than the space the parent allocated. '
        'The clipBehavior property controls whether the overflow is visible '
        'or clipped. The default is Clip.none (overflow visible for debugging).',
        cAmber,
      ),

      // Row 1: child just fits vs barely overflows
      Text(
        'Graduated Overflow Series — 150×100 parent, unconstrained child:',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: cSlate),
      ),
      const SizedBox(height: 4.0),
      Wrap(
        children: [
          overflowDemo(
            title: 'No overflow',
            clipBehavior: Clip.none,
            childWidth: 120.0,
            childHeight: 80.0,
            accent: cForest,
            clipLabel: 'none',
          ),
          overflowDemo(
            title: 'Slight overflow',
            clipBehavior: Clip.none,
            childWidth: 170.0,
            childHeight: 115.0,
            accent: cAmber,
            clipLabel: 'none',
          ),
          overflowDemo(
            title: 'Large overflow',
            clipBehavior: Clip.none,
            childWidth: 220.0,
            childHeight: 150.0,
            accent: cRose,
            clipLabel: 'none',
          ),
        ],
      ),
      const SizedBox(height: 12.0),

      // Row 2: Same oversized child with different clip modes
      Text(
        'Clip Behavior Comparison — Same 200×140 child in 150×100:',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: cSlate),
      ),
      const SizedBox(height: 4.0),
      Wrap(
        children: [
          overflowDemo(
            title: 'Clip.none',
            clipBehavior: Clip.none,
            childWidth: 200.0,
            childHeight: 140.0,
            accent: cTeal,
            clipLabel: 'none',
          ),
          overflowDemo(
            title: 'Clip.hardEdge',
            clipBehavior: Clip.hardEdge,
            childWidth: 200.0,
            childHeight: 140.0,
            accent: cIndigo,
            clipLabel: 'hardEdge',
          ),
          overflowDemo(
            title: 'Clip.antiAlias',
            clipBehavior: Clip.antiAlias,
            childWidth: 200.0,
            childHeight: 140.0,
            accent: cPurple,
            clipLabel: 'antiAlias',
          ),
        ],
      ),
      const SizedBox(height: 8.0),
      infoBox(
        'Clip.none leaves overflow visible — useful during development to see '
        'sizing issues. Clip.hardEdge clips sharply (fastest). '
        'Clip.antiAlias smooths the clipping edge (slightly more expensive). '
        'In production, use hardEdge unless you see jaggies on rounded corners.',
        cIndigo,
      ),
    ],
  );

  print('Scene 3 built: graduated overflow series + clip behavior comparisons');

  // ════════════════════════════════════════════════════════════
  // SCENE 4 — Alignment Under Transform
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 4: Alignment Under Transform ---');
  print('How alignment resolves size mismatches');

  Widget alignmentTile(Alignment align, String label, Color accent) {
    return Container(
      width: 130.0,
      height: 110.0,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7.0),
                topRight: Radius.circular(7.0),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: accent),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: cSand.withValues(alpha: 0.4),
                border: Border.all(color: cSlate.withValues(alpha: 0.1)),
              ),
              child: ConstraintsTransformBox(
                constraintsTransform: ConstraintsTransformBox.unconstrained,
                alignment: align,
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: 40.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.3),
                    border: Border.all(color: accent, width: 1.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final scene4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 4 — Alignment Under Transform',
        'How the alignment property positions a differently-sized child',
        Icons.format_align_center,
        cIndigo,
      ),
      infoBox(
        'When a constraint transform lets the child be smaller (or bigger) than '
        'the parent allocated space, the alignment property determines WHERE the '
        'child is placed within that space. This is identical to how Align works '
        '— but it happens automatically inside ConstraintsTransformBox.',
        cIndigo,
      ),

      // 3x3 alignment grid — small child in bigger parent
      Text(
        'Small child (40×30) in larger parent — 9-point alignment grid:',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: cSlate),
      ),
      const SizedBox(height: 6.0),
      Row(
        children: [
          alignmentTile(Alignment.topLeft, 'topLeft', cTeal),
          alignmentTile(Alignment.topCenter, 'topCenter', cMint),
          alignmentTile(Alignment.topRight, 'topRight', cForest),
        ],
      ),
      Row(
        children: [
          alignmentTile(Alignment.centerLeft, 'centerLeft', cIndigo),
          alignmentTile(Alignment.center, 'center', cPurple),
          alignmentTile(Alignment.centerRight, 'centerRight', cRose),
        ],
      ),
      Row(
        children: [
          alignmentTile(Alignment.bottomLeft, 'bottomLeft', cAmber),
          alignmentTile(Alignment.bottomCenter, 'bottomCenter', cSlate),
          alignmentTile(Alignment.bottomRight, 'bottomRight', cTeal),
        ],
      ),

      const SizedBox(height: 16.0),

      // Oversized child alignment — shows alignment with clipping
      Text(
        'Oversized child (200×150) in 130×90 parent — alignment shifts visible portion:',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: cSlate),
      ),
      const SizedBox(height: 6.0),
      Wrap(
        children: [
          for (final entry in <Map<String, dynamic>>[
            {'align': Alignment.topLeft, 'label': 'topLeft', 'color': cTeal},
            {'align': Alignment.center, 'label': 'center', 'color': cPurple},
            {'align': Alignment.bottomRight, 'label': 'bottomRight', 'color': cRose},
          ])
            Container(
              width: 160.0,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: (entry['color'] as Color).withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: (entry['color'] as Color).withValues(alpha: 0.08),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(7.0),
                        topRight: Radius.circular(7.0),
                      ),
                    ),
                    child: Text(
                      entry['label'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: entry['color'] as Color,
                      ),
                    ),
                  ),
                  Container(
                    width: 130.0,
                    height: 90.0,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: cSand.withValues(alpha: 0.3),
                      border: Border.all(color: cSlate.withValues(alpha: 0.15)),
                    ),
                    child: ConstraintsTransformBox(
                      constraintsTransform: ConstraintsTransformBox.unconstrained,
                      alignment: entry['align'] as Alignment,
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        width: 200.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              (entry['color'] as Color).withValues(alpha: 0.15),
                              (entry['color'] as Color).withValues(alpha: 0.35),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: entry['color'] as Color,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '200×150',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: entry['color'] as Color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      const SizedBox(height: 8.0),
      infoBox(
        'With an oversized child, alignment determines WHICH PORTION of the '
        'child is visible within the clipping rect. topLeft shows the '
        'top-left corner, center shows the middle, bottomRight shows the '
        'bottom-right corner. The child is always its full size in memory — '
        'alignment merely shifts the viewport.',
        cPurple,
      ),
    ],
  );

  print('Scene 4 built: 9-point alignment grid + oversized child alignment');

  // ════════════════════════════════════════════════════════════
  // SCENE 5 — Custom Transform Functions
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 5: Custom Transform Functions ---');
  print('Writing bespoke constraint rewriters');

  Widget customTransformCard({
    required String title,
    required String code,
    required String explanation,
    required BoxConstraints Function(BoxConstraints) transform,
    required Color accent,
    required double parentW,
    required double parentH,
  }) {
    print('  Custom transform: $title');
    return Container(
      width: 280.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.06),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: accent),
                ),
                const SizedBox(height: 4.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: cSlate.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    code,
                    style: TextStyle(
                      fontSize: 9.5,
                      fontFamily: 'monospace',
                      color: cSlate.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  explanation,
                  style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: parentW,
              height: parentH,
              decoration: BoxDecoration(
                color: cSand.withValues(alpha: 0.4),
                border: Border.all(color: cSlate.withValues(alpha: 0.15)),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: ConstraintsTransformBox(
                constraintsTransform: transform,
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: 200.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent.withValues(alpha: 0.15),
                        accent.withValues(alpha: 0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: accent, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      'Child wants\n200×140',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final scene5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 5 — Custom Transform Functions',
        'Writing bespoke constraint rewriters for advanced layouts',
        Icons.code,
        cPurple,
      ),
      infoBox(
        'The constraintsTransform parameter accepts any function with signature '
        'BoxConstraints Function(BoxConstraints). This means you can write ANY '
        'constraint transformation logic — scaling, clamping, axis swapping, '
        'minimum guarantees, aspect ratio enforcement, and more.',
        cPurple,
      ),

      Wrap(
        children: [
          // Scale constraints by 1.5x
          customTransformCard(
            title: 'Scale 1.5×',
            code: '(c) => c * 1.5',
            explanation: 'Allows child 1.5× the parent space',
            transform: (BoxConstraints c) => BoxConstraints(
              minWidth: c.minWidth * 1.5,
              maxWidth: c.maxWidth * 1.5,
              minHeight: c.minHeight * 1.5,
              maxHeight: c.maxHeight * 1.5,
            ),
            accent: cTeal,
            parentW: 200.0,
            parentH: 130.0,
          ),
          // Clamp to specific range
          customTransformCard(
            title: 'Clamp Width 80–120',
            code: '(c) => c.copyWith(\n  minWidth: 80, maxWidth: 120)',
            explanation: 'Forces width between 80 and 120 regardless of parent',
            transform: (BoxConstraints c) => BoxConstraints(
              minWidth: 80.0,
              maxWidth: 120.0,
              minHeight: c.minHeight,
              maxHeight: c.maxHeight,
            ),
            accent: cRose,
            parentW: 200.0,
            parentH: 130.0,
          ),
          // Swap width and height axes
          customTransformCard(
            title: 'Swap Axes',
            code: '(c) => c.flipped',
            explanation: 'Width constraints become height and vice versa',
            transform: (BoxConstraints c) => BoxConstraints(
              minWidth: c.minHeight,
              maxWidth: c.maxHeight,
              minHeight: c.minWidth,
              maxHeight: c.maxWidth,
            ),
            accent: cIndigo,
            parentW: 240.0,
            parentH: 100.0,
          ),
          // Tighten to exact values
          customTransformCard(
            title: 'Tighten to 160×100',
            code: '(c) => BoxConstraints.tight(\n  Size(160, 100))',
            explanation: 'Forces child to exact size, ignoring parent',
            transform: (BoxConstraints c) => BoxConstraints.tight(
              const Size(160.0, 100.0),
            ),
            accent: cAmber,
            parentW: 200.0,
            parentH: 130.0,
          ),
          // Guarantee minimum floor
          customTransformCard(
            title: 'Minimum Floor 100×80',
            code: '(c) => c.enforce(\n  BoxConstraints(min: 100×80))',
            explanation: 'Ensures child is at least 100×80 even in tiny parent',
            transform: (BoxConstraints c) => BoxConstraints(
              minWidth: 100.0,
              maxWidth: c.maxWidth < 100.0 ? 100.0 : c.maxWidth,
              minHeight: 80.0,
              maxHeight: c.maxHeight < 80.0 ? 80.0 : c.maxHeight,
            ),
            accent: cForest,
            parentW: 200.0,
            parentH: 130.0,
          ),
          // Loosen only minimum
          customTransformCard(
            title: 'Remove Minimums Only',
            code: '(c) => c.copyWith(\n  minWidth: 0, minHeight: 0)',
            explanation: 'Keeps maxes from parent but removes tight minimums',
            transform: (BoxConstraints c) => BoxConstraints(
              minWidth: 0.0,
              maxWidth: c.maxWidth,
              minHeight: 0.0,
              maxHeight: c.maxHeight,
            ),
            accent: cMint,
            parentW: 200.0,
            parentH: 130.0,
          ),
        ],
      ),
      const SizedBox(height: 8.0),
      infoBox(
        'Custom transforms unlock powerful layout behaviors:\n'
        '• Scale transforms let content exceed parent boundaries\n'
        '• Clamp transforms override parent size policies\n'
        '• Axis swap enables portrait-to-landscape conversions\n'
        '• Minimum floors guarantee size even in constrained spaces\n'
        '• Selective loosening targets specific constraint edges',
        cPurple,
      ),
    ],
  );

  print('Scene 5 built: 6 custom constraint transforms with live visualizations');

  // ════════════════════════════════════════════════════════════
  // SCENE 6 — Practical Patterns
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 6: Practical Patterns ---');
  print('Real-world usage patterns for ConstraintsTransformBox');

  final scene6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 6 — Practical Patterns',
        'Real-world use cases where ConstraintsTransformBox shines',
        Icons.build_circle,
        cForest,
      ),
      infoBox(
        'ConstraintsTransformBox is most useful in situations where the '
        'standard layout system constrains a child too aggressively. Here '
        'are common patterns where it saves the day.',
        cForest,
      ),

      // Pattern 1: Break free from tight parent
      constraintCard(
        title: 'Pattern: Break Free from Tight Parent',
        description: 'A SizedBox forces 200×60, but the child content is wider',
        accent: cTeal,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SizedBox(width: 200, height: 60) parent:',
              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 6.0),
            SizedBox(
              width: 200.0,
              height: 60.0,
              child: ConstraintsTransformBox(
                constraintsTransform: ConstraintsTransformBox.widthUnconstrained,
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 340.0,
                  height: 50.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [cTeal.withValues(alpha: 0.15), cTeal.withValues(alpha: 0.05)],
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cTeal.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: cTeal, size: 18.0),
                      const SizedBox(width: 6.0),
                      Text(
                        'This label extends beyond its 200px container',
                        style: TextStyle(fontSize: 11.0, color: cTeal, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              'Use case: tooltip-like overlays, badges, ribbons that extend '
              'beyond their logical layout slot.',
              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8.0),

      // Pattern 2: Width-only freedom (tag overflow in column)
      constraintCard(
        title: 'Pattern: Horizontal Tag Overflow',
        description: 'Tags that can scroll or wrap beyond column width',
        accent: cRose,
        width: 380.0,
        child: SizedBox(
          width: 340.0,
          height: 90.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Tags:',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cSlate),
              ),
              const SizedBox(height: 4.0),
              SizedBox(
                height: 34.0,
                child: ConstraintsTransformBox(
                  constraintsTransform: ConstraintsTransformBox.widthUnconstrained,
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final tag in ['Flutter', 'Dart', 'Widgets', 'Layout', 'Constraints', 'Transform', 'Rendering', 'Advanced'])
                        Container(
                          margin: const EdgeInsets.only(right: 6.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: cRose.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(color: cRose.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(fontSize: 10.0, color: cRose, fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Row exceeds parent width but is clipped. Useful for tag clouds, '
                'chip lists, and horizontal scrolling content.',
                style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8.0),

      // Pattern 3: Debug sizing panel
      constraintCard(
        title: 'Pattern: Debug Constraint Inspector',
        description: 'Using transform to probe and display constraint data',
        accent: cPurple,
        width: 380.0,
        child: SizedBox(
          width: 340.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A ConstraintsTransformBox can read, log, and modify constraints '
                'mid-pipeline — perfect for layout debugging:',
                style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.7)),
              ),
              const SizedBox(height: 8.0),
              Container(
                width: 300.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: cSand,
                  border: Border.all(color: cPurple.withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ConstraintsTransformBox(
                  constraintsTransform: (BoxConstraints c) {
                    print('  [Debug Inspector] Incoming constraints: $c');
                    return c.loosen();
                  },
                  alignment: Alignment.center,
                  child: Container(
                    width: 180.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: cPurple.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cPurple, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        'Constraints logged to console\n via transform function',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600,
                          color: cPurple,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: cSlate.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '// Inside transform:\n'
                  'print("Incoming: \$constraints");\n'
                  'return constraints.loosen();\n'
                  '// Now you see EXACTLY what parents send!',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontFamily: 'monospace',
                    color: cSlate.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8.0),

      // Pattern 4: Responsive adapter
      constraintCard(
        title: 'Pattern: Responsive Constraint Adapter',
        description: 'Transform constraints based on available width',
        accent: cIndigo,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Narrow context
                Container(
                  width: 110.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: cSand.withValues(alpha: 0.5),
                    border: Border.all(color: cSlate.withValues(alpha: 0.15)),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(3.0),
                        color: cIndigo.withValues(alpha: 0.08),
                        child: Text(
                          'Narrow (110px)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8.0, color: cIndigo),
                        ),
                      ),
                      Expanded(
                        child: ConstraintsTransformBox(
                          constraintsTransform: (BoxConstraints c) {
                            // In narrow mode, let content stack vertically
                            return BoxConstraints(
                              minWidth: 0.0,
                              maxWidth: c.maxWidth,
                              minHeight: 0.0,
                              maxHeight: double.infinity,
                            );
                          },
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 90.0,
                                height: 20.0,
                                margin: const EdgeInsets.all(2.0),
                                color: cIndigo.withValues(alpha: 0.15),
                                child: Center(
                                  child: Text('Item A', style: TextStyle(fontSize: 8.0, color: cIndigo)),
                                ),
                              ),
                              Container(
                                width: 90.0,
                                height: 20.0,
                                margin: const EdgeInsets.all(2.0),
                                color: cIndigo.withValues(alpha: 0.2),
                                child: Center(
                                  child: Text('Item B', style: TextStyle(fontSize: 8.0, color: cIndigo)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                // Wide context
                Container(
                  width: 220.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: cSand.withValues(alpha: 0.5),
                    border: Border.all(color: cSlate.withValues(alpha: 0.15)),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(3.0),
                        color: cForest.withValues(alpha: 0.08),
                        child: Text(
                          'Wide (220px)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8.0, color: cForest),
                        ),
                      ),
                      Expanded(
                        child: ConstraintsTransformBox(
                          constraintsTransform: (BoxConstraints c) {
                            // In wide mode, let items sit side by side
                            return BoxConstraints(
                              minWidth: 0.0,
                              maxWidth: double.infinity,
                              minHeight: 0.0,
                              maxHeight: c.maxHeight,
                            );
                          },
                          clipBehavior: Clip.hardEdge,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 90.0,
                                height: 40.0,
                                margin: const EdgeInsets.all(3.0),
                                color: cForest.withValues(alpha: 0.15),
                                child: Center(
                                  child: Text('Item A', style: TextStyle(fontSize: 9.0, color: cForest)),
                                ),
                              ),
                              Container(
                                width: 90.0,
                                height: 40.0,
                                margin: const EdgeInsets.all(3.0),
                                color: cForest.withValues(alpha: 0.2),
                                child: Center(
                                  child: Text('Item B', style: TextStyle(fontSize: 9.0, color: cForest)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Transform makes the vertical axis infinite in narrow mode '
              '(stack items) and horizontal axis infinite in wide mode '
              '(place side by side).',
              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8.0),

      // Pattern 5: Aspect ratio enforcement
      constraintCard(
        title: 'Pattern: Aspect Ratio via Transform',
        description: 'Enforce 16:9 ratio regardless of parent shape',
        accent: cAmber,
        width: 380.0,
        child: Row(
          children: [
            // Tall parent
            Column(
              children: [
                Text(
                  'Tall parent (120×180):',
                  style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.6)),
                ),
                const SizedBox(height: 4.0),
                Container(
                  width: 120.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    color: cSand.withValues(alpha: 0.4),
                    border: Border.all(color: cSlate.withValues(alpha: 0.15)),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ConstraintsTransformBox(
                    constraintsTransform: (BoxConstraints c) {
                      // Force 16:9 aspect ratio
                      final w = c.maxWidth;
                      final h = w * 9.0 / 16.0;
                      return BoxConstraints.tight(Size(w, h));
                    },
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            cAmber.withValues(alpha: 0.2),
                            cAmber.withValues(alpha: 0.35),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: cAmber, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          '16:9',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: cAmber,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16.0),
            // Wide parent
            Column(
              children: [
                Text(
                  'Wide parent (200×80):',
                  style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.6)),
                ),
                const SizedBox(height: 4.0),
                Container(
                  width: 200.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: cSand.withValues(alpha: 0.4),
                    border: Border.all(color: cSlate.withValues(alpha: 0.15)),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ConstraintsTransformBox(
                    constraintsTransform: (BoxConstraints c) {
                      final h = c.maxHeight;
                      final w = h * 16.0 / 9.0;
                      return BoxConstraints.tight(Size(w, h));
                    },
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            cAmber.withValues(alpha: 0.2),
                            cAmber.withValues(alpha: 0.35),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: cAmber, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          '16:9',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: cAmber,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 8.0),

      // Pattern 6: Nested transforms
      constraintCard(
        title: 'Pattern: Nested Constraint Transforms',
        description: 'Multiple transforms composing through the tree',
        accent: cMint,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Outer: loosen → Inner: clamp width 60–140 → Leaf child:',
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: cSlate),
            ),
            const SizedBox(height: 6.0),
            Container(
              width: 300.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: cMint.withValues(alpha: 0.03),
                border: Border.all(color: cMint.withValues(alpha: 0.3), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 2.0,
                    left: 4.0,
                    child: Text(
                      'Outer (300×100, tight)',
                      style: TextStyle(fontSize: 8.0, color: cMint.withValues(alpha: 0.5)),
                    ),
                  ),
                  Center(
                    child: ConstraintsTransformBox(
                      constraintsTransform: (BoxConstraints c) => c.loosen(),
                      alignment: Alignment.center,
                      child: Container(
                        width: 220.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: cIndigo.withValues(alpha: 0.05),
                          border: Border.all(color: cIndigo.withValues(alpha: 0.3), width: 1.5),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 2.0,
                              left: 4.0,
                              child: Text(
                                'Middle (loosened, picks 220×80)',
                                style: TextStyle(fontSize: 8.0, color: cIndigo.withValues(alpha: 0.5)),
                              ),
                            ),
                            Center(
                              child: ConstraintsTransformBox(
                                constraintsTransform: (BoxConstraints c) {
                                  return BoxConstraints(
                                    minWidth: 60.0,
                                    maxWidth: 140.0,
                                    minHeight: c.minHeight,
                                    maxHeight: c.maxHeight,
                                  );
                                },
                                alignment: Alignment.center,
                                child: Container(
                                  width: 200.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        cPurple.withValues(alpha: 0.15),
                                        cPurple.withValues(alpha: 0.3),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(6.0),
                                    border: Border.all(color: cPurple, width: 1.5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Leaf (clamped to 140w)',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: cPurple,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Each ConstraintsTransformBox in the tree further modifies the '
              'constraints. The outer loosens, the inner clamps. The leaf child '
              'wants 200px width but gets clamped to 140px by the inner transform.',
              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),

      // Closing summary
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cForest.withValues(alpha: 0.08), cTeal.withValues(alpha: 0.06)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cForest.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: cForest, size: 18.0),
                const SizedBox(width: 8.0),
                Text(
                  'When to reach for ConstraintsTransformBox',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: cForest,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              '• A parent is too tight and the child needs breathing room\n'
              '• You need content to overflow its logical slot (tooltips, badges)\n'
              '• You want to enforce an aspect ratio in a flexible container\n'
              '• You need to debug what constraints a parent is actually sending\n'
              '• You want different constraint policies in narrow vs wide layouts\n'
              '• You need to compose multiple constraint modifications in a tree\n'
              '• You want a child to lay out as if it were in a different container\n\n'
              'ConstraintsTransformBox is a scalpel for constraint surgery — use '
              'it when UnconstrainedBox, OverflowBox, or SizedOverflowBox are too '
              'blunt, and you need precise, programmable control over constraint flow.',
              style: TextStyle(
                fontSize: 11.0,
                color: cSlate.withValues(alpha: 0.8),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('Scene 6 built: 6 practical patterns with live visualizations');

  // ════════════════════════════════════════════════════════════
  // TITLE BANNER
  // ════════════════════════════════════════════════════════════
  final titleBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cTeal.withValues(alpha: 0.12), cRose.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cTeal.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.transform, color: cTeal, size: 28.0),
            const SizedBox(width: 10.0),
            Text(
              'ConstraintsTransformBox',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: cTeal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Programmable Constraint Surgery for Advanced Layouts',
          style: TextStyle(
            fontSize: 13.0,
            color: cSlate.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          alignment: WrapAlignment.center,
          children: [
            constraintLabel('constraintsTransform', cTeal),
            constraintLabel('alignment', cRose),
            constraintLabel('clipBehavior', cAmber),
            constraintLabel('BoxConstraintsTransform', cIndigo),
            constraintLabel('loosen / unconstrained', cForest),
            constraintLabel('custom transforms', cPurple),
          ],
        ),
      ],
    ),
  );

  // ════════════════════════════════════════════════════════════
  // ASSEMBLE APP
  // ════════════════════════════════════════════════════════════
  print('\n=== Assembling final layout ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: cSand,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleBanner,
            scene1,
            scene2,
            scene3,
            scene4,
            scene5,
            scene6,
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    ),
  );
}
