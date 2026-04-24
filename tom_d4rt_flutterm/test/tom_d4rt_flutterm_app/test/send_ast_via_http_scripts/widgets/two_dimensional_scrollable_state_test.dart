// D4rt test script: Deep Demo — TwoDimensionalScrollableState
//
// This file is a deep, hand-authored visual demo of
// `TwoDimensionalScrollableState` — the State object of
// `TwoDimensionalScrollable`. The State exposes two getters,
// `verticalScrollable` and `horizontalScrollable`, each returning a
// `ScrollableState`. Those inner states expose the axis-specific
// `ScrollPosition`, so app code holding a
// `GlobalKey<TwoDimensionalScrollableState>` can drive the 2D viewport
// imperatively by calling `animateTo` / `jumpTo` on each axis independently.
//
// The app presents a small cartographer's workbench: a preamble card
// introduces the API, a "map" scenario shows a 2D grid of city markers
// driven by a compass rose, an animate-vs-jump scenario demonstrates
// easing curves, a "tour" scenario animates through a sequence of
// preset coordinates, a mini-map renders the current viewport rectangle
// inside the full map bounds, a diagnostics panel reads live pixel
// values from both inner scrollables, and an epilogue card summarises
// lifecycle notes and when to prefer the state's imperative API over a
// custom `TwoDimensionalViewport`.
//
// The demo authors a minimal fixed-cell 2D viewport ("the cartograph
// grid") so the `TwoDimensionalScrollable` has something real to drive
// — it follows the same shape seen in sibling demos: a subclass of
// `TwoDimensionalViewport` backed by a `RenderTwoDimensionalViewport`
// that walks the visible cell window.

import 'dart:math' as math;

import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;
import 'package:flutter/scheduler.dart' show Ticker;

// ---------------------------------------------------------------------------
// Theme tokens — parchment cream + deep navy + aged brass. Every colour has
// a semantic name; we avoid `withOpacity` (analyzer lint) in favour of
// `withValues(alpha: ...)` throughout the demo. The prefix `_twoDSS` keeps
// tokens private and lowerCamelCase-compliant for the analyzer while
// preserving the visual "TwoDSS" scoping hinted at in the brief.
// ---------------------------------------------------------------------------
const Color _twoDSSParchment = Color(0xFFF4EAD1);
const Color _twoDSSParchmentDeep = Color(0xFFE7D8AF);
const Color _twoDSSParchmentShadow = Color(0xFFCBBB8E);
const Color _twoDSSInkNavy = Color(0xFF0C1A3A);
const Color _twoDSSInkNavyMid = Color(0xFF1A2B55);
const Color _twoDSSInkNavyBright = Color(0xFF2D4483);
const Color _twoDSSBrass = Color(0xFFB08740);
const Color _twoDSSBrassBright = Color(0xFFD9A94A);
const Color _twoDSSBrassDeep = Color(0xFF7E5E23);
const Color _twoDSSSeal = Color(0xFF8A3E2C);
const Color _twoDSSSealBright = Color(0xFFC35741);
const Color _twoDSSMossGreen = Color(0xFF4E6B45);
const Color _twoDSSMossBright = Color(0xFF7DA472);
const Color _twoDSSInkFaint = Color(0xFF3A3628);

// ---------------------------------------------------------------------------
// Top-level entry expected by the d4rt harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('TwoDimensionalScrollableState deep demo booting...');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TwoDimensionalScrollableState Deep Demo',
    home: _TwoDSSHome(),
  );
}

// ---------------------------------------------------------------------------
// Data model — a small fictional archipelago. The map is a 40-column by
// 30-row grid of 84-pixel cells; certain cells host named landmarks
// (cities, harbours, watchtowers). The mini-map and the tour preset list
// refer to these by `ChildVicinity` coordinates.
// ---------------------------------------------------------------------------
const double _twoDSSCellSize = 84.0;
const int _twoDSSMapColumns = 40;
const int _twoDSSMapRows = 30;

class _TwoDSSLandmark {
  const _TwoDSSLandmark({
    required this.column,
    required this.row,
    required this.name,
    required this.type,
    required this.lore,
    required this.glyph,
  });

  final int column;
  final int row;
  final String name;
  final _TwoDSSLandmarkType type;
  final String lore;
  final IconData glyph;
}

enum _TwoDSSLandmarkType {
  capital,
  harbour,
  fortress,
  lighthouse,
  market,
  grove,
  ruin,
  bridge,
  shrine,
  observatory,
}

Color _twoDSSColourFor(_TwoDSSLandmarkType type) {
  switch (type) {
    case _TwoDSSLandmarkType.capital:
      return _twoDSSSeal;
    case _TwoDSSLandmarkType.harbour:
      return _twoDSSInkNavyBright;
    case _TwoDSSLandmarkType.fortress:
      return _twoDSSBrassDeep;
    case _TwoDSSLandmarkType.lighthouse:
      return _twoDSSBrassBright;
    case _TwoDSSLandmarkType.market:
      return _twoDSSSealBright;
    case _TwoDSSLandmarkType.grove:
      return _twoDSSMossGreen;
    case _TwoDSSLandmarkType.ruin:
      return _twoDSSInkFaint;
    case _TwoDSSLandmarkType.bridge:
      return _twoDSSInkNavyMid;
    case _TwoDSSLandmarkType.shrine:
      return _twoDSSMossBright;
    case _TwoDSSLandmarkType.observatory:
      return _twoDSSBrass;
  }
}

String _twoDSSLabelFor(_TwoDSSLandmarkType type) {
  switch (type) {
    case _TwoDSSLandmarkType.capital:
      return 'Capital';
    case _TwoDSSLandmarkType.harbour:
      return 'Harbour';
    case _TwoDSSLandmarkType.fortress:
      return 'Fortress';
    case _TwoDSSLandmarkType.lighthouse:
      return 'Lighthouse';
    case _TwoDSSLandmarkType.market:
      return 'Market';
    case _TwoDSSLandmarkType.grove:
      return 'Grove';
    case _TwoDSSLandmarkType.ruin:
      return 'Ruin';
    case _TwoDSSLandmarkType.bridge:
      return 'Bridge';
    case _TwoDSSLandmarkType.shrine:
      return 'Shrine';
    case _TwoDSSLandmarkType.observatory:
      return 'Observatory';
  }
}

const List<_TwoDSSLandmark> _twoDSSLandmarks = <_TwoDSSLandmark>[
  _TwoDSSLandmark(
    column: 3,
    row: 4,
    name: 'Port Vesper',
    type: _TwoDSSLandmarkType.harbour,
    lore: 'Evening tide harbour; tea clippers refit here every third moon.',
    glyph: Icons.anchor,
  ),
  _TwoDSSLandmark(
    column: 6,
    row: 2,
    name: 'Lantern Point',
    type: _TwoDSSLandmarkType.lighthouse,
    lore: 'A brass lantern atop basalt, visible nineteen leagues at sea.',
    glyph: Icons.lightbulb_outline,
  ),
  _TwoDSSLandmark(
    column: 9,
    row: 6,
    name: 'Saffron Market',
    type: _TwoDSSLandmarkType.market,
    lore: 'Dust-gold awnings; the spice ledger is kept in three languages.',
    glyph: Icons.storefront,
  ),
  _TwoDSSLandmark(
    column: 12,
    row: 3,
    name: 'Fort Brassgate',
    type: _TwoDSSLandmarkType.fortress,
    lore: 'Six-sided garrison keep; garrison of ninety, rotated quarterly.',
    glyph: Icons.shield_moon,
  ),
  _TwoDSSLandmark(
    column: 15,
    row: 9,
    name: 'Olive Grove of Theodora',
    type: _TwoDSSLandmarkType.grove,
    lore: 'Ancient terraced grove; presses ninety barrels per season.',
    glyph: Icons.park,
  ),
  _TwoDSSLandmark(
    column: 18,
    row: 5,
    name: 'Cinnabar Capital',
    type: _TwoDSSLandmarkType.capital,
    lore: 'Seat of the cartographers\' guild. Hosts the compass-rose census.',
    glyph: Icons.location_city,
  ),
  _TwoDSSLandmark(
    column: 22,
    row: 11,
    name: 'Broken Aqueduct',
    type: _TwoDSSLandmarkType.ruin,
    lore: 'Collapsed in the quake of the late seventh year; still walkable.',
    glyph: Icons.domain_disabled,
  ),
  _TwoDSSLandmark(
    column: 25,
    row: 7,
    name: 'Moonbridge',
    type: _TwoDSSLandmarkType.bridge,
    lore: 'Single-arch stonework; the keystone is carved with the mason\'s name.',
    glyph: Icons.horizontal_rule,
  ),
  _TwoDSSLandmark(
    column: 28,
    row: 14,
    name: 'Shrine of Quiet Mornings',
    type: _TwoDSSLandmarkType.shrine,
    lore: 'A single bell, rung twice per sunrise; visitors remove their shoes.',
    glyph: Icons.self_improvement,
  ),
  _TwoDSSLandmark(
    column: 32,
    row: 8,
    name: 'Astrolabe Observatory',
    type: _TwoDSSLandmarkType.observatory,
    lore: 'Four-storey bronze dome; the astrolabe dates to the second dynasty.',
    glyph: Icons.visibility,
  ),
  _TwoDSSLandmark(
    column: 34,
    row: 18,
    name: 'Coral Harbour',
    type: _TwoDSSLandmarkType.harbour,
    lore: 'Submerged reef-gardens; fishing fleet of forty-two small dhows.',
    glyph: Icons.sailing,
  ),
  _TwoDSSLandmark(
    column: 37,
    row: 22,
    name: 'Fort Umber',
    type: _TwoDSSLandmarkType.fortress,
    lore: 'Built from umber sandstone; garrisons the southern frontier.',
    glyph: Icons.fort,
  ),
  _TwoDSSLandmark(
    column: 5,
    row: 15,
    name: 'Silverleaf Grove',
    type: _TwoDSSLandmarkType.grove,
    lore: 'Wind-sculpted silver poplars, their bark used for map-making vellum.',
    glyph: Icons.forest,
  ),
  _TwoDSSLandmark(
    column: 10,
    row: 19,
    name: 'Old Spice Market',
    type: _TwoDSSLandmarkType.market,
    lore: 'Closed on the tenth day; spice ledgers archived in the capital.',
    glyph: Icons.local_grocery_store,
  ),
  _TwoDSSLandmark(
    column: 14,
    row: 23,
    name: 'Watchtower Rhea',
    type: _TwoDSSLandmarkType.lighthouse,
    lore: 'A seamark, not truly a lighthouse; burns a single brass brazier.',
    glyph: Icons.emoji_flags,
  ),
  _TwoDSSLandmark(
    column: 20,
    row: 26,
    name: 'South Capital',
    type: _TwoDSSLandmarkType.capital,
    lore: 'Seasonal seat; royal household migrates here during the dry months.',
    glyph: Icons.apartment,
  ),
  _TwoDSSLandmark(
    column: 27,
    row: 27,
    name: 'Shrine of Long Light',
    type: _TwoDSSLandmarkType.shrine,
    lore: 'Solstice pilgrimage site; the dawn aligns with a carved stone gate.',
    glyph: Icons.brightness_5,
  ),
  _TwoDSSLandmark(
    column: 2,
    row: 25,
    name: 'Ruin of Andreon',
    type: _TwoDSSLandmarkType.ruin,
    lore: 'Five marble columns remain; swallowed by olive roots.',
    glyph: Icons.broken_image,
  ),
  _TwoDSSLandmark(
    column: 30,
    row: 3,
    name: 'North Observatory',
    type: _TwoDSSLandmarkType.observatory,
    lore: 'Clear-night ratings among the highest on the archipelago.',
    glyph: Icons.nights_stay,
  ),
  _TwoDSSLandmark(
    column: 17,
    row: 17,
    name: 'Twin Bridges',
    type: _TwoDSSLandmarkType.bridge,
    lore: 'Parallel stone causeways across a reedy estuary; always windy.',
    glyph: Icons.swap_horiz,
  ),
];

// Preset tour targets referenced from the "Tour" scenario. Each entry is
// a human label + a `ChildVicinity` the state will `animateTo` on both
// axes in sequence, at the user-selected curve.
class _TwoDSSTourStop {
  const _TwoDSSTourStop({
    required this.label,
    required this.column,
    required this.row,
    required this.description,
  });

  final String label;
  final int column;
  final int row;
  final String description;
}

const List<_TwoDSSTourStop> _twoDSSTourStops = <_TwoDSSTourStop>[
  _TwoDSSTourStop(
    label: 'Port Vesper',
    column: 3,
    row: 4,
    description: 'Tour begins at the evening tide harbour.',
  ),
  _TwoDSSTourStop(
    label: 'Cinnabar Capital',
    column: 18,
    row: 5,
    description: 'Guild business; register the expedition.',
  ),
  _TwoDSSTourStop(
    label: 'Olive Grove',
    column: 15,
    row: 9,
    description: 'Pause for olives and salted bread.',
  ),
  _TwoDSSTourStop(
    label: 'Astrolabe Observatory',
    column: 32,
    row: 8,
    description: 'Observe the tides; compare to the ledgers.',
  ),
  _TwoDSSTourStop(
    label: 'Shrine of Quiet Mornings',
    column: 28,
    row: 14,
    description: 'A quiet hour before continuing south.',
  ),
  _TwoDSSTourStop(
    label: 'South Capital',
    column: 20,
    row: 26,
    description: 'Tour concludes at the seasonal seat.',
  ),
];

// ---------------------------------------------------------------------------
// Curve presets — exposed to the user in the animate-vs-jump scenario and
// the tour scenario. Kept as a named list so each dropdown entry has a
// human-legible label and a predictable Curve implementation.
// ---------------------------------------------------------------------------
class _TwoDSSCurveOption {
  const _TwoDSSCurveOption({
    required this.label,
    required this.curve,
    required this.blurb,
  });

  final String label;
  final Curve curve;
  final String blurb;
}

const List<_TwoDSSCurveOption> _twoDSSCurveOptions = <_TwoDSSCurveOption>[
  _TwoDSSCurveOption(
    label: 'easeInOut',
    curve: Curves.easeInOut,
    blurb: 'Gentle start and end; feels organic for map navigation.',
  ),
  _TwoDSSCurveOption(
    label: 'linear',
    curve: Curves.linear,
    blurb: 'Constant speed; suits diagnostic and step-through motions.',
  ),
  _TwoDSSCurveOption(
    label: 'easeOut',
    curve: Curves.easeOut,
    blurb: 'Fast start, soft landing; comfortable for arrival-style moves.',
  ),
  _TwoDSSCurveOption(
    label: 'easeIn',
    curve: Curves.easeIn,
    blurb: 'Slow start, hurried end; useful for dramatic reveals.',
  ),
  _TwoDSSCurveOption(
    label: 'easeInOutCubic',
    curve: Curves.easeInOutCubic,
    blurb: 'Slightly snappier than easeInOut; good default for tours.',
  ),
  _TwoDSSCurveOption(
    label: 'decelerate',
    curve: Curves.decelerate,
    blurb: 'Friction-like fall-off; feels like letting go of a dial.',
  ),
  _TwoDSSCurveOption(
    label: 'easeInOutQuart',
    curve: Curves.easeInOutQuart,
    blurb: 'Deep easing on both ends; ideal for dramatic tour stops.',
  ),
];

// ---------------------------------------------------------------------------
// Root widget — `_TwoDSSHome` hosts all scenarios in a single scrolling
// column. Each scenario is a private widget built from the home state so
// controls and the `GlobalKey<TwoDimensionalScrollableState>` are shared.
// ---------------------------------------------------------------------------
class _TwoDSSHome extends StatefulWidget {
  const _TwoDSSHome();

  @override
  State<_TwoDSSHome> createState() => _TwoDSSHomeState();
}

class _TwoDSSHomeState extends State<_TwoDSSHome>
    with TickerProviderStateMixin {
  // The anchor key: attached to the `TwoDimensionalScrollable` in scenario 2
  // and read by every imperative helper to reach
  // `verticalScrollable` / `horizontalScrollable`.
  final GlobalKey<TwoDimensionalScrollableState> _mapKey =
      GlobalKey<TwoDimensionalScrollableState>();

  // Step size for the compass rose — in cells. Slider-controlled.
  double _stepCells = 2.0;

  // Whether the compass rose should animate (animateTo) or jump (jumpTo).
  bool _animateSteps = true;

  // Curve for animate mode.
  int _curveIndex = 0;

  // Duration (ms) for `animateTo` calls.
  double _animateDurationMs = 480.0;

  // Live pixel readouts, pulled from the inner states in a ticker. Kept
  // in state so the diagnostics panel and mini-map can both render them
  // without each reaching into the state independently every frame.
  double _liveHorizontalPixels = 0.0;
  double _liveVerticalPixels = 0.0;
  double _liveHorizontalMax = 1.0;
  double _liveVerticalMax = 1.0;
  bool _liveHorizontalReady = false;
  bool _liveVerticalReady = false;

  // The last landmark visited — the compass rose "home" button snaps here,
  // and the tour scenario updates this as it proceeds.
  _TwoDSSLandmark? _lastVisitedLandmark;

  // Tour state — when running, the button row is disabled and the progress
  // indicator advances through stops.
  bool _tourRunning = false;
  int _tourIndex = 0;

  // Ticker that polls the two inner `ScrollPosition`s once per frame so
  // the mini-map and the diagnostics panel stay in sync without any
  // notification plumbing. Flutter frames are ~16ms so this is fine.
  Ticker? _diagnosticsTicker;

  // Controllers for the two inner scrollables. Providing explicit
  // controllers would fight the fallback controllers the State normally
  // constructs — so we leave them null and reach in via the GlobalKey
  // instead, which is the main point of this demo.

  @override
  void initState() {
    super.initState();
    _diagnosticsTicker = createTicker(_pollPositions)..start();
  }

  @override
  void dispose() {
    _diagnosticsTicker?.dispose();
    super.dispose();
  }

  void _pollPositions(Duration _) {
    final TwoDimensionalScrollableState? state = _mapKey.currentState;
    if (state == null) {
      return;
    }
    // Reading these throws assert in debug until both inner scrollables
    // have mounted; guard with a `try` so the first few frames don't
    // trigger failures during the initial build pass.
    double? hPixels;
    double? vPixels;
    double? hMax;
    double? vMax;
    bool hReady = false;
    bool vReady = false;
    try {
      final ScrollableState h = state.horizontalScrollable;
      hPixels = h.position.pixels;
      hMax = h.position.hasContentDimensions
          ? h.position.maxScrollExtent
          : null;
      hReady = h.position.hasContentDimensions;
    } catch (_) {
      hReady = false;
    }
    try {
      final ScrollableState v = state.verticalScrollable;
      vPixels = v.position.pixels;
      vMax = v.position.hasContentDimensions
          ? v.position.maxScrollExtent
          : null;
      vReady = v.position.hasContentDimensions;
    } catch (_) {
      vReady = false;
    }
    // Only trigger setState if values changed meaningfully (0.5px).
    final bool horizontalChanged = hPixels != null &&
        ((hPixels - _liveHorizontalPixels).abs() > 0.5 ||
            hReady != _liveHorizontalReady ||
            (hMax != null && (hMax - _liveHorizontalMax).abs() > 0.5));
    final bool verticalChanged = vPixels != null &&
        ((vPixels - _liveVerticalPixels).abs() > 0.5 ||
            vReady != _liveVerticalReady ||
            (vMax != null && (vMax - _liveVerticalMax).abs() > 0.5));
    if (!horizontalChanged && !verticalChanged) {
      return;
    }
    setState(() {
      if (hPixels != null) {
        _liveHorizontalPixels = hPixels;
      }
      if (vPixels != null) {
        _liveVerticalPixels = vPixels;
      }
      if (hMax != null) {
        _liveHorizontalMax = hMax <= 0 ? 1.0 : hMax;
      }
      if (vMax != null) {
        _liveVerticalMax = vMax <= 0 ? 1.0 : vMax;
      }
      _liveHorizontalReady = hReady;
      _liveVerticalReady = vReady;
    });
  }

  // -------------------------------------------------------------------------
  // Imperative helpers — these are the heart of the demo: each one reaches
  // through the `GlobalKey` into `TwoDimensionalScrollableState` and drives
  // one or both inner scrollables.
  // -------------------------------------------------------------------------

  Future<void> _step(double dxCells, double dyCells) async {
    final TwoDimensionalScrollableState? state = _mapKey.currentState;
    if (state == null) {
      return;
    }
    final ScrollableState h = state.horizontalScrollable;
    final ScrollableState v = state.verticalScrollable;
    final double targetX = _clampTo(
      h.position.pixels + dxCells * _twoDSSCellSize,
      h.position,
    );
    final double targetY = _clampTo(
      v.position.pixels + dyCells * _twoDSSCellSize,
      v.position,
    );
    if (_animateSteps) {
      final Duration d = Duration(milliseconds: _animateDurationMs.round());
      final Curve c = _twoDSSCurveOptions[_curveIndex].curve;
      await Future.wait<void>(<Future<void>>[
        h.position.animateTo(targetX, duration: d, curve: c),
        v.position.animateTo(targetY, duration: d, curve: c),
      ]);
    } else {
      h.position.jumpTo(targetX);
      v.position.jumpTo(targetY);
    }
  }

  Future<void> _goHome() async {
    final TwoDimensionalScrollableState? state = _mapKey.currentState;
    if (state == null) {
      return;
    }
    final ScrollableState h = state.horizontalScrollable;
    final ScrollableState v = state.verticalScrollable;
    if (_animateSteps) {
      final Duration d = Duration(milliseconds: _animateDurationMs.round());
      final Curve c = _twoDSSCurveOptions[_curveIndex].curve;
      await Future.wait<void>(<Future<void>>[
        h.position.animateTo(0.0, duration: d, curve: c),
        v.position.animateTo(0.0, duration: d, curve: c),
      ]);
    } else {
      h.position.jumpTo(0.0);
      v.position.jumpTo(0.0);
    }
    setState(() {
      _lastVisitedLandmark = null;
    });
  }

  Future<void> _goToLandmark(_TwoDSSLandmark landmark) async {
    final TwoDimensionalScrollableState? state = _mapKey.currentState;
    if (state == null) {
      return;
    }
    final ScrollableState h = state.horizontalScrollable;
    final ScrollableState v = state.verticalScrollable;
    final double targetX = _clampTo(
      landmark.column * _twoDSSCellSize - _twoDSSCellSize * 2,
      h.position,
    );
    final double targetY = _clampTo(
      landmark.row * _twoDSSCellSize - _twoDSSCellSize * 2,
      v.position,
    );
    if (_animateSteps) {
      final Duration d = Duration(milliseconds: _animateDurationMs.round());
      final Curve c = _twoDSSCurveOptions[_curveIndex].curve;
      await Future.wait<void>(<Future<void>>[
        h.position.animateTo(targetX, duration: d, curve: c),
        v.position.animateTo(targetY, duration: d, curve: c),
      ]);
    } else {
      h.position.jumpTo(targetX);
      v.position.jumpTo(targetY);
    }
    setState(() {
      _lastVisitedLandmark = landmark;
    });
  }

  Future<void> _runTour() async {
    if (_tourRunning) {
      return;
    }
    setState(() {
      _tourRunning = true;
      _tourIndex = 0;
    });
    for (int i = 0; i < _twoDSSTourStops.length; i++) {
      if (!mounted) {
        return;
      }
      setState(() {
        _tourIndex = i;
      });
      final _TwoDSSTourStop stop = _twoDSSTourStops[i];
      await _goToLandmark(_landmarkByLabel(stop.label) ??
          _TwoDSSLandmark(
            column: stop.column,
            row: stop.row,
            name: stop.label,
            type: _TwoDSSLandmarkType.capital,
            lore: stop.description,
            glyph: Icons.flag,
          ));
      if (!mounted) {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 520));
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _tourRunning = false;
    });
  }

  _TwoDSSLandmark? _landmarkByLabel(String label) {
    for (final _TwoDSSLandmark lm in _twoDSSLandmarks) {
      if (lm.name == label) {
        return lm;
      }
    }
    return null;
  }

  double _clampTo(double value, ScrollPosition p) {
    if (!p.hasContentDimensions) {
      return value;
    }
    return clampDouble(value, p.minScrollExtent, p.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _twoDSSParchment,
      appBar: AppBar(
        backgroundColor: _twoDSSInkNavy,
        foregroundColor: _twoDSSParchment,
        elevation: 0,
        title: const Text(
          'TwoDimensionalScrollableState — Cartographer\'s Workbench',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[_twoDSSParchment, _twoDSSParchmentDeep],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _TwoDSSPreambleCard(),
              const SizedBox(height: 24),
              _TwoDSSAnatomyStrip(),
              const SizedBox(height: 28),
              _TwoDSSMapScenario(
                mapKey: _mapKey,
                onStep: _step,
                onHome: _goHome,
                stepCells: _stepCells,
                onStepChanged: (double v) {
                  setState(() {
                    _stepCells = v;
                  });
                },
                animateSteps: _animateSteps,
                onAnimateChanged: (bool v) {
                  setState(() {
                    _animateSteps = v;
                  });
                },
                curveIndex: _curveIndex,
                onCurveChanged: (int v) {
                  setState(() {
                    _curveIndex = v;
                  });
                },
                durationMs: _animateDurationMs,
                onDurationChanged: (double v) {
                  setState(() {
                    _animateDurationMs = v;
                  });
                },
              ),
              const SizedBox(height: 28),
              _TwoDSSAnimateVsJumpScenario(
                onStep: _step,
                animateSteps: _animateSteps,
                onAnimateChanged: (bool v) {
                  setState(() {
                    _animateSteps = v;
                  });
                },
                curveIndex: _curveIndex,
                onCurveChanged: (int v) {
                  setState(() {
                    _curveIndex = v;
                  });
                },
              ),
              const SizedBox(height: 28),
              _TwoDSSTourScenario(
                onRunTour: _runTour,
                tourRunning: _tourRunning,
                tourIndex: _tourIndex,
                onJumpToStop: (int i) async {
                  final _TwoDSSTourStop stop = _twoDSSTourStops[i];
                  final _TwoDSSLandmark? lm = _landmarkByLabel(stop.label);
                  if (lm != null) {
                    await _goToLandmark(lm);
                  }
                },
              ),
              const SizedBox(height: 28),
              _TwoDSSMiniMap(
                horizontalPixels: _liveHorizontalPixels,
                verticalPixels: _liveVerticalPixels,
                horizontalMax: _liveHorizontalMax,
                verticalMax: _liveVerticalMax,
                ready: _liveHorizontalReady && _liveVerticalReady,
                lastVisited: _lastVisitedLandmark,
              ),
              const SizedBox(height: 28),
              _TwoDSSDiagnosticsPanel(
                horizontalPixels: _liveHorizontalPixels,
                verticalPixels: _liveVerticalPixels,
                horizontalMax: _liveHorizontalMax,
                verticalMax: _liveVerticalMax,
                horizontalReady: _liveHorizontalReady,
                verticalReady: _liveVerticalReady,
                stepCells: _stepCells,
                animateSteps: _animateSteps,
                curveLabel: _twoDSSCurveOptions[_curveIndex].label,
                durationMs: _animateDurationMs,
                lastVisited: _lastVisitedLandmark,
              ),
              const SizedBox(height: 28),
              _TwoDSSEpilogueCard(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1: Preamble card — explains what
// `TwoDimensionalScrollableState` is and why you might want a handle to it.
// ---------------------------------------------------------------------------
class _TwoDSSPreambleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> intro = <Map<String, String>>[
      <String, String>{
        'title': 'State of a 2D Scrollable',
        'body':
            'TwoDimensionalScrollableState is the State object behind a '
                'TwoDimensionalScrollable widget. Where a regular Scrollable '
                'manages one ScrollPosition, this one manages two — one per '
                'axis — and exposes them through `verticalScrollable` and '
                '`horizontalScrollable` (each a full ScrollableState).',
      },
      <String, String>{
        'title': 'Why hold a handle?',
        'body':
            'Attach a GlobalKey<TwoDimensionalScrollableState> to the scrollable '
                'so imperative code (e.g. a compass-rose control pad) can reach '
                '`key.currentState?.horizontalScrollable.position` and call '
                '`animateTo` or `jumpTo` without rebuilding the viewport tree.',
      },
      <String, String>{
        'title': 'Two positions, one viewport',
        'body':
            'Even though the two axes are independent scrollables internally, '
                'they share a single TwoDimensionalViewport. Gesture routing, '
                'drag decomposition, and keyboard arrow handling are all the '
                'State\'s responsibility.',
      },
      <String, String>{
        'title': 'Lifecycle note',
        'body':
            'Reading verticalScrollable / horizontalScrollable too early — '
                'before the inner keys have mounted — triggers an assertion. '
                'Guard with a null check on `currentState`, or wait until the '
                'first frame after `TwoDimensionalScrollable` is in the tree.',
      },
    ];
    return _TwoDSSOutlinedCard(
      accent: _twoDSSInkNavy,
      titleIcon: Icons.explore,
      title: 'TwoDimensionalScrollableState — the map reader\'s grip',
      subtitle: 'Hold the State. Drive both axes. Keep the viewport.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < intro.length; i++)
            Padding(
              padding: EdgeInsets.only(top: i == 0 ? 0 : 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _twoDSSBrass.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _twoDSSBrass.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _twoDSSInkNavy,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          intro[i]['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _twoDSSInkNavy,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          intro[i]['body']!,
                          style: const TextStyle(
                            color: _twoDSSInkFaint,
                            fontSize: 13,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Anatomy strip — six tiny icon cards summarising the State API surface.
// Acts as a quick visual legend below the preamble.
// ---------------------------------------------------------------------------
class _TwoDSSAnatomyStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_TwoDSSAnatomyEntry> entries = const <_TwoDSSAnatomyEntry>[
      _TwoDSSAnatomyEntry(
        label: 'verticalScrollable',
        icon: Icons.swap_vert,
        description:
            'Returns the inner ScrollableState for the vertical axis. '
            'Use its `.position` to read/write pixels.',
        accent: _twoDSSInkNavyBright,
      ),
      _TwoDSSAnatomyEntry(
        label: 'horizontalScrollable',
        icon: Icons.swap_horiz,
        description:
            'Returns the inner ScrollableState for the horizontal axis. '
            'Its `.position` mirrors the vertical one\'s API.',
        accent: _twoDSSSeal,
      ),
      _TwoDSSAnatomyEntry(
        label: '.position.animateTo',
        icon: Icons.animation,
        description:
            'Animate the axis to a target pixel offset with an easing '
            'curve and a Duration.',
        accent: _twoDSSBrassDeep,
      ),
      _TwoDSSAnatomyEntry(
        label: '.position.jumpTo',
        icon: Icons.bolt,
        description:
            'Instantly seek the axis to an offset. Useful for '
            'test harnesses and rapid step buttons.',
        accent: _twoDSSMossGreen,
      ),
      _TwoDSSAnatomyEntry(
        label: 'maxScrollExtent',
        icon: Icons.straighten,
        description:
            'Axis-specific upper bound. Driven by the viewport\'s '
            '`applyContentDimensions` call on each layout pass.',
        accent: _twoDSSBrass,
      ),
      _TwoDSSAnatomyEntry(
        label: 'hasContentDimensions',
        icon: Icons.check_box,
        description:
            'True once both `applyViewportDimension` and '
            '`applyContentDimensions` have been called at least once.',
        accent: _twoDSSMossBright,
      ),
    ];
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        for (final _TwoDSSAnatomyEntry e in entries)
          SizedBox(
            width: 230,
            child: _TwoDSSOutlinedCard(
              accent: e.accent,
              titleIcon: e.icon,
              title: e.label,
              subtitle: '',
              child: Text(
                e.description,
                style: const TextStyle(
                  color: _twoDSSInkFaint,
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _TwoDSSAnatomyEntry {
  const _TwoDSSAnatomyEntry({
    required this.label,
    required this.icon,
    required this.description,
    required this.accent,
  });
  final String label;
  final IconData icon;
  final String description;
  final Color accent;
}

// ---------------------------------------------------------------------------
// Shared card chrome — every scenario is framed in a parchment card with
// a brass edge and an ink title. Keeps the demo visually coherent.
// ---------------------------------------------------------------------------
class _TwoDSSOutlinedCard extends StatelessWidget {
  const _TwoDSSOutlinedCard({
    required this.accent,
    required this.titleIcon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final Color accent;
  final IconData titleIcon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDSSParchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _twoDSSBrass.withValues(alpha: 0.55),
          width: 1.25,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _twoDSSParchmentShadow.withValues(alpha: 0.45),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.55),
                  ),
                ),
                child: Icon(titleIcon, size: 20, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: _twoDSSInkNavy,
                        fontSize: 16,
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: _twoDSSInkFaint,
                          fontSize: 12.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2: Map scenario — the fictional archipelago rendered as a
// 40x30 cell grid. A hand-authored `TwoDimensionalScrollable` is the
// core of this scenario: its GlobalKey is what every other scenario
// reaches for. Left of the map is a compass rose control pad authored
// with a CustomPainter. Below the pad are sliders for step size and
// duration, a switch for animate-vs-jump, and a dropdown for curves.
// ---------------------------------------------------------------------------
class _TwoDSSMapScenario extends StatelessWidget {
  const _TwoDSSMapScenario({
    required this.mapKey,
    required this.onStep,
    required this.onHome,
    required this.stepCells,
    required this.onStepChanged,
    required this.animateSteps,
    required this.onAnimateChanged,
    required this.curveIndex,
    required this.onCurveChanged,
    required this.durationMs,
    required this.onDurationChanged,
  });

  final GlobalKey<TwoDimensionalScrollableState> mapKey;
  final Future<void> Function(double dx, double dy) onStep;
  final Future<void> Function() onHome;
  final double stepCells;
  final ValueChanged<double> onStepChanged;
  final bool animateSteps;
  final ValueChanged<bool> onAnimateChanged;
  final int curveIndex;
  final ValueChanged<int> onCurveChanged;
  final double durationMs;
  final ValueChanged<double> onDurationChanged;

  @override
  Widget build(BuildContext context) {
    return _TwoDSSOutlinedCard(
      accent: _twoDSSSeal,
      titleIcon: Icons.map,
      title: 'The archipelago — driven by the state\'s inner scrollables',
      subtitle:
          'The compass rose calls `animateTo` / `jumpTo` on '
              '`verticalScrollable.position` and `horizontalScrollable.position`.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 360,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 260,
                  child: _TwoDSSCompassPad(
                    stepCells: stepCells,
                    onStep: onStep,
                    onHome: onHome,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _twoDSSInkNavy.withValues(alpha: 0.35),
                        width: 1.2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _TwoDSSGridView(
                        mapKey: mapKey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _TwoDSSControlPanel(
            stepCells: stepCells,
            onStepChanged: onStepChanged,
            animateSteps: animateSteps,
            onAnimateChanged: onAnimateChanged,
            curveIndex: curveIndex,
            onCurveChanged: onCurveChanged,
            durationMs: durationMs,
            onDurationChanged: onDurationChanged,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Compass rose pad — CustomPainter draws the brass rose, and eight
// transparent buttons sit above it, each driving `onStep(dx, dy)`. A
// central "Home" button delegates to `onHome`.
// ---------------------------------------------------------------------------
class _TwoDSSCompassPad extends StatelessWidget {
  const _TwoDSSCompassPad({
    required this.stepCells,
    required this.onStep,
    required this.onHome,
  });

  final double stepCells;
  final Future<void> Function(double dx, double dy) onStep;
  final Future<void> Function() onHome;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _twoDSSParchmentDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _twoDSSBrassDeep.withValues(alpha: 0.55),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints c) {
              final double side = math.min(c.maxWidth, c.maxHeight);
              return SizedBox(
                width: side,
                height: side,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _TwoDSSCompassRosePainter(),
                      ),
                    ),
                    _TwoDSSCompassButton(
                      alignment: Alignment.topCenter,
                      icon: Icons.arrow_upward,
                      label: 'N',
                      onTap: () => onStep(0.0, -stepCells),
                    ),
                    _TwoDSSCompassButton(
                      alignment: Alignment.topRight,
                      icon: Icons.north_east,
                      label: 'NE',
                      onTap: () => onStep(stepCells, -stepCells),
                    ),
                    _TwoDSSCompassButton(
                      alignment: Alignment.centerRight,
                      icon: Icons.arrow_forward,
                      label: 'E',
                      onTap: () => onStep(stepCells, 0.0),
                    ),
                    _TwoDSSCompassButton(
                      alignment: Alignment.bottomRight,
                      icon: Icons.south_east,
                      label: 'SE',
                      onTap: () => onStep(stepCells, stepCells),
                    ),
                    _TwoDSSCompassButton(
                      alignment: Alignment.bottomCenter,
                      icon: Icons.arrow_downward,
                      label: 'S',
                      onTap: () => onStep(0.0, stepCells),
                    ),
                    _TwoDSSCompassButton(
                      alignment: Alignment.bottomLeft,
                      icon: Icons.south_west,
                      label: 'SW',
                      onTap: () => onStep(-stepCells, stepCells),
                    ),
                    _TwoDSSCompassButton(
                      alignment: Alignment.centerLeft,
                      icon: Icons.arrow_back,
                      label: 'W',
                      onTap: () => onStep(-stepCells, 0.0),
                    ),
                    _TwoDSSCompassButton(
                      alignment: Alignment.topLeft,
                      icon: Icons.north_west,
                      label: 'NW',
                      onTap: () => onStep(-stepCells, -stepCells),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onHome(),
                        customBorder: const CircleBorder(),
                        child: Container(
                          width: 56,
                          height: 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _twoDSSBrassBright.withValues(alpha: 0.85),
                            border: Border.all(
                              color: _twoDSSInkNavy.withValues(alpha: 0.85),
                              width: 1.6,
                            ),
                          ),
                          child: const Icon(
                            Icons.home,
                            color: _twoDSSInkNavy,
                            size: 26,
                          ),
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
    );
  }
}

class _TwoDSSCompassButton extends StatelessWidget {
  const _TwoDSSCompassButton({
    required this.alignment,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Alignment alignment;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 48,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _twoDSSInkNavy.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _twoDSSBrass.withValues(alpha: 0.7),
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(icon, size: 16, color: _twoDSSParchment),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: const TextStyle(
                      color: _twoDSSParchment,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TwoDSSCompassRosePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset centre = Offset(size.width / 2, size.height / 2);
    final double r = math.min(size.width, size.height) / 2 - 6;

    final Paint bgRing = Paint()
      ..style = PaintingStyle.fill
      ..color = _twoDSSParchment.withValues(alpha: 0.7);
    canvas.drawCircle(centre, r, bgRing);

    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..color = _twoDSSBrassDeep;
    canvas.drawCircle(centre, r, ring);
    canvas.drawCircle(centre, r * 0.82, ring);
    canvas.drawCircle(centre, r * 0.30, ring);

    // Major cardinal rays.
    final Paint ray = Paint()
      ..style = PaintingStyle.fill
      ..color = _twoDSSBrass;
    for (int i = 0; i < 4; i++) {
      final double a = i * math.pi / 2 - math.pi / 2;
      final Path p = Path();
      final Offset tip = centre + Offset(math.cos(a), math.sin(a)) * r;
      final Offset leftBase = centre +
          Offset(math.cos(a + math.pi / 2), math.sin(a + math.pi / 2)) *
              (r * 0.18);
      final Offset rightBase = centre +
          Offset(math.cos(a - math.pi / 2), math.sin(a - math.pi / 2)) *
              (r * 0.18);
      p
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(leftBase.dx, leftBase.dy)
        ..lineTo(rightBase.dx, rightBase.dy)
        ..close();
      canvas.drawPath(p, ray);
      canvas.drawPath(p, ring);
    }
    // Minor intercardinal rays.
    final Paint minorRay = Paint()
      ..style = PaintingStyle.fill
      ..color = _twoDSSBrassBright.withValues(alpha: 0.65);
    for (int i = 0; i < 4; i++) {
      final double a = i * math.pi / 2 - math.pi / 4;
      final Path p = Path();
      final Offset tip = centre + Offset(math.cos(a), math.sin(a)) * (r * 0.82);
      final Offset leftBase = centre +
          Offset(math.cos(a + math.pi / 2), math.sin(a + math.pi / 2)) *
              (r * 0.12);
      final Offset rightBase = centre +
          Offset(math.cos(a - math.pi / 2), math.sin(a - math.pi / 2)) *
              (r * 0.12);
      p
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(leftBase.dx, leftBase.dy)
        ..lineTo(rightBase.dx, rightBase.dy)
        ..close();
      canvas.drawPath(p, minorRay);
      canvas.drawPath(p, ring);
    }
    // Tick marks around outer ring.
    final Paint tick = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _twoDSSBrassDeep.withValues(alpha: 0.85);
    for (int i = 0; i < 36; i++) {
      final double a = i * (math.pi / 18);
      final double inner = (i % 3 == 0) ? r * 0.92 : r * 0.95;
      final Offset p1 = centre + Offset(math.cos(a), math.sin(a)) * inner;
      final Offset p2 = centre + Offset(math.cos(a), math.sin(a)) * r;
      canvas.drawLine(p1, p2, tick);
    }
  }

  @override
  bool shouldRepaint(covariant _TwoDSSCompassRosePainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Controls panel — slider + switch + dropdown. Laid out in two rows so the
// slider labels remain readable.
// ---------------------------------------------------------------------------
class _TwoDSSControlPanel extends StatelessWidget {
  const _TwoDSSControlPanel({
    required this.stepCells,
    required this.onStepChanged,
    required this.animateSteps,
    required this.onAnimateChanged,
    required this.curveIndex,
    required this.onCurveChanged,
    required this.durationMs,
    required this.onDurationChanged,
  });

  final double stepCells;
  final ValueChanged<double> onStepChanged;
  final bool animateSteps;
  final ValueChanged<bool> onAnimateChanged;
  final int curveIndex;
  final ValueChanged<int> onCurveChanged;
  final double durationMs;
  final ValueChanged<double> onDurationChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _TwoDSSLabelledSlider(
                label:
                    'Step size (cells): ${stepCells.toStringAsFixed(1)}  '
                        '= ${(stepCells * _twoDSSCellSize).toStringAsFixed(0)}px',
                value: stepCells,
                min: 0.5,
                max: 8.0,
                divisions: 15,
                onChanged: onStepChanged,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _TwoDSSLabelledSlider(
                label:
                    'Animate duration: ${durationMs.round()} ms',
                value: durationMs,
                min: 100,
                max: 1600,
                divisions: 15,
                onChanged: onDurationChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _twoDSSParchmentDeep,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _twoDSSBrassDeep.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.animation,
                      size: 18,
                      color: _twoDSSInkNavy,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Jump',
                      style: TextStyle(
                        color: _twoDSSInkNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Switch(
                      value: animateSteps,
                      onChanged: onAnimateChanged,
                      activeThumbColor: _twoDSSSeal,
                      activeTrackColor:
                          _twoDSSSeal.withValues(alpha: 0.55),
                      inactiveThumbColor: _twoDSSInkNavyMid,
                      inactiveTrackColor:
                          _twoDSSInkNavyMid.withValues(alpha: 0.35),
                    ),
                    const Text(
                      'Animate',
                      style: TextStyle(
                        color: _twoDSSInkNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _twoDSSParchmentDeep,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _twoDSSBrassDeep.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.tune,
                      size: 18,
                      color: _twoDSSInkNavy,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Curve:',
                      style: TextStyle(
                        color: _twoDSSInkNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: curveIndex,
                          isExpanded: true,
                          dropdownColor: _twoDSSParchment,
                          iconEnabledColor: _twoDSSInkNavy,
                          style: const TextStyle(
                            color: _twoDSSInkNavy,
                            fontWeight: FontWeight.w600,
                          ),
                          items: <DropdownMenuItem<int>>[
                            for (int i = 0;
                                i < _twoDSSCurveOptions.length;
                                i++)
                              DropdownMenuItem<int>(
                                value: i,
                                child: Text(
                                  _twoDSSCurveOptions[i].label,
                                ),
                              ),
                          ],
                          onChanged: (int? v) {
                            if (v != null) {
                              onCurveChanged(v);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _twoDSSInkNavy.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _twoDSSInkNavy.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            _twoDSSCurveOptions[curveIndex].blurb,
            style: const TextStyle(
              color: _twoDSSInkNavy,
              fontStyle: FontStyle.italic,
              fontSize: 12.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _TwoDSSLabelledSlider extends StatelessWidget {
  const _TwoDSSLabelledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: _twoDSSInkNavy,
            fontWeight: FontWeight.w600,
            fontSize: 12.5,
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: _twoDSSSeal,
            inactiveTrackColor: _twoDSSParchmentShadow,
            thumbColor: _twoDSSInkNavy,
            overlayColor: _twoDSSSeal.withValues(alpha: 0.2),
            valueIndicatorColor: _twoDSSInkNavy,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _TwoDSSGridView — the archipelago rendered via a hand-authored
// `TwoDimensionalScrollable`. The widget feeds fallback scroll controllers
// (null details controllers) and a builder-style child delegate keyed by
// `ChildVicinity`. The outer widget's `mapKey` is threaded into the
// `TwoDimensionalScrollable` so imperative code can find the state.
// ---------------------------------------------------------------------------
class _TwoDSSGridView extends StatelessWidget {
  const _TwoDSSGridView({required this.mapKey});

  final GlobalKey<TwoDimensionalScrollableState> mapKey;

  @override
  Widget build(BuildContext context) {
    final Map<int, _TwoDSSLandmark> byIndex =
        <int, _TwoDSSLandmark>{};
    for (final _TwoDSSLandmark lm in _twoDSSLandmarks) {
      byIndex[lm.row * _twoDSSMapColumns + lm.column] = lm;
    }
    final TwoDimensionalChildBuilderDelegate delegate =
        TwoDimensionalChildBuilderDelegate(
      maxXIndex: _twoDSSMapColumns - 1,
      maxYIndex: _twoDSSMapRows - 1,
      builder: (BuildContext _, ChildVicinity v) {
        final _TwoDSSLandmark? landmark =
            byIndex[v.yIndex * _twoDSSMapColumns + v.xIndex];
        return _TwoDSSMapCell(
          column: v.xIndex,
          row: v.yIndex,
          landmark: landmark,
        );
      },
    );
    return TwoDimensionalScrollable(
      key: mapKey,
      horizontalDetails: const ScrollableDetails.horizontal(),
      verticalDetails: const ScrollableDetails.vertical(),
      diagonalDragBehavior: DiagonalDragBehavior.free,
      dragStartBehavior: DragStartBehavior.start,
      viewportBuilder: (
        BuildContext _,
        ViewportOffset verticalOffset,
        ViewportOffset horizontalOffset,
      ) {
        return _TwoDSSViewport(
          verticalOffset: verticalOffset,
          verticalAxisDirection: AxisDirection.down,
          horizontalOffset: horizontalOffset,
          horizontalAxisDirection: AxisDirection.right,
          mainAxis: Axis.vertical,
          delegate: delegate,
          cellSize: _twoDSSCellSize,
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Cell widget — a single parchment tile with a subtle grid outline and,
// if a landmark is defined at (column, row), a coloured token.
// ---------------------------------------------------------------------------
class _TwoDSSMapCell extends StatelessWidget {
  const _TwoDSSMapCell({
    required this.column,
    required this.row,
    required this.landmark,
  });

  final int column;
  final int row;
  final _TwoDSSLandmark? landmark;

  @override
  Widget build(BuildContext context) {
    final bool stripe = ((column + row) % 2) == 0;
    final Color cellColour = stripe
        ? _twoDSSParchment.withValues(alpha: 0.95)
        : _twoDSSParchmentDeep.withValues(alpha: 0.85);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cellColour,
        border: Border(
          right: BorderSide(
            color: _twoDSSInkNavy.withValues(alpha: 0.08),
            width: 0.6,
          ),
          bottom: BorderSide(
            color: _twoDSSInkNavy.withValues(alpha: 0.08),
            width: 0.6,
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 4,
            top: 3,
            child: Text(
              '$column x $row',
              style: TextStyle(
                color: _twoDSSInkFaint.withValues(alpha: 0.45),
                fontSize: 8,
                fontFamily: 'monospace',
              ),
            ),
          ),
          if (landmark != null)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _twoDSSColourFor(landmark!.type)
                            .withValues(alpha: 0.9),
                        border: Border.all(
                          color: _twoDSSInkNavy.withValues(alpha: 0.8),
                          width: 1.4,
                        ),
                      ),
                      child: Icon(
                        landmark!.glyph,
                        color: _twoDSSParchment,
                        size: 18,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      landmark!.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _twoDSSInkNavy,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Viewport scaffolding — a fixed-cell-size 2D viewport that walks the
// visible window of (column, row) indices and lays each child out at its
// pixel offset. Follows the same shape as the builder-delegate demo.
// ---------------------------------------------------------------------------
class _TwoDSSViewport extends TwoDimensionalViewport {
  const _TwoDSSViewport({
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required TwoDimensionalChildBuilderDelegate delegate,
    required super.mainAxis,
    required this.cellSize,
  }) : super(delegate: delegate);

  final double cellSize;

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return _TwoDSSRenderViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      childManager: context as TwoDimensionalChildManager,
      cellSize: cellSize,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _TwoDSSRenderViewport renderObject,
  ) {
    renderObject
      ..horizontalOffset = horizontalOffset
      ..horizontalAxisDirection = horizontalAxisDirection
      ..verticalOffset = verticalOffset
      ..verticalAxisDirection = verticalAxisDirection
      ..mainAxis = mainAxis
      ..delegate = delegate
      ..cellSize = cellSize;
  }
}

class _TwoDSSRenderViewport extends RenderTwoDimensionalViewport {
  _TwoDSSRenderViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required TwoDimensionalChildBuilderDelegate delegate,
    required super.mainAxis,
    required super.childManager,
    required double cellSize,
  })  : _cellSize = cellSize,
        super(delegate: delegate);

  double _cellSize;
  double get cellSize => _cellSize;
  set cellSize(double value) {
    if (value == _cellSize) {
      return;
    }
    _cellSize = value;
    markNeedsLayout();
  }

  @override
  void layoutChildSequence() {
    final double horizontalPixels = horizontalOffset.pixels;
    final double verticalPixels = verticalOffset.pixels;
    final double viewportWidth = viewportDimension.width;
    final double viewportHeight = viewportDimension.height;
    final TwoDimensionalChildBuilderDelegate builderDelegate =
        delegate as TwoDimensionalChildBuilderDelegate;

    final int maxColumnIndex =
        builderDelegate.maxXIndex ?? _twoDSSMapColumns - 1;
    final int maxRowIndex =
        builderDelegate.maxYIndex ?? _twoDSSMapRows - 1;

    final int leadingColumn = math.max(
      (horizontalPixels / _cellSize).floor(),
      0,
    );
    final int leadingRow = math.max(
      (verticalPixels / _cellSize).floor(),
      0,
    );
    final int trailingColumn = math.min(
      ((horizontalPixels + viewportWidth) / _cellSize).ceil(),
      maxColumnIndex,
    );
    final int trailingRow = math.min(
      ((verticalPixels + viewportHeight) / _cellSize).ceil(),
      maxRowIndex,
    );

    double xLayoutOffset =
        (leadingColumn * _cellSize) - horizontalOffset.pixels;
    for (int column = leadingColumn; column <= trailingColumn; column++) {
      double yLayoutOffset =
          (leadingRow * _cellSize) - verticalOffset.pixels;
      for (int row = leadingRow; row <= trailingRow; row++) {
        final ChildVicinity vicinity =
            ChildVicinity(xIndex: column, yIndex: row);
        final RenderBox? child = buildOrObtainChildFor(vicinity);
        if (child != null) {
          child.layout(
            constraints.tighten(width: _cellSize, height: _cellSize),
          );
          parentDataOf(child).layoutOffset =
              Offset(xLayoutOffset, yLayoutOffset);
        }
        yLayoutOffset += _cellSize;
      }
      xLayoutOffset += _cellSize;
    }

    final double verticalExtent = _cellSize * (maxRowIndex + 1);
    verticalOffset.applyContentDimensions(
      0.0,
      clampDouble(verticalExtent - viewportHeight, 0.0, double.infinity),
    );
    final double horizontalExtent = _cellSize * (maxColumnIndex + 1);
    horizontalOffset.applyContentDimensions(
      0.0,
      clampDouble(horizontalExtent - viewportWidth, 0.0, double.infinity),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3: Animate vs Jump scenario — two large buttons and a
// side-by-side explanation of how the two modes differ. The user toggles
// between `animateTo` and `jumpTo`, selects a curve, and fires the
// control — the scenario itself does not host a map; it delegates to the
// shared map above via the `onStep` callback.
// ---------------------------------------------------------------------------
class _TwoDSSAnimateVsJumpScenario extends StatelessWidget {
  const _TwoDSSAnimateVsJumpScenario({
    required this.onStep,
    required this.animateSteps,
    required this.onAnimateChanged,
    required this.curveIndex,
    required this.onCurveChanged,
  });

  final Future<void> Function(double dx, double dy) onStep;
  final bool animateSteps;
  final ValueChanged<bool> onAnimateChanged;
  final int curveIndex;
  final ValueChanged<int> onCurveChanged;

  @override
  Widget build(BuildContext context) {
    return _TwoDSSOutlinedCard(
      accent: _twoDSSBrassDeep,
      titleIcon: Icons.compare_arrows,
      title: 'animateTo vs jumpTo — which position API fits the moment?',
      subtitle:
          'Both live on `ScrollableState.position`. The state wraps two, '
              'one per axis, so your code calls whichever matches the '
              'motion you want.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _TwoDSSModeCard(
                  selected: animateSteps,
                  accent: _twoDSSSeal,
                  icon: Icons.animation,
                  title: 'animateTo(target, duration, curve)',
                  points: const <String>[
                    'Returns a Future<void> that completes when the motion '
                        'finishes or is interrupted.',
                    'Plays well with Future.wait to coordinate both axes.',
                    'Ideal for map navigation, tour playback, and reveals.',
                    'Respects the supplied Curve — easeInOut is the usual '
                        'default for UX work.',
                  ],
                  onTap: () => onAnimateChanged(true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TwoDSSModeCard(
                  selected: !animateSteps,
                  accent: _twoDSSInkNavyBright,
                  icon: Icons.bolt,
                  title: 'jumpTo(target)',
                  points: const <String>[
                    'Seeks instantly — no duration, no curve.',
                    'Useful for step-through buttons, test fixtures, or '
                        'rapid keyboard navigation.',
                    'Does not produce a Future; motion is complete on '
                        'return.',
                    'Can feel jarring in a user-facing map but is crisp '
                        'in diagnostic or editor contexts.',
                  ],
                  onTap: () => onAnimateChanged(false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _twoDSSParchmentDeep,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _twoDSSBrassDeep.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.tune,
                        size: 18,
                        color: _twoDSSInkNavy,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Curve',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: _twoDSSInkNavy,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: curveIndex,
                            isExpanded: true,
                            dropdownColor: _twoDSSParchment,
                            iconEnabledColor: _twoDSSInkNavy,
                            style: const TextStyle(
                              color: _twoDSSInkNavy,
                              fontWeight: FontWeight.w600,
                            ),
                            items: <DropdownMenuItem<int>>[
                              for (int i = 0;
                                  i < _twoDSSCurveOptions.length;
                                  i++)
                                DropdownMenuItem<int>(
                                  value: i,
                                  child: Text(
                                    _twoDSSCurveOptions[i].label,
                                  ),
                                ),
                            ],
                            onChanged: (int? v) {
                              if (v != null) {
                                onCurveChanged(v);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TwoDSSQuickFire(
                  label: 'Nudge East (+1 cell)',
                  onPressed: () => onStep(1.0, 0.0),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TwoDSSQuickFire(
                  label: 'Nudge South (+1 cell)',
                  onPressed: () => onStep(0.0, 1.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TwoDSSModeCard extends StatelessWidget {
  const _TwoDSSModeCard({
    required this.selected,
    required this.accent,
    required this.icon,
    required this.title,
    required this.points,
    required this.onTap,
  });

  final bool selected;
  final Color accent;
  final IconData icon;
  final String title;
  final List<String> points;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.12)
                : _twoDSSParchmentDeep.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? accent
                  : _twoDSSInkNavy.withValues(alpha: 0.25),
              width: selected ? 2.0 : 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: accent, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  if (selected)
                    const Icon(
                      Icons.check_circle,
                      color: _twoDSSMossGreen,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              for (final String p in points)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '•  ',
                        style: TextStyle(
                          color: _twoDSSInkNavy,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          p,
                          style: const TextStyle(
                            color: _twoDSSInkFaint,
                            fontSize: 12.5,
                            height: 1.4,
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
    );
  }
}

class _TwoDSSQuickFire extends StatelessWidget {
  const _TwoDSSQuickFire({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _twoDSSInkNavy,
        foregroundColor: _twoDSSParchment,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4: Tour scenario — a vertical timeline of preset stops. The
// "Run tour" button starts a sequenced `animateTo` chain through each
// stop; the individual stop buttons jump straight to that stop. While
// the tour is running, the stop buttons are disabled.
// ---------------------------------------------------------------------------
class _TwoDSSTourScenario extends StatelessWidget {
  const _TwoDSSTourScenario({
    required this.onRunTour,
    required this.tourRunning,
    required this.tourIndex,
    required this.onJumpToStop,
  });

  final Future<void> Function() onRunTour;
  final bool tourRunning;
  final int tourIndex;
  final Future<void> Function(int index) onJumpToStop;

  @override
  Widget build(BuildContext context) {
    return _TwoDSSOutlinedCard(
      accent: _twoDSSMossGreen,
      titleIcon: Icons.route,
      title: 'Tour mode — sequenced animateTo calls',
      subtitle:
          'A small Future.forEach over preset (column, row) coordinates, '
              'each waiting for both inner positions to settle before '
              'moving on.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: tourRunning ? null : onRunTour,
                icon: const Icon(Icons.play_circle_fill),
                label: Text(
                  tourRunning ? 'Tour running…' : 'Run tour',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _twoDSSMossGreen,
                  foregroundColor: _twoDSSParchment,
                  disabledBackgroundColor:
                      _twoDSSMossGreen.withValues(alpha: 0.4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  tourRunning
                      ? 'Stop ${tourIndex + 1} of '
                          '${_twoDSSTourStops.length}: '
                          '${_twoDSSTourStops[tourIndex].label}'
                      : 'Press "Run tour" to animate the viewport through '
                          'each of the ${_twoDSSTourStops.length} preset '
                          'coordinates in sequence.',
                  style: const TextStyle(
                    color: _twoDSSInkNavy,
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: tourRunning
                ? (tourIndex + 1) / _twoDSSTourStops.length
                : 0.0,
            backgroundColor: _twoDSSParchmentShadow,
            valueColor: const AlwaysStoppedAnimation<Color>(_twoDSSMossGreen),
          ),
          const SizedBox(height: 18),
          for (int i = 0; i < _twoDSSTourStops.length; i++)
            _TwoDSSTourRow(
              index: i,
              stop: _twoDSSTourStops[i],
              active: tourRunning && tourIndex == i,
              disabled: tourRunning,
              onJump: () => onJumpToStop(i),
            ),
        ],
      ),
    );
  }
}

class _TwoDSSTourRow extends StatelessWidget {
  const _TwoDSSTourRow({
    required this.index,
    required this.stop,
    required this.active,
    required this.disabled,
    required this.onJump,
  });

  final int index;
  final _TwoDSSTourStop stop;
  final bool active;
  final bool disabled;
  final VoidCallback onJump;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: active
            ? _twoDSSMossGreen.withValues(alpha: 0.14)
            : _twoDSSParchmentDeep.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active
              ? _twoDSSMossGreen
              : _twoDSSInkNavy.withValues(alpha: 0.15),
          width: active ? 1.8 : 0.8,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? _twoDSSMossGreen
                  : _twoDSSInkNavyMid.withValues(alpha: 0.3),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: active ? _twoDSSParchment : _twoDSSInkNavy,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${stop.label}  (col ${stop.column}, row ${stop.row})',
                  style: const TextStyle(
                    color: _twoDSSInkNavy,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  stop.description,
                  style: const TextStyle(
                    color: _twoDSSInkFaint,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: disabled ? null : onJump,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            label: const Text('Jump'),
            style: TextButton.styleFrom(
              foregroundColor: _twoDSSSeal,
              disabledForegroundColor:
                  _twoDSSSeal.withValues(alpha: 0.35),
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5: Mini-map — a CustomPaint that draws the full map outline
// (40x30 cell grid), every landmark as a small dot, and the current
// viewport rectangle as a filled brass overlay. Driven by the live
// pixel values from the diagnostics ticker.
// ---------------------------------------------------------------------------
class _TwoDSSMiniMap extends StatelessWidget {
  const _TwoDSSMiniMap({
    required this.horizontalPixels,
    required this.verticalPixels,
    required this.horizontalMax,
    required this.verticalMax,
    required this.ready,
    required this.lastVisited,
  });

  final double horizontalPixels;
  final double verticalPixels;
  final double horizontalMax;
  final double verticalMax;
  final bool ready;
  final _TwoDSSLandmark? lastVisited;

  @override
  Widget build(BuildContext context) {
    return _TwoDSSOutlinedCard(
      accent: _twoDSSBrassDeep,
      titleIcon: Icons.map_outlined,
      title: 'Mini-map — where the viewport is looking right now',
      subtitle:
          'Live from `verticalScrollable.position.pixels` and '
              '`horizontalScrollable.position.pixels`, normalised to the '
              'full map bounds.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: _twoDSSMapColumns / _twoDSSMapRows,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _twoDSSParchmentDeep,
                border: Border.all(
                  color: _twoDSSInkNavy.withValues(alpha: 0.4),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CustomPaint(
                  painter: _TwoDSSMiniMapPainter(
                    horizontalPixels: horizontalPixels,
                    verticalPixels: verticalPixels,
                    horizontalMax: horizontalMax,
                    verticalMax: verticalMax,
                    ready: ready,
                    highlight: lastVisited,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _TwoDSSMiniLegend(
                color: _twoDSSBrass,
                label: 'Current viewport',
              ),
              const SizedBox(width: 14),
              _TwoDSSMiniLegend(
                color: _twoDSSSeal,
                label: 'Capitals / seats',
              ),
              const SizedBox(width: 14),
              _TwoDSSMiniLegend(
                color: _twoDSSMossGreen,
                label: 'Groves / shrines',
              ),
              const SizedBox(width: 14),
              _TwoDSSMiniLegend(
                color: _twoDSSInkNavyBright,
                label: 'Harbours / bridges',
              ),
            ],
          ),
          if (lastVisited != null) ...<Widget>[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _twoDSSInkNavy.withValues(alpha: 0.05),
                border: Border.all(
                  color: _twoDSSInkNavy.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    lastVisited!.glyph,
                    color: _twoDSSColourFor(lastVisited!.type),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${lastVisited!.name} — '
                              '${_twoDSSLabelFor(lastVisited!.type)}',
                          style: const TextStyle(
                            color: _twoDSSInkNavy,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          lastVisited!.lore,
                          style: const TextStyle(
                            color: _twoDSSInkFaint,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TwoDSSMiniLegend extends StatelessWidget {
  const _TwoDSSMiniLegend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(
              color: _twoDSSInkNavy.withValues(alpha: 0.5),
              width: 0.8,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _twoDSSInkNavy,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _TwoDSSMiniMapPainter extends CustomPainter {
  _TwoDSSMiniMapPainter({
    required this.horizontalPixels,
    required this.verticalPixels,
    required this.horizontalMax,
    required this.verticalMax,
    required this.ready,
    required this.highlight,
  });

  final double horizontalPixels;
  final double verticalPixels;
  final double horizontalMax;
  final double verticalMax;
  final bool ready;
  final _TwoDSSLandmark? highlight;

  @override
  void paint(Canvas canvas, Size size) {
    // Grid lines.
    final Paint grid = Paint()
      ..color = _twoDSSInkNavy.withValues(alpha: 0.08)
      ..strokeWidth = 0.6;
    final double cellW = size.width / _twoDSSMapColumns;
    final double cellH = size.height / _twoDSSMapRows;
    for (int c = 0; c <= _twoDSSMapColumns; c++) {
      final double x = c * cellW;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (int r = 0; r <= _twoDSSMapRows; r++) {
      final double y = r * cellH;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Landmark dots.
    for (final _TwoDSSLandmark lm in _twoDSSLandmarks) {
      final Offset c = Offset(
        (lm.column + 0.5) * cellW,
        (lm.row + 0.5) * cellH,
      );
      final Paint dot = Paint()
        ..color = _twoDSSColourFor(lm.type)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(c, 3.0, dot);
      final Paint dotRim = Paint()
        ..color = _twoDSSInkNavy.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7;
      canvas.drawCircle(c, 3.0, dotRim);
    }

    // Highlighted landmark (the last visited) — draw a halo.
    if (highlight != null) {
      final Offset c = Offset(
        (highlight!.column + 0.5) * cellW,
        (highlight!.row + 0.5) * cellH,
      );
      final Paint halo = Paint()
        ..color = _twoDSSBrassBright.withValues(alpha: 0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4;
      canvas.drawCircle(c, 7.0, halo);
    }

    // Viewport rectangle — only when the inner positions are ready.
    if (!ready) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: 'warming up…',
          style: TextStyle(
            color: _twoDSSInkFaint.withValues(alpha: 0.7),
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, const Offset(6, 4));
      return;
    }
    final double viewportW =
        (size.width * (1.0 - horizontalMax / _totalExtentX()))
            .clamp(10.0, size.width);
    final double viewportH =
        (size.height * (1.0 - verticalMax / _totalExtentY()))
            .clamp(10.0, size.height);
    // Map pixel offset -> mini-map coordinates.
    final double x = (horizontalPixels /
            math.max(1.0, _totalExtentX())) *
        size.width;
    final double y = (verticalPixels /
            math.max(1.0, _totalExtentY())) *
        size.height;
    final Rect vp = Rect.fromLTWH(x, y, viewportW, viewportH);
    final Paint vpFill = Paint()
      ..color = _twoDSSBrass.withValues(alpha: 0.28)
      ..style = PaintingStyle.fill;
    final Paint vpStroke = Paint()
      ..color = _twoDSSBrassDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawRect(vp, vpFill);
    canvas.drawRect(vp, vpStroke);
  }

  double _totalExtentX() {
    return horizontalMax +
        (_twoDSSMapColumns * _twoDSSCellSize) *
            (horizontalMax > 0 ? 0.0 : 1.0) +
        (horizontalMax <= 0 ? 1.0 : 0.0);
  }

  double _totalExtentY() {
    return verticalMax +
        (_twoDSSMapRows * _twoDSSCellSize) *
            (verticalMax > 0 ? 0.0 : 1.0) +
        (verticalMax <= 0 ? 1.0 : 0.0);
  }

  @override
  bool shouldRepaint(covariant _TwoDSSMiniMapPainter oldDelegate) {
    return oldDelegate.horizontalPixels != horizontalPixels ||
        oldDelegate.verticalPixels != verticalPixels ||
        oldDelegate.horizontalMax != horizontalMax ||
        oldDelegate.verticalMax != verticalMax ||
        oldDelegate.ready != ready ||
        oldDelegate.highlight?.name != highlight?.name;
  }
}

// ---------------------------------------------------------------------------
// Section 6: Diagnostics panel — a tabular readout of every relevant live
// value, with small bar-style indicators for the pixel / max ratio.
// ---------------------------------------------------------------------------
class _TwoDSSDiagnosticsPanel extends StatelessWidget {
  const _TwoDSSDiagnosticsPanel({
    required this.horizontalPixels,
    required this.verticalPixels,
    required this.horizontalMax,
    required this.verticalMax,
    required this.horizontalReady,
    required this.verticalReady,
    required this.stepCells,
    required this.animateSteps,
    required this.curveLabel,
    required this.durationMs,
    required this.lastVisited,
  });

  final double horizontalPixels;
  final double verticalPixels;
  final double horizontalMax;
  final double verticalMax;
  final bool horizontalReady;
  final bool verticalReady;
  final double stepCells;
  final bool animateSteps;
  final String curveLabel;
  final double durationMs;
  final _TwoDSSLandmark? lastVisited;

  @override
  Widget build(BuildContext context) {
    return _TwoDSSOutlinedCard(
      accent: _twoDSSInkNavyBright,
      titleIcon: Icons.analytics,
      title: 'Diagnostics — reading both inner positions at once',
      subtitle:
          'Each row pulls a value off one of the two inner ScrollableState '
              'objects the 2D state exposes.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _TwoDSSDiagRow(
            axis: 'Horizontal axis',
            pixels: horizontalPixels,
            max: horizontalMax,
            ready: horizontalReady,
            accent: _twoDSSSeal,
          ),
          const SizedBox(height: 12),
          _TwoDSSDiagRow(
            axis: 'Vertical axis',
            pixels: verticalPixels,
            max: verticalMax,
            ready: verticalReady,
            accent: _twoDSSInkNavyBright,
          ),
          const SizedBox(height: 14),
          _TwoDSSKvGrid(
            entries: <List<String>>[
              <String>[
                'stepCells',
                '${stepCells.toStringAsFixed(1)} '
                    '(${(stepCells * _twoDSSCellSize).toStringAsFixed(0)} px)'
              ],
              <String>[
                'mode',
                animateSteps ? 'animateTo(...)' : 'jumpTo(...)'
              ],
              <String>['curve', curveLabel],
              <String>[
                'duration',
                '${durationMs.round()} ms'
              ],
              <String>[
                'lastVisited',
                lastVisited?.name ?? '—'
              ],
              <String>[
                'cellSize',
                '${_twoDSSCellSize.toStringAsFixed(0)} px'
              ],
              <String>[
                'totalCells',
                '${_twoDSSMapColumns * _twoDSSMapRows}'
              ],
              <String>[
                'boundsReady',
                '${horizontalReady && verticalReady}'
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TwoDSSDiagRow extends StatelessWidget {
  const _TwoDSSDiagRow({
    required this.axis,
    required this.pixels,
    required this.max,
    required this.ready,
    required this.accent,
  });

  final String axis;
  final double pixels;
  final double max;
  final bool ready;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final double ratio = (max <= 0 || !ready)
        ? 0.0
        : clampDouble(pixels / max, 0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: accent.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ready ? _twoDSSMossBright : _twoDSSInkFaint,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                axis,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                'pixels: ${pixels.toStringAsFixed(1)}  /  '
                    'max: ${max.toStringAsFixed(1)}',
                style: const TextStyle(
                  color: _twoDSSInkNavy,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  color: _twoDSSParchmentShadow.withValues(alpha: 0.6),
                ),
                FractionallySizedBox(
                  widthFactor: ratio,
                  child: Container(
                    height: 10,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${(ratio * 100).toStringAsFixed(1)}% of max scroll extent',
            style: const TextStyle(
              color: _twoDSSInkFaint,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDSSKvGrid extends StatelessWidget {
  const _TwoDSSKvGrid({required this.entries});
  final List<List<String>> entries;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        for (final List<String> row in entries)
          Container(
            width: 220,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: _twoDSSParchmentDeep.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _twoDSSInkNavy.withValues(alpha: 0.12),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    row[0],
                    style: const TextStyle(
                      color: _twoDSSInkFaint,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Text(
                  row[1],
                  style: const TextStyle(
                    color: _twoDSSInkNavy,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7: Epilogue — guidance and lifecycle notes. Bulleted list style
// so each note stands on its own and can be scanned quickly.
// ---------------------------------------------------------------------------
class _TwoDSSEpilogueCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> notes = <Map<String, String>>[
      <String, String>{
        'title': 'When the state\'s imperative API fits',
        'body':
            'Reach for verticalScrollable / horizontalScrollable when you '
                'need to nudge, seek, or animate from outside the viewport '
                'tree — toolbar buttons, keyboard shortcuts, tour playback, '
                'deep-linking from URL, or test fixtures.',
      },
      <String, String>{
        'title': 'When a custom TwoDimensionalViewport fits',
        'body':
            'If the behaviour you need is *inside* the cell layout (custom '
                'paint order, sticky headers, variable cell sizes, snapping), '
                'the answer is almost always a bespoke TwoDimensionalViewport '
                'subclass instead of imperative state calls.',
      },
      <String, String>{
        'title': 'Guarding the GlobalKey',
        'body':
            'Always check `key.currentState != null` before reading '
                'verticalScrollable / horizontalScrollable. The getters '
                'assert that the inner ScrollableState keys have mounted, '
                'and they have not on the very first frame.',
      },
      <String, String>{
        'title': 'Future.wait for both axes',
        'body':
            'animateTo returns a Future. To synchronise the two axes, '
                'await `Future.wait([h.animateTo(...), v.animateTo(...)])`. '
                'Do not chain them sequentially for simultaneous motion.',
      },
      <String, String>{
        'title': 'Respecting physics and bounds',
        'body':
            'Clamp your computed target to `[minScrollExtent, '
                'maxScrollExtent]`. Otherwise the scrollable will accept '
                'the target but the physics may snap back, producing a '
                'jarring rubber-band.',
      },
      <String, String>{
        'title': 'No controllers? No problem',
        'body':
            'If the ScrollableDetails omit a controller, the state '
                'synthesises fallback ones. They are still reachable via '
                'the inner ScrollableState, so you do not need to wire '
                'ScrollController fields just to drive the scroll.',
      },
      <String, String>{
        'title': 'Diagonal drag behaviour',
        'body':
            'The diagonalDragBehavior enum (none / weightedEvent / '
                'weightedContinuous / free) decides how user gestures feed '
                'both axes. Imperative calls bypass this entirely; they '
                'always drive exactly the axis you name.',
      },
      <String, String>{
        'title': 'Test ergonomics',
        'body':
            'In widget tests, `find.byType(TwoDimensionalScrollable)` and '
                '`tester.state<TwoDimensionalScrollableState>(finder)` give '
                'you the same handle that the GlobalKey would — useful for '
                'verifying imperative scroll effects.',
      },
    ];
    return _TwoDSSOutlinedCard(
      accent: _twoDSSInkNavy,
      titleIcon: Icons.bookmark_outline,
      title: 'Lifecycle notes and when to reach for what',
      subtitle:
          'Summary advice distilled from using this API across map views, '
              'spreadsheets, and node-editor canvases.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < notes.length; i++)
            Container(
              margin: EdgeInsets.only(top: i == 0 ? 0 : 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: i.isEven
                    ? _twoDSSParchmentDeep.withValues(alpha: 0.45)
                    : _twoDSSParchment.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _twoDSSInkNavy.withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.bookmark,
                    color: _twoDSSBrassDeep,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          notes[i]['title']!,
                          style: const TextStyle(
                            color: _twoDSSInkNavy,
                            fontWeight: FontWeight.w800,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notes[i]['body']!,
                          style: const TextStyle(
                            color: _twoDSSInkFaint,
                            fontSize: 12.5,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _twoDSSInkNavy,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.emoji_objects,
                  color: _twoDSSBrassBright,
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'The cartographer\'s rule: if you need to move the '
                        'map, reach for the state. If you need to change '
                        'what the map *is*, reach for a custom viewport. '
                        'TwoDimensionalScrollableState is the grip on an '
                        'existing map — not the atelier where a new one is '
                        'drawn.',
                    style: TextStyle(
                      color: _twoDSSParchment,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
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
}
