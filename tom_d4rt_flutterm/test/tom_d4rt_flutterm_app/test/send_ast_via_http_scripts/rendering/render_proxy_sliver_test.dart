import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _RenderProxySliverLab();
}

enum _SliverScenario {
  proxyOverview,
  opacityStack,
  offstageSwitch,
  ignorePointer,
  geometryTimeline,
  mixedDeck,
}

class _ThemePreset {
  const _ThemePreset({
    required this.name,
    required this.seed,
    required this.brightness,
    required this.description,
  });

  final String name;
  final Color seed;
  final Brightness brightness;
  final String description;
}

const List<_ThemePreset> _presets = <_ThemePreset>[
  _ThemePreset(
    name: 'Harbor Slate',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
    description: 'Balanced palette for reading geometry and scroll overlays.',
  ),
  _ThemePreset(
    name: 'Sun Deck',
    seed: Color(0xFFEA580C),
    brightness: Brightness.light,
    description: 'Warm contrast for visibility and hit-test demonstrations.',
  ),
  _ThemePreset(
    name: 'Night Console',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
    description: 'Dark palette for dense diagnostics and timeline readability.',
  ),
];

const List<String> _guideLines = <String>[
  'RenderProxySliver is an abstract render sliver that forwards behavior to a child sliver.',
  'Many framework widgets map to RenderProxySliver subclasses, including sliver opacity and pointer wrappers.',
  'Proxy slivers are useful when you want to alter paint, visibility, interaction, or semantics around an existing sliver.',
  'Offstage can remove paint and layout participation while preserving structure for future toggles.',
  'IgnorePointer wrappers alter interaction channels without changing visual content.',
  'Opacity wrappers can be animated to inspect transition behavior in sliver pipelines.',
  'Use scroll diagnostics to correlate user input, viewport offset, and event behavior under wrappers.',
  'Complex sliver trees often require timeline views to verify that wrapper order is correct.',
  'Teaching demos should combine visuals, controls, and practical notes, not just static API text.',
];

class _Faq {
  const _Faq(this.question, this.answer);
  final String question;
  final String answer;
}

const List<_Faq> _faqs = <_Faq>[
  _Faq('Can I instantiate RenderProxySliver directly?', 'No. It is abstract and intended as a base for specialized proxy slivers.'),
  _Faq('When should I use sliver wrappers?', 'Use them when you need to modify a sliver behavior without rewriting its core layout logic.'),
  _Faq('What is a practical first wrapper?', 'SliverOpacity is a common first step to visualize wrapper behavior.'),
  _Faq('How do I test interaction routing?', 'Wrap content in ignore-pointer style wrappers and log taps/hover while scrolling.'),
  _Faq('Why include a timeline?', 'A timeline helps validate ordering of scroll, visibility, and wrapper-related interactions.'),
];

class _TimelineEvent {
  const _TimelineEvent({
    required this.time,
    required this.channel,
    required this.message,
    required this.offset,
  });

  final DateTime time;
  final String channel;
  final String message;
  final double offset;
}

class _MetricCard {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.note,
    required this.icon,
  });

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _RenderProxySliverLab extends StatefulWidget {
  const _RenderProxySliverLab();

  @override
  State<_RenderProxySliverLab> createState() => _RenderProxySliverLabState();
}

class _RenderProxySliverLabState extends State<_RenderProxySliverLab> {
  int _themeIndex = 0;
  _SliverScenario _scenario = _SliverScenario.proxyOverview;

  bool _animateOpacity = true;
  bool _showDiagnostics = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _usePinnedHeader = true;
  bool _offstageEnabled = false;
  bool _ignorePointerEnabled = false;
  bool _showGeometryGrid = true;
  bool _highlightVisibleItems = true;

  double _headerHeight = 110;
  double _opacityA = 0.92;
  double _opacityB = 0.48;
  double _tileHeight = 108;
  double _spacing = 10;
  double _curveFactor = 0.5;

  int _scrollEvents = 0;
  int _pointerEvents = 0;
  int _scenarioSwitches = 0;
  int _themeSwitches = 0;
  int _controlEdits = 0;
  int _tapCount = 0;

  double _lastOffset = 0;
  String _lastChannel = 'none';
  String _lastMessage = 'none';

  final ScrollController _scrollController = ScrollController();
  final List<_TimelineEvent> _timeline = <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _pushTimeline('system', 'RenderProxySliver lab initialized');
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final double offset = _scrollController.hasClients ? _scrollController.offset : 0;
    setState(() {
      _lastOffset = offset;
      _scrollEvents += 1;
      _lastChannel = 'scroll';
      _lastMessage = 'offset ${offset.toStringAsFixed(1)}';
    });
    if (_scrollEvents % 6 == 0) {
      _pushTimeline('scroll', 'Viewport moved to ${offset.toStringAsFixed(1)}');
    }
  }

  void _pushTimeline(String channel, String message) {
    final double offset = _scrollController.hasClients ? _scrollController.offset : _lastOffset;
    setState(() {
      _timeline.insert(
        0,
        _TimelineEvent(
          time: DateTime.now(),
          channel: channel,
          message: message,
          offset: offset,
        ),
      );
      if (_timeline.length > 180) {
        _timeline.removeRange(180, _timeline.length);
      }
      _lastChannel = channel;
      _lastMessage = message;
    });
  }

  void _setScenario(_SliverScenario scenario) {
    setState(() {
      _scenario = scenario;
      _scenarioSwitches += 1;
    });
    _pushTimeline('scenario', 'Switched to ${scenario.name}');
  }

  void _setTheme(int index) {
    setState(() {
      _themeIndex = index;
      _themeSwitches += 1;
    });
    _pushTimeline('theme', 'Theme set to ${_presets[index].name}');
  }

  void _onControlChanged(String label, String value) {
    setState(() {
      _controlEdits += 1;
    });
    _pushTimeline('control', '$label -> $value');
  }

  void _reset() {
    setState(() {
      _scenario = _SliverScenario.proxyOverview;
      _animateOpacity = true;
      _showDiagnostics = true;
      _showGuide = true;
      _showTimeline = true;
      _usePinnedHeader = true;
      _offstageEnabled = false;
      _ignorePointerEnabled = false;
      _showGeometryGrid = true;
      _highlightVisibleItems = true;
      _headerHeight = 110;
      _opacityA = 0.92;
      _opacityB = 0.48;
      _tileHeight = 108;
      _spacing = 10;
      _curveFactor = 0.5;
      _tapCount = 0;
      _timeline.clear();
    });
    _pushTimeline('system', 'Controls reset to defaults');
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset preset = _presets[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: preset.seed,
      brightness: preset.brightness,
    );

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: preset.brightness),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                scheme.surface,
                scheme.surfaceContainerLow,
                scheme.surfaceContainer,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(scheme),
                      const SizedBox(height: 14),
                      _buildThemeBoard(scheme),
                      const SizedBox(height: 14),
                      _buildControlBoard(scheme),
                      const SizedBox(height: 14),
                      _buildDemoBoard(scheme),
                      const SizedBox(height: 14),
                      _buildProxyPrimerBoard(scheme),
                      const SizedBox(height: 14),
                      _buildMetricsBoard(scheme),
                      if (_showGuide) const SizedBox(height: 14),
                      if (_showGuide) _buildGuideBoard(scheme),
                      if (_showTimeline) const SizedBox(height: 14),
                      if (_showTimeline) _buildTimelineBoard(scheme),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHighest,
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
                Icon(Icons.view_stream_outlined, size: 26, color: scheme.primary),
                Text(
                  'RenderProxySliver Deep Demo Lab',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _scenario.name,
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Manual visual demonstration of proxy-sliver behavior patterns: opacity, offstage, pointer routing, and geometry-aware diagnostics.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Theme and Scenarios', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_presets.length, (int index) {
                final _ThemePreset preset = _presets[index];
                return ChoiceChip(
                  selected: index == _themeIndex,
                  label: Text(preset.name),
                  onSelected: (_) => _setTheme(index),
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_presets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _scenarioChip(scheme, _SliverScenario.proxyOverview, 'Proxy Overview'),
                _scenarioChip(scheme, _SliverScenario.opacityStack, 'Opacity Stack'),
                _scenarioChip(scheme, _SliverScenario.offstageSwitch, 'Offstage Switch'),
                _scenarioChip(scheme, _SliverScenario.ignorePointer, 'Ignore Pointer'),
                _scenarioChip(scheme, _SliverScenario.geometryTimeline, 'Geometry Timeline'),
                _scenarioChip(scheme, _SliverScenario.mixedDeck, 'Mixed Deck'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scenarioChip(ColorScheme scheme, _SliverScenario scenario, String label) {
    return FilterChip(
      selected: _scenario == scenario,
      label: Text(label),
      onSelected: (_) => _setScenario(scenario),
    );
  }

  Widget _buildControlBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Interactive Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 6),
            Text('These controls adjust wrapper behavior, layout intensity, and diagnostics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            _slider(
              scheme: scheme,
              label: 'Pinned Header Height',
              value: _headerHeight,
              min: 64,
              max: 180,
              divisions: 58,
              onChanged: (double v) => setState(() => _headerHeight = v),
              onChangeEnd: (double v) => _onControlChanged('headerHeight', v.toStringAsFixed(1)),
            ),
            _slider(
              scheme: scheme,
              label: 'Opacity A',
              value: _opacityA,
              min: 0.05,
              max: 1,
              divisions: 95,
              onChanged: (double v) => setState(() => _opacityA = v),
              onChangeEnd: (double v) => _onControlChanged('opacityA', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Opacity B',
              value: _opacityB,
              min: 0.05,
              max: 1,
              divisions: 95,
              onChanged: (double v) => setState(() => _opacityB = v),
              onChangeEnd: (double v) => _onControlChanged('opacityB', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Tile Height',
              value: _tileHeight,
              min: 70,
              max: 170,
              divisions: 100,
              onChanged: (double v) => setState(() => _tileHeight = v),
              onChangeEnd: (double v) => _onControlChanged('tileHeight', v.toStringAsFixed(1)),
            ),
            _slider(
              scheme: scheme,
              label: 'Tile Spacing',
              value: _spacing,
              min: 0,
              max: 24,
              divisions: 48,
              onChanged: (double v) => setState(() => _spacing = v),
              onChangeEnd: (double v) => _onControlChanged('spacing', v.toStringAsFixed(1)),
            ),
            _slider(
              scheme: scheme,
              label: 'Curve Factor',
              value: _curveFactor,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _curveFactor = v),
              onChangeEnd: (double v) => _onControlChanged('curveFactor', v.toStringAsFixed(2)),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(
                  value: _animateOpacity,
                  onChanged: (bool? v) {
                    setState(() => _animateOpacity = v ?? true);
                    _onControlChanged('animateOpacity', '${v ?? true}');
                  },
                  child: const Text('Animate opacity'),
                ),
                CheckboxMenuButton(
                  value: _showDiagnostics,
                  onChanged: (bool? v) {
                    setState(() => _showDiagnostics = v ?? true);
                    _onControlChanged('diagnostics', '${v ?? true}');
                  },
                  child: const Text('Diagnostics panel'),
                ),
                CheckboxMenuButton(
                  value: _showGuide,
                  onChanged: (bool? v) {
                    setState(() => _showGuide = v ?? true);
                    _onControlChanged('guide', '${v ?? true}');
                  },
                  child: const Text('Guide board'),
                ),
                CheckboxMenuButton(
                  value: _showTimeline,
                  onChanged: (bool? v) {
                    setState(() => _showTimeline = v ?? true);
                    _onControlChanged('timeline', '${v ?? true}');
                  },
                  child: const Text('Timeline board'),
                ),
                CheckboxMenuButton(
                  value: _usePinnedHeader,
                  onChanged: (bool? v) {
                    setState(() => _usePinnedHeader = v ?? true);
                    _onControlChanged('pinnedHeader', '${v ?? true}');
                  },
                  child: const Text('Pinned header'),
                ),
                CheckboxMenuButton(
                  value: _offstageEnabled,
                  onChanged: (bool? v) {
                    setState(() => _offstageEnabled = v ?? false);
                    _onControlChanged('offstageEnabled', '${v ?? false}');
                  },
                  child: const Text('Offstage enabled'),
                ),
                CheckboxMenuButton(
                  value: _ignorePointerEnabled,
                  onChanged: (bool? v) {
                    setState(() => _ignorePointerEnabled = v ?? false);
                    _onControlChanged('ignorePointerEnabled', '${v ?? false}');
                  },
                  child: const Text('Ignore pointer enabled'),
                ),
                CheckboxMenuButton(
                  value: _showGeometryGrid,
                  onChanged: (bool? v) {
                    setState(() => _showGeometryGrid = v ?? true);
                    _onControlChanged('geometryGrid', '${v ?? true}');
                  },
                  child: const Text('Geometry grid'),
                ),
                CheckboxMenuButton(
                  value: _highlightVisibleItems,
                  onChanged: (bool? v) {
                    setState(() => _highlightVisibleItems = v ?? true);
                    _onControlChanged('highlightVisibleItems', '${v ?? true}');
                  },
                  child: const Text('Highlight visible items'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _slider({
    required ColorScheme scheme,
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required ValueChanged<double> onChangeEnd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(label, style: TextStyle(color: scheme.onSurface))),
            Text(value.toStringAsFixed(2), style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
        Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged, onChangeEnd: onChangeEnd),
      ],
    );
  }

  Widget _buildDemoBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Scenario Playground', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Each scenario demonstrates a different practical proxy-sliver behavior pattern.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            SizedBox(
              height: 620,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                clipBehavior: Clip.antiAlias,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    _pushTimeline('scrollNotification', '${notification.runtimeType} pixels=${notification.metrics.pixels.toStringAsFixed(1)}');
                    return false;
                  },
                  child: _buildScenarioScrollView(scheme),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioScrollView(ColorScheme scheme) {
    final List<Widget> slivers = <Widget>[];

    slivers.add(
      SliverAppBar(
        pinned: _usePinnedHeader,
        expandedHeight: _headerHeight,
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Scenario: ${_scenario.name}'),
          background: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  scheme.primaryContainer,
                  scheme.tertiaryContainer,
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'offset ${_lastOffset.toStringAsFixed(1)}',
                  style: TextStyle(color: scheme.onPrimaryContainer.withValues(alpha: 0.8), fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    switch (_scenario) {
      case _SliverScenario.proxyOverview:
        slivers.addAll(_buildOverviewSlivers(scheme));
        break;
      case _SliverScenario.opacityStack:
        slivers.addAll(_buildOpacitySlivers(scheme));
        break;
      case _SliverScenario.offstageSwitch:
        slivers.addAll(_buildOffstageSlivers(scheme));
        break;
      case _SliverScenario.ignorePointer:
        slivers.addAll(_buildIgnorePointerSlivers(scheme));
        break;
      case _SliverScenario.geometryTimeline:
        slivers.addAll(_buildGeometrySlivers(scheme));
        break;
      case _SliverScenario.mixedDeck:
        slivers.addAll(_buildMixedDeckSlivers(scheme));
        break;
    }

    slivers.add(
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: scheme.surfaceContainerHigh,
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Text(
              'End of scenario. Change scenarios above to compare wrapper composition and behavior.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ),
        ),
      ),
    );

    return CustomScrollView(
      controller: _scrollController,
      slivers: slivers,
    );
  }

  List<Widget> _buildOverviewSlivers(ColorScheme scheme) {
    return <Widget>[
      _sectionHeader(scheme, 'Proxy Overview Cards'),
      SliverList.builder(
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return _proxyCard(
            scheme,
            index: index,
            title: 'Proxy concept ${index + 1}',
            subtitle: 'Wrapper composition pattern for sliver tree stabilization.',
            color: index.isEven ? scheme.primary : scheme.secondary,
          );
        },
      ),
    ];
  }

  List<Widget> _buildOpacitySlivers(ColorScheme scheme) {
    return <Widget>[
      _sectionHeader(scheme, 'SliverOpacity Visual Ladder'),
      SliverOpacity(
        opacity: _animateOpacity ? _opacityA : _opacityB,
        sliver: SliverList.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return _proxyCard(
              scheme,
              index: index,
              title: 'Opacity lane A-${index + 1}',
              subtitle: 'Visualizing proxy paint forwarding under opacity wrapper.',
              color: Color.lerp(scheme.primary, scheme.tertiary, index / 10)!,
            );
          },
        ),
      ),
      SliverOpacity(
        opacity: _animateOpacity ? _opacityB : _opacityA,
        sliver: SliverList.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return _proxyCard(
              scheme,
              index: index + 100,
              title: 'Opacity lane B-${index + 1}',
              subtitle: 'Second layer shows side-by-side effect of alternate alpha.',
              color: Color.lerp(scheme.secondary, scheme.error, index / 8)!,
            );
          },
        ),
      ),
    ];
  }

  List<Widget> _buildOffstageSlivers(ColorScheme scheme) {
    return <Widget>[
      _sectionHeader(scheme, 'Offstage Toggle Flow'),
      SliverList.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return _proxyCard(
            scheme,
            index: index,
            title: 'Primary lane ${index + 1}',
            subtitle: 'Always visible baseline list for comparison.',
            color: scheme.primary,
          );
        },
      ),
      SliverOffstage(
        offstage: _offstageEnabled,
        sliver: SliverList.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return _proxyCard(
              scheme,
              index: index + 30,
              title: 'Conditional lane ${index + 1}',
              subtitle: 'This region is wrapped by SliverOffstage.',
              color: scheme.tertiary,
            );
          },
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            _offstageEnabled
                ? 'Offstage is ON: conditional lane hidden from layout and paint.'
                : 'Offstage is OFF: conditional lane visible and interactive.',
            style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildIgnorePointerSlivers(ColorScheme scheme) {
    return <Widget>[
      _sectionHeader(scheme, 'IgnorePointer Interaction Lanes'),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Text(
            'Tap cards to increment interaction counter. Toggle ignore-pointer to observe routing differences.',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
        ),
      ),
      SliverIgnorePointer(
        ignoring: _ignorePointerEnabled,
        sliver: SliverList.builder(
          itemCount: 16,
          itemBuilder: (BuildContext context, int index) {
            return _interactiveProxyCard(
              scheme,
              index: index,
              title: 'Pointer lane ${index + 1}',
              subtitle: 'Tap to log interaction event in timeline.',
            );
          },
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            _ignorePointerEnabled
                ? 'IgnorePointer is ON: taps should not reach wrapped cards.'
                : 'IgnorePointer is OFF: taps reach wrapped cards normally.',
            style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildGeometrySlivers(ColorScheme scheme) {
    return <Widget>[
      _sectionHeader(scheme, 'Geometry and Timeline Lane'),
      if (_showGeometryGrid)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
            child: CustomPaint(
              painter: _GeometryGridPainter(
                color: scheme.primary,
                curveFactor: _curveFactor,
                showHighlight: _highlightVisibleItems,
              ),
            ),
          ),
        ),
      SliverList.builder(
        itemCount: 14,
        itemBuilder: (BuildContext context, int index) {
          final double t = index / 14;
          return _proxyCard(
            scheme,
            index: index,
            title: 'Geometry tile ${index + 1}',
            subtitle: 'Used to inspect viewport progression and event timing.',
            color: Color.lerp(scheme.primary, scheme.error, t)!,
          );
        },
      ),
    ];
  }

  List<Widget> _buildMixedDeckSlivers(ColorScheme scheme) {
    return <Widget>[
      _sectionHeader(scheme, 'Mixed Proxy Deck'),
      SliverOpacity(
        opacity: _opacityA,
        sliver: SliverIgnorePointer(
          ignoring: _ignorePointerEnabled,
          sliver: SliverList.builder(
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return _interactiveProxyCard(
                scheme,
                index: index,
                title: 'Composite lane ${index + 1}',
                subtitle: 'Opacity + IgnorePointer composition in one branch.',
              );
            },
          ),
        ),
      ),
      SliverOffstage(
        offstage: _offstageEnabled,
        sliver: SliverOpacity(
          opacity: _opacityB,
          sliver: SliverList.builder(
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return _proxyCard(
                scheme,
                index: index + 70,
                title: 'Composite hidden lane ${index + 1}',
                subtitle: 'Offstage + Opacity composition in secondary branch.',
                color: scheme.tertiary,
              );
            },
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            'This deck combines multiple proxy wrappers to show ordering effects in one scroll scene.',
            style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ];
  }

  Widget _sectionHeader(ColorScheme scheme, String text) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Text(text, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }

  Widget _proxyCard(
    ColorScheme scheme, {
    required int index,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14, _spacing / 2, 14, _spacing / 2),
      child: Container(
        height: _tileHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              color.withValues(alpha: 0.82),
              color.withValues(alpha: 0.48),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 14),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _interactiveProxyCard(
    ColorScheme scheme, {
    required int index,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14, _spacing / 2, 14, _spacing / 2),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tapCount += 1;
            _pointerEvents += 1;
          });
          _pushTimeline('tap', '$title tapped');
        },
        child: Container(
          height: _tileHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                scheme.secondary.withValues(alpha: 0.84),
                scheme.tertiary.withValues(alpha: 0.56),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.44)),
          ),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              Icon(Icons.touch_app_outlined, color: Colors.white.withValues(alpha: 0.92)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.black.withValues(alpha: 0.22),
                ),
                child: Text('tap ${_tapCount + index}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProxyPrimerBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Proxy Sliver Primer', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Core wrapper behaviors commonly backed by RenderProxySliver-derived render objects.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1000;
                final Widget opacity = _primerCard(
                  scheme,
                  title: 'SliverOpacity',
                  note: 'Adjust paint contribution while preserving child sliver structure.',
                  accent: const Color(0xFF0891B2),
                );
                final Widget offstage = _primerCard(
                  scheme,
                  title: 'SliverOffstage',
                  note: 'Temporarily remove a sliver branch from paint/layout participation.',
                  accent: const Color(0xFFB45309),
                );
                final Widget ignore = _primerCard(
                  scheme,
                  title: 'SliverIgnorePointer',
                  note: 'Keep visuals while disabling pointer interaction routing to children.',
                  accent: const Color(0xFF7C3AED),
                );

                if (narrow) {
                  return Column(
                    children: <Widget>[
                      opacity,
                      const SizedBox(height: 10),
                      offstage,
                      const SizedBox(height: 10),
                      ignore,
                    ],
                  );
                }

                return Row(
                  children: <Widget>[
                    Expanded(child: opacity),
                    const SizedBox(width: 10),
                    Expanded(child: offstage),
                    const SizedBox(width: 10),
                    Expanded(child: ignore),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _primerCard(
    ColorScheme scheme, {
    required String title,
    required String note,
    required Color accent,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: accent.withValues(alpha: 0.14),
                border: Border.all(color: accent.withValues(alpha: 0.7)),
              ),
              child: Center(
                child: Text(
                  'Wrapper in action',
                  style: TextStyle(color: accent, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricCard> metrics = <_MetricCard>[
      _MetricCard(label: 'Scenario', value: _scenario.name, note: 'Active scenario lane.', icon: Icons.view_agenda_outlined),
      _MetricCard(label: 'Theme', value: _presets[_themeIndex].name, note: 'Active visual profile.', icon: Icons.palette_outlined),
      _MetricCard(label: 'Scroll Events', value: '$_scrollEvents', note: 'Scroll controller event count.', icon: Icons.swap_vert_outlined),
      _MetricCard(label: 'Pointer Events', value: '$_pointerEvents', note: 'Pointer interactions in cards.', icon: Icons.touch_app_outlined),
      _MetricCard(label: 'Tap Count', value: '$_tapCount', note: 'Taps received by interactive cards.', icon: Icons.ads_click_outlined),
      _MetricCard(label: 'Last Offset', value: _lastOffset.toStringAsFixed(1), note: 'Most recent scroll offset.', icon: Icons.linear_scale_outlined),
      _MetricCard(label: 'Last Channel', value: _lastChannel, note: 'Latest timeline channel.', icon: Icons.fiber_manual_record_outlined),
      _MetricCard(label: 'Last Message', value: _lastMessage, note: 'Latest event note.', icon: Icons.notes_outlined),
      _MetricCard(label: 'Scenario Switches', value: '$_scenarioSwitches', note: 'How often scenario changed.', icon: Icons.swap_horiz_outlined),
      _MetricCard(label: 'Theme Switches', value: '$_themeSwitches', note: 'How often theme changed.', icon: Icons.style_outlined),
      _MetricCard(label: 'Control Edits', value: '$_controlEdits', note: 'Manual control modifications.', icon: Icons.tune_outlined),
      _MetricCard(label: 'Opacity Pair', value: '${_opacityA.toStringAsFixed(2)} / ${_opacityB.toStringAsFixed(2)}', note: 'Current opacity values.', icon: Icons.opacity_outlined),
      _MetricCard(label: 'Header Height', value: _headerHeight.toStringAsFixed(1), note: 'Pinned header height.', icon: Icons.vertical_align_top_outlined),
      _MetricCard(label: 'Tile Height', value: _tileHeight.toStringAsFixed(1), note: 'Scenario tile height.', icon: Icons.height_outlined),
      _MetricCard(label: 'Spacing', value: _spacing.toStringAsFixed(1), note: 'Tile vertical spacing.', icon: Icons.space_bar_outlined),
      _MetricCard(label: 'Curve Factor', value: _curveFactor.toStringAsFixed(2), note: 'Geometry visualization factor.', icon: Icons.show_chart_outlined),
      _MetricCard(label: 'Pinned Header', value: '$_usePinnedHeader', note: 'Header pin behavior.', icon: Icons.push_pin_outlined),
      _MetricCard(label: 'Offstage', value: '$_offstageEnabled', note: 'Offstage wrapper status.', icon: Icons.visibility_off_outlined),
      _MetricCard(label: 'Ignore Pointer', value: '$_ignorePointerEnabled', note: 'Pointer wrapper status.', icon: Icons.block_outlined),
      _MetricCard(label: 'Timeline Entries', value: '${_timeline.length}', note: 'Captured timeline events.', icon: Icons.timeline_outlined),
    ];

    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Metrics and Diagnostics', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 1200
                    ? 4
                    : constraints.maxWidth > 860
                        ? 3
                        : constraints.maxWidth > 560
                            ? 2
                            : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: metrics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.7 : 2.06,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricCard card = metrics[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(card.icon, size: 17, color: scheme.primary),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: Text(
                                    card.label,
                                    style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              card.value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              card.note,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (_showDiagnostics) const SizedBox(height: 12),
            if (_showDiagnostics)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                  color: scheme.surfaceContainerHighest,
                ),
                child: Text(
                  'snapshot scenario=${_scenario.name} theme=${_presets[_themeIndex].name} '
                  'offset=${_lastOffset.toStringAsFixed(1)} opacityA=${_opacityA.toStringAsFixed(2)} '
                  'opacityB=${_opacityB.toStringAsFixed(2)} offstage=$_offstageEnabled ignore=$_ignorePointerEnabled '
                  'scrollEvents=$_scrollEvents pointerEvents=$_pointerEvents timeline=${_timeline.length}',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Guide and FAQ', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            ..._guideLines.map((String line) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 8, color: scheme.primary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 22),
            ..._faqs.map(( _Faq faq) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                  color: scheme.surfaceContainerHighest,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(faq.question, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(faq.answer, style: TextStyle(color: scheme.onSurfaceVariant)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Event Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    setState(() => _timeline.clear());
                    _pushTimeline('system', 'Timeline cleared');
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_timeline.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Text('Timeline is empty. Scroll or interact with cards to record events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _timeline.take(44).map(( _TimelineEvent event) {
                  final String stamp = '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(
                          event.channel.characters.first.toUpperCase(),
                          style: TextStyle(color: scheme.onPrimaryContainer),
                        ),
                      ),
                      title: Text(
                        '${event.channel}  |  offset ${event.offset.toStringAsFixed(1)}',
                        style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      subtitle: Text('$stamp  ${event.message}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _GeometryGridPainter extends CustomPainter {
  const _GeometryGridPainter({
    required this.color,
    required this.curveFactor,
    required this.showHighlight,
  });

  final Color color;
  final double curveFactor;
  final bool showHighlight;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.34),
          color.withValues(alpha: 0.08),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeWidth = 1;
    const double step = 24;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Path curve = Path();
    curve.moveTo(0, size.height * 0.72);
    for (double x = 0; x <= size.width; x += 12) {
      final double t = x / size.width;
      final double y = size.height * (0.7 - 0.45 * curveFactor * (0.5 - (t - 0.5).abs()));
      curve.lineTo(x, y);
    }
    canvas.drawPath(
      curve,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.76)
        ..strokeWidth = 2.2
        ..style = PaintingStyle.stroke,
    );

    if (showHighlight) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width * 0.66, size.height * 0.2, size.width * 0.28, size.height * 0.55),
          const Radius.circular(12),
        ),
        Paint()
          ..color = Colors.white.withValues(alpha: 0.12)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GeometryGridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.curveFactor != curveFactor || oldDelegate.showHighlight != showHighlight;
  }
}
