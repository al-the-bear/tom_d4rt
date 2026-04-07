// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: Scrollable — the low-level widget that manages scroll gestures,
// scroll position, and drives a Viewport. Every scrollable widget in Flutter
// (ListView, GridView, PageView) has a Scrollable at its core.
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'Scrollable Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.deepPurple,
      brightness: Brightness.light,
      useMaterial3: true,
    ),
    home: const _ScrollableHome(),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Home scaffold
// ═════════════════════════════════════════════════════════════════════
class _ScrollableHome extends StatefulWidget {
  const _ScrollableHome();

  @override
  State<_ScrollableHome> createState() => _ScrollableHomeState();
}

class _ScrollableHomeState extends State<_ScrollableHome>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  static const _tabs = <String>[
    'Concept',
    'Architecture',
    'ScrollPosition',
    'ScrollController',
    'Programmatic Scroll',
    'Multiple Controllers',
    'EnsureVisible',
    'Summary',
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        bottom: TabBar(
          controller: _tabCtrl,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ConceptSection(),
          _ArchitectureSection(),
          _ScrollPositionSection(),
          _ScrollControllerSection(),
          _ProgrammaticScrollSection(),
          _MultipleControllersSection(),
          _EnsureVisibleSection(),
          _SummarySection(),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 1 — Concept
// ═════════════════════════════════════════════════════════════════════
class _ConceptSection extends StatelessWidget {
  const _ConceptSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'What is Scrollable?',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 12),
        _buildSCBullet(
          cs,
          Icons.touch_app,
          'Gesture + Position Manager',
          'Scrollable is a StatefulWidget that translates user gestures '
              '(drag, fling, mouse wheel) into scroll position changes. '
              'It does NOT render content — that job belongs to the '
              'Viewport it drives.',
        ),
        _buildSCBullet(
          cs,
          Icons.layers,
          'Layer in the Scroll Stack',
          'ScrollView creates a Scrollable, which creates a '
              'RawGestureDetector + Viewport. The Scrollable sits between '
              'your high-level widget (ListView) and the low-level render '
              'objects (RenderViewport, RenderSliver).',
        ),
        _buildSCBullet(
          cs,
          Icons.location_on,
          'Scrollable.of(context)',
          'Any descendant can find the nearest Scrollable via '
              'Scrollable.of(context). This returns a ScrollableState '
              'that provides the ScrollPosition and allows programmatic '
              'scrolling.',
        ),
        _buildSCBullet(
          cs,
          Icons.sync,
          'Responsibilities',
          '• Listens for drag/scroll gestures\n'
              '• Manages ScrollPosition (pixels, min/max extent)\n'
              '• Applies ScrollPhysics (bounce, clamp)\n'
              '• Dispatches ScrollNotification events\n'
              '• Drives Viewport via ViewportOffset',
        ),
        const Divider(height: 32),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.tertiaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.tertiaryContainer),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Distinction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.tertiary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Scrollable handles input → position.\n'
                'Viewport handles position → rendering.\n'
                'ScrollView combines both into a convenient widget.',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: cs.onSurface.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 2 — Architecture
// ═════════════════════════════════════════════════════════════════════
class _ArchitectureSection extends StatelessWidget {
  const _ArchitectureSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Scroll Architecture',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 16),
        // Architecture diagram
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Column(
            children: [
              _buildArchBox(cs, 'User Gesture (Drag / Fling / Wheel)',
                  Colors.orange, true),
              _buildArchArrow(cs),
              _buildArchBox(
                  cs, 'RawGestureDetector', Colors.amber, false),
              _buildArchArrow(cs),
              _buildArchBox(
                  cs,
                  'Scrollable\n(ScrollableState)',
                  Colors.deepPurple,
                  true),
              _buildArchArrow(cs),
              _buildArchBox(
                  cs, 'ScrollPosition\n(ViewportOffset)', Colors.blue, false),
              _buildArchArrow(cs),
              _buildArchBox(
                  cs, 'Viewport\n(RenderViewport)', Colors.green, false),
              _buildArchArrow(cs),
              _buildArchBox(
                  cs, 'Slivers\n(RenderSliver)', Colors.teal, false),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Component Roles',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildRoleCard(
          cs,
          'RawGestureDetector',
          'Captures drag gestures and routes them to Scrollable. '
              'Configured by ScrollBehavior for platform-specific behavior.',
          Icons.pan_tool,
          Colors.amber,
        ),
        _buildRoleCard(
          cs,
          'Scrollable / ScrollableState',
          'Converts gestures into ScrollPosition updates. Creates and '
              'manages the ScrollPosition. Fires ScrollNotification events.',
          Icons.swap_vert,
          Colors.deepPurple,
        ),
        _buildRoleCard(
          cs,
          'ScrollPosition',
          'Holds the current scroll offset (pixels), min/max extents, '
              'and produces the physics simulation for fling/overscroll.',
          Icons.straighten,
          Colors.blue,
        ),
        _buildRoleCard(
          cs,
          'Viewport',
          'Receives the offset from ScrollPosition and renders only '
              'the slivers that are currently visible.',
          Icons.crop,
          Colors.green,
        ),
      ],
    );
  }
}

Widget _buildArchBox(ColorScheme cs, String label, Color accent, bool bold) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent.withOpacity(0.3)),
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: accent.withOpacity(0.9),
      ),
    ),
  );
}

Widget _buildArchArrow(ColorScheme cs) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Icon(Icons.arrow_downward, size: 18, color: cs.outline),
  );
}

Widget _buildRoleCard(
  ColorScheme cs,
  String title,
  String description,
  IconData icon,
  Color accent,
) {
  return Card(
    margin: const EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.7),
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

// ═════════════════════════════════════════════════════════════════════
// Section 3 — ScrollPosition live inspector
// ═════════════════════════════════════════════════════════════════════
class _ScrollPositionSection extends StatefulWidget {
  const _ScrollPositionSection();

  @override
  State<_ScrollPositionSection> createState() => _ScrollPositionSectionState();
}

class _ScrollPositionSectionState extends State<_ScrollPositionSection> {
  final ScrollController _ctrl = ScrollController();
  double _pixels = 0;
  double _maxExtent = 0;
  double _viewportDim = 0;
  String _direction = 'idle';

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onScroll);
  }

  void _onScroll() {
    final pos = _ctrl.position;
    setState(() {
      _pixels = pos.pixels;
      _maxExtent = pos.maxScrollExtent;
      _viewportDim = pos.viewportDimension;
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool _onNotification(ScrollNotification n) {
    if (n is UserScrollNotification) {
      setState(() {
        _direction = n.direction.toString().split('.').last;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'ScrollPosition Inspector',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Scroll the list and watch the ScrollPosition fields update.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Metrics panel
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: _posMetric(
                            cs, 'pixels', _pixels.toStringAsFixed(1))),
                    Expanded(
                        child: _posMetric(
                            cs, 'maxExtent', _maxExtent.toStringAsFixed(0))),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                        child: _posMetric(
                            cs, 'viewport', _viewportDim.toStringAsFixed(0))),
                    Expanded(child: _posMetric(cs, 'direction', _direction)),
                  ],
                ),
                const SizedBox(height: 6),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _maxExtent > 0
                        ? (_pixels / _maxExtent).clamp(0.0, 1.0)
                        : 0,
                    minHeight: 8,
                    backgroundColor: cs.outline.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation(cs.primary),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${(_maxExtent > 0 ? (_pixels / _maxExtent * 100) : 0).toStringAsFixed(0)}% scrolled',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: cs.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: ListView.builder(
              controller: _ctrl,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 50,
              itemBuilder: (_, i) {
                final hue = (i * 7.0) % 360;
                return Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 3),
                  decoration: BoxDecoration(
                    color: HSLColor.fromAHSL(1, hue, 0.5, 0.87).toColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 14),
                  child: Text(
                    'Item $i',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: HSLColor.fromAHSL(1, hue, 0.6, 0.3).toColor(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _posMetric(ColorScheme cs, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: cs.onSurface.withOpacity(0.5),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: cs.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 4 — ScrollController
// ═════════════════════════════════════════════════════════════════════
class _ScrollControllerSection extends StatelessWidget {
  const _ScrollControllerSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'ScrollController Deep Dive',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 12),
        _buildSCBullet(
          cs,
          Icons.gamepad,
          'What it Does',
          'ScrollController creates, holds, and provides access to one '
              'or more ScrollPosition objects. It is the bridge between '
              'your code and the Scrollable widget.',
        ),
        _buildSCBullet(
          cs,
          Icons.link,
          'Lifecycle',
          '1. Create controller in initState()\n'
              '2. Pass to scrollable widget (controller: _ctrl)\n'
              '3. Scrollable attaches its ScrollPosition\n'
              '4. Listen via addListener() or read position\n'
              '5. Dispose in dispose()',
        ),
        _buildSCBullet(
          cs,
          Icons.numbers,
          'initialScrollOffset',
          'Set the initial position where the scrollable starts. '
              'Only applies when the ScrollPosition is first created.',
        ),
        _buildSCBullet(
          cs,
          Icons.art_track,
          'keepScrollOffset',
          'When true (default), the ScrollPosition\'s scroll offset is '
              'saved with PageStorage and restored when the widget is '
              'recreated (e.g., navigating back to a page).',
        ),
        const Divider(height: 28),
        Text(
          'Controller API',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildAPIRow(cs, 'offset', 'Current scroll offset (double)'),
        _buildAPIRow(cs, 'position', 'The attached ScrollPosition'),
        _buildAPIRow(cs, 'positions', 'All attached ScrollPositions (Iterable)'),
        _buildAPIRow(cs, 'hasClients', 'True if any ScrollPosition is attached'),
        _buildAPIRow(cs, 'animateTo()', 'Animate to a target offset'),
        _buildAPIRow(cs, 'jumpTo()', 'Jump instantly to a target offset'),
        _buildAPIRow(cs, 'addListener()', 'Register a scroll listener'),
        _buildAPIRow(cs, 'attach()', 'Called by Scrollable to attach position'),
        _buildAPIRow(cs, 'detach()', 'Called by Scrollable to detach position'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber, color: Colors.amber.shade800),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Always check hasClients before accessing offset or position. '
                  'If the controller has not been attached to any Scrollable yet '
                  '(e.g., in initState), accessing position will throw.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.amber.shade900,
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

Widget _buildAPIRow(ColorScheme cs, String method, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            method,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: cs.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 5 — Programmatic Scroll (animateTo / jumpTo)
// ═════════════════════════════════════════════════════════════════════
class _ProgrammaticScrollSection extends StatefulWidget {
  const _ProgrammaticScrollSection();

  @override
  State<_ProgrammaticScrollSection> createState() =>
      _ProgrammaticScrollSectionState();
}

class _ProgrammaticScrollSectionState
    extends State<_ProgrammaticScrollSection> {
  final ScrollController _ctrl = ScrollController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _scrollTo(double target, {bool animate = true}) {
    if (animate) {
      _ctrl.animateTo(
        target,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _ctrl.jumpTo(target);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Programmatic Scrolling',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Use animateTo() for smooth transitions and jumpTo() for '
            'instant jumps. Both take a pixel offset target.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Button row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _actionChip(cs, 'Top (animate)', () => _scrollTo(0)),
              _actionChip(
                  cs, 'Middle', () => _scrollTo(1200)),
              _actionChip(
                cs,
                'Bottom',
                () => _scrollTo(_ctrl.position.maxScrollExtent),
              ),
              _actionChip(
                cs,
                'Jump to 800',
                () => _scrollTo(800, animate: false),
              ),
              _actionChip(
                cs,
                '+300',
                () =>
                    _scrollTo(_ctrl.offset + 300),
              ),
              _actionChip(
                cs,
                '-300',
                () => _scrollTo((_ctrl.offset - 300).clamp(0, double.infinity)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            controller: _ctrl,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 60,
            itemBuilder: (_, i) {
              final hue = (i * 6.0) % 360;
              return Container(
                height: 48,
                margin: const EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  color: HSLColor.fromAHSL(1, hue, 0.45, 0.88).toColor(),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 14),
                child: Row(
                  children: [
                    Text(
                      'Item $i',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: HSLColor.fromAHSL(1, hue, 0.6, 0.3).toColor(),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'offset: ${(i * 51).toStringAsFixed(0)}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: cs.onSurface.withOpacity(0.35),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _actionChip(ColorScheme cs, String label, VoidCallback onPressed) {
    return ActionChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      onPressed: onPressed,
      backgroundColor: cs.secondaryContainer,
      side: BorderSide.none,
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 6 — Multiple Controllers
// ═════════════════════════════════════════════════════════════════════
class _MultipleControllersSection extends StatefulWidget {
  const _MultipleControllersSection();

  @override
  State<_MultipleControllersSection> createState() =>
      _MultipleControllersSectionState();
}

class _MultipleControllersSectionState
    extends State<_MultipleControllersSection> {
  final ScrollController _ctrlA = ScrollController();
  final ScrollController _ctrlB = ScrollController();
  bool _synced = false;

  @override
  void initState() {
    super.initState();
    _ctrlA.addListener(_syncFromA);
  }

  void _syncFromA() {
    if (_synced && _ctrlB.hasClients && _ctrlA.hasClients) {
      final target = _ctrlA.offset.clamp(
        _ctrlB.position.minScrollExtent,
        _ctrlB.position.maxScrollExtent,
      );
      _ctrlB.jumpTo(target);
    }
  }

  @override
  void dispose() {
    _ctrlA.dispose();
    _ctrlB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Linked Scroll Controllers',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Two independent lists. When "Sync" is enabled, scrolling '
            'List A mirrors the offset to List B.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              FilterChip(
                label: Text(_synced ? 'Synced' : 'Independent'),
                selected: _synced,
                onSelected: (v) => setState(() => _synced = v),
              ),
              const Spacer(),
              Text(
                _synced ? 'A → B linked' : 'Not linked',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: cs.primary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildLinkedList(cs, _ctrlA, 'A', cs.primary, 25),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildLinkedList(cs, _ctrlB, 'B', cs.tertiary, 25),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLinkedList(
    ColorScheme cs,
    ScrollController ctrl,
    String label,
    Color accent,
    int count,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          width: double.infinity,
          decoration: BoxDecoration(
            color: accent.withOpacity(0.1),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Text(
            'List $label',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accent,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: accent.withOpacity(0.2)),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(10)),
              child: ListView.builder(
                controller: ctrl,
                itemCount: count,
                itemBuilder: (_, i) => Container(
                  height: 48,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.05 + (i / count) * 0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$label-$i',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 7 — Scrollable.ensureVisible
// ═════════════════════════════════════════════════════════════════════
class _EnsureVisibleSection extends StatefulWidget {
  const _EnsureVisibleSection();

  @override
  State<_EnsureVisibleSection> createState() => _EnsureVisibleSectionState();
}

class _EnsureVisibleSectionState extends State<_EnsureVisibleSection> {
  final List<GlobalKey> _keys = List.generate(40, (_) => GlobalKey());
  int _highlighted = -1;

  void _scrollToItem(int index) {
    final ctx = _keys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.3,
      );
      setState(() => _highlighted = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Scrollable.ensureVisible()',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'ensureVisible scrolls the nearest Scrollable ancestor so that '
            'the given context is visible. No ScrollController needed.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Jump buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              for (final idx in [0, 5, 10, 15, 20, 25, 30, 35, 39])
                ActionChip(
                  label: Text('#$idx', style: const TextStyle(fontSize: 12)),
                  onPressed: () => _scrollToItem(idx),
                  backgroundColor: _highlighted == idx
                      ? cs.primaryContainer
                      : cs.surfaceVariant,
                  side: BorderSide.none,
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 40,
            itemBuilder: (_, i) {
              final isHighlighted = i == _highlighted;
              final hue = (i * 9.0) % 360;
              return Container(
                key: _keys[i],
                height: 54,
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? cs.primaryContainer
                      : HSLColor.fromAHSL(1, hue, 0.4, 0.92).toColor(),
                  borderRadius: BorderRadius.circular(8),
                  border: isHighlighted
                      ? Border.all(color: cs.primary, width: 2)
                      : null,
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    if (isHighlighted)
                      Icon(Icons.arrow_right, color: cs.primary, size: 20),
                    Text(
                      'Item #$i',
                      style: TextStyle(
                        fontWeight:
                            isHighlighted ? FontWeight.bold : FontWeight.w500,
                        color: isHighlighted ? cs.primary : cs.onSurface,
                      ),
                    ),
                    const Spacer(),
                    if (isHighlighted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: cs.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'ensureVisible',
                          style: TextStyle(
                            fontSize: 10,
                            color: cs.onPrimary,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 8 — Summary
// ═════════════════════════════════════════════════════════════════════
class _SummarySection extends StatelessWidget {
  const _SummarySection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Scrollable Summary',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 16),
        _buildSCBullet(
          cs,
          Icons.touch_app,
          'Core Responsibility',
          'Scrollable translates user gestures into ScrollPosition '
              'updates and drives the Viewport to render visible content.',
        ),
        _buildSCBullet(
          cs,
          Icons.layers,
          'Architecture Stack',
          'User Gesture → RawGestureDetector → Scrollable → '
              'ScrollPosition → Viewport → Slivers.',
        ),
        _buildSCBullet(
          cs,
          Icons.straighten,
          'ScrollPosition',
          'Holds pixels, extents, viewport dimension, and the physics '
              'simulation. Notifies listeners on every change.',
        ),
        _buildSCBullet(
          cs,
          Icons.gamepad,
          'ScrollController',
          'Creates and manages ScrollPosition. Provides animateTo(), '
              'jumpTo(), offset, and addListener(). Always dispose.',
        ),
        _buildSCBullet(
          cs,
          Icons.visibility,
          'Scrollable.ensureVisible()',
          'Scrolls the nearest ancestor Scrollable to make a given '
              'BuildContext visible. No controller needed — just pass '
              'the context of the widget to show.',
        ),
        _buildSCBullet(
          cs,
          Icons.link,
          'Linked Scrolling',
          'Two ScrollControllers can be linked by listening to one '
              'and calling jumpTo() on another, enabling synchronized '
              'scrolling patterns.',
        ),
        const Divider(height: 32),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cs.primaryContainer.withOpacity(0.5),
                cs.tertiaryContainer.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 32, color: cs.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'You rarely use Scrollable directly — it lives inside '
                  'every ListView, GridView, and PageView. Understanding '
                  'it helps you master ScrollController, ScrollPosition, '
                  'ensureVisible, and the overall Flutter scroll architecture.',
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.8),
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

// ─────────────────────────────────────────────────────────────────────
// Shared helpers (prefixed _buildSC to avoid collisions)
// ─────────────────────────────────────────────────────────────────────
Widget _buildSCBullet(
  ColorScheme cs,
  IconData icon,
  String title,
  String body,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
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
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
