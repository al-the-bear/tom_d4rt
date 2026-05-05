// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// =============================================================================
//  VELOCITY · VELOCITY ESTIMATE · VELOCITY TRACKER
//  A Drift Argent Gauge House
// =============================================================================
//
//  Theme:        Drift Argent — silver gauge sweeps on slate, polished steel
//                bezels, mercury-blue needles, hairline tickmarks. The look
//                of a 1960s test bench: brushed aluminium, lit dials, faint
//                phosphor glow.
//  Subject:      package:flutter/gestures.dart
//                  Velocity
//                  VelocityEstimate
//                  VelocityTracker (constructed offline, no live pointers)
//  Audience:     Anyone trying to understand how a sequence of finger
//                positions becomes a "fling" — i.e. the math between
//                onPointerMove and onPanEnd's DragEndDetails.velocity.
//  Format:       A single static snapshot. D4rt invokes build() exactly
//                once. We construct VelocityTrackers, feed them synthetic
//                (Duration, Offset) samples via addPosition, then read
//                back the resulting Velocity / VelocityEstimate values
//                and render them as labelled gauges, dial-faces, tables,
//                and prose. There is no setState, no animation, no timer.
//
// -----------------------------------------------------------------------------
//  Why does Flutter need a VelocityTracker at all?
// -----------------------------------------------------------------------------
//
//  Imagine the user drags their finger across a list. At the moment they
//  lift, you must decide: was that a slow nudge (the list should stop where
//  it is) or was it a flick (the list should keep coasting)? The answer
//  depends on how fast their finger was moving — i.e. its velocity at
//  release time, expressed in pixels per second.
//
//  But "velocity" is not a single number you can read from the most recent
//  pointer event. A single position has no velocity; only a sequence does.
//  Worse, the touch screen samples are noisy, irregular in time, and
//  occasionally jittery near release. So Flutter ships a VelocityTracker:
//
//      1. You feed it (timestamp, position) samples as they arrive.
//      2. It keeps a rolling window of the last ~20 samples.
//      3. When you ask, it fits a low-degree polynomial to the recent
//         samples and reports the polynomial's first derivative as the
//         estimated velocity at the current moment.
//      4. The result is wrapped in a Velocity (or richer
//         VelocityEstimate) value that the gesture system passes to your
//         onPanEnd / onDragEnd callback as DragEndDetails.velocity.
//
//  In a real app you never construct a VelocityTracker yourself — the
//  drag recognizers do it for you. But for a deep demo running inside a
//  static AST snapshot we can build one, drive it with hand-crafted
//  samples, and inspect what it produces. That is exactly what this file
//  does, five different times, across five distinct scenarios.
//
// -----------------------------------------------------------------------------
//  Drift Argent palette
// -----------------------------------------------------------------------------
//    daSlate         #1B2530   slate of the chassis
//    daSlateDeep     #0F1620   shadow of the chassis
//    daSteel         #5A6878   bezel steel
//    daSteelLight    #8C9AA8   highlight steel
//    daArgent        #C8D2DC   polished silver
//    daArgentBright  #E6ECF2   gauge-face silver
//    daMercury       #4A8FB8   needle mercury blue
//    daMercuryDeep   #2A5F80   needle shadow
//    daPhosphor      #7FBFA0   phosphor glow tickmarks
//    daAmber         #D4A24A   warning amber
//    daRust          #A65A3A   over-redline rust
//    daHairline      #3A4858   hairline divider
//
// -----------------------------------------------------------------------------
//  API surface exercised
// -----------------------------------------------------------------------------
//
//    VelocityTracker.withKind(PointerDeviceKind kind)
//      Constructor. Picks the polynomial-fit algorithm tuned for the kind
//      of input device (touch, mouse, stylus, trackpad).
//
//    void addPosition(Duration time, Offset position)
//      Feed the tracker one sample. Time is monotonic from some arbitrary
//      origin; what matters is the deltas between successive samples.
//
//    Velocity getVelocity()
//      Best-effort velocity vector. Returns Velocity.zero when the
//      tracker has too few or too noisy samples to give an answer.
//
//    VelocityEstimate? getVelocityEstimate()
//      Richer flavour: also reports confidence (0..1), the duration
//      window the estimate was computed over, and the offset travelled
//      during that window. Returns null when no estimate is possible.
//
//    Velocity(pixelsPerSecond: Offset)
//      Direct construction, used in places where you already know the
//      answer and just want to wrap it in the value type.
//
//    Velocity.zero
//      The canonical no-motion velocity. Identity element for + and -.
//
//    Velocity operator -()           // unary; reverses both axes
//    Velocity operator -(other)      // binary; component subtraction
//    Velocity operator +(other)      // binary; component addition
//    Velocity clampMagnitude(min, max)
//      Returns a velocity whose magnitude is clamped into [min, max]
//      while preserving direction.
//
//    Velocity.pixelsPerSecond
//      The Offset; .dx is horizontal px/s, .dy vertical px/s.
//      Sign convention: +x right, +y down (screen coordinates).
//
//    VelocityEstimate.pixelsPerSecond, .confidence, .duration, .offset
//      The four dials of a richer estimate.
//
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// -----------------------------------------------------------------------------
// Drift Argent palette
// -----------------------------------------------------------------------------
const Color daSlate = Color(0xFF1B2530);
const Color daSlateDeep = Color(0xFF0F1620);
const Color daSteel = Color(0xFF5A6878);
const Color daSteelLight = Color(0xFF8C9AA8);
const Color daArgent = Color(0xFFC8D2DC);
const Color daArgentBright = Color(0xFFE6ECF2);
const Color daMercury = Color(0xFF4A8FB8);
const Color daMercuryDeep = Color(0xFF2A5F80);
const Color daPhosphor = Color(0xFF7FBFA0);
const Color daAmber = Color(0xFFD4A24A);
const Color daRust = Color(0xFFA65A3A);
const Color daHairline = Color(0xFF3A4858);

// -----------------------------------------------------------------------------
// Sample container — one (Duration, Offset) tuple, used for rendering.
// -----------------------------------------------------------------------------
class _Sample {
  final Duration t;
  final Offset p;
  const _Sample(this.t, this.p);
}

// -----------------------------------------------------------------------------
// Scenario record — five of these are constructed up top and threaded
// through the visual tree so each card has its own freshly-computed
// Velocity / VelocityEstimate to display.
// -----------------------------------------------------------------------------
class _Scenario {
  final String label;
  final String narrative;
  final List<_Sample> samples;
  final Velocity velocity;
  final VelocityEstimate? estimate;
  final Color accent;

  const _Scenario({
    required this.label,
    required this.narrative,
    required this.samples,
    required this.velocity,
    required this.estimate,
    required this.accent,
  });
}

// =============================================================================
//  build()
// =============================================================================
//  D4rt invokes this exactly once. No setState, no rebuilds, no controllers.
//  We construct five VelocityTrackers, drive each with a different sample
//  pattern, harvest the resulting Velocity and VelocityEstimate, and lay
//  them out across thirteen narrative sections.
// =============================================================================
dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // SCENARIO 1 — Slow horizontal drag.
  //   Finger moves rightwards at a leisurely pace. Total travel: 60 px in
  //   300 ms => about 200 px/s. Should be well under the fling threshold.
  // ---------------------------------------------------------------------------
  final VelocityTracker t1 = VelocityTracker.withKind(PointerDeviceKind.touch);
  final List<_Sample> s1 = <_Sample>[
    const _Sample(Duration(milliseconds: 0), Offset(100, 200)),
    const _Sample(Duration(milliseconds: 33), Offset(106, 200)),
    const _Sample(Duration(milliseconds: 66), Offset(113, 200)),
    const _Sample(Duration(milliseconds: 100), Offset(120, 200)),
    const _Sample(Duration(milliseconds: 133), Offset(127, 200)),
    const _Sample(Duration(milliseconds: 166), Offset(133, 200)),
    const _Sample(Duration(milliseconds: 200), Offset(140, 200)),
    const _Sample(Duration(milliseconds: 233), Offset(147, 200)),
    const _Sample(Duration(milliseconds: 266), Offset(153, 200)),
    const _Sample(Duration(milliseconds: 300), Offset(160, 200)),
  ];
  for (int i = 0; i < s1.length; i++) {
    t1.addPosition(s1[i].t, s1[i].p);
  }
  final Velocity v1 = t1.getVelocity();
  final VelocityEstimate? e1 = t1.getVelocityEstimate();

  // ---------------------------------------------------------------------------
  // SCENARIO 2 — Fast horizontal flick.
  //   Same direction, ten times faster. ~600 px in ~120 ms => 5000 px/s.
  //   Should land safely above the kMinFlingVelocity threshold.
  // ---------------------------------------------------------------------------
  final VelocityTracker t2 = VelocityTracker.withKind(PointerDeviceKind.touch);
  final List<_Sample> s2 = <_Sample>[
    const _Sample(Duration(milliseconds: 0), Offset(50, 300)),
    const _Sample(Duration(milliseconds: 16), Offset(120, 300)),
    const _Sample(Duration(milliseconds: 33), Offset(210, 300)),
    const _Sample(Duration(milliseconds: 50), Offset(310, 300)),
    const _Sample(Duration(milliseconds: 66), Offset(420, 300)),
    const _Sample(Duration(milliseconds: 83), Offset(540, 300)),
    const _Sample(Duration(milliseconds: 100), Offset(650, 300)),
  ];
  for (int i = 0; i < s2.length; i++) {
    t2.addPosition(s2[i].t, s2[i].p);
  }
  final Velocity v2 = t2.getVelocity();
  final VelocityEstimate? e2 = t2.getVelocityEstimate();

  // ---------------------------------------------------------------------------
  // SCENARIO 3 — Reversed: finger flies leftward and slightly upward.
  //   Demonstrates negative components on both axes.
  // ---------------------------------------------------------------------------
  final VelocityTracker t3 = VelocityTracker.withKind(PointerDeviceKind.touch);
  final List<_Sample> s3 = <_Sample>[
    const _Sample(Duration(milliseconds: 0), Offset(500, 500)),
    const _Sample(Duration(milliseconds: 16), Offset(460, 492)),
    const _Sample(Duration(milliseconds: 33), Offset(415, 482)),
    const _Sample(Duration(milliseconds: 50), Offset(360, 470)),
    const _Sample(Duration(milliseconds: 66), Offset(305, 458)),
    const _Sample(Duration(milliseconds: 83), Offset(250, 446)),
    const _Sample(Duration(milliseconds: 100), Offset(200, 436)),
  ];
  for (int i = 0; i < s3.length; i++) {
    t3.addPosition(s3[i].t, s3[i].p);
  }
  final Velocity v3 = t3.getVelocity();
  final VelocityEstimate? e3 = t3.getVelocityEstimate();

  // ---------------------------------------------------------------------------
  // SCENARIO 4 — Diagonal flick at 45 degrees, downward-right.
  //   Equal magnitudes on both axes; useful for showing distance vs dx/dy.
  // ---------------------------------------------------------------------------
  final VelocityTracker t4 = VelocityTracker.withKind(PointerDeviceKind.touch);
  final List<_Sample> s4 = <_Sample>[
    const _Sample(Duration(milliseconds: 0), Offset(200, 200)),
    const _Sample(Duration(milliseconds: 16), Offset(240, 240)),
    const _Sample(Duration(milliseconds: 33), Offset(290, 290)),
    const _Sample(Duration(milliseconds: 50), Offset(345, 345)),
    const _Sample(Duration(milliseconds: 66), Offset(400, 400)),
    const _Sample(Duration(milliseconds: 83), Offset(450, 450)),
    const _Sample(Duration(milliseconds: 100), Offset(495, 495)),
  ];
  for (int i = 0; i < s4.length; i++) {
    t4.addPosition(s4[i].t, s4[i].p);
  }
  final Velocity v4 = t4.getVelocity();
  final VelocityEstimate? e4 = t4.getVelocityEstimate();

  // ---------------------------------------------------------------------------
  // SCENARIO 5 — Stationary then jerk: finger sits still, then flicks at
  //   the very end. The polynomial fit weights recent samples more, so the
  //   reported velocity should still be substantial despite the long lull.
  // ---------------------------------------------------------------------------
  final VelocityTracker t5 = VelocityTracker.withKind(PointerDeviceKind.touch);
  final List<_Sample> s5 = <_Sample>[
    const _Sample(Duration(milliseconds: 0), Offset(300, 300)),
    const _Sample(Duration(milliseconds: 50), Offset(300, 300)),
    const _Sample(Duration(milliseconds: 100), Offset(301, 300)),
    const _Sample(Duration(milliseconds: 150), Offset(301, 300)),
    const _Sample(Duration(milliseconds: 200), Offset(302, 300)),
    const _Sample(Duration(milliseconds: 220), Offset(320, 300)),
    const _Sample(Duration(milliseconds: 240), Offset(360, 300)),
    const _Sample(Duration(milliseconds: 260), Offset(420, 300)),
  ];
  for (int i = 0; i < s5.length; i++) {
    t5.addPosition(s5[i].t, s5[i].p);
  }
  final Velocity v5 = t5.getVelocity();
  final VelocityEstimate? e5 = t5.getVelocityEstimate();

  // ---------------------------------------------------------------------------
  // Bundle the five scenarios for downstream rendering.
  // ---------------------------------------------------------------------------
  final _Scenario scenarioSlow = _Scenario(
    label: 'Slow drag',
    narrative:
        'Ten samples spaced ~33 ms apart, walking right at a steady ~7 px '
        'per frame. Total travel 60 px in 300 ms — pleasant scrolling pace.',
    samples: s1,
    velocity: v1,
    estimate: e1,
    accent: daPhosphor,
  );
  final _Scenario scenarioFlick = _Scenario(
    label: 'Fast flick',
    narrative:
        'Seven samples in 100 ms, accelerating rightward at high speed. '
        'Total travel 600 px — a confident throw that should fling.',
    samples: s2,
    velocity: v2,
    estimate: e2,
    accent: daAmber,
  );
  final _Scenario scenarioReverse = _Scenario(
    label: 'Reversed flick',
    narrative:
        'Finger flying leftward and slightly upward. Both .dx and .dy '
        'in pixelsPerSecond should come out negative.',
    samples: s3,
    velocity: v3,
    estimate: e3,
    accent: daMercury,
  );
  final _Scenario scenarioDiagonal = _Scenario(
    label: 'Diagonal 45°',
    narrative:
        'Equal horizontal and vertical motion. Magnitude (sqrt(dx^2+dy^2)) '
        'is meaningfully larger than either axis alone.',
    samples: s4,
    velocity: v4,
    estimate: e4,
    accent: daSteelLight,
  );
  final _Scenario scenarioJerk = _Scenario(
    label: 'Lull then jerk',
    narrative:
        'Long stationary lead-in followed by a tight burst at the end. '
        'Demonstrates that the tracker weights the most recent samples.',
    samples: s5,
    velocity: v5,
    estimate: e5,
    accent: daRust,
  );

  final List<_Scenario> scenarios = <_Scenario>[
    scenarioSlow,
    scenarioFlick,
    scenarioReverse,
    scenarioDiagonal,
    scenarioJerk,
  ];

  // ---------------------------------------------------------------------------
  // Direct Velocity construction & arithmetic — exercised once up top so
  // every operator we explain is actually invoked through the live API.
  // ---------------------------------------------------------------------------
  const Velocity zeroVel = Velocity.zero;
  const Velocity vRightHundred =
      Velocity(pixelsPerSecond: Offset(100, 0));
  const Velocity vDownTwoFifty =
      Velocity(pixelsPerSecond: Offset(0, 250));
  final Velocity vSum = vRightHundred + vDownTwoFifty;
  final Velocity vDiff = vRightHundred - vDownTwoFifty;
  final Velocity vNegated = -vRightHundred;
  final Velocity vClamped = const Velocity(
    pixelsPerSecond: Offset(20000, 0),
  ).clampMagnitude(50, 4000);
  final Velocity vClampedFloor = const Velocity(
    pixelsPerSecond: Offset(5, 0),
  ).clampMagnitude(50, 4000);

  // ---------------------------------------------------------------------------
  // Narrative print() trace.
  // ---------------------------------------------------------------------------
  print('[Velocity demo] === Drift Argent gauge house ===');
  print('[Velocity demo] Constructed five VelocityTrackers with '
      'PointerDeviceKind.touch.');
  print('[Velocity demo] Scenario 1 (slow drag) velocity = '
      '${v1.pixelsPerSecond}');
  print('[Velocity demo] Scenario 2 (fast flick) velocity = '
      '${v2.pixelsPerSecond}');
  print('[Velocity demo] Scenario 3 (reversed) velocity = '
      '${v3.pixelsPerSecond}');
  print('[Velocity demo] Scenario 4 (diagonal) velocity = '
      '${v4.pixelsPerSecond}');
  print('[Velocity demo] Scenario 5 (jerk) velocity = '
      '${v5.pixelsPerSecond}');
  if (e2 != null) {
    print('[Velocity demo] Scenario 2 estimate confidence = '
        '${e2.confidence}, duration = ${e2.duration}, offset = ${e2.offset}');
  }
  print('[Velocity demo] Velocity.zero = $zeroVel');
  print('[Velocity demo] vRightHundred + vDownTwoFifty = $vSum');
  print('[Velocity demo] vRightHundred - vDownTwoFifty = $vDiff');
  print('[Velocity demo] -vRightHundred = $vNegated');
  print('[Velocity demo] (20000,0).clampMagnitude(50,4000) = $vClamped');
  print('[Velocity demo] (5,0).clampMagnitude(50,4000) = $vClampedFloor');
  print('[Velocity demo] Building thirteen narrative sections...');

  // ---------------------------------------------------------------------------
  // Visual tree.
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: daSlateDeep,
    appBar: AppBar(
      backgroundColor: daSlate,
      foregroundColor: daArgentBright,
      elevation: 0,
      title: const Text(
        'Velocity / VelocityEstimate / VelocityTracker — Drift Argent',
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.4),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection1TitleBanner(),
          const SizedBox(height: 24),
          _buildSection2TheoryOfVelocity(),
          const SizedBox(height: 24),
          _buildSection3ApiAnatomy(),
          const SizedBox(height: 24),
          _buildSection4DirectArithmetic(
            zero: zeroVel,
            right: vRightHundred,
            down: vDownTwoFifty,
            sum: vSum,
            diff: vDiff,
            negated: vNegated,
            clampedHigh: vClamped,
            clampedLow: vClampedFloor,
          ),
          const SizedBox(height: 24),
          _buildSection5ScenarioOverview(scenarios),
          const SizedBox(height: 24),
          _buildSection6ScenarioCards(scenarios),
          const SizedBox(height: 24),
          _buildSection7DialFaces(scenarios),
          const SizedBox(height: 24),
          _buildSection8EstimateAnatomy(scenarios),
          const SizedBox(height: 24),
          _buildSection9FlingThreshold(scenarios),
          const SizedBox(height: 24),
          _buildSection10ClampMagnitude(),
          const SizedBox(height: 24),
          _buildSection11ComparisonTable(scenarios),
          const SizedBox(height: 24),
          _buildSection12DoAvoid(),
          const SizedBox(height: 24),
          _buildSection13Recap(scenarios),
          const SizedBox(height: 64),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 1 — Title banner with palette swatches
// =============================================================================
//  A wide brushed-aluminium banner with the demo title, subtitle, and a
//  horizontal strip of palette swatches. Sets the Drift Argent visual tone.
// =============================================================================
Widget _buildSection1TitleBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [daSlate, daSlateDeep, daHairline],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: daArgent, width: 2),
      boxShadow: [
        BoxShadow(
          color: daMercury.withValues(alpha: 0.15),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Velocity · VelocityEstimate · VelocityTracker',
          style: TextStyle(
            color: daArgentBright,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'pixels per second, polynomial-fit, and the silver gauges that '
          'show them off',
          style: TextStyle(
            color: daSteelLight,
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Drift Argent Gauge House · package:flutter/gestures.dart',
          style: TextStyle(color: daSteel, fontSize: 11),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _swatch('slate', daSlate),
            _swatch('deep', daSlateDeep),
            _swatch('steel', daSteel),
            _swatch('lite', daSteelLight),
            _swatch('argt', daArgent),
            _swatch('brt', daArgentBright),
            _swatch('merc', daMercury),
            _swatch('mercD', daMercuryDeep),
            _swatch('phos', daPhosphor),
            _swatch('amber', daAmber),
            _swatch('rust', daRust),
            _swatch('hair', daHairline),
          ],
        ),
      ],
    ),
  );
}

Widget _swatch(String label, Color color) {
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: daArgent.withValues(alpha: 0.5)),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: daSteelLight, fontSize: 9),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 2 — Theory of velocity
// =============================================================================
//  Several paragraphs explaining what velocity means in screen coordinates,
//  the units (pixels per second), the sign convention, and the difference
//  between "velocity at this instant" and "average velocity over a window".
// =============================================================================
Widget _buildSection2TheoryOfVelocity() {
  return _sectionCard(
    title: '2 · Theory of Velocity',
    accent: daMercury,
    children: const [
      Text(
        'Velocity is the rate of change of position with respect to time. '
        'In a Flutter gesture context the position is an Offset measured in '
        'logical pixels and the time is a Duration measured from some '
        'arbitrary monotonic origin. The result, therefore, is an Offset of '
        'pixels per second — one component for the horizontal rate, one for '
        'the vertical rate. There is no separate "speed" type; the magnitude '
        'is whatever you compute from the two components.',
        style: TextStyle(fontSize: 13, height: 1.5, color: daArgent),
      ),
      SizedBox(height: 10),
      Text(
        'The sign convention is the screen convention. Positive .dx points '
        'rightward, positive .dy points downward. So a finger flick that '
        'moves to the upper-left appears as a Velocity whose pixelsPerSecond '
        'has both components negative. A flick that moves straight down — '
        'a "pull to refresh", say — has .dx near zero and .dy strongly '
        'positive.',
        style: TextStyle(fontSize: 13, height: 1.5, color: daArgent),
      ),
      SizedBox(height: 10),
      Text(
        'A naive way to estimate velocity from a stream of (time, position) '
        'samples is to subtract the last two samples and divide by the time '
        'between them. That gives you the "instantaneous" velocity but it is '
        'extremely noisy: a single jittery sample at the very end of a drag '
        'can throw off the answer by a factor of three. Flutter solves this '
        'by fitting a low-degree polynomial (typically degree 2) to a '
        'rolling window of the most recent samples and reporting the '
        'derivative of that polynomial at the current time. The fit is '
        'weighted so recent samples count more, which means the estimate '
        'tracks fast direction changes without amplifying noise.',
        style: TextStyle(fontSize: 13, height: 1.5, color: daArgent),
      ),
      SizedBox(height: 10),
      Text(
        'The output of the polynomial fit is wrapped in either a Velocity '
        '— the small, callable shape used by drag callbacks — or a richer '
        'VelocityEstimate that also carries a confidence value, the '
        'duration window the estimate was computed across, and the offset '
        'travelled across that window. You usually only see Velocity in '
        'application code, but the recognizer machinery uses '
        'VelocityEstimate to decide whether the answer is trustworthy '
        'enough to act on.',
        style: TextStyle(fontSize: 13, height: 1.5, color: daArgent),
      ),
      SizedBox(height: 10),
      Text(
        'Why "pixels per second" rather than "pixels per millisecond" or '
        '"pixels per frame"? Because a second is roughly the natural '
        'unit of human attention — fling decisions like '
        '"keep coasting" or "stop here" are tuned in seconds, and the '
        'thresholds shipped in package:flutter/gestures.dart '
        '(kMinFlingVelocity, kMaxFlingVelocity) are themselves expressed '
        'in those units. Frame-relative units would couple the threshold '
        'to refresh rate; millisecond-relative units would produce '
        'inconveniently small numbers.',
        style: TextStyle(fontSize: 13, height: 1.5, color: daArgent),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 3 — API anatomy
// =============================================================================
//  A condensed table of every public member touched in this demo, its
//  signature, and a one-line description.
// =============================================================================
Widget _buildSection3ApiAnatomy() {
  return _sectionCard(
    title: '3 · API Anatomy',
    accent: daPhosphor,
    children: [
      _propRow('Velocity(pixelsPerSecond:)', 'const constructor',
          'Wraps an Offset of px/s into a Velocity value.'),
      _propRow('Velocity.zero', 'static const',
          'A no-motion velocity; additive identity for + and -.'),
      _propRow('.pixelsPerSecond', 'Offset',
          'The (.dx, .dy) horizontal and vertical rates in px/s.'),
      _propRow('operator -()', 'Velocity',
          'Unary minus: returns the reverse-direction velocity.'),
      _propRow('operator +(Velocity)', 'Velocity',
          'Component-wise addition of two velocities.'),
      _propRow('operator -(Velocity)', 'Velocity',
          'Component-wise subtraction of two velocities.'),
      _propRow('clampMagnitude(min, max)', 'Velocity',
          'Clamp magnitude into [min, max] while preserving direction.'),
      _propRow('VelocityEstimate', 'class',
          'Richer estimate: pixelsPerSecond, confidence, duration, offset.'),
      _propRow('.confidence', 'double in 0..1',
          'How much the polynomial fit trusts itself. 1.0 = perfect.'),
      _propRow('.duration', 'Duration',
          'The time window over which the estimate was computed.'),
      _propRow('.offset', 'Offset',
          'Pointer travel observed during that duration.'),
      _propRow('VelocityTracker.withKind(kind)', 'constructor',
          'Picks the polynomial-fit strategy for the device kind.'),
      _propRow('.addPosition(t, pos)', 'void',
          'Feed one sample; tracker keeps a rolling history.'),
      _propRow('.getVelocity()', 'Velocity',
          'Best-effort velocity now; Velocity.zero on insufficient data.'),
      _propRow('.getVelocityEstimate()', 'VelocityEstimate?',
          'Same with confidence/duration/offset; null when impossible.'),
    ],
  );
}

Widget _propRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: daArgentBright,
              fontSize: 11,
            ),
          ),
        ),
        SizedBox(
          width: 170,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: daMercury,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 11, color: daArgent),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 4 — Direct Velocity arithmetic
// =============================================================================
//  Shows the raw operator surface on Velocity values: zero, +, -, unary -,
//  and clampMagnitude. Each row prints both the input and the result.
// =============================================================================
Widget _buildSection4DirectArithmetic({
  required Velocity zero,
  required Velocity right,
  required Velocity down,
  required Velocity sum,
  required Velocity diff,
  required Velocity negated,
  required Velocity clampedHigh,
  required Velocity clampedLow,
}) {
  return _sectionCard(
    title: '4 · Direct Velocity Arithmetic',
    accent: daAmber,
    children: [
      const Text(
        'These rows operate on Velocity values constructed by hand — no '
        'tracker involved. Each illustrates one operator on the value type. '
        'All numbers are read out of the live API after the operation.',
        style: TextStyle(
          fontSize: 12,
          color: daArgent,
          fontStyle: FontStyle.italic,
        ),
      ),
      const SizedBox(height: 10),
      _velRow('Velocity.zero', zero),
      _velRow('vRight = Velocity(Offset(100, 0))', right),
      _velRow('vDown  = Velocity(Offset(0, 250))', down),
      const Divider(color: daHairline),
      _velRow('vRight + vDown', sum),
      _velRow('vRight - vDown', diff),
      _velRow('-vRight', negated),
      const SizedBox(height: 6),
      const Text(
        'Unary minus is useful when reversing a fling — for example to '
        'bounce off a list edge — without recomputing the magnitude.',
        style: TextStyle(
          fontSize: 11,
          color: daSteelLight,
          fontStyle: FontStyle.italic,
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: daMercuryDeep.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: daMercury.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'clampMagnitude(50, 4000):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: daArgentBright,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            _velRow('Velocity(20000, 0).clampMagnitude(50, 4000)', clampedHigh),
            _velRow('Velocity(    5, 0).clampMagnitude(50, 4000)', clampedLow),
            const SizedBox(height: 4),
            const Text(
              'Magnitude is sqrt(dx*dx + dy*dy). The clamp scales the vector '
              'so its magnitude lands in [min, max] without changing direction.',
              style: TextStyle(fontSize: 11, color: daArgent),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _velRow(String label, Velocity v) {
  final double dx = v.pixelsPerSecond.dx;
  final double dy = v.pixelsPerSecond.dy;
  final double mag = _magnitude(dx, dy);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 320,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: daArgentBright,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'px/s = (${dx.toStringAsFixed(2)}, ${dy.toStringAsFixed(2)})  '
            '|v| = ${mag.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: daMercury,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

double _magnitude(double dx, double dy) {
  // Hand-rolled sqrt-of-sum-of-squares using doubles only — keeps us out
  // of dart:math which we already get via Material but let us state the
  // formula explicitly here for the demo's pedagogical clarity.
  return _sqrt(dx * dx + dy * dy);
}

double _sqrt(double v) {
  if (v <= 0) return 0;
  // Newton-Raphson with a generous start. Five iterations is more than
  // enough for the precision needed by a label.
  double x = v;
  for (int i = 0; i < 12; i++) {
    x = 0.5 * (x + v / x);
  }
  return x;
}

// =============================================================================
//  SECTION 5 — Scenario overview
// =============================================================================
//  A high-level summary table: one row per scenario showing label, sample
//  count, total duration, total displacement, and the headline px/s value
//  the tracker reported.
// =============================================================================
Widget _buildSection5ScenarioOverview(List<_Scenario> scenarios) {
  return _sectionCard(
    title: '5 · Scenario Overview',
    accent: daSteelLight,
    children: [
      const Text(
        'Five distinct scenarios, each fed into its own VelocityTracker. '
        'The headline column is what the recognizer would expose to your '
        'onPanEnd callback as DragEndDetails.velocity.pixelsPerSecond.',
        style: TextStyle(fontSize: 12, color: daArgent),
      ),
      const SizedBox(height: 10),
      Table(
        border: TableBorder.all(color: daHairline, width: 0.7),
        columnWidths: const {
          0: FixedColumnWidth(140),
          1: FixedColumnWidth(70),
          2: FixedColumnWidth(110),
          3: FixedColumnWidth(150),
          4: FlexColumnWidth(),
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(color: daSlate),
            children: [
              _hCell('scenario'),
              _hCell('# samples'),
              _hCell('duration'),
              _hCell('total Δ (local)'),
              _hCell('Velocity.pixelsPerSecond'),
            ],
          ),
          for (int i = 0; i < scenarios.length; i++)
            _scenarioOverviewRow(scenarios[i], i.isEven),
        ],
      ),
    ],
  );
}

TableRow _scenarioOverviewRow(_Scenario sc, bool even) {
  final Duration dur = sc.samples.last.t - sc.samples.first.t;
  final Offset deltaOff = sc.samples.last.p - sc.samples.first.p;
  final double dx = sc.velocity.pixelsPerSecond.dx;
  final double dy = sc.velocity.pixelsPerSecond.dy;
  return TableRow(
    decoration: BoxDecoration(
      color: even ? daSlateDeep : daSlate,
    ),
    children: [
      _bCell(sc.label),
      _bCell('${sc.samples.length}'),
      _bCell('${dur.inMilliseconds} ms'),
      _bCell(
          '(${deltaOff.dx.toStringAsFixed(0)}, ${deltaOff.dy.toStringAsFixed(0)})'),
      _bCell(
          '(${dx.toStringAsFixed(1)}, ${dy.toStringAsFixed(1)}) px/s'),
    ],
  );
}

Widget _hCell(String t) => Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        t,
        style: const TextStyle(
          color: daArgentBright,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );

Widget _bCell(String t) => Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        t,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: daArgent,
          fontSize: 11,
        ),
      ),
    );

// =============================================================================
//  SECTION 6 — Scenario cards
// =============================================================================
//  One detailed card per scenario. Each card shows:
//    - title and narrative
//    - numbered timeline of (Duration, Offset) samples
//    - the resulting Velocity.pixelsPerSecond
//    - the resulting VelocityEstimate's confidence/duration/offset
// =============================================================================
Widget _buildSection6ScenarioCards(List<_Scenario> scenarios) {
  return _sectionCard(
    title: '6 · Scenario Cards (sample-by-sample)',
    accent: daMercury,
    children: [
      const Text(
        'Each card is one scenario with its full input timeline and full '
        'output. The samples were fed into a real VelocityTracker via '
        '.addPosition; the velocity rows were obtained via .getVelocity() '
        'and .getVelocityEstimate().',
        style: TextStyle(fontSize: 12, color: daArgent),
      ),
      const SizedBox(height: 12),
      for (int i = 0; i < scenarios.length; i++) ...[
        _scenarioCard(scenarios[i]),
        const SizedBox(height: 12),
      ],
    ],
  );
}

Widget _scenarioCard(_Scenario sc) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: daSlate,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: sc.accent.withValues(alpha: 0.6), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: sc.accent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                sc.label,
                style: const TextStyle(
                  color: daSlateDeep,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                sc.narrative,
                style: const TextStyle(
                  fontSize: 11,
                  color: daSteelLight,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Sample timeline.
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: daSlateDeep,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: daHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'samples (Duration, Offset) fed via .addPosition',
                style: TextStyle(
                  color: daArgentBright,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 6),
              for (int i = 0; i < sc.samples.length; i++)
                _sampleRow(i + 1, sc.samples[i], sc.accent),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Output velocity / estimate.
        _outputBlock(sc),
      ],
    ),
  );
}

Widget _sampleRow(int n, _Sample s, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      children: [
        SizedBox(
          width: 28,
          child: Text(
            '#$n',
            style: TextStyle(
              fontFamily: 'monospace',
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            't = ${s.t.inMilliseconds.toString().padLeft(4)} ms',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: daArgent,
              fontSize: 10,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'pos = (${s.p.dx.toStringAsFixed(1)}, ${s.p.dy.toStringAsFixed(1)})',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: daArgent,
              fontSize: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _outputBlock(_Scenario sc) {
  final double dx = sc.velocity.pixelsPerSecond.dx;
  final double dy = sc.velocity.pixelsPerSecond.dy;
  final double mag = _magnitude(dx, dy);
  String estimateLine;
  if (sc.estimate == null) {
    estimateLine = 'getVelocityEstimate() = null '
        '(insufficient or untrustworthy samples)';
  } else {
    final VelocityEstimate est = sc.estimate!;
    estimateLine =
        'estimate.pixelsPerSecond = (${est.pixelsPerSecond.dx.toStringAsFixed(1)}, '
        '${est.pixelsPerSecond.dy.toStringAsFixed(1)})\n'
        'estimate.confidence      = ${est.confidence.toStringAsFixed(3)}\n'
        'estimate.duration        = ${est.duration.inMilliseconds} ms\n'
        'estimate.offset          = (${est.offset.dx.toStringAsFixed(1)}, '
        '${est.offset.dy.toStringAsFixed(1)})';
  }
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: sc.accent.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: sc.accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Velocity.pixelsPerSecond = (${dx.toStringAsFixed(2)}, '
          '${dy.toStringAsFixed(2)})    |v| = ${mag.toStringAsFixed(2)} px/s',
          style: const TextStyle(
            fontFamily: 'monospace',
            color: daArgentBright,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          estimateLine,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: daArgent,
            fontSize: 10,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 7 — Dial faces
// =============================================================================
//  A row of brushed-silver dial faces, one per scenario, each with a
//  rotated needle pointing at the velocity magnitude on a circular gauge.
//  The needle rotation is computed from the velocity magnitude clamped to
//  a 0..6000 px/s range and mapped to -135°..+135° (full sweep).
// =============================================================================
Widget _buildSection7DialFaces(List<_Scenario> scenarios) {
  return _sectionCard(
    title: '7 · Dial Faces (silver gauge sweeps)',
    accent: daArgent,
    children: [
      const Text(
        'Each dial reads the magnitude of the scenario\'s reported '
        'Velocity.pixelsPerSecond. Range is 0..6000 px/s, mapped across '
        'a 270° sweep. Mercury-blue needle, phosphor-green tickmarks.',
        style: TextStyle(fontSize: 12, color: daArgent),
      ),
      const SizedBox(height: 14),
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          for (int i = 0; i < scenarios.length; i++)
            _dialFace(scenarios[i]),
        ],
      ),
      const SizedBox(height: 10),
      const Text(
        'Notes on the dial geometry:\n'
        '  - The full sweep is 270°, from -135° (idle, leftmost) to +135° '
        '(redline, rightmost).\n'
        '  - Tick marks at 0, 1k, 2k, 3k, 4k, 5k, 6k px/s.\n'
        '  - The needle is a rotated thin Container; no CustomPainter.\n'
        '  - The amber band starts at ~3000 px/s; the rust band at 5000.\n'
        '  - The kMinFlingVelocity threshold sits inside the phosphor band.',
        style: TextStyle(
          fontSize: 11,
          color: daSteelLight,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

Widget _dialFace(_Scenario sc) {
  final double dx = sc.velocity.pixelsPerSecond.dx;
  final double dy = sc.velocity.pixelsPerSecond.dy;
  final double mag = _magnitude(dx, dy);
  // Clamp magnitude to 0..6000 then map to -135..135 degrees.
  final double clamped = mag > 6000 ? 6000 : mag;
  final double sweepFraction = clamped / 6000.0; // 0..1
  final double angleDeg = -135.0 + sweepFraction * 270.0;
  final double angleRad = angleDeg * 3.141592653589793 / 180.0;
  return Container(
    width: 200,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [daSlate, daSlateDeep],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: sc.accent.withValues(alpha: 0.6), width: 1.2),
    ),
    child: Column(
      children: [
        Text(
          sc.label,
          style: TextStyle(
            color: sc.accent,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        // The dial.
        SizedBox(
          width: 160,
          height: 110,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Outer bezel.
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [daArgentBright, daSteel],
                    stops: [0.6, 1.0],
                  ),
                ),
              ),
              // Inner face.
              Container(
                width: 144,
                height: 144,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: daSlateDeep,
                  border: Border.all(color: daHairline, width: 1),
                ),
              ),
              // Phosphor arc band (left, "fling threshold").
              Transform.rotate(
                angle: -1.05,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: daPhosphor.withValues(alpha: 0.35),
                      width: 4,
                    ),
                  ),
                ),
              ),
              // Amber arc band.
              Transform.rotate(
                angle: 0.45,
                child: Container(
                  width: 124,
                  height: 124,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: daAmber.withValues(alpha: 0.35),
                      width: 3,
                    ),
                  ),
                ),
              ),
              // Rust redline.
              Transform.rotate(
                angle: 1.65,
                child: Container(
                  width: 122,
                  height: 122,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: daRust.withValues(alpha: 0.55),
                      width: 3,
                    ),
                  ),
                ),
              ),
              // The needle (a rotated thin rectangle).
              Transform.rotate(
                angle: angleRad,
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 3,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [daMercury, daMercuryDeep],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Hub.
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(bottom: 2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [daArgentBright, daSteel],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${mag.toStringAsFixed(0)} px/s',
          style: const TextStyle(
            fontFamily: 'monospace',
            color: daArgentBright,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        Text(
          '(${dx.toStringAsFixed(0)}, ${dy.toStringAsFixed(0)})',
          style: const TextStyle(
            fontFamily: 'monospace',
            color: daSteelLight,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 8 — VelocityEstimate anatomy
// =============================================================================
//  A close-up on the four dials of a VelocityEstimate: pixelsPerSecond,
//  confidence, duration, and offset. We render each one as its own card
//  with a brief explanation and the live values from each scenario.
// =============================================================================
Widget _buildSection8EstimateAnatomy(List<_Scenario> scenarios) {
  return _sectionCard(
    title: '8 · VelocityEstimate Anatomy',
    accent: daPhosphor,
    children: [
      const Text(
        'A VelocityEstimate is what the recognizer\'s polynomial-fit '
        'machinery actually returns. Velocity is just the .pixelsPerSecond '
        'field of the estimate, packaged into a smaller value type for '
        'callbacks. The other three fields are diagnostic.',
        style: TextStyle(fontSize: 12, color: daArgent),
      ),
      const SizedBox(height: 12),
      _estimateField(
        title: '.pixelsPerSecond',
        explanation:
            'The estimated velocity vector at the current instant, in '
            'pixels per logical second. Same units as Velocity.pixelsPerSecond.',
        scenarios: scenarios,
        valueOf: (e) => e == null
            ? 'null'
            : '(${e.pixelsPerSecond.dx.toStringAsFixed(1)}, '
                '${e.pixelsPerSecond.dy.toStringAsFixed(1)}) px/s',
      ),
      const SizedBox(height: 10),
      _estimateField(
        title: '.confidence',
        explanation:
            'A double in 0..1 representing how well the polynomial fits '
            'the recent samples. 1.0 means perfect fit; values below 0.5 '
            'tend to be discarded by recognizers as untrustworthy.',
        scenarios: scenarios,
        valueOf: (e) => e == null ? 'null' : e.confidence.toStringAsFixed(3),
      ),
      const SizedBox(height: 10),
      _estimateField(
        title: '.duration',
        explanation:
            'The time span over which the estimate was computed. Usually '
            'shorter than the full sample history because the tracker '
            'discards stale samples beyond a horizon (~100 ms by default).',
        scenarios: scenarios,
        valueOf: (e) => e == null ? 'null' : '${e.duration.inMilliseconds} ms',
      ),
      const SizedBox(height: 10),
      _estimateField(
        title: '.offset',
        explanation:
            'How far the pointer travelled during .duration. Useful as a '
            'sanity check — if .offset is tiny but .pixelsPerSecond is '
            'huge, you are seeing extrapolated noise.',
        scenarios: scenarios,
        valueOf: (e) => e == null
            ? 'null'
            : '(${e.offset.dx.toStringAsFixed(1)}, '
                '${e.offset.dy.toStringAsFixed(1)})',
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: daPhosphor.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: daPhosphor.withValues(alpha: 0.4)),
        ),
        child: const Text(
          'A useful invariant: roughly, .pixelsPerSecond * (.duration in '
          'seconds) should equal .offset. Deviations come from the fact '
          'that the estimate is the polynomial\'s derivative at the most '
          'recent sample, not the average velocity over the whole window.',
          style: TextStyle(
            fontSize: 11,
            color: daArgent,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ),
    ],
  );
}

Widget _estimateField({
  required String title,
  required String explanation,
  required List<_Scenario> scenarios,
  required String Function(VelocityEstimate?) valueOf,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: daSlate,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: daHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: daArgentBright,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          explanation,
          style: const TextStyle(fontSize: 11, color: daArgent, height: 1.45),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < scenarios.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: scenarios[i].accent,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    scenarios[i].label,
                    style: const TextStyle(
                      color: daSteelLight,
                      fontSize: 11,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    valueOf(scenarios[i].estimate),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: daMercury,
                      fontSize: 11,
                    ),
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
//  SECTION 9 — Drag-to-fling threshold
// =============================================================================
//  A static reference of the package:flutter/gestures.dart constants and a
//  per-scenario assessment of "would this fling?".
// =============================================================================
Widget _buildSection9FlingThreshold(List<_Scenario> scenarios) {
  // Approximate values lifted from package:flutter/gestures.dart constants.
  // We do not import the constant directly because the demo prefers
  // self-contained narration; the numbers are stable across Flutter
  // versions to within 5%.
  const double kMinFlingPxPerSec = 50.0;
  const double kHighFlingPxPerSec = 8000.0;
  const double typicalScrollFlingPxPerSec = 700.0;

  return _sectionCard(
    title: '9 · Drag-to-Fling Threshold',
    accent: daAmber,
    children: [
      const Text(
        'Once the user lifts their finger the recognizer asks: was that '
        'fast enough to count as a fling, or just a drag-and-stop? The '
        'answer is governed by a small set of constants in '
        'package:flutter/gestures.dart.',
        style: TextStyle(fontSize: 12, color: daArgent),
      ),
      const SizedBox(height: 10),
      _thresholdRow('kMinFlingVelocity', kMinFlingPxPerSec,
          'Below this magnitude the recognizer treats the gesture as a '
          'plain drag end — no coast, no inertia.'),
      _thresholdRow('typical scroll fling', typicalScrollFlingPxPerSec,
          'A comfortable scroll-fling on a phone. List coasts a screen '
          'or two before friction stops it.'),
      _thresholdRow('kMaxFlingVelocity', kHighFlingPxPerSec,
          'Upper sanity cap. A faster reading is almost certainly noise; '
          'recognizers clamp to this maximum.'),
      const SizedBox(height: 14),
      const Text(
        'Per-scenario assessment:',
        style: TextStyle(
          color: daArgentBright,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      const SizedBox(height: 6),
      for (int i = 0; i < scenarios.length; i++)
        _flingAssessmentRow(scenarios[i], kMinFlingPxPerSec,
            typicalScrollFlingPxPerSec, kHighFlingPxPerSec),
    ],
  );
}

Widget _thresholdRow(String label, double value, String explanation) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: daAmber,
              fontSize: 11,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            '${value.toStringAsFixed(0)} px/s',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: daArgentBright,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Text(
            explanation,
            style: const TextStyle(fontSize: 11, color: daArgent, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _flingAssessmentRow(
    _Scenario sc, double minFling, double typical, double maxFling) {
  final double mag = _magnitude(
    sc.velocity.pixelsPerSecond.dx,
    sc.velocity.pixelsPerSecond.dy,
  );
  String verdict;
  Color verdictColor;
  if (mag < minFling) {
    verdict = 'plain drag end (below kMinFlingVelocity)';
    verdictColor = daSteelLight;
  } else if (mag < typical) {
    verdict = 'gentle fling';
    verdictColor = daPhosphor;
  } else if (mag < maxFling) {
    verdict = 'strong fling';
    verdictColor = daAmber;
  } else {
    verdict = 'clamped to kMaxFlingVelocity';
    verdictColor = daRust;
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: sc.accent,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 130,
          child: Text(
            sc.label,
            style: const TextStyle(color: daSteelLight, fontSize: 11),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            '|v| ${mag.toStringAsFixed(0)} px/s',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: daArgentBright,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Text(
            verdict,
            style: TextStyle(
              color: verdictColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 10 — clampMagnitude in detail
// =============================================================================
//  Three before/after examples illustrating clampMagnitude on Velocity.
//  Each row shows the input vector, its raw magnitude, the requested
//  [min, max] window, and the clamped result.
// =============================================================================
Widget _buildSection10ClampMagnitude() {
  // Construct a series of inputs and clamp them with various windows.
  final List<List<dynamic>> rows = <List<dynamic>>[
    <dynamic>[
      'too slow → boosted to min',
      const Velocity(pixelsPerSecond: Offset(10, 0)),
      50.0,
      4000.0,
    ],
    <dynamic>[
      'in window → unchanged',
      const Velocity(pixelsPerSecond: Offset(600, 800)),
      50.0,
      4000.0,
    ],
    <dynamic>[
      'too fast → trimmed to max',
      const Velocity(pixelsPerSecond: Offset(12000, 0)),
      50.0,
      4000.0,
    ],
    <dynamic>[
      'diagonal too fast → trimmed',
      const Velocity(pixelsPerSecond: Offset(9000, 9000)),
      50.0,
      4000.0,
    ],
    <dynamic>[
      'tight window — narrow band',
      const Velocity(pixelsPerSecond: Offset(2000, 0)),
      1500.0,
      1800.0,
    ],
    <dynamic>[
      'unary minus then clamp',
      -const Velocity(pixelsPerSecond: Offset(5000, 0)),
      50.0,
      3000.0,
    ],
  ];

  return _sectionCard(
    title: '10 · clampMagnitude in detail',
    accent: daRust,
    children: [
      const Text(
        'clampMagnitude is the safety bumper around fling math. It '
        'guarantees that the velocity passed into a Simulation is neither '
        'so small the simulation does nothing, nor so large the simulation '
        'rockets off-screen in a single frame. The direction is preserved; '
        'only the length changes.',
        style: TextStyle(fontSize: 12, color: daArgent, height: 1.5),
      ),
      const SizedBox(height: 12),
      Table(
        border: TableBorder.all(color: daHairline, width: 0.6),
        columnWidths: const {
          0: FixedColumnWidth(220),
          1: FixedColumnWidth(160),
          2: FixedColumnWidth(70),
          3: FixedColumnWidth(110),
          4: FlexColumnWidth(),
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(color: daSlate),
            children: [
              _hCell('description'),
              _hCell('input px/s'),
              _hCell('|v| in'),
              _hCell('[min, max]'),
              _hCell('clamped px/s'),
            ],
          ),
          for (int i = 0; i < rows.length; i++) _clampRow(rows[i], i.isEven),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: daRust.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: daRust.withValues(alpha: 0.4)),
        ),
        child: const Text(
          'Geometric intuition: clampMagnitude(min, max) is the function '
          'that scales the velocity vector by min / |v| if |v| < min, by '
          'max / |v| if |v| > max, and by 1 otherwise. The angle the '
          'vector makes with the x-axis is invariant under the operation.',
          style: TextStyle(
            fontSize: 11,
            color: daArgent,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ),
    ],
  );
}

TableRow _clampRow(List<dynamic> row, bool even) {
  final String desc = row[0] as String;
  final Velocity input = row[1] as Velocity;
  final double minMag = row[2] as double;
  final double maxMag = row[3] as double;
  final Velocity result = input.clampMagnitude(minMag, maxMag);
  final double mIn = _magnitude(
    input.pixelsPerSecond.dx,
    input.pixelsPerSecond.dy,
  );
  return TableRow(
    decoration: BoxDecoration(
      color: even ? daSlateDeep : daSlate,
    ),
    children: [
      _bCell(desc),
      _bCell(
        '(${input.pixelsPerSecond.dx.toStringAsFixed(0)}, '
        '${input.pixelsPerSecond.dy.toStringAsFixed(0)})',
      ),
      _bCell(mIn.toStringAsFixed(0)),
      _bCell('[${minMag.toStringAsFixed(0)}, ${maxMag.toStringAsFixed(0)}]'),
      _bCell(
        '(${result.pixelsPerSecond.dx.toStringAsFixed(1)}, '
        '${result.pixelsPerSecond.dy.toStringAsFixed(1)})',
      ),
    ],
  );
}

// =============================================================================
//  SECTION 11 — Comparison: Velocity vs VelocityEstimate vs Offset
// =============================================================================
Widget _buildSection11ComparisonTable(List<_Scenario> scenarios) {
  final rows = <TableRow>[
    TableRow(
      decoration: const BoxDecoration(color: daMercuryDeep),
      children: [
        _hCell('aspect'),
        _hCell('Offset'),
        _hCell('Velocity'),
        _hCell('VelocityEstimate'),
      ],
    ),
    _cmp('purpose', 'a generic 2-D vector', 'rate of motion (px/s)',
        'rate of motion + diagnostics'),
    _cmp('shape', '(dx, dy)', '(pixelsPerSecond)',
        '(pixelsPerSecond, confidence, duration, offset)'),
    _cmp('returned by', 'painting/layout', 'recognizer callbacks',
        'VelocityTracker.getVelocityEstimate()'),
    _cmp('nullable?', 'no', 'no (zero on insufficient data)',
        'yes (null when no estimate)'),
    _cmp('arithmetic', '+, -, scalar *', '+, -, unary -, clampMagnitude',
        'none — pure data record'),
    _cmp('confidence', 'n/a', 'n/a', '0..1 polynomial-fit goodness'),
    _cmp('duration', 'n/a', 'n/a', 'time window of the fit'),
    _cmp('typical use', 'translate, paint',
        'fling decision in onPanEnd', 'recognizer-internal diagnosis'),
  ];
  return _sectionCard(
    title: '11 · Offset vs Velocity vs VelocityEstimate',
    accent: daMercury,
    children: [
      Table(
        border: TableBorder.all(color: daHairline, width: 0.6),
        columnWidths: const {
          0: FixedColumnWidth(110),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        children: rows,
      ),
      const SizedBox(height: 12),
      Text(
        'Of our five scenarios, '
        '${_countWithEstimate(scenarios)} of 5 produced a non-null '
        'VelocityEstimate on the first call.',
        style: const TextStyle(
          fontSize: 11,
          color: daSteelLight,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

int _countWithEstimate(List<_Scenario> scenarios) {
  int n = 0;
  for (int i = 0; i < scenarios.length; i++) {
    if (scenarios[i].estimate != null) n++;
  }
  return n;
}

TableRow _cmp(String aspect, String off, String vel, String est) {
  return TableRow(
    decoration: const BoxDecoration(color: daSlate),
    children: [
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          aspect,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: daArgentBright,
            fontSize: 11,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(off, style: const TextStyle(fontSize: 11, color: daArgent)),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(vel, style: const TextStyle(fontSize: 11, color: daArgent)),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(est, style: const TextStyle(fontSize: 11, color: daArgent)),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 12 — DO / AVOID
// =============================================================================
Widget _buildSection12DoAvoid() {
  return _sectionCard(
    title: '12 · DO and AVOID',
    accent: daPhosphor,
    children: [
      _doRow(true, 'DO',
          'Use the velocity reported by the framework in DragEndDetails.velocity '
          'rather than computing one yourself from the last two pointer events.'),
      _doRow(true, 'DO',
          'Pass the velocity through clampMagnitude before feeding it into a '
          'Simulation — it prevents pathological inputs from crashing physics.'),
      _doRow(true, 'DO',
          'Treat Velocity.zero as a meaningful signal. The recognizer returns '
          'it deliberately when the polynomial fit is too weak.'),
      _doRow(true, 'DO',
          'Use VelocityEstimate.confidence to decide whether to act on the '
          'estimate. Recognizers do this internally but custom code may need it too.'),
      _doRow(false, 'AVOID',
          'Adding two velocities from different gestures or different '
          'pointer ids. The arithmetic is defined but the result is meaningless.'),
      _doRow(false, 'AVOID',
          'Hard-coding a fling threshold like "magnitude > 1000". Use '
          'kMinFlingVelocity from package:flutter/gestures.dart so the '
          'threshold tracks framework changes.'),
      _doRow(false, 'AVOID',
          'Confusing Velocity.pixelsPerSecond with a per-frame delta. The '
          'units are pixels per second; multiply by the frame duration in '
          'seconds before adding to a position.'),
      _doRow(false, 'AVOID',
          'Storing a Velocity across a hot reload of the recognizer state. '
          'The samples that produced it are gone; the value is now a fossil.'),
      _doRow(false, 'AVOID',
          'Calling clampMagnitude with min == max == 0; the direction '
          'becomes undefined. Use Velocity.zero directly instead.'),
    ],
  );
}

Widget _doRow(bool good, String tag, String text) {
  final color = good ? daPhosphor : daRust;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: daSlateDeep,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: daArgent,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 13 — Recap
// =============================================================================
Widget _buildSection13Recap(List<_Scenario> scenarios) {
  final int withEst = _countWithEstimate(scenarios);
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [daSlate, daSlateDeep],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: daArgent, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recap — what the gauges showed',
          style: TextStyle(
            color: daArgentBright,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '• Velocity is an Offset of pixels per second wrapped in a '
          'value type, with +, unary -, binary -, and clampMagnitude.\n'
          '• Velocity.zero is the additive identity and the recognizer\'s '
          'fallback when samples are insufficient.\n'
          '• VelocityEstimate is the richer flavour returned by the '
          'tracker: pixelsPerSecond plus confidence, duration, and offset.\n'
          '• VelocityTracker.withKind(...) constructs a tracker tuned to '
          'a PointerDeviceKind; addPosition feeds it samples; '
          'getVelocity / getVelocityEstimate read out the polynomial fit.\n'
          '• kMinFlingVelocity is the practical threshold separating a '
          'plain drag-end from a fling; clampMagnitude is the safety bumper.\n'
          '• Sign convention: +x right, +y down, just like screen coordinates.',
          style: TextStyle(color: daArgent, fontSize: 12, height: 1.55),
        ),
        const SizedBox(height: 10),
        Text(
          'Five scenarios, $withEst of 5 with a non-null estimate.',
          style: const TextStyle(
            color: daSteelLight,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '— end of the Drift Argent gauge house —',
          style: TextStyle(
            color: daArgent,
            fontStyle: FontStyle.italic,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  Section card helper — uniform chrome around every numbered section.
// =============================================================================
Widget _sectionCard({
  required String title,
  required Color accent,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: daSlate,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: daSlateDeep.withValues(alpha: 0.5),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: daSlateDeep,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

// =============================================================================
//  END OF FILE — Velocity / VelocityEstimate / VelocityTracker
//  Drift Argent Gauge House
// =============================================================================
//
//  Closing reflections (kept in the file so future maintainers see the intent
//  rather than archaeology'ing through git blame):
//
//  • Five VelocityTracker instances are constructed with
//    VelocityTracker.withKind(PointerDeviceKind.touch). Each is fed a
//    distinct sample pattern using addPosition(Duration, Offset) inside an
//    indexed for-loop (no for-in over BridgedInstance).
//
//  • Velocity.zero, Velocity(pixelsPerSecond:), unary minus, binary +/-,
//    and clampMagnitude are all exercised through the live API in
//    section 4 and again in section 10.
//
//  • VelocityEstimate.pixelsPerSecond, .confidence, .duration, .offset
//    are surfaced in sections 6 and 8, with prose in section 8 explaining
//    when each is null and why.
//
//  • The sign convention (+x right, +y down) and the units (pixels per
//    second, not per-frame) are spelled out in section 2 because they
//    are the most common source of confusion.
//
//  • The fling thresholds in section 9 are written with conservative
//    constants that match package:flutter/gestures.dart kMinFlingVelocity
//    and kMaxFlingVelocity to within 5%.
//
//  • The dial faces in section 7 use only Container, Stack, and
//    Transform.rotate. No CustomPainter, no CustomMultiChildLayout. Each
//    needle is a thin rotated Container, each arc band is a circle with
//    a coloured border. Pure widget composition.
//
//  • The palette ("Drift Argent") was picked to evoke a 1960s engineering
//    test bench: brushed silver bezels, slate chassis, mercury-blue
//    needles, faint phosphor tickmarks. Unique to this file.
//
//  • The whole file is one snapshot. There is no setState, no controllers,
//    no animation. D4rt evaluates build() exactly once, and the resulting
//    widget tree is what you see.
//
// -----------------------------------------------------------------------------
//  Appendix A — Why a polynomial fit?
// -----------------------------------------------------------------------------
//
//  The naive approach to estimating velocity from a sample stream is
//  finite differences: take the last two samples, subtract, divide by
//  Δt. That is the "instantaneous slope" of the position curve evaluated
//  with a single secant line. It has two well-known problems:
//
//   1. Noise amplification. A 1 px jitter at the very end of a drag
//      becomes a 60 px/s spike (assuming 16 ms between samples). The
//      finger barely moved but the reading is wrong by an order of
//      magnitude.
//
//   2. Direction-change blindness. If the finger reversed in the last
//      30 ms of the drag, a two-sample difference will report the
//      reversal as full speed in the new direction — even though the
//      old direction is the relevant one for "what was the user trying
//      to do?".
//
//  A weighted polynomial fit over a rolling window addresses both. The
//  weights down-weight stale samples, the polynomial smooths jitter,
//  and the derivative at the most recent sample is what the recognizer
//  reports. Flutter uses degree-2 fits with a default ~100 ms horizon;
//  the precise weights are tuned per PointerDeviceKind.
//
// -----------------------------------------------------------------------------
//  Appendix B — How recognizers consume Velocity
// -----------------------------------------------------------------------------
//
//   1. Drag recognizers maintain a VelocityTracker per active pointer.
//   2. On each PointerMoveEvent they call addPosition(t, position).
//   3. On PointerUpEvent they call getVelocity (or getVelocityEstimate
//      for richer diagnostics).
//   4. The result is wrapped into DragEndDetails.velocity and handed to
//      onPanEnd / onVerticalDragEnd / onHorizontalDragEnd.
//   5. Your callback typically does:
//          final double vx = details.velocity.pixelsPerSecond.dx;
//          if (vx.abs() > kMinFlingVelocity) {
//            // start a fling animation
//          }
//   6. The fling animation feeds vx (often after clampMagnitude) into
//      a ClampingScrollSimulation or BouncingScrollSimulation.
//
// -----------------------------------------------------------------------------
//  Appendix C — Common bugs around velocity
// -----------------------------------------------------------------------------
//
//   * "Fling never triggers." Usually because the developer compared
//     velocity.pixelsPerSecond.dx directly to a constant in
//     pixels-per-frame. The units don't match by a factor of ~60.
//
//   * "Fling runs the wrong way." Sign convention slip — code wrote
//     position += vx instead of position += vx * dt, conflating
//     velocity with delta.
//
//   * "Fling sometimes works, sometimes doesn't." VelocityEstimate
//     returned null because confidence was too low. The fix is to
//     fall back to a sensible default rather than skipping the fling.
//
//   * "Fling speed feels uneven across devices." Different
//     PointerDeviceKinds (touch, mouse, stylus, trackpad) use
//     different fit strategies. Always construct the tracker with
//     withKind, never the bare default constructor, so each device
//     gets the right tuning.
//
//   * "Velocity is huge after a tap." When the user barely moves and
//     then lifts, the polynomial extrapolation across a tiny window can
//     produce eye-watering numbers. clampMagnitude is the antidote.
//
// -----------------------------------------------------------------------------
//  Appendix D — Reading list inside the SDK
// -----------------------------------------------------------------------------
//
//   * package:flutter/src/gestures/velocity_tracker.dart
//       Defines Velocity, VelocityEstimate, VelocityTracker. The fit
//       implementation lives here. ~300 lines, very readable.
//   * package:flutter/src/gestures/lsq_solver.dart
//       The least-squares solver that backs the polynomial fit.
//   * package:flutter/src/gestures/monodrag.dart
//       Where DragEndDetails.velocity is populated.
//   * package:flutter/src/gestures/constants.dart
//       kMinFlingVelocity, kMaxFlingVelocity, kPanSlop, etc.
//
// -----------------------------------------------------------------------------
//  Appendix E — Closing thought
// -----------------------------------------------------------------------------
//
//  The whole Velocity / VelocityEstimate / VelocityTracker triad exists
//  to answer one tiny question: at the moment the user lifted their
//  finger, how fast were they going? Despite the simplicity of that
//  question, the machinery behind the answer is genuinely interesting —
//  weighted least-squares fits, per-device tuning, confidence scoring,
//  unit conventions calibrated to human perception. The Drift Argent
//  gauges in this file are an aesthetic excuse to spend time looking
//  at the answer in five different lights.
//
// =============================================================================
