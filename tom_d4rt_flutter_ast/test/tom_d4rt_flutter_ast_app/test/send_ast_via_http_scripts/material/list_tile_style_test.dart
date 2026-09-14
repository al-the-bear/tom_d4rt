// Deep visual demo: ListTileStyle — the Material enum (list, drawer) that
// selects the default typography metrics used by ListTile when resolved
// through ListTileTheme. Authored manually. STATELESS ONLY. Top-level
// ValueNotifiers + ValueListenableBuilder drive every interactive knob;
// no StatefulWidget exists in this file.
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Top-level state. Read by stateless widgets via ValueListenableBuilder.
// ═══════════════════════════════════════════════════════════════════════════

final ValueNotifier<ListTileStyle> _activeStyle =
    ValueNotifier<ListTileStyle>(ListTileStyle.list);
final ValueNotifier<bool> _denseToggle = ValueNotifier<bool>(false);
final ValueNotifier<double> _horizontalGap = ValueNotifier<double>(16.0);
final ValueNotifier<double> _minVerticalPadding = ValueNotifier<double>(4.0);
final ValueNotifier<double> _contentPadEdge = ValueNotifier<double>(16.0);
final ValueNotifier<bool> _tintTile = ValueNotifier<bool>(false);
final ValueNotifier<int> _drawerSelection = ValueNotifier<int>(0);

// ═══════════════════════════════════════════════════════════════════════════
// Entry point — d4rt convention: top-level `build(BuildContext)` returns a
// Widget. No main(), no runApp(), no imports of flutter_test.
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) => const _DemoApp();

class _DemoApp extends StatelessWidget {
  const _DemoApp();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF5B8DEE),
      brightness: Brightness.light,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListTileStyle — Deep Visual Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.w800),
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(height: 1.35),
        ),
      ),
      home: const _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          title: const Text('ListTileStyle — Deep Visual Demo'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: <Tab>[
              Tab(icon: Icon(Icons.rocket_launch_outlined), text: 'Hero'),
              Tab(icon: Icon(Icons.compare_arrows_outlined), text: 'Compare'),
              Tab(icon: Icon(Icons.format_list_bulleted), text: 'Enum'),
              Tab(icon: Icon(Icons.apps_outlined), text: 'Use cases'),
              Tab(icon: Icon(Icons.tune_outlined), text: 'Theme'),
              Tab(icon: Icon(Icons.menu_outlined), text: 'Drawer'),
              Tab(icon: Icon(Icons.account_tree_outlined), text: 'Architecture'),
              Tab(icon: Icon(Icons.warning_amber_outlined), text: 'Pitfalls'),
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'API'),
            ],
          ),
        ),
        body: const TabBarView(children: <Widget>[
          _HeroTab(),
          _CompareTab(),
          _EnumTab(),
          _UseCasesTab(),
          _ThemeInteractionsTab(),
          _DrawerTab(),
          _ArchitectureTab(),
          _PitfallsTab(),
          _ApiTab(),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared layout helpers
// ═══════════════════════════════════════════════════════════════════════════

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child, this.padding = const EdgeInsets.all(16)});
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: child,
    );
  }
}

class _Explainer extends StatelessWidget {
  const _Explainer({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: scheme.onSecondaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onSecondaryContainer,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    color: scheme.onSecondaryContainer,
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
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, this.color, this.icon});
  final String label;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color bg = color ?? scheme.primaryContainer;
    final Color fg = color == null
        ? scheme.onPrimaryContainer
        : (ThemeData.estimateBrightnessForColor(color!) == Brightness.dark
            ? Colors.white
            : Colors.black);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _StylePill extends StatelessWidget {
  const _StylePill({required this.style});
  final ListTileStyle style;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isList = style == ListTileStyle.list;
    return _Pill(
      label: 'ListTileStyle.${style.name}',
      icon: isList ? Icons.list_alt_outlined : Icons.menu_open_outlined,
      color: isList ? scheme.primary : scheme.tertiary,
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: scheme.onSurfaceVariant,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({required this.text, this.header = false});
  final String text;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: header ? FontWeight.w700 : FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 1: Hero — gradient banner introducing ListTileStyle
// ═══════════════════════════════════════════════════════════════════════════

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Meet ListTileStyle',
      subtitle:
          'A Material enum with two values — list and drawer — that selects '
          'the default TextStyle used by ListTile.title and .subtitle when no '
          'explicit textStyle is provided. It is resolved from the ambient '
          'ListTileTheme, not from the ListTile itself.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[scheme.primary, scheme.tertiary],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: scheme.onPrimary.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.format_list_bulleted,
                        color: scheme.onPrimary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'ListTileStyle',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: scheme.onPrimary,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'A tiny enum. A big typographic difference.',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: scheme.onPrimary
                                      .withValues(alpha: 0.85),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'ListTileStyle carries exactly two members: list and drawer. '
                  'When a ListTile is resolved, if no explicit titleTextStyle '
                  'or subtitleTextStyle is provided, the ambient '
                  'ListTileTheme.style decides which default metrics apply. '
                  'The enum looks trivial — two values — but it is what makes '
                  'a ListTile feel at home in a scrolling content list versus '
                  'inside a side-Drawer navigation pane.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: scheme.onPrimary.withValues(alpha: 0.95),
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const <Widget>[
                    _StylePill(style: ListTileStyle.list),
                    _StylePill(style: ListTileStyle.drawer),
                    _Pill(label: 'enum'),
                    _Pill(label: 'Material'),
                    _Pill(label: 'ListTileThemeData'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const <Widget>[
              Expanded(
                child: _HeroBullet(
                  icon: Icons.list_alt_outlined,
                  title: 'list',
                  body:
                      'Typography tuned for dense content lists: 16sp title, '
                      '14sp subtitle — subtle, readable at scale.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _HeroBullet(
                  icon: Icons.menu_open_outlined,
                  title: 'drawer',
                  body:
                      'Typography tuned for side-drawer nav: 14sp title, '
                      '12sp subtitle — compact, menu-grade scanning.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _HeroBullet(
                  icon: Icons.architecture_outlined,
                  title: 'Resolved upstream',
                  body:
                      'The enum only matters when ListTileTheme sets .style. '
                      'Locally-set textStyles always win.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _Explainer(
            icon: Icons.lightbulb_outline,
            title: 'Mental model',
            body:
                'ListTileStyle is a preset switch baked into ListTileTheme. It '
                'is the single knob that tells Flutter: "I want content-list '
                'metrics here" or "I want drawer-menu metrics here." All '
                'other ListTile behavior — colors, padding, icons — stays '
                'orthogonal. Think of it as choosing a font-size pair: '
                '(16, 14) for list, (14, 12) for drawer.',
          ),
          const SizedBox(height: 18),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Why two styles, not one?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'A Drawer lives on a narrow sidebar. Content density matters '
                  'more than reading comfort: users scan labels, they do not '
                  'read paragraphs. A ListView in the main content area is the '
                  'opposite: it wants readable body-copy typography. Rather '
                  'than force every app to configure two separate TextStyles, '
                  'Material exposes ListTileStyle — one field, two presets.',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 12),
                Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(1.2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  border: TableBorder.all(
                    color: scheme.outlineVariant,
                    width: 1,
                  ),
                  children: <TableRow>[
                    TableRow(
                      decoration:
                          BoxDecoration(color: scheme.surfaceContainerHigh),
                      children: const <Widget>[
                        _TableCell(text: 'Metric', header: true),
                        _TableCell(text: 'list', header: true),
                        _TableCell(text: 'drawer', header: true),
                      ],
                    ),
                    const TableRow(children: <Widget>[
                      _TableCell(text: 'title fontSize (sp)'),
                      _TableCell(text: '16'),
                      _TableCell(text: '14'),
                    ]),
                    const TableRow(children: <Widget>[
                      _TableCell(text: 'subtitle fontSize (sp)'),
                      _TableCell(text: '14'),
                      _TableCell(text: '12'),
                    ]),
                    const TableRow(children: <Widget>[
                      _TableCell(text: 'Typical use'),
                      _TableCell(text: 'Content lists'),
                      _TableCell(text: 'Side drawers'),
                    ]),
                    const TableRow(children: <Widget>[
                      _TableCell(text: 'Default'),
                      _TableCell(text: 'Yes'),
                      _TableCell(text: 'Only via Drawer theming'),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBullet extends StatelessWidget {
  const _HeroBullet({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: scheme.primary),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            body,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 2: Compare — the centerpiece. Two identical ListViews side-by-side.
// ═══════════════════════════════════════════════════════════════════════════

class _SampleTile {
  const _SampleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;
}

class _CompareTab extends StatelessWidget {
  const _CompareTab();

  // Identical content rendered under both styles, so the difference
  // is purely typographic.
  static const List<_SampleTile> _samples = <_SampleTile>[
    _SampleTile(
      icon: Icons.inbox_outlined,
      title: 'Inbox',
      subtitle: '12 unread messages',
    ),
    _SampleTile(
      icon: Icons.star_outline,
      title: 'Starred',
      subtitle: '4 pinned items',
    ),
    _SampleTile(
      icon: Icons.send_outlined,
      title: 'Sent',
      subtitle: 'Last sync: 08:42',
    ),
    _SampleTile(
      icon: Icons.drafts_outlined,
      title: 'Drafts',
      subtitle: '1 unsent draft',
    ),
    _SampleTile(
      icon: Icons.archive_outlined,
      title: 'Archive',
      subtitle: '2,048 items',
    ),
    _SampleTile(
      icon: Icons.delete_outline,
      title: 'Trash',
      subtitle: 'Empties in 30 days',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Side-by-side comparison',
      subtitle:
          'The same six ListTiles, identical data, placed inside two '
          'ListTileThemes: one with ListTileStyle.list, the other with '
          'ListTileStyle.drawer. Nothing else differs. The visual gap you '
          'see is entirely the enum choice.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints c) {
              final bool wide = c.maxWidth >= 720;
              const Widget left = _StyledColumn(
                style: ListTileStyle.list,
                caption: 'ListTileStyle.list',
                description: 'Body-copy metrics. 16sp / 14sp.',
                samples: _samples,
              );
              const Widget right = _StyledColumn(
                style: ListTileStyle.drawer,
                caption: 'ListTileStyle.drawer',
                description: 'Menu metrics. 14sp / 12sp.',
                samples: _samples,
              );
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Expanded(child: left),
                    SizedBox(width: 16),
                    Expanded(child: right),
                  ],
                );
              }
              return Column(
                children: const <Widget>[
                  left,
                  SizedBox(height: 16),
                  right,
                ],
              );
            },
          ),
          const SizedBox(height: 22),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Read the difference',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Scan both columns at arm\'s length. The "list" column '
                  'breathes a little more: titles feel like body copy. The '
                  '"drawer" column reads more like a navigation menu — labels '
                  'stand off the leading icon more tightly and subtitles slip '
                  'almost out of sight. Same data. Same padding. Only the '
                  'default font metrics changed.',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const <Widget>[
                    Expanded(
                      child: _DeltaMetric(
                        label: 'Title size',
                        left: '16sp',
                        right: '14sp',
                        delta: '−2sp',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _DeltaMetric(
                        label: 'Subtitle size',
                        left: '14sp',
                        right: '12sp',
                        delta: '−2sp',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _DeltaMetric(
                        label: 'Density',
                        left: 'Comfy',
                        right: 'Compact',
                        delta: '+density',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _Explainer(
            icon: Icons.compare_arrows_outlined,
            title: 'Why wrap in ListTileTheme rather than set the ListTile?',
            body:
                'Because ListTileStyle is a field of ListTileThemeData, not of '
                'ListTile itself. ListTile has no "style" parameter — it only '
                'honors the ambient ListTileTheme. Wrap the subtree, do not '
                'chase each tile.',
          ),
        ],
      ),
    );
  }
}

class _StyledColumn extends StatelessWidget {
  const _StyledColumn({
    required this.style,
    required this.caption,
    required this.description,
    required this.samples,
  });
  final ListTileStyle style;
  final String caption;
  final String description;
  final List<_SampleTile> samples;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDrawer = style == ListTileStyle.drawer;
    final Color accent = isDrawer ? scheme.tertiary : scheme.primary;
    final Color container =
        isDrawer ? scheme.tertiaryContainer : scheme.primaryContainer;
    final Color onContainer =
        isDrawer ? scheme.onTertiaryContainer : scheme.onPrimaryContainer;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14),
            color: container,
            child: Row(
              children: <Widget>[
                Icon(
                  isDrawer
                      ? Icons.menu_open_outlined
                      : Icons.list_alt_outlined,
                  color: onContainer,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        caption,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          color: onContainer,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          color: onContainer.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTileTheme(
            data: ListTileThemeData(
              style: style,
              iconColor: accent,
            ),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < samples.length; i++) ...<Widget>[
                  ListTile(
                    leading: Icon(samples[i].icon),
                    title: Text(samples[i].title),
                    subtitle: Text(samples[i].subtitle),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  if (i < samples.length - 1)
                    Divider(
                      height: 1,
                      color: scheme.outlineVariant,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeltaMetric extends StatelessWidget {
  const _DeltaMetric({
    required this.label,
    required this.left,
    required this.right,
    required this.delta,
  });
  final String label;
  final String left;
  final String right;
  final String delta;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Text(
                left,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.arrow_forward, size: 14),
              ),
              Text(
                right,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            delta,
            style: TextStyle(
              fontSize: 11,
              color: scheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 3: Enum — catalog of ListTileStyle.values
// ═══════════════════════════════════════════════════════════════════════════

class _EnumTab extends StatelessWidget {
  const _EnumTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Enum catalog',
      subtitle:
          'Iterate ListTileStyle.values. Every member carries an .index and a '
          '.name. A captioned preview under the real ListTileTheme shows '
          'exactly what each value does.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.data_array, color: scheme.primary),
                    const SizedBox(width: 10),
                    Text(
                      'ListTileStyle.values.length = ${ListTileStyle.values.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Two and only two. This enum is stable and unlikely to grow '
                  '— it exists to toggle between two default metric sets.',
                  style: TextStyle(height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < ListTileStyle.values.length; i++) ...<Widget>[
            _EnumCard(value: ListTileStyle.values[i], index: i),
            const SizedBox(height: 14),
          ],
          const SizedBox(height: 6),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Full enum reflection',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                for (final ListTileStyle v in ListTileStyle.values)
                  _KeyValueRow(
                    label: 'ListTileStyle.${v.name}',
                    value:
                        'index: ${v.index},  toString(): ${v.toString()}',
                  ),
                const SizedBox(height: 4),
                const _KeyValueRow(
                  label: 'runtimeType',
                  value: 'ListTileStyle (sealed Dart enum)',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EnumCard extends StatelessWidget {
  const _EnumCard({required this.value, required this.index});
  final ListTileStyle value;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDrawer = value == ListTileStyle.drawer;
    final Color accent = isDrawer ? scheme.tertiary : scheme.primary;
    final Color onAccent = isDrawer ? scheme.onTertiary : scheme.onPrimary;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            color: accent,
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: onAccent.withValues(alpha: 0.22),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: TextStyle(
                      color: onAccent,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ListTileStyle.${value.name}',
                        style: TextStyle(
                          color: onAccent,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        isDrawer
                            ? 'Default typography for Drawer nav tiles.'
                            : 'Default typography for content list tiles.',
                        style: TextStyle(
                          color: onAccent.withValues(alpha: 0.85),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _Pill(
                  label: '.index = $index',
                  color: onAccent.withValues(alpha: 0.18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isDrawer
                      ? 'Preview — drawer metrics (14sp / 12sp)'
                      : 'Preview — list metrics (16sp / 14sp)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                ListTileTheme(
                  data: ListTileThemeData(
                    style: value,
                    iconColor: accent,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: const Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.folder_outlined),
                          title: Text('Documents'),
                          subtitle: Text('142 files'),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.photo_library_outlined),
                          title: Text('Photos'),
                          subtitle: Text('8,420 images'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _Pill(label: '.name = "${value.name}"'),
                    _Pill(
                      label: isDrawer
                          ? 'Applied by DrawerThemeData cascade'
                          : 'Default when no .style set',
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
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 4: Use cases — six mini-cards showing real-world scenarios
// ═══════════════════════════════════════════════════════════════════════════

class _UseCaseSpec {
  const _UseCaseSpec({
    required this.title,
    required this.style,
    required this.icon,
    required this.tagline,
    required this.tiles,
  });
  final String title;
  final ListTileStyle style;
  final IconData icon;
  final String tagline;
  final List<_SampleTile> tiles;
}

class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  static const List<_UseCaseSpec> _cases = <_UseCaseSpec>[
    _UseCaseSpec(
      title: 'Settings list',
      style: ListTileStyle.list,
      icon: Icons.settings_outlined,
      tagline: 'Clear reading metrics for toggles and descriptions.',
      tiles: <_SampleTile>[
        _SampleTile(
          icon: Icons.dark_mode_outlined,
          title: 'Appearance',
          subtitle: 'Theme, font scale, colour',
        ),
        _SampleTile(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          subtitle: 'Alerts, badges, sounds',
        ),
        _SampleTile(
          icon: Icons.lock_outline,
          title: 'Privacy & security',
          subtitle: 'Permissions, biometrics',
        ),
      ],
    ),
    _UseCaseSpec(
      title: 'Email list',
      style: ListTileStyle.list,
      icon: Icons.mail_outline,
      tagline: 'Body-copy titles keep senders scannable.',
      tiles: <_SampleTile>[
        _SampleTile(
          icon: Icons.account_circle_outlined,
          title: 'Maya Johansson',
          subtitle: 'Re: Q3 roadmap draft',
        ),
        _SampleTile(
          icon: Icons.account_circle_outlined,
          title: 'Team Releases',
          subtitle: 'Build 2026.04.17 shipped',
        ),
        _SampleTile(
          icon: Icons.account_circle_outlined,
          title: 'Ravi Mehta',
          subtitle: 'Lunch Thursday?',
        ),
      ],
    ),
    _UseCaseSpec(
      title: 'Drawer menu',
      style: ListTileStyle.drawer,
      icon: Icons.menu_open_outlined,
      tagline: 'Compact labels for a narrow side pane.',
      tiles: <_SampleTile>[
        _SampleTile(
          icon: Icons.home_outlined,
          title: 'Home',
          subtitle: 'Dashboard overview',
        ),
        _SampleTile(
          icon: Icons.folder_outlined,
          title: 'Projects',
          subtitle: '14 active',
        ),
        _SampleTile(
          icon: Icons.people_alt_outlined,
          title: 'People',
          subtitle: 'Your org',
        ),
      ],
    ),
    _UseCaseSpec(
      title: 'Contact list',
      style: ListTileStyle.list,
      icon: Icons.contacts_outlined,
      tagline: 'Readable names with supporting metadata.',
      tiles: <_SampleTile>[
        _SampleTile(
          icon: Icons.person_outline,
          title: 'Anya Petrov',
          subtitle: '+1 415 555 0118',
        ),
        _SampleTile(
          icon: Icons.person_outline,
          title: 'Kenji Watanabe',
          subtitle: 'kenji@example.com',
        ),
        _SampleTile(
          icon: Icons.person_outline,
          title: 'Sofia Ricci',
          subtitle: '+39 06 555 0188',
        ),
      ],
    ),
    _UseCaseSpec(
      title: 'Gallery list',
      style: ListTileStyle.list,
      icon: Icons.photo_library_outlined,
      tagline: 'Title + captioned descriptor invites exploration.',
      tiles: <_SampleTile>[
        _SampleTile(
          icon: Icons.image_outlined,
          title: 'Summer 2025',
          subtitle: '312 photos · 4 videos',
        ),
        _SampleTile(
          icon: Icons.image_outlined,
          title: 'Rome trip',
          subtitle: '178 photos · 2 albums',
        ),
        _SampleTile(
          icon: Icons.image_outlined,
          title: 'Favourites',
          subtitle: '48 starred',
        ),
      ],
    ),
    _UseCaseSpec(
      title: 'File browser',
      style: ListTileStyle.drawer,
      icon: Icons.folder_open_outlined,
      tagline: 'Tight metrics pack more nodes per column.',
      tiles: <_SampleTile>[
        _SampleTile(
          icon: Icons.insert_drive_file_outlined,
          title: 'pubspec.yaml',
          subtitle: '2.4 KB',
        ),
        _SampleTile(
          icon: Icons.insert_drive_file_outlined,
          title: 'main.dart',
          subtitle: '18 KB',
        ),
        _SampleTile(
          icon: Icons.insert_drive_file_outlined,
          title: 'README.md',
          subtitle: '6.1 KB',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Six use cases',
      subtitle:
          'Where would you reach for each ListTileStyle? Below are six '
          'canonical scenarios — four fit list metrics, two fit drawer '
          'metrics. Each card wraps its ListTiles in the matching '
          'ListTileTheme so the choice is explicit.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
          final int cols = c.maxWidth >= 1080
              ? 3
              : (c.maxWidth >= 720 ? 2 : 1);
          return _Grid(
            columns: cols,
            spacing: 16,
            children: <Widget>[
              for (final _UseCaseSpec spec in _cases)
                _UseCaseCard(spec: spec),
            ],
          );
        },
      ),
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.spec});
  final _UseCaseSpec spec;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDrawer = spec.style == ListTileStyle.drawer;
    final Color accent = isDrawer ? scheme.tertiary : scheme.primary;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14),
            color: accent.withValues(alpha: 0.14),
            child: Row(
              children: <Widget>[
                Icon(spec.icon, color: accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        spec.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        spec.tagline,
                        style: TextStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                _StylePill(style: spec.style),
              ],
            ),
          ),
          ListTileTheme(
            data: ListTileThemeData(
              style: spec.style,
              iconColor: accent,
            ),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < spec.tiles.length; i++) ...<Widget>[
                  ListTile(
                    leading: Icon(spec.tiles[i].icon),
                    title: Text(spec.tiles[i].title),
                    subtitle: Text(spec.tiles[i].subtitle),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  if (i < spec.tiles.length - 1)
                    Divider(height: 1, color: scheme.outlineVariant),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.columns,
    required this.children,
    this.spacing = 12,
  });
  final int columns;
  final double spacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < children.length; i += columns) {
      final List<Widget> cells = <Widget>[];
      for (int j = 0; j < columns; j++) {
        final int idx = i + j;
        cells.add(
          Expanded(
            child: idx < children.length
                ? children[idx]
                : const SizedBox.shrink(),
          ),
        );
        if (j < columns - 1) cells.add(SizedBox(width: spacing));
      }
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cells,
      ));
      if (i + columns < children.length) {
        rows.add(SizedBox(height: spacing));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 5: ListTileThemeData interactions — live preview with real knobs
// ═══════════════════════════════════════════════════════════════════════════

class _ThemeInteractionsTab extends StatelessWidget {
  const _ThemeInteractionsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'ListTileThemeData interactions',
      subtitle:
          'ListTileStyle is one field of ListTileThemeData. It composes with '
          'dense, contentPadding, horizontalTitleGap, minVerticalPadding, and '
          'tileColor. Move the knobs below; the preview updates live.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Panel(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Interactive knobs',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'State is held in top-level ValueNotifiers — the widget '
                  'tree remains fully stateless.',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                ValueListenableBuilder<ListTileStyle>(
                  valueListenable: _activeStyle,
                  builder: (_, ListTileStyle style, _) {
                    return SegmentedButton<ListTileStyle>(
                      segments: const <ButtonSegment<ListTileStyle>>[
                        ButtonSegment<ListTileStyle>(
                          value: ListTileStyle.list,
                          label: Text('list'),
                          icon: Icon(Icons.list_alt_outlined),
                        ),
                        ButtonSegment<ListTileStyle>(
                          value: ListTileStyle.drawer,
                          label: Text('drawer'),
                          icon: Icon(Icons.menu_open_outlined),
                        ),
                      ],
                      selected: <ListTileStyle>{style},
                      onSelectionChanged: (Set<ListTileStyle> s) {
                        _activeStyle.value = s.first;
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    ValueListenableBuilder<bool>(
                      valueListenable: _denseToggle,
                      builder: (_, bool v, _) => FilterChip(
                        label: const Text('dense'),
                        selected: v,
                        onSelected: (bool nv) => _denseToggle.value = nv,
                        selectedColor: scheme.primaryContainer,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<bool>(
                      valueListenable: _tintTile,
                      builder: (_, bool v, _) => FilterChip(
                        label: const Text('tileColor'),
                        selected: v,
                        onSelected: (bool nv) => _tintTile.value = nv,
                        selectedColor: scheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _Knob(
                  label: 'horizontalTitleGap',
                  min: 0,
                  max: 40,
                  notifier: _horizontalGap,
                  formatter: (double v) => '${v.toStringAsFixed(0)} dp',
                ),
                _Knob(
                  label: 'minVerticalPadding',
                  min: 0,
                  max: 24,
                  notifier: _minVerticalPadding,
                  formatter: (double v) => '${v.toStringAsFixed(0)} dp',
                ),
                _Knob(
                  label: 'contentPadding (horizontal)',
                  min: 0,
                  max: 40,
                  notifier: _contentPadEdge,
                  formatter: (double v) => '${v.toStringAsFixed(0)} dp',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Live preview',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                const _LivePreviewTree(),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'How fields compose',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const _KeyValueRow(
                  label: '.style',
                  value:
                      'list | drawer — selects default title & subtitle metrics',
                ),
                const _KeyValueRow(
                  label: '.dense',
                  value:
                      'Tightens vertical padding & shrinks text one notch',
                ),
                const _KeyValueRow(
                  label: '.contentPadding',
                  value:
                      'Outer left/right inset around leading/title/trailing',
                ),
                const _KeyValueRow(
                  label: '.horizontalTitleGap',
                  value: 'Gap between leading widget and title column',
                ),
                const _KeyValueRow(
                  label: '.minVerticalPadding',
                  value: 'Minimum top/bottom padding around text',
                ),
                const _KeyValueRow(
                  label: '.tileColor',
                  value: 'Background fill for the whole tile',
                ),
                const SizedBox(height: 10),
                const _Explainer(
                  icon: Icons.info_outline,
                  title: 'Orthogonality',
                  body:
                      'Style sets the typography preset. Every other field is '
                      'independent: you can use drawer metrics with generous '
                      'padding, or list metrics in dense mode. They never '
                      'fight each other.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Knob extends StatelessWidget {
  const _Knob({
    required this.label,
    required this.min,
    required this.max,
    required this.notifier,
    required this.formatter,
  });
  final String label;
  final double min;
  final double max;
  final ValueNotifier<double> notifier;
  final String Function(double) formatter;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (_, double v, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  formatter(v),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Slider(
              value: v,
              min: min,
              max: max,
              divisions: (max - min).toInt(),
              onChanged: (double nv) => notifier.value = nv,
            ),
          ],
        ),
      ),
    );
  }
}

class _LivePreviewTree extends StatelessWidget {
  const _LivePreviewTree();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        _activeStyle,
        _denseToggle,
        _horizontalGap,
        _minVerticalPadding,
        _contentPadEdge,
        _tintTile,
      ]),
      builder: (BuildContext ctx, _) {
        final ListTileStyle style = _activeStyle.value;
        final bool isDrawer = style == ListTileStyle.drawer;
        final Color accent = isDrawer ? scheme.tertiary : scheme.primary;
        return Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListTileTheme(
            data: ListTileThemeData(
              style: style,
              dense: _denseToggle.value,
              iconColor: accent,
              horizontalTitleGap: _horizontalGap.value,
              minVerticalPadding: _minVerticalPadding.value,
              contentPadding: EdgeInsets.symmetric(
                horizontal: _contentPadEdge.value,
                vertical: 0,
              ),
              tileColor: _tintTile.value
                  ? accent.withValues(alpha: 0.08)
                  : null,
            ),
            child: Column(
              children: <Widget>[
                for (final _SampleTile s in <_SampleTile>[
                  const _SampleTile(
                    icon: Icons.wb_sunny_outlined,
                    title: 'Daily briefing',
                    subtitle: 'Updated 3 min ago',
                  ),
                  const _SampleTile(
                    icon: Icons.task_alt_outlined,
                    title: 'Tasks',
                    subtitle: '4 open, 2 due today',
                  ),
                  const _SampleTile(
                    icon: Icons.bookmark_outline,
                    title: 'Bookmarks',
                    subtitle: '12 saved pages',
                  ),
                ]) ...<Widget>[
                  ListTile(
                    leading: Icon(s.icon),
                    title: Text(s.title),
                    subtitle: Text(s.subtitle),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  Divider(height: 1, color: scheme.outlineVariant),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 6: Drawer — simulated Drawer widget showing the ambient cascade
// ═══════════════════════════════════════════════════════════════════════════

class _DrawerEntry {
  const _DrawerEntry({
    required this.icon,
    required this.label,
    required this.hint,
  });
  final IconData icon;
  final String label;
  final String hint;
}

class _DrawerTab extends StatelessWidget {
  const _DrawerTab();

  static const List<_DrawerEntry> _entries = <_DrawerEntry>[
    _DrawerEntry(
      icon: Icons.dashboard_outlined,
      label: 'Dashboard',
      hint: 'Today\'s overview',
    ),
    _DrawerEntry(
      icon: Icons.inbox_outlined,
      label: 'Inbox',
      hint: '8 unread',
    ),
    _DrawerEntry(
      icon: Icons.event_note_outlined,
      label: 'Calendar',
      hint: 'Next: 14:00 stand-up',
    ),
    _DrawerEntry(
      icon: Icons.work_outline,
      label: 'Projects',
      hint: '3 active',
    ),
    _DrawerEntry(
      icon: Icons.people_outline,
      label: 'Team',
      hint: '12 members',
    ),
    _DrawerEntry(
      icon: Icons.settings_outlined,
      label: 'Settings',
      hint: 'Preferences',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Usage inside a Drawer',
      subtitle:
          'When a ListTile lives inside a Drawer, the framework applies a '
          'DrawerThemeData → ListTileTheme cascade so ListTileStyle.drawer '
          'becomes the natural default. The simulation below makes the whole '
          'chain visible.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 520,
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: scheme.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: <Widget>[
                // Simulated Drawer on the left.
                SizedBox(
                  width: 280,
                  child: Material(
                    color: scheme.surfaceContainerHighest,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(16, 20, 16, 16),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: scheme.tertiary,
                                child: Icon(Icons.person,
                                    color: scheme.onTertiary),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Alex Hartley',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      'alex@studio.app',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: scheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1, color: scheme.outlineVariant),
                        Expanded(
                          child: ListTileTheme(
                            data: ListTileThemeData(
                              style: ListTileStyle.drawer,
                              iconColor: scheme.onSurfaceVariant,
                              selectedColor: scheme.primary,
                              selectedTileColor:
                                  scheme.primary.withValues(alpha: 0.10),
                            ),
                            child: ValueListenableBuilder<int>(
                              valueListenable: _drawerSelection,
                              builder: (_, int selected, _) => ListView(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8),
                                children: <Widget>[
                                  for (int i = 0;
                                      i < _entries.length;
                                      i++)
                                    ListTile(
                                      selected: selected == i,
                                      onTap: () =>
                                          _drawerSelection.value = i,
                                      leading:
                                          Icon(_entries[i].icon),
                                      title: Text(_entries[i].label),
                                      subtitle: Text(_entries[i].hint),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 1, color: scheme.outlineVariant),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.info_outline,
                                size: 16,
                                color: scheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'Ambient style: drawer',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: scheme.onSurfaceVariant,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Simulated content area on the right.
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _drawerSelection,
                    builder: (_, int selected, _) => Container(
                      color: scheme.surface,
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _entries[selected].label,
                            style:
                                Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _entries[selected].hint,
                            style: TextStyle(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: scheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: scheme.outlineVariant),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '(content for ${_entries[selected].label} pane)',
                                style: TextStyle(
                                  color: scheme.onSurfaceVariant,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'The ambient chain',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'The Material library ships with a built-in cascade. When '
                  'you drop a ListTile inside a Drawer, the resolution is '
                  'roughly:',
                  style: TextStyle(height: 1.4),
                ),
                const SizedBox(height: 10),
                const _Arrow('Theme.of(context).drawerTheme'),
                const _Arrow('DrawerThemeData provides a surface + shape'),
                const _Arrow(
                    'Drawer wraps children in ListTileTheme(style: drawer)'),
                const _Arrow(
                    'ListTile resolves .titleTextStyle from that ambient'),
                const _Arrow(
                    'Typography: 14sp title / 12sp subtitle by default'),
                const SizedBox(height: 10),
                const _Explainer(
                  icon: Icons.bolt_outlined,
                  title: 'You rarely set it by hand',
                  body:
                      'If you use a stock Drawer, you do not need to set '
                      'ListTileStyle.drawer yourself — the cascade already '
                      'does. You only set it explicitly when you are '
                      'building a custom side-pane that is not a real Drawer.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Icon(Icons.chevron_right, size: 18, color: scheme.primary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 7: Architecture — CustomPainter-driven resolution diagram
// ═══════════════════════════════════════════════════════════════════════════

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Architecture diagram',
      subtitle:
          'How a ListTile decides which default typography to apply. The enum '
          'is only a flag — the work happens in ListTileTheme resolution.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 380,
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: scheme.outlineVariant),
            ),
            padding: const EdgeInsets.all(14),
            child: CustomPaint(
              painter: _ArchitecturePainter(
                primary: scheme.primary,
                secondary: scheme.secondary,
                tertiary: scheme.tertiary,
                onSurface: scheme.onSurface,
                outline: scheme.outlineVariant,
                surface: scheme.surface,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: const <Widget>[
              Expanded(
                child: _Step(
                  index: '1',
                  title: 'Theme',
                  body:
                      'An ambient Theme (or nothing) sits at the top of the '
                      'widget tree.',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _Step(
                  index: '2',
                  title: 'ListTileTheme',
                  body:
                      'Explicit ListTileTheme sets .style = list or drawer, '
                      'plus padding and colours.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const <Widget>[
              Expanded(
                child: _Step(
                  index: '3',
                  title: 'ListTile',
                  body:
                      'When ListTile builds, it reads ListTileTheme.of '
                      '(context).',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _Step(
                  index: '4',
                  title: 'Font metrics',
                  body:
                      'If the tile did not override titleTextStyle, the enum '
                      'decides: list → 16/14, drawer → 14/12.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _Explainer(
            icon: Icons.architecture_outlined,
            title: 'Resolution order (short version)',
            body:
                'ListTile.titleTextStyle  >  '
                'ListTileThemeData.titleTextStyle  >  '
                'ListTileStyle preset via ListTileThemeData.style  >  '
                'framework default (list preset).',
          ),
          const SizedBox(height: 14),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Minimal code that exercises this tree',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: const Text(
                    'Theme(\n'
                    '  data: ThemeData(useMaterial3: true),\n'
                    '  child: ListTileTheme(\n'
                    '    data: ListTileThemeData(\n'
                    '      style: ListTileStyle.drawer,\n'
                    '    ),\n'
                    '    child: ListTile(\n'
                    '      leading: Icon(Icons.home),\n'
                    '      title: Text(\'Home\'),         // 14sp\n'
                    '      subtitle: Text(\'Dashboard\'), // 12sp\n'
                    '    ),\n'
                    '  ),\n'
                    ')',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
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
}

class _Step extends StatelessWidget {
  const _Step({
    required this.index,
    required this.title,
    required this.body,
  });
  final String index;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  index,
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchitecturePainter extends CustomPainter {
  _ArchitecturePainter({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.onSurface,
    required this.outline,
    required this.surface,
  });
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color onSurface;
  final Color outline;
  final Color surface;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = outline;
    final Paint fill = Paint()
      ..style = PaintingStyle.fill
      ..color = surface;
    final Paint arrow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = secondary;

    final Rect theme =
        Rect.fromLTWH(w * 0.08, h * 0.06, w * 0.84, h * 0.18);
    final Rect tileTheme =
        Rect.fromLTWH(w * 0.12, h * 0.30, w * 0.76, h * 0.18);
    final Rect tile =
        Rect.fromLTWH(w * 0.18, h * 0.54, w * 0.64, h * 0.18);
    final Rect metrics =
        Rect.fromLTWH(w * 0.24, h * 0.80, w * 0.52, h * 0.14);

    void drawBox(Rect r, String title, String sub, Color stripe) {
      final RRect rr =
          RRect.fromRectAndRadius(r, const Radius.circular(14));
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, stroke);
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(r.left, r.top, 6, r.height),
          topLeft: const Radius.circular(14),
          bottomLeft: const Radius.circular(14),
        ),
        Paint()..color = stripe,
      );
      _text(canvas, title, Offset(r.left + 14, r.top + 10),
          color: onSurface, weight: FontWeight.w700, size: 14);
      _text(canvas, sub, Offset(r.left + 14, r.top + 32),
          color: onSurface.withValues(alpha: 0.75), size: 12);
    }

    drawBox(theme, 'Theme (ThemeData.useMaterial3)',
        'Provides ColorScheme, text theme, drawerTheme.', primary);
    drawBox(tileTheme, 'ListTileTheme',
        'Carries ListTileThemeData(style: list | drawer, ...).', tertiary);
    drawBox(tile, 'ListTile',
        'Reads ListTileTheme.of(context) at build time.', primary);
    drawBox(metrics, 'ListTileStyle -> font metrics',
        'list: 16/14 · drawer: 14/12.', secondary);

    _arrow(canvas, arrow, Offset(w / 2, theme.bottom),
        Offset(w / 2, tileTheme.top), 'inheritance');
    _arrow(canvas, arrow, Offset(w / 2, tileTheme.bottom),
        Offset(w / 2, tile.top), 'ambient');
    _arrow(canvas, arrow, Offset(w / 2, tile.bottom),
        Offset(w / 2, metrics.top), 'resolves');

    _text(
      canvas,
      'ListTile resolution chain',
      Offset(18, h - 14),
      color: onSurface.withValues(alpha: 0.65),
      size: 11,
      weight: FontWeight.w600,
    );
  }

  void _text(
    Canvas canvas,
    String s,
    Offset at, {
    required Color color,
    double size = 12,
    FontWeight weight = FontWeight.w400,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  void _arrow(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset end,
    String label,
  ) {
    canvas.drawLine(start, end, paint);
    final double angle =
        math.atan2(end.dy - start.dy, end.dx - start.dx);
    const double headLen = 10;
    final Offset p1 = Offset(
      end.dx - headLen * math.cos(angle - math.pi / 7),
      end.dy - headLen * math.sin(angle - math.pi / 7),
    );
    final Offset p2 = Offset(
      end.dx - headLen * math.cos(angle + math.pi / 7),
      end.dy - headLen * math.sin(angle + math.pi / 7),
    );
    final Path path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.fill
        ..color = paint.color,
    );
    _text(
      canvas,
      label,
      Offset((start.dx + end.dx) / 2 + 10, (start.dy + end.dy) / 2 - 10),
      color: paint.color,
      size: 11,
      weight: FontWeight.w600,
    );
  }

  @override
  bool shouldRepaint(covariant _ArchitecturePainter old) =>
      old.primary != primary ||
      old.secondary != secondary ||
      old.tertiary != tertiary ||
      old.onSurface != onSurface ||
      old.outline != outline ||
      old.surface != surface;
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 8: Pitfalls
// ═══════════════════════════════════════════════════════════════════════════

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Three pitfalls to watch for',
      subtitle:
          'ListTileStyle is simple, but it interacts with several other '
          'overrides. Here are the three traps that catch new Flutter devs '
          'most often.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PitfallCard(
            index: '1',
            title: 'Overriding titleTextStyle locally',
            situation:
                'You set ListTile.titleTextStyle directly on a tile and '
                'wonder why ListTileStyle.drawer seems to have no effect.',
            fix:
                'Direct ListTile fields always win. If you want the enum '
                'preset, leave titleTextStyle unset. If you want a custom '
                'style, do not rely on the enum at all.',
            icon: Icons.edit_note_outlined,
            demo: _DemoPitfallLocalOverride(),
          ),
          const SizedBox(height: 16),
          _PitfallCard(
            index: '2',
            title: 'Forgetting the ambient ListTileTheme',
            situation:
                'You want drawer metrics but there is no ListTileTheme '
                'ancestor, so your ListTiles render with list metrics.',
            fix:
                'Either use a real Drawer (cascade is automatic) or wrap the '
                'subtree in ListTileTheme(data: ListTileThemeData(style: '
                'ListTileStyle.drawer), child: ...).',
            icon: Icons.wb_incandescent_outlined,
            demo: _DemoPitfallMissingTheme(),
          ),
          const SizedBox(height: 16),
          _PitfallCard(
            index: '3',
            title: 'Mixing with custom textColor',
            situation:
                'You set ListTile.textColor thinking it will shift the whole '
                'tile typography. It only changes the color — metrics stay '
                'whatever ListTileStyle dictates.',
            fix:
                'ListTileStyle is about size/metrics. Color is a separate '
                'field. To fully customize, set titleTextStyle and '
                'subtitleTextStyle and accept that the enum is now ignored.',
            icon: Icons.palette_outlined,
            demo: _DemoPitfallTextColor(),
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.index,
    required this.title,
    required this.situation,
    required this.fix,
    required this.icon,
    required this.demo,
  });
  final String index;
  final String title;
  final String situation;
  final String fix;
  final IconData icon;
  final Widget demo;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withValues(alpha: 0.40),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.error.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.error,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  index,
                  style: TextStyle(
                    color: scheme.onError,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(icon, color: scheme.error),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'What happens',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: scheme.error,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(situation, style: const TextStyle(height: 1.4)),
                const SizedBox(height: 10),
                Text(
                  'Fix',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(fix, style: const TextStyle(height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          demo,
        ],
      ),
    );
  }
}

class _DemoPitfallLocalOverride extends StatelessWidget {
  const _DemoPitfallLocalOverride();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTileTheme(
        data: const ListTileThemeData(style: ListTileStyle.drawer),
        child: Column(
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.label_outline),
              title: Text('Honours drawer style'),
              subtitle: Text('(14 / 12)'),
            ),
            Divider(height: 1, color: scheme.outlineVariant),
            const ListTile(
              leading: Icon(Icons.label_outline),
              title: Text('Ignores drawer style'),
              subtitle: Text('(20 / 16)'),
              titleTextStyle: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700),
              subtitleTextStyle: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoPitfallMissingTheme extends StatelessWidget {
  const _DemoPitfallMissingTheme();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: const Column(
        children: <Widget>[
          // No ListTileTheme ancestor on purpose — defaults to list metrics.
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('No ambient theme here'),
            subtitle: Text('Falls back to list metrics (16 / 14).'),
          ),
        ],
      ),
    );
  }
}

class _DemoPitfallTextColor extends StatelessWidget {
  const _DemoPitfallTextColor();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTileTheme(
        data: ListTileThemeData(
          style: ListTileStyle.drawer,
          iconColor: scheme.primary,
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text('Coloured but still drawer-sized'),
              subtitle:
                  const Text('textColor tints; enum still wins metrics.'),
              textColor: scheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 9: API cheat sheet
// ═══════════════════════════════════════════════════════════════════════════

class _ApiTab extends StatelessWidget {
  const _ApiTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'API cheat sheet',
      subtitle:
          'Everything you need to know fits on one page. ListTileStyle is a '
          'two-member enum and ListTileThemeData.style is the single field '
          'that consumes it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.data_object, color: scheme.primary),
                    const SizedBox(width: 10),
                    Text(
                      'enum ListTileStyle',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontFamily: 'monospace'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                for (final ListTileStyle v in ListTileStyle.values)
                  _ApiRow(
                    name: 'ListTileStyle.${v.name}',
                    meaning: v == ListTileStyle.drawer
                        ? 'Typography preset for side-drawer tiles. '
                            '14sp title / 12sp subtitle. Applied by the '
                            'Drawer widget via its ambient theme cascade.'
                        : 'Typography preset for content-list tiles. '
                            '16sp title / 14sp subtitle. The framework '
                            'default when no ListTileTheme.style is set.',
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.widgets_outlined, color: scheme.tertiary),
                    const SizedBox(width: 10),
                    Text(
                      'ListTileThemeData.style',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontFamily: 'monospace'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const _ApiRow(
                  name: 'Type',
                  meaning: 'ListTileStyle? — nullable.',
                ),
                const _ApiRow(
                  name: 'Default',
                  meaning: 'null, which resolves to ListTileStyle.list.',
                ),
                const _ApiRow(
                  name: 'Scope',
                  meaning:
                      'All ListTiles in the ListTileTheme subtree that do '
                      'not override titleTextStyle / subtitleTextStyle.',
                ),
                const _ApiRow(
                  name: 'Overridable by',
                  meaning:
                      'ListTileThemeData.titleTextStyle, '
                      'ListTileThemeData.subtitleTextStyle, and explicit '
                      'ListTile.titleTextStyle / ListTile.subtitleTextStyle '
                      'on individual tiles.',
                ),
                const _ApiRow(
                  name: 'Interacts with',
                  meaning:
                      'DrawerThemeData (drawers inject style = drawer), '
                      'Theme.of(context).listTileTheme, and the ambient '
                      'TextTheme.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Quick recipes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                const _Recipe(
                  title: 'Global default: list',
                  code:
                      'ThemeData(\n'
                      '  useMaterial3: true,\n'
                      '  listTileTheme: ListTileThemeData(\n'
                      '    style: ListTileStyle.list,\n'
                      '  ),\n'
                      ')',
                ),
                const SizedBox(height: 10),
                const _Recipe(
                  title: 'Scoped drawer-style list (no Drawer widget)',
                  code:
                      'ListTileTheme(\n'
                      '  data: const ListTileThemeData(\n'
                      '    style: ListTileStyle.drawer,\n'
                      '  ),\n'
                      '  child: ListView(\n'
                      '    children: myTiles,\n'
                      '  ),\n'
                      ')',
                ),
                const SizedBox(height: 10),
                const _Recipe(
                  title: 'Override for a single tile (opt out of the enum)',
                  code:
                      'ListTile(\n'
                      '  title: Text(\'Large title\'),\n'
                      '  titleTextStyle: TextStyle(fontSize: 22),\n'
                      ')',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _Explainer(
            icon: Icons.flag_outlined,
            title: 'TL;DR',
            body:
                'ListTileStyle chooses a font-metric preset. You set it on '
                'ListTileThemeData.style, never on ListTile. Two values: '
                'list for content, drawer for navigation. Everything else — '
                'colours, paddings, callbacks — is orthogonal.',
          ),
        ],
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({required this.name, required this.meaning});
  final String name;
  final String meaning;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              meaning,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _Recipe extends StatelessWidget {
  const _Recipe({required this.title, required this.code});
  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
