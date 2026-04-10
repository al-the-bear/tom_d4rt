import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

void main() {
  runApp(const ToggleablePainterDeepDemoApp());
}

class ToggleablePainterDeepDemoApp extends StatelessWidget {
  const ToggleablePainterDeepDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToggleablePainter Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E6F64)),
      ),
      home: const ToggleablePainterDeepDemoPage(),
    );
  }
}

class ToggleablePainterDeepDemoPage extends StatefulWidget {
  const ToggleablePainterDeepDemoPage({super.key});

  @override
  State<ToggleablePainterDeepDemoPage> createState() =>
      _ToggleablePainterDeepDemoPageState();
}

class _ToggleablePainterDeepDemoPageState
    extends State<ToggleablePainterDeepDemoPage>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);

  final ValueNotifier<PainterConfig> _config =
      ValueNotifier<PainterConfig>(const PainterConfig());
  final ValueNotifier<List<String>> _events =
      ValueNotifier<List<String>>(<String>['Painter demo initialized']);

  late final AnimationController _positionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
    value: 0,
  );

  late final AnimationController _reactionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
    value: 0,
  );

  late final AnimationController _hoverController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
    value: 0,
  );

  @override
  void dispose() {
    _tabController.dispose();
    _config.dispose();
    _events.dispose();
    _positionController.dispose();
    _reactionController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  void _append(String message) {
    final stamp = DateTime.now().toIso8601String().substring(11, 19);
    final next = [..._events.value, '[$stamp] $message'];
    _events.value = next.length > 140 ? next.sublist(next.length - 140) : next;
  }

  void _toggle(bool checked) {
    _positionController.animateTo(
      checked ? 1 : 0,
      curve: Curves.easeOutCubic,
    );
    _reactionController
      ..value = 0
      ..forward();
    _append('Toggle changed: ${checked ? 'ON' : 'OFF'}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToggleablePainter Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Paint Pipeline'),
            Tab(text: 'Canvas Studio'),
            Tab(text: 'Variants'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _PipelineTab(config: _config),
          _CanvasStudioTab(
            config: _config,
            events: _events,
            positionController: _positionController,
            reactionController: _reactionController,
            hoverController: _hoverController,
            onEvent: _append,
            onToggle: _toggle,
          ),
          _VariantsTab(config: _config, onEvent: _append, onToggle: _toggle),
        ],
      ),
    );
  }
}

class _PipelineTab extends StatelessWidget {
  const _PipelineTab({required this.config});

  final ValueNotifier<PainterConfig> config;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionTitle(
          title: 'Toggleable Paint Pipeline',
          subtitle:
              'ToggleablePainter composes layered visuals: reaction ink, outer '
              'shape, inner fill, mark stroke, and state overlays.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _StageCard(
              icon: Icons.blur_circular,
              title: 'Reaction Layer',
              text:
                  'Transient radial splash indicating press intent and focus '
                  'feedback before state transition completes.',
            ),
            _StageCard(
              icon: Icons.crop_square,
              title: 'Container Layer',
              text:
                  'Base shape (checkbox/radio/switch capsule) sets semantic '
                  'boundary and contrast rules.',
            ),
            _StageCard(
              icon: Icons.check,
              title: 'Mark Layer',
              text:
                  'Check/dot/knob interpolation follows animation position and '
                  'state-specific opacity curves.',
            ),
            _StageCard(
              icon: Icons.block,
              title: 'Disabled Overlay',
              text:
                  'Desaturates and softens edges without losing affordance '
                  'recognition for accessibility.',
            ),
          ],
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<PainterConfig>(
          valueListenable: config,
          builder: (context, cfg, _) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Visual Contract',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text('Shape: ${cfg.shape.label}')),
                        Chip(label: Text('Stroke: ${cfg.strokeWidth.toStringAsFixed(1)}')),
                        Chip(label: Text('Reaction: ${cfg.reactionRadius.toStringAsFixed(0)}')),
                        Chip(label: Text('Mark Scale: ${cfg.markScale.toStringAsFixed(2)}')),
                        Chip(label: Text('Disabled: ${cfg.disabled ? 'Yes' : 'No'}')),
                      ],
                    ),
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

class _CanvasStudioTab extends StatefulWidget {
  const _CanvasStudioTab({
    required this.config,
    required this.events,
    required this.positionController,
    required this.reactionController,
    required this.hoverController,
    required this.onEvent,
    required this.onToggle,
  });

  final ValueNotifier<PainterConfig> config;
  final ValueNotifier<List<String>> events;
  final AnimationController positionController;
  final AnimationController reactionController;
  final AnimationController hoverController;
  final ValueChanged<String> onEvent;
  final ValueChanged<bool> onToggle;

  @override
  State<_CanvasStudioTab> createState() => _CanvasStudioTabState();
}

class _CanvasStudioTabState extends State<_CanvasStudioTab> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 1150;
        if (wide) {
          return Row(
            children: [
              Expanded(child: _paintPreview(context)),
              SizedBox(width: 420, child: _controlPanel(context)),
            ],
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _paintPreview(context),
            const SizedBox(height: 12),
            _controlPanel(context),
          ],
        );
      },
    );
  }

  Widget _paintPreview(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<PainterConfig>(
          valueListenable: widget.config,
          builder: (context, cfg, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Interactive Canvas',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tap the control to replay mark and reaction animations. Hover '
                  'on desktop to inspect the hover overlay contribution.',
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Center(
                    child: MouseRegion(
                      onEnter: (_) {
                        widget.hoverController.animateTo(1);
                        widget.onEvent('hover entered');
                      },
                      onExit: (_) {
                        widget.hoverController.animateTo(0);
                        widget.onEvent('hover exited');
                      },
                      child: GestureDetector(
                        onTap: cfg.disabled
                            ? null
                            : () {
                                setState(() => _checked = !_checked);
                                widget.onToggle(_checked);
                              },
                        child: AnimatedBuilder(
                          animation: Listenable.merge([
                            widget.positionController,
                            widget.reactionController,
                            widget.hoverController,
                          ]),
                          builder: (context, _) {
                            return CustomPaint(
                              size: const Size(220, 220),
                              painter: _ToggleablePainterDemo(
                                config: cfg,
                                position: widget.positionController.value,
                                reaction: widget.reactionController.value,
                                hover: widget.hoverController.value,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: cfg.disabled
                          ? null
                          : () {
                              setState(() => _checked = !_checked);
                              widget.onToggle(_checked);
                            },
                      icon: Icon(_checked ? Icons.toggle_on : Icons.toggle_off),
                      label: Text(_checked ? 'Set OFF' : 'Set ON'),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {
                        widget.reactionController
                          ..value = 0
                          ..forward();
                        widget.onEvent('reaction replay requested');
                      },
                      child: const Text('Replay Reaction'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _controlPanel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<PainterConfig>(
          valueListenable: widget.config,
          builder: (context, cfg, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Painter Controls',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(height: 10),
                SegmentedButton<ToggleShape>(
                  segments: ToggleShape.values
                      .map((s) => ButtonSegment(value: s, label: Text(s.label)))
                      .toList(),
                  selected: {cfg.shape},
                  onSelectionChanged: (selection) {
                    widget.config.value = cfg.copyWith(shape: selection.first);
                    widget.onEvent('shape -> ${selection.first.label}');
                  },
                ),
                const SizedBox(height: 8),
                _SliderRow(
                  label: 'Stroke Width',
                  value: cfg.strokeWidth,
                  min: 1,
                  max: 6,
                  onChanged: (v) {
                    widget.config.value = cfg.copyWith(strokeWidth: v);
                    widget.onEvent('strokeWidth -> ${v.toStringAsFixed(1)}');
                  },
                ),
                _SliderRow(
                  label: 'Reaction Radius',
                  value: cfg.reactionRadius,
                  min: 20,
                  max: 80,
                  onChanged: (v) {
                    widget.config.value = cfg.copyWith(reactionRadius: v);
                    widget.onEvent('reactionRadius -> ${v.toStringAsFixed(0)}');
                  },
                ),
                _SliderRow(
                  label: 'Mark Scale',
                  value: cfg.markScale,
                  min: 0.4,
                  max: 1.3,
                  onChanged: (v) {
                    widget.config.value = cfg.copyWith(markScale: v);
                    widget.onEvent('markScale -> ${v.toStringAsFixed(2)}');
                  },
                ),
                const SizedBox(height: 8),
                FilterChip(
                  selected: cfg.disabled,
                  label: const Text('Disabled State'),
                  onSelected: (selected) {
                    widget.config.value = cfg.copyWith(disabled: selected);
                    widget.onEvent('disabled ${selected ? 'enabled' : 'cleared'}');
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  'Event Timeline',
                  style: TextStyle(fontWeight: FontWeight.w700, color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: ValueListenableBuilder<List<String>>(
                    valueListenable: widget.events,
                    builder: (context, events, _) {
                      return ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(events[index]),
                        ),
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

class _VariantsTab extends StatelessWidget {
  const _VariantsTab({
    required this.config,
    required this.onEvent,
    required this.onToggle,
  });

  final ValueNotifier<PainterConfig> config;
  final ValueChanged<String> onEvent;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final variants = <PainterVariant>[
      const PainterVariant(
        title: 'Reading App Checkbox',
        summary:
            'Soft reaction and medium stroke improve comfort in long reading '
            'sessions where controls should stay understated.',
        config: PainterConfig(
          shape: ToggleShape.checkbox,
          strokeWidth: 2.4,
          reactionRadius: 40,
          markScale: 0.95,
          disabled: false,
        ),
      ),
      const PainterVariant(
        title: 'Settings Radio',
        summary:
            'Compact reaction and crisp mark optimize for dense settings forms '
            'with many adjacent options.',
        config: PainterConfig(
          shape: ToggleShape.radio,
          strokeWidth: 2.0,
          reactionRadius: 30,
          markScale: 1.05,
          disabled: false,
        ),
      ),
      const PainterVariant(
        title: 'Disabled Preference',
        summary:
            'Demonstrates contrast and opacity balancing when control is '
            'temporarily unavailable but still needs to be legible.',
        config: PainterConfig(
          shape: ToggleShape.checkbox,
          strokeWidth: 2.8,
          reactionRadius: 34,
          markScale: 0.9,
          disabled: true,
        ),
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionTitle(
          title: 'Painter Variants',
          subtitle:
              'Package painter choices into named variants so products can '
              'apply consistent visuals with predictable behavior.',
        ),
        const SizedBox(height: 12),
        for (final variant in variants)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _VariantCard(
              variant: variant,
              onApply: () {
                config.value = variant.config;
                onToggle(!variant.config.disabled);
                onEvent('Applied variant: ${variant.title}');
              },
            ),
          ),
      ],
    );
  }
}

class _ToggleablePainterDemo extends CustomPainter {
  const _ToggleablePainterDemo({
    required this.config,
    required this.position,
    required this.reaction,
    required this.hover,
  });

  final PainterConfig config;
  final double position;
  final double reaction;
  final double hover;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final reactionRadius = config.reactionRadius * Curves.easeOut.transform(reaction);

    if (reaction > 0) {
      final reactionPaint = Paint()
        ..color = const Color(0xFF26A69A).withValues(alpha: (1 - reaction) * 0.35)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, reactionRadius, reactionPaint);
    }

    final outerRect = Rect.fromCenter(center: center, width: 88, height: 88);
    final fill = Color.lerp(const Color(0xFFE0F2F1), const Color(0xFF00897B), position)!;
    final stroke = Color.lerp(const Color(0xFF4DB6AC), const Color(0xFF004D40), position)!;

    switch (config.shape) {
      case ToggleShape.checkbox:
        final rr = RRect.fromRectAndRadius(outerRect, const Radius.circular(18));
        canvas.drawRRect(rr, Paint()..color = fill);
        canvas.drawRRect(
          rr,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = config.strokeWidth
            ..color = stroke,
        );
      case ToggleShape.radio:
        canvas.drawCircle(center, 42, Paint()..color = fill);
        canvas.drawCircle(
          center,
          42,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = config.strokeWidth
            ..color = stroke,
        );
      case ToggleShape.switchCapsule:
        final capsule = RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: 128, height: 72),
          const Radius.circular(40),
        );
        canvas.drawRRect(capsule, Paint()..color = fill);
        canvas.drawRRect(
          capsule,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = config.strokeWidth
            ..color = stroke,
        );
    }

    _paintMark(canvas, center);

    if (hover > 0) {
      canvas.drawCircle(
        center,
        52,
        Paint()..color = const Color(0xFF004D40).withValues(alpha: hover * 0.12),
      );
    }

    if (config.disabled) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: 140, height: 140),
          const Radius.circular(24),
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.45),
      );
    }
  }

  void _paintMark(Canvas canvas, Offset center) {
    final progress = Curves.easeOut.transform(position).clamp(0.0, 1.0);
    final markPaint = Paint()
      ..color = config.disabled
          ? const Color(0xFF78909C)
          : const Color(0xFFFFFFFF).withValues(alpha: 0.94)
      ..strokeWidth = 5 * config.markScale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    switch (config.shape) {
      case ToggleShape.checkbox:
        final p1 = center + Offset(-20 * config.markScale, 0);
        final p2 = center + Offset(-4 * config.markScale, 18 * config.markScale);
        final p3 = center + Offset(24 * config.markScale, -16 * config.markScale);

        if (progress <= 0.5) {
          final local = progress / 0.5;
          final p = Offset.lerp(p1, p2, local)!;
          canvas.drawLine(p1, p, markPaint);
        } else {
          canvas.drawLine(p1, p2, markPaint);
          final local = (progress - 0.5) / 0.5;
          final p = Offset.lerp(p2, p3, local)!;
          canvas.drawLine(p2, p, markPaint);
        }
      case ToggleShape.radio:
        canvas.drawCircle(
          center,
          20 * config.markScale * progress,
          Paint()..color = markPaint.color,
        );
      case ToggleShape.switchCapsule:
        final dx = lerpDouble(-32, 32, progress)!;
        canvas.drawCircle(
          center + Offset(dx, 0),
          20 * config.markScale,
          Paint()..color = markPaint.color,
        );
    }
  }

  @override
  bool shouldRepaint(covariant _ToggleablePainterDemo oldDelegate) {
    return oldDelegate.config != config ||
        oldDelegate.position != position ||
        oldDelegate.reaction != reaction ||
        oldDelegate.hover != hover;
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
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
        ),
        const SizedBox(height: 6),
        Text(subtitle),
      ],
    );
  }
}

class _StageCard extends StatelessWidget {
  const _StageCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final String title;
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
        Text('$label: ${value.toStringAsFixed(2)}'),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _VariantCard extends StatelessWidget {
  const _VariantCard({required this.variant, required this.onApply});

  final PainterVariant variant;
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
                    variant.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                ),
                FilledButton.tonal(onPressed: onApply, child: const Text('Apply')),
              ],
            ),
            const SizedBox(height: 8),
            Text(variant.summary),
            const SizedBox(height: 10),
            Text(
              'shape=${variant.config.shape.label}, '
              'stroke=${variant.config.strokeWidth.toStringAsFixed(1)}, '
              'reaction=${variant.config.reactionRadius.toStringAsFixed(0)}',
            ),
          ],
        ),
      ),
    );
  }
}

enum ToggleShape {
  checkbox('Checkbox'),
  radio('Radio'),
  switchCapsule('Switch');

  const ToggleShape(this.label);
  final String label;
}

@immutable
class PainterConfig {
  const PainterConfig({
    this.shape = ToggleShape.checkbox,
    this.strokeWidth = 2.4,
    this.reactionRadius = 38,
    this.markScale = 1,
    this.disabled = false,
  });

  final ToggleShape shape;
  final double strokeWidth;
  final double reactionRadius;
  final double markScale;
  final bool disabled;

  PainterConfig copyWith({
    ToggleShape? shape,
    double? strokeWidth,
    double? reactionRadius,
    double? markScale,
    bool? disabled,
  }) {
    return PainterConfig(
      shape: shape ?? this.shape,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      reactionRadius: reactionRadius ?? this.reactionRadius,
      markScale: markScale ?? this.markScale,
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PainterConfig &&
        other.shape == shape &&
        other.strokeWidth == strokeWidth &&
        other.reactionRadius == reactionRadius &&
        other.markScale == markScale &&
        other.disabled == disabled;
  }

  @override
  int get hashCode =>
      Object.hash(shape, strokeWidth, reactionRadius, markScale, disabled);
}

@immutable
class PainterVariant {
  const PainterVariant({
    required this.title,
    required this.summary,
    required this.config,
  });

  final String title;
  final String summary;
  final PainterConfig config;
}
