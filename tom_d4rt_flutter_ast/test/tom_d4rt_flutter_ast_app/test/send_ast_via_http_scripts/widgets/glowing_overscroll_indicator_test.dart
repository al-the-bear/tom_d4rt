import 'package:flutter/material.dart';

const _ink = Color(0xFF0F3D57);
const _sun = Color(0xFFE09B3D);
const _mint = Color(0xFF2E8B77);
const _berry = Color(0xFF8A4F6A);
const _violet = Color(0xFF5A5FA8);
const _olive = Color(0xFF6D7034);

dynamic build(BuildContext context) {
  return const _GlowingOverscrollIndicatorDeepDemoApp();
}

class _GlowingOverscrollIndicatorDeepDemoApp extends StatelessWidget {
  const _GlowingOverscrollIndicatorDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _ink),
        scaffoldBackgroundColor: const Color(0xFFF2F6F9),
      ),
      home: const _GlowLabPage(),
    );
  }
}

class _GlowLabPage extends StatefulWidget {
  const _GlowLabPage();

  @override
  State<_GlowLabPage> createState() => _GlowLabPageState();
}

class _GlowLabPageState extends State<_GlowLabPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _rtl = false;

  AxisDirection _axisDirection = AxisDirection.down;
  bool _showLeading = true;
  bool _showTrailing = true;
  Color _glowColor = _sun;

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      axisDirection: _axisDirection,
      showLeading: _showLeading,
      showTrailing: _showTrailing,
      glowColor: _glowColor,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 80,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('GlowingOverscrollIndicator Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'Axis: ${config.axisDirection.name} | Leading: ${config.showLeading} | Trailing: ${config.showTrailing}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroControlDeck(
                config: config,
                compact: _compact,
                showGrid: _showGrid,
                rtl: _rtl,
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGridChanged: (value) => setState(() => _showGrid = value),
                onRtlChanged: (value) => setState(() => _rtl = value),
                onAxisDirectionChanged: (value) => setState(() => _axisDirection = value),
                onShowLeadingChanged: (value) => setState(() => _showLeading = value),
                onShowTrailingChanged: (value) => setState(() => _showTrailing = value),
                onGlowColorChanged: (value) => setState(() => _glowColor = value),
              ),
              const SizedBox(height: 12),
              const _SceneCard(
                index: 1,
                accent: _ink,
                title: 'What This Widget Is For',
                subtitle:
                    'GlowingOverscrollIndicator visualizes overscroll edges by listening to scroll notifications. It can be customized per axis, color, notification depth, and indicator permission.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: _sun,
                title: 'Baseline: Vertical and Horizontal Glow Panels',
                subtitle:
                    'Two independent scrollables wrapped with GlowingOverscrollIndicator, showing practical defaults and immediate visual comparison.',
                child: _BaselineDualScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: _mint,
                title: 'OverscrollIndicatorNotification Control Lab',
                subtitle:
                    'Intervene before glow painting: disallow selected sides or shift paintOffset to reserve top visual space.',
                child: _NotificationControlScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: _berry,
                title: 'Nested Scroll Depth and Predicate Routing',
                subtitle:
                    'Demonstrates notificationPredicate behavior in nested scroll structures and depth-based acceptance.',
                child: _NestedDepthScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: _violet,
                title: 'AxisDirection Matrix',
                subtitle:
                    'Visualizes leading/trailing interpretation across down, up, left, and right axis directions.',
                child: _AxisDirectionMatrixScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: _olive,
                title: 'Practical Feed Composition',
                subtitle:
                    'A realistic content dashboard with multiple scroll regions and scene-specific glow policies.',
                child: _PracticalCompositionScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoConfig {
  const _DemoConfig({
    required this.compact,
    required this.showGrid,
    required this.textDirection,
    required this.axisDirection,
    required this.showLeading,
    required this.showTrailing,
    required this.glowColor,
  });

  final bool compact;
  final bool showGrid;
  final TextDirection textDirection;
  final AxisDirection axisDirection;
  final bool showLeading;
  final bool showTrailing;
  final Color glowColor;
}

class _HeroControlDeck extends StatelessWidget {
  const _HeroControlDeck({
    required this.config,
    required this.compact,
    required this.showGrid,
    required this.rtl,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onRtlChanged,
    required this.onAxisDirectionChanged,
    required this.onShowLeadingChanged,
    required this.onShowTrailingChanged,
    required this.onGlowColorChanged,
  });

  final _DemoConfig config;
  final bool compact;
  final bool showGrid;
  final bool rtl;

  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<AxisDirection> onAxisDirectionChanged;
  final ValueChanged<bool> onShowLeadingChanged;
  final ValueChanged<bool> onShowTrailingChanged;
  final ValueChanged<Color> onGlowColorChanged;

  static const _palette = <Color>[_sun, _mint, _berry, _violet, _olive, _ink];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF123F5B), Color(0xFF2B5D73), Color(0xFF784B60)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Glow Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tune axis, color, side visibility, and directionality. Then drag each scene beyond bounds to study glow behavior and notification routing.',
              style: TextStyle(color: Color(0xFFE5F1FA), height: 1.4),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: const Text('Compact layout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    value: compact,
                    onChanged: onCompactChanged,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    value: showGrid,
                    onChanged: onShowGridChanged,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    value: rtl,
                    onChanged: onRtlChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _AxisDirectionField(
                    value: config.axisDirection,
                    onChanged: onAxisDirectionChanged,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: const Text('Show leading', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          value: config.showLeading,
                          onChanged: onShowLeadingChanged,
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: const Text('Show trailing', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          value: config.showTrailing,
                          onChanged: onShowTrailingChanged,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _palette
                  .map(
                    (entry) => GestureDetector(
                      onTap: () => onGlowColorChanged(entry),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: entry,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: config.glowColor == entry ? Colors.white : Colors.white.withValues(alpha: 0.35),
                            width: config.glowColor == entry ? 2.5 : 1,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _HeroTag(label: 'NotificationListener intervention'),
                _HeroTag(label: 'Depth-aware predicate filtering'),
                _HeroTag(label: 'Axis direction orientation lab'),
                _HeroTag(label: 'Practical multi-scroll dashboard'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AxisDirectionField extends StatelessWidget {
  const _AxisDirectionField({required this.value, required this.onChanged});

  final AxisDirection value;
  final ValueChanged<AxisDirection> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Axis Direction', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AxisDirection>(
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: const Color(0xFF315E79),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: AxisDirection.values
                  .map(
                    (entry) => DropdownMenuItem<AxisDirection>(
                      value: entry,
                      child: Text(entry.name, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (entry) {
                if (entry != null) {
                  onChanged(entry);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.index,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 3),
                      Text(subtitle, style: const TextStyle(height: 1.38, color: Color(0xFF2E3D49))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Key mechanics', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          'GlowingOverscrollIndicator listens to ScrollNotifications and paints glow overlays for overscroll. It dispatches OverscrollIndicatorNotification before painting, giving you a hook to disallow painting or offset it.',
          style: TextStyle(height: 1.42),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FBFE),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD7E3EE)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bullet(text: 'showLeading controls the side with negative scroll offsets.'),
              _Bullet(text: 'showTrailing controls the side with positive scroll offsets.'),
              _Bullet(text: 'axisDirection decides which edge is considered leading/trailing.'),
              _Bullet(text: 'notificationPredicate defaults to depth == 0, useful to override in nested layouts.'),
              _Bullet(text: 'color alpha channel is ignored; use visible RGB tones for clear demos.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _BaselineDualScene extends StatefulWidget {
  const _BaselineDualScene({required this.config});

  final _DemoConfig config;

  @override
  State<_BaselineDualScene> createState() => _BaselineDualSceneState();
}

class _BaselineDualSceneState extends State<_BaselineDualScene> {
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final stageHeight = config.compact ? 250.0 : 320.0;

    return SizedBox(
      height: stageHeight,
      child: Row(
        children: [
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Vertical feed', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: config.glowColor,
                        showLeading: config.showLeading,
                        showTrailing: config.showTrailing,
                        child: ListView.builder(
                          controller: _verticalController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 18,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: index.isEven ? const Color(0xFFEAF3FB) : const Color(0xFFF7EEF2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFD2DFEC)),
                              ),
                              child: Text('Feed item ${index + 1}: drag past top/bottom to trigger glow.'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Horizontal tray', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.right,
                        color: config.glowColor,
                        showLeading: config.showLeading,
                        showTrailing: config.showTrailing,
                        child: ListView.separated(
                          controller: _horizontalController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 14,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    index.isEven ? const Color(0xFFDDEDFB) : const Color(0xFFF7E4EC),
                                    index.isEven ? const Color(0xFFC1DAEE) : const Color(0xFFEDCDD9),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFCCD9E8)),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  'Card ${index + 1}',
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationControlScene extends StatefulWidget {
  const _NotificationControlScene({required this.config});

  final _DemoConfig config;

  @override
  State<_NotificationControlScene> createState() => _NotificationControlSceneState();
}

class _NotificationControlSceneState extends State<_NotificationControlScene> {
  bool _blockLeading = false;
  bool _blockTrailing = false;
  double _paintOffset = 0;
  final List<String> _log = <String>[];

  void _push(String event) {
    setState(() {
      _log.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $event');
      if (_log.length > 14) {
        _log.removeRange(14, _log.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilterChip(
              label: const Text('Block leading glow'),
              selected: _blockLeading,
              onSelected: (value) => setState(() => _blockLeading = value),
            ),
            FilterChip(
              label: const Text('Block trailing glow'),
              selected: _blockTrailing,
              onSelected: (value) => setState(() => _blockTrailing = value),
            ),
            _ActionButton(
              label: 'Clear log',
              color: _mint,
              onPressed: () => setState(_log.clear),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Paint offset: ${_paintOffset.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700)),
        Slider(
          value: _paintOffset,
          min: 0,
          max: 80,
          divisions: 8,
          label: _paintOffset.toStringAsFixed(0),
          onChanged: (value) => setState(() => _paintOffset = value),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: config.compact ? 250 : 320,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Column(
                    children: [
                      Container(
                        height: 52,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF15374E),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                        child: const Text(
                          'Header-safe glow target (offset adjusts where glow paints)',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: NotificationListener<OverscrollIndicatorNotification>(
                          onNotification: (notification) {
                            notification.paintOffset = _paintOffset;
                            final bool leading = notification.leading;
                            if ((leading && _blockLeading) || (!leading && _blockTrailing)) {
                              notification.disallowIndicator();
                              _push('disallowIndicator side=${leading ? 'leading' : 'trailing'}');
                            } else {
                              _push('allow side=${leading ? 'leading' : 'trailing'} offset=${_paintOffset.toStringAsFixed(0)}');
                            }
                            return false;
                          },
                          child: GlowingOverscrollIndicator(
                            axisDirection: AxisDirection.down,
                            color: config.glowColor,
                            showLeading: config.showLeading,
                            showTrailing: config.showTrailing,
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF5FA),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: const Color(0xFFD4DFEA)),
                                  ),
                                  child: Text('Notification lab row ${index + 1}'),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(title: 'Notification log', events: _log)),
            ],
          ),
        ),
      ],
    );
  }
}

class _NestedDepthScene extends StatefulWidget {
  const _NestedDepthScene({required this.config});

  final _DemoConfig config;

  @override
  State<_NestedDepthScene> createState() => _NestedDepthSceneState();
}

class _NestedDepthSceneState extends State<_NestedDepthScene> {
  bool _acceptDepthOne = false;
  final List<String> _events = <String>[];

  bool _predicate(ScrollNotification notification) {
    if (_acceptDepthOne) {
      return notification.depth <= 1;
    }
    return notification.depth == 0;
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 16) {
        _events.removeRange(16, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FilterChip(
              label: const Text('Accept depth <= 1'),
              selected: _acceptDepthOne,
              onSelected: (value) => setState(() => _acceptDepthOne = value),
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: 'Clear',
              color: _berry,
              onPressed: () => setState(_events.clear),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _acceptDepthOne
              ? 'Predicate mode: outer and nested notifications can drive glow.'
              : 'Predicate mode: default-like depth 0 only.',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 270 : 340,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: config.glowColor,
                    showLeading: config.showLeading,
                    showTrailing: config.showTrailing,
                    notificationPredicate: _predicate,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF3FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFCEDDF0)),
                          ),
                          child: const Text(
                            'Outer section. Drag here for depth 0 notifications. Nested list below emits depth 1 notifications.',
                            style: TextStyle(height: 1.35),
                          ),
                        ),
                        const SizedBox(height: 10),
                        NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            _push('ScrollNotification depth=${notification.depth} type=${notification.runtimeType}');
                            return false;
                          },
                          child: Container(
                            height: 160,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDF3F7),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE5C8D4)),
                            ),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: 16,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: const Color(0xFFDCD9E6)),
                                  ),
                                  child: Text('Nested lane ${index + 1}'),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF7EF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFD5E5D5)),
                          ),
                          child: const Text('Continue dragging outer content for depth 0 overscroll at top/bottom.'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(title: 'Depth trace', events: _events)),
            ],
          ),
        ),
      ],
    );
  }
}

class _AxisDirectionMatrixScene extends StatelessWidget {
  const _AxisDirectionMatrixScene({required this.config});

  final _DemoConfig config;

  @override
  Widget build(BuildContext context) {
    final cells = <_AxisCellSpec>[
      const _AxisCellSpec(axisDirection: AxisDirection.down, title: 'down', hint: 'leading=top, trailing=bottom'),
      const _AxisCellSpec(axisDirection: AxisDirection.up, title: 'up', hint: 'leading=bottom, trailing=top'),
      const _AxisCellSpec(axisDirection: AxisDirection.right, title: 'right', hint: 'leading=left, trailing=right'),
      const _AxisCellSpec(axisDirection: AxisDirection.left, title: 'left', hint: 'leading=right, trailing=left'),
    ];

    return SizedBox(
      height: config.compact ? 420 : 520,
      child: GridView.builder(
        itemCount: cells.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final cell = cells[index];
          return _AxisCell(config: config, spec: cell);
        },
      ),
    );
  }
}

class _AxisCellSpec {
  const _AxisCellSpec({required this.axisDirection, required this.title, required this.hint});

  final AxisDirection axisDirection;
  final String title;
  final String hint;
}

class _AxisCell extends StatefulWidget {
  const _AxisCell({required this.config, required this.spec});

  final _DemoConfig config;
  final _AxisCellSpec spec;

  @override
  State<_AxisCell> createState() => _AxisCellState();
}

class _AxisCellState extends State<_AxisCell> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    final bool horizontal = widget.spec.axisDirection == AxisDirection.left || widget.spec.axisDirection == AxisDirection.right;
    final Axis scrollAxis = horizontal ? Axis.horizontal : Axis.vertical;
    final bool reverse = widget.spec.axisDirection == AxisDirection.up || widget.spec.axisDirection == AxisDirection.left;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1DCE8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.spec.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
            Text(widget.spec.hint, style: const TextStyle(fontSize: 12, color: Color(0xFF586A79))),
            const SizedBox(height: 6),
            Expanded(
              child: _GuideStage(
                showGrid: config.showGrid,
                child: GlowingOverscrollIndicator(
                  axisDirection: widget.spec.axisDirection,
                  color: config.glowColor,
                  showLeading: config.showLeading,
                  showTrailing: config.showTrailing,
                  child: ListView.builder(
                    controller: _controller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: scrollAxis,
                    reverse: reverse,
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      if (horizontal) {
                        return Container(
                          width: 82,
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: index.isEven ? const Color(0xFFE8F1FB) : const Color(0xFFF8EAF0),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFD3DFEB)),
                          ),
                          alignment: Alignment.center,
                          child: Text('H${index + 1}'),
                        );
                      }
                      return Container(
                        height: 44,
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: index.isEven ? const Color(0xFFE8F1FB) : const Color(0xFFF8EAF0),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFD3DFEB)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('V${index + 1}'),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticalCompositionScene extends StatefulWidget {
  const _PracticalCompositionScene({required this.config});

  final _DemoConfig config;

  @override
  State<_PracticalCompositionScene> createState() => _PracticalCompositionSceneState();
}

class _PracticalCompositionSceneState extends State<_PracticalCompositionScene> {
  int _selectedTab = 0;
  final List<String> _events = <String>[];

  final List<_FeedCardData> _cards = const [
    _FeedCardData('Ops Health', 'Live system cards with vertical scroll emphasis.', _ink),
    _FeedCardData('Sales Trail', 'Horizontal momentum cards with edge constraints.', _sun),
    _FeedCardData('Creative Queue', 'Nested lane interactions and callback diagnostics.', _berry),
    _FeedCardData('Fulfillment', 'Practical mixed dashboard with readable glow controls.', _mint),
  ];

  void _push(String event) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $event');
      if (_events.length > 16) {
        _events.removeRange(16, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final card = _cards[_selectedTab];

    return SizedBox(
      height: config.compact ? 450 : 560,
      child: Row(
        children: [
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _cards.length,
                        (index) => ChoiceChip(
                          selected: _selectedTab == index,
                          label: Text(_cards[index].title),
                          onSelected: (_) => setState(() => _selectedTab = index),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: card.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: card.color.withValues(alpha: 0.35)),
                      ),
                      child: Text(card.detail, style: const TextStyle(fontWeight: FontWeight.w700, height: 1.35)),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: NotificationListener<OverscrollIndicatorNotification>(
                              onNotification: (notification) {
                                _push('Left lane side=${notification.leading ? 'leading' : 'trailing'} depth=${notification.depth}');
                                if (!notification.leading && _selectedTab == 2) {
                                  notification.disallowIndicator();
                                  _push('Left lane trailing glow blocked for Creative Queue');
                                }
                                return false;
                              },
                              child: GlowingOverscrollIndicator(
                                axisDirection: AxisDirection.down,
                                color: card.color,
                                showLeading: true,
                                showTrailing: true,
                                child: ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: 18,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: const Color(0xFFD8E1EA)),
                                      ),
                                      child: Text('${card.title} detail row ${index + 1}'),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GlowingOverscrollIndicator(
                              axisDirection: AxisDirection.right,
                              color: config.glowColor,
                              showLeading: _selectedTab != 1,
                              showTrailing: true,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: 12,
                                separatorBuilder: (_, _) => const SizedBox(width: 8),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 110,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          card.color.withValues(alpha: 0.22),
                                          card.color.withValues(alpha: 0.1),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: card.color.withValues(alpha: 0.35)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Tile ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w700)),
                                        Text(
                                          _selectedTab == 1 ? 'Leading hidden in this tab' : 'Both sides allowed',
                                          style: const TextStyle(fontSize: 11, color: Color(0xFF4D5E6D)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: _EventLog(title: 'Practical composition log', events: _events)),
        ],
      ),
    );
  }
}

class _FeedCardData {
  const _FeedCardData(this.title, this.detail, this.color);

  final String title;
  final String detail;
  final Color color;
}

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FBFE), Color(0xFFEAF1F7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD5E1EC)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid) CustomPaint(painter: _GridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const step = 22.0;
    final paint = Paint()..color = const Color(0x12000000);

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.color, required this.onPressed});

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _EventLog extends StatelessWidget {
  const _EventLog({required this.title, required this.events});

  final String title;
  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFDFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE6F1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No events captured yet.', style: TextStyle(color: Color(0xFF5D7082)))
          else
            ...events.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(entry, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF33556E)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.33))),
        ],
      ),
    );
  }
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF142F44),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use GlowingOverscrollIndicator for explicit overscroll visuals around scrollables, especially when building custom compositions or nested views where default behavior needs routing control. OverscrollIndicatorNotification enables precise control over whether and where the glow paints.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.4),
          ),
        ],
      ),
    );
  }
}
