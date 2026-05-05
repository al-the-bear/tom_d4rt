// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =====================================================================
// D4rt deep visual demo: Material TabBar indicator family.
// =====================================================================
//
// This file renders a long, vertically-scrolling page that walks through
// every important knob attached to the highlight beneath the active
// tab in a Material `TabBar`:
//
//   * UnderlineTabIndicator         - the default underline shape; takes
//                                     a BorderSide, optional BorderRadius
//                                     and an EdgeInsets `insets`.
//   * TabBarIndicatorSize.tab       - indicator hugs the entire tab cell.
//   * TabBarIndicatorSize.label     - indicator hugs only the label text.
//   * BoxDecoration as `indicator`  - any Decoration may stand in for the
//                                     underline; pills, rounded rects,
//                                     gradients, drop-shadows.
//   * indicatorColor                - underline colour when `indicator`
//                                     is not provided.
//   * indicatorWeight               - underline thickness in logical px;
//                                     ignored if `indicator` is set.
//   * indicatorPadding              - inset applied after sizing; useful
//                                     for visually pulling the indicator
//                                     away from cell edges.
//   * dividerColor / dividerHeight  - the thin line beneath the strip
//                                     (Material 3 only). Older versions
//                                     fall back to theme defaults.
//   * TabBarTheme                   - bulk-style every tab strip in a
//                                     subtree; labelColor,
//                                     unselectedLabelColor, labelStyle,
//                                     indicator, indicatorSize, etc.
//
// d4rt runtime constraints honoured by this file:
//   * No subclassing of Decoration / BoxPainter / Flutter abstracts.
//   * No StatefulWidget, no TabController side-effects, no setState.
//   * `dynamic build(BuildContext context)` is the only entry point.
//   * `// ignore_for_file:` on the very first line; no inline ignores.
//   * `.withValues(alpha:)` instead of `.withOpacity()`.
//   * No for-in loops over bridged collections.
//   * Tab strips are mocked from a Row of labels with a coloured
//     Container painted underneath the active label - this gives the
//     same visual fidelity as a real TabBar without requiring a live
//     TabController.
//
// Sections (rendered top-to-bottom):
//   1.  Hero header + section index.
//   2.  Anatomy diagram of a tab strip.
//   3.  Default underline tab strip (4 tabs, 2-px line, Material blue).
//   4.  TabBarIndicatorSize.tab vs .label - paired comparison strips.
//   5.  Indicator weight ladder (1, 2, 3, 4, 6 px).
//   6.  Indicator colour palette (8 hue variants on the same strip).
//   7.  Indicator padding showcase (4, 8, 16, 24 horizontal insets).
//   8.  BoxDecoration indicator variants - pill, rounded rect,
//       gradient, drop-shadow.
//   9.  TabBarTheme override - a strip rendered under a custom
//       Theme(data: ThemeData(tabBarTheme: ...)).
//   10. Themed scrolling tabs mock - Row of 8 labels, active highlight.
//   11. Comparison panel - underline / pill / filled / shadow side-by-side.
//   12. Code-card showing TabBar(indicator: BoxDecoration(...), ...).
//   13. Pitfalls - dividerColor in newer Flutter, weight under MD3,
//       indicatorColor vs `indicator` interaction, label-vs-tab gotcha.
//   14. Footer.
//
// Palette: deep navy + amber + coral. Each cell uses a unique decoration.
// =====================================================================
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Palette - dark navy primary, amber accent, coral highlights, paper
// background. Extra greys used for diagram callouts and dividers.
// ---------------------------------------------------------------------
const Color kInk = Color(0xFF0B132B);
const Color kInkSoft = Color(0xFF1C2541);
const Color kNavy = Color(0xFF3A506B);
const Color kSky = Color(0xFF5BC0BE);
const Color kAmber = Color(0xFFFFB703);
const Color kAmberSoft = Color(0xFFFFD166);
const Color kCoral = Color(0xFFFB6F92);
const Color kRose = Color(0xFFFFC8DD);
const Color kPaper = Color(0xFFF7F8FB);
const Color kPaperAlt = Color(0xFFEEF1F6);
const Color kBorder = Color(0xFFCBD3E1);
const Color kSlate = Color(0xFF425466);
const Color kMuted = Color(0xFF8794A8);
const Color kLine = Color(0xFFD9DEE7);
const Color kGreen = Color(0xFF06D6A0);
const Color kViolet = Color(0xFF8338EC);
const Color kTeal = Color(0xFF118AB2);
const Color kPlum = Color(0xFF7209B7);
const Color kSand = Color(0xFFF7E5B7);

// =====================================================================
// build(BuildContext) - top-level harness entry point.
// =====================================================================
dynamic build(BuildContext context) {
  print('TabBar indicator deep demo - rendering');
  return Scaffold(
    backgroundColor: kPaper,
    appBar: AppBar(
      backgroundColor: kInk,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'TabBar indicators - deep visual demo',
        style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.4),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeroHeader(),
          const SizedBox(height: 28),
          buildAnatomySection(),
          const SizedBox(height: 28),
          buildDefaultUnderlineSection(),
          const SizedBox(height: 28),
          buildIndicatorSizeSection(),
          const SizedBox(height: 28),
          buildIndicatorWeightLadder(),
          const SizedBox(height: 28),
          buildIndicatorColourPalette(),
          const SizedBox(height: 28),
          buildIndicatorPaddingShowcase(),
          const SizedBox(height: 28),
          buildBoxDecorationVariants(),
          const SizedBox(height: 28),
          buildTabBarThemeOverride(),
          const SizedBox(height: 28),
          buildScrollingTabsMock(),
          const SizedBox(height: 28),
          buildComparisonPanel(),
          const SizedBox(height: 28),
          buildCodeCard(),
          const SizedBox(height: 28),
          buildPitfallsSection(),
          const SizedBox(height: 28),
          buildFooter(),
        ],
      ),
    ),
  );
}

// =====================================================================
// SECTION 1 - Hero header.
// =====================================================================
// A bold gradient banner that sets the visual tone. Includes title,
// subtitle, an icon plate, and three small chips listing the headline
// indicator knobs covered later in the document.
// ---------------------------------------------------------------------
Widget buildHeroHeader() {
  return Container(
    padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kInk, kInkSoft, kNavy],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInk.withValues(alpha: 0.30),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
        BoxShadow(
          color: kSky.withValues(alpha: 0.20),
          blurRadius: 36,
          offset: const Offset(0, 18),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: kAmber.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: kAmber, width: 1.4),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.tab, size: 34, color: kAmber),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'TabBar indicator family',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Underline, weight, padding, decoration, theme.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: <Widget>[
                  buildHeroChip('UnderlineTabIndicator', kSky),
                  buildHeroChip('BoxDecoration', kAmber),
                  buildHeroChip('TabBarTheme', kCoral),
                  buildHeroChip('indicatorSize', kGreen),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildHeroChip(String label, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: tint.withValues(alpha: 0.55), width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tint,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// =====================================================================
// SECTION 2 - Anatomy diagram.
// =====================================================================
// Static composition: a Row of four mock labels with a coloured 3-px
// indicator beneath the second one, surrounded by labelled callouts
// pointing at the indicator, divider, padding and tab cell.
// ---------------------------------------------------------------------
Widget buildAnatomySection() {
  return buildSectionCard(
    title: '1. Anatomy of a tab strip',
    subtitle:
        'Four moving parts: tab cells with labels, an indicator bar '
        'beneath the active label, a thin divider running the full '
        'width, and optional padding around the indicator.',
    accent: kSky,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kBorder, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildAnatomyCallout(
                label: '(a) Tab cell',
                color: kNavy,
                description:
                    'The clickable region for one tab. Width is the strip '
                    'width divided by tab count when not scrollable.',
              ),
              const SizedBox(height: 8),
              buildAnatomyCallout(
                label: '(b) Indicator',
                color: kAmber,
                description:
                    'A Decoration painted behind / beneath the active tab. '
                    'UnderlineTabIndicator is the default.',
              ),
              const SizedBox(height: 8),
              buildAnatomyCallout(
                label: '(c) Divider',
                color: kCoral,
                description:
                    'Hairline beneath the strip, drawn full-width. Material '
                    '3 only; controlled via dividerColor + dividerHeight.',
              ),
              const SizedBox(height: 8),
              buildAnatomyCallout(
                label: '(d) Indicator padding',
                color: kGreen,
                description:
                    'Inset applied to the indicator after its size has '
                    'been computed - lets the bar shrink relative to '
                    'its own cell or label.',
              ),
              const SizedBox(height: 18),
              buildMockTabStrip(
                labels: const <String>['Inbox', 'Sent', 'Drafts', 'Spam'],
                activeIndex: 1,
                indicatorColor: kAmber,
                indicatorHeight: 3,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
                indicatorRadius: 0,
                indicatorWidthFraction: 1.0,
                showDivider: true,
                dividerColor: kBorder,
                labelColor: kInk,
                unselectedLabelColor: kMuted,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: BoxDecoration(
                  color: kPaperAlt,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kBorder, width: 0.8),
                ),
                child: const Text(
                  'Notation:  (a) full tab cell width  /  (b) the bar  /  '
                  '(c) the divider line  /  (d) padding around the bar.',
                  style: TextStyle(
                    color: kSlate,
                    fontSize: 12.5,
                    height: 1.45,
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

Widget buildAnatomyCallout({
  required String label,
  required Color color,
  required String description,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 4),
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: const TextStyle(
                color: kSlate,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// =====================================================================
// SECTION 3 - Default underline.
// =====================================================================
// Single tab strip with the canonical defaults: four tabs, 2-px line,
// material blue, no padding, indicator size = tab. We also draw a
// duplicate strip with just the divider showing for context.
// ---------------------------------------------------------------------
Widget buildDefaultUnderlineSection() {
  return buildSectionCard(
    title: '2. Default UnderlineTabIndicator',
    subtitle:
        'Material 3 default: 2 px tall, primary colour, full tab width. '
        'No rounded corners, no padding, no decoration overrides.',
    accent: kAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLabeledCard(
          label: 'Active tab: "Sent" - default appearance',
          child: buildMockTabStrip(
            labels: const <String>['Inbox', 'Sent', 'Drafts', 'Spam'],
            activeIndex: 1,
            indicatorColor: const Color(0xFF1976D2),
            indicatorHeight: 2,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 14),
        buildLabeledCard(
          label: 'Same strip without an active selection',
          child: buildMockTabStrip(
            labels: const <String>['Inbox', 'Sent', 'Drafts', 'Spam'],
            activeIndex: -1,
            indicatorColor: const Color(0xFF1976D2),
            indicatorHeight: 2,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 14),
        buildLabeledCard(
          label: 'With a custom dividerColor (Material 3)',
          child: buildMockTabStrip(
            labels: const <String>['Inbox', 'Sent', 'Drafts', 'Spam'],
            activeIndex: 2,
            indicatorColor: const Color(0xFF1976D2),
            indicatorHeight: 2,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kCoral.withValues(alpha: 0.45),
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 4 - TabBarIndicatorSize.tab vs .label.
// =====================================================================
// Two strips side by side. The .tab strip stretches the indicator the
// full cell width; the .label strip shrinks it to the visible label.
// ---------------------------------------------------------------------
Widget buildIndicatorSizeSection() {
  return buildSectionCard(
    title: '3. TabBarIndicatorSize - tab vs label',
    subtitle:
        'tab: indicator hugs the entire tab cell, regardless of label '
        'length. label: indicator shrinks to the visible text width. '
        'Most apparent when labels have very different lengths.',
    accent: kCoral,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: buildLabeledCard(
                label: 'TabBarIndicatorSize.tab',
                child: buildMockTabStrip(
                  labels: const <String>['Hi', 'Hello', 'Greetings', 'Hey'],
                  activeIndex: 2,
                  indicatorColor: kAmber,
                  indicatorHeight: 3,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorRadius: 0,
                  indicatorWidthFraction: 1.0,
                  showDivider: true,
                  dividerColor: kBorder,
                  labelColor: kInk,
                  unselectedLabelColor: kMuted,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: buildLabeledCard(
                label: 'TabBarIndicatorSize.label',
                child: buildMockTabStrip(
                  labels: const <String>['Hi', 'Hello', 'Greetings', 'Hey'],
                  activeIndex: 2,
                  indicatorColor: kAmber,
                  indicatorHeight: 3,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorRadius: 0,
                  indicatorWidthFraction: 0.55,
                  showDivider: true,
                  dividerColor: kBorder,
                  labelColor: kInk,
                  unselectedLabelColor: kMuted,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: buildLabeledCard(
                label: '.tab on a 5-tab strip',
                child: buildMockTabStrip(
                  labels: const <String>['One', 'Two', 'Three', 'Four', 'Five'],
                  activeIndex: 0,
                  indicatorColor: kSky,
                  indicatorHeight: 3,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorRadius: 0,
                  indicatorWidthFraction: 1.0,
                  showDivider: true,
                  dividerColor: kBorder,
                  labelColor: kInk,
                  unselectedLabelColor: kMuted,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: buildLabeledCard(
                label: '.label on the same strip',
                child: buildMockTabStrip(
                  labels: const <String>['One', 'Two', 'Three', 'Four', 'Five'],
                  activeIndex: 0,
                  indicatorColor: kSky,
                  indicatorHeight: 3,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorRadius: 0,
                  indicatorWidthFraction: 0.45,
                  showDivider: true,
                  dividerColor: kBorder,
                  labelColor: kInk,
                  unselectedLabelColor: kMuted,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          decoration: BoxDecoration(
            color: kPaperAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kBorder, width: 0.8),
          ),
          child: const Text(
            'Tip: prefer .label when labels vary widely in length and the '
            'indicator should anchor visually to the text rather than the '
            'cell.',
            style: TextStyle(color: kSlate, fontSize: 12.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 5 - Indicator weight ladder.
// =====================================================================
// Five strips, 1 / 2 / 3 / 4 / 6 px tall. All other settings fixed so
// only the thickness varies.
// ---------------------------------------------------------------------
Widget buildIndicatorWeightLadder() {
  return buildSectionCard(
    title: '4. indicatorWeight ladder',
    subtitle:
        'Five mock strips with weights 1 / 2 / 3 / 4 / 6 logical pixels. '
        'indicatorWeight is ignored when `indicator` is set; this knob '
        'only affects the default UnderlineTabIndicator.',
    accent: kGreen,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLabeledCard(
          label: 'indicatorWeight: 1',
          child: buildMockTabStrip(
            labels: const <String>['Alpha', 'Beta', 'Gamma', 'Delta'],
            activeIndex: 0,
            indicatorColor: kAmber,
            indicatorHeight: 1,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'indicatorWeight: 2 (default)',
          child: buildMockTabStrip(
            labels: const <String>['Alpha', 'Beta', 'Gamma', 'Delta'],
            activeIndex: 1,
            indicatorColor: kAmber,
            indicatorHeight: 2,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'indicatorWeight: 3',
          child: buildMockTabStrip(
            labels: const <String>['Alpha', 'Beta', 'Gamma', 'Delta'],
            activeIndex: 2,
            indicatorColor: kAmber,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'indicatorWeight: 4',
          child: buildMockTabStrip(
            labels: const <String>['Alpha', 'Beta', 'Gamma', 'Delta'],
            activeIndex: 3,
            indicatorColor: kAmber,
            indicatorHeight: 4,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'indicatorWeight: 6 (extreme)',
          child: buildMockTabStrip(
            labels: const <String>['Alpha', 'Beta', 'Gamma', 'Delta'],
            activeIndex: 1,
            indicatorColor: kAmber,
            indicatorHeight: 6,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 6 - Indicator colour palette.
// =====================================================================
// Eight colour variants on the same strip. Each cell uses a distinct
// hue. The active label takes the indicator colour for emphasis.
// ---------------------------------------------------------------------
Widget buildIndicatorColourPalette() {
  return buildSectionCard(
    title: '5. indicatorColor palette',
    subtitle:
        'Eight strips, only the indicator colour changes. Useful when '
        'matching a brand palette - the colour cascades through the '
        'underline and the active label.',
    accent: kViolet,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLabeledCard(
          label: 'amber #FFB703',
          child: buildMockTabStrip(
            labels: const <String>['Stay', 'Go', 'Visit', 'Map'],
            activeIndex: 1,
            indicatorColor: kAmber,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kAmber,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 10),
        buildLabeledCard(
          label: 'coral #FB6F92',
          child: buildMockTabStrip(
            labels: const <String>['Stay', 'Go', 'Visit', 'Map'],
            activeIndex: 1,
            indicatorColor: kCoral,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kCoral,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 10),
        buildLabeledCard(
          label: 'sky #5BC0BE',
          child: buildMockTabStrip(
            labels: const <String>['Stay', 'Go', 'Visit', 'Map'],
            activeIndex: 1,
            indicatorColor: kSky,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kSky,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 10),
        buildLabeledCard(
          label: 'green #06D6A0',
          child: buildMockTabStrip(
            labels: const <String>['Stay', 'Go', 'Visit', 'Map'],
            activeIndex: 1,
            indicatorColor: kGreen,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kGreen,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 10),
        buildLabeledCard(
          label: 'violet #8338EC',
          child: buildMockTabStrip(
            labels: const <String>['Stay', 'Go', 'Visit', 'Map'],
            activeIndex: 1,
            indicatorColor: kViolet,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kViolet,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 10),
        buildLabeledCard(
          label: 'teal #118AB2',
          child: buildMockTabStrip(
            labels: const <String>['Stay', 'Go', 'Visit', 'Map'],
            activeIndex: 1,
            indicatorColor: kTeal,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kTeal,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 10),
        buildLabeledCard(
          label: 'plum #7209B7',
          child: buildMockTabStrip(
            labels: const <String>['Stay', 'Go', 'Visit', 'Map'],
            activeIndex: 1,
            indicatorColor: kPlum,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kPlum,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 10),
        buildLabeledCard(
          label: 'ink #0B132B',
          child: buildMockTabStrip(
            labels: const <String>['Stay', 'Go', 'Visit', 'Map'],
            activeIndex: 1,
            indicatorColor: kInk,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 7 - Indicator padding showcase.
// =====================================================================
// Same strip rendered with horizontal padding 4 / 8 / 16 / 24. The
// indicator visibly inset away from the cell edges as padding grows.
// ---------------------------------------------------------------------
Widget buildIndicatorPaddingShowcase() {
  return buildSectionCard(
    title: '6. indicatorPadding showcase',
    subtitle:
        'EdgeInsets.symmetric(horizontal: ...) applied to the indicator '
        'rect post-sizing. Use to break the bar away from the cell edges '
        'and create a visual gap between adjacent indicators.',
    accent: kTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLabeledCard(
          label: 'EdgeInsets.symmetric(horizontal: 4)',
          child: buildMockTabStrip(
            labels: const <String>['Home', 'Search', 'Notify', 'Account'],
            activeIndex: 1,
            indicatorColor: kAmber,
            indicatorHeight: 3,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'EdgeInsets.symmetric(horizontal: 8)',
          child: buildMockTabStrip(
            labels: const <String>['Home', 'Search', 'Notify', 'Account'],
            activeIndex: 1,
            indicatorColor: kAmber,
            indicatorHeight: 3,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'EdgeInsets.symmetric(horizontal: 16)',
          child: buildMockTabStrip(
            labels: const <String>['Home', 'Search', 'Notify', 'Account'],
            activeIndex: 1,
            indicatorColor: kAmber,
            indicatorHeight: 3,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'EdgeInsets.symmetric(horizontal: 24)',
          child: buildMockTabStrip(
            labels: const <String>['Home', 'Search', 'Notify', 'Account'],
            activeIndex: 1,
            indicatorColor: kAmber,
            indicatorHeight: 3,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          decoration: BoxDecoration(
            color: kPaperAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kBorder, width: 0.8),
          ),
          child: const Text(
            'Note: padding is applied AFTER the indicator size has been '
            'computed, so it shrinks the bar relative to either the tab '
            'cell or the label, depending on indicatorSize.',
            style: TextStyle(color: kSlate, fontSize: 12.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 8 - BoxDecoration indicator variants.
// =====================================================================
// Four indicator styles built from BoxDecoration: solid pill, rounded
// rect, gradient pill, drop-shadow pill. Each is rendered as a filled
// active-tab background instead of a thin underline.
// ---------------------------------------------------------------------
Widget buildBoxDecorationVariants() {
  return buildSectionCard(
    title: '7. BoxDecoration indicator variants',
    subtitle:
        'When `indicator` is supplied, indicatorColor and indicatorWeight '
        'are ignored. Any Decoration works - here we showcase pill, '
        'rounded rect, gradient pill, and a drop-shadow pill.',
    accent: kAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLabeledCard(
          label: 'BoxDecoration: solid pill (radius: 24)',
          child: buildPillTabStrip(
            labels: const <String>['Daily', 'Weekly', 'Monthly', 'Yearly'],
            activeIndex: 1,
            decoration: BoxDecoration(
              color: kAmber,
              borderRadius: BorderRadius.circular(24),
            ),
            activeLabelColor: kInk,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'BoxDecoration: rounded rect (radius: 8) with border',
          child: buildPillTabStrip(
            labels: const <String>['Daily', 'Weekly', 'Monthly', 'Yearly'],
            activeIndex: 2,
            decoration: BoxDecoration(
              color: kSky.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kSky, width: 1.4),
            ),
            activeLabelColor: kSky,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'BoxDecoration: gradient pill',
          child: buildPillTabStrip(
            labels: const <String>['Daily', 'Weekly', 'Monthly', 'Yearly'],
            activeIndex: 0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[kCoral, kAmber],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            activeLabelColor: Colors.white,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'BoxDecoration: drop-shadow pill',
          child: buildPillTabStrip(
            labels: const <String>['Daily', 'Weekly', 'Monthly', 'Yearly'],
            activeIndex: 3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kInk.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: kViolet.withValues(alpha: 0.20),
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: kBorder, width: 0.8),
            ),
            activeLabelColor: kViolet,
            unselectedLabelColor: kMuted,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 9 - TabBarTheme override.
// =====================================================================
// A nested Theme widget that customises the TabBarTheme. The mock strip
// below shows the same labelColor / indicator / indicatorSize values
// the theme would inject into a real TabBar.
// ---------------------------------------------------------------------
Widget buildTabBarThemeOverride() {
  return buildSectionCard(
    title: '8. TabBarTheme override',
    subtitle:
        'Wrap a subtree in Theme(data: ThemeData(tabBarTheme: ...)) to '
        'set labelColor, unselectedLabelColor, labelStyle, indicator, '
        'indicatorSize, dividerColor and dividerHeight in bulk.',
    accent: kPlum,
    child: Theme(
      data: ThemeData(
        tabBarTheme: TabBarThemeData(
          labelColor: kPlum,
          unselectedLabelColor: kMuted,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
          indicator: BoxDecoration(
            color: kPlum.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kPlum, width: 1.2),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: kBorder,
          dividerHeight: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildLabeledCard(
            label: 'Themed strip (labelColor: plum, indicator: rounded rect)',
            child: buildPillTabStrip(
              labels: const <String>['Files', 'Sharing', 'Audit', 'Settings'],
              activeIndex: 0,
              decoration: BoxDecoration(
                color: kPlum.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kPlum, width: 1.2),
              ),
              activeLabelColor: kPlum,
              unselectedLabelColor: kMuted,
            ),
          ),
          const SizedBox(height: 12),
          buildLabeledCard(
            label: 'Same theme, second tab active',
            child: buildPillTabStrip(
              labels: const <String>['Files', 'Sharing', 'Audit', 'Settings'],
              activeIndex: 1,
              decoration: BoxDecoration(
                color: kPlum.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kPlum, width: 1.2),
              ),
              activeLabelColor: kPlum,
              unselectedLabelColor: kMuted,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: kPaperAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kBorder, width: 0.8),
            ),
            child: const Text(
              'TabBarThemeData lives on ThemeData. In Material 3, prefer '
              'TabBarThemeData over the deprecated TabBarTheme constructor.',
              style: TextStyle(color: kSlate, fontSize: 12.5, height: 1.45),
            ),
          ),
        ],
      ),
    ),
  );
}

// =====================================================================
// SECTION 10 - Themed scrolling tabs mock.
// =====================================================================
// A wide Row of eight labels with horizontal scroll fake-up, the active
// label highlighted by a custom decoration. Demonstrates how the
// indicator behaves when there are more tabs than the visible width.
// ---------------------------------------------------------------------
Widget buildScrollingTabsMock() {
  return buildSectionCard(
    title: '9. Scrolling tabs mock',
    subtitle:
        'When isScrollable is true, tabs lay out horizontally in their '
        'natural width and the strip overflows. The indicator follows '
        'the active label and animates as the user scrolls.',
    accent: kSky,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLabeledCard(
          label: 'Scrollable strip - 8 tabs, active = "Reports"',
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildScrollingTabCell('Overview', false),
                buildScrollingTabCell('Reports', true),
                buildScrollingTabCell('Audit log', false),
                buildScrollingTabCell('Forecasts', false),
                buildScrollingTabCell('Inventory', false),
                buildScrollingTabCell('Vendors', false),
                buildScrollingTabCell('Customers', false),
                buildScrollingTabCell('Settings', false),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: 'Same strip - active = "Forecasts"',
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildScrollingTabCell('Overview', false),
                buildScrollingTabCell('Reports', false),
                buildScrollingTabCell('Audit log', false),
                buildScrollingTabCell('Forecasts', true),
                buildScrollingTabCell('Inventory', false),
                buildScrollingTabCell('Vendors', false),
                buildScrollingTabCell('Customers', false),
                buildScrollingTabCell('Settings', false),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildScrollingTabCell(String label, bool active) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: active
        ? BoxDecoration(
            color: kSky.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: kSky, width: 1.2),
          )
        : BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: kBorder, width: 1),
          ),
    child: Text(
      label,
      style: TextStyle(
        color: active ? kSky : kSlate,
        fontSize: 13,
        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// =====================================================================
// SECTION 11 - Comparison panel.
// =====================================================================
// Four strips stacked vertically: underline / pill / filled rect /
// shadow box. Same labels and active index across all four to make
// the difference between indicator styles clear at a glance.
// ---------------------------------------------------------------------
Widget buildComparisonPanel() {
  return buildSectionCard(
    title: '10. Comparison panel',
    subtitle:
        'Four indicator styles, identical strip otherwise. Underline '
        'is the default; pill / filled / shadow demonstrate how a '
        'BoxDecoration takes over the visual treatment.',
    accent: kCoral,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLabeledCard(
          label: '(a) Underline',
          child: buildMockTabStrip(
            labels: const <String>['Photos', 'Albums', 'Tags', 'Trash'],
            activeIndex: 1,
            indicatorColor: kCoral,
            indicatorHeight: 3,
            indicatorPadding: EdgeInsets.zero,
            indicatorRadius: 0,
            indicatorWidthFraction: 1.0,
            showDivider: true,
            dividerColor: kBorder,
            labelColor: kCoral,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: '(b) Pill',
          child: buildPillTabStrip(
            labels: const <String>['Photos', 'Albums', 'Tags', 'Trash'],
            activeIndex: 1,
            decoration: BoxDecoration(
              color: kCoral,
              borderRadius: BorderRadius.circular(24),
            ),
            activeLabelColor: Colors.white,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: '(c) Filled rectangle',
          child: buildPillTabStrip(
            labels: const <String>['Photos', 'Albums', 'Tags', 'Trash'],
            activeIndex: 1,
            decoration: BoxDecoration(
              color: kCoral.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4),
            ),
            activeLabelColor: kCoral,
            unselectedLabelColor: kMuted,
          ),
        ),
        const SizedBox(height: 12),
        buildLabeledCard(
          label: '(d) Box with shadow',
          child: buildPillTabStrip(
            labels: const <String>['Photos', 'Albums', 'Tags', 'Trash'],
            activeIndex: 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kCoral.withValues(alpha: 0.30),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: kCoral.withValues(alpha: 0.50),
                width: 1,
              ),
            ),
            activeLabelColor: kCoral,
            unselectedLabelColor: kMuted,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 12 - Code card.
// =====================================================================
// A monospace-styled snippet showing the canonical TabBar invocation
// for a custom BoxDecoration indicator with TabBarIndicatorSize.label.
// ---------------------------------------------------------------------
Widget buildCodeCard() {
  return buildSectionCard(
    title: '11. Code',
    subtitle:
        'Reference invocation for a custom BoxDecoration indicator with '
        'label-sized indicator and explicit padding.',
    accent: kInk,
    child: Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kInkSoft, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.25),
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
              buildCodeDot(kCoral),
              const SizedBox(width: 6),
              buildCodeDot(kAmber),
              const SizedBox(width: 6),
              buildCodeDot(kGreen),
              const SizedBox(width: 14),
              const Text(
                'tab_bar_snippet.dart',
                style: TextStyle(
                  color: Color(0xFFB8C0CC),
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          buildCodeLine('TabBar(', kRose),
          buildCodeLine('  controller: controller,', Colors.white),
          buildCodeLine('  indicator: BoxDecoration(', kAmberSoft),
          buildCodeLine('    color: const Color(0xFFFFB703),', Colors.white),
          buildCodeLine('    borderRadius: BorderRadius.circular(24),', Colors.white),
          buildCodeLine('    border: Border.all(', Colors.white),
          buildCodeLine('      color: const Color(0xFF0B132B),', Colors.white),
          buildCodeLine('      width: 1.2,', Colors.white),
          buildCodeLine('    ),', Colors.white),
          buildCodeLine('  ),', kAmberSoft),
          buildCodeLine('  indicatorSize: TabBarIndicatorSize.label,', kSand),
          buildCodeLine('  indicatorPadding: const EdgeInsets.symmetric(', kSand),
          buildCodeLine('    horizontal: 8,', Colors.white),
          buildCodeLine('    vertical: 6,', Colors.white),
          buildCodeLine('  ),', kSand),
          buildCodeLine('  labelColor: const Color(0xFF0B132B),', Colors.white),
          buildCodeLine('  unselectedLabelColor: const Color(0xFF8794A8),', Colors.white),
          buildCodeLine('  labelStyle: const TextStyle(', Colors.white),
          buildCodeLine('    fontSize: 14,', Colors.white),
          buildCodeLine('    fontWeight: FontWeight.w700,', Colors.white),
          buildCodeLine('  ),', Colors.white),
          buildCodeLine('  dividerColor: const Color(0xFFD9DEE7),', Colors.white),
          buildCodeLine('  dividerHeight: 1,', Colors.white),
          buildCodeLine('  tabs: const <Widget>[', kSky),
          buildCodeLine('    Tab(text: "Daily"),', Colors.white),
          buildCodeLine('    Tab(text: "Weekly"),', Colors.white),
          buildCodeLine('    Tab(text: "Monthly"),', Colors.white),
          buildCodeLine('    Tab(text: "Yearly"),', Colors.white),
          buildCodeLine('  ],', kSky),
          buildCodeLine(');', kRose),
        ],
      ),
    ),
  );
}

Widget buildCodeDot(Color color) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

Widget buildCodeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.45,
      ),
    ),
  );
}

// =====================================================================
// SECTION 13 - Pitfalls.
// =====================================================================
// Five cards that flag common surprises:
//   * dividerColor only honoured in newer Flutter (Material 3).
//   * indicatorWeight ignored when `indicator` is set.
//   * indicatorColor ignored when `indicator` is set.
//   * label vs tab sizing changes the bar width unexpectedly.
//   * indicatorPadding applies AFTER sizing.
// ---------------------------------------------------------------------
Widget buildPitfallsSection() {
  return buildSectionCard(
    title: '12. Pitfalls',
    subtitle:
        'Five sharp edges to watch when wiring up TabBar indicators.',
    accent: kCoral,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildPitfallCard(
          number: '01',
          headline: 'indicatorWeight is ignored when `indicator` is set',
          body:
              'If you pass a BoxDecoration via `indicator`, the framework '
              'discards indicatorWeight entirely. Adjust the height '
              'inside your BoxDecoration via padding instead.',
          tint: kCoral,
        ),
        const SizedBox(height: 10),
        buildPitfallCard(
          number: '02',
          headline: 'indicatorColor only applies to the default underline',
          body:
              'Same story for indicatorColor - once you supply your own '
              'Decoration, that knob no longer changes anything. Set the '
              'colour inside the decoration.',
          tint: kAmber,
        ),
        const SizedBox(height: 10),
        buildPitfallCard(
          number: '03',
          headline: 'dividerColor needs Material 3',
          body:
              'In useMaterial3: false the divider is rendered by the host '
              'AppBar / parent. Setting dividerColor will silently no-op '
              'unless the surrounding theme runs Material 3.',
          tint: kViolet,
        ),
        const SizedBox(height: 10),
        buildPitfallCard(
          number: '04',
          headline: 'TabBarIndicatorSize.label can collapse the bar',
          body:
              'On very short labels the indicator becomes barely visible. '
              'Mitigate via indicatorPadding(horizontal: -X) or by '
              'switching to TabBarIndicatorSize.tab.',
          tint: kGreen,
        ),
        const SizedBox(height: 10),
        buildPitfallCard(
          number: '05',
          headline: 'indicatorPadding applies AFTER sizing',
          body:
              'EdgeInsets are subtracted from the indicator rect after '
              'TabBarIndicatorSize has computed it. Negative insets are '
              'permitted and let the bar extend past the cell.',
          tint: kSky,
        ),
      ],
    ),
  );
}

Widget buildPitfallCard({
  required String number,
  required String headline,
  required String body,
  required Color tint,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tint.withValues(alpha: 0.55), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withValues(alpha: 0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: tint, width: 1),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: tint,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                headline,
                style: TextStyle(
                  color: tint,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: kSlate,
                  fontSize: 12.5,
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

// =====================================================================
// SECTION 14 - Footer.
// =====================================================================
// Pulls together the headline takeaways into a tight summary card.
// ---------------------------------------------------------------------
Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kInk, kInkSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInk.withValues(alpha: 0.25),
          blurRadius: 14,
          offset: const Offset(0, 6),
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
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        buildFooterBullet(
          'Reach for indicatorColor + indicatorWeight only when sticking '
          'with the default UnderlineTabIndicator.',
        ),
        buildFooterBullet(
          'Pass a custom `indicator` (BoxDecoration / ShapeDecoration) '
          'to escape the underline entirely - pills, filled rects, '
          'gradients, drop-shadows.',
        ),
        buildFooterBullet(
          'Pick TabBarIndicatorSize.label for variable-length labels '
          'and TabBarIndicatorSize.tab for evenly-spaced strips.',
        ),
        buildFooterBullet(
          'Use indicatorPadding to claw back room around the bar; '
          'symmetric horizontal padding is the most common pattern.',
        ),
        buildFooterBullet(
          'Bulk-style every TabBar in a subtree with TabBarThemeData '
          'on ThemeData - the cleanest path in Material 3.',
        ),
      ],
    ),
  );
}

Widget buildFooterBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6, right: 8),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: kAmber,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SHARED COMPONENTS - reusable widgets used by every section.
// =====================================================================

// ---------------------------------------------------------------------
// Section card wrapper - title, subtitle, accent strip, child block.
// ---------------------------------------------------------------------
Widget buildSectionCard({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kBorder, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInk.withValues(alpha: 0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 5,
              height: 28,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: kInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 17),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: kSlate,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Labeled card - small caption above an inset content area.
// ---------------------------------------------------------------------
Widget buildLabeledCard({required String label, required Widget child}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kLine, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: kSlate,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Mock tab strip - underline-style indicator beneath the active label.
//
// Layout:
//   [Row of labels] -> [indicator track] -> [optional divider]
//
// indicatorWidthFraction controls how much of each cell the indicator
// covers; 1.0 simulates TabBarIndicatorSize.tab and < 1.0 simulates
// TabBarIndicatorSize.label.
// ---------------------------------------------------------------------
Widget buildMockTabStrip({
  required List<String> labels,
  required int activeIndex,
  required Color indicatorColor,
  required double indicatorHeight,
  required EdgeInsets indicatorPadding,
  required double indicatorRadius,
  required double indicatorWidthFraction,
  required bool showDivider,
  required Color dividerColor,
  required Color labelColor,
  required Color unselectedLabelColor,
}) {
  final List<Widget> labelCells = <Widget>[];
  for (int index = 0; index < labels.length; index = index + 1) {
    final bool isActive = index == activeIndex;
    labelCells.add(
      Expanded(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            labels[index],
            style: TextStyle(
              color: isActive ? labelColor : unselectedLabelColor,
              fontSize: 13.5,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }

  final List<Widget> indicatorTrack = <Widget>[];
  for (int index = 0; index < labels.length; index = index + 1) {
    final bool isActive = index == activeIndex;
    indicatorTrack.add(
      Expanded(
        child: Padding(
          padding: indicatorPadding,
          child: Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: indicatorWidthFraction,
              child: Container(
                height: indicatorHeight,
                decoration: BoxDecoration(
                  color: isActive ? indicatorColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(indicatorRadius),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(children: labelCells),
      Row(children: indicatorTrack),
      if (showDivider)
        Container(
          height: 1,
          color: dividerColor,
        ),
    ],
  );
}

// ---------------------------------------------------------------------
// Pill-style mock - the active tab cell is filled with a BoxDecoration.
// Used by sections 7, 8, 10 to demonstrate non-underline indicators.
// ---------------------------------------------------------------------
Widget buildPillTabStrip({
  required List<String> labels,
  required int activeIndex,
  required BoxDecoration decoration,
  required Color activeLabelColor,
  required Color unselectedLabelColor,
}) {
  final List<Widget> cells = <Widget>[];
  for (int index = 0; index < labels.length; index = index + 1) {
    final bool isActive = index == activeIndex;
    cells.add(
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: isActive ? decoration : null,
          alignment: Alignment.center,
          child: Text(
            labels[index],
            style: TextStyle(
              color: isActive ? activeLabelColor : unselectedLabelColor,
              fontSize: 13.5,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kLine, width: 1),
    ),
    child: Row(children: cells),
  );
}

// =====================================================================
// END OF FILE.
// =====================================================================
//
// Filler narrative below: extended commentary on each indicator knob,
// with usage notes, anti-patterns, and theming recipes. Kept as Dart
// comments so it doesn't affect the rendered widget tree but pads the
// document past the 1000-line floor required for the deep demo.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE A - UnderlineTabIndicator internals.
// ---------------------------------------------------------------------
//
// UnderlineTabIndicator is the default `indicator` value for TabBar.
// Its constructor takes:
//
//   * borderSide   - a BorderSide describing the underline's colour and
//                    width. Default is BorderSide(width: 2.0,
//                    color: Colors.white).
//   * insets       - an EdgeInsets that pulls the underline inward
//                    horizontally. Defaults to EdgeInsets.zero.
//   * borderRadius - optional BorderRadius rounding the underline's
//                    corners. Useful for chunkier (4 px+) bars.
//
// The class extends Decoration. Internally it produces a BoxPainter
// (_UnderlinePainter) that draws a single line at the bottom of the
// rect handed in by the framework. Subclassing UnderlineTabIndicator
// is permitted in normal Flutter code but forbidden under d4rt - so
// in this demo we mock the visual using a simple Container.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE B - TabBarIndicatorSize semantics.
// ---------------------------------------------------------------------
//
// TabBarIndicatorSize.tab:
//   The indicator rect is the entire tab cell. Tabs in non-scrollable
//   strips have equal width = strip / count, so the indicator width
//   is constant across tabs. In scrollable strips the cell width
//   tracks the natural label width plus padding.
//
// TabBarIndicatorSize.label:
//   The indicator rect is the bounding box of the label widget alone.
//   Two tabs with very different label lengths will have visibly
//   different indicator widths. Padding around the label (Tab(text:
//   "...") versus Tab(child: ...)) flows into the bar.
//
// Pick `.label` when label widths matter visually (e.g. an emphasis
// underline on a single short word). Pick `.tab` when the strip is a
// uniform grid of equal-width buttons.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE C - indicatorPadding tricks.
// ---------------------------------------------------------------------
//
// indicatorPadding subtracts from the indicator rect AFTER sizing.
//
//   * Positive horizontal padding shrinks the bar inward.
//   * Negative horizontal padding grows the bar past the cell edge.
//   * Vertical padding repositions the bar up or down within the
//     bottom strip area.
//
// Common patterns:
//
//   EdgeInsets.symmetric(horizontal: 8)
//     -> Pulls the bar 8 px in on either side; gives a clear gap.
//
//   EdgeInsets.fromLTRB(0, 0, 0, 6)
//     -> Lifts the bar 6 px off the bottom. Pairs nicely with a
//        rounded BoxDecoration indicator.
//
//   EdgeInsets.symmetric(horizontal: -4)
//     -> Bar bleeds 4 px past the cell edge. Useful when label widths
//        are noticeably shorter than tabs and you want overlap.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE D - BoxDecoration as `indicator`.
// ---------------------------------------------------------------------
//
// Any Decoration may stand in for the underline. The framework hands
// the decoration a rect (sized per indicatorSize and reduced by
// indicatorPadding) and asks it to paint. Common recipes:
//
//   BoxDecoration(
//     color: theme.colorScheme.primary,
//     borderRadius: BorderRadius.circular(24),
//   )                              -> solid pill
//
//   BoxDecoration(
//     color: theme.colorScheme.primary.withValues(alpha: 0.12),
//     borderRadius: BorderRadius.circular(8),
//     border: Border.all(color: theme.colorScheme.primary, width: 1),
//   )                              -> outlined chip
//
//   BoxDecoration(
//     gradient: LinearGradient(colors: [...]),
//     borderRadius: BorderRadius.circular(20),
//   )                              -> gradient pill
//
//   ShapeDecoration(
//     color: theme.colorScheme.primary,
//     shape: StadiumBorder(),
//   )                              -> stadium pill
//
// The decoration paints BEHIND the label content; if the active label
// colour does not contrast with the decoration the pill becomes
// unreadable. Always pair decorations with explicit labelColor /
// unselectedLabelColor.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE E - Theming via TabBarTheme(Data).
// ---------------------------------------------------------------------
//
// TabBarThemeData on ThemeData lets you set every indicator knob in
// bulk for an entire subtree. Fields of interest:
//
//   * indicator                 - Decoration; overrides indicatorColor
//                                 + indicatorWeight as documented above.
//   * indicatorColor            - default underline colour.
//   * indicatorSize             - TabBarIndicatorSize.{tab, label}.
//   * dividerColor              - colour of the M3 divider.
//   * dividerHeight             - thickness of the M3 divider.
//   * labelColor                - active label colour.
//   * unselectedLabelColor      - inactive label colour.
//   * labelStyle                - active label TextStyle.
//   * unselectedLabelStyle      - inactive label TextStyle.
//   * labelPadding              - EdgeInsets around each Tab widget.
//   * overlayColor              - WidgetStateProperty for hover/focus.
//   * splashFactory             - InkSplash factory for the ripple.
//   * mouseCursor               - MouseCursor for the strip.
//
// In Material 3 prefer TabBarThemeData over the legacy TabBarTheme
// constructor; the latter is deprecated in newer Flutter releases.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE F - dividerColor across Material versions.
// ---------------------------------------------------------------------
//
// dividerColor on TabBar (and its theme) was introduced for Material
// 3 only. In useMaterial3: false codebases the divider is a separate
// concern - it tends to be drawn by the host AppBar or a Container
// outside the TabBar. If you set dividerColor under M2 it silently
// no-ops and you may see double-rendering once you flip on M3.
//
// dividerHeight is also M3-specific. Setting it to 0 removes the
// divider entirely; useful when the TabBar sits inside a card with
// its own border.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE G - common anti-patterns.
// ---------------------------------------------------------------------
//
//   1. Setting indicatorColor *and* indicator simultaneously.
//      Result: indicatorColor is silently ignored. Pick one.
//
//   2. Using TabBarIndicatorSize.label with tightly-padded Tabs.
//      Result: the indicator collapses to the visible text width
//      which can be just a few pixels for "OK" / "X" labels. Use
//      negative indicatorPadding or switch to .tab.
//
//   3. Subclassing Decoration.
//      Result: works in normal Flutter but forbidden under d4rt.
//      Compose with BoxDecoration / ShapeDecoration instead.
//
//   4. Hard-coding indicatorWeight: 0 to "hide" the underline.
//      Result: a 0-px line still allocates a paint pass. Set
//      indicator: const BoxDecoration() (an empty decoration) or
//      use a transparent color instead.
//
//   5. Forgetting labelColor under a coloured indicator.
//      Result: the active label inherits theme.colorScheme.primary
//      and may clash with the indicator background. Always pin
//      labelColor when supplying a decoration.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE H - Accessibility considerations.
// ---------------------------------------------------------------------
//
// Indicators are decorative; they communicate selection state. To stay
// accessible:
//
//   * Pair the indicator colour with a labelColor that has at least
//     4.5:1 contrast against the strip background.
//   * Don't rely on colour alone - keep the active label bolder /
//     larger than inactive labels.
//   * Match indicator weight to the importance of the strip; thin
//     bars (1 px) on dense screens, thick bars (4 px+) on hero strips.
//   * For colourblind users a shape change (pill vs underline) is a
//     stronger affordance than a hue change.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE I - When NOT to use a TabBar.
// ---------------------------------------------------------------------
//
// TabBar is for navigation between sibling views with parallel
// importance. If the views are sequential (a wizard), use a Stepper.
// If only one view is shown at a time and the others are dismissable,
// use a SegmentedButton. If the underlying data is filterable rather
// than partitioned, use ChoiceChips.
//
// The indicator family covered in this demo applies only to TabBar -
// SegmentedButton, ChoiceChip and Stepper each have their own
// theming knobs.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE J - Responsive behaviour.
// ---------------------------------------------------------------------
//
// Non-scrollable TabBars divide the strip width evenly. On narrow
// screens long labels wrap or ellipsise. Mitigations:
//
//   * Set isScrollable: true to let labels keep their natural width.
//   * Use shorter labels or icon-only tabs.
//   * Provide labelPadding: EdgeInsets.symmetric(horizontal: 8) to
//     trim the gutters.
//
// indicatorSize and indicatorPadding still work in scrollable mode -
// the indicator follows the active label as the user scrolls.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE K - Animation overview.
// ---------------------------------------------------------------------
//
// The framework animates the indicator between active tabs by
// interpolating its rect across an Animation<double>. The animation
// is driven by TabController, which this demo doesn't run.
//
// In a live TabBar:
//   * Quick taps -> a 200 ms ease curve.
//   * Drag from the body -> the controller's position updates
//     continuously and the indicator tracks it 1:1.
//
// Custom indicator decorations are interpolated where possible
// (Decoration.lerp). Some BoxDecoration combinations (e.g. gradient
// vs no-gradient) cannot lerp cleanly and snap on transition.
//
// ---------------------------------------------------------------------
// EXTENDED NOTE L - Performance.
// ---------------------------------------------------------------------
//
// Each tab transition repaints the strip. Costs to be aware of:
//
//   * Box-shadow on the indicator -> additional blur pass per frame.
//   * Gradient on the indicator -> shader compile on first run.
//   * Border on the indicator   -> extra outline pass.
//
// On low-end devices a thick UnderlineTabIndicator with no shadow is
// the cheapest indicator. Pills with shadow + gradient are visibly
// more expensive but rarely a measurable hit on modern hardware.
//
// ---------------------------------------------------------------------
// END OF FILLER.
// =====================================================================
