// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: DesktopTextSelectionToolbarButton.
//
// Palette: deep slate + electric teal. Static render, no animation.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette constants — desktop toolbar feels darker, more compact.
// ---------------------------------------------------------------------------
const Color kSlate = Color(0xFF101826);
const Color kSlateDeep = Color(0xFF060A14);
const Color kSlateSoft = Color(0xFF1B2638);
const Color kSlateLine = Color(0xFF2A3852);
const Color kTeal = Color(0xFF14E0C8);
const Color kTealSoft = Color(0xFF5BF3DE);
const Color kTealDeep = Color(0xFF008C7E);
const Color kPaper = Color(0xFFF2F5FA);
const Color kPaperAlt = Color(0xFFE2E8F2);
const Color kPaperEdge = Color(0xFFCBD3E0);
const Color kInk = Color(0xFF0A1426);
const Color kInkMuted = Color(0xFF44516B);
const Color kInkFaint = Color(0xFF6B7891);
const Color kAmber = Color(0xFFFFB020);
const Color kRose = Color(0xFFFF5181);
const Color kViolet = Color(0xFF8A5BFF);
const Color kVioletSoft = Color(0xFFB89BFF);
const Color kLime = Color(0xFFA8E600);
const Color kSky = Color(0xFF38C1FF);

// ---------------------------------------------------------------------------
// No-op callback references — onPressed handlers required, not invoked.
// ---------------------------------------------------------------------------
void noopCut() {}
void noopCopy() {}
void noopPaste() {}
void noopSelectAll() {}
void noopDelete() {}
void noopLookUp() {}
void noopTranslate() {}
void noopShare() {}
void noopSearch() {}
void noopUndo() {}
void noopRedo() {}
void noopFormat() {}
void noopComment() {}

// ---------------------------------------------------------------------------
// Entry point — every section is its own builder; reads top-down.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kPaper,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTitleHero(),
          const SizedBox(height: 22),
          buildSectionLabel(
            tag: '01',
            title: 'Anatomy',
            subtitle:
                'A desktop selection toolbar is a small floating menu — '
                'one row of compact rectangular buttons.',
          ),
          const SizedBox(height: 14),
          buildAnatomyDiagram(),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '02',
            title: 'Single button gallery',
            subtitle:
                'Default constructor, .text named constructor, '
                'custom padding, custom child.',
          ),
          const SizedBox(height: 14),
          buildButtonGallery(context),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '03',
            title: 'Mock toolbar — classic',
            subtitle: 'Cut · Copy · Paste · Select All · Delete.',
          ),
          const SizedBox(height: 14),
          buildClassicToolbarMock(context),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '04',
            title: 'Mock toolbar — extended',
            subtitle: 'With dividers separating logical groups.',
          ),
          const SizedBox(height: 14),
          buildExtendedToolbarMock(context),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '05',
            title: 'Themed variant',
            subtitle: 'ColorScheme flowing through the toolbar surface.',
          ),
          const SizedBox(height: 14),
          buildThemedToolbarMock(context),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '06',
            title: 'State visualisation',
            subtitle:
                'Static decoration mocks for default / hover / focus / '
                'pressed / disabled.',
          ),
          const SizedBox(height: 14),
          buildStateGallery(),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '07',
            title: 'RTL layout',
            subtitle: 'The same toolbar wrapped in Directionality.rtl.',
          ),
          const SizedBox(height: 14),
          buildRtlToolbarMock(context),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '08',
            title: 'Code skeleton',
            subtitle:
                'How DesktopTextSelectionToolbar.buildToolbar wires its '
                'children together.',
          ),
          const SizedBox(height: 14),
          buildCodeCard(),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '09',
            title: 'Desktop vs Mobile',
            subtitle:
                'DesktopTextSelectionToolbarButton vs '
                'TextSelectionToolbarTextButton side by side.',
          ),
          const SizedBox(height: 14),
          buildComparisonStrip(context),
          const SizedBox(height: 28),
          buildSectionLabel(
            tag: '10',
            title: 'Pitfalls & accessibility',
            subtitle: 'Things that bite you when you adopt this widget.',
          ),
          const SizedBox(height: 14),
          buildPitfallsPanel(),
          const SizedBox(height: 28),
          buildFooter(),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 0 — Title hero
// ===========================================================================
Widget buildTitleHero() {
  return Container(
    padding: const EdgeInsets.fromLTRB(26, 24, 26, 26),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kSlateDeep, kSlate, kSlateSoft],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: kTeal.withValues(alpha: 0.25), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kSlateDeep.withValues(alpha: 0.45),
          blurRadius: 28,
          offset: const Offset(0, 14),
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
            color: kTeal.withValues(alpha: 0.14),
            border: Border.all(color: kTeal, width: 1.6),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Text(
              'Dt',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: kTeal,
                letterSpacing: 1.4,
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DesktopTextSelectionToolbarButton',
                style: TextStyle(
                  color: kPaper,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                  shadows: <Shadow>[
                    Shadow(
                      color: kTeal.withValues(alpha: 0.55),
                      blurRadius: 14,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'The compact rectangular button used inside Material\'s '
                'desktop text-selection toolbar (Cut · Copy · Paste …).',
                style: TextStyle(
                  color: Color(0xFFB7C4DA),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  buildHeroChip('material', kTeal),
                  buildHeroChip('desktop', kSky),
                  buildHeroChip('toolbar item', kViolet),
                  buildHeroChip('static demo', kAmber),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildHeroChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.16),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — Section label helper
// ===========================================================================
Widget buildSectionLabel({
  required String tag,
  required String title,
  required String subtitle,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kPaperEdge, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kSlateDeep.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[kTealDeep, kTeal],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              tag,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: kInk,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: kInkMuted,
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

// ===========================================================================
// SECTION 2 — Anatomy diagram
// ===========================================================================
Widget buildAnatomyDiagram() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kPaperEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A desktop selection toolbar is a horizontally-laid floating bar '
          'positioned next to the text caret. Each of its slots is a '
          'DesktopTextSelectionToolbarButton.',
          style: TextStyle(color: kInkMuted, fontSize: 12.5, height: 1.5),
        ),
        const SizedBox(height: 18),
        // Faux text editor pane with selection.
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: kPaperAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPaperEdge, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'The quick brown ',
                style: TextStyle(
                  color: kInk,
                  fontSize: 15,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: kTeal.withValues(alpha: 0.4),
                    child: const Text(
                      'fox jumps over',
                      style: TextStyle(
                        color: kInk,
                        fontSize: 15,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const Text(
                    ' the lazy dog.',
                    style: TextStyle(
                      color: kInk,
                      fontSize: 15,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Mock floating toolbar with arrow.
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildAnatomyToolbar(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Annotated breakdown
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kSlate,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: kTeal.withValues(alpha: 0.35), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Slots inside the toolbar surface:',
                style: TextStyle(
                  color: kTealSoft,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 12),
              buildAnatomyRow('outer surface', 'Material elevation + radius',
                  kTeal),
              buildAnatomyRow('button slot', 'DesktopTextSelectionToolbarButton',
                  kSky),
              buildAnatomyRow('child', 'Text or Row of icon + label', kAmber),
              buildAnatomyRow('padding', 'EdgeInsetsGeometry around child',
                  kViolet),
              buildAnatomyRow('hover/focus', 'Material InkWell highlight',
                  kRose),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAnatomyToolbar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    decoration: BoxDecoration(
      color: kSlate,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: kSlateLine, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kSlateDeep.withValues(alpha: 0.55),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildFauxToolbarBtn('Cut'),
        buildFauxToolbarBtn('Copy', highlight: true),
        buildFauxToolbarBtn('Paste'),
      ],
    ),
  );
}

Widget buildFauxToolbarBtn(String label, {bool highlight = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 1),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: highlight
          ? kTeal.withValues(alpha: 0.25)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: highlight ? kTealSoft : kPaper,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget buildAnatomyRow(String head, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 9,
          height: 9,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 110,
          child: Text(
            head,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            detail,
            style: const TextStyle(
              color: Color(0xFFB7C4DA),
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 3 — Single button gallery
// ===========================================================================
Widget buildButtonGallery(BuildContext context) {
  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    childAspectRatio: 1.65,
    mainAxisSpacing: 14,
    crossAxisSpacing: 14,
    children: <Widget>[
      buildGalleryCell(
        title: 'Default constructor',
        snippet:
            'DesktopTextSelectionToolbarButton(\n  onPressed: () {},\n  child: Text(\'Cut\'),\n)',
        accent: kTeal,
        body: DesktopTextSelectionToolbarButton(
          onPressed: noopCut,
          child: const Text('Cut'),
        ),
      ),
      buildGalleryCell(
        title: '.text named constructor',
        snippet:
            'DesktopTextSelectionToolbarButton.text(\n  context: context,\n  onPressed: () {},\n  text: \'Copy\',\n)',
        accent: kSky,
        body: DesktopTextSelectionToolbarButton.text(
          context: context,
          onPressed: noopCopy,
          text: 'Copy',
        ),
      ),
      buildGalleryCell(
        title: 'Custom padding (via child)',
        snippet:
            'DesktopTextSelectionToolbarButton(\n  child: Padding(\n    padding: EdgeInsets.symmetric(\n      horizontal: 24, vertical: 10),\n    child: Text(\'Paste\')),\n)',
        accent: kViolet,
        body: DesktopTextSelectionToolbarButton(
          onPressed: noopPaste,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Text('Paste'),
          ),
        ),
      ),
      buildGalleryCell(
        title: 'Custom child (icon + text)',
        snippet:
            'child: Row(\n  mainAxisSize: MainAxisSize.min,\n  children: [Icon(...), Text(\'Search\')],\n)',
        accent: kAmber,
        body: DesktopTextSelectionToolbarButton(
          onPressed: noopSearch,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.search, size: 16, color: kInk),
              SizedBox(width: 6),
              Text('Search the web'),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildGalleryCell({
  required String title,
  required String snippet,
  required Color accent,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kPaperEdge, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.06),
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
              height: 22,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: kInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPaperAlt,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kPaperEdge, width: 1),
            ),
            child: Material(
              color: Colors.transparent,
              child: body,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: kSlateDeep,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            snippet,
            style: TextStyle(
              color: accent.withValues(alpha: 0.9),
              fontFamily: 'monospace',
              fontSize: 10.8,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 — Classic toolbar mock
// ===========================================================================
Widget buildClassicToolbarMock(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kPaperAlt, kPaper],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kPaperEdge, width: 1),
    ),
    child: Column(
      children: <Widget>[
        const Text(
          'Anchored next to a caret — width hugs the buttons.',
          style: TextStyle(color: kInkMuted, fontSize: 12),
        ),
        const SizedBox(height: 18),
        Center(
          child: buildToolbarSurface(
            context: context,
            color: kSlate,
            border: kSlateLine,
            children: <Widget>[
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopCut,
                text: 'Cut',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopCopy,
                text: 'Copy',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopPaste,
                text: 'Paste',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopSelectAll,
                text: 'Select all',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopDelete,
                text: 'Delete',
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        buildClassicLegend(),
      ],
    ),
  );
}

Widget buildClassicLegend() {
  return Wrap(
    spacing: 14,
    runSpacing: 8,
    alignment: WrapAlignment.center,
    children: <Widget>[
      buildLegendDot('Cut', kTeal),
      buildLegendDot('Copy', kSky),
      buildLegendDot('Paste', kViolet),
      buildLegendDot('Select all', kAmber),
      buildLegendDot('Delete', kRose),
    ],
  );
}

Widget buildLegendDot(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 6),
      Text(
        label,
        style: const TextStyle(color: kInkMuted, fontSize: 11),
      ),
    ],
  );
}

Widget buildToolbarSurface({
  required BuildContext context,
  required Color color,
  required Color border,
  required List<Widget> children,
  Color? textColor,
}) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #40, P1):
  // DesktopTextSelectionToolbarButton internally wraps its TextButton in
  // SizedBox(width: double.infinity) so it stretches to fill the parent
  // toolbar. Inside this mock we lay them out via Row(mainAxisSize: min)
  // whose first pass hands each child unbounded width, and the
  // double.infinity child trips "BoxConstraints forces an infinite width".
  // Wrap each child in IntrinsicWidth so the row queries the TextButton's
  // intrinsic width (finite — driven by label text) before performing
  // layout, giving the SizedBox a bounded constraint to clamp against.
  final List<Widget> sized = <Widget>[
    for (final Widget c in children) IntrinsicWidth(child: c),
  ];
  return Material(
    color: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: border, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kSlateDeep.withValues(alpha: 0.45),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: textColor ?? kPaper,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: textColor ?? kPaper,
            size: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: sized,
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 5 — Extended toolbar mock with dividers
// ===========================================================================
Widget buildExtendedToolbarMock(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kPaperEdge, width: 1),
    ),
    child: Column(
      children: <Widget>[
        const Text(
          'Heavier menu — split into edit / lookup / share groups.',
          style: TextStyle(color: kInkMuted, fontSize: 12),
        ),
        const SizedBox(height: 18),
        Center(
          child: buildToolbarSurface(
            context: context,
            color: kSlate,
            border: kSlateLine,
            children: <Widget>[
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopCut,
                text: 'Cut',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopCopy,
                text: 'Copy',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopPaste,
                text: 'Paste',
              ),
              buildToolbarDivider(),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopSelectAll,
                text: 'Select all',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopLookUp,
                text: 'Look up',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopTranslate,
                text: 'Translate',
              ),
              buildToolbarDivider(),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopShare,
                text: 'Share',
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: kPaperAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPaperEdge, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.lightbulb_outline,
                  size: 16, color: kAmber),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Dividers are not part of '
                  'DesktopTextSelectionToolbarButton — you usually wrap each '
                  'group with a thin Container holding a vertical Divider.',
                  style: TextStyle(
                    color: kInkMuted.withValues(alpha: 0.9),
                    fontSize: 11.5,
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

Widget buildToolbarDivider() {
  return Container(
    width: 1,
    height: 18,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    color: kSlateLine,
  );
}

// ===========================================================================
// SECTION 6 — Themed variant
// ===========================================================================
Widget buildThemedToolbarMock(BuildContext context) {
  final ColorScheme scheme = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          scheme.primary.withValues(alpha: 0.06),
          scheme.secondary.withValues(alpha: 0.04),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kPaperEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Theme.of(context).colorScheme drives the surface and onSurface',
          style: TextStyle(
            color: scheme.onSurface.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: scheme.copyWith(
                primary: kViolet,
                onPrimary: Colors.white,
                surface: const Color(0xFF1B1438),
                onSurface: kVioletSoft,
              ),
            ),
            child: Builder(
              builder: (BuildContext ctx) {
                return buildToolbarSurface(
                  context: ctx,
                  color: const Color(0xFF1B1438),
                  border: kViolet.withValues(alpha: 0.4),
                  textColor: kVioletSoft,
                  children: <Widget>[
                    DesktopTextSelectionToolbarButton.text(
                      context: ctx,
                      onPressed: noopCut,
                      text: 'Cut',
                    ),
                    DesktopTextSelectionToolbarButton.text(
                      context: ctx,
                      onPressed: noopCopy,
                      text: 'Copy',
                    ),
                    DesktopTextSelectionToolbarButton.text(
                      context: ctx,
                      onPressed: noopPaste,
                      text: 'Paste',
                    ),
                    DesktopTextSelectionToolbarButton.text(
                      context: ctx,
                      onPressed: noopFormat,
                      text: 'Format',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 22),
        buildThemedSwatchRow(scheme),
      ],
    ),
  );
}

Widget buildThemedSwatchRow(ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kPaperEdge, width: 1),
    ),
    child: Row(
      children: <Widget>[
        buildSwatch('primary', kViolet),
        buildSwatch('onPrimary', Colors.white),
        buildSwatch('surface', const Color(0xFF1B1438)),
        buildSwatch('onSurface', kVioletSoft),
        buildSwatch(
            'inverse', scheme.inverseSurface.withValues(alpha: 0.9)),
      ],
    ),
  );
}

Widget buildSwatch(String name, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: kPaperEdge, width: 1),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: estimateContrast(color),
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

Color estimateContrast(Color bg) {
  final double luminance =
      (bg.red * 0.299 + bg.green * 0.587 + bg.blue * 0.114) / 255.0;
  return luminance > 0.55 ? kInk : Colors.white;
}

// ===========================================================================
// SECTION 7 — State visualisation
// ===========================================================================
Widget buildStateGallery() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: kSlate,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: kTeal.withValues(alpha: 0.25),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Faux-decoration mocks — the script is static, so we simulate '
          'each state with a Container.',
          style: TextStyle(
            color: kPaper.withValues(alpha: 0.75),
            fontSize: 12,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: WrapAlignment.center,
          children: <Widget>[
            buildStateCell('default', StateVisualKind.defaultState),
            buildStateCell('hovered', StateVisualKind.hovered),
            buildStateCell('focused', StateVisualKind.focused),
            buildStateCell('pressed', StateVisualKind.pressed),
            buildStateCell('disabled', StateVisualKind.disabled),
          ],
        ),
        const SizedBox(height: 18),
        buildStateLegend(),
      ],
    ),
  );
}

enum StateVisualKind { defaultState, hovered, focused, pressed, disabled }

Widget buildStateCell(String label, StateVisualKind state) {
  Color background;
  Color borderColor;
  Color textColor;
  double borderWidth;
  List<BoxShadow> shadow;
  switch (state) {
    case StateVisualKind.defaultState:
      background = Colors.transparent;
      borderColor = kSlateLine;
      textColor = kPaper;
      borderWidth = 1;
      shadow = const <BoxShadow>[];
      break;
    case StateVisualKind.hovered:
      background = kTeal.withValues(alpha: 0.16);
      borderColor = kTeal.withValues(alpha: 0.55);
      textColor = kTealSoft;
      borderWidth = 1;
      shadow = <BoxShadow>[
        BoxShadow(
          color: kTeal.withValues(alpha: 0.25),
          blurRadius: 10,
          offset: const Offset(0, 0),
        ),
      ];
      break;
    case StateVisualKind.focused:
      background = Colors.transparent;
      borderColor = kTeal;
      textColor = kPaper;
      borderWidth = 2;
      shadow = <BoxShadow>[
        BoxShadow(
          color: kTeal.withValues(alpha: 0.35),
          blurRadius: 12,
          offset: const Offset(0, 0),
        ),
      ];
      break;
    case StateVisualKind.pressed:
      background = kTeal.withValues(alpha: 0.32);
      borderColor = kTealSoft;
      textColor = Colors.white;
      borderWidth = 1;
      shadow = const <BoxShadow>[];
      break;
    case StateVisualKind.disabled:
      background = Colors.transparent;
      borderColor = kSlateLine.withValues(alpha: 0.6);
      textColor = kInkFaint;
      borderWidth = 1;
      shadow = const <BoxShadow>[];
      break;
  }
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: shadow,
        ),
        child: Text(
          'Copy',
          style: TextStyle(
            color: textColor,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          color: kInkFaint,
          fontSize: 11,
          fontFamily: 'monospace',
          letterSpacing: 0.6,
        ),
      ),
    ],
  );
}

Widget buildStateLegend() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kSlateDeep,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildStateLegendRow(
            'default', 'idle button surface — transparent', kInkFaint),
        buildStateLegendRow(
            'hovered', 'pointer overlay (cyan tint, soft glow)', kTeal),
        buildStateLegendRow(
            'focused', 'keyboard focus ring (2-px outline)', kTealSoft),
        buildStateLegendRow(
            'pressed', 'down-state — saturated overlay', kTeal),
        buildStateLegendRow(
            'disabled', 'reduced contrast text + muted border', kInkFaint),
      ],
    ),
  );
}

Widget buildStateLegendRow(String head, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 72,
          child: Text(
            head,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            detail,
            style: const TextStyle(
              color: Color(0xFFB7C4DA),
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — RTL toolbar layout
// ===========================================================================
Widget buildRtlToolbarMock(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kPaperEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Same buttons but with TextDirection.rtl — order flips visually.',
          textAlign: TextAlign.center,
          style: TextStyle(color: kInkMuted, fontSize: 12),
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  buildDirectionLabel('LTR', kSky),
                  const SizedBox(height: 10),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: buildToolbarSurface(
                      context: context,
                      color: kSlate,
                      border: kSlateLine,
                      children: <Widget>[
                        DesktopTextSelectionToolbarButton.text(
                          context: context,
                          onPressed: noopCut,
                          text: 'Cut',
                        ),
                        DesktopTextSelectionToolbarButton.text(
                          context: context,
                          onPressed: noopCopy,
                          text: 'Copy',
                        ),
                        DesktopTextSelectionToolbarButton.text(
                          context: context,
                          onPressed: noopPaste,
                          text: 'Paste',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                children: <Widget>[
                  buildDirectionLabel('RTL', kRose),
                  const SizedBox(height: 10),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: buildToolbarSurface(
                      context: context,
                      color: kSlate,
                      border: kSlateLine,
                      children: <Widget>[
                        DesktopTextSelectionToolbarButton.text(
                          context: context,
                          onPressed: noopCut,
                          text: 'قص',
                        ),
                        DesktopTextSelectionToolbarButton.text(
                          context: context,
                          onPressed: noopCopy,
                          text: 'نسخ',
                        ),
                        DesktopTextSelectionToolbarButton.text(
                          context: context,
                          onPressed: noopPaste,
                          text: 'لصق',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildDirectionLabel(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// ===========================================================================
// SECTION 9 — Code skeleton
// ===========================================================================
Widget buildCodeCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: kSlateDeep,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: kTeal.withValues(alpha: 0.25),
        width: 1,
      ),
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
                color: kRose,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: kAmber,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: kLime,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              'desktop_text_selection_toolbar.dart — sketch',
              style: TextStyle(
                color: kPaper.withValues(alpha: 0.75),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          '''DesktopTextSelectionToolbar(
  anchor: anchorAbove,
  children: <Widget>[
    DesktopTextSelectionToolbarButton.text(
      context: context,
      onPressed: () => editableText.cutSelection(...),
      text: 'Cut',
    ),
    DesktopTextSelectionToolbarButton.text(
      context: context,
      onPressed: () => editableText.copySelection(...),
      text: 'Copy',
    ),
    DesktopTextSelectionToolbarButton.text(
      context: context,
      onPressed: () => editableText.pasteText(...),
      text: 'Paste',
    ),
    DesktopTextSelectionToolbarButton.text(
      context: context,
      onPressed: () => editableText.selectAll(...),
      text: 'Select all',
    ),
  ],
)''',
          style: TextStyle(
            color: kTealSoft,
            fontFamily: 'monospace',
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: kSlate,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kSlateLine, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.bolt, color: kAmber, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The .text constructor inherits localized labels and the '
                  'TextSelectionThemeData from `context` — that\'s the path '
                  'most adopters should pick.',
                  style: TextStyle(
                    color: kPaper.withValues(alpha: 0.85),
                    fontSize: 11.5,
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

// ===========================================================================
// SECTION 10 — Comparison strip
// ===========================================================================
Widget buildComparisonStrip(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildComparisonBanner(),
      const SizedBox(height: 14),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: buildDesktopColumn(context)),
          const SizedBox(width: 14),
          Expanded(child: buildMobileColumn(context)),
        ],
      ),
      const SizedBox(height: 14),
      buildComparisonTable(),
    ],
  );
}

Widget buildComparisonBanner() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[kSlate, kTealDeep],
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.compare_arrows, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Same intent, different platform conventions.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'desktop ⇄ mobile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDesktopColumn(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kPaperEdge, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kSky.withValues(alpha: 0.06),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildColumnHeader('Desktop', 'Compact rectangle, inline row', kSky),
        const SizedBox(height: 14),
        Center(
          child: buildToolbarSurface(
            context: context,
            color: kSlate,
            border: kSlateLine,
            children: <Widget>[
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopCut,
                text: 'Cut',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopCopy,
                text: 'Copy',
              ),
              DesktopTextSelectionToolbarButton.text(
                context: context,
                onPressed: noopPaste,
                text: 'Paste',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        buildBulletPoint('small fixed font size', kSky),
        buildBulletPoint('hover/focus highlight via InkWell', kSky),
        buildBulletPoint('rectangular, dense padding', kSky),
        buildBulletPoint('typically dark surface', kSky),
      ],
    ),
  );
}

Widget buildMobileColumn(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kPaperEdge, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kViolet.withValues(alpha: 0.06),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildColumnHeader(
            'Mobile', 'Larger touch targets, capsule shape', kViolet),
        const SizedBox(height: 14),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(7),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kSlateDeep.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextSelectionToolbarTextButton(
                    onPressed: noopCut,
                    padding: TextSelectionToolbarTextButton.getPadding(0, 3),
                    child: const Text('Cut'),
                  ),
                  TextSelectionToolbarTextButton(
                    onPressed: noopCopy,
                    padding: TextSelectionToolbarTextButton.getPadding(1, 3),
                    child: const Text('Copy'),
                  ),
                  TextSelectionToolbarTextButton(
                    onPressed: noopPaste,
                    padding: TextSelectionToolbarTextButton.getPadding(2, 3),
                    child: const Text('Paste'),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        buildBulletPoint('larger font, thumbable hit area', kViolet),
        buildBulletPoint('uses position-aware padding', kViolet),
        buildBulletPoint('rounded toolbar surface', kViolet),
        buildBulletPoint('typically light surface', kViolet),
      ],
    ),
  );
}

Widget buildColumnHeader(String title, String subtitle, Color color) {
  return Row(
    children: <Widget>[
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: kInkMuted,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildBulletPoint(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.only(top: 7),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: kInkMuted,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonTable() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: kPaperAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kPaperEdge, width: 1),
    ),
    child: Column(
      children: <Widget>[
        buildTableHeader(),
        const SizedBox(height: 6),
        buildTableRow('shape', 'rectangular', 'capsule'),
        buildTableRow('font size', 'small (≈12)', 'larger (≈14)'),
        buildTableRow('padding', '7×3 default', 'position-aware'),
        buildTableRow('hover', 'InkWell highlight', 'press-only'),
        buildTableRow('icon', 'often inline', 'rare'),
        buildTableRow('surface', 'dark', 'light'),
      ],
    ),
  );
}

Widget buildTableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: kSlate,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            'attribute',
            style: TextStyle(
              color: kTealSoft,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const Expanded(
          flex: 3,
          child: Text(
            'desktop',
            style: TextStyle(
              color: kSky,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const Expanded(
          flex: 3,
          child: Text(
            'mobile',
            style: TextStyle(
              color: kVioletSoft,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTableRow(String attr, String desktop, String mobile) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    margin: const EdgeInsets.only(top: 3),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            attr,
            style: const TextStyle(
              color: kInk,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            desktop,
            style: const TextStyle(
              color: kInkMuted,
              fontSize: 11.5,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            mobile,
            style: const TextStyle(
              color: kInkMuted,
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 — Pitfalls & accessibility
// ===========================================================================
Widget buildPitfallsPanel() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.white, kPaperAlt],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kPaperEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Things that bite when you adopt this widget',
          style: TextStyle(
            color: kInk,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        buildPitfall(
          icon: Icons.error_outline,
          color: kRose,
          title: 'Disabled state requires onPressed: null',
          body: 'Passing a no-op callback keeps the button enabled visually. '
              'Pass null when the action cannot run.',
        ),
        buildPitfall(
          icon: Icons.text_fields,
          color: kSky,
          title: 'Localised labels',
          body: 'Use the .text constructor — it pulls localised strings via '
              'context. Hard-coding labels breaks i18n.',
        ),
        buildPitfall(
          icon: Icons.format_size,
          color: kAmber,
          title: 'Padding interplay',
          body: 'The default padding is intentionally small. If you push '
              'larger padding, the toolbar size grows and may overlap the '
              'caret.',
        ),
        buildPitfall(
          icon: Icons.accessibility_new,
          color: kLime,
          title: 'Focus traversal',
          body: 'Keyboard users need predictable arrow-key traversal. Avoid '
              'placing non-button widgets between buttons unless they are '
              'focus-skipped.',
        ),
        buildPitfall(
          icon: Icons.brush,
          color: kViolet,
          title: 'Theme cascading',
          body: 'Override TextSelectionThemeData high in the tree — the '
              'button reads colours from the surrounding theme.',
        ),
        const SizedBox(height: 14),
        buildAccessibilityCard(),
      ],
    ),
  );
}

Widget buildPitfall({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(
        color: color.withValues(alpha: 0.35),
        width: 1,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: const TextStyle(
                  color: kInkMuted,
                  fontSize: 11.5,
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

Widget buildAccessibilityCard() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kSlate,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: kTeal.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.accessibility,
                  size: 14, color: kTeal),
            ),
            const SizedBox(width: 10),
            const Text(
              'Accessibility checklist',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        buildA11yLine('label every button with a localised string'),
        buildA11yLine('pass null onPressed for unavailable actions'),
        buildA11yLine('keep tab order matching visual order'),
        buildA11yLine('verify minimum contrast for both surfaces'),
        buildA11yLine('do not rely on hover-only affordances'),
      ],
    ),
  );
}

Widget buildA11yLine(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.check, size: 14, color: kTeal),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: kPaper.withValues(alpha: 0.85),
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 12 — Footer
// ===========================================================================
Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[kSlateDeep, kSlate, kTealDeep],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: kTeal.withValues(alpha: 0.3),
        width: 1,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: kTeal.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kTeal, width: 1),
          ),
          child: const Center(
            child: Text(
              'Σ',
              style: TextStyle(
                color: kTeal,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'DesktopTextSelectionToolbarButton — wrap up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Compact rectangle for desktop selection toolbars. Use the '
                '.text constructor for localised strings, pass null onPressed '
                'for disabled state, and respect the surrounding theme.',
                style: TextStyle(
                  color: kPaper.withValues(alpha: 0.85),
                  fontSize: 11.5,
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
