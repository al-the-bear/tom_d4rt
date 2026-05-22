// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// Deep visual demonstration script for CheckboxListTile.
///
/// Design plan:
///   Section 1 - Header banner + property anatomy map.
///   Section 2 - Variant gallery: basic, with-subtitle, secondary icon,
///               dense, three-line, tristate, leading vs trailing affinity,
///               selected, disabled, custom shape, custom colors.
///   Section 3 - Tristate state machine card (false -> null -> true).
///   Section 4 - MaterialStateProperty fillColor + checkColor walkthrough.
///   Section 5 - Mini "Settings" panel built from a Column of
///               CheckboxListTile entries with a Card frame.
///   Section 6 - Comparison row: CheckboxListTile vs SwitchListTile vs
///               RadioListTile, with semantic notes.
///   Section 7 - Recipes (selection list, agreement page, density grid,
///               tristate parent / children).
///   Section 8 - Glossary + property reference table.
///
/// The script renders all content in a single scrollable column, uses
/// Material 3 ColorScheme idioms, and uses null onChanged for read-only
/// previews and a no-op closure for interactive previews so the AST
/// interpreter can render every variant without state. Plain ASCII only.

void main() => runApp(const CheckboxListTileDeepDemoApp());

class CheckboxListTileDeepDemoApp extends StatelessWidget {
  const CheckboxListTileDeepDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('CheckboxListTile Deep Demo executing');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckboxListTile Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
      ),
      home: const Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeaderBanner(),
              SizedBox(height: 24.0),
              _SectionOneAnatomy(),
              SizedBox(height: 32.0),
              _SectionTwoVariantGallery(),
              SizedBox(height: 32.0),
              _SectionThreeTristate(),
              SizedBox(height: 32.0),
              _SectionFourMaterialStateProperties(),
              SizedBox(height: 32.0),
              _SectionFiveSettingsPanel(),
              SizedBox(height: 32.0),
              _SectionSixComparison(),
              SizedBox(height: 32.0),
              _SectionSevenRecipes(),
              SizedBox(height: 32.0),
              _SectionEightGlossary(),
              SizedBox(height: 48.0),
              _FooterStrip(),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// Header banner with gradient and identifying glyph.
// =====================================================================
class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner();

  @override
  Widget build(BuildContext context) {
    print('=== Section 0: Header Banner ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 16.0,
            offset: const Offset(0, 6),
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
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: scheme.onPrimary.withValues(alpha: 0.45),
                width: 2.0,
              ),
            ),
            child: Icon(
              Icons.check_box_outlined,
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
                  'CheckboxListTile',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: scheme.onPrimary,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'A ListTile that pairs a label with a Checkbox',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: scheme.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 6.0,
                  children: <Widget>[
                    _badge(scheme, 'material'),
                    _badge(scheme, 'tristate'),
                    _badge(scheme, 'leading/trailing'),
                    _badge(scheme, 'MaterialStateProperty'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _badge(ColorScheme scheme, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: scheme.onPrimary.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(
          color: scheme.onPrimary.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: scheme.onPrimary,
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =====================================================================
// Section 1: Property anatomy. Visualises the slots of a CheckboxListTile
// (leading control, title, subtitle, secondary, trailing) with callouts.
// =====================================================================
class _SectionOneAnatomy extends StatelessWidget {
  const _SectionOneAnatomy();

  @override
  Widget build(BuildContext context) {
    print('=== Section 1: Property Anatomy ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final List<_AnatomyRow> rows = <_AnatomyRow>[
      _AnatomyRow(
        property: 'value',
        type: 'bool?',
        note: 'true | false | null (null only allowed when tristate is true)',
        icon: Icons.toggle_on,
        color: scheme.primary,
      ),
      _AnatomyRow(
        property: 'tristate',
        type: 'bool',
        note: 'When true, value may cycle false -> null -> true -> false',
        icon: Icons.swap_calls,
        color: scheme.secondary,
      ),
      _AnatomyRow(
        property: 'onChanged',
        type: 'ValueChanged<bool?>?',
        note: 'null disables the tile; non-null makes it interactive',
        icon: Icons.touch_app,
        color: scheme.tertiary,
      ),
      _AnatomyRow(
        property: 'activeColor',
        type: 'Color?',
        note: 'Box fill color when value is true (legacy)',
        icon: Icons.format_color_fill,
        color: Colors.teal,
      ),
      _AnatomyRow(
        property: 'checkColor',
        type: 'Color?',
        note: 'Color of the check glyph inside the box',
        icon: Icons.check,
        color: Colors.green,
      ),
      _AnatomyRow(
        property: 'fillColor',
        type: 'MaterialStateProperty<Color?>?',
        note: 'Per-state fill color resolution (selected, disabled, ...)',
        icon: Icons.gradient,
        color: Colors.deepPurple,
      ),
      _AnatomyRow(
        property: 'title',
        type: 'Widget?',
        note: 'Primary label; usually a Text',
        icon: Icons.title,
        color: scheme.primary,
      ),
      _AnatomyRow(
        property: 'subtitle',
        type: 'Widget?',
        note: 'Secondary description below the title',
        icon: Icons.subtitles,
        color: scheme.secondary,
      ),
      _AnatomyRow(
        property: 'secondary',
        type: 'Widget?',
        note: 'Opposite-side glyph (often a leading Icon or Avatar)',
        icon: Icons.dashboard_customize,
        color: Colors.indigo,
      ),
      _AnatomyRow(
        property: 'isThreeLine',
        type: 'bool',
        note: 'Reserves space for a two-line subtitle',
        icon: Icons.format_line_spacing,
        color: Colors.orange,
      ),
      _AnatomyRow(
        property: 'dense',
        type: 'bool?',
        note: 'Compact vertical density',
        icon: Icons.compress,
        color: Colors.brown,
      ),
      _AnatomyRow(
        property: 'controlAffinity',
        type: 'ListTileControlAffinity',
        note: 'leading | trailing | platform (default)',
        icon: Icons.compare_arrows,
        color: Colors.cyan,
      ),
      _AnatomyRow(
        property: 'shape',
        type: 'ShapeBorder?',
        note: 'Outer shape of the tile (RoundedRectangle, Stadium, ...)',
        icon: Icons.crop_square,
        color: Colors.pink,
      ),
      _AnatomyRow(
        property: 'tileColor',
        type: 'Color?',
        note: 'Background color when not selected',
        icon: Icons.crop_din,
        color: Colors.blueGrey,
      ),
      _AnatomyRow(
        property: 'selectedTileColor',
        type: 'Color?',
        note: 'Background color when selected is true',
        icon: Icons.star,
        color: Colors.amber,
      ),
      _AnatomyRow(
        property: 'contentPadding',
        type: 'EdgeInsetsGeometry?',
        note: 'Padding around the tile contents',
        icon: Icons.padding,
        color: Colors.lime,
      ),
      _AnatomyRow(
        property: 'enabled',
        type: 'bool?',
        note: 'When false the entire tile is non-interactive',
        icon: Icons.block,
        color: Colors.redAccent,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 1,
          title: 'Property Anatomy',
          subtitle: 'Every slot and every knob of CheckboxListTile.',
          icon: Icons.account_tree_outlined,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            children: <Widget>[
              for (final _AnatomyRow row in rows)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: row.build(context),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnatomyRow {
  const _AnatomyRow({
    required this.property,
    required this.type,
    required this.note,
    required this.icon,
    required this.color,
  });

  final String property;
  final String type;
  final String note;
  final IconData icon;
  final Color color;

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, size: 18.0, color: color),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      property,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2.0),
                Text(
                  note,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black87,
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

// =====================================================================
// Section 2: Variant gallery. Real CheckboxListTile widgets, one per
// notable configuration. Read-only previews use null onChanged; the
// "interactive" group uses a no-op closure to render the enabled state.
// =====================================================================
class _SectionTwoVariantGallery extends StatelessWidget {
  const _SectionTwoVariantGallery();

  @override
  Widget build(BuildContext context) {
    print('=== Section 2: Variant Gallery ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final List<_VariantSpec> variants = <_VariantSpec>[
      const _VariantSpec(
        label: 'Basic, value=false',
        description: 'Minimal: title + onChanged no-op',
        tile: CheckboxListTile(
          value: false,
          onChanged: _noopBool,
          title: Text('Send weekly digest'),
        ),
      ),
      const _VariantSpec(
        label: 'Basic, value=true',
        description: 'Same as above but checked',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          title: Text('Send weekly digest'),
        ),
      ),
      const _VariantSpec(
        label: 'With subtitle',
        description: 'Two-line tile: title + subtitle',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          title: Text('Background sync'),
          subtitle: Text('Pulls new data every 15 minutes'),
        ),
      ),
      const _VariantSpec(
        label: 'Secondary icon',
        description: 'Opposite-side glyph via secondary slot',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          title: Text('Sound effects'),
          subtitle: Text('Plays UI clicks on tap'),
          secondary: Icon(Icons.volume_up_outlined),
        ),
      ),
      const _VariantSpec(
        label: 'Dense',
        description: 'Compact density for long lists',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          dense: true,
          title: Text('Hide read messages'),
        ),
      ),
      const _VariantSpec(
        label: 'isThreeLine',
        description: 'Reserves space for a multi-line subtitle',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          isThreeLine: true,
          title: Text('Telemetry'),
          subtitle: Text(
            'Crash reports, usage metrics and performance traces '
            'are sent to the diagnostics endpoint.',
          ),
          secondary: Icon(Icons.insights_outlined),
        ),
      ),
      const _VariantSpec(
        label: 'Tristate, null',
        description: 'Mixed indicator (null) - requires tristate: true',
        tile: CheckboxListTile(
          value: null,
          tristate: true,
          onChanged: _noopBool,
          title: Text('Some children selected'),
          subtitle: Text('Tristate parent control'),
        ),
      ),
      const _VariantSpec(
        label: 'Leading affinity',
        description: 'controlAffinity: leading - box on the left',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text('Show line numbers'),
          subtitle: Text('Editor preference'),
          secondary: Icon(Icons.format_list_numbered),
        ),
      ),
      const _VariantSpec(
        label: 'Trailing affinity',
        description: 'controlAffinity: trailing - box on the right',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text('Show minimap'),
          subtitle: Text('Editor preference'),
          secondary: Icon(Icons.map_outlined),
        ),
      ),
      const _VariantSpec(
        label: 'Platform affinity',
        description: 'controlAffinity: platform - default, OS-dependent',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          controlAffinity: ListTileControlAffinity.platform,
          title: Text('Use platform default'),
        ),
      ),
      const _VariantSpec(
        label: 'Selected',
        description: 'selected: true with selectedTileColor highlight',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          selected: true,
          selectedTileColor: Color(0xFFE3F2FD),
          title: Text('Currently selected row'),
        ),
      ),
      _VariantSpec(
        label: 'Disabled (onChanged=null)',
        description: 'Read-only tile - cannot be toggled',
        tile: const CheckboxListTile(
          value: true,
          onChanged: null,
          title: Text('Read-only flag'),
          subtitle: Text('Configured by administrator'),
        ),
      ),
      _VariantSpec(
        label: 'enabled: false',
        description: 'Same effect via the enabled property',
        tile: CheckboxListTile(
          value: false,
          enabled: false,
          onChanged: _noopBool,
          title: const Text('Coming soon'),
          subtitle: const Text('Feature is gated behind a flag'),
          secondary: const Icon(Icons.lock_outline),
        ),
      ),
      _VariantSpec(
        label: 'Custom shape',
        description: 'Stadium border on a colored tile',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          shape: const StadiumBorder(),
          tileColor: scheme.secondaryContainer,
          title: const Text('Stadium-shaped tile'),
          secondary: const Icon(Icons.stadium_outlined),
        ),
      ),
      _VariantSpec(
        label: 'Custom colors',
        description: 'activeColor + checkColor + tileColor combination',
        tile: CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          activeColor: Colors.deepPurple,
          checkColor: Colors.amberAccent,
          tileColor: Colors.deepPurple.shade50,
          title: const Text('Premium plan'),
          subtitle: const Text('Custom brand colors applied'),
          secondary: const Icon(Icons.workspace_premium),
        ),
      ),
      _VariantSpec(
        label: 'Custom contentPadding',
        description: 'EdgeInsets.symmetric(horizontal: 24, vertical: 12)',
        tile: const CheckboxListTile(
          value: true,
          onChanged: _noopBool,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          title: Text('Wide padding'),
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 2,
          title: 'Variant Gallery',
          subtitle:
              'One real CheckboxListTile per configuration. Each tile has '
              'a caption explaining the property under test.',
          icon: Icons.grid_view,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final _VariantSpec spec in variants)
              SizedBox(
                width: 360.0,
                child: Card(
                  elevation: 0,
                  color: scheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                    side: BorderSide(color: scheme.outlineVariant),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: scheme.primaryContainer,
                            borderRadius: BorderRadius.circular(999.0),
                          ),
                          child: Text(
                            spec.label,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: scheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            spec.description,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(color: scheme.outlineVariant),
                          ),
                          child: spec.tile,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _VariantSpec {
  const _VariantSpec({
    required this.label,
    required this.description,
    required this.tile,
  });

  final String label;
  final String description;
  final Widget tile;
}

// =====================================================================
// Section 3: Tristate state machine. Renders three CheckboxListTile
// instances for the three possible values (false, null, true) plus
// arrows explaining the cycle order produced by tap interactions.
// =====================================================================
class _SectionThreeTristate extends StatelessWidget {
  const _SectionThreeTristate();

  @override
  Widget build(BuildContext context) {
    print('=== Section 3: Tristate State Machine ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    const List<_TristateStep> steps = <_TristateStep>[
      _TristateStep(
        label: 'value: false',
        value: false,
        narrative: 'No children are selected; box is empty.',
        color: Colors.redAccent,
      ),
      _TristateStep(
        label: 'value: null',
        value: null,
        narrative:
            'Some children are selected; box shows the mixed indicator.',
        color: Colors.amber,
      ),
      _TristateStep(
        label: 'value: true',
        value: true,
        narrative: 'All children are selected; box is checked.',
        color: Colors.green,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 3,
          title: 'Tristate State Machine',
          subtitle:
              'When tristate: true, value cycles false -> null -> true -> '
              'false. Useful for parent/children selection scenarios.',
          icon: Icons.swap_calls,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < steps.length; i++) ...<Widget>[
                _buildStep(context, steps[i], i),
                if (i != steps.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Icon(
                      Icons.arrow_downward,
                      color: scheme.outline,
                    ),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: scheme.tertiaryContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline, color: scheme.onTertiaryContainer),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'value can only be null when tristate is true. Passing '
                  'null without tristate triggers a debug assertion.',
                  style: TextStyle(
                    color: scheme.onTertiaryContainer,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep(BuildContext context, _TristateStep step, int index) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: step.color.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: step.color.withValues(alpha: 0.18),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: step.color,
                ),
              ),
            ),
          ),
          Expanded(
            child: CheckboxListTile(
              value: step.value,
              tristate: true,
              onChanged: _noopBool,
              title: Text(step.label,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(step.narrative),
              activeColor: step.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _TristateStep {
  const _TristateStep({
    required this.label,
    required this.value,
    required this.narrative,
    required this.color,
  });

  final String label;
  final bool? value;
  final String narrative;
  final Color color;
}

// =====================================================================
// Section 4: MaterialStateProperty-based fill color and check color.
// Each card resolves the property under a different WidgetState set
// (default, selected, disabled, hovered) and renders a tile that shows
// the resulting visual.
// =====================================================================
class _SectionFourMaterialStateProperties extends StatelessWidget {
  const _SectionFourMaterialStateProperties();

  @override
  Widget build(BuildContext context) {
    print('=== Section 4: MaterialStateProperty Walkthrough ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final WidgetStateProperty<Color?> fill =
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade300;
      }
      if (states.contains(WidgetState.selected)) {
        return scheme.primary;
      }
      if (states.contains(WidgetState.hovered)) {
        return scheme.primary.withValues(alpha: 0.6);
      }
      return scheme.surfaceContainerHighest;
    });

    final List<_FillScenario> scenarios = <_FillScenario>[
      _FillScenario(
        label: 'default',
        states: const <WidgetState>{},
        resolved: fill.resolve(const <WidgetState>{}),
        description: 'No states set; falls through to the default branch.',
      ),
      _FillScenario(
        label: 'selected',
        states: const <WidgetState>{WidgetState.selected},
        resolved: fill.resolve(const <WidgetState>{WidgetState.selected}),
        description: 'value == true -> selected branch returns scheme.primary.',
      ),
      _FillScenario(
        label: 'hovered',
        states: const <WidgetState>{WidgetState.hovered},
        resolved: fill.resolve(const <WidgetState>{WidgetState.hovered}),
        description: 'Pointer hover; commonly returns a softer tint.',
      ),
      _FillScenario(
        label: 'disabled',
        states: const <WidgetState>{WidgetState.disabled},
        resolved: fill.resolve(const <WidgetState>{WidgetState.disabled}),
        description: 'Tile cannot be interacted with; greys out the box.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 4,
          title: 'fillColor as WidgetStateProperty',
          subtitle:
              'Per-state resolution lets the checkbox react to selected, '
              'hovered, focused, disabled etc. without writing new widgets.',
          icon: Icons.gradient,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final _FillScenario scenario in scenarios)
              SizedBox(
                width: 260.0,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 22.0,
                            height: 22.0,
                            decoration: BoxDecoration(
                              color:
                                  scenario.resolved ?? Colors.transparent,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  color: Colors.black54, width: 1.5),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            scenario.label,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        scenario.description,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          '{${scenario.states.map((WidgetState s) => s.name).join(', ')}}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            children: <Widget>[
              CheckboxListTile(
                value: true,
                onChanged: _noopBool,
                selected: true,
                title: const Text('Selected tile (resolves to primary)'),
                subtitle:
                    const Text('fillColor uses the WidgetState.selected leg'),
                fillColor: fill,
                checkColor: scheme.onPrimary,
              ),
              const Divider(height: 1),
              CheckboxListTile(
                value: false,
                onChanged: _noopBool,
                title: const Text('Default tile (resolves to neutral)'),
                subtitle: const Text('No states set'),
                fillColor: fill,
              ),
              const Divider(height: 1),
              const CheckboxListTile(
                value: false,
                onChanged: null,
                title: Text('Disabled tile (resolves to grey)'),
                subtitle: Text('WidgetState.disabled wins'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FillScenario {
  const _FillScenario({
    required this.label,
    required this.states,
    required this.resolved,
    required this.description,
  });

  final String label;
  final Set<WidgetState> states;
  final Color? resolved;
  final String description;
}

// =====================================================================
// Section 5: Mini Settings panel. A realistic preferences screen built
// entirely from CheckboxListTile widgets, demonstrating how the control
// composes inside a Card with section dividers.
// =====================================================================
class _SectionFiveSettingsPanel extends StatelessWidget {
  const _SectionFiveSettingsPanel();

  @override
  Widget build(BuildContext context) {
    print('=== Section 5: Mini Settings Panel ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 5,
          title: 'Mini Settings Panel',
          subtitle:
              'A column of CheckboxListTile entries inside a Card, with '
              'a section header, a divider, and a footer summary.',
          icon: Icons.tune,
        ),
        const SizedBox(height: 12.0),
        Card(
          elevation: 0,
          color: scheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: scheme.outlineVariant),
          ),
          child: Column(
            children: <Widget>[
              _settingsHeader(context, 'Notifications', Icons.notifications),
              const CheckboxListTile(
                value: true,
                onChanged: _noopBool,
                title: Text('Push notifications'),
                subtitle: Text('Allow alerts from this app'),
                secondary: Icon(Icons.notifications_active_outlined),
              ),
              const CheckboxListTile(
                value: false,
                onChanged: _noopBool,
                title: Text('Email digest'),
                subtitle: Text('Weekly recap delivered Mondays'),
                secondary: Icon(Icons.mail_outlined),
              ),
              const CheckboxListTile(
                value: true,
                onChanged: _noopBool,
                title: Text('Mentions only'),
                subtitle: Text('Mute everything except @mentions'),
                secondary: Icon(Icons.alternate_email),
              ),
              const Divider(height: 1),
              _settingsHeader(context, 'Privacy', Icons.shield_outlined),
              const CheckboxListTile(
                value: false,
                onChanged: _noopBool,
                title: Text('Share anonymous usage data'),
                subtitle: Text('Helps improve the product'),
                secondary: Icon(Icons.analytics_outlined),
              ),
              const CheckboxListTile(
                value: null,
                tristate: true,
                onChanged: _noopBool,
                title: Text('Personalised ads'),
                subtitle: Text('Mixed across linked devices'),
                secondary: Icon(Icons.ads_click),
              ),
              const Divider(height: 1),
              _settingsHeader(context, 'Accessibility', Icons.accessibility),
              const CheckboxListTile(
                value: true,
                onChanged: _noopBool,
                title: Text('High contrast'),
                subtitle: Text('Improves readability on light surfaces'),
                secondary: Icon(Icons.contrast),
              ),
              const CheckboxListTile(
                value: false,
                onChanged: _noopBool,
                title: Text('Reduce motion'),
                subtitle: Text('Disables non-essential animations'),
                secondary: Icon(Icons.motion_photos_off),
                dense: true,
              ),
              const CheckboxListTile(
                value: true,
                onChanged: null,
                title: Text('System-managed setting'),
                subtitle: Text('Controlled by your device profile'),
                secondary: Icon(Icons.admin_panel_settings_outlined),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: scheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(999.0),
                      ),
                      child: Text(
                        '5 of 8 enabled',
                        style: TextStyle(
                          color: scheme.onSecondaryContainer,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
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
    );
  }

  Widget _settingsHeader(BuildContext context, String label, IconData icon) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 6.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18.0, color: scheme.primary),
          const SizedBox(width: 8.0),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: scheme.primary,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 6: Comparison row. CheckboxListTile next to SwitchListTile and
// RadioListTile with semantic notes about when to pick which.
// =====================================================================
class _SectionSixComparison extends StatelessWidget {
  const _SectionSixComparison();

  @override
  Widget build(BuildContext context) {
    print('=== Section 6: Comparison vs Switch/Radio ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 6,
          title: 'CheckboxListTile vs SwitchListTile vs RadioListTile',
          subtitle:
              'All three share the ListTile chassis. Pick based on the '
              'choice cardinality and the affordance you want to project.',
          icon: Icons.compare,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _comparisonCard(
              context,
              title: 'CheckboxListTile',
              guidance:
                  'Multiple independent boolean options. Supports tristate.',
              tile: const CheckboxListTile(
                value: true,
                onChanged: _noopBool,
                title: Text('Enable feature flag'),
                subtitle: Text('Booleans, optionally tristate'),
              ),
              accent: scheme.primary,
              icon: Icons.check_box_outlined,
            ),
            _comparisonCard(
              context,
              title: 'SwitchListTile',
              guidance:
                  'On/off toggles that take effect immediately. No tristate.',
              tile: SwitchListTile(
                value: true,
                onChanged: _noopBool,
                title: const Text('Enable feature flag'),
                subtitle: const Text('Immediate-effect toggle'),
              ),
              accent: scheme.secondary,
              icon: Icons.toggle_on,
            ),
            _comparisonCard(
              context,
              title: 'RadioListTile',
              guidance:
                  'Exactly one of N mutually-exclusive options. No tristate.',
              tile: RadioListTile<int>(
                value: 1,
                groupValue: 1,
                onChanged: _noopInt,
                title: const Text('Option A'),
                subtitle: const Text('One-of-many selection'),
              ),
              accent: scheme.tertiary,
              icon: Icons.radio_button_checked,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Quick rules of thumb',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                ' - Checkbox: many things, ok to defer commit (form submit).',
                style: TextStyle(fontSize: 12.5),
              ),
              const Text(
                ' - Switch: one thing, takes effect immediately.',
                style: TextStyle(fontSize: 12.5),
              ),
              const Text(
                ' - Radio: pick exactly one of a small set.',
                style: TextStyle(fontSize: 12.5),
              ),
              const Text(
                ' - Use tristate Checkbox for parent rollups (none/some/all).',
                style: TextStyle(fontSize: 12.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _comparisonCard(
    BuildContext context, {
    required String title,
    required String guidance,
    required Widget tile,
    required Color accent,
    required IconData icon,
  }) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 360.0,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(icon, size: 18.0, color: accent),
                ),
                const SizedBox(width: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(guidance, style: const TextStyle(fontSize: 12.5)),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: tile,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// Section 7: Recipes. Four hand-authored compositions showing
// idiomatic usage patterns.
// =====================================================================
class _SectionSevenRecipes extends StatelessWidget {
  const _SectionSevenRecipes();

  @override
  Widget build(BuildContext context) {
    print('=== Section 7: Recipes ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 7,
          title: 'Recipes',
          subtitle:
              'Concrete compositions you can copy into a screen.',
          icon: Icons.menu_book_outlined,
        ),
        const SizedBox(height: 12.0),
        _recipeCard(
          context,
          title: 'Recipe A - Multi-select filter list',
          notes:
              'Independent boolean filters that the user commits explicitly '
              'via an Apply button below the list.',
          body: const Column(
            children: <Widget>[
              CheckboxListTile(
                value: true,
                onChanged: _noopBool,
                title: Text('Status: Open'),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              ),
              CheckboxListTile(
                value: false,
                onChanged: _noopBool,
                title: Text('Status: In review'),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              ),
              CheckboxListTile(
                value: true,
                onChanged: _noopBool,
                title: Text('Status: Closed'),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              ),
              CheckboxListTile(
                value: false,
                onChanged: _noopBool,
                title: Text('Has attachments'),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              ),
            ],
          ),
        ),
        _recipeCard(
          context,
          title: 'Recipe B - Terms agreement',
          notes:
              'A single must-tick checkbox used as a gate. Trailing affinity '
              'puts the box close to the submit button.',
          body: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const CheckboxListTile(
              value: false,
              onChanged: _noopBool,
              controlAffinity: ListTileControlAffinity.trailing,
              isThreeLine: true,
              title: Text('I agree to the terms of service'),
              subtitle: Text(
                'By checking this box you confirm that you have read and '
                'accept the conditions described in the linked document.',
              ),
              secondary: Icon(Icons.gavel_outlined),
            ),
          ),
        ),
        _recipeCard(
          context,
          title: 'Recipe C - Parent/children with tristate',
          notes:
              'The parent row uses tristate; the value depends on how many '
              'children are checked: none -> false, some -> null, all -> true.',
          body: const Column(
            children: <Widget>[
              CheckboxListTile(
                value: null,
                tristate: true,
                onChanged: _noopBool,
                title: Text('Select all'),
                secondary: Icon(Icons.folder_open),
              ),
              Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      value: true,
                      onChanged: _noopBool,
                      title: Text('reports/q1.pdf'),
                      dense: true,
                    ),
                    CheckboxListTile(
                      value: false,
                      onChanged: _noopBool,
                      title: Text('reports/q2.pdf'),
                      dense: true,
                    ),
                    CheckboxListTile(
                      value: true,
                      onChanged: _noopBool,
                      title: Text('reports/q3.pdf'),
                      dense: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _recipeCard(
          context,
          title: 'Recipe D - Density grid',
          notes:
              'Same content rendered dense and non-dense side by side to '
              'show the vertical footprint difference.',
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _miniLabel('Regular density'),
                    const CheckboxListTile(
                      value: true,
                      onChanged: _noopBool,
                      title: Text('Item Alpha'),
                      subtitle: Text('Two-line content'),
                    ),
                    const CheckboxListTile(
                      value: false,
                      onChanged: _noopBool,
                      title: Text('Item Beta'),
                      subtitle: Text('Two-line content'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _miniLabel('dense: true'),
                    const CheckboxListTile(
                      value: true,
                      onChanged: _noopBool,
                      dense: true,
                      title: Text('Item Alpha'),
                      subtitle: Text('Two-line content'),
                    ),
                    const CheckboxListTile(
                      value: false,
                      onChanged: _noopBool,
                      dense: true,
                      title: Text('Item Beta'),
                      subtitle: Text('Two-line content'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miniLabel(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          color: Colors.black54,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _recipeCard(
    BuildContext context, {
    required String title,
    required String notes,
    required Widget body,
  }) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              notes,
              style: const TextStyle(fontSize: 12.5, color: Colors.black87),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// Section 8: Glossary + property reference table.
// =====================================================================
class _SectionEightGlossary extends StatelessWidget {
  const _SectionEightGlossary();

  @override
  Widget build(BuildContext context) {
    print('=== Section 8: Glossary and Property Reference ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final List<_GlossaryEntry> entries = <_GlossaryEntry>[
      _GlossaryEntry(
        term: 'ListTileControlAffinity',
        gloss:
            'Enumeration: leading, trailing, platform. Decides which side '
            'the checkbox sits on. platform is the default and follows the '
            'host OS convention (leading on iOS, trailing on Material).',
      ),
      _GlossaryEntry(
        term: 'Tristate',
        gloss:
            'When tristate is true, the value can be null in addition to '
            'true/false. Useful for parent/children rollups.',
      ),
      _GlossaryEntry(
        term: 'WidgetStateProperty',
        gloss:
            'A function-like object that maps a Set<WidgetState> to a value. '
            'CheckboxListTile uses it for fillColor, overlayColor, etc.',
      ),
      _GlossaryEntry(
        term: 'selected vs value',
        gloss:
            'selected drives the row background (selectedTileColor) and is '
            'orthogonal to the checked state. value drives the checkbox glyph.',
      ),
      _GlossaryEntry(
        term: 'enabled vs onChanged null',
        gloss:
            'Setting enabled: false or passing onChanged: null both make the '
            'tile non-interactive; the former is preferred when the disabled '
            'state is transient.',
      ),
      _GlossaryEntry(
        term: 'secondary',
        gloss:
            'Renders on the side OPPOSITE the checkbox. With trailing '
            'affinity this is the leading slot, and vice versa.',
      ),
      _GlossaryEntry(
        term: 'isThreeLine',
        gloss:
            'Reserves vertical space for a subtitle of up to two lines. '
            'Requires subtitle to be non-null.',
      ),
      _GlossaryEntry(
        term: 'dense',
        gloss:
            'Compact vertical density. When null, ThemeData.listTileTheme '
            'or the platform default applies.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _SectionTitle(
          number: 8,
          title: 'Glossary and Property Reference',
          subtitle:
              'Definitions for the terms used throughout this demo, plus '
              'a quick property-to-purpose lookup table.',
          icon: Icons.menu_book,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            children: <Widget>[
              for (final _GlossaryEntry entry in entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 6.0,
                        height: 6.0,
                        margin: const EdgeInsets.only(top: 7.0, right: 10.0),
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Colors.black87,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: '${entry.term}: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: scheme.primary,
                                ),
                              ),
                              TextSpan(text: entry.gloss),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        _propertyTable(context),
      ],
    );
  }

  Widget _propertyTable(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<List<String>> rows = <List<String>>[
      <String>['value', 'bool?', 'Checkbox state (true/false/null)'],
      <String>['tristate', 'bool', 'Allow null as a valid value'],
      <String>['onChanged', 'ValueChanged<bool?>?', 'null = disabled'],
      <String>['activeColor', 'Color?', 'Box fill when checked (legacy)'],
      <String>['checkColor', 'Color?', 'Color of the check glyph'],
      <String>[
        'fillColor',
        'WidgetStateProperty<Color?>?',
        'Per-state box fill resolver'
      ],
      <String>['title', 'Widget?', 'Primary line (usually Text)'],
      <String>['subtitle', 'Widget?', 'Secondary line (usually Text)'],
      <String>['secondary', 'Widget?', 'Opposite-side leading widget'],
      <String>['isThreeLine', 'bool', 'Reserve space for two-line subtitle'],
      <String>['dense', 'bool?', 'Compact vertical density'],
      <String>[
        'controlAffinity',
        'ListTileControlAffinity',
        'Which side hosts the box'
      ],
      <String>['shape', 'ShapeBorder?', 'Outer tile shape'],
      <String>['tileColor', 'Color?', 'Background when not selected'],
      <String>[
        'selectedTileColor',
        'Color?',
        'Background when selected = true'
      ],
      <String>[
        'contentPadding',
        'EdgeInsetsGeometry?',
        'Padding around tile contents'
      ],
      <String>['enabled', 'bool?', 'Disable the entire tile'],
      <String>[
        'autofocus',
        'bool',
        'Take focus on first build (advanced)'
      ],
    ];

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: scheme.outlineVariant, width: 1.0),
              ),
            ),
            child: const Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    'property',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'type',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'purpose',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: i.isEven
                    ? scheme.surfaceContainerLowest
                    : Colors.transparent,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i][0],
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      rows[i][1],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      rows[i][2],
                      style: const TextStyle(fontSize: 12.0),
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

class _GlossaryEntry {
  const _GlossaryEntry({required this.term, required this.gloss});

  final String term;
  final String gloss;
}

// =====================================================================
// Footer strip.
// =====================================================================
class _FooterStrip extends StatelessWidget {
  const _FooterStrip();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
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
          Icon(Icons.check_circle_outline, color: scheme.onPrimaryContainer),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'End of CheckboxListTile deep demo. Eight sections, every '
              'property exercised.',
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Shared section title used by every section.
// =====================================================================
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final int number;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: scheme.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Icon(icon, color: scheme.primary),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Printed identifier line; the surrounding Builder prints
                // the "=== Section N ===" line via stdout. The widget
                // shows a friendly header to the reader.
                Text(
                  '=== Section $number: $title ===',
                  style: TextStyle(
                    fontSize: 16.0,
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

// =====================================================================
// Shared no-op handlers. CheckboxListTile becomes interactive (visually)
// when onChanged is non-null; we use these to render the enabled state
// without needing any actual state management.
// =====================================================================
void _noopBool(bool? value) {
  // Intentionally empty. Provided so the tile renders in its enabled
  // state; the AST runner has no event loop so nothing is fired.
}

void _noopInt(int? value) {
  // Used by RadioListTile<int> in the comparison section.
}
