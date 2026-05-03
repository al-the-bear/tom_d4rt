// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// ConstraintsTransformBox — Deep Demo
// -----------------------------------------------------------------------------
// A long-form, hand-authored harness that exercises ConstraintsTransformBox in
// many shapes:
//
//   • Section 1  — Intro, mental model, ASCII diagram
//   • Section 2  — Drop-width   (heightUnconstrained)
//   • Section 3  — Drop-height  (widthUnconstrained)
//   • Section 4  — Drop both    (unconstrained / maxUnconstrained)
//   • Section 5  — Loosen       (custom: c.loosen())
//   • Section 6  — Custom transform (tight half-width × 80 px)
//   • Section 7  — ScrollView-friendly child (horizontal scroller + ListView row)
//   • Section 8  — clipBehavior gallery (none / hardEdge / antiAlias / saveLayer)
//   • Section 9  — Comparison: ConstraintsTransformBox vs OverflowBox vs
//                  UnconstrainedBox
//   • Section 10 — Pitfalls (5 cards)
//   • Section 11 — Recipe gallery (4 cards)
//   • Section 12 — Reference table
//
// Notes on the Flutter 3.41.6 API in use:
//
//   ConstraintsTransformBox({
//     Key? key,
//     Widget? child,
//     TextDirection? textDirection,
//     AlignmentGeometry alignment = Alignment.center,
//     required BoxConstraintsTransform constraintsTransform,
//     Clip clipBehavior = Clip.none,
//     String debugTransformType = '',
//   });
//
// There is *no* `ConstraintsTransformBox.unconstrained` named *constructor*.
// What ships are static `BoxConstraintsTransform` *functions* you pass into
// `constraintsTransform`:
//
//   ConstraintsTransformBox.unmodified
//   ConstraintsTransformBox.unconstrained
//   ConstraintsTransformBox.widthUnconstrained        // == c.heightConstraints()
//   ConstraintsTransformBox.heightUnconstrained       // == c.widthConstraints()
//   ConstraintsTransformBox.maxWidthUnconstrained     // copy(maxWidth: ∞)
//   ConstraintsTransformBox.maxHeightUnconstrained    // copy(maxHeight: ∞)
//   ConstraintsTransformBox.maxUnconstrained          // copy(both ∞)
//
// The return value of `constraintsTransform` must be `isNormalized` — i.e.
// 0 ≤ min ≤ max for both axes — otherwise layout asserts.
// =============================================================================

const double _kSectionGap = 28;
const double _kCardRadius = 12;

// ---------------------------------------------------------------------------
// Build entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('=== ConstraintsTransformBox Deep Demo ===');
  print(
    'Flutter version target: 3.41.6 (stable). Demonstrates constraint rewriting.',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ConstraintsTransformBox Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      brightness: Brightness.light,
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('ConstraintsTransformBox — Deep Demo'),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SectionDivider(
                index: 1,
                title: 'Intro — what does it do?',
              ),
              const _IntroSection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(
                index: 2,
                title: 'Drop the WIDTH constraint',
              ),
              const _DropWidthSection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(
                index: 3,
                title: 'Drop the HEIGHT constraint',
              ),
              const _DropHeightSection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(
                index: 4,
                title: 'Drop BOTH constraints',
              ),
              const _DropBothSection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(
                index: 5,
                title: 'Loosen the constraints (min → 0)',
              ),
              const _LoosenSection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(
                index: 6,
                title: 'Custom transform: tight(50% × 80)',
              ),
              const _CustomTransformSection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(
                index: 7,
                title: 'ScrollView-friendly child',
              ),
              const _ScrollFriendlySection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(
                index: 8,
                title: 'clipBehavior gallery',
              ),
              const _ClipBehaviorGallery(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(
                index: 9,
                title:
                    'ConstraintsTransformBox vs OverflowBox vs UnconstrainedBox',
              ),
              const _ComparisonSection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(index: 10, title: 'Pitfalls'),
              const _PitfallsSection(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(index: 11, title: 'Recipe gallery'),
              const _RecipeGallery(),
              const SizedBox(height: _kSectionGap),

              _SectionDivider(index: 12, title: 'Reference table'),
              const _ReferenceTable(),
              const SizedBox(height: 32),

              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'End of ConstraintsTransformBox deep demo.',
                    style: TextStyle(fontStyle: FontStyle.italic),
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

// ===========================================================================
// Reusable building blocks
// ===========================================================================

/// A horizontal divider with a section index pill on the left.
class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.index, required this.title});

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.indigo.shade600,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Wraps a small explanation under a subtitle.
class _Note extends StatelessWidget {
  const _Note(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1.4),
      ),
    );
  }
}

/// A subtitled labelled card used by most demo subsections.
class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.label,
    required this.child,
    this.subLabel,
    this.height,
  });

  final String label;
  final String? subLabel;
  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          if (subLabel != null) ...<Widget>[
            const SizedBox(height: 2),
            Text(
              subLabel!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: 8),
          if (height != null)
            SizedBox(height: height, child: child)
          else
            child,
        ],
      ),
    );
  }
}

/// A simple coloured box that prints its laid-out size in the center.
class _SizedTag extends StatelessWidget {
  const _SizedTag({
    required this.label,
    this.width = 80,
    this.height = 40,
    this.color = Colors.amber,
  });

  final String label;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

/// A row of N coloured tags with the given total intrinsic width.
class _TagRow extends StatelessWidget {
  const _TagRow({
    required this.count,
    this.width = 90,
    this.height = 36,
    this.gap = 6,
  });

  final int count;
  final double width;
  final double height;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < count; i++) ...<Widget>[
          _SizedTag(
            label: 'tag ${i + 1}',
            width: width,
            height: height,
            color: Colors.primaries[i % Colors.primaries.length].shade300,
          ),
          if (i != count - 1) SizedBox(width: gap),
        ],
      ],
    );
  }
}

/// A column of N coloured tags with given intrinsic height.
class _TagColumn extends StatelessWidget {
  const _TagColumn({
    required this.count,
    this.width = 140,
    this.height = 36,
    this.gap = 6,
  });

  final int count;
  final double width;
  final double height;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < count; i++) ...<Widget>[
          _SizedTag(
            label: 'row ${i + 1}',
            width: width,
            height: height,
            color: Colors.primaries[i % Colors.primaries.length].shade300,
          ),
          if (i != count - 1) SizedBox(height: gap),
        ],
      ],
    );
  }
}

// ===========================================================================
// Section 1 — Intro
// ===========================================================================
class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label: 'What is ConstraintsTransformBox?',
      subLabel: 'A precise, programmable rewriter of incoming BoxConstraints.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Note(
            'ConstraintsTransformBox sits between a parent and a child. It is given the '
            'parent\'s BoxConstraints, runs them through a function you supply, and lays the '
            'child out under the *transformed* constraints. After the child reports its size, '
            'this widget itself is sized by the *original* (parent) constraints — the child '
            'is then aligned and optionally clipped inside the box.',
          ),
          const _Note(
            'Compared to its siblings:'
            '\n  • OverflowBox      — also rewrites constraints but cannot grow the parent.'
            '\n  • UnconstrainedBox — drops constraints AND lets the box grow to fit the child.'
            '\n  • SizedOverflowBox — pretends to be a fixed size while letting the child overflow.'
            '\n  • ConstraintsTransformBox — most general: arbitrary transform, alignment, clip, '
            'but the box itself is sized by the *parent* constraints (no auto-growth).',
          ),
          const SizedBox(height: 8),
          // ASCII flow diagram, rendered as a code block.
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Text(
              '''
┌─────────────────────────────────────────────────────────────┐
│            parent BoxConstraints ──► (incoming)             │
│                       │                                     │
│                       ▼                                     │
│               constraintsTransform(c)                       │
│                       │                                     │
│                       ▼                                     │
│             child BoxConstraints ──► (rewritten)            │
│                       │                                     │
│                       ▼                                     │
│       child.layout()  ─►  child.size                        │
│                       │                                     │
│           box size = parent.constrain(child.size)           │
│                       │                                     │
│             align + clipBehavior on child                   │
└─────────────────────────────────────────────────────────────┘
''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.25,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Live example: identity transform + a coloured tag.
          const Text(
            'Live identity example (constraintsTransform: ConstraintsTransformBox.unmodified):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 60,
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              constraintsTransform: ConstraintsTransformBox.unmodified,
              debugTransformType: 'unmodified',
              child: Container(
                color: Colors.indigo.shade50,
                alignment: Alignment.center,
                child: const Text(
                  'I receive the parent constraints unchanged.',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 2 — Drop-width (heightUnconstrained)
// ===========================================================================
class _DropWidthSection extends StatelessWidget {
  const _DropWidthSection();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label: 'constraintsTransform: heightUnconstrained',
      subLabel:
          'Equivalent to (c) => c.widthConstraints(); width is dropped, height stays bounded.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Note(
            'Wait — naming is intentionally counter-intuitive: '
            'heightUnconstrained means "remove the height constraints" so the child gets '
            'unbounded HEIGHT. To pass an unbounded WIDTH to a child you use '
            'widthUnconstrained, which keeps height constraints and removes width '
            'constraints. So dropping the *width* of incoming constraints (i.e. letting '
            'the child have an unbounded height) is the heightUnconstrained transform — '
            'BUT in this section we want the opposite: an unbounded WIDTH for the child, '
            'so we use widthUnconstrained.',
          ),
          const SizedBox(height: 6),
          const Text(
            'Demo: an intrinsically wide Row inside a fixed-width parent.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          // Live demo: a Row of tags totalling >700 px inside a 300 px viewport.
          Container(
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              border: Border.all(color: Colors.amber.shade400, width: 2),
              borderRadius: BorderRadius.circular(_kCardRadius),
            ),
            padding: const EdgeInsets.all(6),
            child: SizedBox(
              height: 60,
              child: ConstraintsTransformBox(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.hardEdge,
                constraintsTransform:
                    ConstraintsTransformBox.widthUnconstrained,
                debugTransformType: 'widthUnconstrained',
                child: const _TagRow(count: 8, width: 100, height: 44, gap: 8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _Note(
            'The Row laid out at its full intrinsic width (~848 px), but the box itself '
            'is still constrained to the parent\'s width. The remainder is clipped by '
            'Clip.hardEdge. Without the ConstraintsTransformBox, the Row would have '
            'overflowed the screen and triggered a layout error.',
          ),
          const SizedBox(height: 14),
          const Text(
            'Naming wrap-up: the static functions read as "this axis is unconstrained".',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 3 — Drop-height (heightUnconstrained really)
// ===========================================================================
class _DropHeightSection extends StatelessWidget {
  const _DropHeightSection();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label: 'constraintsTransform: heightUnconstrained',
      subLabel: '(c) => c.widthConstraints();  height: 0..∞, width unchanged.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Note(
            'Symmetric example: a tall Column inside a 200 px tall parent. The '
            'ConstraintsTransformBox lets the column lay out at its full intrinsic '
            'height; the visible box is still 200 px tall and clips the rest.',
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              border: Border.all(color: Colors.lightBlue.shade400, width: 2),
              borderRadius: BorderRadius.circular(_kCardRadius),
            ),
            padding: const EdgeInsets.all(6),
            child: SizedBox(
              height: 200,
              width: 220,
              child: ConstraintsTransformBox(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.hardEdge,
                constraintsTransform:
                    ConstraintsTransformBox.heightUnconstrained,
                debugTransformType: 'heightUnconstrained',
                child: const _TagColumn(
                  count: 8,
                  height: 36,
                  width: 180,
                  gap: 4,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _Note(
            'Note: if you change alignment from topCenter to bottomCenter, the *bottom* '
            'tag is the one visible; without alignment, the column is centered '
            'vertically and is clipped on both ends.',
          ),
          const SizedBox(height: 12),
          // Quick alignment side-by-side.
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: <Widget>[
              _AlignedColumnDemo(
                title: 'topCenter',
                alignment: Alignment.topCenter,
              ),
              _AlignedColumnDemo(
                title: 'center',
                alignment: Alignment.center,
              ),
              _AlignedColumnDemo(
                title: 'bottomCenter',
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlignedColumnDemo extends StatelessWidget {
  const _AlignedColumnDemo({required this.title, required this.alignment});

  final String title;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 110,
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue.shade400),
            borderRadius: BorderRadius.circular(8),
            color: Colors.lightBlue.shade50,
          ),
          child: ConstraintsTransformBox(
            alignment: alignment,
            clipBehavior: Clip.hardEdge,
            constraintsTransform: ConstraintsTransformBox.heightUnconstrained,
            child: const _TagColumn(count: 6, width: 90, height: 30),
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ===========================================================================
// Section 4 — Drop both
// ===========================================================================
class _DropBothSection extends StatelessWidget {
  const _DropBothSection();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label: 'constraintsTransform: unconstrained / maxUnconstrained',
      subLabel:
          'unconstrained: const BoxConstraints();  maxUnconstrained: copyWith(maxW=∞,maxH=∞)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Note(
            'unconstrained gives the child a fully unbounded BoxConstraints (0..∞ on both '
            'axes). This is similar to UnconstrainedBox(constrainedAxis: null) but the '
            'box itself does NOT grow — it still respects the parent constraints. '
            'maxUnconstrained preserves any minimum constraints from the parent and only '
            'lifts the maxima — useful when the parent insists "you must be at least X tall".',
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: _DemoCard(
                  label: 'unconstrained',
                  height: 130,
                  child: ConstraintsTransformBox(
                    alignment: Alignment.center,
                    clipBehavior: Clip.hardEdge,
                    constraintsTransform: ConstraintsTransformBox.unconstrained,
                    debugTransformType: 'unconstrained',
                    child: Container(
                      color: Colors.deepPurple.shade100,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'I am sized by my own intrinsics.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DemoCard(
                  label: 'maxUnconstrained',
                  height: 130,
                  child: ConstraintsTransformBox(
                    alignment: Alignment.topLeft,
                    clipBehavior: Clip.hardEdge,
                    constraintsTransform:
                        ConstraintsTransformBox.maxUnconstrained,
                    debugTransformType: 'maxUnconstrained',
                    child: Container(
                      color: Colors.deepPurple.shade50,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'min preserved, max lifted to ∞.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const _Note(
            'A useful intuition: if you drop both maxima, an IntrinsicWidth-style child '
            'will pick its natural width, which is what you typically want for chip-like '
            'tag groups inside a flexible parent.',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 5 — Loosen
// ===========================================================================
class _LoosenSection extends StatelessWidget {
  const _LoosenSection();

  // Custom transform: loosen (drop *minimum*, keep maximum).
  static BoxConstraints _loosen(BoxConstraints c) => c.loosen();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label: 'constraintsTransform: (c) => c.loosen()',
      subLabel:
          'Drops minimum constraints. The child can be SMALLER than the parent.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Note(
            'In a horizontal Row(children: [Expanded(...), Expanded(...)]) the parent '
            'forces tight constraints on each Expanded. Wrapping the inner widget in a '
            'ConstraintsTransformBox with c.loosen() lets the inner widget shrink to its '
            'intrinsic size while still being placed in the same slot.',
          ),
          const SizedBox(height: 8),
          Container(
            height: 90,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal.shade400),
              borderRadius: BorderRadius.circular(8),
              color: Colors.teal.shade50,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ConstraintsTransformBox(
                    alignment: Alignment.center,
                    constraintsTransform: _loosen,
                    debugTransformType: 'loosen',
                    child: const _SizedTag(
                      label: 'natural',
                      width: 110,
                      height: 36,
                      color: Color(0xFFFFE082),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      color: Colors.orange.shade200,
                      alignment: Alignment.center,
                      child: const Text('tight'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _Note(
            'Left half: ConstraintsTransformBox with loosen → child is its natural 110×36 '
            'size, centered. Right half: a vanilla Center fills the entire half — note the '
            'visual difference. Center alone does NOT loosen incoming tight constraints '
            'when wrapped in something like Container(color: ...) without an explicit '
            'size, because Container forwards them as-is when no padding/decoration size '
            'change is requested.',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 6 — Custom transform: tight half-width × 80
// ===========================================================================
class _CustomTransformSection extends StatelessWidget {
  const _CustomTransformSection();

  // Tight: child gets exactly halfWidth × 80.
  static BoxConstraints _halfWidthTight80(BoxConstraints c) {
    final double w = c.maxWidth.isFinite ? c.maxWidth * 0.5 : 240;
    return BoxConstraints.tight(Size(w, 80));
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label:
          'constraintsTransform: (c) => BoxConstraints.tight(Size(c.maxWidth*0.5, 80))',
      subLabel:
          'Arbitrary remap — the child is forced to exactly half the parent width × 80 px.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Note(
            'A custom transform can ignore the incoming constraints entirely or remap '
            'them by any rule. Three rules to keep in mind:'
            '\n  1) The returned BoxConstraints must satisfy isNormalized.'
            '\n  2) The box itself is still sized by the parent constraints, NOT the '
            'transformed ones — only the child sees the rewritten box.'
            '\n  3) If the parent constraints can be infinite (e.g. inside a horizontal '
            'ScrollView), guard with isFinite checks to avoid tight(∞ , …).',
          ),
          const SizedBox(height: 8),
          // Live demo
          ConstraintsTransformBox(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.hardEdge,
            constraintsTransform: _halfWidthTight80,
            debugTransformType: 'half-width-tight-80',
            child: Container(
              color: Colors.pink.shade100,
              alignment: Alignment.center,
              child: const Text(
                'Forced to ½ × 80',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // The same transform within a narrower outer container — should remap.
          SizedBox(
            width: 220,
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              constraintsTransform: _halfWidthTight80,
              debugTransformType: 'half-width-tight-80 (220px parent)',
              child: Container(
                color: Colors.pink.shade50,
                alignment: Alignment.center,
                child: const Text('parent 220 → child 110 × 80'),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _Note(
            'Compare both outputs: the inner box width tracks the parent. This is exactly '
            'what makes ConstraintsTransformBox a great primitive for derived layouts — '
            'every time the parent reflows, the transform runs again.',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 7 — ScrollView-friendly child
// ===========================================================================
class _ScrollFriendlySection extends StatelessWidget {
  const _ScrollFriendlySection();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label: 'Wrap a Row in a horizontal SingleChildScrollView',
      subLabel:
          'Common real-world use: tag bar, breadcrumbs, kanban swimlane.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Note(
            'A horizontal SingleChildScrollView gives its child unbounded width — perfect '
            'for a long Row that should be scrollable. But sometimes the child is itself '
            'a ListView or another scrolling widget that needs unbounded width too. '
            'ConstraintsTransformBox(widthUnconstrained) is a convenient adapter.',
          ),
          const SizedBox(height: 8),
          // Direct use: horizontal scroller of tags.
          SizedBox(
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstraintsTransformBox(
                alignment: Alignment.centerLeft,
                constraintsTransform: ConstraintsTransformBox.widthUnconstrained,
                debugTransformType: 'scroll/widthUnconstrained',
                child: const _TagRow(count: 12, width: 90, height: 44),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Nested example: ListView.builder horizontally.
          const Text(
            'Nested example: a horizontal ListView.builder forced unbounded width:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 60,
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              constraintsTransform: (c) => BoxConstraints(
                minWidth: 0,
                maxWidth: 1200,
                minHeight: c.minHeight,
                maxHeight: c.maxHeight,
              ),
              debugTransformType: 'scroll/clamp-1200',
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: 96,
                itemCount: 24,
                itemBuilder: (BuildContext ctx, int i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Colors.primaries[i % Colors.primaries.length].shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text('item $i'),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _Note(
            'Notice the second example clamps maxWidth to 1200 instead of using ∞: a '
            'ListView happily takes finite, large constraints and renders only the items '
            'that fit. Using a real ∞ here would require a viewport with unbounded width '
            'too, which would defeat the inner clip.',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 8 — clipBehavior gallery
// ===========================================================================
class _ClipBehaviorGallery extends StatelessWidget {
  const _ClipBehaviorGallery();

  @override
  Widget build(BuildContext context) {
    // NOTE: Clip.none is intentionally omitted here. With an oversized child,
    // Clip.none triggers a `RenderConstraintsTransformBox overflowed …`
    // assertion in debug builds — useful in production diagnostics, noisy in
    // a gallery. Section 9 (Comparison) shows the overflow case explicitly
    // with `Clip.hardEdge` for clean rendering.
    final List<Clip> clips = <Clip>[
      Clip.hardEdge,
      Clip.antiAlias,
      Clip.antiAliasWithSaveLayer,
    ];
    return _DemoCard(
      label: 'clipBehavior — three clipping flavours',
      subLabel:
          'Same overflowing child, three Clip values. Watch the corners. '
          'Clip.none is omitted because it would assert in debug.',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          for (final Clip c in clips)
            _ClipBehaviorTile(clipBehavior: c, label: c.toString()),
        ],
      ),
    );
  }
}

class _ClipBehaviorTile extends StatelessWidget {
  const _ClipBehaviorTile({required this.clipBehavior, required this.label});

  final Clip clipBehavior;
  final String label;

  @override
  Widget build(BuildContext context) {
    // We use a circular mask to make antiAlias visibly different from hardEdge.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 140,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple.shade400),
            borderRadius: BorderRadius.circular(60),
            color: Colors.deepPurple.shade50,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: clipBehavior,
              constraintsTransform:
                  ConstraintsTransformBox.widthUnconstrained,
              debugTransformType: 'clip:$label',
              child: const _TagRow(count: 6, width: 80, height: 50),
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 140,
          child: Text(
            label.replaceFirst('Clip.', ''),
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// Section 9 — Comparison
// ===========================================================================
class _ComparisonSection extends StatelessWidget {
  const _ComparisonSection();

  @override
  Widget build(BuildContext context) {
    // The shared "child" is intrinsically larger than the 200×100 cell.
    Widget child() {
      return Container(
        width: 320,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.lightGreen.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          '320×80 child',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    return _DemoCard(
      label: 'Same 320×80 child laid out three different ways',
      subLabel:
          'Each cell is 200×100. The child wants to be wider — see who wins.',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          _ComparisonCard(
            title: 'ConstraintsTransformBox',
            subtitle: 'widthUnconstrained + clip',
            cellWidth: 200,
            cellHeight: 100,
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              constraintsTransform: ConstraintsTransformBox.widthUnconstrained,
              debugTransformType: 'cmp/CTB',
              child: child(),
            ),
            note:
                'Box itself is still 200 wide; child renders at 320 and is clipped on the '
                'right. Best when you control alignment and want a precise rectangle.',
          ),
          _ComparisonCard(
            title: 'OverflowBox',
            subtitle: 'maxWidth ∞, alignment.left',
            cellWidth: 200,
            cellHeight: 100,
            child: OverflowBox(
              maxWidth: double.infinity,
              alignment: Alignment.centerLeft,
              child: child(),
            ),
            note:
                'OverflowBox can let the child overflow with alignment, but it does not '
                'clip on its own — the parent must. Cannot run a custom transform '
                'function.',
          ),
          _ComparisonCard(
            title: 'UnconstrainedBox',
            subtitle: 'lets BOTH the child and the box grow',
            cellWidth: 200,
            cellHeight: 100,
            child: UnconstrainedBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              child: child(),
            ),
            note:
                'UnconstrainedBox is the closest analog: drops constraints AND grows the '
                'box to fit the child unless wrapped (here, in a 200×100 SizedBox the box '
                'is forced back to 200, but in the wild it would expand).',
          ),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.title,
    required this.subtitle,
    required this.cellWidth,
    required this.cellHeight,
    required this.child,
    required this.note,
  });

  final String title;
  final String subtitle;
  final double cellWidth;
  final double cellHeight;
  final Widget child;
  final String note;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRect(
              child: SizedBox(
                width: cellWidth,
                height: cellHeight,
                child: child,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: const TextStyle(fontSize: 12, height: 1.3),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 10 — Pitfalls
// ===========================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  // Non-deterministic transform from previous frame (illustrative — kept stable
  // here so analyze stays clean).
  static int _frame = 0;
  static BoxConstraints _drift(BoxConstraints c) {
    _frame++;
    final double w = c.maxWidth.isFinite
        ? c.maxWidth * (0.4 + 0.05 * (_frame % 3))
        : 200;
    return BoxConstraints.tight(Size(w, 60));
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label: 'Five pitfalls to keep in mind',
      child: Column(
        children: <Widget>[
          _PitfallCard(
            number: 1,
            title: 'Unbounded constraints + Flex children = exception',
            body:
                'Wrapping a Row or Column whose children include Expanded/Flexible inside '
                'an unbounded ConstraintsTransformBox will throw at layout time: a Flex '
                'cannot resolve flex factors when its main-axis is ∞. Use IntrinsicWidth, '
                'mainAxisSize: MainAxisSize.min, or non-flex children inside.',
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              constraintsTransform:
                  ConstraintsTransformBox.widthUnconstrained,
              debugTransformType: 'pitfall1/safe',
              // Safe: mainAxisSize.min + non-flex children.
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _SizedTag(label: 'OK 1', width: 60, height: 32),
                  SizedBox(width: 6),
                  _SizedTag(
                    label: 'OK 2',
                    width: 60,
                    height: 32,
                    color: Colors.lightGreen,
                  ),
                ],
              ),
            ),
          ),
          _PitfallCard(
            number: 2,
            title: 'Clipping is not free',
            body:
                'Clip.antiAliasWithSaveLayer requires a save-layer per frame. Under heavy '
                'compositor pressure (e.g. an animated overflow) prefer Clip.hardEdge or '
                'use a static ClipRect higher in the tree so the layer is cached.',
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              constraintsTransform:
                  ConstraintsTransformBox.widthUnconstrained,
              debugTransformType: 'pitfall2',
              child: const _TagRow(count: 5, width: 80, height: 36),
            ),
          ),
          _PitfallCard(
            number: 3,
            title: 'There is no `ConstraintsTransformBox.unconstrained()` ctor',
            body:
                '`unconstrained` is a *static method* (a BoxConstraintsTransform). You '
                'pass it to the constraintsTransform parameter; you do not invoke it as a '
                'named constructor. The same applies to widthUnconstrained, '
                'heightUnconstrained, maxWidthUnconstrained, maxHeightUnconstrained and '
                'maxUnconstrained.',
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              constraintsTransform: ConstraintsTransformBox.unconstrained,
              debugTransformType: 'pitfall3',
              child: const Text(
                'static-method form, not a named ctor',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          _PitfallCard(
            number: 4,
            title: 'Use debugPaintSizeEnabled / debugTransformType',
            body:
                'Pass a meaningful debugTransformType when you create a custom transform. '
                'It lights up in the inspector and in error logs as "ConstraintsTransform '
                '<your label>". Combined with debugPaintSizeEnabled, finding overflow '
                'culprits becomes trivial.',
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              constraintsTransform: (BoxConstraints c) => c.loosen(),
              debugTransformType: 'my-loosen-label',
              child: const _SizedTag(
                label: 'inspect me',
                width: 120,
                height: 36,
                color: Color(0xFFB39DDB),
              ),
            ),
          ),
          _PitfallCard(
            number: 5,
            title: 'Layout thrash if constraintsTransform is non-deterministic',
            body:
                'The transform must be a pure function of the incoming BoxConstraints. '
                'If it depends on time, frame counters, or external state, the framework '
                'cannot cache layout reliably and you may relayout every frame. The '
                '_drift transform above (kept inert in this build) is exactly the kind of '
                'thing to avoid — it returns a different size depending on call count.',
            child: ConstraintsTransformBox(
              alignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              constraintsTransform: _drift,
              debugTransformType: 'pitfall5/drift',
              child: const _SizedTag(
                label: 'don\'t do this',
                width: 220,
                height: 60,
                color: Color(0xFFFF8A80),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.body,
    required this.child,
  });

  final int number;
  final String title;
  final String body;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 13, height: 1.3)),
          const SizedBox(height: 8),
          ClipRect(
            child: SizedBox(
              height: 60,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 11 — Recipe gallery
// ===========================================================================
class _RecipeGallery extends StatelessWidget {
  const _RecipeGallery();

  static BoxConstraints _aspectTile(BoxConstraints c) {
    final double w = c.maxWidth.isFinite ? c.maxWidth : 240;
    return BoxConstraints.tight(Size(w, w / 2)); // 2:1 aspect.
  }

  static BoxConstraints _dropMin(BoxConstraints c) {
    return BoxConstraints(
      minWidth: 0,
      maxWidth: c.maxWidth,
      minHeight: 0,
      maxHeight: c.maxHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      label: 'Four recipes you can copy/paste',
      child: Column(
        children: <Widget>[
          _RecipeCard(
            number: 1,
            title: 'Horizontal overflow row',
            description:
                'A scrollable Row of buttons forced to its intrinsic width.',
            child: SizedBox(
              height: 56,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstraintsTransformBox(
                  alignment: Alignment.centerLeft,
                  constraintsTransform:
                      ConstraintsTransformBox.widthUnconstrained,
                  debugTransformType: 'recipe1',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      for (int i = 0; i < 10; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Action ${i + 1}'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _RecipeCard(
            number: 2,
            title: 'Intrinsic-width chip group',
            description:
                'A chip group that always sizes to its natural width even when the '
                'parent slot is narrower (then clips).',
            child: SizedBox(
              width: 240,
              height: 48,
              child: ConstraintsTransformBox(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.hardEdge,
                constraintsTransform:
                    ConstraintsTransformBox.widthUnconstrained,
                debugTransformType: 'recipe2',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Chip(label: Text('alpha')),
                    SizedBox(width: 6),
                    Chip(label: Text('beta')),
                    SizedBox(width: 6),
                    Chip(label: Text('gamma')),
                    SizedBox(width: 6),
                    Chip(label: Text('delta')),
                    SizedBox(width: 6),
                    Chip(label: Text('epsilon')),
                  ],
                ),
              ),
            ),
          ),
          _RecipeCard(
            number: 3,
            title: 'Fixed-aspect tile',
            description:
                'A tile that is always 2:1 regardless of incoming height.',
            child: SizedBox(
              height: 120,
              child: ConstraintsTransformBox(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                constraintsTransform: _aspectTile,
                debugTransformType: 'recipe3',
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text('2 : 1'),
                ),
              ),
            ),
          ),
          _RecipeCard(
            number: 4,
            title: 'Drop-min for tooltip-style content',
            description:
                'A tooltip should be at most as wide as the parent, but smaller if the '
                'content is short. Drop the minimums and let the child decide.',
            child: SizedBox(
              width: 320,
              child: ConstraintsTransformBox(
                alignment: Alignment.centerLeft,
                constraintsTransform: _dropMin,
                debugTransformType: 'recipe4',
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'short tooltip',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.number,
    required this.title,
    required this.description,
    required this.child,
  });

  final int number;
  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(description, style: const TextStyle(fontSize: 13, height: 1.3)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 12 — Reference table
// ===========================================================================
class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  @override
  Widget build(BuildContext context) {
    final List<_RefRow> rows = <_RefRow>[
      _RefRow(
        symbol: 'ConstraintsTransformBox',
        kind: 'Widget',
        signature: 'constraintsTransform, alignment, clipBehavior, child',
        notes:
            'General-purpose constraint rewriter. Box itself is sized by parent '
            'constraints; child sees the transformed ones.',
      ),
      _RefRow(
        symbol: 'OverflowBox',
        kind: 'Widget',
        signature: 'minWidth/maxWidth/minHeight/maxHeight, alignment, child',
        notes:
            'Lets the child overflow without affecting the parent. No custom transform '
            'function and no clipBehavior.',
      ),
      _RefRow(
        symbol: 'UnconstrainedBox',
        kind: 'Widget',
        signature: 'constrainedAxis, alignment, clipBehavior, child',
        notes:
            'Removes constraints AND lets the box grow to fit the child. Convenience '
            'for the common drop-everything case.',
      ),
      _RefRow(
        symbol: 'SizedOverflowBox',
        kind: 'Widget',
        signature: 'size, alignment, child',
        notes:
            'Pretends to be exactly `size` while letting the child overflow. Cheaper '
            'than ConstraintsTransformBox when you know the rectangle.',
      ),
      _RefRow(
        symbol: 'ConstraintsTransformBox.unmodified',
        kind: 'Static fn',
        signature: '(BoxConstraints c) => c',
        notes: 'Identity. The widget becomes a no-op proxy.',
      ),
      _RefRow(
        symbol: 'ConstraintsTransformBox.unconstrained',
        kind: 'Static fn',
        signature: '(_) => const BoxConstraints()',
        notes:
            'Drops everything. Equivalent to UnconstrainedBox(constrainedAxis: null) '
            'except the box does not grow.',
      ),
      _RefRow(
        symbol: 'ConstraintsTransformBox.widthUnconstrained',
        kind: 'Static fn',
        signature: '(c) => c.heightConstraints()',
        notes: 'Drops width constraints; height pass-through.',
      ),
      _RefRow(
        symbol: 'ConstraintsTransformBox.heightUnconstrained',
        kind: 'Static fn',
        signature: '(c) => c.widthConstraints()',
        notes: 'Drops height constraints; width pass-through.',
      ),
      _RefRow(
        symbol: 'ConstraintsTransformBox.maxWidthUnconstrained',
        kind: 'Static fn',
        signature: '(c) => c.copyWith(maxWidth: ∞)',
        notes:
            'Keeps minWidth, drops only the maxWidth ceiling. Useful when parents '
            'force a non-zero minimum width.',
      ),
      _RefRow(
        symbol: 'ConstraintsTransformBox.maxHeightUnconstrained',
        kind: 'Static fn',
        signature: '(c) => c.copyWith(maxHeight: ∞)',
        notes: 'Symmetric counterpart for height.',
      ),
      _RefRow(
        symbol: 'ConstraintsTransformBox.maxUnconstrained',
        kind: 'Static fn',
        signature: '(c) => c.copyWith(maxWidth: ∞, maxHeight: ∞)',
        notes:
            'Lifts both maxima. Useful for IntrinsicWidth/Height-styled chip groups '
            'that must respect a parent minimum.',
      ),
      _RefRow(
        symbol: 'BoxConstraints.loosen',
        kind: 'Method',
        signature: '() → BoxConstraints',
        notes:
            'Returns BoxConstraints(maxWidth: this.maxWidth, maxHeight: this.maxHeight). '
            'Drops minimums, keeps maxima — child can be smaller.',
      ),
      _RefRow(
        symbol: 'BoxConstraints.tighten',
        kind: 'Method',
        signature: '({double? width, double? height}) → BoxConstraints',
        notes:
            'Forces a particular axis to a tight value (within current min/max). The '
            'opposite of loosen.',
      ),
      _RefRow(
        symbol: 'BoxConstraints.heightConstraints',
        kind: 'Method',
        signature: '() → BoxConstraints',
        notes:
            'Returns the *height* portion of constraints with width 0..∞ — exactly what '
            'widthUnconstrained returns.',
      ),
      _RefRow(
        symbol: 'BoxConstraints.widthConstraints',
        kind: 'Method',
        signature: '() → BoxConstraints',
        notes:
            'Returns the *width* portion of constraints with height 0..∞ — exactly what '
            'heightUnconstrained returns.',
      ),
      _RefRow(
        symbol: 'BoxConstraints.tight',
        kind: 'Constructor',
        signature: 'BoxConstraints.tight(Size size)',
        notes:
            'Forces both axes to a fixed size. Common return value of custom '
            'constraintsTransform functions.',
      ),
      _RefRow(
        symbol: 'Clip.none',
        kind: 'Enum',
        signature: 'no clipping; debug paint shows overflow',
        notes:
            'Cheapest but reveals errors visually. Use when you can prove the child '
            'fits.',
      ),
      _RefRow(
        symbol: 'Clip.hardEdge',
        kind: 'Enum',
        signature: 'rectangular clip; aliased',
        notes: 'Default sensible choice when overflow is expected.',
      ),
      _RefRow(
        symbol: 'Clip.antiAlias',
        kind: 'Enum',
        signature: 'antialiased clip; smoother corners',
        notes: 'Use with rounded shapes; slightly more expensive than hardEdge.',
      ),
      _RefRow(
        symbol: 'Clip.antiAliasWithSaveLayer',
        kind: 'Enum',
        signature: 'antiAlias + a saveLayer',
        notes:
            'Most expensive option. Required for blending tricks (BlendMode etc.). '
            'Avoid in animated trees.',
      ),
    ];

    return _DemoCard(
      label: 'Quick reference',
      subLabel:
          'Symbols you will reach for around ConstraintsTransformBox.',
      child: Column(
        children: <Widget>[
          _RefHeader(),
          for (final _RefRow r in rows) r,
        ],
      ),
    );
  }
}

class _RefHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo.shade100,
        border: Border(bottom: BorderSide(color: Colors.indigo.shade300)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: const Row(
        children: <Widget>[
          SizedBox(
            width: 220,
            child: Text(
              'Symbol',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              'Kind',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              'Signature / behaviour',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefRow extends StatelessWidget {
  const _RefRow({
    required this.symbol,
    required this.kind,
    required this.signature,
    required this.notes,
  });

  final String symbol;
  final String kind;
  final String signature;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220,
            child: Text(
              symbol,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              kind,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  signature,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notes,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// (End of file)  — every demo above uses ConstraintsTransformBox at least once.
// ===========================================================================
