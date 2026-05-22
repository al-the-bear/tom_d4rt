// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// Deep visual demo for the Material 3 enum DropdownMenuCloseBehavior.
//
// Design plan
// -----------
// The enum DropdownMenuCloseBehavior has three values: all, self, none.
// It tells a DropdownMenu what to do when an item inside it is activated
// or the user taps outside. Because the AST runner is static (no event
// loop, no real tap), we cannot record an actual open->select->close
// animation. Instead we render diagrammatic "before / after" pairs that
// show, side by side, what the user would see at the moment of selection
// for each behavior, and we render real DropdownMenu specimens configured
// with each closeBehavior so that the configuration is round-tripped
// through the widget tree (proving the parameter accepts the value).
//
// Sections (each prints "=== Section N: <title> ===" and builds widgets):
//   1. Header banner + enum identity matrix (gradient + chips).
//   2. Behavior table: side-by-side cards for all / self / none.
//   3. Static DropdownMenu specimens with each closeBehavior wired.
//   4. Before/after diagrammatic strips (open menu -> tap item -> result).
//   5. Decision matrix: scenario rows x behavior columns scoring grid.
//   6. Interaction notes: composition with menuStyle, requestFocusOnTap,
//      enableFilter, enableSearch, initialSelection.
//   7. Recipe gallery: single-select, search-as-you-type, persistent
//      multi-action (using close=none to keep menu open).
//   8. Glossary + key takeaways summary panel.
//
// All visuals use a Material 3 ColorScheme.fromSeed(deepPurple) palette,
// with accent ramps from indigo (all), teal (self), and amber (none).
import 'package:flutter/material.dart';

// =============================================================================
// Root widget
// =============================================================================

class DropdownMenuCloseBehaviorDemoApp extends StatelessWidget {
  const DropdownMenuCloseBehaviorDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    );
    final theme = ThemeData(colorScheme: scheme, useMaterial3: true);

    print('DropdownMenuCloseBehavior deep visual demo starting');
    print('Enum values count: ${DropdownMenuCloseBehavior.values.length}');
    for (final v in DropdownMenuCloseBehavior.values) {
      print('  - ${v.name} (index ${v.index})');
    }

    return MaterialApp(
      title: 'DropdownMenuCloseBehavior Deep Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeaderBanner(scheme),
              const SizedBox(height: 28.0),
              _buildSection1IdentityMatrix(scheme),
              const SizedBox(height: 36.0),
              _buildSection2BehaviorTable(scheme),
              const SizedBox(height: 36.0),
              _buildSection3LiveSpecimens(scheme),
              const SizedBox(height: 36.0),
              _buildSection4BeforeAfterStrips(scheme),
              const SizedBox(height: 36.0),
              _buildSection5DecisionMatrix(scheme),
              const SizedBox(height: 36.0),
              _buildSection6InteractionNotes(scheme),
              const SizedBox(height: 36.0),
              _buildSection7RecipeGallery(scheme),
              const SizedBox(height: 36.0),
              _buildSection8GlossarySummary(scheme),
              const SizedBox(height: 40.0),
              _buildFooter(scheme),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Per-behavior visual identity helpers.
// We keep a stable color/icon/name triplet per enum value so every section
// reinforces the same mental model.
// =============================================================================

Color _accentForBehavior(DropdownMenuCloseBehavior b) {
  switch (b) {
    case DropdownMenuCloseBehavior.all:
      return const Color(0xFF3F51B5); // indigo 500
    case DropdownMenuCloseBehavior.self:
      return const Color(0xFF009688); // teal 500
    case DropdownMenuCloseBehavior.none:
      return const Color(0xFFFFA000); // amber 700
  }
}

Color _softFillForBehavior(DropdownMenuCloseBehavior b) {
  return _accentForBehavior(b).withValues(alpha: 0.10);
}

IconData _iconForBehavior(DropdownMenuCloseBehavior b) {
  switch (b) {
    case DropdownMenuCloseBehavior.all:
      return Icons.layers_clear;
    case DropdownMenuCloseBehavior.self:
      return Icons.close;
    case DropdownMenuCloseBehavior.none:
      return Icons.lock_open;
  }
}

String _shortLabelForBehavior(DropdownMenuCloseBehavior b) {
  switch (b) {
    case DropdownMenuCloseBehavior.all:
      return 'Close every open menu in the tree';
    case DropdownMenuCloseBehavior.self:
      return 'Close only this dropdown menu';
    case DropdownMenuCloseBehavior.none:
      return 'Keep the dropdown menu open';
  }
}

String _longBlurbForBehavior(DropdownMenuCloseBehavior b) {
  switch (b) {
    case DropdownMenuCloseBehavior.all:
      return
          'Default. After a selection (or outside tap) the framework dismisses '
          'every open menu route in the widget tree. This is what most users '
          'expect from a classic combobox: pick a value, dialog goes away.';
    case DropdownMenuCloseBehavior.self:
      return
          'Closes the local DropdownMenu but leaves any ancestor menus or '
          'popovers open. Useful when this dropdown lives inside a larger '
          'menu/popover/sheet that has its own dismissal contract.';
    case DropdownMenuCloseBehavior.none:
      return
          'No automatic dismissal at all. The caller decides when (or whether) '
          'to close the menu. Useful for persistent multi-action panels or '
          'live-filter UIs where the menu must remain visible.';
  }
}

// =============================================================================
// Header banner (gradient).
// =============================================================================

Widget _buildHeaderBanner(ColorScheme scheme) {
  print('=== Section 0: Header banner ===');
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          scheme.primary,
          scheme.tertiary,
          scheme.secondary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72.0,
          height: 72.0,
          decoration: BoxDecoration(
            color: scheme.onPrimary.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(
              color: scheme.onPrimary.withValues(alpha: 0.5),
              width: 2.0,
            ),
          ),
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: scheme.onPrimary,
            size: 40.0,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DropdownMenuCloseBehavior',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w800,
                  color: scheme.onPrimary,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Material 3 enum that controls dismissal of DropdownMenu',
                style: TextStyle(
                  fontSize: 14.0,
                  color: scheme.onPrimary.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 6.0,
                children: <Widget>[
                  for (final v in DropdownMenuCloseBehavior.values)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.onPrimary.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        '.${v.name}',
                        style: TextStyle(
                          color: scheme.onPrimary,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 1: Identity matrix.
// =============================================================================

Widget _buildSection1IdentityMatrix(ColorScheme scheme) {
  print('=== Section 1: Identity & enum metadata ===');
  final values = DropdownMenuCloseBehavior.values;

  // Equality grid: for each pair (a,b) note a==b.
  final identityRows = <Widget>[];

  // Header row.
  identityRows.add(
    Row(
      children: <Widget>[
        const SizedBox(width: 92.0),
        for (final v in values)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.center,
              child: Text(
                '.${v.name}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: _accentForBehavior(v),
                ),
              ),
            ),
          ),
      ],
    ),
  );

  for (final a in values) {
    final cells = <Widget>[];
    cells.add(
      SizedBox(
        width: 92.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            '.${a.name}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: _accentForBehavior(a),
            ),
          ),
        ),
      ),
    );
    for (final b in values) {
      final eq = identical(a, b);
      cells.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: eq
                  ? _accentForBehavior(a).withValues(alpha: 0.18)
                  : scheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Icon(
              eq ? Icons.check_circle : Icons.remove_circle_outline,
              color: eq
                  ? _accentForBehavior(a)
                  : scheme.onSurfaceVariant.withValues(alpha: 0.6),
              size: 20.0,
            ),
          ),
        ),
      );
    }
    identityRows.add(Row(children: cells));
  }

  // Metadata strip: index, name, hashCode bucket.
  final metadataCards = <Widget>[];
  for (final v in values) {
    metadataCards.add(
      Container(
        width: 200.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: _softFillForBehavior(v),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: _accentForBehavior(v).withValues(alpha: 0.6),
            width: 1.4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  _iconForBehavior(v),
                  color: _accentForBehavior(v),
                  size: 22.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  '.${v.name}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: _accentForBehavior(v),
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            _kv('index', '${v.index}', scheme),
            _kv('name', v.name, scheme),
            _kv('runtimeType', v.runtimeType.toString(), scheme),
            _kv('toString', v.toString(), scheme),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    scheme: scheme,
    number: '1',
    title: 'Enum identity & metadata',
    subtitle:
        'Three values, mutually exclusive. Equality is reference identity '
        '(enum constants are canonical).',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(children: identityRows),
        ),
        const SizedBox(height: 16.0),
        Wrap(alignment: WrapAlignment.center, children: metadataCards),
      ],
    ),
  );
}

Widget _kv(String key, String value, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 84.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.0,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 2: Behavior table (side by side cards).
// =============================================================================

Widget _buildSection2BehaviorTable(ColorScheme scheme) {
  print('=== Section 2: Behavior table ===');
  final cards = <Widget>[];
  for (final v in DropdownMenuCloseBehavior.values) {
    final accent = _accentForBehavior(v);
    cards.add(
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(6.0),
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: accent.withValues(alpha: 0.5), width: 2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: accent.withValues(alpha: 0.12),
                blurRadius: 10.0,
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
                      color: _softFillForBehavior(v),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _iconForBehavior(v),
                      color: accent,
                      size: 26.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      '.${v.name}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: accent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              Text(
                _shortLabelForBehavior(v),
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                _longBlurbForBehavior(v),
                style: TextStyle(
                  fontSize: 12.0,
                  color: scheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14.0),
              _behaviorAttributeRow(
                  'On item tap', _onItemTapText(v), accent, scheme),
              _behaviorAttributeRow(
                  'Outside tap', _onOutsideTapText(v), accent, scheme),
              _behaviorAttributeRow(
                  'Esc key', _onEscapeText(v), accent, scheme),
              _behaviorAttributeRow(
                  'Nested menus', _nestedMenusText(v), accent, scheme),
            ],
          ),
        ),
      ),
    );
  }

  return _sectionShell(
    scheme: scheme,
    number: '2',
    title: 'Behavior table',
    subtitle:
        'Compare the three values across the four dismissal triggers people '
        'most often think about.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cards,
    ),
  );
}

String _onItemTapText(DropdownMenuCloseBehavior b) {
  switch (b) {
    case DropdownMenuCloseBehavior.all:
      return 'Closes this menu AND all ancestor menus.';
    case DropdownMenuCloseBehavior.self:
      return 'Closes this menu only.';
    case DropdownMenuCloseBehavior.none:
      return 'Menu stays open; selection still fires.';
  }
}

String _onOutsideTapText(DropdownMenuCloseBehavior b) {
  switch (b) {
    case DropdownMenuCloseBehavior.all:
      return 'Standard dismiss-on-outside behavior.';
    case DropdownMenuCloseBehavior.self:
      return 'Standard dismiss-on-outside behavior.';
    case DropdownMenuCloseBehavior.none:
      return 'Outside tap still closes (modal barrier).';
  }
}

String _onEscapeText(DropdownMenuCloseBehavior b) {
  switch (b) {
    case DropdownMenuCloseBehavior.all:
      return 'Esc closes the dropdown.';
    case DropdownMenuCloseBehavior.self:
      return 'Esc closes the dropdown.';
    case DropdownMenuCloseBehavior.none:
      return 'Esc closes the dropdown.';
  }
}

String _nestedMenusText(DropdownMenuCloseBehavior b) {
  switch (b) {
    case DropdownMenuCloseBehavior.all:
      return 'Bubbles up; parents close too.';
    case DropdownMenuCloseBehavior.self:
      return 'Local only; parents stay open.';
    case DropdownMenuCloseBehavior.none:
      return 'No cascade. Caller-controlled.';
  }
}

Widget _behaviorAttributeRow(
    String label, String value, Color accent, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.only(top: 5.0, right: 8.0),
          decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        ),
        SizedBox(
          width: 78.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              color: scheme.onSurface,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 3: Live DropdownMenu specimens.
// Real Flutter widgets configured with each enum value. In a static AST
// context they will not animate open, but the widget tree must accept and
// render them correctly.
// =============================================================================

Widget _buildSection3LiveSpecimens(ColorScheme scheme) {
  print('=== Section 3: Live DropdownMenu specimens ===');

  final fruitEntries = <DropdownMenuEntry<String>>[
    const DropdownMenuEntry<String>(value: 'apple', label: 'Apple'),
    const DropdownMenuEntry<String>(value: 'banana', label: 'Banana'),
    const DropdownMenuEntry<String>(value: 'cherry', label: 'Cherry'),
    const DropdownMenuEntry<String>(value: 'date', label: 'Date'),
  ];

  final colorEntries = <DropdownMenuEntry<int>>[
    const DropdownMenuEntry<int>(value: 0, label: 'Crimson'),
    const DropdownMenuEntry<int>(value: 1, label: 'Indigo'),
    const DropdownMenuEntry<int>(value: 2, label: 'Teal'),
    const DropdownMenuEntry<int>(value: 3, label: 'Amber'),
  ];

  final modeEntries = <DropdownMenuEntry<String>>[
    const DropdownMenuEntry<String>(value: 'light', label: 'Light'),
    const DropdownMenuEntry<String>(value: 'dark', label: 'Dark'),
    const DropdownMenuEntry<String>(value: 'auto', label: 'Auto'),
  ];

  final specimens = <Widget>[
    _specimenCard(
      scheme: scheme,
      behavior: DropdownMenuCloseBehavior.all,
      child: DropdownMenu<String>(
        initialSelection: 'apple',
        label: const Text('Fruit (close=all)'),
        leadingIcon: const Icon(Icons.eco),
        closeBehavior: DropdownMenuCloseBehavior.all,
        dropdownMenuEntries: fruitEntries,
      ),
      caption:
          'Default behavior. Tapping a fruit dismisses every open menu in '
          'the route.',
    ),
    _specimenCard(
      scheme: scheme,
      behavior: DropdownMenuCloseBehavior.self,
      child: DropdownMenu<int>(
        initialSelection: 1,
        label: const Text('Accent color (close=self)'),
        leadingIcon: const Icon(Icons.palette),
        closeBehavior: DropdownMenuCloseBehavior.self,
        dropdownMenuEntries: colorEntries,
      ),
      caption:
          'Only this dropdown closes on selection. Ancestor menus / popovers '
          'remain visible for further configuration.',
    ),
    _specimenCard(
      scheme: scheme,
      behavior: DropdownMenuCloseBehavior.none,
      child: DropdownMenu<String>(
        initialSelection: 'auto',
        label: const Text('Theme mode (close=none)'),
        leadingIcon: const Icon(Icons.brightness_6),
        closeBehavior: DropdownMenuCloseBehavior.none,
        dropdownMenuEntries: modeEntries,
      ),
      caption:
          'Selection does not auto-close. Suitable for live previews where '
          'the user wants to compare several values.',
    ),
  ];

  return _sectionShell(
    scheme: scheme,
    number: '3',
    title: 'Live specimens',
    subtitle:
        'Each DropdownMenu below is built with the labelled closeBehavior. '
        'Open them in the running app to feel the difference.',
    body: Wrap(spacing: 12.0, runSpacing: 12.0, children: specimens),
  );
}

Widget _specimenCard({
  required ColorScheme scheme,
  required DropdownMenuCloseBehavior behavior,
  required Widget child,
  required String caption,
}) {
  final accent = _accentForBehavior(behavior);
  return Container(
    width: 320.0,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: _softFillForBehavior(behavior),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(_iconForBehavior(behavior), color: accent, size: 14.0),
                  const SizedBox(width: 5.0),
                  Text(
                    '.${behavior.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        child,
        const SizedBox(height: 10.0),
        Text(
          caption,
          style: TextStyle(
            fontSize: 11.5,
            color: scheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 4: Before/After diagrammatic strips.
// We draw what the user sees the instant before and after they tap an item.
// =============================================================================

Widget _buildSection4BeforeAfterStrips(ColorScheme scheme) {
  print('=== Section 4: Before/after diagrammatic strips ===');
  final strips = <Widget>[];
  for (final v in DropdownMenuCloseBehavior.values) {
    strips.add(_beforeAfterStrip(v, scheme));
    strips.add(const SizedBox(height: 16.0));
  }
  return _sectionShell(
    scheme: scheme,
    number: '4',
    title: 'Before / after dismissal',
    subtitle:
        'Snapshot of the menu surface immediately before the tap (left) and '
        'immediately after (right).',
    body: Column(children: strips),
  );
}

Widget _beforeAfterStrip(DropdownMenuCloseBehavior b, ColorScheme scheme) {
  final accent = _accentForBehavior(b);
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(_iconForBehavior(b), color: accent, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              '.${b.name}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: accent,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                _shortLabelForBehavior(b),
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _diagramBefore(scheme)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.east, color: accent, size: 28.0),
                  const SizedBox(height: 4.0),
                  Text(
                    'tap "Indigo"',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _diagramAfter(b, scheme)),
          ],
        ),
      ],
    ),
  );
}

Widget _diagramBefore(ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: scheme.outlineVariant),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _fakeMenuChrome('Settings popover', Icons.tune, scheme,
            innerOpen: true),
      ],
    ),
  );
}

Widget _diagramAfter(DropdownMenuCloseBehavior b, ColorScheme scheme) {
  // Show whether the dropdown closed and whether the parent popover closed.
  final bool dropdownClosed = b != DropdownMenuCloseBehavior.none;
  final bool parentClosed = b == DropdownMenuCloseBehavior.all;
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: scheme.outlineVariant),
    ),
    child: parentClosed
        ? _emptyAfter(scheme)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _fakeMenuChrome(
                'Settings popover',
                Icons.tune,
                scheme,
                innerOpen: !dropdownClosed,
              ),
            ],
          ),
  );
}

Widget _emptyAfter(ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24.0),
    child: Column(
      children: <Widget>[
        Icon(Icons.visibility_off,
            color: scheme.onSurfaceVariant.withValues(alpha: 0.7), size: 28.0),
        const SizedBox(height: 6.0),
        Text(
          'Everything dismissed',
          style: TextStyle(fontSize: 11.0, color: scheme.onSurfaceVariant),
        ),
      ],
    ),
  );
}

Widget _fakeMenuChrome(
  String title,
  IconData icon,
  ColorScheme scheme, {
  required bool innerOpen,
}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: scheme.secondaryContainer.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 16.0, color: scheme.onSecondaryContainer),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: scheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        // The inner DropdownMenu mock.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.color_lens,
                  size: 14.0, color: scheme.onSurfaceVariant),
              const SizedBox(width: 6.0),
              Text(
                'Accent color',
                style: TextStyle(
                  fontSize: 11.0,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Icon(
                innerOpen ? Icons.expand_less : Icons.expand_more,
                size: 14.0,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        if (innerOpen) ...<Widget>[
          const SizedBox(height: 4.0),
          _miniMenuEntry('Crimson', scheme, highlighted: false),
          _miniMenuEntry('Indigo', scheme, highlighted: true),
          _miniMenuEntry('Teal', scheme, highlighted: false),
          _miniMenuEntry('Amber', scheme, highlighted: false),
        ],
      ],
    ),
  );
}

Widget _miniMenuEntry(String label, ColorScheme scheme,
    {required bool highlighted}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 1.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: highlighted
          ? scheme.primary.withValues(alpha: 0.16)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        color: highlighted ? scheme.primary : scheme.onSurface,
        fontWeight: highlighted ? FontWeight.w600 : FontWeight.normal,
      ),
    ),
  );
}

// =============================================================================
// Section 5: Decision matrix.
// =============================================================================

Widget _buildSection5DecisionMatrix(ColorScheme scheme) {
  print('=== Section 5: Decision matrix ===');

  // For each scenario, score each enum value as: best / ok / avoid.
  final scenarios = <_ScenarioRow>[
    _ScenarioRow(
      'Simple form field combobox',
      Icons.input,
      <DropdownMenuCloseBehavior, _Score>{
        DropdownMenuCloseBehavior.all: _Score.best,
        DropdownMenuCloseBehavior.self: _Score.ok,
        DropdownMenuCloseBehavior.none: _Score.avoid,
      },
    ),
    _ScenarioRow(
      'Dropdown inside a PopupMenu',
      Icons.menu_open,
      <DropdownMenuCloseBehavior, _Score>{
        DropdownMenuCloseBehavior.all: _Score.avoid,
        DropdownMenuCloseBehavior.self: _Score.best,
        DropdownMenuCloseBehavior.none: _Score.ok,
      },
    ),
    _ScenarioRow(
      'Search-as-you-type filter',
      Icons.search,
      <DropdownMenuCloseBehavior, _Score>{
        DropdownMenuCloseBehavior.all: _Score.ok,
        DropdownMenuCloseBehavior.self: _Score.ok,
        DropdownMenuCloseBehavior.none: _Score.best,
      },
    ),
    _ScenarioRow(
      'Persistent multi-action panel',
      Icons.dynamic_form,
      <DropdownMenuCloseBehavior, _Score>{
        DropdownMenuCloseBehavior.all: _Score.avoid,
        DropdownMenuCloseBehavior.self: _Score.avoid,
        DropdownMenuCloseBehavior.none: _Score.best,
      },
    ),
    _ScenarioRow(
      'Wizard step selector',
      Icons.assignment_turned_in,
      <DropdownMenuCloseBehavior, _Score>{
        DropdownMenuCloseBehavior.all: _Score.best,
        DropdownMenuCloseBehavior.self: _Score.ok,
        DropdownMenuCloseBehavior.none: _Score.avoid,
      },
    ),
    _ScenarioRow(
      'Dropdown inside a BottomSheet',
      Icons.layers,
      <DropdownMenuCloseBehavior, _Score>{
        DropdownMenuCloseBehavior.all: _Score.avoid,
        DropdownMenuCloseBehavior.self: _Score.best,
        DropdownMenuCloseBehavior.none: _Score.ok,
      },
    ),
    _ScenarioRow(
      'Live theme preview chooser',
      Icons.brush,
      <DropdownMenuCloseBehavior, _Score>{
        DropdownMenuCloseBehavior.all: _Score.avoid,
        DropdownMenuCloseBehavior.self: _Score.ok,
        DropdownMenuCloseBehavior.none: _Score.best,
      },
    ),
  ];

  final rows = <Widget>[];

  // Header row.
  rows.add(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.6),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 28.0),
          Expanded(
            flex: 4,
            child: Text(
              'Scenario',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          for (final v in DropdownMenuCloseBehavior.values)
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  '.${v.name}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: _accentForBehavior(v),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );

  for (int i = 0; i < scenarios.length; i++) {
    final s = scenarios[i];
    final zebra = i.isEven
        ? scheme.surface
        : scheme.surfaceContainerLow.withValues(alpha: 0.6);
    rows.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(color: zebra),
        child: Row(
          children: <Widget>[
            Icon(s.icon, size: 18.0, color: scheme.onSurfaceVariant),
            const SizedBox(width: 10.0),
            Expanded(
              flex: 4,
              child: Text(
                s.title,
                style: TextStyle(
                  fontSize: 12.5,
                  color: scheme.onSurface,
                ),
              ),
            ),
            for (final v in DropdownMenuCloseBehavior.values)
              Expanded(
                flex: 2,
                child: Center(child: _scoreBadge(s.scores[v]!, scheme)),
              ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    scheme: scheme,
    number: '5',
    title: 'Decision matrix',
    subtitle:
        'Quick-pick which closeBehavior fits the scenario at hand. Scores '
        'are heuristic, not absolute.',
    body: Container(
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Column(children: rows),
      ),
    ),
  );
}

enum _Score { best, ok, avoid }

class _ScenarioRow {
  _ScenarioRow(this.title, this.icon, this.scores);
  final String title;
  final IconData icon;
  final Map<DropdownMenuCloseBehavior, _Score> scores;
}

Widget _scoreBadge(_Score score, ColorScheme scheme) {
  late Color color;
  late IconData icon;
  late String label;
  switch (score) {
    case _Score.best:
      color = Colors.green.shade600;
      icon = Icons.star;
      label = 'best';
      break;
    case _Score.ok:
      color = Colors.blueGrey.shade500;
      icon = Icons.check;
      label = 'ok';
      break;
    case _Score.avoid:
      color = Colors.red.shade400;
      icon = Icons.block;
      label = 'avoid';
      break;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 12.0, color: color),
        const SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 6: Interaction notes (composition with sibling parameters).
// =============================================================================

Widget _buildSection6InteractionNotes(ColorScheme scheme) {
  print('=== Section 6: Interaction notes ===');

  final notes = <_NoteCard>[
    _NoteCard(
      icon: Icons.center_focus_strong,
      title: 'requestFocusOnTap',
      body:
          'Independent of closeBehavior. When closeBehavior is none, you '
          'usually still want requestFocusOnTap=true so the user can type '
          'to filter without an extra click.',
      color: scheme.primary,
    ),
    _NoteCard(
      icon: Icons.filter_alt,
      title: 'enableFilter & enableSearch',
      body:
          'Search-as-you-type UIs typically pair closeBehavior=none with '
          'enableFilter=true. The menu must stay open while the user '
          'narrows results.',
      color: scheme.tertiary,
    ),
    _NoteCard(
      icon: Icons.style,
      title: 'menuStyle',
      body:
          'menuStyle controls visual chrome only. It has no effect on close '
          'semantics, but combining a custom menuStyle with closeBehavior='
          'none lets you build floating "command palette" surfaces.',
      color: scheme.secondary,
    ),
    _NoteCard(
      icon: Icons.first_page,
      title: 'initialSelection',
      body:
          'When closeBehavior=none, the menu does not auto-dismiss, so the '
          'initialSelection acts as a recurring visual anchor as the user '
          'tries other rows.',
      color: const Color(0xFF7E57C2),
    ),
    _NoteCard(
      icon: Icons.format_align_left,
      title: 'alignmentOffset',
      body:
          'closeBehavior does not change the menu position. Use '
          'alignmentOffset for fine alignment regardless of the dismissal '
          'strategy you pick.',
      color: const Color(0xFFEC407A),
    ),
    _NoteCard(
      icon: Icons.warning_amber,
      title: 'Nested menu pitfalls',
      body:
          'closeBehavior=all inside a PopupMenu/PopoverMenu/BottomSheet will '
          'collapse the entire stack on selection. Prefer self in nested '
          'contexts unless that is exactly what you want.',
      color: Colors.deepOrange.shade400,
    ),
  ];

  final cards = <Widget>[];
  for (final n in notes) {
    cards.add(
      Container(
        width: 320.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: n.color.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: n.color.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(n.icon, color: n.color, size: 18.0),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    n.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: n.color,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              n.body,
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onSurface,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    scheme: scheme,
    number: '6',
    title: 'Interaction notes',
    subtitle:
        'How closeBehavior composes with the other DropdownMenu knobs you '
        'will probably set on the same widget.',
    body: Wrap(alignment: WrapAlignment.start, children: cards),
  );
}

class _NoteCard {
  _NoteCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color color;
}

// =============================================================================
// Section 7: Recipe gallery.
// =============================================================================

Widget _buildSection7RecipeGallery(ColorScheme scheme) {
  print('=== Section 7: Recipe gallery ===');

  final recipes = <Widget>[
    _recipeSingleSelect(scheme),
    _recipeSearchAsYouType(scheme),
    _recipePersistentMultiAction(scheme),
    _recipeNestedSelfClose(scheme),
  ];

  return _sectionShell(
    scheme: scheme,
    number: '7',
    title: 'Recipe gallery',
    subtitle:
        'Four end-to-end patterns. Each card pairs a working DropdownMenu '
        'specimen with the snippet that produces it.',
    body: Column(children: recipes),
  );
}

Widget _recipeFrame({
  required ColorScheme scheme,
  required String title,
  required String summary,
  required Widget specimen,
  required String code,
  required Color accent,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.10),
          blurRadius: 8.0,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.restaurant_menu, color: accent, size: 18.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          summary,
          style: TextStyle(
            fontSize: 12.0,
            color: scheme.onSurfaceVariant,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: specimen),
            const SizedBox(width: 16.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.greenAccent.shade100,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _recipeSingleSelect(ColorScheme scheme) {
  final accent = _accentForBehavior(DropdownMenuCloseBehavior.all);
  return _recipeFrame(
    scheme: scheme,
    title: 'Recipe 1 — Single-select form field',
    summary:
        'The canonical use case. closeBehavior defaults to all so you can '
        'usually omit it.',
    accent: accent,
    specimen: DropdownMenu<String>(
      label: const Text('Country'),
      initialSelection: 'CH',
      leadingIcon: const Icon(Icons.public),
      dropdownMenuEntries: const <DropdownMenuEntry<String>>[
        DropdownMenuEntry<String>(value: 'CH', label: 'Switzerland'),
        DropdownMenuEntry<String>(value: 'DE', label: 'Germany'),
        DropdownMenuEntry<String>(value: 'FR', label: 'France'),
        DropdownMenuEntry<String>(value: 'IT', label: 'Italy'),
      ],
    ),
    code:
        'DropdownMenu<String>(\n'
        '  label: const Text("Country"),\n'
        '  initialSelection: "CH",\n'
        '  // closeBehavior defaults to .all\n'
        '  dropdownMenuEntries: countries,\n'
        ')',
  );
}

Widget _recipeSearchAsYouType(ColorScheme scheme) {
  final accent = _accentForBehavior(DropdownMenuCloseBehavior.none);
  return _recipeFrame(
    scheme: scheme,
    title: 'Recipe 2 — Search-as-you-type',
    summary:
        'Combine closeBehavior=none with enableFilter=true. The menu stays '
        'open while the user narrows the result set.',
    accent: accent,
    specimen: DropdownMenu<String>(
      label: const Text('Find a city'),
      enableFilter: true,
      requestFocusOnTap: true,
      leadingIcon: const Icon(Icons.search),
      closeBehavior: DropdownMenuCloseBehavior.none,
      dropdownMenuEntries: const <DropdownMenuEntry<String>>[
        DropdownMenuEntry<String>(value: 'zur', label: 'Zurich'),
        DropdownMenuEntry<String>(value: 'gen', label: 'Geneva'),
        DropdownMenuEntry<String>(value: 'ber', label: 'Bern'),
        DropdownMenuEntry<String>(value: 'bas', label: 'Basel'),
        DropdownMenuEntry<String>(value: 'lau', label: 'Lausanne'),
      ],
    ),
    code:
        'DropdownMenu<String>(\n'
        '  label: const Text("Find a city"),\n'
        '  enableFilter: true,\n'
        '  requestFocusOnTap: true,\n'
        '  closeBehavior:\n'
        '    DropdownMenuCloseBehavior.none,\n'
        '  dropdownMenuEntries: cities,\n'
        ')',
  );
}

Widget _recipePersistentMultiAction(ColorScheme scheme) {
  final accent = _accentForBehavior(DropdownMenuCloseBehavior.none);
  return _recipeFrame(
    scheme: scheme,
    title: 'Recipe 3 — Persistent multi-action panel',
    summary:
        'Toolbox-style menu where each item triggers an action without '
        'dismissing the surface. The user can chain several actions.',
    accent: accent,
    specimen: DropdownMenu<String>(
      label: const Text('Quick actions'),
      leadingIcon: const Icon(Icons.dynamic_form),
      closeBehavior: DropdownMenuCloseBehavior.none,
      dropdownMenuEntries: const <DropdownMenuEntry<String>>[
        DropdownMenuEntry<String>(
          value: 'duplicate',
          label: 'Duplicate row',
          leadingIcon: Icon(Icons.copy),
        ),
        DropdownMenuEntry<String>(
          value: 'archive',
          label: 'Archive row',
          leadingIcon: Icon(Icons.archive),
        ),
        DropdownMenuEntry<String>(
          value: 'highlight',
          label: 'Highlight row',
          leadingIcon: Icon(Icons.brush),
        ),
      ],
    ),
    code:
        'DropdownMenu<String>(\n'
        '  label: const Text("Quick actions"),\n'
        '  closeBehavior:\n'
        '    DropdownMenuCloseBehavior.none,\n'
        '  dropdownMenuEntries: actions,\n'
        ')',
  );
}

Widget _recipeNestedSelfClose(ColorScheme scheme) {
  final accent = _accentForBehavior(DropdownMenuCloseBehavior.self);
  return _recipeFrame(
    scheme: scheme,
    title: 'Recipe 4 — Nested DropdownMenu (self)',
    summary:
        'When the DropdownMenu lives inside a host popover, use self so a '
        'selection collapses this dropdown but leaves the host visible for '
        'further configuration.',
    accent: accent,
    specimen: DropdownMenu<String>(
      label: const Text('Accent'),
      initialSelection: 'indigo',
      leadingIcon: const Icon(Icons.palette),
      closeBehavior: DropdownMenuCloseBehavior.self,
      dropdownMenuEntries: const <DropdownMenuEntry<String>>[
        DropdownMenuEntry<String>(value: 'indigo', label: 'Indigo'),
        DropdownMenuEntry<String>(value: 'teal', label: 'Teal'),
        DropdownMenuEntry<String>(value: 'amber', label: 'Amber'),
      ],
    ),
    code:
        'DropdownMenu<String>(\n'
        '  label: const Text("Accent"),\n'
        '  closeBehavior:\n'
        '    DropdownMenuCloseBehavior.self,\n'
        '  dropdownMenuEntries: accents,\n'
        ')',
  );
}

// =============================================================================
// Section 8: Glossary + summary.
// =============================================================================

Widget _buildSection8GlossarySummary(ColorScheme scheme) {
  print('=== Section 8: Glossary & key takeaways ===');

  final glossary = <_GlossaryEntry>[
    _GlossaryEntry(
      term: 'DropdownMenu',
      def:
          'Material 3 widget that pairs a TextField with a vertical list of '
          'DropdownMenuEntry items shown in a popup.',
    ),
    _GlossaryEntry(
      term: 'DropdownMenuEntry',
      def:
          'Single row inside a DropdownMenu. Carries a value, label, optional '
          'leading/trailing icons, and an enabled flag.',
    ),
    _GlossaryEntry(
      term: 'closeBehavior',
      def:
          'DropdownMenu parameter typed DropdownMenuCloseBehavior. Defaults '
          'to all. Controls dismissal of the menu on selection.',
    ),
    _GlossaryEntry(
      term: 'requestFocusOnTap',
      def:
          'When true, tapping the TextField focuses it. Orthogonal to '
          'closeBehavior but commonly paired with closeBehavior=none for '
          'search UIs.',
    ),
    _GlossaryEntry(
      term: 'enableFilter / enableSearch',
      def:
          'When set, the menu narrows/scrolls based on typed text. Useful '
          'companions to closeBehavior=none.',
    ),
    _GlossaryEntry(
      term: 'menuStyle',
      def:
          'MenuStyle applied to the popup surface (color, shape, padding). '
          'Has no effect on close semantics.',
    ),
    _GlossaryEntry(
      term: 'modal barrier',
      def:
          'Invisible overlay around an open menu. Catching a tap on it '
          'closes the menu regardless of closeBehavior.',
    ),
    _GlossaryEntry(
      term: 'route dismissal',
      def:
          'Internal mechanism Flutter uses to pop menu routes. all dismisses '
          'all menu routes, self pops only the local one.',
    ),
  ];

  final glossaryWidgets = <Widget>[];
  for (final g in glossary) {
    glossaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              g.term,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: scheme.primary,
                fontSize: 12.5,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              g.def,
              style: TextStyle(
                fontSize: 11.5,
                color: scheme.onSurface,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final takeaways = <_TakeawayItem>[
    _TakeawayItem(
      icon: Icons.flag,
      title: 'Default is .all',
      body:
          'You can omit closeBehavior in 80 % of cases. Only override it '
          'when you have a specific reason.',
      color: _accentForBehavior(DropdownMenuCloseBehavior.all),
    ),
    _TakeawayItem(
      icon: Icons.alt_route,
      title: 'Pick .self for nested surfaces',
      body:
          'If the DropdownMenu lives inside a popover or sheet, .self '
          'preserves the host context after a selection.',
      color: _accentForBehavior(DropdownMenuCloseBehavior.self),
    ),
    _TakeawayItem(
      icon: Icons.all_inclusive,
      title: 'Pick .none for live workflows',
      body:
          'Search-as-you-type, multi-action panels, live previews — these '
          'all want the menu to remain visible across selections.',
      color: _accentForBehavior(DropdownMenuCloseBehavior.none),
    ),
    _TakeawayItem(
      icon: Icons.help_outline,
      title: 'Outside tap still closes',
      body:
          'Even with .none, tapping the modal barrier or pressing Esc still '
          'dismisses the menu. closeBehavior only governs item activation.',
      color: scheme.primary,
    ),
  ];

  return _sectionShell(
    scheme: scheme,
    number: '8',
    title: 'Glossary & key takeaways',
    subtitle:
        'Reference vocabulary and the four bullet points to remember after '
        'closing this file.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                scheme.primaryContainer,
                scheme.tertiaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Key takeaways',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 10.0),
              for (final t in takeaways)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: scheme.surface.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: t.color.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: t.color.withValues(alpha: 0.16),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(t.icon, color: t.color, size: 18.0),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              t.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: t.color,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              t.body,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: scheme.onSurface,
                                height: 1.4,
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
        ),
        const SizedBox(height: 20.0),
        Text(
          'Glossary',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 8.0),
        ...glossaryWidgets,
      ],
    ),
  );
}

class _GlossaryEntry {
  _GlossaryEntry({required this.term, required this.def});
  final String term;
  final String def;
}

class _TakeawayItem {
  _TakeawayItem({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color color;
}

// =============================================================================
// Footer.
// =============================================================================

Widget _buildFooter(ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: scheme.outlineVariant),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.info_outline,
            color: scheme.onSurfaceVariant, size: 18.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'End of demo. DropdownMenuCloseBehavior has exactly three '
            'values: .all (default), .self, and .none. Choose them by '
            'thinking about where the menu lives in the widget tree and '
            'what the user expects to see immediately after a selection.',
            style: TextStyle(
              fontSize: 12.0,
              color: scheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section shell helper — provides consistent section header chrome.
// =============================================================================

Widget _sectionShell({
  required ColorScheme scheme,
  required String number,
  required String title,
  required String subtitle,
  required Widget body,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.4),
                  blurRadius: 8.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: scheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: scheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      body,
    ],
  );
}

// =============================================================================
// Entry point.
// =============================================================================

void main() => runApp(const DropdownMenuCloseBehaviorDemoApp());
