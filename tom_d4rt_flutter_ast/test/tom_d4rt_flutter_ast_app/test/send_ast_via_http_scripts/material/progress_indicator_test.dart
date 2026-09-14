// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo gallery - Material ProgressIndicator family.
//
// This file is a hand-authored, harness-safe demonstration of the Material
// `ProgressIndicator` family. It exercises the abstract base class together
// with its three concrete subclasses:
//
//   - `CircularProgressIndicator`
//   - `LinearProgressIndicator`
//   - `RefreshProgressIndicator`
//
// and shows how `ProgressIndicatorTheme` plus `ProgressIndicatorThemeData`
// hoist defaults to a sub-tree.
//
// HARNESS CONTRACT
// -----------------
// The script exposes a single top-level `dynamic build(BuildContext context)`
// returning a `MaterialApp`. There is no `main()` and no `runApp()` and no
// `testWidgets()` invocation. The harness mounts the returned widget tree
// into its own host scaffold; this file simply describes the UI.
//
// ANIMATION STRATEGY
// ------------------
// Determinate live progress is driven by a long-lived `ValueNotifier<double>`
// per section. A `WidgetsBinding.instance.addPostFrameCallback` recursively
// schedules the next frame, advancing each notifier's value by a small delta
// modulo 1.0. Each section then uses a `StatefulBuilder` whose `setState` is
// triggered by a listener attached to its notifier inside the builder. This
// gives the page a real, visible animation loop without involving a
// `TickerProvider` (which is unavailable in this harness because we cannot
// declare a `StatefulWidget` of our own and mix in `SingleTickerProviderState`
// at the top level - the harness wants `dynamic build(BuildContext context)`,
// not a widget class).
//
// Indeterminate indicators animate themselves automatically once they are
// mounted, so they require no driver from us at all.
//
// For non-time-dependent demonstrations we use `AnimatedBuilder` listening to
// a `ValueNotifier` so the progress value passed into the indicator updates
// every frame.
import 'package:flutter/material.dart';

// =============================================================================
// MODULE-LEVEL ANIMATION DRIVERS
// -----------------------------------------------------------------------------
// These notifiers are created exactly once at module load. Each section that
// wants to display a live moving progress bar listens to one of them. The
// `_kicked` flag ensures the recursive frame loop is started exactly once
// even if `build` is invoked more than once for the same page.
// =============================================================================
final ValueNotifier<double> _slowProgress = ValueNotifier<double>(0.0);
final ValueNotifier<double> _mediumProgress = ValueNotifier<double>(0.0);
final ValueNotifier<double> _fastProgress = ValueNotifier<double>(0.0);
final ValueNotifier<double> _bounceProgress = ValueNotifier<double>(0.0);

bool _kicked = false;

void _kickAnimationLoop() {
  if (_kicked) {
    return;
  }
  _kicked = true;

  void tick(Duration _) {
    final double slowNext = (_slowProgress.value + 0.005) % 1.0001;
    final double mediumNext = (_mediumProgress.value + 0.012) % 1.0001;
    final double fastNext = (_fastProgress.value + 0.024) % 1.0001;
    // Bounce ranges 0->1->0 using sawtooth doubled.
    final double bounceRaw = (_bounceProgress.value + 0.018) % 2.0;
    final double bounceMapped = bounceRaw <= 1.0 ? bounceRaw : 2.0 - bounceRaw;

    _slowProgress.value = slowNext > 1.0 ? 0.0 : slowNext;
    _mediumProgress.value = mediumNext > 1.0 ? 0.0 : mediumNext;
    _fastProgress.value = fastNext > 1.0 ? 0.0 : fastNext;
    _bounceProgress.value = bounceMapped;

    // Schedule next frame.
    WidgetsBinding.instance.addPostFrameCallback(tick);
  }

  WidgetsBinding.instance.addPostFrameCallback(tick);
}

// =============================================================================
// PALETTE
// -----------------------------------------------------------------------------
// Each section picks from this palette so the gallery has visual variety.
// Colors deliberately avoid relying on `Theme.of(context)` so that the demo
// looks identical regardless of the harness theme.
// =============================================================================
const Color _palette1Surface = Color(0xFFE8F1FE);
const Color _palette1Border = Color(0xFFB5D0F5);
const Color _palette1Tint = Color(0xFF1A73E8);

const Color _palette2Surface = Color(0xFFFFF3E0);
const Color _palette2Border = Color(0xFFFFCC80);
const Color _palette2Tint = Color(0xFFEF6C00);

const Color _palette3Surface = Color(0xFFE8F5E9);
const Color _palette3Border = Color(0xFFA5D6A7);
const Color _palette3Tint = Color(0xFF2E7D32);

const Color _palette4Surface = Color(0xFFF3E5F5);
const Color _palette4Border = Color(0xFFCE93D8);
const Color _palette4Tint = Color(0xFF6A1B9A);

const Color _palette5Surface = Color(0xFFFFEBEE);
const Color _palette5Border = Color(0xFFEF9A9A);
const Color _palette5Tint = Color(0xFFC62828);

const Color _palette6Surface = Color(0xFFE0F7FA);
const Color _palette6Border = Color(0xFF80DEEA);
const Color _palette6Tint = Color(0xFF00838F);

const Color _palette7Surface = Color(0xFFEDE7F6);
const Color _palette7Border = Color(0xFFB39DDB);
const Color _palette7Tint = Color(0xFF4527A0);

const Color _palette8Surface = Color(0xFFFFFDE7);
const Color _palette8Border = Color(0xFFFFE082);
const Color _palette8Tint = Color(0xFFF57F17);

const Color _palette9Surface = Color(0xFFE0F2F1);
const Color _palette9Border = Color(0xFF80CBC4);
const Color _palette9Tint = Color(0xFF00695C);

const Color _palette10Surface = Color(0xFFFCE4EC);
const Color _palette10Border = Color(0xFFF48FB1);
const Color _palette10Tint = Color(0xFFAD1457);

const Color _palette11Surface = Color(0xFFECEFF1);
const Color _palette11Border = Color(0xFFB0BEC5);
const Color _palette11Tint = Color(0xFF37474F);

const Color _palette12Surface = Color(0xFFF1F8E9);
const Color _palette12Border = Color(0xFFC5E1A5);
const Color _palette12Tint = Color(0xFF558B2F);

// =============================================================================
// ENTRY POINT
// =============================================================================
dynamic build(BuildContext context) {
  // Start the recursive frame ticker. Safe to call multiple times.
  _kickAnimationLoop();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _palette1Tint,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _galleryHeader(),
              const SizedBox(height: 20.0),
              _section1IndeterminateCircular(),
              const SizedBox(height: 16.0),
              _section2DeterminateCircular(),
              const SizedBox(height: 16.0),
              _section3IndeterminateLinear(),
              const SizedBox(height: 16.0),
              _section4DeterminateLinear(),
              const SizedBox(height: 16.0),
              _section5ColorCustomization(),
              const SizedBox(height: 16.0),
              _section6CircularStrokeAndCap(),
              const SizedBox(height: 16.0),
              _section7LinearShapeOptions(),
              const SizedBox(height: 16.0),
              _section8Material3Options(),
              const SizedBox(height: 16.0),
              _section9RefreshProgressIndicator(),
              const SizedBox(height: 16.0),
              _section10ProgressIndicatorTheme(),
              const SizedBox(height: 16.0),
              _section11SizedVariants(),
              const SizedBox(height: 16.0),
              _section12EmbeddedInButtons(),
              const SizedBox(height: 16.0),
              _section13DecisionGuide(),
              const SizedBox(height: 24.0),
              _galleryFooter(),
              const SizedBox(height: 12.0),
              const Center(
                child: Text(
                  'Material ProgressIndicator - live deep demo gallery',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF8E8E93)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HEADER
// =============================================================================
Widget _galleryHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF1A73E8), Color(0xFF6A1B9A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ProgressIndicator',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Abstract base + Circular + Linear + Refresh + Theme',
          style: TextStyle(fontSize: 14.0, color: Color(0xFFE5E5F0)),
        ),
        SizedBox(height: 4.0),
        Text(
          'Thirteen live sections covering every common API surface',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFFEBE9F7),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1 - DEFAULT INDETERMINATE CIRCULAR
// =============================================================================
Widget _section1IndeterminateCircular() {
  return _sectionCard(
    surface: _palette1Surface,
    border: _palette1Border,
    tint: _palette1Tint,
    number: '1',
    title: 'Indeterminate CircularProgressIndicator',
    description:
        'A bare `CircularProgressIndicator()` with no `value` runs an '
        'indeterminate animation. Use this when you do not know how long the '
        'work will take. The widget owns its own ticker, so it animates as '
        'soon as it is mounted.',
    caption:
        'API: CircularProgressIndicator() - no value means indeterminate.',
    body: StatefulBuilder(
      builder: (ctx, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: CircularProgressIndicator(
                    semanticsLabel: 'loading',
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'default',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _palette1Tint,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: CircularProgressIndicator(
                    color: _palette1Tint,
                    backgroundColor: Color(0xFFD7E5FB),
                    semanticsLabel: 'loading content',
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'tinted',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _palette1Tint,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  width: 64.0,
                  height: 64.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 6.0,
                    color: _palette1Tint,
                    backgroundColor: Color(0x331A73E8),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'thicker',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _palette1Tint,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 2 - DETERMINATE CIRCULAR (LIVE VALUE)
// =============================================================================
Widget _section2DeterminateCircular() {
  return _sectionCard(
    surface: _palette2Surface,
    border: _palette2Border,
    tint: _palette2Tint,
    number: '2',
    title: 'Determinate CircularProgressIndicator (live)',
    description:
        'When you pass `value`, the indicator becomes determinate. The arc '
        'sweeps from 0 to value*2*pi. This card drives the `value` from a '
        'live `ValueNotifier<double>` that loops 0->1 every couple of seconds.',
    caption:
        'API: CircularProgressIndicator(value: 0..1, color, backgroundColor).',
    body: AnimatedBuilder(
      animation: _slowProgress,
      builder: (ctx, _) {
        final double v = _slowProgress.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 56.0,
                  height: 56.0,
                  child: CircularProgressIndicator(
                    value: v,
                    color: _palette2Tint,
                    backgroundColor: const Color(0xFFFFE0B2),
                    semanticsLabel: 'download progress',
                    // Flutter's debug-mode `_semanticsProgressBar` validator
                    // parses semanticsValue as a number (no "%"). Match the
                    // built-in default formatter from progress_indicator.dart.
                    semanticsValue: '${(v * 100).round()}',
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${(v * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: _palette2Tint,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 56.0,
                  height: 56.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 56.0,
                        height: 56.0,
                        child: CircularProgressIndicator(
                          value: v,
                          color: _palette2Tint,
                          backgroundColor: const Color(0xFFFFE0B2),
                          strokeWidth: 6.0,
                        ),
                      ),
                      Text(
                        '${(v * 100).round()}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: _palette2Tint,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'with label',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _palette2Tint,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 64.0,
                  height: 64.0,
                  child: CircularProgressIndicator(
                    value: v,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      _palette2Tint,
                    ),
                    backgroundColor: const Color(0xFFFFE0B2),
                    strokeWidth: 8.0,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'rounded cap',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _palette2Tint,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 3 - DEFAULT INDETERMINATE LINEAR
// =============================================================================
Widget _section3IndeterminateLinear() {
  return _sectionCard(
    surface: _palette3Surface,
    border: _palette3Border,
    tint: _palette3Tint,
    number: '3',
    title: 'Indeterminate LinearProgressIndicator',
    description:
        'A bare `LinearProgressIndicator()` paints a track and a moving '
        'highlight. Use it for top-of-screen busy bars or banners while '
        'background work runs of unknown length.',
    caption: 'API: LinearProgressIndicator() - no value -> indeterminate.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'default height',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: _palette3Tint,
          ),
        ),
        const SizedBox(height: 6.0),
        const LinearProgressIndicator(
          color: _palette3Tint,
          backgroundColor: Color(0xFFC8E6C9),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'tall (minHeight: 10)',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: _palette3Tint,
          ),
        ),
        const SizedBox(height: 6.0),
        const LinearProgressIndicator(
          minHeight: 10.0,
          color: _palette3Tint,
          backgroundColor: Color(0xFFC8E6C9),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'rounded',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: _palette3Tint,
          ),
        ),
        const SizedBox(height: 6.0),
        const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: LinearProgressIndicator(
            minHeight: 14.0,
            color: _palette3Tint,
            backgroundColor: Color(0xFFC8E6C9),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4 - DETERMINATE LINEAR (LIVE VALUE)
// =============================================================================
Widget _section4DeterminateLinear() {
  return _sectionCard(
    surface: _palette4Surface,
    border: _palette4Border,
    tint: _palette4Tint,
    number: '4',
    title: 'Determinate LinearProgressIndicator (live)',
    description:
        'When `value` is a known fraction in [0, 1], the bar fills exactly. '
        'Three live bars below run at three different speeds, all driven by '
        'the same tick callback.',
    caption: 'API: LinearProgressIndicator(value: 0..1).',
    body: AnimatedBuilder(
      animation: Listenable.merge([
        _slowProgress,
        _mediumProgress,
        _fastProgress,
      ]),
      builder: (ctx, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _liveLinearRow(
              label: 'slow',
              value: _slowProgress.value,
              tint: _palette4Tint,
              track: const Color(0xFFE1BEE7),
            ),
            const SizedBox(height: 12.0),
            _liveLinearRow(
              label: 'medium',
              value: _mediumProgress.value,
              tint: _palette4Tint,
              track: const Color(0xFFE1BEE7),
            ),
            const SizedBox(height: 12.0),
            _liveLinearRow(
              label: 'fast',
              value: _fastProgress.value,
              tint: _palette4Tint,
              track: const Color(0xFFE1BEE7),
            ),
          ],
        );
      },
    ),
  );
}

Widget _liveLinearRow({
  required String label,
  required double value,
  required Color tint,
  required Color track,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: 56.0,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            color: tint,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Expanded(
        child: LinearProgressIndicator(
          value: value,
          color: tint,
          backgroundColor: track,
          minHeight: 8.0,
        ),
      ),
      const SizedBox(width: 8.0),
      SizedBox(
        width: 44.0,
        child: Text(
          '${(value * 100).round()}%',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 11.0,
            color: tint,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 5 - COLOR CUSTOMIZATION
// =============================================================================
Widget _section5ColorCustomization() {
  return _sectionCard(
    surface: _palette5Surface,
    border: _palette5Border,
    tint: _palette5Tint,
    number: '5',
    title: 'Color customization (color, valueColor, backgroundColor)',
    description:
        'The base class exposes three color parameters: `color`, '
        '`valueColor` (an `Animation<Color?>` that wins over `color`), and '
        '`backgroundColor` (the track behind the bar/arc). Use `valueColor` '
        'when you need to animate the indicator color over time.',
    caption: 'AlwaysStoppedAnimation<Color> is the simplest valueColor.',
    body: AnimatedBuilder(
      animation: _mediumProgress,
      builder: (ctx, _) {
        final double v = _mediumProgress.value;
        // Interpolate the valueColor between two tints.
        final Color animatedColor =
            Color.lerp(_palette5Tint, _palette4Tint, v)!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'color only',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette5Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            const LinearProgressIndicator(
              value: 0.65,
              color: _palette5Tint,
              backgroundColor: Color(0xFFFFCDD2),
              minHeight: 8.0,
            ),
            const SizedBox(height: 14.0),
            const Text(
              'valueColor (AlwaysStoppedAnimation<Color>)',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette5Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: 0.45,
              valueColor: const AlwaysStoppedAnimation<Color>(
                _palette5Tint,
              ),
              backgroundColor: const Color(0xFFFFCDD2),
              minHeight: 8.0,
            ),
            const SizedBox(height: 14.0),
            Text(
              'valueColor animated -> ${_describeColor(animatedColor)}',
              style: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette5Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: v,
              valueColor: AlwaysStoppedAnimation<Color>(animatedColor),
              backgroundColor: const Color(0xFFFFCDD2),
              minHeight: 8.0,
            ),
            const SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: CircularProgressIndicator(
                    value: v,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(animatedColor),
                    backgroundColor: const Color(0xFFFFCDD2),
                  ),
                ),
                const SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: CircularProgressIndicator(
                    color: _palette5Tint,
                    backgroundColor: Color(0xFFFFCDD2),
                  ),
                ),
                const SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _palette4Tint,
                    ),
                    backgroundColor: Color(0xFFFFCDD2),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

String _describeColor(Color c) {
  return 'rgb(${c.red}, ${c.green}, ${c.blue})';
}

// =============================================================================
// SECTION 6 - CIRCULAR STROKE WIDTH AND CAP
// =============================================================================
Widget _section6CircularStrokeAndCap() {
  return _sectionCard(
    surface: _palette6Surface,
    border: _palette6Border,
    tint: _palette6Tint,
    number: '6',
    title: 'Circular: strokeWidth, strokeAlign, strokeCap',
    description:
        '`strokeWidth` is the thickness of the arc in logical pixels. '
        '`strokeAlign` (-1 inside, 0 center, 1 outside) shifts the arc '
        'relative to the layout box. `strokeCap` (butt, round, square) '
        'controls the end-cap shape.',
    caption: 'Try mixing strokeAlign and strokeCap for chunky modern looks.',
    body: AnimatedBuilder(
      animation: _bounceProgress,
      builder: (ctx, _) {
        final double v = _bounceProgress.value;
        return Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            _circularSpec(
              caption: 'sw 2',
              value: v,
              strokeWidth: 2.0,
            ),
            _circularSpec(
              caption: 'sw 4 (default)',
              value: v,
              strokeWidth: 4.0,
            ),
            _circularSpec(
              caption: 'sw 8',
              value: v,
              strokeWidth: 8.0,
            ),
            _circularSpec(
              caption: 'sw 12 round',
              value: v,
              strokeWidth: 12.0,
              cap: StrokeCap.round,
            ),
            _circularSpec(
              caption: 'sw 8 square',
              value: v,
              strokeWidth: 8.0,
              cap: StrokeCap.square,
            ),
            _circularSpec(
              caption: 'align -1',
              value: v,
              strokeWidth: 6.0,
              align: -1.0,
            ),
            _circularSpec(
              caption: 'align 0',
              value: v,
              strokeWidth: 6.0,
              align: 0.0,
            ),
            _circularSpec(
              caption: 'align 1',
              value: v,
              strokeWidth: 6.0,
              align: 1.0,
            ),
          ],
        );
      },
    ),
  );
}

Widget _circularSpec({
  required String caption,
  required double value,
  required double strokeWidth,
  StrokeCap? cap,
  double? align,
}) {
  return Column(
    children: [
      SizedBox(
        width: 56.0,
        height: 56.0,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth,
          strokeCap: cap,
          strokeAlign: align ?? 0.0,
          color: _palette6Tint,
          backgroundColor: const Color(0xFFB2EBF2),
        ),
      ),
      const SizedBox(height: 6.0),
      SizedBox(
        width: 80.0,
        child: Text(
          caption,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.5,
            fontFamily: 'monospace',
            color: _palette6Tint,
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 7 - LINEAR SHAPE OPTIONS
// =============================================================================
Widget _section7LinearShapeOptions() {
  return _sectionCard(
    surface: _palette7Surface,
    border: _palette7Border,
    tint: _palette7Tint,
    number: '7',
    title: 'Linear: minHeight + borderRadius',
    description:
        '`minHeight` controls the bar thickness. `borderRadius` (a '
        '`BorderRadiusGeometry`) rounds the bar corners (Material 3). For '
        'Material 2 fall back to wrapping the bar in `ClipRRect`.',
    caption: 'borderRadius is honoured natively in Material 3.',
    body: AnimatedBuilder(
      animation: _mediumProgress,
      builder: (ctx, _) {
        final double v = _mediumProgress.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'minHeight: 4 (default)',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette7Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: v,
              color: _palette7Tint,
              backgroundColor: const Color(0xFFD1C4E9),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'minHeight: 12, borderRadius: 6 (M3)',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette7Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: v,
              minHeight: 12.0,
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              color: _palette7Tint,
              backgroundColor: const Color(0xFFD1C4E9),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'minHeight: 20, borderRadius: 10 (pill)',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette7Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: v,
              minHeight: 20.0,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: _palette7Tint,
              backgroundColor: const Color(0xFFD1C4E9),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'asymmetric corners',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette7Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: v,
              minHeight: 16.0,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                topRight: Radius.circular(2.0),
                bottomRight: Radius.circular(2.0),
              ),
              color: _palette7Tint,
              backgroundColor: const Color(0xFFD1C4E9),
            ),
          ],
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 8 - MATERIAL 3 OPTIONS (year2023, trackGap, stop indicators)
// =============================================================================
Widget _section8Material3Options() {
  return _sectionCard(
    surface: _palette8Surface,
    border: _palette8Border,
    tint: _palette8Tint,
    number: '8',
    title: 'Material 3 options (year2023, trackGap, stopIndicator)',
    description:
        'Setting `year2023: false` opts in to the latest Material 3 visuals: '
        'a track gap between the active and inactive segments and a stop '
        'indicator dot at the trailing edge. Use `trackGap`, '
        '`stopIndicatorColor`, and `stopIndicatorRadius` to customise.',
    caption:
        'These props are no-ops if year2023 is true (the legacy default).',
    body: AnimatedBuilder(
      animation: _mediumProgress,
      builder: (ctx, _) {
        final double v = _mediumProgress.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'year2023 (legacy)',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette8Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: v,
              minHeight: 10.0,
              color: _palette8Tint,
              backgroundColor: const Color(0xFFFFE082),
            ),
            const SizedBox(height: 14.0),
            const Text(
              'year2023: false, trackGap: 4, stopIndicatorRadius: 3',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette8Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: v,
              minHeight: 10.0,
              year2023: false,
              trackGap: 4.0,
              stopIndicatorColor: _palette8Tint,
              stopIndicatorRadius: 3.0,
              color: _palette8Tint,
              backgroundColor: const Color(0xFFFFE082),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            const SizedBox(height: 14.0),
            const Text(
              'year2023: false, trackGap: 8, stopIndicatorRadius: 5',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _palette8Tint,
              ),
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: v,
              minHeight: 14.0,
              year2023: false,
              trackGap: 8.0,
              stopIndicatorColor: _palette5Tint,
              stopIndicatorRadius: 5.0,
              color: _palette8Tint,
              backgroundColor: const Color(0xFFFFE082),
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
            ),
            const SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 56.0,
                      height: 56.0,
                      child: CircularProgressIndicator(
                        value: v,
                        color: _palette8Tint,
                        backgroundColor: const Color(0xFFFFE082),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'circular legacy',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: _palette8Tint,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 56.0,
                      height: 56.0,
                      child: CircularProgressIndicator(
                        value: v,
                        year2023: false,
                        trackGap: 6.0,
                        strokeWidth: 6.0,
                        color: _palette8Tint,
                        backgroundColor: const Color(0xFFFFE082),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'circular trackGap',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: _palette8Tint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 9 - REFRESH PROGRESS INDICATOR
// =============================================================================
Widget _section9RefreshProgressIndicator() {
  return _sectionCard(
    surface: _palette9Surface,
    border: _palette9Border,
    tint: _palette9Tint,
    number: '9',
    title: 'RefreshProgressIndicator',
    description:
        '`RefreshProgressIndicator` is the spinner Material uses for '
        'pull-to-refresh. It extends `CircularProgressIndicator` and adds '
        'an arrowhead and a Material elevation backdrop. Used directly here '
        'so you can see what `RefreshIndicator` paints on top.',
    caption: 'Same family - it extends CircularProgressIndicator.',
    body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        RefreshProgressIndicator(
          color: _palette9Tint,
          backgroundColor: Color(0xFFB2DFDB),
        ),
        RefreshProgressIndicator(
          value: 0.3,
          color: _palette9Tint,
          backgroundColor: Color(0xFFB2DFDB),
        ),
        RefreshProgressIndicator(
          value: 0.7,
          color: _palette9Tint,
          backgroundColor: Color(0xFFB2DFDB),
          strokeWidth: 4.0,
        ),
        RefreshProgressIndicator(
          value: 1.0,
          color: _palette9Tint,
          backgroundColor: Color(0xFFB2DFDB),
          strokeWidth: 5.0,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 - PROGRESS INDICATOR THEME
// =============================================================================
Widget _section10ProgressIndicatorTheme() {
  return _sectionCard(
    surface: _palette10Surface,
    border: _palette10Border,
    tint: _palette10Tint,
    number: '10',
    title: 'ProgressIndicatorTheme + ProgressIndicatorThemeData',
    description:
        '`ProgressIndicatorTheme` hoists defaults for every progress '
        'indicator below it. The two columns below paint identical-API '
        'indicators but the right column inherits a `ProgressIndicatorTheme` '
        'that overrides color, track color, stroke width and minHeight.',
    caption:
        'Theme override is preferred over per-widget configuration in apps.',
    body: AnimatedBuilder(
      animation: _mediumProgress,
      builder: (ctx, _) {
        final double v = _mediumProgress.value;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'NO theme',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: _palette10Tint,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  LinearProgressIndicator(
                    value: v,
                    minHeight: 4.0,
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: 44.0,
                    height: 44.0,
                    child: CircularProgressIndicator(
                      value: v,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WITH ProgressIndicatorTheme',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: _palette10Tint,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ProgressIndicatorTheme(
                    data: const ProgressIndicatorThemeData(
                      color: _palette10Tint,
                      linearTrackColor: Color(0xFFF8BBD0),
                      circularTrackColor: Color(0xFFF8BBD0),
                      linearMinHeight: 12.0,
                      strokeWidth: 6.0,
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: v,
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          width: 44.0,
                          height: 44.0,
                          child: CircularProgressIndicator(
                            value: v,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

// =============================================================================
// SECTION 11 - SIZED VARIANTS (small badge spinner vs hero spinner)
// =============================================================================
Widget _section11SizedVariants() {
  return _sectionCard(
    surface: _palette11Surface,
    border: _palette11Border,
    tint: _palette11Tint,
    number: '11',
    title: 'Sized variants - badge spinner vs hero spinner',
    description:
        'A progress indicator does not have an intrinsic size; it fills its '
        'parent. Wrap it in `SizedBox` to give it a specific footprint. '
        'Tiny: inline spinners next to text. Large: hero/empty-state '
        'centerpieces.',
    caption: 'SizedBox is the canonical way to size a CircularProgressIndicator.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'inline (16px)',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: _palette11Tint,
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: [
            const SizedBox(
              width: 16.0,
              height: 16.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: _palette11Tint,
              ),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Loading inline content...',
              style: TextStyle(fontSize: 13.0, color: _palette11Tint),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'badge (24px)',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: _palette11Tint,
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: const Color(0xFFCFD8DC),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  color: _palette11Tint,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Notification badge spinner',
              style: TextStyle(fontSize: 13.0, color: _palette11Tint),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'hero (96px)',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: _palette11Tint,
          ),
        ),
        const SizedBox(height: 6.0),
        Center(
          child: Column(
            children: [
              const SizedBox(
                width: 96.0,
                height: 96.0,
                child: CircularProgressIndicator(
                  strokeWidth: 8.0,
                  color: _palette11Tint,
                  backgroundColor: Color(0xFFCFD8DC),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Loading account...',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: _palette11Tint,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 12 - EMBEDDED IN BUTTONS
// =============================================================================
Widget _section12EmbeddedInButtons() {
  return _sectionCard(
    surface: _palette12Surface,
    border: _palette12Border,
    tint: _palette12Tint,
    number: '12',
    title: 'Embedded inside buttons',
    description:
        'A common pattern: replace the button label with a small spinner '
        'while a request is in flight. Use a `SizedBox` to keep the spinner '
        'small and use the button foreground color for tonal harmony.',
    caption: 'Always sync the spinner color with the button foreground.',
    body: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.start,
      children: [
        FilledButton(
          onPressed: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14.0,
                height: 14.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(width: 8.0),
              Text('Saving'),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14.0,
                height: 14.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
              SizedBox(width: 8.0),
              Text('Loading'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14.0,
                height: 14.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
              SizedBox(width: 8.0),
              Text('Refreshing'),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const SizedBox(
            width: 14.0,
            height: 14.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Color(0xFF558B2F),
            ),
          ),
          label: const Text('Working...'),
        ),
        FilledButton.tonal(
          onPressed: () {},
          child: AnimatedBuilder(
            animation: _mediumProgress,
            builder: (ctx, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      value: _mediumProgress.value,
                      color: _palette12Tint,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text('Upload ${(_mediumProgress.value * 100).round()}%'),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 13 - DECISION GUIDE
// =============================================================================
Widget _section13DecisionGuide() {
  return _sectionCard(
    surface: const Color(0xFFFAFAFA),
    border: const Color(0xFFBDBDBD),
    tint: const Color(0xFF424242),
    number: '13',
    title: 'Decision guide: linear vs circular, determinate vs indeterminate',
    description:
        'A short cheat-sheet to help pick the right indicator. Pair this '
        'card with the live demos above when teaching newcomers.',
    caption:
        'Accessibility tip: always set semanticsLabel; for determinate set '
        'semanticsValue too.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _decisionRow(
          title: 'Linear',
          when: 'Top-of-page banners, file uploads, multi-step wizards.',
          why: 'Reads like a percentage gauge; sits in flow.',
        ),
        _decisionRow(
          title: 'Circular',
          when: 'Inline waiting states; small UI areas; hero loaders.',
          why: 'Compact; rotational motion reads as activity.',
        ),
        _decisionRow(
          title: 'Determinate',
          when: 'You can compute progress: bytes/total, items processed/total.',
          why: 'Reduces uncertainty; lets users plan.',
        ),
        _decisionRow(
          title: 'Indeterminate',
          when: 'Unknown duration: network round-trips, server-side waits.',
          why: 'Shows liveness without lying about ETA.',
        ),
        _decisionRow(
          title: 'RefreshProgressIndicator',
          when: 'Pull-to-refresh and similar drag-to-trigger affordances.',
          why: 'Carries the standard arrow + Material elevation.',
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Always provide semanticsLabel: e.g., "Loading photos". '
            'For determinate indicators also pass semanticsValue: '
            '"\${percent}%". Screen readers depend on these to announce '
            'progress to assistive tech users.',
            style: TextStyle(fontSize: 11.0, color: Color(0xFF424242)),
          ),
        ),
      ],
    ),
  );
}

Widget _decisionRow({
  required String title,
  required String when,
  required String why,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Use when: $when',
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                'Why: $why',
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF616161),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// FOOTER
// =============================================================================
Widget _galleryFooter() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery summary',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          '13 sections covering CircularProgressIndicator, '
          'LinearProgressIndicator, RefreshProgressIndicator, and '
          'ProgressIndicatorTheme + ProgressIndicatorThemeData.',
          style: TextStyle(color: Color(0xFFEBEBF5), fontSize: 12.0),
        ),
        SizedBox(height: 4.0),
        Text(
          'Live values are driven by module-level ValueNotifiers ticked from '
          'WidgetsBinding.addPostFrameCallback - no TickerProvider mixin '
          'required.',
          style: TextStyle(
            color: Color(0xFFAEAEB2),
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SHARED CARD HELPER
// =============================================================================
Widget _sectionCard({
  required Color surface,
  required Color border,
  required Color tint,
  required String number,
  required String title,
  required String description,
  required Widget body,
  required String caption,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(number: number, title: title, tint: tint),
        const SizedBox(height: 10.0),
        Text(
          description,
          style: const TextStyle(fontSize: 13.0, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        body,
        const SizedBox(height: 10.0),
        Text(
          caption,
          style: TextStyle(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: tint,
          ),
        ),
      ],
    ),
  );
}

Widget _sectionTitle({
  required String number,
  required String title,
  required Color tint,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22.0,
          height: 22.0,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: tint,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    ),
  );
}
