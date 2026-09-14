// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SchedulerPhase enum from package:flutter/scheduler.dart
//
// Deep Demo: Visual, instructive deep-dive into the Flutter frame pipeline as
// described by the SchedulerPhase enum. Each frame produced by the engine
// passes through a strict sequence of phases. Knowing which phase is currently
// active is essential for safely scheduling work, calling setState, awaiting
// endOfFrame, and avoiding jank.
//
// Phases:
//   - idle                  : not building a frame; engine waiting for vsync
//   - transientCallbacks    : animation ticks, gesture recognizers
//   - midFrameMicrotasks    : microtasks queued during transientCallbacks
//   - persistentCallbacks   : build, layout, paint, composite
//   - postFrameCallbacks    : one-shot callbacks scheduled for end-of-frame
//
// The current phase is read once via SchedulerBinding.instance.schedulerPhase.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('SchedulerPhase Deep Demo executing');

  // Read the current phase ONCE. This snapshot represents where the engine
  // is right now while this build() runs. Because build() is itself part of
  // persistentCallbacks (it is the build sub-step of layout-build-paint),
  // this will most often be SchedulerPhase.persistentCallbacks. We never
  // mutate state based on this; we display it for instruction.
  final SchedulerPhase currentPhase =
      SchedulerBinding.instance.schedulerPhase;
  print('Current SchedulerBinding.instance.schedulerPhase: $currentPhase');

  // Enumerate every value for the demo. The order in `values` corresponds to
  // the temporal order within a frame, which is the spine of this whole demo.
  print('SchedulerPhase has ${SchedulerPhase.values.length} values:');
  for (final v in SchedulerPhase.values) {
    print('  index=${v.index} name=${v.name} toString=$v');
  }
  print('First phase: ${SchedulerPhase.values.first}');
  print('Last  phase: ${SchedulerPhase.values.last}');

  // Phase metadata used by several sections below. Keeping it in one place
  // makes it easy to audit the colours, icons and copy.
  final List<_PhaseInfo> phaseInfos = <_PhaseInfo>[
    _PhaseInfo(
      phase: SchedulerPhase.idle,
      label: 'idle',
      tagline: 'Engine awaits the next vsync.',
      icon: Icons.bedtime,
      color: const Color(0xFF607D8B),
      altColor: const Color(0xFF90A4AE),
      description:
          'No frame is currently being produced. The Dart isolate is free '
          'to process microtasks, async events, I/O and user code. Most app '
          'time is spent here.',
      runs:
          'Pending Futures, Timers, isolate messages, user event handlers '
          'that are not gated by a frame.',
      schedulesHere:
          'scheduleTask, Timer.run, scheduleMicrotask. Calling setState here '
          'simply marks the element dirty and schedules a frame.',
      sample: 'SchedulerBinding.instance.scheduleTask(work, Priority.idle);',
    ),
    _PhaseInfo(
      phase: SchedulerPhase.transientCallbacks,
      label: 'transientCallbacks',
      tagline: 'Tick the world: animations and gestures.',
      icon: Icons.animation,
      color: const Color(0xFF1E88E5),
      altColor: const Color(0xFF42A5F5),
      description:
          'Called once at the start of every frame. AnimationController '
          'ticks, Tickers, gesture recognizers and other "drive the world" '
          'callbacks fire here. Their job is to update animation values and '
          'route input events into the framework.',
      runs:
          'All transient frame callbacks registered via '
          'SchedulerBinding.instance.scheduleFrameCallback. Tickers also run '
          'here.',
      schedulesHere:
          'scheduleFrameCallback(fn). Use rescheduling=true only inside an '
          'existing transient callback.',
      sample:
          'SchedulerBinding.instance.scheduleFrameCallback((Duration t) { '
          '/* tick */ });',
    ),
    _PhaseInfo(
      phase: SchedulerPhase.midFrameMicrotasks,
      label: 'midFrameMicrotasks',
      tagline: 'Drain microtasks before layout.',
      icon: Icons.bubble_chart,
      color: const Color(0xFF8E24AA),
      altColor: const Color(0xFFAB47BC),
      description:
          'After transientCallbacks have run, the scheduler drains the '
          'microtask queue so that anything an animation tick scheduled is '
          'observed before build/layout begins. This phase is short-lived '
          'and is the reason "await" inside a tick can resume mid-frame.',
      runs:
          'Microtasks queued during transientCallbacks (e.g. then() chains, '
          'await continuations, scheduleMicrotask).',
      schedulesHere:
          'scheduleMicrotask from a transient callback. Avoid heavy work; '
          'this is on the critical frame path.',
      sample: 'scheduleMicrotask(() => log("after tick, before build"));',
    ),
    _PhaseInfo(
      phase: SchedulerPhase.persistentCallbacks,
      label: 'persistentCallbacks',
      tagline: 'Build, layout, paint, composite.',
      icon: Icons.architecture,
      color: const Color(0xFFE65100),
      altColor: const Color(0xFFFB8C00),
      description:
          'The big one. WidgetsBinding.drawFrame runs here: build dirty '
          'elements, perform layout, paint into layers, then hand the scene '
          'to the engine for compositing. Calling setState during this '
          'phase is illegal because the tree is being walked.',
      runs:
          'buildScope -> Element.rebuild for dirty elements -> RenderObject '
          'layout -> paint -> compositeFrame.',
      schedulesHere:
          'Persistent frame callbacks via addPersistentFrameCallback (rare; '
          'only the framework itself does this in normal use).',
      sample:
          'WidgetsBinding.instance.addPersistentFrameCallback((Duration t) {});',
    ),
    _PhaseInfo(
      phase: SchedulerPhase.postFrameCallbacks,
      label: 'postFrameCallbacks',
      tagline: 'Layout-dependent work, exactly once.',
      icon: Icons.flag,
      color: const Color(0xFF2E7D32),
      altColor: const Color(0xFF43A047),
      description:
          'After the frame is painted but before the engine truly idles, '
          'one-shot callbacks registered via addPostFrameCallback fire. '
          'This is the safe place to read RenderBox sizes, scroll '
          'positions, or schedule the next animation now that the tree '
          'is consistent.',
      runs:
          'All callbacks registered via '
          'WidgetsBinding.instance.addPostFrameCallback during the frame.',
      schedulesHere:
          'addPostFrameCallback. The list is drained and cleared every frame.',
      sample:
          'WidgetsBinding.instance.addPostFrameCallback((_) => measure());',
    ),
  ];

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');
  final Widget header = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0D1B2A),
          Color(0xFF1B263B),
          Color(0xFF415A77),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0D1B2A).withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: const Color(0xFF415A77).withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFFFC857), Color(0xFFE9724C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFFE9724C).withValues(alpha: 0.5),
                    blurRadius: 14.0,
                    offset: const Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.schedule,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'SchedulerPhase',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'A guided tour of the Flutter frame pipeline',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFFE0E1DD),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.radio_button_checked,
                color: Color(0xFFFFC857),
                size: 18.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Snapshot at build(): $currentPhase',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC857).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'index ${currentPhase.index}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: Color(0xFFFFC857),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Frame pipeline circular flow diagram
  // ============================================================
  print('=== Section 2: Pipeline circular flow ===');
  final Widget pipelineFlow = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.06),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Frame pipeline (one vsync tick)',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'idle -> transient -> microtasks -> persistent -> postFrame -> idle',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 18.0),
        // The "circular flow": phases as colored chips with arrows wrapping
        // back to idle at the end. Wrap lets it reflow on narrow surfaces.
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (int i = 0; i < phaseInfos.length; i++) ...<Widget>[
              _phaseChip(phaseInfos[i]),
              if (i < phaseInfos.length - 1)
                const Icon(
                  Icons.arrow_right_alt,
                  color: Color(0xFF64748B),
                  size: 28.0,
                ),
            ],
            const Icon(
              Icons.subdirectory_arrow_left,
              color: Color(0xFF64748B),
              size: 24.0,
            ),
            _phaseChip(phaseInfos[0], faded: true),
          ],
        ),
        const SizedBox(height: 16.0),
        // Persistent callbacks expanded into its real sub-steps. These are
        // not separate enum values but are conceptually crucial and the
        // single biggest source of jank.
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFFFFF7ED), Color(0xFFFFEDD5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFFDBA74), width: 1.2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFFFB923C).withValues(alpha: 0.20),
                blurRadius: 8.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Inside persistentCallbacks (drawFrame):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF7C2D12),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  _SubStep(label: 'build', color: Color(0xFFEA580C)),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xFF7C2D12),
                  ),
                  _SubStep(label: 'layout', color: Color(0xFFD97706)),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xFF7C2D12),
                  ),
                  _SubStep(label: 'paint', color: Color(0xFFCA8A04)),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xFF7C2D12),
                  ),
                  _SubStep(label: 'composite', color: Color(0xFF65A30D)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (5)
  // ============================================================
  print('=== Section 3: Per-value cards ===');
  final List<Widget> phaseCards = <Widget>[];
  for (final _PhaseInfo info in phaseInfos) {
    final bool isCurrent = info.phase == currentPhase;
    print(
      'Card built for ${info.label} (current=$isCurrent, '
      'index=${info.phase.index})',
    );
    phaseCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              info.color.withValues(alpha: 0.08),
              info.altColor.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isCurrent ? info.color : info.color.withValues(alpha: 0.35),
            width: isCurrent ? 2.5 : 1.2,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: info.color.withValues(alpha: isCurrent ? 0.35 : 0.18),
              blurRadius: isCurrent ? 16.0 : 10.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[info.color, info.altColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: info.color.withValues(alpha: 0.45),
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 4.0),
                        ),
                      ],
                    ),
                    child: Icon(info.icon, color: Colors.white, size: 28.0),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'SchedulerPhase.${info.label}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: info.color,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          info.tagline,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: info.color.withValues(alpha: 0.85),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isCurrent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: info.color,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Text(
                        'NOW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: info.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        '#${info.phase.index}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: info.color,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14.0),
              _kvBlock('Definition', info.description, info.color),
              const SizedBox(height: 8.0),
              _kvBlock('What runs here', info.runs, info.color),
              const SizedBox(height: 8.0),
              _kvBlock('Callbacks scheduled here', info.schedulesHere,
                  info.color),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: info.color.withValues(alpha: 0.6),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  info.sample,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: info.altColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: 16.7ms frame budget timeline
  // ============================================================
  print('=== Section 4: Frame budget timeline ===');
  // Approximate, hand-tuned slice fractions of a 16.7ms 60fps budget. These
  // are illustrative numbers; the real cost depends on the app. They sum to
  // 1.0. The slack at the end is the comfort margin before the next vsync.
  final List<_BudgetSlice> slices = <_BudgetSlice>[
    _BudgetSlice('vsync wait',  0.04, const Color(0xFF94A3B8)),
    _BudgetSlice('transient',   0.10, const Color(0xFF1E88E5)),
    _BudgetSlice('microtasks',  0.04, const Color(0xFF8E24AA)),
    _BudgetSlice('build',       0.18, const Color(0xFFEA580C)),
    _BudgetSlice('layout',      0.16, const Color(0xFFD97706)),
    _BudgetSlice('paint',       0.14, const Color(0xFFCA8A04)),
    _BudgetSlice('composite',   0.10, const Color(0xFF65A30D)),
    _BudgetSlice('postFrame',   0.08, const Color(0xFF2E7D32)),
    _BudgetSlice('slack',       0.16, const Color(0xFFE2E8F0)),
  ];

  final Widget budgetTimeline = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFF1F5F9), Color(0xFFFFFFFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFCBD5E1)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.05),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.timer, color: Color(0xFF0F172A), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              '60 fps frame budget: 16.7 ms',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Each slice shows roughly which phase consumes which share of the '
          'frame. If any slice grows past its share, you drop a frame.',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF475569)),
        ),
        const SizedBox(height: 14.0),
        // The bar.
        Container(
          height: 36.0,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFF94A3B8)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.10),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              for (final _BudgetSlice s in slices)
                Expanded(
                  flex: (s.fraction * 1000).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          s.color,
                          s.color.withValues(alpha: 0.75),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: s.fraction >= 0.10
                        ? Text(
                            '${(s.fraction * 16.7).toStringAsFixed(1)}ms',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        // Legend.
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (final _BudgetSlice s in slices)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: s.color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: s.color.withValues(alpha: 0.6),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: s.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      '${s.label} ${(s.fraction * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Recipes (3) - PSEUDOCODE ONLY, never executed.
  // ============================================================
  print('=== Section 5: Recipes ===');
  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'Recipe 1: Layout-dependent measurement after build',
      whenPhase: SchedulerPhase.postFrameCallbacks,
      color: const Color(0xFF2E7D32),
      altColor: const Color(0xFF66BB6A),
      icon: Icons.flag,
      pseudocode:
          '// Inside a State.build() or initState():\n'
          'WidgetsBinding.instance.addPostFrameCallback((_) {\n'
          '  final RenderBox? box = key.currentContext?.findRenderObject()\n'
          '      as RenderBox?;\n'
          '  if (box != null && box.hasSize) {\n'
          '    debugPrint("measured: \${box.size}");\n'
          '  }\n'
          '});',
      explanation:
          'During build, the RenderBox has not been laid out yet, so .size '
          'is unreliable. Defer the read to postFrameCallbacks, where '
          'layout has completed. The callback fires exactly once.',
    ),
    _Recipe(
      title: 'Recipe 2: Per-tick animation work',
      whenPhase: SchedulerPhase.transientCallbacks,
      color: const Color(0xFF1E88E5),
      altColor: const Color(0xFF64B5F6),
      icon: Icons.animation,
      pseudocode:
          '// Stateless tick driver via SchedulerBinding (no Ticker required):\n'
          'void scheduleNextTick() {\n'
          '  SchedulerBinding.instance.scheduleFrameCallback((Duration t) {\n'
          '    // t is the timestamp passed to all transientCallbacks\n'
          '    advanceSimulation(t);\n'
          '    scheduleNextTick(); // queue another for the following frame\n'
          '  });\n'
          '}',
      explanation:
          'transientCallbacks is the canonical place to advance any per-frame '
          'simulation. Tickers, AnimationControllers and gesture recognizers '
          'all run here. Keep the work tiny: every microsecond burned here '
          'eats into the build/layout budget.',
    ),
    _Recipe(
      title: 'Recipe 3: Awaiting endOfFrame',
      whenPhase: SchedulerPhase.idle,
      color: const Color(0xFF8E24AA),
      altColor: const Color(0xFFBA68C8),
      icon: Icons.hourglass_bottom,
      pseudocode:
          '// In an async helper, e.g. a test or off-frame coordinator:\n'
          'Future<void> afterNextFrame() async {\n'
          '  await SchedulerBinding.instance.endOfFrame;\n'
          '  // We are now in idle, the previous frame is fully done.\n'
          '  takeScreenshotOrInspectTree();\n'
          '}',
      explanation:
          'endOfFrame returns a Future that completes after the current (or '
          'next) frame finishes its postFrameCallbacks. It is the cleanest '
          'way to wait for the pipeline to come to rest before reading state '
          'or driving the next interaction.',
    ),
  ];

  final List<Widget> recipeCards = <Widget>[];
  for (final _Recipe r in recipes) {
    print('Recipe: ${r.title} — anchor phase ${r.whenPhase.name}');
    recipeCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              r.color.withValues(alpha: 0.08),
              r.altColor.withValues(alpha: 0.20),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: r.color.withValues(alpha: 0.55),
            width: 1.4,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: r.color.withValues(alpha: 0.20),
              blurRadius: 12.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[r.color, r.altColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(r.icon, color: Colors.white, size: 22.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    r.title,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: r.color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: r.color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'Anchor phase: SchedulerPhase.${r.whenPhase.name}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: r.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: r.color.withValues(alpha: 0.45),
                  width: 1.0,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF000000).withValues(alpha: 0.30),
                    blurRadius: 6.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Text(
                r.pseudocode,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.4,
                  color: r.altColor,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              r.explanation,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF1F2937),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Comparison — SchedulerPhase vs AppLifecycleState vs vsync
  // ============================================================
  print('=== Section 6: Comparison ===');
  final Widget comparison = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFFCD34D), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.compare_arrows, color: Color(0xFF92400E), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Easy to confuse with...',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF92400E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonRow(
          'SchedulerPhase',
          'Where in a SINGLE frame the engine currently is.',
          const Color(0xFFE65100),
          Icons.schedule,
        ),
        _comparisonRow(
          'AppLifecycleState',
          'Whether the WHOLE APP is resumed/inactive/paused/detached.',
          const Color(0xFF1565C0),
          Icons.apps,
        ),
        _comparisonRow(
          'Ticker / vsync',
          'The pulse that drives transient callbacks. Each tick is one '
              'frame, but the Ticker itself is not a phase.',
          const Color(0xFF6A1B9A),
          Icons.show_chart,
        ),
        _comparisonRow(
          'FrameTiming',
          'Post-mortem measurement of a frame after compositing. Useful '
              'for performance overlays, not for control flow.',
          const Color(0xFF2E7D32),
          Icons.insights,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  print('=== Section 7: Pitfalls ===');
  final Widget pitfalls = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFEF2F2), Color(0xFFFECACA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFFCA5A5), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFFEF4444).withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded,
                color: Color(0xFF991B1B), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and anti-patterns',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF991B1B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfall(
          'Calling setState inside a postFrameCallback without guarding.',
          'You will trigger another frame immediately after the current '
              'one. Fine for one-shot transitions, disaster if it loops. '
              'Always guard with `if (!mounted) return;` and a stable '
              'condition.',
        ),
        _pitfall(
          'Doing heavy work in transientCallbacks.',
          'Animation ticks must be O(microseconds). Anything else cascades '
              'into build/layout/paint and overflows the frame budget. Push '
              'expensive work to a background isolate or to scheduleTask '
              'with idle priority.',
        ),
        _pitfall(
          'Forgetting to await endOfFrame in tests.',
          'Reading sizes, taking screenshots or driving the next gesture '
              'before the pipeline reaches idle yields stale or partial '
              'results. Always `await tester.pumpAndSettle()` or '
              '`await SchedulerBinding.instance.endOfFrame;`.',
        ),
        _pitfall(
          'Assuming SchedulerPhase.idle equals "no Dart code running".',
          'idle just means no frame is in flight. Your microtasks, '
              'Timer callbacks and async continuations still run during '
              'idle and can race with whatever you scheduled.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Phase reference table
  // ============================================================
  print('=== Section 8: Reference table ===');
  final Widget refTable = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFCBD5E1)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Quick reference',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: const <Widget>[
              _HeaderCell('idx', 36.0),
              _HeaderCell('phase', 170.0),
              _HeaderCell('also called', 140.0),
              _HeaderCell('safe to setState?', 130.0),
            ],
          ),
        ),
        for (final _PhaseInfo info in phaseInfos)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            child: Row(
              children: <Widget>[
                _DataCell('${info.phase.index}', 36.0,
                    fontFamily: 'monospace'),
                _DataCell(info.label, 170.0,
                    color: info.color, bold: true, fontFamily: 'monospace'),
                _DataCell(_alsoCalled(info.phase), 140.0),
                _DataCell(_setStateSafety(info.phase), 130.0,
                    color: _setStateSafetyColor(info.phase), bold: true),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Live snapshot panel + footer
  // ============================================================
  print('=== Section 9: Live snapshot + footer ===');
  final Widget livePanel = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF111827), Color(0xFF1F2937)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.terminal, color: Color(0xFF34D399), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Live snapshot',
              style: TextStyle(
                color: Color(0xFF34D399),
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'SchedulerBinding.instance.schedulerPhase\n'
          '  -> $currentPhase\n'
          '  -> .name           = ${currentPhase.name}\n'
          '  -> .index          = ${currentPhase.index}\n'
          '  -> values.length   = ${SchedulerPhase.values.length}\n'
          '  -> values.first    = ${SchedulerPhase.values.first.name}\n'
          '  -> values.last     = ${SchedulerPhase.values.last.name}',
          style: const TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFFE5E7EB),
            fontSize: 12.0,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  final Widget footer = Container(
    margin: const EdgeInsets.only(top: 12.0, bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.5),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: const Text(
      '+--------------------------------------------------------------+\n'
      '|  SchedulerPhase Deep Demo                                    |\n'
      '|  test/.../send_ast_via_http_scripts/scheduler/               |\n'
      '|    scheduler_phase_test.dart                                 |\n'
      '|  idle -> transient -> microtasks -> persistent -> postFrame  |\n'
      '+--------------------------------------------------------------+',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Color(0xFFE2E8F0),
        height: 1.4,
      ),
    ),
  );

  print('SchedulerPhase Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        header,
        const SizedBox(height: 22.0),
        const _SectionTitle('1. Frame pipeline (one tick of the engine)'),
        pipelineFlow,
        const SizedBox(height: 16.0),
        const _SectionTitle('2. Per-value cards'),
        ...phaseCards,
        const SizedBox(height: 16.0),
        const _SectionTitle('3. 16.7 ms frame budget'),
        budgetTimeline,
        const SizedBox(height: 16.0),
        const _SectionTitle('4. Recipes (pseudocode, never executed)'),
        ...recipeCards,
        const SizedBox(height: 16.0),
        const _SectionTitle('5. Comparison: SchedulerPhase vs neighbours'),
        comparison,
        const SizedBox(height: 16.0),
        const _SectionTitle('6. Pitfalls and anti-patterns'),
        pitfalls,
        const SizedBox(height: 16.0),
        const _SectionTitle('7. Quick reference table'),
        refTable,
        const SizedBox(height: 16.0),
        const _SectionTitle('8. Live snapshot at this build'),
        livePanel,
        const SizedBox(height: 16.0),
        const _SectionTitle('9. Footer'),
        footer,
      ],
    ),
  );
}

// ============================================================
// Data holders
// ============================================================

class _PhaseInfo {
  const _PhaseInfo({
    required this.phase,
    required this.label,
    required this.tagline,
    required this.icon,
    required this.color,
    required this.altColor,
    required this.description,
    required this.runs,
    required this.schedulesHere,
    required this.sample,
  });

  final SchedulerPhase phase;
  final String label;
  final String tagline;
  final IconData icon;
  final Color color;
  final Color altColor;
  final String description;
  final String runs;
  final String schedulesHere;
  final String sample;
}

class _BudgetSlice {
  const _BudgetSlice(this.label, this.fraction, this.color);
  final String label;
  final double fraction;
  final Color color;
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.whenPhase,
    required this.color,
    required this.altColor,
    required this.icon,
    required this.pseudocode,
    required this.explanation,
  });

  final String title;
  final SchedulerPhase whenPhase;
  final Color color;
  final Color altColor;
  final IconData icon;
  final String pseudocode;
  final String explanation;
}

// ============================================================
// Small widget helpers
// ============================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 6.0,
            height: 22.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFFE9724C), Color(0xFFFFC857)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubStep extends StatelessWidget {
  const _SubStep({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color, width: 1.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text, this.width);
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0F172A),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  const _DataCell(
    this.text,
    this.width, {
    this.color = const Color(0xFF1F2937),
    this.bold = false,
    this.fontFamily,
  });

  final String text;
  final double width;
  final Color color;
  final bool bold;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          color: color,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}

Widget _phaseChip(_PhaseInfo info, {bool faded = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          info.color.withValues(alpha: faded ? 0.20 : 0.85),
          info.altColor.withValues(alpha: faded ? 0.30 : 1.0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: faded
          ? const <BoxShadow>[]
          : <BoxShadow>[
              BoxShadow(
                color: info.color.withValues(alpha: 0.40),
                blurRadius: 8.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(info.icon, color: Colors.white, size: 16.0),
        const SizedBox(width: 6.0),
        Text(
          info.label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: faded ? Colors.white.withValues(alpha: 0.85) : Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _kvBlock(String key, String value, Color tint) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.65),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: tint.withValues(alpha: 0.30), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          key,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
            color: tint,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF1F2937),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(
  String name,
  String description,
  Color color,
  IconData icon,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF1F2937),
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

Widget _pitfall(String headline, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(
          Icons.error_outline,
          color: Color(0xFF991B1B),
          size: 18.0,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                headline,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF991B1B),
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF7F1D1D),
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

String _alsoCalled(SchedulerPhase phase) {
  switch (phase) {
    case SchedulerPhase.idle:
      return 'between frames';
    case SchedulerPhase.transientCallbacks:
      return 'tickers';
    case SchedulerPhase.midFrameMicrotasks:
      return 'microtask drain';
    case SchedulerPhase.persistentCallbacks:
      return 'drawFrame';
    case SchedulerPhase.postFrameCallbacks:
      return 'end-of-frame';
  }
}

String _setStateSafety(SchedulerPhase phase) {
  switch (phase) {
    case SchedulerPhase.idle:
      return 'yes';
    case SchedulerPhase.transientCallbacks:
      return 'yes (careful)';
    case SchedulerPhase.midFrameMicrotasks:
      return 'avoid';
    case SchedulerPhase.persistentCallbacks:
      return 'NO';
    case SchedulerPhase.postFrameCallbacks:
      return 'yes';
  }
}

Color _setStateSafetyColor(SchedulerPhase phase) {
  switch (phase) {
    case SchedulerPhase.idle:
      return const Color(0xFF166534);
    case SchedulerPhase.transientCallbacks:
      return const Color(0xFF92400E);
    case SchedulerPhase.midFrameMicrotasks:
      return const Color(0xFFB45309);
    case SchedulerPhase.persistentCallbacks:
      return const Color(0xFF991B1B);
    case SchedulerPhase.postFrameCallbacks:
      return const Color(0xFF166534);
  }
}
