// ignore_for_file: avoid_print
// D4rt test script: Deep demo for WidgetsServiceExtensions from widgets.
import 'package:flutter/material.dart';

const List<_ServiceExtensionEntry> _extensionEntries = <_ServiceExtensionEntry>[
  _ServiceExtensionEntry(
    name: 'ext.flutter.debugDumpApp',
    category: 'Tree Dumps',
    detail: 'Prints the widget tree for hierarchy audits.',
    impact: 'Low runtime impact, high debugging value.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.debugDumpRenderTree',
    category: 'Tree Dumps',
    detail: 'Prints RenderObject ownership and constraints.',
    impact: 'Useful when layout looks correct in widgets but fails in render.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.debugDumpLayerTree',
    category: 'Compositor',
    detail: 'Prints layer composition graph and retained layers.',
    impact: 'Helps locate expensive overlays and clipping boundaries.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.debugDumpFocusTree',
    category: 'Interaction',
    detail: 'Prints current focus hierarchy and traversal candidates.',
    impact: 'Important for desktop and accessibility keyboard flow.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.debugDumpSemanticsTree',
    category: 'Accessibility',
    detail: 'Prints semantics nodes and action annotations.',
    impact: 'Critical for screen-reader parity and QA audits.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.showPerformanceOverlay',
    category: 'Performance',
    detail: 'Toggles frame chart overlay for UI and GPU lanes.',
    impact: 'Immediate visual signal for jank during interactions.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.fastReassemble',
    category: 'Reload',
    detail: 'Performs efficient framework reassembly during hot reload.',
    impact: 'Accelerates iteration loops while preserving state.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.profileWidgetBuilds',
    category: 'Performance',
    detail: 'Tracks widget build cost stats for heavy subtrees.',
    impact: 'Pinpoints expensive rebuild regions for optimization.',
    defaultEnabledInDebug: false,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.debugAllowBanner',
    category: 'Visual Flags',
    detail: 'Controls whether debug banner is rendered.',
    impact: 'Useful for screenshot scenarios and visual checks.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.didSendFirstFrameEvent',
    category: 'Startup Telemetry',
    detail: 'Reports first-frame event emission status.',
    impact: 'Supports app startup profiling and launch dashboards.',
    defaultEnabledInDebug: true,
  ),
  _ServiceExtensionEntry(
    name: 'ext.flutter.didSendFirstFrameRasterizedEvent',
    category: 'Startup Telemetry',
    detail: 'Reports first frame rasterization status.',
    impact: 'Pairs with launch KPI tracking and perf budgets.',
    defaultEnabledInDebug: true,
  ),
];

const List<_CommandScenario> _commandScenarios = <_CommandScenario>[
  _CommandScenario(
    title: 'Inspector tree snapshot',
    extensionName: 'ext.flutter.debugDumpApp',
    invocationPath: 'DevTools -> Inspector -> Dump widget tree',
    expectedSignal: 'Console shows root-to-leaf widget hierarchy.',
  ),
  _CommandScenario(
    title: 'Render constraints audit',
    extensionName: 'ext.flutter.debugDumpRenderTree',
    invocationPath: 'IDE debug command palette -> dump render tree',
    expectedSignal: 'RenderObject dump includes constraints and sizes.',
  ),
  _CommandScenario(
    title: 'Frame timing overlay',
    extensionName: 'ext.flutter.showPerformanceOverlay',
    invocationPath: 'DevTools toggle button or service extension panel',
    expectedSignal: 'Overlay appears with frame bars and raster traces.',
  ),
  _CommandScenario(
    title: 'Hot reload acceleration',
    extensionName: 'ext.flutter.fastReassemble',
    invocationPath: 'Hot reload pipeline from IDE attach session',
    expectedSignal: 'State is retained and tree is refreshed quickly.',
  ),
  _CommandScenario(
    title: 'Semantics diagnostics',
    extensionName: 'ext.flutter.debugDumpSemanticsTree',
    invocationPath: 'vm_service extension call from diagnostics script',
    expectedSignal: 'Semantics structure appears for screen reader validation.',
  ),
];

dynamic build(BuildContext context) {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  final ValueNotifier<int> selectedCategory = ValueNotifier<int>(0);
  final ValueNotifier<int> selectedScenario = ValueNotifier<int>(0);
  final ValueNotifier<bool> showDebugOnly = ValueNotifier<bool>(false);
  final ValueNotifier<bool> highlightPerfCategory = ValueNotifier<bool>(true);
  final ValueNotifier<int> simulatedCommandLatencyMs = ValueNotifier<int>(36);

  print('WidgetsServiceExtensions deep demo executing');
  print('Binding: ${binding.runtimeType}');
  print('Render views count: ${binding.renderViews.length}');

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF005E67)),
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
          colors: <Color>[Color(0xFFF0FAFB), Color(0xFFFFF6EE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          _buildHeader(binding),
          const SizedBox(height: 16),
          _buildBindingRuntimePanel(binding),
          const SizedBox(height: 16),
          _buildFilterAndCatalog(
            selectedCategory: selectedCategory,
            showDebugOnly: showDebugOnly,
            highlightPerfCategory: highlightPerfCategory,
          ),
          const SizedBox(height: 16),
          _buildScenarioConsole(
            selectedScenario: selectedScenario,
            simulatedCommandLatencyMs: simulatedCommandLatencyMs,
          ),
          const SizedBox(height: 16),
          _buildCategoryHeatmap(
            selectedCategory: selectedCategory,
            highlightPerfCategory: highlightPerfCategory,
          ),
          const SizedBox(height: 16),
          _buildCommandPipeline(),
          const SizedBox(height: 16),
          _buildReleaseNotesPanel(),
          const SizedBox(height: 16),
          _buildChecklist(),
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
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF005E67),
                child: Icon(Icons.miscellaneous_services, color: Colors.white),
              ),
              const Text(
                'WidgetsServiceExtensions Deep Demo',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
              ),
              Chip(
                avatar: const Icon(Icons.memory),
                label: Text(binding.runtimeType.toString()),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'The WidgetsServiceExtensions mixin wires vm_service extension '
            'endpoints used by DevTools and IDEs. This demo focuses on extension '
            'catalog structure, call scenarios, and debugging signal interpretation.',
          ),
        ],
      ),
    ),
  );
}

Widget _buildBindingRuntimePanel(WidgetsBinding binding) {
  final List<_MetricRow> rows = <_MetricRow>[
    _MetricRow('renderViews', binding.renderViews.length.toString()),
    _MetricRow('platform views',
        binding.platformDispatcher.views.length.toString()),
    _MetricRow('frames enabled', binding.framesEnabled.toString()),
    _MetricRow('lifecycle state',
        binding.lifecycleState?.name ?? 'not reported here'),
    _MetricRow('extensions catalog size', _extensionEntries.length.toString()),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Binding Runtime Snapshot',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (final _MetricRow row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(row.keyLabel)),
                  Text(
                    row.value,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildFilterAndCatalog({
  required ValueNotifier<int> selectedCategory,
  required ValueNotifier<bool> showDebugOnly,
  required ValueNotifier<bool> highlightPerfCategory,
}) {
  final List<String> categories = _extensionEntries
      .map((_ServiceExtensionEntry entry) => entry.category)
      .toSet()
      .toList()
    ..sort();

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder3<int, bool, bool>(
        first: selectedCategory,
        second: showDebugOnly,
        third: highlightPerfCategory,
        builder: (BuildContext context, int categoryIndex, bool debugOnly,
            bool highlightPerf) {
          if (categoryIndex >= categories.length) {
            selectedCategory.value = 0;
            return const SizedBox.shrink();
          }

          final String activeCategory = categories[categoryIndex];
          final List<_ServiceExtensionEntry> filtered = _extensionEntries.where(
            (_ServiceExtensionEntry entry) {
              if (entry.category != activeCategory) {
                return false;
              }
              if (debugOnly && !entry.defaultEnabledInDebug) {
                return false;
              }
              return true;
            },
          ).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Extension Catalog Explorer',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (int i = 0; i < categories.length; i++)
                    ChoiceChip(
                      selected: i == categoryIndex,
                      label: Text(categories[i]),
                      onSelected: (_) => selectedCategory.value = i,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Show only debug-enabled-by-default entries'),
                value: debugOnly,
                onChanged: (bool next) => showDebugOnly.value = next,
              ),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Highlight performance category in overview'),
                value: highlightPerf,
                onChanged: (bool next) => highlightPerfCategory.value = next,
              ),
              const SizedBox(height: 8),
              if (filtered.isEmpty)
                const Text('No entries available for selected filters.')
              else
                for (final _ServiceExtensionEntry entry in filtered)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ExtensionCard(
                      entry: entry,
                      emphasize: highlightPerf && entry.category == 'Performance',
                    ),
                  ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildScenarioConsole({
  required ValueNotifier<int> selectedScenario,
  required ValueNotifier<int> simulatedCommandLatencyMs,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder2<int, int>(
        first: selectedScenario,
        second: simulatedCommandLatencyMs,
        builder: (BuildContext context, int scenarioIndex, int latencyMs) {
          final _CommandScenario scenario = _commandScenarios[scenarioIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Command Scenario Console',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (int i = 0; i < _commandScenarios.length; i++)
                    FilterChip(
                      selected: i == scenarioIndex,
                      label: Text(_commandScenarios[i].title),
                      onSelected: (_) => selectedScenario.value = i,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF0F2527),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '[36m${scenario.title}[0m',
                        style: const TextStyle(
                          color: Color(0xFFBFF4FF),
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'call -> ${scenario.extensionName}',
                        style: const TextStyle(
                          color: Color(0xFF9BE4ED),
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'path -> ${scenario.invocationPath}',
                        style: const TextStyle(
                          color: Color(0xFF9BE4ED),
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'result -> ${scenario.expectedSignal}',
                        style: const TextStyle(
                          color: Color(0xFF9BE4ED),
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'simulated latency -> ${latencyMs}ms',
                        style: const TextStyle(
                          color: Color(0xFFFADBA4),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Slider(
                min: 5,
                max: 120,
                divisions: 23,
                label: '${latencyMs}ms',
                value: latencyMs.toDouble(),
                onChanged: (double value) =>
                    simulatedCommandLatencyMs.value = value.round(),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildCategoryHeatmap({
  required ValueNotifier<int> selectedCategory,
  required ValueNotifier<bool> highlightPerfCategory,
}) {
  final Map<String, int> counts = <String, int>{};
  for (final _ServiceExtensionEntry entry in _extensionEntries) {
    counts[entry.category] = (counts[entry.category] ?? 0) + 1;
  }
  final List<MapEntry<String, int>> sorted = counts.entries.toList()
    ..sort((MapEntry<String, int> a, MapEntry<String, int> b) =>
        a.key.compareTo(b.key));

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder2<int, bool>(
        first: selectedCategory,
        second: highlightPerfCategory,
        builder: (BuildContext context, int selected, bool highlightPerf) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Category Heatmap',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < sorted.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 140, child: Text(sorted[i].key)),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            minHeight: 12,
                            value: sorted[i].value / _extensionEntries.length,
                            color: (highlightPerf && sorted[i].key == 'Performance')
                                ? const Color(0xFFCA6A00)
                                : const Color(0xFF0A7F86),
                            backgroundColor: const Color(0xFFE2ECEE),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${sorted[i].value}'),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              Text(
                'Selected category index: $selected. Toggle highlight to focus perf diagnostics.',
                style: const TextStyle(color: Color(0xFF506166)),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildCommandPipeline() {
  const List<_PipelineStep> steps = <_PipelineStep>[
    _PipelineStep(
      title: 'Attach session',
      description: 'DevTools or IDE establishes vm_service connection.',
      icon: Icons.usb,
      color: Color(0xFF005B66),
    ),
    _PipelineStep(
      title: 'Discover extensions',
      description: 'Client inspects exposed ext.flutter.* commands.',
      icon: Icons.travel_explore,
      color: Color(0xFF3A6200),
    ),
    _PipelineStep(
      title: 'Invoke command',
      description: 'Specific extension request is sent with arguments.',
      icon: Icons.send,
      color: Color(0xFF7A3E00),
    ),
    _PipelineStep(
      title: 'Binding handles request',
      description: 'WidgetsServiceExtensions routes to framework callback.',
      icon: Icons.route,
      color: Color(0xFF4D3C8C),
    ),
    _PipelineStep(
      title: 'Client renders result',
      description: 'Console output, overlay, or structured response appears.',
      icon: Icons.terminal,
      color: Color(0xFF7A1A52),
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Invocation Pipeline',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: steps[i].color,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: steps[i].color.withValues(alpha: 0.45),
                        ),
                        color: steps[i].color.withValues(alpha: 0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(steps[i].icon, color: steps[i].color, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    steps[i].title,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(steps[i].description),
                                ],
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
        ],
      ),
    ),
  );
}

Widget _buildReleaseNotesPanel() {
  const List<_SnippetInfo> snippets = <_SnippetInfo>[
    _SnippetInfo(
      title: 'CLI vm_service call',
      snippet: 'flutter attach --debug-uri <uri>\n# issue ext call through tooling bridge',
      note: 'Use when running headless diagnostics in CI debug jobs.',
    ),
    _SnippetInfo(
      title: 'Programmatic extension callback',
      snippet: 'registerBoolServiceExtension(\n  name: "showPerformanceOverlay",\n  getter: () async => value,\n  setter: (v) async => setState(v),\n);',
      note: 'Pattern for custom debug toggles in app-level diagnostics.',
    ),
    _SnippetInfo(
      title: 'Failure triage hint',
      snippet: 'if extension is missing:\n  check build mode\n  verify attach mode\n  confirm asserts',
      note: 'Most extension availability issues originate from mode mismatch.',
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Operational Notes',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 10),
          for (final _SnippetInfo snippet in snippets)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD5E1E4)),
                  color: const Color(0xFFF9FCFD),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snippet.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF18272A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          snippet.snippet,
                          style: const TextStyle(
                            color: Color(0xFFD8F5FF),
                            fontFamily: 'monospace',
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(snippet.note),
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

Widget _buildChecklist() {
  const List<String> checklist = <String>[
    'Extension catalog includes tree, performance, and telemetry examples.',
    'Filter controls allow category exploration and debug-only focus.',
    'Scenario console demonstrates invocation paths and expected results.',
    'Heatmap summarizes extension distribution by operational category.',
    'Operational notes provide practical integration and triage snippets.',
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
          for (final String line in checklist)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.check_circle, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(line)),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

class _ExtensionCard extends StatelessWidget {
  const _ExtensionCard({required this.entry, required this.emphasize});

  final _ServiceExtensionEntry entry;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final Color accent = emphasize ? const Color(0xFFCA6A00) : const Color(0xFF0A6D74);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.55)),
        color: accent.withValues(alpha: 0.09),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    entry.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Chip(label: Text(entry.category)),
              ],
            ),
            const SizedBox(height: 4),
            Text(entry.detail),
            const SizedBox(height: 4),
            Text(
              entry.impact,
              style: const TextStyle(color: Color(0xFF485B61), fontSize: 12),
            ),
            const SizedBox(height: 6),
            Text(
              entry.defaultEnabledInDebug
                  ? 'Default debug availability: yes'
                  : 'Default debug availability: no (opt-in)',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceExtensionEntry {
  const _ServiceExtensionEntry({
    required this.name,
    required this.category,
    required this.detail,
    required this.impact,
    required this.defaultEnabledInDebug,
  });

  final String name;
  final String category;
  final String detail;
  final String impact;
  final bool defaultEnabledInDebug;
}

class _CommandScenario {
  const _CommandScenario({
    required this.title,
    required this.extensionName,
    required this.invocationPath,
    required this.expectedSignal,
  });

  final String title;
  final String extensionName;
  final String invocationPath;
  final String expectedSignal;
}

class _PipelineStep {
  const _PipelineStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

class _SnippetInfo {
  const _SnippetInfo({
    required this.title,
    required this.snippet,
    required this.note,
  });

  final String title;
  final String snippet;
  final String note;
}

class _MetricRow {
  const _MetricRow(this.keyLabel, this.value);

  final String keyLabel;
  final String value;
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
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nestedChild) {
            return builder(context, a, b);
          },
        );
      },
    );
  }
}

class ValueListenableBuilder3<A, B, C> extends StatelessWidget {
  const ValueListenableBuilder3({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final Widget Function(BuildContext context, A a, B b, C c) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nestedChild) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (BuildContext context, C c, Widget? leafChild) {
                return builder(context, a, b, c);
              },
            );
          },
        );
      },
    );
  }
}
