import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const TextSelectionToolbarLayoutDelegateDeepDemoApp());
}

class TextSelectionToolbarLayoutDelegateDeepDemoApp extends StatelessWidget {
  const TextSelectionToolbarLayoutDelegateDeepDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextSelectionToolbarLayoutDelegate Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B3A9E)),
      ),
      home: const TextSelectionToolbarLayoutDelegateDeepDemoPage(),
    );
  }
}

class TextSelectionToolbarLayoutDelegateDeepDemoPage extends StatefulWidget {
  const TextSelectionToolbarLayoutDelegateDeepDemoPage({super.key});

  @override
  State<TextSelectionToolbarLayoutDelegateDeepDemoPage> createState() =>
      _TextSelectionToolbarLayoutDelegateDeepDemoPageState();
}

class _TextSelectionToolbarLayoutDelegateDeepDemoPageState
    extends State<TextSelectionToolbarLayoutDelegateDeepDemoPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);

  final ValueNotifier<DelegateConfig> _config =
      ValueNotifier<DelegateConfig>(const DelegateConfig());
  final ValueNotifier<LayoutComputation> _computation =
      ValueNotifier<LayoutComputation>(const LayoutComputation.initial());
  final ValueNotifier<List<String>> _events =
      ValueNotifier<List<String>>(<String>['Delegate playground initialized']);

  @override
  void dispose() {
    _tabController.dispose();
    _config.dispose();
    _computation.dispose();
    _events.dispose();
    super.dispose();
  }

  void _append(String message) {
    final stamp = DateTime.now().toIso8601String().substring(11, 19);
    final next = [..._events.value, '[$stamp] $message'];
    _events.value = next.length > 140 ? next.sublist(next.length - 140) : next;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextSelectionToolbarLayoutDelegate Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Delegate Model'),
            Tab(text: 'Ranking Lab'),
            Tab(text: 'Patterns'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DelegateModelTab(config: _config),
          _RankingLabTab(
            config: _config,
            computation: _computation,
            events: _events,
            onEvent: _append,
          ),
          _PatternsTab(config: _config, onEvent: _append),
        ],
      ),
    );
  }
}

class _DelegateModelTab extends StatelessWidget {
  const _DelegateModelTab({required this.config});

  final ValueNotifier<DelegateConfig> config;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _Header(
          title: 'Layout Delegate Model',
          subtitle:
              'A toolbar layout delegate evaluates candidate positions and '
              'selects one through deterministic ranking and tie-breakers.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _ModelCard(
              icon: Icons.grid_view,
              title: 'Candidate Generation',
              bullets: [
                'Produce top/bottom/start/end candidates from anchors.',
                'Include offset variants for dense interfaces.',
                'Attach metadata for explainable ranking.',
              ],
            ),
            _ModelCard(
              icon: Icons.rule,
              title: 'Scoring',
              bullets: [
                'Penalty for clipping and overlap with protected zones.',
                'Reward for proximity and directional preference.',
                'Optional user bias from product UX rules.',
              ],
            ),
            _ModelCard(
              icon: Icons.compare_arrows,
              title: 'Tie-Break',
              bullets: [
                'Stable ordering ensures deterministic behavior.',
                'Avoids jitter during small pointer movement.',
                'Logs reasons for easier regression analysis.',
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<DelegateConfig>(
          valueListenable: config,
          builder: (context, cfg, _) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Delegate Profile',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text('Direction: ${cfg.direction.label}')),
                        Chip(label: Text('Safety: ${cfg.safeMargin.toStringAsFixed(0)}')),
                        Chip(label: Text('Weight Clip: ${cfg.clipPenalty.toStringAsFixed(1)}')),
                        Chip(label: Text('Weight Dist: ${cfg.distancePenalty.toStringAsFixed(1)}')),
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

class _RankingLabTab extends StatefulWidget {
  const _RankingLabTab({
    required this.config,
    required this.computation,
    required this.events,
    required this.onEvent,
  });

  final ValueNotifier<DelegateConfig> config;
  final ValueNotifier<LayoutComputation> computation;
  final ValueNotifier<List<String>> events;
  final ValueChanged<String> onEvent;

  @override
  State<_RankingLabTab> createState() => _RankingLabTabState();
}

class _RankingLabTabState extends State<_RankingLabTab> {
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
        final wide = constraints.maxWidth > 1180;
        if (wide) {
          return Row(
            children: [
              Expanded(child: _visualPanel(context)),
              SizedBox(width: 410, child: _controlPanel(context)),
            ],
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _visualPanel(context),
            const SizedBox(height: 12),
            _controlPanel(context),
          ],
        );
      },
    );
  }

  Widget _visualPanel(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<DelegateConfig>(
          valueListenable: widget.config,
          builder: (context, cfg, _) {
            return ValueListenableBuilder<Offset>(
              valueListenable: _selectionCenter,
              builder: (context, center, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Candidate Ranking Canvas',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Move selection point to trigger re-ranking. Candidate cards '
                      'display weighted scores from the delegate.',
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, box) {
                          final viewport = Size(box.maxWidth, box.maxHeight);
                          final result = _computeLayout(
                            viewport: viewport,
                            selectionCenter: center,
                            config: cfg,
                          );
                          widget.computation.value = result;

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
                              painter: _RankingPainter(
                                config: cfg,
                                result: result,
                                selectionCenter: _selectionCenter.value,
                              ),
                              child: const SizedBox.expand(),
                            ),
                          );
                        },
                      ),
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

  Widget _controlPanel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delegate Controls',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<DelegateConfig>(
              valueListenable: widget.config,
              builder: (context, cfg, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<PreferredDirection>(
                      segments: PreferredDirection.values
                          .map((d) => ButtonSegment(value: d, label: Text(d.label)))
                          .toList(),
                      selected: {cfg.direction},
                      onSelectionChanged: (selection) {
                        widget.config.value = cfg.copyWith(direction: selection.first);
                        widget.onEvent('Direction preference -> ${selection.first.label}');
                      },
                    ),
                    const SizedBox(height: 8),
                    _SliderLine(
                      label: 'Safe Margin',
                      value: cfg.safeMargin,
                      min: 4,
                      max: 48,
                      onChanged: (v) {
                        widget.config.value = cfg.copyWith(safeMargin: v);
                        widget.onEvent('Safe margin -> ${v.toStringAsFixed(0)}');
                      },
                    ),
                    _SliderLine(
                      label: 'Clip Penalty',
                      value: cfg.clipPenalty,
                      min: 0,
                      max: 40,
                      onChanged: (v) {
                        widget.config.value = cfg.copyWith(clipPenalty: v);
                        widget.onEvent('Clip penalty -> ${v.toStringAsFixed(1)}');
                      },
                    ),
                    _SliderLine(
                      label: 'Distance Penalty',
                      value: cfg.distancePenalty,
                      min: 0,
                      max: 20,
                      onChanged: (v) {
                        widget.config.value = cfg.copyWith(distancePenalty: v);
                        widget.onEvent('Distance penalty -> ${v.toStringAsFixed(1)}');
                      },
                    ),
                    FilterChip(
                      selected: cfg.avoidBottomInset,
                      label: const Text('Avoid Bottom Inset'),
                      onSelected: (selected) {
                        widget.config.value = cfg.copyWith(avoidBottomInset: selected);
                        widget.onEvent(
                          'Avoid bottom inset ${selected ? 'enabled' : 'disabled'}',
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Ranking Snapshot',
              style: TextStyle(fontWeight: FontWeight.w700, color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: ValueListenableBuilder<LayoutComputation>(
                valueListenable: widget.computation,
                builder: (context, value, _) {
                  return ListView(
                    children: [
                      for (final candidate in value.candidates)
                        Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          color: candidate.id == value.chosenId
                              ? scheme.primaryContainer
                              : scheme.surfaceContainerLow,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '${candidate.id}: '
                              'score=${candidate.score.toStringAsFixed(1)} '
                              '(clip=${candidate.clip.toStringAsFixed(1)}, '
                              'dist=${candidate.distance.toStringAsFixed(1)}, '
                              'bonus=${candidate.preferenceBonus.toStringAsFixed(1)})',
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Events',
              style: TextStyle(fontWeight: FontWeight.w700, color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 160,
              child: ValueListenableBuilder<List<String>>(
                valueListenable: widget.events,
                builder: (context, events, _) {
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(events[index]),
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

  LayoutComputation _computeLayout({
    required Size viewport,
    required Offset selectionCenter,
    required DelegateConfig config,
  }) {
    const toolbarSize = Size(180, 46);
    final offsets = <String, Offset>{
      'top': Offset(selectionCenter.dx - toolbarSize.width / 2, selectionCenter.dy - 70),
      'bottom':
          Offset(selectionCenter.dx - toolbarSize.width / 2, selectionCenter.dy + 24),
      'start': Offset(selectionCenter.dx - toolbarSize.width - 24, selectionCenter.dy - 22),
      'end': Offset(selectionCenter.dx + 24, selectionCenter.dy - 22),
    };

    final candidates = <LayoutCandidate>[];
    for (final entry in offsets.entries) {
      final id = entry.key;
      final origin = entry.value;
      final rect = origin & toolbarSize;

      final leftClip = math.max(0.0, config.safeMargin - rect.left);
      final rightClip = math.max(0.0, rect.right - (viewport.width - config.safeMargin));
      final topClip = math.max(0.0, config.safeMargin - rect.top);
      final bottomLimit = config.avoidBottomInset
          ? viewport.height - config.safeMargin - viewport.height * 0.20
          : viewport.height - config.safeMargin;
      final bottomClip = math.max(0.0, rect.bottom - bottomLimit);
      final clip = leftClip + rightClip + topClip + bottomClip;

      final center = rect.center;
      final distance = (center - selectionCenter).distance;

      final preferenceBonus = switch (config.direction) {
        PreferredDirection.above => id == 'top' ? 6.0 : 0.0,
        PreferredDirection.below => id == 'bottom' ? 6.0 : 0.0,
        PreferredDirection.start => id == 'start' ? 6.0 : 0.0,
        PreferredDirection.end => id == 'end' ? 6.0 : 0.0,
        PreferredDirection.auto =>
          id == 'top' || id == 'bottom' ? 3.0 : 1.0,
      };

      final score = preferenceBonus -
          clip * config.clipPenalty / 10 -
          distance * config.distancePenalty / 100;

      candidates.add(
        LayoutCandidate(
          id: id,
          rect: rect,
          clip: clip,
          distance: distance,
          preferenceBonus: preferenceBonus,
          score: score,
        ),
      );
    }

    candidates.sort((a, b) {
      final scoreCompare = b.score.compareTo(a.score);
      if (scoreCompare != 0) {
        return scoreCompare;
      }
      final clipCompare = a.clip.compareTo(b.clip);
      if (clipCompare != 0) {
        return clipCompare;
      }
      return a.id.compareTo(b.id);
    });

    return LayoutComputation(candidates: candidates, chosenId: candidates.first.id);
  }
}

class _PatternsTab extends StatelessWidget {
  const _PatternsTab({required this.config, required this.onEvent});

  final ValueNotifier<DelegateConfig> config;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    final patterns = <DelegatePattern>[
      const DelegatePattern(
        title: 'Chat Composer',
        summary:
            'Toolbar should avoid bottom inset and prefer top placement to keep '
            'composer visible during text operations.',
        apply: DelegateConfig(
          direction: PreferredDirection.above,
          safeMargin: 12,
          clipPenalty: 26,
          distancePenalty: 8,
          avoidBottomInset: true,
        ),
      ),
      const DelegatePattern(
        title: 'Desktop Editor',
        summary:
            'Minimize travel distance and allow side placement near context menu '
            'zones for high-speed pointer workflows.',
        apply: DelegateConfig(
          direction: PreferredDirection.end,
          safeMargin: 8,
          clipPenalty: 18,
          distancePenalty: 4,
          avoidBottomInset: false,
        ),
      ),
      const DelegatePattern(
        title: 'Accessibility First',
        summary:
            'Strong clipping penalties and wider margins reduce accidental '
            'occlusion and preserve stable location cues.',
        apply: DelegateConfig(
          direction: PreferredDirection.auto,
          safeMargin: 24,
          clipPenalty: 36,
          distancePenalty: 10,
          avoidBottomInset: true,
        ),
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _Header(
          title: 'Delegate Patterns',
          subtitle:
              'Represent layout strategy as reusable patterns to keep behavior '
              'consistent across features and teams.',
        ),
        const SizedBox(height: 12),
        for (final pattern in patterns)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _PatternCard(
              pattern: pattern,
              onApply: () {
                config.value = pattern.apply;
                onEvent('Applied pattern: ${pattern.title}');
              },
            ),
          ),
      ],
    );
  }
}

class _RankingPainter extends CustomPainter {
  const _RankingPainter({
    required this.config,
    required this.result,
    required this.selectionCenter,
  });

  final DelegateConfig config;
  final LayoutComputation result;
  final Offset selectionCenter;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFF5F0FF), Color(0xFFF0E8FF), Color(0xFFF5F0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect),
    );

    final safeRect = Rect.fromLTWH(
      config.safeMargin,
      config.safeMargin,
      size.width - config.safeMargin * 2,
      size.height - config.safeMargin * 2,
    );
    canvas.drawRect(
      safeRect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF7E57C2),
    );

    if (config.avoidBottomInset) {
      final insetRect = Rect.fromLTWH(
        config.safeMargin,
        size.height * 0.8,
        size.width - config.safeMargin * 2,
        size.height * 0.2 - config.safeMargin,
      );
      canvas.drawRect(
        insetRect,
        Paint()..color = const Color(0xFFB39DDB).withValues(alpha: 0.35),
      );
    }

    final selectionRect = Rect.fromCenter(
      center: selectionCenter,
      width: 110,
      height: 32,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(selectionRect, const Radius.circular(8)),
      Paint()..color = const Color(0xFF4A148C).withValues(alpha: 0.20),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(selectionRect, const Radius.circular(8)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF4A148C),
    );

    for (final candidate in result.candidates) {
      final chosen = candidate.id == result.chosenId;
      final color = chosen ? const Color(0xFF2E7D32) : const Color(0xFF283593);
      canvas.drawRRect(
        RRect.fromRectAndRadius(candidate.rect, const Radius.circular(10)),
        Paint()..color = color.withValues(alpha: chosen ? 0.72 : 0.35),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(candidate.rect, const Radius.circular(10)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = chosen ? 2.5 : 1.4
          ..color = color,
      );
      final painter = TextPainter(
        text: TextSpan(
          text: '${candidate.id}\n${candidate.score.toStringAsFixed(1)}',
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: candidate.rect.width - 10);
      painter.paint(canvas, candidate.rect.topLeft + const Offset(6, 6));
    }
  }

  @override
  bool shouldRepaint(covariant _RankingPainter oldDelegate) {
    return oldDelegate.config != config ||
        oldDelegate.result != result ||
        oldDelegate.selectionCenter != selectionCenter;
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.subtitle});

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

class _ModelCard extends StatelessWidget {
  const _ModelCard({
    required this.icon,
    required this.title,
    required this.bullets,
  });

  final IconData icon;
  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 250, maxWidth: 360),
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

class _SliderLine extends StatelessWidget {
  const _SliderLine({
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
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _PatternCard extends StatelessWidget {
  const _PatternCard({required this.pattern, required this.onApply});

  final DelegatePattern pattern;
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
                    pattern.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                ),
                FilledButton.tonal(onPressed: onApply, child: const Text('Apply')),
              ],
            ),
            const SizedBox(height: 8),
            Text(pattern.summary),
            const SizedBox(height: 10),
            Text(
              'direction=${pattern.apply.direction.label}, '
              'margin=${pattern.apply.safeMargin.toStringAsFixed(0)}, '
              'clipPenalty=${pattern.apply.clipPenalty.toStringAsFixed(1)}',
            ),
          ],
        ),
      ),
    );
  }
}

enum PreferredDirection {
  auto('Auto'),
  above('Above'),
  below('Below'),
  start('Start'),
  end('End');

  const PreferredDirection(this.label);
  final String label;
}

@immutable
class DelegateConfig {
  const DelegateConfig({
    this.direction = PreferredDirection.auto,
    this.safeMargin = 12,
    this.clipPenalty = 24,
    this.distancePenalty = 7,
    this.avoidBottomInset = true,
  });

  final PreferredDirection direction;
  final double safeMargin;
  final double clipPenalty;
  final double distancePenalty;
  final bool avoidBottomInset;

  DelegateConfig copyWith({
    PreferredDirection? direction,
    double? safeMargin,
    double? clipPenalty,
    double? distancePenalty,
    bool? avoidBottomInset,
  }) {
    return DelegateConfig(
      direction: direction ?? this.direction,
      safeMargin: safeMargin ?? this.safeMargin,
      clipPenalty: clipPenalty ?? this.clipPenalty,
      distancePenalty: distancePenalty ?? this.distancePenalty,
      avoidBottomInset: avoidBottomInset ?? this.avoidBottomInset,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DelegateConfig &&
        other.direction == direction &&
        other.safeMargin == safeMargin &&
        other.clipPenalty == clipPenalty &&
        other.distancePenalty == distancePenalty &&
        other.avoidBottomInset == avoidBottomInset;
  }

  @override
  int get hashCode =>
      Object.hash(direction, safeMargin, clipPenalty, distancePenalty, avoidBottomInset);
}

@immutable
class LayoutCandidate {
  const LayoutCandidate({
    required this.id,
    required this.rect,
    required this.clip,
    required this.distance,
    required this.preferenceBonus,
    required this.score,
  });

  final String id;
  final Rect rect;
  final double clip;
  final double distance;
  final double preferenceBonus;
  final double score;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is LayoutCandidate &&
        other.id == id &&
        other.rect == rect &&
        other.clip == clip &&
        other.distance == distance &&
        other.preferenceBonus == preferenceBonus &&
        other.score == score;
  }

  @override
  int get hashCode => Object.hash(id, rect, clip, distance, preferenceBonus, score);
}

@immutable
class LayoutComputation {
  const LayoutComputation({required this.candidates, required this.chosenId});

  const LayoutComputation.initial()
      : candidates = const <LayoutCandidate>[],
        chosenId = 'none';

  final List<LayoutCandidate> candidates;
  final String chosenId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is LayoutComputation &&
        _sameCandidates(other.candidates, candidates) &&
        other.chosenId == chosenId;
  }

  @override
  int get hashCode => Object.hash(Object.hashAll(candidates), chosenId);

  static bool _sameCandidates(List<LayoutCandidate> a, List<LayoutCandidate> b) {
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}

@immutable
class DelegatePattern {
  const DelegatePattern({
    required this.title,
    required this.summary,
    required this.apply,
  });

  final String title;
  final String summary;
  final DelegateConfig apply;
}
