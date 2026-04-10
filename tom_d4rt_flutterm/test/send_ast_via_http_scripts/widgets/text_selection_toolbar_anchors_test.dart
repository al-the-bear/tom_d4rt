import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const TextSelectionToolbarAnchorsDeepDemoApp());
}

class TextSelectionToolbarAnchorsDeepDemoApp extends StatelessWidget {
  const TextSelectionToolbarAnchorsDeepDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextSelectionToolbarAnchors Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A4C1B)),
      ),
      home: const TextSelectionToolbarAnchorsDeepDemoPage(),
    );
  }
}

class TextSelectionToolbarAnchorsDeepDemoPage extends StatefulWidget {
  const TextSelectionToolbarAnchorsDeepDemoPage({super.key});

  @override
  State<TextSelectionToolbarAnchorsDeepDemoPage> createState() =>
      _TextSelectionToolbarAnchorsDeepDemoPageState();
}

class _TextSelectionToolbarAnchorsDeepDemoPageState
    extends State<TextSelectionToolbarAnchorsDeepDemoPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);

  final ValueNotifier<AnchorScenario> _scenario =
      ValueNotifier<AnchorScenario>(const AnchorScenario());
  final ValueNotifier<AnchorComputation> _computation =
      ValueNotifier<AnchorComputation>(const AnchorComputation.initial());
  final ValueNotifier<List<String>> _log =
      ValueNotifier<List<String>>(<String>['Anchor demo initialized']);

  @override
  void dispose() {
    _tabController.dispose();
    _scenario.dispose();
    _computation.dispose();
    _log.dispose();
    super.dispose();
  }

  void _append(String text) {
    final stamp = DateTime.now().toIso8601String().substring(11, 19);
    final next = [..._log.value, '[$stamp] $text'];
    _log.value = next.length > 120 ? next.sublist(next.length - 120) : next;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextSelectionToolbarAnchors Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Concepts'),
            Tab(text: 'Anchor Map'),
            Tab(text: 'Policies'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ConceptsTab(scenario: _scenario),
          _AnchorMapTab(
            scenario: _scenario,
            computation: _computation,
            log: _log,
            onEvent: _append,
          ),
          _PoliciesTab(scenario: _scenario, onEvent: _append),
        ],
      ),
    );
  }
}

class _ConceptsTab extends StatelessWidget {
  const _ConceptsTab({required this.scenario});

  final ValueNotifier<AnchorScenario> scenario;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _TitleBlock(
          title: 'Anchor Concepts',
          subtitle:
              'Toolbar anchors represent candidate points around a selection. '
              'Placement logic selects the best candidate after constraints, '
              'viewport, and occlusion checks.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _ConceptCard(
              title: 'Primary Anchor',
              icon: Icons.adjust,
              text:
                  'Preferred position, often centered above selection. Used when '
                  'space is available and avoids covering text.',
            ),
            _ConceptCard(
              title: 'Secondary Anchor',
              icon: Icons.swap_vert,
              text:
                  'Fallback candidate (for example below selection) when primary '
                  'would clip or overlap restricted areas.',
            ),
            _ConceptCard(
              title: 'Clamped Output',
              icon: Icons.fit_screen,
              text:
                  'Final toolbar point after applying screen edges, safe areas, '
                  'and ergonomic minimum margins.',
            ),
          ],
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<AnchorScenario>(
          valueListenable: scenario,
          builder: (context, value, _) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selection Topology',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Current scenario: ${value.layout.label}. '
                      'Safe margin=${value.safeMargin.toStringAsFixed(0)}px, '
                      'toolbar height=${value.toolbarHeight.toStringAsFixed(0)}px.',
                    ),
                    const SizedBox(height: 12),
                    _TopologyChips(scenario: value),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AnchorMapTab extends StatefulWidget {
  const _AnchorMapTab({
    required this.scenario,
    required this.computation,
    required this.log,
    required this.onEvent,
  });

  final ValueNotifier<AnchorScenario> scenario;
  final ValueNotifier<AnchorComputation> computation;
  final ValueNotifier<List<String>> log;
  final ValueChanged<String> onEvent;

  @override
  State<_AnchorMapTab> createState() => _AnchorMapTabState();
}

class _AnchorMapTabState extends State<_AnchorMapTab> {
  final ValueNotifier<Offset> _selectionCenter =
      ValueNotifier<Offset>(const Offset(260, 220));

  @override
  void dispose() {
    _selectionCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 1120;
        if (wide) {
          return Row(
            children: [
              Expanded(child: _mapPanel(context)),
              SizedBox(width: 380, child: _inspector(context)),
            ],
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _mapPanel(context),
            const SizedBox(height: 12),
            _inspector(context),
          ],
        );
      },
    );
  }

  Widget _mapPanel(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<AnchorScenario>(
          valueListenable: widget.scenario,
          builder: (context, scenario, _) {
            return ValueListenableBuilder<Offset>(
              valueListenable: _selectionCenter,
              builder: (context, center, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interactive Anchor Map',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Drag the selection marker. The engine computes primary, '
                      'secondary, and clamped toolbar anchors in real time.',
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, box) {
                          final viewport = Size(box.maxWidth, box.maxHeight);
                          final computation = _computeAnchors(
                            viewport: viewport,
                            center: center,
                            scenario: scenario,
                          );
                          widget.computation.value = computation;

                          return GestureDetector(
                            onPanUpdate: (details) {
                              final local = details.localPosition;
                              _selectionCenter.value = Offset(
                                local.dx.clamp(20, viewport.width - 20),
                                local.dy.clamp(20, viewport.height - 20),
                              );
                              widget.onEvent(
                                'Selection moved to '
                                '(${_selectionCenter.value.dx.toStringAsFixed(0)}, '
                                '${_selectionCenter.value.dy.toStringAsFixed(0)})',
                              );
                            },
                            child: CustomPaint(
                              painter: _AnchorMapPainter(
                                scenario: scenario,
                                computation: computation,
                                selectionCenter: _selectionCenter.value,
                              ),
                              child: const SizedBox.expand(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        _LegendChip(color: const Color(0xFF0D47A1), text: 'Primary'),
                        _LegendChip(color: const Color(0xFF2E7D32), text: 'Secondary'),
                        _LegendChip(color: const Color(0xFFD84315), text: 'Clamped'),
                        _LegendChip(color: const Color(0xFF6A1B9A), text: 'Selection'),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _inspector(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inspector',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<AnchorScenario>(
              valueListenable: widget.scenario,
              builder: (context, scenario, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<LayoutMode>(
                      segments: LayoutMode.values
                          .map((m) => ButtonSegment(value: m, label: Text(m.label)))
                          .toList(),
                      selected: {scenario.layout},
                      onSelectionChanged: (selection) {
                        widget.scenario.value =
                            scenario.copyWith(layout: selection.first);
                        widget.onEvent('Layout switched to ${selection.first.label}');
                      },
                    ),
                    const SizedBox(height: 10),
                    _SliderRow(
                      label: 'Safe Margin',
                      value: scenario.safeMargin,
                      min: 4,
                      max: 48,
                      onChanged: (v) {
                        widget.scenario.value = scenario.copyWith(safeMargin: v);
                        widget.onEvent('Safe margin -> ${v.toStringAsFixed(0)}');
                      },
                    ),
                    _SliderRow(
                      label: 'Toolbar Height',
                      value: scenario.toolbarHeight,
                      min: 28,
                      max: 88,
                      onChanged: (v) {
                        widget.scenario.value = scenario.copyWith(toolbarHeight: v);
                        widget.onEvent('Toolbar height -> ${v.toStringAsFixed(0)}');
                      },
                    ),
                    _SliderRow(
                      label: 'Anchor Gap',
                      value: scenario.anchorGap,
                      min: 8,
                      max: 48,
                      onChanged: (v) {
                        widget.scenario.value = scenario.copyWith(anchorGap: v);
                        widget.onEvent('Anchor gap -> ${v.toStringAsFixed(0)}');
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<AnchorComputation>(
              valueListenable: widget.computation,
              builder: (context, value, _) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Primary: ${value.primary.dx.toStringAsFixed(1)}, ${value.primary.dy.toStringAsFixed(1)}\n'
                    'Secondary: ${value.secondary.dx.toStringAsFixed(1)}, ${value.secondary.dy.toStringAsFixed(1)}\n'
                    'Clamped: ${value.clamped.dx.toStringAsFixed(1)}, ${value.clamped.dy.toStringAsFixed(1)}\n'
                    'Decision: ${value.decision}',
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Event Log',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: ValueListenableBuilder<List<String>>(
                valueListenable: widget.log,
                builder: (context, events, _) {
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 12,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(events[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnchorComputation _computeAnchors({
    required Size viewport,
    required Offset center,
    required AnchorScenario scenario,
  }) {
    final primary = Offset(center.dx, center.dy - scenario.anchorGap);
    final secondary = Offset(center.dx, center.dy + scenario.anchorGap);

    final preferAbove = center.dy > viewport.height * 0.34;
    final candidate = preferAbove ? primary : secondary;

    final clamped = Offset(
      candidate.dx.clamp(
        scenario.safeMargin,
        viewport.width - scenario.safeMargin,
      ),
      candidate.dy.clamp(
        scenario.safeMargin + scenario.toolbarHeight / 2,
        viewport.height - scenario.safeMargin - scenario.toolbarHeight / 2,
      ),
    );

    final blockedByKeyboard =
        scenario.layout == LayoutMode.keyboard && candidate.dy > viewport.height * 0.70;
    final blockedByEdge = candidate.dy < scenario.safeMargin + scenario.toolbarHeight / 2;
    final blockedByNotch = scenario.layout == LayoutMode.notch &&
        candidate.dy < (scenario.safeMargin + scenario.toolbarHeight);

    final decision = blockedByKeyboard
        ? 'secondary due to keyboard intrusion'
        : blockedByEdge
            ? 'secondary due to top edge'
            : blockedByNotch
                ? 'secondary due to notch safe zone'
                : preferAbove
                    ? 'primary above selection'
                    : 'secondary below selection';

    return AnchorComputation(
      primary: primary,
      secondary: secondary,
      clamped: clamped,
      decision: decision,
    );
  }
}

class _PoliciesTab extends StatelessWidget {
  const _PoliciesTab({required this.scenario, required this.onEvent});

  final ValueNotifier<AnchorScenario> scenario;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    final items = <AnchorPolicyPreset>[
      const AnchorPolicyPreset(
        title: 'Dense Navigation Bars',
        summary:
            'Increase top safe margin and bias anchors below selection when '
            'the upper viewport is visually crowded.',
        knobs: [
          'safeMargin: 24',
          'toolbarHeight: 52',
          'layout: Notch',
        ],
      ),
      const AnchorPolicyPreset(
        title: 'Bottom Keyboard Active',
        summary:
            'Use aggressive clamping to keep the toolbar above virtual keyboard '
            'while preserving pointer travel predictability.',
        knobs: [
          'safeMargin: 16',
          'toolbarHeight: 48',
          'layout: Keyboard',
        ],
      ),
      const AnchorPolicyPreset(
        title: 'Immersive Reader',
        summary:
            'Prefer top placement with modest margins for low-distraction '
            'full-screen reading surfaces.',
        knobs: [
          'safeMargin: 10',
          'toolbarHeight: 40',
          'layout: Standard',
        ],
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _TitleBlock(
          title: 'Policy Presets',
          subtitle:
              'Anchor presets make placement choices explicit and reviewable '
              'across design and engineering teams.',
        ),
        const SizedBox(height: 12),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _PresetCard(
              preset: item,
              onApply: () {
                final current = scenario.value;
                switch (item.title) {
                  case 'Dense Navigation Bars':
                    scenario.value = current.copyWith(
                      safeMargin: 24,
                      toolbarHeight: 52,
                      layout: LayoutMode.notch,
                    );
                  case 'Bottom Keyboard Active':
                    scenario.value = current.copyWith(
                      safeMargin: 16,
                      toolbarHeight: 48,
                      layout: LayoutMode.keyboard,
                    );
                  default:
                    scenario.value = current.copyWith(
                      safeMargin: 10,
                      toolbarHeight: 40,
                      layout: LayoutMode.standard,
                    );
                }
                onEvent('Applied preset: ${item.title}');
              },
            ),
          ),
      ],
    );
  }
}

class _AnchorMapPainter extends CustomPainter {
  const _AnchorMapPainter({
    required this.scenario,
    required this.computation,
    required this.selectionCenter,
  });

  final AnchorScenario scenario;
  final AnchorComputation computation;
  final Offset selectionCenter;

  @override
  void paint(Canvas canvas, Size size) {
    _paintBackground(canvas, size);
    _paintSafeRegion(canvas, size);
    _paintSelection(canvas);
    _paintAnchorPoint(canvas, computation.primary, const Color(0xFF0D47A1), 'P');
    _paintAnchorPoint(canvas, computation.secondary, const Color(0xFF2E7D32), 'S');
    _paintAnchorPoint(canvas, computation.clamped, const Color(0xFFD84315), 'C');
    _paintToolbarGhost(canvas, computation.clamped, scenario.toolbarHeight);
  }

  void _paintBackground(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFFFFF7E8),
          const Color(0xFFFFF0DE),
          const Color(0xFFFFF7E8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  void _paintSafeRegion(Canvas canvas, Size size) {
    final safe = scenario.safeMargin;
    final inner = Rect.fromLTWH(
      safe,
      safe,
      size.width - safe * 2,
      size.height - safe * 2,
    );
    canvas.drawRect(
      inner,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF8D6E63),
    );

    if (scenario.layout == LayoutMode.notch) {
      final notch = Rect.fromCenter(
        center: Offset(size.width / 2, safe + 10),
        width: math.min(size.width * 0.35, 180),
        height: 20,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(notch, const Radius.circular(12)),
        Paint()..color = const Color(0xFF6D4C41),
      );
    }

    if (scenario.layout == LayoutMode.keyboard) {
      final keyboard = Rect.fromLTWH(
        safe,
        size.height * 0.72,
        size.width - safe * 2,
        size.height * 0.28 - safe,
      );
      canvas.drawRect(
        keyboard,
        Paint()..color = const Color(0xFFBCAAA4).withValues(alpha: 0.45),
      );
    }
  }

  void _paintSelection(Canvas canvas) {
    final rect = Rect.fromCenter(center: selectionCenter, width: 110, height: 34);
    final rr = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(rr, Paint()..color = const Color(0xFF6A1B9A).withValues(alpha: 0.2));
    canvas.drawRRect(
      rr,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF6A1B9A),
    );
  }

  void _paintAnchorPoint(Canvas canvas, Offset point, Color color, String label) {
    canvas.drawCircle(point, 8, Paint()..color = color);
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, point - Offset(painter.width / 2, painter.height / 2));
  }

  void _paintToolbarGhost(Canvas canvas, Offset center, double height) {
    final rect = Rect.fromCenter(center: center, width: 180, height: height);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      Paint()..color = const Color(0xFF4E342E).withValues(alpha: 0.82),
    );
  }

  @override
  bool shouldRepaint(covariant _AnchorMapPainter oldDelegate) {
    return oldDelegate.scenario != scenario ||
        oldDelegate.computation != computation ||
        oldDelegate.selectionCenter != selectionCenter;
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
        ),
        const SizedBox(height: 6),
        Text(subtitle),
      ],
    );
  }
}

class _ConceptCard extends StatelessWidget {
  const _ConceptCard({
    required this.title,
    required this.icon,
    required this.text,
  });

  final String title;
  final IconData icon;
  final String text;

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
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopologyChips extends StatelessWidget {
  const _TopologyChips({required this.scenario});

  final AnchorScenario scenario;

  @override
  Widget build(BuildContext context) {
    final tags = <String>[
      'layout:${scenario.layout.label}',
      'margin:${scenario.safeMargin.toStringAsFixed(0)}',
      'gap:${scenario.anchorGap.toStringAsFixed(0)}',
      'toolbar:${scenario.toolbarHeight.toStringAsFixed(0)}',
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final tag in tags) Chip(label: Text(tag)),
      ],
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: color.withValues(alpha: 0.18),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
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
        Text('$label: ${value.toStringAsFixed(0)}'),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _PresetCard extends StatelessWidget {
  const _PresetCard({required this.preset, required this.onApply});

  final AnchorPolicyPreset preset;
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
                    preset.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                ),
                FilledButton.tonal(onPressed: onApply, child: const Text('Apply')),
              ],
            ),
            const SizedBox(height: 8),
            Text(preset.summary),
            const SizedBox(height: 10),
            for (final knob in preset.knobs)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• $knob'),
              ),
          ],
        ),
      ),
    );
  }
}

enum LayoutMode {
  standard('Standard'),
  notch('Notch'),
  keyboard('Keyboard');

  const LayoutMode(this.label);
  final String label;
}

@immutable
class AnchorScenario {
  const AnchorScenario({
    this.layout = LayoutMode.standard,
    this.safeMargin = 14,
    this.toolbarHeight = 44,
    this.anchorGap = 24,
  });

  final LayoutMode layout;
  final double safeMargin;
  final double toolbarHeight;
  final double anchorGap;

  AnchorScenario copyWith({
    LayoutMode? layout,
    double? safeMargin,
    double? toolbarHeight,
    double? anchorGap,
  }) {
    return AnchorScenario(
      layout: layout ?? this.layout,
      safeMargin: safeMargin ?? this.safeMargin,
      toolbarHeight: toolbarHeight ?? this.toolbarHeight,
      anchorGap: anchorGap ?? this.anchorGap,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AnchorScenario &&
        other.layout == layout &&
        other.safeMargin == safeMargin &&
        other.toolbarHeight == toolbarHeight &&
        other.anchorGap == anchorGap;
  }

  @override
  int get hashCode => Object.hash(layout, safeMargin, toolbarHeight, anchorGap);
}

@immutable
class AnchorComputation {
  const AnchorComputation({
    required this.primary,
    required this.secondary,
    required this.clamped,
    required this.decision,
  });

  const AnchorComputation.initial()
      : primary = const Offset(0, 0),
        secondary = const Offset(0, 0),
        clamped = const Offset(0, 0),
        decision = 'not computed yet';

  final Offset primary;
  final Offset secondary;
  final Offset clamped;
  final String decision;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AnchorComputation &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.clamped == clamped &&
        other.decision == decision;
  }

  @override
  int get hashCode => Object.hash(primary, secondary, clamped, decision);
}

@immutable
class AnchorPolicyPreset {
  const AnchorPolicyPreset({
    required this.title,
    required this.summary,
    required this.knobs,
  });

  final String title;
  final String summary;
  final List<String> knobs;
}
