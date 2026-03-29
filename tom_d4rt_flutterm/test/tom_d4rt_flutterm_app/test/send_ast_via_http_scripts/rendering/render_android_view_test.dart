import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'oxide',
    name: 'Oxide Console',
    description: 'Industrial dashboard look for platform-view lifecycle studies.',
    seed: Color(0xFF0369A1),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'ember',
    name: 'Ember Grid',
    description: 'Warm accent profile tuned for interactive workshops.',
    seed: Color(0xFFC2410C),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'graphite',
    name: 'Graphite Night',
    description: 'Dark review profile for inspecting overlays and hit-test layers.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'mint',
    name: 'Mint Lab',
    description: 'Readable profile for long explain-and-demo sessions.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(
    id: 'runtime-host',
    title: 'Runtime Host',
    subtitle: 'Live host area showing Android-specific and non-Android behavior.',
  ),
  _Scenario(
    id: 'hit-test',
    title: 'Hit Test Matrix',
    subtitle: 'Compare opaque, translucent, and transparent platform hit policies.',
  ),
  _Scenario(
    id: 'clip-showcase',
    title: 'Clip Showcase',
    subtitle: 'Visualize clip behavior options around platform view surfaces.',
  ),
  _Scenario(
    id: 'ops-console',
    title: 'Ops Console',
    subtitle: 'Full diagnostics, gesture registry, and lifecycle timeline.',
  ),
];

const List<_ViewTypePreset> _viewTypePresets = <_ViewTypePreset>[
  _ViewTypePreset(
    viewType: 'demo/native-map',
    label: 'Native Map Surface',
    note: 'Typical geospatial integration where AndroidView hosts a map SDK surface.',
  ),
  _ViewTypePreset(
    viewType: 'demo/native-web',
    label: 'Native Web Surface',
    note: 'Web or rich content host backed by Android platform widgets.',
  ),
  _ViewTypePreset(
    viewType: 'demo/native-camera',
    label: 'Native Camera Surface',
    note: 'Camera preview style host for sensor-rich native plugins.',
  ),
  _ViewTypePreset(
    viewType: 'demo/native-ad',
    label: 'Native Ad Surface',
    note: 'Embedded ad unit where platform SDK controls rendering and gestures.',
  ),
];

const List<_FaqItem> _faq = <_FaqItem>[
  _FaqItem(
    question: 'Where does RenderAndroidView appear in app code?',
    answer:
        'It is the render object used by AndroidView and related platform view widgets when running on Android.',
  ),
  _FaqItem(
    question: 'Why focus on hitTestBehavior?',
    answer:
        'Because gesture routing between Flutter layers and platform surfaces is the most common source of integration bugs.',
  ),
  _FaqItem(
    question: 'Can this script still teach behavior on Linux/macOS?',
    answer:
        'Yes. The simulator path explains render decisions while guarding Android-only runtime creation safely.',
  ),
  _FaqItem(
    question: 'When should clipBehavior be adjusted?',
    answer:
        'When edges, rounded corners, or host overflow are part of visual polish and layering correctness.',
  ),
];

const List<String> _introBullets = <String>[
  'RenderAndroidView is a platform-view render box used for embedding Android-native surfaces in Flutter layouts.',
  'This deep demo is visual-first: it combines operational boards, controls, and diagnostics rather than API assertions.',
  'The runtime host panel demonstrates Android-only creation and safe fallback behavior on non-Android platforms.',
  'Hit-test and gesture boards help reason about user interaction routing across Flutter and native layers.',
  'Clip behavior galleries illustrate edge handling when platform surfaces are framed or rounded.',
  'Timeline events and metrics provide practical instrumentation for interpreter bridge verification.',
];

const List<String> _bestPractices = <String>[
  'Pick a hit-test behavior intentionally; never rely on defaults in complex layered screens.',
  'Log platform view creation IDs and lifecycle transitions when debugging missing or stale surfaces.',
  'Register only required gesture recognizers to avoid accidental gesture competition.',
  'Apply clip behavior deliberately when composing rounded cards or segmented host panels.',
  'Test integration behavior on Android hardware in addition to editor simulations.',
  'Keep visible fallback panels for non-Android environments during cross-platform development.',
  'Document viewType contract and expected creationParams with plugin owners.',
  'Use dashboard metrics to compare behavior before and after bridge changes.',
];

class _ThemePreset {
  const _ThemePreset({
    required this.id,
    required this.name,
    required this.description,
    required this.seed,
    required this.brightness,
  });

  final String id;
  final String name;
  final String description;
  final Color seed;
  final Brightness brightness;
}

class _Scenario {
  const _Scenario({required this.id, required this.title, required this.subtitle});

  final String id;
  final String title;
  final String subtitle;
}

class _ViewTypePreset {
  const _ViewTypePreset({
    required this.viewType,
    required this.label,
    required this.note,
  });

  final String viewType;
  final String label;
  final String note;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _Metric {
  const _Metric({
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

class _TimelineEntry {
  const _TimelineEntry({
    required this.time,
    required this.title,
    required this.message,
  });

  final DateTime time;
  final String title;
  final String message;
}

dynamic build(BuildContext context) {
  return const _RenderAndroidViewStudio();
}

class _RenderAndroidViewStudio extends StatefulWidget {
  const _RenderAndroidViewStudio();

  @override
  State<_RenderAndroidViewStudio> createState() => _RenderAndroidViewStudioState();
}

class _RenderAndroidViewStudioState extends State<_RenderAndroidViewStudio> {
  final ScrollController _scrollController = ScrollController();

  int _themeIndex = 0;
  int _scenarioIndex = 0;
  int _viewPresetIndex = 0;

  PlatformViewHitTestBehavior _hitTestBehavior = PlatformViewHitTestBehavior.opaque;
  Clip _clipBehavior = Clip.hardEdge;

  bool _enableTap = true;
  bool _enablePan = false;
  bool _enableScale = false;
  bool _enableLongPress = false;

  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;

  double _hostWidth = 360;
  double _hostHeight = 220;
  double _borderRadius = 18;
  double _overlayOpacity = 0.24;

  int _outsideTapCount = 0;
  int _insideTapCount = 0;
  int _platformCreatedCount = 0;
  int _behaviorSwitchCount = 0;
  int _clipSwitchCount = 0;
  int _gestureSwitchCount = 0;

  String _lastPlatformId = 'none';
  String _lastMessage = 'No platform events yet.';

  List<_TimelineEntry> _timeline = const <_TimelineEntry>[];

  bool get _isAndroidRuntime => defaultTargetPlatform == TargetPlatform.android;

  String get _viewType => _viewTypePresets[_viewPresetIndex].viewType;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addTimeline(String title, String message) {
    final List<_TimelineEntry> next = <_TimelineEntry>[
      _TimelineEntry(time: DateTime.now(), title: title, message: message),
      ..._timeline,
    ];
    setState(() {
      _timeline = next.take(36).toList(growable: false);
      _lastMessage = '$title: $message';
    });
  }

  void _registerPlatformCreated(int id) {
    setState(() {
      _platformCreatedCount += 1;
      _lastPlatformId = '$id';
    });
    _addTimeline('PlatformViewCreated', 'Android platform view id=$id for viewType=$_viewType');
  }

  void _applyHitTestBehavior(PlatformViewHitTestBehavior behavior) {
    if (_hitTestBehavior == behavior) {
      return;
    }
    setState(() {
      _hitTestBehavior = behavior;
      _behaviorSwitchCount += 1;
    });
    _addTimeline('HitTestBehavior', 'Changed to ${behavior.name}.');
  }

  void _applyClipBehavior(Clip clip) {
    if (_clipBehavior == clip) {
      return;
    }
    setState(() {
      _clipBehavior = clip;
      _clipSwitchCount += 1;
    });
    _addTimeline('ClipBehavior', 'Changed to ${clip.name}.');
  }

  void _resetConsole() {
    setState(() {
      _scenarioIndex = 0;
      _viewPresetIndex = 0;
      _hitTestBehavior = PlatformViewHitTestBehavior.opaque;
      _clipBehavior = Clip.hardEdge;
      _enableTap = true;
      _enablePan = false;
      _enableScale = false;
      _enableLongPress = false;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _hostWidth = 360;
      _hostHeight = 220;
      _borderRadius = 18;
      _overlayOpacity = 0.24;
      _outsideTapCount = 0;
      _insideTapCount = 0;
      _platformCreatedCount = 0;
      _behaviorSwitchCount = 0;
      _clipSwitchCount = 0;
      _gestureSwitchCount = 0;
      _lastPlatformId = 'none';
      _lastMessage = 'Console reset complete.';
      _timeline = const <_TimelineEntry>[];
    });
    _addTimeline('Reset', 'Studio settings returned to defaults.');
  }

  Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers() {
    final Set<Factory<OneSequenceGestureRecognizer>> recognizers = <Factory<OneSequenceGestureRecognizer>>{};
    if (_enableTap) {
      recognizers.add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()));
    }
    if (_enablePan) {
      recognizers.add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()));
    }
    if (_enableScale) {
      recognizers.add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()));
    }
    if (_enableLongPress) {
      recognizers.add(Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer()));
    }
    return recognizers;
  }

  List<_Metric> _buildMetrics(ColorScheme scheme) {
    final Set<Factory<OneSequenceGestureRecognizer>> recognizers = _gestureRecognizers();
    return <_Metric>[
      _Metric(
        label: 'Platform Runtime',
        value: _isAndroidRuntime ? 'Android' : 'Non-Android',
        note: _isAndroidRuntime
            ? 'AndroidView branch can produce RenderAndroidView at runtime.'
            : 'Simulator branch active; AndroidView guarded for safe execution.',
        icon: Icons.phone_android,
      ),
      _Metric(
        label: 'viewType',
        value: _viewType,
        note: 'Plugin channel key used to request the platform surface.',
        icon: Icons.key_outlined,
      ),
      _Metric(
        label: 'Hit Test',
        value: _hitTestBehavior.name,
        note: 'Controls whether platform view absorbs, shares, or ignores hits.',
        icon: Icons.ads_click_outlined,
      ),
      _Metric(
        label: 'Clip',
        value: _clipBehavior.name,
        note: 'Edge clipping policy for the platform host frame.',
        icon: Icons.crop,
      ),
      _Metric(
        label: 'Recognizers',
        value: '${recognizers.length}',
        note: 'Registered gesture recognizers passed to AndroidView.',
        icon: Icons.gesture,
      ),
      _Metric(
        label: 'Created IDs',
        value: '$_platformCreatedCount',
        note: 'Count of onPlatformViewCreated callbacks observed.',
        icon: Icons.confirmation_number_outlined,
      ),
      _Metric(
        label: 'Last ID',
        value: _lastPlatformId,
        note: 'Most recent platform view identifier callback value.',
        icon: Icons.pin_outlined,
      ),
      _Metric(
        label: 'Outside Taps',
        value: '$_outsideTapCount',
        note: 'Gesture count captured by Flutter layers around host.',
        icon: Icons.touch_app,
      ),
      _Metric(
        label: 'Inside Taps',
        value: '$_insideTapCount',
        note: 'Gesture count captured on simulator/native host panel.',
        icon: Icons.fingerprint,
      ),
      _Metric(
        label: 'Behavior Switches',
        value: '$_behaviorSwitchCount',
        note: 'How often hit-test mode was switched during exploration.',
        icon: Icons.swap_horiz,
      ),
      _Metric(
        label: 'Clip Switches',
        value: '$_clipSwitchCount',
        note: 'How often clip behavior changed.',
        icon: Icons.flip,
      ),
      _Metric(
        label: 'Gesture Toggles',
        value: '$_gestureSwitchCount',
        note: 'Total toggles on gesture recognizer registry.',
        icon: Icons.tune,
      ),
      _Metric(
        label: 'Theme',
        value: _themePresets[_themeIndex].name,
        note: 'Visual profile for this demonstration board.',
        icon: Icons.palette_outlined,
      ),
      _Metric(
        label: 'Scenario',
        value: _scenarios[_scenarioIndex].title,
        note: 'Active demo narrative lane.',
        icon: Icons.dashboard_customize_outlined,
      ),
      _Metric(
        label: 'Last Event',
        value: _lastMessage,
        note: 'Most recent operational message in this studio.',
        icon: Icons.topic_outlined,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset preset = _themePresets[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: preset.seed,
      brightness: preset.brightness,
    );

    return Theme(
      data: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        brightness: preset.brightness,
      ),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                scheme.surface,
                scheme.surfaceContainerLowest,
                scheme.surfaceContainerLow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1320),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildProfileAndScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _buildPrimaryConsole(scheme),
                        const SizedBox(height: 16),
                        _buildHitTestMatrix(scheme),
                        const SizedBox(height: 16),
                        _buildClipShowcase(scheme),
                        const SizedBox(height: 16),
                        _buildMetricsBoard(scheme),
                        const SizedBox(height: 16),
                        if (_showGuide) _buildGuideBoard(scheme),
                        if (_showGuide) const SizedBox(height: 16),
                        if (_showTimeline) _buildTimelineBoard(scheme),
                      ],
                    ),
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
                Icon(Icons.view_in_ar_outlined, color: scheme.primary, size: 24),
                Text(
                  'RenderAndroidView Platform Studio',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _isAndroidRuntime ? 'Android Runtime' : 'Simulator Runtime',
                    style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'A visual, interactive demo for RenderAndroidView behavior through AndroidView integration.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAndScenarioBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_themePresets.length, (int index) {
                final _ThemePreset option = _themePresets[index];
                return ChoiceChip(
                  selected: index == _themeIndex,
                  label: Text(option.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
                    });
                    _addTimeline('Theme', 'Switched to ${option.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(_themePresets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 14),
            Text('Scenarios', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int index) {
                final _Scenario option = _scenarios[index];
                return FilterChip(
                  selected: index == _scenarioIndex,
                  label: Text(option.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = index;
                    });
                    _addTimeline('Scenario', option.subtitle);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarios[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryConsole(ColorScheme scheme) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 1040;
        if (narrow) {
          return Column(
            children: <Widget>[
              _buildRuntimeHostBoard(scheme),
              const SizedBox(height: 16),
              _buildControlBoard(scheme),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 7, child: _buildRuntimeHostBoard(scheme)),
            const SizedBox(width: 16),
            Expanded(flex: 5, child: _buildControlBoard(scheme)),
          ],
        );
      },
    );
  }

  Widget _buildRuntimeHostBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Runtime Host', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: _resetConsole,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Uses AndroidView on Android and a simulator panel elsewhere while preserving the same controls.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () {
                setState(() {
                  _outsideTapCount += 1;
                });
                _addTimeline('OuterTap', 'Tap captured by outer Flutter host layer.');
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    width: _hostWidth,
                    height: _hostHeight,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(_borderRadius),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: Stack(
                      children: <Widget>[
                        if (_showGrid)
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.26)),
                            ),
                          ),
                        Positioned.fill(child: _buildRuntimeSurface(scheme)),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: _buildStatusChip(
                            scheme,
                            _isAndroidRuntime ? 'Android runtime active' : 'Simulator runtime active',
                            Icons.memory_outlined,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: _buildStatusChip(
                            scheme,
                            'HitTest: ${_hitTestBehavior.name}',
                            Icons.ads_click_outlined,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: _buildStatusChip(
                            scheme,
                            'Clip: ${_clipBehavior.name}',
                            Icons.crop,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _outsideTapCount = 0;
                      _insideTapCount = 0;
                    });
                    _addTimeline('Counters', 'Tap counters cleared.');
                  },
                  icon: const Icon(Icons.cleaning_services_outlined),
                  label: const Text('Clear Tap Counters'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showGrid = !_showGrid;
                    });
                    _addTimeline('Grid', _showGrid ? 'Grid enabled.' : 'Grid disabled.');
                  },
                  icon: const Icon(Icons.grid_on),
                  label: Text(_showGrid ? 'Hide Grid' : 'Show Grid'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(ColorScheme scheme, String text, IconData icon) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: scheme.primary),
            const SizedBox(width: 6),
            Text(text, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildRuntimeSurface(ColorScheme scheme) {
    if (_isAndroidRuntime) {
      return AndroidView(
        key: ValueKey<String>('android-view-$_viewType-${_hitTestBehavior.name}-${_clipBehavior.name}'),
        viewType: _viewType,
        hitTestBehavior: _hitTestBehavior,
        clipBehavior: _clipBehavior,
        gestureRecognizers: _gestureRecognizers(),
        onPlatformViewCreated: _registerPlatformCreated,
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _insideTapCount += 1;
        });
        _addTimeline('InnerTap', 'Simulator panel tap captured in Flutter.');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[scheme.primaryContainer, scheme.secondaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(color: scheme.scrim.withValues(alpha: _overlayOpacity)),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.phone_android, color: scheme.onPrimaryContainer, size: 30),
                    const SizedBox(height: 8),
                    Text(
                      'AndroidView simulator lane',
                      style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Current viewType: $_viewType',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.onPrimaryContainer),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Running on ${defaultTargetPlatform.name}, so RenderAndroidView is explained visually via simulator path.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.onPrimaryContainer.withValues(alpha: 0.9), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Control Deck', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Tune host size, hit-test policy, clip mode, and gesture registry passed to AndroidView.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            Text('viewType Presets', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_viewTypePresets.length, (int index) {
                final _ViewTypePreset preset = _viewTypePresets[index];
                return ChoiceChip(
                  selected: index == _viewPresetIndex,
                  label: Text(preset.label),
                  onSelected: (_) {
                    setState(() {
                      _viewPresetIndex = index;
                    });
                    _addTimeline('viewType', 'Changed to ${preset.viewType}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_viewTypePresets[_viewPresetIndex].note, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 24),
            _sliderRow(
              scheme: scheme,
              label: 'Host Width',
              value: _hostWidth,
              min: 240,
              max: 640,
              divisions: 80,
              onChanged: (double value) => setState(() => _hostWidth = value),
              onChangeEnd: (_) => _addTimeline('Host Width', 'Changed to ${_hostWidth.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Host Height',
              value: _hostHeight,
              min: 160,
              max: 420,
              divisions: 65,
              onChanged: (double value) => setState(() => _hostHeight = value),
              onChangeEnd: (_) => _addTimeline('Host Height', 'Changed to ${_hostHeight.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Border Radius',
              value: _borderRadius,
              min: 0,
              max: 42,
              divisions: 42,
              onChanged: (double value) => setState(() => _borderRadius = value),
              onChangeEnd: (_) => _addTimeline('Border Radius', 'Changed to ${_borderRadius.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Overlay Opacity',
              value: _overlayOpacity,
              min: 0,
              max: 0.6,
              divisions: 30,
              onChanged: (double value) => setState(() => _overlayOpacity = value),
              onChangeEnd: (_) => _addTimeline('Overlay', 'Changed to ${_overlayOpacity.toStringAsFixed(2)}.'),
            ),
            const Divider(height: 24),
            Text('Hit-Test Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            SegmentedButton<PlatformViewHitTestBehavior>(
              segments: const <ButtonSegment<PlatformViewHitTestBehavior>>[
                ButtonSegment<PlatformViewHitTestBehavior>(
                  value: PlatformViewHitTestBehavior.opaque,
                  label: Text('Opaque'),
                ),
                ButtonSegment<PlatformViewHitTestBehavior>(
                  value: PlatformViewHitTestBehavior.translucent,
                  label: Text('Translucent'),
                ),
                ButtonSegment<PlatformViewHitTestBehavior>(
                  value: PlatformViewHitTestBehavior.transparent,
                  label: Text('Transparent'),
                ),
              ],
              selected: <PlatformViewHitTestBehavior>{_hitTestBehavior},
              onSelectionChanged: (Set<PlatformViewHitTestBehavior> values) {
                _applyHitTestBehavior(values.first);
              },
            ),
            const SizedBox(height: 10),
            Text('Clip Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            SegmentedButton<Clip>(
              segments: const <ButtonSegment<Clip>>[
                ButtonSegment<Clip>(value: Clip.none, label: Text('None')),
                ButtonSegment<Clip>(value: Clip.hardEdge, label: Text('HardEdge')),
                ButtonSegment<Clip>(value: Clip.antiAlias, label: Text('AntiAlias')),
                ButtonSegment<Clip>(value: Clip.antiAliasWithSaveLayer, label: Text('SaveLayer')),
              ],
              selected: <Clip>{_clipBehavior},
              onSelectionChanged: (Set<Clip> values) {
                _applyClipBehavior(values.first);
              },
            ),
            const Divider(height: 24),
            Text('Gesture Registry', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _enableTap,
              title: const Text('TapGestureRecognizer'),
              onChanged: (bool? value) {
                setState(() {
                  _enableTap = value ?? false;
                  _gestureSwitchCount += 1;
                });
                _addTimeline('Gesture Registry', 'Tap recognizer ${_enableTap ? 'enabled' : 'disabled'}.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _enablePan,
              title: const Text('PanGestureRecognizer'),
              onChanged: (bool? value) {
                setState(() {
                  _enablePan = value ?? false;
                  _gestureSwitchCount += 1;
                });
                _addTimeline('Gesture Registry', 'Pan recognizer ${_enablePan ? 'enabled' : 'disabled'}.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _enableScale,
              title: const Text('ScaleGestureRecognizer'),
              onChanged: (bool? value) {
                setState(() {
                  _enableScale = value ?? false;
                  _gestureSwitchCount += 1;
                });
                _addTimeline('Gesture Registry', 'Scale recognizer ${_enableScale ? 'enabled' : 'disabled'}.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _enableLongPress,
              title: const Text('LongPressGestureRecognizer'),
              onChanged: (bool? value) {
                setState(() {
                  _enableLongPress = value ?? false;
                  _gestureSwitchCount += 1;
                });
                _addTimeline('Gesture Registry', 'Long-press recognizer ${_enableLongPress ? 'enabled' : 'disabled'}.');
              },
            ),
            const Divider(height: 24),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showDiagnostics,
              title: const Text('Show diagnostics board'),
              onChanged: (bool? value) => setState(() => _showDiagnostics = value ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showGuide,
              title: const Text('Show guide board'),
              onChanged: (bool? value) => setState(() => _showGuide = value ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showTimeline,
              title: const Text('Show timeline board'),
              onChanged: (bool? value) => setState(() => _showTimeline = value ?? true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliderRow({
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
            Expanded(
              child: Text(label, style: TextStyle(color: scheme.onSurface)),
            ),
            Text(value.toStringAsFixed(2), style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
        ),
      ],
    );
  }

  Widget _buildHitTestMatrix(ColorScheme scheme) {
    final List<PlatformViewHitTestBehavior> modes = <PlatformViewHitTestBehavior>[
      PlatformViewHitTestBehavior.opaque,
      PlatformViewHitTestBehavior.translucent,
      PlatformViewHitTestBehavior.transparent,
    ];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hit Test Matrix', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Visual comparison of hit-test behavior policies used by RenderAndroidView hosts.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool stacked = constraints.maxWidth < 900;
                if (stacked) {
                  return Column(
                    children: modes.map((PlatformViewHitTestBehavior behavior) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildHitTestCard(scheme, behavior),
                      );
                    }).toList(),
                  );
                }
                return Row(
                  children: modes.map((PlatformViewHitTestBehavior behavior) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _buildHitTestCard(scheme, behavior),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHitTestCard(ColorScheme scheme, PlatformViewHitTestBehavior behavior) {
    final bool selected = behavior == _hitTestBehavior;
    final String narrative = switch (behavior) {
      PlatformViewHitTestBehavior.opaque => 'Platform view consumes gestures in its area.',
      PlatformViewHitTestBehavior.translucent => 'Platform and Flutter layers may both participate.',
      PlatformViewHitTestBehavior.transparent => 'Flutter layers behind can receive gestures directly.',
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: selected ? scheme.primaryContainer.withValues(alpha: 0.32) : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: selected ? scheme.primary : scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    behavior.name,
                    style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(narrative, style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            Container(
              height: 92,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        'Flutter Layer',
                        style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 20,
                    bottom: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: scheme.primary.withValues(alpha: 0.6)),
                      ),
                      child: Center(
                        child: Text(
                          'Platform Surface',
                          style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _applyHitTestBehavior(behavior),
                child: Text(selected ? 'Active' : 'Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClipShowcase(ColorScheme scheme) {
    final List<Clip> clipModes = <Clip>[
      Clip.none,
      Clip.hardEdge,
      Clip.antiAlias,
      Clip.antiAliasWithSaveLayer,
    ];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Clip Showcase', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Compare clip policies used when framing platform-view content inside decorative shells.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: clipModes.map((Clip clip) {
                final bool selected = clip == _clipBehavior;
                return SizedBox(
                  width: 280,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: selected ? scheme.secondaryContainer.withValues(alpha: 0.38) : scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: selected ? scheme.secondary : scheme.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(clip.name, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          ClipRRect(
                            clipBehavior: clip,
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              height: 100,
                              color: scheme.surface,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: -14,
                                    top: -10,
                                    child: Container(width: 72, height: 72, color: scheme.primary.withValues(alpha: 0.7)),
                                  ),
                                  Positioned(
                                    right: -18,
                                    bottom: -10,
                                    child: Container(width: 80, height: 80, color: scheme.tertiary.withValues(alpha: 0.7)),
                                  ),
                                  Center(
                                    child: Text(
                                      'Surface Frame',
                                      style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () => _applyClipBehavior(clip),
                              child: Text(selected ? 'Active' : 'Use ${clip.name}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_Metric> metrics = _buildMetrics(scheme);
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Metrics & Diagnostics', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 1180
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
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.8 : 1.9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _Metric metric = metrics[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(metric.icon, color: scheme.primary, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    metric.label,
                                    style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              metric.value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              metric.note,
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
            if (_showDiagnostics) const SizedBox(height: 14),
            if (_showDiagnostics) _buildDiagnosticsPanel(scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticsPanel(ColorScheme scheme) {
    final Set<Factory<OneSequenceGestureRecognizer>> recognizers = _gestureRecognizers();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.terminal_outlined, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Operational Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 10),
            Text('Runtime: ${_isAndroidRuntime ? 'Android' : defaultTargetPlatform.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('viewType: $_viewType', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('hitTestBehavior: ${_hitTestBehavior.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('clipBehavior: ${_clipBehavior.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('gestureRecognizers: ${recognizers.length}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('lastPlatformId: $_lastPlatformId', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            Text('Last message: $_lastMessage', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Guide', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 10),
            ..._introBullets.map((String text) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.circle, color: scheme.primary, size: 8),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(text, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 24),
            Text('Best Practices', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._bestPractices.map((String text) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.check_circle_outline, color: scheme.secondary, size: 14),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(text, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 24),
            Text('FAQ', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._faq.map(( _FaqItem item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DecoratedBox(
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
                        Text(item.question, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text(item.answer, style: TextStyle(color: scheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
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
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Lifecycle Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _timeline = const <_TimelineEntry>[];
                    });
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Action stream for behavior toggles, platform callbacks, and runtime updates.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            if (_timeline.isEmpty)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    'Timeline is empty. Interact with the console to create events.',
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ),
              )
            else
              Column(
                children: _timeline.map(( _TimelineEntry entry) {
                  final String stamp =
                      '${entry.time.hour.toString().padLeft(2, '0')}:${entry.time.minute.toString().padLeft(2, '0')}:${entry.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer)),
                      ),
                      title: Text(entry.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${entry.message}', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const double step = 20;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final Paint center = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..strokeWidth = 1.8;
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), center);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), center);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
