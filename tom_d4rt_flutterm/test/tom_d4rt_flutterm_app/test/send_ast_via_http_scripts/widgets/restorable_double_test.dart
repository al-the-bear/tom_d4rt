import 'package:flutter/material.dart';
// foundation.dart is re-exported by material.dart; debugPrint and
// RestorationMixin both come through the material barrel file.

// ---------------------------------------------------------------------------
// RestorableDouble — Deep Visual Demo
// ---------------------------------------------------------------------------
//
// RestorableDouble is the *non-nullable* sibling of RestorableDoubleN. It
// holds a raw `double` that survives process-level restoration via the
// RestorationMixin. The value is always present (never null), which is ideal
// for controls that must have a defined state at all times — volume levels,
// playback speeds, EQ gains, opacity, brightness, contrast, and so on.
//
// Under the hood the restoration framework writes the double into a
// RestorationBucket as a 64-bit IEEE 754 value. The exact bit pattern is
// preserved, meaning that a value like 0.1 + 0.2 (which is famously not
// exactly 0.3 in IEEE 754) will restore to the *same* imprecise double it
// was saved as. There is no rounding or normalization applied by the
// framework itself.
//
// This demo is the "rich visual showcase" counterpart to the nullable
// RestorableDoubleN demo. Whereas RestorableDoubleN highlights null-handling
// (toggle between "unset" and a value), this demo highlights the natural
// home of non-null doubles: continuous analog-feeling controls where a
// missing value would be nonsensical. A volume slider is always at some
// volume; a playback speed is always at some speed; an EQ band has some
// gain even when that gain happens to be zero.
//
// We build a faux "Media Control Suite" with five distinct scenarios, each
// with its own visual identity so no two scenarios share a shell:
//
//   S1. Volume — circular dial + three-bar VU meter
//   S2. Playback speed — horizontal tick-mark strip + sweep bar
//   S3. 5-band equalizer — row of 5 vertical sliders with mini spectra
//   S4. Opacity — gradient ruler + checkerboard overlay
//   S5. Brightness/contrast + teaching panel
//
// ---------------------------------------------------------------------------

// Entry point for the d4rt harness. This script returns a MaterialApp; the
// harness wires it into the interpreted widget tree. There is intentionally
// no main(); d4rt invokes build(context) directly.
dynamic build(BuildContext context) {
  debugPrint('[RestorableDouble demo] Building Media Control Suite...');
  return MaterialApp(
    title: 'RestorableDouble Deep Demo',
    theme: ThemeData(colorSchemeSeed: Colors.pink, useMaterial3: true),
    // restorationScopeId at the MaterialApp level establishes the root
    // restoration bucket. All descendant RestorationMixin users anchor
    // their per-widget buckets inside this scope.
    restorationScopeId: 'restorable_double_demo',
    home: const MediaControlsDemo(),
    debugShowCheckedModeBanner: false,
  );
}

// ---------------------------------------------------------------------------
// MediaControlsDemo — the one and only StatefulWidget in this file.
// All RestorableDouble fields live inside its State, which mixes in
// RestorationMixin. We keep them all in a single State because each field
// is logically part of the same "media control suite" and they share the
// same restoration bucket.
// ---------------------------------------------------------------------------
class MediaControlsDemo extends StatefulWidget {
  const MediaControlsDemo({super.key});

  @override
  State<MediaControlsDemo> createState() => _MediaControlsDemoState();
}

class _MediaControlsDemoState extends State<MediaControlsDemo>
    with RestorationMixin {
  // --- S1: Volume ---------------------------------------------------------
  // 0.0 .. 1.0. Default 0.7 (70%). Because this is a RestorableDouble,
  // *some* value is always present — useful for a hero control where a
  // null volume would require a "not initialized" branch in the UI.
  final RestorableDouble _volume = RestorableDouble(0.7);

  // --- S2: Playback speed -------------------------------------------------
  // 0.5 .. 2.0. Default 1.0 (normal speed).
  final RestorableDouble _speed = RestorableDouble(1.0);

  // --- S3: Five-band equalizer -------------------------------------------
  // Each band holds a gain in dB in the range -12 .. +12. Default 0 (flat).
  // Five separate RestorableDouble fields — one per band — because each
  // band should restore independently and because the restoration bucket
  // stores primitive leaves, not composite arrays.
  final RestorableDouble _eq60Hz = RestorableDouble(0.0);
  final RestorableDouble _eq250Hz = RestorableDouble(0.0);
  final RestorableDouble _eq1kHz = RestorableDouble(0.0);
  final RestorableDouble _eq4kHz = RestorableDouble(0.0);
  final RestorableDouble _eq16kHz = RestorableDouble(0.0);

  // --- S4: Opacity --------------------------------------------------------
  // 0.0 .. 1.0. Default 0.6 — enough opacity to see the overlaid colour
  // but not so much that the checkerboard is fully hidden.
  final RestorableDouble _opacity = RestorableDouble(0.6);

  // --- S5: Brightness + contrast -----------------------------------------
  // Both 0.0 .. 1.0. 0.5 is the "neutral" midpoint — no lightening or
  // darkening applied.
  final RestorableDouble _brightness = RestorableDouble(0.5);
  final RestorableDouble _contrast = RestorableDouble(0.5);

  // restorationId is the key this State uses when registering itself and
  // its properties into the enclosing RestorationBucket. Nesting under the
  // MaterialApp's 'restorable_double_demo' scope gives us a full path like
  // 'restorable_double_demo/media_controls_demo/volume'.
  @override
  String? get restorationId => 'media_controls_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // Register every RestorableDouble property with a unique key. These
    // keys identify leaves in the bucket tree and must be stable across
    // app versions if we want persisted state to survive upgrades.
    registerForRestoration(_volume, 'volume');
    registerForRestoration(_speed, 'speed');
    registerForRestoration(_eq60Hz, 'eq_60hz');
    registerForRestoration(_eq250Hz, 'eq_250hz');
    registerForRestoration(_eq1kHz, 'eq_1khz');
    registerForRestoration(_eq4kHz, 'eq_4khz');
    registerForRestoration(_eq16kHz, 'eq_16khz');
    registerForRestoration(_opacity, 'opacity');
    registerForRestoration(_brightness, 'brightness');
    registerForRestoration(_contrast, 'contrast');
  }

  @override
  void dispose() {
    // RestorableProperty instances are resources. Disposing them detaches
    // them from the restoration system and releases any associated
    // listeners.
    _volume.dispose();
    _speed.dispose();
    _eq60Hz.dispose();
    _eq250Hz.dispose();
    _eq1kHz.dispose();
    _eq4kHz.dispose();
    _eq16kHz.dispose();
    _opacity.dispose();
    _brightness.dispose();
    _contrast.dispose();
    super.dispose();
  }

  // --- Top-level build ----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F7),
      appBar: AppBar(
        title: const Text('RestorableDouble — Media Controls'),
        backgroundColor: Colors.pink.shade50,
        foregroundColor: Colors.pink.shade900,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildVolumeSection(),
            const SizedBox(height: 24),
            _buildSpeedSection(),
            const SizedBox(height: 24),
            _buildEqualizerSection(),
            const SizedBox(height: 24),
            _buildOpacitySection(),
            const SizedBox(height: 24),
            _buildBrightnessTeachingSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // =======================================================================
  // SCENARIO 1 — Volume hero panel
  //
  // The hero scenario: a circular dial approximated by 36 rotated segments
  // (one every 10°), with the segments inside the swept arc illuminated,
  // plus a three-bar LED-style VU meter, a slider, and quick-jump buttons.
  // =======================================================================
  Widget _buildVolumeSection() {
    final double v = _volume.value;
    final int percent = (v * 100).round();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.pink.shade300,
                        Colors.pink.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.volume_up, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  'S1 — Volume',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.pink.shade200),
                  ),
                  child: Text(
                    'RestorableDouble — 0.0..1.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.pink.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Dial + VU meter side-by-side. The dial dominates the left,
            // the VU meter stacks on the right.
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // --- Circular dial -------------------------------------
                SizedBox(
                  width: 220,
                  height: 220,
                  child: _buildVolumeDial(v, percent),
                ),
                const SizedBox(width: 24),
                // --- VU meter ------------------------------------------
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: _buildVuMeter(v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Slider for fine adjustment.
            Row(
              children: <Widget>[
                const Icon(Icons.volume_mute, size: 20),
                Expanded(
                  child: Slider(
                    value: v,
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    label: '$percent%',
                    activeColor: Colors.pink,
                    onChanged: (double nv) {
                      setState(() {
                        // Assignment to a RestorableDouble's .value
                        // triggers a bucket write. The next restoration
                        // cycle will see this new double.
                        _volume.value = nv;
                      });
                    },
                  ),
                ),
                const Icon(Icons.volume_up, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            // Quick-jump buttons.
            Row(
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _volume.value = 0.0;
                    });
                  },
                  icon: const Icon(Icons.volume_off),
                  label: const Text('Mute'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _volume.value = 1.0;
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.pink,
                  ),
                  icon: const Icon(Icons.graphic_eq),
                  label: const Text('Max'),
                ),
                const Spacer(),
                Text(
                  'Raw IEEE 754 double: ${v.toStringAsFixed(6)}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the 36-segment dial by stacking 36 little rectangles, each
  // rotated around the centre. Each segment represents 10° of the full
  // circle. The segments whose angle is within the sweep (0 .. value*360)
  // are drawn bright; the rest are drawn dim.
  Widget _buildVolumeDial(double value, int percent) {
    const int segmentCount = 36;
    final double sweepDeg = value * 360.0;
    final List<Widget> segments = <Widget>[];
    for (int i = 0; i < segmentCount; i++) {
      final double segDeg = i * (360.0 / segmentCount);
      final bool lit = segDeg <= sweepDeg;
      // Radians conversion: 2*pi/360 ≈ 0.01745329.
      final double rad = segDeg * 0.01745329;
      // The segment is a small rectangle offset from the centre then
      // rotated around the centre of the dial.
      segments.add(
        Center(
          child: Transform.rotate(
            angle: rad,
            child: Transform.translate(
              offset: const Offset(0, -85),
              child: Container(
                width: 8,
                height: 22,
                decoration: BoxDecoration(
                  gradient: lit
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            _dialColorForIndex(i, segmentCount),
                            _dialColorForIndex(i, segmentCount)
                                .withValues(alpha: 0.6),
                          ],
                        )
                      : null,
                  color: lit ? null : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: lit
                      ? <BoxShadow>[
                          BoxShadow(
                            color: _dialColorForIndex(i, segmentCount)
                                .withValues(alpha: 0.4),
                            blurRadius: 4,
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Outer ring decoration.
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        // All rotated segments.
        ...segments,
        // Inner hub + readout.
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.pink.shade900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'VOLUME',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Dial segments transition from green in the lower third, to orange,
  // to red at the top — a classic "signal strength" gradient.
  Color _dialColorForIndex(int i, int total) {
    final double t = i / total;
    if (t < 0.55) {
      return Colors.green.shade500;
    } else if (t < 0.80) {
      return Colors.orange.shade600;
    } else {
      return Colors.red.shade600;
    }
  }

  // The VU meter: three LED-style vertical bars. Each bar's *fill height*
  // is proportional to the volume value but with a different ceiling,
  // and each is a different classic LED colour (green/orange/red).
  Widget _buildVuMeter(double value) {
    // Bar maxHeights differ slightly so the LED stack looks like classic
    // hardware VU meters where the centre channel is slightly taller.
    const double leftMax = 170;
    const double centreMax = 190;
    const double rightMax = 170;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _buildVuBar(value, leftMax, Colors.green.shade400, 'L'),
          _buildVuBar(value, centreMax, Colors.orange.shade500, 'C'),
          _buildVuBar(value, rightMax, Colors.red.shade400, 'R'),
        ],
      ),
    );
  }

  Widget _buildVuBar(double value, double maxHeight, Color tip, String label) {
    final double h = value * maxHeight;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // The "shaft" — the unlit portion sits as background.
        Container(
          width: 28,
          height: maxHeight,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade800),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 22,
            height: h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Colors.green.shade500,
                  Colors.orange.shade400,
                  tip,
                ],
                stops: const <double>[0.0, 0.6, 1.0],
              ),
              borderRadius: BorderRadius.circular(4),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: tip.withValues(alpha: 0.6),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  // =======================================================================
  // SCENARIO 2 — Playback speed
  //
  // Visual identity: a horizontal tick-mark strip with the tick nearest
  // the current speed drawn taller and coloured, plus a "sweep bar"
  // AnimatedContainer, plus a row of preset pills.
  // =======================================================================
  Widget _buildSpeedSection() {
    final double s = _speed.value;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.indigo.shade300,
                        Colors.indigo.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.speed, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  'S2 — Playback Speed',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                // Big speed pill.
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.indigo.shade400,
                        Colors.indigo.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.indigo.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    '${s.toStringAsFixed(2)}x',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Sweep bar — scales with speed.
            LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints cons) {
                final double maxW = cons.maxWidth;
                // Normalise speed 0.5..2.0 → 0..1 for the sweep.
                final double norm = ((s - 0.5) / 1.5).clamp(0.0, 1.0);
                return Stack(
                  children: <Widget>[
                    Container(
                      width: maxW,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      width: norm * maxW,
                      height: 12,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.indigo.shade300,
                            Colors.indigo.shade900,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            // Tick-mark strip. 16 ticks at 0.5, 0.6, ... 2.0.
            _buildSpeedTickStrip(s),
            const SizedBox(height: 16),
            // Fine slider.
            Slider(
              value: s,
              min: 0.5,
              max: 2.0,
              divisions: 30,
              label: '${s.toStringAsFixed(2)}x',
              activeColor: Colors.indigo,
              onChanged: (double ns) {
                setState(() {
                  _speed.value = ns;
                });
              },
            ),
            const SizedBox(height: 8),
            // Preset pills.
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _buildSpeedPreset(0.5, s),
                _buildSpeedPreset(0.75, s),
                _buildSpeedPreset(1.0, s),
                _buildSpeedPreset(1.25, s),
                _buildSpeedPreset(1.5, s),
                _buildSpeedPreset(2.0, s),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedTickStrip(double speed) {
    // Build 16 ticks in a Row, each a Container with its own height.
    // The tick whose represented value is closest to `speed` gets
    // special styling (taller + vivid colour).
    final List<Widget> ticks = <Widget>[];
    for (int i = 0; i < 16; i++) {
      final double tickValue = 0.5 + i * 0.1;
      final double dist = (tickValue - speed).abs();
      final bool isNearest = dist < 0.05;
      final bool isMajor = ((tickValue * 10).round() % 5) == 0;
      ticks.add(
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 3,
                height: isNearest ? 40 : (isMajor ? 24 : 14),
                decoration: BoxDecoration(
                  color: isNearest
                      ? Colors.indigo.shade700
                      : (isMajor
                          ? Colors.indigo.shade400
                          : Colors.indigo.shade200),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 4),
              if (isMajor || isNearest)
                Text(
                  '${tickValue.toStringAsFixed(1)}x',
                  style: TextStyle(
                    fontSize: 10,
                    color: isNearest
                        ? Colors.indigo.shade900
                        : Colors.indigo.shade400,
                    fontWeight: isNearest
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                )
              else
                const SizedBox(height: 12),
            ],
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ticks,
      ),
    );
  }

  Widget _buildSpeedPreset(double preset, double current) {
    final bool selected = (preset - current).abs() < 0.01;
    return GestureDetector(
      onTap: () {
        setState(() {
          _speed.value = preset;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.indigo.shade700 : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? Colors.indigo.shade900
                : Colors.indigo.shade200,
            width: 1.5,
          ),
          boxShadow: selected
              ? <BoxShadow>[
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.3),
                    blurRadius: 6,
                  ),
                ]
              : null,
        ),
        child: Text(
          '${preset.toStringAsFixed(preset == preset.roundToDouble() ? 0 : 2)}x',
          style: TextStyle(
            color: selected ? Colors.white : Colors.indigo.shade900,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // =======================================================================
  // SCENARIO 3 — Five-band equalizer
  //
  // Visual identity: a row of 5 vertical sliders built with RotatedBox,
  // each capped with a tiny "frequency spectrum" graphic hinting at the
  // band's character, labelled and showing its current dB gain.
  // =======================================================================
  Widget _buildEqualizerSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.teal.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.teal.shade300,
                        Colors.teal.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.graphic_eq, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  'S3 — 5-Band Equalizer',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  '5 × RestorableDouble · -12..+12 dB',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.teal.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildEqBand(_eq60Hz, '60 Hz', 0, (double v) {
                    setState(() {
                      _eq60Hz.value = v;
                    });
                  }),
                  _buildEqBand(_eq250Hz, '250 Hz', 1, (double v) {
                    setState(() {
                      _eq250Hz.value = v;
                    });
                  }),
                  _buildEqBand(_eq1kHz, '1 kHz', 2, (double v) {
                    setState(() {
                      _eq1kHz.value = v;
                    });
                  }),
                  _buildEqBand(_eq4kHz, '4 kHz', 3, (double v) {
                    setState(() {
                      _eq4kHz.value = v;
                    });
                  }),
                  _buildEqBand(_eq16kHz, '16 kHz', 4, (double v) {
                    setState(() {
                      _eq16kHz.value = v;
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Flatten + presets row.
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: _flattenEq,
                  icon: const Icon(Icons.horizontal_rule),
                  label: const Text('Flatten'),
                ),
                _buildEqPresetButton(
                    'Rock', <double>[4, 2, -1, 2, 3], Colors.red.shade700),
                _buildEqPresetButton(
                    'Jazz', <double>[2, 1, 0, 2, 3], Colors.amber.shade800),
                _buildEqPresetButton('Classical',
                    <double>[0, 0, 0, 2, 4], Colors.blueGrey.shade700),
                _buildEqPresetButton('Bass Boost',
                    <double>[6, 4, 0, -1, -2], Colors.deepPurple.shade700),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _flattenEq() {
    setState(() {
      _eq60Hz.value = 0.0;
      _eq250Hz.value = 0.0;
      _eq1kHz.value = 0.0;
      _eq4kHz.value = 0.0;
      _eq16kHz.value = 0.0;
    });
  }

  Widget _buildEqPresetButton(
      String name, List<double> values, Color color) {
    return FilledButton.tonal(
      onPressed: () {
        setState(() {
          _eq60Hz.value = values[0];
          _eq250Hz.value = values[1];
          _eq1kHz.value = values[2];
          _eq4kHz.value = values[3];
          _eq16kHz.value = values[4];
        });
      },
      style: FilledButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.15),
        foregroundColor: color,
      ),
      child: Text(name),
    );
  }

  // Single EQ band: mini spectrum graphic + band label + vertical slider
  // (created by rotating a horizontal Slider 90° counter-clockwise) + dB
  // readout. `bandIdx` selects the shape of the mini spectrum.
  Widget _buildEqBand(RestorableDouble band, String label, int bandIdx,
      ValueChanged<double> onChanged) {
    final double v = band.value;
    final String dbText = v == 0
        ? '0 dB'
        : (v > 0 ? '+${v.toStringAsFixed(1)} dB' : '${v.toStringAsFixed(1)} dB');
    final Color dbColor = v > 0.5
        ? Colors.green.shade400
        : (v < -0.5 ? Colors.red.shade400 : Colors.grey.shade400);
    return Column(
      children: <Widget>[
        // Mini spectrum hint.
        SizedBox(
          width: 50,
          height: 30,
          child: _buildMiniSpectrum(bandIdx),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        // Vertical slider: -12 bottom, +12 top.
        SizedBox(
          width: 36,
          height: 170,
          child: RotatedBox(
            quarterTurns: 3,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.teal.shade400,
                inactiveTrackColor: Colors.grey.shade800,
                thumbColor: Colors.tealAccent,
                overlayColor:
                    Colors.tealAccent.withValues(alpha: 0.25),
              ),
              child: Slider(
                value: v,
                min: -12.0,
                max: 12.0,
                divisions: 48,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: dbColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            dbText,
            style: TextStyle(
              color: dbColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }

  // A tiny inline "spectrum" whose shape hints at the band. Low bands get
  // wide, low-to-the-left shapes. High bands get narrow, rightward peaks.
  Widget _buildMiniSpectrum(int bandIdx) {
    // Define a fixed 10-bar shape per band.
    List<double> bars;
    switch (bandIdx) {
      case 0: // 60 Hz — sub-bass hump to the left
        bars = <double>[1.0, 0.95, 0.8, 0.6, 0.4, 0.25, 0.15, 0.1, 0.08, 0.05];
        break;
      case 1: // 250 Hz — broad low hump
        bars = <double>[0.5, 0.8, 1.0, 0.9, 0.6, 0.35, 0.2, 0.15, 0.1, 0.08];
        break;
      case 2: // 1 kHz — central hump
        bars = <double>[0.2, 0.4, 0.6, 0.85, 1.0, 0.9, 0.6, 0.4, 0.25, 0.15];
        break;
      case 3: // 4 kHz — slight right
        bars = <double>[0.1, 0.2, 0.3, 0.45, 0.65, 0.85, 1.0, 0.85, 0.5, 0.3];
        break;
      default: // 16 kHz — sharp spike right
        bars = <double>[0.05, 0.08, 0.12, 0.18, 0.3, 0.5, 0.75, 1.0, 0.85, 0.5];
        break;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: bars.map((double h) {
        return Container(
          width: 3,
          height: 2 + h * 26,
          decoration: BoxDecoration(
            color: Colors.tealAccent.withValues(alpha: 0.3 + h * 0.6),
            borderRadius: BorderRadius.circular(1),
          ),
        );
      }).toList(),
    );
  }

  // =======================================================================
  // SCENARIO 4 — Opacity
  //
  // Visual identity: a gradient "ruler" that reveals only the leftmost
  // N% where N = opacity*100, plus a checkerboard with a coloured overlay
  // whose alpha channel is driven by _opacity.value.
  // =======================================================================
  Widget _buildOpacitySection() {
    final double o = _opacity.value;
    final int percent = (o * 100).round();
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.amber.shade300,
                        Colors.amber.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.opacity, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  'S4 — Opacity',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  '$percent% alpha',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.amber.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // --- Gradient ruler -------------------------------------
            Text(
              'Gradient ruler — revealed width = opacity %',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints cons) {
                final double maxW = cons.maxWidth;
                return Stack(
                  children: <Widget>[
                    // Background "empty" slot.
                    Container(
                      width: maxW,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Revealed portion — a gradient masked to o*maxW.
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: o * maxW,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.purple.shade300,
                            Colors.pink.shade400,
                            Colors.orange.shade400,
                            Colors.amber.shade500,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Percent tick marks (0, 25, 50, 75, 100).
                    Positioned(
                      top: 42,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text('0%', style: TextStyle(fontSize: 10)),
                          Text('25%', style: TextStyle(fontSize: 10)),
                          Text('50%', style: TextStyle(fontSize: 10)),
                          Text('75%', style: TextStyle(fontSize: 10)),
                          Text('100%', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 42),
            // --- Checkerboard + overlay ----------------------------
            Text(
              'Checkerboard background + coloured overlay at alpha $percent%',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // 8x8 checkerboard, each cell 24x24 = 192x192 total.
                  _buildCheckerboard(8, 24),
                  // The overlay rectangle — alpha-modulated coloured fill.
                  Container(
                    width: 192,
                    height: 192,
                    decoration: BoxDecoration(
                      color:
                          Colors.deepPurple.withValues(alpha: o),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'alpha=${o.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white
                              .withValues(alpha: o > 0.5 ? 1.0 : 0.4),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Slider(
              value: o,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: '$percent%',
              activeColor: Colors.amber.shade700,
              onChanged: (double nv) {
                setState(() {
                  _opacity.value = nv;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // An N×N checkerboard built from two nested Row/Column loops. Each cell
  // is a Container of the given size alternating between two greys.
  Widget _buildCheckerboard(int n, double cell) {
    final List<Widget> rows = <Widget>[];
    for (int y = 0; y < n; y++) {
      final List<Widget> cells = <Widget>[];
      for (int x = 0; x < n; x++) {
        final bool dark = ((x + y) % 2) == 0;
        cells.add(
          Container(
            width: cell,
            height: cell,
            color: dark ? Colors.grey.shade400 : Colors.grey.shade100,
          ),
        );
      }
      rows.add(Row(mainAxisSize: MainAxisSize.min, children: cells));
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade600),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Column(mainAxisSize: MainAxisSize.min, children: rows),
      ),
    );
  }

  // =======================================================================
  // SCENARIO 5 — Brightness + contrast + teaching panel
  //
  // Visual identity: a card showing a "preview" container whose colour
  // and gradient stops change with the two values, followed by a tri-card
  // teaching panel.
  // =======================================================================
  Widget _buildBrightnessTeachingSection() {
    final double b = _brightness.value;
    final double c = _contrast.value;
    // Derive a preview colour: base is mid-blue, lerp toward white as
    // brightness increases past 0.5 and toward black as it drops below.
    final Color baseColor = Colors.blue.shade600;
    final double brightnessDelta = b - 0.5;
    final Color adjusted = brightnessDelta >= 0
        ? Color.lerp(baseColor, Colors.white, brightnessDelta * 2) ??
            baseColor
        : Color.lerp(baseColor, Colors.black, -brightnessDelta * 2) ??
            baseColor;
    // Contrast effect: tighter stops = harder edge. contrast=0 gives a
    // soft spread (stops at 0.2 and 0.8); contrast=1 gives near-hard cut
    // (stops at 0.48 and 0.52).
    final double stop1 = 0.2 + c * 0.28;
    final double stop2 = 0.8 - c * 0.28;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.deepOrange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.deepOrange.shade300,
                        Colors.deepOrange.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.brightness_6, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  'S5 — Brightness & Contrast + Teaching',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Preview container.
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    adjusted,
                    Color.lerp(adjusted, Colors.black, 0.3) ?? adjusted,
                    adjusted,
                  ],
                  stops: <double>[0.0, (stop1 + stop2) / 2.0, 1.0],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'brightness=${b.toStringAsFixed(2)} · contrast=${c.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'stops: $stop1 / $stop2',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Brightness controls.
            Row(
              children: <Widget>[
                const Icon(Icons.wb_sunny_outlined, size: 20),
                const SizedBox(width: 8),
                const SizedBox(width: 90, child: Text('Brightness')),
                Expanded(
                  child: Slider(
                    value: b,
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    activeColor: Colors.deepOrange,
                    onChanged: (double nv) {
                      setState(() {
                        _brightness.value = nv;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 46,
                  child: Text(
                    b.toStringAsFixed(2),
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.contrast, size: 20),
                const SizedBox(width: 8),
                const SizedBox(width: 90, child: Text('Contrast')),
                Expanded(
                  child: Slider(
                    value: c,
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    activeColor: Colors.deepOrange,
                    onChanged: (double nv) {
                      setState(() {
                        _contrast.value = nv;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 46,
                  child: Text(
                    c.toStringAsFixed(2),
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Teaching panel.
            _buildTeachingPanel(),
          ],
        ),
      ),
    );
  }

  // Three explanatory cards side-by-side on wide displays, wrapping on
  // narrow ones. Each card is a concise didactic unit on a single aspect
  // of RestorableDouble.
  Widget _buildTeachingPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Teaching panel — RestorableDouble concepts',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            _buildTeachCard(
              icon: Icons.check_circle_outline,
              tint: Colors.green,
              title: 'Always-present values',
              body:
                  'RestorableDouble stores a *non-null* double. The value is '
                  'always defined — useful for controls like volume, speed, '
                  'or zoom where a null reading would be meaningless. Compare '
                  'with RestorableDoubleN, which adds an explicit "unset" '
                  'state.',
            ),
            _buildTeachCard(
              icon: Icons.storage,
              tint: Colors.indigo,
              title: 'Restoration bucket mechanics',
              body:
                  'During restoreState, each RestorableDouble is registered '
                  'against a key in the enclosing RestorationBucket. The '
                  '64-bit IEEE 754 representation is written verbatim, so '
                  'the exact bit pattern round-trips — important for '
                  'numerically sensitive values.',
            ),
            _buildTeachCard(
              icon: Icons.lightbulb_outline,
              tint: Colors.amber,
              title: 'Common use-cases',
              body:
                  'Sliders, thresholds, positions (scroll offsets, drag '
                  'handles), zoom levels, playback speed, volume and gain, '
                  'progress counters, ratings. Anything continuous where the '
                  'control has a natural default.',
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Numeric precision demo row.
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'IEEE 754 sample — what actually gets stored:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              _buildIeeeSampleRow('0.1 + 0.2', 0.1 + 0.2),
              _buildIeeeSampleRow('1.0 / 3.0', 1.0 / 3.0),
              _buildIeeeSampleRow('_volume.value', _volume.value),
              _buildIeeeSampleRow('_speed.value', _speed.value),
              _buildIeeeSampleRow('_opacity.value', _opacity.value),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIeeeSampleRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          const Text('→ '),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachCard({
    required IconData icon,
    required MaterialColor tint,
    required String title,
    required String body,
  }) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tint.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: tint.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: tint.shade700, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: tint.shade900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
