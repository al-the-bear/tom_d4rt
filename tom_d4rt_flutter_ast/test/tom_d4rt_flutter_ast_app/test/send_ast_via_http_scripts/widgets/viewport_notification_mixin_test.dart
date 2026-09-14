// D4rt test script: Deep Demo — ViewportNotificationMixin
//
// This file is a deep, hand-authored visual demo of
// `ViewportNotificationMixin` — the `Notification` mixin used by
// `ScrollNotification` and `OverscrollIndicatorNotification` to track
// how many `RenderAbstractViewport` ancestors a notification has
// bubbled through. Each `ViewportElementMixin` element increments the
// notification's `depth` as it passes, so a `NotificationListener`
// ancestor can tell whether a `ScrollNotification` came from the
// nearest `Scrollable` (`depth == 0`) or from a nested one
// (`depth >= 1`).
//
// The demo presents a signal-operator's console styled like a vintage
// radio tower: a preamble card explains the mixin, a nested
// scrollables scenario pumps real notifications through the tree, a
// live "signal tower" radiates pulses at the depth level of each
// arriving notification, a depth inspector table logs the recent
// bubble activity, a filter lab lets the user reject notifications
// above a chosen depth threshold, a breadcrumb diagram draws the
// ancestor chain pointed to by each notification, and an epilogue
// card collects the production recipes (throttling updates,
// guarding with depth checks, selective re-renders).
//
// The demo is authored for the d4rt AST harness. It exposes a single
// top-level `dynamic build(BuildContext context)` entry point and
// does not call `runApp` or define a `main` function.

import 'dart:math' as math;

import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;

// ---------------------------------------------------------------------------
// Theme tokens — midnight-blue sky, amber signal lamps, teal antenna glow,
// and black tower silhouette. The `_Vnm` prefix keeps every identifier
// private to this demo and lowerCamelCase-compliant for the analyzer.
// `withValues(alpha: ...)` is used everywhere instead of `withOpacity` to
// keep the deprecation lint quiet.
// ---------------------------------------------------------------------------
const Color _vnmMidnight = Color(0xFF0A1630);
const Color _vnmMidnightDeep = Color(0xFF050C1C);
const Color _vnmMidnightMid = Color(0xFF152448);
const Color _vnmMidnightBright = Color(0xFF223A73);
const Color _vnmSkyHaze = Color(0xFF2E4A82);
const Color _vnmAmber = Color(0xFFE6A94B);
const Color _vnmAmberBright = Color(0xFFFFD27A);
const Color _vnmAmberDeep = Color(0xFFA5722A);
const Color _vnmTeal = Color(0xFF37B6A3);
const Color _vnmTealBright = Color(0xFF74E3D0);
const Color _vnmTealDeep = Color(0xFF1F7B6E);
const Color _vnmTowerBlack = Color(0xFF0A0A10);
const Color _vnmTowerSlate = Color(0xFF202330);
const Color _vnmGround = Color(0xFF0F0F18);
const Color _vnmParchment = Color(0xFFE9DEC2);
const Color _vnmParchmentSoft = Color(0xFFD6C79F);
const Color _vnmParchmentShadow = Color(0xFF8F8365);
const Color _vnmCrimson = Color(0xFFB0453A);
const Color _vnmCrimsonBright = Color(0xFFE27362);

// ---------------------------------------------------------------------------
// Tower geometry constants. The tower, lamps, and ground are painted by a
// `CustomPainter` that consumes these. Depth levels are indexed 0..4 with
// zero at the tower tip (nearest Scrollable) and higher numbers further
// down (outer viewports).
// ---------------------------------------------------------------------------
const int _vnmMaxDepth = 4;
const double _vnmTowerWidth = 260.0;
const double _vnmTowerHeight = 380.0;
const double _vnmLampRadius = 12.0;
const Duration _vnmPulseDuration = Duration(milliseconds: 900);
const Duration _vnmHistoryWindow = Duration(seconds: 12);

// ---------------------------------------------------------------------------
// A single logged notification — captured by the signal log, rendered by
// the inspector table, and drawn as a pulse on the tower painter. The
// `receivedAt` field is used by the log's sliding window, the `depth` and
// `kind` fields drive the visual presentation.
// ---------------------------------------------------------------------------
class _VnmSignalEvent {
  const _VnmSignalEvent({
    required this.id,
    required this.kind,
    required this.depth,
    required this.pixels,
    required this.axis,
    required this.direction,
    required this.receivedAt,
    required this.accepted,
  });

  final int id;
  final _VnmSignalKind kind;
  final int depth;
  final double? pixels;
  final String axis;
  final String direction;
  final DateTime receivedAt;
  final bool accepted;
}

enum _VnmSignalKind {
  start,
  update,
  over,
  user,
  end,
  simulated,
}

String _vnmKindLabel(_VnmSignalKind kind) {
  switch (kind) {
    case _VnmSignalKind.start:
      return 'ScrollStart';
    case _VnmSignalKind.update:
      return 'ScrollUpdate';
    case _VnmSignalKind.over:
      return 'Overscroll';
    case _VnmSignalKind.user:
      return 'UserScroll';
    case _VnmSignalKind.end:
      return 'ScrollEnd';
    case _VnmSignalKind.simulated:
      return 'Simulated';
  }
}

Color _vnmColourFor(_VnmSignalKind kind) {
  switch (kind) {
    case _VnmSignalKind.start:
      return _vnmTealBright;
    case _VnmSignalKind.update:
      return _vnmAmberBright;
    case _VnmSignalKind.over:
      return _vnmCrimsonBright;
    case _VnmSignalKind.user:
      return _vnmAmber;
    case _VnmSignalKind.end:
      return _vnmTeal;
    case _VnmSignalKind.simulated:
      return _vnmParchment;
  }
}

IconData _vnmIconFor(_VnmSignalKind kind) {
  switch (kind) {
    case _VnmSignalKind.start:
      return Icons.play_circle_fill;
    case _VnmSignalKind.update:
      return Icons.autorenew;
    case _VnmSignalKind.over:
      return Icons.warning_amber;
    case _VnmSignalKind.user:
      return Icons.touch_app;
    case _VnmSignalKind.end:
      return Icons.stop_circle;
    case _VnmSignalKind.simulated:
      return Icons.science;
  }
}

// ---------------------------------------------------------------------------
// Preamble content — seven cards that describe the mixin in plain
// language. The body of each card is a short paragraph; rendering is done
// by a reusable `_VnmDossierCard` widget.
// ---------------------------------------------------------------------------
class _VnmDossierEntry {
  const _VnmDossierEntry({
    required this.heading,
    required this.body,
    required this.glyph,
    required this.accent,
  });

  final String heading;
  final String body;
  final IconData glyph;
  final Color accent;
}

const List<_VnmDossierEntry> _vnmDossier = <_VnmDossierEntry>[
  _VnmDossierEntry(
    heading: 'What the mixin does',
    body:
        'ViewportNotificationMixin is mixed into any Notification that should '
        'track how many RenderAbstractViewport render objects it has bubbled '
        'through. The counter is exposed via the depth getter.',
    glyph: Icons.info_outline,
    accent: _vnmAmber,
  ),
  _VnmDossierEntry(
    heading: 'Who uses it',
    body:
        'ScrollNotification and OverscrollIndicatorNotification both mix it '
        'in. A NotificationListener<ScrollNotification> therefore always sees '
        'a depth integer on incoming notifications.',
    glyph: Icons.account_tree,
    accent: _vnmTeal,
  ),
  _VnmDossierEntry(
    heading: 'How depth is set',
    body:
        'ViewportElementMixin.onNotification increments depth by one each '
        'time the notification bubbles past a Viewport element. Depth zero '
        'means the notification came from the nearest Scrollable.',
    glyph: Icons.layers,
    accent: _vnmAmberBright,
  ),
  _VnmDossierEntry(
    heading: 'Why it matters',
    body:
        'If a UI wants to react only to its own Scrollable it should filter '
        'for depth == 0. Without that guard, nested scrollables will deliver '
        'spurious events to outer listeners.',
    glyph: Icons.filter_alt,
    accent: _vnmCrimsonBright,
  ),
  _VnmDossierEntry(
    heading: 'Local vs remote',
    body:
        'The mixin\'s debugFillDescription prints "depth: N (local)" for '
        'zero and "(remote)" otherwise — a handy breadcrumb when dumping '
        'notifications during a bug hunt.',
    glyph: Icons.travel_explore,
    accent: _vnmTealBright,
  ),
  _VnmDossierEntry(
    heading: 'Timing caveat',
    body:
        'Scroll notifications arrive after build and layout, so it is too '
        'late to call setState in the listener. Paint-time reactions are '
        'fine; layout ones are not.',
    glyph: Icons.hourglass_bottom,
    accent: _vnmAmber,
  ),
  _VnmDossierEntry(
    heading: 'Stopping bubbling',
    body:
        'Returning true from the listener halts further propagation. Most '
        'code returns false so ancestors still observe. Combine depth check '
        'and return value for precise routing.',
    glyph: Icons.block,
    accent: _vnmParchment,
  ),
];

// ---------------------------------------------------------------------------
// Production recipes for the epilogue card.
// ---------------------------------------------------------------------------
class _VnmRecipe {
  const _VnmRecipe({
    required this.title,
    required this.body,
    required this.glyph,
    required this.tint,
  });

  final String title;
  final String body;
  final IconData glyph;
  final Color tint;
}

const List<_VnmRecipe> _vnmRecipes = <_VnmRecipe>[
  _VnmRecipe(
    title: 'Guard with depth == 0',
    body:
        'Before reacting to a ScrollNotification, check the depth. This is '
        'the single biggest footgun when a listener sits above nested '
        'Scrollables.',
    glyph: Icons.shield,
    tint: _vnmAmberBright,
  ),
  _VnmRecipe(
    title: 'Throttle update bursts',
    body:
        'ScrollUpdateNotification fires per frame during an active scroll. '
        'Wrap heavy work in a Timer, a ValueNotifier, or a ticker so you '
        'downsample to your rendering budget.',
    glyph: Icons.speed,
    tint: _vnmTealBright,
  ),
  _VnmRecipe(
    title: 'Selective re-render',
    body:
        'Route notification payloads into ValueNotifier instances and wrap '
        'dependent subtrees in ValueListenableBuilder. The NotificationListener '
        'itself never needs to call setState.',
    glyph: Icons.refresh,
    tint: _vnmAmber,
  ),
  _VnmRecipe(
    title: 'Log before you filter',
    body:
        'While diagnosing a scroll bug, capture every notification with its '
        'depth, runtimeType, and metrics. Filter later — premature filtering '
        'hides the story.',
    glyph: Icons.history_edu,
    tint: _vnmParchment,
  ),
  _VnmRecipe(
    title: 'Prefer controllers for imperative work',
    body:
        'Notifications are for paint-time reactions. If you need to drive '
        'scroll programmatically, use ScrollController.animateTo rather than '
        'reacting to your own notifications.',
    glyph: Icons.settings_remote,
    tint: _vnmCrimsonBright,
  ),
  _VnmRecipe(
    title: 'Avoid layout work in listeners',
    body:
        'setState during onNotification runs a frame behind the scroll. For '
        'sticky-header effects, compute layout synchronously during build '
        'and only use notifications to trigger repaint.',
    glyph: Icons.architecture,
    tint: _vnmTeal,
  ),
];

// ---------------------------------------------------------------------------
// Signal log — the central ValueNotifier-backed store used by listeners and
// rendered by the inspector, tower, and breadcrumb widgets. The log keeps a
// bounded rolling window of the most recent notifications.
// ---------------------------------------------------------------------------
class _VnmSignalLog extends ChangeNotifier {
  _VnmSignalLog();

  final List<_VnmSignalEvent> _events = <_VnmSignalEvent>[];
  int _nextId = 1;
  int _threshold = _vnmMaxDepth;
  _VnmSignalEvent? _latestAccepted;
  int _acceptedCount = 0;
  int _rejectedCount = 0;

  static const int _maxEntries = 20;

  List<_VnmSignalEvent> get events => List<_VnmSignalEvent>.unmodifiable(_events);
  int get threshold => _threshold;
  _VnmSignalEvent? get latestAccepted => _latestAccepted;
  int get acceptedCount => _acceptedCount;
  int get rejectedCount => _rejectedCount;
  int get totalCount => _acceptedCount + _rejectedCount;

  void setThreshold(int value) {
    final int clamped = value.clamp(0, _vnmMaxDepth);
    if (clamped == _threshold) {
      return;
    }
    _threshold = clamped;
    notifyListeners();
  }

  /// Ingests an event. Returns the (possibly adjusted) event so the caller can
  /// inspect the assigned id if needed.
  _VnmSignalEvent ingest({
    required _VnmSignalKind kind,
    required int depth,
    double? pixels,
    String axis = 'vertical',
    String direction = 'idle',
  }) {
    final bool accepted = depth <= _threshold;
    final _VnmSignalEvent event = _VnmSignalEvent(
      id: _nextId++,
      kind: kind,
      depth: depth,
      pixels: pixels,
      axis: axis,
      direction: direction,
      receivedAt: DateTime.now(),
      accepted: accepted,
    );
    _events.insert(0, event);
    if (_events.length > _maxEntries) {
      _events.removeRange(_maxEntries, _events.length);
    }
    if (accepted) {
      _latestAccepted = event;
      _acceptedCount += 1;
    } else {
      _rejectedCount += 1;
    }
    notifyListeners();
    return event;
  }

  void clear() {
    if (_events.isEmpty && _acceptedCount == 0 && _rejectedCount == 0) {
      return;
    }
    _events.clear();
    _latestAccepted = null;
    _acceptedCount = 0;
    _rejectedCount = 0;
    notifyListeners();
  }
}

// ---------------------------------------------------------------------------
// Breadcrumb chain — the ancestor path illustrated at the top of the nested
// scenario. This is a static illustration and is not tied to the live
// element tree.
// ---------------------------------------------------------------------------
class _VnmBreadcrumb {
  const _VnmBreadcrumb({
    required this.label,
    required this.detail,
    required this.depth,
    required this.tint,
  });

  final String label;
  final String detail;
  final int depth;
  final Color tint;
}

const List<_VnmBreadcrumb> _vnmBreadcrumbs = <_VnmBreadcrumb>[
  _VnmBreadcrumb(
    label: 'OuterFrame',
    detail: 'Scaffold → SingleChildScrollView',
    depth: 2,
    tint: _vnmCrimsonBright,
  ),
  _VnmBreadcrumb(
    label: 'MidList',
    detail: 'ListView.builder (scroll container)',
    depth: 1,
    tint: _vnmAmberBright,
  ),
  _VnmBreadcrumb(
    label: 'InnerLane',
    detail: 'Horizontal ListView tiles',
    depth: 0,
    tint: _vnmTealBright,
  ),
];

// ---------------------------------------------------------------------------
// Top-level entry expected by the d4rt harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('ViewportNotificationMixin deep demo booting...');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ViewportNotificationMixin Deep Demo',
    home: _VnmHome(),
  );
}

// ---------------------------------------------------------------------------
// _VnmHome — Scaffold with AppBar depth readout, long scrollable body.
// ---------------------------------------------------------------------------
class _VnmHome extends StatefulWidget {
  const _VnmHome();

  @override
  State<_VnmHome> createState() => _VnmHomeState();
}

class _VnmHomeState extends State<_VnmHome> {
  final _VnmSignalLog _log = _VnmSignalLog();
  final math.Random _rng = math.Random(91919);

  @override
  void dispose() {
    _log.dispose();
    super.dispose();
  }

  void _simulate() {
    final int depth = _rng.nextInt(_vnmMaxDepth + 1);
    final List<_VnmSignalKind> kinds = <_VnmSignalKind>[
      _VnmSignalKind.simulated,
      _VnmSignalKind.update,
      _VnmSignalKind.over,
      _VnmSignalKind.start,
      _VnmSignalKind.end,
    ];
    final _VnmSignalKind kind = kinds[_rng.nextInt(kinds.length)];
    _log.ingest(
      kind: kind,
      depth: depth,
      pixels: _rng.nextDouble() * 480.0,
      axis: _rng.nextBool() ? 'vertical' : 'horizontal',
      direction: _rng.nextBool() ? 'forward' : 'reverse',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _vnmMidnightDeep,
      appBar: _VnmAppBar(log: _log),
      body: _VnmBody(log: _log),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _simulate,
        backgroundColor: _vnmAmber,
        foregroundColor: _vnmMidnightDeep,
        icon: const Icon(Icons.bolt),
        label: const Text('Simulate'),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar with live depth readout and accepted/rejected counters.
// ---------------------------------------------------------------------------
class _VnmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _VnmAppBar({required this.log});

  final _VnmSignalLog log;

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: log,
      builder: (BuildContext context, Widget? child) {
        final _VnmSignalEvent? latest = log.latestAccepted;
        return Material(
          color: _vnmMidnight,
          elevation: 8,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: _vnmMidnightMid,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _vnmAmber, width: 1.4),
                    ),
                    child: const Icon(
                      Icons.cell_tower,
                      color: _vnmAmberBright,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'ViewportNotificationMixin — Signal Console',
                          style: TextStyle(
                            color: _vnmParchment,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Watching notifications as they bubble through '
                          'nested viewports.',
                          style: TextStyle(
                            color: _vnmParchmentShadow,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  _VnmHeaderChip(
                    label: 'depth',
                    value: latest == null ? '—' : latest.depth.toString(),
                    accent: _vnmTealBright,
                  ),
                  const SizedBox(width: 8),
                  _VnmHeaderChip(
                    label: 'kept',
                    value: log.acceptedCount.toString(),
                    accent: _vnmAmberBright,
                  ),
                  const SizedBox(width: 8),
                  _VnmHeaderChip(
                    label: 'dropped',
                    value: log.rejectedCount.toString(),
                    accent: _vnmCrimsonBright,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _VnmHeaderChip extends StatelessWidget {
  const _VnmHeaderChip({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _vnmMidnightMid,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: _vnmParchment,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Body — top-level scrollable column holding all sections.
// ---------------------------------------------------------------------------
class _VnmBody extends StatelessWidget {
  const _VnmBody({required this.log});

  final _VnmSignalLog log;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _vnmMidnightDeep,
            _vnmMidnight,
            _vnmMidnightDeep,
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _VnmSectionHeader(
              number: '01',
              title: 'Dossier',
              subtitle: 'Seven cards on what the mixin does and why it matters.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 16),
            const _VnmDossierGrid(),
            const SizedBox(height: 40),
            _VnmSectionHeader(
              number: '02',
              title: 'Breadcrumb Chain',
              subtitle: 'Outer → inner ancestor path for the nested scenario.',
              icon: Icons.account_tree,
            ),
            const SizedBox(height: 16),
            const _VnmBreadcrumbRow(),
            const SizedBox(height: 40),
            _VnmSectionHeader(
              number: '03',
              title: 'Signal Tower',
              subtitle: 'Animated lamp at the latest depth bands 0..4.',
              icon: Icons.cell_tower,
            ),
            const SizedBox(height: 16),
            _VnmSignalTower(log: log),
            const SizedBox(height: 40),
            _VnmSectionHeader(
              number: '04',
              title: 'Nested Scrollables',
              subtitle:
                  'Three real nested scroll containers. Each listener logs '
                  'with its depth.',
              icon: Icons.view_column,
            ),
            const SizedBox(height: 16),
            _VnmNestedScenario(log: log),
            const SizedBox(height: 40),
            _VnmSectionHeader(
              number: '05',
              title: 'Filter Lab',
              subtitle: 'Reject notifications above a depth threshold.',
              icon: Icons.filter_alt,
            ),
            const SizedBox(height: 16),
            _VnmFilterLab(log: log),
            const SizedBox(height: 40),
            _VnmSectionHeader(
              number: '06',
              title: 'Depth Inspector',
              subtitle: 'Last twenty notifications — depth, kind, pixels.',
              icon: Icons.table_rows,
            ),
            const SizedBox(height: 16),
            _VnmInspectorTable(log: log),
            const SizedBox(height: 40),
            _VnmSectionHeader(
              number: '07',
              title: 'Production Recipes',
              subtitle: 'Six patterns for shipping with the mixin.',
              icon: Icons.fact_check,
            ),
            const SizedBox(height: 16),
            const _VnmRecipesGrid(),
            const SizedBox(height: 36),
            const _VnmFooter(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section header — uniform chrome across the seven sections.
// ---------------------------------------------------------------------------
class _VnmSectionHeader extends StatelessWidget {
  const _VnmSectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String number;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: _vnmMidnightMid,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _vnmAmber.withValues(alpha: 0.6),
              width: 1.2,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: _vnmAmberBright, size: 24),
        ),
        const SizedBox(width: 16),
        // Secondary sky tint accent kept visible by consuming the
        // midnight-bright token here.
        Container(
          width: 4,
          height: 52,
          decoration: BoxDecoration(
            color: _vnmMidnightBright,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    number,
                    style: const TextStyle(
                      color: _vnmAmber,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: _vnmParchment,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _vnmParchmentShadow,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      _vnmAmber.withValues(alpha: 0.6),
                      _vnmAmber.withValues(alpha: 0.0),
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

// ---------------------------------------------------------------------------
// Dossier grid — seven `_vnmDossier` entries as cards.
// ---------------------------------------------------------------------------
class _VnmDossierGrid extends StatelessWidget {
  const _VnmDossierGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth > 900
            ? 3
            : (constraints.maxWidth > 560 ? 2 : 1);
        final double gap = 16;
        final double cardWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: <Widget>[
            for (final _VnmDossierEntry entry in _vnmDossier)
              SizedBox(
                width: cardWidth,
                child: _VnmDossierCard(entry: entry),
              ),
          ],
        );
      },
    );
  }
}

class _VnmDossierCard extends StatelessWidget {
  const _VnmDossierCard({required this.entry});

  final _VnmDossierEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _vnmMidnightMid,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: entry.accent.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: entry.accent.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: entry.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(entry.glyph, color: entry.accent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.heading,
                  style: const TextStyle(
                    color: _vnmParchment,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            entry.body,
            style: const TextStyle(
              color: _vnmParchmentSoft,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Breadcrumb row — outer → inner ancestor chain.
// ---------------------------------------------------------------------------
class _VnmBreadcrumbRow extends StatelessWidget {
  const _VnmBreadcrumbRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _vnmMidnightMid,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _vnmAmber.withValues(alpha: 0.25)),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool vertical = constraints.maxWidth < 620;
          if (vertical) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (int i = 0; i < _vnmBreadcrumbs.length; i++) ...<Widget>[
                  _VnmBreadcrumbChip(crumb: _vnmBreadcrumbs[i]),
                  if (i < _vnmBreadcrumbs.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Icon(
                        Icons.south,
                        color: _vnmAmber,
                        size: 18,
                      ),
                    ),
                ],
              ],
            );
          }
          return Row(
            children: <Widget>[
              for (int i = 0; i < _vnmBreadcrumbs.length; i++) ...<Widget>[
                Expanded(
                  child: _VnmBreadcrumbChip(crumb: _vnmBreadcrumbs[i]),
                ),
                if (i < _vnmBreadcrumbs.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.east,
                      color: _vnmAmber,
                      size: 20,
                    ),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _VnmBreadcrumbChip extends StatelessWidget {
  const _VnmBreadcrumbChip({required this.crumb});

  final _VnmBreadcrumb crumb;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _vnmMidnightDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: crumb.tint.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: crumb.tint.withValues(alpha: 0.2),
              border: Border.all(color: crumb.tint, width: 1.6),
            ),
            alignment: Alignment.center,
            child: Text(
              crumb.depth.toString(),
              style: TextStyle(
                color: crumb.tint,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  crumb.label,
                  style: const TextStyle(
                    color: _vnmParchment,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  crumb.detail,
                  style: const TextStyle(
                    color: _vnmParchmentShadow,
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
// Signal tower — CustomPainter with ticker-driven amber pulses at the depth
// of the latest notification.
// ---------------------------------------------------------------------------
class _VnmSignalTower extends StatefulWidget {
  const _VnmSignalTower({required this.log});

  final _VnmSignalLog log;

  @override
  State<_VnmSignalTower> createState() => _VnmSignalTowerState();
}

class _VnmSignalTowerState extends State<_VnmSignalTower>
    with TickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _elapsed = Duration.zero;
  final List<_VnmPulse> _pulses = <_VnmPulse>[];

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _ticker.start();
    widget.log.addListener(_onLog);
  }

  @override
  void dispose() {
    widget.log.removeListener(_onLog);
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    setState(() {
      _elapsed = elapsed;
      _pulses.removeWhere((_VnmPulse p) {
        final double age =
            (_elapsed - p.start).inMilliseconds /
                _vnmPulseDuration.inMilliseconds;
        return age > 1.0;
      });
    });
  }

  void _onLog() {
    final _VnmSignalEvent? event = widget.log.latestAccepted;
    if (event == null) {
      return;
    }
    if (_pulses.isNotEmpty && _pulses.last.eventId == event.id) {
      return;
    }
    _pulses.add(
      _VnmPulse(
        eventId: event.id,
        depth: event.depth,
        start: _elapsed,
        kind: event.kind,
      ),
    );
    if (_pulses.length > 8) {
      _pulses.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.log,
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: 420,
          decoration: BoxDecoration(
            color: _vnmMidnightDeep,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _vnmAmber.withValues(alpha: 0.25)),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomPaint(
            painter: _VnmTowerPainter(
              elapsed: _elapsed,
              pulses: List<_VnmPulse>.unmodifiable(_pulses),
              latest: widget.log.latestAccepted,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}

class _VnmPulse {
  const _VnmPulse({
    required this.eventId,
    required this.depth,
    required this.start,
    required this.kind,
  });

  final int eventId;
  final int depth;
  final Duration start;
  final _VnmSignalKind kind;
}

class _VnmTowerPainter extends CustomPainter {
  _VnmTowerPainter({
    required this.elapsed,
    required this.pulses,
    required this.latest,
  });

  final Duration elapsed;
  final List<_VnmPulse> pulses;
  final _VnmSignalEvent? latest;

  @override
  void paint(Canvas canvas, Size size) {
    _paintSky(canvas, size);
    _paintStars(canvas, size);
    _paintGround(canvas, size);
    final Offset towerBase = Offset(size.width / 2, size.height - 40);
    final double towerHeight = math.min(_vnmTowerHeight, size.height - 80);
    _paintTower(canvas, towerBase, towerHeight);
    _paintLamps(canvas, towerBase, towerHeight);
    _paintPulses(canvas, towerBase, towerHeight);
    _paintLegend(canvas, size);
  }

  void _paintSky(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint p = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          _vnmMidnightDeep,
          _vnmMidnight,
          _vnmSkyHaze,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, p);
  }

  void _paintStars(Canvas canvas, Size size) {
    final math.Random rng = math.Random(42);
    final Paint star = Paint()..color = _vnmParchment.withValues(alpha: 0.7);
    for (int i = 0; i < 80; i++) {
      final double x = rng.nextDouble() * size.width;
      final double y = rng.nextDouble() * (size.height * 0.65);
      final double twinkle = 0.4 +
          0.6 *
              ((math.sin(
                        elapsed.inMilliseconds / 900.0 + i.toDouble() * 0.7,
                      ) +
                      1) /
                  2);
      star.color = _vnmParchment.withValues(alpha: 0.2 + 0.5 * twinkle);
      canvas.drawCircle(Offset(x, y), 0.8 + rng.nextDouble() * 1.2, star);
    }
  }

  void _paintGround(Canvas canvas, Size size) {
    final Paint p = Paint()..color = _vnmGround;
    final Rect rect = Rect.fromLTRB(
      0,
      size.height - 40,
      size.width,
      size.height,
    );
    canvas.drawRect(rect, p);
    final Paint line = Paint()
      ..color = _vnmAmber.withValues(alpha: 0.25)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, size.height - 40),
      Offset(size.width, size.height - 40),
      line,
    );
  }

  void _paintTower(Canvas canvas, Offset base, double height) {
    final double halfBase = _vnmTowerWidth / 2;
    final double halfTop = 22;
    final Path silhouette = Path()
      ..moveTo(base.dx - halfBase, base.dy)
      ..lineTo(base.dx - halfTop, base.dy - height)
      ..lineTo(base.dx + halfTop, base.dy - height)
      ..lineTo(base.dx + halfBase, base.dy)
      ..close();
    final Paint silPaint = Paint()..color = _vnmTowerBlack;
    canvas.drawPath(silhouette, silPaint);

    final Paint slate = Paint()
      ..color = _vnmTowerSlate
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final int rungs = 10;
    for (int i = 1; i < rungs; i++) {
      final double t = i / rungs;
      final double y = base.dy - height * t;
      final double leftX = base.dx - (halfBase * (1 - t) + halfTop * t);
      final double rightX = base.dx + (halfBase * (1 - t) + halfTop * t);
      canvas.drawLine(Offset(leftX, y), Offset(rightX, y), slate);
    }

    for (int i = 0; i < rungs; i++) {
      final double t0 = i / rungs;
      final double t1 = (i + 1) / rungs;
      final double y0 = base.dy - height * t0;
      final double y1 = base.dy - height * t1;
      final double leftX0 = base.dx - (halfBase * (1 - t0) + halfTop * t0);
      final double rightX1 = base.dx + (halfBase * (1 - t1) + halfTop * t1);
      canvas.drawLine(Offset(leftX0, y0), Offset(rightX1, y1), slate);
      final double rightX0 = base.dx + (halfBase * (1 - t0) + halfTop * t0);
      final double leftX1 = base.dx - (halfBase * (1 - t1) + halfTop * t1);
      canvas.drawLine(Offset(rightX0, y0), Offset(leftX1, y1), slate);
    }

    final Paint tip = Paint()..color = _vnmTowerBlack;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(base.dx, base.dy - height - 12),
        width: 6,
        height: 30,
      ),
      tip,
    );
  }

  void _paintLamps(Canvas canvas, Offset base, double height) {
    for (int depth = 0; depth <= _vnmMaxDepth; depth++) {
      final Offset lampCenter = _lampCenter(base, height, depth);
      final Paint halo = Paint()
        ..color = _vnmAmber.withValues(alpha: 0.12)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(lampCenter, _vnmLampRadius * 2.2, halo);
      // Secondary teal tint ring — keeps deep teal token in use.
      final Paint tealRing = Paint()
        ..color = _vnmTealDeep.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8;
      canvas.drawCircle(lampCenter, _vnmLampRadius * 1.6, tealRing);
      final Paint bulb = Paint()..color = _vnmAmberDeep;
      canvas.drawCircle(lampCenter, _vnmLampRadius, bulb);
      final Paint rim = Paint()
        ..color = _vnmAmber
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      canvas.drawCircle(lampCenter, _vnmLampRadius, rim);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: 'depth $depth',
          style: TextStyle(
            color: _vnmParchmentShadow,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(lampCenter.dx + _vnmLampRadius + 8, lampCenter.dy - 8),
      );
    }
  }

  Offset _lampCenter(Offset base, double height, int depth) {
    final double t = depth / _vnmMaxDepth;
    return Offset(base.dx, base.dy - height * (1 - t) - 12);
  }

  void _paintPulses(Canvas canvas, Offset base, double height) {
    for (final _VnmPulse pulse in pulses) {
      final Offset center = _lampCenter(base, height, pulse.depth);
      final double age = (elapsed - pulse.start).inMilliseconds /
          _vnmPulseDuration.inMilliseconds;
      final double clamped = clampDouble(age, 0.0, 1.0);
      final double radius = _vnmLampRadius + 80 * clamped;
      final double alpha = (1 - clamped) * 0.85;
      final Color tint = _vnmColourFor(pulse.kind);
      final Paint ring = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..color = tint.withValues(alpha: alpha);
      canvas.drawCircle(center, radius, ring);
      final Paint glow = Paint()
        ..color = tint.withValues(alpha: alpha * 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
      canvas.drawCircle(center, radius * 0.6, glow);
    }
    final _VnmSignalEvent? ev = latest;
    if (ev != null) {
      final Offset center = _lampCenter(base, height, ev.depth);
      final Paint flash = Paint()
        ..color = _vnmAmberBright.withValues(alpha: 0.9);
      canvas.drawCircle(center, _vnmLampRadius * 0.55, flash);
    }
  }

  void _paintLegend(Canvas canvas, Size size) {
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'Lamp fires at notification depth',
        style: TextStyle(
          color: _vnmParchmentShadow,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, const Offset(16, 12));
  }

  @override
  bool shouldRepaint(covariant _VnmTowerPainter oldDelegate) {
    return oldDelegate.elapsed != elapsed ||
        oldDelegate.pulses != pulses ||
        oldDelegate.latest != latest;
  }
}

// ---------------------------------------------------------------------------
// Nested scenario — three NotificationListener layers around three real
// scroll containers. Each listener stamps its own depth-observed value into
// the log so the tower can pulse.
// ---------------------------------------------------------------------------
class _VnmNestedScenario extends StatelessWidget {
  const _VnmNestedScenario({required this.log});

  final _VnmSignalLog log;

  _VnmSignalKind _kindFor(ScrollNotification n) {
    if (n is ScrollStartNotification) {
      return _VnmSignalKind.start;
    }
    if (n is ScrollUpdateNotification) {
      return _VnmSignalKind.update;
    }
    if (n is OverscrollNotification) {
      return _VnmSignalKind.over;
    }
    if (n is UserScrollNotification) {
      return _VnmSignalKind.user;
    }
    if (n is ScrollEndNotification) {
      return _VnmSignalKind.end;
    }
    return _VnmSignalKind.simulated;
  }

  String _axisOf(ScrollNotification n) {
    return n.metrics.axis == Axis.vertical ? 'vertical' : 'horizontal';
  }

  String _directionOf(ScrollNotification n) {
    if (n is ScrollUpdateNotification) {
      final double delta = n.scrollDelta ?? 0;
      if (delta > 0) {
        return 'forward';
      }
      if (delta < 0) {
        return 'reverse';
      }
      return 'idle';
    }
    if (n is UserScrollNotification) {
      return n.direction.toString().split('.').last;
    }
    if (n is ScrollStartNotification) {
      return 'start';
    }
    if (n is ScrollEndNotification) {
      return 'end';
    }
    return 'idle';
  }

  bool _dispatch(ScrollNotification notification) {
    log.ingest(
      kind: _kindFor(notification),
      depth: notification.depth,
      pixels: notification.metrics.pixels,
      axis: _axisOf(notification),
      direction: _directionOf(notification),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _vnmMidnightMid,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _vnmAmber.withValues(alpha: 0.2)),
      ),
      child: NotificationListener<ScrollNotification>(
        onNotification: _dispatch,
        child: _VnmOuterScroller(log: log),
      ),
    );
  }
}

class _VnmOuterScroller extends StatelessWidget {
  const _VnmOuterScroller({required this.log});

  final _VnmSignalLog log;

  @override
  Widget build(BuildContext context) {
    // Cluster G TODO #14 fix: thumbVisibility: true requires an explicit
    // ScrollController; the ambient PrimaryScrollController isn't
    // auto-inherited by ListView on desktop.
    return SizedBox(
      height: 520,
      child: Builder(
        builder: (ctx) {
          final scrollCtrl = ScrollController();
          return Scrollbar(
            controller: scrollCtrl,
            thumbVisibility: true,
            child: ListView.builder(
              controller: scrollCtrl,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 6,
              itemBuilder: (BuildContext context, int section) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  child: _VnmSectionCapsule(section: section, log: log),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _VnmSectionCapsule extends StatelessWidget {
  const _VnmSectionCapsule({
    required this.section,
    required this.log,
  });

  final int section;
  final _VnmSignalLog log;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _vnmMidnightDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _vnmTeal.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _vnmTeal.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Section ${section + 1}',
                  style: const TextStyle(
                    color: _vnmTealBright,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Horizontal lane below is nested — inner depth starts at 0.',
                  style: TextStyle(
                    color: _vnmParchmentShadow,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification n) {
                // Inner listener — we don't forward; outer listener already
                // sees the same notification with an increased depth.
                return false;
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 16,
                itemBuilder: (BuildContext context, int index) {
                  return _VnmTile(
                    section: section,
                    index: index,
                    log: log,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VnmTile extends StatelessWidget {
  const _VnmTile({
    required this.section,
    required this.index,
    required this.log,
  });

  final int section;
  final int index;
  final _VnmSignalLog log;

  @override
  Widget build(BuildContext context) {
    final Color tint = switch ((section + index) % 4) {
      0 => _vnmAmber,
      1 => _vnmTeal,
      2 => _vnmAmberBright,
      _ => _vnmTealBright,
    };
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: _vnmMidnight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.radio, color: tint, size: 22),
          Text(
            'Tile ${section + 1}.${index + 1}',
            style: const TextStyle(
              color: _vnmParchment,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          Text(
            'log size ${log.events.length}',
            style: TextStyle(
              color: tint.withValues(alpha: 0.75),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Filter lab — slider that controls the threshold inside the log. Events
// above the threshold are rejected.
// ---------------------------------------------------------------------------
class _VnmFilterLab extends StatelessWidget {
  const _VnmFilterLab({required this.log});

  final _VnmSignalLog log;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: log,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _vnmMidnightMid,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _vnmTeal.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.tune, color: _vnmTealBright, size: 22),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Accept notifications with depth ≤ threshold',
                      style: TextStyle(
                        color: _vnmParchment,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _vnmTeal.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'threshold ${log.threshold}',
                      style: const TextStyle(
                        color: _vnmTealBright,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: _vnmTealBright,
                  inactiveTrackColor: _vnmMidnightDeep,
                  thumbColor: _vnmAmberBright,
                  overlayColor: _vnmTeal.withValues(alpha: 0.2),
                  valueIndicatorColor: _vnmMidnight,
                  valueIndicatorTextStyle: const TextStyle(
                    color: _vnmParchment,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Slider(
                  value: log.threshold.toDouble(),
                  min: 0,
                  max: _vnmMaxDepth.toDouble(),
                  divisions: _vnmMaxDepth,
                  label: 'depth ≤ ${log.threshold}',
                  onChanged: (double value) =>
                      log.setThreshold(value.round()),
                ),
              ),
              Row(
                children: <Widget>[
                  for (int d = 0; d <= _vnmMaxDepth; d++)
                    Expanded(
                      child: _VnmThresholdBadge(
                        depth: d,
                        active: d <= log.threshold,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  _VnmMetric(
                    label: 'Accepted',
                    value: log.acceptedCount.toString(),
                    tint: _vnmTealBright,
                  ),
                  const SizedBox(width: 12),
                  _VnmMetric(
                    label: 'Rejected',
                    value: log.rejectedCount.toString(),
                    tint: _vnmCrimsonBright,
                  ),
                  const SizedBox(width: 12),
                  _VnmMetric(
                    label: 'Total',
                    value: log.totalCount.toString(),
                    tint: _vnmAmberBright,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: log.clear,
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: _vnmCrimsonBright,
                    ),
                    label: const Text(
                      'Clear log',
                      style: TextStyle(color: _vnmCrimsonBright),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _VnmThresholdBadge extends StatelessWidget {
  const _VnmThresholdBadge({required this.depth, required this.active});

  final int depth;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final Color tint = active ? _vnmTealBright : _vnmParchmentShadow;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: active
              ? _vnmTeal.withValues(alpha: 0.18)
              : _vnmMidnightDeep,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: tint.withValues(alpha: 0.5)),
        ),
        alignment: Alignment.center,
        child: Text(
          'd=$depth',
          style: TextStyle(
            color: tint,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _VnmMetric extends StatelessWidget {
  const _VnmMetric({
    required this.label,
    required this.value,
    required this.tint,
  });

  final String label;
  final String value;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _vnmMidnightDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: tint,
              fontSize: 10,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: _vnmParchment,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Inspector table — last 20 signals, highlighted by accepted/rejected.
// ---------------------------------------------------------------------------
class _VnmInspectorTable extends StatelessWidget {
  const _VnmInspectorTable({required this.log});

  final _VnmSignalLog log;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: log,
      builder: (BuildContext context, Widget? child) {
        final List<_VnmSignalEvent> events = log.events;
        return Container(
          decoration: BoxDecoration(
            color: _vnmMidnightMid,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _vnmAmber.withValues(alpha: 0.25)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              const _VnmInspectorHeader(),
              if (events.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'No signals yet — scroll or press Simulate.',
                    style: TextStyle(
                      color: _vnmParchmentShadow,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else
                Column(
                  children: <Widget>[
                    for (int i = 0; i < events.length; i++)
                      _VnmInspectorRow(
                        event: events[i],
                        zebra: i.isEven,
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _VnmInspectorHeader extends StatelessWidget {
  const _VnmInspectorHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _vnmMidnightDeep,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: const <Widget>[
          SizedBox(width: 40, child: _VnmHeaderCell('id')),
          SizedBox(width: 130, child: _VnmHeaderCell('kind')),
          SizedBox(width: 70, child: _VnmHeaderCell('depth')),
          SizedBox(width: 90, child: _VnmHeaderCell('pixels')),
          SizedBox(width: 90, child: _VnmHeaderCell('axis')),
          SizedBox(width: 100, child: _VnmHeaderCell('direction')),
          Expanded(child: _VnmHeaderCell('received')),
          SizedBox(width: 90, child: _VnmHeaderCell('state')),
        ],
      ),
    );
  }
}

class _VnmHeaderCell extends StatelessWidget {
  const _VnmHeaderCell(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _vnmAmberBright,
        fontWeight: FontWeight.w700,
        fontSize: 11,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _VnmInspectorRow extends StatelessWidget {
  const _VnmInspectorRow({required this.event, required this.zebra});

  final _VnmSignalEvent event;
  final bool zebra;

  @override
  Widget build(BuildContext context) {
    final Color base = zebra ? _vnmMidnightMid : _vnmMidnight;
    final Color textColor =
        event.accepted ? _vnmParchment : _vnmParchmentShadow;
    return Container(
      color: base,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            child: Text(
              '#${event.id}',
              style: TextStyle(
                color: textColor,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: Row(
              children: <Widget>[
                Icon(
                  _vnmIconFor(event.kind),
                  size: 14,
                  color: _vnmColourFor(event.kind),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    _vnmKindLabel(event.kind),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 70,
            child: Row(
              children: <Widget>[
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _vnmAmber.withValues(alpha: 0.2),
                    border: Border.all(
                      color: event.accepted
                          ? _vnmAmberBright
                          : _vnmParchmentShadow,
                    ),
                  ),
                  child: Text(
                    event.depth.toString(),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              event.pixels == null
                  ? '—'
                  : event.pixels!.toStringAsFixed(1),
              style: TextStyle(
                color: textColor,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              event.axis,
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              event.direction,
              style: TextStyle(color: textColor, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              _formatTime(event.receivedAt),
              style: TextStyle(
                color: textColor,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (event.accepted ? _vnmTeal : _vnmCrimson)
                        .withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    event.accepted ? 'kept' : 'drop',
                    style: TextStyle(
                      color: event.accepted
                          ? _vnmTealBright
                          : _vnmCrimsonBright,
                      fontWeight: FontWeight.w700,
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

  String _formatTime(DateTime t) {
    final Duration age = DateTime.now().difference(t);
    final bool fresh = age < _vnmHistoryWindow;
    final String hh = t.hour.toString().padLeft(2, '0');
    final String mm = t.minute.toString().padLeft(2, '0');
    final String ss = t.second.toString().padLeft(2, '0');
    final String ms = t.millisecond.toString().padLeft(3, '0');
    final String stamp = '$hh:$mm:$ss.$ms';
    return fresh ? '$stamp*' : stamp;
  }
}

// ---------------------------------------------------------------------------
// Recipes grid — six cards for the epilogue.
// ---------------------------------------------------------------------------
class _VnmRecipesGrid extends StatelessWidget {
  const _VnmRecipesGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth > 900
            ? 3
            : (constraints.maxWidth > 560 ? 2 : 1);
        final double gap = 16;
        final double width =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: <Widget>[
            for (final _VnmRecipe recipe in _vnmRecipes)
              SizedBox(
                width: width,
                child: _VnmRecipeCard(recipe: recipe),
              ),
          ],
        );
      },
    );
  }
}

class _VnmRecipeCard extends StatelessWidget {
  const _VnmRecipeCard({required this.recipe});

  final _VnmRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _vnmMidnightDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: recipe.tint.withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: recipe.tint.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(recipe.glyph, color: recipe.tint, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            recipe.title,
            style: const TextStyle(
              color: _vnmParchment,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            recipe.body,
            style: const TextStyle(
              color: _vnmParchmentSoft,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer — closing banner.
// ---------------------------------------------------------------------------
class _VnmFooter extends StatelessWidget {
  const _VnmFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _vnmMidnightMid,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _vnmAmber.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.lightbulb_outline,
            color: _vnmAmberBright,
            size: 32,
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Filter ScrollNotifications by depth to decouple outer '
              'listeners from nested scrollables. The mixin makes the '
              'invisible visible — every viewport you bubble through '
              'leaves a trace.',
              style: TextStyle(
                color: _vnmParchment,
                fontSize: 13,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
