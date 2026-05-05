// Deep-demo Flutter test script for RenderFollowerLayer / FollowerLayer.
// Stateless, single-file, returns a Scaffold inside a SingleChildScrollView.
//
// Subject summary:
//   RenderFollowerLayer is the render object behind CompositedTransformFollower.
//   It composites its subtree at a position derived from a LayerLink that
//   refers to a RenderLeaderLayer (CompositedTransformTarget). The follower
//   sees the leader's transform during paint, applies a targetAnchor on the
//   leader rect, a followerAnchor on the follower rect, plus an offset, and
//   produces a FollowerLayer that captures the resulting transform. When the
//   leader is not in the layer tree, showWhenUnlinked decides whether the
//   follower draws at unlinkedOffset or not at all.
//
// This file exercises:
//   - The conceptual triangle: LayerLink, LeaderLayer, FollowerLayer.
//   - Live anchored panels (dropdown below / above / right of an anchor).
//   - A floating tooltip-with-arrow attached to a target.
//   - A 3x3 anchor matrix sweeping (targetAnchor x followerAnchor).
//   - Five offset variations against the same anchor pair.
//   - showWhenUnlinked: linked card vs detached-link card.
//   - The public API surface as a code block.
//   - Overlay / OverlayEntry vs CompositedTransformFollower comparison.
//   - Real-world patterns: autocomplete dropdown, anchored popover menu,
//     avatar badge follower, chart point tooltip.
//   - Caveats and a closing takeaway strip.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Cached LayerLink instances. LayerLink is not const-constructible; cache the
// links once at top level so repeated builds reuse them and the leader/
// follower pair stays connected across rebuilds.
// ---------------------------------------------------------------------------

final LayerLink kDropdownBelowLink = LayerLink();
final LayerLink kDropdownAboveLink = LayerLink();
final LayerLink kDropdownRightLink = LayerLink();
final LayerLink kTooltipLink = LayerLink();
final LayerLink kAutocompleteLink = LayerLink();
final LayerLink kPopoverLink = LayerLink();
final LayerLink kAvatarBadgeLink = LayerLink();
final LayerLink kChartPointLink = LayerLink();
final LayerLink kLinkedCardLink = LayerLink();
final LayerLink kDetachedFollowerLink = LayerLink();
final LayerLink kOffsetShowcaseLink = LayerLink();
final LayerLink kAnchorMatrixSharedLink = LayerLink();

// ---------------------------------------------------------------------------
// Palette tokens — indigo / purple / violet accent family.
// ---------------------------------------------------------------------------

const Color kInkDeep = Color(0xFF1E1B4B);
const Color kInkMid = Color(0xFF312E81);
const Color kInkSoft = Color(0xFF3730A3);
const Color kInkMuted = Color(0xFF4338CA);

const Color kPaperBase = Color(0xFFF5F3FF);
const Color kPaperLilac = Color(0xFFEDE9FE);
const Color kPaperViolet = Color(0xFFDDD6FE);
const Color kPaperIris = Color(0xFFE0E7FF);
const Color kPaperOrchid = Color(0xFFFAE8FF);
const Color kPaperCloud = Color(0xFFF1F5F9);

const Color kAccentIndigo = Color(0xFF4F46E5);
const Color kAccentViolet = Color(0xFF7C3AED);
const Color kAccentPurple = Color(0xFF8B5CF6);
const Color kAccentFuchsia = Color(0xFFC026D3);
const Color kAccentMagenta = Color(0xFFD946EF);
const Color kAccentBlue = Color(0xFF6366F1);
const Color kAccentSlate = Color(0xFF64748B);
const Color kAccentRose = Color(0xFFE11D48);
const Color kAccentTeal = Color(0xFF0D9488);
const Color kAccentAmber = Color(0xFFD97706);

// ---------------------------------------------------------------------------
// Local data classes describing rendered entries.
// ---------------------------------------------------------------------------

class ChipEntry {
  const ChipEntry({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

class AnchorMatrixCell {
  const AnchorMatrixCell({
    required this.targetLabel,
    required this.followerLabel,
    required this.targetAnchor,
    required this.followerAnchor,
    required this.accent,
  });

  final String targetLabel;
  final String followerLabel;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Color accent;
}

class OffsetEntry {
  const OffsetEntry({
    required this.label,
    required this.offset,
    required this.accent,
    required this.note,
  });

  final String label;
  final Offset offset;
  final Color accent;
  final String note;
}

class RealWorldCase {
  const RealWorldCase({
    required this.title,
    required this.scenario,
    required this.takeaway,
    required this.icon,
    required this.accent,
    required this.paper,
  });

  final String title;
  final String scenario;
  final String takeaway;
  final IconData icon;
  final Color accent;
  final Color paper;
}

class CaveatEntry {
  const CaveatEntry({
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

class Takeaway {
  const Takeaway({
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

class ComparisonColumn {
  const ComparisonColumn({
    required this.title,
    required this.summary,
    required this.preferWhen,
    required this.accent,
    required this.paper,
    required this.icon,
  });

  final String title;
  final String summary;
  final List<String> preferWhen;
  final Color accent;
  final Color paper;
  final IconData icon;
}

class CodeLine {
  const CodeLine({
    required this.text,
    required this.indent,
    this.comment = false,
  });

  final String text;
  final int indent;
  final bool comment;
}

// ---------------------------------------------------------------------------
// Catalog data (const).
// ---------------------------------------------------------------------------

const List<ChipEntry> kHeroChips = <ChipEntry>[
  ChipEntry(label: 'Layer', icon: Icons.layers_outlined),
  ChipEntry(label: 'Compositing', icon: Icons.dynamic_feed_outlined),
  ChipEntry(label: 'LayerLink', icon: Icons.link),
  ChipEntry(label: 'Anchor', icon: Icons.adjust),
];

const List<OffsetEntry> kOffsetEntries = <OffsetEntry>[
  OffsetEntry(
    label: '(0, 0)',
    offset: Offset.zero,
    accent: kAccentIndigo,
    note: 'Snug — follower sits exactly at the anchored corner.',
  ),
  OffsetEntry(
    label: '(16, 0)',
    offset: Offset(16, 0),
    accent: kAccentViolet,
    note: 'Slide right — gap to the right of the leader.',
  ),
  OffsetEntry(
    label: '(0, 16)',
    offset: Offset(0, 16),
    accent: kAccentPurple,
    note: 'Slide down — gap below the leader.',
  ),
  OffsetEntry(
    label: '(-16, -16)',
    offset: Offset(-16, -16),
    accent: kAccentFuchsia,
    note: 'Negative offset pulls follower up and left.',
  ),
  OffsetEntry(
    label: '(32, 32)',
    offset: Offset(32, 32),
    accent: kAccentMagenta,
    note: 'Large positive — clear visual gap on both axes.',
  ),
];

const List<AnchorMatrixCell> kAnchorMatrix = <AnchorMatrixCell>[
  AnchorMatrixCell(
    targetLabel: 'TL',
    followerLabel: 'BR',
    targetAnchor: Alignment.topLeft,
    followerAnchor: Alignment.bottomRight,
    accent: kAccentIndigo,
  ),
  AnchorMatrixCell(
    targetLabel: 'TC',
    followerLabel: 'BC',
    targetAnchor: Alignment.topCenter,
    followerAnchor: Alignment.bottomCenter,
    accent: kAccentBlue,
  ),
  AnchorMatrixCell(
    targetLabel: 'TR',
    followerLabel: 'BL',
    targetAnchor: Alignment.topRight,
    followerAnchor: Alignment.bottomLeft,
    accent: kAccentViolet,
  ),
  AnchorMatrixCell(
    targetLabel: 'CL',
    followerLabel: 'CR',
    targetAnchor: Alignment.centerLeft,
    followerAnchor: Alignment.centerRight,
    accent: kAccentPurple,
  ),
  AnchorMatrixCell(
    targetLabel: 'C',
    followerLabel: 'C',
    targetAnchor: Alignment.center,
    followerAnchor: Alignment.center,
    accent: kAccentFuchsia,
  ),
  AnchorMatrixCell(
    targetLabel: 'CR',
    followerLabel: 'CL',
    targetAnchor: Alignment.centerRight,
    followerAnchor: Alignment.centerLeft,
    accent: kAccentMagenta,
  ),
  AnchorMatrixCell(
    targetLabel: 'BL',
    followerLabel: 'TR',
    targetAnchor: Alignment.bottomLeft,
    followerAnchor: Alignment.topRight,
    accent: kAccentBlue,
  ),
  AnchorMatrixCell(
    targetLabel: 'BC',
    followerLabel: 'TC',
    targetAnchor: Alignment.bottomCenter,
    followerAnchor: Alignment.topCenter,
    accent: kAccentIndigo,
  ),
  AnchorMatrixCell(
    targetLabel: 'BR',
    followerLabel: 'TL',
    targetAnchor: Alignment.bottomRight,
    followerAnchor: Alignment.topLeft,
    accent: kAccentViolet,
  ),
];

const List<RealWorldCase> kRealWorldCases = <RealWorldCase>[
  RealWorldCase(
    title: 'Autocomplete dropdown',
    scenario:
        'A search field shows a list of suggestions immediately below it. '
        'CompositedTransformTarget wraps the TextField, and an Overlay-hosted '
        'CompositedTransformFollower with targetAnchor: bottomLeft and '
        'followerAnchor: topLeft tracks the field as the layout shifts, the '
        'window resizes, or the page scrolls — without recomputing global '
        'coordinates each frame.',
    takeaway:
        'Pin contextual lists to inputs without a global RenderObject lookup.',
    icon: Icons.search_outlined,
    accent: kAccentIndigo,
    paper: kPaperIris,
  ),
  RealWorldCase(
    title: 'Anchored popover menu',
    scenario:
        'An ellipsis (…) button opens a small actions menu hovering near the '
        'button. The button is the target; the menu is the follower in the '
        'app overlay. The follower keeps tracking the button if the row '
        'reflows during animation, so the popover never visually drifts off '
        'its anchor.',
    takeaway:
        'Robust against animated layouts: the menu rides with its button.',
    icon: Icons.more_vert,
    accent: kAccentViolet,
    paper: kPaperLilac,
  ),
  RealWorldCase(
    title: 'Badge that follows an avatar',
    scenario:
        'An unread-count badge is composited at the top-right of a user '
        'avatar. The avatar (target) is in a list that scrolls; the badge '
        '(follower) lives in an overlay so it can render above neighbouring '
        'tiles. Because both share a LayerLink, the badge tracks the avatar '
        'across scroll, animations, and reordering.',
    takeaway:
        'Decorations can live in an overlay and still hug their anchor.',
    icon: Icons.notifications_active_outlined,
    accent: kAccentPurple,
    paper: kPaperViolet,
  ),
  RealWorldCase(
    title: 'Tooltip on a chart point',
    scenario:
        'A chart shows interactive data points. Each hovered point has an '
        'invisible CompositedTransformTarget; a single follower in the app '
        'overlay re-attaches to whichever target is currently active. The '
        'tooltip snaps to the data point and follows live as the chart '
        'animates or the user pans.',
    takeaway:
        'One follower, many leaders — change the link to retarget cheaply.',
    icon: Icons.show_chart,
    accent: kAccentFuchsia,
    paper: kPaperOrchid,
  ),
];

const List<CaveatEntry> kCaveats = <CaveatEntry>[
  CaveatEntry(
    title: 'Each LayerLink must be used by exactly one leader',
    detail:
        'A LayerLink is a 1:1 channel: one CompositedTransformTarget and any '
        'number of followers that point at it. If two leaders share one '
        'link, the follower latches onto whichever was painted last and the '
        'tracking will glitch. Keep one link per anchor.',
    icon: Icons.link_off,
    accent: kAccentRose,
  ),
  CaveatEntry(
    title: 'Follower repaints when the leader transforms',
    detail:
        'The FollowerLayer captures its transform during compositing, so '
        'when the leader moves the follower repaints (no full layout). This '
        'is cheap, but it does mean the follower is excluded from raster '
        'caching while it tracks an animated leader.',
    icon: Icons.brush_outlined,
    accent: kAccentIndigo,
  ),
  CaveatEntry(
    title: 'Targets inside scrollables work as expected',
    detail:
        'A leader inside a ScrollView will move; followers track that '
        'movement at compositing time, so the follower stays glued to the '
        'leader while the user scrolls. No extra wiring is required, '
        'provided the follower lives in a paint context that can see both.',
    icon: Icons.swap_vert,
    accent: kAccentViolet,
  ),
  CaveatEntry(
    title: 'showWhenUnlinked controls offscreen visibility',
    detail:
        'When the leader is not in the layer tree (disposed, scrolled out, '
        'never painted), the FollowerLayer falls back to unlinkedOffset and '
        'paints only if showWhenUnlinked is true. Pick true for stable UI '
        'placeholders; pick false (the typical choice) for popovers that '
        'should disappear with their target.',
    icon: Icons.visibility_off_outlined,
    accent: kAccentPurple,
  ),
];

const List<Takeaway> kTakeaways = <Takeaway>[
  Takeaway(
    heading: 'A LayerLink is the channel',
    detail:
        'It carries the leader rect and transform from RenderLeaderLayer to '
        'RenderFollowerLayer at compositing time. Both ends must share the '
        'same instance.',
    icon: Icons.link,
    accent: kAccentIndigo,
  ),
  Takeaway(
    heading: 'Anchors compose like alignment pairs',
    detail:
        'targetAnchor picks a point on the leader; followerAnchor picks a '
        'point on the follower; the follower is positioned so those two '
        'points coincide, then offset is added in follower space.',
    icon: Icons.center_focus_strong_outlined,
    accent: kAccentViolet,
  ),
  Takeaway(
    heading: 'It runs at compositing, not layout',
    detail:
        'The follower owns its own size; only its position is tied to the '
        'leader. That is why scrolling and animated transforms feel cheap: '
        'no relayout is triggered for the follower itself.',
    icon: Icons.layers_outlined,
    accent: kAccentPurple,
  ),
  Takeaway(
    heading: 'showWhenUnlinked is your fallback',
    detail:
        'Decide upfront what should happen when the leader is gone. Almost '
        'all popover-like UIs want false; almost all stable decorations '
        'with an unlinkedOffset want true.',
    icon: Icons.help_outline,
    accent: kAccentFuchsia,
  ),
];

const List<ComparisonColumn> kComparisonColumns = <ComparisonColumn>[
  ComparisonColumn(
    title: 'Overlay + OverlayEntry',
    summary:
        'You build the floating widget yourself, manage its lifecycle, and '
        'compute its position from a global RenderBox lookup. Repositioning '
        'on scroll/resize is your responsibility.',
    preferWhen: <String>[
      'You need full control over insertion order and z-stacking.',
      'The floating UI does not have a stable anchor (e.g. global toasts).',
      'You want to composite into a different navigator/overlay scope.',
    ],
    accent: kAccentSlate,
    paper: kPaperCloud,
    icon: Icons.layers_clear_outlined,
  ),
  ComparisonColumn(
    title: 'CompositedTransformFollower',
    summary:
        'The framework wires leader and follower for you via LayerLink. '
        'Position updates happen at compositing — automatic on scroll, '
        'animation, layout shift — without any per-frame measurement code.',
    preferWhen: <String>[
      'The floating UI has a clear anchor widget.',
      'You want the follower to track scroll and transforms cheaply.',
      'You want declarative anchor and offset configuration.',
    ],
    accent: kAccentIndigo,
    paper: kPaperIris,
    icon: Icons.adjust,
  ),
];

const List<CodeLine> kApiCodeLines = <CodeLine>[
  CodeLine(
    text: '// One link instance, shared by leader and follower.',
    indent: 0,
    comment: true,
  ),
  CodeLine(text: 'final LayerLink link = LayerLink();', indent: 0),
  CodeLine(text: '', indent: 0),
  CodeLine(
    text: '// 1) Place the target — typically wraps the anchor widget.',
    indent: 0,
    comment: true,
  ),
  CodeLine(text: 'CompositedTransformTarget(', indent: 0),
  CodeLine(text: 'link: link,', indent: 1),
  CodeLine(text: 'child: anchorWidget,', indent: 1),
  CodeLine(text: ')', indent: 0),
  CodeLine(text: '', indent: 0),
  CodeLine(
    text: '// 2) Place the follower — typically inside an Overlay.',
    indent: 0,
    comment: true,
  ),
  CodeLine(text: 'CompositedTransformFollower(', indent: 0),
  CodeLine(text: 'link: link,', indent: 1),
  CodeLine(text: 'targetAnchor: Alignment.bottomLeft,', indent: 1),
  CodeLine(text: 'followerAnchor: Alignment.topLeft,', indent: 1),
  CodeLine(text: 'offset: Offset.zero,', indent: 1),
  CodeLine(text: 'showWhenUnlinked: false,', indent: 1),
  CodeLine(text: 'child: floatingPanel,', indent: 1),
  CodeLine(text: ')', indent: 0),
  CodeLine(text: '', indent: 0),
  CodeLine(
    text: '// Render-side equivalents (rarely used directly):',
    indent: 0,
    comment: true,
  ),
  CodeLine(
    text: '//   RenderLeaderLayer(link: link, child: ...)',
    indent: 0,
    comment: true,
  ),
  CodeLine(
    text: '//   RenderFollowerLayer(',
    indent: 0,
    comment: true,
  ),
  CodeLine(
    text: '//     link: link, showWhenUnlinked: true,',
    indent: 0,
    comment: true,
  ),
  CodeLine(
    text: '//     offset: Offset.zero, leaderAnchor, followerAnchor,',
    indent: 0,
    comment: true,
  ),
  CodeLine(
    text: '//   )',
    indent: 0,
    comment: true,
  ),
];

// ---------------------------------------------------------------------------
// Top-level entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kPaperBase,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildHero(),
          const SizedBox(height: 36),
          buildConceptDiagram(),
          const SizedBox(height: 36),
          buildDropdownAnchorDemo(),
          const SizedBox(height: 36),
          buildTooltipAnchorDemo(),
          const SizedBox(height: 36),
          buildAnchorMatrix(),
          const SizedBox(height: 36),
          buildOffsetShowcase(),
          const SizedBox(height: 36),
          buildShowWhenUnlinkedDemo(),
          const SizedBox(height: 36),
          buildApiSurface(),
          const SizedBox(height: 36),
          buildComparisonPanel(),
          const SizedBox(height: 36),
          buildRealWorldExamples(),
          const SizedBox(height: 36),
          buildCaveats(),
          const SizedBox(height: 36),
          buildFooter(),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 1. Hero header with gradient, link icon, title and chip strip.
// ---------------------------------------------------------------------------

Widget buildHero() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1E1B4B),
          Color(0xFF4338CA),
          Color(0xFF7C3AED),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkDeep.withValues(alpha: 0.34),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
        BoxShadow(
          color: kAccentViolet.withValues(alpha: 0.26),
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
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.34),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.link,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'rendering · layer',
                style: TextStyle(
                  color: Color(0xCCEDE9FE),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'RenderFollowerLayer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'A render object that composites at a position derived from '
                'a LayerLink referring to a RenderLeaderLayer. The public '
                'face of this is CompositedTransformFollower paired with '
                'CompositedTransformTarget — two widgets that share one '
                'LayerLink and let one rectangle ride another at paint time.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 14.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  for (final ChipEntry chip in kHeroChips)
                    buildHeroChip(chip),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildHeroChip(ChipEntry chip) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: Colors.white.withValues(alpha: 0.32)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(chip.icon, color: Colors.white, size: 14),
        const SizedBox(width: 8),
        Text(
          chip.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 2. Conceptual diagram: LayerLink in the middle, leader and follower around.
// ---------------------------------------------------------------------------

Widget buildConceptDiagram() {
  return _Section(
    eyebrow: 'CONCEPT',
    title: 'LayerLink is the channel between leader and follower',
    subtitle:
        'The leader records its rect and transform during paint; the link '
        'carries that data; the follower applies anchors and offset, then '
        'composites a FollowerLayer that rides the leader.',
    accent: kAccentIndigo,
    paper: kPaperIris,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kAccentIndigo.withValues(alpha: 0.20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kAccentIndigo.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: buildDiagramBox(
              title: 'LeaderLayer',
              subtitle:
                  'CompositedTransformTarget\nrecords rect + transform',
              icon: Icons.flag_outlined,
              accent: kAccentIndigo,
              paper: kPaperIris,
              footnote: 'targetAnchor lives on this rect.',
            ),
          ),
          buildDiagramArrow(label: 'reads', accent: kAccentIndigo),
          Expanded(
            child: buildDiagramBox(
              title: 'LayerLink',
              subtitle:
                  'A small mutable handle\nshared by both ends',
              icon: Icons.link,
              accent: kAccentViolet,
              paper: kPaperLilac,
              footnote: 'final LayerLink link = LayerLink();',
            ),
          ),
          buildDiagramArrow(label: 'reads', accent: kAccentViolet),
          Expanded(
            child: buildDiagramBox(
              title: 'FollowerLayer',
              subtitle:
                  'CompositedTransformFollower\napplies anchors + offset',
              icon: Icons.center_focus_strong_outlined,
              accent: kAccentPurple,
              paper: kPaperViolet,
              footnote: 'followerAnchor lives on this rect.',
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDiagramBox({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color accent,
  required Color paper,
  required String footnote,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: accent.withValues(alpha: 0.40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent.withValues(alpha: 0.45)),
              ),
              child: Icon(icon, color: accent, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: const TextStyle(
            color: kInkDeep,
            fontSize: 12.5,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: accent.withValues(alpha: 0.30)),
          ),
          child: Text(
            footnote,
            style: TextStyle(
              color: accent,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDiagramArrow({required String label, required Color accent}) {
  return SizedBox(
    width: 56,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.arrow_forward, color: accent, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 3. Live demo: dropdown anchor (below / above / right).
// ---------------------------------------------------------------------------

Widget buildDropdownAnchorDemo() {
  return _Section(
    eyebrow: 'LIVE · DROPDOWN',
    title: 'A button-style anchor with a follower panel',
    subtitle:
        'Three variants: dropdown opens below, above, or to the right of the '
        'anchor. Each variant uses one LayerLink instance.',
    accent: kAccentViolet,
    paper: kPaperLilac,
    child: Wrap(
      spacing: 24,
      runSpacing: 24,
      children: <Widget>[
        buildDropdownVariant(
          title: 'Below the anchor',
          description:
              'targetAnchor: bottomLeft / followerAnchor: topLeft. The most '
              'common dropdown pattern.',
          link: kDropdownBelowLink,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          followerOffset: const Offset(0, 8),
          accent: kAccentIndigo,
        ),
        buildDropdownVariant(
          title: 'Above the anchor',
          description:
              'targetAnchor: topLeft / followerAnchor: bottomLeft. Useful '
              'when the anchor is near the bottom of the viewport.',
          link: kDropdownAboveLink,
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          followerOffset: const Offset(0, -8),
          accent: kAccentViolet,
        ),
        buildDropdownVariant(
          title: 'To the right of the anchor',
          description:
              'targetAnchor: topRight / followerAnchor: topLeft. Side panel '
              'pattern, often seen for nested menus.',
          link: kDropdownRightLink,
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.topLeft,
          followerOffset: const Offset(8, 0),
          accent: kAccentPurple,
        ),
      ],
    ),
  );
}

Widget buildDropdownVariant({
  required String title,
  required String description,
  required LayerLink link,
  required Alignment targetAnchor,
  required Alignment followerAnchor,
  required Offset followerOffset,
  required Color accent,
}) {
  return SizedBox(
    width: 320,
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.30)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accent.withValues(alpha: 0.45)),
                ),
                child: Icon(Icons.arrow_drop_down, color: accent, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: kInkMuted,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 200,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: 80,
                  child: CompositedTransformTarget(
                    link: link,
                    child: buildAnchorButton(
                      label: 'Anchor',
                      accent: accent,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 80,
                  width: 160,
                  height: 40,
                  child: CompositedTransformFollower(
                    link: link,
                    showWhenUnlinked: false,
                    targetAnchor: targetAnchor,
                    followerAnchor: followerAnchor,
                    offset: followerOffset,
                    child: buildFollowerPanel(
                      lines: const <String>[
                        'Edit',
                        'Duplicate',
                        'Delete',
                      ],
                      accent: accent,
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

Widget buildAnchorButton({required String label, required Color accent}) {
  return Container(
    width: 160,
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: accent,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.34),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
          size: 22,
        ),
      ],
    ),
  );
}

Widget buildFollowerPanel({
  required List<String> lines,
  required Color accent,
}) {
  return Container(
    width: 160,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.45)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final String line in lines)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.chevron_right,
                  color: accent,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: kInkDeep,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
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

// ---------------------------------------------------------------------------
// 4. Live demo: tooltip with arrow.
// ---------------------------------------------------------------------------

Widget buildTooltipAnchorDemo() {
  return _Section(
    eyebrow: 'LIVE · TOOLTIP',
    title: 'A tooltip with an arrow tracking its target',
    subtitle:
        'Same pattern as a dropdown but the follower is a small bubble with '
        'an arrow on the side that points at the leader.',
    accent: kAccentPurple,
    paper: kPaperViolet,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kAccentPurple.withValues(alpha: 0.30)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kAccentPurple.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Hover semantics: in a real app the tooltip would only paint '
            'while the target is hovered or focused. Here both are always '
            'visible to make the layer relationship obvious.',
            style: TextStyle(
              color: kInkMuted,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 220,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  left: 80,
                  top: 110,
                  child: CompositedTransformTarget(
                    link: kTooltipLink,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: kAccentPurple,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color:
                                kAccentPurple.withValues(alpha: 0.36),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  top: 110,
                  width: 200,
                  height: 80,
                  child: CompositedTransformFollower(
                    link: kTooltipLink,
                    showWhenUnlinked: false,
                    targetAnchor: Alignment.topCenter,
                    followerAnchor: Alignment.bottomCenter,
                    offset: const Offset(0, -10),
                    child: buildTooltipBubble(
                      message:
                          'A FollowerLayer rides this avatar at composite '
                          'time.',
                      accent: kAccentPurple,
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

Widget buildTooltipBubble({
  required String message,
  required Color accent,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: kInkDeep,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent.withValues(alpha: 0.55)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kInkDeep.withValues(alpha: 0.36),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.45,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Transform.rotate(
        angle: 0.785398,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: kInkDeep,
            border: Border.all(color: accent.withValues(alpha: 0.55)),
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 5. Anchor matrix: 3x3 grid of (targetAnchor x followerAnchor) cells.
// ---------------------------------------------------------------------------

Widget buildAnchorMatrix() {
  return _Section(
    eyebrow: 'ANCHORS',
    title: 'Sweeping (targetAnchor × followerAnchor)',
    subtitle:
        'Each cell shows a small target rect and a follower rect. '
        'targetAnchor picks a point on the leader; followerAnchor picks a '
        'point on the follower; the two coincide.',
    accent: kAccentBlue,
    paper: kPaperIris,
    child: GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.05,
      children: <Widget>[
        for (final AnchorMatrixCell cell in kAnchorMatrix)
          buildAnchorMatrixCell(cell),
      ],
    ),
  );
}

Widget buildAnchorMatrixCell(AnchorMatrixCell cell) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cell.accent.withValues(alpha: 0.32)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cell.accent.withValues(alpha: 0.12),
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
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cell.accent.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'T:${cell.targetLabel}',
                style: TextStyle(
                  color: cell.accent,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cell.accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(999),
                border:
                    Border.all(color: cell.accent.withValues(alpha: 0.32)),
              ),
              child: Text(
                'F:${cell.followerLabel}',
                style: TextStyle(
                  color: cell.accent,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ClipRect(
            child: buildMatrixVisual(cell: cell),
          ),
        ),
      ],
    ),
  );
}

Widget buildMatrixVisual({required AnchorMatrixCell cell}) {
  // Use a fresh LayerLink per cell — different leaders must not share links.
  final LayerLink localLink = LayerLink();
  return Stack(
    clipBehavior: Clip.none,
    children: <Widget>[
      Positioned(
        left: 30,
        top: 30,
        child: CompositedTransformTarget(
          link: localLink,
          child: Container(
            width: 60,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cell.accent.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'leader',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 30,
        top: 30,
        width: 50,
        height: 26,
        child: CompositedTransformFollower(
          link: localLink,
          showWhenUnlinked: false,
          targetAnchor: cell.targetAnchor,
          followerAnchor: cell.followerAnchor,
          offset: Offset.zero,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: cell.accent.withValues(alpha: 0.65),
                width: 1.5,
              ),
            ),
            child: Text(
              'follow',
              style: TextStyle(
                color: cell.accent,
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 6. Offset showcase: same anchor pair, varying offsets.
// ---------------------------------------------------------------------------

Widget buildOffsetShowcase() {
  return _Section(
    eyebrow: 'OFFSET',
    title: 'Offset is applied in follower space, after anchoring',
    subtitle:
        'Same target/follower anchor pair (bottomLeft / topLeft); five '
        'offset values shift the follower by the indicated vector.',
    accent: kAccentFuchsia,
    paper: kPaperOrchid,
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        for (final OffsetEntry entry in kOffsetEntries)
          buildOffsetCard(entry),
      ],
    ),
  );
}

Widget buildOffsetCard(OffsetEntry entry) {
  final LayerLink localLink = LayerLink();
  return SizedBox(
    width: 220,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: entry.accent.withValues(alpha: 0.32)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: entry.accent.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: entry.accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'offset: ${entry.label}',
              style: TextStyle(
                color: entry.accent,
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  left: 50,
                  top: 30,
                  child: CompositedTransformTarget(
                    link: localLink,
                    child: Container(
                      width: 60,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: entry.accent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'leader',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 30,
                  width: 60,
                  height: 26,
                  child: CompositedTransformFollower(
                    link: localLink,
                    showWhenUnlinked: false,
                    targetAnchor: Alignment.bottomLeft,
                    followerAnchor: Alignment.topLeft,
                    offset: entry.offset,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: entry.accent.withValues(alpha: 0.65),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        'follow',
                        style: TextStyle(
                          color: entry.accent,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry.note,
            style: const TextStyle(
              color: kInkMuted,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 7. showWhenUnlinked: linked card vs detached follower link.
// ---------------------------------------------------------------------------

Widget buildShowWhenUnlinkedDemo() {
  return _Section(
    eyebrow: 'showWhenUnlinked',
    title: 'What does the follower do without a leader?',
    subtitle:
        'In the left card the leader and follower share a link; the '
        'follower tracks normally. In the right card the follower has its '
        'own (detached) link, so showWhenUnlinked decides if it paints.',
    accent: kAccentMagenta,
    paper: kPaperOrchid,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: buildShowWhenUnlinkedLinked(),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: buildShowWhenUnlinkedDetached(),
        ),
      ],
    ),
  );
}

Widget buildShowWhenUnlinkedLinked() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kAccentIndigo.withValues(alpha: 0.30)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentIndigo.withValues(alpha: 0.10),
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
            const Icon(Icons.link, color: kAccentIndigo, size: 18),
            const SizedBox(width: 8),
            const Text(
              'Linked: leader and follower share kLinkedCardLink',
              style: TextStyle(
                color: kAccentIndigo,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'The follower tracks normally; showWhenUnlinked has no visible '
          'effect because the leader is in the tree.',
          style: TextStyle(
            color: kInkMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 140,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                left: 30,
                top: 60,
                child: CompositedTransformTarget(
                  link: kLinkedCardLink,
                  child: buildAnchorButton(
                    label: 'Leader',
                    accent: kAccentIndigo,
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 60,
                width: 160,
                height: 36,
                child: CompositedTransformFollower(
                  link: kLinkedCardLink,
                  showWhenUnlinked: true,
                  targetAnchor: Alignment.bottomLeft,
                  followerAnchor: Alignment.topLeft,
                  offset: const Offset(0, 8),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kPaperIris,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: kAccentIndigo.withValues(alpha: 0.55),
                      ),
                    ),
                    child: const Text(
                      'follower (linked)',
                      style: TextStyle(
                        color: kAccentIndigo,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
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
  );
}

Widget buildShowWhenUnlinkedDetached() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kAccentMagenta.withValues(alpha: 0.30)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentMagenta.withValues(alpha: 0.10),
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
            const Icon(Icons.link_off, color: kAccentMagenta, size: 18),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Detached: follower link points at no leader',
                style: TextStyle(
                  color: kAccentMagenta,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'showWhenUnlinked: true paints the follower at unlinkedOffset; '
          'showWhenUnlinked: false hides it entirely.',
          style: TextStyle(
            color: kInkMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 140,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                left: 30,
                top: 60,
                child: Container(
                  width: 160,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: kAccentSlate.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kAccentSlate.withValues(alpha: 0.40),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Text(
                    'no leader here',
                    style: TextStyle(
                      color: kAccentSlate,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 110,
                width: 160,
                height: 28,
                child: CompositedTransformFollower(
                  link: kDetachedFollowerLink,
                  showWhenUnlinked: true,
                  targetAnchor: Alignment.bottomLeft,
                  followerAnchor: Alignment.topLeft,
                  offset: Offset.zero,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kPaperOrchid,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: kAccentMagenta.withValues(alpha: 0.55),
                      ),
                    ),
                    child: const Text(
                      'unlinked: drawn at unlinkedOffset',
                      style: TextStyle(
                        color: kAccentMagenta,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
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
  );
}

// ---------------------------------------------------------------------------
// 8. API surface: the canonical code block.
// ---------------------------------------------------------------------------

Widget buildApiSurface() {
  return _Section(
    eyebrow: 'API',
    title: 'CompositedTransformTarget + CompositedTransformFollower',
    subtitle:
        'The render objects RenderLeaderLayer and RenderFollowerLayer are '
        'rarely used directly. The two widget partners and a single shared '
        'LayerLink are usually enough.',
    accent: kAccentIndigo,
    paper: kPaperIris,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kInkDeep,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInkDeep.withValues(alpha: 0.36),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'follower_layer.dart',
                style: TextStyle(
                  color: Color(0xFFC7D2FE),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (final CodeLine line in kApiCodeLines) buildCodeLine(line),
        ],
      ),
    ),
  );
}

Widget buildCodeLine(CodeLine line) {
  return Padding(
    padding: EdgeInsets.only(left: line.indent * 18.0, top: 2, bottom: 2),
    child: Text(
      line.text.isEmpty ? ' ' : line.text,
      style: TextStyle(
        color: line.comment ? const Color(0xFF94A3B8) : Colors.white,
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.55,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 9. Comparison panel: Overlay+OverlayEntry vs CompositedTransformFollower.
// ---------------------------------------------------------------------------

Widget buildComparisonPanel() {
  return _Section(
    eyebrow: 'COMPARISON',
    title: 'When to use Overlay vs CompositedTransformFollower',
    subtitle:
        'Both put content above the rest of the tree. The distinction is '
        'how positioning is computed: explicit code vs declarative anchors.',
    accent: kAccentSlate,
    paper: kPaperCloud,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < kComparisonColumns.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: i == 0 ? 0 : 12,
                right: i == kComparisonColumns.length - 1 ? 0 : 12,
              ),
              child: buildComparisonColumn(kComparisonColumns[i]),
            ),
          ),
      ],
    ),
  );
}

Widget buildComparisonColumn(ComparisonColumn column) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: column.paper,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: column.accent.withValues(alpha: 0.40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: column.accent.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: column.accent.withValues(alpha: 0.45)),
              ),
              child: Icon(column.icon, color: column.accent, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                column.title,
                style: TextStyle(
                  color: column.accent,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          column.summary,
          style: const TextStyle(
            color: kInkDeep,
            fontSize: 12.5,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'PREFER WHEN',
          style: TextStyle(
            color: column.accent,
            fontSize: 10.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        for (final String reason in column.preferWhen)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.check_circle_outline,
                    color: column.accent, size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    reason,
                    style: const TextStyle(
                      color: kInkMid,
                      fontSize: 12,
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
}

// ---------------------------------------------------------------------------
// 10. Real-world examples — illustrative cards with live mini-demos where
//     useful. The text describes the pattern; the picture shows the leader/
//     follower geometry.
// ---------------------------------------------------------------------------

Widget buildRealWorldExamples() {
  return _Section(
    eyebrow: 'PATTERNS',
    title: 'Real-world uses for CompositedTransformFollower',
    subtitle:
        'Each card is a tiny scenario plus a live miniature: a target rect '
        'with a follower attached via the canonical anchor pair for that '
        'pattern.',
    accent: kAccentPurple,
    paper: kPaperViolet,
    child: Wrap(
      spacing: 18,
      runSpacing: 18,
      children: <Widget>[
        buildAutocompletePatternCard(),
        buildAnchoredPopoverPatternCard(),
        buildAvatarBadgePatternCard(),
        buildChartTooltipPatternCard(),
      ],
    ),
  );
}

Widget buildAutocompletePatternCard() {
  return SizedBox(
    width: 320,
    child: buildPatternCardShell(
      meta: kRealWorldCases[0],
      visual: SizedBox(
        height: 150,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 18,
              child: CompositedTransformTarget(
                link: kAutocompleteLink,
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: kPaperCloud,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kAccentIndigo.withValues(alpha: 0.45),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.search, color: kAccentIndigo, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'che…',
                        style: TextStyle(
                          color: kInkDeep,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 18,
              width: 280,
              height: 90,
              child: CompositedTransformFollower(
                link: kAutocompleteLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.bottomLeft,
                followerAnchor: Alignment.topLeft,
                offset: const Offset(0, 6),
                child: buildFollowerPanel(
                  lines: const <String>[
                    'cherry',
                    'chestnut',
                    'cheetah',
                  ],
                  accent: kAccentIndigo,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildAnchoredPopoverPatternCard() {
  return SizedBox(
    width: 320,
    child: buildPatternCardShell(
      meta: kRealWorldCases[1],
      visual: SizedBox(
        height: 150,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              left: 220,
              top: 30,
              child: CompositedTransformTarget(
                link: kPopoverLink,
                child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kAccentViolet,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 220,
              top: 30,
              width: 160,
              height: 90,
              child: CompositedTransformFollower(
                link: kPopoverLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.bottomRight,
                followerAnchor: Alignment.topRight,
                offset: const Offset(0, 6),
                child: buildFollowerPanel(
                  lines: const <String>[
                    'Open',
                    'Rename',
                    'Archive',
                  ],
                  accent: kAccentViolet,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildAvatarBadgePatternCard() {
  return SizedBox(
    width: 320,
    child: buildPatternCardShell(
      meta: kRealWorldCases[2],
      visual: SizedBox(
        height: 150,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              left: 30,
              top: 30,
              child: CompositedTransformTarget(
                link: kAvatarBadgeLink,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: kAccentPurple,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 30,
              width: 22,
              height: 22,
              child: CompositedTransformFollower(
                link: kAvatarBadgeLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.topRight,
                followerAnchor: Alignment.center,
                offset: Offset.zero,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kAccentRose,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Text(
                    '7',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildChartTooltipPatternCard() {
  return SizedBox(
    width: 320,
    child: buildPatternCardShell(
      meta: kRealWorldCases[3],
      visual: SizedBox(
        height: 150,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[
                      kAccentFuchsia.withValues(alpha: 0.20),
                      kAccentFuchsia.withValues(alpha: 0.04),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 130,
              top: 70,
              child: CompositedTransformTarget(
                link: kChartPointLink,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: kAccentFuchsia,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 130,
              top: 70,
              width: 140,
              height: 50,
              child: CompositedTransformFollower(
                link: kChartPointLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.topCenter,
                followerAnchor: Alignment.bottomCenter,
                offset: const Offset(0, -6),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kInkDeep,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: kAccentFuchsia.withValues(alpha: 0.55),
                    ),
                  ),
                  child: const Text(
                    '2026-04 · 184',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildPatternCardShell({
  required RealWorldCase meta,
  required Widget visual,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: meta.paper,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: meta.accent.withValues(alpha: 0.40)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: meta.accent.withValues(alpha: 0.12),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: meta.accent.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: meta.accent.withValues(alpha: 0.45)),
              ),
              child: Icon(meta.icon, color: meta.accent, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                meta.title,
                style: TextStyle(
                  color: meta.accent,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: meta.accent.withValues(alpha: 0.30)),
          ),
          child: visual,
        ),
        const SizedBox(height: 12),
        Text(
          meta.scenario,
          style: const TextStyle(
            color: kInkMid,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: meta.accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            meta.takeaway,
            style: TextStyle(
              color: meta.accent,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 11. Caveats — four cards.
// ---------------------------------------------------------------------------

Widget buildCaveats() {
  return _Section(
    eyebrow: 'CAVEATS',
    title: 'Things that bite if you forget them',
    subtitle:
        'These come up in real codebases. Most are easy to avoid once they '
        'are explicit.',
    accent: kAccentRose,
    paper: kPaperOrchid,
    child: GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.6,
      children: <Widget>[
        for (final CaveatEntry caveat in kCaveats)
          buildCaveatCard(caveat),
      ],
    ),
  );
}

Widget buildCaveatCard(CaveatEntry caveat) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: caveat.accent.withValues(alpha: 0.32)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: caveat.accent.withValues(alpha: 0.10),
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
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: caveat.accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: caveat.accent.withValues(alpha: 0.45),
                ),
              ),
              child: Icon(caveat.icon, color: caveat.accent, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                caveat.title,
                style: TextStyle(
                  color: caveat.accent,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Text(
            caveat.detail,
            style: const TextStyle(
              color: kInkMid,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 12. Footer with takeaways.
// ---------------------------------------------------------------------------

Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1E1B4B),
          Color(0xFF312E81),
          Color(0xFF4338CA),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkDeep.withValues(alpha: 0.30),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Takeaways',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A short crib sheet to keep next to your code.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        for (final Takeaway entry in kTakeaways)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: buildTakeawayCard(entry),
          ),
      ],
    ),
  );
}

Widget buildTakeawayCard(Takeaway entry) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: entry.accent.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: entry.accent.withValues(alpha: 0.50)),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.detail,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.86),
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

// ---------------------------------------------------------------------------
// Reusable section wrapper.
// ---------------------------------------------------------------------------

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
              fontWeight: FontWeight.w900,
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
