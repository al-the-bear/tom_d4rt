import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show PlatformViewHitTestBehavior;

const _cNavy = Color(0xFF114364);
const _cAmber = Color(0xFFC98A3E);
const _cTeal = Color(0xFF328A79);
const _cRose = Color(0xFF8F4E6C);
const _cViolet = Color(0xFF5E5AA5);
const _cOlive = Color(0xFF6D7135);

dynamic build(BuildContext context) {
  return const _HtmlElementViewDeepDemoApp();
}

class _HtmlElementViewDeepDemoApp extends StatelessWidget {
  const _HtmlElementViewDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cNavy),
        scaffoldBackgroundColor: const Color(0xFFF2F6FA),
      ),
      home: const _HtmlElementViewLabPage(),
    );
  }
}

class _HtmlElementViewLabPage extends StatefulWidget {
  const _HtmlElementViewLabPage();

  @override
  State<_HtmlElementViewLabPage> createState() => _HtmlElementViewLabPageState();
}

class _HtmlElementViewLabPageState extends State<_HtmlElementViewLabPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _rtl = false;
  PlatformViewHitTestBehavior _defaultBehavior = PlatformViewHitTestBehavior.opaque;

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      behavior: _defaultBehavior,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 82,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('HtmlElementView Deep Demo'),
              const SizedBox(height: 2),
              Text(
                kIsWeb ? 'Runtime: Flutter Web (live platform view)' : 'Runtime: non-web (visual simulation mode)',
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
              _ControlDeck(
                compact: _compact,
                showGrid: _showGrid,
                rtl: _rtl,
                behavior: _defaultBehavior,
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGridChanged: (value) => setState(() => _showGrid = value),
                onRtlChanged: (value) => setState(() => _rtl = value),
                onBehaviorChanged: (value) => setState(() => _defaultBehavior = value),
              ),
              const SizedBox(height: 12),
              const _SceneCard(
                index: 1,
                accent: _cNavy,
                title: 'What HtmlElementView Is For',
                subtitle:
                    'HtmlElementView embeds browser DOM content in Flutter Web. It is useful for interoperating with HTML widgets, maps, iframes, and custom web integrations that need direct DOM presence.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: _cAmber,
                title: 'fromTagName Playground',
                subtitle:
                    'Interactive exploration of tagName, isVisible, and hitTestBehavior with live platform-view embedding when running on web.',
                child: _FromTagNamePlayground(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: _cTeal,
                title: 'onElementCreated Lifecycle Lab',
                subtitle:
                    'Tracks creation callbacks and demonstrates element customization timing before DOM attachment.',
                child: _ElementCreatedScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: _cRose,
                title: 'Hit Testing and Overlay Interactions',
                subtitle:
                    'Compares behavior values and surrounding Flutter gestures to explain event routing around HTML-backed views.',
                child: _HitTestOverlayScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: _cViolet,
                title: 'isVisible and Overlay Cost Strategy',
                subtitle:
                    'Visualizes where visible vs invisible HTML views are appropriate and why invisible views can optimize overlay usage.',
                child: _VisibilityStrategyScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: _cOlive,
                title: 'Practical Embedded Workspace',
                subtitle:
                    'A realistic dashboard combining Flutter controls, HTML embed slots, event logs, and explanatory implementation notes.',
                child: _PracticalWorkspaceScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
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
    required this.behavior,
  });

  final bool compact;
  final bool showGrid;
  final TextDirection textDirection;
  final PlatformViewHitTestBehavior behavior;
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.showGrid,
    required this.rtl,
    required this.behavior,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onRtlChanged,
    required this.onBehaviorChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool rtl;
  final PlatformViewHitTestBehavior behavior;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<PlatformViewHitTestBehavior> onBehaviorChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173F66), Color(0xFF2B5F7A), Color(0xFF724C66)],
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
              'Html Embed Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
            ),
            const SizedBox(height: 6),
            Text(
              kIsWeb
                  ? 'Web runtime detected: scenes render actual HtmlElementView instances.'
                  : 'Non-web runtime detected: scenes render faithful visual simulations with same configuration controls and explanations.',
              style: const TextStyle(color: Color(0xFFEAF2FA), height: 1.4),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: compact,
                    onChanged: onCompactChanged,
                    title: const Text('Compact layout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: showGrid,
                    onChanged: onShowGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: rtl,
                    onChanged: onRtlChanged,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            _BehaviorField(value: behavior, onChanged: onBehaviorChanged),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'fromTagName constructor'),
                _DeckTag(label: 'onElementCreated timing'),
                _DeckTag(label: 'isVisible optimization'),
                _DeckTag(label: 'hitTestBehavior routing'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BehaviorField extends StatelessWidget {
  const _BehaviorField({required this.value, required this.onChanged});

  final PlatformViewHitTestBehavior value;
  final ValueChanged<PlatformViewHitTestBehavior> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Default Hit Test Behavior', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<PlatformViewHitTestBehavior>(
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: const Color(0xFF315E79),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: PlatformViewHitTestBehavior.values
                  .map(
                    (entry) => DropdownMenuItem<PlatformViewHitTestBehavior>(
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

class _DeckTag extends StatelessWidget {
  const _DeckTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
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
        const Text('Core points', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          'HtmlElementView is Flutter Web specific at runtime, but its API is available in Flutter widgets. fromTagName creates a DOM element directly and triggers onElementCreated before attachment. hitTestBehavior and isVisible tune interaction and rendering trade-offs.',
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
              _Bullet(text: 'HtmlElementView(viewType: ...) requires a registered platform view factory on web.'),
              _Bullet(text: 'fromTagName is simpler for direct element creation and styling callbacks.'),
              _Bullet(text: 'onElementCreated runs before DOM attach; use it for attributes/styles setup.'),
              _Bullet(text: 'isVisible false can avoid unnecessary overlays for non-painting interceptors.'),
              _Bullet(text: 'Iframes may swallow pointer events due to browser behavior.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _FromTagNamePlayground extends StatefulWidget {
  const _FromTagNamePlayground({required this.config});

  final _DemoConfig config;

  @override
  State<_FromTagNamePlayground> createState() => _FromTagNamePlaygroundState();
}

class _FromTagNamePlaygroundState extends State<_FromTagNamePlayground> {
  String _tag = 'div';
  bool _isVisible = true;
  PlatformViewHitTestBehavior _behavior = PlatformViewHitTestBehavior.opaque;
  int _revision = 0;
  final List<String> _log = <String>[];

  void _logEvent(String message) {
    setState(() {
      _log.insert(0, '${_time()} | $message');
      if (_log.length > 16) {
        _log.removeRange(16, _log.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double stageHeight = config.compact ? 320 : 390;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...const <String>['div', 'section', 'article', 'aside', 'button'].map(
              (entry) => ChoiceChip(
                selected: _tag == entry,
                label: Text(entry),
                onSelected: (_) => setState(() => _tag = entry),
              ),
            ),
            FilterChip(
              selected: _isVisible,
              label: const Text('isVisible'),
              onSelected: (value) => setState(() => _isVisible = value),
            ),
            _ActionButton(
              label: 'Recreate view',
              color: _cAmber,
              onPressed: () => setState(() => _revision += 1),
            ),
            _ActionButton(
              label: 'Clear log',
              color: _cNavy,
              onPressed: () => setState(_log.clear),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _BehaviorField(
                value: _behavior,
                onChanged: (entry) => setState(() => _behavior = entry),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: _panelBox(),
                child: Text(
                  'tag=$_tag | isVisible=$_isVisible | behavior=${_behavior.name} | revision=$_revision',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
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
                        const Text('Live embed panel', style: TextStyle(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FBFF),
                                border: Border.all(color: const Color(0xFFD7E2ED)),
                              ),
                              child: _buildHtmlOrMock(
                                key: ValueKey<String>('$_tag-$_isVisible-${_behavior.name}-$_revision'),
                                tag: _tag,
                                isVisible: _isVisible,
                                behavior: _behavior,
                                label: 'Playground',
                                onElementCreated: (element) {
                                  _styleElement(element, label: 'Playground $_tag');
                                  _logEvent('onElementCreated tag=$_tag type=${element.runtimeType}');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(title: 'fromTagName log', events: _log)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ElementCreatedScene extends StatefulWidget {
  const _ElementCreatedScene({required this.config});

  final _DemoConfig config;

  @override
  State<_ElementCreatedScene> createState() => _ElementCreatedSceneState();
}

class _ElementCreatedSceneState extends State<_ElementCreatedScene> {
  bool _decorate = true;
  bool _isVisible = true;
  int _revision = 0;
  final List<String> _events = <String>[];

  void _push(String entry) {
    setState(() {
      _events.insert(0, '${_time()} | $entry');
      if (_events.length > 18) {
        _events.removeRange(18, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double height = config.compact ? 360 : 430;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              selected: _decorate,
              label: const Text('Decorate element in callback'),
              onSelected: (value) => setState(() => _decorate = value),
            ),
            FilterChip(
              selected: _isVisible,
              label: const Text('isVisible'),
              onSelected: (value) => setState(() => _isVisible = value),
            ),
            _ActionButton(
              label: 'Recreate all',
              color: _cTeal,
              onPressed: () => setState(() => _revision += 1),
            ),
            _ActionButton(
              label: 'Clear log',
              color: _cNavy,
              onPressed: () => setState(_events.clear),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: height,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: 6,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: config.compact ? 2 : 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.05,
                      ),
                      itemBuilder: (context, index) {
                        final tag = index.isEven ? 'div' : 'section';
                        final title = 'Slot ${index + 1}';
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFD6E2ED)),
                              color: Colors.white,
                            ),
                            child: _buildHtmlOrMock(
                              key: ValueKey<String>('el-$index-$_revision-$_decorate-$_isVisible'),
                              tag: tag,
                              isVisible: _isVisible,
                              behavior: config.behavior,
                              label: title,
                              onElementCreated: (element) {
                                if (_decorate) {
                                  _styleElement(element, label: title);
                                }
                                _push('$title created type=${element.runtimeType} decorated=$_decorate');
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(title: 'onElementCreated log', events: _events)),
            ],
          ),
        ),
      ],
    );
  }
}

class _HitTestOverlayScene extends StatefulWidget {
  const _HitTestOverlayScene({required this.config});

  final _DemoConfig config;

  @override
  State<_HitTestOverlayScene> createState() => _HitTestOverlaySceneState();
}

class _HitTestOverlaySceneState extends State<_HitTestOverlayScene> {
  PlatformViewHitTestBehavior _behavior = PlatformViewHitTestBehavior.opaque;
  bool _pointerShield = false;
  int _flutterTapCount = 0;
  final List<String> _events = <String>[];

  void _push(String text) {
    setState(() {
      _events.insert(0, '${_time()} | $text');
      if (_events.length > 18) {
        _events.removeRange(18, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double h = config.compact ? 340 : 410;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...PlatformViewHitTestBehavior.values.map(
              (entry) => ChoiceChip(
                selected: _behavior == entry,
                label: Text(entry.name),
                onSelected: (_) => setState(() => _behavior = entry),
              ),
            ),
            FilterChip(
              selected: _pointerShield,
              label: const Text('IgnorePointer shield'),
              onSelected: (value) => setState(() => _pointerShield = value),
            ),
            _ActionButton(
              label: 'Clear log',
              color: _cRose,
              onPressed: () => setState(() {
                _events.clear();
                _flutterTapCount = 0;
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Flutter taps: $_flutterTapCount', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        SizedBox(
          height: h,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFD6ECFB), Color(0xFFF2E2EA)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 22,
                          top: 22,
                          right: 22,
                          bottom: 70,
                          child: IgnorePointer(
                            ignoring: _pointerShield,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFB8CDE0), width: 1.2),
                              ),
                              child: _buildHtmlOrMock(
                                tag: 'div',
                                isVisible: true,
                                behavior: _behavior,
                                label: 'HitTest zone',
                                onElementCreated: (element) {
                                  _styleElement(element, label: 'HitTest zone');
                                  _push('onElementCreated hit-test zone');
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 18,
                          bottom: 16,
                          child: FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: _cRose, foregroundColor: Colors.white),
                            onPressed: () {
                              setState(() => _flutterTapCount += 1);
                              _push('Flutter button tap');
                            },
                            child: const Text('Flutter control A'),
                          ),
                        ),
                        Positioned(
                          right: 18,
                          bottom: 16,
                          child: FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: _cNavy, foregroundColor: Colors.white),
                            onPressed: () {
                              setState(() => _flutterTapCount += 1);
                              _push('Flutter button tap B');
                            },
                            child: const Text('Flutter control B'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(title: 'Hit test log', events: _events)),
            ],
          ),
        ),
      ],
    );
  }
}

class _VisibilityStrategyScene extends StatefulWidget {
  const _VisibilityStrategyScene({required this.config});

  final _DemoConfig config;

  @override
  State<_VisibilityStrategyScene> createState() => _VisibilityStrategySceneState();
}

class _VisibilityStrategySceneState extends State<_VisibilityStrategyScene> {
  bool _showVisibleLane = true;
  bool _showInvisibleLane = true;
  final List<String> _events = <String>[];

  void _push(String line) {
    setState(() {
      _events.insert(0, '${_time()} | $line');
      if (_events.length > 18) {
        _events.removeRange(18, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double h = config.compact ? 390 : 470;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              selected: _showVisibleLane,
              label: const Text('Render visible lane'),
              onSelected: (value) => setState(() => _showVisibleLane = value),
            ),
            FilterChip(
              selected: _showInvisibleLane,
              label: const Text('Render invisible lane'),
              onSelected: (value) => setState(() => _showInvisibleLane = value),
            ),
            _ActionButton(
              label: 'Clear log',
              color: _cViolet,
              onPressed: () => setState(_events.clear),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: h,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _lane(
                    title: 'Visible lane (isVisible: true)',
                    subtitle: 'Use for elements that actually paint pixels (maps, chart DOM, rich embeds).',
                    cards: _visibleCards,
                    enabled: _showVisibleLane,
                    isVisible: true,
                    onEvent: _push,
                    behavior: config.behavior,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _lane(
                    title: 'Invisible lane (isVisible: false)',
                    subtitle: 'Use for non-painting platform overlays like interceptors or structural hooks.',
                    cards: _invisibleCards,
                    enabled: _showInvisibleLane,
                    isVisible: false,
                    onEvent: _push,
                    behavior: config.behavior,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(title: 'Visibility strategy log', events: _events)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _lane({
    required String title,
    required String subtitle,
    required List<_LaneCard> cards,
    required bool enabled,
    required bool isVisible,
    required ValueChanged<String> onEvent,
    required PlatformViewHitTestBehavior behavior,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF566979), height: 1.3)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: cards.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final card = cards[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFD9E4EE)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(card.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      Text(card.note, style: const TextStyle(fontSize: 12, color: Color(0xFF4F6272))),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 74,
                        child: enabled
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _buildHtmlOrMock(
                                  tag: card.tag,
                                  isVisible: isVisible,
                                  behavior: behavior,
                                  label: card.title,
                                  onElementCreated: (element) {
                                    _styleElement(element, label: card.title);
                                    onEvent('created ${card.title} isVisible=$isVisible');
                                  },
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8EEF4),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFD1DCE7)),
                                ),
                                alignment: Alignment.center,
                                child: const Text('Lane disabled', style: TextStyle(fontWeight: FontWeight.w700)),
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticalWorkspaceScene extends StatefulWidget {
  const _PracticalWorkspaceScene({required this.config});

  final _DemoConfig config;

  @override
  State<_PracticalWorkspaceScene> createState() => _PracticalWorkspaceSceneState();
}

class _PracticalWorkspaceSceneState extends State<_PracticalWorkspaceScene> {
  int _selected = 0;
  bool _renderSlots = true;
  bool _pointerPassThrough = false;
  final List<String> _events = <String>[];

  void _push(String event) {
    setState(() {
      _events.insert(0, '${_time()} | $event');
      if (_events.length > 24) {
        _events.removeRange(24, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final section = _workspaceSections[_selected];
    final double h = config.compact ? 510 : 620;

    return SizedBox(
      height: h,
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
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _workspaceSections.length,
                        (index) => ChoiceChip(
                          selected: _selected == index,
                          label: Text(_workspaceSections[index].title),
                          onSelected: (_) => setState(() => _selected = index),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: section.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: section.color.withValues(alpha: 0.35)),
                      ),
                      child: Text(section.description, style: const TextStyle(fontWeight: FontWeight.w700, height: 1.34)),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _renderSlots,
                          label: const Text('Render HTML slots'),
                          onSelected: (value) => setState(() => _renderSlots = value),
                        ),
                        FilterChip(
                          selected: _pointerPassThrough,
                          label: const Text('Pointer pass-through mode'),
                          onSelected: (value) => setState(() => _pointerPassThrough = value),
                        ),
                        _ActionButton(
                          label: 'Clear log',
                          color: section.color,
                          onPressed: () => setState(_events.clear),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: section.entries.length,
                              separatorBuilder: (_, _) => const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final entry = section.entries[index];
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: const Color(0xFFD9E4EE)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(entry.icon, size: 18, color: section.color),
                                          const SizedBox(width: 6),
                                          Expanded(child: Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w800))),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(entry.note, style: const TextStyle(fontSize: 12, color: Color(0xFF4E6272), height: 1.3)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFD6E2ED)),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Preview board', style: TextStyle(fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 6),
                                  Expanded(
                                    child: GridView.builder(
                                      itemCount: section.entries.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 1.02,
                                      ),
                                      itemBuilder: (context, index) {
                                        final entry = section.entries[index];
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xFFD7E2ED)),
                                              color: const Color(0xFFF7FAFE),
                                            ),
                                            child: _renderSlots
                                                ? IgnorePointer(
                                                    ignoring: _pointerPassThrough,
                                                    child: _buildHtmlOrMock(
                                                      tag: entry.tag,
                                                      isVisible: entry.visible,
                                                      behavior: _pointerPassThrough
                                                          ? PlatformViewHitTestBehavior.transparent
                                                          : config.behavior,
                                                      label: entry.title,
                                                      onElementCreated: (element) {
                                                        _styleElement(element, label: entry.title);
                                                        _push('created ${entry.title} tag=${entry.tag} visible=${entry.visible}');
                                                      },
                                                    ),
                                                  )
                                                : Container(
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      'Slot disabled',
                                                      style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF4E6272)),
                                                    ),
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
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
          Expanded(child: _EventLog(title: 'Workspace log', events: _events)),
        ],
      ),
    );
  }
}

class _WorkspaceSection {
  const _WorkspaceSection({
    required this.title,
    required this.description,
    required this.color,
    required this.entries,
  });

  final String title;
  final String description;
  final Color color;
  final List<_WorkspaceEntry> entries;
}

class _WorkspaceEntry {
  const _WorkspaceEntry({
    required this.title,
    required this.note,
    required this.icon,
    required this.tag,
    required this.visible,
  });

  final String title;
  final String note;
  final IconData icon;
  final String tag;
  final bool visible;
}

class _LaneCard {
  const _LaneCard({required this.title, required this.note, required this.tag});

  final String title;
  final String note;
  final String tag;
}

const List<_LaneCard> _visibleCards = <_LaneCard>[
  _LaneCard(title: 'Map embed', note: 'Visible HTML map tile surface.', tag: 'section'),
  _LaneCard(title: 'Chart canvas', note: 'Visible chart DOM host area.', tag: 'article'),
  _LaneCard(title: 'Media card', note: 'Visible media content shell.', tag: 'div'),
  _LaneCard(title: 'Partner widget', note: 'Visible external integration slot.', tag: 'aside'),
  _LaneCard(title: 'Preview tile', note: 'Visible preview renderer.', tag: 'section'),
  _LaneCard(title: 'Status board', note: 'Visible metrics board.', tag: 'div'),
];

const List<_LaneCard> _invisibleCards = <_LaneCard>[
  _LaneCard(title: 'Pointer interceptor', note: 'No pixels, event routing aid.', tag: 'div'),
  _LaneCard(title: 'Link bridge', note: 'Structural anchor without paint.', tag: 'span'),
  _LaneCard(title: 'Gesture shim', note: 'Support layer for gesture integration.', tag: 'div'),
  _LaneCard(title: 'Focus trap host', note: 'Accessibility and focus utility shell.', tag: 'section'),
  _LaneCard(title: 'Overlay sentinel', note: 'Coordinates overlay bookkeeping.', tag: 'article'),
  _LaneCard(title: 'Event channel slot', note: 'Message bridge point without visuals.', tag: 'div'),
];

const List<_WorkspaceSection> _workspaceSections = <_WorkspaceSection>[
  _WorkspaceSection(
    title: 'Marketing Studio',
    description: 'Compose campaign widgets where some slots render branded HTML and others serve invisible interaction bridges.',
    color: _cNavy,
    entries: <_WorkspaceEntry>[
      _WorkspaceEntry(title: 'Hero Banner', note: 'Rendered HTML banner surface.', icon: Icons.image, tag: 'section', visible: true),
      _WorkspaceEntry(title: 'CTA Layer', note: 'Interactive bridge around CTA area.', icon: Icons.touch_app, tag: 'div', visible: false),
      _WorkspaceEntry(title: 'Media Slot', note: 'Video or media host slot.', icon: Icons.movie, tag: 'article', visible: true),
      _WorkspaceEntry(title: 'Anchor Layer', note: 'Non-painting link shim.', icon: Icons.link, tag: 'span', visible: false),
    ],
  ),
  _WorkspaceSection(
    title: 'Operations Board',
    description: 'Balance visible telemetry embeds with invisible coordination layers for robust routing and overlay efficiency.',
    color: _cTeal,
    entries: <_WorkspaceEntry>[
      _WorkspaceEntry(title: 'Metrics Pane', note: 'Rendered HTML metrics block.', icon: Icons.query_stats, tag: 'section', visible: true),
      _WorkspaceEntry(title: 'Drag Proxy', note: 'Invisible drag interaction shim.', icon: Icons.drag_indicator, tag: 'div', visible: false),
      _WorkspaceEntry(title: 'Alert Feed', note: 'Rendered event feed shell.', icon: Icons.notifications_active, tag: 'article', visible: true),
      _WorkspaceEntry(title: 'Focus Utility', note: 'Invisible keyboard focus helper.', icon: Icons.keyboard, tag: 'div', visible: false),
    ],
  ),
  _WorkspaceSection(
    title: 'Partner Integrations',
    description: 'Demonstrates mixed third-party widgets where explicit visibility control can prevent unnecessary overlay pressure.',
    color: _cOlive,
    entries: <_WorkspaceEntry>[
      _WorkspaceEntry(title: 'Partner Card', note: 'Rendered third-party card slot.', icon: Icons.handshake, tag: 'section', visible: true),
      _WorkspaceEntry(title: 'Adapter Bridge', note: 'Invisible adapter interface shell.', icon: Icons.settings_ethernet, tag: 'div', visible: false),
      _WorkspaceEntry(title: 'Geo Widget', note: 'Rendered location element host.', icon: Icons.map, tag: 'article', visible: true),
      _WorkspaceEntry(title: 'Event Relay', note: 'Invisible relay node for events.', icon: Icons.swap_horiz, tag: 'div', visible: false),
    ],
  ),
  _WorkspaceSection(
    title: 'Design Review',
    description: 'Prototype board that compares rendered visuals and invisible helper slots while preserving Flutter-first layout controls.',
    color: _cRose,
    entries: <_WorkspaceEntry>[
      _WorkspaceEntry(title: 'Prototype Panel', note: 'Rendered visual surface.', icon: Icons.palette, tag: 'section', visible: true),
      _WorkspaceEntry(title: 'Hover Shim', note: 'Invisible hover capture assist.', icon: Icons.ads_click, tag: 'div', visible: false),
      _WorkspaceEntry(title: 'Demo Block', note: 'Rendered sample panel.', icon: Icons.slideshow, tag: 'article', visible: true),
      _WorkspaceEntry(title: 'Telemetry Hook', note: 'Invisible instrumentation host.', icon: Icons.track_changes, tag: 'div', visible: false),
    ],
  ),
];

Widget _buildHtmlOrMock({
  Key? key,
  required String tag,
  required bool isVisible,
  required PlatformViewHitTestBehavior behavior,
  required String label,
  required ValueChanged<Object> onElementCreated,
}) {
  if (!kIsWeb) {
    return _NonWebHtmlMock(key: key, tag: tag, isVisible: isVisible, behavior: behavior, label: label);
  }

  return HtmlElementView.fromTagName(
    key: key,
    tagName: tag,
    isVisible: isVisible,
    hitTestBehavior: behavior,
    onElementCreated: onElementCreated,
  );
}

void _styleElement(Object element, {required String label}) {
  if (!kIsWeb) {
    return;
  }
  final dynamic e = element;
  try {
    e.text = 'HTML $label';
  } catch (_) {}
  try {
    e.innerText = 'HTML $label';
  } catch (_) {}
  try {
    e.setAttribute('data-label', label);
  } catch (_) {}
  try {
    e.style.background = 'linear-gradient(135deg, rgba(66,116,156,0.16), rgba(207,141,159,0.18))';
    e.style.border = '1px solid rgba(118,146,170,0.52)';
    e.style.borderRadius = '10px';
    e.style.padding = '8px';
    e.style.display = 'flex';
    e.style.alignItems = 'center';
    e.style.justifyContent = 'center';
    e.style.fontFamily = 'monospace';
    e.style.fontSize = '12px';
    e.style.color = '#294258';
  } catch (_) {}
}

String _time() => DateTime.now().toIso8601String().substring(11, 19);

class _NonWebHtmlMock extends StatelessWidget {
  const _NonWebHtmlMock({
    super.key,
    required this.tag,
    required this.isVisible,
    required this.behavior,
    required this.label,
  });

  final String tag;
  final bool isVisible;
  final PlatformViewHitTestBehavior behavior;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isVisible ? const Color(0xFFE3EFFA) : const Color(0xFFE9EEF3),
            isVisible ? const Color(0xFFF8E9EF) : const Color(0xFFF1F3F5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // The mock content has a natural height of ~140 px but several call
      // sites embed it in a SizedBox as small as 74 px (e.g. the visibility
      // lane cards). Wrap the inner card in FittedBox(scaleDown) so it
      // shrinks to fit the available height instead of triggering a
      // RenderFlex bottom overflow.
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD9E6)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.web, size: 20, color: Color(0xFF43627B)),
                const SizedBox(height: 4),
                Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('Mock HtmlElementView<$tag>', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 2),
                Text('isVisible=$isVisible | behavior=${behavior.name}', style: const TextStyle(fontSize: 11, color: Color(0xFF536779))),
                const SizedBox(height: 4),
                const Text('Non-web runtime simulation', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF405A70))),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
          colors: [Color(0xFFF9FCFF), Color(0xFFECF3F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD7E2ED)),
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
    const double step = 22;
    final paint = Paint()..color = const Color(0x11000000);
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
            child: Icon(Icons.circle, size: 7, color: Color(0xFF36536D)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
        ],
      ),
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
        color: const Color(0xFFFCFDFF),
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

BoxDecoration _panelBox({Color color = const Color(0xFFF2F7FC), Color border = const Color(0xFFD6E2EE)}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: border),
  );
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

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
            'Recap: HtmlElementView',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use HtmlElementView when browser-native DOM integration is required. Prefer fromTagName for direct element creation, configure onElementCreated for setup, choose hitTestBehavior intentionally, and apply isVisible=false only for non-painting utility views to keep web overlay usage efficient.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.4),
          ),
        ],
      ),
    );
  }
}
