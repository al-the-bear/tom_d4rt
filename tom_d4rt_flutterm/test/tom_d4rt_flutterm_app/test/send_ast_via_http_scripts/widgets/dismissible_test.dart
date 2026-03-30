import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _DismissibleDeepDemoApp();
}

class _DismissibleDeepDemoApp extends StatelessWidget {
  const _DismissibleDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF264B70)),
        useMaterial3: true,
      ),
      home: const _DismissibleDemoPage(),
    );
  }
}

class _DismissibleDemoPage extends StatefulWidget {
  const _DismissibleDemoPage();

  @override
  State<_DismissibleDemoPage> createState() => _DismissibleDemoPageState();
}

class _DismissibleDemoPageState extends State<_DismissibleDemoPage> {
  bool _rtl = false;
  bool _requireConfirm = true;
  bool _compact = false;
  bool _showGuides = true;

  double _thresholdStartToEnd = 0.38;
  double _thresholdEndToStart = 0.38;
  double _movementMs = 230;
  double _crossAxisEndOffset = 0.0;

  int _thresholdCardSeed = 0;
  double _liveProgress = 0;
  bool _liveReached = false;
  DismissDirection _liveDirection = DismissDirection.none;

  int _resizeCount = 0;
  int _dismissCount = 0;

  final List<_SwipeEntry> _startToEndEntries = _seedStartToEndEntries();
  final List<_SwipeEntry> _endToStartEntries = _seedEndToStartEntries();
  final List<_SwipeEntry> _confirmEntries = _seedConfirmEntries();
  final List<_SwipeEntry> _resizeEntries = _seedResizeEntries();
  final List<_SwipeEntry> _noResizeEntries = _seedNoResizeEntries();
  final List<_SwipeEntry> _verticalUpEntries = _seedVerticalUpEntries();
  final List<_SwipeEntry> _verticalDownEntries = _seedVerticalDownEntries();
  final List<_SwipeEntry> _inboxEntries = _seedInboxEntries();
  final List<_SwipeEntry> _archivedEntries = <_SwipeEntry>[];

  final List<String> _eventLog = <String>[];

  @override
  Widget build(BuildContext context) {
    const cNavy = Color(0xFF264B70);
    const cAmber = Color(0xFFD27C39);
    const cTeal = Color(0xFF2A7E72);
    const cRose = Color(0xFF9A4E6C);
    const cIndigo = Color(0xFF5357A1);
    const cOlive = Color(0xFF6D6A2D);

    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          backgroundColor: cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 76,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dismissible Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl
                    ? 'Ambient direction: RTL (start and end are mirrored)'
                    : 'Ambient direction: LTR (default start/end semantics)',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroControlPanel(
                rtl: _rtl,
                requireConfirm: _requireConfirm,
                compact: _compact,
                showGuides: _showGuides,
                thresholdStartToEnd: _thresholdStartToEnd,
                thresholdEndToStart: _thresholdEndToStart,
                movementMs: _movementMs,
                crossAxisEndOffset: _crossAxisEndOffset,
                onRtlChanged: (v) => setState(() => _rtl = v),
                onRequireConfirmChanged: (v) => setState(() => _requireConfirm = v),
                onCompactChanged: (v) => setState(() => _compact = v),
                onShowGuidesChanged: (v) => setState(() => _showGuides = v),
                onThresholdStartChanged: (v) => setState(() => _thresholdStartToEnd = v),
                onThresholdEndChanged: (v) => setState(() => _thresholdEndToStart = v),
                onMovementChanged: (v) => setState(() => _movementMs = v),
                onCrossAxisChanged: (v) => setState(() => _crossAxisEndOffset = v),
              ),
              const SizedBox(height: 12),
              const _SceneCard(
                index: 1,
                accent: cNavy,
                title: 'Dismissible Anatomy and Usage',
                subtitle:
                    'Understand core properties: key, direction, background, secondaryBackground, confirmDismiss, dismissThresholds, onUpdate, movementDuration, and resizeDuration.',
                child: _AnatomyScene(),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: cAmber,
                title: 'Dual Swipe Direction Gallery',
                subtitle:
                    'Compare start-to-end and end-to-start gestures with distinct leave-behind visuals and semantic actions.',
                child: _DualDirectionScene(
                  compact: _compact,
                  startEntries: _startToEndEntries,
                  endEntries: _endToStartEntries,
                  onResetStart: _resetStartToEnd,
                  onResetEnd: _resetEndToStart,
                  onDismissStart: _dismissStartToEndEntry,
                  onDismissEnd: _dismissEndToStartEntry,
                ),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: cTeal,
                title: 'Confirm Dismiss Workflow',
                subtitle:
                    'confirmDismiss can veto dismissal asynchronously. This scene demonstrates approve/reject behavior and logs each decision.',
                child: _ConfirmScene(
                  compact: _compact,
                  requireConfirm: _requireConfirm,
                  entries: _confirmEntries,
                  eventLog: _eventLog,
                  onDismiss: _dismissConfirmEntry,
                  onReset: _resetConfirmEntries,
                  onConfirm: _handleConfirmDismiss,
                ),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: cRose,
                title: 'Threshold and Live Drag Lab',
                subtitle:
                    'onUpdate exposes progress and threshold crossing status. Tune thresholds and watch live feedback update while dragging.',
                child: _ThresholdLabScene(
                  compact: _compact,
                  thresholdStartToEnd: _thresholdStartToEnd,
                  thresholdEndToStart: _thresholdEndToStart,
                  liveProgress: _liveProgress,
                  liveReached: _liveReached,
                  liveDirection: _liveDirection,
                  thresholdCardSeed: _thresholdCardSeed,
                  onDismissed: _handleThresholdLabDismissed,
                  onUpdate: _handleThresholdLabUpdate,
                ),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: cIndigo,
                title: 'Motion and Resize Behavior',
                subtitle:
                    'Compare resizeDuration null vs non-null, and observe movementDuration plus crossAxisEndOffset effects on dismissal motion.',
                child: _ResizeMotionScene(
                  compact: _compact,
                  movementMs: _movementMs,
                  crossAxisEndOffset: _crossAxisEndOffset,
                  resizeEntries: _resizeEntries,
                  noResizeEntries: _noResizeEntries,
                  resizeCount: _resizeCount,
                  dismissCount: _dismissCount,
                  onReset: _resetResizeMotionEntries,
                  onDismissResizeEntry: _dismissResizeEntry,
                  onDismissNoResizeEntry: _dismissNoResizeEntry,
                  onResizeTick: _handleResizeTick,
                ),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: cOlive,
                title: 'Vertical and Practical Inbox Patterns',
                subtitle:
                    'Dismissible also supports vertical gestures and production patterns such as archive/delete with undo.',
                child: _VerticalAndPracticalScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  verticalUpEntries: _verticalUpEntries,
                  verticalDownEntries: _verticalDownEntries,
                  inboxEntries: _inboxEntries,
                  archivedEntries: _archivedEntries,
                  onResetVertical: _resetVerticalEntries,
                  onDismissVerticalUp: _dismissVerticalUpEntry,
                  onDismissVerticalDown: _dismissVerticalDownEntry,
                  onDismissInbox: _dismissInboxEntry,
                  onUndoArchive: _undoLastArchived,
                  onResetInbox: _resetInboxEntries,
                  onConfirm: _handleConfirmDismiss,
                ),
              ),
              const SizedBox(height: 12),
              _EventLogCard(events: _eventLog),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _log(String message) {
    final now = TimeOfDay.now();
    final formatted =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}  $message';
    setState(() {
      _eventLog.insert(0, formatted);
      if (_eventLog.length > 16) {
        _eventLog.removeLast();
      }
    });
  }

  Future<bool?> _handleConfirmDismiss(DismissDirection direction, _SwipeEntry entry) async {
    if (!_requireConfirm) {
      _log('Auto-approved ${entry.title} (${direction.name})');
      return true;
    }

    final decision = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Confirm dismiss?'),
          content: Text(
            'Entry: ${entry.title}\nDirection: ${direction.name}\n\n'
            'Approve to remove this card, or cancel to keep it.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Keep'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Dismiss'),
            ),
          ],
        );
      },
    );

    _log(
      decision == true
          ? 'Confirmed ${entry.title} (${direction.name})'
          : 'Vetoed ${entry.title} (${direction.name})',
    );

    return decision;
  }

  void _dismissStartToEndEntry(_SwipeEntry entry, DismissDirection direction) {
    setState(() {
      _startToEndEntries.removeWhere((e) => e.id == entry.id);
    });
    _log('Dismissed start-to-end: ${entry.title}');
  }

  void _dismissEndToStartEntry(_SwipeEntry entry, DismissDirection direction) {
    setState(() {
      _endToStartEntries.removeWhere((e) => e.id == entry.id);
    });
    _log('Dismissed end-to-start: ${entry.title}');
  }

  void _dismissConfirmEntry(_SwipeEntry entry, DismissDirection direction) {
    setState(() {
      _confirmEntries.removeWhere((e) => e.id == entry.id);
    });
    _log('Removed from confirm list: ${entry.title}');
  }

  void _handleThresholdLabUpdate(DismissUpdateDetails details) {
    setState(() {
      _liveProgress = details.progress;
      _liveReached = details.reached;
      _liveDirection = details.direction;
    });

    if (details.reached && !details.previousReached) {
      _log('Threshold crossed in ${details.direction.name} at progress ${details.progress.toStringAsFixed(2)}');
    }
  }

  void _handleThresholdLabDismissed(DismissDirection direction) {
    _log('Threshold lab card dismissed (${direction.name}), regenerated card');
    setState(() {
      _thresholdCardSeed += 1;
      _liveProgress = 0;
      _liveReached = false;
      _liveDirection = DismissDirection.none;
    });
  }

  void _dismissResizeEntry(_SwipeEntry entry, DismissDirection direction) {
    setState(() {
      _resizeEntries.removeWhere((e) => e.id == entry.id);
      _dismissCount += 1;
    });
    _log('Dismissed resize list entry: ${entry.title}');
  }

  void _dismissNoResizeEntry(_SwipeEntry entry, DismissDirection direction) {
    setState(() {
      _noResizeEntries.removeWhere((e) => e.id == entry.id);
      _dismissCount += 1;
    });
    _log('Dismissed no-resize list entry: ${entry.title}');
  }

  void _handleResizeTick() {
    setState(() {
      _resizeCount += 1;
    });
  }

  void _dismissVerticalUpEntry(_SwipeEntry entry, DismissDirection direction) {
    setState(() {
      _verticalUpEntries.removeWhere((e) => e.id == entry.id);
    });
    _log('Vertical up dismiss: ${entry.title}');
  }

  void _dismissVerticalDownEntry(_SwipeEntry entry, DismissDirection direction) {
    setState(() {
      _verticalDownEntries.removeWhere((e) => e.id == entry.id);
    });
    _log('Vertical down dismiss: ${entry.title}');
  }

  void _dismissInboxEntry(_SwipeEntry entry, DismissDirection direction) {
    setState(() {
      _inboxEntries.removeWhere((e) => e.id == entry.id);
      _archivedEntries.insert(0, entry);
    });
    _log('Inbox dismissed ${entry.title} (${direction.name}) and moved to archive queue');
  }

  void _undoLastArchived() {
    if (_archivedEntries.isEmpty) {
      _log('Undo requested but archive queue is empty');
      return;
    }

    setState(() {
      final restored = _archivedEntries.removeAt(0);
      _inboxEntries.insert(0, restored);
    });
    _log('Undo archive: restored latest item');
  }

  void _resetStartToEnd() {
    setState(() {
      _startToEndEntries
        ..clear()
        ..addAll(_seedStartToEndEntries());
    });
    _log('Reset start-to-end gallery list');
  }

  void _resetEndToStart() {
    setState(() {
      _endToStartEntries
        ..clear()
        ..addAll(_seedEndToStartEntries());
    });
    _log('Reset end-to-start gallery list');
  }

  void _resetConfirmEntries() {
    setState(() {
      _confirmEntries
        ..clear()
        ..addAll(_seedConfirmEntries());
    });
    _log('Reset confirm-dismiss entries');
  }

  void _resetResizeMotionEntries() {
    setState(() {
      _resizeEntries
        ..clear()
        ..addAll(_seedResizeEntries());
      _noResizeEntries
        ..clear()
        ..addAll(_seedNoResizeEntries());
      _resizeCount = 0;
      _dismissCount = 0;
    });
    _log('Reset motion/resize scene entries and counters');
  }

  void _resetVerticalEntries() {
    setState(() {
      _verticalUpEntries
        ..clear()
        ..addAll(_seedVerticalUpEntries());
      _verticalDownEntries
        ..clear()
        ..addAll(_seedVerticalDownEntries());
    });
    _log('Reset vertical dismiss scene');
  }

  void _resetInboxEntries() {
    setState(() {
      _inboxEntries
        ..clear()
        ..addAll(_seedInboxEntries());
      _archivedEntries.clear();
    });
    _log('Reset practical inbox/undo scene');
  }
}

class _HeroControlPanel extends StatelessWidget {
  const _HeroControlPanel({
    required this.rtl,
    required this.requireConfirm,
    required this.compact,
    required this.showGuides,
    required this.thresholdStartToEnd,
    required this.thresholdEndToStart,
    required this.movementMs,
    required this.crossAxisEndOffset,
    required this.onRtlChanged,
    required this.onRequireConfirmChanged,
    required this.onCompactChanged,
    required this.onShowGuidesChanged,
    required this.onThresholdStartChanged,
    required this.onThresholdEndChanged,
    required this.onMovementChanged,
    required this.onCrossAxisChanged,
  });

  final bool rtl;
  final bool requireConfirm;
  final bool compact;
  final bool showGuides;
  final double thresholdStartToEnd;
  final double thresholdEndToStart;
  final double movementMs;
  final double crossAxisEndOffset;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onRequireConfirmChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGuidesChanged;
  final ValueChanged<double> onThresholdStartChanged;
  final ValueChanged<double> onThresholdEndChanged;
  final ValueChanged<double> onMovementChanged;
  final ValueChanged<double> onCrossAxisChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF264B70), Color(0xFF4A6E8D), Color(0xFF6F4D6E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dismissible Control Deck',
            style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tune gesture thresholds and animation behavior globally, then interact with each scene to observe live Dismissible behavior.',
            style: TextStyle(color: Color(0xFFF2F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Global RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: requireConfirm,
                  onChanged: onRequireConfirmChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Require confirmDismiss', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGuides,
                  onChanged: onShowGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guide lines', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Threshold startToEnd: ${thresholdStartToEnd.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: thresholdStartToEnd,
            min: 0.1,
            max: 0.9,
            divisions: 16,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.25),
            onChanged: onThresholdStartChanged,
          ),
          Text(
            'Threshold endToStart: ${thresholdEndToStart.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: thresholdEndToStart,
            min: 0.1,
            max: 0.9,
            divisions: 16,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.25),
            onChanged: onThresholdEndChanged,
          ),
          Text(
            'movementDuration: ${movementMs.toStringAsFixed(0)}ms',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: movementMs,
            min: 100,
            max: 600,
            divisions: 20,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.25),
            onChanged: onMovementChanged,
          ),
          Text(
            'crossAxisEndOffset: ${crossAxisEndOffset.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: crossAxisEndOffset,
            min: -0.5,
            max: 0.5,
            divisions: 20,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.25),
            onChanged: onCrossAxisChanged,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroChip(label: rtl ? 'Direction: RTL' : 'Direction: LTR'),
              _HeroChip(label: requireConfirm ? 'confirmDismiss active' : 'confirmDismiss bypassed'),
              const _HeroChip(label: 'onUpdate progress telemetry'),
              const _HeroChip(label: 'background + secondaryBackground'),
              const _HeroChip(label: 'horizontal + vertical directions'),
              const _HeroChip(label: 'resizeDuration comparison'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.index,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$index', style: TextStyle(color: accent, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: accent, fontSize: 19, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, height: 1.45, color: accent.withValues(alpha: 0.84)),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _AnatomyScene extends StatelessWidget {
  const _AnatomyScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoText(
          'Dismissible is designed for swipe-to-remove interactions. It is stateful and relies on stable keys when used in mutable lists.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _AnatomyInfoCard(
              title: 'Required key',
              accent: Color(0xFF264B70),
              lines: [
                'Use unique keys for list entries.',
                'Without keys, list state can sync with wrong item.',
                'ValueKey(entry.id) is a common pattern.',
              ],
            ),
            _AnatomyInfoCard(
              title: 'Leave-behind visuals',
              accent: Color(0xFF264B70),
              lines: [
                'background appears for start/down drag.',
                'secondaryBackground appears for end/up drag.',
                'Use clear action visuals (archive/delete).',
              ],
            ),
            _AnatomyInfoCard(
              title: 'Decision and telemetry',
              accent: Color(0xFF264B70),
              lines: [
                'confirmDismiss can approve or veto dismissal.',
                'onUpdate provides direction/reached/progress.',
                'Useful for dynamic color and haptic cues.',
              ],
            ),
            _AnatomyInfoCard(
              title: 'Motion behavior',
              accent: Color(0xFF264B70),
              lines: [
                'movementDuration controls slide speed.',
                'resizeDuration controls collapse animation.',
                'crossAxisEndOffset adds diagonal settle.',
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F7FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFCBD7E1)),
          ),
          child: const SelectableText(
            'Dismissible(\n'
            '  key: ValueKey(entry.id),\n'
            '  direction: DismissDirection.horizontal,\n'
            '  background: archiveBg,\n'
            '  secondaryBackground: deleteBg,\n'
            '  dismissThresholds: {\n'
            '    DismissDirection.startToEnd: 0.35,\n'
            '    DismissDirection.endToStart: 0.45,\n'
            '  },\n'
            '  confirmDismiss: (direction) async => await askUser(),\n'
            '  onUpdate: (details) => updateProgress(details.progress),\n'
            '  onDismissed: (direction) => removeFromList(entry),\n'
            '  child: card,\n'
            ')',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11.1, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _AnatomyInfoCard extends StatelessWidget {
  const _AnatomyInfoCard({
    required this.title,
    required this.accent,
    required this.lines,
  });

  final String title;
  final Color accent;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.4)),
            const SizedBox(height: 6),
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(line, style: const TextStyle(fontSize: 11.4, height: 1.35)),
              ),
          ],
        ),
      ),
    );
  }
}

class _DualDirectionScene extends StatelessWidget {
  const _DualDirectionScene({
    required this.compact,
    required this.startEntries,
    required this.endEntries,
    required this.onResetStart,
    required this.onResetEnd,
    required this.onDismissStart,
    required this.onDismissEnd,
  });

  final bool compact;
  final List<_SwipeEntry> startEntries;
  final List<_SwipeEntry> endEntries;
  final VoidCallback onResetStart;
  final VoidCallback onResetEnd;
  final void Function(_SwipeEntry, DismissDirection) onDismissStart;
  final void Function(_SwipeEntry, DismissDirection) onDismissEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _DirectionListCard(
            title: 'startToEnd list',
            subtitle: 'Swipe from logical start toward end',
            accent: const Color(0xFFD27C39),
            entries: startEntries,
            compact: compact,
            direction: DismissDirection.startToEnd,
            onReset: onResetStart,
            onDismissed: onDismissStart,
            backgroundBuilder: _archiveBackground,
            secondaryBuilder: _deleteBackground,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _DirectionListCard(
            title: 'endToStart list',
            subtitle: 'Swipe from logical end toward start',
            accent: const Color(0xFFD27C39),
            entries: endEntries,
            compact: compact,
            direction: DismissDirection.endToStart,
            onReset: onResetEnd,
            onDismissed: onDismissEnd,
            backgroundBuilder: _archiveBackground,
            secondaryBuilder: _deleteBackground,
          ),
        ),
      ],
    );
  }

  static Widget _archiveBackground(BuildContext context, _SwipeEntry entry) {
    return _DismissBackground(
      label: 'Archive',
      icon: Icons.archive_rounded,
      alignment: AlignmentDirectional.centerStart,
      color: const Color(0xFF2F7C71),
      subtitle: entry.subtitle,
    );
  }

  static Widget _deleteBackground(BuildContext context, _SwipeEntry entry) {
    return _DismissBackground(
      label: 'Delete',
      icon: Icons.delete_forever_rounded,
      alignment: AlignmentDirectional.centerEnd,
      color: const Color(0xFFB14D4D),
      subtitle: entry.subtitle,
    );
  }
}

class _DirectionListCard extends StatelessWidget {
  const _DirectionListCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.entries,
    required this.compact,
    required this.direction,
    required this.onReset,
    required this.onDismissed,
    required this.backgroundBuilder,
    required this.secondaryBuilder,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final List<_SwipeEntry> entries;
  final bool compact;
  final DismissDirection direction;
  final VoidCallback onReset;
  final void Function(_SwipeEntry, DismissDirection) onDismissed;
  final Widget Function(BuildContext, _SwipeEntry) backgroundBuilder;
  final Widget Function(BuildContext, _SwipeEntry) secondaryBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.3),
                ),
              ),
              TextButton(onPressed: onReset, child: const Text('Reset list')),
            ],
          ),
          Text(subtitle, style: TextStyle(fontSize: 11.1, color: accent.withValues(alpha: 0.82))),
          const SizedBox(height: 8),
          if (entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accent.withValues(alpha: 0.22)),
              ),
              child: const Text('All entries dismissed. Press reset.'),
            ),
          if (entries.isNotEmpty)
            ListView.separated(
              itemCount: entries.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Dismissible(
                  key: ValueKey('${direction.name}-${entry.id}'),
                  direction: direction,
                  background: backgroundBuilder(context, entry),
                  secondaryBackground: secondaryBuilder(context, entry),
                  onDismissed: (d) => onDismissed(entry, d),
                  child: _EntryTile(entry: entry, compact: compact, accent: accent),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ConfirmScene extends StatelessWidget {
  const _ConfirmScene({
    required this.compact,
    required this.requireConfirm,
    required this.entries,
    required this.eventLog,
    required this.onDismiss,
    required this.onReset,
    required this.onConfirm,
  });

  final bool compact;
  final bool requireConfirm;
  final List<_SwipeEntry> entries;
  final List<String> eventLog;
  final void Function(_SwipeEntry, DismissDirection) onDismiss;
  final VoidCallback onReset;
  final Future<bool?> Function(DismissDirection, _SwipeEntry) onConfirm;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF2A7E72);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Confirm dismiss queue (${requireConfirm ? 'dialog approval required' : 'auto approval'})',
                  style: const TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.3),
                ),
              ),
              TextButton(onPressed: onReset, child: const Text('Reset queue')),
            ],
          ),
          const SizedBox(height: 6),
          if (entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accent.withValues(alpha: 0.2)),
              ),
              child: const Text('No pending entries. Reset to interact again.'),
            ),
          if (entries.isNotEmpty)
            ListView.separated(
              itemCount: entries.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Dismissible(
                  key: ValueKey('confirm-${entry.id}'),
                  background: _DismissBackground(
                    label: 'Approve',
                    icon: Icons.check_circle_rounded,
                    alignment: AlignmentDirectional.centerStart,
                    color: const Color(0xFF2A7E72),
                    subtitle: 'Confirm this dismissal',
                  ),
                  secondaryBackground: _DismissBackground(
                    label: 'Reject',
                    icon: Icons.undo_rounded,
                    alignment: AlignmentDirectional.centerEnd,
                    color: const Color(0xFFB45B3C),
                    subtitle: 'Swipe back if vetoed',
                  ),
                  confirmDismiss: (direction) => onConfirm(direction, entry),
                  onDismissed: (direction) => onDismiss(entry, direction),
                  child: _EntryTile(entry: entry, compact: compact, accent: accent),
                );
              },
            ),
          const SizedBox(height: 8),
          _MiniLogPreview(events: eventLog),
        ],
      ),
    );
  }
}

class _ThresholdLabScene extends StatelessWidget {
  const _ThresholdLabScene({
    required this.compact,
    required this.thresholdStartToEnd,
    required this.thresholdEndToStart,
    required this.liveProgress,
    required this.liveReached,
    required this.liveDirection,
    required this.thresholdCardSeed,
    required this.onDismissed,
    required this.onUpdate,
  });

  final bool compact;
  final double thresholdStartToEnd;
  final double thresholdEndToStart;
  final double liveProgress;
  final bool liveReached;
  final DismissDirection liveDirection;
  final int thresholdCardSeed;
  final ValueChanged<DismissDirection> onDismissed;
  final ValueChanged<DismissUpdateDetails> onUpdate;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF9A4E6C);
    final progress = liveProgress.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoText(
          'Drag the card slowly. Observe progress and threshold status in real-time. The card regenerates after dismissal so you can repeat tests.',
        ),
        const SizedBox(height: 10),
        Dismissible(
          key: ValueKey('threshold-lab-$thresholdCardSeed'),
          dismissThresholds: {
            DismissDirection.startToEnd: thresholdStartToEnd,
            DismissDirection.endToStart: thresholdEndToStart,
          },
          background: _DismissBackground(
            label: 'Start path',
            icon: Icons.trending_flat_rounded,
            alignment: AlignmentDirectional.centerStart,
            color: const Color(0xFF2F7C71),
            subtitle: 'Threshold ${thresholdStartToEnd.toStringAsFixed(2)}',
          ),
          secondaryBackground: _DismissBackground(
            label: 'End path',
            icon: Icons.trending_flat_rounded,
            alignment: AlignmentDirectional.centerEnd,
            color: const Color(0xFFB14D4D),
            subtitle: 'Threshold ${thresholdEndToStart.toStringAsFixed(2)}',
          ),
          onUpdate: onUpdate,
          onDismissed: onDismissed,
          child: Container(
            height: compact ? 72 : 96,
            padding: const EdgeInsetsDirectional.only(start: 14, end: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accent.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Icon(Icons.swipe_rounded, color: accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Threshold lab draggable card', style: TextStyle(fontWeight: FontWeight.w800, color: accent)),
                      Text(
                        'Direction ${liveDirection.name} | reached=${liveReached ? 'yes' : 'no'} | progress=${progress.toStringAsFixed(2)}',
                        style: TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: accent.withValues(alpha: 0.85)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _ProgressBand(
          label: 'Live drag progress',
          value: progress,
          accent: accent,
          highlight: liveReached,
        ),
        const SizedBox(height: 8),
        _ProgressBand(
          label: 'startToEnd threshold',
          value: thresholdStartToEnd,
          accent: const Color(0xFF2F7C71),
          highlight: liveDirection == DismissDirection.startToEnd && liveReached,
        ),
        const SizedBox(height: 8),
        _ProgressBand(
          label: 'endToStart threshold',
          value: thresholdEndToStart,
          accent: const Color(0xFFB14D4D),
          highlight: liveDirection == DismissDirection.endToStart && liveReached,
        ),
      ],
    );
  }
}

class _ResizeMotionScene extends StatelessWidget {
  const _ResizeMotionScene({
    required this.compact,
    required this.movementMs,
    required this.crossAxisEndOffset,
    required this.resizeEntries,
    required this.noResizeEntries,
    required this.resizeCount,
    required this.dismissCount,
    required this.onReset,
    required this.onDismissResizeEntry,
    required this.onDismissNoResizeEntry,
    required this.onResizeTick,
  });

  final bool compact;
  final double movementMs;
  final double crossAxisEndOffset;
  final List<_SwipeEntry> resizeEntries;
  final List<_SwipeEntry> noResizeEntries;
  final int resizeCount;
  final int dismissCount;
  final VoidCallback onReset;
  final void Function(_SwipeEntry, DismissDirection) onDismissResizeEntry;
  final void Function(_SwipeEntry, DismissDirection) onDismissNoResizeEntry;
  final VoidCallback onResizeTick;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF5357A1);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'movementDuration ${movementMs.toStringAsFixed(0)}ms | crossAxisEndOffset ${crossAxisEndOffset.toStringAsFixed(2)}',
                  style: const TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 12.8),
                ),
              ),
              TextButton(onPressed: onReset, child: const Text('Reset')),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'onResize ticks: $resizeCount | onDismissed events: $dismissCount',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ResizeListCard(
                  title: 'resizeDuration: 300ms',
                  accent: accent,
                  entries: resizeEntries,
                  compact: compact,
                  movementMs: movementMs,
                  crossAxisEndOffset: crossAxisEndOffset,
                  resizeDuration: const Duration(milliseconds: 300),
                  onDismissed: onDismissResizeEntry,
                  onResize: onResizeTick,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResizeListCard(
                  title: 'resizeDuration: null',
                  accent: accent,
                  entries: noResizeEntries,
                  compact: compact,
                  movementMs: movementMs,
                  crossAxisEndOffset: crossAxisEndOffset,
                  resizeDuration: null,
                  onDismissed: onDismissNoResizeEntry,
                  onResize: onResizeTick,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResizeListCard extends StatelessWidget {
  const _ResizeListCard({
    required this.title,
    required this.accent,
    required this.entries,
    required this.compact,
    required this.movementMs,
    required this.crossAxisEndOffset,
    required this.resizeDuration,
    required this.onDismissed,
    required this.onResize,
  });

  final String title;
  final Color accent;
  final List<_SwipeEntry> entries;
  final bool compact;
  final double movementMs;
  final double crossAxisEndOffset;
  final Duration? resizeDuration;
  final void Function(_SwipeEntry, DismissDirection) onDismissed;
  final VoidCallback onResize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 12.5)),
          const SizedBox(height: 8),
          if (entries.isEmpty)
            const Text('All cards dismissed.'),
          if (entries.isNotEmpty)
            ListView.separated(
              itemCount: entries.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Dismissible(
                  key: ValueKey('resize-$title-${entry.id}'),
                  resizeDuration: resizeDuration,
                  movementDuration: Duration(milliseconds: movementMs.round()),
                  crossAxisEndOffset: crossAxisEndOffset,
                  background: _DismissBackground(
                    label: 'Done',
                    icon: Icons.done_all_rounded,
                    alignment: AlignmentDirectional.centerStart,
                    color: const Color(0xFF2E7C7C),
                    subtitle: 'Motion + resize demo',
                  ),
                  secondaryBackground: _DismissBackground(
                    label: 'Skip',
                    icon: Icons.skip_next_rounded,
                    alignment: AlignmentDirectional.centerEnd,
                    color: const Color(0xFFB05A56),
                    subtitle: 'Motion + resize demo',
                  ),
                  onResize: onResize,
                  onDismissed: (direction) => onDismissed(entry, direction),
                  child: _EntryTile(entry: entry, compact: compact, accent: accent),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _VerticalAndPracticalScene extends StatelessWidget {
  const _VerticalAndPracticalScene({
    required this.compact,
    required this.showGuides,
    required this.verticalUpEntries,
    required this.verticalDownEntries,
    required this.inboxEntries,
    required this.archivedEntries,
    required this.onResetVertical,
    required this.onDismissVerticalUp,
    required this.onDismissVerticalDown,
    required this.onDismissInbox,
    required this.onUndoArchive,
    required this.onResetInbox,
    required this.onConfirm,
  });

  final bool compact;
  final bool showGuides;
  final List<_SwipeEntry> verticalUpEntries;
  final List<_SwipeEntry> verticalDownEntries;
  final List<_SwipeEntry> inboxEntries;
  final List<_SwipeEntry> archivedEntries;
  final VoidCallback onResetVertical;
  final void Function(_SwipeEntry, DismissDirection) onDismissVerticalUp;
  final void Function(_SwipeEntry, DismissDirection) onDismissVerticalDown;
  final void Function(_SwipeEntry, DismissDirection) onDismissInbox;
  final VoidCallback onUndoArchive;
  final VoidCallback onResetInbox;
  final Future<bool?> Function(DismissDirection, _SwipeEntry) onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _VerticalListCard(
                title: 'DismissDirection.up',
                accent: const Color(0xFF6D6A2D),
                entries: verticalUpEntries,
                direction: DismissDirection.up,
                compact: compact,
                onDismissed: onDismissVerticalUp,
                onReset: onResetVertical,
                guide: showGuides,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _VerticalListCard(
                title: 'DismissDirection.down',
                accent: const Color(0xFF6D6A2D),
                entries: verticalDownEntries,
                direction: DismissDirection.down,
                compact: compact,
                onDismissed: onDismissVerticalDown,
                onReset: onResetVertical,
                guide: showGuides,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _PracticalInboxCard(
          compact: compact,
          entries: inboxEntries,
          archivedEntries: archivedEntries,
          onDismissed: onDismissInbox,
          onUndo: onUndoArchive,
          onReset: onResetInbox,
          onConfirm: onConfirm,
        ),
      ],
    );
  }
}

class _VerticalListCard extends StatelessWidget {
  const _VerticalListCard({
    required this.title,
    required this.accent,
    required this.entries,
    required this.direction,
    required this.compact,
    required this.onDismissed,
    required this.onReset,
    required this.guide,
  });

  final String title;
  final Color accent;
  final List<_SwipeEntry> entries;
  final DismissDirection direction;
  final bool compact;
  final void Function(_SwipeEntry, DismissDirection) onDismissed;
  final VoidCallback onReset;
  final bool guide;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800))),
              TextButton(onPressed: onReset, child: const Text('Reset')),
            ],
          ),
          if (guide)
            Text(
              'Guide: drag cards vertically in ${direction.name} direction',
              style: TextStyle(fontSize: 10.8, color: accent.withValues(alpha: 0.84)),
            ),
          const SizedBox(height: 6),
          if (entries.isEmpty)
            const Text('No cards left.'),
          if (entries.isNotEmpty)
            ListView.separated(
              itemCount: entries.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Dismissible(
                  key: ValueKey('vertical-${direction.name}-${entry.id}'),
                  direction: direction,
                  background: _DismissBackground(
                    label: direction == DismissDirection.up ? 'Up action' : 'Down action',
                    icon: direction == DismissDirection.up ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    alignment: Alignment.center,
                    color: accent,
                    subtitle: 'Vertical dismiss',
                  ),
                  onDismissed: (d) => onDismissed(entry, d),
                  child: _EntryTile(entry: entry, compact: compact, accent: accent),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _PracticalInboxCard extends StatelessWidget {
  const _PracticalInboxCard({
    required this.compact,
    required this.entries,
    required this.archivedEntries,
    required this.onDismissed,
    required this.onUndo,
    required this.onReset,
    required this.onConfirm,
  });

  final bool compact;
  final List<_SwipeEntry> entries;
  final List<_SwipeEntry> archivedEntries;
  final void Function(_SwipeEntry, DismissDirection) onDismissed;
  final VoidCallback onUndo;
  final VoidCallback onReset;
  final Future<bool?> Function(DismissDirection, _SwipeEntry) onConfirm;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF6D6A2D);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.26)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Practical inbox triage',
                  style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.4),
                ),
              ),
              TextButton(onPressed: onUndo, child: const Text('Undo latest')),
              TextButton(onPressed: onReset, child: const Text('Reset inbox')),
            ],
          ),
          Text(
            'Archived queue: ${archivedEntries.length}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
          const SizedBox(height: 8),
          if (entries.isEmpty)
            const Text('Inbox is empty.'),
          if (entries.isNotEmpty)
            ListView.separated(
              itemCount: entries.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Dismissible(
                  key: ValueKey('inbox-${entry.id}'),
                  background: _DismissBackground(
                    label: 'Archive',
                    icon: Icons.archive_rounded,
                    alignment: AlignmentDirectional.centerStart,
                    color: const Color(0xFF2E7A69),
                    subtitle: 'Keep for later',
                  ),
                  secondaryBackground: _DismissBackground(
                    label: 'Delete',
                    icon: Icons.delete_rounded,
                    alignment: AlignmentDirectional.centerEnd,
                    color: const Color(0xFFB24E4E),
                    subtitle: 'Requires confirm',
                  ),
                  dismissThresholds: const {
                    DismissDirection.startToEnd: 0.26,
                    DismissDirection.endToStart: 0.44,
                  },
                  confirmDismiss: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      return onConfirm(direction, entry);
                    }
                    return Future<bool>.value(true);
                  },
                  onDismissed: (direction) => onDismissed(entry, direction),
                  child: _EntryTile(entry: entry, compact: compact, accent: accent),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({
    required this.label,
    required this.icon,
    required this.alignment,
    required this.color,
    required this.subtitle,
  });

  final String label;
  final IconData icon;
  final AlignmentGeometry alignment;
  final Color color;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsetsDirectional.only(start: 14, end: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.38)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
              Text(subtitle, style: TextStyle(color: color.withValues(alpha: 0.82), fontSize: 10.4)),
            ],
          ),
        ],
      ),
    );
  }
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({
    required this.entry,
    required this.compact,
    required this.accent,
  });

  final _SwipeEntry entry;
  final bool compact;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final height = compact ? 58.0 : 74.0;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: double.infinity,
            decoration: BoxDecoration(
              color: entry.color.withValues(alpha: 0.85),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                bottomStart: Radius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: compact ? 12.2 : 13.2),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  entry.subtitle,
                  style: TextStyle(fontSize: compact ? 10.4 : 11.2, color: accent.withValues(alpha: 0.82)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: entry.color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(entry.tag, style: TextStyle(fontSize: 10, color: entry.color, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBand extends StatelessWidget {
  const _ProgressBand({
    required this.label,
    required this.value,
    required this.accent,
    required this.highlight,
  });

  final String label;
  final double value;
  final Color accent;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: highlight ? 0.5 : 0.2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(label, style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 11.5)),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: value.clamp(0, 1),
              minHeight: 10,
              borderRadius: BorderRadius.circular(999),
              backgroundColor: accent.withValues(alpha: 0.15),
              color: accent,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 44,
            child: Text(
              value.toStringAsFixed(2),
              textAlign: TextAlign.end,
              style: TextStyle(fontFamily: 'monospace', color: accent),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniLogPreview extends StatelessWidget {
  const _MiniLogPreview({required this.events});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F7F7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC5D8D6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent confirm flow events',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11.5, color: Color(0xFF2A7E72)),
          ),
          const SizedBox(height: 6),
          for (final line in events.take(4))
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 10.2)),
            ),
          if (events.isEmpty) const Text('No events yet.'),
        ],
      ),
    );
  }
}

class _EventLogCard extends StatelessWidget {
  const _EventLogCard({required this.events});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD3D9E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Event Log',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF314A5E)),
          ),
          const SizedBox(height: 8),
          if (events.isEmpty)
            const Text('No events yet. Interact with scenes to generate logs.')
          else
            for (final event in events)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(event, style: const TextStyle(fontFamily: 'monospace', fontSize: 10.8)),
              ),
        ],
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFE9F0F6), Color(0xFFF6ECE5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFC0CCD7)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF30495B)),
          ),
          SizedBox(height: 8),
          Text(
            '1) Dismissible requires stable keys when used in mutable lists.\n'
            '2) background and secondaryBackground expose action affordances while swiping.\n'
            '3) confirmDismiss can asynchronously allow or veto dismissal.\n'
            '4) dismissThresholds + onUpdate enable nuanced drag policies with live telemetry.\n'
            '5) movementDuration, resizeDuration, and crossAxisEndOffset shape dismissal feel.\n'
            '6) Dismissible supports both horizontal and vertical gesture directions for practical app workflows.',
            style: TextStyle(fontSize: 12.4, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.4, height: 1.45));
  }
}

class _SwipeEntry {
  const _SwipeEntry({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.color,
  });

  final String id;
  final String title;
  final String subtitle;
  final String tag;
  final Color color;
}

List<_SwipeEntry> _seedStartToEndEntries() {
  return const [
    _SwipeEntry(
      id: 's1',
      title: 'Morning standup summary',
      subtitle: 'Swipe start-to-end to archive completed briefing',
      tag: 'Archive',
      color: Color(0xFF2F7C71),
    ),
    _SwipeEntry(
      id: 's2',
      title: 'Budget sync notes',
      subtitle: 'Designed to demonstrate directional leave-behind',
      tag: 'Archive',
      color: Color(0xFF2F7C71),
    ),
    _SwipeEntry(
      id: 's3',
      title: 'Prototype review checklist',
      subtitle: 'Observe mirrored meaning when RTL is active',
      tag: 'Archive',
      color: Color(0xFF2F7C71),
    ),
  ];
}

List<_SwipeEntry> _seedEndToStartEntries() {
  return const [
    _SwipeEntry(
      id: 'e1',
      title: 'Deprecated endpoint alert',
      subtitle: 'Swipe end-to-start to dismiss critical alert',
      tag: 'Delete',
      color: Color(0xFFB14D4D),
    ),
    _SwipeEntry(
      id: 'e2',
      title: 'Outdated dependency warning',
      subtitle: 'Secondary background is exposed on this side',
      tag: 'Delete',
      color: Color(0xFFB14D4D),
    ),
    _SwipeEntry(
      id: 'e3',
      title: 'Old branch cleanup task',
      subtitle: 'Use with caution in production flows',
      tag: 'Delete',
      color: Color(0xFFB14D4D),
    ),
  ];
}

List<_SwipeEntry> _seedConfirmEntries() {
  return const [
    _SwipeEntry(
      id: 'c1',
      title: 'Invoice #1042',
      subtitle: 'Pending payment dispute review',
      tag: 'Finance',
      color: Color(0xFF2A7E72),
    ),
    _SwipeEntry(
      id: 'c2',
      title: 'Legal document draft',
      subtitle: 'Requires explicit dismissal approval',
      tag: 'Legal',
      color: Color(0xFF2A7E72),
    ),
    _SwipeEntry(
      id: 'c3',
      title: 'Security incident timeline',
      subtitle: 'Veto path demonstrates confirmDismiss false',
      tag: 'Security',
      color: Color(0xFF2A7E72),
    ),
  ];
}

List<_SwipeEntry> _seedResizeEntries() {
  return const [
    _SwipeEntry(
      id: 'r1',
      title: 'Resize card A',
      subtitle: 'Contracts after slide animation',
      tag: 'resize',
      color: Color(0xFF5357A1),
    ),
    _SwipeEntry(
      id: 'r2',
      title: 'Resize card B',
      subtitle: 'onResize callback ticks during collapse',
      tag: 'resize',
      color: Color(0xFF5357A1),
    ),
    _SwipeEntry(
      id: 'r3',
      title: 'Resize card C',
      subtitle: 'Good for list item disappearance affordance',
      tag: 'resize',
      color: Color(0xFF5357A1),
    ),
  ];
}

List<_SwipeEntry> _seedNoResizeEntries() {
  return const [
    _SwipeEntry(
      id: 'n1',
      title: 'No-resize card A',
      subtitle: 'onDismissed fires immediately after slide',
      tag: 'no-resize',
      color: Color(0xFF5357A1),
    ),
    _SwipeEntry(
      id: 'n2',
      title: 'No-resize card B',
      subtitle: 'Useful when list is rebuilt externally',
      tag: 'no-resize',
      color: Color(0xFF5357A1),
    ),
    _SwipeEntry(
      id: 'n3',
      title: 'No-resize card C',
      subtitle: 'Compare feel against timed collapse list',
      tag: 'no-resize',
      color: Color(0xFF5357A1),
    ),
  ];
}

List<_SwipeEntry> _seedVerticalUpEntries() {
  return const [
    _SwipeEntry(
      id: 'u1',
      title: 'Upward action card 1',
      subtitle: 'DismissDirection.up',
      tag: 'up',
      color: Color(0xFF6D6A2D),
    ),
    _SwipeEntry(
      id: 'u2',
      title: 'Upward action card 2',
      subtitle: 'Useful in stacked overlays',
      tag: 'up',
      color: Color(0xFF6D6A2D),
    ),
  ];
}

List<_SwipeEntry> _seedVerticalDownEntries() {
  return const [
    _SwipeEntry(
      id: 'd1',
      title: 'Downward action card 1',
      subtitle: 'DismissDirection.down',
      tag: 'down',
      color: Color(0xFF6D6A2D),
    ),
    _SwipeEntry(
      id: 'd2',
      title: 'Downward action card 2',
      subtitle: 'Useful for pull-away metaphors',
      tag: 'down',
      color: Color(0xFF6D6A2D),
    ),
  ];
}

List<_SwipeEntry> _seedInboxEntries() {
  return const [
    _SwipeEntry(
      id: 'i1',
      title: 'Customer request: export CSV',
      subtitle: 'Archive for follow-up or delete after confirm',
      tag: 'Inbox',
      color: Color(0xFF6D6A2D),
    ),
    _SwipeEntry(
      id: 'i2',
      title: 'UX review notes',
      subtitle: 'Practical triage pattern with undo',
      tag: 'Inbox',
      color: Color(0xFF6D6A2D),
    ),
    _SwipeEntry(
      id: 'i3',
      title: 'Telemetry anomaly report',
      subtitle: 'Dismiss with direction-sensitive meaning',
      tag: 'Inbox',
      color: Color(0xFF6D6A2D),
    ),
  ];
}
