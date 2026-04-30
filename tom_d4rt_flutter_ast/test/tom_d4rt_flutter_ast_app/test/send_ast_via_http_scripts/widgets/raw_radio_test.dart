import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Top-level mutable state (STATELESS constraint: all mutable state lives here)
// ─────────────────────────────────────────────────────────────────────────────

/// Basic group (tab 2)
final ValueNotifier<String?> _picked = ValueNotifier<String?>(null);

/// Toggleable demo (tab 3)
final ValueNotifier<String?> _togglePicked = ValueNotifier<String?>(null);
final ValueNotifier<bool> _toggleableEnabled = ValueNotifier<bool>(true);

/// fillColor / overlayColor showcase (tab 4)
final ValueNotifier<int?> _colorPicked = ValueNotifier<int?>(null);

/// Visual-density matrix (tab 5)
final ValueNotifier<String?> _densityPicked = ValueNotifier<String?>(null);

/// Splash-radius playground (tab 6)
final ValueNotifier<double> _splashRadius = ValueNotifier<double>(20.0);
final ValueNotifier<int?> _splashPicked = ValueNotifier<int?>(null);

/// Custom labeled radio (tab 7)
final ValueNotifier<String?> _planPicked = ValueNotifier<String?>(null);

/// Keyboard navigation (tab 8)
final ValueNotifier<int?> _kbPicked = ValueNotifier<int?>(null);

// FocusNodes — file-scope so they survive rebuilds across ValueListenableBuilder
final FocusNode _kbFocus0 = FocusNode();
final FocusNode _kbFocus1 = FocusNode();
final FocusNode _kbFocus2 = FocusNode();
final FocusNode _kbFocus3 = FocusNode();

// ─────────────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: const _RawRadioDemo(),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Root shell — 9 tabs
// ─────────────────────────────────────────────────────────────────────────────

class _RawRadioDemo extends StatelessWidget {
  const _RawRadioDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Basic Group'),
    Tab(text: 'Toggleable'),
    Tab(text: 'Colors'),
    Tab(text: 'Density'),
    Tab(text: 'Splash'),
    Tab(text: 'Custom Labels'),
    Tab(text: 'Keyboard'),
    Tab(text: 'Compare'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.primaryContainer,
          title: Text(
            'RawRadio<T> Deep Demo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cs.onPrimaryContainer,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: cs.onPrimaryContainer,
            indicatorColor: cs.primary,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: [
            _HeroBannerTab(),
            _BasicGroupTab(),
            _ToggleableTab(),
            _ColorsTab(),
            _DensityMatrixTab(),
            _SplashPlaygroundTab(),
            _CustomLabeledTab(),
            _KeyboardNavigationTab(),
            _ComparisonTab(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Titled section card used across all tabs.
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = cs.surfaceContainerHighest;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: bg.withValues(alpha: 0.55),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow(this.name, this.value, {this.highlight = false});

  final String name;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color:
            highlight
                ? cs.primaryContainer.withValues(alpha: 0.35)
                : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: cs.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet(this.code);

  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(
        code,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontFamily: 'monospace',
          color: cs.onSurfaceVariant,
          height: 1.55,
        ),
      ),
    );
  }
}

class _SelectionChip extends StatelessWidget {
  const _SelectionChip({
    required this.label,
    required this.icon,
    required this.selected,
  });

  final String label;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:
            selected ? cs.primaryContainer : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? cs.primary : cs.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: selected ? cs.primary : cs.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color:
                  selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
              fontWeight:
                  selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 8),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RawRadio visual builder — a custom radio circle painter
// ─────────────────────────────────────────────────────────────────────────────

/// Custom builder widget passed to RawRadio.builder.
/// Paints the outer ring, inner dot, hover highlight, and splash ripple
/// using the [ToggleableStateMixin] animation values.
class _RadioVisual extends StatelessWidget {
  const _RadioVisual({
    required this.state,
    required this.ringColor,
    required this.dotColor,
    required this.splashRadius,
  });

  final ToggleableStateMixin state;
  final Color ringColor;
  final Color dotColor;
  final double splashRadius;

  @override
  Widget build(BuildContext context) {
    final bool selected = state.value == true;
    final bool interactive = state.isInteractive;
    final cs = Theme.of(context).colorScheme;

    final Color effectiveRing =
        interactive ? ringColor : cs.onSurface.withValues(alpha: 0.38);
    final Color effectiveDot =
        interactive ? dotColor : cs.onSurface.withValues(alpha: 0.38);

    final double reactionOpacity =
        state.reaction.value * 0.20 + state.reactionHoverFade.value * 0.08;

    return SizedBox(
      width: splashRadius * 2,
      height: splashRadius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Splash / reaction overlay
          if (interactive)
            Container(
              width: splashRadius * 2 * state.reaction.value.clamp(0.0, 1.0),
              height: splashRadius * 2 * state.reaction.value.clamp(0.0, 1.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: effectiveDot.withValues(
                  alpha: reactionOpacity.clamp(0.0, 0.28),
                ),
              ),
            ),
          // Outer ring
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: effectiveRing,
                width: selected ? 2.0 : 2.0,
              ),
            ),
            child: selected
                ? Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 20.0 * 0.48,
                      height: 20.0 * 0.48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: effectiveDot,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

// Default visual using theme colors.
class _DefaultRadioVisual extends StatelessWidget {
  const _DefaultRadioVisual({required this.state});

  final ToggleableStateMixin state;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _RadioVisual(
      state: state,
      ringColor: state.value == true ? cs.primary : cs.onSurface.withValues(alpha: 0.6),
      dotColor: cs.primary,
      splashRadius: 20.0,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper: a RawRadio wired into the nearest RadioGroup via maybeOf
// ─────────────────────────────────────────────────────────────────────────────

class _GroupedRawRadio<T> extends StatelessWidget {
  const _GroupedRawRadio({
    super.key,
    required this.value,
    required this.focusNode,
    this.autofocus = false,
    this.toggleable = false,
    this.splashR = 20.0,
    this.ringColor,
    this.dotColor,
    this.enabled = true,
  });

  final T value;
  final FocusNode focusNode;
  final bool autofocus;
  final bool toggleable;
  final double splashR;
  final Color? ringColor;
  final Color? dotColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final registry = RadioGroup.maybeOf<T>(context);
    final cs = Theme.of(context).colorScheme;
    final effectiveRing = ringColor ?? cs.primary;
    final effectiveDot = dotColor ?? cs.primary;

    return RawRadio<T>(
      value: value,
      mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.forbidden;
        }
        return SystemMouseCursors.click;
      }),
      toggleable: toggleable,
      focusNode: focusNode,
      autofocus: autofocus,
      groupRegistry: registry,
      enabled: enabled && registry != null,
      builder: (BuildContext ctx, ToggleableStateMixin state) {
        return _RadioVisual(
          state: state,
          ringColor: effectiveRing,
          dotColor: effectiveDot,
          splashRadius: splashR,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 1 – Hero Banner
// ─────────────────────────────────────────────────────────────────────────────

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gradient hero
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.radio_button_checked, size: 44, color: cs.primary),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RawRadio<T>',
                            style: tt.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: cs.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            'The bare-metal radio primitive',
                            style: tt.bodyMedium?.copyWith(
                              color: cs.onSecondaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'RawRadio<T> is the lowest-level radio widget in Flutter\'s '
                  'widget library. It manages animation, focus, gestures, and '
                  'selection state, but delegates all visual rendering to the '
                  'caller-provided builder. Both Material Radio<T> and '
                  'CupertinoRadio<T> are built on top of RawRadio<T>. '
                  'In Flutter 3.41+ RawRadio uses RadioGroup / '
                  'RadioGroupRegistry for group state management.',
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onPrimaryContainer,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Live hierarchy preview
          _SectionCard(
            title: 'Widget Hierarchy',
            subtitle: 'How radio primitives stack in Flutter 3.41+',
            child: const _HierarchyDiagram(),
          ),
          // Key concept callouts
          _SectionCard(
            title: 'Key Concepts',
            subtitle: 'What makes RawRadio the building block',
            child: Column(
              children: const [
                _ConceptTile(
                  icon: Icons.layers_outlined,
                  label: 'builder-driven visual',
                  body:
                      'RawRadio accepts a RadioBuilder callback that receives '
                      'a ToggleableStateMixin, giving full control over '
                      'animation values (position, reaction, hover/focus '
                      'fade).',
                ),
                _ConceptTile(
                  icon: Icons.group_work_outlined,
                  label: 'RadioGroup / RadioGroupRegistry',
                  body:
                      'Group state (groupValue, onChanged) is now owned by '
                      'RadioGroup, the parent widget. RawRadio registers '
                      'itself via RadioGroupRegistry obtained from '
                      'RadioGroup.maybeOf(context).',
                ),
                _ConceptTile(
                  icon: Icons.toggle_off_outlined,
                  label: 'toggleable: bool',
                  body:
                      'When true, tapping the already-selected radio calls '
                      'RadioGroup.onChanged(null), deselecting the group.',
                ),
                _ConceptTile(
                  icon: Icons.keyboard_outlined,
                  label: 'Built-in keyboard navigation',
                  body:
                      'RadioGroup wires arrow-key shortcuts automatically. '
                      'Up/Left = previous, Down/Right = next, Space = select.',
                ),
              ],
            ),
          ),
          // Constructor reference
          _SectionCard(
            title: 'RawRadio Constructor (Flutter 3.41+)',
            subtitle: 'All parameters — all required',
            child: _CodeSnippet(
              'RawRadio<T>({\n'
              '  Key? key,\n'
              '  required T value,\n'
              '  required WidgetStateProperty<MouseCursor> mouseCursor,\n'
              '  required bool toggleable,\n'
              '  required FocusNode focusNode,\n'
              '  required bool autofocus,\n'
              '  required RadioGroupRegistry<T>? groupRegistry,\n'
              '  required bool enabled,\n'
              '  required RadioBuilder builder,\n'
              '  // builder = (BuildContext ctx, ToggleableStateMixin state)\n'
              '  //             => Widget\n'
              '})',
            ),
          ),
          // vs Radio difference box
          _SectionCard(
            title: 'API Delta: RawRadio vs Radio',
            subtitle: 'Params that Radio adds on top of RawRadio',
            child: Column(
              children: const [
                _PropRow('fillColor', 'WidgetStateProperty<Color?>?'),
                _PropRow('overlayColor', 'WidgetStateProperty<Color?>?'),
                _PropRow('splashRadius', 'double?'),
                _PropRow('visualDensity', 'VisualDensity?'),
                _PropRow(
                  'materialTapTargetSize',
                  'MaterialTapTargetSize?',
                ),
                _PropRow('activeColor', 'Color? (deprecated convenience)'),
                _PropRow('hoverColor / focusColor', 'Color? shortcuts'),
                _PropRow('backgroundColor', 'WidgetStateProperty<Color?>?'),
                _PropRow('side / innerRadius', 'BorderSide / WidgetStateProperty<double?>?'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HierarchyDiagram extends StatelessWidget {
  const _HierarchyDiagram();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final items = <(String, String, Color, Color)>[
      (
        'RadioListTile<T>',
        'Full ListTile chrome + Radio inside',
        cs.tertiaryContainer,
        cs.onTertiaryContainer,
      ),
      (
        'Radio<T>  |  CupertinoRadio<T>',
        'Adds theme defaults, painter, colors, tap-target size',
        cs.secondaryContainer,
        cs.onSecondaryContainer,
      ),
      (
        'RawRadio<T>',
        'Animations · Focus · Gestures · Semantics · builder callback',
        cs.primaryContainer,
        cs.onPrimaryContainer,
      ),
      (
        'RadioGroup<T>',
        'groupValue · onChanged · keyboard shortcuts · accessibility',
        cs.surfaceContainerHighest,
        cs.onSurface,
      ),
    ];
    return Column(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: items[i].$3,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[i].$1,
                        style: TextStyle(
                          color: items[i].$4,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        items[i].$2,
                        style: TextStyle(
                          color: items[i].$4.withValues(alpha: 0.75),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (i == 2)
                  Chip(
                    label: const Text('primitive'),
                    backgroundColor: cs.primary,
                    labelStyle: TextStyle(
                      color: cs.onPrimary,
                      fontSize: 10,
                    ),
                  ),
              ],
            ),
          ),
          if (i < items.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Icon(Icons.arrow_downward, color: cs.outline, size: 18),
            ),
        ],
      ],
    );
  }
}

class _ConceptTile extends StatelessWidget {
  const _ConceptTile({
    required this.icon,
    required this.label,
    required this.body,
  });

  final IconData icon;
  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: cs.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(body, style: tt.bodySmall?.copyWith(height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 2 – Basic Radio Group
// ─────────────────────────────────────────────────────────────────────────────

class _BasicGroupTab extends StatelessWidget {
  const _BasicGroupTab();

  static const List<String> _options = [
    'Mercury',
    'Venus',
    'Earth',
    'Mars',
    'Jupiter',
  ];

  static const Map<String, String> _subtitles = {
    'Mercury': 'Closest to the Sun · rocky · 0 moons',
    'Venus': 'Hottest planet · thick CO₂ atmosphere',
    'Earth': 'Our home · liquid water · 1 moon',
    'Mars': 'The Red Planet · iron oxide surface · 2 moons',
    'Jupiter': 'Largest planet · Great Red Spot · 95 moons',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: '5-Item Radio Group',
            subtitle:
                'Five RawRadio<String> inside a RadioGroup<String>. '
                'The group\'s value comes from a top-level ValueNotifier<String?>.',
            child: ValueListenableBuilder<String?>(
              valueListenable: _picked,
              builder: (context, picked, _) {
                return RadioGroup<String>(
                  groupValue: picked,
                  onChanged: (v) => _picked.value = v,
                  child: Column(
                    children: [
                      for (final option in _options)
                        _BasicRadioRow(
                          option: option,
                          subtitle: _subtitles[option]!,
                          groupValue: picked,
                        ),
                      const SizedBox(height: 12),
                      _SelectionChip(
                        label:
                            picked == null
                                ? 'Nothing selected yet'
                                : 'Selected: $picked',
                        icon:
                            picked == null
                                ? Icons.help_outline
                                : Icons.check_circle_outline,
                        selected: picked != null,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _SectionCard(
            title: 'RadioGroup + RawRadio Pattern',
            subtitle: 'The correct wiring in Flutter 3.41+',
            child: _CodeSnippet(
              'final ValueNotifier<String?> _picked =\n'
              '    ValueNotifier<String?>(null);\n\n'
              'ValueListenableBuilder<String?>(\n'
              '  valueListenable: _picked,\n'
              '  builder: (ctx, picked, _) => RadioGroup<String>(\n'
              '    groupValue: picked,\n'
              '    onChanged: (v) => _picked.value = v,\n'
              '    child: Column(\n'
              '      children: [\n'
              '        RawRadio<String>(\n'
              '          value: \'Mercury\',\n'
              '          mouseCursor: WidgetStateProperty\n'
              '              .all(SystemMouseCursors.click),\n'
              '          toggleable: false,\n'
              '          focusNode: _myFocusNode,\n'
              '          autofocus: false,\n'
              '          groupRegistry:\n'
              '              RadioGroup.maybeOf<String>(ctx),\n'
              '          enabled: true,\n'
              '          builder: (ctx, state) =>\n'
              '              _MyRadioVisual(state: state),\n'
              '        ),\n'
              '        ...\n'
              '      ],\n'
              '    ),\n'
              '  ),\n'
              ')',
            ),
          ),
          _SectionCard(
            title: 'groupValue: null vs non-null',
            subtitle: 'When groupValue is null, no radio appears selected.',
            child: _NullGroupValueDemo(),
          ),
        ],
      ),
    );
  }
}

class _BasicRadioRow extends StatelessWidget {
  const _BasicRadioRow({
    required this.option,
    required this.subtitle,
    required this.groupValue,
  });

  final String option;
  final String subtitle;
  final String? groupValue;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final selected = option == groupValue;
    final fn = FocusNode();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          _GroupedRawRadio<String>(
            value: option,
            focusNode: fn,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight:
                        selected ? FontWeight.bold : FontWeight.normal,
                    color: selected ? cs.primary : cs.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            Icon(Icons.check, size: 16, color: cs.primary),
        ],
      ),
    );
  }
}

class _NullGroupValueDemo extends StatelessWidget {
  const _NullGroupValueDemo();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              'groupValue: null',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 6),
            RadioGroup<int>(
              groupValue: null,
              onChanged: (_) {},
              child: Row(
                children: [
                  _GroupedRawRadio<int>(
                    value: 1,
                    focusNode: FocusNode(),
                  ),
                  _GroupedRawRadio<int>(
                    value: 2,
                    focusNode: FocusNode(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cs.errorContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'none selected',
                style: TextStyle(
                  fontSize: 10,
                  color: cs.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'groupValue: 1',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 6),
            RadioGroup<int>(
              groupValue: 1,
              onChanged: (_) {},
              child: Row(
                children: [
                  _GroupedRawRadio<int>(
                    value: 1,
                    focusNode: FocusNode(),
                  ),
                  _GroupedRawRadio<int>(
                    value: 2,
                    focusNode: FocusNode(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'first selected',
                style: TextStyle(
                  fontSize: 10,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 3 – Toggleable Demo
// ─────────────────────────────────────────────────────────────────────────────

class _ToggleableTab extends StatelessWidget {
  const _ToggleableTab();

  static const List<String> _fruits = ['Apple', 'Banana', 'Cherry'];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'toggleable: true',
            subtitle:
                'When toggleable is true, tapping the currently selected radio '
                'calls RadioGroup.onChanged(null), deselecting it. '
                'Toggle the switch to compare modes.',
            child: Column(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: _toggleableEnabled,
                  builder: (context, toggleEnabled, _) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            toggleEnabled
                                ? cs.primaryContainer.withValues(alpha: 0.4)
                                : cs.errorContainer.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              toggleEnabled
                                  ? cs.primary.withValues(alpha: 0.4)
                                  : cs.error.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            toggleEnabled
                                ? 'toggleable: true'
                                : 'toggleable: false',
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(
                              fontFamily: 'monospace',
                              color:
                                  toggleEnabled ? cs.primary : cs.error,
                            ),
                          ),
                          Switch(
                            value: toggleEnabled,
                            onChanged: (v) {
                              _toggleableEnabled.value = v;
                              _togglePicked.value = null;
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<String?>(
                  valueListenable: _togglePicked,
                  builder: (context, picked, _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _toggleableEnabled,
                      builder: (context, toggleable, _) {
                        return RadioGroup<String>(
                          groupValue: picked,
                          onChanged: (v) => _togglePicked.value = v,
                          child: Column(
                            children: [
                              for (final fruit in _fruits)
                                _ToggleableRadioRow(
                                  label: fruit,
                                  value: fruit,
                                  groupValue: picked,
                                  toggleable: toggleable,
                                ),
                              const SizedBox(height: 10),
                              _SelectionChip(
                                label:
                                    picked == null
                                        ? 'Nothing selected'
                                        : 'Selected: $picked',
                                icon:
                                    picked == null
                                        ? Icons.radio_button_unchecked
                                        : Icons.radio_button_checked,
                                selected: picked != null,
                              ),
                              if (toggleable && picked != null) ...[
                                const SizedBox(height: 6),
                                Text(
                                  'Tap "$picked" again to deselect',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: cs.primary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'onChanged callback contract',
            subtitle: 'How the callback differs with toggleable',
            child: Column(
              children: const [
                _PropRow(
                  'toggleable: false',
                  'onChanged(value) — fires only when a NEW item is tapped',
                ),
                _PropRow(
                  'toggleable: true (new item)',
                  'onChanged(newValue) — normal selection',
                  highlight: true,
                ),
                _PropRow(
                  'toggleable: true (same item)',
                  'onChanged(null) — deselects the group',
                  highlight: true,
                ),
                _PropRow(
                  'enabled: false',
                  'No ink or gesture; radio is read-only',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'When to use toggleable',
            subtitle: 'Common UX scenarios',
            child: Column(
              children: const [
                _BulletPoint(
                  'Optional single-select filters (none = show all)',
                ),
                _BulletPoint(
                  'Radio acting as toggle button (value vs null)',
                ),
                _BulletPoint(
                  'Form fields where "no preference" is valid',
                ),
                _BulletPoint(
                  'Avoid in required-choice forms — null breaks validation',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleableRadioRow extends StatelessWidget {
  const _ToggleableRadioRow({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.toggleable,
  });

  final String value;
  final String? groupValue;
  final String label;
  final bool toggleable;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final selected = value == groupValue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          _GroupedRawRadio<String>(
            value: value,
            focusNode: FocusNode(),
            toggleable: toggleable,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: selected ? cs.primary : cs.onSurface,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          if (selected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                toggleable ? 'tap to deselect' : 'selected',
                style: TextStyle(
                  fontSize: 10,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 4 – Custom builder colors (fillColor / overlayColor analogue)
// ─────────────────────────────────────────────────────────────────────────────

class _ColorsTab extends StatelessWidget {
  const _ColorsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Custom builder — 4 color themes',
            subtitle:
                'Each RawRadio has its own builder that uses different '
                'ringColor / dotColor. RawRadio.builder is the equivalent of '
                'fillColor in Radio<T>.',
            child: const _ColorBuilderShowcase(),
          ),
          _SectionCard(
            title: 'Overlay / reaction colors',
            subtitle:
                'The builder receives ToggleableStateMixin.reaction, '
                'reactionHoverFade, reactionFocusFade animations. '
                'Use them to paint overlay effects.',
            child: const _OverlayBuilderShowcase(),
          ),
          _SectionCard(
            title: 'How Radio<T> maps fillColor to RawRadio',
            subtitle: 'Reference for building equivalent behavior',
            child: _CodeSnippet(
              '// Radio<T> does internally:\n'
              'RawRadio<T>(\n'
              '  ...\n'
              '  builder: (ctx, state) => _RadioPaint(\n'
              '    toggleableState: state,\n'
              '    fillColor: widget.fillColor, // WidgetStateProperty\n'
              '    overlayColor: widget.overlayColor,\n'
              '    splashRadius: widget.splashRadius,\n'
              '    ...\n'
              '  ),\n'
              ')\n\n'
              '// Inside _RadioPaintState.build():\n'
              '// state.value == true  → selected\n'
              '// state.reaction.value → ink ripple progress\n'
              '// state.reactionHoverFade.value → hover overlay\n'
              '// state.reactionFocusFade.value → focus overlay',
            ),
          ),
          _SectionCard(
            title: 'ToggleableStateMixin — key properties',
            subtitle: 'Available inside builder callback',
            child: Column(
              children: const [
                _PropRow('state.value', 'bool? — true=selected, false=unselected'),
                _PropRow('state.isInteractive', 'bool — false when disabled'),
                _PropRow('state.position', 'CurvedAnimation 0→1 (select transition)'),
                _PropRow('state.reaction', 'CurvedAnimation 0→1 (ink ripple)'),
                _PropRow('state.reactionHoverFade', 'CurvedAnimation (hover overlay)'),
                _PropRow('state.reactionFocusFade', 'CurvedAnimation (focus overlay)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorBuilderShowcase extends StatelessWidget {
  const _ColorBuilderShowcase();

  static final List<(String, String, Color, Color)> _profiles = [
    ('Indigo / Pink', 'ring=indigo, dot=pink', Colors.indigo, Colors.pink),
    ('Teal / Amber', 'ring=teal, dot=amber', Colors.teal, Colors.amber),
    ('Red / Orange', 'ring=red.800, dot=orange', Colors.red.shade800, Colors.orange),
    ('Purple accent', 'ring=deepPurple, dot=purple.200', Colors.deepPurple, Colors.purple.shade200),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<int?>(
      valueListenable: _colorPicked,
      builder: (context, picked, _) {
        return RadioGroup<int>(
          groupValue: picked,
          onChanged: (v) => _colorPicked.value = v,
          child: Column(
            children: [
              for (int i = 0; i < _profiles.length; i++) ...[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        picked == i
                            ? cs.primaryContainer.withValues(alpha: 0.25)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          picked == i
                              ? cs.primary.withValues(alpha: 0.4)
                              : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      _GroupedRawRadio<int>(
                        value: i,
                        focusNode: FocusNode(),
                        ringColor: _profiles[i].$3,
                        dotColor: _profiles[i].$4,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _profiles[i].$1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _profiles[i].$2,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      // Color swatches
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: _profiles[i].$3,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: _profiles[i].$4,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < _profiles.length - 1) const SizedBox(height: 6),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _OverlayBuilderShowcase extends StatelessWidget {
  const _OverlayBuilderShowcase();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _OverlayDemoCell(
              label: 'Default\n(theme)',
              ringColor: cs.primary,
              dotColor: cs.primary,
              overlayMultiplier: 1.0,
            ),
            _OverlayDemoCell(
              label: 'Low\noverlay',
              ringColor: Colors.teal,
              dotColor: Colors.teal,
              overlayMultiplier: 0.3,
            ),
            _OverlayDemoCell(
              label: 'High\noverlay',
              ringColor: Colors.deepOrange,
              dotColor: Colors.deepOrange,
              overlayMultiplier: 2.0,
            ),
            _OverlayDemoCell(
              label: 'No\noverlay',
              ringColor: Colors.grey,
              dotColor: Colors.grey,
              overlayMultiplier: 0.0,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cs.secondaryContainer.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: cs.secondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Press, hover, or focus each radio. '
                  'The ring color fades as an overlay on interaction. '
                  'overlayMultiplier scales the alpha.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OverlayDemoCell extends StatelessWidget {
  const _OverlayDemoCell({
    required this.label,
    required this.ringColor,
    required this.dotColor,
    required this.overlayMultiplier,
  });

  final String label;
  final Color ringColor;
  final Color dotColor;
  final double overlayMultiplier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioGroup<int>(
          groupValue: null,
          onChanged: (_) {},
          child: RawRadio<int>(
            value: 1,
            mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
            toggleable: false,
            focusNode: FocusNode(),
            autofocus: false,
            groupRegistry: RadioGroup.maybeOf<int>(context),
            enabled: RadioGroup.maybeOf<int>(context) != null,
            builder: (ctx, state) {
              return _RadioVisual(
                state: state,
                ringColor: ringColor,
                dotColor: dotColor,
                splashRadius: 20.0 * (overlayMultiplier == 0.0 ? 0.01 : 1.0),
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 5 – Visual Density Matrix
// ─────────────────────────────────────────────────────────────────────────────

class _DensityMatrixTab extends StatelessWidget {
  const _DensityMatrixTab();

  static const List<(String, double)> _sizes = [
    ('20 dp', 20.0),
    ('16 dp', 16.0),
    ('12 dp', 12.0),
  ];

  static const List<String> _densityLabels = [
    'compact',
    'standard',
    'comfortable',
    'adaptive',
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Radio Size × Label Density Grid',
            subtitle:
                '4 density labels × 3 radio sizes. The radio size is '
                'applied by changing the visual circle diameter in the '
                'builder. Tap any radio to highlight it.',
            child: ValueListenableBuilder<String?>(
              valueListenable: _densityPicked,
              builder: (context, picked, _) {
                return RadioGroup<String>(
                  groupValue: picked,
                  onChanged: (v) => _densityPicked.value = v,
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: cs.primaryContainer.withValues(alpha: 0.4),
                        ),
                        children: [
                          const _TH('Density'),
                          ..._sizes.map((s) => _TH(s.$1)),
                        ],
                      ),
                      for (int r = 0; r < _densityLabels.length; r++)
                        TableRow(
                          decoration: BoxDecoration(
                            color:
                                r.isEven
                                    ? cs.surfaceContainerHighest.withValues(
                                      alpha: 0.18,
                                    )
                                    : Colors.transparent,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              child: Text(
                                _densityLabels[r],
                                style: tt.labelSmall?.copyWith(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            for (int c = 0; c < _sizes.length; c++)
                              Center(
                                child: _GroupedRawRadio<String>(
                                  value: 'd${r}_s$c',
                                  focusNode: FocusNode(),
                                  splashR: _sizes[c].$2,
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          _SectionCard(
            title: 'Note: VisualDensity in RawRadio',
            subtitle:
                'RawRadio itself has no visualDensity param. Density is '
                'applied in the builder by sizing the visual widget.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'In Radio<T>, visualDensity is passed to the internal '
                  '_RadioPaint widget to adjust the tap-area SizedBox. When '
                  'using RawRadio directly, the caller controls sizing '
                  'entirely through the builder.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.5,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                _CodeSnippet(
                  'RawRadio<T>(\n'
                  '  ...\n'
                  '  builder: (ctx, state) => SizedBox(\n'
                  '    width: 48 + visualDensityDelta.x,\n'
                  '    height: 48 + visualDensityDelta.y,\n'
                  '    child: Center(\n'
                  '      child: _RadioCircle(state: state, size: 20),\n'
                  '    ),\n'
                  '  ),\n'
                  ')',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Disabled radios',
            subtitle: 'enabled: false prevents interaction',
            child: RadioGroup<int>(
              groupValue: 1,
              onChanged: (_) {},
              child: Column(
                children: [
                  Row(
                    children: [
                      _GroupedRawRadio<int>(
                        value: 1,
                        focusNode: FocusNode(),
                        enabled: false,
                      ),
                      const SizedBox(width: 8),
                      const Text('Selected + disabled (enabled: false)'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _GroupedRawRadio<int>(
                        value: 2,
                        focusNode: FocusNode(),
                        enabled: false,
                      ),
                      const SizedBox(width: 8),
                      const Text('Unselected + disabled'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TH extends StatelessWidget {
  const _TH(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 6 – Splash Radius Playground
// ─────────────────────────────────────────────────────────────────────────────

class _SplashPlaygroundTab extends StatelessWidget {
  const _SplashPlaygroundTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'splashRadius Playground',
            subtitle:
                'Drag the slider to set splashRadius (0–40). The custom '
                'builder uses this value for the SizedBox hit area and the '
                'reaction overlay circle size.',
            child: ValueListenableBuilder<double>(
              valueListenable: _splashRadius,
              builder: (context, radius, _) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'splashRadius: ${radius.toStringAsFixed(1)}',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Slider(
                      value: radius,
                      min: 0,
                      max: 40,
                      divisions: 80,
                      label: radius.toStringAsFixed(1),
                      onChanged: (v) => _splashRadius.value = v,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '20 (default)',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: cs.primary),
                          ),
                          Text(
                            '40',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    ValueListenableBuilder<int?>(
                      valueListenable: _splashPicked,
                      builder: (context, picked, _) {
                        return RadioGroup<int>(
                          groupValue: picked,
                          onChanged: (v) => _splashPicked.value = v,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i < 4; i++)
                                Column(
                                  children: [
                                    _GroupedRawRadio<int>(
                                      value: i,
                                      focusNode: FocusNode(),
                                      splashR: radius < 1 ? 1.0 : radius,
                                    ),
                                    Text(
                                      'R${i + 1}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    // Visual circle preview
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: (radius * 2 + 4).clamp(8.0, 84.0),
                        height: (radius * 2 + 4).clamp(8.0, 84.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: cs.primary.withValues(alpha: 0.4),
                            width: 2,
                          ),
                          color: cs.primaryContainer.withValues(alpha: 0.25),
                        ),
                        child: Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cs.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Reaction area preview '
                      '(${(radius * 2).toStringAsFixed(0)} dp diameter)',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _SectionCard(
            title: 'splashRadius in Radio<T> vs RawRadio',
            subtitle: 'How the param flows down',
            child: _CodeSnippet(
              '// Radio<T> passes it to _RadioPaint:\n'
              'RawRadio<T>(\n'
              '  builder: (ctx, state) => _RadioPaint(\n'
              '    splashRadius: widget.splashRadius,  // → SizedBox size\n'
              '    ...\n'
              '  ),\n'
              ')\n\n'
              '// In _RadioPaintState:\n'
              '// Size = (radioWidth, radioHeight) scaled by splashRadius.\n'
              '// The painter clips the ink to this box.',
            ),
          ),
          _SectionCard(
            title: 'splashRadius Guidelines',
            subtitle: 'When to adjust from the default',
            child: Column(
              children: const [
                _PropRow('0', 'Remove ripple entirely (strict / kiosk design)'),
                _PropRow('< 14', 'Dense list rows with many radios'),
                _PropRow('20', 'Default — recommended for touch screens', highlight: true),
                _PropRow('> 24', 'Accessibility-focused, large touch target'),
                _PropRow('> 36', 'Decorative / hero call-to-action only'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 7 – Custom Labeled Radio
// ─────────────────────────────────────────────────────────────────────────────

class _CustomLabeledTab extends StatelessWidget {
  const _CustomLabeledTab();

  static const List<_PlanInfo> _plans = [
    _PlanInfo(
      id: 'free',
      name: 'Free Plan',
      price: '\$0 / month',
      features: ['5 projects', '1 GB storage', 'Community support'],
      icon: Icons.star_border,
      color: Colors.teal,
    ),
    _PlanInfo(
      id: 'standard',
      name: 'Standard',
      price: '\$12 / month',
      features: ['50 projects', '20 GB storage', 'Email support', 'API access'],
      icon: Icons.star_half,
      color: Colors.indigo,
    ),
    _PlanInfo(
      id: 'premium',
      name: 'Premium',
      price: '\$49 / month',
      features: [
        'Unlimited projects',
        '500 GB storage',
        'Priority support',
        'API + webhooks',
        'SSO',
      ],
      icon: Icons.star,
      color: Colors.deepPurple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Plan Selector — Custom Labeled Radio',
            subtitle:
                'RawRadio inside a custom card layout. '
                'The builder uses plan accent colors.',
            child: ValueListenableBuilder<String?>(
              valueListenable: _planPicked,
              builder: (context, picked, _) {
                return RadioGroup<String>(
                  groupValue: picked,
                  onChanged: (v) => _planPicked.value = v,
                  child: Column(
                    children: [
                      for (final plan in _plans) ...[
                        _PlanCard(plan: plan, groupValue: picked),
                        const SizedBox(height: 10),
                      ],
                      if (picked != null) _ConfirmBanner(planId: picked),
                    ],
                  ),
                );
              },
            ),
          ),
          _SectionCard(
            title: 'The Wrapping Pattern',
            subtitle: 'How to build a custom labeled radio card',
            child: _CodeSnippet(
              'InkWell(\n'
              '  onTap: () => _planPicked.value = plan.id,\n'
              '  child: Row(\n'
              '    children: [\n'
              '      Icon(plan.icon, color: plan.color),\n'
              '      SizedBox(width: 12),\n'
              '      Expanded(child: Column(...)),\n'
              '      RawRadio<String>(\n'
              '        value: plan.id,\n'
              '        ...\n'
              '        groupRegistry:\n'
              '            RadioGroup.maybeOf<String>(context),\n'
              '        builder: (ctx, state) => _RadioVisual(\n'
              '          state: state,\n'
              '          ringColor: plan.color,\n'
              '          dotColor: plan.color,\n'
              '          splashRadius: 20,\n'
              '        ),\n'
              '      ),\n'
              '    ],\n'
              '  ),\n'
              ')',
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanInfo {
  const _PlanInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.features,
    required this.icon,
    required this.color,
  });

  final String id;
  final String name;
  final String price;
  final List<String> features;
  final IconData icon;
  final Color color;
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan, required this.groupValue});

  final _PlanInfo plan;
  final String? groupValue;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final selected = groupValue == plan.id;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color:
            selected
                ? plan.color.withValues(alpha: 0.08)
                : cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? plan.color : cs.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: plan.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(plan.icon, color: plan.color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name,
                        style: tt.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: selected ? plan.color : cs.onSurface,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: plan.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          plan.price,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: plan.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RawRadio<String>(
                  value: plan.id,
                  mouseCursor: const WidgetStatePropertyAll(
                    SystemMouseCursors.click,
                  ),
                  toggleable: false,
                  focusNode: FocusNode(),
                  autofocus: false,
                  groupRegistry: RadioGroup.maybeOf<String>(context),
                  enabled: RadioGroup.maybeOf<String>(context) != null,
                  builder: (ctx, state) => _RadioVisual(
                    state: state,
                    ringColor: plan.color,
                    dotColor: plan.color,
                    splashRadius: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                for (final f in plan.features)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? plan.color.withValues(alpha: 0.15)
                              : cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          size: 10,
                          color:
                              selected ? plan.color : cs.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          f,
                          style: TextStyle(
                            fontSize: 11,
                            color:
                                selected
                                    ? plan.color
                                    : cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmBanner extends StatelessWidget {
  const _ConfirmBanner({required this.planId});

  final String planId;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: cs.primary, size: 20),
          const SizedBox(width: 10),
          Text(
            'Plan selected: $planId',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: cs.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 8 – Keyboard Navigation
// ─────────────────────────────────────────────────────────────────────────────

class _KeyboardNavigationTab extends StatelessWidget {
  const _KeyboardNavigationTab();

  static const List<String> _items = [
    'Option Alpha',
    'Option Beta',
    'Option Gamma',
    'Option Delta',
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'autofocus: true + FocusNode',
            subtitle:
                'The first radio uses autofocus: true. RadioGroup wires '
                'arrow-key navigation automatically.',
            child: ValueListenableBuilder<int?>(
              valueListenable: _kbPicked,
              builder: (context, picked, _) {
                return RadioGroup<int>(
                  groupValue: picked,
                  onChanged: (v) => _kbPicked.value = v,
                  child: Column(
                    children: [
                      for (int i = 0; i < _items.length; i++)
                        _KbRadioRow(
                          index: i,
                          label: _items[i],
                          groupValue: picked,
                          focusNode: [
                            _kbFocus0,
                            _kbFocus1,
                            _kbFocus2,
                            _kbFocus3,
                          ][i],
                          autofocus: i == 0,
                        ),
                      const SizedBox(height: 12),
                      _SelectionChip(
                        label:
                            picked == null
                                ? 'Tab to focus · arrows to navigate · Space to select'
                                : 'Selected: ${_items[picked]}',
                        icon:
                            picked == null
                                ? Icons.keyboard_outlined
                                : Icons.check_circle_outline,
                        selected: picked != null,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _SectionCard(
            title: 'RadioGroup Keyboard Contract',
            subtitle: 'Built-in shortcuts provided by RadioGroup',
            child: Column(
              children: const [
                _KeyShortcutRow(
                  key_: 'Tab / Shift+Tab',
                  action:
                      'Move focus into / out of the radio group. Focus goes '
                      'to the selected radio, or the first if none selected.',
                  icon: Icons.keyboard_tab,
                ),
                _KeyShortcutRow(
                  key_: 'Space',
                  action: 'Toggle selection on the focused radio.',
                  icon: Icons.space_bar,
                ),
                _KeyShortcutRow(
                  key_: 'Arrow Down / Right',
                  action:
                      'Move selection to next radio (wraps to first).',
                  icon: Icons.arrow_downward,
                ),
                _KeyShortcutRow(
                  key_: 'Arrow Up / Left',
                  action:
                      'Move selection to previous radio (wraps to last).',
                  icon: Icons.arrow_upward,
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'FocusNode API',
            subtitle: 'Programmatic focus control',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: const [
                    _PropRow('focusNode', 'Required — pass a FocusNode instance'),
                    _PropRow('autofocus', 'bool — request focus on first frame'),
                    _PropRow('node.hasFocus', 'true when this radio is focused'),
                    _PropRow('node.requestFocus()', 'Set focus programmatically'),
                    _PropRow('node.unfocus()', 'Remove focus'),
                    _PropRow('node.dispose()', 'Must call in StatefulWidget.dispose()'),
                  ],
                ),
                const SizedBox(height: 10),
                _CodeSnippet(
                  '// RawRadio requires a non-null FocusNode:\n'
                  'final _node = FocusNode();\n\n'
                  'RawRadio<T>(\n'
                  '  focusNode: _node,\n'
                  '  autofocus: true,\n'
                  '  ...\n'
                  ')\n\n'
                  '// In dispose():\n'
                  '_node.dispose();',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Semantics',
            subtitle: 'Accessibility role emitted by RawRadio',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawRadio wraps its builder output in a Semantics widget with:\n'
                  '• inMutuallyExclusiveGroup: true\n'
                  '• checked: state.value (true = selected)\n'
                  '• On iOS/macOS: selected + radioButtonUnselectedLabel hint\n\n'
                  'RadioGroup adds SemanticsRole.radioGroup for the group.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.6,
                    color: cs.onSurfaceVariant,
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

class _KbRadioRow extends StatelessWidget {
  const _KbRadioRow({
    required this.index,
    required this.label,
    required this.groupValue,
    required this.focusNode,
    this.autofocus = false,
  });

  final int index;
  final String label;
  final int? groupValue;
  final FocusNode focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final selected = index == groupValue;
    final registry = RadioGroup.maybeOf<int>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          RawRadio<int>(
            value: index,
            mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
            toggleable: false,
            focusNode: focusNode,
            autofocus: autofocus,
            groupRegistry: registry,
            enabled: registry != null,
            builder: (ctx, state) => _DefaultRadioVisual(state: state),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: selected ? cs.primary : cs.onSurface,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          if (autofocus && !selected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: cs.tertiaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'autofocus',
                style: TextStyle(
                  fontSize: 10,
                  color: cs.onTertiaryContainer,
                  fontFamily: 'monospace',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _KeyShortcutRow extends StatelessWidget {
  const _KeyShortcutRow({
    required this.key_,
    required this.action,
    required this.icon,
  });

  final String key_;
  final String action;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: cs.primary),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: cs.outline.withValues(alpha: 0.4)),
            ),
            child: Text(
              key_,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              action,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 9 – Comparison + API Cheat Sheet
// ─────────────────────────────────────────────────────────────────────────────

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Widget Comparison Table',
            subtitle:
                'RawRadio · Radio · RadioListTile · Switch · Checkbox',
            child: const _ComparisonTable(),
          ),
          _SectionCard(
            title: 'API Cheat Sheet — RawRadio Parameters',
            subtitle: 'Every constructor parameter with type and notes',
            child: const _ApiCheatSheet(),
          ),
          _SectionCard(
            title: 'RadioGroup API',
            subtitle: 'The parent group widget that manages state',
            child: Column(
              children: const [
                _PropRow('groupValue', 'T? — currently selected value'),
                _PropRow('onChanged', 'ValueChanged<T?> — selection callback'),
                _PropRow('child', 'Widget — subtree containing RawRadio widgets'),
                _PropRow(
                  'RadioGroup.maybeOf<T>(ctx)',
                  'Returns RadioGroupRegistry<T>? from context',
                  highlight: true,
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Common Mistakes',
            subtitle: 'Pitfalls when using RawRadio directly',
            child: const _CommonMistakes(),
          ),
        ],
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    const headers = [
      'Feature',
      'RawRadio',
      'Radio',
      'RadioListTile',
      'Switch',
      'Checkbox',
    ];
    const rows = <List<String>>[
      ['Type param', 'T', 'T', 'T', 'bool', 'bool?'],
      ['Label', 'none', 'none', 'built-in', 'none', 'none'],
      ['Group state', 'RadioGroup', 'RadioGroup', 'RadioGroup', 'external', 'external'],
      ['Toggleable', 'param', 'param', 'param', 'always', 'tristate'],
      ['Visual', 'builder fn', 'painter', 'painter', 'thumb', 'painter'],
      ['Theme colors', 'manual', 'auto', 'auto', 'auto', 'auto'],
      ['splashRadius', 'builder ctrl', 'param', 'theme', 'fixed', 'fixed'],
      ['FocusNode', 'required', 'optional', 'optional', 'optional', 'optional'],
      ['Keyboard nav', 'RadioGroup', 'RadioGroup', 'RadioGroup', 'manual', 'manual'],
      ['Use case', 'custom UI', 'forms', 'list rows', 'on/off', 'multi'],
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 64,
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(),
            4: FlexColumnWidth(),
            5: FlexColumnWidth(),
          },
          border: TableBorder(
            horizontalInside: BorderSide(
              color: cs.outlineVariant,
              width: 0.5,
            ),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: cs.primaryContainer.withValues(alpha: 0.5),
              ),
              children: [
                for (final h in headers)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Text(
                      h,
                      textAlign: TextAlign.center,
                      style: tt.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            for (int r = 0; r < rows.length; r++)
              TableRow(
                decoration: BoxDecoration(
                  color:
                      r.isEven
                          ? cs.surfaceContainerHighest.withValues(alpha: 0.18)
                          : Colors.transparent,
                ),
                children: [
                  for (int c = 0; c < rows[r].length; c++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: Text(
                        rows[r][c],
                        textAlign: c == 0 ? TextAlign.left : TextAlign.center,
                        style: tt.bodySmall?.copyWith(
                          fontFamily: c == 0 ? null : 'monospace',
                          fontWeight:
                              c == 1 ? FontWeight.bold : FontWeight.normal,
                          color: c == 1 ? cs.primary : cs.onSurface,
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    const params = <(String, String, String, bool)>[
      (
        'value',
        'T',
        'The value this radio represents.',
        true,
      ),
      (
        'mouseCursor',
        'WidgetStateProperty\n<MouseCursor>',
        'Cursor for each WidgetState. Use '
            'WidgetStatePropertyAll(SystemMouseCursors.click) as default.',
        true,
      ),
      (
        'toggleable',
        'bool',
        'If true, tapping the selected radio calls '
            'RadioGroup.onChanged(null).',
        true,
      ),
      (
        'focusNode',
        'FocusNode',
        'Non-nullable. Must be disposed by caller.',
        true,
      ),
      (
        'autofocus',
        'bool',
        'Request focus on the first frame.',
        true,
      ),
      (
        'groupRegistry',
        'RadioGroupRegistry<T>?',
        'Obtained via RadioGroup.maybeOf<T>(context). '
            'null = disabled.',
        true,
      ),
      (
        'enabled',
        'bool',
        'Must be false when groupRegistry is null. '
            'Controls interactivity.',
        true,
      ),
      (
        'builder',
        'RadioBuilder',
        '(BuildContext, ToggleableStateMixin) → Widget. '
            'Draw your radio visual here.',
        true,
      ),
    ];

    return Column(
      children: [
        for (final (name, type, desc, required_) in params)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    required_
                        ? cs.primaryContainer.withValues(alpha: 0.18)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: cs.outlineVariant,
                  width: 0.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: tt.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: cs.primary,
                          ),
                        ),
                        Text(
                          type,
                          style: tt.labelSmall?.copyWith(
                            color: cs.onSurfaceVariant,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          desc,
                          style: tt.bodySmall?.copyWith(height: 1.4),
                        ),
                        if (required_) ...[
                          const SizedBox(height: 3),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: cs.errorContainer,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              'required',
                              style: TextStyle(
                                fontSize: 9,
                                color: cs.onErrorContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _CommonMistakes extends StatelessWidget {
  const _CommonMistakes();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mistakes = <(String, String, String)>[
      (
        'Null groupRegistry with enabled: true',
        'If groupRegistry is null (no RadioGroup in tree) and enabled is '
        'true, RawRadio throws an assertion error.',
        'Always set enabled = (groupRegistry != null).',
      ),
      (
        'Forgetting FocusNode',
        'FocusNode is required (non-nullable). Creating a new FocusNode '
        'inside build() leaks it because it is never disposed.',
        'Declare FocusNode at widget scope (StatefulWidget) or file scope '
        'for demos. Call dispose() in StatefulWidget.dispose().',
      ),
      (
        'Using Color.withOpacity()',
        'withOpacity() is deprecated. It produces a Color in the sRGB '
        'color space and ignores the source color space.',
        'Use Color.withValues(alpha: x) instead.',
      ),
      (
        'Skipping RadioGroup',
        'RawRadio has no groupValue or onChanged of its own. Without a '
        'RadioGroup parent, registry is null and the radio is disabled.',
        'Always wrap RawRadio widgets in a RadioGroup<T>.',
      ),
      (
        'Inline FocusNode in build()',
        'Creating FocusNode() inside a build method means a new node on '
        'every rebuild — the old one leaks.',
        'Store FocusNode in a StatefulWidget or as a file-scope variable.',
      ),
    ];

    return Column(
      children: [
        for (final (title, problem, fix) in mistakes)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.errorContainer.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: cs.errorContainer),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 16,
                      color: cs.error,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: cs.error,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  problem,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 13,
                      color: cs.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        fix,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: cs.primary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
