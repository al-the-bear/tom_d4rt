import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ChildDelegateDeepDemo();
}

const Color _kSlate = Color(0xFF0F172A);
const Color _kIce = Color(0xFFEFF6FF);
const Color _kLime = Color(0xFFD9F99D);

class _ChildDelegateDeepDemo extends StatefulWidget {
  const _ChildDelegateDeepDemo();

  @override
  State<_ChildDelegateDeepDemo> createState() => _ChildDelegateDeepDemoState();
}

class _ChildDelegateDeepDemoState extends State<_ChildDelegateDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kIce,
      appBar: AppBar(
        backgroundColor: _kSlate,
        foregroundColor: Colors.white,
        title: const Text('TwoDimensionalChildDelegate Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kLime,
          tabs: const [
            Tab(text: 'Contract'),
            Tab(text: 'Vicinity Prober'),
            Tab(text: 'Rebuild Matrix'),
            Tab(text: 'Integration Playbook'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ContractPanel(),
          _VicinityProberPanel(),
          _RebuildMatrixPanel(),
          _IntegrationPlaybookPanel(),
        ],
      ),
    );
  }
}

class _ContractPanel extends StatelessWidget {
  const _ContractPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _LeadCard(
          title: 'Abstract Contract for 2D Child Provision',
          body:
              'TwoDimensionalChildDelegate is the protocol a viewport uses to '
              'request widgets by ChildVicinity. Concrete delegates decide what '
              'exists at each coordinate and when a rebuild is required.',
        ),
        SizedBox(height: 12),
        _BulletCard(
          title: 'Methods and properties that matter',
          color: Color(0xFF14532D),
          bullets: [
            'build(context, vicinity) -> Widget? for a coordinate.',
            'shouldRebuild(oldDelegate) controls invalidation behavior.',
            'maxXIndex/maxYIndex can bound known extents.',
            'keepAlive/repaint choices shape performance characteristics.',
          ],
        ),
        _BulletCard(
          title: 'Mental model',
          color: Color(0xFF1E3A8A),
          bullets: [
            'Viewport asks for visible cells only.',
            'Delegate maps each request to widget or null.',
            'Element management and cache policy happen around the contract.',
            'Rebuild policy decides whether existing render units survive.',
          ],
        ),
        _BulletCard(
          title: 'What this demo emphasizes',
          color: Color(0xFF9A3412),
          bullets: [
            'How ChildVicinity routing works in practice.',
            'How two delegates can express different occupancy rules.',
            'How shouldRebuild changes lifecycle and cost profile.',
            'How to choose delegate strategy per product behavior.',
          ],
        ),
        SizedBox(height: 12),
        _ContractFlowCard(),
      ],
    );
  }
}

class _ContractFlowCard extends StatelessWidget {
  const _ContractFlowCard();

  @override
  Widget build(BuildContext context) {
    final steps = <_FlowStep>[
      const _FlowStep('1', 'Viewport picks a visible vicinity window.'),
      const _FlowStep('2', 'Delegate build() is queried for each needed cell.'),
      const _FlowStep('3', 'Null responses become empty regions / terminate ranges.'),
      const _FlowStep('4', 'Rebuild decision runs when delegate instance changes.'),
      const _FlowStep('5', 'Cache and painting wrappers apply around produced child.'),
    ];

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Contract Flow', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (final step in steps)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: Color(0xFF1E3A8A), shape: BoxShape.circle),
                      child: Text(step.id, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(step.text)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _VicinityProberPanel extends StatefulWidget {
  const _VicinityProberPanel();

  @override
  State<_VicinityProberPanel> createState() => _VicinityProberPanelState();
}

class _VicinityProberPanelState extends State<_VicinityProberPanel> {
  int _x = 0;
  int _y = 0;
  int _maxX = 12;
  int _maxY = 9;
  bool _sparseRule = false;
  final List<String> _log = <String>['Prober initialized'];

  Widget? _activeBuilder(BuildContext context, ChildVicinity vicinity) {
    final inBounds = vicinity.xIndex <= _maxX && vicinity.yIndex <= _maxY;
    if (!inBounds) {
      return null;
    }
    if (_sparseRule && (vicinity.xIndex + vicinity.yIndex) % 4 == 0) {
      return null;
    }
    final hue = ((vicinity.xIndex * 31 + vicinity.yIndex * 17) % 360).toDouble();
    final color = HSLColor.fromAHSL(1, hue, 0.58, 0.7).toColor();
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Center(
        child: Text(
          'Cell (${vicinity.xIndex}, ${vicinity.yIndex})',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TwoDimensionalChildDelegate delegate = TwoDimensionalChildBuilderDelegate(
      maxXIndex: _maxX,
      maxYIndex: _maxY,
      builder: _activeBuilder,
    );

    final vicinity = ChildVicinity(xIndex: _x, yIndex: _y);
    final child = delegate.build(context, vicinity);
    final state = child == null ? 'null (no child)' : 'widget produced';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'Vicinity Prober',
          body:
              'Move the request coordinate and inspect what build() returns for '
              'the current delegate rules. This reveals occupancy and boundary behavior.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ValueSlider(
                  label: 'Request xIndex',
                  value: _x.toDouble(),
                  min: 0,
                  max: 20,
                  divisions: 20,
                  onChanged: (v) => setState(() => _x = v.round()),
                ),
                _ValueSlider(
                  label: 'Request yIndex',
                  value: _y.toDouble(),
                  min: 0,
                  max: 20,
                  divisions: 20,
                  onChanged: (v) => setState(() => _y = v.round()),
                ),
                _ValueSlider(
                  label: 'maxXIndex',
                  value: _maxX.toDouble(),
                  min: 4,
                  max: 20,
                  divisions: 16,
                  onChanged: (v) => setState(() => _maxX = v.round()),
                ),
                _ValueSlider(
                  label: 'maxYIndex',
                  value: _maxY.toDouble(),
                  min: 4,
                  max: 20,
                  divisions: 16,
                  onChanged: (v) => setState(() => _maxY = v.round()),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Enable sparse occupancy rule'),
                  subtitle: const Text('Null every 4th diagonal cell by index sum'),
                  value: _sparseRule,
                  onChanged: (v) => setState(() => _sparseRule = v),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _log.add('build(${vicinity.xIndex}, ${vicinity.yIndex}) => $state');
                          if (_log.length > 24) {
                            _log.removeAt(0);
                          }
                        });
                      },
                      child: const Text('Probe Build'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () => setState(() => _log.clear()),
                      child: const Text('Clear Log'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFDCFCE7),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current probe result: $state', style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                SizedBox(height: 120, child: child ?? const _NullResultPane()),
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
                const Text('Probe Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _log)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
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

class _RebuildMatrixPanel extends StatefulWidget {
  const _RebuildMatrixPanel();

  @override
  State<_RebuildMatrixPanel> createState() => _RebuildMatrixPanelState();
}

class _RebuildMatrixPanelState extends State<_RebuildMatrixPanel> {
  int _seedOld = 1;
  int _seedNew = 1;
  bool _sameBounds = true;
  bool _sameFlags = true;

  Widget _seedBuilder(int seed, BuildContext context, ChildVicinity vicinity) {
    final color = HSLColor.fromAHSL(1, ((vicinity.xIndex + vicinity.yIndex + seed) * 19 % 360).toDouble(), 0.45, 0.68).toColor();
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text('seed:$seed\n${vicinity.xIndex},${vicinity.yIndex}', textAlign: TextAlign.center)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final oldDelegate = TwoDimensionalChildBuilderDelegate(
      maxXIndex: _sameBounds ? 8 : 6,
      maxYIndex: _sameBounds ? 8 : 5,
      addAutomaticKeepAlives: _sameFlags,
      addRepaintBoundaries: _sameFlags,
      builder: (ctx, v) => _seedBuilder(_seedOld, ctx, v),
    );

    final newDelegate = TwoDimensionalChildBuilderDelegate(
      maxXIndex: 8,
      maxYIndex: 8,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      builder: (ctx, v) => _seedBuilder(_seedNew, ctx, v),
    );

    final rebuild = newDelegate.shouldRebuild(oldDelegate);
    final previewRows = <Widget>[];
    for (var y = 0; y < 3; y++) {
      previewRows.add(
        Row(
          children: [
            for (var x = 0; x < 4; x++)
              Expanded(
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.all(3),
                  child: newDelegate.build(context, ChildVicinity(xIndex: x, yIndex: y))!,
                ),
              ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'Rebuild Matrix',
          body:
              'Compare an old and new delegate and inspect shouldRebuild outcome. '
              'This determines whether the viewport invalidates previously built children.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ValueSlider(
                  label: 'Old delegate seed',
                  value: _seedOld.toDouble(),
                  min: 1,
                  max: 9,
                  divisions: 8,
                  onChanged: (v) => setState(() => _seedOld = v.round()),
                ),
                _ValueSlider(
                  label: 'New delegate seed',
                  value: _seedNew.toDouble(),
                  min: 1,
                  max: 9,
                  divisions: 8,
                  onChanged: (v) => setState(() => _seedNew = v.round()),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Old delegate uses same bounds'),
                  value: _sameBounds,
                  onChanged: (v) => setState(() => _sameBounds = v),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Old delegate uses same keepAlive/repaint flags'),
                  value: _sameFlags,
                  onChanged: (v) => setState(() => _sameFlags = v),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: rebuild ? const Color(0xFFFEE2E2) : const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'shouldRebuild result: $rebuild',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFE2E8F0),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Delegate Preview Cells', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _IntegrationPlaybookPanel extends StatelessWidget {
  const _IntegrationPlaybookPanel();

  @override
  Widget build(BuildContext context) {
    final tracks = <_PlaybookTrack>[
      const _PlaybookTrack(
        title: 'Static finite matrix',
        guidance: 'Use bounded indexes and deterministic builders for predictable memory.',
        icon: Icons.grid_on,
      ),
      const _PlaybookTrack(
        title: 'Streaming data wall',
        guidance: 'Return null for not-yet-loaded vicinities and hydrate incrementally.',
        icon: Icons.cloud_sync,
      ),
      const _PlaybookTrack(
        title: 'Sparse occupancy map',
        guidance: 'Use vicinity rules to skip empty cells without allocating placeholders.',
        icon: Icons.scatter_plot,
      ),
      const _PlaybookTrack(
        title: 'High-interaction editor',
        guidance: 'Prefer keep alive for active edit zones to preserve local state.',
        icon: Icons.edit_note,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'Integration Playbook',
          body:
              'Practical recipes for selecting and tuning TwoDimensionalChildDelegate '
              'strategies in production UI surfaces.',
        ),
        const SizedBox(height: 12),
        for (final track in tracks)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(track.icon, color: const Color(0xFF1D4ED8)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(track.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text(track.guidance),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _NullResultPane extends StatelessWidget {
  const _NullResultPane();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF1F5F9),
        border: Border.all(color: const Color(0xFF94A3B8)),
      ),
      child: const Center(child: Text('Delegate returned null for this vicinity.')),
    );
  }
}

class _LeadCard extends StatelessWidget {
  const _LeadCard({required this.title, required this.body});

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

class _BulletCard extends StatelessWidget {
  const _BulletCard({required this.title, required this.color, required this.bullets});

  final String title;
  final Color color;
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: color)),
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

class _ValueSlider extends StatelessWidget {
  const _ValueSlider({
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

class _FlowStep {
  const _FlowStep(this.id, this.text);

  final String id;
  final String text;
}

class _PlaybookTrack {
  const _PlaybookTrack({
    required this.title,
    required this.guidance,
    required this.icon,
  });

  final String title;
  final String guidance;
  final IconData icon;
}
