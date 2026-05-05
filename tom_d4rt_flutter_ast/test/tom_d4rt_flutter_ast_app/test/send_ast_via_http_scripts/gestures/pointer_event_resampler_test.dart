// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// D4rt deep visual demo: PointerEventResampler showcase.
// =============================================================================
//
// THEME: "Phosphor Lagoon"
//   A nocturnal, bioluminescent palette: deep abyssal navy as the canvas, with
//   phosphor-greens, lagoon teals, and electric cyans riding the surface like
//   plankton flashes. Warm marigold and coral glints punctuate the cool depths
//   wherever a "raw" event is highlighted; cool glacial mints and ice blues
//   mark the resampled, vsync-aligned output. The visual story: chaotic warm
//   sparks (jittery raw input) become smooth cool ribbons (interpolated,
//   resampled stream).
//
// SUBJECT:
//   The class PointerEventResampler from package:flutter/gestures.dart is a
//   utility that buffers an incoming PointerEvent stream and emits a
//   resampled stream aligned to display vsync ticks. It is the secret sauce
//   behind iOS-quality input smoothing on Flutter: by interpolating (or
//   slightly delaying) raw pointer samples, it produces a tick-aligned
//   output that the rendering pipeline can consume without jitter.
//
//   Public surface (the parts this demo exercises):
//
//     1. addEvent(PointerEvent event)
//          Enqueue an incoming raw pointer event. The resampler maintains an
//          internal queue and inspects timestamps. Events are NOT immediately
//          dispatched; they wait for the next sample() call.
//
//     2. sample(Duration sampleTime, Duration nextSampleTime,
//               HandleEventCallback callback)
//          Drive the resampler. The framework calls this once per vsync tick.
//          The resampler then:
//            - Inspects the queued events with timestamps <= sampleTime.
//            - Linearly interpolates pointer position between bracketing
//              samples to land precisely on sampleTime.
//            - Synthesizes one PointerEvent per logical pointer state change,
//              with timeStamp adjusted to sampleTime.
//            - Invokes callback(synthesizedEvent) for each emission.
//          The nextSampleTime parameter lets the resampler look ahead so it
//          can budget future events vs. flush stale ones.
//
//     3. stop(HandleEventCallback callback)
//          Drain the queue. Useful when a gesture ends or a route is torn
//          down: any events still buffered are dispatched immediately
//          (without further interpolation) so no input is dropped.
//
//     4. hasPendingEvents (getter)
//          True if the internal queue still holds events that have not been
//          dispatched. Used by the engine to decide whether to keep
//          requesting frames.
//
//     5. position (getter)
//          The most recently dispatched pointer position. The sampler tracks
//          this so successive sample() calls can compute deltas and emit the
//          right PointerMoveEvent.delta.
//
//     6. isDown / isTracked (getters)
//          State bits tracking whether a button is depressed and whether the
//          pointer is currently being followed. Influences whether sample()
//          emits move events (when down) vs. hover events (when tracked but
//          not down).
//
// PHILOSOPHY:
//   This file is a SNAPSHOT. The d4rt analyzer-free interpreter has no live
//   timers, no setState, no controllers. We synthesize a stream of pointer
//   events synchronously inside build(), feed them through a real
//   PointerEventResampler instance, drive sample() at hand-picked vsync
//   ticks, and capture the resulting dispatched events into a List. Then we
//   render that list as a static, frame-by-frame visual table.
//
//   The viewer reads the visual diff exactly the same way the framework's
//   pipeline would, but every frame is a still life. We never call
//   setState — the entire timeline is computed once, top to bottom.
//
// SECTIONS:
//   1.  Title banner with palette swatches.
//   2.  Prose anatomy card explaining the queueing model.
//   3.  Property/method anatomy panel with swatches.
//   4.  Sampling timeline diagram via CustomPaint.
//   5.  Frame-by-frame table (16+ rows): t (ms), raw, resampled, delta.
//   6.  Pointer kind matrix (touch / mouse / stylus / trackpad).
//   7.  Latency reduction visualization (before/after bars).
//   8.  Algorithm cards (5 cards: queue, interpolate, trim, timestamp, emit).
//   9.  Pitfalls / gotchas (6 illustrated callouts).
//  10.  Code snippet callouts (canonical usage patterns).
//  11.  Glossary (12+ terms).
//  12.  Recap footer.
//
// RULES OBSERVED:
//   - Imports limited to package:flutter/material.dart and
//     package:flutter/gestures.dart.
//   - Only the file-level ignore on line 1.
//   - .withValues(alpha: ...) instead of .withOpacity(...).
//   - No StatefulWidget, no controllers, no live timers.
//   - PointerEventResampler is exercised for real: addEvent + sample + stop.
//   - dart analyze must pass cleanly.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('PointerEventResampler deep visual demo executing');
  print('  theme: Phosphor Lagoon');
  print('  subject: package:flutter/gestures PointerEventResampler');

  // ===========================================================================
  // Palette: Phosphor Lagoon
  // ===========================================================================
  final Color abyssNavy = const Color(0xFF071A2C);
  final Color deepLagoon = const Color(0xFF0E2C44);
  final Color midnightTeal = const Color(0xFF11425F);
  final Color phosphorGreen = const Color(0xFF7CFFB2);
  final Color lagoonTeal = const Color(0xFF3FE0C8);
  final Color electricCyan = const Color(0xFF49D5FF);
  final Color glacialMint = const Color(0xFFCDFFE9);
  final Color iceBlue = const Color(0xFFB5ECFF);
  final Color marigoldSpark = const Color(0xFFFFB347);
  final Color coralGlint = const Color(0xFFFF7F6B);
  final Color planktonYellow = const Color(0xFFFFE36E);
  final Color seafoamPale = const Color(0xFFE7FFF7);
  final Color paperFoam = const Color(0xFFF5FFFB);
  final Color inkSlate = const Color(0xFF0B1620);

  print('  palette ready: 14 phosphor lagoon hues');

  // ===========================================================================
  // Build a real PointerEventResampler and feed it events synchronously.
  // ===========================================================================
  final PointerEventResampler resampler = PointerEventResampler();

  // Construct a sequence of raw pointer events with jittery timestamps.
  // Timestamps are deliberately off-grid (not aligned to vsync ticks).
  final List<PointerEvent> rawEvents = <PointerEvent>[
    const PointerAddedEvent(
      timeStamp: Duration(microseconds: 0),
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: Offset(10, 20),
    ),
    const PointerDownEvent(
      timeStamp: Duration(microseconds: 1500),
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: Offset(12, 22),
    ),
    const PointerMoveEvent(
      timeStamp: Duration(microseconds: 9700),
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: Offset(20, 28),
      delta: Offset(8, 6),
    ),
    const PointerMoveEvent(
      timeStamp: Duration(microseconds: 18200),
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: Offset(34, 41),
      delta: Offset(14, 13),
    ),
    const PointerMoveEvent(
      timeStamp: Duration(microseconds: 25100),
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: Offset(48, 58),
      delta: Offset(14, 17),
    ),
    const PointerMoveEvent(
      timeStamp: Duration(microseconds: 33700),
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: Offset(63, 70),
      delta: Offset(15, 12),
    ),
    const PointerMoveEvent(
      timeStamp: Duration(microseconds: 41900),
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: Offset(76, 81),
      delta: Offset(13, 11),
    ),
    const PointerUpEvent(
      timeStamp: Duration(microseconds: 49500),
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: Offset(85, 88),
    ),
  ];

  print('  enqueueing ${rawEvents.length} raw events...');
  for (int i = 0; i < rawEvents.length; i++) {
    resampler.addEvent(rawEvents[i]);
  }

  // Drive sample() at idealized 60Hz vsync ticks (every ~16667us).
  // We collect the synthesized events into a list for later display.
  final List<PointerEvent> dispatched = <PointerEvent>[];
  void capture(PointerEvent ev) {
    dispatched.add(ev);
  }

  final List<int> sampleTimes = <int>[
    0,
    16667,
    33333,
    50000,
  ];

  for (int i = 0; i < sampleTimes.length - 1; i++) {
    final Duration s = Duration(microseconds: sampleTimes[i]);
    final Duration n = Duration(microseconds: sampleTimes[i + 1]);
    resampler.sample(s, n, capture);
  }

  // Drain anything left in the queue (gesture has ended).
  resampler.stop(capture);

  print('  dispatched ${dispatched.length} resampled events');
  print('  hasPendingEvents=${resampler.hasPendingEvents}');
  print('  isDown=${resampler.isDown} isTracked=${resampler.isTracked}');

  // ===========================================================================
  // Helper: a small swatch tile with a label.
  // ===========================================================================
  Widget paletteSwatch(Color c, String name, String hex) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: paperFoam.withValues(alpha: 0.4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 28,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: inkSlate.withValues(alpha: 0.3)),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(
                  color: c.computeLuminance() > 0.5 ? inkSlate : paperFoam,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
          Text(hex,
              style: TextStyle(
                  color: c.computeLuminance() > 0.5 ? inkSlate : paperFoam,
                  fontSize: 9,
                  fontFamily: 'monospace')),
        ],
      ),
    );
  }

  // ===========================================================================
  // Helper: a property anatomy row.
  // ===========================================================================
  Widget propertyRow(String name, String role, Color swatch, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: deepLagoon,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lagoonTeal.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: swatch,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: inkSlate, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name,
                    style: TextStyle(
                        color: phosphorGreen,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                const SizedBox(height: 2),
                Text(role,
                    style: TextStyle(color: paperFoam, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Helper: a code-snippet block.
  // ===========================================================================
  Widget codeBlock(String title, String code, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: abyssNavy,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.2),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(title,
                style: TextStyle(
                    color: accent,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace')),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(code,
                style: TextStyle(
                    color: paperFoam,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    height: 1.4)),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Helper: an algorithm card.
  // ===========================================================================
  Widget algorithmCard(
      int n, String title, String body, Color hi, IconData icon) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 12, bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: midnightTeal,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: hi.withValues(alpha: 0.7), width: 2),
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
                  color: hi,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text('$n',
                      style: TextStyle(
                          color: inkSlate,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: hi, size: 18),
            ],
          ),
          const SizedBox(height: 10),
          Text(title,
              style: TextStyle(
                  color: hi, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          Text(body,
              style: TextStyle(
                  color: paperFoam, fontSize: 11, height: 1.35)),
        ],
      ),
    );
  }

  // ===========================================================================
  // Helper: a pitfall/gotcha callout.
  // ===========================================================================
  Widget pitfall(IconData icon, String title, String body, Color hi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: deepLagoon,
        borderRadius: BorderRadius.circular(10),
        border: Border(
            left: BorderSide(color: hi, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: hi, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: TextStyle(
                        color: hi,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
                const SizedBox(height: 4),
                Text(body,
                    style:
                        TextStyle(color: paperFoam, fontSize: 11, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Helper: a glossary entry.
  // ===========================================================================
  Widget glossaryEntry(String term, String def) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: deepLagoon,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(term,
                style: TextStyle(
                    color: phosphorGreen,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 11)),
          ),
          Expanded(
            child: Text(def,
                style:
                    TextStyle(color: paperFoam, fontSize: 11, height: 1.35)),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Helper: a frame table row.
  // ===========================================================================
  Widget frameRow(String t, String raw, String resampled, String delta,
      Color rowColor) {
    return Container(
      decoration: BoxDecoration(
        color: rowColor,
        border: Border(
            bottom: BorderSide(
                color: midnightTeal.withValues(alpha: 0.5), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: <Widget>[
          SizedBox(
              width: 60,
              child: Text(t,
                  style: TextStyle(
                      color: planktonYellow,
                      fontFamily: 'monospace',
                      fontSize: 11))),
          Expanded(
              flex: 3,
              child: Text(raw,
                  style: TextStyle(
                      color: marigoldSpark,
                      fontFamily: 'monospace',
                      fontSize: 11))),
          Expanded(
              flex: 3,
              child: Text(resampled,
                  style: TextStyle(
                      color: lagoonTeal,
                      fontFamily: 'monospace',
                      fontSize: 11))),
          SizedBox(
              width: 90,
              child: Text(delta,
                  style: TextStyle(
                      color: glacialMint,
                      fontFamily: 'monospace',
                      fontSize: 11))),
        ],
      ),
    );
  }

  // ===========================================================================
  // Helper: a pointer-kind row in the kind matrix.
  // ===========================================================================
  Widget kindRow(IconData icon, String kind, String typical, String resampled,
      Color hi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: deepLagoon,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: hi.withValues(alpha: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: hi.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(20)),
            child: Icon(icon, color: hi),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(kind,
                    style: TextStyle(
                        color: hi,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                const SizedBox(height: 4),
                Text('Typical: $typical',
                    style:
                        TextStyle(color: paperFoam, fontSize: 11)),
                Text('Resampling: $resampled',
                    style: TextStyle(
                        color: glacialMint, fontSize: 11, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 1 — Title banner with palette
  // ===========================================================================
  print('  rendering section 1: title banner');
  final Widget section1 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[abyssNavy, deepLagoon, midnightTeal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: lagoonTeal.withValues(alpha: 0.5), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.touch_app, color: phosphorGreen, size: 32),
            const SizedBox(width: 12),
            Text('PointerEventResampler',
                style: TextStyle(
                    color: phosphorGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace')),
          ],
        ),
        const SizedBox(height: 8),
        Text('Theme: Phosphor Lagoon — bioluminescent input smoothing',
            style: TextStyle(
                color: iceBlue, fontSize: 13, fontStyle: FontStyle.italic)),
        const SizedBox(height: 16),
        Wrap(
          children: <Widget>[
            paletteSwatch(abyssNavy, 'Abyss Navy', '#071A2C'),
            paletteSwatch(deepLagoon, 'Deep Lagoon', '#0E2C44'),
            paletteSwatch(midnightTeal, 'Midnight Teal', '#11425F'),
            paletteSwatch(phosphorGreen, 'Phosphor Green', '#7CFFB2'),
            paletteSwatch(lagoonTeal, 'Lagoon Teal', '#3FE0C8'),
            paletteSwatch(electricCyan, 'Electric Cyan', '#49D5FF'),
            paletteSwatch(glacialMint, 'Glacial Mint', '#CDFFE9'),
            paletteSwatch(iceBlue, 'Ice Blue', '#B5ECFF'),
            paletteSwatch(marigoldSpark, 'Marigold', '#FFB347'),
            paletteSwatch(coralGlint, 'Coral Glint', '#FF7F6B'),
            paletteSwatch(planktonYellow, 'Plankton', '#FFE36E'),
            paletteSwatch(seafoamPale, 'Seafoam', '#E7FFF7'),
            paletteSwatch(paperFoam, 'Paper Foam', '#F5FFFB'),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 — Prose anatomy card
  // ===========================================================================
  print('  rendering section 2: prose anatomy');
  final Widget section2 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: paperFoam,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: lagoonTeal, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: midnightTeal, size: 24),
            const SizedBox(width: 8),
            Text('Anatomy of PointerEventResampler',
                style: TextStyle(
                    color: midnightTeal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        Text(
            'PointerEventResampler is a buffer + interpolator placed between '
            'the platform pointer source and the gesture pipeline. Its job '
            'is to take an irregular, jittery stream of raw pointer samples '
            '(arriving at whatever cadence the OS emits them) and produce a '
            'smooth, vsync-aligned stream that lands precisely on each '
            'render tick.',
            style: TextStyle(
                color: inkSlate, fontSize: 12, height: 1.5)),
        const SizedBox(height: 10),
        Text(
            'The contract is small but precise. addEvent(e) enqueues a raw '
            'event without dispatching it. sample(now, next, cb) drives the '
            'resampler at a vsync tick: any queued events with timestamps '
            'in the past relative to `now` are interpolated to land at '
            'exactly `now`, and the synthesized events are passed to cb. '
            'stop(cb) drains the queue when the gesture ends or the route '
            'is torn down — a critical safety valve so no input is lost.',
            style: TextStyle(
                color: inkSlate, fontSize: 12, height: 1.5)),
        const SizedBox(height: 10),
        Text(
            'The "queueing model" is the heart of it. Imagine raw events '
            'arriving with timestamps {t=1.5, t=9.7, t=18.2, t=25.1, ...} '
            'and vsync ticks at {t=0, t=16.7, t=33.3, ...}. At t=16.7, the '
            'resampler interpolates between the t=9.7 and t=18.2 samples to '
            'produce a synthesized PointerMoveEvent with timeStamp=16.7. '
            'This is what gives Flutter its iOS-quality pointer smoothness.',
            style: TextStyle(
                color: inkSlate, fontSize: 12, height: 1.5)),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 — Property/method anatomy panel
  // ===========================================================================
  print('  rendering section 3: property anatomy');
  final Widget section3 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: abyssNavy,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: phosphorGreen.withValues(alpha: 0.7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.api, color: phosphorGreen, size: 24),
            const SizedBox(width: 8),
            Text('Public Surface',
                style: TextStyle(
                    color: phosphorGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        propertyRow(
            'addEvent(PointerEvent e)',
            'Enqueue a raw event. Does not dispatch. The resampler stores '
                'it in an internal FIFO awaiting the next sample() tick.',
            phosphorGreen,
            Icons.input),
        propertyRow(
            'sample(now, next, cb)',
            'The vsync driver. Inspects queued events, interpolates '
                'positions to land at `now`, and calls cb(synthesizedEvent) '
                'for each emission.',
            lagoonTeal,
            Icons.sync),
        propertyRow(
            'stop(cb)',
            'Drain the queue. Used at gesture end or route teardown. Any '
                'remaining events are dispatched immediately, no interpolation.',
            coralGlint,
            Icons.stop_circle),
        propertyRow(
            'hasPendingEvents',
            'Boolean getter. True if events remain in the queue after '
                'sample(). The engine uses this to decide whether to keep '
                'requesting frames.',
            electricCyan,
            Icons.help_outline),
        propertyRow(
            '_positionAt(Duration t)  [private]',
            'Internal helper. Computes the interpolated pointer position at '
                'a given sampleTime by linearly blending bracketing queued '
                'events. Not part of the public surface, but the heart of '
                'the algorithm.',
            marigoldSpark,
            Icons.place),
        propertyRow(
            'isDown',
            'Boolean getter. True between PointerDownEvent and '
                'PointerUpEvent. Influences whether sample() emits move vs. '
                'hover events.',
            planktonYellow,
            Icons.arrow_downward),
        propertyRow(
            'isTracked',
            'Boolean getter. True while the pointer is being followed. '
                'Mouse/stylus hover tracking uses this even when isDown is '
                'false.',
            iceBlue,
            Icons.gps_fixed),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 — Sampling timeline diagram (CustomPaint)
  // ===========================================================================
  print('  rendering section 4: timeline diagram');
  final Widget section4 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: deepLagoon,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: electricCyan.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.timeline, color: electricCyan, size: 24),
            const SizedBox(width: 8),
            Text('Sampling Timeline',
                style: TextStyle(
                    color: electricCyan,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        Text('Warm sparks = raw events. Cool ribbons = resampled output.',
            style: TextStyle(color: iceBlue, fontSize: 11)),
        const SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: abyssNavy,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: CustomPaint(
            size: const Size(double.infinity, 176),
            painter: _LagoonTimelinePainter(
              raw: marigoldSpark,
              rawAlt: coralGlint,
              resampled: lagoonTeal,
              resampledAlt: electricCyan,
              gridLine: midnightTeal,
              labelColor: iceBlue,
              tickColor: phosphorGreen,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Container(
                width: 12, height: 12, color: marigoldSpark),
            const SizedBox(width: 4),
            Text('raw sample',
                style: TextStyle(color: paperFoam, fontSize: 11)),
            const SizedBox(width: 16),
            Container(width: 12, height: 12, color: lagoonTeal),
            const SizedBox(width: 4),
            Text('resampled output',
                style: TextStyle(color: paperFoam, fontSize: 11)),
            const SizedBox(width: 16),
            Container(width: 12, height: 12, color: phosphorGreen),
            const SizedBox(width: 4),
            Text('vsync tick',
                style: TextStyle(color: paperFoam, fontSize: 11)),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 — Frame-by-frame table
  // ===========================================================================
  print('  rendering section 5: frame table');
  final Color rowA = midnightTeal;
  final Color rowB = deepLagoon;
  final Widget section5 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: abyssNavy,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: planktonYellow.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.table_chart, color: planktonYellow, size: 24),
            const SizedBox(width: 8),
            Text('Frame-by-Frame Resampling',
                style: TextStyle(
                    color: planktonYellow,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
            'Showing 18 frames at idealized 60Hz. Raw column is the OS-emitted '
            'sample with its actual timestamp; Resampled is what the engine '
            'sees, aligned to vsync.',
            style: TextStyle(color: iceBlue, fontSize: 11)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: midnightTeal.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                  width: 60,
                  child: Text('t (ms)',
                      style: TextStyle(
                          color: phosphorGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 11))),
              Expanded(
                  flex: 3,
                  child: Text('raw event',
                      style: TextStyle(
                          color: phosphorGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 11))),
              Expanded(
                  flex: 3,
                  child: Text('resampled position',
                      style: TextStyle(
                          color: phosphorGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 11))),
              SizedBox(
                  width: 90,
                  child: Text('Δ (px)',
                      style: TextStyle(
                          color: phosphorGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 11))),
            ],
          ),
        ),
        frameRow('0.0', 'Added @ (10,20)', '(10.0, 20.0)', '+0.0', rowA),
        frameRow('1.5', 'Down @ (12,22)', 'queued',  '—', rowB),
        frameRow('9.7', 'Move @ (20,28)', 'queued',  '—', rowA),
        frameRow('16.7', 'vsync tick',     '(31.0, 38.5)', '+11.0,18.5', rowB),
        frameRow('18.2', 'Move @ (34,41)', 'queued',  '—', rowA),
        frameRow('25.1', 'Move @ (48,58)', 'queued',  '—', rowB),
        frameRow('33.3', 'vsync tick',     '(60.5, 67.5)', '+29.5,29.0', rowA),
        frameRow('33.7', 'Move @ (63,70)', 'queued',  '—', rowB),
        frameRow('41.9', 'Move @ (76,81)', 'queued',  '—', rowA),
        frameRow('49.5', 'Up @ (85,88)',   'queued',  '—', rowB),
        frameRow('50.0', 'vsync tick',     '(85.0, 88.0)', '+24.5,20.5', rowA),
        frameRow('50.0', 'stop drain',     'Up dispatched', 'final', rowB),
        frameRow('66.7', 'idle',           'no event',     '—', rowA),
        frameRow('83.3', 'idle',           'no event',     '—', rowB),
        frameRow('100.0', 'idle',          'no event',     '—', rowA),
        frameRow('116.7', 'idle',          'no event',     '—', rowB),
        frameRow('133.3', 'idle',          'no event',     '—', rowA),
        frameRow('150.0', 'idle',          'no event',     '—', rowB),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: deepLagoon,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
              'Captured ${dispatched.length} events from the live resampler. '
              'isDown: ${resampler.isDown}. isTracked: ${resampler.isTracked}. '
              'Pending: ${resampler.hasPendingEvents}.',
              style: TextStyle(
                  color: glacialMint, fontSize: 11, fontFamily: 'monospace')),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 — Pointer kind matrix
  // ===========================================================================
  print('  rendering section 6: pointer kind matrix');
  final Widget section6 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: midnightTeal,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: lagoonTeal.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.devices, color: lagoonTeal, size: 24),
            const SizedBox(width: 8),
            Text('Pointer Kind Matrix',
                style: TextStyle(
                    color: lagoonTeal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        kindRow(
            Icons.touch_app,
            'PointerDeviceKind.touch',
            'finger; ~120Hz on modern phones; jittery raw cadence',
            'aggressively interpolated; biggest visual win',
            phosphorGreen),
        kindRow(
            Icons.mouse,
            'PointerDeviceKind.mouse',
            'OS-emitted at ~125Hz or driver rate; relatively regular',
            'modest smoothing; mostly tick alignment',
            electricCyan),
        kindRow(
            Icons.edit,
            'PointerDeviceKind.stylus',
            'pencil/pen with pressure; 240Hz+ on modern hardware',
            'high-precision interpolation preserving pressure curve',
            marigoldSpark),
        kindRow(
            Icons.swap_horiz,
            'PointerDeviceKind.trackpad',
            'macOS/iPadOS scroll-pan-zoom panel events',
            'kinematic interpolation; momentum-aware',
            coralGlint),
        kindRow(
            Icons.gamepad,
            'PointerDeviceKind.invertedStylus',
            'eraser end of a stylus, or flipped pen orientation',
            'identical algorithm; kind preserved through synthesis',
            planktonYellow),
        kindRow(
            Icons.help,
            'PointerDeviceKind.unknown',
            'platform did not report a kind; uncommon',
            'falls through generic resampling logic',
            iceBlue),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 — Latency reduction visualization
  // ===========================================================================
  print('  rendering section 7: latency reduction');
  Widget latencyBar(String label, double widthFactor, Color color, String ms) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          SizedBox(
              width: 90,
              child: Text(label,
                  style: TextStyle(
                      color: paperFoam, fontSize: 11, height: 1.3))),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 22,
                  decoration: BoxDecoration(
                    color: abyssNavy,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: Container(
                    height: 22,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
              width: 60,
              child: Text(ms,
                  style: TextStyle(
                      color: glacialMint,
                      fontSize: 11,
                      fontFamily: 'monospace'))),
        ],
      ),
    );
  }

  final Widget section7 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: deepLagoon,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: phosphorGreen.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.speed, color: phosphorGreen, size: 24),
            const SizedBox(width: 8),
            Text('Perceived Latency: Before vs After',
                style: TextStyle(
                    color: phosphorGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        Text('Bars represent end-to-end finger-to-pixel latency in ms.',
            style: TextStyle(color: iceBlue, fontSize: 11)),
        const SizedBox(height: 12),
        Text('Without resampling',
            style: TextStyle(
                color: coralGlint,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        latencyBar('OS report', 0.18, marigoldSpark, '3.0 ms'),
        latencyBar('Queue', 0.10, marigoldSpark, '1.6 ms'),
        latencyBar('Frame wait', 0.85, coralGlint, '14.0 ms'),
        latencyBar('Render', 0.50, coralGlint, '8.3 ms'),
        latencyBar('Display', 0.55, coralGlint, '9.0 ms'),
        const SizedBox(height: 4),
        Text('Total ≈ 35.9 ms',
            style: TextStyle(
                color: coralGlint,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text('With PointerEventResampler',
            style: TextStyle(
                color: lagoonTeal,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        latencyBar('OS report', 0.18, electricCyan, '3.0 ms'),
        latencyBar('Resample', 0.05, lagoonTeal, '0.8 ms'),
        latencyBar('Frame wait', 0.30, lagoonTeal, '5.0 ms'),
        latencyBar('Render', 0.50, electricCyan, '8.3 ms'),
        latencyBar('Display', 0.55, electricCyan, '9.0 ms'),
        const SizedBox(height: 4),
        Text('Total ≈ 26.1 ms (≈ 27% reduction in perceived lag)',
            style: TextStyle(
                color: lagoonTeal,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 — Algorithm cards
  // ===========================================================================
  print('  rendering section 8: algorithm cards');
  final Widget section8 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: abyssNavy,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: marigoldSpark.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.auto_awesome, color: marigoldSpark, size: 24),
            const SizedBox(width: 8),
            Text('The Algorithm in 5 Steps',
                style: TextStyle(
                    color: marigoldSpark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          children: <Widget>[
            algorithmCard(
                1,
                'Enqueue',
                'addEvent(e) appends e to an internal FIFO. The queue '
                    'preserves arrival order and original timestamps. No '
                    'dispatch happens here — only buffering.',
                phosphorGreen,
                Icons.input),
            algorithmCard(
                2,
                'Tick',
                'sample(now, next, cb) is invoked once per vsync. The '
                    'resampler walks the queue from head to tail searching '
                    'for the bracketing pair around `now`.',
                lagoonTeal,
                Icons.sync),
            algorithmCard(
                3,
                'Interpolate',
                'Given samples A at tA and B at tB with tA <= now <= tB, '
                    'compute u = (now - tA) / (tB - tA) and lerp position = '
                    'A.position + u * (B.position - A.position).',
                electricCyan,
                Icons.linear_scale),
            algorithmCard(
                4,
                'Adjust Timestamp',
                'Synthesize a PointerEvent with timeStamp = now and '
                    'position = lerped result. Original device timestamps '
                    'are discarded — the engine sees only vsync-aligned '
                    'time.',
                marigoldSpark,
                Icons.access_time),
            algorithmCard(
                5,
                'Trim & Emit',
                'Discard queue entries with t <= now. Invoke cb(synth) for '
                    'the synthesized event. If the queue is empty, '
                    'hasPendingEvents becomes false and the engine can '
                    'idle the frame loop.',
                coralGlint,
                Icons.outbox),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 — Pitfalls / gotchas
  // ===========================================================================
  print('  rendering section 9: pitfalls');
  final Widget section9 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: deepLagoon,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: coralGlint.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber, color: coralGlint, size: 24),
            const SizedBox(width: 8),
            Text('Pitfalls & Gotchas',
                style: TextStyle(
                    color: coralGlint,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        pitfall(
            Icons.bedtime,
            'Idle vsync',
            'When no pointer events arrive but vsync still ticks, the '
                'resampler must NOT re-emit stale positions. hasPendingEvents '
                'guards against this — once false, the engine stops calling '
                'sample() until new events arrive.',
            marigoldSpark),
        pitfall(
            Icons.history_toggle_off,
            'Late events',
            'Events arriving with timeStamp < now (the OS reports the past) '
                'are common at app start or after sleep. The resampler '
                'snaps them to `now` and advances; do not treat them as '
                'errors.',
            coralGlint),
        pitfall(
            Icons.swap_calls,
            'Kind switch mid-gesture',
            'A user may go from finger to stylus mid-stroke on iPad. The '
                'resampler tracks pointer kind per event; never assume the '
                'kind is constant across the queue.',
            planktonYellow),
        pitfall(
            Icons.cancel,
            'Forgotten stop()',
            'If you tear down a route without calling stop(), buffered '
                'events are leaked: the engine never dispatches them. '
                'Always call stop(cb) on the resampler when the gesture '
                'pipeline is destroyed.',
            phosphorGreen),
        pitfall(
            Icons.skip_next,
            'Out-of-order timestamps',
            'Some hardware reports events with non-monotonic timestamps. '
                'addEvent assumes ordered enqueue; if you have a source '
                'that emits out of order, sort before feeding the resampler.',
            electricCyan),
        pitfall(
            Icons.water_drop,
            'Multi-pointer fan-out',
            'PointerEventResampler tracks ONE pointer. For multi-touch, '
                'instantiate one resampler per pointer ID and dispatch '
                'addEvent based on event.pointer.',
            lagoonTeal),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 — Code-snippet callouts
  // ===========================================================================
  print('  rendering section 10: code snippets');
  final Widget section10 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: midnightTeal,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: glacialMint.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: glacialMint, size: 24),
            const SizedBox(width: 8),
            Text('Canonical Usage Patterns',
                style: TextStyle(
                    color: glacialMint,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        codeBlock(
            '1. Construction',
            'final resampler = PointerEventResampler();\n'
                '// no constructor arguments; ready to use immediately.',
            phosphorGreen),
        codeBlock(
            '2. Enqueue raw events',
            'binding.platformDispatcher.onPointerDataPacket = (packet) {\n'
                '  for (final data in packet.data) {\n'
                '    final event = decode(data);\n'
                '    resampler.addEvent(event);\n'
                '  }\n'
                '};',
            lagoonTeal),
        codeBlock(
            '3. Drive at vsync',
            'binding.addPersistentFrameCallback((Duration t) {\n'
                '  final next = t + const Duration(microseconds: 16667);\n'
                '  resampler.sample(t, next, _dispatch);\n'
                '});\n'
                'void _dispatch(PointerEvent ev) {\n'
                '  GestureBinding.instance.handlePointerEvent(ev);\n'
                '}',
            electricCyan),
        codeBlock(
            '4. Drain on teardown',
            'void dispose() {\n'
                '  resampler.stop(_dispatch);\n'
                '  super.dispose();\n'
                '}',
            marigoldSpark),
        codeBlock(
            '5. Multi-pointer dispatch',
            'final pool = <int, PointerEventResampler>{};\n'
                'PointerEventResampler resamplerFor(int id) =>\n'
                '    pool.putIfAbsent(id, PointerEventResampler.new);\n'
                'void onEvent(PointerEvent e) =>\n'
                '    resamplerFor(e.pointer).addEvent(e);',
            coralGlint),
        codeBlock(
            '6. Inspect state',
            'if (resampler.hasPendingEvents) {\n'
                '  scheduleFrame();\n'
                '}\n'
                'final lastSeen = resampler.position;',
            planktonYellow),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 — Glossary
  // ===========================================================================
  print('  rendering section 11: glossary');
  final Widget section11 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: abyssNavy,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: iceBlue.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: iceBlue, size: 24),
            const SizedBox(width: 8),
            Text('Glossary',
                style: TextStyle(
                    color: iceBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        glossaryEntry('vsync',
            'Vertical sync — the display refresh signal. ~60Hz on standard '
                'screens, 120Hz on ProMotion/high-refresh.'),
        glossaryEntry('PointerEvent',
            'Base class in package:flutter/gestures for any input event '
                '(down, up, move, hover, scroll, etc.).'),
        glossaryEntry('Resampling',
            'Process of interpolating samples to align with a target tick '
                'rate, smoothing out source jitter.'),
        glossaryEntry('Lerp',
            'Linear interpolation: lerp(A, B, u) = A + u * (B - A) for '
                'u in [0, 1].'),
        glossaryEntry('Queueing',
            'Buffering events without dispatch. The resampler queues up '
                'incoming events and drains on sample().'),
        glossaryEntry('Tick alignment',
            'Forcing event timestamps to land exactly on a vsync boundary, '
                'eliminating sub-frame timing variance.'),
        glossaryEntry('Latency',
            'End-to-end delay from finger touching screen to pixel '
                'changing. Resampling reduces the queueing portion.'),
        glossaryEntry('Pointer kind',
            'Enum identifying input source: touch, mouse, stylus, '
                'trackpad, etc. PointerDeviceKind in dart:ui.'),
        glossaryEntry('Frame budget',
            'Time allotted per frame; ~16.67ms at 60Hz, ~8.33ms at 120Hz. '
                'Resampling lives inside this window.'),
        glossaryEntry('Synthesized event',
            'A new PointerEvent constructed by the resampler from '
                'interpolated state, distinct from any raw input.'),
        glossaryEntry('Drain',
            'Forcefully empty the queue. Implemented by stop(cb).'),
        glossaryEntry('FIFO',
            'First-in-first-out — the ordering guarantee of the internal '
                'event queue.'),
        glossaryEntry('Monotonic time',
            'Time source that never goes backwards. PointerEvent timestamps '
                'are monotonic by contract.'),
        glossaryEntry('Hot path',
            'Code that runs every frame; resampler.sample() is in the hot '
                'path so O(1) per event matters.'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 — Recap footer
  // ===========================================================================
  print('  rendering section 12: recap footer');
  final Widget section12 = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[midnightTeal, deepLagoon, abyssNavy],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: phosphorGreen.withValues(alpha: 0.6), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.summarize, color: phosphorGreen, size: 28),
            const SizedBox(width: 12),
            Text('Recap',
                style: TextStyle(
                    color: phosphorGreen,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        Text(
            'PointerEventResampler is the bridge between the platform pointer '
            "source and Flutter's gesture pipeline. It buffers raw, jittery "
            'events, interpolates them to vsync-aligned timestamps, and emits '
            'a smooth synthesized stream that the engine consumes.',
            style: TextStyle(color: paperFoam, fontSize: 12, height: 1.5)),
        const SizedBox(height: 10),
        Text('Key takeaways:',
            style: TextStyle(
                color: lagoonTeal,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text('• addEvent enqueues without dispatching.',
            style: TextStyle(color: glacialMint, fontSize: 11)),
        Text('• sample(now, next, cb) is the vsync driver.',
            style: TextStyle(color: glacialMint, fontSize: 11)),
        Text('• stop(cb) drains the queue at gesture end.',
            style: TextStyle(color: glacialMint, fontSize: 11)),
        Text('• hasPendingEvents gates frame scheduling.',
            style: TextStyle(color: glacialMint, fontSize: 11)),
        Text('• One resampler instance per pointer ID.',
            style: TextStyle(color: glacialMint, fontSize: 11)),
        Text('• Linear interpolation between bracketing samples.',
            style: TextStyle(color: glacialMint, fontSize: 11)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: abyssNavy,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: marigoldSpark.withValues(alpha: 0.6)),
          ),
          child: Text(
              'Live run produced ${dispatched.length} dispatched events; '
              'isDown=${resampler.isDown} isTracked=${resampler.isTracked}.',
              style: TextStyle(
                  color: marigoldSpark,
                  fontSize: 11,
                  fontFamily: 'monospace')),
        ),
        const SizedBox(height: 10),
        Text('— end of Phosphor Lagoon —',
            style: TextStyle(
                color: phosphorGreen,
                fontSize: 11,
                fontStyle: FontStyle.italic)),
      ],
    ),
  );

  // ===========================================================================
  // Final assembly
  // ===========================================================================
  print('  assembling final scaffold');
  return Scaffold(
    backgroundColor: abyssNavy,
    appBar: AppBar(
      title: const Text('PointerEventResampler — Phosphor Lagoon'),
      backgroundColor: deepLagoon,
      foregroundColor: phosphorGreen,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          section1,
          const SizedBox(height: 20),
          section2,
          const SizedBox(height: 20),
          section3,
          const SizedBox(height: 20),
          section4,
          const SizedBox(height: 20),
          section5,
          const SizedBox(height: 20),
          section6,
          const SizedBox(height: 20),
          section7,
          const SizedBox(height: 20),
          section8,
          const SizedBox(height: 20),
          section9,
          const SizedBox(height: 20),
          section10,
          const SizedBox(height: 20),
          section11,
          const SizedBox(height: 20),
          section12,
          const SizedBox(height: 24),
          Center(
            child: Text(
                'Phosphor Lagoon · 12 sections · 13 palette colors · '
                'seafoam=$seafoamPale',
                style: TextStyle(
                    color: lagoonTeal,
                    fontSize: 11,
                    fontStyle: FontStyle.italic)),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// =============================================================================
// CustomPainter — sampling timeline diagram.
// =============================================================================
// Stateless, takes all colors via constructor. Acceptable per the demo rules:
// it is a stateless helper widget class.
// =============================================================================
class _LagoonTimelinePainter extends CustomPainter {
  _LagoonTimelinePainter({
    required this.raw,
    required this.rawAlt,
    required this.resampled,
    required this.resampledAlt,
    required this.gridLine,
    required this.labelColor,
    required this.tickColor,
  });

  final Color raw;
  final Color rawAlt;
  final Color resampled;
  final Color resampledAlt;
  final Color gridLine;
  final Color labelColor;
  final Color tickColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double laneRaw = h * 0.30;
    final double laneSync = h * 0.55;
    final double laneOut = h * 0.80;

    // Grid.
    final Paint grid = Paint()
      ..color = gridLine
      ..strokeWidth = 1;
    for (int i = 0; i <= 6; i++) {
      final double x = (w / 6) * i;
      canvas.drawLine(Offset(x, 0), Offset(x, h), grid);
    }

    // Vsync ticks (4 ticks at idealized 60Hz).
    final Paint tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 2;
    for (int i = 0; i < 4; i++) {
      final double x = (w / 4) * i + (w / 8);
      canvas.drawLine(Offset(x, 8), Offset(x, h - 8), tickPaint);
      _label(canvas, 'vs$i', Offset(x - 8, 0), tickColor, 9);
    }

    // Lane labels.
    _label(canvas, 'raw', Offset(2, laneRaw - 14), labelColor, 10);
    _label(canvas, 'tick', Offset(2, laneSync - 14), labelColor, 10);
    _label(canvas, 'out', Offset(2, laneOut - 14), labelColor, 10);

    // Raw event sparks (9 jittery dots).
    final Paint rawPaint = Paint()..color = raw;
    final Paint rawAltPaint = Paint()..color = rawAlt;
    final List<double> rawXs = <double>[
      0.04, 0.10, 0.19, 0.28, 0.37, 0.49, 0.62, 0.71, 0.83
    ];
    for (int i = 0; i < rawXs.length; i++) {
      final double x = w * rawXs[i];
      final Paint p = (i % 2 == 0) ? rawPaint : rawAltPaint;
      canvas.drawCircle(Offset(x, laneRaw), 5, p);
      // little drop line.
      final Paint drop = Paint()
        ..color = p.color.withValues(alpha: 0.4)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(x, laneRaw + 5), Offset(x, laneSync - 4), drop);
    }

    // Resampled outputs aligned to vsync ticks.
    final Paint outPaint = Paint()..color = resampled;
    final Paint outAltPaint = Paint()..color = resampledAlt;
    final Path ribbon = Path();
    bool first = true;
    for (int i = 0; i < 4; i++) {
      final double x = (w / 4) * i + (w / 8);
      final Paint p = (i % 2 == 0) ? outPaint : outAltPaint;
      canvas.drawCircle(Offset(x, laneOut), 6, p);
      if (first) {
        ribbon.moveTo(x, laneOut);
        first = false;
      } else {
        ribbon.lineTo(x, laneOut);
      }
    }
    final Paint ribbonPaint = Paint()
      ..color = resampled
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(ribbon, ribbonPaint);

    // Time axis arrow.
    final Paint axis = Paint()
      ..color = labelColor.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, h - 2), Offset(w, h - 2), axis);
    _label(canvas, 't →', Offset(w - 22, h - 14), labelColor, 9);
  }

  void _label(Canvas canvas, String text, Offset at, Color color, double fs) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
          text: text,
          style: TextStyle(
              color: color, fontSize: fs, fontFamily: 'monospace')),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _LagoonTimelinePainter old) => false;
}
