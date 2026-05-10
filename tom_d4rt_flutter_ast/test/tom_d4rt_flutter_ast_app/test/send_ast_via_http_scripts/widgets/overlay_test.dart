// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =====================================================================
// VISUAL DEEP DEMO  --  Flutter `Overlay` widget
// =====================================================================
//
// This file is a hand-written, analyzer-friendly demo that documents the
// behaviour of `Overlay`, `OverlayState`, and `OverlayEntry`. Nothing in
// this file is run as a live overlay — the document only *describes* the
// API. Every visual is a static composition of `Container`, `Stack`,
// `Row`, `Column`, `Text`, and `CustomPaint` widgets, organised into
// nine themed sections inside a single `SingleChildScrollView`.
//
// The single entry point is `dynamic build(BuildContext)`, which returns
// a `MaterialApp` whose body is a long, scrollable lecture-style page.
//
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Palette and tokens.
// ---------------------------------------------------------------------

const Color kInkDeep = Color(0xFF101421);
const Color kInkSoft = Color(0xFF24304A);
const Color kPaper = Color(0xFFF5F2EA);
const Color kPaperWarm = Color(0xFFEFE7D6);
const Color kHeroFill = Color(0xFF1B2640);
const Color kHeroStripe = Color(0xFF2D3A55);
const Color kAccentRed = Color(0xFFD64545);
const Color kAccentBlue = Color(0xFF3A5BC3);
const Color kAccentGreen = Color(0xFF2D8F5F);
const Color kAccentAmber = Color(0xFFE0A84C);
const Color kAccentPurple = Color(0xFF7242B0);
const Color kAccentTeal = Color(0xFF2C7A85);
const Color kSubtleLine = Color(0xFFCCC1A8);

const double kPagePad = 26.0;
const double kSectionGap = 30.0;
const double kCardRadius = 14.0;
const double kInnerRadius = 8.0;

// ---------------------------------------------------------------------
// Public entry. Single static `dynamic build(BuildContext)`.
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('overlay_test: building visual deep demo');
  return MaterialApp(
    title: 'Overlay deep demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: kPaper,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: kInkDeep, fontSize: 14.0),
      ),
    ),
    home: Scaffold(
      backgroundColor: kPaper,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: kPagePad,
          vertical: kPagePad,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildHeroSection(),
            const SizedBox(height: kSectionGap),
            buildAnatomySection(),
            const SizedBox(height: kSectionGap),
            buildEntryFieldPanel(),
            const SizedBox(height: kSectionGap),
            buildLifecycleTimeline(),
            const SizedBox(height: kSectionGap),
            buildScenesSection(),
            const SizedBox(height: kSectionGap),
            buildOpaqueComparisonSection(),
            const SizedBox(height: kSectionGap),
            buildRearrangeDiagram(),
            const SizedBox(height: kSectionGap),
            buildLookupVariantsSection(),
            const SizedBox(height: kSectionGap),
            buildRecipeListing(),
            const SizedBox(height: kSectionGap),
            buildComparisonSection(),
            const SizedBox(height: kSectionGap),
            buildPitfallsSection(),
            const SizedBox(height: kSectionGap),
            buildFooter(),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// 1. Hero card -- the stack-of-cards graphic.
// =====================================================================

Widget buildHeroSection() {
  return Container(
    decoration: BoxDecoration(
      color: kHeroFill,
      borderRadius: BorderRadius.circular(kCardRadius),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkDeep.withValues(alpha: 0.20),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: buildHeroText()),
            const SizedBox(width: 18.0),
            buildStackOfCardsGraphic(),
          ],
        ),
        const SizedBox(height: 20.0),
        buildHeroBadgeRow(),
      ],
    ),
  );
}

Widget buildHeroText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const <Widget>[
      Text(
        'Overlay',
        style: TextStyle(
          color: kPaper,
          fontSize: 38.0,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          height: 1.0,
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        'an ordered stack of OverlayEntry items',
        style: TextStyle(
          color: kAccentAmber,
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 14.0),
      Text(
        'Overlay hosts the visual layers that float above the regular '
        'widget tree: route content, dialogs, snackbars, autocomplete '
        'menus, and tooltips. Each layer is an OverlayEntry (a builder '
        'plus two flags: opaque and maintainState). The OverlayState '
        'holds the entries and lays them out in a Stack.',
        style: TextStyle(color: kPaper, fontSize: 14.0, height: 1.5),
      ),
    ],
  );
}

Widget buildStackOfCardsGraphic() {
  return SizedBox(
    width: 220.0,
    height: 178.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          left: 0.0,
          top: 110.0,
          child: buildHeroCard(
            label: 'OverlayEntry #0',
            subLabel: 'route content',
            color: kAccentBlue,
            width: 200.0,
          ),
        ),
        Positioned(
          left: 14.0,
          top: 80.0,
          child: buildHeroCard(
            label: 'OverlayEntry #1',
            subLabel: 'snackbar',
            color: kAccentGreen,
            width: 188.0,
          ),
        ),
        Positioned(
          left: 28.0,
          top: 50.0,
          child: buildHeroCard(
            label: 'OverlayEntry #2',
            subLabel: 'autocomplete',
            color: kAccentAmber,
            width: 176.0,
          ),
        ),
        Positioned(
          left: 42.0,
          top: 20.0,
          child: buildHeroCard(
            label: 'OverlayEntry #3',
            subLabel: 'tooltip',
            color: kAccentRed,
            width: 162.0,
          ),
        ),
        Positioned(
          left: 56.0,
          top: -8.0,
          child: buildHeroCard(
            label: 'OverlayEntry #4',
            subLabel: 'topmost',
            color: kAccentPurple,
            width: 146.0,
          ),
        ),
      ],
    ),
  );
}

Widget buildHeroCard({
  required String label,
  required String subLabel,
  required Color color,
  required double width,
}) {
  return Container(
    width: width,
    height: 38.0,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: kPaper.withValues(alpha: 0.25), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkDeep.withValues(alpha: 0.40),
          blurRadius: 5.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: const BoxDecoration(
            color: kPaper,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            color: kPaper,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6.0),
        Expanded(
          child: Text(
            subLabel,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: kPaper.withValues(alpha: 0.80),
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildHeroBadgeRow() {
  return Wrap(
    spacing: 10.0,
    runSpacing: 8.0,
    children: <Widget>[
      buildHeroBadge('package: widgets'),
      buildHeroBadge('extends: StatefulWidget'),
      buildHeroBadge('state: OverlayState'),
      buildHeroBadge('entries: List<OverlayEntry>'),
    ],
  );
}

Widget buildHeroBadge(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: kHeroStripe,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: kPaper.withValues(alpha: 0.30),
        width: 1.0,
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: kPaper,
        fontSize: 11.5,
        fontFamily: 'monospace',
        letterSpacing: 0.2,
      ),
    ),
  );
}

// =====================================================================
// 2. Anatomy of `Overlay(initialEntries: [], onWillRemove: ...)`
// =====================================================================

Widget buildAnatomySection() {
  return buildPaperCard(
    title: 'Anatomy',
    subtitle: 'Overlay( initialEntries, clipBehavior, onWillRemove )',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildAnatomySignature(),
        const SizedBox(height: 14.0),
        buildAnatomyParamRow(
          name: 'initialEntries',
          type: 'List<OverlayEntry>',
          desc: 'Seed entries inserted in order on first build. Bottom of '
              'the visual stack is index 0.',
          colorChip: kAccentBlue,
        ),
        buildAnatomyDivider(),
        buildAnatomyParamRow(
          name: 'clipBehavior',
          type: 'Clip',
          desc: 'How children are clipped to the overlay\'s box. '
              'Defaults to Clip.hardEdge.',
          colorChip: kAccentGreen,
        ),
        buildAnatomyDivider(),
        buildAnatomyParamRow(
          name: 'onWillRemove',
          type: 'WillRemoveOverlayEntryCallback?',
          desc: 'Optional veto callback invoked before an entry is '
              'removed. Used by Navigator integration.',
          colorChip: kAccentAmber,
        ),
        buildAnatomyDivider(),
        buildAnatomyParamRow(
          name: 'key',
          type: 'Key?',
          desc: 'Standard widget key for re-identification.',
          colorChip: kAccentTeal,
        ),
      ],
    ),
  );
}

Widget buildAnatomySignature() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kInkDeep,
      borderRadius: BorderRadius.circular(kInnerRadius),
    ),
    child: const Text(
      'class Overlay extends StatefulWidget {\n'
      '  const Overlay({\n'
      '    super.key,\n'
      '    this.initialEntries = const <OverlayEntry>[],\n'
      '    this.clipBehavior = Clip.hardEdge,\n'
      '    this.onWillRemove,\n'
      '  });\n'
      '\n'
      '  @override\n'
      '  OverlayState createState() => OverlayState();\n'
      '}',
      style: TextStyle(
        color: kPaper,
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.55,
      ),
    ),
  );
}

Widget buildAnatomyParamRow({
  required String name,
  required String type,
  required String desc,
  required Color colorChip,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
            color: colorChip,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10.0),
        SizedBox(
          width: 130.0,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: kInkDeep,
            ),
          ),
        ),
        SizedBox(
          width: 220.0,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: kAccentPurple,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 13.0, color: kInkSoft),
          ),
        ),
      ],
    ),
  );
}

Widget buildAnatomyDivider() {
  return Container(height: 1.0, color: kSubtleLine.withValues(alpha: 0.55));
}

// =====================================================================
// 3. OverlayEntry field panel.
// =====================================================================

Widget buildEntryFieldPanel() {
  return buildPaperCard(
    title: 'OverlayEntry',
    subtitle: 'a builder plus two flags',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildEntrySignature(),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: buildEntryFieldCard('builder', 'WidgetBuilder',
                'Returns the widget shown in this layer. Called every '
                'time the entry is marked dirty. The builder receives '
                'the BuildContext of the OverlayState.')),
            const SizedBox(width: 12.0),
            Expanded(child: buildEntryFieldCard('opaque', 'bool',
                'When true, the entry fully covers entries below it; '
                'their builders are skipped during paint. Defaults to '
                'false.')),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: buildEntryFieldCard('maintainState', 'bool',
                'When true, the entry is kept in the element tree even '
                'when fully covered by an opaque entry above it. '
                'Default is false (state thrown away on cover).')),
            const SizedBox(width: 12.0),
            Expanded(child: buildEntryFieldCard('mounted', 'bool',
                'Read-only. True between insert() and remove(). '
                'OverlayEntry is itself a Listenable on this state.')),
          ],
        ),
      ],
    ),
  );
}

Widget buildEntrySignature() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kInkDeep,
      borderRadius: BorderRadius.circular(kInnerRadius),
    ),
    child: const Text(
      'class OverlayEntry implements Listenable {\n'
      '  OverlayEntry({\n'
      '    required this.builder,\n'
      '    bool opaque = false,\n'
      '    bool maintainState = false,\n'
      '  });\n'
      '\n'
      '  WidgetBuilder builder;\n'
      '  bool opaque;\n'
      '  bool maintainState;\n'
      '  bool get mounted;\n'
      '\n'
      '  void markNeedsBuild();\n'
      '  void remove();\n'
      '  void dispose();\n'
      '}',
      style: TextStyle(
        color: kPaper,
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.55,
      ),
    ),
  );
}

Widget buildEntryFieldCard(String name, String type, String description) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(kInnerRadius),
      border: Border.all(color: kSubtleLine, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: kInkDeep,
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: kAccentPurple.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                type,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: kAccentPurple,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: const TextStyle(fontSize: 12.5, color: kInkSoft, height: 1.4),
        ),
      ],
    ),
  );
}

// =====================================================================
// 4. Lifecycle timeline.
// =====================================================================

Widget buildLifecycleTimeline() {
  return buildPaperCard(
    title: 'Lifecycle',
    subtitle: 'constructor -> insert -> markNeedsBuild -> remove -> dispose',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 6.0),
        SizedBox(
          height: 130.0,
          child: CustomPaint(
            size: const Size(double.infinity, 130.0),
            painter: LifecyclePainter(),
          ),
        ),
        const SizedBox(height: 12.0),
        buildLifecycleStep(
          1,
          'OverlayEntry(...)',
          'Object created. mounted == false. Has a builder, opaque flag, '
              'and maintainState flag, but no slot in any overlay yet.',
        ),
        buildLifecycleStep(
          2,
          'OverlayState.insert(entry)',
          'Entry is appended to the entries list. mounted becomes true. '
              'The Element for the builder is built next frame.',
        ),
        buildLifecycleStep(
          3,
          'entry.markNeedsBuild()',
          'Schedules a rebuild for that single entry. Cheaper than '
              'rebuilding the whole overlay.',
        ),
        buildLifecycleStep(
          4,
          'entry.remove()',
          'Removes this entry from the entries list. mounted becomes '
              'false. The owning overlay rebuilds without it.',
        ),
        buildLifecycleStep(
          5,
          'entry.dispose()',
          'Final cleanup; releases listener resources. After this the '
              'entry must not be re-inserted.',
        ),
      ],
    ),
  );
}

Widget buildLifecycleStep(int number, String head, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26.0,
          height: 26.0,
          decoration: const BoxDecoration(
            color: kAccentBlue,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: const TextStyle(
              color: kPaper,
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                head,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                  color: kInkDeep,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: kInkSoft,
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

class LifecyclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = kInkSoft
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final Paint nodeFill = Paint()..color = kAccentBlue;
    final Paint paperFill = Paint()..color = kPaper;

    final double y = size.height / 2.0;
    canvas.drawLine(Offset(20.0, y), Offset(size.width - 20.0, y), line);

    final List<String> labels = <String>[
      'ctor',
      'insert',
      'markNeedsBuild',
      'remove',
      'dispose',
    ];
    final int n = labels.length;
    for (int i = 0; i < n; i++) {
      final double x = 20.0 + (size.width - 40.0) * (i / (n - 1));
      canvas.drawCircle(Offset(x, y), 9.0, nodeFill);
      canvas.drawCircle(Offset(x, y), 9.0, line);
      canvas.drawCircle(Offset(x, y), 4.0, paperFill);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: kInkDeep,
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2.0, y + 14.0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 5. Four simulated overlay scenes.
// =====================================================================

Widget buildScenesSection() {
  return buildPaperCard(
    title: 'Four overlay scenes',
    subtitle: 'simulated, non-interactive — these would normally live in '
        'the overlay',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: buildSceneRouteTransition()),
            const SizedBox(width: 14.0),
            Expanded(child: buildSceneSnackbar()),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: buildSceneAutocomplete()),
            const SizedBox(width: 14.0),
            Expanded(child: buildSceneTooltip()),
          ],
        ),
      ],
    ),
  );
}

// --- Scene A: route transition ------------------------------------------

Widget buildSceneRouteTransition() {
  return buildSceneFrame(
    title: 'A. route transition',
    caption: 'one route fading over another',
    canvas: SizedBox(
      height: 180.0,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: kAccentBlue,
                borderRadius: BorderRadius.circular(kInnerRadius),
              ),
              alignment: Alignment.center,
              child: const Text(
                'route A\n(below)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPaper,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            child: Container(
              decoration: BoxDecoration(
                color: kAccentRed.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(kInnerRadius),
                border: Border.all(color: kPaper, width: 2.0),
              ),
              alignment: Alignment.center,
              child: const Text(
                'route B\n(fading in)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPaper,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// --- Scene B: snackbar --------------------------------------------------

Widget buildSceneSnackbar() {
  return buildSceneFrame(
    title: 'B. snackbar',
    caption: 'transient bottom layer',
    canvas: SizedBox(
      height: 180.0,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: kPaperWarm,
                borderRadius: BorderRadius.circular(kInnerRadius),
                border: Border.all(color: kSubtleLine),
              ),
              alignment: Alignment.center,
              child: const Text(
                'underlying screen',
                style: TextStyle(color: kInkSoft, fontSize: 13.0),
              ),
            ),
          ),
          Positioned(
            left: 14.0,
            right: 14.0,
            bottom: 14.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: kInkDeep,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Saved!',
                      style: TextStyle(
                        color: kPaper,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: kAccentAmber,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: const Text(
                      'UNDO',
                      style: TextStyle(
                        color: kInkDeep,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// --- Scene C: autocomplete dropdown -------------------------------------

Widget buildSceneAutocomplete() {
  return buildSceneFrame(
    title: 'C. autocomplete',
    caption: 'dropdown anchored to a TextField',
    canvas: SizedBox(
      height: 200.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 14.0,
            left: 14.0,
            right: 14.0,
            child: Container(
              height: 36.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: kPaperWarm,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: kAccentBlue, width: 1.4),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'fl|',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  color: kInkDeep,
                ),
              ),
            ),
          ),
          Positioned(
            top: 56.0,
            left: 14.0,
            right: 14.0,
            child: Container(
              decoration: BoxDecoration(
                color: kPaper,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: kSubtleLine),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kInkDeep.withValues(alpha: 0.15),
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildAutocompleteRow('flutter', isSelected: true),
                  buildAutocompleteRow('flux'),
                  buildAutocompleteRow('flag'),
                  buildAutocompleteRow('flow'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildAutocompleteRow(String text, {bool isSelected = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    color: isSelected ? kAccentBlue.withValues(alpha: 0.15) : null,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13.0,
        color: kInkDeep,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
      ),
    ),
  );
}

// --- Scene D: tooltip with arrow tail -----------------------------------

Widget buildSceneTooltip() {
  return buildSceneFrame(
    title: 'D. tooltip',
    caption: 'small bubble with an arrow tail',
    canvas: SizedBox(
      height: 180.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 60.0,
            top: 110.0,
            child: Container(
              width: 80.0,
              height: 30.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kAccentTeal,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'BUTTON',
                style: TextStyle(
                  color: kPaper,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Positioned(
            left: 18.0,
            top: 36.0,
            child: SizedBox(
              width: 170.0,
              height: 60.0,
              child: CustomPaint(
                size: const Size(170.0, 60.0),
                painter: TooltipPainter(),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 16.0),
                  child: Text(
                    'Saves your\ncurrent draft',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPaper,
                      fontSize: 12.0,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class TooltipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()..color = kInkDeep;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height - 12.0),
      const Radius.circular(6.0),
    );
    canvas.drawRRect(rrect, fill);
    final Path tail = Path()
      ..moveTo(size.width / 2.0 - 8.0, size.height - 12.0)
      ..lineTo(size.width / 2.0, size.height)
      ..lineTo(size.width / 2.0 + 8.0, size.height - 12.0)
      ..close();
    canvas.drawPath(tail, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Common scene frame -------------------------------------------------

Widget buildSceneFrame({
  required String title,
  required String caption,
  required Widget canvas,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(kInnerRadius),
      border: Border.all(color: kSubtleLine),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: kInkDeep,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: kPaper,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                caption,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: kInkSoft,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        canvas,
      ],
    ),
  );
}

// =====================================================================
// 6. Opaque vs transparent comparison.
// =====================================================================

Widget buildOpaqueComparisonSection() {
  return buildPaperCard(
    title: 'opaque vs transparent',
    subtitle: 'what happens to entries below?',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: buildOpaqueCard()),
            const SizedBox(width: 14.0),
            Expanded(child: buildTransparentCard()),
          ],
        ),
        const SizedBox(height: 14.0),
        buildOpaqueExplanation(),
      ],
    ),
  );
}

Widget buildOpaqueCard() {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(kInnerRadius),
      border: Border.all(color: kAccentRed, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'opaque: true',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14.0,
            color: kAccentRed,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 130.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: kSubtleLine.withValues(alpha: 0.50),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'entry #0\n(skipped)',
                    style: TextStyle(
                      color: kInkSoft,
                      fontStyle: FontStyle.italic,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: kAccentRed,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'entry #1\n(opaque)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPaper,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Below entries are NOT painted unless they have '
          'maintainState: true.',
          style: TextStyle(fontSize: 12.0, color: kInkSoft),
        ),
      ],
    ),
  );
}

Widget buildTransparentCard() {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(kInnerRadius),
      border: Border.all(color: kAccentGreen, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'opaque: false',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14.0,
            color: kAccentGreen,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 130.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: kAccentBlue,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'entry #0\n(visible)',
                    style: TextStyle(
                      color: kPaper,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: kAccentGreen.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'entry #1\n(transparent)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPaper,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Below entries are painted normally and remain interactive.',
          style: TextStyle(fontSize: 12.0, color: kInkSoft),
        ),
      ],
    ),
  );
}

Widget buildOpaqueExplanation() {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kInkDeep,
      borderRadius: BorderRadius.circular(kInnerRadius),
    ),
    child: const Text(
      'Rule of thumb:\n'
      '  -  full-screen routes  -> opaque: true,  maintainState: false\n'
      '  -  modals (sheet, dialog) -> opaque: false, maintainState: false\n'
      '  -  background hosts (autocomplete root) -> maintainState: true',
      style: TextStyle(
        color: kPaper,
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.55,
      ),
    ),
  );
}

// =====================================================================
// 7. Rearrange semantics diagram.
// =====================================================================

Widget buildRearrangeDiagram() {
  return buildPaperCard(
    title: 'rearrange semantics',
    subtitle: 'OverlayState.rearrange(newEntries, { below })',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: buildRearrangeColumn('before', <RearrangeEntry>[
              RearrangeEntry('A', kAccentBlue),
              RearrangeEntry('B', kAccentGreen),
              RearrangeEntry('C', kAccentAmber),
              RearrangeEntry('D', kAccentRed),
            ])),
            const SizedBox(width: 12.0),
            buildRearrangeArrow(),
            const SizedBox(width: 12.0),
            Expanded(child: buildRearrangeColumn('after', <RearrangeEntry>[
              RearrangeEntry('A', kAccentBlue),
              RearrangeEntry('C', kAccentAmber),
              RearrangeEntry('B', kAccentGreen),
              RearrangeEntry('D', kAccentRed),
            ])),
          ],
        ),
        const SizedBox(height: 14.0),
        buildRearrangeNotes(),
      ],
    ),
  );
}

class RearrangeEntry {
  final String label;
  final Color color;
  const RearrangeEntry(this.label, this.color);
}

Widget buildRearrangeColumn(String label, List<RearrangeEntry> entries) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: kInkSoft,
          borderRadius: BorderRadius.circular(3.0),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: kPaper,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      for (int i = entries.length - 1; i >= 0; i--)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Container(
            height: 32.0,
            decoration: BoxDecoration(
              color: entries[i].color,
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignment: Alignment.center,
            child: Text(
              'entry ${entries[i].label}',
              style: const TextStyle(
                color: kPaper,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
    ],
  );
}

Widget buildRearrangeArrow() {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: SizedBox(
      width: 36.0,
      height: 32.0,
      child: CustomPaint(
        size: const Size(36.0, 32.0),
        painter: ArrowPainter(),
      ),
    ),
  );
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = kInkSoft
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final double y = size.height / 2.0;
    canvas.drawLine(Offset(2.0, y), Offset(size.width - 6.0, y), p);
    final Path head = Path()
      ..moveTo(size.width - 12.0, y - 6.0)
      ..lineTo(size.width - 2.0, y)
      ..lineTo(size.width - 12.0, y + 6.0);
    canvas.drawPath(head, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget buildRearrangeNotes() {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(kInnerRadius),
      border: Border.all(color: kSubtleLine),
    ),
    child: const Text(
      'rearrange( newEntries, below: ... ) replaces the entries list in '
      'one shot. The below parameter is an optional anchor: every entry '
      'in newEntries will be placed below that anchor entry. This is '
      'cheaper than calling remove + insert pairs because the existing '
      'state objects are reused for entries that are still present.',
      style: TextStyle(fontSize: 13.0, color: kInkSoft, height: 1.5),
    ),
  );
}

// =====================================================================
// 8. Lookup variants: Overlay.of vs Navigator.of(...).overlay.
// =====================================================================

Widget buildLookupVariantsSection() {
  return buildPaperCard(
    title: 'how to find an OverlayState',
    subtitle: 'three lookup paths, three meanings',
    child: Column(
      children: <Widget>[
        buildLookupRow(
          codeLine: 'Overlay.of(context)',
          summary: 'returns the nearest enclosing OverlayState. '
              'Throws (in debug) if there is no Overlay ancestor.',
          accent: kAccentBlue,
        ),
        buildLookupRow(
          codeLine: 'Navigator.of(context).overlay',
          summary: 'returns the OverlayState owned by the nearest '
              'Navigator. Useful for entries scoped to a route stack.',
          accent: kAccentGreen,
        ),
        buildLookupRow(
          codeLine: 'context.findAncestorStateOfType<OverlayState>()',
          summary: 'low-level lookup. Returns null if there is no '
              'overlay above. Avoid except in framework code.',
          accent: kAccentAmber,
        ),
      ],
    ),
  );
}

Widget buildLookupRow({
  required String codeLine,
  required String summary,
  required Color accent,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 36.0,
          margin: const EdgeInsets.only(top: 2.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: kInkDeep,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  codeLine,
                  style: const TextStyle(
                    color: kPaper,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                summary,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: kInkSoft,
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

// =====================================================================
// 9. Recipe code listing for inserting a custom overlay entry.
// =====================================================================

Widget buildRecipeListing() {
  return buildPaperCard(
    title: 'recipe',
    subtitle: 'inserting a custom OverlayEntry',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A typical pattern for showing a banner without a Navigator:',
          style: TextStyle(fontSize: 13.0, color: kInkSoft),
        ),
        const SizedBox(height: 10.0),
        buildCodeBlock(
          'OverlayEntry showBanner(BuildContext context, String text) {\n'
          '  final OverlayState overlay = Overlay.of(context);\n'
          '  late OverlayEntry entry;\n'
          '  entry = OverlayEntry(\n'
          '    builder: (BuildContext ctx) => Positioned(\n'
          '      top: 24.0,\n'
          '      left: 24.0,\n'
          '      right: 24.0,\n'
          '      child: Material(\n'
          '        color: Colors.indigo,\n'
          '        elevation: 6.0,\n'
          '        borderRadius: BorderRadius.circular(6.0),\n'
          '        child: Padding(\n'
          '          padding: const EdgeInsets.all(12.0),\n'
          '          child: Text(text,\n'
          '            style: const TextStyle(color: Colors.white)),\n'
          '        ),\n'
          '      ),\n'
          '    ),\n'
          '  );\n'
          '  overlay.insert(entry);\n'
          '  return entry;\n'
          '}\n'
          '\n'
          '// later, the caller is responsible for cleanup:\n'
          '//   entry.remove();\n'
          '//   entry.dispose();',
        ),
      ],
    ),
  );
}

Widget buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kInkDeep,
      borderRadius: BorderRadius.circular(kInnerRadius),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: kPaper,
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.55,
      ),
    ),
  );
}

// =====================================================================
// 10. Comparison: Overlay vs OverlayPortal vs Stack.
// =====================================================================

Widget buildComparisonSection() {
  return buildPaperCard(
    title: 'Overlay vs OverlayPortal vs Stack',
    subtitle: 'when each is the right tool',
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: buildComparisonColumn(
                title: 'Overlay',
                tagline: 'global, ordered, route-aware',
                color: kAccentBlue,
                bullets: <String>[
                  'Single per-app hosting widget.',
                  'Entries are imperative (insert / remove).',
                  'Used by Navigator, ScaffoldMessenger, '
                      'PopupMenu, Tooltip.',
                  'Best when the layer must outlive the calling '
                      'widget (snackbar across rebuilds).',
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: buildComparisonColumn(
                title: 'OverlayPortal',
                tagline: 'declarative child of an Overlay',
                color: kAccentGreen,
                bullets: <String>[
                  'A widget that renders its overlayChild via '
                      'a controller.',
                  'Reactive: rebuilds with the host.',
                  'Best for tooltips, hover cards, and dropdowns '
                      'tied to widget state.',
                  'No manual remove needed — disposing the '
                      'host cleans up.',
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: buildComparisonColumn(
                title: 'Stack',
                tagline: 'layout, not lifetime',
                color: kAccentAmber,
                bullets: <String>[
                  'Plain layout: children share the same parent box.',
                  'No global ordering, no insert / remove API.',
                  'Best when layers belong to one widget '
                      'subtree.',
                  'Cheaper than Overlay; no extra Element tree.',
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildComparisonColumn({
  required String title,
  required String tagline,
  required Color color,
  required List<String> bullets,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(kInnerRadius),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          tagline,
          style: const TextStyle(
            color: kInkSoft,
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10.0),
        for (final String bullet in bullets)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 5.0,
                  height: 5.0,
                  margin: const EdgeInsets.only(top: 6.0, right: 6.0),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    bullet,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: kInkDeep,
                      height: 1.35,
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

// =====================================================================
// 11. Pitfalls.
// =====================================================================

Widget buildPitfallsSection() {
  return buildPaperCard(
    title: 'pitfalls',
    subtitle: 'small things that bite hard',
    child: Column(
      children: <Widget>[
        buildPitfallRow(
          'Calling Overlay.of from a context that has no Overlay '
              'ancestor throws. Always anchor lookups to a widget below '
              'MaterialApp / WidgetsApp.',
          kAccentRed,
        ),
        buildPitfallRow(
          'OverlayEntry is owned by the caller — except for entries '
              'you inserted via Route.install, which the Navigator '
              'manages. Manually-inserted entries leak if you forget '
              'remove() and dispose().',
          kAccentRed,
        ),
        buildPitfallRow(
          'opaque: true is a paint optimisation only; tap targets '
              'below still work via hit-testing if maintainState is '
              'true. Do not use opaque to disable input.',
          kAccentAmber,
        ),
        buildPitfallRow(
          'rearrange does not call remove on entries that vanish — '
              'they must be removed first or you assert in debug.',
          kAccentAmber,
        ),
        buildPitfallRow(
          'Inserting the same OverlayEntry instance into two overlays '
              'asserts. An entry is single-use.',
          kAccentAmber,
        ),
        buildPitfallRow(
          'Tooltips, popups, autocomplete and snackbars all share the '
              'same overlay. Their stacking order is the ordering of '
              'their underlying entries.',
          kAccentBlue,
        ),
      ],
    ),
  );
}

Widget buildPitfallRow(String text, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 22.0,
          height: 22.0,
          margin: const EdgeInsets.only(top: 1.0, right: 10.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.center,
          child: const Text(
            '!',
            style: TextStyle(
              color: kPaper,
              fontWeight: FontWeight.w800,
              fontSize: 14.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13.0,
              color: kInkDeep,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 12. Footer.
// =====================================================================

Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
    decoration: BoxDecoration(
      color: kInkDeep,
      borderRadius: BorderRadius.circular(kCardRadius),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kAccentAmber,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'O',
            style: TextStyle(
              color: kInkDeep,
              fontWeight: FontWeight.w900,
              fontSize: 22.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Overlay deep demo',
                style: TextStyle(
                  color: kPaper,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'static visual lecture — no live overlay manipulation',
                style: TextStyle(
                  color: kPaperWarm,
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const Text(
          'flutter / widgets',
          style: TextStyle(
            color: kAccentAmber,
            fontFamily: 'monospace',
            fontSize: 11.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Shared helpers.
// =====================================================================

Widget buildPaperCard({
  required String title,
  String? subtitle,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(kCardRadius),
      border: Border.all(color: kSubtleLine, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkDeep.withValues(alpha: 0.06),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 6.0,
              height: 22.0,
              margin: const EdgeInsets.only(right: 10.0, bottom: 3.0),
              decoration: BoxDecoration(
                color: kAccentRed,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: kInkDeep,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
        if (subtitle != null) ...<Widget>[
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: kInkSoft,
                fontSize: 13.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
        const SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}
