// D4rt deep visual demo: Platform Menu Widgets
// Covers: PlatformMenuBar, PlatformMenu, PlatformMenuItem,
//         PlatformMenuDivider, PlatformProvidedMenuItem.
// Stateless only; top-level ValueNotifiers hold mutable state.
// Entry point: dynamic build(BuildContext context).

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// Top-level ValueNotifiers — no StatefulWidget allowed.
// ============================================================================

/// Log of onSelected events from PlatformMenuItem callbacks.
final ValueNotifier<List<String>> menuLog = ValueNotifier<List<String>>(
  <String>['(no menu item selected yet)'],
);

/// Which simulated macOS top-level menu is open: null = all closed.
final ValueNotifier<String?> openMenu = ValueNotifier<String?>(null);

/// Checked state for the "Show Toolbar" demo item.
final ValueNotifier<bool> toolbarChecked = ValueNotifier<bool>(true);

/// Checked state for the "Show Sidebar" demo item.
final ValueNotifier<bool> sidebarChecked = ValueNotifier<bool>(false);

/// Counter incremented by the simulated "New Window" shortcut demo.
final ValueNotifier<int> newWindowCount = ValueNotifier<int>(0);

// ============================================================================
// Logging helpers.
// ============================================================================

void _log(String line) {
  final List<String> next = <String>[
    '${_timestamp()} $line',
    ...menuLog.value,
  ];
  menuLog.value = next.length > 18 ? next.sublist(0, 18) : next;
}

String _timestamp() {
  final DateTime now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:'
      '${now.minute.toString().padLeft(2, '0')}:'
      '${now.second.toString().padLeft(2, '0')}';
}

// ============================================================================
// Entry point.
// ============================================================================

dynamic build(BuildContext context) {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1565C0),
    brightness: Brightness.light,
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorScheme: scheme),
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Platform Menu Widgets'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'Hero'),
              Tab(icon: Icon(Icons.menu_open), text: 'PlatformMenuBar'),
              Tab(icon: Icon(Icons.desktop_mac_outlined), text: 'Simulated'),
              Tab(icon: Icon(Icons.list_alt_outlined), text: 'Item variants'),
              Tab(icon: Icon(Icons.horizontal_rule), text: 'Dividers'),
              Tab(icon: Icon(Icons.system_update_alt), text: 'Provided'),
              Tab(icon: Icon(Icons.keyboard_outlined), text: 'Shortcuts'),
              Tab(icon: Icon(Icons.compare_arrows), text: 'Platforms'),
              Tab(icon: Icon(Icons.warning_amber_outlined), text: 'Pitfalls'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _PlatformMenuBarTab(),
            _SimulatedMacOSTab(),
            _ItemVariantsTab(),
            _DividersTab(),
            _ProvidedItemsTab(),
            _ShortcutsTab(),
            _PlatformSupportTab(),
            _PitfallsTab(),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Shared visual primitives.
// ============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: cs.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                if (subtitle != null) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
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

class _CodeChip extends StatelessWidget {
  const _CodeChip(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontFamily: 'monospace',
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body, this.color});
  final String title;
  final String body;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final Color bg = color ?? cs.surfaceContainerLow;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: bg,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow({required this.name, required this.type, required this.desc});
  final String name;
  final String type;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _CodeChip(name),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 2,
            child: Text(
              type,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: cs.tertiary,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              desc,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Tab 1 — Hero banner.
// ============================================================================

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── Hero gradient banner ──
          Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  cs.primary,
                  cs.tertiary,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.menu_open, size: 40, color: cs.onPrimary),
                  const SizedBox(height: 10),
                  Text(
                    'Platform Menu Widgets',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Native macOS menu bar integration from Flutter',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: cs.onPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── What are platform menus? ──
          const _SectionHeader(
            icon: Icons.help_outline,
            title: 'What are Platform Menu Widgets?',
            subtitle: 'Flutter communicates structured menus to the host OS',
          ),

          _InfoCard(
            title: 'Native menu bar integration',
            body:
                'On macOS every app has a system menu bar at the very top of the '
                'screen — outside the Flutter window. PlatformMenuBar lets Flutter '
                'describe menus declaratively in Dart; the framework serialises them '
                'to the platform channel, and macOS renders them natively.\n\n'
                'On Windows / Linux / iOS / Android, PlatformMenuBar is a no-op: '
                'the child is rendered and the menus are silently ignored.',
          ),

          _InfoCard(
            title: 'Why not a Flutter-drawn menu bar?',
            body:
                'Native menus respect the OS appearance (dark mode, accent colour, '
                'font sizing, accessibility), appear in the correct z-order above '
                'every window, and integrate with system shortcut registration. '
                'Flutter-drawn menus cannot appear outside the app window and do not '
                'receive the same OS-level shortcut dispatch.',
          ),

          const SizedBox(height: 12),

          // ── Widget family overview ──
          const _SectionHeader(
            icon: Icons.account_tree_outlined,
            title: 'Widget family',
            subtitle: 'Five classes form the complete API',
          ),

          _buildFamilyTable(context, cs),

          const SizedBox(height: 12),

          // ── Architecture diagram ──
          const _SectionHeader(
            icon: Icons.architecture,
            title: 'Architecture overview',
            subtitle: 'How Flutter menus reach the macOS menu bar',
          ),

          _buildArchDiagram(context, cs),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFamilyTable(BuildContext context, ColorScheme cs) {
    const List<(String, String, String)> rows = <(String, String, String)>[
      (
        'PlatformMenuBar',
        'Widget',
        'Root host; connects Flutter to the platform menu delegate',
      ),
      ('PlatformMenu', 'PlatformMenuItem', 'A top-level menu with a label and child items'),
      ('PlatformMenuItem', 'PlatformMenuItem', 'A single clickable/shortcut item'),
      ('PlatformMenuDivider', 'PlatformMenuItem', 'Horizontal separator between items'),
      (
        'PlatformProvidedMenuItem',
        'PlatformMenuItem',
        'OS-built-in item (About, Quit, Hide…)',
      ),
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: <Widget>[
          Container(
            color: cs.primaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    'Class',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Extends',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    'Purpose',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...rows.map(((String, String, String) r) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 4, child: _CodeChip(r.$1)),
                  const SizedBox(width: 4),
                  Expanded(
                    flex: 4,
                    child: Text(
                      r.$2,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontFamily: 'monospace',
                        color: cs.tertiary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      r.$3,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildArchDiagram(BuildContext context, ColorScheme cs) {
    const List<String> steps = <String>[
      '1  Flutter Dart code declares\n   PlatformMenuBar( menus: [...] )',
      '2  DefaultPlatformMenuDelegate serialises\n   the tree to channel messages',
      '3  MethodChannel "flutter/menu"\n   sends JSON to the platform embedder',
      '4  macOS AppKit reads the JSON\n   and builds NSMenu / NSMenuItem objects',
      '5  macOS renders the native menu bar\n   at the top of the screen',
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: steps.indexed
              .map(((int, String) pair) {
                final int idx = pair.$1;
                final String label = pair.$2;
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: cs.primary,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${idx + 1}',
                            style: TextStyle(
                              color: cs.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            label,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    if (idx < steps.length - 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            color: cs.outlineVariant,
                            width: 2,
                          ),
                        ),
                      ),
                  ],
                );
              })
              .toList(),
        ),
      ),
    );
  }
}

// ============================================================================
// Tab 2 — Real PlatformMenuBar instantiation.
// ============================================================================

class _PlatformMenuBarTab extends StatelessWidget {
  const _PlatformMenuBarTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    // Build the actual PlatformMenuBar.  On non-macOS platforms this is a
    // no-op (the menus are not shown) but the widget tree is valid Dart.
    // PlatformMenuItemGroup wraps items and adds automatic separator lines
    // around the group — this is the Flutter 3.x replacement for the
    // removed PlatformMenuDivider class.
    final Widget platformMenuBar = PlatformMenuBar(
      menus: <PlatformMenuItem>[
        PlatformMenu(
          label: 'File',
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'New',
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyN, meta: true),
                  onSelected: () => _log('File > New'),
                ),
                PlatformMenuItem(
                  label: 'Open…',
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyO, meta: true),
                  onSelected: () => _log('File > Open…'),
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'Save',
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyS, meta: true),
                  onSelected: () => _log('File > Save'),
                ),
                PlatformMenuItem(
                  label: 'Save As…',
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyS,
                    meta: true,
                    shift: true,
                  ),
                  onSelected: () => _log('File > Save As…'),
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'Close Window',
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyW, meta: true),
                  onSelected: () => _log('File > Close Window'),
                ),
              ],
            ),
          ],
        ),
        PlatformMenu(
          label: 'Edit',
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'Undo',
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, meta: true),
                  onSelected: () => _log('Edit > Undo'),
                ),
                PlatformMenuItem(
                  label: 'Redo',
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyZ,
                    meta: true,
                    shift: true,
                  ),
                  onSelected: () => _log('Edit > Redo'),
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'Cut',
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyX, meta: true),
                  onSelected: () => _log('Edit > Cut'),
                ),
                PlatformMenuItem(
                  label: 'Copy',
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyC, meta: true),
                  onSelected: () => _log('Edit > Copy'),
                ),
                PlatformMenuItem(
                  label: 'Paste',
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyV, meta: true),
                  onSelected: () => _log('Edit > Paste'),
                ),
              ],
            ),
          ],
        ),
        PlatformMenu(
          label: 'View',
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'Zoom In',
                  shortcut: const SingleActivator(LogicalKeyboardKey.equal, meta: true),
                  onSelected: () => _log('View > Zoom In'),
                ),
                PlatformMenuItem(
                  label: 'Zoom Out',
                  shortcut: const SingleActivator(LogicalKeyboardKey.minus, meta: true),
                  onSelected: () => _log('View > Zoom Out'),
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'Enter Full Screen',
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyF,
                    meta: true,
                    control: true,
                  ),
                  onSelected: () => _log('View > Enter Full Screen'),
                ),
              ],
            ),
          ],
        ),
      ],
      child: const SizedBox.shrink(),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            icon: Icons.menu_open,
            title: 'Real PlatformMenuBar',
            subtitle: 'Actual widget instantiation — menus active on macOS',
          ),

          // Mount the actual PlatformMenuBar so the API is truly exercised.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: platformMenuBar,
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: cs.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.check_circle_outline, color: cs.primary, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'PlatformMenuBar is mounted above',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'On macOS the "File", "Edit", and "View" menus appear in the '
                    'system menu bar. On other platforms the widget is a no-op. '
                    'Tap any item on macOS to see the log below update.',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Dart source ──
          const _SectionHeader(
            icon: Icons.code,
            title: 'Constructor signature',
            subtitle: 'PlatformMenuBar({ required menus, required child })',
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: cs.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _codeBlock(
                    context,
                    cs,
                    '''PlatformMenuBar(
  menus: <PlatformMenuItem>[
    PlatformMenu(
      label: 'File',
      menus: <PlatformMenuItem>[
        PlatformMenuItem(
          label: 'New',
          shortcut: SingleActivator(
            LogicalKeyboardKey.keyN, meta: true),
          onSelected: () { /* handle */ },
        ),
        const PlatformMenuDivider(),
        PlatformMenuItem(label: 'Close', ...),
      ],
    ),
  ],
  child: myScaffold,
)''',
                  ),
                ],
              ),
            ),
          ),

          // ── Properties ──
          const _SectionHeader(
            icon: Icons.settings_outlined,
            title: 'PlatformMenuBar properties',
          ),

          const _PropRow(
            name: 'menus',
            type: 'List<PlatformMenuItem>',
            desc: 'Top-level menu items (usually PlatformMenu instances)',
          ),
          const _PropRow(
            name: 'child',
            type: 'Widget',
            desc:
                'The Flutter UI rendered below the menu bar; not the menu content',
          ),
          const _PropRow(
            name: 'focusNode',
            type: 'FocusNode?',
            desc: 'Optional focus node to receive keyboard shortcuts',
          ),

          // ── Event log ──
          const _SectionHeader(
            icon: Icons.receipt_long_outlined,
            title: 'onSelected event log',
            subtitle: 'Updated when a menu item fires its callback',
          ),

          ValueListenableBuilder<List<String>>(
            valueListenable: menuLog,
            builder: (BuildContext ctx, List<String> lines, _) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                color: cs.surfaceContainerLowest,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.fiber_manual_record,
                              size: 10, color: cs.error),
                          const SizedBox(width: 6),
                          Text(
                            'Live log',
                            style: Theme.of(ctx).textTheme.labelMedium!.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () =>
                                menuLog.value = <String>['(cleared)'],
                            icon: const Icon(Icons.delete_outline, size: 16),
                            label: const Text('Clear'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A2E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: lines.length,
                          itemBuilder: (BuildContext c, int i) {
                            return Text(
                              lines[i],
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: Color(0xFF00FF41),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _codeBlock(BuildContext context, ColorScheme cs, String code) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: Color(0xFF90CAF9),
        ),
      ),
    );
  }
}

// ============================================================================
// Tab 3 — Simulated macOS menu bar (CustomPainter + Widgets).
// ============================================================================

class _SimulatedMacOSTab extends StatelessWidget {
  const _SimulatedMacOSTab();

  static const List<String> _menuLabels = <String>[
    'File',
    'Edit',
    'View',
    'Window',
    'Help',
  ];

  static const Map<String, List<String>> _menuItems = <String, List<String>>{
    'File': <String>[
      'New',
      '---',
      'Open…',
      'Open Recent',
      '---',
      'Close',
      'Save',
      'Save As…',
      '---',
      'Print…',
    ],
    'Edit': <String>[
      'Undo',
      'Redo',
      '---',
      'Cut',
      'Copy',
      'Paste',
      'Select All',
    ],
    'View': <String>[
      'Show Toolbar',
      'Show Sidebar',
      '---',
      'Zoom In',
      'Zoom Out',
      'Actual Size',
      '---',
      'Enter Full Screen',
    ],
    'Window': <String>[
      'Minimise',
      'Zoom',
      '---',
      'Move to iPad',
      'Merge All Windows',
    ],
    'Help': <String>['Search', '---', 'Flutter Help', 'Report a Bug…'],
  };

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            icon: Icons.desktop_mac_outlined,
            title: 'Simulated macOS menu bar',
            subtitle:
                'Flutter-drawn reproduction using CustomPainter + Widgets',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Because PlatformMenuBar renders natively only on macOS, this tab '
              'provides a pixel-faithful Flutter simulation of the macOS menu bar '
              'using a Stack/CustomPainter so you can see what native menus look '
              'like on any platform.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          // ── macOS desktop simulation ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E8E8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC0C0C0)),
                ),
                child: Column(
                  children: <Widget>[
                    // Traffic lights bar
                    Container(
                      height: 28,
                      color: const Color(0xFFD0D0D0),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          _MacTrafficLight(color: const Color(0xFFFF5F56)),
                          const SizedBox(width: 6),
                          _MacTrafficLight(color: const Color(0xFFFFBD2E)),
                          const SizedBox(width: 6),
                          _MacTrafficLight(color: const Color(0xFF27C93F)),
                          const Spacer(),
                          Text(
                            'My Flutter App',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: const Color(0xFF505050),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),

                    // macOS menu bar strip
                    ValueListenableBuilder<String?>(
                      valueListenable: openMenu,
                      builder: (BuildContext ctx, String? open, _) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            // The grey strip
                            Container(
                              height: 24,
                              color: const Color(0xFFF0F0F0),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 8),
                                  // Apple logo placeholder
                                  const Icon(
                                    Icons.apple,
                                    size: 16,
                                    color: Color(0xFF333333),
                                  ),
                                  const SizedBox(width: 12),
                                  // Bold app name
                                  Text(
                                    'MyApp',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF111111),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Menu labels
                                  ..._menuLabels.map((String label) {
                                    final bool isOpen = open == label;
                                    return GestureDetector(
                                      onTap: () {
                                        openMenu.value =
                                            isOpen ? null : label;
                                        _log('Tapped $label menu');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isOpen
                                              ? const Color(0xFF3478F6)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          label,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isOpen
                                                ? Colors.white
                                                : const Color(0xFF111111),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),

                            // Dropdown panel when a menu is open
                            if (open != null)
                              Positioned(
                                top: 24,
                                left: _dropdownLeft(open),
                                child: _MacDropdown(
                                  items: _menuItems[open] ?? <String>[],
                                  onClose: () => openMenu.value = null,
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    // Fake window content area
                    Container(
                      height: 200,
                      color: const Color(0xFFFAFAFA),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.widgets_outlined,
                              size: 48,
                              color: cs.outlineVariant,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Flutter app content area',
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(color: cs.outlineVariant),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tap menu labels above to open',
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(color: cs.outlineVariant),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ── Log ──
          ValueListenableBuilder<List<String>>(
            valueListenable: menuLog,
            builder: (BuildContext ctx, List<String> lines, _) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                color: cs.surfaceContainerLowest,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Interaction log',
                        style: Theme.of(ctx).textTheme.labelMedium!.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...lines.take(6).map(
                            (String l) => Text(
                              l,
                              style: Theme.of(ctx).textTheme.bodySmall!.copyWith(
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              );
            },
          ),

          // ── Implementation notes ──
          const _SectionHeader(
            icon: Icons.tips_and_updates_outlined,
            title: 'Simulation notes',
            subtitle: 'How this widget reproduces the macOS look',
          ),

          _InfoCard(
            title: 'Menu bar strip',
            body:
                'A Container with height 24 and color #F0F0F0 mimics the macOS '
                'Ventura / Sonoma menu bar. Items are GestureDetector-wrapped Text '
                'widgets with a blue highlight (#3478F6) when active.',
          ),

          _InfoCard(
            title: 'Dropdown panel',
            body:
                'A Positioned widget overlaid via Stack renders the dropdown. Each '
                'item is either a menu entry or a PlatformMenuDivider-equivalent '
                'horizontal rule. Items log their label on tap.',
          ),

          _InfoCard(
            title: 'ValueNotifier for open state',
            body:
                'openMenu (a ValueNotifier<String?>) tracks which menu is open. '
                'ValueListenableBuilder rebuilds only the Stack when it changes — '
                'no StatefulWidget needed.',
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  double _dropdownLeft(String menu) {
    final Map<String, double> offsets = <String, double>{
      'File': 55,
      'Edit': 95,
      'View': 130,
      'Window': 165,
      'Help': 218,
    };
    return offsets[menu] ?? 55;
  }
}

class _MacTrafficLight extends StatelessWidget {
  const _MacTrafficLight({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.6), width: 0.5),
      ),
    );
  }
}

class _MacDropdown extends StatelessWidget {
  const _MacDropdown({required this.items, required this.onClose});
  final List<String> items;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(6),
      color: const Color(0xFFF5F5F5),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: items.map((String item) {
            if (item == '---') {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Divider(height: 1, thickness: 1, color: Color(0xFFD0D0D0)),
              );
            }
            return GestureDetector(
              onTap: () {
                _log('Selected: $item');
                onClose();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ============================================================================
// Tab 4 — PlatformMenuItem variants.
// ============================================================================

class _ItemVariantsTab extends StatelessWidget {
  const _ItemVariantsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            icon: Icons.list_alt_outlined,
            title: 'PlatformMenuItem variants',
            subtitle: '5 cards demonstrating distinct configurations',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'PlatformMenuItem is the leaf node of a platform menu tree. Each '
              'configuration below shows a different use-case.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 8),

          // Card 1 — Basic item
          _VariantCard(
            cs: cs,
            tag: '1',
            tagColor: cs.primary,
            title: 'Basic item',
            subtitle: 'Label + onSelected callback',
            codeSnippet: '''PlatformMenuItem(
  label: 'New File',
  onSelected: () { /* open new file */ },
)''',
            child: _SimulatedMenuItem(
              label: 'New File',
              onTap: () => _log('Basic: New File'),
            ),
          ),

          const SizedBox(height: 8),

          // Card 2 — Item with shortcut
          _VariantCard(
            cs: cs,
            tag: '2',
            tagColor: cs.secondary,
            title: 'Item with shortcut',
            subtitle: 'SingleActivator registers the OS-level shortcut',
            codeSnippet: '''PlatformMenuItem(
  label: 'Save',
  shortcut: SingleActivator(
    LogicalKeyboardKey.keyS,
    meta: true,
  ),
  onSelected: () { /* save */ },
)''',
            child: _SimulatedMenuItem(
              label: 'Save',
              shortcut: '⌘ S',
              onTap: () => _log('Shortcut: Save'),
            ),
          ),

          const SizedBox(height: 8),

          // Card 3 — Disabled item
          _VariantCard(
            cs: cs,
            tag: '3',
            tagColor: cs.tertiary,
            title: 'Disabled item',
            subtitle: 'Pass onSelected: null to disable',
            codeSnippet: '''PlatformMenuItem(
  label: 'Publish',
  onSelected: null,   // null = disabled
)''',
            child: _SimulatedMenuItem(
              label: 'Publish',
              disabled: true,
              onTap: () {},
            ),
          ),

          const SizedBox(height: 8),

          // Card 4 — Checked item
          _VariantCard(
            cs: cs,
            tag: '4',
            tagColor: const Color(0xFF00796B),
            title: 'Checked state item',
            subtitle: 'Toggleable preference, tracked via ValueNotifier',
            codeSnippet: '''// top-level
final checkedNotifier = ValueNotifier<bool>(true);

// In menu:
ValueListenableBuilder<bool>(
  valueListenable: checkedNotifier,
  builder: (ctx, checked, _) {
    return PlatformMenuItem(
      label: checked
          ? '✓ Show Toolbar'
          : '  Show Toolbar',
      onSelected: () {
        checkedNotifier.value = !checkedNotifier.value;
      },
    );
  },
)''',
            child: ValueListenableBuilder<bool>(
              valueListenable: toolbarChecked,
              builder: (BuildContext ctx, bool checked, _) {
                return _SimulatedMenuItem(
                  label: 'Show Toolbar',
                  checkmark: checked,
                  onTap: () {
                    toolbarChecked.value = !toolbarChecked.value;
                    _log('Toggle Toolbar: ${!checked}');
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Card 5 — Destructive item
          _VariantCard(
            cs: cs,
            tag: '5',
            tagColor: cs.error,
            title: 'Destructive item',
            subtitle:
                'Rendered in red text (macOS convention for dangerous actions)',
            codeSnippet: '''// Use a custom label with ANSI colour on macOS,
// or simulate with red text in the Flutter UI.
PlatformMenuItem(
  label: 'Delete Project…',
  onSelected: () { /* confirm then delete */ },
)
// Note: PlatformMenuItem has no built-in
// "destructive" flag — the red colour is
// a macOS convention applied by the OS when
// the item label follows certain patterns.''',
            child: _SimulatedMenuItem(
              label: 'Delete Project…',
              destructive: true,
              onTap: () => _log('Destructive: Delete Project…'),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _VariantCard extends StatelessWidget {
  const _VariantCard({
    required this.cs,
    required this.tag,
    required this.tagColor,
    required this.title,
    required this.subtitle,
    required this.codeSnippet,
    required this.child,
  });

  final ColorScheme cs;
  final String tag;
  final Color tagColor;
  final String title;
  final String subtitle;
  final String codeSnippet;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: tagColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Live preview
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFD0D0D0)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: child,
            ),

            const SizedBox(height: 10),

            // Code snippet
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                codeSnippet,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF90CAF9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimulatedMenuItem extends StatelessWidget {
  const _SimulatedMenuItem({
    required this.label,
    required this.onTap,
    this.shortcut,
    this.disabled = false,
    this.checkmark = false,
    this.destructive = false,
  });

  final String label;
  final VoidCallback onTap;
  final String? shortcut;
  final bool disabled;
  final bool checkmark;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final Color textColor = disabled
        ? const Color(0xFFAAAAAA)
        : destructive
            ? const Color(0xFFCC0000)
            : const Color(0xFF111111);

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 18,
              child: checkmark
                  ? const Icon(Icons.check, size: 14, color: Color(0xFF111111))
                  : null,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 13, color: textColor),
              ),
            ),
            if (shortcut != null)
              Text(
                shortcut!,
                style: TextStyle(
                  fontSize: 12,
                  color: disabled ? const Color(0xFFAAAAAA) : const Color(0xFF666666),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Tab 5 — PlatformMenuDivider.
// ============================================================================

class _DividersTab extends StatelessWidget {
  const _DividersTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            icon: Icons.horizontal_rule,
            title: 'PlatformMenuDivider',
            subtitle: 'Visual separator for grouping related menu items',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'PlatformMenuDivider is the simplest of the platform menu widgets: '
              'a horizontal rule that visually separates groups of related items '
              'within a PlatformMenu. It has no constructor parameters.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 8),

          // ── Constructor ──
          const _SectionHeader(
            icon: Icons.code,
            title: 'Constructor',
            subtitle: 'const PlatformMenuDivider() — zero parameters',
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: const Color(0xFF1A1A2E),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                '''class PlatformMenuDivider extends PlatformMenuItem {
  const PlatformMenuDivider();

  @override
  Iterable<Map<String, Object?>> toChannelRepresentation(
    PlatformMenuDelegate delegate,
    {required MenuItemSerializableIdGenerator getId}) {
      return <Map<String, Object?>>[
        <String, Object?>{
          'isDivider': true,
        },
      ];
    }
}''',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF90CAF9),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ── Visual demo: menu with dividers ──
          const _SectionHeader(
            icon: Icons.preview_outlined,
            title: 'Live preview',
            subtitle: 'Simulated dropdown showing divider placement',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: <Widget>[
                // Simulated dropdown
                Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF5F5F5),
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildGroup(
                          context,
                          cs,
                          'GROUP A — File operations',
                          <String>['New', 'New Window', 'New Tab'],
                        ),
                        _buildDivider(),
                        _buildGroup(
                          context,
                          cs,
                          'GROUP B — Open',
                          <String>['Open…', 'Open Recent'],
                        ),
                        _buildDivider(),
                        _buildGroup(
                          context,
                          cs,
                          'GROUP C — Save',
                          <String>['Save', 'Save As…', 'Revert to Saved'],
                        ),
                        _buildDivider(),
                        _buildGroup(
                          context,
                          cs,
                          'GROUP D — Print',
                          <String>['Page Setup…', 'Print…'],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Annotation column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _annotationBadge(
                        context,
                        cs,
                        'PlatformMenuDivider',
                        'Separates Groups A and B',
                      ),
                      const SizedBox(height: 10),
                      _annotationBadge(
                        context,
                        cs,
                        'PlatformMenuDivider',
                        'Separates Groups B and C',
                      ),
                      const SizedBox(height: 10),
                      _annotationBadge(
                        context,
                        cs,
                        'PlatformMenuDivider',
                        'Separates Groups C and D',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Dart source for the above ──
          const _SectionHeader(
            icon: Icons.code,
            title: 'Dart code for the preview above',
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: const Color(0xFF1A1A2E),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                '''PlatformMenu(
  label: 'File',
  menus: <PlatformMenuItem>[
    // Group A
    PlatformMenuItem(label: 'New',         onSelected: () {}),
    PlatformMenuItem(label: 'New Window',  onSelected: () {}),
    PlatformMenuItem(label: 'New Tab',     onSelected: () {}),

    const PlatformMenuDivider(),  // ← divider

    // Group B
    PlatformMenuItem(label: 'Open…',       onSelected: () {}),
    PlatformMenuItem(label: 'Open Recent', onSelected: () {}),

    const PlatformMenuDivider(),  // ← divider

    // Group C
    PlatformMenuItem(label: 'Save',        onSelected: () {}),
    PlatformMenuItem(label: 'Save As…',    onSelected: () {}),

    const PlatformMenuDivider(),  // ← divider

    // Group D
    PlatformMenuItem(label: 'Print…',      onSelected: () {}),
  ],
)''',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF90CAF9),
                ),
              ),
            ),
          ),

          // ── Best practices ──
          const _SectionHeader(
            icon: Icons.tips_and_updates_outlined,
            title: 'Best practices',
          ),

          _InfoCard(
            title: 'Group semantically related items',
            body:
                'Use dividers to separate groups that belong to different conceptual '
                'categories: file lifecycle (New/Open/Close), saving, import/export, '
                'and printing. This matches the macOS HIG conventions.',
          ),

          _InfoCard(
            title: 'Never start or end with a divider',
            body:
                'A PlatformMenuDivider at the very start or end of a menu is hidden '
                'automatically by macOS. Still, avoid them at boundaries to prevent '
                'confusion across platforms.',
          ),

          _InfoCard(
            title: 'Consecutive dividers are collapsed',
            body:
                'macOS automatically hides consecutive dividers, showing only one. '
                'If a whole group becomes empty (e.g. all items are conditionally '
                'removed), the surrounding dividers collapse.',
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildGroup(
    BuildContext context,
    ColorScheme cs,
    String groupLabel,
    List<String> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 18, top: 4, bottom: 1),
          child: Text(
            groupLabel,
            style: TextStyle(
              fontSize: 9,
              color: cs.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items.map(
          (String item) => GestureDetector(
            onTap: () => _log('Divider demo: $item'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: Text(item, style: const TextStyle(fontSize: 13)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Divider(height: 1, thickness: 1, color: Color(0xFFD0D0D0)),
    );
  }

  Widget _annotationBadge(
    BuildContext context,
    ColorScheme cs,
    String label,
    String desc,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.tertiary.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _CodeChip(label),
          const SizedBox(height: 4),
          Text(
            desc,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: cs.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Tab 6 — PlatformProvidedMenuItem types.
// ============================================================================

class _ProvidedItemsTab extends StatelessWidget {
  const _ProvidedItemsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    const List<(String, String, String)> types = <(String, String, String)>[
      (
        'about',
        'About MyApp',
        'Displays the standard macOS About panel with app name, version, icon.',
      ),
      (
        'quit',
        'Quit MyApp ⌘Q',
        'Terminates the application. macOS adds the shortcut automatically.',
      ),
      (
        'hide',
        'Hide MyApp ⌘H',
        'Hides all windows of the app. Equivalent to clicking the yellow traffic light.',
      ),
      (
        'hideOtherApplications',
        'Hide Others ⌥⌘H',
        'Hides all windows of every other app, leaving only this app visible.',
      ),
      (
        'showAllApplications',
        'Show All',
        'Reveals all hidden app windows. Typically follows Hide Others.',
      ),
      (
        'separator',
        '— (divider) —',
        'A platform-provided separator, identical in appearance to PlatformMenuDivider.',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            icon: Icons.system_update_alt,
            title: 'PlatformProvidedMenuItem',
            subtitle:
                'Built-in OS menu items — label, shortcut, action supplied by macOS',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Unlike PlatformMenuItem where you supply the label and callback, '
              'PlatformProvidedMenuItem delegates everything to the OS. '
              'You specify only the type enum value. The OS knows the label '
              '(localised!), the shortcut, and what the action does.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 8),

          // ── Constructor ──
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: const Color(0xFF1A1A2E),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                '''PlatformProvidedMenuItem(
  type: PlatformProvidedMenuItemType.about,
  enabled: true,   // optional, defaults to true
)''',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF90CAF9),
                ),
              ),
            ),
          ),

          // ── Type gallery ──
          const _SectionHeader(
            icon: Icons.grid_view_outlined,
            title: 'Type enum gallery',
            subtitle: 'All PlatformProvidedMenuItemType values',
          ),

          ...types.map(((String, String, String) t) {
            return _ProvidedTypeCard(
              cs: cs,
              typeName: t.$1,
              macosLabel: t.$2,
              description: t.$3,
            );
          }),

          const SizedBox(height: 12),

          // ── hasMenu() ──
          const _SectionHeader(
            icon: Icons.device_unknown_outlined,
            title: 'PlatformProvidedMenuItem.hasMenu()',
            subtitle: 'Check if the current platform supports a type',
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: const Color(0xFF1A1A2E),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                '''// Guard before using a provided item:
if (PlatformProvidedMenuItem.hasMenu(
      PlatformProvidedMenuItemType.about)) {
  // Safe to add the About item
}

// Returns true only on macOS (currently).
// On all other platforms it returns false.''',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF90CAF9),
                ),
              ),
            ),
          ),

          // ── Simulated macOS App menu ──
          const _SectionHeader(
            icon: Icons.apple,
            title: 'Simulated macOS Apple menu',
            subtitle:
                'Where PlatformProvidedMenuItem items typically appear in practice',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFF5F5F5),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _providedItem(context, cs, 'About MyApp', false),
                    _menuDivider(),
                    _providedItem(context, cs, 'Preferences…', false),
                    _menuDivider(),
                    _providedItem(context, cs, 'Hide MyApp', false, shortcut: '⌘H'),
                    _providedItem(context, cs, 'Hide Others', false, shortcut: '⌥⌘H'),
                    _providedItem(context, cs, 'Show All', false),
                    _menuDivider(),
                    _providedItem(context, cs, 'Quit MyApp', false, shortcut: '⌘Q'),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _providedItem(
    BuildContext context,
    ColorScheme cs,
    String label,
    bool disabled, {
    String? shortcut,
  }) {
    return GestureDetector(
      onTap: disabled ? null : () => _log('Provided: $label'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: disabled ? const Color(0xFFAAAAAA) : const Color(0xFF111111),
                ),
              ),
            ),
            if (shortcut != null)
              Text(
                shortcut,
                style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _menuDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Divider(height: 1, thickness: 1, color: Color(0xFFD0D0D0)),
    );
  }
}

class _ProvidedTypeCard extends StatelessWidget {
  const _ProvidedTypeCard({
    required this.cs,
    required this.typeName,
    required this.macosLabel,
    required this.description,
  });

  final ColorScheme cs;
  final String typeName;
  final String macosLabel;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: cs.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '.$typeName',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontFamily: 'monospace',
                  color: cs.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    macosLabel,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Tab 7 — Shortcut display.
// ============================================================================

class _ShortcutsTab extends StatelessWidget {
  const _ShortcutsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    const List<(String, String, String, String, String)> shortcuts =
        <(String, String, String, String, String)>[
      (
        'New',
        '⌘ N',
        'LogicalKeyboardKey.keyN',
        'meta: true',
        'SingleActivator(LogicalKeyboardKey.keyN, meta: true)',
      ),
      (
        'Save',
        '⌘ S',
        'LogicalKeyboardKey.keyS',
        'meta: true',
        'SingleActivator(LogicalKeyboardKey.keyS, meta: true)',
      ),
      (
        'Undo',
        '⌘ Z',
        'LogicalKeyboardKey.keyZ',
        'meta: true',
        'SingleActivator(LogicalKeyboardKey.keyZ, meta: true)',
      ),
      (
        'Redo',
        '⌘ ⇧ Z',
        'LogicalKeyboardKey.keyZ',
        'meta: true, shift: true',
        'SingleActivator(LogicalKeyboardKey.keyZ,\n  meta: true, shift: true)',
      ),
      (
        'Find',
        '⌘ F',
        'LogicalKeyboardKey.keyF',
        'meta: true',
        'SingleActivator(LogicalKeyboardKey.keyF, meta: true)',
      ),
      (
        'Find Next',
        '⌘ G',
        'LogicalKeyboardKey.keyG',
        'meta: true',
        'SingleActivator(LogicalKeyboardKey.keyG, meta: true)',
      ),
      (
        'Find Previous',
        '⌘ ⇧ G',
        'LogicalKeyboardKey.keyG',
        'meta: true, shift: true',
        'SingleActivator(LogicalKeyboardKey.keyG,\n  meta: true, shift: true)',
      ),
      (
        'Select All',
        '⌘ A',
        'LogicalKeyboardKey.keyA',
        'meta: true',
        'SingleActivator(LogicalKeyboardKey.keyA, meta: true)',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            icon: Icons.keyboard_outlined,
            title: 'Shortcut display',
            subtitle: 'SingleActivator connects keyboard shortcuts to menu items',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'PlatformMenuItem.shortcut accepts a MenuSerializableShortcut, '
              'typically a SingleActivator. The OS registers the shortcut globally '
              'for the app — it fires even when no keyboard focus is in the app.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 8),

          // ── SingleActivator breakdown ──
          const _SectionHeader(
            icon: Icons.construction_outlined,
            title: 'SingleActivator anatomy',
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: const Color(0xFF1A1A2E),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                '''SingleActivator(
  LogicalKeyboardKey.keyS,  // the main key
  meta: true,               // ⌘ Command (macOS) / ❖ Super (Linux)
  control: false,           // ^ Control
  shift: false,             // ⇧ Shift
  alt: false,               // ⌥ Option / Alt
  includeRepeats: true,     // fire on key repeat?
)''',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF90CAF9),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ── Shortcut gallery ──
          const _SectionHeader(
            icon: Icons.grid_view_outlined,
            title: 'Common macOS shortcuts gallery',
          ),

          ...shortcuts.map(((String, String, String, String, String) s) {
            return _ShortcutCard(
              cs: cs,
              label: s.$1,
              display: s.$2,
              key_: s.$3,
              modifiers: s.$4,
              fullCode: s.$5,
            );
          }),

          const SizedBox(height: 12),

          // ── Modifier key reference ──
          const _SectionHeader(
            icon: Icons.table_chart_outlined,
            title: 'Modifier key reference',
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              children: <Widget>[
                _modifierRow(context, cs, 'meta: true', '⌘ Command (macOS)', 'true'),
                _modifierRow(context, cs, 'control: true', '^ Control', 'false'),
                _modifierRow(context, cs, 'shift: true', '⇧ Shift', 'false'),
                _modifierRow(context, cs, 'alt: true', '⌥ Option / Alt', 'false'),
              ],
            ),
          ),

          // ── Platform note ──
          _InfoCard(
            title: 'Shortcut dispatch on non-macOS',
            body:
                'On platforms where PlatformMenuBar is a no-op, shortcuts declared '
                'in PlatformMenuItem are not automatically registered either. '
                'Use Shortcuts + Actions widgets in your Flutter widget tree for '
                'cross-platform keyboard shortcut handling.',
            color: Theme.of(context).colorScheme.errorContainer,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _modifierRow(
    BuildContext context,
    ColorScheme cs,
    String param,
    String meaning,
    String defaultVal,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        children: <Widget>[
          Expanded(flex: 3, child: _CodeChip(param)),
          const SizedBox(width: 6),
          Expanded(
            flex: 4,
            child: Text(meaning, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'default: $defaultVal',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  const _ShortcutCard({
    required this.cs,
    required this.label,
    required this.display,
    required this.key_,
    required this.modifiers,
    required this.fullCode,
  });

  final ColorScheme cs;
  final String label;
  final String display;
  final String key_;
  final String modifiers;
  final String fullCode;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            // Shortcut chip
            Container(
              width: 72,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                display,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    fullCode,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontFamily: 'monospace',
                      color: cs.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Tab 8 — Cross-platform support matrix.
// ============================================================================

class _PlatformSupportTab extends StatelessWidget {
  const _PlatformSupportTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    // Rows: (widget/feature, macOS, Windows, Linux, iOS, Android)
    const List<(String, String, String, String, String, String)> matrix =
        <(String, String, String, String, String, String)>[
      ('PlatformMenuBar', '✅ Native', '🚫 No-op', '🚫 No-op', '🚫 No-op', '🚫 No-op'),
      ('PlatformMenu', '✅ Native', '🚫 No-op', '🚫 No-op', '🚫 No-op', '🚫 No-op'),
      ('PlatformMenuItem', '✅ Native', '🚫 No-op', '🚫 No-op', '🚫 No-op', '🚫 No-op'),
      ('PlatformMenuDivider', '✅ Native', '🚫 No-op', '🚫 No-op', '🚫 No-op', '🚫 No-op'),
      (
        'PlatformProvidedMenuItem',
        '✅ Native',
        '🚫 No-op',
        '🚫 No-op',
        '🚫 No-op',
        '🚫 No-op',
      ),
      ('Shortcut registration', '✅ Global', '🚫 None', '🚫 None', '🚫 None', '🚫 None'),
      ('hasMenu() = true', '✅ Yes', '❌ false', '❌ false', '❌ false', '❌ false'),
      (
        'child rendered',
        '✅ Yes',
        '✅ Yes',
        '✅ Yes',
        '✅ Yes',
        '✅ Yes',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            icon: Icons.compare_arrows,
            title: 'Cross-platform support',
            subtitle: 'Which platforms render native menus vs ignore them',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'As of Flutter 3.x, native platform menu bars are only supported on '
              'macOS. All other platforms accept the PlatformMenuBar widget but '
              'treat it as a transparent pass-through — only the child is rendered.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 8),

          // ── Matrix table ──
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(cs.primaryContainer),
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Feature',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'macOS',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Windows',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Linux',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'iOS',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Android',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ),
                ],
                rows: matrix
                    .map(
                      (
                        (String, String, String, String, String, String) r,
                      ) =>
                          DataRow(
                        cells: <DataCell>[
                          DataCell(_CodeChip(r.$1)),
                          DataCell(Text(r.$2)),
                          DataCell(Text(r.$3)),
                          DataCell(Text(r.$4)),
                          DataCell(Text(r.$5)),
                          DataCell(Text(r.$6)),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          // ── Platform diagram ──
          const _SectionHeader(
            icon: Icons.device_hub_outlined,
            title: 'Platform rendering diagram',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              children: <Widget>[
                _platformRow(context, cs, 'macOS', '✅', true,
                    'PlatformMenuBar → AppKit NSMenu → system menu bar'),
                const SizedBox(height: 8),
                _platformRow(context, cs, 'Windows', '🚫', false,
                    'PlatformMenuBar is a transparent Container — menus ignored'),
                const SizedBox(height: 8),
                _platformRow(context, cs, 'Linux', '🚫', false,
                    'PlatformMenuBar is a transparent Container — menus ignored'),
                const SizedBox(height: 8),
                _platformRow(context, cs, 'iOS', '🚫', false,
                    'No system menu bar concept; PlatformMenuBar = no-op'),
                const SizedBox(height: 8),
                _platformRow(context, cs, 'Android', '🚫', false,
                    'No system menu bar concept; PlatformMenuBar = no-op'),
              ],
            ),
          ),

          // ── Recommendation ──
          _InfoCard(
            title: 'Recommendation for cross-platform apps',
            body:
                'Conditionally build the menu only on macOS using Platform.isMacOS '
                'from dart:io, or check PlatformProvidedMenuItem.hasMenu() before '
                'using provided items. For cross-platform keyboard shortcuts, use the '
                'Shortcuts + Actions widget system in your Flutter tree.',
            color: cs.tertiaryContainer,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _platformRow(
    BuildContext context,
    ColorScheme cs,
    String platform,
    String emoji,
    bool supported,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: supported ? cs.primaryContainer : cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: supported ? cs.primary.withValues(alpha: 0.4) : cs.outlineVariant,
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              platform,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: supported ? cs.onPrimaryContainer : cs.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: supported ? cs.onPrimaryContainer : cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Tab 9 — Pitfalls.
// ============================================================================

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            icon: Icons.warning_amber_outlined,
            title: 'Common pitfalls',
            subtitle: '3 gotchas developers hit when using platform menus',
          ),

          const SizedBox(height: 8),

          // ── Pitfall 1 ──
          _PitfallCard(
            cs: cs,
            number: '1',
            color: cs.error,
            title: 'Menus only render on macOS',
            symptom:
                'You add PlatformMenuBar and menus, deploy to Windows or '
                'Android, and see no menu bar at all — not even an error.',
            explanation:
                'PlatformMenuBar silently becomes a no-op on non-macOS '
                'platforms. The child widget is rendered normally, but the '
                'menus list is completely ignored. There is no warning or '
                'assertion to alert you.',
            fix: '''// Option 1: guard with Platform check
import 'dart:io' show Platform;

final Widget menuBar = Platform.isMacOS
    ? PlatformMenuBar(menus: myMenus, child: child)
    : child;

// Option 2: always use PlatformMenuBar —
// it is safe but menus are invisible on non-macOS.
// Use Shortcuts + Actions for cross-platform shortcuts.''',
          ),

          const SizedBox(height: 8),

          // ── Pitfall 2 ──
          _PitfallCard(
            cs: cs,
            number: '2',
            color: cs.tertiary,
            title: 'Hot reload does not re-register menus',
            symptom:
                'You change menu labels or add new items during development, '
                'hot-reload, but the macOS menu bar still shows the old menus.',
            explanation:
                'PlatformMenuBar registers menus with the platform during its '
                'lifecycle. Hot reload preserves widget state and may not fully '
                're-trigger the registration path. Menus are a stateful side-effect '
                'outside Flutter\'s widget tree.',
            fix: '''// Use hot restart (⇧⌘R or Shift+R in the CLI)
// rather than hot reload (⌘R or r) when iterating
// on menu structure changes.

// In development, wrap menu configuration in a
// ValueNotifier and rebuild PlatformMenuBar on
// notifier changes to force re-registration.''',
          ),

          const SizedBox(height: 8),

          // ── Pitfall 3 ──
          _PitfallCard(
            cs: cs,
            number: '3',
            color: const Color(0xFF6A1B9A),
            title: 'PlatformMenuItem enabled vs onSelected: null',
            symptom:
                'You want to disable a menu item but setting enabled: false '
                'has no effect — or you cannot find the enabled property at all.',
            explanation:
                'PlatformMenuItem does not have an enabled property. The item '
                'is enabled when onSelected is a non-null callback, and disabled '
                'when onSelected is null. This is different from PlatformProvidedMenuItem '
                'which does have an explicit enabled property.',
            fix: '''// WRONG — PlatformMenuItem has no .enabled property:
// PlatformMenuItem(label: 'Save', enabled: false, ...)

// CORRECT — pass null for onSelected to disable:
PlatformMenuItem(
  label: 'Save',
  onSelected: canSave ? () { /* save */ } : null,
)

// PlatformProvidedMenuItem DOES have enabled:
PlatformProvidedMenuItem(
  type: PlatformProvidedMenuItemType.quit,
  enabled: false, // this works here
)''',
          ),

          const SizedBox(height: 24),

          // ── API cheat sheet ──
          const _SectionHeader(
            icon: Icons.summarize_outlined,
            title: 'API cheat sheet',
            subtitle: 'All 5 classes and their key properties at a glance',
          ),

          _buildCheatSheet(context, cs),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCheatSheet(BuildContext context, ColorScheme cs) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cheatEntry(
              context,
              cs,
              'PlatformMenuBar',
              <(String, String)>[
                ('menus', 'List<PlatformMenuItem> — top-level menus'),
                ('child', 'Widget — Flutter UI content'),
                ('focusNode', 'FocusNode? — optional keyboard focus'),
              ],
            ),
            const SizedBox(height: 10),
            _cheatEntry(
              context,
              cs,
              'PlatformMenu',
              <(String, String)>[
                ('label', 'String — menu title in the menu bar'),
                ('menus', 'List<PlatformMenuItem> — child items'),
                ('onOpen', 'VoidCallback? — called when menu opens'),
                ('onClose', 'VoidCallback? — called when menu closes'),
              ],
            ),
            const SizedBox(height: 10),
            _cheatEntry(
              context,
              cs,
              'PlatformMenuItem',
              <(String, String)>[
                ('label', 'String — item text'),
                ('shortcut', 'MenuSerializableShortcut? — keyboard shortcut'),
                ('onSelected', 'VoidCallback? — null = disabled'),
                ('onSelectedIntent', 'Intent? — alternative to onSelected'),
              ],
            ),
            const SizedBox(height: 10),
            _cheatEntry(
              context,
              cs,
              'PlatformMenuDivider',
              <(String, String)>[
                ('(none)', 'const constructor — no properties'),
              ],
            ),
            const SizedBox(height: 10),
            _cheatEntry(
              context,
              cs,
              'PlatformProvidedMenuItem',
              <(String, String)>[
                ('type', 'PlatformProvidedMenuItemType — which built-in item'),
                ('enabled', 'bool — whether the item is enabled (default: true)'),
                ('hasMenu()', 'static bool — check platform support'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cheatEntry(
    BuildContext context,
    ColorScheme cs,
    String className,
    List<(String, String)> props,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            className,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontFamily: 'monospace',
              color: cs.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 4),
        ...props.map(((String, String) p) {
          return Padding(
            padding: const EdgeInsets.only(left: 14, top: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.arrow_right, size: 16, color: cs.primary),
                const SizedBox(width: 4),
                _CodeChip(p.$1),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    p.$2,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.cs,
    required this.number,
    required this.color,
    required this.title,
    required this.symptom,
    required this.explanation,
    required this.fix,
  });

  final ColorScheme cs;
  final String number;
  final Color color;
  final String title;
  final String symptom;
  final String explanation;
  final String fix;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _pitfallSection(context, cs, '🐛 Symptom', symptom),
            const SizedBox(height: 8),
            _pitfallSection(context, cs, '🔍 Explanation', explanation),
            const SizedBox(height: 8),
            Text(
              '✅ Fix',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                fix,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF90CAF9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pitfallSection(
    BuildContext context,
    ColorScheme cs,
    String label,
    String body,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(body, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
