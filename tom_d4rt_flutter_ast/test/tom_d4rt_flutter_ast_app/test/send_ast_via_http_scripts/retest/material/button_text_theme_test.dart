// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for ButtonTextTheme enum.
//
// /// DESIGN PLAN
// /// ============
// /// Subject: ButtonTextTheme enum (normal, accent, primary) - part of the
// /// legacy ButtonTheme system that drove the text-color resolution path for
// /// RaisedButton, FlatButton and OutlineButton. Superseded in Material 3 by
// /// ElevatedButton / OutlinedButton / TextButton + ButtonStyle.
// ///
// /// Sections (all numbered, each prints its banner and renders widgets):
// ///   1. Banner + legacy lineage map: where ButtonTextTheme sits in Material
// ///      history.
// ///   2. Enum value catalog: one rich card per value with role, brightness
// ///      semantics and a swatch.
// ///   3. Legacy specimens: real RaisedButton / FlatButton / OutlineButton
// ///      built under each enum value (deprecated_member_use header covers).
// ///   4. Modern equivalents: ElevatedButton / OutlinedButton / TextButton
// ///      with ButtonStyle.foregroundColor + WidgetStateProperty resolvers.
// ///   5. Side-by-side comparison table and decision matrix.
// ///   6. Migration recipes: textual cookbook + before/after code blocks.
// ///   7. Pitfalls and glossary panel.
// ///
// /// Hand-authored. No templates. Plain ASCII narrative comments only.
import 'package:flutter/material.dart';

void main() => runApp(const ButtonTextThemeDemoApp());

// ============================================================================
// Top-level model: each ButtonTextTheme value with extra metadata that we use
// to build the cards below. We keep this immutable and rely on a const list so
// the AST walker can serialise it cleanly.
// ============================================================================
class _EnumFacts {
  const _EnumFacts({
    required this.value,
    required this.name,
    required this.tagline,
    required this.colorRole,
    required this.brightness,
    required this.swatch,
  });

  final ButtonTextTheme value;
  final String name;
  final String tagline;
  final String colorRole;
  final String brightness;
  final Color swatch;
}

const List<_EnumFacts> _enumCatalog = <_EnumFacts>[
  _EnumFacts(
    value: ButtonTextTheme.normal,
    name: 'normal',
    tagline: 'Black on light themes, white on dark themes.',
    colorRole: 'Inherits from theme.textTheme.button.color',
    brightness: 'Adapts to ThemeData.brightness',
    swatch: Color(0xFF424242),
  ),
  _EnumFacts(
    value: ButtonTextTheme.accent,
    name: 'accent',
    tagline: 'Tinted with the accent / secondary color.',
    colorRole: 'theme.colorScheme.secondary',
    brightness: 'Independent of theme brightness',
    swatch: Color(0xFFE91E63),
  ),
  _EnumFacts(
    value: ButtonTextTheme.primary,
    name: 'primary',
    tagline: 'Contrast text drawn on top of the primary fill.',
    colorRole: 'White or black depending on primary luminance',
    brightness: 'Computed from primary color',
    swatch: Color(0xFF1565C0),
  ),
];

// ============================================================================
// Root widget. Stateless. Renders the entire demo inside a single scrolling
// column so the AST runner can capture it as one frame.
// ============================================================================
class ButtonTextThemeDemoApp extends StatelessWidget {
  const ButtonTextThemeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('ButtonTextTheme Deep Demo executing');

    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1565C0),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ButtonTextTheme Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: scheme),
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildBanner(scheme),
              const SizedBox(height: 28.0),
              _buildSection1(scheme),
              const SizedBox(height: 32.0),
              _buildSection2(scheme),
              const SizedBox(height: 32.0),
              _buildSection3(scheme),
              const SizedBox(height: 32.0),
              _buildSection4(scheme),
              const SizedBox(height: 32.0),
              _buildSection5(scheme),
              const SizedBox(height: 32.0),
              _buildSection6(scheme),
              const SizedBox(height: 32.0),
              _buildSection7(scheme),
              const SizedBox(height: 24.0),
              _buildFooter(scheme),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Header banner with a gradient. This is the visual entry point that
  // grounds the rest of the demo. It also re-states the enum values so the
  // viewer never has to scroll back to the file header for context.
  // --------------------------------------------------------------------------
  Widget _buildBanner(ColorScheme scheme) {
    print('Building header gradient banner');
    return Container(
      padding: const EdgeInsets.all(28.0),
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
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
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
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: const Icon(
                  Icons.smart_button,
                  size: 36.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'ButtonTextTheme',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Legacy enum that drove RaisedButton text color.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 10.0,
            runSpacing: 8.0,
            children: const <Widget>[
              _EnumChip(label: 'normal'),
              _EnumChip(label: 'accent'),
              _EnumChip(label: 'primary'),
              _EnumChip(label: 'deprecated since M3'),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 1. Lineage map. We walk the viewer from RaisedButton through
  // ButtonTheme down to ButtonTextTheme so they understand where the enum
  // even applies. A horizontal pipeline of cards with arrows in between.
  // --------------------------------------------------------------------------
  Widget _buildSection1(ColorScheme scheme) {
    print('=== Section 1: Legacy Lineage Map ===');

    Widget lineageCard(IconData icon, String title, String subtitle,
        Color color, bool deprecated) {
      return Container(
        width: 160.0,
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: color, size: 22.0),
                const Spacer(),
                if (deprecated)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Text(
                      'DEPR',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11.0,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    Widget arrow() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(
            Icons.arrow_forward,
            color: scheme.outline,
            size: 22.0,
          ),
        );

    final Widget pipeline = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          lineageCard(Icons.touch_app, 'RaisedButton',
              'Material 1/2 elevated button widget.', Colors.indigo, true),
          arrow(),
          lineageCard(Icons.layers, 'ButtonTheme',
              'InheritedWidget that owns button defaults.',
              Colors.deepPurple, true),
          arrow(),
          lineageCard(Icons.format_color_text, 'ButtonTextTheme',
              'Enum picking the text color strategy.', Colors.teal, true),
          arrow(),
          lineageCard(Icons.brush, 'ButtonStyle',
              'M3 replacement: WidgetStateProperty values.',
              Colors.green, false),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 1,
          title: 'Legacy Lineage Map',
          subtitle:
              'From RaisedButton -> ButtonTheme -> ButtonTextTheme -> ButtonStyle.',
        ),
        const SizedBox(height: 14.0),
        pipeline,
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline,
                  color: scheme.primary, size: 22.0),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'ButtonTextTheme only controls text color. Fills and shapes '
                  'live on ButtonTheme. In Material 3 both responsibilities '
                  'collapse into ButtonStyle and its WidgetStateProperty '
                  'resolvers.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: scheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 2. Enum value catalog. For each of normal / accent / primary we
  // render a deep card: name, tagline, color role, brightness rule and a big
  // swatch. The cards use a uniform layout but never share data - each is
  // authored against its semantic role.
  // --------------------------------------------------------------------------
  Widget _buildSection2(ColorScheme scheme) {
    print('=== Section 2: Enum Value Catalog ===');

    final List<Widget> cards = <Widget>[];
    for (final _EnumFacts fact in _enumCatalog) {
      print('Cataloging ButtonTextTheme.${fact.name}: ${fact.tagline}');
      cards.add(_buildEnumCard(fact, scheme));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 2,
          title: 'Enum Value Catalog',
          subtitle:
              'Each enum value, its semantic role and the color it resolved to.',
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: cards,
        ),
      ],
    );
  }

  Widget _buildEnumCard(_EnumFacts fact, ColorScheme scheme) {
    return Container(
      width: 280.0,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            fact.swatch.withValues(alpha: 0.10),
            fact.swatch.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: fact.swatch.withValues(alpha: 0.45),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: fact.swatch,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: fact.swatch.withValues(alpha: 0.35),
                      blurRadius: 6.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.format_color_text,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ButtonTextTheme',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: scheme.onSurfaceVariant,
                        letterSpacing: 0.4,
                      ),
                    ),
                    Text(
                      '.${fact.name}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: fact.swatch,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            fact.tagline,
            style: TextStyle(
              fontSize: 13.0,
              height: 1.4,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 12.0),
          _kvRow('Resolves to', fact.colorRole, scheme),
          const SizedBox(height: 6.0),
          _kvRow('Brightness', fact.brightness, scheme),
          const SizedBox(height: 14.0),
          Container(
            height: 26.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  fact.swatch.withValues(alpha: 0.4),
                  fact.swatch,
                ],
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Sample swatch',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kvRow(String key, String value, ColorScheme scheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 90.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.0,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 3. Legacy specimens. RaisedButton / FlatButton / OutlineButton
  // were removed from the framework outright, so we now use MaterialButton -
  // the only public widget that still threads ButtonTextTheme through. We
  // build three flavours per enum value (filled, flat, outlined-by-shape) so
  // the comparison with the M3 triad in Section 4 still holds visually.
  // --------------------------------------------------------------------------
  Widget _buildSection3(ColorScheme scheme) {
    print('=== Section 3: Legacy Specimens ===');

    final List<Widget> rows = <Widget>[];
    for (final _EnumFacts fact in _enumCatalog) {
      print('Building legacy specimens for ButtonTextTheme.${fact.name}');
      rows.add(_buildLegacyRow(fact, scheme));
      rows.add(const SizedBox(height: 14.0));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 3,
          title: 'Legacy Specimens',
          subtitle:
              'RaisedButton / FlatButton / OutlineButton with each enum value.',
        ),
        const SizedBox(height: 14.0),
        ...rows,
      ],
    );
  }

  Widget _buildLegacyRow(_EnumFacts fact, ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: fact.swatch.withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: fact.swatch.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'textTheme: ButtonTextTheme.${fact.name}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: fact.swatch,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.history, color: scheme.outline, size: 18.0),
            ],
          ),
          const SizedBox(height: 14.0),
          ButtonTheme(
            textTheme: fact.value,
            minWidth: 0.0,
            height: 40.0,
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {},
                  color: fact.swatch,
                  textTheme: fact.value,
                  child: const Text('Filled (was RaisedButton)'),
                ),
                MaterialButton(
                  onPressed: () {},
                  textTheme: fact.value,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  child: const Text('Flat (was FlatButton)'),
                ),
                MaterialButton(
                  onPressed: () {},
                  textTheme: fact.value,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: fact.swatch.withValues(alpha: 0.7),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text('Outlined (was OutlineButton)'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            _legacyExplanation(fact.value),
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

  String _legacyExplanation(ButtonTextTheme value) {
    switch (value) {
      case ButtonTextTheme.normal:
        return 'Text color comes from theme.textTheme.button.color. On a '
            'light theme this is roughly black54; on a dark theme it flips '
            'to white. The button fill is independent.';
      case ButtonTextTheme.accent:
        return 'Text color is the accentColor (now colorScheme.secondary). '
            'Useful for FlatButton calls-to-action that need to pop on a '
            'neutral surface.';
      case ButtonTextTheme.primary:
        return 'Text color is computed to contrast with the fill color. The '
            'framework picks white on dark fills and black on light fills via '
            'ThemeData.estimateBrightnessForColor.';
    }
  }

  // --------------------------------------------------------------------------
  // SECTION 4. Modern equivalents. We render the same triad using the M3
  // button widgets and ButtonStyle.foregroundColor with WidgetStateProperty
  // resolvers. The point is to show that the resolver replaces the entire
  // ButtonTextTheme enum with a one-liner that handles state-driven styling
  // out of the box.
  // --------------------------------------------------------------------------
  Widget _buildSection4(ColorScheme scheme) {
    print('=== Section 4: Modern Equivalents ===');

    final List<Widget> rows = <Widget>[];
    for (final _EnumFacts fact in _enumCatalog) {
      print('Building M3 equivalents for ${fact.name}');
      rows.add(_buildModernRow(fact, scheme));
      rows.add(const SizedBox(height: 14.0));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 4,
          title: 'Modern Equivalents (Material 3)',
          subtitle:
              'ElevatedButton / OutlinedButton / TextButton with ButtonStyle.',
        ),
        const SizedBox(height: 14.0),
        ...rows,
      ],
    );
  }

  Widget _buildModernRow(_EnumFacts fact, ColorScheme scheme) {
    final Color resolved = _modernForeground(fact.value, scheme);
    final WidgetStateProperty<Color?> fgProp =
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurface.withValues(alpha: 0.38);
      }
      if (states.contains(WidgetState.pressed)) {
        return resolved.withValues(alpha: 0.85);
      }
      return resolved;
    });
    final ButtonStyle elevatedStyle = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(fact.swatch),
      foregroundColor: fgProp,
    );
    final ButtonStyle outlinedStyle = ButtonStyle(
      foregroundColor: fgProp,
      side: WidgetStatePropertyAll<BorderSide>(
        BorderSide(color: resolved.withValues(alpha: 0.6), width: 1.2),
      ),
    );
    final ButtonStyle textStyle = ButtonStyle(foregroundColor: fgProp);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: scheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'foregroundColor: WidgetStateProperty.resolveWith(...)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: scheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.auto_awesome,
                  color: scheme.tertiary, size: 18.0),
            ],
          ),
          const SizedBox(height: 14.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                style: elevatedStyle,
                child: const Text('ElevatedButton'),
              ),
              OutlinedButton(
                onPressed: () {},
                style: outlinedStyle,
                child: const Text('OutlinedButton'),
              ),
              TextButton(
                onPressed: () {},
                style: textStyle,
                child: const Text('TextButton'),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            'Equivalent to ButtonTextTheme.${fact.name}. State handling '
            '(hover, pressed, disabled) lives inside the resolver, not in a '
            'global enum.',
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

  Color _modernForeground(ButtonTextTheme value, ColorScheme scheme) {
    switch (value) {
      case ButtonTextTheme.normal:
        return scheme.onSurface;
      case ButtonTextTheme.accent:
        return scheme.secondary;
      case ButtonTextTheme.primary:
        return scheme.onPrimary;
    }
  }

  // --------------------------------------------------------------------------
  // SECTION 5. Comparison table and decision matrix. The matrix is rendered
  // as a real Table widget so we exercise the AST around colSpan / TableRow.
  // The decision matrix below is a small grid: rows = scenarios, columns =
  // recommended enum value or its modern replacement.
  // --------------------------------------------------------------------------
  Widget _buildSection5(ColorScheme scheme) {
    print('=== Section 5: Comparison Table and Decision Matrix ===');

    final TableRow header = TableRow(
      decoration: BoxDecoration(color: scheme.primary.withValues(alpha: 0.12)),
      children: <Widget>[
        _tableCell('Aspect', scheme, bold: true),
        _tableCell('ButtonTextTheme.normal', scheme, bold: true),
        _tableCell('ButtonTextTheme.accent', scheme, bold: true),
        _tableCell('ButtonTextTheme.primary', scheme, bold: true),
      ],
    );

    TableRow body(String label, String a, String b, String c) {
      return TableRow(
        children: <Widget>[
          _tableCell(label, scheme, bold: true),
          _tableCell(a, scheme),
          _tableCell(b, scheme),
          _tableCell(c, scheme),
        ],
      );
    }

    final Table table = Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(110.0),
        1: FlexColumnWidth(1.0),
        2: FlexColumnWidth(1.0),
        3: FlexColumnWidth(1.0),
      },
      border: TableBorder.all(
        color: scheme.outlineVariant,
        width: 1.0,
      ),
      children: <TableRow>[
        header,
        body('Text color', 'black/white', 'accent', 'on-fill contrast'),
        body('Adapts to', 'brightness', 'theme accent', 'fill luminance'),
        body('Best for', 'neutral text', 'CTA in FlatButton',
            'RaisedButton labels'),
        body('M3 mapping', 'onSurface', 'secondary', 'onPrimary'),
        body('State-aware', 'no', 'no', 'no'),
      ],
    );

    final List<Widget> matrixRows = <Widget>[
      _decisionRow(scheme, 'Neutral text on a card', 'normal',
          'ColorScheme.onSurface'),
      _decisionRow(scheme, 'Call-to-action link', 'accent',
          'ColorScheme.secondary'),
      _decisionRow(scheme, 'Solid filled button', 'primary',
          'ColorScheme.onPrimary'),
      _decisionRow(scheme, 'Pressed state tint', 'n/a',
          'WidgetStateProperty resolver'),
      _decisionRow(scheme, 'Disabled label', 'n/a',
          'onSurface.withValues(alpha: 0.38)'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 5,
          title: 'Comparison Table and Decision Matrix',
          subtitle:
              'Side-by-side semantics and a quick "which one" cheat-sheet.',
        ),
        const SizedBox(height: 14.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: table,
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.fact_check_outlined,
                      color: scheme.primary, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    'Decision matrix',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              ...matrixRows,
            ],
          ),
        ),
      ],
    );
  }

  Widget _tableCell(String text, ColorScheme scheme, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: bold ? scheme.primary : scheme.onSurface,
        ),
      ),
    );
  }

  Widget _decisionRow(ColorScheme scheme, String scenario, String enumValue,
      String modern) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              scenario,
              style: TextStyle(fontSize: 12.0, color: scheme.onSurface),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                enumValue,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: scheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 4,
            child: Text(
              modern,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 6. Migration recipes. Three recipe cards: before/after for each
  // enum value. Each card renders the legacy code, the modern code and a
  // small narrative explaining the trade-offs.
  // --------------------------------------------------------------------------
  Widget _buildSection6(ColorScheme scheme) {
    print('=== Section 6: Migration Recipes ===');

    final List<Widget> recipes = <Widget>[
      _recipeCard(
        scheme,
        'normal -> onSurface',
        'ButtonTheme(\n'
            '  textTheme: ButtonTextTheme.normal,\n'
            '  child: FlatButton(\n'
            '    onPressed: () {},\n'
            '    child: Text("Cancel"),\n'
            '  ),\n'
            ')',
        'TextButton(\n'
            '  onPressed: () {},\n'
            '  style: TextButton.styleFrom(\n'
            '    foregroundColor: scheme.onSurface,\n'
            '  ),\n'
            '  child: Text("Cancel"),\n'
            ')',
        'Drop ButtonTheme entirely. Pass the on-surface color directly via '
            'styleFrom; state handling is built-in.',
      ),
      _recipeCard(
        scheme,
        'accent -> secondary',
        'ButtonTheme(\n'
            '  textTheme: ButtonTextTheme.accent,\n'
            '  child: FlatButton(\n'
            '    onPressed: () {},\n'
            '    child: Text("Learn more"),\n'
            '  ),\n'
            ')',
        'TextButton(\n'
            '  onPressed: () {},\n'
            '  style: ButtonStyle(\n'
            '    foregroundColor: WidgetStateProperty.all(\n'
            '      scheme.secondary,\n'
            '    ),\n'
            '  ),\n'
            '  child: Text("Learn more"),\n'
            ')',
        'In M3 the accent role lives on colorScheme.secondary. Wrap it in a '
            'WidgetStateProperty to allow per-state overrides.',
      ),
      _recipeCard(
        scheme,
        'primary -> onPrimary',
        'ButtonTheme(\n'
            '  textTheme: ButtonTextTheme.primary,\n'
            '  child: RaisedButton(\n'
            '    color: theme.primaryColor,\n'
            '    onPressed: () {},\n'
            '    child: Text("Submit"),\n'
            '  ),\n'
            ')',
        'ElevatedButton(\n'
            '  onPressed: () {},\n'
            '  style: ElevatedButton.styleFrom(\n'
            '    backgroundColor: scheme.primary,\n'
            '    foregroundColor: scheme.onPrimary,\n'
            '  ),\n'
            '  child: Text("Submit"),\n'
            ')',
        'M3 derives onPrimary from the seed and guarantees WCAG contrast. '
            'No need to estimate brightness manually.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 6,
          title: 'Migration Recipes',
          subtitle: 'Before / after snippets for every enum value.',
        ),
        const SizedBox(height: 14.0),
        ...recipes,
      ],
    );
  }

  Widget _recipeCard(ColorScheme scheme, String title, String before,
      String after, String narrative) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: scheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'RECIPE',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: scheme.onTertiaryContainer,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _codeBlock('// Before (legacy)', before, Colors.red.shade300,
              const Color(0xFF1B1B1F)),
          const SizedBox(height: 10.0),
          _codeBlock('// After (Material 3)', after, Colors.green.shade300,
              const Color(0xFF1B1B1F)),
          const SizedBox(height: 12.0),
          Text(
            narrative,
            style: TextStyle(
              fontSize: 12.0,
              color: scheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeBlock(
      String caption, String code, Color codeColor, Color bg) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.4,
              color: codeColor,
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 7. Pitfalls + glossary. We close with: (a) common pitfalls when
  // migrating, (b) a glossary of every term used in the demo.
  // --------------------------------------------------------------------------
  Widget _buildSection7(ColorScheme scheme) {
    print('=== Section 7: Pitfalls and Glossary ===');

    final List<Widget> pitfalls = <Widget>[
      _pitfall(scheme, Icons.warning_amber,
          'Mixing legacy and modern buttons in the same theme.',
          'A ButtonTheme ancestor still affects RaisedButton even after you '
              'migrate the rest to ElevatedButton. Remove the ButtonTheme to '
              'avoid surprises.'),
      _pitfall(scheme, Icons.warning_amber,
          'Forgetting state-aware colors.',
          'ButtonTextTheme had no notion of pressed / hovered. With '
              'WidgetStateProperty you must add resolvers for each state you '
              'care about, otherwise the M3 defaults win.'),
      _pitfall(scheme, Icons.warning_amber,
          'Using accentColor instead of secondary.',
          'ThemeData.accentColor was removed. The migration target is '
              'ColorScheme.secondary inside the active ColorScheme.'),
      _pitfall(scheme, Icons.warning_amber,
          'Manual brightness calculation.',
          'ThemeData.estimateBrightnessForColor still exists but rarely '
              'needs to be called manually: M3 picks the right onPrimary for '
              'you when you seed the ColorScheme.'),
    ];

    final Map<String, String> glossary = <String, String>{
      'ButtonTextTheme': 'Legacy enum for resolving button text color.',
      'ButtonTheme': 'Legacy InheritedWidget that owned button defaults.',
      'ButtonStyle': 'M3 style object with WidgetStateProperty fields.',
      'WidgetStateProperty':
          'Function from a Set<WidgetState> to a concrete value.',
      'ColorScheme': 'Material 3 token palette: primary, secondary, etc.',
      'onPrimary': 'Foreground color guaranteed to contrast with primary.',
      'onSurface': 'Foreground color for content drawn on the surface role.',
      'styleFrom':
          'Static helper that builds a ButtonStyle from positional shortcuts.',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 7,
          title: 'Pitfalls and Glossary',
          subtitle: 'What to watch for, and a vocabulary cheat-sheet.',
        ),
        const SizedBox(height: 14.0),
        ...pitfalls,
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.menu_book,
                      color: scheme.primary, size: 22.0),
                  const SizedBox(width: 8.0),
                  Text(
                    'Glossary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              ...glossary.entries.map(
                (MapEntry<String, String> e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 150.0,
                        child: Text(
                          e.key,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          e.value,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: scheme.onSurfaceVariant,
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
      ],
    );
  }

  Widget _pitfall(
      ColorScheme scheme, IconData icon, String title, String body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: scheme.error.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: scheme.error, size: 22.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.onErrorContainer,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  body,
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
    );
  }

  // --------------------------------------------------------------------------
  // Footer with a final note. Not a numbered section.
  // --------------------------------------------------------------------------
  Widget _buildFooter(ColorScheme scheme) {
    print('ButtonTextTheme Deep Demo completed successfully');
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primaryContainer,
            scheme.tertiaryContainer,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.check_circle,
              color: scheme.onPrimaryContainer, size: 26.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              'End of the ButtonTextTheme deep dive. Prefer ButtonStyle for '
              'new code; keep ButtonTextTheme only for in-place maintenance of '
              'legacy screens.',
              style: TextStyle(
                fontSize: 13.0,
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Helper widgets - kept private to the file so we do not pollute global names.
// ============================================================================

class _EnumChip extends StatelessWidget {
  const _EnumChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 42.0,
          height: 42.0,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.4),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: TextStyle(
              color: scheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
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
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.5,
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
