import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _navy = Color(0xFF1E4E75);
const _amber = Color(0xFFC57B35);
const _teal = Color(0xFF277E71);
const _rose = Color(0xFF92466A);
const _indigo = Color(0xFF5653A0);
const _olive = Color(0xFF6B682D);

dynamic build(BuildContext context) {
  return const _FadeInImageDeepDemoApp();
}

class _FadeInImageDeepDemoApp extends StatelessWidget {
  const _FadeInImageDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _navy),
        useMaterial3: true,
      ),
      home: const _FadeInImageDemoPage(),
    );
  }
}

class _FadeInImageDemoPage extends StatefulWidget {
  const _FadeInImageDemoPage();

  @override
  State<_FadeInImageDemoPage> createState() => _FadeInImageDemoPageState();
}

class _FadeInImageDemoPageState extends State<_FadeInImageDemoPage> {
  late final Future<_GeneratedImages> _imagesFuture;

  bool _rtl = false;
  bool _compact = false;
  bool _showGrid = true;

  double _loaderDelayMs = 900;
  double _fadeOutMs = 300;
  double _fadeInMs = 800;

  _CurveChoice _fadeOutCurve = _CurveChoice.easeOut;
  _CurveChoice _fadeInCurve = _CurveChoice.easeIn;

  @override
  void initState() {
    super.initState();
    _imagesFuture = _GeneratedImages.create();
  }

  @override
  Widget build(BuildContext context) {
    final config = _GlobalFadeConfig(
      compact: _compact,
      showGrid: _showGrid,
      loaderDelay: Duration(milliseconds: _loaderDelayMs.round()),
      fadeOutDuration: Duration(milliseconds: _fadeOutMs.round()),
      fadeInDuration: Duration(milliseconds: _fadeInMs.round()),
      fadeOutCurve: _fadeOutCurve.curve,
      fadeInCurve: _fadeInCurve.curve,
    );

    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          backgroundColor: _navy,
          foregroundColor: Colors.white,
          toolbarHeight: 78,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('FadeInImage Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl ? 'Ambient direction: RTL' : 'Ambient direction: LTR',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: FutureBuilder<_GeneratedImages>(
          future: _imagesFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 12),
                    Text('Generating synthetic image assets for demo scenes...'),
                  ],
                ),
              );
            }

            final images = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroDeck(
                    rtl: _rtl,
                    compact: _compact,
                    showGrid: _showGrid,
                    loaderDelayMs: _loaderDelayMs,
                    fadeOutMs: _fadeOutMs,
                    fadeInMs: _fadeInMs,
                    fadeOutCurve: _fadeOutCurve,
                    fadeInCurve: _fadeInCurve,
                    onRtlChanged: (value) => setState(() => _rtl = value),
                    onCompactChanged: (value) => setState(() => _compact = value),
                    onShowGridChanged: (value) => setState(() => _showGrid = value),
                    onLoaderDelayChanged: (value) => setState(() => _loaderDelayMs = value),
                    onFadeOutChanged: (value) => setState(() => _fadeOutMs = value),
                    onFadeInChanged: (value) => setState(() => _fadeInMs = value),
                    onFadeOutCurveChanged: (value) => setState(() => _fadeOutCurve = value),
                    onFadeInCurveChanged: (value) => setState(() => _fadeInCurve = value),
                  ),
                  const SizedBox(height: 12),
                  _ScenePanel(
                    index: 1,
                    accent: _navy,
                    title: 'Core Behavior Overview',
                    subtitle:
                        'FadeInImage shows a placeholder first, then fades placeholder out while fading the target image in when it resolves.',
                    child: _ConceptScene(images: images, config: config),
                  ),
                  const SizedBox(height: 12),
                  _ScenePanel(
                    index: 2,
                    accent: _amber,
                    title: 'Timing And Curve Lab',
                    subtitle:
                        'Tune loading delay and fade durations/curves to understand visual feel and transition pacing.',
                    child: _TimingLabScene(images: images, config: config),
                  ),
                  const SizedBox(height: 12),
                  _ScenePanel(
                    index: 3,
                    accent: _teal,
                    title: 'Error Builder Paths',
                    subtitle:
                        'Demonstrates placeholderErrorBuilder and imageErrorBuilder while keeping the UI stable and informative.',
                    child: _ErrorBuilderScene(images: images, config: config),
                  ),
                  const SizedBox(height: 12),
                  _ScenePanel(
                    index: 4,
                    accent: _rose,
                    title: 'Gapless Playback Switching',
                    subtitle:
                        'Switch target providers rapidly while retaining continuity; previous image remains until the next one is ready.',
                    child: _GaplessPlaybackScene(images: images, config: config),
                  ),
                  const SizedBox(height: 12),
                  _ScenePanel(
                    index: 5,
                    accent: _indigo,
                    title: 'Constructors And Visual Variants',
                    subtitle:
                        'Compare direct constructor usage with memoryNetwork and assetNetwork style scenarios, plus fit/color semantics.',
                    child: _ConstructorAndStylingScene(images: images, config: config),
                  ),
                  const SizedBox(height: 12),
                  _ScenePanel(
                    index: 6,
                    accent: _olive,
                    title: 'Practical Pattern: Story Feed Cards',
                    subtitle:
                        'A realistic feed of cards uses FadeInImage with unique delays and placeholders to avoid abrupt pops while scrolling.',
                    child: _PracticalFeedScene(images: images, config: config),
                  ),
                  const SizedBox(height: 12),
                  const _RecapCard(),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GlobalFadeConfig {
  const _GlobalFadeConfig({
    required this.compact,
    required this.showGrid,
    required this.loaderDelay,
    required this.fadeOutDuration,
    required this.fadeInDuration,
    required this.fadeOutCurve,
    required this.fadeInCurve,
  });

  final bool compact;
  final bool showGrid;
  final Duration loaderDelay;
  final Duration fadeOutDuration;
  final Duration fadeInDuration;
  final Curve fadeOutCurve;
  final Curve fadeInCurve;
}

enum _CurveChoice {
  linear('Linear', Curves.linear),
  easeOut('Ease Out', Curves.easeOut),
  easeIn('Ease In', Curves.easeIn),
  easeInOut('Ease In Out', Curves.easeInOut),
  fastOutSlowIn('Fast Out Slow In', Curves.fastOutSlowIn),
  easeOutBack('Ease Out Back', Curves.easeOutBack);

  const _CurveChoice(this.label, this.curve);

  final String label;
  final Curve curve;
}

class _HeroDeck extends StatelessWidget {
  const _HeroDeck({
    required this.rtl,
    required this.compact,
    required this.showGrid,
    required this.loaderDelayMs,
    required this.fadeOutMs,
    required this.fadeInMs,
    required this.fadeOutCurve,
    required this.fadeInCurve,
    required this.onRtlChanged,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onLoaderDelayChanged,
    required this.onFadeOutChanged,
    required this.onFadeInChanged,
    required this.onFadeOutCurveChanged,
    required this.onFadeInCurveChanged,
  });

  final bool rtl;
  final bool compact;
  final bool showGrid;
  final double loaderDelayMs;
  final double fadeOutMs;
  final double fadeInMs;
  final _CurveChoice fadeOutCurve;
  final _CurveChoice fadeInCurve;

  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<double> onLoaderDelayChanged;
  final ValueChanged<double> onFadeOutChanged;
  final ValueChanged<double> onFadeInChanged;
  final ValueChanged<_CurveChoice> onFadeOutCurveChanged;
  final ValueChanged<_CurveChoice> onFadeInCurveChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E4E75), Color(0xFF426A87), Color(0xFF714D67)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fade Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
          ),
          const SizedBox(height: 8),
          const Text(
            'Control loader delay and transition timings globally, then compare how each scene interprets the same FadeInImage settings.',
            style: TextStyle(color: Color(0xFFF4F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGrid,
                  onChanged: onShowGridChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Synthetic image load delay: ${loaderDelayMs.toStringAsFixed(0)} ms',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: loaderDelayMs,
            min: 0,
            max: 2200,
            divisions: 22,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onLoaderDelayChanged,
          ),
          Text(
            'Placeholder fade-out duration: ${fadeOutMs.toStringAsFixed(0)} ms',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: fadeOutMs,
            min: 80,
            max: 1400,
            divisions: 22,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onFadeOutChanged,
          ),
          Text(
            'Target fade-in duration: ${fadeInMs.toStringAsFixed(0)} ms',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: fadeInMs,
            min: 80,
            max: 1800,
            divisions: 28,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onFadeInChanged,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _CurveDropdown(
                  title: 'Fade out curve',
                  value: fadeOutCurve,
                  onChanged: onFadeOutCurveChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CurveDropdown(
                  title: 'Fade in curve',
                  value: fadeInCurve,
                  onChanged: onFadeInCurveChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _DeckTag(label: 'FadeInImage(placeholder, image)'),
              _DeckTag(label: 'placeholderErrorBuilder + imageErrorBuilder'),
              _DeckTag(label: 'fadeOutDuration/fadeInDuration and curves'),
              _DeckTag(label: 'gapless playback when provider changes'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurveDropdown extends StatelessWidget {
  const _CurveDropdown({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final _CurveChoice value;
  final ValueChanged<_CurveChoice> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        ),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<_CurveChoice>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF3B5D79),
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: _CurveChoice.values
                  .map(
                    (choice) => DropdownMenuItem<_CurveChoice>(
                      value: choice,
                      child: Text(choice.label, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (selected) {
                if (selected != null) {
                  onChanged(selected);
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _ScenePanel extends StatelessWidget {
  const _ScenePanel({
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
                      Text(subtitle, style: const TextStyle(height: 1.4, color: Color(0xFF2F3B45))),
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

class _ConceptScene extends StatefulWidget {
  const _ConceptScene({required this.images, required this.config});

  final _GeneratedImages images;
  final _GlobalFadeConfig config;

  @override
  State<_ConceptScene> createState() => _ConceptSceneState();
}

class _ConceptSceneState extends State<_ConceptScene> {
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final imageBytes = widget.images.targets[_imageIndex % widget.images.targets.length];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [
            _LegendDot(color: _navy, label: 'Placeholder visible first'),
            _LegendDot(color: _rose, label: 'Target fades in over placeholder'),
            _LegendDot(color: _teal, label: 'Error builders can rescue failures'),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Tap next image to replay the transition. The target provider is intentionally delayed to make fading behavior obvious.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _ActionButton(
              label: 'Next image',
              color: _navy,
              onPressed: () => setState(() => _imageIndex += 1),
            ),
            const SizedBox(width: 8),
            Text('Current slot: ${_imageIndex % widget.images.targets.length}'),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 170 : 220,
          child: _GuideStage(
            showGrid: widget.config.showGrid,
            child: Center(
              child: _DemoFrame(
                label: 'Baseline FadeInImage',
                child: FadeInImage(
                  placeholder: MemoryImage(widget.images.placeholder),
                  image: _DelayedMemoryImage(
                    bytes: imageBytes,
                    delay: widget.config.loaderDelay,
                    id: 'concept-image-${_imageIndex % widget.images.targets.length}',
                  ),
                  width: 260,
                  height: 160,
                  fit: BoxFit.cover,
                  fadeOutDuration: widget.config.fadeOutDuration,
                  fadeOutCurve: widget.config.fadeOutCurve,
                  fadeInDuration: widget.config.fadeInDuration,
                  fadeInCurve: widget.config.fadeInCurve,
                  placeholderFit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimingLabScene extends StatefulWidget {
  const _TimingLabScene({required this.images, required this.config});

  final _GeneratedImages images;
  final _GlobalFadeConfig config;

  @override
  State<_TimingLabScene> createState() => _TimingLabSceneState();
}

class _TimingLabSceneState extends State<_TimingLabScene> {
  int _seed = 0;
  BoxFit _fit = BoxFit.cover;
  BoxFit _placeholderFit = BoxFit.contain;

  @override
  Widget build(BuildContext context) {
    final target = widget.images.targets[_seed % widget.images.targets.length];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(label: 'Replay', color: _amber, onPressed: () => setState(() => _seed += 1)),
            _ActionButton(
              label: 'fit: ${_fit.name}',
              color: _teal,
              onPressed: () {
                setState(() {
                  _fit = _fit == BoxFit.cover ? BoxFit.contain : BoxFit.cover;
                });
              },
            ),
            _ActionButton(
              label: 'placeholderFit: ${_placeholderFit.name}',
              color: _rose,
              onPressed: () {
                setState(() {
                  _placeholderFit = _placeholderFit == BoxFit.cover ? BoxFit.contain : BoxFit.cover;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Target delay ${widget.config.loaderDelay.inMilliseconds}ms | fadeOut ${widget.config.fadeOutDuration.inMilliseconds}ms | fadeIn ${widget.config.fadeInDuration.inMilliseconds}ms',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 180 : 245,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: widget.config.showGrid,
                  child: Center(
                    child: _DemoFrame(
                      label: 'Default blend',
                      child: FadeInImage(
                        placeholder: MemoryImage(widget.images.placeholder),
                        image: _DelayedMemoryImage(bytes: target, delay: widget.config.loaderDelay, id: 'timing-a-$_seed'),
                        width: 220,
                        height: 140,
                        fit: _fit,
                        placeholderFit: _placeholderFit,
                        fadeOutDuration: widget.config.fadeOutDuration,
                        fadeOutCurve: widget.config.fadeOutCurve,
                        fadeInDuration: widget.config.fadeInDuration,
                        fadeInCurve: widget.config.fadeInCurve,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GuideStage(
                  showGrid: widget.config.showGrid,
                  child: Center(
                    child: _DemoFrame(
                      label: 'Tinted placeholder and target',
                      child: FadeInImage(
                        placeholder: MemoryImage(widget.images.placeholderAlt),
                        image: _DelayedMemoryImage(bytes: target, delay: widget.config.loaderDelay, id: 'timing-b-$_seed'),
                        width: 220,
                        height: 140,
                        fit: _fit,
                        placeholderFit: _placeholderFit,
                        fadeOutDuration: widget.config.fadeOutDuration,
                        fadeOutCurve: widget.config.fadeOutCurve,
                        fadeInDuration: widget.config.fadeInDuration,
                        fadeInCurve: widget.config.fadeInCurve,
                        color: const Color(0x80FFFFFF),
                        colorBlendMode: BlendMode.modulate,
                        placeholderColor: const Color(0x7F5A6C7A),
                        placeholderColorBlendMode: BlendMode.srcATop,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorBuilderScene extends StatefulWidget {
  const _ErrorBuilderScene({required this.images, required this.config});

  final _GeneratedImages images;
  final _GlobalFadeConfig config;

  @override
  State<_ErrorBuilderScene> createState() => _ErrorBuilderSceneState();
}

class _ErrorBuilderSceneState extends State<_ErrorBuilderScene> {
  bool _breakPlaceholder = false;
  bool _breakTarget = false;
  int _tick = 0;

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object> placeholderProvider = _breakPlaceholder
        ? _FailingImageProvider(id: 'placeholder-fail-$_tick')
        : MemoryImage(widget.images.placeholder);

    final ImageProvider<Object> imageProvider = _breakTarget
        ? _FailingImageProvider(id: 'target-fail-$_tick')
        : _DelayedMemoryImage(
            bytes: widget.images.targets[_tick % widget.images.targets.length],
            delay: widget.config.loaderDelay,
            id: 'error-scene-target-$_tick',
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _breakPlaceholder ? 'Placeholder: FAIL' : 'Placeholder: OK',
              color: _teal,
              onPressed: () => setState(() => _breakPlaceholder = !_breakPlaceholder),
            ),
            _ActionButton(
              label: _breakTarget ? 'Target: FAIL' : 'Target: OK',
              color: _rose,
              onPressed: () => setState(() => _breakTarget = !_breakTarget),
            ),
            _ActionButton(
              label: 'Rebuild',
              color: _navy,
              onPressed: () => setState(() => _tick += 1),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Toggle failures to see how each error builder can render fallback visuals without breaking page layout.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 170 : 220,
          child: _GuideStage(
            showGrid: widget.config.showGrid,
            child: Center(
              child: _DemoFrame(
                label: 'Error-resilient FadeInImage',
                child: FadeInImage(
                  placeholder: placeholderProvider,
                  image: imageProvider,
                  width: 260,
                  height: 160,
                  fit: BoxFit.cover,
                  fadeOutDuration: widget.config.fadeOutDuration,
                  fadeOutCurve: widget.config.fadeOutCurve,
                  fadeInDuration: widget.config.fadeInDuration,
                  fadeInCurve: widget.config.fadeInCurve,
                  placeholderErrorBuilder: (context, error, stackTrace) {
                    return _ErrorTile(
                      color: _amber,
                      title: 'Placeholder error',
                      detail: error.toString(),
                    );
                  },
                  imageErrorBuilder: (context, error, stackTrace) {
                    return _ErrorTile(
                      color: _rose,
                      title: 'Target image error',
                      detail: error.toString(),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GaplessPlaybackScene extends StatefulWidget {
  const _GaplessPlaybackScene({required this.images, required this.config});

  final _GeneratedImages images;
  final _GlobalFadeConfig config;

  @override
  State<_GaplessPlaybackScene> createState() => _GaplessPlaybackSceneState();
}

class _GaplessPlaybackSceneState extends State<_GaplessPlaybackScene> {
  int _targetIndex = 0;
  bool _rapidMode = false;

  @override
  void initState() {
    super.initState();
    _runRapidTicker();
  }

  Future<void> _runRapidTicker() async {
    while (mounted) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      if (!mounted || !_rapidMode) {
        continue;
      }
      setState(() {
        _targetIndex += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final target = widget.images.targets[_targetIndex % widget.images.targets.length];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'Next provider',
              color: _rose,
              onPressed: () => setState(() => _targetIndex += 1),
            ),
            _ActionButton(
              label: _rapidMode ? 'Rapid switching: ON' : 'Rapid switching: OFF',
              color: _indigo,
              onPressed: () => setState(() => _rapidMode = !_rapidMode),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'With provider changes, the old loaded image remains visible until the next delayed provider resolves, avoiding blank flashes.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 190 : 240,
          child: _GuideStage(
            showGrid: widget.config.showGrid,
            child: Center(
              child: _DemoFrame(
                label: 'Gapless playback behavior',
                child: FadeInImage(
                  placeholder: MemoryImage(widget.images.placeholder),
                  image: _DelayedMemoryImage(
                    bytes: target,
                    delay: widget.config.loaderDelay,
                    id: 'gapless-image-${_targetIndex % widget.images.targets.length}',
                  ),
                  width: 300,
                  height: 180,
                  fit: BoxFit.cover,
                  fadeOutDuration: widget.config.fadeOutDuration,
                  fadeOutCurve: widget.config.fadeOutCurve,
                  fadeInDuration: widget.config.fadeInDuration,
                  fadeInCurve: widget.config.fadeInCurve,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConstructorAndStylingScene extends StatefulWidget {
  const _ConstructorAndStylingScene({required this.images, required this.config});

  final _GeneratedImages images;
  final _GlobalFadeConfig config;

  @override
  State<_ConstructorAndStylingScene> createState() => _ConstructorAndStylingSceneState();
}

class _ConstructorAndStylingSceneState extends State<_ConstructorAndStylingScene> {
  int _nonce = 0;
  bool _matchTextDirection = false;

  @override
  Widget build(BuildContext context) {
    final current = widget.images.targets[_nonce % widget.images.targets.length];
    final placeholder = widget.images.placeholder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'Replay visuals',
              color: _indigo,
              onPressed: () => setState(() => _nonce += 1),
            ),
            _ActionButton(
              label: _matchTextDirection ? 'matchTextDirection: true' : 'matchTextDirection: false',
              color: _teal,
              onPressed: () => setState(() => _matchTextDirection = !_matchTextDirection),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 250 : 320,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: widget.config.showGrid,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Direct constructor', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      FadeInImage(
                        placeholder: MemoryImage(placeholder),
                        image: _DelayedMemoryImage(bytes: current, delay: widget.config.loaderDelay, id: 'direct-$_nonce'),
                        width: 200,
                        height: 120,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        repeat: ImageRepeat.noRepeat,
                        matchTextDirection: _matchTextDirection,
                        fadeOutDuration: widget.config.fadeOutDuration,
                        fadeOutCurve: widget.config.fadeOutCurve,
                        fadeInDuration: widget.config.fadeInDuration,
                        fadeInCurve: widget.config.fadeInCurve,
                      ),
                      const SizedBox(height: 8),
                      const Text('Uses direct ImageProvider objects.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GuideStage(
                  showGrid: widget.config.showGrid,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('memoryNetwork constructor', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 200,
                        height: 120,
                        child: FadeInImage.memoryNetwork(
                          placeholder: placeholder,
                          image: 'https://invalid.localhost.example/non-existent-image.jpg',
                          fit: BoxFit.cover,
                          fadeOutDuration: widget.config.fadeOutDuration,
                          fadeOutCurve: widget.config.fadeOutCurve,
                          fadeInDuration: widget.config.fadeInDuration,
                          fadeInCurve: widget.config.fadeInCurve,
                          placeholderColor: const Color(0x665C707D),
                          placeholderColorBlendMode: BlendMode.srcATop,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return _ErrorTile(
                              color: _indigo,
                              title: 'memoryNetwork target failed',
                              detail: 'Fallback confirms constructor wiring.',
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Useful when placeholder bytes are available in memory.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GuideStage(
                  showGrid: widget.config.showGrid,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('assetNetwork constructor', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 200,
                        height: 120,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/does_not_exist_placeholder.png',
                          image: 'https://invalid.localhost.example/asset-network-target.jpg',
                          fit: BoxFit.cover,
                          fadeOutDuration: widget.config.fadeOutDuration,
                          fadeOutCurve: widget.config.fadeOutCurve,
                          fadeInDuration: widget.config.fadeInDuration,
                          fadeInCurve: widget.config.fadeInCurve,
                          placeholderErrorBuilder: (context, error, stackTrace) {
                            return _ErrorTile(
                              color: _amber,
                              title: 'assetNetwork placeholder failed',
                              detail: 'Use placeholderErrorBuilder for robust fallbacks.',
                            );
                          },
                          imageErrorBuilder: (context, error, stackTrace) {
                            return _ErrorTile(
                              color: _rose,
                              title: 'assetNetwork target failed',
                              detail: 'Network fallback path handled too.',
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Useful for asset placeholders plus remote targets.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PracticalFeedScene extends StatefulWidget {
  const _PracticalFeedScene({required this.images, required this.config});

  final _GeneratedImages images;
  final _GlobalFadeConfig config;

  @override
  State<_PracticalFeedScene> createState() => _PracticalFeedSceneState();
}

class _PracticalFeedSceneState extends State<_PracticalFeedScene> {
  final List<_FeedItem> _items = const [
    _FeedItem('Dawn Dock', 'Subtle morning gradients for launch banners.'),
    _FeedItem('Forest Pulse', 'Green-heavy palette for sustainability reports.'),
    _FeedItem('Skyline Data', 'Cool tones with geometric accents for dashboards.'),
    _FeedItem('Crimson Notes', 'Warm punchy visuals for alert stories.'),
    _FeedItem('Indigo Memory', 'Night-mode inspired placeholder transitions.'),
    _FeedItem('Olive Archive', 'Muted editorial cards for long-form pieces.'),
  ];

  int _refreshSeed = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'Refresh cards',
              color: _olive,
              onPressed: () => setState(() => _refreshSeed += 1),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Each feed card uses a slightly different delay and fade profile to avoid synchronized popping while scrolling through content.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 300 : 390,
          child: _GuideStage(
            showGrid: widget.config.showGrid,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: _items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = _items[index];
                final target = widget.images.targets[(index + _refreshSeed) % widget.images.targets.length];
                final delay = widget.config.loaderDelay + Duration(milliseconds: index * 120);

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFD9E3EE)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: FadeInImage(
                          placeholder: MemoryImage(widget.images.placeholder),
                          image: _DelayedMemoryImage(bytes: target, delay: delay, id: 'feed-$index-$_refreshSeed'),
                          width: 120,
                          height: 90,
                          fit: BoxFit.cover,
                          fadeOutDuration: widget.config.fadeOutDuration,
                          fadeOutCurve: widget.config.fadeOutCurve,
                          fadeInDuration: widget.config.fadeInDuration,
                          fadeInCurve: widget.config.fadeInCurve,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 4),
                              Text(item.subtitle, style: const TextStyle(height: 1.3, color: Color(0xFF4A5B6B))),
                              const SizedBox(height: 6),
                              Text(
                                'Delay ${delay.inMilliseconds}ms | FadeIn ${widget.config.fadeInDuration.inMilliseconds}ms',
                                style: const TextStyle(fontSize: 12, color: Color(0xFF697D8F)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _FeedItem {
  const _FeedItem(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

class _DemoFrame extends StatelessWidget {
  const _DemoFrame({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD8E2EC)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _ErrorTile extends StatelessWidget {
  const _ErrorTile({
    required this.color,
    required this.title,
    required this.detail,
  });

  final Color color;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.42)),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, color: color),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
          const SizedBox(height: 2),
          Text(detail, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 9, height: 9, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
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

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF7FBFF), Color(0xFFEAF2F8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD4E0EB)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid)
            CustomPaint(
              painter: _GridPainter(),
            ),
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

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF10273C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap: FadeInImage in practice',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use FadeInImage when target images may arrive late and abrupt replacement would hurt perceived quality. Combine cached placeholders, tuned fade durations, and explicit error builders for stable user-facing loading experiences.',
            style: TextStyle(color: Color(0xFFD9E5F1), height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _GeneratedImages {
  const _GeneratedImages({
    required this.placeholder,
    required this.placeholderAlt,
    required this.targets,
  });

  final Uint8List placeholder;
  final Uint8List placeholderAlt;
  final List<Uint8List> targets;

  static Future<_GeneratedImages> create() async {
    final placeholder = await _createSwatch(
      primary: const Color(0xFFCDD9E4),
      secondary: const Color(0xFF9EAFC0),
      accent: const Color(0xFF7F93A8),
      index: 0,
    );

    final placeholderAlt = await _createSwatch(
      primary: const Color(0xFFE4D3C9),
      secondary: const Color(0xFFC6A88D),
      accent: const Color(0xFF8E6E57),
      index: 1,
    );

    final targets = <Uint8List>[];
    final palette = <(Color, Color, Color)>[
      (const Color(0xFF5AA8E8), const Color(0xFF1B6FC2), const Color(0xFF0F3E75)),
      (const Color(0xFF64C77E), const Color(0xFF3C9C54), const Color(0xFF246838)),
      (const Color(0xFFE0A25A), const Color(0xFFC67632), const Color(0xFF7D4A1F)),
      (const Color(0xFFCD6D8E), const Color(0xFFA1456A), const Color(0xFF6B2C48)),
      (const Color(0xFF8B8FEA), const Color(0xFF5F63C7), const Color(0xFF3B3F84)),
      (const Color(0xFFC5B65E), const Color(0xFF95893C), const Color(0xFF635B27)),
    ];

    for (int i = 0; i < palette.length; i += 1) {
      final entry = palette[i];
      final image = await _createSwatch(
        primary: entry.$1,
        secondary: entry.$2,
        accent: entry.$3,
        index: i + 2,
      );
      targets.add(image);
    }

    return _GeneratedImages(
      placeholder: placeholder,
      placeholderAlt: placeholderAlt,
      targets: targets,
    );
  }

  static Future<Uint8List> _createSwatch({
    required Color primary,
    required Color secondary,
    required Color accent,
    required int index,
  }) async {
    const size = 360;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()));

    final baseRect = Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble());
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primary, secondary],
    );

    canvas.drawRect(baseRect, Paint()..shader = gradient.createShader(baseRect));

    final stripePaint = Paint()..color = accent.withValues(alpha: 0.35);
    for (int i = -size; i < size * 2; i += 28) {
      canvas.drawRect(Rect.fromLTWH(i.toDouble(), 0, 12, size.toDouble()), stripePaint);
    }

    final orbitPaint = Paint()..color = Colors.white.withValues(alpha: 0.22);
    for (int i = 0; i < 7; i += 1) {
      final t = (i + index * 0.35) / 7;
      final x = 20 + t * 320;
      final y = 60 + math.sin((t + index * 0.08) * math.pi * 2) * 42 + i * 28;
      canvas.drawCircle(Offset(x, y), 20 + i * 2, orbitPaint);
    }

    final badgePaint = Paint()..color = accent.withValues(alpha: 0.72);
    final path = Path()
      ..moveTo(40, 280)
      ..lineTo(120, 220)
      ..lineTo(180, 290)
      ..lineTo(230, 250)
      ..lineTo(315, 330)
      ..lineTo(40, 330)
      ..close();
    canvas.drawPath(path, badgePaint);

    final picture = recorder.endRecording();
    final image = await picture.toImage(size, size);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}

class _DelayedMemoryImage extends ImageProvider<_DelayedMemoryImage> {
  const _DelayedMemoryImage({
    required this.bytes,
    required this.delay,
    required this.id,
  });

  final Uint8List bytes;
  final Duration delay;
  final String id;

  @override
  Future<_DelayedMemoryImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_DelayedMemoryImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(_DelayedMemoryImage key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: 1,
      debugLabel: 'DelayedMemoryImage($id)',
    );
  }

  Future<ui.Codec> _loadAsync(_DelayedMemoryImage key, ImageDecoderCallback decode) async {
    assert(key == this);
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    return decode(buffer);
  }

  @override
  bool operator ==(Object other) {
    return other is _DelayedMemoryImage && other.id == id && other.delay == delay;
  }

  @override
  int get hashCode => Object.hash(id, delay);
}

class _FailingImageProvider extends ImageProvider<_FailingImageProvider> {
  const _FailingImageProvider({required this.id});

  final String id;

  @override
  Future<_FailingImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_FailingImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(_FailingImageProvider key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(
      Future<ImageInfo>.error(
        StateError('Synthetic image failure: $id'),
      ),
      informationCollector: () sync* {
        yield DiagnosticsProperty<String>('failingImageProvider', id);
      },
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FailingImageProvider && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
