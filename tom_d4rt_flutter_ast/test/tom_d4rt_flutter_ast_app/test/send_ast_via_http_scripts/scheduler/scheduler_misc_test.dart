// ignore_for_file: avoid_print, sort_child_properties_last, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// =============================================================================
// SchedulerBinding & Friends — Static Visual Tour
// =============================================================================
//
// This file is a static, hand-authored Flutter demo describing the scheduler
// subsystem found in `package:flutter/scheduler.dart`. It is rendered once,
// returns a single MaterialApp, and never starts a Ticker, never schedules a
// real frame callback, and never blocks a frame.
//
// We illustrate, in pictures and prose:
//   - The frame anatomy and the SchedulerPhase enum.
//   - The Priority class and how scheduleTask uses it.
//   - The Ticker / TickerProvider relationship.
//   - FrameTiming members and their meaning.
//   - timeDilation and what it scales.
//   - addPostFrameCallback vs addPersistentFrameCallback.
//   - AppLifecycleState transitions.
//   - Real-world use cases and pitfalls.
//   - A static "FPS overlay" mockup.
//
// All helper widgets and value-objects are private (prefixed with `_`).
// =============================================================================

dynamic build(BuildContext context) {
  print('scheduler_misc_test: building static demo');

  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Scheduler — Visual Reference',
    home: _SchedulerDemoScaffold(),
  );
}

// =============================================================================
// Color & Style Tokens
// =============================================================================

class _Tokens {
  // Background & ink
  static const Color bg = Color(0xFF0B1020);
  static const Color bgAlt = Color(0xFF111A33);
  static const Color ink = Color(0xFFE8ECF7);
  static const Color inkSoft = Color(0xFFB7C0D9);
  static const Color inkMuted = Color(0xFF6E7AA0);

  // Accents — six "phase" colors used for frame anatomy + many cards
  static const Color phaseIdle = Color(0xFF394168);
  static const Color phaseBegin = Color(0xFF4DA8DA);
  static const Color phaseTransient = Color(0xFFFFB454);
  static const Color phaseMicro = Color(0xFFEC6B6B);
  static const Color phasePersistent = Color(0xFF7DD181);
  static const Color phasePost = Color(0xFFB78AFF);
  static const Color phaseDraw = Color(0xFF4ECDC4);

  // Priority palette
  static const Color prioIdle = Color(0xFF5C6790);
  static const Color prioAnim = Color(0xFFFFB454);
  static const Color prioTouch = Color(0xFFEC6B6B);
  static const Color prioBumped = Color(0xFFFF8AB5);

  // Lifecycle palette
  static const Color lifeResumed = Color(0xFF7DD181);
  static const Color lifeInactive = Color(0xFFFFD166);
  static const Color lifePaused = Color(0xFFFFB454);
  static const Color lifeHidden = Color(0xFF8895C8);
  static const Color lifeDetached = Color(0xFFEC6B6B);
}

// =============================================================================
// Top-level scaffold
// =============================================================================

class _SchedulerDemoScaffold extends StatelessWidget {
  const _SchedulerDemoScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Tokens.bg,
      body: const _PageBody(),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Hero(),
          const SizedBox(height: 32),
          _section(
            title: '01  Frame Anatomy',
            subtitle: '16.6 ms at 60 Hz, sliced by SchedulerPhase',
            child: const _FrameAnatomySection(),
          ),
          _section(
            title: '02  SchedulerPhase Enum',
            subtitle: 'The five values of SchedulerPhase',
            child: const _SchedulerPhaseSection(),
          ),
          _section(
            title: '03  Priority Class',
            subtitle: 'Static integer constants used by scheduleTask()',
            child: const _PrioritySection(),
          ),
          _section(
            title: '04  AppLifecycleState',
            subtitle: 'Five states observed by SchedulerBinding.lifecycleState',
            child: const _LifecycleSection(),
          ),
          _section(
            title: '05  Ticker Anatomy',
            subtitle: 'A pulse-source driven by the SchedulerBinding',
            child: const _TickerSection(),
          ),
          _section(
            title: '06  FrameTiming Members',
            subtitle: 'Per-frame timestamps captured by the engine',
            child: const _FrameTimingSection(),
          ),
          _section(
            title: '07  timeDilation',
            subtitle: 'A global multiplier applied to all Tickers',
            child: const _TimeDilationSection(),
          ),
          _section(
            title: '08  Post-Frame vs Persistent Frame',
            subtitle: 'Two flavours of "do this with a frame"',
            child: const _PostVsPersistentSection(),
          ),
          _section(
            title: '09  Real-world Use Cases',
            subtitle: 'What SchedulerBinding actually pays the rent doing',
            child: const _UseCasesSection(),
          ),
          _section(
            title: '10  Pitfalls',
            subtitle: 'Painful lessons codified',
            child: const _PitfallsSection(),
          ),
          _section(
            title: '11  FPS Overlay (mock)',
            subtitle: 'A static rendering of a typical performance HUD',
            child: const _FpsOverlaySection(),
          ),
          _section(
            title: '12  scheduleTask Lane Diagram',
            subtitle: 'Idle/Animation/Touch/Touch+1 priority lanes',
            child: const _PriorityLaneSection(),
          ),
          const SizedBox(height: 48),
          const _FooterStrip(),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  Widget _section({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: title, subtitle: subtitle),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// Hero
// =============================================================================

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1B2547),
            Color(0xFF0F1733),
            Color(0xFF1A1240),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.55),
            blurRadius: 32,
            offset: const Offset(0, 18),
          ),
          BoxShadow(
            color: _Tokens.phasePost.withValues(alpha: 0.2),
            blurRadius: 60,
            offset: const Offset(-20, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _Clockwork(size: 168),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Pill(
                  text: 'package:flutter/scheduler.dart',
                  color: _Tokens.phaseTransient,
                ),
                SizedBox(height: 12),
                Text(
                  'Scheduler',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w800,
                    color: _Tokens.ink,
                    height: 1.0,
                    letterSpacing: -1.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'How Flutter decides what to do, and when.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: _Tokens.inkSoft,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 14),
                _BulletRow(text: 'SchedulerBinding orchestrates frames.'),
                _BulletRow(text: 'Tickers pulse on every frame.'),
                _BulletRow(text: 'Priority queues defer work to idle.'),
                _BulletRow(text: 'FrameTiming is your forensic toolkit.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final String text;
  const _BulletRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: _Tokens.phasePost,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: _Tokens.inkSoft,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Clockwork extends StatelessWidget {
  final double size;
  const _Clockwork({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer rim
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const SweepGradient(
                colors: [
                  _Tokens.phaseTransient,
                  _Tokens.phaseMicro,
                  _Tokens.phasePersistent,
                  _Tokens.phasePost,
                  _Tokens.phaseBegin,
                  _Tokens.phaseTransient,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: _Tokens.phasePost.withValues(alpha: 0.4),
                  blurRadius: 28,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
          // Mid ring
          Container(
            width: size * 0.78,
            height: size * 0.78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _Tokens.bgAlt,
              border: Border.all(
                color: _Tokens.phaseTransient.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
          ),
          // Inner gear
          Container(
            width: size * 0.55,
            height: size * 0.55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [
                  Color(0xFF252F58),
                  Color(0xFF101630),
                ],
              ),
              border: Border.all(
                color: _Tokens.phasePost.withValues(alpha: 0.7),
                width: 1.4,
              ),
            ),
          ),
          // Hands
          Container(
            width: 4,
            height: size * 0.36,
            margin: EdgeInsets.only(bottom: size * 0.12),
            decoration: BoxDecoration(
              color: _Tokens.ink,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: 3,
            height: size * 0.26,
            margin: EdgeInsets.only(left: size * 0.16),
            decoration: BoxDecoration(
              color: _Tokens.phaseTransient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Hub
          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _Tokens.phasePost,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color color;
  const _Pill({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontFamily: 'monospace',
          letterSpacing: 0.4,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =============================================================================
// Section header
// =============================================================================

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _Tokens.ink,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: _Tokens.inkMuted,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: 64,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_Tokens.phaseTransient, _Tokens.phasePost],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// 01  Frame Anatomy
// =============================================================================

class _FramePhase {
  final String name;
  final String desc;
  final int flex;
  final Color color;
  const _FramePhase(this.name, this.desc, this.flex, this.color);
}

class _FrameAnatomySection extends StatelessWidget {
  const _FrameAnatomySection();

  @override
  Widget build(BuildContext context) {
    const phases = <_FramePhase>[
      _FramePhase(
        'handleBeginFrame',
        'engine wakes us at vsync',
        2,
        _Tokens.phaseBegin,
      ),
      _FramePhase(
        'transientCallbacks',
        'animations advance, Tickers tick',
        4,
        _Tokens.phaseTransient,
      ),
      _FramePhase(
        'midFrameMicrotasks',
        'queued microtasks drained',
        2,
        _Tokens.phaseMicro,
      ),
      _FramePhase(
        'persistentCallbacks',
        'rendering pipeline (build, layout, paint)',
        7,
        _Tokens.phasePersistent,
      ),
      _FramePhase(
        'postFrameCallbacks',
        'one-shot callbacks for "after this frame"',
        2,
        _Tokens.phasePost,
      ),
      _FramePhase(
        'handleDrawFrame',
        'scene handed back to the engine',
        1,
        _Tokens.phaseDraw,
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Text(
                '|',
                style: TextStyle(color: _Tokens.inkMuted, fontFamily: 'monospace'),
              ),
              SizedBox(width: 6),
              Text(
                '0 ms',
                style: TextStyle(color: _Tokens.inkMuted, fontFamily: 'monospace'),
              ),
              Spacer(),
              Text(
                '16.6 ms (60 Hz budget)',
                style: TextStyle(color: _Tokens.inkMuted, fontFamily: 'monospace'),
              ),
              SizedBox(width: 6),
              Text(
                '|',
                style: TextStyle(color: _Tokens.inkMuted, fontFamily: 'monospace'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _Tokens.inkMuted.withValues(alpha: 0.4),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                for (final p in phases)
                  Expanded(
                    flex: p.flex,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            p.color.withValues(alpha: 0.85),
                            p.color.withValues(alpha: 0.55),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        border: Border(
                          right: BorderSide(
                            color: _Tokens.bg.withValues(alpha: 0.6),
                            width: 1,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          p.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 11,
                            color: _Tokens.bg,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              for (final p in phases)
                _LegendChip(
                  color: p.color,
                  label: p.name,
                  desc: p.desc,
                ),
            ],
          ),
          const SizedBox(height: 16),
          const _NoteParagraph(
            text:
                'A single frame at 60 Hz must complete inside ~16.6 ms; at 120 Hz '
                'inside ~8.3 ms. SchedulerBinding walks each phase in order, then '
                'resumes the SchedulerPhase.idle baseline until the next vsync.',
          ),
        ],
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  final Color color;
  final String label;
  final String desc;
  const _LegendChip({
    required this.color,
    required this.label,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            desc,
            style: const TextStyle(
              color: _Tokens.inkSoft,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 02  SchedulerPhase
// =============================================================================

class _PhaseInfo {
  final SchedulerPhase phase;
  final String name;
  final String summary;
  final String detail;
  final Color color;
  const _PhaseInfo({
    required this.phase,
    required this.name,
    required this.summary,
    required this.detail,
    required this.color,
  });
}

class _SchedulerPhaseSection extends StatelessWidget {
  const _SchedulerPhaseSection();

  @override
  Widget build(BuildContext context) {
    const phases = <_PhaseInfo>[
      _PhaseInfo(
        phase: SchedulerPhase.idle,
        name: 'idle',
        summary: 'No frame in flight',
        detail:
            'The default state between frames. Microtasks and idle-priority tasks '
            'run here; this is where most app code observes the binding.',
        color: _Tokens.phaseIdle,
      ),
      _PhaseInfo(
        phase: SchedulerPhase.transientCallbacks,
        name: 'transientCallbacks',
        summary: 'Animations & Tickers',
        detail:
            'Frame just started. Active Tickers fire here, animations advance. '
            'Code in this phase should be cheap — long work blocks the frame.',
        color: _Tokens.phaseTransient,
      ),
      _PhaseInfo(
        phase: SchedulerPhase.midFrameMicrotasks,
        name: 'midFrameMicrotasks',
        summary: 'Drain queued microtasks',
        detail:
            'Microtasks queued by transient callbacks run here, before any '
            'rendering work begins.',
        color: _Tokens.phaseMicro,
      ),
      _PhaseInfo(
        phase: SchedulerPhase.persistentCallbacks,
        name: 'persistentCallbacks',
        summary: 'build → layout → paint',
        detail:
            'The rendering pipeline runs as a persistent callback registered by '
            'WidgetsBinding. Most of your frame budget is spent here.',
        color: _Tokens.phasePersistent,
      ),
      _PhaseInfo(
        phase: SchedulerPhase.postFrameCallbacks,
        name: 'postFrameCallbacks',
        summary: 'One-shot "after this frame"',
        detail:
            'Callbacks registered with addPostFrameCallback fire once each, '
            'then the queue empties. Ideal for "now that layout is done…" work.',
        color: _Tokens.phasePost,
      ),
    ];

    return _Card(
      child: Column(
        children: [
          for (var i = 0; i < phases.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == phases.length - 1 ? 0 : 12),
              child: _PhaseCard(info: phases[i]),
            ),
        ],
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  final _PhaseInfo info;
  const _PhaseCard({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            info.color.withValues(alpha: 0.18),
            info.color.withValues(alpha: 0.04),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: info.color.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: info.color.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: info.color.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: info.color.withValues(alpha: 0.6)),
            ),
            child: Text(
              '${info.phase.index}',
              style: TextStyle(
                color: info.color,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'SchedulerPhase.${info.name}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        color: _Tokens.ink,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _Pill(text: info.summary, color: info.color),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  info.detail,
                  style: const TextStyle(
                    color: _Tokens.inkSoft,
                    fontSize: 13,
                    height: 1.35,
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

// =============================================================================
// 03  Priority
// =============================================================================

class _PriorityCard {
  final String name;
  final int value;
  final String desc;
  final Color color;
  const _PriorityCard({
    required this.name,
    required this.value,
    required this.desc,
    required this.color,
  });
}

class _PrioritySection extends StatelessWidget {
  const _PrioritySection();

  @override
  Widget build(BuildContext context) {
    final cards = <_PriorityCard>[
      _PriorityCard(
        name: 'Priority.idle',
        value: Priority.idle.value,
        desc:
            'Lowest scheduling priority. scheduleTask() runs only when the '
            'system is otherwise idle.',
        color: _Tokens.prioIdle,
      ),
      _PriorityCard(
        name: 'Priority.animation',
        value: Priority.animation.value,
        desc:
            'Used internally by the scheduler for animation work. Higher than '
            'idle, lower than touch.',
        color: _Tokens.prioAnim,
      ),
      _PriorityCard(
        name: 'Priority.touch',
        value: Priority.touch.value,
        desc:
            'Highest standard priority. Reserved for processing user input so '
            'taps stay responsive.',
        color: _Tokens.prioTouch,
      ),
      _PriorityCard(
        name: 'Priority.touch + 1',
        value: Priority.touch.value + 1,
        desc:
            'You can bump above touch by adding to the value — useful for code '
            'that must run before any other touch work.',
        color: _Tokens.prioBumped,
      ),
    ];

    return Column(
      children: [
        _Card(
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.4,
            children: [
              for (final p in cards) _PriorityChipCard(card: p),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _Card(
          child: const _CodeBlock(
            lines: [
              '// scheduleTask runs when the binding is idle.',
              'SchedulerBinding.instance.scheduleTask(',
              '  () => buildSearchIndex(),',
              '  Priority.idle,',
              ');',
              '',
              '// Bump above touch when something must precede input handling:',
              'SchedulerBinding.instance.scheduleTask(',
              '  () => preflightCheck(),',
              '  Priority(Priority.touch.value + 1),',
              ');',
            ],
          ),
        ),
      ],
    );
  }
}

class _PriorityChipCard extends StatelessWidget {
  final _PriorityCard card;
  const _PriorityChipCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            card.color.withValues(alpha: 0.22),
            card.color.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: card.color.withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(
            color: card.color.withValues(alpha: 0.16),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card.name,
                style: TextStyle(
                  color: card.color,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _Tokens.bg.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${card.value}',
                  style: const TextStyle(
                    color: _Tokens.ink,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              card.desc,
              style: const TextStyle(
                color: _Tokens.inkSoft,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 04  AppLifecycleState
// =============================================================================

class _LifecycleStep {
  final String name;
  final String summary;
  final Color color;
  const _LifecycleStep(this.name, this.summary, this.color);
}

class _LifecycleSection extends StatelessWidget {
  const _LifecycleSection();

  @override
  Widget build(BuildContext context) {
    const steps = <_LifecycleStep>[
      _LifecycleStep('resumed', 'visible & responsive', _Tokens.lifeResumed),
      _LifecycleStep('inactive', 'visible, losing focus', _Tokens.lifeInactive),
      _LifecycleStep('hidden', 'fully obscured', _Tokens.lifeHidden),
      _LifecycleStep('paused', 'background, no UI', _Tokens.lifePaused),
      _LifecycleStep('detached', 'engine running, no view', _Tokens.lifeDetached),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < steps.length; i++) ...[
                Expanded(child: _LifecycleNode(step: steps[i])),
                if (i < steps.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.arrow_right_alt,
                      color: _Tokens.inkMuted,
                    ),
                  ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          const _NoteParagraph(
            text:
                'SchedulerBinding.instance.lifecycleState reports the current '
                'AppLifecycleState. Mixin WidgetsBindingObserver and override '
                'didChangeAppLifecycleState to react to transitions. The exact '
                'order is platform-dependent — never assume e.g. paused always '
                'follows hidden.',
          ),
        ],
      ),
    );
  }
}

class _LifecycleNode extends StatelessWidget {
  final _LifecycleStep step;
  const _LifecycleNode({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            step.color.withValues(alpha: 0.2),
            step.color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: step.color.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: step.color.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.name,
            style: TextStyle(
              color: step.color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            step.summary,
            style: const TextStyle(
              color: _Tokens.inkSoft,
              fontSize: 11,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 05  Ticker anatomy
// =============================================================================

class _TickerSection extends StatelessWidget {
  const _TickerSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: _TickerDiagram(),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _LabelRow(
                      label: 'onTick(elapsed)',
                      desc:
                          'Called once per frame while running. The Duration is '
                          'measured from the moment Ticker.start() was issued.',
                    ),
                    SizedBox(height: 10),
                    _LabelRow(
                      label: 'start() / stop()',
                      desc:
                          'start returns a TickerFuture that completes when stop is '
                          'called. Calling start while running is a no-op.',
                    ),
                    SizedBox(height: 10),
                    _LabelRow(
                      label: 'muted',
                      desc:
                          'When true, onTick is skipped but the Ticker is still '
                          'considered active. Useful while a parent is offscreen.',
                    ),
                    SizedBox(height: 10),
                    _LabelRow(
                      label: 'dispose()',
                      desc:
                          'Mandatory before drop. A Ticker that outlives its '
                          'TickerProvider is the canonical source of memory leaks.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _CodeBlock(
            lines: [
              'class _MyState extends State<MyWidget>',
              '    with SingleTickerProviderStateMixin {',
              '  late final Ticker _ticker;',
              '',
              '  @override',
              '  void initState() {',
              '    super.initState();',
              '    _ticker = createTicker((elapsed) {',
              '      // do per-frame work; keep it cheap',
              '    })..start();',
              '  }',
              '',
              '  @override',
              '  void dispose() {',
              '    _ticker.dispose();',
              '    super.dispose();',
              '  }',
              '}',
            ],
          ),
        ],
      ),
    );
  }
}

class _TickerDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF161E3D),
            Color(0xFF0E142A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Tokens.phaseTransient.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          _DiagramBlock(
            label: 'TickerProvider',
            color: _Tokens.phasePost,
            description: '(SingleTicker / TickerProviderStateMixin)',
          ),
          const _DiagramArrow(label: 'createTicker(onTick)'),
          _DiagramBlock(
            label: 'Ticker',
            color: _Tokens.phaseTransient,
            description: 'start() · stop() · muted · dispose()',
          ),
          const _DiagramArrow(label: 'fires in transientCallbacks'),
          _DiagramBlock(
            label: 'onTick(Duration elapsed)',
            color: _Tokens.phasePersistent,
            description: 'your per-frame callback',
          ),
        ],
      ),
    );
  }
}

class _DiagramBlock extends StatelessWidget {
  final String label;
  final String description;
  final Color color;
  const _DiagramBlock({
    required this.label,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.28),
            color.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: const TextStyle(
              color: _Tokens.inkSoft,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagramArrow extends StatelessWidget {
  final String label;
  const _DiagramArrow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Icon(
              Icons.south,
              color: _Tokens.inkMuted,
              size: 18,
            ),
          ),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _Tokens.inkMuted,
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelRow extends StatelessWidget {
  final String label;
  final String desc;
  const _LabelRow({required this.label, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
            color: _Tokens.phaseTransient,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _Tokens.ink,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  color: _Tokens.inkSoft,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// 06  FrameTiming
// =============================================================================

class _FrameTimingSection extends StatelessWidget {
  const _FrameTimingSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Note(
            text:
                'FrameTiming is the immutable record of one frame, delivered via '
                'SchedulerBinding.instance.addTimingsCallback. Each member is a '
                'monotonic timestamp in microseconds.',
          ),
          const SizedBox(height: 16),
          _FrameTimingTimeline(),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              _LegendChip(
                color: _Tokens.phaseBegin,
                label: 'vsyncStart',
                desc: 'engine vsync',
              ),
              _LegendChip(
                color: _Tokens.phaseTransient,
                label: 'buildStart',
                desc: 'UI thread starts work',
              ),
              _LegendChip(
                color: _Tokens.phasePersistent,
                label: 'buildFinish',
                desc: 'layout/paint complete',
              ),
              _LegendChip(
                color: _Tokens.phasePost,
                label: 'rasterStart',
                desc: 'GPU thread begins',
              ),
              _LegendChip(
                color: _Tokens.phaseDraw,
                label: 'rasterFinish',
                desc: 'pixels handed to swapchain',
              ),
              _LegendChip(
                color: _Tokens.phaseMicro,
                label: 'frameNumber',
                desc: 'monotonic frame id',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FrameTimingTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stops = const [
      _TimelineStop('vsyncStart', 0.04, _Tokens.phaseBegin),
      _TimelineStop('buildStart', 0.18, _Tokens.phaseTransient),
      _TimelineStop('buildFinish', 0.5, _Tokens.phasePersistent),
      _TimelineStop('rasterStart', 0.55, _Tokens.phasePost),
      _TimelineStop('rasterFinish', 0.94, _Tokens.phaseDraw),
    ];

    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _Tokens.bgAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Tokens.inkMuted.withValues(alpha: 0.3)),
      ),
      child: LayoutBuilder(
        builder: (ctx, c) {
          final w = c.maxWidth;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Baseline
              Positioned(
                left: 0,
                right: 0,
                top: 50,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        _Tokens.phaseBegin,
                        _Tokens.phaseTransient,
                        _Tokens.phasePersistent,
                        _Tokens.phasePost,
                        _Tokens.phaseDraw,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              for (final s in stops)
                Positioned(
                  left: (w * s.fraction) - 2,
                  top: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.label,
                        style: TextStyle(
                          color: s.color,
                          fontSize: 10,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: 2,
                        height: 64,
                        color: s.color,
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
}

class _TimelineStop {
  final String label;
  final double fraction;
  final Color color;
  const _TimelineStop(this.label, this.fraction, this.color);
}

// =============================================================================
// 07  timeDilation
// =============================================================================

class _TimeDilationSection extends StatelessWidget {
  const _TimeDilationSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _NoteParagraph(
            text:
                'timeDilation is a global double in package:flutter/scheduler.dart '
                'that multiplies the Duration each Ticker reports. Setting it to '
                '4.0 makes animations feel four times slower; 0.25 makes them four '
                'times faster. It does not affect Future.delayed or Timer — only '
                'Ticker-driven work.',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _DilationLane(
                  label: '0.25× (fast)',
                  color: _Tokens.phaseDraw,
                  ticks: 8,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DilationLane(
                  label: '1.0× (default)',
                  color: _Tokens.phaseTransient,
                  ticks: 4,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DilationLane(
                  label: '4.0× (slow-mo)',
                  color: _Tokens.phasePost,
                  ticks: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _CodeBlock(
            lines: [
              "import 'package:flutter/scheduler.dart';",
              '',
              '// Slow every animation in the app down by 4x:',
              'timeDilation = 4.0;',
              '',
              '// Reset:',
              'timeDilation = 1.0;',
            ],
          ),
        ],
      ),
    );
  }
}

class _DilationLane extends StatelessWidget {
  final String label;
  final Color color;
  final int ticks;
  const _DilationLane({
    required this.label,
    required this.color,
    required this.ticks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.14),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 24,
            child: Row(
              children: [
                for (var i = 0; i < ticks; i++) ...[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  if (i < ticks - 1) const SizedBox(width: 4),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$ticks Ticker pulses per perceived second',
            style: const TextStyle(
              color: _Tokens.inkSoft,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 08  Post vs Persistent comparison table
// =============================================================================

class _PostVsPersistentSection extends StatelessWidget {
  const _PostVsPersistentSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          _CompareHeader(),
          _CompareRow(
            attr: 'Lifetime',
            post: 'fires once, then deregisters',
            persistent: 'fires every frame forever',
          ),
          _CompareRow(
            attr: 'Phase',
            post: 'postFrameCallbacks',
            persistent: 'persistentCallbacks',
          ),
          _CompareRow(
            attr: 'Typical use',
            post: 'measure layout, scroll-to-bottom, show snackbar',
            persistent: 'rendering pipeline (registered by WidgetsBinding)',
          ),
          _CompareRow(
            attr: 'Cleanup',
            post: 'automatic',
            persistent: 'cannot be removed once registered',
          ),
          _CompareRow(
            attr: 'Re-entrance',
            post: 'safe to add another inside',
            persistent: 'rare; you almost never want to add more',
          ),
          _CompareRow(
            attr: 'Source',
            post: 'addPostFrameCallback(callback)',
            persistent: 'addPersistentFrameCallback(callback)',
          ),
        ],
      ),
    );
  }
}

class _CompareHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_Tokens.phasePost, _Tokens.phasePersistent],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              'attribute',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'addPostFrameCallback',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'addPersistentFrameCallback',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  final String attr;
  final String post;
  final String persistent;
  const _CompareRow({
    required this.attr,
    required this.post,
    required this.persistent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _Tokens.inkMuted.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              attr,
              style: const TextStyle(
                color: _Tokens.ink,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              post,
              style: const TextStyle(
                color: _Tokens.inkSoft,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              persistent,
              style: const TextStyle(
                color: _Tokens.inkSoft,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 09  Use cases
// =============================================================================

class _UseCase {
  final String title;
  final String body;
  final IconData icon;
  final Color color;
  final Widget representative;
  const _UseCase({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.representative,
  });
}

class _UseCasesSection extends StatelessWidget {
  const _UseCasesSection();

  @override
  Widget build(BuildContext context) {
    final cases = <_UseCase>[
      _UseCase(
        title: 'Scroll-to-bottom on first build',
        body:
            'Schedule a postFrame callback so the ScrollController has a real '
            'extent to scroll to.',
        icon: Icons.south,
        color: _Tokens.phasePost,
        representative: _ScrollToBottomMock(),
      ),
      _UseCase(
        title: 'Overlay injection on insert',
        body:
            'Need to position a tooltip relative to a freshly-built RenderBox? '
            'Wait one frame.',
        icon: Icons.layers_outlined,
        color: _Tokens.phaseTransient,
        representative: _OverlayMock(),
      ),
      _UseCase(
        title: 'FPS overlay',
        body:
            'A persistent frame callback writes timing into a ring-buffer and '
            'a tiny widget renders it.',
        icon: Icons.speed,
        color: _Tokens.phasePersistent,
        representative: _MiniFpsMock(),
      ),
      _UseCase(
        title: 'Long-task scheduling',
        body:
            'scheduleTask(work, Priority.idle) defers expensive work until the '
            'binding sees a quiet moment.',
        icon: Icons.timelapse,
        color: _Tokens.prioIdle,
        representative: _IdleQueueMock(),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        for (final c in cases) _UseCaseCard(useCase: c),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  final _UseCase useCase;
  const _UseCaseCard({required this.useCase});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            useCase.color.withValues(alpha: 0.16),
            useCase.color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: useCase.color.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: useCase.color.withValues(alpha: 0.16),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: useCase.color.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(useCase.icon, color: useCase.color, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  useCase.title,
                  style: const TextStyle(
                    color: _Tokens.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            useCase.body,
            style: const TextStyle(
              color: _Tokens.inkSoft,
              fontSize: 12,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(child: useCase.representative),
        ],
      ),
    );
  }
}

class _ScrollToBottomMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Tokens.bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Tokens.phasePost.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: _Tokens.inkMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          const Spacer(),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: _Tokens.phasePost,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverlayMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: _Tokens.bg,
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: _Tokens.phaseTransient.withValues(alpha: 0.4)),
          ),
        ),
        Positioned(
          left: 18,
          top: 16,
          child: Container(
            width: 70,
            height: 24,
            decoration: BoxDecoration(
              color: _Tokens.phaseTransient,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Positioned(
          left: 8,
          top: 46,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _Tokens.phasePost.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'tooltip',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniFpsMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _Tokens.bg,
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: _Tokens.phasePersistent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _MiniBar(label: 'B', value: 0.45, color: _Tokens.phaseTransient),
          SizedBox(height: 4),
          _MiniBar(label: 'R', value: 0.62, color: _Tokens.phasePost),
          SizedBox(height: 4),
          _MiniBar(label: 'T', value: 0.81, color: _Tokens.phasePersistent),
        ],
      ),
    );
  }
}

class _MiniBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _MiniBar({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 14,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: _Tokens.inkMuted.withValues(alpha: 0.25),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
  }
}

class _IdleQueueMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _Tokens.bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Tokens.prioIdle.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: _Tokens.prioIdle,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: _Tokens.prioIdle.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(3),
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

// =============================================================================
// 10  Pitfalls
// =============================================================================

class _Pitfall {
  final String title;
  final String body;
  final Color color;
  final IconData icon;
  const _Pitfall({
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
  });
}

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    const pitfalls = <_Pitfall>[
      _Pitfall(
        title: 'Never block in a transientCallback',
        body:
            'Tickers and animation drivers run here. A 10 ms sleep here is a '
            'visible jank. Move heavy work off-frame with scheduleTask or an '
            'isolate.',
        icon: Icons.block,
        color: _Tokens.phaseMicro,
      ),
      _Pitfall(
        title: 'scheduleTask is not Future.microtask',
        body:
            'Microtasks run as soon as the event loop spins; scheduleTask only '
            'fires when SchedulerBinding decides the binding is idle. They have '
            'completely different latency profiles.',
        icon: Icons.warning_amber_outlined,
        color: _Tokens.phaseTransient,
      ),
      _Pitfall(
        title: 'Ticker leak: forgetting to dispose',
        body:
            'A Ticker outliving its TickerProvider keeps the State alive too. '
            'Symptoms: assertions in debug, slow memory growth in release. '
            'Always dispose() in State.dispose().',
        icon: Icons.bug_report_outlined,
        color: _Tokens.phasePost,
      ),
      _Pitfall(
        title: 'addPostFrameCallback inside build',
        body:
            'Calling it from build is fine, but doing setState inside the '
            'callback unconditionally produces an immediate second frame. '
            'Guard with mounted and a "should rebuild?" check.',
        icon: Icons.refresh,
        color: _Tokens.phasePersistent,
      ),
    ];

    return _Card(
      child: Column(
        children: [
          for (var i = 0; i < pitfalls.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == pitfalls.length - 1 ? 0 : 12),
              child: _PitfallRow(pitfall: pitfalls[i]),
            ),
        ],
      ),
    );
  }
}

class _PitfallRow extends StatelessWidget {
  final _Pitfall pitfall;
  const _PitfallRow({required this.pitfall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pitfall.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: pitfall.color, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(pitfall.icon, color: pitfall.color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pitfall.title,
                  style: TextStyle(
                    color: pitfall.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pitfall.body,
                  style: const TextStyle(
                    color: _Tokens.inkSoft,
                    fontSize: 12,
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

// =============================================================================
// 11  FPS Overlay mock
// =============================================================================

class _FpsOverlaySection extends StatelessWidget {
  const _FpsOverlaySection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF101737),
                    Color(0xFF050913),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _Tokens.phasePersistent.withValues(alpha: 0.4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: _Tokens.phasePersistent.withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  _FpsBar(
                    label: 'build',
                    value: 0.32,
                    color: _Tokens.phaseTransient,
                    text: '5.3 / 16.6 ms',
                  ),
                  SizedBox(height: 10),
                  _FpsBar(
                    label: 'raster',
                    value: 0.48,
                    color: _Tokens.phasePost,
                    text: '8.0 / 16.6 ms',
                  ),
                  SizedBox(height: 10),
                  _FpsBar(
                    label: 'total',
                    value: 0.80,
                    color: _Tokens.phasePersistent,
                    text: '13.3 / 16.6 ms',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _NoteParagraph(
                  text:
                      'A typical FPS overlay registers a persistent frame '
                      'callback that records FrameTiming entries into a ring '
                      'buffer, plus an addTimingsCallback for raster-thread '
                      'timing. The widget shows three LinearProgressIndicator '
                      'bars normalised against the 16.6 ms target.',
                ),
                SizedBox(height: 10),
                _NoteParagraph(
                  text:
                      'In production, do not run this in release mode. The '
                      'overhead of mass-recording timings is non-trivial and '
                      'the visual clutter is undesirable.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FpsBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final String text;
  const _FpsBar({
    required this.label,
    required this.value,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                color: _Tokens.inkSoft,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 10,
            backgroundColor: _Tokens.inkMuted.withValues(alpha: 0.25),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// 12  scheduleTask lane diagram
// =============================================================================

class _PriorityLaneSection extends StatelessWidget {
  const _PriorityLaneSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _NoteParagraph(
            text:
                'scheduleTask runs the earliest task whose priority is at least '
                'the current schedulingStrategy threshold. The diagram below '
                'pictures four lanes of varying priority — work in higher lanes '
                'pre-empts work in lower lanes once the binding is idle.',
          ),
          const SizedBox(height: 12),
          _PriorityLane(
            label: 'Priority.touch + 1',
            value: Priority.touch.value + 1,
            color: _Tokens.prioBumped,
            chips: const ['preflight', 'critical input prep'],
          ),
          const SizedBox(height: 8),
          _PriorityLane(
            label: 'Priority.touch',
            value: Priority.touch.value,
            color: _Tokens.prioTouch,
            chips: const ['gesture', 'tap', 'scroll start'],
          ),
          const SizedBox(height: 8),
          _PriorityLane(
            label: 'Priority.animation',
            value: Priority.animation.value,
            color: _Tokens.prioAnim,
            chips: const ['scheduled curve update', 'route transition'],
          ),
          const SizedBox(height: 8),
          _PriorityLane(
            label: 'Priority.idle',
            value: Priority.idle.value,
            color: _Tokens.prioIdle,
            chips: const [
              'index docs',
              'thumbnail decode',
              'analytics flush',
            ],
          ),
        ],
      ),
    );
  }
}

class _PriorityLane extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final List<String> chips;
  const _PriorityLane({
    required this.label,
    required this.value,
    required this.color,
    required this.chips,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'value = $value',
                  style: const TextStyle(
                    color: _Tokens.inkMuted,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final c in chips)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: color.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      c,
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontFamily: 'monospace',
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

// =============================================================================
// Reusable atoms
// =============================================================================

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF161E3D),
            Color(0xFF0E142A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Tokens.inkMuted.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.4),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Note extends StatelessWidget {
  final String text;
  const _Note({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _Tokens.inkSoft,
        fontSize: 13,
        height: 1.4,
      ),
    );
  }
}

class _NoteParagraph extends StatelessWidget {
  final String text;
  const _NoteParagraph({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: _Tokens.inkSoft,
          fontSize: 13,
          height: 1.5,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final List<String> lines;
  const _CodeBlock({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF050913),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Tokens.phaseBegin.withValues(alpha: 0.3)),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final line in lines)
            Text(
              line.isEmpty ? ' ' : line,
              style: TextStyle(
                color: line.startsWith('//')
                    ? _Tokens.inkMuted
                    : _Tokens.inkSoft,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}

class _FooterStrip extends StatelessWidget {
  const _FooterStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Tokens.phaseBegin.withValues(alpha: 0.18),
            _Tokens.phasePost.withValues(alpha: 0.18),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Tokens.inkMuted.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book_outlined, color: _Tokens.ink, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Reference: package:flutter/scheduler.dart — '
              'SchedulerBinding, SchedulerPhase, Priority, Ticker, '
              'TickerProvider, FrameTiming, AppLifecycleState, timeDilation.',
              style: TextStyle(
                color: _Tokens.inkSoft,
                fontSize: 12,
                fontStyle: FontStyle.italic,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
