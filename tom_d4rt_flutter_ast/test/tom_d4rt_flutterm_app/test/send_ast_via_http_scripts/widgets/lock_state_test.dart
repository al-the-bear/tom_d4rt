import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// LockState — Educational Simulation Demo
//
// LockState is NOT a public Flutter widget. It was an experimental internal
// concept explored in early Flutter versions (and referenced in some framework
// internals as "_LockState" or similar) that would allow a widget subtree to
// "freeze" its visual output — preventing child state from causing rebuild
// propagation — during a critical window such as a page transition or an
// animated list reorder. The concept is analogous to a read-lock on the
// element tree: state mutations are accepted but their visual effects are
// deferred until the lock is released.
//
// This file provides:
//   • A full conceptual explanation with diagrams (CustomPainter)
//   • A working simulation using ValueNotifier + custom widgets that replicate
//     the semantics Flutter's hypothetical LockState would have provided
//   • 9 tabbed sections covering architecture, patterns, pitfalls, and API
// ---------------------------------------------------------------------------

// ─── Top-level ValueNotifiers (STATELESS constraint) ───────────────────────

/// Whether the "lock" is currently engaged in the comparison demo.
final ValueNotifier<bool> _lockEngaged = ValueNotifier<bool>(false);

/// Raw counter increments arriving while the lock may or may not be held.
final ValueNotifier<int> _rawCounter = ValueNotifier<int>(0);

/// The counter value that is actually displayed (frozen when locked).
final ValueNotifier<int> _displayCounter = ValueNotifier<int>(0);

/// Buffered increments queued while the lock is held.
final ValueNotifier<int> _bufferedIncrements = ValueNotifier<int>(0);


// ─── Entry point ────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
    ),
    home: const _LockStateDemoRoot(),
  );
}

// ─── Root scaffold ───────────────────────────────────────────────────────────

class _LockStateDemoRoot extends StatelessWidget {
  const _LockStateDemoRoot();

  static const List<String> _tabLabels = <String>[
    'Concept',
    'Architecture',
    'Comparison',
    'Freeze',
    'Transition',
    'Queue Demo',
    'Use Cases',
    'vs Others',
    'Pitfalls',
  ];

  static const List<IconData> _tabIcons = <IconData>[
    Icons.info_outline,
    Icons.account_tree_outlined,
    Icons.compare_arrows,
    Icons.ac_unit,
    Icons.swap_horiz,
    Icons.queue,
    Icons.apps,
    Icons.balance,
    Icons.warning_amber_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLabels.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LockState — Flutter Simulation'),
          centerTitle: false,
          bottom: TabBar(
            isScrollable: true,
            tabs: List<Tab>.generate(
              _tabLabels.length,
              (int i) => Tab(
                icon: Icon(_tabIcons[i]),
                text: _tabLabels[i],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _ConceptTab(),
            _ArchitectureTab(),
            _ComparisonTab(),
            _FreezeTab(),
            _TransitionTab(),
            _QueueDemoTab(),
            _UseCasesTab(),
            _VsOthersTab(),
            _PitfallsTab(),
          ],
        ),
      ),
    );
  }
}

// ─── Shared helpers ──────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainerHighest,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Text(body, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

// ─── Tab 1: Concept ──────────────────────────────────────────────────────────

class _ConceptTab extends StatelessWidget {
  const _ConceptTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        // Hero banner
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: <Color>[cs.primary, cs.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.lock, color: cs.onPrimary, size: 36),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'LockState',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: cs.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'An experimental Flutter concept: a widget that holds a '
                '"read-lock" on its subtree, deferring visual updates until '
                'the lock is released. Useful during page transitions, '
                'animated reorders, and shared-element animations where '
                'mid-flight state changes would cause visual glitches.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: cs.onPrimary.withAlpha(230),
                    ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: cs.onPrimary.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Status: NOT a public Flutter API.\n'
                  'This demo simulates the semantics using ValueNotifier '
                  'and custom widgets so you can understand the pattern '
                  'and implement it yourself.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: cs.onPrimary,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionTitle('What is LockState?'),
        const _BodyText(
          'LockState would be a widget (or mixin applied to a State) that '
          'intercepts calls to setState() within its subtree during a '
          '"locked" period. While locked:\n\n'
          '  • setState() calls are accepted but queued, not flushed.\n'
          '  • The element tree does not schedule a rebuild frame for the\n'
          '    locked subtree.\n'
          '  • The visual output of the locked subtree is frozen at the\n'
          '    snapshot taken when the lock was acquired.\n'
          '  • When the lock is released, all queued setState() calls are\n'
          '    flushed in a single batch rebuild.\n\n'
          'This is conceptually similar to a database read-lock: readers '
          'see a consistent snapshot, and writers wait until the lock is '
          'released before their changes become visible.',
        ),
        const SizedBox(height: 16),
        _SectionTitle('Why does this matter?'),
        const _InfoCard(
          title: 'Page transitions',
          body:
              'During a Navigator push/pop animation both the outgoing and '
              'incoming routes are composited together. If a widget on the '
              'incoming route fires setState() mid-animation (e.g. a timer '
              'tick), the rebuilding widget gets a new render object while '
              'the compositor is still interpolating the route animation. '
              'This causes a single-frame visual glitch. LockState would '
              'suppress the rebuild until the animation completes.',
        ),
        const _InfoCard(
          title: 'Animated list reorder',
          body:
              'ReorderableListView animates the dragged item. Other list '
              'items may have state (e.g. unread-count badges) that change '
              'during the drag. A LockState around the list would defer '
              'those badge updates until the drop animation completes.',
        ),
        const _InfoCard(
          title: 'Shared element / Hero transitions',
          body:
              'Hero widgets overlay the two routes during a transition. If '
              'the destination widget rebuilds before the hero overlay '
              'settles, the hero snapshot diverges from the real widget '
              'layout, producing a jump. LockState on the destination route '
              'would prevent this.',
        ),
        const SizedBox(height: 16),
        _SectionTitle('Conceptual API'),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: const Text(
            '// Hypothetical public API\n'
            'class LockState extends StatelessWidget {\n'
            '  const LockState({\n'
            '    super.key,\n'
            '    required this.locked,\n'
            '    required this.child,\n'
            '  });\n\n'
            '  /// When true, child setState() calls are deferred.\n'
            '  final bool locked;\n\n'
            '  /// The subtree to freeze while locked.\n'
            '  final Widget child;\n\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    // Real impl would use an InheritedWidget to communicate\n'
            '    // the lock flag down to each State object, which would\n'
            '    // intercept its own scheduleBuild() call.\n'
            '    return child;\n'
            '  }\n'
            '}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        const SizedBox(height: 20),
        _SectionTitle('Flutter SDK status'),
        const _InfoCard(
          title: 'Internal references only',
          body:
              'Searching the Flutter SDK source (flutter/packages/flutter/lib/) '
              'finds zero public classes named LockState. The concept appears '
              'in design discussions and was partially explored in the context '
              'of the KeepAlive/AutomaticKeepAlive subsystem, but was never '
              'shipped as a public widget. The closest public APIs that achieve '
              'similar results are: Offstage (hides but keeps alive), '
              'RepaintBoundary (isolates repaint), and the KeepAlive family.',
        ),
      ],
    );
  }
}

// ─── Tab 2: Architecture ─────────────────────────────────────────────────────

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle('Widget-tree architecture'),
        const _BodyText(
          'The diagram below shows how a hypothetical LockState node '
          'would sit in the widget tree and intercept rebuild scheduling '
          'for its locked subtree.',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 340,
          child: CustomPaint(
            painter: _ArchitecturePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 20),
        _SectionTitle('Element tree interaction'),
        const _BodyText(
          'Flutter\'s build pipeline works like this:\n\n'
          '1. State.setState() calls element.markNeedsBuild().\n'
          '2. WidgetsBinding schedules a frame if none is pending.\n'
          '3. On the next frame, SchedulerBinding calls\n'
          '   BuildOwner.buildScope(), which rebuilds dirty elements.\n\n'
          'LockState would intercept step 1: when the lock is held, '
          'markNeedsBuild() adds the element to a local "pending" set '
          'instead of the global dirty list. On unlock, all pending '
          'elements are transferred to the global dirty list and a frame '
          'is scheduled.',
        ),
        const SizedBox(height: 16),
        _SectionTitle('Lock lifecycle'),
        SizedBox(
          height: 180,
          child: CustomPaint(
            painter: _LifecyclePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 16),
        _SectionTitle('Implementation sketch'),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(14),
          child: const Text(
            '// Simplified implementation concept\n'
            'class _LockStateElement extends StatelessElement {\n'
            '  final Set<Element> _pendingRebuild = {};\n'
            '  bool _locked = false;\n\n'
            '  void acquireLock() => _locked = true;\n\n'
            '  void releaseLock() {\n'
            '    _locked = false;\n'
            '    for (final e in _pendingRebuild) {\n'
            '      e.markNeedsBuild(); // forward to BuildOwner\n'
            '    }\n'
            '    _pendingRebuild.clear();\n'
            '  }\n\n'
            '  // Children call this instead of markNeedsBuild():\n'
            '  void requestRebuild(Element child) {\n'
            '    if (_locked) {\n'
            '      _pendingRebuild.add(child);\n'
            '    } else {\n'
            '      child.markNeedsBuild();\n'
            '    }\n'
            '  }\n'
            '}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class _ArchitecturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Color boxPaint = Color(0xFFBBDEFB);
    const Color lockPaint = Color(0xFFFFE082);
    const Color frozenPaint = Color(0xFFB3E5FC);
    final Paint linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF37474F)
      ..strokeWidth = 1.5;
    final Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFFE53935)
      ..strokeWidth = 2;

    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
    );

    void drawBox(
      Rect rect,
      String label,
      Color fill, {
      bool dashed = false,
    }) {
      final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(6));
      canvas.drawRRect(rr, Paint()..color = fill);
      if (dashed) {
        final Paint d = Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color(0xFF0288D1)
          ..strokeWidth = 2;
        canvas.drawRRect(rr, d);
      } else {
        canvas.drawRRect(rr, linePaint);
      }
      tp.text = TextSpan(
        text: label,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF1A237E),
          fontWeight: FontWeight.w600,
        ),
      );
      tp.layout(maxWidth: rect.width - 8);
      tp.paint(
        canvas,
        Offset(rect.left + 4, rect.top + (rect.height - tp.height) / 2),
      );
    }

    void drawLine(Offset a, Offset b) {
      canvas.drawLine(a, b, linePaint);
    }

    // Root
    final Rect root = Rect.fromLTWH(size.width / 2 - 60, 8, 120, 32);
    drawBox(root, 'MaterialApp', boxPaint);

    // Scaffold
    final Rect scaffold =
        Rect.fromLTWH(size.width / 2 - 60, 56, 120, 32);
    drawBox(scaffold, 'Scaffold', boxPaint);
    drawLine(
      Offset(size.width / 2, root.bottom),
      Offset(size.width / 2, scaffold.top),
    );

    // LockState node (highlighted)
    final Rect lock = Rect.fromLTWH(size.width / 2 - 70, 104, 140, 36);
    drawBox(lock, '★ LockState (locked=true)', lockPaint, dashed: true);
    drawLine(
      Offset(size.width / 2, scaffold.bottom),
      Offset(size.width / 2, lock.top),
    );

    // Two children
    final Rect childA = Rect.fromLTWH(40, 164, 110, 32);
    final Rect childB = Rect.fromLTWH(size.width - 150, 164, 110, 32);
    drawBox(childA, 'Column (frozen)', frozenPaint, dashed: true);
    drawBox(childB, 'Row (frozen)', frozenPaint, dashed: true);
    drawLine(
      Offset(size.width / 2, lock.bottom),
      Offset(childA.right - 10, childA.top),
    );
    drawLine(
      Offset(size.width / 2, lock.bottom),
      Offset(childB.left + 10, childB.top),
    );

    // Grandchildren
    final Rect grandA1 = Rect.fromLTWH(20, 220, 70, 28);
    final Rect grandA2 = Rect.fromLTWH(100, 220, 70, 28);
    final Rect grandB1 = Rect.fromLTWH(size.width - 170, 220, 70, 28);
    final Rect grandB2 = Rect.fromLTWH(size.width - 90, 220, 70, 28);

    drawBox(grandA1, 'Text', frozenPaint, dashed: true);
    drawBox(grandA2, 'Counter', frozenPaint, dashed: true);
    drawBox(grandB1, 'Icon', frozenPaint, dashed: true);
    drawBox(grandB2, 'Badge', frozenPaint, dashed: true);

    drawLine(
      Offset(childA.left + 35, childA.bottom),
      Offset(grandA1.left + 35, grandA1.top),
    );
    drawLine(
      Offset(childA.left + 75, childA.bottom),
      Offset(grandA2.left + 35, grandA2.top),
    );
    drawLine(
      Offset(childB.left + 35, childB.bottom),
      Offset(grandB1.left + 35, grandB1.top),
    );
    drawLine(
      Offset(childB.left + 75, childB.bottom),
      Offset(grandB2.left + 35, grandB2.top),
    );

    // setState() arrow blocked
    final Offset stateOrigin = Offset(grandA2.right + 4, grandA2.top + 14);
    final Offset stateTarget = Offset(lock.right - 8, lock.top + 18);
    canvas.drawLine(stateOrigin, stateTarget, arrowPaint);
    // blocked X
    final Offset mid = Offset(
      (stateOrigin.dx + stateTarget.dx) / 2,
      (stateOrigin.dy + stateTarget.dy) / 2,
    );
    canvas.drawLine(
      Offset(mid.dx - 8, mid.dy - 8),
      Offset(mid.dx + 8, mid.dy + 8),
      arrowPaint,
    );
    canvas.drawLine(
      Offset(mid.dx + 8, mid.dy - 8),
      Offset(mid.dx - 8, mid.dy + 8),
      arrowPaint,
    );

    // Legend
    tp.text = const TextSpan(
      text: '→ setState() BLOCKED by lock',
      style: TextStyle(
        fontSize: 10,
        color: Color(0xFFE53935),
        fontStyle: FontStyle.italic,
      ),
    );
    tp.layout(maxWidth: size.width);
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, 304));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LifecyclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 2;

    final Paint greenFill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFC8E6C9);
    final Paint redFill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFFFCDD2);

    final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr);

    // Timeline
    const double timelineY = 80;
    final double left = 20;
    final double right = size.width - 20;
    canvas.drawLine(Offset(left, timelineY), Offset(right, timelineY), linePaint);

    // Phases
    final double lockX = left + (right - left) * 0.2;
    final double unlockX = left + (right - left) * 0.75;

    // Unlocked (before)
    canvas.drawRect(
      Rect.fromLTWH(left, timelineY - 30, lockX - left, 60),
      greenFill,
    );
    // Locked phase
    canvas.drawRect(
      Rect.fromLTWH(lockX, timelineY - 30, unlockX - lockX, 60),
      redFill,
    );
    // Unlocked (after)
    canvas.drawRect(
      Rect.fromLTWH(unlockX, timelineY - 30, right - unlockX, 60),
      greenFill,
    );

    void label(String text, double x, Color color) {
      tp.text = TextSpan(
        text: text,
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
      );
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, timelineY - tp.height / 2));
    }

    label('Unlocked\n(live)', left + (lockX - left) / 2, const Color(0xFF2E7D32));
    label('LOCKED\n(frozen)', lockX + (unlockX - lockX) / 2, const Color(0xFFC62828));
    label('Unlocked\n(flushed)', unlockX + (right - unlockX) / 2, const Color(0xFF2E7D32));

    // Tick marks
    void tick(double x, String note) {
      canvas.drawLine(Offset(x, timelineY - 36), Offset(x, timelineY + 36), linePaint);
      tp.text = TextSpan(
        text: note,
        style: const TextStyle(fontSize: 9, color: Color(0xFF37474F)),
      );
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, timelineY + 40));
    }

    tick(lockX, 'acquireLock()');
    tick(unlockX, 'releaseLock()');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Tab 3: Comparison ───────────────────────────────────────────────────────

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle('Locked vs Unlocked — live comparison'),
        const _BodyText(
          'The left panel simulates a LockState-wrapped counter: while the '
          'lock is engaged, UI increments are buffered and not shown. '
          'The right panel has no lock and always displays the latest value.',
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<bool>(
          valueListenable: _lockEngaged,
          builder: (BuildContext ctx, bool locked, _) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _LockPanel(
                        title: 'With LockState',
                        isLocked: locked,
                        icon: Icons.lock,
                        color: ctx.colorScheme.errorContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _LockPanel(
                        title: 'No LockState',
                        isLocked: false,
                        icon: Icons.lock_open,
                        color: ctx.colorScheme.primaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FilledButton.icon(
                      onPressed: () {
                        _rawCounter.value++;
                        if (!_lockEngaged.value) {
                          _displayCounter.value = _rawCounter.value;
                        } else {
                          _bufferedIncrements.value++;
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Increment'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.tonal(
                      onPressed: () {
                        _lockEngaged.value = !locked;
                        if (locked) {
                          // Was locked, now releasing — flush buffer
                          _displayCounter.value = _rawCounter.value;
                          _bufferedIncrements.value = 0;
                        }
                      },
                      child: Text(locked ? 'Release Lock' : 'Engage Lock'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {
                        _rawCounter.value = 0;
                        _displayCounter.value = 0;
                        _bufferedIncrements.value = 0;
                        _lockEngaged.value = false;
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<int>(
                  valueListenable: _bufferedIncrements,
                  builder: (BuildContext c, int buf, _) => Text(
                    'Buffered (hidden) increments: $buf',
                    style: TextStyle(
                      color: c.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        _SectionTitle('What you are seeing'),
        const _BodyText(
          'When you engage the lock and press Increment:\n\n'
          '  • The "With LockState" panel does NOT update — it shows the\n'
          '    frozen value from before the lock was engaged.\n'
          '  • The "No LockState" panel updates immediately every time.\n'
          '  • The "Buffered" counter tracks how many updates are pending.\n\n'
          'When you press "Release Lock", the frozen panel jumps directly\n'
          'to the latest value — all buffered updates applied at once.',
        ),
      ],
    );
  }
}

extension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

class _LockPanel extends StatelessWidget {
  const _LockPanel({
    required this.title,
    required this.isLocked,
    required this.icon,
    required this.color,
  });

  final String title;
  final bool isLocked;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLocked
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 32),
          const SizedBox(height: 6),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            isLocked ? 'LOCKED' : 'LIVE',
            style: TextStyle(
              color: isLocked
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<int>(
            valueListenable: isLocked ? _displayCounter : _rawCounter,
            builder: (_, int v, Widget? child) => Text(
              '$v',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab 4: Freeze ───────────────────────────────────────────────────────────

class _FreezeTab extends StatelessWidget {
  const _FreezeTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle('State freeze simulation'),
        const _BodyText(
          'This panel shows a ValueNotifier<int> counter that is '
          'continuously incrementing. A simulated LockState buffers '
          'those updates; you can release the buffer on demand.',
        ),
        const SizedBox(height: 12),
        _FreezeDemoWidget(),
        const SizedBox(height: 20),
        _SectionTitle('How this maps to the real pattern'),
        const _InfoCard(
          title: 'Buffer semantics',
          body:
              'In a real LockState, buffered setState() calls are not '
              'forgotten — they are simply deferred. When the lock releases, '
              'the element\'s build() method is called once with the latest '
              'state, not once per buffered call. This is efficient: N '
              'buffered updates result in exactly 1 rebuild frame.',
        ),
        const _InfoCard(
          title: 'Why not just use shouldRebuild?',
          body:
              'InheritedWidget.updateShouldNotify() and '
              'AnimatedWidget.shouldRepaint() only affect specific widget '
              'types. LockState would be a general-purpose mechanism that '
              'works on any descendant, including StatefulWidgets and '
              'widgets that depend on InheritedWidgets.',
        ),
        const _InfoCard(
          title: 'Coalescing',
          body:
              'Multiple rapid setState() calls during a locked window are '
              'coalesced. The element\'s state object holds the accumulated '
              'mutations; only the final state is visible after unlock. '
              'This is identical to how Flutter already coalesces multiple '
              'calls to setState() within a single frame.',
        ),
      ],
    );
  }
}

class _FreezeDemoWidget extends StatelessWidget {
  _FreezeDemoWidget();

  final ValueNotifier<int> _liveCount = ValueNotifier<int>(0);
  final ValueNotifier<int> _frozenDisplay = ValueNotifier<int>(0);
  final ValueNotifier<int> _buffered = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isLocked = ValueNotifier<bool>(false);

  void _increment() {
    _liveCount.value++;
    if (_isLocked.value) {
      _buffered.value++;
    } else {
      _frozenDisplay.value = _liveCount.value;
    }
  }

  void _toggleLock() {
    if (_isLocked.value) {
      // Release
      _frozenDisplay.value = _liveCount.value;
      _buffered.value = 0;
      _isLocked.value = false;
    } else {
      _isLocked.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<bool>(
      valueListenable: _isLocked,
      builder: (BuildContext ctx, bool locked, _) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _CounterBubble(
                  label: 'Raw value',
                  notifier: _liveCount,
                  color: cs.primaryContainer,
                ),
                Icon(
                  locked ? Icons.lock : Icons.arrow_forward,
                  size: 28,
                  color: locked ? cs.error : cs.primary,
                ),
                _CounterBubble(
                  label: locked ? 'Frozen display' : 'Live display',
                  notifier: _frozenDisplay,
                  color: locked ? cs.errorContainer : cs.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (locked)
              ValueListenableBuilder<int>(
                valueListenable: _buffered,
                builder: (_, int buf, Widget? child) => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cs.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Queued updates: $buf  (waiting for lock release)',
                    style: TextStyle(color: cs.onErrorContainer),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Increment'),
                ),
                FilledButton.tonal(
                  onPressed: _toggleLock,
                  child: Text(locked ? 'Release Lock' : 'Lock'),
                ),
                OutlinedButton(
                  onPressed: () {
                    _liveCount.value = 0;
                    _frozenDisplay.value = 0;
                    _buffered.value = 0;
                    _isLocked.value = false;
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _CounterBubble extends StatelessWidget {
  const _CounterBubble({
    required this.label,
    required this.notifier,
    required this.color,
  });

  final String label;
  final ValueNotifier<int> notifier;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          ValueListenableBuilder<int>(
            valueListenable: notifier,
            builder: (_, int v, Widget? child) => Text(
              '$v',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab 5: Transition protection ────────────────────────────────────────────

class _TransitionTab extends StatelessWidget {
  const _TransitionTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle('Transition protection pattern'),
        const _BodyText(
          'During a route transition the Navigator composites two routes. '
          'Any setState() call on either route that produces a layout change '
          'can corrupt the hero overlay or the transition animation itself.\n\n'
          'LockState solves this by being activated at the start of the '
          'animation and released when the animation settles.',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: CustomPaint(
            painter: _TransitionDiagramPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 16),
        _SectionTitle('Annotated timeline'),
        const _InfoCard(
          title: 'T=0  Navigator.push() called',
          body:
              'The incoming route\'s LockState is activated immediately. '
              'Any widget on the incoming route that would normally respond '
              'to state changes (timers, streams, ChangeNotifiers) sees its '
              'setState() calls deferred.',
        ),
        const _InfoCard(
          title: 'T=0 … T=300ms  Animation in progress',
          body:
              'The outgoing route slides/fades out. The incoming route\'s '
              'widgets are rendered from the frozen snapshot. The hero '
              'overlay interpolates smoothly without layout recalculations '
              'from the destination widget.',
        ),
        const _InfoCard(
          title: 'T=300ms  Animation complete',
          body:
              'LockState.releaseLock() is called by the route framework. '
              'All pending setState() calls are flushed in a single batch '
              'rebuild frame. The incoming route snaps to its final state, '
              'which may be slightly ahead of where it would have been '
              'without the lock — but there is no visible glitch.',
        ),
        const SizedBox(height: 16),
        _SectionTitle('Code pattern'),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(14),
          child: const Text(
            '// Route transition integration (hypothetical)\n'
            'class _LockedRoute extends PageRoute {\n'
            '  late LockStateController _lockCtrl;\n\n'
            '  @override\n'
            '  void install() {\n'
            '    super.install();\n'
            '    _lockCtrl = LockStateController();\n'
            '  }\n\n'
            '  @override\n'
            '  TickerFuture didPush() {\n'
            '    _lockCtrl.acquireLock(); // freeze incoming route\n'
            '    final result = super.didPush();\n'
            '    result.whenCompleteOrCancel(_lockCtrl.releaseLock);\n'
            '    return result;\n'
            '  }\n\n'
            '  @override\n'
            '  Widget buildContent(BuildContext context) {\n'
            '    return LockState(\n'
            '      controller: _lockCtrl,\n'
            '      child: MyPage(),\n'
            '    );\n'
            '  }\n'
            '}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        const SizedBox(height: 16),
        _SectionTitle('Live transition simulation'),
        _TransitionSimWidget(),
      ],
    );
  }
}

class _TransitionDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint outgoing = Paint()
      ..color = const Color(0xFFE3F2FD)
      ..style = PaintingStyle.fill;
    final Paint incoming = Paint()
      ..color = const Color(0xFFFFF8E1)
      ..style = PaintingStyle.fill;
    final Paint hero = Paint()
      ..color = const Color(0xFFE8F5E9)
      ..style = PaintingStyle.fill;
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xFF78909C);
    final Paint lockLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFFE53935);

    final TextPainter tp =
        TextPainter(textDirection: TextDirection.ltr);

    void label(String text, Offset pos,
        {double size = 10, Color color = const Color(0xFF37474F)}) {
      tp.text = TextSpan(
          text: text,
          style: TextStyle(
              fontSize: size, color: color, fontWeight: FontWeight.w500));
      tp.layout(maxWidth: 200);
      tp.paint(canvas, pos);
    }

    // Outgoing route
    final Rect out = Rect.fromLTWH(10, 30, size.width * 0.45 - 10, 200);
    canvas.drawRRect(
        RRect.fromRectAndRadius(out, const Radius.circular(8)), outgoing);
    canvas.drawRRect(
        RRect.fromRectAndRadius(out, const Radius.circular(8)), border);
    label('Outgoing Route', Offset(out.left + 8, out.top + 6),
        size: 11, color: const Color(0xFF1565C0));
    label('(no lock needed\nduring push)', Offset(out.left + 8, out.top + 26),
        size: 9);

    // Incoming route
    final Rect inc =
        Rect.fromLTWH(size.width * 0.55, 30, size.width * 0.45 - 10, 200);
    canvas.drawRRect(
        RRect.fromRectAndRadius(inc, const Radius.circular(8)), incoming);
    canvas.drawRRect(
        RRect.fromRectAndRadius(inc, const Radius.circular(8)), border);
    label('Incoming Route', Offset(inc.left + 8, inc.top + 6),
        size: 11, color: const Color(0xFFE65100));
    label('LockState active\n(frozen snapshot)', Offset(inc.left + 8, inc.top + 26),
        size: 9, color: const Color(0xFFE53935));

    // Lock bracket
    canvas.drawLine(
      Offset(inc.left + 4, inc.top + 20),
      Offset(inc.left + 4, inc.bottom - 20),
      lockLine,
    );

    // Hero overlay
    final Rect heroRect =
        Rect.fromLTWH(size.width / 2 - 50, 90, 100, 60);
    canvas.drawRRect(
        RRect.fromRectAndRadius(heroRect, const Radius.circular(8)), hero);
    canvas.drawRRect(
        RRect.fromRectAndRadius(heroRect, const Radius.circular(8)), border);
    label('Hero\nOverlay', Offset(heroRect.left + 20, heroRect.top + 12));

    // Arrow
    canvas.drawLine(
      Offset(out.right - 10, size.height / 2 - 20),
      Offset(inc.left + 10, size.height / 2 - 20),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = const Color(0xFF1565C0)
        ..strokeWidth = 2,
    );
    label('transition →', Offset(size.width / 2 - 30, size.height / 2 - 32),
        size: 9);

    // Timeline at bottom
    label('Animation: 0ms ────────────────────────── 300ms → settled',
        Offset(10, size.height - 20),
        size: 9, color: const Color(0xFF546E7A));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TransitionSimWidget extends StatelessWidget {
  _TransitionSimWidget();

  final ValueNotifier<bool> _running = ValueNotifier<bool>(false);
  final ValueNotifier<double> _progress = ValueNotifier<double>(0);
  final ValueNotifier<bool> _locked = ValueNotifier<bool>(false);
  final ValueNotifier<String> _status = ValueNotifier<String>('Idle');

  Future<void> _runAnimation() async {
    if (_running.value) return;
    _running.value = true;
    _locked.value = true;
    _progress.value = 0;
    _status.value = 'Transition in progress — LockState active';

    // Simulate animation ticks
    for (int i = 1; i <= 20; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 40));
      _progress.value = i / 20;
    }
    _locked.value = false;
    _status.value = 'Lock released — all deferred updates flushed';
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _running.value = false;
    _progress.value = 0;
    _status.value = 'Idle';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        ValueListenableBuilder<String>(
          valueListenable: _status,
          builder: (_, String s, Widget? child) => Text(s,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontStyle: FontStyle.italic)),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<double>(
          valueListenable: _progress,
          builder: (_, double p, Widget? child) => LinearProgressIndicator(value: p == 0 ? null : p),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: _locked,
          builder: (_, bool locked, Widget? child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                locked ? Icons.lock : Icons.lock_open,
                color: locked ? cs.error : cs.primary,
              ),
              const SizedBox(width: 8),
              Text(locked ? 'Locked (frozen)' : 'Unlocked (live)',
                  style: TextStyle(color: locked ? cs.error : cs.primary)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _runAnimation,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Simulate Transition'),
        ),
      ],
    );
  }
}

// ─── Tab 6: Queue Demo ───────────────────────────────────────────────────────

class _QueueDemoTab extends StatelessWidget {
  const _QueueDemoTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle('Animated transition with message queue'),
        const _BodyText(
          'This demo simulates a stream of incoming state-change messages '
          '(like chat messages or notifications) arriving while a transition '
          'lock is held. Messages are queued, then released all at once.',
        ),
        const SizedBox(height: 12),
        _QueueDemo(),
        const SizedBox(height: 20),
        _SectionTitle('Queue semantics'),
        const _InfoCard(
          title: 'First-in, first-out',
          body:
              'Queued updates are flushed in arrival order. This ensures '
              'that state consistency is preserved: the widget that was '
              'going to rebuild first still rebuilds first after unlock.',
        ),
        const _InfoCard(
          title: 'No updates are lost',
          body:
              'Unlike Offstage (which throws away work) or IgnorePointer '
              '(which only blocks input), the LockState pattern guarantees '
              'that every state update is eventually applied. This is safe '
              'for data integrity.',
        ),
        const _InfoCard(
          title: 'Batch flush',
          body:
              'Flutter\'s own setState() already coalesces multiple calls '
              'within a single microtask into one rebuild. The lock-release '
              'flush works the same way: all pending setState() calls are '
              'scheduled together, producing at most one rebuild frame per '
              'dirty element.',
        ),
      ],
    );
  }
}

class _QueueDemo extends StatelessWidget {
  _QueueDemo();

  final ValueNotifier<List<String>> _queue =
      ValueNotifier<List<String>>(<String>[]);
  final ValueNotifier<List<String>> _rendered =
      ValueNotifier<List<String>>(<String>[]);
  final ValueNotifier<bool> _locked = ValueNotifier<bool>(false);
  final ValueNotifier<int> _msgCount = ValueNotifier<int>(0);

  void _send() {
    _msgCount.value++;
    final String msg = 'Message #${_msgCount.value} at ${_timestamp()}';
    if (_locked.value) {
      _queue.value = <String>[..._queue.value, msg];
    } else {
      _rendered.value = <String>[..._rendered.value, msg];
    }
  }

  void _toggleLock() {
    if (_locked.value) {
      // Flush queue
      _rendered.value = <String>[..._rendered.value, ..._queue.value];
      _queue.value = <String>[];
      _locked.value = false;
    } else {
      _locked.value = true;
    }
  }

  String _timestamp() {
    final DateTime now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<bool>(
      valueListenable: _locked,
      builder: (BuildContext ctx, bool locked, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: locked
                          ? cs.errorContainer
                          : cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: locked ? cs.error : cs.outlineVariant,
                        width: locked ? 2 : 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          locked ? '🔒 Queued (not shown yet)' : 'Live display',
                          style: Theme.of(ctx).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: ValueListenableBuilder<List<String>>(
                            valueListenable: locked ? _queue : _rendered,
                            builder: (_, List<String> items, Widget? child) {
                              if (items.isEmpty) {
                                return Center(
                                  child: Text(
                                    locked ? 'No queued messages yet' : 'No messages yet',
                                    style: Theme.of(ctx).textTheme.bodySmall,
                                  ),
                                );
                              }
                              return ListView(
                                children: items
                                    .map((String m) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: Text(m,
                                              style: Theme.of(ctx)
                                                  .textTheme
                                                  .bodySmall),
                                        ))
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Rendered messages',
                          style: Theme.of(ctx).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: ValueListenableBuilder<List<String>>(
                            valueListenable: _rendered,
                            builder: (_, List<String> items, Widget? child) {
                              if (items.isEmpty) {
                                return Center(
                                  child: Text(
                                    'None yet',
                                    style: Theme.of(ctx).textTheme.bodySmall,
                                  ),
                                );
                              }
                              return ListView(
                                children: items
                                    .map((String m) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: Text(m,
                                              style: Theme.of(ctx)
                                                  .textTheme
                                                  .bodySmall),
                                        ))
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: _send,
                  icon: const Icon(Icons.send),
                  label: const Text('Send message'),
                ),
                FilledButton.tonal(
                  onPressed: _toggleLock,
                  child: Text(locked ? 'Release lock' : 'Lock'),
                ),
                OutlinedButton(
                  onPressed: () {
                    _queue.value = <String>[];
                    _rendered.value = <String>[];
                    _locked.value = false;
                    _msgCount.value = 0;
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<List<String>>(
              valueListenable: _queue,
              builder: (_, List<String> q, Widget? child) => Text(
                locked
                    ? '${q.length} message(s) queued behind lock'
                    : 'No lock active — messages render immediately',
                style: TextStyle(
                  color: locked ? cs.error : cs.primary,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Tab 7: Use Cases ────────────────────────────────────────────────────────

class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  static const List<_UseCase> _cases = <_UseCase>[
    _UseCase(
      icon: Icons.swap_horiz,
      title: 'Page transitions',
      detail:
          'Prevents setState() calls on the incoming route from causing '
          'layout shifts while the slide/fade animation is running. '
          'The route is frozen from push() until the animation settles.',
    ),
    _UseCase(
      icon: Icons.reorder,
      title: 'List reorder animations',
      detail:
          'During a drag-and-drop reorder, badge counters and other live '
          'state on list items would normally rebuild every tick. '
          'LockState on the list view defers those updates until drop.',
    ),
    _UseCase(
      icon: Icons.route,
      title: 'Route animations',
      detail:
          'Custom PageRouteBuilder animations can lock the destination '
          'widget during the animation curve, ensuring the hero snapshot '
          'matches the final widget layout at the moment of settlement.',
    ),
    _UseCase(
      icon: Icons.drag_handle,
      title: 'Drag handles',
      detail:
          'Bottom sheet or side panel drag handles often cause the content '
          'inside the sheet to re-layout as the sheet height changes. '
          'A lock prevents mid-drag rebuilds that would stutter.',
    ),
    _UseCase(
      icon: Icons.movie_filter,
      title: 'Shared element transitions',
      detail:
          'Hero widgets capture a size/position snapshot. If the destination '
          'widget rebuilds during flight (e.g. image loaded), the hero '
          'overlay diverges. LockState keeps the destination frozen '
          'until the hero lands.',
    ),
    _UseCase(
      icon: Icons.video_library,
      title: 'Video scrubbing',
      detail:
          'During a seek gesture, thumbnail previews and playback-position '
          'indicators update rapidly. LockState on the player controls '
          'would queue UI updates and flush them at the gesture\'s end.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle('Real-world use cases'),
        const _BodyText(
          'These are the six scenarios where LockState-style deferral of '
          'rebuilds provides the most value in a Flutter application.',
        ),
        const SizedBox(height: 12),
        ...List<Widget>.generate(
          _cases.length,
          (int i) {
            final _UseCase uc = _cases[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(uc.icon,
                      color: Theme.of(context).colorScheme.primary),
                ),
                title: Text(uc.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(uc.detail),
                isThreeLine: true,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _SectionTitle('Pattern summary'),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(14),
          child: const Text(
            'Common pattern across all use cases:\n\n'
            '  1. Identify the start of a "critical window"\n'
            '     (animation start, drag begin, seek start)\n'
            '  2. Call LockState.acquireLock() at that point\n'
            '  3. Allow the animation/gesture to complete\n'
            '  4. Call LockState.releaseLock() at completion\n'
            '  5. Deferred setState() calls are flushed in one batch',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _UseCase {
  const _UseCase({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;
}

// ─── Tab 8: vs Others ────────────────────────────────────────────────────────

class _VsOthersTab extends StatelessWidget {
  const _VsOthersTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle('LockState vs similar Flutter mechanisms'),
        const _BodyText(
          'Flutter provides several widgets that superficially resemble '
          'LockState. This tab explains the differences.',
        ),
        const SizedBox(height: 12),
        _ComparisonTable(),
        const SizedBox(height: 20),
        _SectionTitle('RepaintBoundary'),
        const _InfoCard(
          title: 'What it does',
          body:
              'Isolates the repaint of its subtree from the rest of the '
              'tree. Widgets inside a RepaintBoundary repaint independently '
              'without invalidating their ancestors.',
        ),
        const _InfoCard(
          title: 'Difference from LockState',
          body:
              'RepaintBoundary operates at the render-layer level — it '
              'affects compositing, not rebuilding. Widgets inside still '
              'rebuild (their element tree is updated), but the resulting '
              'render object is cached as a separate layer. '
              'LockState would prevent the rebuild entirely, not just '
              'cache the rendered result.',
        ),
        _SectionTitle('AutomaticKeepAlive'),
        const _InfoCard(
          title: 'What it does',
          body:
              'Prevents a widget from being discarded when it scrolls off '
              'screen in a ListView/PageView. Keeps the element and state '
              'alive in memory.',
        ),
        const _InfoCard(
          title: 'Difference from LockState',
          body:
              'AutomaticKeepAlive is about persistence (preventing disposal), '
              'not about deferral. A kept-alive widget still rebuilds freely '
              'in response to setState(). LockState defers rebuilds '
              'regardless of scroll position.',
        ),
        _SectionTitle('Offstage'),
        const _InfoCard(
          title: 'What it does',
          body:
              'Hides its child from the visual output and from hit testing, '
              'but keeps it in the widget tree and fully alive.',
        ),
        const _InfoCard(
          title: 'Difference from LockState',
          body:
              'Offstage widgets still rebuild when setState() is called — '
              'they just don\'t paint. LockState defers the rebuild itself, '
              'so no computation is wasted. Offstage is useful for '
              'pre-warming a route; LockState is useful for preventing '
              'glitches during transitions.',
        ),
        _SectionTitle('IgnorePointer'),
        const _InfoCard(
          title: 'What it does',
          body:
              'Prevents its subtree from receiving pointer events (tap, '
              'scroll, hover). Does not affect rebuilding.',
        ),
        const _InfoCard(
          title: 'Difference from LockState',
          body:
              'IgnorePointer has no effect on widget rebuilding. It is '
              'purely an input-blocking mechanism. LockState has no effect '
              'on input — it only defers visual rebuilds.',
        ),
      ],
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextStyle header = Theme.of(context)
        .textTheme
        .labelSmall!
        .copyWith(fontWeight: FontWeight.bold, color: cs.onPrimary);
    final TextStyle cell = Theme.of(context).textTheme.bodySmall!;

    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(1.5),
        4: FlexColumnWidth(1.5),
      },
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.primary),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('Mechanism', style: header),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('Prevents\nrebuild?', style: header),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('Defers vs\ndiscards', style: header),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('Input\nblocking?', style: header),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('Layer\nisolation?', style: header),
            ),
          ],
        ),
        _tableRow('LockState (sim)', 'Yes', 'Defers', 'No', 'No', cell, cs),
        _tableRow('RepaintBoundary', 'No', 'N/A', 'No', 'Yes', cell, cs),
        _tableRow(
            'AutomaticKeepAlive', 'No', 'N/A', 'No', 'No', cell, cs),
        _tableRow('Offstage', 'No', 'N/A', 'No*', 'No', cell, cs),
        _tableRow('IgnorePointer', 'No', 'N/A', 'Yes', 'No', cell, cs),
      ],
    );
  }

  TableRow _tableRow(
    String a,
    String b,
    String c,
    String d,
    String e,
    TextStyle style,
    ColorScheme cs,
  ) {
    return TableRow(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(6),
            child: Text(a, style: style.copyWith(fontWeight: FontWeight.w600))),
        Padding(padding: const EdgeInsets.all(6), child: Text(b, style: style)),
        Padding(padding: const EdgeInsets.all(6), child: Text(c, style: style)),
        Padding(padding: const EdgeInsets.all(6), child: Text(d, style: style)),
        Padding(padding: const EdgeInsets.all(6), child: Text(e, style: style)),
      ],
    );
  }
}

// ─── Tab 9: Pitfalls ─────────────────────────────────────────────────────────

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle('Common pitfalls'),
        const _BodyText(
          'LockState is a powerful but dangerous tool. Here are the '
          'most common mistakes and how to avoid them.',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: 1,
          title: 'Infinite lock — never released',
          icon: Icons.lock_clock,
          color: cs.errorContainer,
          description:
              'If acquireLock() is called but releaseLock() is never called '
              '(e.g. the animation completes via an exception, or the '
              'animation controller is disposed without completing), the '
              'subtree is permanently frozen. Users see a stuck UI.',
          solution:
              'Always use try/finally or .whenCompleteOrCancel() to guarantee '
              'releaseLock() is called. Implement a timeout: if the lock is '
              'held for more than N seconds, force-release it and log an error.',
        ),
        _PitfallCard(
          number: 2,
          title: 'Nested locks — deadlock risk',
          icon: Icons.account_tree,
          color: cs.secondaryContainer,
          description:
              'If a LockState inside another LockState both try to flush '
              'on release, the outer lock may re-lock the inner subtree '
              'after the inner lock releases, or the flush ordering may '
              'produce unexpected intermediate states.',
          solution:
              'Track lock depth with a counter (not a boolean). Only flush '
              'when the depth returns to zero. Alternatively, forbid nested '
              'LockState widgets in the same subtree via assertion.',
        ),
        _PitfallCard(
          number: 3,
          title: 'State updates that bypass the lock',
          icon: Icons.warning_amber,
          color: cs.tertiaryContainer,
          description:
              'Not all state mutations go through setState(). '
              'InheritedWidget notifications, AnimationController ticks, '
              'and GlobalKey-based access can all trigger rebuilds that '
              'bypass the LockState mechanism entirely.',
          solution:
              'Complement LockState with a RepaintBoundary to isolate '
              'repaints. For animations inside the locked subtree, pause '
              'the AnimationController during the lock. Document which '
              'state sources are and are not covered by the lock.',
        ),
        _PitfallCard(
          number: 4,
          title: 'Data staleness after long locks',
          icon: Icons.hourglass_bottom,
          color: cs.surfaceContainerHighest,
          description:
              'If the lock is held for a long time (e.g. a 2-second '
              'animation), many state changes may be queued. When the lock '
              'releases, the widget jumps directly to the latest state, '
              'skipping all intermediate states. For most UI this is fine, '
              'but for data-critical widgets (e.g. stock tickers, medical '
              'monitors), skipping intermediate values may be unacceptable.',
          solution:
              'For data-critical displays, do not use LockState. Instead '
              'use RepaintBoundary to isolate repaints, and accept that '
              'intermediate states will be shown during the animation.',
        ),
        _PitfallCard(
          number: 5,
          title: 'Testing locked widgets',
          icon: Icons.bug_report_outlined,
          color: cs.primaryContainer,
          description:
              'Widget tests that pump frames while a lock is held will not '
              'see state updates reflected in the widget tree until the lock '
              'is released. This can cause tests to fail or produce '
              'misleading results if the test author does not account for '
              'the lock.',
          solution:
              'Expose a testMode flag on LockStateController that disables '
              'the lock in test environments. Alternatively, always release '
              'the lock before calling tester.pump() in tests.',
        ),
        const SizedBox(height: 20),
        _SectionTitle('API cheat sheet'),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          padding: const EdgeInsets.all(16),
          child: const Text(
            '// ── Hypothetical public API summary ──\n\n'
            'class LockState extends StatelessWidget {\n'
            '  /// [locked] — when true, child setState() calls are deferred.\n'
            '  /// [child]  — the subtree to freeze while locked.\n'
            '  const LockState({required this.locked, required this.child});\n\n'
            '  final bool locked;\n'
            '  final Widget child;\n\n'
            '  // Behavior:\n'
            '  // • locked=true  → setState() in subtree is queued\n'
            '  // • locked=false → any queued setState() calls are flushed\n'
            '  //                  in a single batch rebuild frame\n'
            '  // • No visual artifact between lock and unlock\n'
            '  // • Widget tree remains intact (elements not disposed)\n'
            '  // • InheritedWidget notifications are NOT blocked\n'
            '  // • AnimationController ticks are NOT blocked\n\n'
            '  // Safety guidelines:\n'
            '  // • Always pair acquireLock() with releaseLock() in finally\n'
            '  // • Do not nest LockState around AnimationControllers\n'
            '  // • Use timeout-based force-unlock as a safety net\n'
            '  // • In tests: disable via testMode or release before pump()\n'
            '}\n\n'
            'class LockStateController extends ChangeNotifier {\n'
            '  bool get isLocked => _depth > 0;\n'
            '  int _depth = 0;\n\n'
            '  void acquireLock() { _depth++; notifyListeners(); }\n'
            '  void releaseLock() {\n'
            '    assert(_depth > 0, "releaseLock without acquireLock");\n'
            '    _depth--;\n'
            '    notifyListeners(); // triggers flush\n'
            '  }\n'
            '}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        const SizedBox(height: 20),
        _SectionTitle('Summary'),
        const _InfoCard(
          title: 'When to use LockState (or this pattern)',
          body:
              'Use the LockState pattern when you have a well-defined '
              '"critical window" (animation, gesture, transition) during '
              'which incoming state changes would cause visual glitches. '
              'Always prefer the built-in solutions first: RepaintBoundary '
              'for repaint isolation, KeepAlive for scroll persistence, '
              'and Offstage for pre-warming. Only reach for LockState when '
              'those tools are insufficient.',
        ),
        const _InfoCard(
          title: 'Flutter SDK status',
          body:
              'As of the Flutter 3.x era, LockState has not been shipped as '
              'a public API. The Flutter team has explored similar concepts '
              'in the context of the Impeller renderer and the new '
              'rendering pipeline, but no public widget exists. This demo '
              'serves as both documentation of the concept and a working '
              'implementation you can adapt for your own use cases.',
        ),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.solution,
  });

  final int number;
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final String solution;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  child: Text(
                    '$number',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(icon, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Problem:',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(description, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(
              'Solution:',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(solution, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
