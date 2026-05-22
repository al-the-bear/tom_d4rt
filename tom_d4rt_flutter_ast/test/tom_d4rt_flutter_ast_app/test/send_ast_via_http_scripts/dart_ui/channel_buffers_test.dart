// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// D4rt AST deep visual demo for dart:ui ChannelBuffers.
//
// Design plan
// -----------
// ChannelBuffers is a piece of platform-message plumbing in dart:ui. The
// engine pushes inbound messages into per-channel ring buffers; handlers
// drain them later. Because this is invisible infrastructure that never
// renders pixels of its own, this demo presents the machinery
// diagrammatically using plain Material widgets - no real platform calls,
// no async, no Timer, no navigation.
//
// Sections:
//   1. Header banner introducing the subsystem.
//   2. Message lifecycle flow diagram (engine -> ChannelBuffers -> handler).
//   3. Per-channel buffer capacity meters with warning-zone visualisation.
//   4. Resize API decision matrix (when to call resize on a channel).
//   5. Overflow + warning zone narrative with annotated log mock-ups.
//   6. MethodChannel integration recipe cards for plugin authors.
//   7. Glossary, recipes and key takeaways.
//
// The root widget is a StatelessWidget. The widget tree is fully static so
// the AST runner can serialize the build without any side effects.
import 'package:flutter/material.dart';

void main() => runApp(const ChannelBuffersDemoApp());

// ---------------------------------------------------------------------------
// Data records
// ---------------------------------------------------------------------------

class _LifecycleStage {
  const _LifecycleStage({
    required this.ordinal,
    required this.title,
    required this.actor,
    required this.summary,
    required this.icon,
    required this.accent,
  });
  final int ordinal;
  final String title;
  final String actor;
  final String summary;
  final IconData icon;
  final Color accent;
}

class _ChannelState {
  const _ChannelState({
    required this.name,
    required this.capacity,
    required this.pending,
    required this.warningZone,
    required this.note,
  });
  final String name;
  final int capacity;
  final int pending;
  final int warningZone;
  final String note;

  double get fillFraction => capacity == 0 ? 0.0 : pending / capacity;
  bool get inWarningZone => capacity > warningZone;
  bool get isOverflowing => pending > capacity;
}

class _ResizeDecision {
  const _ResizeDecision({
    required this.scenario,
    required this.recommendedCapacity,
    required this.rationale,
    required this.severity,
  });
  final String scenario;
  final int recommendedCapacity;
  final String rationale;
  final int severity; // 1..3
}

class _OverflowEvent {
  const _OverflowEvent({
    required this.tick,
    required this.channel,
    required this.action,
    required this.discarded,
    required this.detail,
  });
  final int tick;
  final String channel;
  final String action;
  final int discarded;
  final String detail;
}

class _RecipeCard {
  const _RecipeCard({
    required this.title,
    required this.audience,
    required this.snippet,
    required this.summary,
  });
  final String title;
  final String audience;
  final String snippet;
  final String summary;
}

class _GlossaryTerm {
  const _GlossaryTerm({
    required this.term,
    required this.definition,
    required this.icon,
  });
  final String term;
  final String definition;
  final IconData icon;
}

// ---------------------------------------------------------------------------
// Static data tables
// ---------------------------------------------------------------------------

const List<_LifecycleStage> _lifecycle = <_LifecycleStage>[
  _LifecycleStage(
    ordinal: 1,
    title: 'Engine emits message',
    actor: 'Flutter engine (C++)',
    summary:
        'Platform produces an inbound binary message for a named channel '
        'and pushes it across the engine/dart boundary.',
    icon: Icons.memory,
    accent: Color(0xFF6750A4),
  ),
  _LifecycleStage(
    ordinal: 2,
    title: 'ChannelBuffers receives',
    actor: 'dart:ui ChannelBuffers',
    summary:
        'The static singleton stores the message in the named channel ring '
        'buffer. If no handler is attached the buffer accumulates until '
        'capacity, then drops the oldest entry.',
    icon: Icons.inbox,
    accent: Color(0xFF7D5260),
  ),
  _LifecycleStage(
    ordinal: 3,
    title: 'Handler attaches',
    actor: 'BinaryMessenger / plugin',
    summary:
        'Once a handler is registered, ChannelBuffers drains any backlog by '
        'invoking the handler for each pending message in arrival order.',
    icon: Icons.cable,
    accent: Color(0xFF386A20),
  ),
  _LifecycleStage(
    ordinal: 4,
    title: 'Handler responds',
    actor: 'Plugin Dart code',
    summary:
        'Handler decodes the payload (typically via a MethodCodec), reacts, '
        'and replies through the reply callback supplied with each message.',
    icon: Icons.reply_all,
    accent: Color(0xFF7E5700),
  ),
  _LifecycleStage(
    ordinal: 5,
    title: 'Reply travels back',
    actor: 'Engine / native code',
    summary:
        'The encoded reply travels back along the same channel, completing '
        'the round trip. New inbound messages may now reuse the slot.',
    icon: Icons.compare_arrows,
    accent: Color(0xFF1E6585),
  ),
];

const List<_ChannelState> _channels = <_ChannelState>[
  _ChannelState(
    name: 'flutter/platform',
    capacity: 1,
    pending: 0,
    warningZone: 100,
    note: 'Default capacity; system messages drain immediately.',
  ),
  _ChannelState(
    name: 'flutter/lifecycle',
    capacity: 1,
    pending: 1,
    warningZone: 100,
    note: 'One pending app-lifecycle event waiting for engine.',
  ),
  _ChannelState(
    name: 'flutter/keyevent',
    capacity: 16,
    pending: 4,
    warningZone: 100,
    note: 'Plugin resized for burst key events from IME.',
  ),
  _ChannelState(
    name: 'flutter/textinput',
    capacity: 32,
    pending: 28,
    warningZone: 100,
    note: 'Near capacity; consider draining sooner or increasing.',
  ),
  _ChannelState(
    name: 'sensors/gyroscope',
    capacity: 250,
    pending: 245,
    warningZone: 100,
    note: 'Sensor stream above warning zone; expect log noise.',
  ),
  _ChannelState(
    name: 'analytics/events',
    capacity: 8,
    pending: 9,
    warningZone: 100,
    note: 'Overflowing - oldest entry is being discarded.',
  ),
];

const List<_ResizeDecision> _resizeDecisions = <_ResizeDecision>[
  _ResizeDecision(
    scenario: 'System control channel (low traffic)',
    recommendedCapacity: 1,
    rationale:
        'Default capacity is sufficient. Messages drain on the very next '
        'frame and any extra slot wastes memory.',
    severity: 1,
  ),
  _ResizeDecision(
    scenario: 'Bursty user input (keyboard, IME)',
    recommendedCapacity: 16,
    rationale:
        'Keystrokes can arrive faster than the Dart isolate drains. Modest '
        'buffer protects against accidental drops without entering the '
        'warning zone.',
    severity: 2,
  ),
  _ResizeDecision(
    scenario: 'High frequency sensor stream',
    recommendedCapacity: 64,
    rationale:
        'Streaming sensors at 60Hz easily backlog a few frames. Stay below '
        '100 to avoid the engine warning log.',
    severity: 2,
  ),
  _ResizeDecision(
    scenario: 'Analytics flush queue (intentional batching)',
    recommendedCapacity: 200,
    rationale:
        'Batch analytics legitimately need backlog. Be aware that capacity '
        'above 100 logs a one-time warning per channel.',
    severity: 3,
  ),
  _ResizeDecision(
    scenario: 'Channel with deterministic single message',
    recommendedCapacity: 1,
    rationale:
        'Use capacity 1 for request/response patterns. Older requests are '
        'overwritten which is usually the correct behaviour.',
    severity: 1,
  ),
];

const List<_OverflowEvent> _overflowTimeline = <_OverflowEvent>[
  _OverflowEvent(
    tick: 0,
    channel: 'analytics/events',
    action: 'enqueue',
    discarded: 0,
    detail: 'event #1 pushed; pending=1 of capacity=8.',
  ),
  _OverflowEvent(
    tick: 1,
    channel: 'analytics/events',
    action: 'enqueue',
    discarded: 0,
    detail: 'event #2 pushed; pending=2 of capacity=8.',
  ),
  _OverflowEvent(
    tick: 6,
    channel: 'analytics/events',
    action: 'enqueue',
    discarded: 0,
    detail: 'event #7 pushed; pending=7 of capacity=8.',
  ),
  _OverflowEvent(
    tick: 7,
    channel: 'analytics/events',
    action: 'enqueue',
    discarded: 0,
    detail: 'event #8 pushed; pending=8 of capacity=8 (full).',
  ),
  _OverflowEvent(
    tick: 8,
    channel: 'analytics/events',
    action: 'overflow',
    discarded: 1,
    detail:
        'event #9 forces discard of event #1; engine logs "Discarding '
        'message on channel analytics/events".',
  ),
  _OverflowEvent(
    tick: 9,
    channel: 'sensors/gyroscope',
    action: 'resize',
    discarded: 0,
    detail:
        'resize(250) crosses warning zone (>100); engine logs "Channel '
        'sensors/gyroscope buffer capacity is 250 which is above warning '
        'limit".',
  ),
  _OverflowEvent(
    tick: 11,
    channel: 'analytics/events',
    action: 'drain',
    discarded: 0,
    detail:
        'handler attached; ChannelBuffers replays 8 pending messages in '
        'arrival order then resumes live delivery.',
  ),
];

const List<_RecipeCard> _recipes = <_RecipeCard>[
  _RecipeCard(
    title: 'Resize a custom channel',
    audience: 'Plugin authors',
    snippet:
        'import \'dart:ui\' as ui;\n'
        '\n'
        '// Call once during plugin initialisation, before handler attaches.\n'
        'ui.channelBuffers.resize(\'my_plugin/events\', 16);',
    summary:
        'Resize before the first message arrives so that the engine sizes '
        'the ring correctly.',
  ),
  _RecipeCard(
    title: 'Attach a handler that drains the backlog',
    audience: 'MethodChannel consumers',
    snippet:
        'const channel = MethodChannel(\'my_plugin/events\');\n'
        'channel.setMethodCallHandler((call) async {\n'
        '  // ChannelBuffers replays any messages queued before this point.\n'
        '  return _dispatch(call);\n'
        '});',
    summary:
        'The first setMethodCallHandler call triggers ChannelBuffers to '
        'flush the backlog in FIFO order.',
  ),
  _RecipeCard(
    title: 'Stay below the warning zone',
    audience: 'Performance-sensitive code',
    snippet:
        '// Avoid: capacity above WARNING_ZONE_SIZE (100) logs a warning.\n'
        'ui.channelBuffers.resize(\'noisy/channel\', 64);',
    summary:
        'Pick the smallest capacity that absorbs your worst-case burst. '
        'Capacities >100 produce a one-time engine warning.',
  ),
  _RecipeCard(
    title: 'Explicit drain or discard',
    audience: 'Advanced consumers',
    snippet:
        '// drain() invokes the callback for every pending message and\n'
        '// removes it from the buffer.\n'
        'await ui.channelBuffers.drain(\n'
        '  \'analytics/events\',\n'
        '  (data, callback) async {\n'
        '    _handle(data);\n'
        '    callback(null);\n'
        '  },\n'
        ');',
    summary:
        'Use drain when you want to process the backlog imperatively '
        'rather than registering a long-lived handler.',
  ),
];

const List<_GlossaryTerm> _glossary = <_GlossaryTerm>[
  _GlossaryTerm(
    term: 'Channel',
    definition:
        'A named string identifier shared by Dart and the host platform. '
        'Examples: flutter/platform, flutter/textinput, my_plugin/events.',
    icon: Icons.cable,
  ),
  _GlossaryTerm(
    term: 'Ring buffer',
    definition:
        'Fixed-capacity FIFO per channel. When full, the oldest entry is '
        'discarded to make room for the newest.',
    icon: Icons.refresh,
  ),
  _GlossaryTerm(
    term: 'Capacity',
    definition:
        'Maximum number of in-flight messages per channel. Default is 1; '
        'resize() adjusts it.',
    icon: Icons.straighten,
  ),
  _GlossaryTerm(
    term: 'Warning zone',
    definition:
        'Internal threshold (kWarningZoneSize == 100). Resizing above this '
        'limit causes the engine to log a one-time warning per channel.',
    icon: Icons.warning_amber,
  ),
  _GlossaryTerm(
    term: 'Drain',
    definition:
        'Process and remove every pending message in order. drain() exits '
        'once the buffer is empty.',
    icon: Icons.water_drop,
  ),
  _GlossaryTerm(
    term: 'Overflow discard',
    definition:
        'Silent removal of the oldest message when a full buffer receives '
        'a new entry. Engine logs the discard once per channel.',
    icon: Icons.delete_sweep,
  ),
  _GlossaryTerm(
    term: 'Handler attach',
    definition:
        'Registering a callback (e.g. via BinaryMessenger or '
        'MethodChannel.setMethodCallHandler) causes ChannelBuffers to '
        'flush the backlog and resume live delivery.',
    icon: Icons.link,
  ),
];

// ---------------------------------------------------------------------------
// Root widget
// ---------------------------------------------------------------------------

class ChannelBuffersDemoApp extends StatelessWidget {
  const ChannelBuffersDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF386A20),
      brightness: Brightness.light,
    );
    final ThemeData theme = ThemeData(colorScheme: scheme, useMaterial3: true);
    print('ChannelBuffers Deep Demo executing');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChannelBuffers Deep Demo',
      theme: theme,
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeaderBanner(scheme: scheme),
              const SizedBox(height: 24.0),
              _SectionTitle(
                scheme: scheme,
                index: 1,
                title: 'Subsystem at a glance',
                subtitle: 'Why ChannelBuffers exists in dart:ui',
              ),
              _IntroPanel(scheme: scheme),
              const SizedBox(height: 32.0),
              _SectionTitle(
                scheme: scheme,
                index: 2,
                title: 'Platform message lifecycle',
                subtitle: 'Engine -> ChannelBuffers -> handler -> reply',
              ),
              _LifecycleDiagram(scheme: scheme, stages: _lifecycle),
              const SizedBox(height: 32.0),
              _SectionTitle(
                scheme: scheme,
                index: 3,
                title: 'Per-channel buffer meters',
                subtitle: 'Capacity, pending depth, warning zone overlay',
              ),
              _CapacityMetersGrid(scheme: scheme, channels: _channels),
              const SizedBox(height: 32.0),
              _SectionTitle(
                scheme: scheme,
                index: 4,
                title: 'When to call resize()',
                subtitle: 'Decision matrix by traffic profile',
              ),
              _ResizeDecisionMatrix(
                scheme: scheme,
                decisions: _resizeDecisions,
              ),
              const SizedBox(height: 32.0),
              _SectionTitle(
                scheme: scheme,
                index: 5,
                title: 'Overflow and warning zone narrative',
                subtitle: 'A simulated timeline of buffer events',
              ),
              _OverflowTimeline(scheme: scheme, events: _overflowTimeline),
              const SizedBox(height: 32.0),
              _SectionTitle(
                scheme: scheme,
                index: 6,
                title: 'MethodChannel integration recipes',
                subtitle: 'Code patterns for plugin authors',
              ),
              _RecipesGrid(scheme: scheme, recipes: _recipes),
              const SizedBox(height: 32.0),
              _SectionTitle(
                scheme: scheme,
                index: 7,
                title: 'Glossary and key takeaways',
                subtitle: 'The vocabulary of ChannelBuffers',
              ),
              _GlossaryPanel(scheme: scheme, terms: _glossary),
              const SizedBox(height: 16.0),
              _TakeawaysPanel(scheme: scheme),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header banner
// ---------------------------------------------------------------------------

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 0: Header banner ===');
    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.secondary,
            scheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 88.0,
            height: 88.0,
            decoration: BoxDecoration(
              color: scheme.onPrimary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: scheme.onPrimary.withValues(alpha: 0.4),
                width: 2.0,
              ),
            ),
            child: Icon(
              Icons.inbox,
              size: 44.0,
              color: scheme.onPrimary,
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'dart:ui ChannelBuffers',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: scheme.onPrimary,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Per-channel ring buffers for inbound platform messages',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: scheme.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 12.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: <Widget>[
                    _HeaderChip(
                      label: 'static singleton',
                      scheme: scheme,
                    ),
                    _HeaderChip(
                      label: 'FIFO ring buffers',
                      scheme: scheme,
                    ),
                    _HeaderChip(
                      label: 'resize / drain',
                      scheme: scheme,
                    ),
                    _HeaderChip(
                      label: 'warning zone: 100',
                      scheme: scheme,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label, required this.scheme});
  final String label;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: scheme.onPrimary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: scheme.onPrimary.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: scheme.onPrimary,
          fontFamily: 'monospace',
          fontSize: 12.0,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section title helper
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.scheme,
    required this.index,
    required this.title,
    required this.subtitle,
  });
  final ColorScheme scheme;
  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    print('=== Section $index: $title ===');
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: scheme.onSurfaceVariant,
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
// Section 1 - Intro panel
// ---------------------------------------------------------------------------

class _IntroPanel extends StatelessWidget {
  const _IntroPanel({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_IntroBullet> bullets = <_IntroBullet>[
      _IntroBullet(
        icon: Icons.api,
        title: 'Sits beneath BinaryMessenger',
        body:
            'ChannelBuffers is the bottom-most layer that holds inbound '
            'binary messages before any Dart handler is ready to consume '
            'them. Higher-level APIs like MethodChannel and EventChannel '
            'are built on top of it.',
        accent: scheme.primary,
        accentContainer: scheme.primaryContainer,
        onAccent: scheme.onPrimaryContainer,
      ),
      _IntroBullet(
        icon: Icons.timer_outlined,
        title: 'Bridges startup ordering',
        body:
            'During app startup, the engine may push messages before any '
            'Dart code has registered a handler. ChannelBuffers absorbs '
            'this race condition by queueing those messages until a handler '
            'attaches.',
        accent: scheme.secondary,
        accentContainer: scheme.secondaryContainer,
        onAccent: scheme.onSecondaryContainer,
      ),
      _IntroBullet(
        icon: Icons.tune,
        title: 'Configurable per channel',
        body:
            'Each channel has its own ring buffer with capacity 1 by '
            'default. Use ui.channelBuffers.resize(name, capacity) to '
            'adjust per-channel behaviour without affecting other channels.',
        accent: scheme.tertiary,
        accentContainer: scheme.tertiaryContainer,
        onAccent: scheme.onTertiaryContainer,
      ),
      _IntroBullet(
        icon: Icons.error_outline,
        title: 'Drops oldest on overflow',
        body:
            'When a full ring buffer receives a new message, the oldest '
            'entry is discarded so the newest is preserved. The engine '
            'logs the discard so plugin authors can diagnose missing '
            'events.',
        accent: scheme.error,
        accentContainer: scheme.errorContainer,
        onAccent: scheme.onErrorContainer,
      ),
    ];

    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: bullets
          .map(
            (_IntroBullet b) => SizedBox(
              width: 340.0,
              child: _IntroBulletCard(bullet: b, scheme: scheme),
            ),
          )
          .toList(),
    );
  }
}

class _IntroBullet {
  const _IntroBullet({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
    required this.accentContainer,
    required this.onAccent,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color accent;
  final Color accentContainer;
  final Color onAccent;
}

class _IntroBulletCard extends StatelessWidget {
  const _IntroBulletCard({required this.bullet, required this.scheme});
  final _IntroBullet bullet;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bullet.accentContainer,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: bullet.accent.withValues(alpha: 0.4),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: bullet.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(bullet.icon, color: bullet.accent, size: 20.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  bullet.title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: bullet.onAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            bullet.body,
            style: TextStyle(
              fontSize: 12.5,
              color: bullet.onAccent.withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 - Lifecycle flow diagram
// ---------------------------------------------------------------------------

class _LifecycleDiagram extends StatelessWidget {
  const _LifecycleDiagram({required this.scheme, required this.stages});
  final ColorScheme scheme;
  final List<_LifecycleStage> stages;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < stages.length; i++) {
      final _LifecycleStage stage = stages[i];
      final bool isLast = i == stages.length - 1;
      rows.add(_LifecycleRow(stage: stage, scheme: scheme, isLast: isLast));
    }
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: scheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.alt_route, color: scheme.primary, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Five-stage flow',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          ...rows,
          const SizedBox(height: 4.0),
          _LifecycleLegend(scheme: scheme),
        ],
      ),
    );
  }
}

class _LifecycleRow extends StatelessWidget {
  const _LifecycleRow({
    required this.stage,
    required this.scheme,
    required this.isLast,
  });
  final _LifecycleStage stage;
  final ColorScheme scheme;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: stage.accent,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: stage.accent.withValues(alpha: 0.35),
                    blurRadius: 6.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(stage.icon, color: Colors.white, size: 24.0),
            ),
            if (!isLast)
              Container(
                width: 3.0,
                height: 56.0,
                color: stage.accent.withValues(alpha: 0.4),
              ),
          ],
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0.0 : 16.0),
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: stage.accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: stage.accent.withValues(alpha: 0.4),
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: stage.accent,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'STEP ${stage.ordinal}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        stage.title,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: stage.accent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: stage.accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'Actor: ${stage.actor}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: stage.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  stage.summary,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: scheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LifecycleLegend extends StatelessWidget {
  const _LifecycleLegend({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.info_outline, color: scheme.secondary, size: 18.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'If steps 3 and 4 happen before step 2 the buffer is empty. '
              'If they happen long after, the buffer may overflow and '
              'discard the oldest entries.',
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onSecondaryContainer,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 - Capacity meters grid
// ---------------------------------------------------------------------------

class _CapacityMetersGrid extends StatelessWidget {
  const _CapacityMetersGrid({required this.scheme, required this.channels});
  final ColorScheme scheme;
  final List<_ChannelState> channels;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: channels
          .map(
            (_ChannelState c) => SizedBox(
              width: 320.0,
              child: _CapacityMeterCard(channel: c, scheme: scheme),
            ),
          )
          .toList(),
    );
  }
}

class _CapacityMeterCard extends StatelessWidget {
  const _CapacityMeterCard({required this.channel, required this.scheme});
  final _ChannelState channel;
  final ColorScheme scheme;

  Color _statusColor(BuildContext context) {
    if (channel.isOverflowing) {
      return scheme.error;
    }
    if (channel.inWarningZone) {
      return scheme.tertiary;
    }
    if (channel.fillFraction >= 0.8) {
      return scheme.secondary;
    }
    return scheme.primary;
  }

  String _statusLabel() {
    if (channel.isOverflowing) {
      return 'OVERFLOWING';
    }
    if (channel.inWarningZone) {
      return 'WARNING ZONE';
    }
    if (channel.fillFraction >= 0.8) {
      return 'NEAR LIMIT';
    }
    if (channel.fillFraction == 0.0) {
      return 'IDLE';
    }
    return 'HEALTHY';
  }

  @override
  Widget build(BuildContext context) {
    final Color color = _statusColor(context);
    final String label = _statusLabel();
    final double meterValue = channel.capacity == 0
        ? 0.0
        : (channel.pending / channel.capacity).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.cable, color: color, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  channel.name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          _CapacityMeter(
            color: color,
            scheme: scheme,
            value: meterValue,
            overflow: channel.isOverflowing,
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                child: _MetricChip(
                  label: 'pending',
                  value: '${channel.pending}',
                  color: color,
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: _MetricChip(
                  label: 'capacity',
                  value: '${channel.capacity}',
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: _MetricChip(
                  label: 'warn @',
                  value: '${channel.warningZone}',
                  color: scheme.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            channel.note,
            style: TextStyle(
              fontSize: 11.5,
              color: scheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _CapacityMeter extends StatelessWidget {
  const _CapacityMeter({
    required this.color,
    required this.scheme,
    required this.value,
    required this.overflow,
  });
  final Color color;
  final ColorScheme scheme;
  final double value;
  final bool overflow;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: 22.0,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          border: Border.all(
            color: scheme.outlineVariant,
            width: 1.0,
          ),
        ),
        child: Stack(
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext _, BoxConstraints constraints) {
                final double width = constraints.maxWidth * value;
                return Container(
                  width: width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        color.withValues(alpha: 0.65),
                        color,
                      ],
                    ),
                  ),
                );
              },
            ),
            if (overflow)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'OVERFLOW',
                    style: TextStyle(
                      color: scheme.onError,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5,
              color: color,
              letterSpacing: 0.4,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 - Resize decision matrix
// ---------------------------------------------------------------------------

class _ResizeDecisionMatrix extends StatelessWidget {
  const _ResizeDecisionMatrix({
    required this.scheme,
    required this.decisions,
  });
  final ColorScheme scheme;
  final List<_ResizeDecision> decisions;

  Color _severityColor(int s) {
    if (s == 1) {
      return scheme.primary;
    }
    if (s == 2) {
      return scheme.secondary;
    }
    return scheme.tertiary;
  }

  String _severityLabel(int s) {
    if (s == 1) {
      return 'Safe';
    }
    if (s == 2) {
      return 'Mind the gap';
    }
    return 'Above warning zone';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _MatrixHeader(scheme: scheme),
          const SizedBox(height: 10.0),
          ...List<Widget>.generate(decisions.length, (int i) {
            final _ResizeDecision d = decisions[i];
            return _MatrixRow(
              decision: d,
              scheme: scheme,
              accent: _severityColor(d.severity),
              severityLabel: _severityLabel(d.severity),
              alternate: i.isOdd,
            );
          }),
        ],
      ),
    );
  }
}

class _MatrixHeader extends StatelessWidget {
  const _MatrixHeader({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Scenario',
              style: TextStyle(
                color: scheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Capacity',
              style: TextStyle(
                color: scheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'Rationale',
              style: TextStyle(
                color: scheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Severity',
              style: TextStyle(
                color: scheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({
    required this.decision,
    required this.scheme,
    required this.accent,
    required this.severityLabel,
    required this.alternate,
  });
  final _ResizeDecision decision;
  final ColorScheme scheme;
  final Color accent;
  final String severityLabel;
  final bool alternate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: alternate
            ? scheme.surfaceContainerHighest
            : scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: accent.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              decision.scenario,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 3.0,
              ),
              margin: const EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '${decision.recommendedCapacity}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: accent,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                decision.rationale,
                style: TextStyle(
                  fontSize: 11.5,
                  color: scheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                severityLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 - Overflow timeline
// ---------------------------------------------------------------------------

class _OverflowTimeline extends StatelessWidget {
  const _OverflowTimeline({required this.scheme, required this.events});
  final ColorScheme scheme;
  final List<_OverflowEvent> events;

  Color _actionColor(String action) {
    if (action == 'enqueue') {
      return scheme.primary;
    }
    if (action == 'overflow') {
      return scheme.error;
    }
    if (action == 'resize') {
      return scheme.tertiary;
    }
    if (action == 'drain') {
      return scheme.secondary;
    }
    return scheme.outline;
  }

  IconData _actionIcon(String action) {
    if (action == 'enqueue') {
      return Icons.arrow_downward;
    }
    if (action == 'overflow') {
      return Icons.error;
    }
    if (action == 'resize') {
      return Icons.straighten;
    }
    if (action == 'drain') {
      return Icons.water_drop;
    }
    return Icons.circle;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> entries = <Widget>[];
    for (int i = 0; i < events.length; i++) {
      final _OverflowEvent ev = events[i];
      final Color color = _actionColor(ev.action);
      final IconData icon = _actionIcon(ev.action);
      entries.add(
        _OverflowRow(
          event: ev,
          scheme: scheme,
          color: color,
          icon: icon,
          isLast: i == events.length - 1,
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.timeline, color: scheme.primary, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Simulated buffer log',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
              const Spacer(),
              Text(
                'tick',
                style: TextStyle(
                  fontSize: 12.0,
                  color: scheme.onSurfaceVariant,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          ...entries,
          const SizedBox(height: 8.0),
          _LogConsole(scheme: scheme),
        ],
      ),
    );
  }
}

class _OverflowRow extends StatelessWidget {
  const _OverflowRow({
    required this.event,
    required this.scheme,
    required this.color,
    required this.icon,
    required this.isLast,
  });
  final _OverflowEvent event;
  final ColorScheme scheme;
  final Color color;
  final IconData icon;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: color, size: 18.0),
            ),
            if (!isLast)
              Container(
                width: 2.0,
                height: 36.0,
                color: color.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: 12.0),
        Container(
          width: 44.0,
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          alignment: Alignment.center,
          child: Text(
            't=${event.tick}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0.0 : 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: color.withValues(alpha: 0.35),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        event.action.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      event.channel,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: scheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    if (event.discarded > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.errorContainer,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'discarded x${event.discarded}',
                          style: TextStyle(
                            color: scheme.onErrorContainer,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  event.detail,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: scheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LogConsole extends StatelessWidget {
  const _LogConsole({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.terminal,
                color: Colors.greenAccent.shade400,
                size: 16.0,
              ),
              const SizedBox(width: 6.0),
              Text(
                'engine.log (mock)',
                style: TextStyle(
                  color: Colors.greenAccent.shade400,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text(
            'W/flutter: Discarding message on channel analytics/events. '
            'Channel buffer is full (capacity = 8).\n'
            'W/flutter: Channel sensors/gyroscope buffer capacity is 250 '
            'which is above the warning limit (100).\n'
            'I/flutter: ChannelBuffers: flushed 8 backlog messages for '
            'analytics/events after handler attach.',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 - Recipes grid
// ---------------------------------------------------------------------------

class _RecipesGrid extends StatelessWidget {
  const _RecipesGrid({required this.scheme, required this.recipes});
  final ColorScheme scheme;
  final List<_RecipeCard> recipes;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: recipes
          .map(
            (_RecipeCard r) => SizedBox(
              width: 360.0,
              child: _RecipeTile(recipe: r, scheme: scheme),
            ),
          )
          .toList(),
    );
  }
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile({required this.recipe, required this.scheme});
  final _RecipeCard recipe;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: scheme.primary, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  recipe.title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'audience: ${recipe.audience}',
              style: TextStyle(
                fontSize: 11.0,
                color: scheme.onSecondaryContainer,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B1B),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              recipe.snippet,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Colors.greenAccent.shade100,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            recipe.summary,
            style: TextStyle(
              fontSize: 12.0,
              color: scheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 - Glossary + takeaways
// ---------------------------------------------------------------------------

class _GlossaryPanel extends StatelessWidget {
  const _GlossaryPanel({required this.scheme, required this.terms});
  final ColorScheme scheme;
  final List<_GlossaryTerm> terms;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: scheme.tertiary.withValues(alpha: 0.45),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: scheme.tertiary, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Glossary',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          ...terms.map(
            (_GlossaryTerm t) => _GlossaryRow(term: t, scheme: scheme),
          ),
        ],
      ),
    );
  }
}

class _GlossaryRow extends StatelessWidget {
  const _GlossaryRow({required this.term, required this.scheme});
  final _GlossaryTerm term;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: scheme.tertiary.withValues(alpha: 0.25),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: scheme.tertiary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(term.icon, color: scheme.tertiary, size: 18.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  term.term,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  term.definition,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: scheme.onSurfaceVariant,
                    height: 1.4,
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

class _TakeawaysPanel extends StatelessWidget {
  const _TakeawaysPanel({required this.scheme});
  final ColorScheme scheme;

  static const List<_Takeaway> _items = <_Takeaway>[
    _Takeaway(
      icon: Icons.bolt,
      title: 'Default capacity is 1',
      body:
          'Every channel starts with a one-slot ring. Bump it only when '
          'you measurably need to absorb bursts.',
    ),
    _Takeaway(
      icon: Icons.warning_amber,
      title: 'Stay below 100',
      body:
          'The warning zone is a hard-coded 100. Capacities at or above '
          'trigger a one-time engine log per channel.',
    ),
    _Takeaway(
      icon: Icons.delete_sweep,
      title: 'Overflow drops oldest',
      body:
          'Full buffers do not block; they silently discard the oldest '
          'entry. Treat discards as data loss for analytics-style channels.',
    ),
    _Takeaway(
      icon: Icons.link,
      title: 'Handler attach drains',
      body:
          'Register the handler before sending replies. The first attach '
          'replays everything queued since startup in FIFO order.',
    ),
    _Takeaway(
      icon: Icons.science,
      title: 'No async / no Timer in this demo',
      body:
          'Everything shown is conceptual. The AST runner executes a static '
          'snapshot, so no real platform messages are exchanged.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primaryContainer,
            scheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.4),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.bookmark, color: scheme.primary, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Key takeaways',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          ..._items.map((_Takeaway t) => _TakeawayRow(item: t, scheme: scheme)),
        ],
      ),
    );
  }
}

class _Takeaway {
  const _Takeaway({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;
}

class _TakeawayRow extends StatelessWidget {
  const _TakeawayRow({required this.item, required this.scheme});
  final _Takeaway item;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.25),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: scheme.primary, size: 18.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  item.body,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: scheme.onSurfaceVariant,
                    height: 1.4,
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
