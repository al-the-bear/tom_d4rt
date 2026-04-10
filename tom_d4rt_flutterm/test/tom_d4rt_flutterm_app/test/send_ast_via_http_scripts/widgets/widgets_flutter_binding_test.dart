// ignore_for_file: avoid_print
// D4rt test script: Deep demo for WidgetsFlutterBinding from widgets.
import 'package:flutter/material.dart';

const List<_BindingCapability> _capabilities = <_BindingCapability>[
  _BindingCapability(
    title: 'GestureBinding',
    description: 'Pointer routing, gesture arenas, and hit test dispatch.',
    color: Color(0xFF005E7A),
    icon: Icons.touch_app,
  ),
  _BindingCapability(
    title: 'SchedulerBinding',
    description: 'Frame callbacks, task priorities, and ticker heartbeat.',
    color: Color(0xFF006F4E),
    icon: Icons.schedule,
  ),
  _BindingCapability(
    title: 'ServicesBinding',
    description: 'Platform channels, lifecycle messages, and restoration data.',
    color: Color(0xFF5D4A00),
    icon: Icons.settings_ethernet,
  ),
  _BindingCapability(
    title: 'PaintingBinding',
    description: 'Image cache, text metrics, and paint lifecycle wiring.',
    color: Color(0xFF6A1A45),
    icon: Icons.brush,
  ),
  _BindingCapability(
    title: 'SemanticsBinding',
    description: 'Accessibility updates and semantics owner integration.',
    color: Color(0xFF2D3F9B),
    icon: Icons.accessibility_new,
  ),
  _BindingCapability(
    title: 'RendererBinding',
    description: 'PipelineOwner, render views, and composite frame orchestration.',
    color: Color(0xFF7A2F00),
    icon: Icons.layers,
  ),
  _BindingCapability(
    title: 'WidgetsBinding',
    description: 'Element tree updates, inherited widgets, and observers.',
    color: Color(0xFF234400),
    icon: Icons.widgets,
  ),
];

const List<_LifecycleStep> _lifecycle = <_LifecycleStep>[
  _LifecycleStep(
    title: 'main()',
    details: 'Developer entrypoint starts; async preflight can be prepared.',
    keyPoint: 'Call ensureInitialized before platform channels.',
  ),
  _LifecycleStep(
    title: 'ensureInitialized()',
    details:
        'Creates a singleton binding when not created yet and wires core mixins.',
    keyPoint: 'Safe to call repeatedly; same instance returns.',
  ),
  _LifecycleStep(
    title: 'attachRootWidget()',
    details: 'Root widget gets linked with render tree and build owner.',
    keyPoint: 'runApp internally attaches and schedules warm-up frame.',
  ),
  _LifecycleStep(
    title: 'scheduleFrame()',
    details:
        'SchedulerBinding requests frame from platform dispatcher for pipeline.',
    keyPoint: 'Multiple requests before frame coalesce.',
  ),
  _LifecycleStep(
    title: 'drawFrame()',
    details:
        'Build, layout, paint, semantics, and final layer submission occur in order.',
    keyPoint: 'DevTools timeline segments map directly to this cycle.',
  ),
  _LifecycleStep(
    title: 'postFrameCallbacks',
    details: 'Deferred work runs after rendering but before next event turn.',
    keyPoint: 'Ideal for measurements and one-shot UI reactions.',
  ),
];

const List<_ExtensionInfo> _extensions = <_ExtensionInfo>[
  _ExtensionInfo(
    name: 'ext.flutter.debugDumpApp',
    purpose: 'Prints full widget hierarchy to console output.',
    audience: 'Inspector and debug sessions.',
  ),
  _ExtensionInfo(
    name: 'ext.flutter.debugDumpRenderTree',
    purpose: 'Prints RenderObject topology and constraints.',
    audience: 'Layout troubleshooting in complex trees.',
  ),
  _ExtensionInfo(
    name: 'ext.flutter.debugDumpLayerTree',
    purpose: 'Shows composited layer hierarchy and retained layers.',
    audience: 'Compositing and platform view diagnostics.',
  ),
  _ExtensionInfo(
    name: 'ext.flutter.showPerformanceOverlay',
    purpose: 'Toggles frame chart overlay for UI/GPU timing.',
    audience: 'Performance tuning and jank investigation.',
  ),
  _ExtensionInfo(
    name: 'ext.flutter.fastReassemble',
    purpose: 'Triggers efficient tree refresh used by hot reload.',
    audience: 'Development loops and iteration speed checks.',
  ),
  _ExtensionInfo(
    name: 'ext.flutter.profileWidgetBuilds',
    purpose: 'Profiles widget build costs at runtime.',
    audience: 'Targeted optimization in heavy scenes.',
  ),
];

dynamic build(BuildContext context) {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  final ValueNotifier<int> selectedLifecycle = ValueNotifier<int>(2);
  final ValueNotifier<int> selectedCapability = ValueNotifier<int>(1);
  final ValueNotifier<double> frameBudgetMs = ValueNotifier<double>(16.0);
  final ValueNotifier<bool> simulatedWorkload = ValueNotifier<bool>(false);

  print('WidgetsFlutterBinding deep demo executing');
  print('Binding runtimeType: ${binding.runtimeType}');
  print('Identical ensureInitialized: '
      '${identical(binding, WidgetsFlutterBinding.ensureInitialized())}');
  print('Render views count: ${binding.renderViews.length}');

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A6A74)),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFE7F6F8), Color(0xFFFDF6EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          _buildHeader(binding),
          const SizedBox(height: 16),
          _buildBindingSnapshot(binding),
          const SizedBox(height: 16),
          _buildLifecycleBoard(selectedLifecycle),
          const SizedBox(height: 16),
          _buildCapabilitiesBoard(selectedCapability),
          const SizedBox(height: 16),
          _buildFrameBudgetSimulator(
            frameBudgetMs: frameBudgetMs,
            simulatedWorkload: simulatedWorkload,
          ),
          const SizedBox(height: 16),
          _buildServiceExtensionCatalog(),
          const SizedBox(height: 16),
          _buildPracticalPatternDeck(),
          const SizedBox(height: 16),
          _buildValidationChecklist(),
        ],
      ),
    ),
  );
}

Widget _buildHeader(WidgetsBinding binding) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 26,
                backgroundColor: Color(0xFF0A6A74),
                child: Icon(Icons.hub, color: Colors.white),
              ),
              const Text(
                'WidgetsFlutterBinding Deep Demo',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Chip(
                label: Text(binding.runtimeType.toString()),
                avatar: const Icon(Icons.memory),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'This script simulates how the singleton binding coordinates the '
            'engine pulse with framework responsibilities. It focuses on lifecycle '
            'sequencing, capability composition, and debugging extension discovery.',
          ),
        ],
      ),
    ),
  );
}

Widget _buildBindingSnapshot(WidgetsBinding binding) {
  final List<_SnapshotRow> rows = <_SnapshotRow>[
    _SnapshotRow('is singleton alive', 'true'),
    _SnapshotRow('renderViews', binding.renderViews.length.toString()),
    _SnapshotRow('platform views',
        binding.platformDispatcher.views.length.toString()),
    _SnapshotRow('framesEnabled', binding.framesEnabled.toString()),
    _SnapshotRow('lifecycleState',
        binding.lifecycleState?.name ?? 'unavailable in this context'),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Runtime Snapshot',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2.2),
              1: FlexColumnWidth(1.8),
            },
            children: rows
                .map(
                  (_SnapshotRow row) => TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(row.label),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          row.value,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );
}

Widget _buildLifecycleBoard(ValueNotifier<int> selectedLifecycle) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedLifecycle,
        builder: (BuildContext context, int index, Widget? _) {
          final _LifecycleStep current = _lifecycle[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Lifecycle Timeline',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (int i = 0; i < _lifecycle.length; i++)
                    ChoiceChip(
                      selected: i == index,
                      label: Text('${i + 1}. ${_lifecycle[i].title}'),
                      onSelected: (_) => selectedLifecycle.value = i,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FBFC),
                  border: Border.all(color: const Color(0xFFD2E7EA)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      current.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(current.details),
                    const SizedBox(height: 6),
                    Text(
                      'Key point: ${current.keyPoint}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildCapabilitiesBoard(ValueNotifier<int> selectedCapability) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedCapability,
        builder: (BuildContext context, int index, Widget? _) {
          final _BindingCapability cap = _capabilities[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Mixin Capability Map',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _capabilities.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (BuildContext context, int i) {
                  final _BindingCapability item = _capabilities[i];
                  final bool isSelected = i == index;
                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => selectedCapability.value = i,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: isSelected
                            ? item.color.withValues(alpha: 0.16)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? item.color.withValues(alpha: 0.9)
                              : const Color(0xFFCAD5D9),
                          width: isSelected ? 1.7 : 1,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(item.icon, color: item.color),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: cap.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: cap.color.withValues(alpha: 0.4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(cap.icon, color: cap.color),
                      const SizedBox(width: 10),
                      Expanded(child: Text(cap.description)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildFrameBudgetSimulator({
  required ValueNotifier<double> frameBudgetMs,
  required ValueNotifier<bool> simulatedWorkload,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Frame Budget Simulator',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 6),
          const Text(
            'A conceptual slider to reason about 60fps (\$16.67ms) and '
            '120fps (\$8.33ms) targets while scheduling expensive work.',
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<double>(
            valueListenable: frameBudgetMs,
            builder: (BuildContext context, double budget, Widget? _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Slider(
                    min: 4,
                    max: 32,
                    divisions: 28,
                    value: budget,
                    label: '${budget.toStringAsFixed(1)} ms',
                    onChanged: (double v) => frameBudgetMs.value = v,
                  ),
                  Text('Current frame budget: ${budget.toStringAsFixed(1)} ms'),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<bool>(
            valueListenable: simulatedWorkload,
            builder: (BuildContext context, bool heavy, Widget? _) {
              return SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Simulate heavy post-frame callback workload'),
                subtitle: const Text(
                  'When enabled, pretend one callback consumes 12ms on the UI thread.',
                ),
                value: heavy,
                onChanged: (bool next) => simulatedWorkload.value = next,
              );
            },
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder2<double, bool>(
            first: frameBudgetMs,
            second: simulatedWorkload,
            builder: (BuildContext context, double budget, bool heavy) {
              final double consumed = heavy ? 12 : 4;
              final double remaining = budget - consumed;
              final bool safe = remaining > 2;
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: safe
                      ? const Color(0xFFEAF8EE)
                      : const Color(0xFFFFF0E8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: safe
                        ? const Color(0xFF88C49A)
                        : const Color(0xFFE8A07B),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    safe
                        ? 'Budget healthy: ${remaining.toStringAsFixed(1)}ms remains after callback work.'
                        : 'Budget tight: ${remaining.toStringAsFixed(1)}ms remains. Consider idle task split.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildServiceExtensionCatalog() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Service Extension Catalog',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (final _ExtensionInfo extension in _extensions)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD6DFE1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        extension.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0A5A64),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(extension.purpose),
                      const SizedBox(height: 2),
                      Text(
                        extension.audience,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4A5C62),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildPracticalPatternDeck() {
  const List<_PatternCardData> patterns = <_PatternCardData>[
    _PatternCardData(
      title: 'Pre-runApp initialization',
      snippet: 'WidgetsFlutterBinding.ensureInitialized();\nawait loadConfig();\nrunApp(App());',
      note: 'Use when startup needs platform channels or async setup.',
    ),
    _PatternCardData(
      title: 'Post frame measurement',
      snippet: 'WidgetsBinding.instance.addPostFrameCallback((_) {\n  // read size\n});',
      note: 'Safe point for querying layout-dependent values.',
    ),
    _PatternCardData(
      title: 'Observer registration',
      snippet: 'final observer = LifecycleObserver();\nWidgetsBinding.instance.addObserver(observer);',
      note: 'Integrate app lifecycle transitions and memory pressure signals.',
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Practical Usage Patterns',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: patterns
                .map(
                  (_PatternCardData card) => SizedBox(
                    width: 300,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FCFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFD9E5E6)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              card.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0E2527),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                card.snippet,
                                style: const TextStyle(
                                  color: Color(0xFFD4F4F5),
                                  fontFamily: 'monospace',
                                  height: 1.3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(card.note),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );
}

Widget _buildValidationChecklist() {
  const List<String> checklist = <String>[
    'Binding singleton verified through repeated ensureInitialized calls.',
    'Lifecycle timeline maps to visible frame phases and callback points.',
    'Capability deck explains all major mixins in the concrete binding.',
    'Service extension catalog links runtime commands with concrete tooling.',
    'Frame budget simulator demonstrates how callback costs influence jank.',
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Demo Validation Checklist',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 8),
          for (final String item in checklist)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.check_circle, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

class _BindingCapability {
  const _BindingCapability({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  final String title;
  final String description;
  final Color color;
  final IconData icon;
}

class _LifecycleStep {
  const _LifecycleStep({
    required this.title,
    required this.details,
    required this.keyPoint,
  });

  final String title;
  final String details;
  final String keyPoint;
}

class _ExtensionInfo {
  const _ExtensionInfo({
    required this.name,
    required this.purpose,
    required this.audience,
  });

  final String name;
  final String purpose;
  final String audience;
}

class _SnapshotRow {
  const _SnapshotRow(this.label, this.value);

  final String label;
  final String value;
}

class _PatternCardData {
  const _PatternCardData({
    required this.title,
    required this.snippet,
    required this.note,
  });

  final String title;
  final String snippet;
  final String note;
}

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    super.key,
    required this.first,
    required this.second,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final Widget Function(BuildContext context, A a, B b) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? _) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? unused) {
            return builder(context, a, b);
          },
        );
      },
    );
  }
}
