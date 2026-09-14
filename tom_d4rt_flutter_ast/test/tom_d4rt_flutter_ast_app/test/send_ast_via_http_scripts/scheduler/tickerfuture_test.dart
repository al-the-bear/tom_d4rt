// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for TickerFuture, Ticker,
// TickerProvider and SchedulerBinding family
//
// This file is a *descriptive* tour of the Flutter scheduler API. It never
// starts a Ticker, never schedules a real frame callback, and never reads from
// `AnimationController` -- those would either crash the interpreter or rely on
// async state that the analyzer-free test corpus deliberately avoids.
//
// What you DO see here:
//   1. A ticker anatomy diagram, drawn with stacked Containers and Texts,
//      labelling every public hook on the Ticker class.
//   2. A TickerFuture lifecycle reference: the three terminal states
//      (resolved, canceled, replaced) and the callbacks attached to each.
//   3. A SchedulerPhase enum showcase that walks through every phase in the
//      temporal order it appears within one engine frame.
//   4. A FrameTiming explainer: build/raster/total budget, vsync target,
//      jank classification.
//   5. A callback-type comparison: transient vs persistent vs post-frame
//      vs scheduled-task, mapped onto the phase diagram.
//   6. A vsync diagram that ties TickerProvider back to the engine's
//      vertical-sync signal so the reader can see *why* every animation
//      needs a `vsync:` argument.
//
// Every section is composed and returned in a final Scaffold/ListView so a
// human can scroll through the rendered output. Print statements between
// sections give the test driver a stable trace.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------
//
// Section colours stay in this central block so the analyzer sees them as
// real const expressions and so the demo reads as a single design system
// rather than a chaotic series of inline hex codes.

const Color kBgPage = Color(0xFFFAFAFA);
const Color kBgCard = Color(0xFFFFFFFF);
const Color kBgMutedCard = Color(0xFFF3F4F6);
const Color kBgCode = Color(0xFF1E1E2E);
const Color kFgCode = Color(0xFFE0E0E8);
const Color kAccentTicker = Color(0xFF1565C0);
const Color kAccentTickerSoft = Color(0xFFBBDEFB);
const Color kAccentFuture = Color(0xFF6A1B9A);
const Color kAccentFutureSoft = Color(0xFFE1BEE7);
const Color kAccentPhase = Color(0xFFE65100);
const Color kAccentPhaseSoft = Color(0xFFFFE0B2);
const Color kAccentTiming = Color(0xFF00897B);
const Color kAccentTimingSoft = Color(0xFFB2DFDB);
const Color kAccentCallback = Color(0xFFAD1457);
const Color kAccentCallbackSoft = Color(0xFFF8BBD0);
const Color kAccentVsync = Color(0xFF455A64);
const Color kAccentVsyncSoft = Color(0xFFCFD8DC);
const Color kRed = Color(0xFFC62828);
const Color kGreen = Color(0xFF2E7D32);
const Color kAmber = Color(0xFFEF6C00);
const Color kFgDim = Color(0xFF616161);
const Color kFgStrong = Color(0xFF212121);
const Color kBorder = Color(0xFFE0E0E0);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('TickerFuture deep visual demo: build() entered');

  // We read the *current* scheduler phase exactly once, purely for display.
  // Reading is side-effect-free: it is a property getter on the singleton
  // SchedulerBinding. We never *write* anything to the binding.
  final SchedulerPhase observedPhase =
      SchedulerBinding.instance.schedulerPhase;
  print('observedPhase = $observedPhase');

  // Snapshot a few binding properties for the diagnostic card later. Doing
  // this once at the top keeps the rest of the build pure.
  final Duration? observedFrameTimeStamp = _safeFrameTimeStamp();
  print('observedFrameTimeStamp = $observedFrameTimeStamp');

  // Build each section. Each returns a Widget, fully composed, that we hand
  // to the final ListView.
  final Widget headerSection = _buildHeader(observedPhase);
  print('section 0 (header) built');

  final Widget anatomySection = _buildTickerAnatomy();
  print('section 1 (ticker anatomy) built');

  final Widget lifecycleSection = _buildTickerFutureLifecycle();
  print('section 2 (TickerFuture lifecycle) built');

  final Widget phaseSection = _buildSchedulerPhaseShowcase(observedPhase);
  print('section 3 (SchedulerPhase showcase) built');

  final Widget timingSection = _buildFrameTimingExplainer();
  print('section 4 (FrameTiming explainer) built');

  final Widget callbackSection = _buildCallbackTypeComparison();
  print('section 5 (callback comparison) built');

  final Widget vsyncSection = _buildVsyncDiagram();
  print('section 6 (vsync diagram) built');

  final Widget timeDilationSection = _buildTimeDilationCard();
  print('section 7 (timeDilation) built');

  final Widget glossarySection = _buildGlossary();
  print('section 8 (glossary) built');

  final Widget diagnosticsSection =
      _buildDiagnostics(observedPhase, observedFrameTimeStamp);
  print('section 9 (diagnostics) built');

  // Final assembly. Scaffold > ListView so the user can scroll through ~10
  // visual sections without scroll fights.
  final Widget root = Scaffold(
    backgroundColor: kBgPage,
    appBar: AppBar(
      title: const Text('TickerFuture & SchedulerBinding Tour'),
      backgroundColor: kAccentTicker,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: <Widget>[
        headerSection,
        const SizedBox(height: 20),
        anatomySection,
        const SizedBox(height: 20),
        lifecycleSection,
        const SizedBox(height: 20),
        phaseSection,
        const SizedBox(height: 20),
        timingSection,
        const SizedBox(height: 20),
        callbackSection,
        const SizedBox(height: 20),
        vsyncSection,
        const SizedBox(height: 20),
        timeDilationSection,
        const SizedBox(height: 20),
        glossarySection,
        const SizedBox(height: 20),
        diagnosticsSection,
        const SizedBox(height: 24),
        _buildFooter(),
      ],
    ),
  );

  print('TickerFuture deep visual demo: build() returning root widget');
  return root;
}

// ---------------------------------------------------------------------------
// Safe property readers
// ---------------------------------------------------------------------------
//
// These exist so we can mention things like `currentFrameTimeStamp` without
// the demo throwing on a binding that has not produced a frame yet. The
// binding API treats those as "may throw if read at the wrong phase". We
// avoid that with a tiny wrapper that simply returns null on phase mismatch.

Duration? _safeFrameTimeStamp() {
  // We only read inside persistentCallbacks/postFrameCallbacks where the
  // value is defined. Outside of that, return null.
  final SchedulerPhase phase = SchedulerBinding.instance.schedulerPhase;
  final bool ok = phase == SchedulerPhase.persistentCallbacks ||
      phase == SchedulerPhase.postFrameCallbacks ||
      phase == SchedulerPhase.transientCallbacks ||
      phase == SchedulerPhase.midFrameMicrotasks;
  if (!ok) {
    return null;
  }
  // Even when phase is right, reading may throw on certain test bindings.
  // We don't have try/catch in the descriptive script, so we just check the
  // phase and trust it. Real apps would wrap in try/catch.
  return SchedulerBinding.instance.currentFrameTimeStamp;
}

// ---------------------------------------------------------------------------
// Small reusable widgets
// ---------------------------------------------------------------------------

Widget _sectionTitle(String label, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 6,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bodyText(String s, {double size = 13, Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text(
      s,
      style: TextStyle(
        fontSize: size,
        color: color ?? kFgStrong,
        height: 1.35,
      ),
    ),
  );
}

Widget _bullet(String s) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 5, right: 6),
          child: Icon(Icons.circle, size: 6, color: kFgDim),
        ),
        Expanded(
          child: Text(
            s,
            style: const TextStyle(fontSize: 13, color: kFgStrong, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: kFgDim,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, color: kFgStrong),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kBgCode,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: kFgCode,
        height: 1.4,
      ),
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = kBgCard,
  EdgeInsets padding = const EdgeInsets.all(16),
  Color borderColor = kBorder,
}) {
  return Container(
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: borderColor, width: 1),
    ),
    padding: padding,
    child: child,
  );
}

Widget _chip(String text, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        color: fg,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 0: Header
// ---------------------------------------------------------------------------

Widget _buildHeader(SchedulerPhase phase) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kAccentTicker, kAccentFuture],
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'TickerFuture, Ticker & SchedulerBinding',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A descriptive tour of the Flutter scheduler surface. '
          'No frames are scheduled. No animations are started. '
          'Every section is just text and shapes — read at your own pace.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: <Widget>[
            _chip('Ticker', Colors.white24, Colors.white),
            _chip('TickerProvider', Colors.white24, Colors.white),
            _chip('TickerFuture', Colors.white24, Colors.white),
            _chip('TickerCanceled', Colors.white24, Colors.white),
            _chip('SchedulerBinding', Colors.white24, Colors.white),
            _chip('SchedulerPhase', Colors.white24, Colors.white),
            _chip('FrameTiming', Colors.white24, Colors.white),
            _chip('Priority', Colors.white24, Colors.white),
            _chip('timeDilation', Colors.white24, Colors.white),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'observed SchedulerPhase: ${phase.name}',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Ticker anatomy diagram
// ---------------------------------------------------------------------------
//
// A Ticker is a tiny object that asks the SchedulerBinding to call back
// once per frame while it is "active". The anatomy is small enough that we
// can lay out every public member on a single diagram.

Widget _buildTickerAnatomy() {
  // We construct an *unstarted* Ticker to demonstrate that the constructor
  // itself is side-effect free. We will never call .start() on it.
  final Ticker probe = Ticker((Duration d) {
    // This onTick will never fire because we don't .start() the ticker.
    // It exists only to give the constructor a non-null callback.
    print('probe ticker tick (will never run): elapsed=$d');
  }, debugLabel: 'tickerfuture-demo-probe');

  final String probeDebugLabel = probe.debugLabel ?? '(no label)';
  final bool probeIsActive = probe.isActive;
  final bool probeIsTicking = probe.isTicking;
  final bool probeMuted = probe.muted;
  final String probeRuntime = probe.runtimeType.toString();

  // Note: ticker.scheduled and ticker.shouldScheduleTick are @protected and
  // can only be read by Ticker subclasses. We describe them in the diagram
  // below but do not read them from outside.

  print('probe ticker constructed: '
      'label=$probeDebugLabel '
      'isActive=$probeIsActive '
      'isTicking=$probeIsTicking '
      'muted=$probeMuted '
      'runtimeType=$probeRuntime');

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('1. Ticker anatomy', Icons.tune, kAccentTicker),
        _bodyText(
          'A Ticker is the lowest-level abstraction over per-frame '
          'callbacks. It owns no animation state. Its only job is to call '
          'a function once per frame while it is active and not muted.',
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: kAccentTickerSoft,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kAccentTicker, width: 1),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'class Ticker',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: kAccentTicker,
                ),
              ),
              const SizedBox(height: 6),
              _kvRow('constructor', 'Ticker(TickerCallback onTick, {String? debugLabel})'),
              _kvRow('start()', 'TickerFuture — schedules the ticker, returns the future'),
              _kvRow('stop({canceled})', 'void — settles the future (cancel=true throws TickerCanceled)'),
              _kvRow('dispose()', 'void — permanently releases the ticker'),
              _kvRow('isActive', 'bool — was start() called and stop() not yet?'),
              _kvRow('isTicking', 'bool — active AND not muted AND a tick is scheduled'),
              _kvRow('muted', 'bool — settable; muted tickers stay active but skip ticks'),
              _kvRow('scheduled', 'bool — true if a tick is currently pending with the binding'),
              _kvRow('shouldScheduleTick', 'bool — protected helper used by subclasses'),
              _kvRow('debugLabel', 'String? — appears in diagnostics, e.g. "AnimationController"'),
              _kvRow('runtimeType', 'Ticker (or subclass like _DisposingTicker)'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Probe instance snapshot',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        _bodyText(
          'We constructed a Ticker but deliberately never called .start() '
          'on it. These are the values you can read off the resulting '
          'object — note the live "isActive" flag.',
        ),
        const SizedBox(height: 6),
        _card(
          background: kBgMutedCard,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('runtimeType', probeRuntime),
              _kvRow('debugLabel', probeDebugLabel),
              _kvRow('isActive', probeIsActive.toString()),
              _kvRow('isTicking', probeIsTicking.toString()),
              _kvRow('muted', probeMuted.toString()),
              _kvRow('scheduled', '@protected — readable only inside subclass'),
              _kvRow('shouldScheduleTick',
                  '@protected — readable only inside subclass'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Lifecycle as ASCII',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        _codeBlock(
          '   new Ticker(onTick)\n'
          '          |\n'
          '          v\n'
          '   [ constructed, isActive=false ]\n'
          '          |\n'
          '          |   ticker.start()\n'
          '          v\n'
          '   [ active, scheduled, ticks each frame ]   <---+\n'
          '          |                                     |\n'
          '          |   muted=true                        |\n'
          '          v                                     |\n'
          '   [ active, but ticks are skipped ]             |\n'
          '          |                                     |\n'
          '          |   muted=false  -------------------> +\n'
          '          |\n'
          '          |   ticker.stop()                ticker.stop(canceled: true)\n'
          '          v                                  v\n'
          '   TickerFuture resolves               TickerFuture.orCancel throws\n'
          '                                       TickerCanceled\n'
          '          |\n'
          '          v\n'
          '   ticker.dispose()  [terminal]',
        ),
        const SizedBox(height: 12),
        _bodyText(
          'Note: we did not call .start() in this demo because that would '
          'register the ticker with SchedulerBinding and produce frames '
          'we cannot manage from inside a stateless build script.',
          color: kFgDim,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: TickerFuture lifecycle reference
// ---------------------------------------------------------------------------
//
// We can construct one degenerate TickerFuture for free, via the named
// constructor `TickerFuture.complete()`. That future is already resolved,
// which lets us demonstrate the `whenCompleteOrCancel` and `orCancel`
// helpers without ever starting a real ticker.

Widget _buildTickerFutureLifecycle() {
  // A pre-completed TickerFuture is the only safe shape we can build.
  final TickerFuture preCompleted = TickerFuture.complete();
  print('preCompleted = $preCompleted (runtimeType=${preCompleted.runtimeType})');

  // Attach a whenCompleteOrCancel handler. This fires immediately because
  // the future is already complete.
  preCompleted.whenCompleteOrCancel(() {
    print('preCompleted whenCompleteOrCancel callback fired');
  });

  // The `orCancel` getter returns a Future<void>. We don't await it, but we
  // can inspect its runtimeType for the diagnostics table.
  final orCancelFuture = preCompleted.orCancel;
  final String orCancelType = orCancelFuture.runtimeType.toString();
  print('preCompleted.orCancel runtimeType = $orCancelType');

  // TickerCanceled construction is free of side effects. Discuss in card.
  final TickerCanceled canceled = TickerCanceled();
  print('TickerCanceled() => $canceled');

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          '2. TickerFuture lifecycle',
          Icons.timeline,
          kAccentFuture,
        ),
        _bodyText(
          'TickerFuture is the Future returned by Ticker.start(). It is '
          'unusual: it has TWO completion paths, modelled by two callback '
          'shapes.',
        ),
        const SizedBox(height: 8),
        _bullet(
          'The "normal" completion path — fires when ticker.stop() is '
          'called without the canceled flag, or when the animation reaches '
          'its target. Reachable via "await tickerFuture" and via '
          'tickerFuture.whenComplete(...).',
        ),
        _bullet(
          'The "cancellation" completion path — fires when '
          'ticker.stop(canceled: true) is called, or when the surrounding '
          'TickerProvider is disposed mid-flight. Reachable via '
          'tickerFuture.orCancel which throws TickerCanceled.',
        ),
        _bullet(
          'Both paths funnel through whenCompleteOrCancel(callback). That '
          'callback is invoked exactly once, with no arguments, regardless '
          'of which terminal state was reached.',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: kAccentFutureSoft,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kAccentFuture, width: 1),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'class TickerFuture implements Future<void>',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: kAccentFuture,
                ),
              ),
              const SizedBox(height: 6),
              _kvRow('TickerFuture.complete()', 'Returns a pre-resolved TickerFuture (testing shortcut)'),
              _kvRow('orCancel', 'Future<void> — throws TickerCanceled if the ticker was canceled'),
              _kvRow('whenCompleteOrCancel(fn)', 'Runs fn once on either terminal state'),
              _kvRow('whenComplete(fn)', 'Inherited Future API; runs only on normal completion'),
              _kvRow('then(...)', 'Inherited Future API; canceled futures skip then() handlers'),
              _kvRow('catchError(...)', 'Inherited; catches TickerCanceled when chained off orCancel'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Probe values',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        _bodyText(
          'TickerFuture.complete() returns a future that is already in the '
          '"normal completion" terminal state. whenCompleteOrCancel fires '
          'immediately on the next microtask boundary.',
        ),
        const SizedBox(height: 6),
        _card(
          background: kBgMutedCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('preCompleted.runtimeType', preCompleted.runtimeType.toString()),
              _kvRow('preCompleted.orCancel.runtimeType', orCancelType),
              _kvRow('TickerCanceled().runtimeType', canceled.runtimeType.toString()),
              _kvRow('TickerCanceled.toString()', canceled.toString()),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Three callsites that return a TickerFuture',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        _codeBlock(
          '// 1. Bare Ticker\n'
          'final TickerFuture f1 = ticker.start();\n'
          '\n'
          '// 2. AnimationController forward/reverse\n'
          'final TickerFuture f2 = controller.forward();\n'
          'final TickerFuture f3 = controller.reverse();\n'
          '\n'
          '// 3. AnimationController repeat()\n'
          'final TickerFuture f4 = controller.repeat();\n'
          '\n'
          '// Awaiting catches only normal completion:\n'
          'await f1;\n'
          '\n'
          '// Awaiting .orCancel catches both, surfacing TickerCanceled:\n'
          'try {\n'
          '  await f1.orCancel;\n'
          '} on TickerCanceled {\n'
          '  // widget was disposed mid-animation\n'
          '}',
        ),
        const SizedBox(height: 12),
        _bodyText(
          'A common bug: writing `await controller.forward()` without '
          '`.orCancel`. If the widget unmounts during the animation, the '
          'returned TickerFuture resolves (without throwing), the await '
          'continues, and the next line runs against a disposed State. '
          'Always use orCancel when the surrounding code touches `this`.',
          color: kRed,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: SchedulerPhase enum showcase
// ---------------------------------------------------------------------------

Widget _buildSchedulerPhaseShowcase(SchedulerPhase observedPhase) {
  // We build a row per phase with: index, name, what runs, what to schedule
  // here. This mirrors the temporal ordering inside one engine frame.
  final List<_PhaseRow> rows = <_PhaseRow>[
    _PhaseRow(
      phase: SchedulerPhase.idle,
      icon: Icons.bedtime,
      color: const Color(0xFF607D8B),
      tagline: 'Engine awaits the next vsync.',
      whatRuns:
          'Microtasks, async user code, timers, isolate messages, gesture '
          'events that did not come from a frame.',
      scheduleHere:
          'scheduleTask(priority: Priority.idle), Timer.run, '
          'scheduleMicrotask, setState (just marks dirty).',
    ),
    _PhaseRow(
      phase: SchedulerPhase.transientCallbacks,
      icon: Icons.animation,
      color: const Color(0xFF1E88E5),
      tagline: 'Tick the world: animations and gestures.',
      whatRuns:
          'Frame-callback queue: each Ticker fires here; gesture recognizers '
          'consume input; AnimationController updates its value.',
      scheduleHere:
          'SchedulerBinding.scheduleFrameCallback(fn). Use rescheduling=true '
          'only when *already* inside a transient callback.',
    ),
    _PhaseRow(
      phase: SchedulerPhase.midFrameMicrotasks,
      icon: Icons.bubble_chart,
      color: const Color(0xFF8E24AA),
      tagline: 'Drain microtasks before layout.',
      whatRuns:
          'All microtasks scheduled during transientCallbacks. Lets `await` '
          'in a tick resume before build/layout run.',
      scheduleHere:
          'scheduleMicrotask from within a transient callback. Keep it '
          'cheap — this is on the critical frame path.',
    ),
    _PhaseRow(
      phase: SchedulerPhase.persistentCallbacks,
      icon: Icons.architecture,
      color: const Color(0xFFE65100),
      tagline: 'Build, layout, paint, composite.',
      whatRuns:
          'WidgetsBinding.drawFrame: build dirty elements, perform layout, '
          'paint into layers, hand the scene to the engine.',
      scheduleHere:
          'addPersistentFrameCallback — only the framework itself does this. '
          'User code does NOT call setState here.',
    ),
    _PhaseRow(
      phase: SchedulerPhase.postFrameCallbacks,
      icon: Icons.checklist,
      color: const Color(0xFF2E7D32),
      tagline: 'One-shot callbacks at end-of-frame.',
      whatRuns:
          'Callbacks registered with addPostFrameCallback (and ONLY those). '
          'They are invoked exactly once and then dropped from the list.',
      scheduleHere:
          'addPostFrameCallback. Common use: reading a RenderBox size right '
          'after layout, or kicking off the next animation cleanly.',
    ),
  ];

  // Build the visual list of phases.
  final List<Widget> phaseTiles = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final _PhaseRow row = rows[i];
    final bool isObserved = row.phase == observedPhase;
    phaseTiles.add(_buildPhaseTile(row, i, isObserved));
    if (i < rows.length - 1) {
      phaseTiles.add(_phaseArrow());
    }
  }

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          '3. SchedulerPhase — one frame, top to bottom',
          Icons.layers,
          kAccentPhase,
        ),
        _bodyText(
          'SchedulerBinding.schedulerPhase reports where the engine is in '
          'the frame pipeline RIGHT NOW. Most of the time it is idle. '
          'When a frame is in flight, it passes through the four other '
          'phases in strict order.',
        ),
        const SizedBox(height: 8),
        _bodyText(
          'The vertical diagram below is one frame, top to bottom. The '
          'phase highlighted in green is the one observed when this demo '
          'was built — almost always persistentCallbacks, because that is '
          'when build() runs.',
        ),
        const SizedBox(height: 12),
        Column(children: phaseTiles),
        const SizedBox(height: 12),
        const Text(
          'Reading the current phase',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        _codeBlock(
          'final SchedulerPhase p = SchedulerBinding.instance.schedulerPhase;\n'
          'switch (p) {\n'
          '  case SchedulerPhase.idle: ...\n'
          '  case SchedulerPhase.transientCallbacks: ...\n'
          '  case SchedulerPhase.midFrameMicrotasks: ...\n'
          '  case SchedulerPhase.persistentCallbacks: ...\n'
          '  case SchedulerPhase.postFrameCallbacks: ...\n'
          '}',
        ),
        const SizedBox(height: 8),
        _bodyText(
          'Tip: tests use `SchedulerBinding.instance.endOfFrame` to wait '
          'until phase returns to idle — useful for awaiting the next '
          'paint without polling.',
        ),
      ],
    ),
  );
}

Widget _buildPhaseTile(_PhaseRow row, int index, bool isObserved) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: isObserved ? const Color(0xFFE8F5E9) : kBgMutedCard,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isObserved ? kGreen : kBorder,
        width: isObserved ? 2 : 1,
      ),
    ),
    padding: const EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Index badge
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: row.color,
            borderRadius: BorderRadius.circular(18),
          ),
          alignment: Alignment.center,
          child: Text(
            index.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Icon(row.icon, color: row.color, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'SchedulerPhase.${row.phase.name}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: row.color,
                      ),
                    ),
                  ),
                  if (isObserved)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: kGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'OBSERVED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                row.tagline,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: kFgDim,
                ),
              ),
              const SizedBox(height: 6),
              _kvRow('runs', row.whatRuns),
              _kvRow('schedule here', row.scheduleHere),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _phaseArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(Icons.arrow_downward, color: kFgDim, size: 18),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: FrameTiming explainer
// ---------------------------------------------------------------------------

Widget _buildFrameTimingExplainer() {
  // FrameTiming is a small data class delivered to addTimingsCallback. We
  // never register such a callback — we just describe the fields.
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          '4. FrameTiming — why a frame missed its budget',
          Icons.speed,
          kAccentTiming,
        ),
        _bodyText(
          'For every frame produced, the engine emits a FrameTiming record. '
          'Apps can subscribe via SchedulerBinding.addTimingsCallback. The '
          'record splits the frame into a build phase and a raster phase, '
          'each with start and finish timestamps measured from a shared '
          'clock. The total is "finish minus vsync".',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: kAccentTimingSoft,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kAccentTiming, width: 1),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'class FrameTiming',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: kAccentTiming,
                ),
              ),
              const SizedBox(height: 6),
              _kvRow('vsyncOverhead', 'engine wake to first build start'),
              _kvRow('buildDuration', 'build phase elapsed on the UI thread'),
              _kvRow('rasterDuration', 'raster phase elapsed on the raster thread'),
              _kvRow('totalSpan', 'vsync target to raster finish — must fit budget'),
              _kvRow('frameNumber', 'monotonic counter, useful for joining traces'),
              _kvRow('frameInterval', 'measured interval between adjacent vsyncs'),
              _kvRow('rasterStats', 'detailed raster sub-phase timings'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'The frame budget',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        _bodyText(
          'Display refresh rates dictate the budget. Miss it and the user '
          'sees the previous frame for an extra vsync — that is jank.',
        ),
        const SizedBox(height: 8),
        _budgetBar(
          label: '60 Hz display',
          value: '16.67 ms',
          fillFrac: 16.67 / 16.67,
          color: kAccentTiming,
        ),
        _budgetBar(
          label: '90 Hz display',
          value: '11.11 ms',
          fillFrac: 11.11 / 16.67,
          color: kAccentTiming,
        ),
        _budgetBar(
          label: '120 Hz display',
          value: '8.33 ms',
          fillFrac: 8.33 / 16.67,
          color: kAccentTiming,
        ),
        _budgetBar(
          label: '144 Hz display',
          value: '6.94 ms',
          fillFrac: 6.94 / 16.67,
          color: kAccentTiming,
        ),
        const SizedBox(height: 14),
        const Text(
          'Jank classification',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        _bullet(
          'totalSpan ≤ budget — frame on time. The user sees smooth motion.',
        ),
        _bullet(
          'budget < totalSpan ≤ 2 × budget — single dropped frame. Often '
          'imperceptible unless it lines up with a gesture.',
        ),
        _bullet(
          'totalSpan > 2 × budget — visible stutter; the eye notices the '
          'pause and motion feels sticky.',
        ),
        _bullet(
          'totalSpan > 16 × budget — "freeze frame": the user thinks the '
          'app is hung. Usually a synchronous JSON parse on the UI thread.',
          // intentional emphasis colour
        ),
        const SizedBox(height: 12),
        _codeBlock(
          '// Reference: how a real app would register a timings callback.\n'
          '// We do NOT call this in the demo to keep build() pure.\n'
          'void onFrameTimings(List<FrameTiming> timings) {\n'
          '  for (int i = 0; i < timings.length; i++) {\n'
          '    final FrameTiming t = timings[i];\n'
          '    final double buildMs = t.buildDuration.inMicroseconds / 1000.0;\n'
          '    final double rasterMs = t.rasterDuration.inMicroseconds / 1000.0;\n'
          '    print("frame \${t.frameNumber}: build=\${buildMs}ms raster=\${rasterMs}ms");\n'
          '  }\n'
          '}\n'
          '\n'
          '// Registration is one line:\n'
          '// SchedulerBinding.instance.addTimingsCallback(onFrameTimings);',
        ),
      ],
    ),
  );
}

Widget _budgetBar({
  required String label,
  required String value,
  required double fillFrac,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: kFgStrong),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                height: 18,
                decoration: BoxDecoration(
                  color: kBgMutedCard,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: kBorder, width: 0.5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: fillFrac.clamp(0.0, 1.0),
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 70,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: kFgStrong,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: Callback-type comparison
// ---------------------------------------------------------------------------

Widget _buildCallbackTypeComparison() {
  // Build a 4-column table comparing the four callback registration shapes
  // on SchedulerBinding: scheduleFrameCallback, addPersistentFrameCallback,
  // addPostFrameCallback, scheduleTask.
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          '5. Callback types compared',
          Icons.compare_arrows,
          kAccentCallback,
        ),
        _bodyText(
          'SchedulerBinding exposes four entry points for "run my code at '
          'a particular point in time". They differ in when they fire, '
          'how often, and what cancellation guarantees they offer.',
        ),
        const SizedBox(height: 12),
        _calloutHeader(),
        _calloutRow(
          name: 'scheduleFrameCallback',
          phase: 'transientCallbacks',
          frequency: 'once (rescheduling=false) or per-frame',
          cancel: 'cancelFrameCallbackWithId(id)',
          useCase:
              'Driving an animation tick by hand, hooking a gesture into the '
              'frame pipeline.',
        ),
        _calloutRow(
          name: 'addPersistentFrameCallback',
          phase: 'persistentCallbacks',
          frequency: 'every frame, forever',
          cancel: 'no public cancel — framework-only',
          useCase:
              'WidgetsBinding registers drawFrame this way. App code almost '
              'never calls this directly.',
        ),
        _calloutRow(
          name: 'addPostFrameCallback',
          phase: 'postFrameCallbacks',
          frequency: 'once, end of next frame',
          cancel: 'no cancel; you "miss" it by unmounting',
          useCase:
              'Read a RenderBox size after layout, start the *next* animation '
              'on a clean phase boundary.',
        ),
        _calloutRow(
          name: 'scheduleTask',
          phase: 'idle (with priority)',
          frequency: 'once, when idle and priority threshold met',
          cancel: 'no cancel; cooperative — finish your microtask',
          useCase:
              'Heavy background work that should yield to animation and touch '
              '— Priority.idle vs Priority.animation vs Priority.touch.',
        ),
        const SizedBox(height: 14),
        const Text(
          'Priority values you choose from for scheduleTask',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 6),
        _card(
          background: kAccentCallbackSoft,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('Priority.idle.value', Priority.idle.value.toString()),
              _kvRow('Priority.animation.value', Priority.animation.value.toString()),
              _kvRow('Priority.touch.value', Priority.touch.value.toString()),
              _kvRow('Priority.kMaxOffset', Priority.kMaxOffset.toString()),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _bodyText(
          'Higher integer value wins. Touch beats animation; animation '
          'beats idle. Tasks below the current "soft barrier" wait until '
          'higher-priority work drains.',
        ),
        const SizedBox(height: 14),
        const Text(
          'Reference snippets (do not run inside this script)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        _codeBlock(
          '// 1. Frame callback — fires inside transientCallbacks.\n'
          'final int id = SchedulerBinding.instance.scheduleFrameCallback(\n'
          '  (Duration t) {\n'
          '    // t is monotonic frame time, suitable for animation math.\n'
          '  },\n'
          ');\n'
          '// Cancel before it fires:\n'
          'SchedulerBinding.instance.cancelFrameCallbackWithId(id);',
        ),
        _codeBlock(
          '// 2. Post-frame callback — fires once after the next frame.\n'
          'SchedulerBinding.instance.addPostFrameCallback((Duration t) {\n'
          '  // safe place to read sizes after layout settled\n'
          '});',
        ),
        _codeBlock(
          '// 3. Persistent — framework only, sketch here for completeness:\n'
          'SchedulerBinding.instance.addPersistentFrameCallback(\n'
          '  (Duration t) {\n'
          '    // WidgetsBinding.drawFrame is registered like this.\n'
          '  },\n'
          ');',
        ),
        _codeBlock(
          '// 4. Idle task — yields to higher-priority work.\n'
          'SchedulerBinding.instance.scheduleTask<void>(\n'
          '  () { /* heavy parse */ },\n'
          '  Priority.idle,\n'
          ');',
        ),
      ],
    ),
  );
}

Widget _calloutHeader() {
  return Container(
    decoration: BoxDecoration(
      color: kAccentCallback,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Row(
      children: const <Widget>[
        SizedBox(
          width: 180,
          child: Text(
            'method',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 140,
          child: Text(
            'fires in',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'frequency / cancel / use',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _calloutRow({
  required String name,
  required String phase,
  required String frequency,
  required String cancel,
  required String useCase,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: const BoxDecoration(
      border: Border(
        left: BorderSide(color: kBorder),
        right: BorderSide(color: kBorder),
        bottom: BorderSide(color: kBorder),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 180,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: kAccentCallback,
            ),
          ),
        ),
        SizedBox(
          width: 140,
          child: Text(
            phase,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: kFgStrong,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'frequency: $frequency',
                style: const TextStyle(fontSize: 11, color: kFgStrong),
              ),
              Text(
                'cancel: $cancel',
                style: const TextStyle(fontSize: 11, color: kFgDim),
              ),
              const SizedBox(height: 4),
              Text(
                useCase,
                style: const TextStyle(fontSize: 11, color: kFgStrong),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: vsync diagram
// ---------------------------------------------------------------------------

Widget _buildVsyncDiagram() {
  // Draw a stylised diagram showing vsync ticks, frame budgets, and the
  // ticker callbacks fired in transientCallbacks per vsync.
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          '6. vsync — why every Ticker needs a TickerProvider',
          Icons.sync_alt,
          kAccentVsync,
        ),
        _bodyText(
          'Every animation in Flutter is gated by a vsync signal. The '
          'display tells the engine "I am ready to scan out a new frame" '
          'at a fixed cadence. The engine wakes the framework, the '
          'framework drives drawFrame, and drawFrame calls every active '
          'Ticker.',
        ),
        const SizedBox(height: 8),
        _bodyText(
          'A TickerProvider exists to associate each Ticker with a vsync '
          'source. In production, that source is the engine. In tests, it '
          'may be a fake driver that advances time deterministically.',
        ),
        const SizedBox(height: 12),
        // Stylised timeline. Six vsync columns.
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: kAccentVsyncSoft,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              _vsyncColumn('v0', 0),
              _vsyncColumn('v1', 1),
              _vsyncColumn('v2', 2),
              _vsyncColumn('v3', 3),
              _vsyncColumn('v4', 4),
              _vsyncColumn('v5', 5),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _bullet('Top dot   = vsync pulse from display.'),
        _bullet('Bar       = the frame budget that vsync starts.'),
        _bullet(
          'Tick label = a Ticker.onTick invocation. Notice they all happen '
          'at the same offset within each budget bar — that is what '
          '"synchronised to vsync" means.',
        ),
        const SizedBox(height: 14),
        const Text(
          'TickerProvider mixins',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        _bullet(
          'SingleTickerProviderStateMixin — for State with exactly one '
          'AnimationController. Cheapest option.',
        ),
        _bullet(
          'TickerProviderStateMixin — for State with multiple controllers. '
          'Tracks every ticker so dispose() can stop them all.',
        ),
        _bullet(
          'Custom — implement TickerProvider yourself when you want to '
          'fake vsync for a test, or pause all animations together.',
        ),
        const SizedBox(height: 12),
        _codeBlock(
          '// Standard pattern (we are NOT in a State here; reference only):\n'
          'class FooState extends State<Foo> with SingleTickerProviderStateMixin {\n'
          '  late final AnimationController _controller = AnimationController(\n'
          '    vsync: this,                  // <-- TickerProvider hookup\n'
          '    duration: const Duration(milliseconds: 300),\n'
          '  );\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _controller.dispose();         // cancels the ticker\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 8),
        _bodyText(
          'When the State is disposed, every Ticker created against `this` '
          'is canceled. Each TickerFuture returned by start() resolves on '
          'its `orCancel` path, throwing TickerCanceled.',
          color: kFgDim,
        ),
      ],
    ),
  );
}

Widget _vsyncColumn(String label, int index) {
  // Build a single column for the vsync diagram.
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // vsync pulse
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: kAccentVsync,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: kAccentVsync,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Frame budget bar
          Container(
            height: 36,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kAccentTicker,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                _tickLabelForIndex(index),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Tick label
          Text(
            'tick#$index',
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: kFgStrong,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _elapsedLabelForIndex(index),
            style: const TextStyle(
              fontSize: 9,
              color: kFgDim,
            ),
          ),
        ],
      ),
    ),
  );
}

String _tickLabelForIndex(int i) {
  // Produce a stable "elapsed since first vsync" label for the diagram.
  return '${i * 16}ms';
}

String _elapsedLabelForIndex(int i) {
  return 't=${i * 16}.67ms';
}

// ---------------------------------------------------------------------------
// Section 7: timeDilation card
// ---------------------------------------------------------------------------

Widget _buildTimeDilationCard() {
  // timeDilation is a global multiplier applied by SchedulerBinding to the
  // duration passed to every transient frame callback. We read it for
  // display but never mutate it.
  final double dilation = timeDilation;
  print('timeDilation = $dilation');

  // For the visual scale we map a dilation of 1.0 to the middle of the bar.
  // Anything > 1.0 stretches; anything between 0 and 1 compresses.
  final double clamped = dilation < 0.0 ? 0.0 : (dilation > 5.0 ? 5.0 : dilation);
  final double frac = clamped / 5.0;

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          '7. timeDilation — the global animation slowdown',
          Icons.slow_motion_video,
          kAmber,
        ),
        _bodyText(
          'timeDilation is a top-level mutable double in '
          'package:flutter/scheduler.dart. The SchedulerBinding divides '
          'every transient callback duration by this value before '
          'dispatching, which effectively slows every animation by that '
          'factor. Setting it to 5.0 produces the famous "slow animations" '
          'devtools toggle.',
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            const SizedBox(
              width: 100,
              child: Text(
                'current',
                style: TextStyle(fontSize: 12, color: kFgDim),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: kBgMutedCard,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: kBorder, width: 0.5),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: frac.clamp(0.0, 1.0),
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: kAmber,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  dilation.toStringAsFixed(2),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _bullet('0.0 < timeDilation < 1.0 — animations run FASTER. Used in tests.'),
        _bullet('timeDilation == 1.0 — production default. No scaling.'),
        _bullet('1.0 < timeDilation < 5.0 — animations slow down visibly.'),
        _bullet('timeDilation >= 5.0 — devtools "slow animations" preset.'),
        const SizedBox(height: 10),
        _codeBlock(
          '// Toggle slow animations from anywhere in app code:\n'
          'import \'package:flutter/scheduler.dart\';\n'
          '\n'
          'void enableSlowAnimations() {\n'
          '  timeDilation = 5.0;\n'
          '}\n'
          '\n'
          'void resetAnimations() {\n'
          '  timeDilation = 1.0;\n'
          '}',
        ),
        const SizedBox(height: 6),
        _bodyText(
          'The setter is global; every Ticker in the isolate is affected '
          'on its next frame.',
          color: kFgDim,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: glossary
// ---------------------------------------------------------------------------

Widget _buildGlossary() {
  // A flat glossary of every term used in this demo. Useful as a final
  // reference card.
  final List<_GlossaryEntry> entries = <_GlossaryEntry>[
    _GlossaryEntry(
      term: 'Ticker',
      gloss:
          'Per-frame callback object. Subclasses do not exist in user code; '
          'this is the base.',
    ),
    _GlossaryEntry(
      term: 'TickerCallback',
      gloss: 'typedef void Function(Duration elapsed). Elapsed is monotonic.',
    ),
    _GlossaryEntry(
      term: 'TickerProvider',
      gloss:
          'Abstract class with a single method createTicker(onTick). '
          'Usually mixed into a State.',
    ),
    _GlossaryEntry(
      term: 'TickerFuture',
      gloss:
          'Future<void> returned by Ticker.start(). Has dual completion: '
          'normal or canceled.',
    ),
    _GlossaryEntry(
      term: 'TickerCanceled',
      gloss:
          'Exception thrown from TickerFuture.orCancel when the ticker '
          'was stopped with canceled=true.',
    ),
    _GlossaryEntry(
      term: 'SchedulerBinding',
      gloss:
          'Singleton that owns the frame pipeline. Holds the timeline, '
          'phase, and registered callbacks.',
    ),
    _GlossaryEntry(
      term: 'SchedulerPhase',
      gloss:
          'Enum of five frame phases: idle, transientCallbacks, '
          'midFrameMicrotasks, persistentCallbacks, postFrameCallbacks.',
    ),
    _GlossaryEntry(
      term: 'FrameTiming',
      gloss:
          'Per-frame stats: build/raster durations, vsync overhead, total '
          'span. Emitted via addTimingsCallback.',
    ),
    _GlossaryEntry(
      term: 'timeDilation',
      gloss:
          'Global scalar that slows every animation. Default 1.0; devtools '
          'sets it to 5.0 for the slow-animation toggle.',
    ),
    _GlossaryEntry(
      term: 'Priority',
      gloss:
          'Integer score used by scheduleTask. Higher wins. Idle, animation, '
          'and touch are the named constants.',
    ),
    _GlossaryEntry(
      term: 'scheduleFrameCallback',
      gloss:
          'Register a one-shot callback that fires in transientCallbacks of '
          'the next frame. Cancel with cancelFrameCallbackWithId.',
    ),
    _GlossaryEntry(
      term: 'addPersistentFrameCallback',
      gloss:
          'Register a callback that fires every frame in persistentCallbacks. '
          'Framework-only in practice.',
    ),
    _GlossaryEntry(
      term: 'addPostFrameCallback',
      gloss:
          'Register a one-shot callback for the end of the next frame. The '
          'go-to "I need to read layout after build" hook.',
    ),
    _GlossaryEntry(
      term: 'scheduleTask',
      gloss:
          'Run a function lazily during idle time, gated by Priority.',
    ),
    _GlossaryEntry(
      term: 'vsync',
      gloss:
          'Vertical-sync pulse from the display, the heartbeat of the '
          'frame pipeline.',
    ),
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('8. Glossary', Icons.menu_book, kFgStrong),
        for (int i = 0; i < entries.length; i++)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: i.isEven ? kBgMutedCard : kBgCard,
              border: Border.all(color: kBorder, width: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 160,
                  child: Text(
                    entries[i].term,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: kAccentTicker,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entries[i].gloss,
                    style: const TextStyle(
                      fontSize: 12,
                      color: kFgStrong,
                      height: 1.4,
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

// ---------------------------------------------------------------------------
// Section 9: diagnostics
// ---------------------------------------------------------------------------

Widget _buildDiagnostics(SchedulerPhase phase, Duration? frameStamp) {
  // A small card that prints the diagnostics from this run. Useful for
  // debugging mismatches between test driver and demo.
  final String phaseStr = phase.name;
  final String stampStr =
      frameStamp == null ? '(not available outside frame)' : frameStamp.toString();

  return _card(
    background: kBgMutedCard,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('9. Diagnostics', Icons.bug_report, kFgDim),
        _kvRow('schedulerPhase', phaseStr),
        _kvRow('currentFrameTimeStamp', stampStr),
        _kvRow('timeDilation', timeDilation.toStringAsFixed(2)),
        _kvRow('Priority.idle.value', Priority.idle.value.toString()),
        _kvRow('Priority.animation.value', Priority.animation.value.toString()),
        _kvRow('Priority.touch.value', Priority.touch.value.toString()),
        _kvRow('Priority.kMaxOffset', Priority.kMaxOffset.toString()),
        _kvRow('SchedulerPhase.values.length',
            SchedulerPhase.values.length.toString()),
        const SizedBox(height: 6),
        _bodyText(
          'These values are read once at build() time. They reflect the '
          'state of the scheduler when this widget tree was constructed.',
          color: kFgDim,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBorder, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'End of tour',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 6),
        _bodyText(
          'You have walked through nine sections covering Ticker, '
          'TickerProvider, TickerFuture, TickerCanceled, SchedulerBinding, '
          'SchedulerPhase, FrameTiming, the four callback registration '
          'shapes, vsync, and timeDilation. None of these called .start() '
          'or scheduled a real frame — the goal was descriptive, not '
          'kinetic.',
        ),
        const SizedBox(height: 6),
        _bodyText(
          'When you are ready to use these for real, head to the '
          'AnimationController / Animation tour. Those classes wrap '
          'Ticker + TickerFuture + Curve and give you the .value getter '
          'most apps actually consume.',
          color: kFgDim,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Plain-data helper classes used to drive sections above
// ---------------------------------------------------------------------------

class _PhaseRow {
  _PhaseRow({
    required this.phase,
    required this.icon,
    required this.color,
    required this.tagline,
    required this.whatRuns,
    required this.scheduleHere,
  });

  final SchedulerPhase phase;
  final IconData icon;
  final Color color;
  final String tagline;
  final String whatRuns;
  final String scheduleHere;
}

class _GlossaryEntry {
  _GlossaryEntry({required this.term, required this.gloss});
  final String term;
  final String gloss;
}
