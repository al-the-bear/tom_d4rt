// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: ScrollView — the abstract base class for scrollable widget
// implementations. ListView, GridView, and CustomScrollView all extend
// ScrollView. This demo explores every major property and pattern.
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'ScrollView Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      brightness: Brightness.light,
      useMaterial3: true,
    ),
    home: const _ScrollViewHome(),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Home scaffold
// ═════════════════════════════════════════════════════════════════════
class _ScrollViewHome extends StatefulWidget {
  const _ScrollViewHome();

  @override
  State<_ScrollViewHome> createState() => _ScrollViewHomeState();
}

class _ScrollViewHomeState extends State<_ScrollViewHome>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  static const _tabs = <String>[
    'Concept',
    'Class Hierarchy',
    'ListView',
    'GridView',
    'CustomScrollView',
    'Properties',
    'Scroll Direction',
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
        title: const Text('ScrollView'),
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
          _HierarchySection(),
          _ListViewSection(),
          _GridViewSection(),
          _CustomScrollViewSection(),
          _PropertiesSection(),
          _ScrollDirectionSection(),
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
          'What is ScrollView?',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 12),
        _buildSVBullet(
          cs,
          Icons.view_stream,
          'Abstract Base Class',
          'ScrollView is an abstract widget that combines a Scrollable '
              'with a Viewport. Subclasses define how slivers are built — '
              'ListView uses SliverList, GridView uses SliverGrid, and '
              'CustomScrollView lets you compose any combination of slivers.',
        ),
        _buildSVBullet(
          cs,
          Icons.layers,
          'Viewport + Scrollable',
          'ScrollView creates a Scrollable (gesture handling, scroll '
              'position) and a Viewport (renders only visible slivers). '
              'The key method buildSlivers() is overridden by each subclass '
              'to return the list of slivers that populate the viewport.',
        ),
        _buildSVBullet(
          cs,
          Icons.speed,
          'Lazy Rendering',
          'ScrollView-based widgets are inherently lazy — they only build '
              'and lay out slivers that are currently visible (plus a small '
              'cache extent). This makes them efficient for large datasets.',
        ),
        _buildSVBullet(
          cs,
          Icons.settings,
          'Key Properties',
          'scrollDirection, reverse, controller, physics, primary, '
              'shrinkWrap, cacheExtent, clipBehavior, keyboardDismissBehavior '
              '— all configured at the ScrollView level and inherited '
              'by ListView, GridView, and CustomScrollView.',
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
                'buildSlivers() Contract',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.tertiary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Every ScrollView subclass must implement List<Widget> '
                'buildSlivers(BuildContext context). This method returns '
                'the sliver widgets that are placed inside the Viewport.',
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurface.withOpacity(0.75),
                ),
              ),
              const SizedBox(height: 8),
              _buildCodeSnippet(cs, [
                'class ListView extends ScrollView {',
                '  @override',
                '  List<Widget> buildSlivers(BuildContext context) {',
                '    // Returns a single SliverList wrapping the children',
                '    return [SliverList(delegate: childrenDelegate)];',
                '  }',
                '}',
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildCodeSnippet(ColorScheme cs, List<String> lines) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cs.surface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cs.outlineVariant),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines
          .map((l) => Text(
                l,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: cs.onSurface.withOpacity(0.8),
                ),
              ))
          .toList(),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 2 — Class Hierarchy
// ═════════════════════════════════════════════════════════════════════
class _HierarchySection extends StatelessWidget {
  const _HierarchySection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'ScrollView Class Hierarchy',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 16),
        _buildHierarchyTree(cs),
        const SizedBox(height: 20),
        Text(
          'Subclass Comparison',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildComparisonCard(
          cs,
          'ListView',
          'Displays children in a single-axis linear list. '
              'Constructors: ListView(), .builder(), .separated(), .custom().',
          Icons.view_list,
          Colors.blue,
        ),
        _buildComparisonCard(
          cs,
          'GridView',
          'Displays children in a 2D grid. '
              'Constructors: GridView(), .builder(), .count(), .extent(), .custom().',
          Icons.grid_view,
          Colors.green,
        ),
        _buildComparisonCard(
          cs,
          'CustomScrollView',
          'Composes arbitrary slivers: SliverAppBar, SliverList, '
              'SliverGrid, SliverToBoxAdapter, SliverFillRemaining, etc.',
          Icons.dashboard_customize,
          Colors.purple,
        ),
        _buildComparisonCard(
          cs,
          'BoxScrollView (internal)',
          'Abstract class between ScrollView and ListView/GridView. '
              'Adds padding support via SliverPadding wrapper.',
          Icons.crop_square,
          Colors.orange,
        ),
        const Divider(height: 28),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: cs.primary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Rule of thumb: Use ListView for linear content, GridView '
                  'for 2D grids, and CustomScrollView when you need to mix '
                  'different sliver types (e.g., SliverAppBar + SliverGrid + '
                  'SliverList).',
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.75),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHierarchyTree(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hierLine(cs, 'Widget', 0, false),
          _hierLine(cs, '└─ StatelessWidget', 1, false),
          _hierLine(cs, '   └─ ScrollView (abstract)', 2, true),
          _hierLine(cs, '      ├─ CustomScrollView', 3, false),
          _hierLine(cs, '      └─ BoxScrollView (abstract)', 3, false),
          _hierLine(cs, '         ├─ ListView', 4, false),
          _hierLine(cs, '         └─ GridView', 4, false),
        ],
      ),
    );
  }

  Widget _hierLine(ColorScheme cs, String text, int depth, bool highlight) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 8.0, top: 3, bottom: 3),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
          color: highlight ? cs.primary : cs.onSurface.withOpacity(0.85),
        ),
      ),
    );
  }
}

Widget _buildComparisonCard(
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 22),
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
// Section 3 — ListView variants
// ═════════════════════════════════════════════════════════════════════
class _ListViewSection extends StatelessWidget {
  const _ListViewSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'ListView Variants',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 8),
        Text(
          'ListView extends BoxScrollView → ScrollView. Each constructor '
          'creates a different SliverChildDelegate under the hood.',
          style: TextStyle(
            fontSize: 13,
            color: cs.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 16),
        // ListView() — static children
        _buildVariantLabel(cs, '1. ListView()  —  Static Children'),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: List.generate(
              8,
              (i) => Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.indigo.shade100),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 12),
                child: Text('Static item $i',
                    style: TextStyle(color: Colors.indigo.shade700)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // ListView.builder() — lazy
        _buildVariantLabel(cs, '2. ListView.builder()  —  Lazy Builder'),
        Container(
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 100,
            itemBuilder: (_, i) {
              final hue = (i * 3.6) % 360;
              return Container(
                height: 36,
                margin: const EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  color: HSLColor.fromAHSL(1, hue, 0.5, 0.9).toColor(),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Lazy item $i  (hue ${hue.toStringAsFixed(0)}°)',
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // ListView.separated() — with separators
        _buildVariantLabel(cs, '3. ListView.separated()  —  With Dividers'),
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: 15,
            separatorBuilder: (_, i) => Divider(
              height: 1,
              color: Colors.teal.shade200,
            ),
            itemBuilder: (_, i) => ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.teal.shade100,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.teal.shade800,
                  ),
                ),
              ),
              title: Text(
                'Separated item ${i + 1}',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Delegate comparison
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.secondaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delegate Comparison',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              _buildDelegateRow(
                cs,
                'ListView()',
                'SliverChildListDelegate',
                'All children built upfront',
              ),
              _buildDelegateRow(
                cs,
                'ListView.builder()',
                'SliverChildBuilderDelegate',
                'Children built lazily on demand',
              ),
              _buildDelegateRow(
                cs,
                'ListView.separated()',
                'SliverChildBuilderDelegate',
                'Like builder + separators',
              ),
              _buildDelegateRow(
                cs,
                'ListView.custom()',
                'Custom delegate',
                'Full control over child management',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildVariantLabel(ColorScheme cs, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: cs.tertiary,
      ),
    ),
  );
}

Widget _buildDelegateRow(
  ColorScheme cs,
  String constructor,
  String delegate,
  String note,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            constructor,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: cs.primary,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                delegate,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: cs.onSurface.withOpacity(0.7),
                ),
              ),
              Text(
                note,
                style: TextStyle(
                  fontSize: 11,
                  color: cs.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 4 — GridView variants
// ═════════════════════════════════════════════════════════════════════
class _GridViewSection extends StatelessWidget {
  const _GridViewSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'GridView Variants',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 8),
        Text(
          'GridView extends BoxScrollView → ScrollView. It creates a '
          'SliverGrid with a SliverGridDelegate to define the grid layout.',
          style: TextStyle(
            fontSize: 13,
            color: cs.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 16),
        // GridView.count
        _buildVariantLabel(cs, '1. GridView.count()  —  Fixed Cross-Axis Count'),
        Container(
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(8),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1.4,
            children: List.generate(12, (i) {
              final hue = (i * 30.0) % 360;
              return Container(
                decoration: BoxDecoration(
                  color: HSLColor.fromAHSL(1, hue, 0.5, 0.85).toColor(),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '#$i',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HSLColor.fromAHSL(1, hue, 0.7, 0.3).toColor(),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        // GridView.extent
        _buildVariantLabel(
            cs, '2. GridView.extent()  —  Max Cross-Axis Extent'),
        Container(
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GridView.extent(
            maxCrossAxisExtent: 100,
            padding: const EdgeInsets.all(8),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            children: List.generate(16, (i) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.primaries[i % Colors.primaries.length].shade200,
                      Colors.primaries[i % Colors.primaries.length].shade400,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        // GridView.builder
        _buildVariantLabel(cs, '3. GridView.builder()  —  Lazy Grid'),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: 80,
            itemBuilder: (_, i) {
              final shade = (i * 3) % 256;
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, shade, 255 - shade, 128),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$i',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Grid delegate comparison
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.tertiaryContainer.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SliverGridDelegate Variants',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.tertiary,
                ),
              ),
              const SizedBox(height: 8),
              _buildGridDelegateRow(
                cs,
                'WithFixedCrossAxisCount',
                'Exactly N items per row. Items stretch to fill.',
              ),
              _buildGridDelegateRow(
                cs,
                'WithMaxCrossAxisExtent',
                'Each item at most N pixels wide. Count adjusts to fit.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildGridDelegateRow(ColorScheme cs, String name, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.grid_on, size: 16, color: cs.tertiary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 5 — CustomScrollView
// ═════════════════════════════════════════════════════════════════════
class _CustomScrollViewSection extends StatelessWidget {
  const _CustomScrollViewSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        // SliverAppBar
        SliverAppBar(
          expandedHeight: 140,
          pinned: true,
          backgroundColor: cs.primaryContainer,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'CustomScrollView',
              style: TextStyle(color: cs.onPrimaryContainer, fontSize: 16),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [cs.primary, cs.tertiary],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.dashboard_customize,
                  size: 50,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ),
        // Description
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Composing Multiple Slivers',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  'CustomScrollView lets you compose SliverAppBar, '
                  'SliverList, SliverGrid, SliverToBoxAdapter, '
                  'SliverFillRemaining, and custom slivers into a '
                  'single scrollable area.',
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Section header
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'SliverGrid — Photo Gallery',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cs.onSecondaryContainer,
              ),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 8)),
        // SliverGrid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                final hue = (i * 25.0) % 360;
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        HSLColor.fromAHSL(1, hue, 0.6, 0.7).toColor(),
                        HSLColor.fromAHSL(1, hue + 40, 0.6, 0.5).toColor(),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.photo,
                    color: Colors.white.withOpacity(0.7),
                  ),
                );
              },
              childCount: 9,
            ),
          ),
        ),
        // Another section header
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.tertiaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'SliverList — Recent Articles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cs.onTertiaryContainer,
              ),
            ),
          ),
        ),
        // SliverList
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                return Container(
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: cs.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors
                          .primaries[i % Colors.primaries.length].shade200,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    title: Text(
                      'Article ${i + 1}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    subtitle: Text(
                      'Composed via SliverList inside CustomScrollView',
                      style: TextStyle(
                        fontSize: 11,
                        color: cs.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ),
                );
              },
              childCount: 12,
            ),
          ),
        ),
        // Fill remaining
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 36, color: cs.primary),
                const SizedBox(height: 8),
                Text(
                  'SliverFillRemaining — fills leftover space',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cs.primary,
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

// ═════════════════════════════════════════════════════════════════════
// Section 6 — Properties deep dive
// ═════════════════════════════════════════════════════════════════════
class _PropertiesSection extends StatelessWidget {
  const _PropertiesSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'ScrollView Properties',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 12),
        _buildPropertyRow(
          cs,
          'scrollDirection',
          'Axis.vertical | Axis.horizontal',
          'The axis along which the scroll view scrolls.',
        ),
        _buildPropertyRow(
          cs,
          'reverse',
          'bool (default: false)',
          'Whether the scroll view goes in the reading direction. '
              'When true, items start at the bottom/right.',
        ),
        _buildPropertyRow(
          cs,
          'controller',
          'ScrollController?',
          'Controls the scroll position. If null and primary is true, '
              'uses PrimaryScrollController.of(context).',
        ),
        _buildPropertyRow(
          cs,
          'primary',
          'bool?',
          'Whether this is the primary scroll view. When true, uses '
              'the PrimaryScrollController. Defaults to true for '
              'vertical scroll views with no controller.',
        ),
        _buildPropertyRow(
          cs,
          'physics',
          'ScrollPhysics?',
          'Determines scroll behavior: BouncingScrollPhysics, '
              'ClampingScrollPhysics, NeverScrollableScrollPhysics, etc.',
        ),
        _buildPropertyRow(
          cs,
          'shrinkWrap',
          'bool (default: false)',
          'When true, the scroll view sizes to its content. '
              'Expensive — disables lazy rendering of offscreen slivers.',
        ),
        _buildPropertyRow(
          cs,
          'cacheExtent',
          'double? (default: ~250px)',
          'Extra area around the viewport where slivers are pre-built. '
              'Larger values → smoother scrolling but more memory.',
        ),
        _buildPropertyRow(
          cs,
          'clipBehavior',
          'Clip (default: Clip.hardEdge)',
          'How content outside the viewport is clipped. '
              'Clip.none shows overflow for visual effects.',
        ),
        _buildPropertyRow(
          cs,
          'keyboardDismissBehavior',
          'ScrollViewKeyboardDismissBehavior',
          'manual (default) or onDrag — controls keyboard '
              'dismissal behavior during scrolling.',
        ),
        const Divider(height: 28),
        // ShrinkWrap warning
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber, color: Colors.red.shade700, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'shrinkWrap Performance Warning',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Setting shrinkWrap: true forces the scroll view to '
                      'lay out ALL its children to determine its own size. '
                      'This defeats lazy rendering and can cause jank with '
                      'large lists. Consider using a Sliver-based solution '
                      'instead.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Primary scroll controller
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PrimaryScrollController Resolution',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                ),
              ),
              const SizedBox(height: 6),
              _buildCodeSnippet(cs, [
                '// When controller is null and:',
                '//   scrollDirection == Axis.vertical,',
                '//   primary defaults to true',
                '// → uses PrimaryScrollController.of(context)',
                '',
                '// This is how Scaffold\'s body scroll view',
                '// automatically gets connected to the',
                '// scaffold\'s scroll-to-top behavior.',
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildPropertyRow(
  ColorScheme cs,
  String name,
  String type,
  String description,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                type,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: cs.onSurface.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            description,
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
// Section 7 — Scroll Direction demo
// ═════════════════════════════════════════════════════════════════════
class _ScrollDirectionSection extends StatefulWidget {
  const _ScrollDirectionSection();

  @override
  State<_ScrollDirectionSection> createState() =>
      _ScrollDirectionSectionState();
}

class _ScrollDirectionSectionState extends State<_ScrollDirectionSection> {
  Axis _axis = Axis.vertical;
  bool _reverse = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Scroll Direction & Reverse',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Toggle scrollDirection and reverse to see how the items '
            'are laid out differently.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Controls
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ChoiceChip(
                label: const Text('Vertical'),
                selected: _axis == Axis.vertical,
                onSelected: (_) => setState(() => _axis = Axis.vertical),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Horizontal'),
                selected: _axis == Axis.horizontal,
                onSelected: (_) => setState(() => _axis = Axis.horizontal),
              ),
              const SizedBox(width: 16),
              FilterChip(
                label: const Text('reverse'),
                selected: _reverse,
                onSelected: (v) => setState(() => _reverse = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'scrollDirection: ${_axis.name}  ·  reverse: $_reverse',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: cs.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: cs.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListView.builder(
                scrollDirection: _axis,
                reverse: _reverse,
                padding: const EdgeInsets.all(8),
                itemCount: 30,
                itemBuilder: (_, i) {
                  final hue = (i * 12.0) % 360;
                  final size = _axis == Axis.horizontal
                      ? const Size(80, double.infinity)
                      : const Size(double.infinity, 56);
                  return Container(
                    width: size.width == double.infinity ? null : size.width,
                    height: size.height == double.infinity ? null : size.height,
                    margin: EdgeInsets.only(
                      right: _axis == Axis.horizontal ? 4 : 0,
                      bottom: _axis == Axis.vertical ? 4 : 0,
                    ),
                    decoration: BoxDecoration(
                      color:
                          HSLColor.fromAHSL(1, hue, 0.55, 0.8).toColor(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$i',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color:
                                HSLColor.fromAHSL(1, hue, 0.7, 0.3).toColor(),
                          ),
                        ),
                        if (_axis == Axis.vertical)
                          Text(
                            _reverse ? '← reverse' : '',
                            style: TextStyle(
                              fontSize: 10,
                              color: cs.onSurface.withOpacity(0.4),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
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
          'ScrollView Summary',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 16),
        _buildSVBullet(
          cs,
          Icons.view_stream,
          'Abstract Foundation',
          'ScrollView is the abstract base for all scrollable widget '
              'containers in Flutter. It combines Scrollable (gesture '
              'input and scroll position) with Viewport (visible rendering).',
        ),
        _buildSVBullet(
          cs,
          Icons.view_list,
          'ListView',
          'For linear lists of items. Use .builder() for large or '
              'infinite lists. Use .separated() for divider-based lists.',
        ),
        _buildSVBullet(
          cs,
          Icons.grid_view,
          'GridView',
          'For 2D grids. Use .count() for fixed column counts, '
              '.extent() for responsive sizing, .builder() for lazy grids.',
        ),
        _buildSVBullet(
          cs,
          Icons.dashboard_customize,
          'CustomScrollView',
          'For composing multiple sliver types: SliverAppBar, SliverList, '
              'SliverGrid, SliverToBoxAdapter, SliverFillRemaining.',
        ),
        _buildSVBullet(
          cs,
          Icons.speed,
          'Performance',
          'Avoid shrinkWrap: true for large lists — it defeats lazy '
              'rendering. Use cacheExtent to tune preloading. Prefer '
              '.builder() constructors for lists over 20 items.',
        ),
        _buildSVBullet(
          cs,
          Icons.swap_horiz,
          'Direction & Reverse',
          'scrollDirection controls the scroll axis. reverse changes '
              'item ordering. Both work with all ScrollView subclasses.',
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
                  'ScrollView is rarely used directly. Instead, use its '
                  'subclasses: ListView for lists, GridView for grids, '
                  'and CustomScrollView for mixed-sliver layouts. '
                  'Understanding ScrollView helps you understand the '
                  'common properties and behaviors they all share.',
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
// Shared helpers (prefixed _buildSV to avoid collisions)
// ─────────────────────────────────────────────────────────────────────
Widget _buildSVBullet(
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
