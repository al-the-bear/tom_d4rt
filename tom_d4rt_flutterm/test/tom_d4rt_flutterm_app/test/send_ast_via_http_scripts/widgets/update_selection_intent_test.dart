import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _UpdateSelectionIntentDeepDemo();
}

const Color _kInk = Color(0xFF0F172A);
const Color _kSurface = Color(0xFFF8FAFC);
const Color _kAccent = Color(0xFFC7D2FE);

class _UpdateSelectionIntentDeepDemo extends StatefulWidget {
  const _UpdateSelectionIntentDeepDemo();

  @override
  State<_UpdateSelectionIntentDeepDemo> createState() =>
      _UpdateSelectionIntentDeepDemoState();
}

class _UpdateSelectionIntentDeepDemoState extends State<_UpdateSelectionIntentDeepDemo>
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
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kInk,
        foregroundColor: Colors.white,
        title: const Text('UpdateSelectionIntent Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Intent Atlas'),
            Tab(text: 'Selection Geometry'),
            Tab(text: 'Dispatch Studio'),
            Tab(text: 'Cause Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _IntentAtlasPanel(),
          _SelectionGeometryPanel(),
          _DispatchStudioPanel(),
          _CauseAnalyticsPanel(),
        ],
      ),
    );
  }
}

class _IntentAtlasPanel extends StatelessWidget {
  const _IntentAtlasPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _IntroCard(
          title: 'UpdateSelectionIntent Purpose',
          body:
              'UpdateSelectionIntent requests selection changes for a current '
              'TextEditingValue. It bundles current value, target selection, and '
              'a SelectionChangedCause to preserve interaction context.',
        ),
        SizedBox(height: 12),
        _KnowledgeCard(
          title: 'Required properties',
          color: Color(0xFF166534),
          points: [
            'currentTextEditingValue: source text and existing selection.',
            'newSelection: target TextSelection to apply.',
            'cause: SelectionChangedCause indicating trigger source.',
            'Together they support deterministic selection transitions.',
          ],
        ),
        _KnowledgeCard(
          title: 'Behavior patterns',
          color: Color(0xFF1D4ED8),
          points: [
            'Collapsed newSelection moves caret only.',
            'Range selection expands or contracts highlight span.',
            'Cause can influence analytics, accessibility messaging, or heuristics.',
            'Actions layer decides how to apply and broadcast updates.',
          ],
        ),
        _KnowledgeCard(
          title: 'When this intent appears',
          color: Color(0xFF9A3412),
          points: [
            'Keyboard navigation and selection extension commands.',
            'Gesture-driven text selection gestures.',
            'Programmatic selection restoration after undo/redo flows.',
            'Shortcut actions such as select all / move caret.',
          ],
        ),
        SizedBox(height: 12),
        _ReferenceCard(),
      ],
    );
  }
}

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard();

  @override
  Widget build(BuildContext context) {
    final causes = SelectionChangedCause.values;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SelectionChangedCause Reference', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (final c in causes)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• ${c.name}'),
              ),
          ],
        ),
      ),
    );
  }
}

class _SelectionGeometryPanel extends StatefulWidget {
  const _SelectionGeometryPanel();

  @override
  State<_SelectionGeometryPanel> createState() => _SelectionGeometryPanelState();
}

class _SelectionGeometryPanelState extends State<_SelectionGeometryPanel> {
  String _text = 'Selection geometry demo for Flutter interpreter bridge.';
  int _base = 0;
  int _extent = 0;
  SelectionChangedCause _cause = SelectionChangedCause.keyboard;
  final List<String> _events = ['Geometry panel initialized'];

  void _clamp() {
    final max = _text.length;
    _base = _base.clamp(0, max);
    _extent = _extent.clamp(0, max);
  }

  void _setPreset(_SelectionPreset preset) {
    setState(() {
      switch (preset) {
        case _SelectionPreset.start:
          _base = 0;
          _extent = 0;
        case _SelectionPreset.word:
          _base = 10;
          _extent = 18;
        case _SelectionPreset.end:
          _base = _text.length;
          _extent = _text.length;
        case _SelectionPreset.all:
          _base = 0;
          _extent = _text.length;
      }
      _clamp();
      _events.add('preset ${preset.name} applied');
      if (_events.length > 25) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _clamp();
    final selection = TextSelection(baseOffset: _base, extentOffset: _extent);
    final minSel = selection.start;
    final maxSel = selection.end;
    final before = _text.substring(0, minSel);
    final selected = _text.substring(minSel, maxSel);
    final after = _text.substring(maxSel);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Selection Geometry Lab',
          body:
              'Manipulate selection base/extent and visualize how UpdateSelectionIntent '
              'encodes changes with cause metadata.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: TextEditingController(text: _text),
                  onChanged: (value) => setState(() => _text = value),
                  decoration: const InputDecoration(
                    labelText: 'Source text',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                _SliderLine(
                  label: 'baseOffset',
                  value: _base.toDouble(),
                  min: 0,
                  max: _text.length.toDouble(),
                  divisions: _text.isEmpty ? 1 : _text.length,
                  onChanged: (v) => setState(() => _base = v.round()),
                ),
                _SliderLine(
                  label: 'extentOffset',
                  value: _extent.toDouble(),
                  min: 0,
                  max: _text.length.toDouble(),
                  divisions: _text.isEmpty ? 1 : _text.length,
                  onChanged: (v) => setState(() => _extent = v.round()),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final cause in SelectionChangedCause.values)
                      ChoiceChip(
                        label: Text(cause.name),
                        selected: _cause == cause,
                        onSelected: (_) => setState(() => _cause = cause),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(onPressed: () => _setPreset(_SelectionPreset.start), child: const Text('Start')), 
                    FilledButton(onPressed: () => _setPreset(_SelectionPreset.word), child: const Text('Word-like')), 
                    FilledButton(onPressed: () => _setPreset(_SelectionPreset.end), child: const Text('End')), 
                    FilledButton(onPressed: () => _setPreset(_SelectionPreset.all), child: const Text('Select All')),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFEFF6FF),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rendered Selection Preview', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    children: [
                      TextSpan(text: before),
                      TextSpan(
                        text: selected,
                        style: const TextStyle(backgroundColor: Color(0xFFBFDBFE), fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: after),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text('selection: base=$_base extent=$_extent start=${selection.start} end=${selection.end}'),
                Text('isCollapsed: ${selection.isCollapsed} | cause: ${_cause.name}'),
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
                const Text('Selection Events', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _events)
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

class _DispatchStudioPanel extends StatefulWidget {
  const _DispatchStudioPanel();

  @override
  State<_DispatchStudioPanel> createState() => _DispatchStudioPanelState();
}

class _DispatchStudioPanelState extends State<_DispatchStudioPanel> {
  TextEditingValue _value = const TextEditingValue(
    text: 'Dispatch studio text',
    selection: TextSelection.collapsed(offset: 0),
  );
  SelectionChangedCause _cause = SelectionChangedCause.keyboard;
  final List<String> _journal = ['Dispatch studio initialized'];

  void _apply(TextSelection selection) {
    final intent = UpdateSelectionIntent(_value, selection, _cause);
    final action = _SelectionAction();
    final updated = action.invoke(intent)!;
    setState(() {
      _value = updated;
      _journal.add(
        'intent dispatched -> base ${selection.baseOffset}, '
        'extent ${selection.extentOffset}, cause ${_cause.name}',
      );
      if (_journal.length > 24) {
        _journal.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final len = _value.text.length;
    final midpoint = len ~/ 2;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Dispatch Studio',
          body:
              'Create UpdateSelectionIntent objects and pass them through an action '
              'handler to simulate framework selection updates.',
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
                for (final c in SelectionChangedCause.values)
                  ChoiceChip(
                    label: Text(c.name),
                    selected: _cause == c,
                    onSelected: (_) => setState(() => _cause = c),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFF1F5F9),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => _apply(const TextSelection.collapsed(offset: 0)),
                  child: const Text('Caret Start'),
                ),
                FilledButton(
                  onPressed: () => _apply(TextSelection.collapsed(offset: midpoint)),
                  child: const Text('Caret Mid'),
                ),
                FilledButton(
                  onPressed: () => _apply(TextSelection.collapsed(offset: len)),
                  child: const Text('Caret End'),
                ),
                OutlinedButton(
                  onPressed: () => _apply(TextSelection(baseOffset: 0, extentOffset: len)),
                  child: const Text('Select All'),
                ),
                OutlinedButton(
                  onPressed: () => _apply(TextSelection(baseOffset: 3, extentOffset: (3 + midpoint).clamp(0, len))),
                  child: const Text('Select Segment'),
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
                const Text('Current Value Snapshot', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text('text: ${_value.text}'),
                Text('selection base: ${_value.selection.baseOffset}'),
                Text('selection extent: ${_value.selection.extentOffset}'),
                Text('selection collapsed: ${_value.selection.isCollapsed}'),
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
                const Text('Dispatch Journal', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final row in _journal)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $row'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CauseAnalyticsPanel extends StatefulWidget {
  const _CauseAnalyticsPanel();

  @override
  State<_CauseAnalyticsPanel> createState() => _CauseAnalyticsPanelState();
}

class _CauseAnalyticsPanelState extends State<_CauseAnalyticsPanel> {
  final Map<SelectionChangedCause, int> _counts = {
    for (final c in SelectionChangedCause.values) c: 0,
  };

  void _record(SelectionChangedCause cause) {
    setState(() {
      _counts[cause] = (_counts[cause] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Cause Analytics Desk',
          body:
              'Selection cause telemetry can expose interaction patterns and help '
              'debug unexpected intent routes in interpreter sessions.',
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
                for (final cause in SelectionChangedCause.values)
                  FilledButton.tonal(
                    onPressed: () => _record(cause),
                    child: Text('Dispatch ${cause.name}'),
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
                const Text('Cause Counts', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final c in SelectionChangedCause.values)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(c.name)),
                        Text('${_counts[c]} events'),
                      ],
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

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.title, required this.body});

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

class _KnowledgeCard extends StatelessWidget {
  const _KnowledgeCard({required this.title, required this.color, required this.points});

  final String title;
  final Color color;
  final List<String> points;

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
              for (final p in points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $p'),
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

class _SelectionAction extends Action<UpdateSelectionIntent> {
  @override
  TextEditingValue? invoke(UpdateSelectionIntent intent) {
    return intent.currentTextEditingValue.copyWith(selection: intent.newSelection);
  }
}

enum _SelectionPreset { start, word, end, all }
