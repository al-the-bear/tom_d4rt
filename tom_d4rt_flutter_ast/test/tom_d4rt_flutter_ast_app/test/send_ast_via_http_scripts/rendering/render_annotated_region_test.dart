import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'reef',
    name: 'Reef Studio',
    description: 'Bright contrast profile for zone-level annotation training.',
    seed: Color(0xFF0E7490),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'ember',
    name: 'Ember Panel',
    description: 'Warm profile emphasizing stacked annotation precedence.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Console',
    description: 'Low-luminance profile suitable for motion and overlay studies.',
    seed: Color(0xFF1E293B),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'spruce',
    name: 'Spruce Lab',
    description: 'Balanced profile for long diagnostic sessions.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
  ),
];

const List<_ScenarioLane> _lanes = <_ScenarioLane>[
  _ScenarioLane(
    id: 'zone',
    title: 'Zone Map',
    subtitle: 'Grid-driven annotation tags and active-region tracking.',
  ),
  _ScenarioLane(
    id: 'stack',
    title: 'Stack Precedence',
    subtitle: 'Top-layer wins and visibility toggles in overlapping regions.',
  ),
  _ScenarioLane(
    id: 'sized',
    title: 'Sized Lab',
    subtitle: 'sized=true and sized=false behavior under different container bounds.',
  ),
  _ScenarioLane(
    id: 'corridor',
    title: 'Scroll Corridor',
    subtitle: 'Annotation continuity through horizontally scrolling segments.',
  ),
  _ScenarioLane(
    id: 'ops',
    title: 'Ops Console',
    subtitle: 'Metrics, timeline, practical use board, and diagnostic snapshots.',
  ),
];

const List<_AlignmentPreset> _anchors = <_AlignmentPreset>[
  _AlignmentPreset(label: 'Center', value: Alignment.center),
  _AlignmentPreset(label: 'Top Left', value: Alignment.topLeft),
  _AlignmentPreset(label: 'Top Right', value: Alignment.topRight),
  _AlignmentPreset(label: 'Bottom Left', value: Alignment.bottomLeft),
  _AlignmentPreset(label: 'Bottom Right', value: Alignment.bottomRight),
];

const List<_FaqItem> _faq = <_FaqItem>[
  _FaqItem(
    question: 'What is RenderAnnotatedRegion for?',
    answer: 'It attaches typed metadata to painted regions so ancestor systems can query context at a location.',
  ),
  _FaqItem(
    question: 'Where is it commonly used?',
    answer: 'A common use is SystemUiOverlayStyle via AnnotatedRegion<SystemUiOverlayStyle> near app bars.',
  ),
  _FaqItem(
    question: 'Why does overlap matter?',
    answer: 'When multiple annotations overlap, the effective value depends on which layer is resolved at a given point.',
  ),
  _FaqItem(
    question: 'What does the sized flag influence?',
    answer: 'It controls how the annotation region maps to layout bounds, changing how far the value is considered valid.',
  ),
];

const List<String> _guideBullets = <String>[
  'AnnotatedRegion<T> is the high-level widget used to create a RenderAnnotatedRegion in the render tree.',
  'Treat annotation values as contextual metadata, not UI state; keep them immutable and descriptive.',
  'Model overlapping layers intentionally, because precedence and hit context can change active metadata.',
  'Use typed payloads to avoid guessing intent when reading values from annotation queries.',
  'Document where annotations are expected to be read (status bars, overlay coordinators, debug tools).',
  'Exercise scrolling and clipping scenarios; moving viewports are common places where context assumptions break.',
  'For platform overlays, test light and dark modes with explicit SystemUiOverlayStyle variants.',
  'Build operational diagnostics so annotation behavior stays transparent during maintenance.',
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

class _ScenarioLane {
  const _ScenarioLane({required this.id, required this.title, required this.subtitle});

  final String id;
  final String title;
  final String subtitle;
}

class _AlignmentPreset {
  const _AlignmentPreset({required this.label, required this.value});

  final String label;
  final Alignment value;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _RegionTag {
  const _RegionTag({
    required this.id,
    required this.title,
    required this.category,
    required this.intent,
    required this.color,
    required this.priority,
  });

  final String id;
  final String title;
  final String category;
  final String intent;
  final Color color;
  final int priority;
}

class _MetricItem {
  const _MetricItem({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _TimelineEvent {
  const _TimelineEvent({required this.time, required this.title, required this.message});

  final DateTime time;
  final String title;
  final String message;
}

class _OverlayPreset {
  const _OverlayPreset({required this.label, required this.style, required this.description, required this.surface});

  final String label;
  final SystemUiOverlayStyle style;
  final String description;
  final Color surface;
}

const List<_OverlayPreset> _overlayPresets = <_OverlayPreset>[
  _OverlayPreset(
    label: 'Light Icons',
    style: SystemUiOverlayStyle.light,
    description: 'Intended for dark app bar backgrounds where light system icons remain legible.',
    surface: Color(0xFF0F172A),
  ),
  _OverlayPreset(
    label: 'Dark Icons',
    style: SystemUiOverlayStyle.dark,
    description: 'Intended for light app bar backgrounds where dark system icons remain legible.',
    surface: Color(0xFFF8FAFC),
  ),
  _OverlayPreset(
    label: 'Brand Blend',
    style: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarColor: Color(0x00222222),
      systemNavigationBarColor: Color(0xFF111827),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    description: 'Custom mixed style often used in brand-driven immersive surfaces.',
    surface: Color(0xFF1F2937),
  ),
];

dynamic build(BuildContext context) {
  return const _RenderAnnotatedRegionAtlas();
}

class _RenderAnnotatedRegionAtlas extends StatefulWidget {
  const _RenderAnnotatedRegionAtlas();

  @override
  State<_RenderAnnotatedRegionAtlas> createState() => _RenderAnnotatedRegionAtlasState();
}

class _RenderAnnotatedRegionAtlasState extends State<_RenderAnnotatedRegionAtlas> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _corridorController = ScrollController();

  int _themeIndex = 0;
  int _laneIndex = 0;
  int _overlayIndex = 0;

  bool _showGrid = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showTopLayer = true;
  bool _showMiddleLayer = true;
  bool _showBottomLayer = true;
  bool _topSized = true;
  bool _middleSized = true;
  bool _bottomSized = true;

  double _zoneScale = 1;
  double _stackProbeX = 0.5;
  double _stackProbeY = 0.5;
  double _corridorDensity = 0.6;

  Alignment _zoneAnchor = Alignment.center;

  _RegionTag? _activeZoneTag;
  _RegionTag? _hoverZoneTag;
  _RegionTag? _stackResolvedTag;
  _RegionTag? _corridorTag;

  int _zoneTapCount = 0;
  int _hoverCount = 0;
  int _stackProbeCount = 0;
  int _sizedToggleCount = 0;
  int _overlaySwitchCount = 0;
  int _corridorScrollCount = 0;
  int _themeSwitchCount = 0;

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  final List<_RegionTag> _zoneTags = <_RegionTag>[
    const _RegionTag(
      id: 'status',
      title: 'Status Header',
      category: 'system-ui',
      intent: 'Represents app bar or status area metadata.',
      color: Color(0xFF2563EB),
      priority: 9,
    ),
    const _RegionTag(
      id: 'hero',
      title: 'Hero Banner',
      category: 'content',
      intent: 'Primary content zone carrying high-level context value.',
      color: Color(0xFF7C3AED),
      priority: 8,
    ),
    const _RegionTag(
      id: 'action',
      title: 'Action Rail',
      category: 'controls',
      intent: 'Region typically associated with actions and intent routing.',
      color: Color(0xFFB45309),
      priority: 7,
    ),
    const _RegionTag(
      id: 'insight',
      title: 'Insight Card',
      category: 'analytics',
      intent: 'Observability-focused context used by debug overlays.',
      color: Color(0xFF047857),
      priority: 6,
    ),
    const _RegionTag(
      id: 'notes',
      title: 'Notes Dock',
      category: 'context',
      intent: 'Low-priority annotation to retain user guidance context.',
      color: Color(0xFFDC2626),
      priority: 4,
    ),
    const _RegionTag(
      id: 'footer',
      title: 'Footer Path',
      category: 'navigation',
      intent: 'Bottom-surface region often associated with navigation metadata.',
      color: Color(0xFF0EA5E9),
      priority: 5,
    ),
    const _RegionTag(
      id: 'modal',
      title: 'Modal Scope',
      category: 'overlay',
      intent: 'Overlay layer annotation for transient surfaces.',
      color: Color(0xFF9333EA),
      priority: 10,
    ),
    const _RegionTag(
      id: 'feed',
      title: 'Feed Lane',
      category: 'content',
      intent: 'Scrolling feed context annotation.',
      color: Color(0xFF16A34A),
      priority: 3,
    ),
    const _RegionTag(
      id: 'detail',
      title: 'Detail Pane',
      category: 'detail',
      intent: 'Detail panel context tied to selected content.',
      color: Color(0xFF4F46E5),
      priority: 2,
    ),
  ];

  late final _RegionTag _stackBottomTag = _zoneTags[1];
  late final _RegionTag _stackMiddleTag = _zoneTags[6];
  late final _RegionTag _stackTopTag = _zoneTags[0];

  @override
  void initState() {
    super.initState();
    _activeZoneTag = _zoneTags.first;
    _stackResolvedTag = _stackTopTag;
    _corridorTag = _zoneTags[0];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'RenderAnnotatedRegion annotation atlas initialized.');
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _corridorController.dispose();
    super.dispose();
  }

  void _pushTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEvent>[
        _TimelineEvent(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(60).toList(growable: false);
    });
  }

  void _resolveStackTag() {
    final Rect topRect = Rect.fromLTWH(230, 60, _topSized ? 170 : 310, _topSized ? 120 : 230);
    final Rect middleRect = Rect.fromLTWH(150, 90, _middleSized ? 220 : 310, _middleSized ? 150 : 230);
    final Rect bottomRect = Rect.fromLTWH(80, 130, _bottomSized ? 250 : 310, _bottomSized ? 190 : 230);

    final Offset p = Offset(lerpDouble(50, 360, _stackProbeX) ?? 200, lerpDouble(30, 260, _stackProbeY) ?? 150);
    _RegionTag? resolved;

    if (_showTopLayer && topRect.contains(p)) {
      resolved = _stackTopTag;
    } else if (_showMiddleLayer && middleRect.contains(p)) {
      resolved = _stackMiddleTag;
    } else if (_showBottomLayer && bottomRect.contains(p)) {
      resolved = _stackBottomTag;
    }

    setState(() {
      _stackResolvedTag = resolved;
      _stackProbeCount += 1;
    });

    if (resolved == null) {
      _pushTimeline('Stack Probe', 'Probe moved outside active annotation layers.');
    } else {
      _pushTimeline('Stack Probe', 'Probe resolved ${resolved.title} (${resolved.category}).');
    }
  }

  List<_MetricItem> _metrics() {
    return <_MetricItem>[
      _MetricItem(label: 'Lane', value: _lanes[_laneIndex].title, note: 'Active demonstration lane.', icon: Icons.dashboard_customize),
      _MetricItem(label: 'Theme', value: _themePresets[_themeIndex].name, note: 'Current visual profile.', icon: Icons.palette_outlined),
      _MetricItem(label: 'Zone Taps', value: '$_zoneTapCount', note: 'Number of explicit zone selections.', icon: Icons.touch_app_outlined),
      _MetricItem(label: 'Hover Changes', value: '$_hoverCount', note: 'Hover-triggered zone updates.', icon: Icons.ads_click_outlined),
      _MetricItem(label: 'Stack Probes', value: '$_stackProbeCount', note: 'Stack precedence probe updates.', icon: Icons.layers_outlined),
      _MetricItem(label: 'Sized Toggles', value: '$_sizedToggleCount', note: 'sized=true/false toggle count.', icon: Icons.aspect_ratio),
      _MetricItem(label: 'Overlay Switches', value: '$_overlaySwitchCount', note: 'SystemUiOverlayStyle preset changes.', icon: Icons.phone_android_outlined),
      _MetricItem(label: 'Corridor Scrolls', value: '$_corridorScrollCount', note: 'Horizontal corridor movement actions.', icon: Icons.swap_horiz_outlined),
      _MetricItem(label: 'Theme Switches', value: '$_themeSwitchCount', note: 'Visual profile changes.', icon: Icons.color_lens_outlined),
      _MetricItem(label: 'Active Zone', value: _activeZoneTag?.title ?? 'none', note: 'Last selected zone tag.', icon: Icons.location_on_outlined),
      _MetricItem(label: 'Stack Result', value: _stackResolvedTag?.title ?? 'none', note: 'Current stack probe resolution.', icon: Icons.filter_center_focus),
      _MetricItem(label: 'Corridor Tag', value: _corridorTag?.title ?? 'none', note: 'Tag selected from corridor segments.', icon: Icons.view_carousel_outlined),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset preset = _themePresets[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: preset.seed, brightness: preset.brightness);
    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: preset.brightness),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[scheme.surface, scheme.surfaceContainerLowest, scheme.surfaceContainerLow],
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
                    constraints: const BoxConstraints(maxWidth: 1330),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildThemeAndLaneBoard(scheme),
                        const SizedBox(height: 16),
                        _buildZoneMapBoard(scheme),
                        const SizedBox(height: 16),
                        _buildStackPrecedenceBoard(scheme),
                        const SizedBox(height: 16),
                        _buildSizedLabBoard(scheme),
                        const SizedBox(height: 16),
                        _buildCorridorBoard(scheme),
                        const SizedBox(height: 16),
                        _buildPracticalOverlayBoard(scheme),
                        const SizedBox(height: 16),
                        _buildMetricsBoard(scheme),
                        if (_showGuide) const SizedBox(height: 16),
                        if (_showGuide) _buildGuideBoard(scheme),
                        if (_showTimeline) const SizedBox(height: 16),
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
                Icon(Icons.sell_outlined, color: scheme.primary, size: 26),
                Text(
                  'RenderAnnotatedRegion Annotation Atlas',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_lanes[_laneIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'This deep visual demo uses AnnotatedRegion to illustrate RenderAnnotatedRegion-style metadata behavior across zones, stacks, sizing modes, scrolling lanes, and platform overlay use cases.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeAndLaneBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Theme Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_themePresets.length, (int index) {
                final _ThemePreset p = _themePresets[index];
                return ChoiceChip(
                  selected: index == _themeIndex,
                  label: Text(p.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
                      _themeSwitchCount += 1;
                    });
                    _pushTimeline('Theme', 'Switched to ${p.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themePresets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 24),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_lanes.length, (int index) {
                final _ScenarioLane lane = _lanes[index];
                return FilterChip(
                  selected: _laneIndex == index,
                  label: Text(lane.title),
                  onSelected: (_) {
                    setState(() {
                      _laneIndex = index;
                    });
                    _pushTimeline('Lane', lane.subtitle);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_lanes[_laneIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 24),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              children: <Widget>[
                CheckboxMenuButton(
                  value: _showGrid,
                  onChanged: (bool? value) => setState(() => _showGrid = value ?? true),
                  child: const Text('Show zone grid'),
                ),
                CheckboxMenuButton(
                  value: _showDiagnostics,
                  onChanged: (bool? value) => setState(() => _showDiagnostics = value ?? true),
                  child: const Text('Show diagnostics snapshot'),
                ),
                CheckboxMenuButton(
                  value: _showGuide,
                  onChanged: (bool? value) => setState(() => _showGuide = value ?? true),
                  child: const Text('Show guide board'),
                ),
                CheckboxMenuButton(
                  value: _showTimeline,
                  onChanged: (bool? value) => setState(() => _showTimeline = value ?? true),
                  child: const Text('Show timeline board'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoneMapBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Zone Map', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Nine annotated regions model a dashboard-style layout. Hover or tap tiles to surface active metadata.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _anchors.map(( _AlignmentPreset p) {
                      return ChoiceChip(
                        selected: p.value == _zoneAnchor,
                        label: Text(p.label),
                        onSelected: (_) {
                          setState(() {
                            _zoneAnchor = p.value;
                          });
                          _pushTimeline('Zone Anchor', 'Changed zone tile alignment to ${p.label}.');
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 220,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Expanded(child: Text('Zone Scale')),
                          Text(_zoneScale.toStringAsFixed(2)),
                        ],
                      ),
                      Slider(
                        value: _zoneScale,
                        min: 0.7,
                        max: 1.4,
                        divisions: 35,
                        onChanged: (double value) => setState(() => _zoneScale = value),
                        onChangeEnd: (double value) => _pushTimeline('Zone Scale', 'Zone scale changed to ${value.toStringAsFixed(2)}.'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double width = constraints.maxWidth;
                    final double cellWidth = (width - 24) / 3;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List<Widget>.generate(_zoneTags.length, (int index) {
                        final _RegionTag tag = _zoneTags[index];
                        return SizedBox(
                          width: cellWidth,
                          child: _zoneTile(scheme, tag),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            _activeTagSummary(scheme),
          ],
        ),
      ),
    );
  }

  Widget _zoneTile(ColorScheme scheme, _RegionTag tag) {
    final bool isActive = _activeZoneTag?.id == tag.id;
    final bool isHover = _hoverZoneTag?.id == tag.id;
    return AnnotatedRegion<_RegionTag>(
      value: tag,
      sized: true,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _hoverZoneTag = tag;
            _hoverCount += 1;
          });
        },
        onExit: (_) => setState(() => _hoverZoneTag = null),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _activeZoneTag = tag;
              _zoneTapCount += 1;
            });
            _pushTimeline('Zone Tap', 'Selected ${tag.title} (${tag.category}).');
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 126,
            transform: Matrix4.identity()..scaleByDouble(_zoneScale, _zoneScale, 1, 1),
            alignment: _zoneAnchor,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[tag.color.withValues(alpha: 0.90), tag.color.withValues(alpha: 0.55)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isActive ? scheme.primary : isHover ? scheme.secondary : scheme.outlineVariant,
                width: isActive ? 2 : 1,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(color: tag.color.withValues(alpha: 0.25), blurRadius: 14, offset: const Offset(0, 6)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(tag.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(tag.category, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const Spacer(),
                  Text('priority ${tag.priority}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _activeTagSummary(ColorScheme scheme) {
    final _RegionTag? tag = _activeZoneTag;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.info_outline, color: scheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: tag == null
                  ? Text('No active tag selected.', style: TextStyle(color: scheme.onSurfaceVariant))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${tag.title} (${tag.category})', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(tag.intent, style: TextStyle(color: scheme.onSurfaceVariant)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStackPrecedenceBoard(ColorScheme scheme) {
    final Size stage = const Size(430, 300);
    final Offset probe = Offset(lerpDouble(50, 360, _stackProbeX) ?? 200, lerpDouble(30, 260, _stackProbeY) ?? 140);

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Stack Precedence', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Overlapping AnnotatedRegion layers visualize precedence. Probe movement shows which annotation resolves first.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget stageWidget = Center(
                  child: SizedBox(
                    width: stage.width,
                    height: stage.height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Stack(
                        children: <Widget>[
                          if (_showGrid)
                            Positioned.fill(
                              child: CustomPaint(
                                painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.20), step: 26),
                              ),
                            ),
                          if (_showBottomLayer)
                            Positioned(
                              left: 80,
                              top: 130,
                              child: _stackLayer(
                                tag: _stackBottomTag,
                                width: _bottomSized ? 250 : 310,
                                height: _bottomSized ? 190 : 230,
                                sized: _bottomSized,
                                scheme: scheme,
                              ),
                            ),
                          if (_showMiddleLayer)
                            Positioned(
                              left: 150,
                              top: 90,
                              child: _stackLayer(
                                tag: _stackMiddleTag,
                                width: _middleSized ? 220 : 310,
                                height: _middleSized ? 150 : 230,
                                sized: _middleSized,
                                scheme: scheme,
                              ),
                            ),
                          if (_showTopLayer)
                            Positioned(
                              left: 230,
                              top: 60,
                              child: _stackLayer(
                                tag: _stackTopTag,
                                width: _topSized ? 170 : 310,
                                height: _topSized ? 120 : 230,
                                sized: _topSized,
                                scheme: scheme,
                              ),
                            ),
                          Positioned(
                            left: probe.dx - 8,
                            top: probe.dy - 8,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: scheme.error,
                                shape: BoxShape.circle,
                                border: Border.all(color: scheme.onError, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                final Widget controls = _stackControls(scheme);

                if (narrow) {
                  return Column(
                    children: <Widget>[
                      stageWidget,
                      const SizedBox(height: 12),
                      controls,
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 7, child: stageWidget),
                    const SizedBox(width: 12),
                    Expanded(flex: 5, child: controls),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _stackLayer({required _RegionTag tag, required double width, required double height, required bool sized, required ColorScheme scheme}) {
    return AnnotatedRegion<_RegionTag>(
      value: tag,
      sized: sized,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: tag.color.withValues(alpha: 0.48),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tag.color.withValues(alpha: 0.88), width: 1.4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(tag.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text('sized=$sized', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stackControls(ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Probe and Layer Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Probe X')),
                Text(_stackProbeX.toStringAsFixed(2)),
              ],
            ),
            Slider(
              value: _stackProbeX,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _stackProbeX = v),
              onChangeEnd: (_) => _resolveStackTag(),
            ),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Probe Y')),
                Text(_stackProbeY.toStringAsFixed(2)),
              ],
            ),
            Slider(
              value: _stackProbeY,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _stackProbeY = v),
              onChangeEnd: (_) => _resolveStackTag(),
            ),
            const Divider(height: 22),
            SwitchListTile(
              value: _showTopLayer,
              title: const Text('Show Top Layer'),
              subtitle: const Text('Highest precedence candidate'),
              onChanged: (bool value) {
                setState(() => _showTopLayer = value);
                _resolveStackTag();
              },
            ),
            SwitchListTile(
              value: _showMiddleLayer,
              title: const Text('Show Middle Layer'),
              subtitle: const Text('Mid precedence candidate'),
              onChanged: (bool value) {
                setState(() => _showMiddleLayer = value);
                _resolveStackTag();
              },
            ),
            SwitchListTile(
              value: _showBottomLayer,
              title: const Text('Show Bottom Layer'),
              subtitle: const Text('Fallback precedence candidate'),
              onChanged: (bool value) {
                setState(() => _showBottomLayer = value);
                _resolveStackTag();
              },
            ),
            const Divider(height: 22),
            CheckboxListTile(
              value: _topSized,
              title: const Text('Top layer sized=true'),
              contentPadding: EdgeInsets.zero,
              onChanged: (bool? value) {
                setState(() {
                  _topSized = value ?? true;
                  _sizedToggleCount += 1;
                });
                _resolveStackTag();
              },
            ),
            CheckboxListTile(
              value: _middleSized,
              title: const Text('Middle layer sized=true'),
              contentPadding: EdgeInsets.zero,
              onChanged: (bool? value) {
                setState(() {
                  _middleSized = value ?? true;
                  _sizedToggleCount += 1;
                });
                _resolveStackTag();
              },
            ),
            CheckboxListTile(
              value: _bottomSized,
              title: const Text('Bottom layer sized=true'),
              contentPadding: EdgeInsets.zero,
              onChanged: (bool? value) {
                setState(() {
                  _bottomSized = value ?? true;
                  _sizedToggleCount += 1;
                });
                _resolveStackTag();
              },
            ),
            const SizedBox(height: 8),
            Text(
              _stackResolvedTag == null
                  ? 'Resolved Tag: none'
                  : 'Resolved Tag: ${_stackResolvedTag!.title} (${_stackResolvedTag!.category})',
              style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizedLabBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Sized Flag Lab', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Compare parallel lanes where annotation widgets use sized=true and sized=false under parent clipping and constrained area differences.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget laneA = _sizedLane(
                  scheme: scheme,
                  title: 'Lane A (sized=true)',
                  subtitle: 'Annotation region tracks child footprint.',
                  sized: true,
                  tag: _zoneTags[3],
                );
                final Widget laneB = _sizedLane(
                  scheme: scheme,
                  title: 'Lane B (sized=false)',
                  subtitle: 'Annotation region can conceptually outlive strict child bounds.',
                  sized: false,
                  tag: _zoneTags[5],
                );
                if (narrow) {
                  return Column(children: <Widget>[laneA, const SizedBox(height: 10), laneB]);
                }
                return Row(children: <Widget>[Expanded(child: laneA), const SizedBox(width: 10), Expanded(child: laneB)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sizedLane({required ColorScheme scheme, required String title, required String subtitle, required bool sized, required _RegionTag tag}) {
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
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 160,
                color: scheme.surface,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.20), step: 18)),
                    ),
                    Positioned(
                      left: 30,
                      top: 22,
                      child: AnnotatedRegion<_RegionTag>(
                        value: tag,
                        sized: sized,
                        child: Container(
                          width: 170,
                          height: 96,
                          decoration: BoxDecoration(
                            color: tag.color.withValues(alpha: 0.44),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: tag.color),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(tag.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                                const Spacer(),
                                Text('sized=$sized', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 16,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: scheme.primaryContainer.withValues(alpha: 0.8),
                          border: Border.all(color: scheme.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              sized
                  ? 'In this lane, metadata follows child extent tightly and behaves as a compact annotated zone.'
                  : 'In this lane, metadata is configured without strict child sizing to illustrate a broader conceptual coverage zone.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorridorBoard(ColorScheme scheme) {
    final List<_RegionTag> corridorTags = <_RegionTag>[
      _zoneTags[0],
      _zoneTags[4],
      _zoneTags[7],
      _zoneTags[3],
      _zoneTags[2],
      _zoneTags[8],
    ];

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Scroll Corridor', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'A horizontal corridor of annotated sections demonstrates metadata context in scroll-heavy compositions.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Density')),
                Text(_corridorDensity.toStringAsFixed(2)),
                const SizedBox(width: 12),
                SizedBox(
                  width: 280,
                  child: Slider(
                    value: _corridorDensity,
                    min: 0.2,
                    max: 1,
                    divisions: 40,
                    onChanged: (double value) => setState(() => _corridorDensity = value),
                    onChangeEnd: (double value) => _pushTimeline('Corridor', 'Density changed to ${value.toStringAsFixed(2)}.'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 192,
              child: ListView.separated(
                controller: _corridorController,
                scrollDirection: Axis.horizontal,
                itemCount: corridorTags.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (BuildContext context, int index) {
                  final _RegionTag tag = corridorTags[index];
                  final bool active = _corridorTag?.id == tag.id;
                  final double width = 170 + (70 * _corridorDensity);
                  return SizedBox(
                    width: width,
                    child: AnnotatedRegion<_RegionTag>(
                      value: tag,
                      sized: true,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _corridorTag = tag;
                          });
                          _pushTimeline('Corridor Tag', 'Selected ${tag.title} in corridor lane.');
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[tag.color.withValues(alpha: 0.92), tag.color.withValues(alpha: 0.55)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: active ? scheme.primary : Colors.white.withValues(alpha: 0.75), width: active ? 2 : 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(tag.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                                const SizedBox(height: 4),
                                Text(tag.category, style: const TextStyle(color: Colors.white70)),
                                const Spacer(),
                                Text('priority ${tag.priority}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      final double target = (_corridorController.offset - 180).clamp(0, _corridorController.position.maxScrollExtent);
                      _corridorController.animateTo(target, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
                      setState(() => _corridorScrollCount += 1);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Scroll Left'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      final double target = (_corridorController.offset + 180).clamp(0, _corridorController.position.maxScrollExtent);
                      _corridorController.animateTo(target, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
                      setState(() => _corridorScrollCount += 1);
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Scroll Right'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticalOverlayBoard(ColorScheme scheme) {
    final _OverlayPreset preset = _overlayPresets[_overlayIndex];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Practical Use: System Overlay Annotation', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'AnnotatedRegion<SystemUiOverlayStyle> is a common practical pattern. This board shows style presets mapped to app-bar-like surfaces.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_overlayPresets.length, (int index) {
                final _OverlayPreset p = _overlayPresets[index];
                return ChoiceChip(
                  selected: _overlayIndex == index,
                  label: Text(p.label),
                  onSelected: (_) {
                    setState(() {
                      _overlayIndex = index;
                      _overlaySwitchCount += 1;
                    });
                    _pushTimeline('Overlay Preset', 'Selected ${p.label}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: preset.style,
              child: Container(
                height: 166,
                decoration: BoxDecoration(
                  color: preset.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.20),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                      ),
                      child: Center(
                        child: Text('Status Area', style: TextStyle(color: Colors.white.withValues(alpha: 0.88), fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          preset.label,
                          style: TextStyle(
                            color: preset.label == 'Dark Icons' ? Colors.black87 : Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(preset.description, style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricItem> metrics = _metrics();
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
                    : constraints.maxWidth > 900
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
                    childAspectRatio: columns == 1 ? 2.7 : 1.92,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricItem item = metrics[index];
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
                                Icon(item.icon, size: 18, color: scheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(item.label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const Spacer(),
                            Text(item.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(item.note, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (_showDiagnostics) const SizedBox(height: 12),
            if (_showDiagnostics) _buildDiagnosticsPanel(scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticsPanel(ColorScheme scheme) {
    final String resolved = _stackResolvedTag == null ? 'none' : '${_stackResolvedTag!.id}/${_stackResolvedTag!.priority}';
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
                Icon(Icons.terminal, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('lane=${_lanes[_laneIndex].id} theme=${_themePresets[_themeIndex].id}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('activeZone=${_activeZoneTag?.id ?? 'none'} hover=${_hoverZoneTag?.id ?? 'none'}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('stackProbe=(${_stackProbeX.toStringAsFixed(2)}, ${_stackProbeY.toStringAsFixed(2)}) resolved=$resolved', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('stackLayers: top($_showTopLayer,$_topSized) mid($_showMiddleLayer,$_middleSized) bottom($_showBottomLayer,$_bottomSized)', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('corridorTag=${_corridorTag?.id ?? 'none'} density=${_corridorDensity.toStringAsFixed(2)} overlay=${_overlayPresets[_overlayIndex].label}', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Guide and Usage Notes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            ..._guideBullets.map((String line) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.circle, size: 8, color: scheme.primary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 22),
            Text('FAQ', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._faq.map(( _FaqItem item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
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
                Text('Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _timeline = const <_TimelineEvent>[]),
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological operational record for annotation interactions and controls.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_timeline.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Text('Timeline is empty. Interact with the atlas controls to generate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _timeline.map(( _TimelineEvent event) {
                  final String stamp =
                      '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer)),
                      ),
                      title: Text(event.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${event.message}', style: TextStyle(color: scheme.onSurfaceVariant)),
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
  _GridPainter({required this.color, required this.step});

  final Color color;
  final double step;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.step != step;
  }
}
