// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — SliverChildListDelegate
///
/// SliverChildListDelegate is the eager counterpart to SliverChildBuilderDelegate.
/// It takes a concrete list of child widgets and provides them to slivers
/// such as SliverList, SliverGrid, and SliverFixedExtentList. All children
/// are created up front when the delegate is constructed — making it ideal
/// for small, known-length lists where the cost of creating all widgets at
/// once is acceptable.
///
/// Sections
/// ─────────
/// 1. What is SliverChildListDelegate?
/// 2. Constructor parameters explained
/// 3. Eager vs Lazy — when to choose ListDelegate
/// 4. Live: eager list with creation tracking
/// 5. Live: grid layout with ListDelegate
/// 6. Live: mixed content (headers, cards, dividers)
/// 7. addRepaintBoundaries & addSemanticIndexes
/// 8. Best practices

// ─── palette ───────────────────────────────────────────────
const _kBrown      = Color(0xFF795548);
const _kBrownLight = Color(0xFFD7CCC8);
const _kBrownDark  = Color(0xFF3E2723);
const _kCyan       = Color(0xFF00BCD4);
const _kCyanLight  = Color(0xFFB2EBF2);
const _kCyanDark   = Color(0xFF006064);
const _kSurface    = Color(0xFFFBFBFD);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── 1. Overview ───────────────────────────────────────────
const _kOverview = 'SliverChildListDelegate accepts a pre-built List<Widget> '
    'and provides children to slivers by index. Unlike SliverChildBuilderDelegate '
    'which creates children lazily on demand, SliverChildListDelegate has every '
    'widget already instantiated. The sliver framework still only layouts and '
    'paints the visible subset, but all widget objects exist in memory from the '
    'start. This is the simplest delegate — just hand it a list.';

// ─── 2. Parameters ─────────────────────────────────────────
class _Param {
  const _Param(this.name, this.type, this.defaultValue, this.description);
  final String name;
  final String type;
  final String defaultValue;
  final String description;
}

const _kParams = <_Param>[
  _Param('children', 'List<Widget>', '(required)',
      'The list of child widgets. All are created when the delegate is '
      'constructed. The framework indexes into this list on demand.'),
  _Param('addAutomaticKeepAlives', 'bool', 'true',
      'Wraps each child in AutomaticKeepAlive. If a child mixes in '
      'AutomaticKeepAliveClientMixin and wantKeepAlive returns true, '
      'the element is kept alive even when scrolled off-screen.'),
  _Param('addRepaintBoundaries', 'bool', 'true',
      'Wraps each child in a RepaintBoundary to isolate repaints. '
      'Disable for very cheap children to save layer overhead.'),
  _Param('addSemanticIndexes', 'bool', 'true',
      'Wraps each child in IndexedSemantics. The semanticIndexCallback '
      'and semanticIndexOffset control the mapping.'),
  _Param('semanticIndexCallback', 'SemanticIndexCallback',
      '(_, localIndex) => localIndex',
      'Maps (widget, localIndex) to a semantic index. Override when '
      'the list contains non-semantic items like separators.'),
  _Param('semanticIndexOffset', 'int', '0',
      'Added to the semanticIndexCallback result. Use when composing '
      'multiple delegates in a single scroll view.'),
];

// ─── 3. Eager vs Lazy ─────────────────────────────────────
class _CompRow {
  const _CompRow(this.feature, this.list, this.builder);
  final String feature;
  final String list;
  final String builder;
}

const _kComparison = <_CompRow>[
  _CompRow('Construction', 'All at once (eager)', 'On-demand (lazy)'),
  _CompRow('Memory footprint', 'O(n) widget objects', 'O(visible) widget objects'),
  _CompRow('Initial cost', 'Higher — builds all', 'Lower — builds visible only'),
  _CompRow('Scroll performance', 'No build during scroll', 'Builder called during scroll'),
  _CompRow('childCount', 'Implicit (list.length)', 'Explicit or null'),
  _CompRow('Ideal list size', '< 50 items', '> 50 items or infinite'),
  _CompRow('Code simplicity', 'Very simple', 'Requires builder function'),
  _CompRow('State retention', 'All states always alive', 'Depends on KeepAlive'),
];

// ─── 7. Wrapping notes ────────────────────────────────────
const _kWrappingNotes = <String, String>{
  'RepaintBoundary wrapping':
      'With addRepaintBoundaries: true (default), each child is wrapped in a '
      'RepaintBoundary. This means repainting one child (e.g., an animation) '
      'does not trigger a repaint of its neighbors. The trade-off is a small '
      'per-child layer overhead. Disable for very lightweight children.',
  'SemanticIndex wrapping':
      'With addSemanticIndexes: true (default), each child is wrapped in an '
      'IndexedSemantics widget. Accessibility tools use this to announce the '
      'position of each item ("item 3 of 10"). Override semanticIndexCallback '
      'when some children (like dividers) should not be counted.',
  'AutomaticKeepAlive wrapping':
      'With addAutomaticKeepAlives: true (default), each child is wrapped in '
      'AutomaticKeepAlive. This only has an effect if the child\'s State mixes '
      'in AutomaticKeepAliveClientMixin and wantKeepAlive returns true. Since '
      'ListDelegate already keeps all widget objects in memory, this mainly '
      'affects the element tree lifecycle.',
};

// ─── 8. Best practices ─────────────────────────────────────
class _Practice {
  const _Practice(this.tip, this.detail);
  final String tip;
  final String detail;
}

const _kBestPractices = <_Practice>[
  _Practice(
    'Use for small, known lists only',
    'If you have fewer than 20-30 items and they are all known at build time, '
    'SliverChildListDelegate is the easier choice. Beyond that, prefer '
    'SliverChildBuilderDelegate for memory efficiency.',
  ),
  _Practice(
    'Perfect for heterogeneous content',
    'When your scroll view mixes headers, cards, dividers, and special widgets '
    'that are all different, a plain list is more readable than a builder '
    'with index-based branching.',
  ),
  _Practice(
    'Combine with SliverToBoxAdapter for singles',
    'For one-off items (a header, a banner), SliverToBoxAdapter is even '
    'simpler. Use SliverChildListDelegate when you have 2+ items that '
    'logically belong together in one sliver.',
  ),
  _Practice(
    'Disable wrapping for trivial items',
    'If every child is a simple Container or Text, setting both '
    'addRepaintBoundaries and addAutomaticKeepAlives to false removes '
    'two wrapper widgets per child, flattening the widget tree.',
  ),
  _Practice(
    'Don\'t use for infinite or paginated lists',
    'SliverChildListDelegate requires a complete list. For data that '
    'loads incrementally (pagination, infinite scroll), '
    'SliverChildBuilderDelegate with a null childCount is required.',
  ),
];

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kBrownDark, _kCyanDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
          blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5,
          color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kBrown, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('SliverChildListDelegate deep visual demo');
  print('─' * 48);
  print('Sections: overview, parameters, eager vs lazy, live eager list,');
  print('grid layout, mixed content, wrapping, best practices.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kBrown, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoScaffold(),
  );
}

class _DemoScaffold extends StatefulWidget {
  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverChildListDelegate'),
        backgroundColor: _kBrownDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _EagerListPage(), _MixedContentPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kBrownDark,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Eager'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Mixed'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Theory
// ═══════════════════════════════════════════════════════════
class _TheoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1 ──
        _sectionHeader('1 · What Is SliverChildListDelegate?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('TYPICAL USAGE'),
              SizedBox(height: 8),
              _mono('CustomScrollView('),
              _mono('  slivers: ['),
              _mono('    SliverList('),
              _mono('      delegate: SliverChildListDelegate(['),
              _mono('        HeaderWidget(),'),
              _mono('        ContentCard(title: "A"),'),
              _mono('        ContentCard(title: "B"),'),
              _mono('        ContentCard(title: "C"),'),
              _mono('        FooterWidget(),'),
              _mono('      ]),'),
              _mono('    ),'),
              _mono('  ],'),
              _mono(')'),
              SizedBox(height: 8),
              _bullet('Pass a plain list — no builder function needed.'),
              _bullet('All children are Widget objects, ready immediately.'),
              _bullet('Ideal for small heterogeneous lists.'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 2 ──
        _sectionHeader('2 · Constructor Parameters', Icons.settings_outlined),
        SizedBox(height: 8),
        ..._kParams.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _kBrownLight, borderRadius: BorderRadius.circular(5)),
                      child: Text(p.name,
                          style: TextStyle(fontFamily: 'monospace',
                              fontWeight: FontWeight.w700, fontSize: 12,
                              color: _kBrownDark)),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(p.defaultValue,
                      style: TextStyle(fontFamily: 'monospace', fontSize: 11,
                          color: _kCyanDark, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(height: 4),
              Text(p.type,
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11,
                      color: _kTextMuted)),
              SizedBox(height: 6),
              Text(p.description,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3 ──
        _sectionHeader('3 · Eager vs Lazy Comparison', Icons.compare_arrows),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('SLIVERCHILDLISTDELEGATE vs SLIVERCHILDBUILDERDELEGATE'),
              SizedBox(height: 8),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                border: TableBorder.all(color: _kDivider, width: 0.5),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: _kBrownLight.withOpacity(0.5)),
                    children: ['Feature', 'ListDelegate', 'BuilderDelegate'].map((h) =>
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(h, style: TextStyle(fontWeight: FontWeight.w700,
                              fontSize: 10.5, color: _kBrownDark)),
                        )).toList(),
                  ),
                  ..._kComparison.map((r) => TableRow(
                    children: [r.feature, r.list, r.builder].map((c) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(c, style: TextStyle(fontSize: 10.5, color: _kTextDark)),
                    )).toList(),
                  )),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 7 ──
        _sectionHeader('7 · Wrapping Behavior', Icons.layers_outlined),
        SizedBox(height: 8),
        ..._kWrappingNotes.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kCyanLight, borderRadius: BorderRadius.circular(6)),
                child: Text(e.key,
                    style: TextStyle(fontFamily: 'monospace',
                        fontWeight: FontWeight.w700, fontSize: 12,
                        color: _kCyanDark)),
              ),
              SizedBox(height: 6),
              Text(e.value,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 8 ──
        _sectionHeader('8 · Best Practices', Icons.lightbulb_outlined),
        SizedBox(height: 8),
        ..._kBestPractices.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kCyan, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(p.tip,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,
                            color: _kBrownDark)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(p.detail,
                    style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Eager list with creation tracking
// ═══════════════════════════════════════════════════════════
class _EagerListPage extends StatefulWidget {
  @override
  State<_EagerListPage> createState() => _EagerListPageState();
}

class _EagerListPageState extends State<_EagerListPage> {
  int _itemCount = 20;
  bool _keepAlives = true;
  bool _repaintBoundaries = true;

  @override
  Widget build(BuildContext context) {
    // Build the entire list eagerly — every _TrackedTile is created NOW
    final children = List<Widget>.generate(_itemCount, (i) {
      final hue = (i * 360 / _itemCount) % 360;
      final color = HSVColor.fromAHSV(1, hue, 0.30, 0.95).toColor();
      return _TrackedTile(
        key: ValueKey('eager-$i'),
        index: i,
        total: _itemCount,
        color: color,
        hue: hue.toInt(),
      );
    });

    return Column(
      children: [
        // Dashboard
        Container(
          padding: EdgeInsets.all(12),
          color: _kBrownDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('EAGER LIST — ALL CHILDREN EXIST',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('All $_itemCount widgets are created up front, even those '
                  'off-screen. Scroll and notice no builder is called.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5, height: 1.3)),
              SizedBox(height: 8),
              Row(
                children: [
                  _dashChip('Items (eager)', '$_itemCount'),
                  SizedBox(width: 8),
                  _dashChip('Widget objects', '$_itemCount'),
                  SizedBox(width: 8),
                  _dashChip('Memory', 'O($_itemCount)'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text('Count: ', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  Expanded(
                    child: Slider(
                      value: _itemCount.toDouble(), min: 5, max: 100,
                      activeColor: _kCyan,
                      onChanged: (v) => setState(() => _itemCount = v.toInt()),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _toggleChip('KeepAlive', _keepAlives,
                      (v) => setState(() => _keepAlives = v)),
                  SizedBox(width: 8),
                  _toggleChip('RepaintBnd', _repaintBoundaries,
                      (v) => setState(() => _repaintBoundaries = v)),
                ],
              ),
            ],
          ),
        ),
        // The eager SliverList
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  children,
                  addAutomaticKeepAlives: _keepAlives,
                  addRepaintBoundaries: _repaintBoundaries,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dashChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.white54, fontSize: 9,
                fontWeight: FontWeight.w600)),
            Text(value, style: TextStyle(color: _kCyan,
                fontFamily: 'monospace', fontSize: 13,
                fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, ValueChanged<bool> onChanged) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
            color: value ? _kCyan.withOpacity(0.25)
                : Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: value ? _kCyan : Colors.white24),
          ),
          child: Row(
            children: [
              Icon(value ? Icons.check_box : Icons.check_box_outline_blank,
                  color: value ? _kCyan : Colors.white54, size: 16),
              SizedBox(width: 6),
              Expanded(
                child: Text(label,
                    style: TextStyle(color: Colors.white, fontSize: 10.5,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A tile that prints when constructed — demonstrating eager creation.
class _TrackedTile extends StatelessWidget {
  const _TrackedTile({
    required super.key,
    required this.index,
    required this.total,
    required this.color,
    required this.hue,
  });

  final int index;
  final int total;
  final Color color;
  final int hue;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(index),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      height: 54,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('${index + 1}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800,
                    color: _kTextDark)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Eager item ${index + 1} of $total',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,
                        color: _kTextDark)),
                Text('Created at delegate construction time',
                    style: TextStyle(fontSize: 10, color: _kTextMuted)),
              ],
            ),
          ),
          Text('$hue°',
              style: TextStyle(fontFamily: 'monospace', fontSize: 10,
                  color: _kTextMuted)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3: Mixed content — headers, cards, dividers
// ═══════════════════════════════════════════════════════════
class _MixedContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          color: _kBrownDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MIXED CONTENT — HETEROGENEOUS LIST',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('SliverChildListDelegate shines when children are different '
                  'types — headers, cards, dividers, banners — all in one list.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Section A: products
              SliverList(
                delegate: SliverChildListDelegate([
                  _sectionBanner('Electronics', Icons.devices, _kCyanDark),
                  _productCard('Wireless Headphones', 'Bluetooth 5.3, ANC',
                      79.99, _kCyanLight),
                  _productCard('Mechanical Keyboard', 'Cherry MX Blue, RGB',
                      149.99, _kCyanLight),
                  _productCard('USB-C Hub', '7-in-1, 100W PD',
                      39.99, _kCyanLight),
                  _thinDivider(),
                ]),
              ),
              // Section B: home
              SliverList(
                delegate: SliverChildListDelegate([
                  _sectionBanner('Home & Garden', Icons.yard, _kBrownDark),
                  _productCard('Ceramic Planter', 'Matte white, 8-inch',
                      24.99, _kBrownLight),
                  _productCard('LED Grow Light', 'Full spectrum, timer',
                      34.99, _kBrownLight),
                  _thinDivider(),
                ]),
              ),
              // Section C: stats
              SliverList(
                delegate: SliverChildListDelegate([
                  _sectionBanner('Usage Stats', Icons.bar_chart, _kCyan),
                  _statsRow('Delegates created', '3'),
                  _statsRow('Total children', '12'),
                  _statsRow('Unique widget types', '4'),
                  _statsRow('Memory model', 'Eager (all alive)'),
                  SizedBox(height: 12),
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('WHY THIS WORKS WELL'),
                        SizedBox(height: 6),
                        _bullet('Each sliver section has its own ListDelegate.'),
                        _bullet('Headers, cards, and dividers are different widget types.'),
                        _bullet('No builder needed — the list describes itself.'),
                        _bullet('The total count is small, so eager is fine.'),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('CODE PATTERN'),
                        SizedBox(height: 8),
                        _mono('SliverList('),
                        _mono('  delegate: SliverChildListDelegate(['),
                        _mono('    SectionBanner("Electronics"),'),
                        _mono('    ProductCard("Headphones"),'),
                        _mono('    ProductCard("Keyboard"),'),
                        _mono('    Divider(),'),
                        _mono('  ]),'),
                        _mono(')'),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _sectionBanner(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 4),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(width: 12),
        Text(title,
            style: TextStyle(color: Colors.white, fontSize: 16,
                fontWeight: FontWeight.w700)),
      ],
    ),
  );
}

Widget _productCard(String name, String desc, double price, Color bg) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg.withOpacity(0.4),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kDivider),
    ),
    child: Row(
      children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Icon(Icons.shopping_bag_outlined, color: _kBrown, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14,
                      color: _kTextDark)),
              Text(desc,
                  style: TextStyle(fontSize: 11, color: _kTextMuted)),
            ],
          ),
        ),
        Text('\$${price.toStringAsFixed(2)}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 14,
                fontWeight: FontWeight.w700, color: _kCyanDark)),
      ],
    ),
  );
}

Widget _thinDivider() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    height: 1,
    color: _kDivider,
  );
}

Widget _statsRow(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kDivider),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontSize: 13, color: _kTextDark)),
        Text(value,
            style: TextStyle(fontFamily: 'monospace', fontSize: 13,
                fontWeight: FontWeight.w700, color: _kBrownDark)),
      ],
    ),
  );
}
