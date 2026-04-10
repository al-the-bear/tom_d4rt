import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _BuilderDelegateDeepDemo();
}

const Color _kInk = Color(0xFF1F2937);
const Color _kSky = Color(0xFFDFF4FF);
const Color _kMint = Color(0xFFB8F2E6);
const Color _kPaper = Color(0xFFF7FBFF);

class _BuilderDelegateDeepDemo extends StatefulWidget {
  const _BuilderDelegateDeepDemo();

  @override
  State<_BuilderDelegateDeepDemo> createState() => _BuilderDelegateDeepDemoState();
}

class _BuilderDelegateDeepDemoState extends State<_BuilderDelegateDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPaper,
      appBar: AppBar(
        backgroundColor: _kInk,
        foregroundColor: Colors.white,
        title: const Text('TwoDimensionalChildBuilderDelegate Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kMint,
          tabs: const [
            Tab(text: 'Concept Atlas'),
            Tab(text: 'Viewport Lab'),
            Tab(text: 'Delegate Swap'),
            Tab(text: 'Edge Cases'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConceptAtlasPanel(),
          _ViewportLabPanel(),
          _DelegateSwapPanel(),
          _EdgeCasesPanel(),
        ],
      ),
    );
  }
}

class _ConceptAtlasPanel extends StatelessWidget {
  const _ConceptAtlasPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HeaderCard(
          title: 'What This Delegate Is For',
          description:
              'TwoDimensionalChildBuilderDelegate is a lazy child factory for '
              'two-axis scrolling surfaces. It creates cells by vicinity only '
              'when the viewport asks for them.',
        ),
        SizedBox(height: 12),
        _DetailCard(
          tone: Color(0xFF0F766E),
          title: 'Core contract',
          bullets: [
            'builder(context, vicinity) returns a widget for one cell location.',
            'maxXIndex / maxYIndex cap the finite matrix when needed.',
            'Returning null can terminate sparse or bounded regions.',
            'repaintBoundaries and keep-alive behavior tune perf/state tradeoffs.',
          ],
        ),
        _DetailCard(
          tone: Color(0xFF4338CA),
          title: 'Why builder delegates scale',
          bullets: [
            'You avoid constructing all cells up front.',
            'Expensive visuals only appear for visible vicinities.',
            'State strategy is explicit via automatic keep alive choices.',
            'Data can be streamed, paged, or virtually computed on demand.',
          ],
        ),
        _DetailCard(
          tone: Color(0xFF9A3412),
          title: 'Typical use cases',
          bullets: [
            'Spreadsheet-like editors with dynamic row/column sizes.',
            'Large 2D galleries with lazy thumbnail hydration.',
            'Telemetry heatmaps where cells map to live metrics.',
            'Any grid with sparse occupancy and frequent viewport moves.',
          ],
        ),
        SizedBox(height: 12),
        _SignalBoard(),
      ],
    );
  }
}

class _SignalBoard extends StatelessWidget {
  const _SignalBoard();

  @override
  Widget build(BuildContext context) {
    final items = <_SignalItem>[
      const _SignalItem('Build Trigger', 'Viewport requests vicinity (x,y)', Icons.apps),
      const _SignalItem('Data Access', 'Lookup value for vicinity', Icons.storage),
      const _SignalItem('Widget Fabrication', 'Construct display tile', Icons.precision_manufacturing),
      const _SignalItem('Cache/Reuse', 'Keep alive or recycle cell', Icons.loop),
    ];

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Signal Flow', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(item.icon, size: 18, color: const Color(0xFF1D4ED8)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('${item.title}: ${item.detail}'),
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

class _ViewportLabPanel extends StatefulWidget {
  const _ViewportLabPanel();

  @override
  State<_ViewportLabPanel> createState() => _ViewportLabPanelState();
}

class _ViewportLabPanelState extends State<_ViewportLabPanel> {
  int _maxX = 36;
  int _maxY = 28;
  int _viewportX = 6;
  int _viewportY = 5;
  int _offsetX = 0;
  int _offsetY = 0;
  bool _keepAlive = true;
  bool _repaintBoundaries = true;
  final Map<String, int> _buildCounts = <String, int>{};

  Widget _buildCell(BuildContext context, ChildVicinity vicinity) {
    final key = '${vicinity.xIndex}:${vicinity.yIndex}';
    _buildCounts[key] = (_buildCounts[key] ?? 0) + 1;
    final hue = ((vicinity.xIndex * 21 + vicinity.yIndex * 11) % 360).toDouble();
    final hsl = HSLColor.fromAHSL(1.0, hue, 0.55, 0.72);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: hsl.toColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF334155), width: 0.8),
      ),
      child: Text(
        'x${vicinity.xIndex} y${vicinity.yIndex}\n#${_buildCounts[key]}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final delegate = TwoDimensionalChildBuilderDelegate(
      maxXIndex: _maxX,
      maxYIndex: _maxY,
      addAutomaticKeepAlives: _keepAlive,
      addRepaintBoundaries: _repaintBoundaries,
      builder: _buildCell,
    );
    final visibleCells = <Widget>[];

    for (var y = _offsetY; y < _offsetY + _viewportY; y++) {
      final rowChildren = <Widget>[];
      for (var x = _offsetX; x < _offsetX + _viewportX; x++) {
        final inRange = x <= _maxX && y <= _maxY;
        if (!inRange) {
          rowChildren.add(
            Expanded(
              child: Container(
                height: 66,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('null', style: TextStyle(color: Color(0xFF64748B)))),
              ),
            ),
          );
          continue;
        }
        final cell = _buildCell(context, ChildVicinity(xIndex: x, yIndex: y));
        rowChildren.add(
          Expanded(
            child: Container(height: 66, margin: const EdgeInsets.all(2), child: cell),
          ),
        );
      }
      visibleCells.add(Row(children: rowChildren));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeaderCard(
          title: 'Viewport Lab',
          description:
              'This lab emulates a moving two-dimensional viewport and uses the '
              'same builder callback passed into TwoDimensionalChildBuilderDelegate '
              'so you can inspect lazy fabrication patterns.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Delegate Settings', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                _SliderLine(
                  label: 'maxXIndex',
                  value: _maxX.toDouble(),
                  min: 8,
                  max: 80,
                  divisions: 72,
                  onChanged: (v) => setState(() => _maxX = v.round()),
                ),
                _SliderLine(
                  label: 'maxYIndex',
                  value: _maxY.toDouble(),
                  min: 8,
                  max: 80,
                  divisions: 72,
                  onChanged: (v) => setState(() => _maxY = v.round()),
                ),
                Row(
                  children: [
                    FilterChip(
                      label: const Text('Automatic keep-alive'),
                      selected: _keepAlive,
                      onSelected: (v) => setState(() => _keepAlive = v),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Repaint boundaries'),
                      selected: _repaintBoundaries,
                      onSelected: (v) => setState(() => _repaintBoundaries = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Configured delegate: maxX=${delegate.maxXIndex}, maxY=${delegate.maxYIndex}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Viewport Controls', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                _SliderLine(
                  label: 'Viewport width (cells)',
                  value: _viewportX.toDouble(),
                  min: 3,
                  max: 10,
                  divisions: 7,
                  onChanged: (v) => setState(() => _viewportX = v.round()),
                ),
                _SliderLine(
                  label: 'Viewport height (cells)',
                  value: _viewportY.toDouble(),
                  min: 3,
                  max: 10,
                  divisions: 7,
                  onChanged: (v) => setState(() => _viewportY = v.round()),
                ),
                _SliderLine(
                  label: 'Offset x',
                  value: _offsetX.toDouble(),
                  min: 0,
                  max: 60,
                  divisions: 60,
                  onChanged: (v) => setState(() => _offsetX = v.round()),
                ),
                _SliderLine(
                  label: 'Offset y',
                  value: _offsetY.toDouble(),
                  min: 0,
                  max: 60,
                  divisions: 60,
                  onChanged: (v) => setState(() => _offsetY = v.round()),
                ),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () => setState(() {
                        _offsetX = (_offsetX + 3).clamp(0, 60);
                        _offsetY = (_offsetY + 2).clamp(0, 60);
                      }),
                      child: const Text('Pan Diagonal'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () => setState(() => _buildCounts.clear()),
                      child: const Text('Reset Build Counts'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kSky,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Visible Cell Window', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...visibleCells,
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _BuildStatsCard(buildCounts: _buildCounts),
      ],
    );
  }
}

class _BuildStatsCard extends StatelessWidget {
  const _BuildStatsCard({required this.buildCounts});

  final Map<String, int> buildCounts;

  @override
  Widget build(BuildContext context) {
    final entries = buildCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top = entries.take(12).toList();
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Build Metrics: ${buildCounts.length} unique vicinities',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            if (top.isEmpty)
              const Text('No cells have been built yet.')
            else
              for (final entry in top)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('${entry.key} -> ${entry.value} build(s)'),
                ),
          ],
        ),
      ),
    );
  }
}

class _DelegateSwapPanel extends StatefulWidget {
  const _DelegateSwapPanel();

  @override
  State<_DelegateSwapPanel> createState() => _DelegateSwapPanelState();
}

class _DelegateSwapPanelState extends State<_DelegateSwapPanel> {
  bool _dense = true;
  bool _keepAlive = true;
  bool _repaint = true;
  int _seed = 1;

  Widget _denseBuilder(BuildContext context, ChildVicinity vicinity) {
    final color = Color(0xFF0369A1 + ((vicinity.xIndex + vicinity.yIndex + _seed) % 4) * 0x00101010);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'D ${vicinity.xIndex},${vicinity.yIndex}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget? _sparseBuilder(BuildContext context, ChildVicinity vicinity) {
    final allowed = (vicinity.xIndex + vicinity.yIndex + _seed) % 3 != 0;
    if (!allowed) {
      return null;
    }
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF581C87), Color(0xFF9333EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'S ${vicinity.xIndex},${vicinity.yIndex}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final delegate = _dense
        ? TwoDimensionalChildBuilderDelegate(
            maxXIndex: 11,
            maxYIndex: 8,
            addAutomaticKeepAlives: _keepAlive,
            addRepaintBoundaries: _repaint,
            builder: _denseBuilder,
          )
        : TwoDimensionalChildBuilderDelegate(
            maxXIndex: 11,
            maxYIndex: 8,
            addAutomaticKeepAlives: _keepAlive,
            addRepaintBoundaries: _repaint,
            builder: _sparseBuilder,
          );

    final cells = <Widget>[];
    for (var y = 0; y < 5; y++) {
      final row = <Widget>[];
      for (var x = 0; x < 6; x++) {
        final child = _dense ? _denseBuilder(context, ChildVicinity(xIndex: x, yIndex: y)) : _sparseBuilder(context, ChildVicinity(xIndex: x, yIndex: y));
        row.add(
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(3),
              height: 56,
              child: child ?? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF1F5F9),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: const Center(child: Text('null')), 
              ),
            ),
          ),
        );
      }
      cells.add(Row(children: row));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeaderCard(
          title: 'Delegate Swap Bench',
          description:
              'Compare dense and sparse builder strategies, and inspect how '
              'configuration flags alter state retention and repaint strategy.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Dense delegate'),
                      selected: _dense,
                      onSelected: (_) => setState(() => _dense = true),
                    ),
                    ChoiceChip(
                      label: const Text('Sparse delegate (null gaps)'),
                      selected: !_dense,
                      onSelected: (_) => setState(() => _dense = false),
                    ),
                    FilterChip(
                      label: const Text('Keep alive'),
                      selected: _keepAlive,
                      onSelected: (v) => setState(() => _keepAlive = v),
                    ),
                    FilterChip(
                      label: const Text('Repaint boundaries'),
                      selected: _repaint,
                      onSelected: (v) => setState(() => _repaint = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => setState(() => _seed++),
                  child: const Text('Mutate Data Seed (force new visuals)'),
                ),
                const SizedBox(height: 8),
                Text(
                  'Delegate summary: maxX=${delegate.maxXIndex}, maxY=${delegate.maxYIndex}, '
                  'keepAlive=$_keepAlive, repaint=$_repaint',
                ),
                const SizedBox(height: 8),
                const Text(
                  'When swapping delegates, shouldRebuild determines whether '
                  'existing children are invalidated and recreated.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kMint,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rendered Sample Window', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...cells,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EdgeCasesPanel extends StatefulWidget {
  const _EdgeCasesPanel();

  @override
  State<_EdgeCasesPanel> createState() => _EdgeCasesPanelState();
}

class _EdgeCasesPanelState extends State<_EdgeCasesPanel> {
  bool _bounded = true;
  int _requests = 8;
  final List<String> _log = <String>['Edge case inspector initialized'];

  Widget? _inspectorBuilder(BuildContext context, ChildVicinity vicinity) {
    final allow = !_bounded || (vicinity.xIndex <= 4 && vicinity.yIndex <= 3);
    _log.add('request ${vicinity.xIndex},${vicinity.yIndex} -> ${allow ? 'widget' : 'null'}');
    if (_log.length > 28) {
      _log.removeAt(0);
    }
    if (!allow) {
      return null;
    }
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4338CA)),
      ),
      child: Center(
        child: Text('(${vicinity.xIndex}, ${vicinity.yIndex})'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final delegate = TwoDimensionalChildBuilderDelegate(
      maxXIndex: _bounded ? 4 : null,
      maxYIndex: _bounded ? 3 : null,
      builder: _inspectorBuilder,
    );
    final previews = <Widget>[];
    for (var i = 0; i < _requests; i++) {
      final x = i % 7;
      final y = (i * 2) % 6;
      final child = _inspectorBuilder(context, ChildVicinity(xIndex: x, yIndex: y));
      previews.add(
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              SizedBox(width: 140, child: Text('vicinity ($x,$y)')),
              Expanded(child: SizedBox(height: 44, child: child ?? const _NullCellBadge())),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeaderCard(
          title: 'Edge Cases and Boundaries',
          description:
              'This panel focuses on nullable builder responses, finite bounds, '
              'and request traces that help debug delegates during viewport churn.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Bounded mode (maxX=4, maxY=3)'),
                  value: _bounded,
                  onChanged: (v) => setState(() => _bounded = v),
                ),
                _SliderLine(
                  label: 'Synthetic request count',
                  value: _requests.toDouble(),
                  min: 4,
                  max: 20,
                  divisions: 16,
                  onChanged: (v) => setState(() => _requests = v.round()),
                ),
                Text('Delegate maxXIndex: ${delegate.maxXIndex}'),
                Text('Delegate maxYIndex: ${delegate.maxYIndex}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFEEF2FF),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Request Preview', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...previews,
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recent Build Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _log)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text('• $line'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NullCellBadge extends StatelessWidget {
  const _NullCellBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF1F5F9),
        border: Border.all(color: const Color(0xFF94A3B8)),
      ),
      child: const Text('null (outside boundary)'),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.tone, required this.title, required this.bullets});

  final Color tone;
  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: tone)),
              const SizedBox(height: 6),
              for (final line in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $line'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderLine extends StatelessWidget {
  const _SliderLine({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.round()}'),
        Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged),
      ],
    );
  }
}

class _SignalItem {
  const _SignalItem(this.title, this.detail, this.icon);

  final String title;
  final String detail;
  final IconData icon;
}
