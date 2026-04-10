import 'package:flutter/material.dart';

void main() {
  runApp(const TextSelectionHandleControlsDeepDemoApp());
}

class TextSelectionHandleControlsDeepDemoApp extends StatelessWidget {
  const TextSelectionHandleControlsDeepDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextSelectionHandleControls Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F5F84)),
      ),
      home: const TextSelectionHandleControlsDeepDemoPage(),
    );
  }
}

class TextSelectionHandleControlsDeepDemoPage extends StatefulWidget {
  const TextSelectionHandleControlsDeepDemoPage({super.key});

  @override
  State<TextSelectionHandleControlsDeepDemoPage> createState() =>
      _TextSelectionHandleControlsDeepDemoPageState();
}

class _TextSelectionHandleControlsDeepDemoPageState
    extends State<TextSelectionHandleControlsDeepDemoPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);

  final ValueNotifier<HandleConfig> _config =
      ValueNotifier<HandleConfig>(const HandleConfig());
  final ValueNotifier<DragTelemetry> _telemetry =
      ValueNotifier<DragTelemetry>(const DragTelemetry.empty());

  final TextEditingController _controller = TextEditingController(text: _sampleText);

  @override
  void dispose() {
    _tabController.dispose();
    _config.dispose();
    _telemetry.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _log(String message) {
    _telemetry.value = _telemetry.value.push(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextSelectionHandleControls Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Anatomy'),
            Tab(text: 'Workbench'),
            Tab(text: 'Strategies'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AnatomyTab(config: _config),
          _WorkbenchTab(
            config: _config,
            telemetry: _telemetry,
            controller: _controller,
            onLog: _log,
          ),
          _StrategyTab(config: _config, onLog: _log),
        ],
      ),
    );
  }
}

class _AnatomyTab extends StatelessWidget {
  const _AnatomyTab({required this.config});

  final ValueNotifier<HandleConfig> config;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionTitle(
          title: 'Handle Anatomy',
          subtitle:
              'Selection handles are small but critical. Their geometry and '
              'touch target decide whether selection feels precise or frustrating.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _InfoCard(
              icon: Icons.radio_button_checked,
              title: 'Knob',
              details:
                  'The visible dot users anchor visually. Shape and contrast '
                  'communicate manipulability.',
            ),
            _InfoCard(
              icon: Icons.height,
              title: 'Stem',
              details:
                  'Connects knob to text baseline, preserving directional cues '
                  'for start/end handles.',
            ),
            _InfoCard(
              icon: Icons.gesture,
              title: 'Hit Region',
              details:
                  'Interactive area can exceed visible pixels to improve finger '
                  'selection reliability.',
            ),
          ],
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<HandleConfig>(
          valueListenable: config,
          builder: (context, value, _) {
            return _HandlePreviewStrip(config: value);
          },
        ),
      ],
    );
  }
}

class _HandlePreviewStrip extends StatelessWidget {
  const _HandlePreviewStrip({required this.config});

  final HandleConfig config;

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Live Geometry Preview',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _PreviewTile(
                  label: 'Start Handle',
                  child: CustomPaint(
                    size: const Size(84, 84),
                    painter: _HandlePainter(
                      style: config.style,
                      size: config.knobSize,
                      stemLength: config.stemLength,
                      color: config.color,
                      mirror: false,
                    ),
                  ),
                ),
                _PreviewTile(
                  label: 'End Handle',
                  child: CustomPaint(
                    size: const Size(84, 84),
                    painter: _HandlePainter(
                      style: config.style,
                      size: config.knobSize,
                      stemLength: config.stemLength,
                      color: config.color,
                      mirror: true,
                    ),
                  ),
                ),
                _PreviewTile(
                  label: 'Hit Target',
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: config.hitRadius * 2,
                        height: config.hitRadius * 2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cardColor,
                          border: Border.all(color: config.color),
                        ),
                      ),
                      Text('${config.hitRadius.toInt()}px'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkbenchTab extends StatefulWidget {
  const _WorkbenchTab({
    required this.config,
    required this.telemetry,
    required this.controller,
    required this.onLog,
  });

  final ValueNotifier<HandleConfig> config;
  final ValueNotifier<DragTelemetry> telemetry;
  final TextEditingController controller;
  final ValueChanged<String> onLog;

  @override
  State<_WorkbenchTab> createState() => _WorkbenchTabState();
}

class _WorkbenchTabState extends State<_WorkbenchTab> {
  final ValueNotifier<TextSelection> _selection =
      ValueNotifier<TextSelection>(const TextSelection.collapsed(offset: -1));

  @override
  void dispose() {
    _selection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 1080;
        if (wide) {
          return Row(
            children: [
              Expanded(child: _editorPanel(context)),
              SizedBox(width: 360, child: _controlsPanel(context)),
            ],
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _editorPanel(context),
            const SizedBox(height: 12),
            _controlsPanel(context),
          ],
        );
      },
    );
  }

  Widget _editorPanel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selection Workbench',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
            ),
            const SizedBox(height: 8),
            Text(
              'Adjust handle parameters and observe how selection gestures feel '
              'during dragging and range adjustments.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            ValueListenableBuilder<HandleConfig>(
              valueListenable: widget.config,
              builder: (context, cfg, _) {
                return _HandleOverlayShell(
                  config: cfg,
                  onDragStart: () => widget.onLog('handle drag started'),
                  onDragUpdate: (delta) =>
                      widget.onLog('handle drag update ${delta.dx.toStringAsFixed(1)}, ${delta.dy.toStringAsFixed(1)}'),
                  onDragEnd: () => widget.onLog('handle drag ended'),
                  child: TextField(
                    controller: widget.controller,
                    maxLines: 14,
                    minLines: 10,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Try selecting text and imagine custom handles.',
                    ),
                    onTap: () {
                      _selection.value = widget.controller.selection;
                      widget.onLog('tap selection changed');
                    },
                    onChanged: (_) {
                      _selection.value = widget.controller.selection;
                      widget.onLog('content changed');
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            ValueListenableBuilder<TextSelection>(
              valueListenable: _selection,
              builder: (context, selection, _) {
                final text = widget.controller.text;
                final excerpt = selection.isValid
                    ? selection.textInside(text).replaceAll('\n', ' ').trim()
                    : '';
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'base=${selection.baseOffset}, extent=${selection.extentOffset}, '
                    'len=${selection.isValid ? selection.end - selection.start : 0}\n'
                    'preview=${excerpt.isEmpty ? '(caret)' : excerpt}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _controlsPanel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<HandleConfig>(
          valueListenable: widget.config,
          builder: (context, cfg, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Control Panel',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(height: 10),
                _LabeledSlider(
                  label: 'Knob Size',
                  value: cfg.knobSize,
                  min: 8,
                  max: 28,
                  onChanged: (v) {
                    widget.config.value = cfg.copyWith(knobSize: v);
                    widget.onLog('knob size -> ${v.toStringAsFixed(1)}');
                  },
                ),
                _LabeledSlider(
                  label: 'Stem Length',
                  value: cfg.stemLength,
                  min: 6,
                  max: 34,
                  onChanged: (v) {
                    widget.config.value = cfg.copyWith(stemLength: v);
                    widget.onLog('stem length -> ${v.toStringAsFixed(1)}');
                  },
                ),
                _LabeledSlider(
                  label: 'Hit Radius',
                  value: cfg.hitRadius,
                  min: 16,
                  max: 42,
                  onChanged: (v) {
                    widget.config.value = cfg.copyWith(hitRadius: v);
                    widget.onLog('hit radius -> ${v.toStringAsFixed(1)}');
                  },
                ),
                const SizedBox(height: 10),
                SegmentedButton<HandleStyle>(
                  segments: HandleStyle.values
                      .map((s) => ButtonSegment(value: s, label: Text(s.label)))
                      .toList(),
                  selected: {cfg.style},
                  onSelectionChanged: (selection) {
                    final style = selection.first;
                    widget.config.value = cfg.copyWith(style: style);
                    widget.onLog('style -> ${style.label}');
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<Color>(
                  initialValue: cfg.color,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Handle Color',
                  ),
                  items: _palette
                      .map(
                        (color) => DropdownMenuItem(
                          value: color,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black26),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(_describeColor(color)),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (color) {
                    if (color == null) {
                      return;
                    }
                    widget.config.value = cfg.copyWith(color: color);
                    widget.onLog('color -> ${_describeColor(color)}');
                  },
                ),
                const SizedBox(height: 14),
                Text(
                  'Drag Telemetry',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: ValueListenableBuilder<DragTelemetry>(
                    valueListenable: widget.telemetry,
                    builder: (context, telemetry, _) {
                      return ListView.builder(
                        itemCount: telemetry.events.length,
                        itemBuilder: (context, index) {
                          final event = telemetry.events[index];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 12,
                              child: Text('${index + 1}'),
                            ),
                            title: Text(event),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StrategyTab extends StatelessWidget {
  const _StrategyTab({required this.config, required this.onLog});

  final ValueNotifier<HandleConfig> config;
  final ValueChanged<String> onLog;

  @override
  Widget build(BuildContext context) {
    final strategies = <HandleStrategy>[
      const HandleStrategy(
        title: 'Compact Reading Mode',
        target: 'Dense text and book-like typography',
        recommendation: [
          'Knob size: 10-12',
          'Stem length: 10-14',
          'Hit radius: 26+',
          'Rounded style for touch comfort',
        ],
      ),
      const HandleStrategy(
        title: 'Developer Editor Mode',
        target: 'Code editing with mouse precision',
        recommendation: [
          'Knob size: 8-10',
          'Stem length: 8-12',
          'Hit radius: 18-22',
          'Diamond style to improve directional cue',
        ],
      ),
      const HandleStrategy(
        title: 'Accessibility Mode',
        target: 'Large touch targets and strong contrast',
        recommendation: [
          'Knob size: 18-24',
          'Stem length: 20+',
          'Hit radius: 34-42',
          'Circular style and high-contrast color',
        ],
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionTitle(
          title: 'Implementation Strategies',
          subtitle:
              'Use strategy presets to keep handle decisions explicit and '
              'testable across product surfaces.',
        ),
        const SizedBox(height: 12),
        for (final strategy in strategies)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _StrategyCard(
              strategy: strategy,
              onApply: () {
                final current = config.value;
                switch (strategy.title) {
                  case 'Compact Reading Mode':
                    config.value = current.copyWith(
                      knobSize: 11,
                      stemLength: 12,
                      hitRadius: 28,
                      style: HandleStyle.rounded,
                    );
                  case 'Developer Editor Mode':
                    config.value = current.copyWith(
                      knobSize: 9,
                      stemLength: 10,
                      hitRadius: 20,
                      style: HandleStyle.diamond,
                    );
                  default:
                    config.value = current.copyWith(
                      knobSize: 20,
                      stemLength: 22,
                      hitRadius: 38,
                      style: HandleStyle.rounded,
                      color: const Color(0xFF0A4FA8),
                    );
                }
                onLog('Applied strategy: ${strategy.title}');
              },
            ),
          ),
      ],
    );
  }
}

class _StrategyCard extends StatelessWidget {
  const _StrategyCard({required this.strategy, required this.onApply});

  final HandleStrategy strategy;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    strategy.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                ),
                FilledButton.tonal(onPressed: onApply, child: const Text('Apply')),
              ],
            ),
            const SizedBox(height: 6),
            Text('Target: ${strategy.target}'),
            const SizedBox(height: 10),
            for (final item in strategy.recommendation)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• $item'),
              ),
          ],
        ),
      ),
    );
  }
}

class _HandleOverlayShell extends StatelessWidget {
  const _HandleOverlayShell({
    required this.config,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
    required this.child,
  });

  final HandleConfig config;
  final VoidCallback onDragStart;
  final ValueChanged<Offset> onDragUpdate;
  final VoidCallback onDragEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          right: 12,
          bottom: 12,
          child: GestureDetector(
            onPanStart: (_) => onDragStart(),
            onPanUpdate: (details) => onDragUpdate(details.delta),
            onPanEnd: (_) => onDragEnd(),
            child: Container(
              width: config.hitRadius,
              height: config.hitRadius,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: config.color.withValues(alpha: 0.9),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 2),
                    color: Colors.black26,
                  ),
                ],
              ),
              child: const Icon(Icons.open_with, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _HandlePainter extends CustomPainter {
  const _HandlePainter({
    required this.style,
    required this.size,
    required this.stemLength,
    required this.color,
    required this.mirror,
  });

  final HandleStyle style;
  final double size;
  final double stemLength;
  final Color color;
  final bool mirror;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()..color = color;
    final cx = canvasSize.width / 2;
    final cy = canvasSize.height / 2;

    canvas.save();
    if (mirror) {
      canvas.translate(canvasSize.width, 0);
      canvas.scale(-1, 1);
    }

    final stem = Path()
      ..moveTo(cx, cy - stemLength / 2)
      ..lineTo(cx, cy + stemLength / 2);
    canvas.drawPath(
      stem,
      Paint()
        ..color = color.withValues(alpha: 0.85)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    switch (style) {
      case HandleStyle.rounded:
        canvas.drawCircle(Offset(cx, cy - stemLength / 2), size / 2, paint);
      case HandleStyle.diamond:
        final diamond = Path()
          ..moveTo(cx, cy - stemLength / 2 - size / 2)
          ..lineTo(cx + size / 2, cy - stemLength / 2)
          ..lineTo(cx, cy - stemLength / 2 + size / 2)
          ..lineTo(cx - size / 2, cy - stemLength / 2)
          ..close();
        canvas.drawPath(diamond, paint);
      case HandleStyle.teardrop:
        final drop = Path()
          ..moveTo(cx, cy - stemLength / 2 - size / 2)
          ..quadraticBezierTo(
            cx + size / 2,
            cy - stemLength / 2,
            cx,
            cy - stemLength / 2 + size * 0.6,
          )
          ..quadraticBezierTo(
            cx - size / 2,
            cy - stemLength / 2,
            cx,
            cy - stemLength / 2 - size / 2,
          )
          ..close();
        canvas.drawPath(drop, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HandlePainter oldDelegate) {
    return oldDelegate.style != style ||
        oldDelegate.size != size ||
        oldDelegate.stemLength != stemLength ||
        oldDelegate.color != color ||
        oldDelegate.mirror != mirror;
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(subtitle),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.details,
  });

  final IconData icon;
  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 250, maxWidth: 350),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(details),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewTile extends StatelessWidget {
  const _PreviewTile({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Center(child: child),
        ],
      ),
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(1)}'),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

enum HandleStyle {
  rounded('Rounded'),
  diamond('Diamond'),
  teardrop('Teardrop');

  const HandleStyle(this.label);
  final String label;
}

@immutable
class HandleConfig {
  const HandleConfig({
    this.knobSize = 14,
    this.stemLength = 16,
    this.hitRadius = 28,
    this.style = HandleStyle.rounded,
    this.color = const Color(0xFF0D6FA8),
  });

  final double knobSize;
  final double stemLength;
  final double hitRadius;
  final HandleStyle style;
  final Color color;

  HandleConfig copyWith({
    double? knobSize,
    double? stemLength,
    double? hitRadius,
    HandleStyle? style,
    Color? color,
  }) {
    return HandleConfig(
      knobSize: knobSize ?? this.knobSize,
      stemLength: stemLength ?? this.stemLength,
      hitRadius: hitRadius ?? this.hitRadius,
      style: style ?? this.style,
      color: color ?? this.color,
    );
  }
}

@immutable
class DragTelemetry {
  const DragTelemetry({required this.events});

  const DragTelemetry.empty() : events = const ['Telemetry initialized'];

  final List<String> events;

  DragTelemetry push(String event) {
    final stamp = DateTime.now().toIso8601String().substring(11, 19);
    final next = [...events, '[$stamp] $event'];
    if (next.length > 100) {
      return DragTelemetry(events: next.sublist(next.length - 100));
    }
    return DragTelemetry(events: next);
  }
}

@immutable
class HandleStrategy {
  const HandleStrategy({
    required this.title,
    required this.target,
    required this.recommendation,
  });

  final String title;
  final String target;
  final List<String> recommendation;
}

const List<Color> _palette = [
  Color(0xFF0D6FA8),
  Color(0xFF2E7D32),
  Color(0xFF8E24AA),
  Color(0xFFD84315),
  Color(0xFF37474F),
];

String _describeColor(Color color) {
  if (color == const Color(0xFF0D6FA8)) {
    return 'Ocean Blue';
  }
  if (color == const Color(0xFF2E7D32)) {
    return 'Forest Green';
  }
  if (color == const Color(0xFF8E24AA)) {
    return 'Violet';
  }
  if (color == const Color(0xFFD84315)) {
    return 'Amber Clay';
  }
  return 'Slate';
}

const String _sampleText = '''Selection handles need to feel both visible and subtle.

If they are too small, users struggle to drag accurately.
If they are too large, they obscure the text itself.

A robust handle-controls design balances shape, color, and hit targets,
and aligns those choices with expected input method:
- mouse-first precision editing,
- finger-first touch editing,
- accessibility-focused larger controls.

This deep demo helps evaluate those decisions before wiring platform-specific
selection controls into production editors.''';
