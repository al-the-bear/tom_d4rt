// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// Deep visual demo for the DrawerButton family of Material widgets:
//   DrawerButton, EndDrawerButton, BackButton, CloseButton
// and their *Icon variants:
//   DrawerButtonIcon, EndDrawerButtonIcon, BackButtonIcon, CloseButtonIcon
//
// All four are thin IconButton wrappers wired to common navigation/scaffold
// affordances. They exist so that an AppBar leading/actions slot reads at a
// glance instead of writing IconButton(icon: Icon(Icons.menu), onPressed: ...).
//
// Design plan for this file:
//   Section 1: Header banner + family roster (gradient hero card).
//   Section 2: Default appearance card per widget with Material 3 colors.
//   Section 3: AppBar specimens showing each button in leading or actions.
//   Section 4: Theming axis -- ButtonStyle, color, iconSize variations.
//   Section 5: Routing semantics -- which Scaffold/Navigator hook each fires.
//   Section 6: *Icon sub-widgets (just the Icon, no IconButton wrapper).
//   Section 7: Comparison table -- DrawerButton vs raw IconButton(Icons.menu)
//              and BackButton vs raw IconButton(Icons.arrow_back).
//   Section 8: Decision matrix -- when to reach for which member.
//   Section 9: Recipes (snippet cards) for common AppBar patterns.
//   Section 10: Glossary + key takeaways panel.
//
// All buttons are rendered with onPressed: null because this script runs in
// the static AST harness; pressing them is not the point, looking at them is.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) => const DrawerButtonDemoApp();

// ---------------------------------------------------------------------------
// Root widget
// ---------------------------------------------------------------------------

class DrawerButtonDemoApp extends StatelessWidget {
  const DrawerButtonDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('DrawerButton family deep demo executing');
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4A6FFF),
      brightness: Brightness.light,
    );
    final theme = ThemeData(useMaterial3: true, colorScheme: scheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DrawerButton Family Demo',
      theme: theme,
      home: Scaffold(
        backgroundColor: scheme.surfaceContainerLowest,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeaderBanner(scheme: scheme),
              const SizedBox(height: 24.0),
              _Section1FamilyRoster(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section2DefaultAppearance(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section3AppBarSpecimens(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section4ThemingAxis(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section5RoutingSemantics(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section6IconVariants(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section7ComparisonTable(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section8DecisionMatrix(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section9Recipes(scheme: scheme),
              const SizedBox(height: 28.0),
              _Section10Glossary(scheme: scheme),
              const SizedBox(height: 36.0),
              _FooterStamp(scheme: scheme),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header banner with gradient
// ---------------------------------------------------------------------------

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('Building header banner');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
            scheme.secondary,
          ],
          stops: const <double>[0.0, 0.55, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.32),
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
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: scheme.onPrimary.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Icon(Icons.menu_open, size: 40.0, color: scheme.onPrimary),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'DrawerButton Family',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: scheme.onPrimary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'DrawerButton  /  EndDrawerButton  /  BackButton  /  CloseButton',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: scheme.onPrimary.withValues(alpha: 0.92),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Convenience IconButton wrappers wired to Scaffold and Navigator hooks.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: scheme.onPrimary.withValues(alpha: 0.85),
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

// ---------------------------------------------------------------------------
// Section 1: Family roster
// ---------------------------------------------------------------------------

class _Section1FamilyRoster extends StatelessWidget {
  const _Section1FamilyRoster({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 1: Family Roster ===');
    final members = <_RosterEntry>[
      _RosterEntry(
        name: 'DrawerButton',
        iconData: Icons.menu,
        accent: scheme.primary,
        purpose: 'Opens the Scaffold drawer (leading slot).',
        hook: 'Scaffold.of(context).openDrawer()',
      ),
      _RosterEntry(
        name: 'EndDrawerButton',
        iconData: Icons.menu_open,
        accent: scheme.tertiary,
        purpose: 'Opens the Scaffold end-drawer (actions slot).',
        hook: 'Scaffold.of(context).openEndDrawer()',
      ),
      _RosterEntry(
        name: 'BackButton',
        iconData: Icons.arrow_back,
        accent: scheme.secondary,
        purpose: 'Pops the route, platform-correct glyph.',
        hook: 'Navigator.maybePop(context)',
      ),
      _RosterEntry(
        name: 'CloseButton',
        iconData: Icons.close,
        accent: scheme.error,
        purpose: 'Closes a dialog or modal route.',
        hook: 'Navigator.maybePop(context)',
      ),
    ];
    final cards = <Widget>[];
    for (var i = 0; i < members.length; i++) {
      cards.add(_buildRosterCard(members[i], i + 1));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 1: Family Roster', scheme: scheme),
        const SizedBox(height: 12.0),
        Wrap(spacing: 12.0, runSpacing: 12.0, children: cards),
      ],
    );
  }

  Widget _buildRosterCard(_RosterEntry entry, int index) {
    return Container(
      width: 260.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: entry.accent.withValues(alpha: 0.4), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: entry.accent.withValues(alpha: 0.12),
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
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: entry.accent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: entry.accent,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  entry.name,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: entry.accent,
                  ),
                ),
              ),
              Icon(entry.iconData, color: entry.accent, size: 22.0),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            entry.purpose,
            style: TextStyle(
              fontSize: 12.0,
              color: scheme.onSurface.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              entry.hook,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RosterEntry {
  const _RosterEntry({
    required this.name,
    required this.iconData,
    required this.accent,
    required this.purpose,
    required this.hook,
  });
  final String name;
  final IconData iconData;
  final Color accent;
  final String purpose;
  final String hook;
}

// ---------------------------------------------------------------------------
// Section 2: Default appearance cards
// ---------------------------------------------------------------------------

class _Section2DefaultAppearance extends StatelessWidget {
  const _Section2DefaultAppearance({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 2: Default Appearance ===');
    final entries = <_DefaultEntry>[
      _DefaultEntry(
        title: 'DrawerButton',
        accent: scheme.primary,
        button: const DrawerButton(onPressed: null),
        note: 'Default icon: Icons.menu',
      ),
      _DefaultEntry(
        title: 'EndDrawerButton',
        accent: scheme.tertiary,
        button: const EndDrawerButton(onPressed: null),
        note: 'Default icon: Icons.menu (rendered in actions slot)',
      ),
      _DefaultEntry(
        title: 'BackButton',
        accent: scheme.secondary,
        button: const BackButton(onPressed: null),
        note: 'Picks Icons.arrow_back on Android / Icons.arrow_back_ios_new on iOS',
      ),
      _DefaultEntry(
        title: 'CloseButton',
        accent: scheme.error,
        button: const CloseButton(onPressed: null),
        note: 'Default icon: Icons.close',
      ),
    ];
    final cards = <Widget>[];
    for (final e in entries) {
      cards.add(_buildCard(e));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 2: Default Appearance', scheme: scheme),
        const SizedBox(height: 12.0),
        Wrap(spacing: 14.0, runSpacing: 14.0, children: cards),
      ],
    );
  }

  Widget _buildCard(_DefaultEntry e) {
    return Container(
      width: 220.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: e.accent.withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            e.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: e.accent,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 56.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: e.accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: e.button,
          ),
          const SizedBox(height: 8.0),
          Text(
            e.note,
            style: TextStyle(
              fontSize: 11.0,
              color: scheme.onSurface.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultEntry {
  const _DefaultEntry({
    required this.title,
    required this.accent,
    required this.button,
    required this.note,
  });
  final String title;
  final Color accent;
  final Widget button;
  final String note;
}

// ---------------------------------------------------------------------------
// Section 3: AppBar specimens
// ---------------------------------------------------------------------------

class _Section3AppBarSpecimens extends StatelessWidget {
  const _Section3AppBarSpecimens({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 3: AppBar Specimens ===');
    final specimens = <_AppBarSpec>[
      _AppBarSpec(
        label: 'DrawerButton in leading slot',
        bar: AppBar(
          leading: const DrawerButton(onPressed: null),
          title: const Text('Inbox'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
        ),
      ),
      _AppBarSpec(
        label: 'EndDrawerButton in actions slot',
        bar: AppBar(
          title: const Text('Filters'),
          actions: const <Widget>[EndDrawerButton(onPressed: null)],
          backgroundColor: scheme.tertiaryContainer,
          foregroundColor: scheme.onTertiaryContainer,
        ),
      ),
      _AppBarSpec(
        label: 'BackButton in leading slot',
        bar: AppBar(
          leading: const BackButton(onPressed: null),
          title: const Text('Message detail'),
          backgroundColor: scheme.secondaryContainer,
          foregroundColor: scheme.onSecondaryContainer,
        ),
      ),
      _AppBarSpec(
        label: 'CloseButton in leading slot (modal AppBar)',
        bar: AppBar(
          leading: const CloseButton(onPressed: null),
          title: const Text('Compose'),
          backgroundColor: scheme.errorContainer,
          foregroundColor: scheme.onErrorContainer,
        ),
      ),
      _AppBarSpec(
        label: 'DrawerButton leading + EndDrawerButton trailing',
        bar: AppBar(
          leading: const DrawerButton(onPressed: null),
          title: const Text('Dashboard'),
          actions: const <Widget>[EndDrawerButton(onPressed: null)],
          backgroundColor: scheme.surfaceContainerHighest,
          foregroundColor: scheme.onSurface,
        ),
      ),
      _AppBarSpec(
        label: 'BackButton leading + CloseButton trailing',
        bar: AppBar(
          leading: const BackButton(onPressed: null),
          title: const Text('Step 2 of 3'),
          actions: const <Widget>[CloseButton(onPressed: null)],
          backgroundColor: scheme.inverseSurface,
          foregroundColor: scheme.onInverseSurface,
        ),
      ),
    ];
    final rows = <Widget>[];
    for (var i = 0; i < specimens.length; i++) {
      rows.add(_buildSpec(specimens[i], i + 1));
      rows.add(const SizedBox(height: 12.0));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 3: AppBar Specimens', scheme: scheme),
        const SizedBox(height: 12.0),
        ...rows,
      ],
    );
  }

  Widget _buildSpec(_AppBarSpec spec, int n) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.0),
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
                width: 26.0,
                height: 26.0,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$n',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  spec.label,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: kToolbarHeight,
              child: spec.bar,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarSpec {
  const _AppBarSpec({required this.label, required this.bar});
  final String label;
  final AppBar bar;
}

// ---------------------------------------------------------------------------
// Section 4: Theming axis -- style, color, iconSize
// ---------------------------------------------------------------------------

class _Section4ThemingAxis extends StatelessWidget {
  const _Section4ThemingAxis({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 4: Theming Axis ===');
    final colorVariants = <_ThemedButton>[
      _ThemedButton(
        label: 'default',
        button: const DrawerButton(onPressed: null),
      ),
      _ThemedButton(
        label: 'color: primary',
        button: DrawerButton(onPressed: null, color: scheme.primary),
      ),
      _ThemedButton(
        label: 'color: tertiary',
        button: DrawerButton(onPressed: null, color: scheme.tertiary),
      ),
      _ThemedButton(
        label: 'color: error',
        button: DrawerButton(onPressed: null, color: scheme.error),
      ),
    ];

    final sizeVariants = <_ThemedButton>[
      _ThemedButton(
        label: 'iconSize: default',
        button: const BackButton(onPressed: null),
      ),
      _ThemedButton(
        label: 'iconSize: 20',
        button: IconButton(
          iconSize: 20.0,
          icon: const BackButtonIcon(),
          onPressed: null,
        ),
      ),
      _ThemedButton(
        label: 'iconSize: 32',
        button: IconButton(
          iconSize: 32.0,
          icon: const BackButtonIcon(),
          onPressed: null,
        ),
      ),
      _ThemedButton(
        label: 'iconSize: 44',
        button: IconButton(
          iconSize: 44.0,
          icon: const BackButtonIcon(),
          onPressed: null,
        ),
      ),
    ];

    final styleVariants = <_ThemedButton>[
      _ThemedButton(
        label: 'style: filled tonal',
        button: CloseButton(
          onPressed: null,
          style: IconButton.styleFrom(
            backgroundColor: scheme.secondaryContainer,
            foregroundColor: scheme.onSecondaryContainer,
          ),
        ),
      ),
      _ThemedButton(
        label: 'style: filled error',
        button: CloseButton(
          onPressed: null,
          style: IconButton.styleFrom(
            backgroundColor: scheme.errorContainer,
            foregroundColor: scheme.onErrorContainer,
          ),
        ),
      ),
      _ThemedButton(
        label: 'style: outlined',
        button: CloseButton(
          onPressed: null,
          style: IconButton.styleFrom(
            side: BorderSide(color: scheme.outline, width: 1.4),
            foregroundColor: scheme.onSurface,
          ),
        ),
      ),
      _ThemedButton(
        label: 'style: rounded rect',
        button: CloseButton(
          onPressed: null,
          style: IconButton.styleFrom(
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 4: Theming Axis', scheme: scheme),
        const SizedBox(height: 12.0),
        _buildLane('color (DrawerButton)', colorVariants),
        const SizedBox(height: 14.0),
        _buildLane('iconSize (BackButton)', sizeVariants),
        const SizedBox(height: 14.0),
        _buildLane('style (CloseButton)', styleVariants),
      ],
    );
  }

  Widget _buildLane(String laneLabel, List<_ThemedButton> variants) {
    final cells = <Widget>[];
    for (final v in variants) {
      cells.add(
        Container(
          width: 140.0,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: scheme.outlineVariant, width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 56.0, child: Center(child: v.button)),
              const SizedBox(height: 6.0),
              Text(
                v.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.0,
                  color: scheme.onSurface.withValues(alpha: 0.78),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            laneLabel,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: scheme.primary,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(spacing: 10.0, runSpacing: 10.0, children: cells),
        ],
      ),
    );
  }
}

class _ThemedButton {
  const _ThemedButton({required this.label, required this.button});
  final String label;
  final Widget button;
}

// ---------------------------------------------------------------------------
// Section 5: Routing semantics
// ---------------------------------------------------------------------------

class _Section5RoutingSemantics extends StatelessWidget {
  const _Section5RoutingSemantics({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 5: Routing Semantics ===');
    final rows = <_RouteRow>[
      _RouteRow(
        name: 'DrawerButton',
        icon: Icons.menu,
        accent: scheme.primary,
        defaultAction: 'Scaffold.of(context).openDrawer()',
        requires: 'Ancestor Scaffold with drawer: ... provided.',
        override: 'Pass onPressed to override the default action.',
      ),
      _RouteRow(
        name: 'EndDrawerButton',
        icon: Icons.menu_open,
        accent: scheme.tertiary,
        defaultAction: 'Scaffold.of(context).openEndDrawer()',
        requires: 'Ancestor Scaffold with endDrawer: ... provided.',
        override: 'Pass onPressed to override the default action.',
      ),
      _RouteRow(
        name: 'BackButton',
        icon: Icons.arrow_back,
        accent: scheme.secondary,
        defaultAction: 'Navigator.maybePop(context)',
        requires: 'A pop-able route on the Navigator stack.',
        override: 'Provide onPressed to intercept (e.g. confirm dialog).',
      ),
      _RouteRow(
        name: 'CloseButton',
        icon: Icons.close,
        accent: scheme.error,
        defaultAction: 'Navigator.maybePop(context)',
        requires: 'Typically used on modal / full-screen dialog routes.',
        override: 'Provide onPressed to dismiss with a custom result.',
      ),
    ];
    final tiles = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      tiles.add(_buildTile(rows[i], i + 1));
      tiles.add(const SizedBox(height: 10.0));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 5: Routing Semantics', scheme: scheme),
        const SizedBox(height: 12.0),
        ...tiles,
      ],
    );
  }

  Widget _buildTile(_RouteRow r, int n) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: r.accent.withValues(alpha: 0.4), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: r.accent.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(r.icon, color: r.accent, size: 22.0),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      r.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: r.accent,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: r.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        '#$n',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: r.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                _miniRow('default', r.defaultAction, mono: true),
                _miniRow('requires', r.requires),
                _miniRow('override', r.override),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniRow(String label, String value, {bool mono = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 70.0,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface.withValues(alpha: 0.62),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11.5,
                fontFamily: mono ? 'monospace' : null,
                color: scheme.onSurface.withValues(alpha: 0.86),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteRow {
  const _RouteRow({
    required this.name,
    required this.icon,
    required this.accent,
    required this.defaultAction,
    required this.requires,
    required this.override,
  });
  final String name;
  final IconData icon;
  final Color accent;
  final String defaultAction;
  final String requires;
  final String override;
}

// ---------------------------------------------------------------------------
// Section 6: Icon-only variants
// ---------------------------------------------------------------------------

class _Section6IconVariants extends StatelessWidget {
  const _Section6IconVariants({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 6: Icon Variants ===');
    final entries = <_IconVariantEntry>[
      _IconVariantEntry(
        title: 'DrawerButtonIcon',
        icon: const DrawerButtonIcon(),
        accent: scheme.primary,
        note: 'Just the glyph used by DrawerButton.',
      ),
      _IconVariantEntry(
        title: 'EndDrawerButtonIcon',
        icon: const EndDrawerButtonIcon(),
        accent: scheme.tertiary,
        note: 'Just the glyph used by EndDrawerButton.',
      ),
      _IconVariantEntry(
        title: 'BackButtonIcon',
        icon: const BackButtonIcon(),
        accent: scheme.secondary,
        note: 'Platform-aware back glyph; respects TargetPlatform.',
      ),
      _IconVariantEntry(
        title: 'CloseButtonIcon',
        icon: const CloseButtonIcon(),
        accent: scheme.error,
        note: 'Just the glyph used by CloseButton.',
      ),
    ];
    final cards = <Widget>[];
    for (final e in entries) {
      cards.add(_buildCard(e));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 6: Icon-Only Variants', scheme: scheme),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: scheme.outlineVariant, width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Use these inside custom IconButton or ListTile widgets when '
                'you want the official glyph but not the wrapper button.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: scheme.onSurface.withValues(alpha: 0.74),
                ),
              ),
              const SizedBox(height: 12.0),
              Wrap(spacing: 12.0, runSpacing: 12.0, children: cards),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(_IconVariantEntry e) {
    return Container(
      width: 180.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: e.accent.withValues(alpha: 0.45), width: 1.2),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: e.accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: IconTheme(
              data: IconThemeData(color: e.accent, size: 28.0),
              child: Center(child: e.icon),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            e.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: e.accent,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            e.note,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.5,
              color: scheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconVariantEntry {
  const _IconVariantEntry({
    required this.title,
    required this.icon,
    required this.accent,
    required this.note,
  });
  final String title;
  final Widget icon;
  final Color accent;
  final String note;
}

// ---------------------------------------------------------------------------
// Section 7: Comparison table vs raw IconButton
// ---------------------------------------------------------------------------

class _Section7ComparisonTable extends StatelessWidget {
  const _Section7ComparisonTable({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 7: Comparison Table ===');
    final pairs = <_ComparisonPair>[
      _ComparisonPair(
        leftLabel: 'DrawerButton',
        leftWidget: const DrawerButton(onPressed: null),
        rightLabel: 'IconButton(Icons.menu)',
        rightWidget: const IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        verdict:
            'DrawerButton wires the default to openDrawer() and reads as intent.',
        accent: scheme.primary,
      ),
      _ComparisonPair(
        leftLabel: 'EndDrawerButton',
        leftWidget: const EndDrawerButton(onPressed: null),
        rightLabel: 'IconButton(Icons.menu)',
        rightWidget: const IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        verdict:
            'EndDrawerButton routes to openEndDrawer() automatically.',
        accent: scheme.tertiary,
      ),
      _ComparisonPair(
        leftLabel: 'BackButton',
        leftWidget: const BackButton(onPressed: null),
        rightLabel: 'IconButton(Icons.arrow_back)',
        rightWidget: const IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: null,
        ),
        verdict:
            'BackButton picks the platform-correct glyph and uses maybePop.',
        accent: scheme.secondary,
      ),
      _ComparisonPair(
        leftLabel: 'CloseButton',
        leftWidget: const CloseButton(onPressed: null),
        rightLabel: 'IconButton(Icons.close)',
        rightWidget: const IconButton(
          icon: Icon(Icons.close),
          onPressed: null,
        ),
        verdict:
            'CloseButton expresses dismiss intent; semantics labelled by Material.',
        accent: scheme.error,
      ),
    ];
    final rows = <Widget>[
      _buildHeader(),
      ...List<Widget>.generate(pairs.length, (i) => _buildPairRow(pairs[i], i + 1)),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 7: Comparison vs Raw IconButton', scheme: scheme),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.outlineVariant, width: 1.0),
          ),
          child: Column(children: rows),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 28.0,
            child: Text(
              '#',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onPrimaryContainer,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'family member',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onPrimaryContainer,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'raw equivalent',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onPrimaryContainer,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'verdict',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onPrimaryContainer,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPairRow(_ComparisonPair p, int n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: scheme.outlineVariant, width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 28.0,
            child: Text(
              '$n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: p.accent,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                p.leftWidget,
                const SizedBox(height: 4.0),
                Text(
                  p.leftLabel,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                    color: p.accent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                p.rightWidget,
                const SizedBox(height: 4.0),
                Text(
                  p.rightLabel,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: scheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              p.verdict,
              style: TextStyle(
                fontSize: 11.5,
                color: scheme.onSurface.withValues(alpha: 0.84),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonPair {
  const _ComparisonPair({
    required this.leftLabel,
    required this.leftWidget,
    required this.rightLabel,
    required this.rightWidget,
    required this.verdict,
    required this.accent,
  });
  final String leftLabel;
  final Widget leftWidget;
  final String rightLabel;
  final Widget rightWidget;
  final String verdict;
  final Color accent;
}

// ---------------------------------------------------------------------------
// Section 8: Decision matrix
// ---------------------------------------------------------------------------

class _Section8DecisionMatrix extends StatelessWidget {
  const _Section8DecisionMatrix({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 8: Decision Matrix ===');
    final cells = <_DecisionCell>[
      _DecisionCell(
        question: 'You have a Drawer and want a leading button',
        answer: 'DrawerButton',
        icon: Icons.menu,
        color: scheme.primary,
      ),
      _DecisionCell(
        question: 'You have an EndDrawer and want a trailing button',
        answer: 'EndDrawerButton',
        icon: Icons.menu_open,
        color: scheme.tertiary,
      ),
      _DecisionCell(
        question: 'You are on a sub-route and want to go back',
        answer: 'BackButton',
        icon: Icons.arrow_back,
        color: scheme.secondary,
      ),
      _DecisionCell(
        question: 'You opened a full-screen dialog and need to dismiss it',
        answer: 'CloseButton',
        icon: Icons.close,
        color: scheme.error,
      ),
      _DecisionCell(
        question: 'You want the glyph only (no IconButton)',
        answer: 'XxxButtonIcon variants',
        icon: Icons.image_outlined,
        color: scheme.primary,
      ),
      _DecisionCell(
        question: 'You want platform-aware back arrow',
        answer: 'BackButton / BackButtonIcon',
        icon: Icons.swap_horiz,
        color: scheme.secondary,
      ),
      _DecisionCell(
        question: 'You need a totally custom icon + onPressed',
        answer: 'Plain IconButton',
        icon: Icons.build_outlined,
        color: scheme.outline,
      ),
      _DecisionCell(
        question: 'You want to override the default action (e.g. confirm)',
        answer: 'Pass onPressed to the family member',
        icon: Icons.handyman,
        color: scheme.primary,
      ),
    ];
    final tiles = <Widget>[];
    for (var i = 0; i < cells.length; i++) {
      tiles.add(_buildCell(cells[i]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 8: Decision Matrix', scheme: scheme),
        const SizedBox(height: 12.0),
        Wrap(spacing: 10.0, runSpacing: 10.0, children: tiles),
      ],
    );
  }

  Widget _buildCell(_DecisionCell c) {
    return Container(
      width: 250.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: c.color.withValues(alpha: 0.38), width: 1.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: c.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(c.icon, size: 18.0, color: c.color),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  c.question,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: scheme.onSurface.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  c.answer,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: c.color,
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

class _DecisionCell {
  const _DecisionCell({
    required this.question,
    required this.answer,
    required this.icon,
    required this.color,
  });
  final String question;
  final String answer;
  final IconData icon;
  final Color color;
}

// ---------------------------------------------------------------------------
// Section 9: Recipes
// ---------------------------------------------------------------------------

class _Section9Recipes extends StatelessWidget {
  const _Section9Recipes({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 9: Recipes ===');
    final recipes = <_RecipeCard>[
      _RecipeCard(
        title: 'AppBar with drawer + endDrawer',
        accent: scheme.primary,
        snippet:
            'Scaffold(\n'
            '  appBar: AppBar(\n'
            '    leading: const DrawerButton(),\n'
            '    title: const Text("Inbox"),\n'
            '    actions: const [EndDrawerButton()],\n'
            '  ),\n'
            '  drawer: const NavDrawer(),\n'
            '  endDrawer: const FilterDrawer(),\n'
            '  body: ...\n'
            ')',
      ),
      _RecipeCard(
        title: 'BackButton with confirmation',
        accent: scheme.secondary,
        snippet:
            'AppBar(\n'
            '  leading: BackButton(\n'
            '    onPressed: () async {\n'
            '      final ok = await _confirmDiscard(context);\n'
            '      if (ok) Navigator.maybePop(context);\n'
            '    },\n'
            '  ),\n'
            '  title: const Text("Edit profile"),\n'
            ')',
      ),
      _RecipeCard(
        title: 'Full-screen dialog with CloseButton',
        accent: scheme.error,
        snippet:
            'Scaffold(\n'
            '  appBar: AppBar(\n'
            '    leading: const CloseButton(),\n'
            '    title: const Text("Compose"),\n'
            '    actions: [\n'
            '      TextButton(onPressed: _send, child: Text("Send")),\n'
            '    ],\n'
            '  ),\n'
            '  body: ComposeForm(),\n'
            ')',
      ),
      _RecipeCard(
        title: 'Themed DrawerButton (filled tonal)',
        accent: scheme.tertiary,
        snippet:
            'DrawerButton(\n'
            '  style: IconButton.styleFrom(\n'
            '    backgroundColor: colorScheme.secondaryContainer,\n'
            '    foregroundColor: colorScheme.onSecondaryContainer,\n'
            '  ),\n'
            ')',
      ),
      _RecipeCard(
        title: 'Custom IconButton with BackButtonIcon',
        accent: scheme.primary,
        snippet:
            'IconButton(\n'
            '  iconSize: 32.0,\n'
            '  icon: const BackButtonIcon(),\n'
            '  tooltip: "Back to inbox",\n'
            '  onPressed: () => Navigator.maybePop(context),\n'
            ')',
      ),
    ];
    final widgets = <Widget>[];
    for (var i = 0; i < recipes.length; i++) {
      widgets.add(_buildRecipe(recipes[i], i + 1));
      widgets.add(const SizedBox(height: 12.0));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 9: Recipes', scheme: scheme),
        const SizedBox(height: 12.0),
        ...widgets,
      ],
    );
  }

  Widget _buildRecipe(_RecipeCard r, int n) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: r.accent.withValues(alpha: 0.4), width: 1.2),
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
                  color: r.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'recipe $n',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: r.accent,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  r.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: r.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFF111418),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              r.snippet,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                height: 1.4,
                color: Color(0xFFB7E1B0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeCard {
  const _RecipeCard({
    required this.title,
    required this.accent,
    required this.snippet,
  });
  final String title;
  final Color accent;
  final String snippet;
}

// ---------------------------------------------------------------------------
// Section 10: Glossary + takeaways
// ---------------------------------------------------------------------------

class _Section10Glossary extends StatelessWidget {
  const _Section10Glossary({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 10: Glossary ===');
    final terms = <_GlossaryTerm>[
      _GlossaryTerm(
        term: 'DrawerButton',
        definition:
            'A Material IconButton wired to Scaffold.of(context).openDrawer() '
            'as its default onPressed.',
      ),
      _GlossaryTerm(
        term: 'EndDrawerButton',
        definition:
            'The mirror of DrawerButton, defaulting to openEndDrawer(). '
            'Typically rendered in AppBar.actions.',
      ),
      _GlossaryTerm(
        term: 'BackButton',
        definition:
            'A back-affordance IconButton whose icon adapts to TargetPlatform '
            'and whose default action is Navigator.maybePop(context).',
      ),
      _GlossaryTerm(
        term: 'CloseButton',
        definition:
            'An IconButton with the close glyph, also defaulting to '
            'Navigator.maybePop. Conveys dismiss rather than go-back.',
      ),
      _GlossaryTerm(
        term: 'DrawerButtonIcon / EndDrawerButtonIcon',
        definition:
            'The icon-only widgets used internally by the buttons. Useful when '
            'you want to build a custom IconButton but keep the official glyph.',
      ),
      _GlossaryTerm(
        term: 'BackButtonIcon',
        definition:
            'Selects the platform-correct back arrow glyph (e.g. arrow_back on '
            'Android, arrow_back_ios_new on iOS).',
      ),
      _GlossaryTerm(
        term: 'CloseButtonIcon',
        definition: 'The Icons.close glyph used by CloseButton.',
      ),
      _GlossaryTerm(
        term: 'ButtonStyle (style:)',
        definition:
            'IconButton.styleFrom(...) builds a ButtonStyle. All family members '
            'forward it to the underlying IconButton.',
      ),
    ];
    final takeaways = <_Takeaway>[
      _Takeaway(
        icon: Icons.read_more,
        label: 'Express intent',
        body:
            'Reach for DrawerButton / BackButton instead of IconButton + icon -- '
            'reviewers and screen readers both benefit.',
        color: scheme.primary,
      ),
      _Takeaway(
        icon: Icons.settings_input_component,
        label: 'Defaults are sensible',
        body:
            'Each member ships with the correct Scaffold/Navigator hook. You '
            'only pass onPressed when you need to override it.',
        color: scheme.secondary,
      ),
      _Takeaway(
        icon: Icons.style,
        label: 'Fully themable',
        body:
            'style, color, and iconSize all flow through to the underlying '
            'IconButton, so Material 3 theming applies cleanly.',
        color: scheme.tertiary,
      ),
      _Takeaway(
        icon: Icons.devices,
        label: 'Platform aware',
        body:
            'BackButton automatically picks the right glyph per platform. No '
            'manual Platform.isIOS branching needed.',
        color: scheme.error,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(text: 'Section 10: Glossary and Takeaways', scheme: scheme),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: scheme.outlineVariant, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Glossary',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              ...List<Widget>.generate(terms.length, (i) {
                final t = terms[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        t.term,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: scheme.primary,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        t.definition,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: scheme.onSurface.withValues(alpha: 0.82),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
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
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ...List<Widget>.generate(takeaways.length, (i) {
                final t = takeaways[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: scheme.surface.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: t.color.withValues(alpha: 0.35),
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
                          color: t.color.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(t.icon, size: 18.0, color: t.color),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              t.label,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                                color: t.color,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              t.body,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: scheme.onSurface.withValues(alpha: 0.85),
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlossaryTerm {
  const _GlossaryTerm({required this.term, required this.definition});
  final String term;
  final String definition;
}

class _Takeaway {
  const _Takeaway({
    required this.icon,
    required this.label,
    required this.body,
    required this.color,
  });
  final IconData icon;
  final String label;
  final String body;
  final Color color;
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class _FooterStamp extends StatelessWidget {
  const _FooterStamp({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('Building footer stamp');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.check_circle, color: scheme.primary, size: 22.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Demo built: DrawerButton, EndDrawerButton, BackButton, '
              'CloseButton and their *Icon variants.',
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section title widget
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text, required this.scheme});
  final String text;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary.withValues(alpha: 0.18),
            scheme.tertiary.withValues(alpha: 0.10),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(color: scheme.primary, width: 3.5),
        ),
      ),
      child: Text(
        '=== $text ===',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: scheme.onSurface,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
