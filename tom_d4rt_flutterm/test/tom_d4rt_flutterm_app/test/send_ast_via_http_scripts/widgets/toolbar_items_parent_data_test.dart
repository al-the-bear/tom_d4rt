import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ToolbarItemsParentDataDemo();
}

const Color _kPrimary = Color(0xFF1B5E20);
const Color _kAccent = Color(0xFF00ACC1);
const Color _kSurface = Color(0xFFF1F8E9);
const Color _kCard = Colors.white;
const Color _kText = Color(0xFF253238);
const Color _kCode = Color(0xFFE8F5E9);

class _ToolbarItemsParentDataDemo extends StatefulWidget {
  const _ToolbarItemsParentDataDemo();

  @override
  State<_ToolbarItemsParentDataDemo> createState() =>
      _ToolbarItemsParentDataDemoState();
}

class _ToolbarItemsParentDataDemoState extends State<_ToolbarItemsParentDataDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: const Text('ToolbarItemsParentData'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Concepts'),
            Tab(text: 'Overflow Lab'),
            Tab(text: 'Paint Timeline'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ConceptsTab(),
          _OverflowLabTab(),
          _PaintTimelineTab(),
        ],
      ),
    );
  }
}

class _ConceptsTab extends StatelessWidget {
  const _ConceptsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HeroCard(
          title: 'What ToolbarItemsParentData Solves',
          subtitle:
              'Toolbar layouts often measure more actions than they can paint. '
              'This parent data marks each child as paintable or hidden after '
              'layout decisions are made.',
          bulletPoints: const [
            'ParentData attached per child render box',
            'Stores a shouldPaint flag used in paint phase',
            'Keeps layout and painting responsibilities cleanly separated',
            'Supports overflow menus without rebuilding child list',
          ],
        ),
        const SizedBox(height: 12),
        const _SectionTitle('Inheritance and Role'),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: _ChainCard(
                title: 'Inheritance Chain',
                lines: [
                  'ParentData',
                  'BoxParentData',
                  'ContainerBoxParentData<RenderBox>',
                  'ToolbarItemsParentData',
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ChainCard(
                title: 'Key Data',
                lines: [
                  'offset: position for child painting',
                  'previousSibling / nextSibling links',
                  'shouldPaint: visibility after layout',
                  'debug-friendly string formatting',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _SectionTitle('Render Pipeline Storyboard'),
        const SizedBox(height: 8),
        const _PipelineStoryboard(),
        const SizedBox(height: 12),
        const _SectionTitle('Practical Guidance'),
        const SizedBox(height: 8),
        _AdviceCard(
          title: 'When building custom toolbar render objects',
          advice: const [
            'Measure all candidate children to know intrinsic widths.',
            'Mark only visible children as shouldPaint = true.',
            'Paint hidden children only via overflow menu content.',
            'Keep deterministic ordering to avoid visual jitter.',
          ],
        ),
        const SizedBox(height: 10),
        _AdviceCard(
          title: 'Debug strategy',
          advice: const [
            'Log each child width and resulting shouldPaint value.',
            'Visualize available width and overflow breakpoints.',
            'Verify paint sequence uses same order as layout pass.',
          ],
        ),
      ],
    );
  }
}

class _OverflowLabTab extends StatefulWidget {
  const _OverflowLabTab();

  @override
  State<_OverflowLabTab> createState() => _OverflowLabTabState();
}

class _OverflowLabTabState extends State<_OverflowLabTab> {
  double _availableWidth = 480;
  bool _showOverflowTrigger = true;
  bool _reserveGap = true;

  final List<_ToolbarEntry> _entries = const [
    _ToolbarEntry(label: 'Cut', width: 82, priority: 0, color: Color(0xFF2E7D32)),
    _ToolbarEntry(label: 'Copy', width: 96, priority: 1, color: Color(0xFF00796B)),
    _ToolbarEntry(label: 'Paste', width: 98, priority: 2, color: Color(0xFF1565C0)),
    _ToolbarEntry(label: 'Select all', width: 130, priority: 3, color: Color(0xFF6A1B9A)),
    _ToolbarEntry(label: 'Share', width: 94, priority: 4, color: Color(0xFFAD1457)),
    _ToolbarEntry(label: 'Translate', width: 124, priority: 5, color: Color(0xFFE65100)),
  ];

  @override
  Widget build(BuildContext context) {
    final result = _simulateLayout(
      entries: _entries,
      availableWidth: _availableWidth,
      reserveOverflowTrigger: _showOverflowTrigger,
      reserveGap: _reserveGap,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HeroCard(
          title: 'Interactive Overflow Simulator',
          subtitle:
              'This panel mimics how a toolbar render object can set shouldPaint '
              'on each child based on width constraints.',
          bulletPoints: const [
            'Resize available width to trigger overflow',
            'Observe visible and hidden item sets in real time',
            'Inspect per-item shouldPaint values',
          ],
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Layout Controls',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text('Available width: ${_availableWidth.toStringAsFixed(0)} px'),
                Slider(
                  value: _availableWidth,
                  min: 220,
                  max: 760,
                  onChanged: (value) => setState(() => _availableWidth = value),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  children: [
                    FilterChip(
                      label: const Text('Reserve overflow trigger'),
                      selected: _showOverflowTrigger,
                      onSelected: (value) => setState(() => _showOverflowTrigger = value),
                    ),
                    FilterChip(
                      label: const Text('Reserve inter-item gap'),
                      selected: _reserveGap,
                      onSelected: (value) => setState(() => _reserveGap = value),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Visual Toolbar Preview',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Container(
                  width: _availableWidth,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF80CBC4)),
                    color: const Color(0xFFE0F2F1),
                  ),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final item in result.visible)
                        _ToolbarChip(label: item.label, color: item.color),
                      if (result.hidden.isNotEmpty && _showOverflowTrigger)
                        const _ToolbarChip(
                          label: 'More',
                          color: Color(0xFF37474F),
                          icon: Icons.more_horiz,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Visible: ${result.visible.length} | Hidden: ${result.hidden.length} '
                  '| Consumed: ${result.consumedWidth.toStringAsFixed(0)} px',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Per-Child ParentData View',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                for (final state in result.states)
                  _ParentDataRow(
                    label: state.entry.label,
                    width: state.entry.width,
                    shouldPaint: state.shouldPaint,
                    reason: state.reason,
                    color: state.entry.color,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PaintTimelineTab extends StatefulWidget {
  const _PaintTimelineTab();

  @override
  State<_PaintTimelineTab> createState() => _PaintTimelineTabState();
}

class _PaintTimelineTabState extends State<_PaintTimelineTab> {
  int _step = 0;

  static const List<_TimelineStep> _steps = [
    _TimelineStep(
      title: '1. Child measurement',
      details:
          'Render object measures every toolbar action and records intrinsic '
          'width requirements.',
      color: Color(0xFF1565C0),
    ),
    _TimelineStep(
      title: '2. Overflow decision',
      details:
          'Layout compares accumulated widths with viewport budget and '
          'selects hidden candidates.',
      color: Color(0xFF6A1B9A),
    ),
    _TimelineStep(
      title: '3. ParentData update',
      details:
          'Each child receives shouldPaint = true or false in '
          'ToolbarItemsParentData.',
      color: Color(0xFF2E7D32),
    ),
    _TimelineStep(
      title: '4. Paint pass',
      details:
          'Painter iterates children and skips draw calls where '
          'shouldPaint is false.',
      color: Color(0xFFD84315),
    ),
    _TimelineStep(
      title: '5. Overflow menu rendering',
      details:
          'Hidden actions remain accessible from an overflow trigger, '
          'preserving command completeness.',
      color: Color(0xFF455A64),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HeroCard(
          title: 'Paint Timeline Walkthrough',
          subtitle:
              'Step through the layout and paint pipeline to see exactly where '
              'ToolbarItemsParentData is read and written.',
          bulletPoints: const [
            'Layout writes parent data',
            'Paint phase reads shouldPaint',
            'Overflow path preserves command access',
          ],
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Timeline Position',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Slider(
                  value: _step.toDouble(),
                  min: 0,
                  max: (_steps.length - 1).toDouble(),
                  divisions: _steps.length - 1,
                  onChanged: (value) => setState(() => _step = value.round()),
                ),
                Text(
                  _steps[_step].title,
                  style: TextStyle(
                    color: _steps[_step].color,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(_steps[_step].details),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Code-Level Mental Model',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _kCode,
                  ),
                  child: const Text(
                    'for (final child in toolbarChildren) {\n'
                    '  final data = child.parentData as ToolbarItemsParentData;\n'
                    '  if (!data.shouldPaint) continue;\n'
                    '  context.paintChild(child, data.offset);\n'
                    '}',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 13),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'The key insight: child objects can still be measured and '
                  'tracked in parent data while being omitted from actual paint output.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kCard,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Checklist for Robust Implementations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const _ChecklistLine('Keep layout and paint order aligned.'),
                const _ChecklistLine('Store reasons for hidden actions for debugging.'),
                const _ChecklistLine('Guarantee at least one visible primary action.'),
                const _ChecklistLine('Use overflow affordance when any hidden item exists.'),
                const _ChecklistLine('Recompute shouldPaint when constraints change.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.bulletPoints,
  });

  final String title;
  final String subtitle;
  final List<String> bulletPoints;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: _kText,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(color: _kText)),
            const SizedBox(height: 8),
            for (final point in bulletPoints)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• $point', style: const TextStyle(color: _kText)),
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: _kText),
    );
  }
}

class _ChainCard extends StatelessWidget {
  const _ChainCard({required this.title, required this.lines});

  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(line, style: const TextStyle(color: _kText)),
              ),
          ],
        ),
      ),
    );
  }
}

class _PipelineStoryboard extends StatelessWidget {
  const _PipelineStoryboard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: const [
            _StoryboardRow(step: 'Layout pass', outcome: 'Computes offsets and shouldPaint'),
            _StoryboardArrow(),
            _StoryboardRow(step: 'Paint pass', outcome: 'Skips hidden children quickly'),
            _StoryboardArrow(),
            _StoryboardRow(step: 'Overflow UI', outcome: 'Hidden items surfaced in menu'),
          ],
        ),
      ),
    );
  }
}

class _StoryboardRow extends StatelessWidget {
  const _StoryboardRow({required this.step, required this.outcome});

  final String step;
  final String outcome;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 118,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFC8E6C9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(step, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(outcome, style: const TextStyle(color: _kText))),
      ],
    );
  }
}

class _StoryboardArrow extends StatelessWidget {
  const _StoryboardArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Icon(Icons.south, color: Color(0xFF558B2F)),
    );
  }
}

class _AdviceCard extends StatelessWidget {
  const _AdviceCard({required this.title, required this.advice});

  final String title;
  final List<String> advice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kCard,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: _kText)),
            const SizedBox(height: 8),
            for (final line in advice)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• $line', style: const TextStyle(color: _kText)),
              ),
          ],
        ),
      ),
    );
  }
}

class _ToolbarChip extends StatelessWidget {
  const _ToolbarChip({required this.label, required this.color, this.icon});

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 4),
          ],
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ParentDataRow extends StatelessWidget {
  const _ParentDataRow({
    required this.label,
    required this.width,
    required this.shouldPaint,
    required this.reason,
    required this.color,
  });

  final String label;
  final double width;
  final bool shouldPaint;
  final String reason;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45)),
        color: shouldPaint
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFFFEBEE),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label (${width.toStringAsFixed(0)} px)',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            shouldPaint ? 'shouldPaint=true' : 'shouldPaint=false',
            style: TextStyle(
              color: shouldPaint ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 160,
            child: Text(reason, style: const TextStyle(fontSize: 12, color: _kText)),
          ),
        ],
      ),
    );
  }
}

class _ChecklistLine extends StatelessWidget {
  const _ChecklistLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 18, color: Color(0xFF2E7D32)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _kText))),
        ],
      ),
    );
  }
}

class _ToolbarEntry {
  const _ToolbarEntry({
    required this.label,
    required this.width,
    required this.priority,
    required this.color,
  });

  final String label;
  final double width;
  final int priority;
  final Color color;
}

class _EntryPaintState {
  const _EntryPaintState({
    required this.entry,
    required this.shouldPaint,
    required this.reason,
  });

  final _ToolbarEntry entry;
  final bool shouldPaint;
  final String reason;
}

class _LayoutSimulation {
  const _LayoutSimulation({
    required this.visible,
    required this.hidden,
    required this.states,
    required this.consumedWidth,
  });

  final List<_ToolbarEntry> visible;
  final List<_ToolbarEntry> hidden;
  final List<_EntryPaintState> states;
  final double consumedWidth;
}

_LayoutSimulation _simulateLayout({
  required List<_ToolbarEntry> entries,
  required double availableWidth,
  required bool reserveOverflowTrigger,
  required bool reserveGap,
}) {
  const double overflowTriggerWidth = 78;
  const double gap = 6;
  final sorted = [...entries]..sort((a, b) => a.priority.compareTo(b.priority));
  final List<_ToolbarEntry> visible = [];
  final List<_ToolbarEntry> hidden = [];
  final List<_EntryPaintState> states = [];

  final double budget = reserveOverflowTrigger
      ? availableWidth - overflowTriggerWidth - (reserveGap ? gap : 0)
      : availableWidth;

  double consumed = 0;
  for (var i = 0; i < sorted.length; i++) {
    final item = sorted[i];
    final needsGap = i > 0 && reserveGap;
    final candidateWidth = consumed + (needsGap ? gap : 0) + item.width;
    if (candidateWidth <= budget) {
      consumed = candidateWidth;
      visible.add(item);
      states.add(
        const _EntryPaintState(
          entry: _ToolbarEntry(label: '', width: 0, priority: 0, color: Colors.transparent),
          shouldPaint: true,
          reason: '',
        ),
      );
      states.removeLast();
      states.add(
        _EntryPaintState(
          entry: item,
          shouldPaint: true,
          reason: 'fits within current budget',
        ),
      );
    } else {
      hidden.add(item);
      states.add(
        _EntryPaintState(
          entry: item,
          shouldPaint: false,
          reason: 'moved to overflow to preserve spacing',
        ),
      );
    }
  }

  return _LayoutSimulation(
    visible: visible,
    hidden: hidden,
    states: states,
    consumedWidth: consumed,
  );
}

class _TimelineStep {
  const _TimelineStep({
    required this.title,
    required this.details,
    required this.color,
  });

  final String title;
  final String details;
  final Color color;
}
