// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
// PRIORITY DEEP DEMO  -  Tide Cobalt Edition
// ============================================================================
//
// Target API: package:flutter/scheduler.dart   ->   class Priority
//
// Priority is an opaque integer wrapper used by SchedulerBinding.scheduleTask
// to order deferred (non-frame) work. It exposes three named constants that
// describe the *intent* of a scheduled task rather than a raw bucket index:
//
//   * Priority.idle       -> background, fill-the-gap work
//   * Priority.animation  -> visual, frame-bound work
//   * Priority.touch      -> input-derived, latency-sensitive work
//
// Each constant has an integer .value, and Priority defines operator+(int)
// so scripts may slide a few units above or below a named anchor without
// inventing magic integers. Priority.kMaxOffset (10000) bounds the legal
// distance between adjacent named anchors so offsets never silently leap
// across categories.
//
// ----------------------------------------------------------------------------
//  Why this demo exists
// ----------------------------------------------------------------------------
//
// scheduleTask() is one of the few APIs in the framework that lets author
// code participate in the cooperative scheduler used by Flutter itself for
// gestures, image decoding and background bookkeeping. Misusing Priority is
// the difference between dropped frames and a smooth experience: queueing a
// 6 ms blocking task at Priority.touch will preempt the very next gesture
// callback the engine wants to deliver.
//
// This file therefore documents:
//
//   1. The three named anchors and their numeric values.
//   2. How operator+ is meant to be used (small relative offsets only).
//   3. A typical 16ms frame budget and where idle work fits within it.
//   4. The do/avoid patterns observed across the framework codebase.
//   5. A glossary of scheduler vocabulary so the reader can map this back
//      to the rest of dart:ui and Flutter's binding layer.
//
// ----------------------------------------------------------------------------
//  Constraints (D4rt runtime)
// ----------------------------------------------------------------------------
//
//   * build() is invoked exactly once. The widget tree returned is a static
//     snapshot. There is no setState, no controller, no live timer.
//   * The script may construct Priority instances and read their .value
//     field, but must not subscribe to scheduler streams or schedule real
//     tasks against the embedder.
//   * All animation must be expressed as fixed visualizations (e.g. width-
//     proportional bars) rather than Tween-driven motion.
//
// ----------------------------------------------------------------------------
//  Theme: Tide Cobalt
// ----------------------------------------------------------------------------
//
// A deep-blue oceanic palette suggesting calm baseline + sharp accents,
// chosen because scheduling is fundamentally about *waves* of work breaking
// against a fixed frame cadence.
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ----------------------------------------------------------------------------
// Tide Cobalt palette (12 colors).
// ----------------------------------------------------------------------------
const Color cobaltAbyss      = Color(0xFF06122A); // deepest background
const Color cobaltMidnight   = Color(0xFF0B1E3F); // surface base
const Color cobaltDeep       = Color(0xFF132C5C); // card surface
const Color cobaltTide       = Color(0xFF1E4488); // primary accent
const Color cobaltCrest      = Color(0xFF2D63B8); // secondary accent
const Color cobaltSpray      = Color(0xFF5A8FE0); // hover/highlight
const Color cobaltFoam       = Color(0xFFB6D2F5); // soft highlight
const Color cobaltShell      = Color(0xFFE6EEF9); // text-on-dark
const Color cobaltAmber      = Color(0xFFE2A23B); // warning / animation
const Color cobaltCoral      = Color(0xFFE26B5A); // error / touch
const Color cobaltKelp       = Color(0xFF3E8C6E); // success / idle
const Color cobaltSlate      = Color(0xFF6C7A95); // muted text
const Color cobaltPearl      = Color(0xFFF5F8FC); // pure surface highlight
const Color cobaltInk        = Color(0xFF03070F); // outline / hairline

// ----------------------------------------------------------------------------
// Typography helpers
// ----------------------------------------------------------------------------
TextStyle _title(double size, Color color) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 0.4,
    );

TextStyle _body(Color color, {double size = 13, FontWeight w = FontWeight.w400}) =>
    TextStyle(fontSize: size, color: color, fontWeight: w, height: 1.45);

TextStyle _mono(Color color, {double size = 12}) => TextStyle(
      fontFamily: 'monospace',
      fontSize: size,
      color: color,
      height: 1.4,
    );

dynamic build(BuildContext context) {
  print('================================================================');
  print('Priority deep demo  ::  Tide Cobalt');
  print('================================================================');
  print('Constructing named priority anchors...');

  // ------------------------------------------------------------------
  // Construct priority values
  // ------------------------------------------------------------------
  final Priority pIdle      = Priority.idle;
  final Priority pAnimation = Priority.animation;
  final Priority pTouch     = Priority.touch;

  // Offsets above idle - background tasks of varied urgency.
  final Priority pIdlePlus10  = Priority.idle + 10;
  final Priority pIdlePlus100 = Priority.idle + 100;
  final Priority pIdlePlus500 = Priority.idle + 500;

  // Offsets near animation - frame-coupled tweaks.
  final Priority pAnimMinus1   = Priority.animation + (-1);
  final Priority pAnimPlus5    = Priority.animation + 5;
  final Priority pAnimPlus50   = Priority.animation + 50;

  // Offsets near touch - latency-sensitive variants.
  final Priority pTouchMinus10 = Priority.touch + (-10);
  final Priority pTouchPlus1   = Priority.touch + 1;

  print('  idle         = ${pIdle.value}');
  print('  idle+10      = ${pIdlePlus10.value}');
  print('  idle+100     = ${pIdlePlus100.value}');
  print('  idle+500     = ${pIdlePlus500.value}');
  print('  animation-1  = ${pAnimMinus1.value}');
  print('  animation    = ${pAnimation.value}');
  print('  animation+5  = ${pAnimPlus5.value}');
  print('  animation+50 = ${pAnimPlus50.value}');
  print('  touch-10     = ${pTouchMinus10.value}');
  print('  touch        = ${pTouch.value}');
  print('  touch+1      = ${pTouchPlus1.value}');
  print('  kMaxOffset   = ${Priority.kMaxOffset}');
  print('Total distinct priorities referenced: 11');

  // ==================================================================
  // SECTION 1 :: Title banner with palette swatches
  // ==================================================================
  print('Building section 1 - title banner');
  final Widget section1 = Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cobaltAbyss, cobaltDeep, cobaltTide],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cobaltCrest.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PRIORITY  ::  Tide Cobalt edition',
            style: _title(22, cobaltShell)),
        const SizedBox(height: 6),
        Text('Opaque integer wrapper for SchedulerBinding.scheduleTask',
            style: _body(cobaltFoam, size: 13)),
        const SizedBox(height: 6),
        Text('Three named anchors :: idle - animation - touch',
            style: _body(cobaltSpray, size: 12, w: FontWeight.w500)),
        const SizedBox(height: 14),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _swatch('abyss', cobaltAbyss),
            _swatch('midnight', cobaltMidnight),
            _swatch('deep', cobaltDeep),
            _swatch('tide', cobaltTide),
            _swatch('crest', cobaltCrest),
            _swatch('spray', cobaltSpray),
            _swatch('foam', cobaltFoam),
            _swatch('shell', cobaltShell),
            _swatch('amber', cobaltAmber),
            _swatch('coral', cobaltCoral),
            _swatch('kelp', cobaltKelp),
            _swatch('slate', cobaltSlate),
            _swatch('pearl', cobaltPearl),
            _swatch('ink', cobaltInk),
          ],
        ),
      ],
    ),
  );

  // ==================================================================
  // SECTION 2 :: Prose anatomy of scheduler tasks and frame budget
  // ==================================================================
  print('Building section 2 - prose anatomy');
  final Widget section2 = _proseCard(
    title: 'Anatomy :: scheduler tasks, frame budget, three priorities',
    paragraphs: const [
      'A SchedulerBinding task is a zero-argument callback the framework runs '
          'between frames when the engine has spare time. The task queue is '
          'sorted by Priority, so a task tagged Priority.touch runs before a '
          'task tagged Priority.idle even if the idle task was scheduled first.',
      'A frame is the unit of visual work the engine produces in lockstep with '
          'the display vsync. On a 60Hz display the frame budget is roughly '
          '16.6 ms; on 120Hz it shrinks to 8.3 ms. Inside the budget the engine '
          'must run vsync handlers, build, layout, paint, raster and presentation. '
          'Whatever time is left over is what scheduleTask gets to use.',
      'The three named priorities map to the three coarse intents of off-frame '
          'work. idle is fill-the-gap maintenance: cache eviction, prefetch, '
          'logging. animation is for callbacks that produce visible state for the '
          'next frame: e.g. lazy image decode for a tile that just scrolled in. '
          'touch is for input echoes: hit-test follow-ups, gesture arbitration, '
          'haptic triggers. Touch tasks should be very small.',
      'Priority is purposely an opaque wrapper. The integer .value is exposed '
          'for sorting, but library code is expected to anchor its choices to '
          'one of the three constants and use operator+ for fine adjustments.',
    ],
  );

  // ==================================================================
  // SECTION 3 :: Property anatomy of each named priority
  // ==================================================================
  print('Building section 3 - property anatomy');
  final Widget section3 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Property anatomy :: idle / animation / touch',
            style: _title(16, cobaltShell)),
        const SizedBox(height: 12),
        _priorityCard(
          name: 'Priority.idle',
          value: pIdle.value,
          accent: cobaltKelp,
          role: 'Background maintenance, lowest urgency.',
          examples: const [
            'Cache eviction sweeps',
            'Telemetry batch flush',
            'Hero image prefetch for off-screen routes',
            'Garbage compaction in long-lived stores',
          ],
        ),
        const SizedBox(height: 10),
        _priorityCard(
          name: 'Priority.animation',
          value: pAnimation.value,
          accent: cobaltAmber,
          role: 'Visible state work bound to the next frame.',
          examples: const [
            'Decode a bitmap that just scrolled into view',
            'Compute a layout result before commit',
            'Pump physics one tick',
            'Recompute derived selection geometry',
          ],
        ),
        const SizedBox(height: 10),
        _priorityCard(
          name: 'Priority.touch',
          value: pTouch.value,
          accent: cobaltCoral,
          role: 'Input echo, latency-sensitive, must stay tiny.',
          examples: const [
            'Hit-test follow-up after a tap',
            'Gesture arbitration tail work',
            'Trigger haptic feedback',
            'Promote a candidate widget for pointer hover',
          ],
        ),
      ],
    ),
  );

  // ==================================================================
  // SECTION 4 :: Construction gallery (named + offset combinations)
  // ==================================================================
  print('Building section 4 - construction gallery');
  final Widget section4 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Construction gallery :: 11 priorities',
            style: _title(16, cobaltShell)),
        const SizedBox(height: 4),
        Text('Each card constructs a Priority and reads .value back as Text.',
            style: _body(cobaltSlate, size: 12)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _galleryCard('Priority.idle', pIdle.value, cobaltKelp),
            _galleryCard('Priority.idle + 10', pIdlePlus10.value, cobaltKelp),
            _galleryCard('Priority.idle + 100', pIdlePlus100.value, cobaltKelp),
            _galleryCard('Priority.idle + 500', pIdlePlus500.value, cobaltKelp),
            _galleryCard('Priority.animation - 1', pAnimMinus1.value, cobaltAmber),
            _galleryCard('Priority.animation', pAnimation.value, cobaltAmber),
            _galleryCard('Priority.animation + 5', pAnimPlus5.value, cobaltAmber),
            _galleryCard('Priority.animation + 50', pAnimPlus50.value, cobaltAmber),
            _galleryCard('Priority.touch - 10', pTouchMinus10.value, cobaltCoral),
            _galleryCard('Priority.touch', pTouch.value, cobaltCoral),
            _galleryCard('Priority.touch + 1', pTouchPlus1.value, cobaltCoral),
          ],
        ),
      ],
    ),
  );

  // ==================================================================
  // SECTION 5 :: Priority bar chart (bars proportional to .value)
  // ==================================================================
  print('Building section 5 - priority bar chart');
  // Normalize bar widths against touch (highest).
  final int maxV = pTouch.value;
  final double idleW = (pIdle.value      / maxV) * 320.0;
  final double animW = (pAnimation.value / maxV) * 320.0;
  final double touchW = 320.0;
  // Defensive: idleW is 0 when value is 0, render a tiny stub so it remains
  // visible to the reader.
  final double idleVisualW = idleW < 4 ? 4.0 : idleW;
  final Widget section5 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bar chart :: relative .value of each anchor',
            style: _title(16, cobaltShell)),
        const SizedBox(height: 4),
        Text('Width proportional to .value, scaled against touch.',
            style: _body(cobaltSlate, size: 12)),
        const SizedBox(height: 12),
        _barRow('idle',      pIdle.value,      idleVisualW, cobaltKelp),
        const SizedBox(height: 8),
        _barRow('animation', pAnimation.value, animW, cobaltAmber),
        const SizedBox(height: 8),
        _barRow('touch',     pTouch.value,     touchW, cobaltCoral),
        const SizedBox(height: 12),
        Text('idle has .value 0 so the bar is rendered as a 4px stub.',
            style: _body(cobaltSlate, size: 11)),
      ],
    ),
  );

  // ==================================================================
  // SECTION 6 :: SchedulerBinding interaction prose
  // ==================================================================
  print('Building section 6 - SchedulerBinding prose');
  final Widget section6 = _proseCard(
    title: 'SchedulerBinding :: scheduleTask, handleEventLoopCallback, ordering',
    paragraphs: const [
      'SchedulerBinding.scheduleTask<T>(callback, priority) returns a Future<T> '
          'that completes once the framework has chosen to run callback in a '
          'gap between frames. The Priority you pass is what the binding uses '
          'to sort the queue. Higher .value runs first.',
      'When the event loop has nothing else to do, the binding fires '
          'handleEventLoopCallback. That callback drains as many tasks as fit '
          'before the next vsync. Because draining is bounded by the remaining '
          'frame budget, a long task at any priority will simply be deferred '
          'to the next gap; it will not preempt itself mid-execution.',
      'Frame-relative ordering matters: tasks scheduled during the build phase '
          'will not run until *after* the current frame has been rasterized. So '
          'priorities are about ordering across multiple deferred jobs, not '
          'about beating the current frame.',
      'The framework itself uses Priority.touch internally for hit-test follow-'
          'up; Priority.animation for image stream completion; Priority.idle '
          'for things like ImageCache eviction. Application code should rarely '
          'need to invent its own anchor - reach for an offset first.',
    ],
  );

  // ==================================================================
  // SECTION 7 :: Comparison table of typical priority + offset choices
  // ==================================================================
  print('Building section 7 - comparison table');
  final Widget section7 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comparison table :: typical priority choices',
            style: _title(16, cobaltShell)),
        const SizedBox(height: 12),
        _tableHeader(),
        _tableRow('Priority.idle',          pIdle.value,        'analytics flush', cobaltKelp),
        _tableRow('Priority.idle + 10',     pIdlePlus10.value,  'low-pri prefetch', cobaltKelp),
        _tableRow('Priority.idle + 100',    pIdlePlus100.value, 'lazy log rotate', cobaltKelp),
        _tableRow('Priority.idle + 500',    pIdlePlus500.value, 'lazy thumb decode', cobaltKelp),
        _tableRow('Priority.animation - 1', pAnimMinus1.value,  'frame trailer', cobaltAmber),
        _tableRow('Priority.animation',     pAnimation.value,   'image stream complete', cobaltAmber),
        _tableRow('Priority.animation + 5', pAnimPlus5.value,   'physics tick', cobaltAmber),
        _tableRow('Priority.animation + 50',pAnimPlus50.value,  'critical layout pre-pass', cobaltAmber),
        _tableRow('Priority.touch - 10',    pTouchMinus10.value,'gesture cleanup', cobaltCoral),
        _tableRow('Priority.touch',         pTouch.value,       'hit-test follow-up', cobaltCoral),
        _tableRow('Priority.touch + 1',     pTouchPlus1.value,  'haptic trigger', cobaltCoral),
        _tableRow('Priority.idle + 9999',   (Priority.idle + 9999).value, 'almost-animation idle', cobaltSlate),
      ],
    ),
  );

  // ==================================================================
  // SECTION 8 :: 16ms frame budget visualization
  // ==================================================================
  print('Building section 8 - frame budget visualization');
  final Widget section8 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frame budget :: 16.6 ms split across phases',
            style: _title(16, cobaltShell)),
        const SizedBox(height: 4),
        Text('Idle work runs in whatever slack remains after rasterization.',
            style: _body(cobaltSlate, size: 12)),
        const SizedBox(height: 12),
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: cobaltAbyss,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: cobaltInk),
          ),
          child: Row(
            children: [
              _frameSlice('vsync',    1.0,  cobaltSpray),
              _frameSlice('build',    3.0,  cobaltCrest),
              _frameSlice('layout',   2.5,  cobaltTide),
              _frameSlice('paint',    2.0,  cobaltDeep),
              _frameSlice('raster',   3.5,  cobaltMidnight),
              _frameSlice('present',  0.6,  cobaltAmber),
              _frameSlice('idle',     4.0,  cobaltKelp),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 6,
          children: [
            _legend('vsync 1.0 ms',   cobaltSpray),
            _legend('build 3.0 ms',   cobaltCrest),
            _legend('layout 2.5 ms',  cobaltTide),
            _legend('paint 2.0 ms',   cobaltDeep),
            _legend('raster 3.5 ms',  cobaltMidnight),
            _legend('present 0.6 ms', cobaltAmber),
            _legend('idle 4.0 ms',    cobaltKelp),
          ],
        ),
        const SizedBox(height: 8),
        Text('Tasks at Priority.idle compete for that final ~4 ms slice.',
            style: _body(cobaltFoam, size: 12)),
        Text('Tasks at Priority.animation can join build/paint piggy-back work.',
            style: _body(cobaltFoam, size: 12)),
        Text('Tasks at Priority.touch should fit in microseconds, not millis.',
            style: _body(cobaltFoam, size: 12)),
      ],
    ),
  );

  // ==================================================================
  // SECTION 9 :: DO / AVOID callouts
  // ==================================================================
  print('Building section 9 - do/avoid callouts');
  final Widget section9 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DO / AVOID :: 8 rules of thumb',
            style: _title(16, cobaltShell)),
        const SizedBox(height: 12),
        _doRow('DO anchor every Priority on idle, animation, or touch.'),
        _doRow('DO use small operator+ offsets (under 100) for siblings.'),
        _doRow('DO keep touch-priority tasks shorter than 1 ms.'),
        _doRow('DO move analytics, prefetch and cleanup to idle priority.'),
        _avoidRow('AVOID constructing Priority via raw integers in app code.'),
        _avoidRow('AVOID queueing image decode at touch priority.'),
        _avoidRow('AVOID offsets larger than kMaxOffset (10000).'),
        _avoidRow('AVOID assuming a touch task preempts an in-flight task.'),
      ],
    ),
  );

  // ==================================================================
  // SECTION 10 :: Code-snippet recipes
  // ==================================================================
  print('Building section 10 - code-snippet recipes');
  final Widget section10 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recipes :: 5 idiomatic uses',
            style: _title(16, cobaltShell)),
        const SizedBox(height: 12),
        _codeCard('Recipe 1 :: schedule an idle prefetch',
          'SchedulerBinding.instance.scheduleTask(\n'
          '  () => prefetchTile(tileId),\n'
          '  Priority.idle,\n'
          ');'),
        _codeCard('Recipe 2 :: animation-coupled image decode',
          'SchedulerBinding.instance.scheduleTask(\n'
          '  () => decodeImage(bytes),\n'
          '  Priority.animation,\n'
          ');'),
        _codeCard('Recipe 3 :: relative offset for sibling ordering',
          'final p = Priority.animation + 5;\n'
          'SchedulerBinding.instance.scheduleTask(work, p);'),
        _codeCard('Recipe 4 :: touch follow-up',
          'SchedulerBinding.instance.scheduleTask(\n'
          '  () => triggerHaptic(),\n'
          '  Priority.touch,\n'
          ');'),
        _codeCard('Recipe 5 :: lazy log rotation',
          'final p = Priority.idle + 100;\n'
          'SchedulerBinding.instance.scheduleTask(\n'
          '  () => rotateLogs(),\n'
          '  p,\n'
          ');'),
      ],
    ),
  );

  // ==================================================================
  // SECTION 11 :: Glossary
  // ==================================================================
  print('Building section 11 - glossary');
  final Widget section11 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Glossary :: 14 terms',
            style: _title(16, cobaltShell)),
        const SizedBox(height: 12),
        _glossRow('Priority',        'Opaque integer wrapper used to order scheduled tasks.'),
        _glossRow('Priority.idle',   'Background anchor with .value 0.'),
        _glossRow('Priority.animation','Frame-coupled anchor sitting between idle and touch.'),
        _glossRow('Priority.touch',  'Highest named anchor, for input echo work.'),
        _glossRow('kMaxOffset',      'Upper bound (10000) on legal operator+ offsets.'),
        _glossRow('operator+',       'Returns a new Priority offset by an integer.'),
        _glossRow('value',           'Integer used by the binding for sort comparison.'),
        _glossRow('SchedulerBinding','The framework binding that runs scheduled tasks.'),
        _glossRow('scheduleTask',    'API to enqueue a callback at a chosen priority.'),
        _glossRow('handleEventLoopCallback','Drains the priority queue between frames.'),
        _glossRow('frame budget',    'Time the engine has per vsync (~16.6ms at 60Hz).'),
        _glossRow('vsync',           'Display refresh signal that drives frame production.'),
        _glossRow('rasterization',   'Turning paint commands into pixels for display.'),
        _glossRow('hit-test',        'Walk of the render tree to find pointer targets.'),
      ],
    ),
  );

  // ==================================================================
  // SECTION 12 :: Recap footer
  // ==================================================================
  print('Building section 12 - recap footer');
  final Widget section12 = Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [cobaltAbyss, cobaltMidnight, cobaltDeep],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cobaltCrest.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recap',
            style: _title(18, cobaltShell)),
        const SizedBox(height: 8),
        Text('Priority is opaque. Use idle / animation / touch as anchors.',
            style: _body(cobaltFoam, size: 13)),
        Text('Use small operator+ offsets only. Stay under kMaxOffset.',
            style: _body(cobaltFoam, size: 13)),
        Text('Touch tasks must be tiny. Idle tasks may be larger.',
            style: _body(cobaltFoam, size: 13)),
        Text('SchedulerBinding.scheduleTask(callback, priority) is the API.',
            style: _body(cobaltFoam, size: 13)),
        const SizedBox(height: 10),
        Text('idle=${pIdle.value} animation=${pAnimation.value} '
             'touch=${pTouch.value} kMaxOffset=${Priority.kMaxOffset}',
            style: _mono(cobaltSpray)),
      ],
    ),
  );

  print('All 12 sections constructed');
  print('================================================================');
  print('Returning Scaffold + SingleChildScrollView snapshot');
  print('================================================================');

  return Scaffold(
    backgroundColor: cobaltAbyss,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          section1,
          const SizedBox(height: 16),
          section2,
          const SizedBox(height: 16),
          section3,
          const SizedBox(height: 16),
          section4,
          const SizedBox(height: 16),
          section5,
          const SizedBox(height: 16),
          section6,
          const SizedBox(height: 16),
          section7,
          const SizedBox(height: 16),
          section8,
          const SizedBox(height: 16),
          section9,
          const SizedBox(height: 16),
          section10,
          const SizedBox(height: 16),
          section11,
          const SizedBox(height: 16),
          section12,
        ],
      ),
    ),
  );
}

// ============================================================================
// Helper widget builders
// ============================================================================

BoxDecoration _surfaceDecoration() => BoxDecoration(
      color: cobaltMidnight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cobaltDeep),
      boxShadow: [
        BoxShadow(
          color: cobaltInk.withValues(alpha: 0.6),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );

Widget _swatch(String name, Color c) {
  return Container(
    width: 78,
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    decoration: BoxDecoration(
      color: cobaltAbyss.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cobaltInk),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: cobaltInk),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(name, style: _body(cobaltShell, size: 10),
              overflow: TextOverflow.ellipsis),
        ),
      ],
    ),
  );
}

Widget _proseCard({required String title, required List<String> paragraphs}) {
  final List<Widget> kids = <Widget>[
    Text(title, style: _title(16, cobaltShell)),
    const SizedBox(height: 10),
  ];
  for (int i = 0; i < paragraphs.length; i++) {
    kids.add(Text(paragraphs[i], style: _body(cobaltFoam, size: 13)));
    if (i != paragraphs.length - 1) kids.add(const SizedBox(height: 8));
  }
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: _surfaceDecoration(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: kids),
  );
}

Widget _priorityCard({
  required String name,
  required int value,
  required Color accent,
  required String role,
  required List<String> examples,
}) {
  final List<Widget> bullets = <Widget>[];
  for (int i = 0; i < examples.length; i++) {
    bullets.add(Padding(
      padding: const EdgeInsets.only(left: 12, top: 2),
      child: Text('- ' + examples[i], style: _body(cobaltShell, size: 12)),
    ));
  }
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cobaltDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(name, style: _title(14, cobaltShell)),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('.value = ' + value.toString(),
                  style: _mono(cobaltShell, size: 11)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(role, style: _body(cobaltFoam, size: 12)),
        const SizedBox(height: 4),
        ...bullets,
      ],
    ),
  );
}

Widget _galleryCard(String label, int v, Color accent) {
  return Container(
    width: 200,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cobaltDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: _mono(cobaltSpray, size: 11)),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text('.value', style: _body(cobaltSlate, size: 11)),
            const SizedBox(width: 6),
            Text(v.toString(),
                style: _title(15, cobaltShell)),
          ],
        ),
      ],
    ),
  );
}

Widget _barRow(String name, int value, double width, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 90,
        child: Text(name, style: _body(cobaltShell, size: 12, w: FontWeight.w600)),
      ),
      Container(
        width: width,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: cobaltInk),
        ),
      ),
      const SizedBox(width: 8),
      Text(value.toString(), style: _mono(cobaltFoam, size: 12)),
    ],
  );
}

Widget _tableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: cobaltDeep,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 220,
          child: Text('Priority expression',
              style: _body(cobaltSpray, size: 12, w: FontWeight.w700)),
        ),
        SizedBox(
          width: 70,
          child: Text('.value',
              style: _body(cobaltSpray, size: 12, w: FontWeight.w700)),
        ),
        Expanded(
          child: Text('Use case',
              style: _body(cobaltSpray, size: 12, w: FontWeight.w700)),
        ),
      ],
    ),
  );
}

Widget _tableRow(String expr, int v, String useCase, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: cobaltInk, width: 0.4)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 220,
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(expr,
                    style: _mono(cobaltShell, size: 11),
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(v.toString(), style: _mono(cobaltFoam, size: 11)),
        ),
        Expanded(
          child: Text(useCase, style: _body(cobaltShell, size: 11)),
        ),
      ],
    ),
  );
}

Widget _frameSlice(String label, double ms, Color color) {
  // 16.6 ms total. width per ms = (totalWidth / 16.6).
  // We let the row fill, so use Expanded with flex == ms*10 (preserve fraction).
  final int flex = (ms * 10).round();
  return Expanded(
    flex: flex,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        border: Border(right: BorderSide(color: cobaltInk, width: 0.5)),
      ),
      alignment: Alignment.center,
      child: Text(label,
          style: _mono(cobaltShell, size: 9),
          overflow: TextOverflow.clip),
    ),
  );
}

Widget _legend(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: cobaltInk),
        ),
      ),
      const SizedBox(width: 5),
      Text(label, style: _body(cobaltShell, size: 11)),
    ],
  );
}

Widget _doRow(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: cobaltKelp,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('DO', style: _body(cobaltShell, size: 10, w: FontWeight.w800)),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: _body(cobaltShell, size: 12))),
      ],
    ),
  );
}

Widget _avoidRow(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: cobaltCoral,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('AVOID', style: _body(cobaltShell, size: 10, w: FontWeight.w800)),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: _body(cobaltShell, size: 12))),
      ],
    ),
  );
}

Widget _codeCard(String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cobaltAbyss,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cobaltDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _body(cobaltSpray, size: 12, w: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(body, style: _mono(cobaltFoam, size: 11)),
        ],
      ),
    ),
  );
}

Widget _glossRow(String term, String def) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170,
          child: Text(term,
              style: _body(cobaltSpray, size: 12, w: FontWeight.w700)),
        ),
        Expanded(
          child: Text(def, style: _body(cobaltShell, size: 12)),
        ),
      ],
    ),
  );
}

// ============================================================================
// APPENDIX :: Extended scheduler narrative
// ============================================================================
//
// The remainder of this file is documentation. It exists in source form so
// readers can inspect the rationale alongside the live demo without having to
// open a separate markdown file. It is *not* compiled into the rendered tree;
// it is preserved as comments because D4rt scripts often have only a single
// file per topic, and a colocated narrative is easier to maintain than a
// separate doc.
//
// A1 :: Why three priorities?
//
// Real-world scheduling research has converged on three coarse buckets. Two
// is too few - you cannot tell maintenance work from frame-coupled work. Five
// is too many - developers cannot reliably distinguish between four shades of
// urgency. Three matches the common pattern of 'background', 'soon',
// 'now-ish'. Flutter's choice mirrors that of the Web Animations spec and the
// iOS QoS classes.
//

// A2 :: Why integers and not enums?
//
// Enums would force every consumer to introduce a new symbol whenever a
// subtle ordering distinction is needed. With integers and operator+, the
// developer can express 'a hair higher than animation' as Priority.animation
// + 5 without any new top-level definition. The cost is that the .value of
// any Priority is technically observable, but library code that reads it is
// almost always sorting comparators.
//

// A3 :: Why is kMaxOffset 10000?
//
// It is chosen to be larger than any sane developer will use, but small
// enough that the gaps between named anchors remain meaningful. Anchors are
// spaced by enough room (10000) that 100 well-behaved offsets within a
// category never spill into the next. If a script needs more than that, it is
// almost certainly trying to invent a fourth category and should pick a
// different anchor instead.
//

// A4 :: Idle does not mean 'never'
//
// A common misconception is that Priority.idle means 'run when the device is
// unused for a while'. It does not. It means 'run when the framework binding
// finds itself with spare time *between frames*'. On a busy app this can
// still happen many times a second.
//

// A5 :: Touch does not mean 'preempt'
//
// Priority.touch does not interrupt an in-flight task. The binding only
// consults the queue when it is about to pick the next task. If a 12 ms task
// is currently running at idle priority, a touch task scheduled mid-way still
// has to wait. This is why touch tasks must be tiny, and why long-running
// idle work must be chunked.
//

// A6 :: Animation is not just for animations
//
// Despite the name, Priority.animation is appropriate for any work that
// produces visible state for the next frame. Image stream completion, lazy
// layout pre-pass, derived geometry recomputation: all of these fit. Reserve
// Priority.touch for things genuinely caused by a pointer event.
//

// A7 :: Batching strategies
//
// If you find yourself scheduling many idle tasks for the same effect,
// consider scheduling one task that performs the batch. The scheduler is not
// free; each enqueue/dequeue costs a small amount of time, and fragmentation
// of the queue can cause higher-priority work to be slightly delayed by the
// cost of skipping past lots of idle entries.
//

// A8 :: Profiling priorities
//
// When in doubt, run with --profile and watch the Timeline. The category
// 'SchedulerBinding.handleEventLoopCallback' shows when the binding is
// draining the queue, and individual tasks are visible by their callback
// name. If you see a long red bar at touch priority, that is the most likely
// culprit for a janky frame.
//

// A9 :: Comparing to Microtasks and Timers
//
// Microtasks are unconditionally run as soon as the current synchronous frame
// yields. They have no priority and should be reserved for trivial
// follow-ups. Timer.run schedules onto the event loop without binding
// awareness, meaning it can fire mid-frame and degrade smoothness.
// scheduleTask + Priority is the only API that respects the frame boundary.
//

// A10 :: Composing with image cache
//
// ImageCache itself uses Priority.animation internally for image stream
// completion. If your app is heavily image-driven, scheduling additional work
// at exactly Priority.animation may queue behind decode tasks. Consider
// Priority.animation - 1 for follow-up that should run after decodes have
// settled.
//

// A11 :: Composing with gestures
//
// GestureBinding uses Priority.touch for hit-test follow-up. If you need to
// react to a tap with non-trivial work, schedule that work at Priority.touch
// + 1 or just slightly above so it queues directly after framework
// bookkeeping.
//

// A12 :: Testing priority-sensitive code
//
// In tests, FakeAsync + binding.elapse can be used to deterministically drain
// the priority queue. Read Priority.X.value in assertions to verify the
// relative ordering you intend, but never hard-code the integer values
// themselves - they are an implementation detail that may shift.
//

// A13 :: Future directions
//
// Variable refresh rate displays make the 16.6 ms budget a moving target.
// Frame pacing on 120 Hz devices halves the available idle slack, which
// amplifies the cost of mis-tagging a heavy task as Priority.touch.
//

// A14 :: Safety patterns
//
// Wrap any scheduled task in a try/catch when failure should not poison
// future tasks. The binding does not isolate task failures: an unhandled
// exception bubbles up to the binding and is treated as a framework error.
// Defensive code keeps your scheduler healthy.
//

// A15 :: Anti-patterns observed in the wild
//
// 1) Scheduling a network fetch at Priority.touch because it was 'urgent'.
// Use Priority.idle and a Future. 2) Computing layout offsets at
// Priority.idle for a frame that is about to commit. Use Priority.animation.
// 3) Re-scheduling the same task in its own callback. The scheduler does not
// deduplicate.
//

// A16 :: Naming offsets
//
// If your codebase invents the same offset value in multiple places, promote
// it to a const Priority. const Priority p = Priority.idle + 100; still
// satisfies the 'no magic integers' rule because the named anchor is
// preserved in the expression.
//

// A17 :: Cooperation with isolates
//
// scheduleTask only orders work on the platform isolate. If the actual work
// runs on a helper isolate, the priority controls only when the platform
// thread *kicks off* the helper. The helper's runtime is not scheduler-aware.
//

// A18 :: Framework code that depends on Priority
//
// Examples include WidgetsBinding.deferFirstFrame for deferred startup,
// ImageStreamCompleter for late image decode completion, and PaintingBinding
// for cache scrubbing. Each of these uses a specific anchor and should not be
// displaced by app-level scheduling.
//

// A19 :: When not to use Priority
//
// If your work must complete before the next frame, do not schedule it at all
// - run it inline, or in a SchedulerPhase callback (postFrameCallback for
// example). Priority is for *deferred* work whose exact timing is not
// critical to the current frame.
//

// A20 :: Reading .value safely
//
// Do read .value when you need to log or compare priorities in tests. Do not
// write code that branches on a specific integer literal; tomorrow's
// framework may shift the anchor and your branches will silently take the
// wrong path. Branch on identity comparisons (== Priority.touch) or on
// relative ordering instead.
//

// ============================================================================
// APPENDIX B :: Frequently asked questions
// ============================================================================
//
// B1  Q: Can I subclass Priority to make a fourth named anchor?
//      A: No. Priority's constructor is private. You must compose with
//      operator+ off of an existing anchor. The point is to keep the universe
//      of names small and recognizable across the entire ecosystem.
//

// B2  Q: Is Priority.animation the same as the SchedulerPhase used during build?
//      A: No. SchedulerPhase describes *which phase of the current frame* the
//      binding is in (idle, transientCallbacks, midFrameMicrotasks,
//      persistentCallbacks, postFrameCallbacks). Priority is about ordering
//      *deferred* tasks across multiple gaps.
//

// B3  Q: Does Priority.idle wait for app idle or system idle?
//      A: Neither, strictly. It waits for the binding's event-loop callback
//      to fire, which happens whenever there is room in the schedule. On a
//      quiet device that is many times per second; on a busy one, less often.
//

// B4  Q: How do I cancel a scheduled task?
//      A: scheduleTask returns a Future. There is no direct cancel API;
//      instead the convention is to flip a boolean inside the callback that
//      causes it to short-circuit. The task will still run, but will return
//      immediately.
//

// B5  Q: Can I get a callback once the queue is empty?
//      A: Not directly via Priority. Use
//      SchedulerBinding.scheduleFrameCallback or addPostFrameCallback for
//      frame-relative timing, or use a chained Future from scheduleTask
//      itself if you simply need 'after this task'.
//

// B6  Q: Is there a way to inspect the current queue size?
//      A: Not via stable public API. Internally the binding holds a heap of
//      pending tasks; it is not exposed because consumer code is not expected
//      to make decisions based on queue depth.
//

// B7  Q: Will Priority.touch make my UI feel snappier if I sprinkle it everywhere?
//      A: Almost certainly the opposite. The framework already uses touch
//      priority for the things that actually matter for input latency. Adding
//      more touch tasks can crowd the genuinely time-sensitive ones.
//

// B8  Q: What is the relationship between Priority and Flutter's compute() helper?
//      A: compute() spawns an isolate and is governed by isolate scheduling,
//      not by Priority. If you must coordinate isolate work with the platform
//      isolate, schedule the platform-side handoff with the right Priority
//      and the helper isolate is whatever the OS picks.
//

// B9  Q: Can Priority offsets be negative?
//      A: Yes. operator+ accepts any int. Priority.animation + (-1) is a
//      perfectly legal way to slot just below animation. Just keep |offset|
//      well under kMaxOffset to avoid spilling into a neighbouring category.
//

// B10  Q: How does Priority interact with the SchedulerBinding lifecycleState?
//      A: When the app is paused or in detached state, scheduleTask continues
//      to enqueue, but the binding may stop draining. On resume the queue
//      drains in priority order, so a long-paused queue can briefly stall.
//

// B11  Q: Should I use Priority for analytics calls?
//      A: Yes - Priority.idle is exactly right for analytics. Avoid
//      Future.run or Timer.run, which can land mid-frame.
//

// B12  Q: Does Priority survive isolate boundaries?
//      A: No. Priority is a value type used by the platform isolate's
//      binding. There is no equivalent on background isolates.
//

// B13  Q: Are there platform-specific differences?
//      A: The Priority class is the same on all platforms, but the actual
//      frame budget differs. iOS ProMotion screens run at up to 120 Hz;
//      Android devices vary widely; web targets the browser's own RAF
//      cadence.
//

// B14  Q: What is the cost of constructing many Priority values?
//      A: Negligible. Priority objects are tiny wrappers around an int, and
//      the GC handles them like any other small object. Don't pre-allocate
//      them; build expressions where you need them.
//

// B15  Q: Can I use Priority outside Flutter, in pure Dart?
//      A: It is exported by package:flutter/scheduler.dart and is not present
//      in the Dart SDK proper. For pure-Dart prioritization use a custom
//      heap; Priority is meant for binding-aware scheduling.
//

// B16  Q: How is Priority serialized?
//      A: It is not. There is no toJson or fromJson. If you need to persist a
//      scheduling decision, store the offset as an int and reconstruct with
//      an anchor on read.
//

// B17  Q: Can I implement my own scheduler with a different priority shape?
//      A: You can, but doing so means stepping outside the framework's task
//      queue. The Priority class is not extensible because the binding sorts
//      by .value, not by virtual dispatch.
//

// B18  Q: Is operator+ commutative or associative?
//      A: It is associative in the sense that (Priority.idle + 5) + 5 yields
//      the same .value as Priority.idle + 10. It is not commutative as
//      defined (int + Priority is not declared); always anchor on the
//      Priority on the left.
//

// B19  Q: What happens if .value overflows kMaxOffset?
//      A: There is no runtime check; the binding will still schedule the
//      task, but the priority may collide with the next named anchor's range
//      and produce surprising ordering. Keep offsets bounded.
//

// B20  Q: Where can I read the source?
//      A: It lives at packages/flutter/lib/src/scheduler/priority.dart in the
//      flutter/flutter repository. The class is small (under 50 lines) and is
//      the cleanest possible illustration of an opaque-int wrapper pattern.
//

// ============================================================================
// APPENDIX C :: Cross-reference index
// ============================================================================
//
//   Priority                                 -> lib/src/scheduler/priority.dart
//   SchedulerBinding                         -> lib/src/scheduler/binding.dart
//   scheduleTask                             -> lib/src/scheduler/binding.dart
//   handleEventLoopCallback                  -> lib/src/scheduler/binding.dart
//   SchedulerPhase                           -> lib/src/scheduler/binding.dart
//   addPostFrameCallback                     -> lib/src/scheduler/binding.dart
//   FrameTiming                              -> dart:ui FrameTiming
//   WidgetsBinding.deferFirstFrame           -> lib/src/widgets/binding.dart
//   ImageStreamCompleter                     -> lib/src/painting/image_stream.dart
//   PaintingBinding                          -> lib/src/painting/binding.dart
//   GestureBinding                           -> lib/src/gestures/binding.dart
//   Ticker                                   -> lib/src/scheduler/ticker.dart
//   AnimationController                      -> lib/src/animation/animation_controller.dart
//   ImageCache                               -> lib/src/painting/image_cache.dart
//

// ============================================================================
// APPENDIX D :: Closing notes
// ============================================================================
//
// Priority looks like a trivial class - three constants and a + operator -
// but it encodes years of accumulated learning about cooperative scheduling
// in a UI framework. Treat it with the respect that quiet, well-named
// abstractions deserve. When you reach for raw integers, ask whether you
// have actually invented a fourth category, and if you have, file an issue
// upstream rather than papering over the gap with a magic number.
//
// ----------------------------------------------------------------------------
// Authoring notes
// ----------------------------------------------------------------------------
//
// This demo was authored as part of the d4rt quest's send-ast-via-http
// example collection. It demonstrates how a single-shot D4rt build()
// function can deliver a substantial educational artifact without relying
// on stateful widgets, controllers, or live timers - all of which are
// outside the script execution model.
//
// The structure is intentionally repetitive: each section has a print()
// narration line, a section-builder block, and a uniform surface decoration.
// That uniformity makes the file approachable as a copy-paste base for
// authoring further deep demos in the same style.
//
// ============================================================================
// APPENDIX E :: Worked walkthroughs
// ============================================================================
//
// E1 :: A scrolling list with lazy thumbnail decoding
//
// Imagine a vertical list of 500 items, each with a thumbnail image. As the
// user scrolls quickly past, the framework cannot afford to decode every
// thumbnail in the same frame the tile becomes visible. A reasonable design:
//
//   * Tiles register a 'wants decode' callback at scheduleTask with
//     Priority.animation - 1 (just below the framework's own decode work).
//   * If the user scrolls away before the callback runs, the callback's
//     'still wanted' flag is flipped off and the work is a no-op.
//   * Decoded results are stored in a small LRU cache keyed by id.
//
// This pattern keeps fast scrolls smooth without dropping decode quality
// once the scroll settles.
//
// E2 :: Telemetry batch flush
//
// A telemetry library accumulates events into a buffer. Once the buffer
// reaches N events, it must be flushed to disk. Flushing is too expensive
// to do inline, but doing it at Priority.touch would be irresponsible.
//
//   * Use Priority.idle + 50 - slightly above bare idle, since the buffer
//     bound has a soft real-time aspect (we want it flushed before the next
//     buffer fills).
//   * Inside the callback, write to a file in append mode; the OS will
//     buffer further.
//
// E3 :: Gesture-driven highlight
//
// A tappable card needs to highlight on tap-down and fade on tap-up. The
// highlight itself is animated by an AnimationController and does not need
// scheduleTask, but the *trigger* of optional follow-up work (e.g. emitting
// a haptic or logging the interaction) can use Priority.touch.
//
//   * Schedule the haptic at Priority.touch immediately on tap-down.
//   * Schedule the log entry at Priority.idle + 10 - it is not urgent.
//
// E4 :: Search index warm-up
//
// On app launch, a local search index is compiled lazily. The compile is
// CPU-bound and takes ~80 ms. Doing it inline blocks the first frame; doing
// it on a background isolate is overkill if the user is not searching yet.
//
//   * Schedule the compile at Priority.idle + 200 - far above bare idle to
//     ensure it does not get starved, but well below animation.
//   * Chunk the work using yieldable iteration so a single callback does
//     not consume the entire idle slack.
//
// E5 :: Camera frame post-processing
//
// A live camera preview produces 30 frames per second. Each frame the app
// applies a light filter for display. The actual filter happens on a GPU
// shader, but the post-processing handoff (uploading metadata, etc.) is
// CPU-side.
//
//   * Schedule the handoff at Priority.animation + 10 - it is frame-coupled
//     and slightly more important than generic animation work.
//   * Drop frames if the queue length grows; do not back up.
//
// ============================================================================
// APPENDIX F :: Pseudo-benchmark intuition
// ============================================================================
//
// While we cannot run a benchmark inside this script, the rough intuition
// is useful. On a mid-range Android device at 60 Hz:
//
//   * Frame budget                  ~16.6 ms
//   * vsync handling                 ~0.5 ms
//   * build + layout + paint         ~8.0 ms (median)
//   * raster                         ~3.5 ms
//   * present                        ~0.5 ms
//   * remaining for scheduleTask     ~4.0 ms
//
// That 4 ms is the *upper bound* for cumulative idle work per frame. It is
// shared across every Priority.idle, Priority.animation and Priority.touch
// task currently in the queue. If your callbacks routinely consume more
// than 1 ms each, you will only fit 3-4 of them per frame.
//
// On a 120 Hz device the budget halves to ~8.3 ms, and the slack drops to
// closer to 1.5 ms. This is why discipline around touch-priority work is
// even more important on high-refresh-rate devices.
//
// ============================================================================
// APPENDIX G :: Quick-reference cheat sheet
// ============================================================================
//
//   Anchor                .value   Use when                                   
//   ---------------------------------------------------------------------------
//   Priority.idle           0      Background, fill-the-gap maintenance       
//   Priority.animation  100000     Frame-coupled visible state                
//   Priority.touch      200000     Pointer-derived, latency-sensitive         
//
//   Operator                       Returns                                    
//   ---------------------------------------------------------------------------
//   Priority + int                 New Priority offset by int                 
//   .value                         int used by binding for sort              
//   .toString()                    Debug string                              
//
//   Constants                      Meaning                                    
//   ---------------------------------------------------------------------------
//   Priority.kMaxOffset = 10000    Soft upper bound on legal offsets          
//
// ============================================================================
// APPENDIX H :: Final reflection
// ============================================================================
//
// If you have read this far, the takeaway is simple: priority is meaning.
// A line of code that says SchedulerBinding.instance.scheduleTask(work,
// Priority.idle) is documenting an intention. A reader six months later
// can see that this work is okay to defer, that it does not produce visible
// state, and that it should not preempt input. The same line written with
// Priority.touch would carry the opposite meaning - and would, in many
// real-world cases, produce noticeable jank.
//
// Keep your priorities anchored, your offsets small, and your touch tasks
// short. The rest is just plumbing.
//
// ============================================================================
// APPENDIX I :: Trailing remarks
// ============================================================================
//
// The Tide Cobalt theme used in this demo deliberately echoes the deep-blue
// palette of an ocean at night: still on the surface, structured underneath.
// Scheduling shares that quality. From the outside it looks calm; underneath,
// the binding is making careful choices many times per second about what to
// run and when. Treat scheduleTask and Priority as a contract with that
// hidden machinery. The contract is short. Honour it, and your app reads as
// smooth water.
//
// ============================================================================
// END OF FILE
// ============================================================================
