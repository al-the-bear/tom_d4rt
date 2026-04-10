// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — SliverChildBuilderDelegate
///
/// SliverChildBuilderDelegate is the lazy, on-demand child provider for
/// sliver-based scroll views. Instead of creating all children up front
/// (SliverChildListDelegate), it calls a builder callback only for the
/// indices that are currently visible — making it efficient for lists with
/// hundreds or thousands of items.
///
/// Sections
/// ─────────
/// 1. What is SliverChildBuilderDelegate?
/// 2. Constructor parameters explained
/// 3. Builder vs ListDelegate comparison
/// 4. Live: basic builder with build-count tracker
/// 5. Live: separator pattern (odd/even index)
/// 6. Live: infinite vs bounded childCount
/// 7. addAutomaticKeepAlives & addRepaintBoundaries
/// 8. Best practices and memory efficiency

// ─── palette ───────────────────────────────────────────────
const _kIndigo      = Color(0xFF3F51B5);
const _kIndigoLight = Color(0xFFC5CAE9);
const _kIndigoDark  = Color(0xFF1A237E);
const _kCoral       = Color(0xFFFF7043);
const _kCoralLight  = Color(0xFFFFCCBC);
const _kCoralDark   = Color(0xFFBF360C);
const _kSurface     = Color(0xFFFAFAFC);
const _kDivider     = Color(0xFFE0E0E0);
const _kTextDark    = Color(0xFF212121);
const _kTextMuted   = Color(0xFF757575);

// ─── 1. Overview ───────────────────────────────────────────
const _kOverview = 'SliverChildBuilderDelegate provides children to SliverList, '
    'SliverGrid, and SliverFixedExtentList on demand. It calls your builder '
    'function only for the indices the viewport needs to display, then recycles '
    'those widgets when they scroll out of view. This lazy construction is the '
    'key to scrolling extremely large lists without consuming proportional memory.';

// ─── 2. Parameters ─────────────────────────────────────────
class _Param {
  const _Param(this.name, this.type, this.defaultValue, this.description);
  final String name;
  final String type;
  final String defaultValue;
  final String description;
}

const _kParams = <_Param>[
  _Param('builder', 'NullableIndexedWidgetBuilder', '(required)',
      'The callback that creates a child widget for a given index. Return null '
      'to signal that there are no more children (when childCount is null).'),
  _Param('childCount', 'int?', 'null',
      'The total number of children. When null, the builder is called until it '
      'returns null — useful for infinite or not-yet-known list sizes.'),
  _Param('addAutomaticKeepAlives', 'bool', 'true',
      'Wraps each child in an AutomaticKeepAlive to prevent garbage collection '
      'when the child scrolls out of view (if child wants keepAlive).'),
  _Param('addRepaintBoundaries', 'bool', 'true',
      'Wraps each child in a RepaintBoundary, isolating its paint from '
      'neighbors. Saves repainting the whole viewport on partial changes.'),
  _Param('addSemanticIndexes', 'bool', 'true',
      'Wraps each child with an IndexedSemantics widget for accessibility. '
      'The semanticIndexCallback controls the mapping from child index.'),
  _Param('semanticIndexCallback', 'SemanticIndexCallback',
      '(_, localIndex) => localIndex',
      'Maps the (widget, localIndex) to a semantic index. Override when indices '
      'don\'t map 1:1 (e.g., separators between real items).'),
  _Param('semanticIndexOffset', 'int', '0',
      'Added to the value from semanticIndexCallback to produce the final '
      'semantic index. Useful when composing multiple delegates.'),
  _Param('findChildIndexCallback', 'ChildIndexGetter?', 'null',
      'Given a Key, returns the child\'s index. Enables efficient reordering '
      'and keeps state stable when the list mutates.'),
];

// ─── 3. Comparison ─────────────────────────────────────────
class _CompRow {
  const _CompRow(this.feature, this.builder, this.list);
  final String feature;
  final String builder;
  final String list;
}

const _kComparison = <_CompRow>[
  _CompRow('Construction', 'Lazy — only visible + buffer', 'Eager — all at once'),
  _CompRow('Memory', 'O(visible) widgets in memory', 'O(n) widgets always alive'),
  _CompRow('Infinite lists', 'Supported (childCount null)', 'Not practical'),
  _CompRow('Separators', 'Built into builder logic', 'Separate list entry needed'),
  _CompRow('State retention', 'Via KeepAlive or keys', 'Always retained'),
  _CompRow('Use case', 'Large/dynamic lists', 'Small fixed lists'),
];

// ─── 7. KeepAlive & RepaintBoundary ────────────────────────
const _kWrappingExplanation = <String, String>{
  'AutomaticKeepAlive':
      'When addAutomaticKeepAlives is true, each child is wrapped in an '
      'AutomaticKeepAlive widget. If the child\'s State mixes in '
      'AutomaticKeepAliveClientMixin and wantKeepAlive returns true, the '
      'sliver won\'t garbage-collect it when scrolled off-screen. Useful for '
      'stateful children like video players or text editors.',
  'RepaintBoundary':
      'When addRepaintBoundaries is true, each child is wrapped in a '
      'RepaintBoundary. This creates an isolated paint layer so that '
      'repainting one child doesn\'t force a repaint of others. The trade-off '
      'is a small overhead per layer. Disable for very cheap children.',
};

// ─── 8. Best practices ─────────────────────────────────────
class _Practice {
  const _Practice(this.tip, this.detail);
  final String tip;
  final String detail;
}

const _kBestPractices = <_Practice>[
  _Practice(
    'Always specify childCount when known',
    'Without childCount, the framework must probe one index past the last to '
    'discover the end. Setting childCount avoids that extra builder call and '
    'enables accurate scrollbar thumbs.',
  ),
  _Practice(
    'Return null from builder for out-of-range',
    'If childCount is null, the framework stops when builder returns null. '
    'Never throw — returning null is the defined termination signal.',
  ),
  _Practice(
    'Use keys for reorderable lists',
    'When items can be reordered or removed, give each child a ValueKey. '
    'Combine with findChildIndexCallback so the framework can locate '
    'existing elements without rebuilding the whole visible range.',
  ),
  _Practice(
    'Disable wrapping for cheap children',
    'If your child widgets are stateless and fast to paint (e.g., a simple Text '
    'row), set addRepaintBoundaries and addAutomaticKeepAlives to false. '
    'This reduces widget depth and layer count.',
  ),
  _Practice(
    'Prefer SliverChildBuilderDelegate over SliverChildListDelegate',
    'Even for modest lists (>20 items), the lazy builder avoids the initial '
    'startup cost of creating every child widget up front.',
  ),
];

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kIndigoDark, _kCoralDark]),
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
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2))],
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
            decoration: BoxDecoration(color: _kIndigo, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('SliverChildBuilderDelegate deep visual demo');
  print('─' * 48);
  print('Sections: overview, parameters, comparison, live basic builder,');
  print('separator pattern, infinite vs bounded, wrapping, best practices.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kIndigo, brightness: Brightness.light),
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
        title: Text('SliverChildBuilderDelegate'),
        backgroundColor: _kIndigoDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _BuilderDemoPage(), _SeparatorDemoPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kIndigoDark,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.build_outlined), label: 'Builder'),
          BottomNavigationBarItem(icon: Icon(Icons.view_list_outlined), label: 'Separators'),
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
        _sectionHeader('1 · What Is SliverChildBuilderDelegate?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('HOW IT FITS TOGETHER'),
              SizedBox(height: 8),
              _mono('CustomScrollView'),
              _mono('  └─ SliverList('),
              _mono('       delegate: SliverChildBuilderDelegate('),
              _mono('         (context, index) => MyTile(index),'),
              _mono('         childCount: 1000,'),
              _mono('       ),'),
              _mono('     )'),
              SizedBox(height: 8),
              _bullet('The builder is called only for visible + buffered indices.'),
              _bullet('Widgets are recycled when they scroll off screen.'),
              _bullet('Memory usage stays constant regardless of list size.'),
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
                        color: _kIndigoLight, borderRadius: BorderRadius.circular(5)),
                      child: Text(p.name,
                          style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                              fontSize: 12, color: _kIndigoDark)),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(p.defaultValue,
                      style: TextStyle(fontFamily: 'monospace', fontSize: 11,
                          color: _kCoralDark, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(height: 4),
              Text(p.type,
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: _kTextMuted)),
              SizedBox(height: 6),
              Text(p.description,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3 ──
        _sectionHeader('3 · Builder vs ListDelegate', Icons.compare_arrows),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('COMPARISON TABLE'),
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
                    decoration: BoxDecoration(color: _kIndigoLight.withOpacity(0.5)),
                    children: ['Feature', 'BuilderDelegate', 'ListDelegate'].map((h) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(h, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.5, color: _kIndigoDark)),
                    )).toList(),
                  ),
                  ..._kComparison.map((r) => TableRow(
                    children: [r.feature, r.builder, r.list].map((c) => Padding(
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
        _sectionHeader('7 · AutomaticKeepAlive & RepaintBoundary', Icons.layers_outlined),
        SizedBox(height: 8),
        ..._kWrappingExplanation.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kCoralLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(e.key,
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                        fontSize: 12, color: _kCoralDark)),
              ),
              SizedBox(height: 6),
              Text(e.value,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('EFFECTIVE WRAPPING'),
              SizedBox(height: 8),
              _mono('// With defaults (both true), the delegate wraps:'),
              _mono('RepaintBoundary('),
              _mono('  child: AutomaticKeepAlive('),
              _mono('    child: IndexedSemantics('),
              _mono('      index: semanticIndex,'),
              _mono('      child: yourChild,'),
              _mono('    ),'),
              _mono('  ),'),
              _mono(')'),
              SizedBox(height: 8),
              _mono('// With all false — just the raw child:'),
              _mono('yourChild'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 8 ──
        _sectionHeader('8 · Best Practices & Memory Efficiency', Icons.lightbulb_outlined),
        SizedBox(height: 8),
        ..._kBestPractices.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kIndigo, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(p.tip,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,
                            color: _kIndigoDark)),
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
// TAB 2: Live builder with build-count tracking
// ═══════════════════════════════════════════════════════════
class _BuilderDemoPage extends StatefulWidget {
  @override
  State<_BuilderDemoPage> createState() => _BuilderDemoPageState();
}

class _BuilderDemoPageState extends State<_BuilderDemoPage> {
  int _totalItems = 50;
  final Set<int> _builtIndices = {};
  bool _keepAlives = true;
  bool _repaintBoundaries = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dashboard
        Container(
          padding: EdgeInsets.all(12),
          color: _kIndigoDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BUILDER TRACKING',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 6),
              Row(
                children: [
                  _dashChip('Total items', '$_totalItems'),
                  SizedBox(width: 8),
                  _dashChip('Built so far', '${_builtIndices.length}'),
                  SizedBox(width: 8),
                  _dashChip('Memory ratio', '${(_builtIndices.length * 100 / _totalItems).toStringAsFixed(0)}%'),
                ],
              ),
              SizedBox(height: 8),
              // Item count slider
              Row(
                children: [
                  Text('Items: ', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  Expanded(
                    child: Slider(
                      value: _totalItems.toDouble(), min: 10, max: 500,
                      activeColor: _kCoral,
                      onChanged: (v) => setState(() {
                        _totalItems = v.toInt();
                        _builtIndices.clear();
                      }),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _toggleChip('KeepAlive', _keepAlives, (v) => setState(() {
                    _keepAlives = v;
                    _builtIndices.clear();
                  })),
                  SizedBox(width: 8),
                  _toggleChip('RepaintBoundary', _repaintBoundaries, (v) => setState(() {
                    _repaintBoundaries = v;
                    _builtIndices.clear();
                  })),
                ],
              ),
            ],
          ),
        ),
        // Scrollable list
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (!_builtIndices.contains(index)) {
                      _builtIndices.add(index);
                      print('[Builder] built index $index (total: ${_builtIndices.length})');
                      // Schedule a rebuild to update the dashboard
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) setState(() {});
                      });
                    }
                    final hue = (index * 360 / _totalItems) % 360;
                    final color = HSVColor.fromAHSV(1, hue, 0.35, 0.95).toColor();
                    return Container(
                      key: ValueKey(index),
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      height: 52,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 30, height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text('${index + 1}',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _kTextDark)),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text('Item ${index + 1} of $_totalItems',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _kTextDark)),
                          ),
                          Text('hue ${hue.toInt()}°',
                              style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: _kTextMuted)),
                        ],
                      ),
                    );
                  },
                  childCount: _totalItems,
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
            Text(label, style: TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.w600)),
            Text(value, style: TextStyle(color: _kCoral, fontFamily: 'monospace', fontSize: 13, fontWeight: FontWeight.w700)),
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
            color: value ? _kCoral.withOpacity(0.3) : Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: value ? _kCoral : Colors.white24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(value ? Icons.check_box : Icons.check_box_outline_blank,
                  color: value ? _kCoral : Colors.white54, size: 16),
              SizedBox(width: 6),
              Expanded(
                child: Text(label,
                    style: TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3: Separator pattern
// ═══════════════════════════════════════════════════════════
class _SeparatorDemoPage extends StatefulWidget {
  @override
  State<_SeparatorDemoPage> createState() => _SeparatorDemoPageState();
}

class _SeparatorDemoPageState extends State<_SeparatorDemoPage> {
  bool _showSeparators = true;
  int _groupSize = 5;

  @override
  Widget build(BuildContext context) {
    final totalLogicalItems = 30;

    return Column(
      children: [
        // Controls
        Container(
          padding: EdgeInsets.all(12),
          color: _kIndigoDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SEPARATOR PATTERN',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 6),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _showSeparators = !_showSeparators),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _showSeparators ? _kCoral.withOpacity(0.3) : Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _showSeparators ? _kCoral : Colors.white24),
                      ),
                      child: Text(_showSeparators ? 'Separators ON' : 'Separators OFF',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Group: $_groupSize',
                      style: TextStyle(color: Colors.white70, fontSize: 11)),
                  Expanded(
                    child: Slider(
                      value: _groupSize.toDouble(), min: 2, max: 10, divisions: 8,
                      activeColor: _kCoral,
                      onChanged: (v) => setState(() => _groupSize = v.toInt()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                _showSeparators
                    ? 'Builder uses index math: odd indices → separator, even → item. '
                      'semanticIndexCallback skips separators.'
                    : 'Standard 1:1 builder — one widget per index.',
                style: TextStyle(color: Colors.white70, fontSize: 10.5, height: 1.3),
              ),
            ],
          ),
        ),
        // List
        Expanded(
          child: CustomScrollView(
            slivers: [
              if (_showSeparators)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Separator pattern: even = item, odd = separator
                      final itemIndex = index ~/ 2;
                      if (index.isOdd) {
                        // Separator
                        final isGroupBoundary = (itemIndex + 1) % _groupSize == 0;
                        return Container(
                          height: isGroupBoundary ? 24 : 1,
                          margin: EdgeInsets.symmetric(horizontal: isGroupBoundary ? 0 : 16),
                          color: isGroupBoundary
                              ? _kIndigoLight.withOpacity(0.5)
                              : _kDivider,
                          child: isGroupBoundary
                              ? Center(child: Text('Group ${(itemIndex ~/ _groupSize) + 1} / ${(itemIndex ~/ _groupSize) + 2}',
                                  style: TextStyle(fontSize: 10, color: _kIndigoDark, fontWeight: FontWeight.w600)))
                              : null,
                        );
                      }
                      // Item
                      final hue = (itemIndex * 12.0) % 360;
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        height: 50,
                        decoration: BoxDecoration(
                          color: HSVColor.fromAHSV(1, hue, 0.25, 0.97).toColor(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text('Item ${itemIndex + 1}',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: _kTextDark)),
                      );
                    },
                    childCount: totalLogicalItems * 2 - 1,
                    semanticIndexCallback: (widget, localIndex) => localIndex ~/ 2,
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final hue = (index * 12.0) % 360;
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                        height: 50,
                        decoration: BoxDecoration(
                          color: HSVColor.fromAHSV(1, hue, 0.25, 0.97).toColor(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text('Item ${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: _kTextDark)),
                      );
                    },
                    childCount: totalLogicalItems,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
