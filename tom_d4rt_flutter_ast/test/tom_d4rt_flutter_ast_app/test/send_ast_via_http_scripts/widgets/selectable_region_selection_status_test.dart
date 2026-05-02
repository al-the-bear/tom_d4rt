// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep-demo: SelectableRegionSelectionStatus.
//
// SelectableRegionSelectionStatus is the two-value Flutter enum that describes
// the lifecycle of a selection inside a SelectableRegion:
//
//   * SelectableRegionSelectionStatus.changing   - a gesture is in progress
//   * SelectableRegionSelectionStatus.finalized  - the selection has settled
//
// This demo branches on the enum LIVE in many places: switch expressions,
// equality checks, listener callbacks driven by ValueNotifier, state-driven
// UI rebuilds, and a fake state machine that toggles the enum and renders
// different widgets for each value. Every enum value appears in compiled
// code paths, not just inside string literals.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectableRegionSelectionStatus deep demo executing');

  final TargetPlatform platform = Theme.of(context).platform;
  final bool isMobilePlatform =
      platform == TargetPlatform.android || platform == TargetPlatform.iOS;
  print('Detected platform: $platform, mobile=$isMobilePlatform');

  // ===========================================================================
  // SECTION 1 - Live state catalog (switch on every enum value)
  // ===========================================================================
  print('=== Section 1: live state catalog ===');

  final List<Widget> stateCatalog = <Widget>[];
  for (final SelectableRegionSelectionStatus status
      in SelectableRegionSelectionStatus.values) {
    print(
        'Building catalog card for ${status.name} (index=${status.index})');
    stateCatalog.add(_buildStatusCatalogCard(status, isMobilePlatform));
  }

  // ===========================================================================
  // SECTION 2 - Pair-wise equality matrix (live equality checks)
  // ===========================================================================
  print('=== Section 2: equality matrix ===');

  final List<Widget> equalityRows = <Widget>[];
  for (final SelectableRegionSelectionStatus row
      in SelectableRegionSelectionStatus.values) {
    final List<Widget> cells = <Widget>[];
    cells.add(_buildEqLabel(row.name));
    for (final SelectableRegionSelectionStatus col
        in SelectableRegionSelectionStatus.values) {
      final bool same = row == col;
      print('Equality ${row.name} == ${col.name} -> $same');
      cells.add(_buildEqCell(same));
    }
    equalityRows.add(Row(children: cells));
  }

  final Widget equalityHeader = Row(
    children: <Widget>[
      _buildEqLabel(''),
      ...SelectableRegionSelectionStatus.values
          .map((SelectableRegionSelectionStatus s) => _buildEqLabel(s.name)),
    ],
  );

  final Widget equalityMatrix = Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Equality Matrix',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10.0),
        equalityHeader,
        const SizedBox(height: 4.0),
        ...equalityRows,
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 - Switch expressions producing concrete widgets per value
  // ===========================================================================
  print('=== Section 3: switch expressions ===');

  final List<Widget> switchSamples = <Widget>[];
  for (final SelectableRegionSelectionStatus status
      in SelectableRegionSelectionStatus.values) {
    final Widget icon = switch (status) {
      SelectableRegionSelectionStatus.changing =>
        const Icon(Icons.gesture, color: Colors.orange, size: 28.0),
      SelectableRegionSelectionStatus.finalized =>
        const Icon(Icons.check_circle, color: Colors.green, size: 28.0),
    };

    final String headline = switch (status) {
      SelectableRegionSelectionStatus.changing =>
        'A selection gesture is in progress',
      SelectableRegionSelectionStatus.finalized =>
        'The selection has been finalized',
    };

    final Color background = switch (status) {
      SelectableRegionSelectionStatus.changing =>
        Colors.orange.withValues(alpha: 0.07),
      SelectableRegionSelectionStatus.finalized =>
        Colors.green.withValues(alpha: 0.07),
    };

    final double progress = switch (status) {
      SelectableRegionSelectionStatus.changing => 0.55,
      SelectableRegionSelectionStatus.finalized => 1.0,
    };

    print(
        'Switch sample for ${status.name}: progress=$progress headline="$headline"');

    switchSamples.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            icon,
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'SelectableRegionSelectionStatus.${status.name}',
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(headline,
                      style: TextStyle(
                          fontSize: 12.5, color: Colors.grey.shade800)),
                  const SizedBox(height: 6.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6.0,
                      backgroundColor: Colors.grey.shade200,
                      color: status == SelectableRegionSelectionStatus.changing
                          ? Colors.orange
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 4 - Index / name / values introspection
  // ===========================================================================
  print('=== Section 4: enum introspection ===');

  final List<Widget> introspectionRows = <Widget>[];
  for (final SelectableRegionSelectionStatus status
      in SelectableRegionSelectionStatus.values) {
    print(
        'Introspection ${status.name} index=${status.index} toString=$status');
    introspectionRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 60.0,
              child: Text(
                status.index.toString(),
                style: const TextStyle(
                    fontFamily: 'monospace', fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Text(
                status.name,
                style: const TextStyle(
                    fontFamily: 'monospace', fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                status.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget introspectionTable = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(9.0)),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 60.0,
                child: Text('index',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12.0)),
              ),
              Expanded(
                child: Text('name',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12.0)),
              ),
              Expanded(
                flex: 2,
                child: Text('toString()',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12.0)),
              ),
            ],
          ),
        ),
        ...introspectionRows,
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 - ValueNotifier<SelectableRegionSelectionStatus> live demo
  // ===========================================================================
  print('=== Section 5: notifier demo ===');

  final Widget notifierDemo = const _StatusNotifierDemo();

  // ===========================================================================
  // SECTION 6 - Per-value UI reactions table
  // ===========================================================================
  print('=== Section 6: UI reactions per value ===');

  final List<Widget> reactionCards = <Widget>[];
  for (final SelectableRegionSelectionStatus status
      in SelectableRegionSelectionStatus.values) {
    final List<_ReactionEntry> entries = switch (status) {
      SelectableRegionSelectionStatus.changing => const <_ReactionEntry>[
          _ReactionEntry(
              ui: 'Selection handles', detail: 'Visible at drag endpoints'),
          _ReactionEntry(
              ui: 'Highlight', detail: 'Expanding/contracting in real time'),
          _ReactionEntry(
              ui: 'Toolbar', detail: 'Hidden while gesture is active'),
          _ReactionEntry(
              ui: 'Cursor',
              detail: 'May change to selection cursor on desktop'),
          _ReactionEntry(
              ui: 'Listeners',
              detail: 'Receive intermediate ChangeNotifier ticks'),
        ],
      SelectableRegionSelectionStatus.finalized => const <_ReactionEntry>[
          _ReactionEntry(
              ui: 'Selection handles', detail: 'Stable, draggable for resize'),
          _ReactionEntry(
              ui: 'Highlight', detail: 'Stationary on the selected text'),
          _ReactionEntry(
              ui: 'Toolbar', detail: 'Visible with copy / share actions'),
          _ReactionEntry(
              ui: 'Cursor', detail: 'Returns to default text cursor'),
          _ReactionEntry(
              ui: 'Listeners', detail: 'Receive a final settled value'),
        ],
    };

    final Color accent = switch (status) {
      SelectableRegionSelectionStatus.changing => Colors.orange,
      SelectableRegionSelectionStatus.finalized => Colors.green,
    };

    print('Reaction card for ${status.name} accent=$accent');

    reactionCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: accent.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: accent),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Status: ${status.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ),
                ],
              ),
            ),
            ...entries.map((_ReactionEntry e) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 7.0),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade100)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          e.ui,
                          style: const TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          e.detail,
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 7 - State machine transitions diagram
  // ===========================================================================
  print('=== Section 7: state machine ===');

  final List<_StatusTransition> transitions = <_StatusTransition>[
    _StatusTransition(
      from: SelectableRegionSelectionStatus.finalized,
      to: SelectableRegionSelectionStatus.changing,
      trigger: 'Pointer down + drag begins',
    ),
    _StatusTransition(
      from: SelectableRegionSelectionStatus.changing,
      to: SelectableRegionSelectionStatus.changing,
      trigger: 'Drag continues - notifier ticks again',
    ),
    _StatusTransition(
      from: SelectableRegionSelectionStatus.changing,
      to: SelectableRegionSelectionStatus.finalized,
      trigger: 'Pointer up - selection settles',
    ),
    _StatusTransition(
      from: SelectableRegionSelectionStatus.finalized,
      to: SelectableRegionSelectionStatus.changing,
      trigger: 'Drag a handle to resize selection',
    ),
    _StatusTransition(
      from: SelectableRegionSelectionStatus.finalized,
      to: SelectableRegionSelectionStatus.finalized,
      trigger: 'Tap outside - same finalized state',
    ),
  ];

  final List<Widget> transitionTiles = <Widget>[];
  for (int i = 0; i < transitions.length; i++) {
    final _StatusTransition t = transitions[i];

    final Color fromColor =
        t.from == SelectableRegionSelectionStatus.changing
            ? Colors.orange
            : Colors.green;
    final Color toColor = t.to == SelectableRegionSelectionStatus.changing
        ? Colors.orange
        : Colors.green;

    print(
        'Transition ${i + 1}: ${t.from.name} -> ${t.to.name} via "${t.trigger}"');

    transitionTiles.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: <Widget>[
            _statusBadge(t.from, fromColor),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.arrow_forward, size: 16.0, color: Colors.grey),
            ),
            _statusBadge(t.to, toColor),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                t.trigger,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget stateMachineDiagram = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Selection Lifecycle State Machine',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bigStateBubble(SelectableRegionSelectionStatus.finalized,
                Colors.green, Icons.check_circle_outline),
            const Icon(Icons.swap_horiz, color: Colors.grey, size: 24.0),
            _bigStateBubble(SelectableRegionSelectionStatus.changing,
                Colors.orange, Icons.gesture),
          ],
        ),
        const SizedBox(height: 12.0),
        ...transitionTiles,
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 - Toggle simulator (live state-driven UI changes)
  // ===========================================================================
  print('=== Section 8: toggle simulator ===');

  final Widget toggleSimulator = const _StatusToggleSimulator();

  // ===========================================================================
  // SECTION 9 - Listener-based event log demo
  // ===========================================================================
  print('=== Section 9: listener event log ===');

  final Widget listenerDemo = const _StatusListenerLog();

  // ===========================================================================
  // SECTION 10 - Pattern matching helpers (when clauses, isXyz getters)
  // ===========================================================================
  print('=== Section 10: pattern matching helpers ===');

  final List<Widget> patternHelperCards = <Widget>[];
  for (final SelectableRegionSelectionStatus status
      in SelectableRegionSelectionStatus.values) {
    final bool isChanging =
        status == SelectableRegionSelectionStatus.changing;
    final bool isFinalized =
        status == SelectableRegionSelectionStatus.finalized;
    final String guardSummary = switch (status) {
      SelectableRegionSelectionStatus.changing when isChanging =>
        'Active gesture - block toolbar updates',
      SelectableRegionSelectionStatus.finalized when isFinalized =>
        'Stable selection - safe to show toolbar',
      // Required by exhaustive switch with when-clause; should be unreachable.
      // ignore: unreachable_switch_default
      _ => 'unreachable',
    };

    print(
        'Pattern helpers for ${status.name}: isChanging=$isChanging isFinalized=$isFinalized');

    patternHelperCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SelectableRegionSelectionStatus.${status.name}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
            const SizedBox(height: 6.0),
            Row(
              children: <Widget>[
                _booleanChip('isChanging', isChanging),
                const SizedBox(width: 8.0),
                _booleanChip('isFinalized', isFinalized),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              guardSummary,
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 11 - Code snippet showcase
  // ===========================================================================
  print('=== Section 11: code snippets ===');

  final List<String> switchSnippetLines = <String>[
    'Widget renderForStatus(SelectableRegionSelectionStatus status) {',
    '  return switch (status) {',
    '    SelectableRegionSelectionStatus.changing =>',
    '      const CircularProgressIndicator(),',
    '    SelectableRegionSelectionStatus.finalized =>',
    '      const Icon(Icons.check, color: Colors.green),',
    '  };',
    '}',
  ];

  final List<String> listenerSnippetLines = <String>[
    'final notifier = SelectableRegionSelectionStatusScope.maybeOf(context);',
    'notifier?.addListener(() {',
    '  switch (notifier.value) {',
    '    case SelectableRegionSelectionStatus.changing:',
    '      _hideToolbar();',
    '    case SelectableRegionSelectionStatus.finalized:',
    '      _showToolbar();',
    '  }',
    '});',
  ];

  final Widget codeBlocks = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _codeBlock('Switch expression', switchSnippetLines, Colors.deepPurple),
      const SizedBox(height: 12.0),
      _codeBlock('Listener via scope', listenerSnippetLines, Colors.indigo),
    ],
  );

  // ===========================================================================
  // SECTION 12 - Comparison with related ValueListenable enums
  // ===========================================================================
  print('=== Section 12: comparison ===');

  final List<Map<String, String>> analogies = <Map<String, String>>[
    <String, String>{
      'enum': 'AnimationStatus',
      'values': 'dismissed | forward | reverse | completed',
      'parallel': 'changing ~ forward/reverse, finalized ~ dismissed/completed',
    },
    <String, String>{
      'enum': 'ConnectionState',
      'values': 'none | waiting | active | done',
      'parallel': 'changing ~ active, finalized ~ done',
    },
    <String, String>{
      'enum': 'SnackBarClosedReason',
      'values': 'action | dismiss | hide | remove | swipe | timeout',
      'parallel': 'finalized maps to terminal closed reasons',
    },
    <String, String>{
      'enum': 'AppLifecycleState',
      'values': 'inactive | resumed | paused | detached | hidden',
      'parallel': 'changing ~ inactive, finalized ~ resumed/paused',
    },
  ];

  final List<Widget> analogyCards = <Widget>[];
  for (final Map<String, String> a in analogies) {
    print('Analogy: ${a['enum']}');
    analogyCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              color: Colors.deepPurple.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              a['enum']!,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 13.0,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              a['values']!,
              style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700),
            ),
            const SizedBox(height: 4.0),
            Text(
              a['parallel']!,
              style: TextStyle(
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepPurple.shade700),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 13 - Platform-aware advice (uses Theme.of platform)
  // ===========================================================================
  print('=== Section 13: platform advice ===');

  final String platformAdvice = switch (platform) {
    TargetPlatform.android =>
      'On Android, expect frequent changing ticks during touch drag and a single finalized tick on lift.',
    TargetPlatform.iOS =>
      'On iOS, magnifier-driven drags emit a burst of changing values; finalized arrives when the bubble resolves.',
    TargetPlatform.macOS =>
      'On macOS, mouse drags continually emit changing; release emits finalized. Cmd+A jumps directly to finalized.',
    TargetPlatform.windows =>
      'On Windows, click+drag emits changing; mouse-up emits finalized. Shift+arrow keys produce a rapid sequence ending in finalized.',
    TargetPlatform.linux =>
      'On Linux, gtk text gestures emit changing during drag and finalized on release.',
    TargetPlatform.fuchsia =>
      'Fuchsia behaves similarly to other desktop targets - changing during drag, finalized on release.',
  };

  print('Platform advice: $platformAdvice');

  final Widget platformCard = Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.amber.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.devices, color: Colors.amber, size: 18.0),
            const SizedBox(width: 8.0),
            Text(
              'Platform: ${platform.name}',
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 13.0),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          platformAdvice,
          style: TextStyle(
              fontSize: 12.5, color: Colors.grey.shade800, height: 1.35),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 14 - Multi-listener fan-out simulator
  // ===========================================================================
  print('=== Section 14: multi-listener ===');

  final Widget multiListenerDemo = const _MultiListenerSimulator();

  // ===========================================================================
  // SECTION 15 - Hypothetical extension methods
  // ===========================================================================
  print('=== Section 15: extension methods ===');

  final List<Widget> extensionRows = <Widget>[];
  for (final SelectableRegionSelectionStatus status
      in SelectableRegionSelectionStatus.values) {
    final String shortLabel = switch (status) {
      SelectableRegionSelectionStatus.changing => 'C',
      SelectableRegionSelectionStatus.finalized => 'F',
    };
    final String emoji = switch (status) {
      SelectableRegionSelectionStatus.changing => '~',
      SelectableRegionSelectionStatus.finalized => '#',
    };
    final int weight = switch (status) {
      SelectableRegionSelectionStatus.changing => 1,
      SelectableRegionSelectionStatus.finalized => 2,
    };

    print(
        'Extension row ${status.name}: short=$shortLabel emoji=$emoji weight=$weight');

    extensionRows.add(
      Container(
        margin: const EdgeInsets.only(bottom: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 110.0,
              child: Text(
                status.name,
                style: const TextStyle(
                    fontFamily: 'monospace', fontWeight: FontWeight.w700),
              ),
            ),
            _smallChip('short', shortLabel),
            const SizedBox(width: 6.0),
            _smallChip('mark', emoji),
            const SizedBox(width: 6.0),
            _smallChip('weight', weight.toString()),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 16 - Summary
  // ===========================================================================
  print('=== Section 16: summary ===');

  final List<Map<String, dynamic>> summary = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.format_list_numbered,
      'text':
          'Two-value enum: SelectableRegionSelectionStatus.changing and .finalized.',
    },
    <String, dynamic>{
      'icon': Icons.swap_horiz,
      'text':
          'Selection toggles between the two values across the gesture lifecycle.',
    },
    <String, dynamic>{
      'icon': Icons.notifications_active,
      'text':
          'Exposed as a ValueListenable via SelectableRegionSelectionStatusScope.',
    },
    <String, dynamic>{
      'icon': Icons.code,
      'text':
          'Compatible with Dart 3 exhaustive switch statements and expressions.',
    },
    <String, dynamic>{
      'icon': Icons.layers,
      'text':
          'Often consumed via SelectableRegionSelectionStatusScope.maybeOf(context).',
    },
    <String, dynamic>{
      'icon': Icons.memory,
      'text':
          'The notifier asserts that finalized only follows changing - this enforces lifecycle ordering.',
    },
  ];

  final List<Widget> summaryCards = <Widget>[];
  for (final Map<String, dynamic> s in summary) {
    summaryCards.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(s['icon'] as IconData, size: 16.0, color: Colors.deepPurple),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                s['text'] as String,
                style: TextStyle(
                    fontSize: 12.5, color: Colors.grey.shade800, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // FINAL ASSEMBLY - one continuous SingleChildScrollView per the harness rules
  // ===========================================================================
  print('Assembling final widget tree');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SelectableRegionSelectionStatus Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.deepPurple,
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectableRegionSelectionStatus'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _sectionHeader(
                  '1. State catalog',
                  'Each enum value rendered with switch-expression-driven '
                      'icon, headline, color, and progress.'),
              ...stateCatalog,
              const SizedBox(height: 24.0),
              _sectionHeader('2. Equality matrix',
                  'Pair-wise == comparisons across SelectableRegionSelectionStatus.values.'),
              equalityMatrix,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '3. Switch expression demo',
                  'Switch expressions returning concrete widgets per enum '
                      'value.'),
              ...switchSamples,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '4. Enum introspection',
                  '.index, .name, and .toString() for every value, plus '
                      'SelectableRegionSelectionStatus.values listing.'),
              introspectionTable,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '5. ValueNotifier demo',
                  'A live ValueNotifier<SelectableRegionSelectionStatus> '
                      'with a listener that branches on every value.'),
              notifierDemo,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '6. UI reactions',
                  'Per-status table of how surrounding widgets react when '
                      'the notifier changes.'),
              ...reactionCards,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '7. State machine',
                  'Transitions between changing and finalized, with the '
                      'self-loops the notifier permits.'),
              stateMachineDiagram,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '8. Toggle simulator',
                  'Tap to flip between changing and finalized; UI reacts '
                      'live to each value.'),
              toggleSimulator,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '9. Listener event log',
                  'A multi-tick listener that records every status emission '
                      'into a scrolling log.'),
              listenerDemo,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '10. Pattern matching helpers',
                  'isChanging / isFinalized predicates and switch '
                      'when-clauses.'),
              ...patternHelperCards,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '11. Code patterns',
                  'Idiomatic snippets showing switch expressions and '
                      'listener wiring with scope.'),
              codeBlocks,
              const SizedBox(height: 24.0),
              _sectionHeader('12. Related enums',
                  'How the two-value enum compares to other Flutter status enums.'),
              ...analogyCards,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '13. Platform-aware advice',
                  'Different gesture sources emit changing/finalized at '
                      'different cadences.'),
              platformCard,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '14. Multi-listener fan-out',
                  'Several independent listeners each branching on the '
                      'enum value.'),
              multiListenerDemo,
              const SizedBox(height: 24.0),
              _sectionHeader(
                  '15. Extension-style helpers',
                  'Hypothetical short label, mark, and weight derived from '
                      'each enum value.'),
              ...extensionRows,
              const SizedBox(height: 24.0),
              _sectionHeader('16. Summary', 'Key facts about the enum.'),
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Colors.deepPurple.withValues(alpha: 0.2)),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.deepPurple.withValues(alpha: 0.04),
                      Colors.indigo.withValues(alpha: 0.04),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: summaryCards,
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// Helpers
// ===========================================================================

/// Builds the catalog card for one [SelectableRegionSelectionStatus] using a
/// live switch on the value. Every branch produces real Widgets compiled into
/// the program.
Widget _buildStatusCatalogCard(
    SelectableRegionSelectionStatus status, bool isMobile) {
  final IconData icon = switch (status) {
    SelectableRegionSelectionStatus.changing => Icons.gesture,
    SelectableRegionSelectionStatus.finalized => Icons.check_circle_outline,
  };

  final Color color = switch (status) {
    SelectableRegionSelectionStatus.changing => Colors.orange,
    SelectableRegionSelectionStatus.finalized => Colors.green,
  };

  final String subtitle = switch (status) {
    SelectableRegionSelectionStatus.changing =>
      'Active - selection is being updated',
    SelectableRegionSelectionStatus.finalized =>
      'Settled - selection is no longer changing',
  };

  final String description = switch (status) {
    SelectableRegionSelectionStatus.changing =>
      'A SelectableRegions selection is "changing" while the user is '
          'actively updating it through gestures (drag) or keyboard '
          'shortcuts (Shift+arrow). Listeners receive frequent ticks while '
          'this state is active.',
    SelectableRegionSelectionStatus.finalized =>
      'A SelectableRegions selection is "finalized" once it stops being '
          'updated by the user. This happens on mouse-up, long-press end, '
          'a single click that collapses, double click for word, triple for '
          'paragraph, or Ctrl/Cmd+A for select-all.',
  };

  final String mobileNote = switch (status) {
    SelectableRegionSelectionStatus.changing =>
      isMobile ? 'Mobile: drag handle bubbles emit many ticks.' : '',
    SelectableRegionSelectionStatus.finalized =>
      isMobile ? 'Mobile: tap to collapse jumps directly to finalized.' : '',
  };

  return Container(
    margin: const EdgeInsets.only(bottom: 14.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.05),
          color.withValues(alpha: 0.12),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(11.0)),
          ),
          child: Row(
            children: <Widget>[
              Icon(icon, color: color, size: 26.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'SelectableRegionSelectionStatus.${status.name}',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                        color: color,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 11.5,
                          color: color.withValues(alpha: 0.85)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'index ${status.index}',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                description,
                style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey.shade800,
                    height: 1.4),
              ),
              if (mobileNote.isNotEmpty) ...<Widget>[
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    mobileNote,
                    style: TextStyle(
                        fontSize: 11.0,
                        color: color,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildEqLabel(String text) {
  return Container(
    width: 96.0,
    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    alignment: Alignment.center,
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _buildEqCell(bool same) {
  return Container(
    width: 96.0,
    height: 32.0,
    margin: const EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      color: same
          ? Colors.green.withValues(alpha: 0.18)
          : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(
        color: same ? Colors.green : Colors.grey.shade300,
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      same ? 'true' : 'false',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        color: same ? Colors.green.shade800 : Colors.grey.shade600,
      ),
    ),
  );
}

Widget _statusBadge(SelectableRegionSelectionStatus status, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      status.name,
      style: TextStyle(
        fontSize: 11.5,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w700,
        color: color,
      ),
    ),
  );
}

Widget _bigStateBubble(
    SelectableRegionSelectionStatus status, Color color, IconData icon) {
  return Column(
    children: <Widget>[
      Container(
        width: 72.0,
        height: 72.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.15),
          border: Border.all(color: color, width: 2.0),
        ),
        child: Center(child: Icon(icon, color: color, size: 28.0)),
      ),
      const SizedBox(height: 6.0),
      Text(
        status.name,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

Widget _booleanChip(String label, bool value) {
  final Color color = value ? Colors.green : Colors.grey;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          value ? Icons.check : Icons.close,
          size: 12.0,
          color: color,
        ),
        const SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _smallChip(String label, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: Colors.indigo.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Colors.indigo,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 10.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            color: Colors.indigo,
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String title, List<String> lines, Color accent) {
  final List<Widget> rendered = <Widget>[];
  for (int i = 0; i < lines.length; i++) {
    final String line = lines[i];
    final bool isKey = line.contains('SelectableRegionSelectionStatus');
    rendered.add(
      Row(
        children: <Widget>[
          SizedBox(
            width: 28.0,
            child: Text(
              '${i + 1}',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              color: isKey
                  ? accent.withValues(alpha: 0.12)
                  : Colors.transparent,
              child: Text(
                line,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color:
                      isKey ? accent : Colors.grey.shade800,
                  fontWeight:
                      isKey ? FontWeight.w800 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: accent, size: 18.0),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: accent, fontSize: 13.0),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ...rendered,
      ],
    ),
  );
}

Widget _sectionHeader(String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: const Border(
            left: BorderSide(color: Colors.deepPurple, width: 3.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
                color: Colors.deepPurple),
          ),
          if (body.isNotEmpty) ...<Widget>[
            const SizedBox(height: 4.0),
            Text(
              body,
              style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade700,
                  height: 1.4),
            ),
          ],
        ],
      ),
    ),
  );
}

// =============================================================================
// Plain data holders
// =============================================================================

/// Per-status reaction row used in section 6.
class _ReactionEntry {
  const _ReactionEntry({required this.ui, required this.detail});
  final String ui;
  final String detail;
}

/// Edge in the lifecycle diagram used in section 7.
class _StatusTransition {
  const _StatusTransition({
    required this.from,
    required this.to,
    required this.trigger,
  });
  final SelectableRegionSelectionStatus from;
  final SelectableRegionSelectionStatus to;
  final String trigger;
}

// =============================================================================
// Live ValueNotifier demo (section 5)
// =============================================================================

class _StatusNotifierDemo extends StatefulWidget {
  const _StatusNotifierDemo();

  @override
  State<_StatusNotifierDemo> createState() => _StatusNotifierDemoState();
}

class _StatusNotifierDemoState extends State<_StatusNotifierDemo> {
  late final ValueNotifier<SelectableRegionSelectionStatus> _notifier;
  int _changes = 0;
  String _lastTransitionLabel = 'initial';

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<SelectableRegionSelectionStatus>(
      SelectableRegionSelectionStatus.finalized,
    );
    _notifier.addListener(_onStatusChanged);
  }

  void _onStatusChanged() {
    final SelectableRegionSelectionStatus current = _notifier.value;
    // Real branching on the enum, not just printing.
    final String label = switch (current) {
      SelectableRegionSelectionStatus.changing =>
        'started or continued changing',
      SelectableRegionSelectionStatus.finalized => 'settled to finalized',
    };
    print('NotifierDemo listener fired: ${current.name} ($label)');
    setState(() {
      _changes++;
      _lastTransitionLabel = label;
    });
  }

  void _push(SelectableRegionSelectionStatus next) {
    print('NotifierDemo pushing ${next.name}');
    _notifier.value = next;
  }

  @override
  void dispose() {
    _notifier.removeListener(_onStatusChanged);
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SelectableRegionSelectionStatus>(
      valueListenable: _notifier,
      builder: (BuildContext context, SelectableRegionSelectionStatus value,
          Widget? _) {
        // Live switch in the build method.
        final Color color = switch (value) {
          SelectableRegionSelectionStatus.changing => Colors.orange,
          SelectableRegionSelectionStatus.finalized => Colors.green,
        };
        final IconData icon = switch (value) {
          SelectableRegionSelectionStatus.changing => Icons.gesture,
          SelectableRegionSelectionStatus.finalized => Icons.check_circle,
        };
        final String narration = switch (value) {
          SelectableRegionSelectionStatus.changing =>
            'Listeners receive intermediate ticks while the gesture is alive.',
          SelectableRegionSelectionStatus.finalized =>
            'Listeners receive a settled value - safe to compute toolbars.',
        };

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: color.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: color, size: 28.0),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Notifier value: ${value.name}',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0,
                          color: color),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'changes: $_changes',
                      style: TextStyle(
                          fontSize: 11.0, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                narration,
                style: TextStyle(
                    fontSize: 12.5, color: Colors.grey.shade800, height: 1.35),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Last transition: $_lastTransitionLabel',
                style: TextStyle(
                    fontSize: 11.5, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    icon: const Icon(Icons.gesture),
                    label: const Text('Push changing'),
                    onPressed: () =>
                        _push(SelectableRegionSelectionStatus.changing),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Push finalized'),
                    onPressed: () =>
                        _push(SelectableRegionSelectionStatus.finalized),
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

// =============================================================================
// Toggle simulator (section 8)
// =============================================================================

class _StatusToggleSimulator extends StatefulWidget {
  const _StatusToggleSimulator();

  @override
  State<_StatusToggleSimulator> createState() =>
      _StatusToggleSimulatorState();
}

class _StatusToggleSimulatorState extends State<_StatusToggleSimulator> {
  SelectableRegionSelectionStatus _status =
      SelectableRegionSelectionStatus.finalized;

  void _flip() {
    setState(() {
      // Real switch driving the next state.
      _status = switch (_status) {
        SelectableRegionSelectionStatus.changing =>
          SelectableRegionSelectionStatus.finalized,
        SelectableRegionSelectionStatus.finalized =>
          SelectableRegionSelectionStatus.changing,
      };
      print('Toggle simulator flipped to ${_status.name}');
    });
  }

  void _setExplicit(SelectableRegionSelectionStatus s) {
    setState(() {
      _status = s;
      print('Toggle simulator explicitly set to ${s.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color color = switch (_status) {
      SelectableRegionSelectionStatus.changing => Colors.orange,
      SelectableRegionSelectionStatus.finalized => Colors.green,
    };

    final IconData icon = switch (_status) {
      SelectableRegionSelectionStatus.changing => Icons.gesture,
      SelectableRegionSelectionStatus.finalized => Icons.check_circle_outline,
    };

    final String reactiveBody = switch (_status) {
      SelectableRegionSelectionStatus.changing =>
        'A SelectionToolbar would be hidden right now. Live highlight visible.',
      SelectableRegionSelectionStatus.finalized =>
        'A SelectionToolbar can render here with copy / share / select all.',
    };

    final List<Widget> reactiveButtons = switch (_status) {
      SelectableRegionSelectionStatus.changing => <Widget>[
          OutlinedButton(
            onPressed: null,
            child: const Text('Copy (disabled while changing)'),
          ),
          const SizedBox(width: 8.0),
          OutlinedButton(
            onPressed: null,
            child: const Text('Share (disabled while changing)'),
          ),
        ],
      SelectableRegionSelectionStatus.finalized => <Widget>[
          OutlinedButton.icon(
            icon: const Icon(Icons.copy),
            label: const Text('Copy'),
            onPressed: () => print('Copy pressed (status=finalized)'),
          ),
          const SizedBox(width: 8.0),
          OutlinedButton.icon(
            icon: const Icon(Icons.share),
            label: const Text('Share'),
            onPressed: () => print('Share pressed (status=finalized)'),
          ),
        ],
    };

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.15),
              border: Border.all(color: color, width: 3.0),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(icon, color: color, size: 32.0),
                  const SizedBox(height: 4.0),
                  Text(
                    _status.name,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _flip,
                child: const Text('Flip'),
              ),
              OutlinedButton(
                onPressed: () =>
                    _setExplicit(SelectableRegionSelectionStatus.changing),
                child: const Text('Set changing'),
              ),
              OutlinedButton(
                onPressed: () =>
                    _setExplicit(SelectableRegionSelectionStatus.finalized),
                child: const Text('Set finalized'),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  reactiveBody,
                  style: TextStyle(
                      fontSize: 12.5,
                      color: color.withValues(alpha: 0.95),
                      height: 1.35),
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: reactiveButtons,
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
// Listener event log (section 9)
// =============================================================================

class _StatusListenerLog extends StatefulWidget {
  const _StatusListenerLog();

  @override
  State<_StatusListenerLog> createState() => _StatusListenerLogState();
}

class _StatusListenerLogState extends State<_StatusListenerLog> {
  late final ValueNotifier<SelectableRegionSelectionStatus> _notifier;
  final List<_LogEntry> _log = <_LogEntry>[];
  int _seq = 0;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<SelectableRegionSelectionStatus>(
      SelectableRegionSelectionStatus.finalized,
    );
    _notifier.addListener(_onTick);
  }

  void _onTick() {
    final SelectableRegionSelectionStatus value = _notifier.value;
    // Branching: each value gets distinct log treatment.
    final String tag = switch (value) {
      SelectableRegionSelectionStatus.changing => 'tick',
      SelectableRegionSelectionStatus.finalized => 'settle',
    };
    final IconData icon = switch (value) {
      SelectableRegionSelectionStatus.changing => Icons.timeline,
      SelectableRegionSelectionStatus.finalized => Icons.flag,
    };
    final Color color = switch (value) {
      SelectableRegionSelectionStatus.changing => Colors.orange,
      SelectableRegionSelectionStatus.finalized => Colors.green,
    };
    setState(() {
      _seq++;
      _log.insert(
          0,
          _LogEntry(
            seq: _seq,
            value: value,
            tag: tag,
            icon: icon,
            color: color,
          ));
      while (_log.length > 12) {
        _log.removeLast();
      }
    });
    print(
        'StatusListenerLog tick #$_seq tag=$tag value=${value.name}');
  }

  @override
  void dispose() {
    _notifier.removeListener(_onTick);
    _notifier.dispose();
    super.dispose();
  }

  void _simulateGesture() {
    print('Simulating a full gesture: changing*3 then finalized');
    // Three "changing" emissions then a "finalized" emission. Use the value
    // setter directly so the assert in real-world notifier is mirrored.
    _notifier.value = SelectableRegionSelectionStatus.changing;
    Future<void>.delayed(const Duration(milliseconds: 80)).then((_) {
      if (!mounted) return;
      _notifier.notifyListenersDirect();
    });
    Future<void>.delayed(const Duration(milliseconds: 160)).then((_) {
      if (!mounted) return;
      _notifier.notifyListenersDirect();
    });
    Future<void>.delayed(const Duration(milliseconds: 240)).then((_) {
      if (!mounted) return;
      _notifier.value = SelectableRegionSelectionStatus.finalized;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.list_alt, color: Colors.deepPurple),
              const SizedBox(width: 8.0),
              const Text(
                'Listener event log',
                style:
                    TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Simulate gesture'),
                onPressed: _simulateGesture,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          if (_log.isEmpty)
            Text(
              'No events yet. Tap "Simulate gesture" to push values.',
              style: TextStyle(
                  fontSize: 12.0, color: Colors.grey.shade500),
            )
          else
            Column(
              children: _log.map((_LogEntry e) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 4.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: e.color.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                        color: e.color.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(e.icon, color: e.color, size: 16.0),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        width: 50.0,
                        child: Text(
                          '#${e.seq}',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: e.color.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          e.tag,
                          style: TextStyle(
                              fontSize: 10.5,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w700,
                              color: e.color),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          e.value.name,
                          style: TextStyle(
                              fontSize: 11.5,
                              fontFamily: 'monospace',
                              color: e.color),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _LogEntry {
  const _LogEntry({
    required this.seq,
    required this.value,
    required this.tag,
    required this.icon,
    required this.color,
  });
  final int seq;
  final SelectableRegionSelectionStatus value;
  final String tag;
  final IconData icon;
  final Color color;
}

// Helper extension: re-fires listeners without changing the ValueNotifier
// stored value. Used by the listener log demo to simulate a stream of
// changing ticks (the real notifier emits ticks even when the value stays
// "changing" because gesture deltas keep arriving).
extension _ValueNotifierRefire<T> on ValueNotifier<T> {
  void notifyListenersDirect() {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    notifyListeners();
  }
}

// =============================================================================
// Multi-listener simulator (section 14)
// =============================================================================

class _MultiListenerSimulator extends StatefulWidget {
  const _MultiListenerSimulator();

  @override
  State<_MultiListenerSimulator> createState() =>
      _MultiListenerSimulatorState();
}

class _MultiListenerSimulatorState extends State<_MultiListenerSimulator> {
  late final ValueNotifier<SelectableRegionSelectionStatus> _notifier;

  // Each listener slot is independent and reacts differently to the same
  // SelectableRegionSelectionStatus value.
  String _toolbarLabel = 'idle';
  String _highlightLabel = 'none';
  String _hapticLabel = 'no buzz';

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<SelectableRegionSelectionStatus>(
      SelectableRegionSelectionStatus.finalized,
    );
    _notifier.addListener(_toolbarListener);
    _notifier.addListener(_highlightListener);
    _notifier.addListener(_hapticListener);
  }

  void _toolbarListener() {
    setState(() {
      _toolbarLabel = switch (_notifier.value) {
        SelectableRegionSelectionStatus.changing => 'hidden (gesture active)',
        SelectableRegionSelectionStatus.finalized => 'shown (copy/share)',
      };
    });
    print('Toolbar listener: $_toolbarLabel');
  }

  void _highlightListener() {
    setState(() {
      _highlightLabel = switch (_notifier.value) {
        SelectableRegionSelectionStatus.changing => 'pulsing - drag in flight',
        SelectableRegionSelectionStatus.finalized => 'stable selection band',
      };
    });
    print('Highlight listener: $_highlightLabel');
  }

  void _hapticListener() {
    setState(() {
      _hapticLabel = switch (_notifier.value) {
        SelectableRegionSelectionStatus.changing => 'light tick',
        SelectableRegionSelectionStatus.finalized => 'success buzz',
      };
    });
    print('Haptic listener: $_hapticLabel');
  }

  @override
  void dispose() {
    _notifier.removeListener(_toolbarListener);
    _notifier.removeListener(_highlightListener);
    _notifier.removeListener(_hapticListener);
    _notifier.dispose();
    super.dispose();
  }

  void _push(SelectableRegionSelectionStatus s) {
    _notifier.value = s;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.hub, color: Colors.deepPurple),
              const SizedBox(width: 8.0),
              Text(
                'Three listeners on one notifier (current: ${_notifier.value.name})',
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13.0),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          _multiRow('Toolbar', _toolbarLabel, Icons.menu, Colors.indigo),
          _multiRow('Highlight', _highlightLabel, Icons.brush, Colors.teal),
          _multiRow('Haptics', _hapticLabel, Icons.vibration, Colors.pink),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    _push(SelectableRegionSelectionStatus.changing),
                child: const Text('Push changing'),
              ),
              ElevatedButton(
                onPressed: () =>
                    _push(SelectableRegionSelectionStatus.finalized),
                child: const Text('Push finalized'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _multiRow(String name, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: color, size: 18.0),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 90.0,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
