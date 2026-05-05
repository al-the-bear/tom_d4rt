// Deep-demo Flutter test script for RenderConstraintsTransformBox /
// ConstraintsTransformBox. Stateless, single-file, returns a Scaffold.
//
// Subject summary:
//   ConstraintsTransformBox lets the parent transform the BoxConstraints
//   handed to its child, while the parent itself still reports a size based
//   on the original incoming constraints. The render-side partner is
//   RenderConstraintsTransformBox.
//
// This file exercises:
//   - Pre-defined transforms: unmodified, unconstrained, widthUnconstrained,
//     heightUnconstrained, maxWidthUnconstrained, maxHeightUnconstrained.
//   - Custom transforms (closure-based and constant-based).
//   - Alignment, clipBehavior, and a comparison vs OverflowBox /
//     UnconstrainedBox.
//   - Real-world usage patterns and caveats.

import 'package:flutter/material.dart';

// ----------------------------------------------------------------------------
// Palette and decoration tokens.
// ----------------------------------------------------------------------------

const Color kInkDeep = Color(0xFF0F172A);
const Color kInkMid = Color(0xFF1E293B);
const Color kInkSoft = Color(0xFF334155);
const Color kInkMuted = Color(0xFF475569);
const Color kPaperWarm = Color(0xFFFFF7ED);
const Color kPaperCool = Color(0xFFF1F5F9);
const Color kPaperMint = Color(0xFFECFDF5);
const Color kPaperLilac = Color(0xFFF5F3FF);
const Color kPaperRose = Color(0xFFFFF1F2);
const Color kPaperSky = Color(0xFFEFF6FF);

const Color kAccentTeal = Color(0xFF0D9488);
const Color kAccentAmber = Color(0xFFD97706);
const Color kAccentIndigo = Color(0xFF4F46E5);
const Color kAccentRose = Color(0xFFE11D48);
const Color kAccentEmerald = Color(0xFF059669);
const Color kAccentSky = Color(0xFF0284C7);
const Color kAccentViolet = Color(0xFF7C3AED);
const Color kAccentLime = Color(0xFF65A30D);
const Color kAccentCyan = Color(0xFF0891B2);
const Color kAccentFuchsia = Color(0xFFC026D3);

// ----------------------------------------------------------------------------
// Reusable static const transforms (these are the user-defined examples).
// ----------------------------------------------------------------------------

BoxConstraints kHalveMaxWidth(BoxConstraints input) {
  return BoxConstraints(
    minWidth: input.minWidth,
    maxWidth: input.hasBoundedWidth ? input.maxWidth / 2.0 : input.maxWidth,
    minHeight: input.minHeight,
    maxHeight: input.maxHeight,
  );
}

BoxConstraints kInflateBoth(BoxConstraints input) {
  final double mw = input.hasBoundedWidth ? input.maxWidth + 80.0 : 320.0;
  final double mh = input.hasBoundedHeight ? input.maxHeight + 60.0 : 260.0;
  return BoxConstraints(
    minWidth: input.minWidth,
    maxWidth: mw,
    minHeight: input.minHeight,
    maxHeight: mh,
  );
}

BoxConstraints kLooseShrunken(BoxConstraints input) {
  final double w = input.hasBoundedWidth ? input.maxWidth * 0.6 : 200.0;
  final double h = input.hasBoundedHeight ? input.maxHeight * 0.6 : 160.0;
  return BoxConstraints(maxWidth: w, maxHeight: h);
}

BoxConstraints kTightenToHalf(BoxConstraints input) {
  final double w = input.hasBoundedWidth ? input.maxWidth * 0.5 : 180.0;
  final double h = input.hasBoundedHeight ? input.maxHeight * 0.5 : 120.0;
  return BoxConstraints.tight(Size(w, h));
}

// ----------------------------------------------------------------------------
// Local data classes describing each catalog entry.
// ----------------------------------------------------------------------------

class _TransformInfo {
  const _TransformInfo({
    required this.name,
    required this.symbol,
    required this.headline,
    required this.body,
    required this.beforeText,
    required this.afterText,
    required this.accent,
    required this.paper,
    required this.icon,
  });

  final String name;
  final String symbol;
  final String headline;
  final String body;
  final String beforeText;
  final String afterText;
  final Color accent;
  final Color paper;
  final IconData icon;
}

class _AlignmentEntry {
  const _AlignmentEntry({
    required this.label,
    required this.alignment,
    required this.swatch,
  });

  final String label;
  final Alignment alignment;
  final Color swatch;
}

class _ClipEntry {
  const _ClipEntry({
    required this.label,
    required this.clip,
    required this.note,
    required this.accent,
  });

  final String label;
  final Clip clip;
  final String note;
  final Color accent;
}

class _RealWorldCase {
  const _RealWorldCase({
    required this.title,
    required this.scenario,
    required this.takeaway,
    required this.accent,
    required this.paper,
    required this.icon,
  });

  final String title;
  final String scenario;
  final String takeaway;
  final Color accent;
  final Color paper;
  final IconData icon;
}

class _CaveatEntry {
  const _CaveatEntry({
    required this.title,
    required this.detail,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String detail;
  final IconData icon;
  final Color accent;
}

class _Takeaway {
  const _Takeaway({
    required this.heading,
    required this.detail,
    required this.icon,
    required this.accent,
  });

  final String heading;
  final String detail;
  final IconData icon;
  final Color accent;
}

class _ComparisonEntry {
  const _ComparisonEntry({
    required this.title,
    required this.summary,
    required this.parentReports,
    required this.childMeasured,
    required this.accent,
    required this.paper,
  });

  final String title;
  final String summary;
  final String parentReports;
  final String childMeasured;
  final Color accent;
  final Color paper;
}

// ----------------------------------------------------------------------------
// Catalog data.
// ----------------------------------------------------------------------------

const List<_TransformInfo> _kCatalog = <_TransformInfo>[
  _TransformInfo(
    name: 'unmodified',
    symbol: 'ConstraintsTransformBox.unmodified',
    headline: 'Pass-through, parent constraints reach the child intact.',
    body:
        'Behaves like a SizedBox in shape: the child receives the same '
        'BoxConstraints the parent sent. Useful as a baseline value when a '
        'higher-order builder wants to swap transforms in and out without '
        'special-casing the no-op path.',
    beforeText: 'min(0,0)..max(W,H)',
    afterText: 'min(0,0)..max(W,H)',
    accent: kAccentSky,
    paper: kPaperSky,
    icon: Icons.swap_horiz,
  ),
  _TransformInfo(
    name: 'unconstrained',
    symbol: 'ConstraintsTransformBox.unconstrained',
    headline: 'Drops both axes: child sees infinite max width and height.',
    body:
        'Equivalent to UnconstrainedBox in spirit: the child is laid out as '
        'though the parent imposed no upper bounds. The wrapping box still '
        'sizes itself against the parent constraints, so anything that '
        'overflows must be clipped or accepted as visual overflow.',
    beforeText: 'min(0,0)..max(W,H)',
    afterText: 'min(0,0)..max(inf,inf)',
    accent: kAccentIndigo,
    paper: kPaperLilac,
    icon: Icons.open_in_full,
  ),
  _TransformInfo(
    name: 'widthUnconstrained',
    symbol: 'ConstraintsTransformBox.widthUnconstrained',
    headline: 'Removes only the horizontal upper bound.',
    body:
        'The vertical constraint is preserved while horizontal max becomes '
        'infinite. Common when laying out long inline content (a number, a '
        'name) that must keep its natural width without forcing the row to '
        'grow.',
    beforeText: 'min(0,0)..max(W,H)',
    afterText: 'min(0,0)..max(inf,H)',
    accent: kAccentTeal,
    paper: kPaperMint,
    icon: Icons.swap_horiz_outlined,
  ),
  _TransformInfo(
    name: 'heightUnconstrained',
    symbol: 'ConstraintsTransformBox.heightUnconstrained',
    headline: 'Removes only the vertical upper bound.',
    body:
        'Vertical max becomes infinite while horizontal stays bounded. Useful '
        'for wrapping multi-line text in a horizontally constrained band when '
        'the parent should keep its own height.',
    beforeText: 'min(0,0)..max(W,H)',
    afterText: 'min(0,0)..max(W,inf)',
    accent: kAccentEmerald,
    paper: kPaperMint,
    icon: Icons.swap_vert,
  ),
  _TransformInfo(
    name: 'maxHeightUnconstrained',
    symbol: 'ConstraintsTransformBox.maxHeightUnconstrained',
    headline: 'Like heightUnconstrained, named for the bound it lifts.',
    body:
        'Functionally identical to heightUnconstrained for the common case of '
        'parents that pass min == 0. Existing for symmetry with '
        'maxWidthUnconstrained, both of which target only the upper bound.',
    beforeText: 'min(0,0)..max(W,H)',
    afterText: 'min(0,0)..max(W,inf)',
    accent: kAccentAmber,
    paper: kPaperWarm,
    icon: Icons.height,
  ),
  _TransformInfo(
    name: 'maxWidthUnconstrained',
    symbol: 'ConstraintsTransformBox.maxWidthUnconstrained',
    headline: 'Like widthUnconstrained, named for the bound it lifts.',
    body:
        'Same intent as widthUnconstrained for the standard case where '
        'minWidth is zero. Reads more clearly when paired with a sibling '
        'that lifts maxHeight, signalling that only upper bounds are being '
        'changed.',
    beforeText: 'min(0,0)..max(W,H)',
    afterText: 'min(0,0)..max(inf,H)',
    accent: kAccentRose,
    paper: kPaperRose,
    icon: Icons.straighten,
  ),
];

const List<_AlignmentEntry> _kAlignmentEntries = <_AlignmentEntry>[
  _AlignmentEntry(
    label: 'topLeft',
    alignment: Alignment.topLeft,
    swatch: kAccentTeal,
  ),
  _AlignmentEntry(
    label: 'center',
    alignment: Alignment.center,
    swatch: kAccentIndigo,
  ),
  _AlignmentEntry(
    label: 'bottomRight',
    alignment: Alignment.bottomRight,
    swatch: kAccentRose,
  ),
  _AlignmentEntry(
    label: 'centerLeft',
    alignment: Alignment.centerLeft,
    swatch: kAccentAmber,
  ),
];

const List<_ClipEntry> _kClipEntries = <_ClipEntry>[
  _ClipEntry(
    label: 'Clip.none',
    clip: Clip.none,
    note: 'Child paints freely past the parent box. Best when overflow is '
        'expected and visually intentional (badges, tooltips).',
    accent: kAccentAmber,
  ),
  _ClipEntry(
    label: 'Clip.hardEdge',
    clip: Clip.hardEdge,
    note: 'Cheapest non-trivial clip. Crisp pixel edge, no antialiasing.',
    accent: kAccentTeal,
  ),
  _ClipEntry(
    label: 'Clip.antiAlias',
    clip: Clip.antiAlias,
    note: 'Smooth edge, slight cost. Use for circular/rounded clip surfaces '
        'where pixelated edges are objectionable.',
    accent: kAccentIndigo,
  ),
];

const List<_ComparisonEntry> _kComparisonEntries = <_ComparisonEntry>[
  _ComparisonEntry(
    title: 'OverflowBox',
    summary:
        'Imposes new explicit min/max on the child. Parent keeps original '
        'size; child paints inside or outside as it likes.',
    parentReports: 'Original parent size',
    childMeasured: 'Whatever fits inside the new explicit min/max',
    accent: kAccentRose,
    paper: kPaperRose,
  ),
  _ComparisonEntry(
    title: 'UnconstrainedBox',
    summary:
        'Drops both axes of the parent constraint, then sizes itself to the '
        'child (so the parent box grows to fit the child).',
    parentReports: 'Child size (parent grows)',
    childMeasured: 'Unbounded; child picks its own size',
    accent: kAccentIndigo,
    paper: kPaperLilac,
  ),
  _ComparisonEntry(
    title: 'ConstraintsTransformBox',
    summary:
        'Like UnconstrainedBox but keeps the parent reporting a size based '
        'on the parent constraints. Child uses the transformed constraints '
        'only for its own measurement.',
    parentReports: 'Original parent constraint',
    childMeasured: 'Whatever the transform yielded',
    accent: kAccentTeal,
    paper: kPaperMint,
  ),
];

const List<_RealWorldCase> _kRealWorldCases = <_RealWorldCase>[
  _RealWorldCase(
    title: 'Long label inside a fixed Row cell',
    scenario:
        'A toolbar Row contains a numeric label whose value can grow long. '
        'You want it to keep its natural width without forcing the row to '
        'expand and push siblings around. ConstraintsTransformBox.'
        'widthUnconstrained lets the Text measure its full intrinsic width '
        'while the surrounding cell remains fixed and can clip on overflow.',
    takeaway:
        'Stop layout shift in toolbars and dashboards when text length is '
        'unpredictable.',
    accent: kAccentTeal,
    paper: kPaperMint,
    icon: Icons.label_important_outline,
  ),
  _RealWorldCase(
    title: 'Container measured tall for shadow, reported short',
    scenario:
        'A card uses a soft drop shadow whose blur extends past its visual '
        'bounds. By measuring the child with extra height (custom transform '
        'inflating maxHeight) but keeping the parent layout slot small, the '
        'shadow is preserved without changing the layout footprint.',
    takeaway:
        'Decouple visual bleed from layout footprint without lying about '
        'sizes elsewhere in the tree.',
    accent: kAccentAmber,
    paper: kPaperWarm,
    icon: Icons.gradient_outlined,
  ),
  _RealWorldCase(
    title: 'Force-stretch child width, preserve parent layout',
    scenario:
        'Inside a tile that participates in the surrounding grid, you want '
        'the child to be measured against a wider constraint (e.g. for a '
        'horizontal track) while the tile itself stays inside its grid '
        'cell. A custom transform fixing a constant maxWidth on the child '
        'achieves this without touching the grid.',
    takeaway:
        'A child can always be measured against a different ruler than its '
        'parent uses for self-sizing.',
    accent: kAccentIndigo,
    paper: kPaperLilac,
    icon: Icons.aspect_ratio,
  ),
];

const List<_CaveatEntry> _kCaveats = <_CaveatEntry>[
  _CaveatEntry(
    title: 'RTL is alignment-relative',
    detail:
        'Pass a textDirection (or use AlignmentDirectional) so the child is '
        'positioned correctly under right-to-left layouts. Otherwise '
        'topLeft and topRight will behave the same in both directions.',
    icon: Icons.format_textdirection_r_to_l,
    accent: kAccentRose,
  ),
  _CaveatEntry(
    title: 'Infinite constraints are contagious',
    detail:
        'When you remove an upper bound, any child that sizes itself to '
        'fill (Expanded, Column with mainAxisSize.max, etc.) will explode. '
        'Always pair an unconstrained transform with a child that sizes '
        'intrinsically.',
    icon: Icons.all_inclusive,
    accent: kAccentAmber,
  ),
  _CaveatEntry(
    title: 'Performance: extra layout pass',
    detail:
        'Every constraints transform forces a layout against modified '
        'constraints. In tight scrolling lists, this can compound. Prefer '
        'simpler containers when the transform is not strictly necessary.',
    icon: Icons.speed,
    accent: kAccentIndigo,
  ),
  _CaveatEntry(
    title: 'Clip vs overflow indicator',
    detail:
        'Clip.hardEdge silently chops content; Clip.none surfaces it (and '
        'an overflow indicator in debug). Choose the one that matches your '
        'design intent and document it in code.',
    icon: Icons.crop_square,
    accent: kAccentTeal,
  ),
  _CaveatEntry(
    title: 'Not a SizedBox replacement',
    detail:
        'If you do not need the child to be measured against different '
        'constraints, do not reach for ConstraintsTransformBox. A SizedBox, '
        'ConstrainedBox, or LimitedBox is cheaper and clearer.',
    icon: Icons.warning_amber,
    accent: kAccentEmerald,
  ),
];

const List<_Takeaway> _kTakeaways = <_Takeaway>[
  _Takeaway(
    heading: 'Two distinct sizes in one widget',
    detail:
        'Parent reports its own size; child is measured against transformed '
        'constraints. Do not conflate the two.',
    icon: Icons.compare_arrows,
    accent: kAccentTeal,
  ),
  _Takeaway(
    heading: 'Built-ins cover the common cases',
    detail:
        'unmodified, unconstrained, widthUnconstrained, heightUnconstrained '
        '(plus the maxWidth/maxHeight aliases) handle most needs.',
    icon: Icons.dashboard_customize,
    accent: kAccentIndigo,
  ),
  _Takeaway(
    heading: 'Custom transforms are just functions',
    detail:
        'Any BoxConstraints -> BoxConstraints function works. Keep them '
        'pure, allocation-light, and named clearly.',
    icon: Icons.functions,
    accent: kAccentAmber,
  ),
  _Takeaway(
    heading: 'Pair with explicit clip and alignment',
    detail:
        'Always decide what happens at the edges. clipBehavior + alignment '
        'document intent and prevent surprises.',
    icon: Icons.view_in_ar,
    accent: kAccentRose,
  ),
];

// ----------------------------------------------------------------------------
// Top-level entry point.
// ----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kPaperCool,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHero(),
          const SizedBox(height: 36),
          _buildAnatomyDiagram(),
          const SizedBox(height: 36),
          _buildCatalog(),
          const SizedBox(height: 36),
          _buildLiveDemos(),
          const SizedBox(height: 36),
          _buildCustomTransform(),
          const SizedBox(height: 36),
          _buildAlignmentShowcase(),
          const SizedBox(height: 36),
          _buildClipBehaviorShowcase(),
          const SizedBox(height: 36),
          _buildComparisonPanel(),
          const SizedBox(height: 36),
          _buildRealWorldExamples(),
          const SizedBox(height: 36),
          _buildCaveats(),
          const SizedBox(height: 36),
          _buildFooter(),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// 1. Hero header: title strip with gradient + shadows.
// ----------------------------------------------------------------------------

Widget _buildHero() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1E293B),
          Color(0xFF0F766E),
          Color(0xFF4F46E5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkDeep.withValues(alpha: 0.32),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
        BoxShadow(
          color: kAccentIndigo.withValues(alpha: 0.22),
          blurRadius: 48,
          offset: const Offset(0, 24),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.32),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.transform,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(width: 24),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'RenderConstraintsTransformBox',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.4,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Transform the BoxConstraints handed to a child without '
                'changing how the parent itself reports its size.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFE2E8F0),
                  height: 1.45,
                ),
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _HeroChip(label: 'rendering'),
                  _HeroChip(label: 'layout'),
                  _HeroChip(label: 'overflow'),
                  _HeroChip(label: 'constraints'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.32),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 2. Anatomy diagram.
// ----------------------------------------------------------------------------

Widget _buildAnatomyDiagram() {
  return _Section(
    eyebrow: 'Section 02 / Anatomy',
    title: 'Constraint flow through the box',
    subtitle:
        'Incoming constraints are transformed for the child. The parent '
        'reports its own size from the original incoming constraints.',
    accent: kAccentTeal,
    paper: kPaperMint,
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInkDeep.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              _FlowBox(
                title: 'Parent',
                lines: <String>['BoxConstraints', 'incoming'],
                accent: kAccentSky,
              ),
              _FlowArrow(),
              _FlowBox(
                title: 'Transform',
                lines: <String>['fn(c) -> c\u2032', 'pure function'],
                accent: kAccentIndigo,
              ),
              _FlowArrow(),
              _FlowBox(
                title: 'Child',
                lines: <String>['receives c\u2032', 'measures itself'],
                accent: kAccentEmerald,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: kPaperCool,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.subdirectory_arrow_right,
                  color: kInkMuted,
                  size: 18,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Parent reports its own size from the ORIGINAL '
                    'incoming constraints, not from the child size. '
                    'That is what makes this widget different from '
                    'UnconstrainedBox.',
                    style: TextStyle(
                      color: kInkSoft,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: _AnatomyNote(
                  title: 'No layout side-effects',
                  body: 'The transform is a pure '
                      'BoxConstraints -> BoxConstraints function. It '
                      'does not read state, does not mutate, does not '
                      'allocate beyond the new constraints object.',
                  accent: kAccentTeal,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AnatomyNote(
                  title: 'Parent paints what it laid out',
                  body: 'If the child measured larger than the parent '
                      'box, the overflow is governed by clipBehavior and '
                      'alignment, never by the transform itself.',
                  accent: kAccentAmber,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _FlowBox extends StatelessWidget {
  const _FlowBox({
    required this.title,
    required this.lines,
    required this.accent,
  });

  final String title;
  final List<String> lines;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 96,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          border: Border.all(color: accent.withValues(alpha: 0.45)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 4),
            for (final String line in lines)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  line,
                  style: const TextStyle(
                    color: kInkMid,
                    fontSize: 12.5,
                    height: 1.3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.chevron_right,
        size: 28,
        color: kInkMuted,
      ),
    );
  }
}

class _AnatomyNote extends StatelessWidget {
  const _AnatomyNote({
    required this.title,
    required this.body,
    required this.accent,
  });

  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 3. Pre-defined transforms catalog.
// ----------------------------------------------------------------------------

Widget _buildCatalog() {
  return _Section(
    eyebrow: 'Section 03 / Catalog',
    title: 'Pre-defined BoxConstraintsTransform constants',
    subtitle:
        'The library ships ready-to-use transforms covering the common '
        'lift-the-bound shapes. Each card shows name, intent, and a '
        'before/after constraint diagram.',
    accent: kAccentIndigo,
    paper: kPaperLilac,
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        for (final _TransformInfo info in _kCatalog)
          SizedBox(
            width: 360,
            child: _CatalogCard(info: info),
          ),
      ],
    ),
  );
}

class _CatalogCard extends StatelessWidget {
  const _CatalogCard({required this.info});

  final _TransformInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: info.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: info.accent.withValues(alpha: 0.30)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: info.accent.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: info.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(info.icon, color: info.accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      info.name,
                      style: TextStyle(
                        color: info.accent,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      info.symbol,
                      style: const TextStyle(
                        color: kInkMuted,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            info.headline,
            style: const TextStyle(
              color: kInkMid,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            info.body,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          _BeforeAfterRow(
            before: info.beforeText,
            after: info.afterText,
            accent: info.accent,
          ),
        ],
      ),
    );
  }
}

class _BeforeAfterRow extends StatelessWidget {
  const _BeforeAfterRow({
    required this.before,
    required this.after,
    required this.accent,
  });

  final String before;
  final String after;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _MiniCons(
            label: 'before',
            text: before,
            accent: kInkMuted,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.arrow_forward, size: 16, color: accent),
        ),
        Expanded(
          child: _MiniCons(
            label: 'after',
            text: after,
            accent: accent,
          ),
        ),
      ],
    );
  }
}

class _MiniCons extends StatelessWidget {
  const _MiniCons({
    required this.label,
    required this.text,
    required this.accent,
  });

  final String label;
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(
              color: kInkMid,
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 4. Live demonstrations.
// ----------------------------------------------------------------------------

Widget _buildLiveDemos() {
  return _Section(
    eyebrow: 'Section 04 / Live',
    title: 'Live demonstrations of pre-defined transforms',
    subtitle:
        'A child whose intrinsic size exceeds the parent slot. Each tile '
        'wraps the same child in a different transform so you can see how '
        'the layout responds.',
    accent: kAccentEmerald,
    paper: kPaperMint,
    child: Wrap(
      spacing: 18,
      runSpacing: 18,
      children: <Widget>[
        _LiveDemoTile(
          label: 'unmodified',
          accent: kAccentSky,
          paper: kPaperSky,
          child: ConstraintsTransformBox(
            constraintsTransform: ConstraintsTransformBox.unmodified,
            clipBehavior: Clip.hardEdge,
            child: const _OverflowChild(text: 'Pass-through'),
          ),
        ),
        _LiveDemoTile(
          label: 'unconstrained',
          accent: kAccentIndigo,
          paper: kPaperLilac,
          child: ConstraintsTransformBox(
            constraintsTransform: ConstraintsTransformBox.unconstrained,
            clipBehavior: Clip.hardEdge,
            child: const _OverflowChild(text: 'Both axes free'),
          ),
        ),
        _LiveDemoTile(
          label: 'widthUnconstrained',
          accent: kAccentTeal,
          paper: kPaperMint,
          child: ConstraintsTransformBox(
            constraintsTransform:
                ConstraintsTransformBox.widthUnconstrained,
            clipBehavior: Clip.hardEdge,
            child: const _OverflowChild(text: 'Wide free axis'),
          ),
        ),
        _LiveDemoTile(
          label: 'heightUnconstrained',
          accent: kAccentEmerald,
          paper: kPaperMint,
          child: ConstraintsTransformBox(
            constraintsTransform:
                ConstraintsTransformBox.heightUnconstrained,
            clipBehavior: Clip.hardEdge,
            child: const _OverflowChild(text: 'Tall free axis'),
          ),
        ),
        _LiveDemoTile(
          label: 'maxWidthUnconstrained',
          accent: kAccentRose,
          paper: kPaperRose,
          child: ConstraintsTransformBox(
            constraintsTransform:
                ConstraintsTransformBox.maxWidthUnconstrained,
            clipBehavior: Clip.hardEdge,
            child: const _OverflowChild(text: 'Upper-w free'),
          ),
        ),
        _LiveDemoTile(
          label: 'maxHeightUnconstrained',
          accent: kAccentAmber,
          paper: kPaperWarm,
          child: ConstraintsTransformBox(
            constraintsTransform:
                ConstraintsTransformBox.maxHeightUnconstrained,
            clipBehavior: Clip.hardEdge,
            child: const _OverflowChild(text: 'Upper-h free'),
          ),
        ),
      ],
    ),
  );
}

class _LiveDemoTile extends StatelessWidget {
  const _LiveDemoTile({
    required this.label,
    required this.accent,
    required this.paper,
    required this.child,
  });

  final String label;
  final Color accent;
  final Color paper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: paper,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent.withValues(alpha: 0.40)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: accent.withValues(alpha: 0.10),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: accent,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 240,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent.withValues(alpha: 0.35)),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: child,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Parent slot 200 x 80; child intrinsic ~320 x 140.',
              style: TextStyle(
                color: kInkMuted,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverflowChild extends StatelessWidget {
  const _OverflowChild({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 140,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFF0F766E),
              Color(0xFF4F46E5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 5. Custom transform.
// ----------------------------------------------------------------------------

Widget _buildCustomTransform() {
  return _Section(
    eyebrow: 'Section 05 / Custom',
    title: 'User-defined transforms',
    subtitle:
        'Any pure BoxConstraints -> BoxConstraints function works. Below '
        'are three top-level functions and a live render of each.',
    accent: kAccentAmber,
    paper: kPaperWarm,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _CustomCard(
          name: 'kHalveMaxWidth',
          description:
              'Halves the maximum width while leaving height alone. Good '
              'for studying how tightly-packed children compress when the '
              'available horizontal track is reduced.',
          codeLines: const <String>[
            'BoxConstraints kHalveMaxWidth(BoxConstraints input) {',
            '  return BoxConstraints(',
            '    minWidth: input.minWidth,',
            '    maxWidth: input.hasBoundedWidth',
            '        ? input.maxWidth / 2.0 : input.maxWidth,',
            '    minHeight: input.minHeight,',
            '    maxHeight: input.maxHeight,',
            '  );',
            '}',
          ],
          accent: kAccentTeal,
          paper: kPaperMint,
          child: ConstraintsTransformBox(
            constraintsTransform: kHalveMaxWidth,
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            child: const _CustomChild(
              text: 'Half-width child',
              color: kAccentTeal,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _CustomCard(
          name: 'kInflateBoth',
          description:
              'Adds 80 px of width and 60 px of height to the upper bounds. '
              'Useful for letting the child measure with extra room (e.g. '
              'shadow margins) while the surrounding layout slot stays put.',
          codeLines: const <String>[
            'BoxConstraints kInflateBoth(BoxConstraints input) {',
            '  final double mw = input.hasBoundedWidth',
            '      ? input.maxWidth + 80.0 : 320.0;',
            '  final double mh = input.hasBoundedHeight',
            '      ? input.maxHeight + 60.0 : 260.0;',
            '  return BoxConstraints(',
            '    minWidth: input.minWidth, maxWidth: mw,',
            '    minHeight: input.minHeight, maxHeight: mh,',
            '  );',
            '}',
          ],
          accent: kAccentIndigo,
          paper: kPaperLilac,
          child: ConstraintsTransformBox(
            constraintsTransform: kInflateBoth,
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            child: const _CustomChild(
              text: 'Inflated child',
              color: kAccentIndigo,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _CustomCard(
          name: 'kTightenToHalf',
          description:
              'Forces tight constraints at half the parent dimensions. The '
              'child must adopt that exact size; everything responsive '
              'inside it has to fit.',
          codeLines: const <String>[
            'BoxConstraints kTightenToHalf(BoxConstraints input) {',
            '  final double w = input.hasBoundedWidth',
            '      ? input.maxWidth * 0.5 : 180.0;',
            '  final double h = input.hasBoundedHeight',
            '      ? input.maxHeight * 0.5 : 120.0;',
            '  return BoxConstraints.tight(Size(w, h));',
            '}',
          ],
          accent: kAccentRose,
          paper: kPaperRose,
          child: ConstraintsTransformBox(
            constraintsTransform: kTightenToHalf,
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            child: const _CustomChild(
              text: 'Tightened child',
              color: kAccentRose,
            ),
          ),
        ),
      ],
    ),
  );
}

class _CustomCard extends StatelessWidget {
  const _CustomCard({
    required this.name,
    required this.description,
    required this.codeLines,
    required this.accent,
    required this.paper,
    required this.child,
  });

  final String name;
  final String description;
  final List<String> codeLines;
  final Color accent;
  final Color paper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.40)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    color: accent,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: kInkMid,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kInkDeep,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (final String line in codeLines)
                        Text(
                          line,
                          style: const TextStyle(
                            color: Color(0xFFE2E8F0),
                            fontSize: 11.5,
                            fontFamily: 'monospace',
                            height: 1.5,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            flex: 2,
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accent.withValues(alpha: 0.35)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomChild extends StatelessWidget {
  const _CustomChild({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 6. Alignment showcase.
// ----------------------------------------------------------------------------

Widget _buildAlignmentShowcase() {
  return _Section(
    eyebrow: 'Section 06 / Alignment',
    title: 'How alignment positions an oversized child',
    subtitle:
        'The same custom transform (kHalveMaxWidth) and the same child are '
        'shown four times with different alignment values, demonstrating '
        'how the child anchors when it exceeds the parent slot.',
    accent: kAccentSky,
    paper: kPaperSky,
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        for (final _AlignmentEntry entry in _kAlignmentEntries)
          SizedBox(
            width: 260,
            child: _AlignmentTile(entry: entry),
          ),
      ],
    ),
  );
}

class _AlignmentTile extends StatelessWidget {
  const _AlignmentTile({required this.entry});

  final _AlignmentEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: entry.swatch.withValues(alpha: 0.40)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: entry.swatch.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.center_focus_strong,
                  color: entry.swatch, size: 16),
              const SizedBox(width: 6),
              Text(
                entry.label,
                style: TextStyle(
                  color: entry.swatch,
                  fontSize: 13,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: 220,
            height: 130,
            decoration: BoxDecoration(
              color: kPaperCool,
              border: Border.all(color: entry.swatch.withValues(alpha: 0.30)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: ConstraintsTransformBox(
                constraintsTransform: kHalveMaxWidth,
                alignment: entry.alignment,
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: 180,
                  height: 100,
                  decoration: BoxDecoration(
                    color: entry.swatch.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    entry.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
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
}

// ----------------------------------------------------------------------------
// 7. clipBehavior showcase.
// ----------------------------------------------------------------------------

Widget _buildClipBehaviorShowcase() {
  return _Section(
    eyebrow: 'Section 07 / Clip',
    title: 'clipBehavior in three flavors',
    subtitle:
        'Same overflow scenario shown three times: no clipping, hard edge, '
        'and antialiased. Notice how Clip.none lets the child paint past '
        'the parent box.',
    accent: kAccentViolet,
    paper: kPaperLilac,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < _kClipEntries.length; i++) ...<Widget>[
          if (i != 0) const SizedBox(width: 16),
          Expanded(child: _ClipPanel(entry: _kClipEntries[i])),
        ],
      ],
    ),
  );
}

class _ClipPanel extends StatelessWidget {
  const _ClipPanel({required this.entry});

  final _ClipEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: entry.accent.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 24,
                decoration: BoxDecoration(
                  color: entry.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                entry.label,
                style: TextStyle(
                  color: entry.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: kPaperCool,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: entry.accent.withValues(alpha: 0.25)),
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: 160,
              height: 80,
              child: ConstraintsTransformBox(
                constraintsTransform: ConstraintsTransformBox.unconstrained,
                clipBehavior: entry.clip,
                alignment: Alignment.center,
                child: Container(
                  width: 220,
                  height: 110,
                  decoration: BoxDecoration(
                    color: entry.accent.withValues(alpha: 0.80),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: entry.accent, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'oversized child',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            entry.note,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 8. Comparison panel.
// ----------------------------------------------------------------------------

Widget _buildComparisonPanel() {
  return _Section(
    eyebrow: 'Section 08 / Compare',
    title: 'OverflowBox vs UnconstrainedBox vs ConstraintsTransformBox',
    subtitle:
        'Same content, same parent constraint. Each card calls out who '
        'reports what size, and how the child is measured.',
    accent: kAccentFuchsia,
    paper: kPaperLilac,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < _kComparisonEntries.length; i++) ...<Widget>[
          if (i != 0) const SizedBox(width: 14),
          Expanded(child: _ComparisonCard(entry: _kComparisonEntries[i])),
        ],
      ],
    ),
  );
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({required this.entry});

  final _ComparisonEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: entry.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: entry.accent.withValues(alpha: 0.40)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: entry.accent.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: entry.accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              entry.title,
              style: TextStyle(
                color: entry.accent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            entry.summary,
            style: const TextStyle(
              color: kInkMid,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          _CompareRow(label: 'parent reports', value: entry.parentReports),
          const SizedBox(height: 6),
          _CompareRow(label: 'child measured', value: entry.childMeasured),
          const SizedBox(height: 12),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: entry.accent.withValues(alpha: 0.30)),
            ),
            alignment: Alignment.center,
            child: _ComparisonInline(title: entry.title, accent: entry.accent),
          ),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: kInkMuted,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: kInkMid,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _ComparisonInline extends StatelessWidget {
  const _ComparisonInline({required this.title, required this.accent});

  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    if (title == 'OverflowBox') {
      return ClipRect(
        child: SizedBox(
          width: 120,
          height: 60,
          child: OverflowBox(
            minWidth: 0,
            maxWidth: 200,
            minHeight: 0,
            maxHeight: 100,
            alignment: Alignment.center,
            child: Container(
              width: 160,
              height: 80,
              color: accent.withValues(alpha: 0.85),
              alignment: Alignment.center,
              child: const Text('OverflowBox',
                  style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
        ),
      );
    } else if (title == 'UnconstrainedBox') {
      return ClipRect(
        child: SizedBox(
          width: 120,
          height: 60,
          child: UnconstrainedBox(
            clipBehavior: Clip.hardEdge,
            child: Container(
              width: 160,
              height: 80,
              color: accent.withValues(alpha: 0.85),
              alignment: Alignment.center,
              child: const Text('UnconstrainedBox',
                  style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
        ),
      );
    }
    return ClipRect(
      child: SizedBox(
        width: 120,
        height: 60,
        child: ConstraintsTransformBox(
          constraintsTransform: ConstraintsTransformBox.unconstrained,
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: 160,
            height: 80,
            color: accent.withValues(alpha: 0.85),
            alignment: Alignment.center,
            child: const Text('CTB',
                style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 9. Real-world examples.
// ----------------------------------------------------------------------------

Widget _buildRealWorldExamples() {
  return _Section(
    eyebrow: 'Section 09 / Real World',
    title: 'Where this widget actually pays off',
    subtitle:
        'Three concrete patterns that are clearer with '
        'ConstraintsTransformBox than with the alternatives.',
    accent: kAccentEmerald,
    paper: kPaperMint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (int i = 0; i < _kRealWorldCases.length; i++) ...<Widget>[
          if (i != 0) const SizedBox(height: 14),
          _RealWorldRow(entry: _kRealWorldCases[i], index: i),
        ],
      ],
    ),
  );
}

class _RealWorldRow extends StatelessWidget {
  const _RealWorldRow({required this.entry, required this.index});

  final _RealWorldCase entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: entry.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: entry.accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: entry.accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(entry.icon, color: entry.accent, size: 24),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Pattern ${index + 1}',
                      style: TextStyle(
                        color: entry.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: entry.accent.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        entry.title,
                        style: const TextStyle(
                          color: kInkDeep,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  entry.scenario,
                  style: const TextStyle(
                    color: kInkSoft,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: entry.accent.withValues(alpha: 0.40)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.lightbulb_outline,
                          size: 14, color: entry.accent),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          entry.takeaway,
                          style: TextStyle(
                            color: entry.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 10. Caveats.
// ----------------------------------------------------------------------------

Widget _buildCaveats() {
  return _Section(
    eyebrow: 'Section 10 / Caveats',
    title: 'Things to watch for',
    subtitle:
        'Constraints transforms are powerful but easy to misuse. Keep '
        'these in mind when deciding whether to reach for the widget.',
    accent: kAccentRose,
    paper: kPaperRose,
    child: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        for (final _CaveatEntry caveat in _kCaveats)
          SizedBox(
            width: 360,
            child: _CaveatCard(entry: caveat),
          ),
      ],
    ),
  );
}

class _CaveatCard extends StatelessWidget {
  const _CaveatCard({required this.entry});

  final _CaveatEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: entry.accent.withValues(alpha: 0.40)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: entry.accent.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: entry.accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(entry.icon, color: entry.accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.title,
                  style: TextStyle(
                    color: entry.accent,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  entry.detail,
                  style: const TextStyle(
                    color: kInkSoft,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 11. Footer takeaways.
// ----------------------------------------------------------------------------

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkDeep.withValues(alpha: 0.30),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flag_outlined,
                color: Colors.white.withValues(alpha: 0.9), size: 20),
            const SizedBox(width: 10),
            const Text(
              'Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            for (final _Takeaway takeaway in _kTakeaways)
              SizedBox(
                width: 320,
                child: _TakeawayCard(entry: takeaway),
              ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline,
                  color: Colors.white.withValues(alpha: 0.85), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'ConstraintsTransformBox is the small surgical tool: '
                  'use it when you specifically need to give a child a '
                  'different ruler than the parent uses for itself.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TakeawayCard extends StatelessWidget {
  const _TakeawayCard({required this.entry});

  final _Takeaway entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: entry.accent.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: entry.accent.withValues(alpha: 0.45)),
            ),
            child: Icon(entry.icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.heading,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.detail,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
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
}

// ----------------------------------------------------------------------------
// Reusable section wrapper.
// ----------------------------------------------------------------------------

class _Section extends StatelessWidget {
  const _Section({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.paper,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Color accent;
  final Color paper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            eyebrow,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: kInkDeep,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
