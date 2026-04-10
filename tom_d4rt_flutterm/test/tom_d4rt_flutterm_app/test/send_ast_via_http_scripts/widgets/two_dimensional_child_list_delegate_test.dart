import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ListDelegateDeepDemo();
}

const Color _kNight = Color(0xFF111827);
const Color _kCanvas = Color(0xFFFFFBEB);
const Color _kGold = Color(0xFFFBBF24);

class _ListDelegateDeepDemo extends StatefulWidget {
  const _ListDelegateDeepDemo();

  @override
  State<_ListDelegateDeepDemo> createState() => _ListDelegateDeepDemoState();
}

class _ListDelegateDeepDemoState extends State<_ListDelegateDeepDemo>
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
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: _kNight,
        foregroundColor: Colors.white,
        title: const Text('TwoDimensionalChildListDelegate Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kGold,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Matrix Composer'),
            Tab(text: 'Ragged Rows'),
            Tab(text: 'List vs Builder'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _OverviewPanel(),
          _MatrixComposerPanel(),
          _RaggedRowsPanel(),
          _ListVsBuilderPanel(),
        ],
      ),
    );
  }
}

class _OverviewPanel extends StatelessWidget {
  const _OverviewPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _TopCard(
          title: 'Explicit 2D Child Matrices',
          body:
              'TwoDimensionalChildListDelegate is ideal when your full matrix '
              'is already known. You provide a concrete List<List<Widget>> and '
              'the viewport resolves vicinities against that list.',
        ),
        SizedBox(height: 12),
        _InsightCard(
          title: 'Strengths',
          tint: Color(0xFF14532D),
          bullets: [
            'Deterministic structure and direct visual curation.',
            'Simple authoring for dashboards, control boards, and static maps.',
            'Supports ragged row shapes naturally.',
            'Excellent for showcasing designed panels with unique cells.',
          ],
        ),
        _InsightCard(
          title: 'Trade-offs',
          tint: Color(0xFF1D4ED8),
          bullets: [
            'All widgets are prepared in the source matrix.',
            'Less suitable for very large or infinite domains.',
            'Data mutation usually means matrix replacement and rebuild.',
            'Memory profile grows with full matrix size.',
          ],
        ),
        _InsightCard(
          title: 'Best fit scenarios',
          tint: Color(0xFF9A3412),
          bullets: [
            'Finite control surfaces and operations grids.',
            'Preset board-game or tactical map layouts.',
            'Learning environments with fixed content sets.',
            'UI test harnesses where each coordinate has hand-authored meaning.',
          ],
        ),
        SizedBox(height: 12),
        _AxisMappingCard(),
      ],
    );
  }
}

class _AxisMappingCard extends StatelessWidget {
  const _AxisMappingCard();

  @override
  Widget build(BuildContext context) {
    final rows = <String>[
      'children[y][x] maps y = vertical row, x = horizontal column.',
      'Different row lengths create sparse right-side gaps.',
      'Missing positions resolve to null in build lookup.',
      'Structure is explicit, ideal for curated panels.',
    ];
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Axis Mapping', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (final row in rows)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• $row'),
              ),
          ],
        ),
      ),
    );
  }
}

class _MatrixComposerPanel extends StatefulWidget {
  const _MatrixComposerPanel();

  @override
  State<_MatrixComposerPanel> createState() => _MatrixComposerPanelState();
}

class _MatrixComposerPanelState extends State<_MatrixComposerPanel> {
  int _rows = 5;
  int _cols = 6;
  int _themeIndex = 0;
  bool _showBadges = true;
  bool _keepAlive = true;

  static const List<List<Color>> _palettes = [
    [Color(0xFF7C3AED), Color(0xFFC4B5FD), Color(0xFFDDD6FE)],
    [Color(0xFF047857), Color(0xFF6EE7B7), Color(0xFFA7F3D0)],
    [Color(0xFF1D4ED8), Color(0xFF93C5FD), Color(0xFFDBEAFE)],
    [Color(0xFF9A3412), Color(0xFFFDE68A), Color(0xFFFEF3C7)],
  ];

  List<List<Widget>> _buildMatrix() {
    final palette = _palettes[_themeIndex];
    final matrix = <List<Widget>>[];
    for (var y = 0; y < _rows; y++) {
      final row = <Widget>[];
      for (var x = 0; x < _cols; x++) {
        final color = palette[(x + y) % palette.length];
        row.add(
          Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF1F2937), width: 0.7),
            ),
            child: Center(
              child: Text(
                _showBadges ? 'R$y C$x' : 'cell',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        );
      }
      matrix.add(row);
    }
    return matrix;
  }

  @override
  Widget build(BuildContext context) {
    final matrix = _buildMatrix();
    final delegate = TwoDimensionalChildListDelegate(
      children: matrix,
      addAutomaticKeepAlives: _keepAlive,
    );
    final previewRows = <Widget>[];
    for (var y = 0; y < _rows; y++) {
      final row = <Widget>[];
      for (var x = 0; x < _cols; x++) {
        row.add(
          Expanded(
            child: SizedBox(height: 62, child: delegate.build(context, ChildVicinity(xIndex: x, yIndex: y))),
          ),
        );
      }
      previewRows.add(Row(children: row));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _TopCard(
          title: 'Matrix Composer',
          body:
              'Build a fully explicit matrix and feed it into TwoDimensionalChildListDelegate. '
              'This mirrors curated dashboards where each cell is intentionally authored.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SliderControl(
                  label: 'Rows',
                  value: _rows.toDouble(),
                  min: 2,
                  max: 10,
                  divisions: 8,
                  onChanged: (v) => setState(() => _rows = v.round()),
                ),
                _SliderControl(
                  label: 'Columns',
                  value: _cols.toDouble(),
                  min: 2,
                  max: 10,
                  divisions: 8,
                  onChanged: (v) => setState(() => _cols = v.round()),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 0; i < _palettes.length; i++)
                      ChoiceChip(
                        label: Text('Palette ${i + 1}'),
                        selected: _themeIndex == i,
                        onSelected: (_) => setState(() => _themeIndex = i),
                      ),
                    FilterChip(
                      label: const Text('Show badges'),
                      selected: _showBadges,
                      onSelected: (v) => setState(() => _showBadges = v),
                    ),
                    FilterChip(
                      label: const Text('Automatic keep alive'),
                      selected: _keepAlive,
                      onSelected: (v) => setState(() => _keepAlive = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Matrix dimensions: ${matrix.length}x${matrix.first.length}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFF1F5F9),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Delegate Output Window', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...previewRows,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RaggedRowsPanel extends StatefulWidget {
  const _RaggedRowsPanel();

  @override
  State<_RaggedRowsPanel> createState() => _RaggedRowsPanelState();
}

class _RaggedRowsPanelState extends State<_RaggedRowsPanel> {
  int _pattern = 0;
  final List<String> _events = <String>['Ragged rows demo ready'];

  List<List<Widget>> _matrixByPattern() {
    if (_pattern == 0) {
      return [
        _makeRow(5, const Color(0xFFFCA5A5), 'A'),
        _makeRow(3, const Color(0xFFFCD34D), 'B'),
        _makeRow(6, const Color(0xFF86EFAC), 'C'),
        _makeRow(2, const Color(0xFFA5B4FC), 'D'),
      ];
    }
    if (_pattern == 1) {
      return [
        _makeRow(2, const Color(0xFFFBCFE8), 'X'),
        _makeRow(7, const Color(0xFFBFDBFE), 'Y'),
        _makeRow(4, const Color(0xFFFDE68A), 'Z'),
      ];
    }
    return [
      _makeRow(8, const Color(0xFFC7D2FE), 'M'),
      _makeRow(1, const Color(0xFFFED7AA), 'N'),
      _makeRow(5, const Color(0xFFA7F3D0), 'P'),
      _makeRow(3, const Color(0xFFFBCFE8), 'Q'),
      _makeRow(6, const Color(0xFFDDD6FE), 'R'),
    ];
  }

  List<Widget> _makeRow(int count, Color color, String prefix) {
    return [
      for (var i = 0; i < count; i++)
        Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF374151), width: 0.6),
          ),
          child: Center(
            child: Text('$prefix$i', style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final matrix = _matrixByPattern();
    var maxColumns = 0;
    for (final row in matrix) {
      if (row.length > maxColumns) {
        maxColumns = row.length;
      }
    }

    final delegate = TwoDimensionalChildListDelegate(children: matrix);
    final rows = <Widget>[];
    for (var y = 0; y < matrix.length; y++) {
      final cells = <Widget>[];
      for (var x = 0; x < maxColumns; x++) {
        final child = delegate.build(context, ChildVicinity(xIndex: x, yIndex: y));
        cells.add(
          Expanded(
            child: Container(
              height: 56,
              margin: const EdgeInsets.all(2),
              child: child ?? const _GapCell(),
            ),
          ),
        );
      }
      rows.add(Row(children: cells));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _TopCard(
          title: 'Ragged Rows Lab',
          body:
              'TwoDimensionalChildListDelegate can represent non-rectangular matrices '
              'where rows have different lengths. Missing coordinates resolve to null.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Pattern A'),
                  selected: _pattern == 0,
                  onSelected: (_) => setState(() {
                    _pattern = 0;
                    _events.add('Switched to pattern A');
                  }),
                ),
                ChoiceChip(
                  label: const Text('Pattern B'),
                  selected: _pattern == 1,
                  onSelected: (_) => setState(() {
                    _pattern = 1;
                    _events.add('Switched to pattern B');
                  }),
                ),
                ChoiceChip(
                  label: const Text('Pattern C'),
                  selected: _pattern == 2,
                  onSelected: (_) => setState(() {
                    _pattern = 2;
                    _events.add('Switched to pattern C');
                  }),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFFFF7ED),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rows: ${matrix.length}, max columns: $maxColumns', style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...rows,
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
                const Text('Interaction Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final event in _events.take(12))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $event'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ListVsBuilderPanel extends StatefulWidget {
  const _ListVsBuilderPanel();

  @override
  State<_ListVsBuilderPanel> createState() => _ListVsBuilderPanelState();
}

class _ListVsBuilderPanelState extends State<_ListVsBuilderPanel> {
  int _seed = 1;

  @override
  Widget build(BuildContext context) {
    final listMatrix = <List<Widget>>[
      for (var y = 0; y < 4; y++)
        [
          for (var x = 0; x < 5; x++)
            Container(
              decoration: BoxDecoration(
                color: HSLColor.fromAHSL(1, ((x + y + _seed) * 27 % 360).toDouble(), 0.55, 0.72).toColor(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('L$x,$y')),
            ),
        ],
    ];

    final listDelegate = TwoDimensionalChildListDelegate(children: listMatrix);
    final builderDelegate = TwoDimensionalChildBuilderDelegate(
      maxXIndex: 4,
      maxYIndex: 3,
      builder: (context, vicinity) {
        return Container(
          decoration: BoxDecoration(
            color: HSLColor.fromAHSL(1, ((vicinity.xIndex + vicinity.yIndex + _seed) * 27 % 360).toDouble(), 0.55, 0.72).toColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Text('B${vicinity.xIndex},${vicinity.yIndex}')),
        );
      },
    );

    final rows = <Widget>[];
    for (var y = 0; y < 4; y++) {
      rows.add(
        Row(
          children: [
            for (var x = 0; x < 5; x++)
              Expanded(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.all(2),
                  child: listDelegate.build(context, ChildVicinity(xIndex: x, yIndex: y)),
                ),
              ),
          ],
        ),
      );
    }

    final rowsBuilder = <Widget>[];
    for (var y = 0; y < 4; y++) {
      rowsBuilder.add(
        Row(
          children: [
            for (var x = 0; x < 5; x++)
              Expanded(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.all(2),
                  child: builderDelegate.build(context, ChildVicinity(xIndex: x, yIndex: y)),
                ),
              ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _TopCard(
          title: 'List Delegate vs Builder Delegate',
          body:
              'Both delegates can render similar results for finite matrices. '
              'The key difference is data source style: explicit list versus computed builder callback.',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            FilledButton(
              onPressed: () => setState(() => _seed++),
              child: const Text('Mutate Seed'),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('Use ListDelegate for curated static grids and BuilderDelegate for computed/lazy grids.'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('List Delegate Output', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...rows,
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
                const Text('Builder Delegate Output', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...rowsBuilder,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GapCell extends StatelessWidget {
  const _GapCell();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF9CA3AF)),
      ),
      child: const Center(child: Text('null')), 
    );
  }
}

class _TopCard extends StatelessWidget {
  const _TopCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.title, required this.tint, required this.bullets});

  final String title;
  final Color tint;
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: tint)),
              const SizedBox(height: 6),
              for (final bullet in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $bullet'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderControl extends StatelessWidget {
  const _SliderControl({
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
