// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: ButtonBarLayoutBehavior enum
//
// Design plan:
// -----------------------------------------------------------------------------
// ButtonBarLayoutBehavior is a deprecated enum from package:flutter/material.dart
// with exactly two constants: constrained and padded. The enum controlled how a
// ButtonBar laid out itself: 'constrained' sized the bar to a Material-style
// minimum height (52 logical pixels by default) so a dialog action row had a
// stable footprint, while 'padded' simply added padding around the children and
// let the bar take whatever height the children produced.
//
// Both ButtonBar and ButtonBarLayoutBehavior were deprecated in favor of
// OverflowBar (which wraps children when they would not fit horizontally) and
// plain Padding/SizedBox/ConstrainedBox for height control. The replacement is
// more composable: instead of one widget toggling two unrelated behaviors via
// an enum, OverflowBar focuses on overflow only, and authors compose Padding
// or ConstrainedBox explicitly for sizing.
//
// This script renders eight sections covering: gradient header, anatomy of the
// enum, side-by-side ButtonBar specimens for both behaviors, equivalent
// OverflowBar specimens, a comparison table, migration recipes, a decision
// matrix, and a glossary of related terms. Material 3 ColorScheme idioms are
// used throughout via Theme.of(context).colorScheme references.
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';

dynamic build(BuildContext context) => const ButtonBarLayoutBehaviorDemoApp();

/// Root application widget. Stateless because every section renders statically.
class ButtonBarLayoutBehaviorDemoApp extends StatelessWidget {
  const ButtonBarLayoutBehaviorDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('ButtonBarLayoutBehavior Deep Demo executing');
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF3949AB),
      brightness: Brightness.light,
      useMaterial3: true,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ButtonBarLayoutBehavior Deep Demo',
      theme: theme,
      home: const _DemoScaffold(),
    );
  }
}

/// Top-level scaffold hosting every section in a scroll view.
class _DemoScaffold extends StatelessWidget {
  const _DemoScaffold();

  @override
  Widget build(BuildContext context) {
    print('Building demo scaffold');
    final cs = Theme.of(context).colorScheme;

    // Section widget instances. We build each once and drop them into the
    // Column below in the documented order. This keeps the body shallow and
    // readable while still being a real widget tree.
    final header = _buildHeader(context);
    final anatomy = _buildAnatomySection(context);
    final specimens = _buildButtonBarSpecimens(context);
    final overflowBars = _buildOverflowBarSpecimens(context);
    final comparisonTable = _buildComparisonTable(context);
    final migration = _buildMigrationRecipes(context);
    final decision = _buildDecisionMatrix(context);
    final glossary = _buildGlossary(context);

    return Scaffold(
      backgroundColor: cs.surfaceContainerLowest,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              header,
              const SizedBox(height: 32.0),
              anatomy,
              const SizedBox(height: 32.0),
              specimens,
              const SizedBox(height: 32.0),
              overflowBars,
              const SizedBox(height: 32.0),
              comparisonTable,
              const SizedBox(height: 32.0),
              migration,
              const SizedBox(height: 32.0),
              decision,
              const SizedBox(height: 32.0),
              glossary,
              const SizedBox(height: 48.0),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 1: Gradient header banner.
// ============================================================================
//
// The header acts as a visual title card. It uses a Material 3 ColorScheme
// gradient, an icon, a primary title, a subtitle, and a small "deprecated"
// pill so readers immediately understand the API status before scrolling.
Widget _buildHeader(BuildContext context) {
  print('=== Section 1: Header banner ===');
  final cs = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[cs.primary, cs.tertiary, cs.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cs.primary.withValues(alpha: 0.25),
          blurRadius: 18.0,
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
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: cs.onPrimary.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.view_agenda_outlined,
                size: 36.0,
                color: cs.onPrimary,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ButtonBarLayoutBehavior',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: cs.onPrimary,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'enum { constrained, padded } - deprecated Material API',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: cs.onPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Row(
          children: <Widget>[
            _headerPill(
              context,
              icon: Icons.warning_amber_rounded,
              label: 'Deprecated',
              tint: Colors.amber,
            ),
            const SizedBox(width: 8.0),
            _headerPill(
              context,
              icon: Icons.swap_horiz_rounded,
              label: 'Replaced by OverflowBar',
              tint: Colors.lightBlueAccent,
            ),
            const SizedBox(width: 8.0),
            _headerPill(
              context,
              icon: Icons.layers_outlined,
              label: 'Material',
              tint: Colors.greenAccent,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _headerPill(
  BuildContext context, {
  required IconData icon,
  required String label,
  required Color tint,
}) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: cs.onPrimary.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: cs.onPrimary.withValues(alpha: 0.35)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14.0, color: tint),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: cs.onPrimary,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2: Anatomy of the enum.
//
// Two concept cards side-by-side explaining each enum constant in narrative
// form, then a third card explaining the deprecation rationale.
// ============================================================================
Widget _buildAnatomySection(BuildContext context) {
  print('=== Section 2: Anatomy of the enum ===');
  final cs = Theme.of(context).colorScheme;

  final constrainedCard = _anatomyCard(
    context,
    title: 'constrained',
    headline: 'Snap to a stable minimum height',
    description:
        'When a ButtonBar uses ButtonBarLayoutBehavior.constrained, the bar '
        'guarantees a minimum height that matches the Material 2 dialog action '
        'row (52 logical pixels by default, configurable through '
        'buttonMinHeight). The result is visually consistent dialog footers '
        'regardless of whether the buttons themselves are 36, 40, or 48 high.',
    bullets: const <String>[
      'Stable footprint for dialog action rows',
      'Children are vertically centered inside the min-height box',
      'Used as the default in AlertDialog actions historically',
      'Independent from horizontal padding handling',
    ],
    icon: Icons.height_rounded,
    accent: cs.primary,
  );

  final paddedCard = _anatomyCard(
    context,
    title: 'padded',
    headline: 'Wrap children with theme-driven padding',
    description:
        'ButtonBarLayoutBehavior.padded does not force a minimum height. '
        'Instead the bar applies symmetric padding so children sit comfortably '
        'inside the bar regardless of their intrinsic size. This is the right '
        'choice when the parent already controls vertical layout (for example '
        'a Card footer) and the surrounding height should hug the children.',
    bullets: const <String>[
      'Bar height collapses to the children',
      'Horizontal and vertical padding still applied',
      'Better for inline action rows inside Cards',
      'No fixed 52px guarantee',
    ],
    icon: Icons.space_bar_rounded,
    accent: cs.tertiary,
  );

  final rationaleCard = Container(
    margin: const EdgeInsets.only(top: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: cs.errorContainer.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: cs.error.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.report_problem_outlined, color: cs.error, size: 28.0),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Why ButtonBarLayoutBehavior was deprecated',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: cs.onErrorContainer,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'A single enum bundled two orthogonal responsibilities (minimum '
                'height vs symmetric padding). When children overflowed '
                'horizontally the bar clipped silently. OverflowBar replaces '
                'ButtonBar with a focused widget: it wraps children to a new '
                'line when they would overflow, leaving height and padding to '
                'be composed by the caller (ConstrainedBox, Padding, '
                'SizedBox). The Material 3 dialog uses OverflowBar internally '
                'and exposes actionsPadding for the constrained-style spacing.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: cs.onErrorContainer.withValues(alpha: 0.9),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(context, '2', 'Anatomy of the enum'),
      const SizedBox(height: 14.0),
      LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          final wide = constraints.maxWidth > 720.0;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: constrainedCard),
                const SizedBox(width: 16.0),
                Expanded(child: paddedCard),
              ],
            );
          }
          return Column(
            children: <Widget>[
              constrainedCard,
              const SizedBox(height: 16.0),
              paddedCard,
            ],
          );
        },
      ),
      rationaleCard,
    ],
  );
}

Widget _anatomyCard(
  BuildContext context, {
  required String title,
  required String headline,
  required String description,
  required List<String> bullets,
  required IconData icon,
  required Color accent,
}) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 12.0,
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
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: accent, size: 26.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ButtonBarLayoutBehavior.$title',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.5,
                      color: accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    headline,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.5,
            color: cs.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        ...bullets.map(
          (String b) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.check_circle_outline, size: 14.0, color: accent),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    b,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: cs.onSurface.withValues(alpha: 0.85),
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

// ============================================================================
// SECTION 3: Real ButtonBar specimens for both enum values.
//
// We construct two literal ButtonBar widgets to make the visual difference
// concrete. Both bars get the same children so the only variable is the
// layoutBehavior. We frame each in a bordered container to show the
// outer box the bar consumes.
// ============================================================================
Widget _buildButtonBarSpecimens(BuildContext context) {
  print('=== Section 3: ButtonBar specimens ===');
  final cs = Theme.of(context).colorScheme;

  List<Widget> sampleButtons() => <Widget>[
        TextButton(onPressed: () {}, child: const Text('CANCEL')),
        TextButton(onPressed: () {}, child: const Text('CONFIRM')),
      ];

  final constrainedSpecimen = _specimenFrame(
    context,
    label: 'layoutBehavior: constrained',
    description:
        'The bar reserves at least 52px of height (configurable via '
        'buttonMinHeight). Try shrinking the window: the bar still presents a '
        'consistent dialog-style footer.',
    accent: cs.primary,
    child: ButtonBar(
      alignment: MainAxisAlignment.end,
      layoutBehavior: ButtonBarLayoutBehavior.constrained,
      children: sampleButtons(),
    ),
  );

  final paddedSpecimen = _specimenFrame(
    context,
    label: 'layoutBehavior: padded',
    description:
        'The bar collapses to whatever its children require, plus the theme '
        'padding. Use this inside Cards or other containers that already '
        'control vertical spacing.',
    accent: cs.tertiary,
    child: ButtonBar(
      alignment: MainAxisAlignment.end,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      children: sampleButtons(),
    ),
  );

  // A third specimen mixes both bars inside a fake "dialog" surface so the
  // reader can see how each behavior looks in context, not just isolated.
  final dialogSpecimen = Container(
    margin: const EdgeInsets.only(top: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: cs.outlineVariant),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Specimen 3: ButtonBar inside a faux AlertDialog',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: cs.outline.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Discard changes?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'If you discard, your edits will be lost permanently.',
                style: TextStyle(fontSize: 13.0, color: cs.onSurfaceVariant),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                layoutBehavior: ButtonBarLayoutBehavior.constrained,
                children: <Widget>[
                  TextButton(onPressed: () {}, child: const Text('KEEP')),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('DISCARD'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(context, '3', 'Live ButtonBar specimens'),
      const SizedBox(height: 14.0),
      LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          final wide = constraints.maxWidth > 720.0;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: constrainedSpecimen),
                const SizedBox(width: 16.0),
                Expanded(child: paddedSpecimen),
              ],
            );
          }
          return Column(
            children: <Widget>[
              constrainedSpecimen,
              const SizedBox(height: 16.0),
              paddedSpecimen,
            ],
          );
        },
      ),
      dialogSpecimen,
    ],
  );
}

Widget _specimenFrame(
  BuildContext context, {
  required String label,
  required String description,
  required Color accent,
  required Widget child,
}) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: cs.surfaceContainerLow,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: cs.onSurfaceVariant,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: accent.withValues(alpha: 0.25),
            ),
          ),
          child: child,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4: OverflowBar specimens - the modern replacement.
//
// Three specimens demonstrating how OverflowBar plus Padding plus
// ConstrainedBox covers everything the old enum did, more explicitly.
// ============================================================================
Widget _buildOverflowBarSpecimens(BuildContext context) {
  print('=== Section 4: OverflowBar specimens ===');
  final cs = Theme.of(context).colorScheme;

  // Replacement for 'constrained': wrap the OverflowBar in a ConstrainedBox.
  final constrainedReplacement = _specimenFrame(
    context,
    label: 'OverflowBar + ConstrainedBox',
    description:
        'Equivalent to layoutBehavior: constrained. ConstrainedBox guarantees '
        'a 52px minimum height; OverflowBar handles horizontal layout and '
        'wraps to a new line when the row would overflow.',
    accent: cs.primary,
    child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: OverflowBar(
          alignment: MainAxisAlignment.end,
          spacing: 8.0,
          overflowAlignment: OverflowBarAlignment.end,
          children: <Widget>[
            TextButton(onPressed: () {}, child: const Text('CANCEL')),
            FilledButton(onPressed: () {}, child: const Text('CONFIRM')),
          ],
        ),
      ),
    ),
  );

  // Replacement for 'padded': just wrap OverflowBar with Padding.
  final paddedReplacement = _specimenFrame(
    context,
    label: 'OverflowBar + Padding',
    description:
        'Equivalent to layoutBehavior: padded. The Padding adds breathing '
        'room and the bar height hugs the children. Use this inside Cards '
        'and inline action rows.',
    accent: cs.tertiary,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: OverflowBar(
        alignment: MainAxisAlignment.end,
        spacing: 8.0,
        overflowAlignment: OverflowBarAlignment.end,
        children: <Widget>[
          TextButton(onPressed: () {}, child: const Text('CANCEL')),
          FilledButton(onPressed: () {}, child: const Text('CONFIRM')),
        ],
      ),
    ),
  );

  // A third specimen showcasing the killer feature: real overflow wrapping
  // when the children would not fit horizontally. ButtonBar could not do this.
  final overflowDemo = Container(
    margin: const EdgeInsets.only(top: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: cs.secondaryContainer.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: cs.secondary.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.wrap_text_rounded, color: cs.secondary),
            const SizedBox(width: 8.0),
            Text(
              'Specimen 3: OverflowBar wraps when children do not fit',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: cs.onSecondaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'A narrow container forces the bar to spill into a second row. '
          'overflowSpacing controls the gap between rows. ButtonBar would '
          'have clipped instead.',
          style: TextStyle(
            fontSize: 12.0,
            color: cs.onSecondaryContainer.withValues(alpha: 0.85),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          width: 280.0,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: OverflowBar(
            alignment: MainAxisAlignment.end,
            overflowAlignment: OverflowBarAlignment.end,
            spacing: 8.0,
            overflowSpacing: 6.0,
            children: <Widget>[
              TextButton(onPressed: () {}, child: const Text('RESET')),
              TextButton(onPressed: () {}, child: const Text('SECONDARY')),
              FilledButton(onPressed: () {}, child: const Text('PRIMARY')),
            ],
          ),
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(context, '4', 'OverflowBar replacements'),
      const SizedBox(height: 14.0),
      LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          final wide = constraints.maxWidth > 720.0;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: constrainedReplacement),
                const SizedBox(width: 16.0),
                Expanded(child: paddedReplacement),
              ],
            );
          }
          return Column(
            children: <Widget>[
              constrainedReplacement,
              const SizedBox(height: 16.0),
              paddedReplacement,
            ],
          );
        },
      ),
      overflowDemo,
    ],
  );
}

// ============================================================================
// SECTION 5: Comparison table.
//
// A real Table widget with header row and content rows that compares
// ButtonBar (both enum values) with OverflowBar across several axes.
// ============================================================================
Widget _buildComparisonTable(BuildContext context) {
  print('=== Section 5: Comparison table ===');
  final cs = Theme.of(context).colorScheme;

  final rows = <_CompareRow>[
    const _CompareRow(
      axis: 'Min height guarantee',
      bbConstrained: 'Yes (52px default)',
      bbPadded: 'No',
      overflowBar: 'No - compose with ConstrainedBox',
    ),
    const _CompareRow(
      axis: 'Symmetric padding',
      bbConstrained: 'Yes via theme',
      bbPadded: 'Yes via theme',
      overflowBar: 'No - compose with Padding',
    ),
    const _CompareRow(
      axis: 'Overflow wrap to new line',
      bbConstrained: 'No (clips)',
      bbPadded: 'No (clips)',
      overflowBar: 'Yes',
    ),
    const _CompareRow(
      axis: 'Alignment control',
      bbConstrained: 'MainAxisAlignment',
      bbPadded: 'MainAxisAlignment',
      overflowBar: 'alignment + overflowAlignment',
    ),
    const _CompareRow(
      axis: 'Spacing between children',
      bbConstrained: 'Via ButtonBarTheme',
      bbPadded: 'Via ButtonBarTheme',
      overflowBar: 'spacing parameter',
    ),
    const _CompareRow(
      axis: 'Spacing between rows',
      bbConstrained: 'N/A',
      bbPadded: 'N/A',
      overflowBar: 'overflowSpacing',
    ),
    const _CompareRow(
      axis: 'Direction reversal on overflow',
      bbConstrained: 'No',
      bbPadded: 'No',
      overflowBar: 'overflowDirection',
    ),
    const _CompareRow(
      axis: 'API status',
      bbConstrained: 'Deprecated',
      bbPadded: 'Deprecated',
      overflowBar: 'Stable',
    ),
  ];

  Widget headerCell(String label, Color tint) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        color: tint.withValues(alpha: 0.18),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
      );

  Widget bodyCell(String label, {bool isFirst = false}) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: isFirst ? FontWeight.w600 : FontWeight.normal,
            color: isFirst ? cs.onSurface : cs.onSurfaceVariant,
            height: 1.3,
          ),
        ),
      );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(context, '5', 'Side-by-side comparison'),
      const SizedBox(height: 14.0),
      Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cs.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.4),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(2.0),
            3: FlexColumnWidth(2.6),
          },
          border: TableBorder.symmetric(
            inside: BorderSide(
              color: cs.outlineVariant.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                headerCell('Concern', cs.surfaceContainerHighest),
                headerCell('ButtonBar.constrained', cs.primary),
                headerCell('ButtonBar.padded', cs.tertiary),
                headerCell('OverflowBar', cs.secondary),
              ],
            ),
            for (final _CompareRow row in rows)
              TableRow(
                children: <Widget>[
                  bodyCell(row.axis, isFirst: true),
                  bodyCell(row.bbConstrained),
                  bodyCell(row.bbPadded),
                  bodyCell(row.overflowBar),
                ],
              ),
          ],
        ),
      ),
    ],
  );
}

class _CompareRow {
  const _CompareRow({
    required this.axis,
    required this.bbConstrained,
    required this.bbPadded,
    required this.overflowBar,
  });
  final String axis;
  final String bbConstrained;
  final String bbPadded;
  final String overflowBar;
}

// ============================================================================
// SECTION 6: Migration recipes.
//
// Three concrete before/after snippets, each in a dark code-card style.
// ============================================================================
Widget _buildMigrationRecipes(BuildContext context) {
  print('=== Section 6: Migration recipes ===');
  final cs = Theme.of(context).colorScheme;

  final recipes = <_Recipe>[
    _Recipe(
      title: 'Recipe 1: dialog footer (constrained -> ConstrainedBox)',
      before: '// Legacy dialog action row\n'
          'ButtonBar(\n'
          '  alignment: MainAxisAlignment.end,\n'
          '  layoutBehavior: ButtonBarLayoutBehavior.constrained,\n'
          '  buttonMinHeight: 52.0,\n'
          '  children: <Widget>[\n'
          '    TextButton(onPressed: cancel, child: Text(\'CANCEL\')),\n'
          '    FilledButton(onPressed: confirm, child: Text(\'OK\')),\n'
          '  ],\n'
          ');',
      after: '// Modern Material 3 replacement\n'
          'ConstrainedBox(\n'
          '  constraints: const BoxConstraints(minHeight: 52.0),\n'
          '  child: OverflowBar(\n'
          '    alignment: MainAxisAlignment.end,\n'
          '    spacing: 8.0,\n'
          '    children: <Widget>[\n'
          '      TextButton(onPressed: cancel, child: Text(\'CANCEL\')),\n'
          '      FilledButton(onPressed: confirm, child: Text(\'OK\')),\n'
          '    ],\n'
          '  ),\n'
          ');',
    ),
    _Recipe(
      title: 'Recipe 2: inline card footer (padded -> Padding)',
      before: '// Legacy card footer\n'
          'ButtonBar(\n'
          '  alignment: MainAxisAlignment.end,\n'
          '  layoutBehavior: ButtonBarLayoutBehavior.padded,\n'
          '  children: <Widget>[\n'
          '    TextButton(onPressed: dismiss, child: Text(\'LATER\')),\n'
          '    FilledButton(onPressed: act, child: Text(\'OPEN\')),\n'
          '  ],\n'
          ');',
      after: '// Modern replacement\n'
          'Padding(\n'
          '  padding: const EdgeInsets.all(8.0),\n'
          '  child: OverflowBar(\n'
          '    alignment: MainAxisAlignment.end,\n'
          '    spacing: 8.0,\n'
          '    children: <Widget>[\n'
          '      TextButton(onPressed: dismiss, child: Text(\'LATER\')),\n'
          '      FilledButton(onPressed: act, child: Text(\'OPEN\')),\n'
          '    ],\n'
          '  ),\n'
          ');',
    ),
    _Recipe(
      title: 'Recipe 3: AlertDialog actions (built-in OverflowBar)',
      before: '// AlertDialog historically wrapped actions in ButtonBar.\n'
          'AlertDialog(\n'
          '  title: Text(\'Heads up\'),\n'
          '  content: Text(\'Body\'),\n'
          '  actions: <Widget>[\n'
          '    TextButton(onPressed: dismiss, child: Text(\'OK\')),\n'
          '  ],\n'
          ');',
      after: '// In Material 3, AlertDialog uses OverflowBar internally.\n'
          '// Tune the visual height via actionsPadding rather than enum.\n'
          'AlertDialog(\n'
          '  title: Text(\'Heads up\'),\n'
          '  content: Text(\'Body\'),\n'
          '  actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),\n'
          '  actions: <Widget>[\n'
          '    TextButton(onPressed: dismiss, child: Text(\'OK\')),\n'
          '  ],\n'
          ');',
    ),
  ];

  final cards = <Widget>[];
  for (int i = 0; i < recipes.length; i++) {
    final r = recipes[i];
    cards.add(
      Container(
        margin: EdgeInsets.only(bottom: i == recipes.length - 1 ? 0 : 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1F26),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cs.primary.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.swap_horizontal_circle_outlined,
                  color: Colors.cyanAccent,
                  size: 20.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    r.title,
                    style: const TextStyle(
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            _codeBlock(
              context,
              title: 'BEFORE (deprecated)',
              titleColor: Colors.orangeAccent,
              code: r.before,
              codeColor: Colors.orange.shade200,
            ),
            const SizedBox(height: 10.0),
            _codeBlock(
              context,
              title: 'AFTER (recommended)',
              titleColor: Colors.lightGreenAccent,
              code: r.after,
              codeColor: Colors.lightGreen.shade200,
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(context, '6', 'Migration recipes'),
      const SizedBox(height: 14.0),
      ...cards,
    ],
  );
}

class _Recipe {
  _Recipe({required this.title, required this.before, required this.after});
  final String title;
  final String before;
  final String after;
}

Widget _codeBlock(
  BuildContext context, {
  required String title,
  required Color titleColor,
  required String code,
  required Color codeColor,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFF12131A),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: titleColor.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 10.5,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: codeColor,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7: Decision matrix.
//
// A flowchart-style series of rows guiding the reader from a question down to
// the recommended widget composition.
// ============================================================================
Widget _buildDecisionMatrix(BuildContext context) {
  print('=== Section 7: Decision matrix ===');
  final cs = Theme.of(context).colorScheme;

  final steps = <_DecisionStep>[
    _DecisionStep(
      question: 'Do you control a dialog action row?',
      yes: 'Use AlertDialog.actions. Tune actionsPadding for vertical spacing.',
      no: 'Continue.',
      icon: Icons.help_outline,
      tint: cs.primary,
    ),
    _DecisionStep(
      question: 'Do your buttons need a guaranteed minimum height?',
      yes: 'Wrap OverflowBar in a ConstrainedBox(minHeight: 52.0).',
      no: 'Continue.',
      icon: Icons.height_rounded,
      tint: cs.tertiary,
    ),
    _DecisionStep(
      question: 'Can the buttons overflow horizontally on narrow screens?',
      yes: 'OverflowBar handles wrapping automatically.',
      no: 'A plain Row with mainAxisAlignment is sufficient.',
      icon: Icons.wrap_text_rounded,
      tint: cs.secondary,
    ),
    _DecisionStep(
      question: 'Do you need consistent spacing between buttons?',
      yes: 'Set OverflowBar.spacing (8.0 is the Material default).',
      no: 'Skip the parameter; default packs children tightly.',
      icon: Icons.space_bar_rounded,
      tint: cs.primary,
    ),
    _DecisionStep(
      question: 'Do you need consistent spacing between wrapped rows?',
      yes: 'Set OverflowBar.overflowSpacing.',
      no: 'Leave it 0.',
      icon: Icons.format_line_spacing_rounded,
      tint: cs.tertiary,
    ),
  ];

  final rows = <Widget>[];
  for (int i = 0; i < steps.length; i++) {
    final step = steps[i];
    final isLast = i == steps.length - 1;
    rows.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: step.tint,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: step.tint.withValues(alpha: 0.35),
                      blurRadius: 8.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(step.icon, color: cs.onPrimary, size: 22.0),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 50.0,
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  color: step.tint.withValues(alpha: 0.4),
                ),
            ],
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 18.0),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: cs.surfaceContainer,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: step.tint.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    step.question,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _yesNo(
                    context,
                    label: 'Yes',
                    detail: step.yes,
                    positive: true,
                  ),
                  const SizedBox(height: 4.0),
                  _yesNo(
                    context,
                    label: 'No',
                    detail: step.no,
                    positive: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(context, '7', 'Decision matrix'),
      const SizedBox(height: 14.0),
      ...rows,
    ],
  );
}

class _DecisionStep {
  _DecisionStep({
    required this.question,
    required this.yes,
    required this.no,
    required this.icon,
    required this.tint,
  });
  final String question;
  final String yes;
  final String no;
  final IconData icon;
  final Color tint;
}

Widget _yesNo(
  BuildContext context, {
  required String label,
  required String detail,
  required bool positive,
}) {
  final cs = Theme.of(context).colorScheme;
  final color = positive ? Colors.green.shade700 : Colors.blueGrey.shade600;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: color.withValues(alpha: 0.6)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
      ),
      const SizedBox(width: 10.0),
      Expanded(
        child: Text(
          detail,
          style: TextStyle(
            fontSize: 12.0,
            color: cs.onSurfaceVariant,
            height: 1.35,
          ),
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 8: Glossary and recipes recap.
//
// A glossary of related terms readers will encounter when working through the
// migration, plus a final "key takeaways" summary panel.
// ============================================================================
Widget _buildGlossary(BuildContext context) {
  print('=== Section 8: Glossary and key takeaways ===');
  final cs = Theme.of(context).colorScheme;

  final entries = <_GlossaryEntry>[
    _GlossaryEntry(
      term: 'ButtonBar',
      meaning:
          'A deprecated horizontal arrangement of children used historically '
          'for dialog action rows. Hosted ButtonBarLayoutBehavior.',
      icon: Icons.view_week_outlined,
      tint: cs.primary,
    ),
    _GlossaryEntry(
      term: 'ButtonBarLayoutBehavior',
      meaning:
          'The deprecated enum with values constrained and padded. Controlled '
          'whether the bar reserved a minimum height or simply added padding.',
      icon: Icons.tune_rounded,
      tint: cs.tertiary,
    ),
    _GlossaryEntry(
      term: 'constrained',
      meaning:
          'Enum value forcing a minimum height (52px default). Produces '
          'consistent dialog-style footprints.',
      icon: Icons.height_rounded,
      tint: cs.primary,
    ),
    _GlossaryEntry(
      term: 'padded',
      meaning:
          'Enum value collapsing height to the children while adding theme '
          'padding around them.',
      icon: Icons.space_bar_rounded,
      tint: cs.tertiary,
    ),
    _GlossaryEntry(
      term: 'OverflowBar',
      meaning:
          'Modern replacement that wraps overflowing children onto another '
          'line. Exposes alignment, overflowAlignment, spacing, '
          'overflowSpacing, and overflowDirection.',
      icon: Icons.wrap_text_rounded,
      tint: cs.secondary,
    ),
    _GlossaryEntry(
      term: 'ConstrainedBox',
      meaning:
          'Generic layout primitive used to enforce min/max width or height. '
          'Pairs naturally with OverflowBar to recreate constrained behavior.',
      icon: Icons.crop_din_rounded,
      tint: cs.primary,
    ),
    _GlossaryEntry(
      term: 'AlertDialog.actionsPadding',
      meaning:
          'Replacement knob for what ButtonBar used to control via theme. '
          'Sets the padding around the actions row inside an AlertDialog.',
      icon: Icons.format_indent_increase_rounded,
      tint: cs.tertiary,
    ),
    _GlossaryEntry(
      term: 'overflowDirection',
      meaning:
          'OverflowBar parameter controlling whether wrapped rows go down or '
          'up. Maps to VerticalDirection.',
      icon: Icons.unfold_more_rounded,
      tint: cs.secondary,
    ),
  ];

  final glossaryGrid = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final isWide = constraints.maxWidth > 720.0;
      final columns = isWide ? 2 : 1;
      final widgets = entries.map((_GlossaryEntry e) {
        return Container(
          margin: const EdgeInsets.all(6.0),
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: e.tint.withValues(alpha: 0.35)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: e.tint.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(e.icon, color: e.tint, size: 20.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      e.term,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: e.tint,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      e.meaning,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: cs.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList();

      if (columns == 1) {
        return Column(children: widgets);
      }
      final pairRows = <Widget>[];
      for (int i = 0; i < widgets.length; i += 2) {
        final left = widgets[i];
        final right = i + 1 < widgets.length
            ? widgets[i + 1]
            : const SizedBox.shrink();
        pairRows.add(
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: left),
                Expanded(child: right),
              ],
            ),
          ),
        );
      }
      return Column(children: pairRows);
    },
  );

  final takeaways = Container(
    margin: const EdgeInsets.only(top: 18.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          cs.primaryContainer.withValues(alpha: 0.85),
          cs.tertiaryContainer.withValues(alpha: 0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.task_alt_rounded, color: cs.primary, size: 26.0),
            const SizedBox(width: 10.0),
            Text(
              'Key takeaways',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _takeawayItem(
          context,
          icon: Icons.archive_outlined,
          title: 'ButtonBar is deprecated',
          detail:
              'Treat any code touching ButtonBar or ButtonBarLayoutBehavior as '
              'tech debt and budget a migration pass.',
        ),
        _takeawayItem(
          context,
          icon: Icons.layers_outlined,
          title: 'Compose, do not configure',
          detail:
              'The old enum bundled two responsibilities. Replace it with '
              'OverflowBar plus Padding and/or ConstrainedBox.',
        ),
        _takeawayItem(
          context,
          icon: Icons.wrap_text_rounded,
          title: 'OverflowBar earns its name',
          detail:
              'On narrow screens it wraps to additional rows instead of '
              'clipping silently, which is something ButtonBar never did.',
        ),
        _takeawayItem(
          context,
          icon: Icons.dashboard_customize_outlined,
          title: 'Material 3 dialogs already use it',
          detail:
              'AlertDialog and Dialog use OverflowBar under the hood. Prefer '
              'actionsPadding over manual ButtonBar wrappers.',
        ),
        _takeawayItem(
          context,
          icon: Icons.history_edu_outlined,
          title: 'Keep this script as living documentation',
          detail:
              'The D4rt AST runner renders this file deterministically, so it '
              'doubles as an integration test that the deprecated APIs still '
              'parse correctly under the interpreter.',
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(context, '8', 'Glossary and key takeaways'),
      const SizedBox(height: 14.0),
      glossaryGrid,
      takeaways,
    ],
  );
}

class _GlossaryEntry {
  _GlossaryEntry({
    required this.term,
    required this.meaning,
    required this.icon,
    required this.tint,
  });
  final String term;
  final String meaning;
  final IconData icon;
  final Color tint;
}

Widget _takeawayItem(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String detail,
}) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: cs.surface.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: cs.outlineVariant),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: cs.primary, size: 18.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 11.5,
                  color: cs.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Shared helpers.
// ============================================================================

/// Renders the "=== Section N: title ===" badge used at the top of every
/// section. Also prints the same string to stdout so the script can be
/// followed in console output.
Widget _sectionTitle(BuildContext context, String number, String title) {
  final cs = Theme.of(context).colorScheme;
  print('=== Section $number: $title ===');
  return Row(
    children: <Widget>[
      Container(
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: cs.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
      ),
    ],
  );
}
