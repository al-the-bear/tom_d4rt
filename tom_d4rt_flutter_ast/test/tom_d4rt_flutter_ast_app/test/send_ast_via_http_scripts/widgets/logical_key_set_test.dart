import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (STATELESS constraint; notifiers replace setState)
// ---------------------------------------------------------------------------
final ValueNotifier<int> _saveCount = ValueNotifier<int>(0);
final ValueNotifier<List<String>> _eventLog = ValueNotifier<List<String>>([]);
final ValueNotifier<int> _undoCount = ValueNotifier<int>(0);
final ValueNotifier<int> _redoCount = ValueNotifier<int>(0);
final ValueNotifier<int> _altF4Count = ValueNotifier<int>(0);
final ValueNotifier<int> _terminalCount = ValueNotifier<int>(0);
final ValueNotifier<int> _lockCount = ValueNotifier<int>(0);

// ---------------------------------------------------------------------------
// Intents
// ---------------------------------------------------------------------------
class SaveIntent extends Intent {
  const SaveIntent();
}

class UndoIntent extends Intent {
  const UndoIntent();
}

class RedoIntent extends Intent {
  const RedoIntent();
}

class CloseWindowIntent extends Intent {
  const CloseWindowIntent();
}

class OpenTerminalIntent extends Intent {
  const OpenTerminalIntent();
}

class LockScreenIntent extends Intent {
  const LockScreenIntent();
}

// ---------------------------------------------------------------------------
// Actions
// ---------------------------------------------------------------------------
class SaveAction extends Action<SaveIntent> {
  @override
  Object? invoke(SaveIntent intent) {
    _saveCount.value += 1;
    final log = List<String>.from(_eventLog.value);
    log.insert(0, 'Ctrl+S fired — save #${_saveCount.value}');
    if (log.length > 12) log.removeLast();
    _eventLog.value = log;
    return null;
  }
}

class UndoAction extends Action<UndoIntent> {
  @override
  Object? invoke(UndoIntent intent) {
    _undoCount.value += 1;
    final log = List<String>.from(_eventLog.value);
    log.insert(0, 'Ctrl+Z fired — undo #${_undoCount.value}');
    if (log.length > 12) log.removeLast();
    _eventLog.value = log;
    return null;
  }
}

class RedoAction extends Action<RedoIntent> {
  @override
  Object? invoke(RedoIntent intent) {
    _redoCount.value += 1;
    final log = List<String>.from(_eventLog.value);
    log.insert(0, 'Ctrl+Shift+Z fired — redo #${_redoCount.value}');
    if (log.length > 12) log.removeLast();
    _eventLog.value = log;
    return null;
  }
}

class CloseWindowAction extends Action<CloseWindowIntent> {
  @override
  Object? invoke(CloseWindowIntent intent) {
    _altF4Count.value += 1;
    final log = List<String>.from(_eventLog.value);
    log.insert(0, 'Alt+F4 fired — close #${_altF4Count.value}');
    if (log.length > 12) log.removeLast();
    _eventLog.value = log;
    return null;
  }
}

class OpenTerminalAction extends Action<OpenTerminalIntent> {
  @override
  Object? invoke(OpenTerminalIntent intent) {
    _terminalCount.value += 1;
    final log = List<String>.from(_eventLog.value);
    log.insert(0, 'Ctrl+Alt+T fired — terminal #${_terminalCount.value}');
    if (log.length > 12) log.removeLast();
    _eventLog.value = log;
    return null;
  }
}

class LockScreenAction extends Action<LockScreenIntent> {
  @override
  Object? invoke(LockScreenIntent intent) {
    _lockCount.value += 1;
    final log = List<String>.from(_eventLog.value);
    log.insert(0, 'Meta+L fired — lock #${_lockCount.value}');
    if (log.length > 12) log.removeLast();
    _eventLog.value = log;
    return null;
  }
}

// ---------------------------------------------------------------------------
// CustomPainter: keyboard → ShortcutManager → Intent → Action pipeline
// ---------------------------------------------------------------------------
class _ShortcutPipelinePainter extends CustomPainter {
  const _ShortcutPipelinePainter({required this.accentColor});

  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()
      ..color = accentColor.withAlpha(30)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final arrowPaint = Paint()
      ..color = accentColor.withAlpha(200)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final labelStyle = TextStyle(
      color: accentColor,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    );

    final subStyle = TextStyle(
      color: accentColor.withAlpha(180),
      fontSize: 9,
    );

    // ---- layout constants ----
    const double nodeW = 108;
    const double nodeH = 42;
    const double gap = 28;
    final double totalW = 6 * nodeW + 5 * gap;
    final double startX = (size.width - totalW) / 2;
    const double y = 30.0;

    final nodes = <(String, String)>[
      ('HardwareKeyboard', 'raw KeyEvents'),
      ('RawKeyboard', '(legacy layer)'),
      ('FocusNode', 'captures events'),
      ('ShortcutManager', 'walks shortcuts map'),
      // ignore: prefer_adjacent_string_concatenation
      ('LogicalKeySet\n.accepts()', 'set membership check'),
      ('Intent → Action', 'invoke() dispatched'),
    ];

    for (int i = 0; i < nodes.length; i++) {
      final left = startX + i * (nodeW + gap);
      final rect = RRect.fromLTRBR(
        left,
        y,
        left + nodeW,
        y + nodeH,
        const Radius.circular(8),
      );
      canvas.drawRRect(rect, boxPaint);
      canvas.drawRRect(rect, borderPaint);

      // label
      final tp = TextPainter(
        text: TextSpan(
          children: [
            TextSpan(text: nodes[i].$1, style: labelStyle),
            const TextSpan(text: '\n'),
            TextSpan(text: nodes[i].$2, style: subStyle),
          ],
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: nodeW - 6);
      tp.paint(
        canvas,
        Offset(left + (nodeW - tp.width) / 2, y + (nodeH - tp.height) / 2),
      );

      // arrow to next
      if (i < nodes.length - 1) {
        final ax = left + nodeW + 2;
        final ax2 = ax + gap - 4;
        final ay = y + nodeH / 2;
        canvas.drawLine(Offset(ax, ay), Offset(ax2, ay), arrowPaint);
        // arrowhead
        final path = Path()
          ..moveTo(ax2, ay)
          ..lineTo(ax2 - 7, ay - 5)
          ..moveTo(ax2, ay)
          ..lineTo(ax2 - 7, ay + 5);
        canvas.drawPath(path, arrowPaint);
      }
    }

    // bottom label
    final bottomTp = TextPainter(
      text: TextSpan(
        text: 'LogicalKeySet.accepts() checks whether the pressed key set '
            'exactly matches its stored key set',
        style: subStyle.copyWith(fontSize: 10),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 32);
    bottomTp.paint(
      canvas,
      Offset((size.width - bottomTp.width) / 2, y + nodeH + 10),
    );
  }

  @override
  bool shouldRepaint(_ShortcutPipelinePainter old) =>
      old.accentColor != accentColor;
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
    ),
    home: const _LogicalKeySetDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root stateless shell (wraps everything in DefaultTabController)
// ---------------------------------------------------------------------------
class _LogicalKeySetDemo extends StatelessWidget {
  const _LogicalKeySetDemo();

  static const List<Tab> _tabs = [
    Tab(text: 'Overview'),
    Tab(text: 'Live Binding'),
    Tab(text: 'Multi-Key'),
    Tab(text: 'Key Gallery'),
    Tab(text: 'fromSet'),
    Tab(text: 'Comparison'),
    Tab(text: 'Diagram'),
    Tab(text: 'Platforms'),
    Tab(text: 'Pitfalls & API'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LogicalKeySet Deep Demo'),
          centerTitle: false,
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: [
            _OverviewTab(),
            _LiveBindingTab(),
            _MultiKeyTab(),
            _KeyGalleryTab(),
            _FromSetTab(),
            _ComparisonTab(),
            _DiagramTab(),
            _PlatformsTab(),
            _PitfallsApiTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child, this.color});

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: child,
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);

  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }
}

class _KeyChip extends StatelessWidget {
  const _KeyChip(this.label, {this.modifier = false});

  final String label;
  final bool modifier;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: modifier ? FontWeight.w700 : FontWeight.normal,
          color: modifier ? cs.onPrimary : cs.onSurface,
        ),
      ),
      backgroundColor:
          modifier ? cs.primary : cs.surfaceContainerHighest,
      side: BorderSide(color: cs.outlineVariant),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 1 — Overview / Hero Banner
// ---------------------------------------------------------------------------
class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Hero banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                cs.primaryContainer,
                cs.secondaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.keyboard, size: 40, color: cs.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'LogicalKeySet',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'A set of LogicalKeyboardKey values that together form a '
                'keyboard shortcut activator.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: cs.onPrimaryContainer,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'class LogicalKeySet extends KeySet<LogicalKeyboardKey> '
                'implements ShortcutActivator',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Deprecation notice
        _InfoCard(
          color: cs.errorContainer,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: cs.onErrorContainer, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deprecation Notice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cs.onErrorContainer,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'LogicalKeySet is still functional but the Flutter team '
                      'recommends migrating to SingleActivator (for '
                      'modifier+key combos) or CharacterActivator (for '
                      'character-based shortcuts). LogicalKeySet has no '
                      'ordering guarantees and does not distinguish between '
                      'left/right modifier keys, making it less precise for '
                      'modern shortcut handling.',
                      style: TextStyle(color: cs.onErrorContainer),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _SectionTitle('What LogicalKeySet Does'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bulletPoint(context,
                  'Groups one to four LogicalKeyboardKey values into a '
                  'single activator object.'),
              _bulletPoint(context,
                  'Implements ShortcutActivator.accepts() — returns true '
                  'when the currently pressed key set exactly equals the '
                  'stored set.'),
              _bulletPoint(context,
                  'Used as map keys in the Shortcuts widget\'s shortcuts '
                  'map to bind key combos to Intent objects.'),
              _bulletPoint(context,
                  'The set is unordered: Ctrl+S and S+Ctrl produce the '
                  'same LogicalKeySet.'),
              _bulletPoint(context,
                  'Equality and hashCode are based on the set of keys, not '
                  'insertion order.'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _SectionTitle('Class Hierarchy'),
        _CodeBlock(
          'KeySet<LogicalKeyboardKey>\n'
          '  └── LogicalKeySet\n'
          '        implements ShortcutActivator\n\n'
          '// KeySet provides:\n'
          '//   Set<LogicalKeyboardKey> get keys\n'
          '//   operator == and hashCode (set-based)\n\n'
          '// ShortcutActivator provides:\n'
          '//   bool accepts(RawKeyEvent event, RawKeyboard state)\n'
          '//   Iterable<LogicalKeyboardKey>? get triggers',
        ),
        const SizedBox(height: 20),

        _SectionTitle('Constructors at a Glance'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Positional constructor',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: cs.primary),
              ),
              const SizedBox(height: 4),
              const _CodeBlock(
                'LogicalKeySet(\n'
                '  LogicalKeyboardKey key1, [\n'
                '  LogicalKeyboardKey? key2,\n'
                '  LogicalKeyboardKey? key3,\n'
                '  LogicalKeyboardKey? key4,\n'
                '])',
              ),
              const SizedBox(height: 12),
              Text(
                '2. Set constructor',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: cs.primary),
              ),
              const SizedBox(height: 4),
              const _CodeBlock(
                'LogicalKeySet.fromSet(\n'
                '  Set<LogicalKeyboardKey> keys,\n'
                ')',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 2 — Live Shortcut Binding (Ctrl+S → SaveIntent)
// ---------------------------------------------------------------------------
class _LiveBindingTab extends StatelessWidget {
  const _LiveBindingTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // LogicalKeySet for Ctrl+S
    final ctrlS = LogicalKeySet(
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.keyS,
    );

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        ctrlS: const SaveIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          SaveIntent: SaveAction(),
        },
        child: Focus(
          autofocus: true,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _SectionTitle('Live Shortcut Binding — Ctrl+S → SaveIntent'),
              _InfoCard(
                child: Text(
                  'A LogicalKeySet(control, keyS) is registered in a Shortcuts '
                  'widget. A SaveAction handles SaveIntent and increments the '
                  'save counter. The Focus widget has autofocus: true so key '
                  'events are captured immediately. Press Ctrl+S on a physical '
                  'keyboard or tap the button below to simulate the action.',
                  style: TextStyle(color: cs.onSurface),
                ),
              ),
              const SizedBox(height: 20),
              _SectionTitle('Shortcut Registration Code'),
              _CodeBlock(
                '// 1. Define the activator\n'
                'final ctrlS = LogicalKeySet(\n'
                '  LogicalKeyboardKey.control,\n'
                '  LogicalKeyboardKey.keyS,\n'
                ');\n\n'
                '// 2. Map it to an Intent\n'
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    ctrlS: const SaveIntent(),\n'
                '  },\n'
                '  child: Actions(\n'
                '    actions: { SaveIntent: SaveAction() },\n'
                '    child: Focus(autofocus: true, child: myApp),\n'
                '  ),\n'
                ')',
              ),
              const SizedBox(height: 20),
              Builder(
                builder: (innerCtx) {
                  return _InfoCard(
                    color: cs.primaryContainer,
                    child: Column(
                      children: [
                        Text(
                          'Active shortcut: Ctrl+S',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: cs.onPrimaryContainer,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'LogicalKeySet keys: ${ctrlS.keys.map((k) => k.keyLabel).join(' + ')}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder<int>(
                          valueListenable: _saveCount,
                          builder: (context2, count, child2) =>Column(
                            children: [
                              Text(
                                'Save count: $count',
                                style: Theme.of(innerCtx)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: cs.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              FilledButton.icon(
                                onPressed: () => Actions.invoke(
                                  innerCtx,
                                  const SaveIntent(),
                                ),
                                icon: const Icon(Icons.save),
                                label: const Text('Simulate Ctrl+S'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _SectionTitle('Event Log'),
              ValueListenableBuilder<List<String>>(
                valueListenable: _eventLog,
                builder: (context2, log, child2) {
                  if (log.isEmpty) {
                    return _InfoCard(
                      child: Text(
                        'No events yet — trigger a shortcut.',
                        style: TextStyle(
                          color: cs.onSurface.withAlpha(120),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }
                  return _InfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: log
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_right,
                                      size: 16, color: cs.primary),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 3 — Multi-Key Combos
// ---------------------------------------------------------------------------
class _MultiKeyTab extends StatelessWidget {
  const _MultiKeyTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final shortcuts = <ShortcutActivator, Intent>{
      LogicalKeySet(
        LogicalKeyboardKey.control,
        LogicalKeyboardKey.keyZ,
      ): const UndoIntent(),
      LogicalKeySet(
        LogicalKeyboardKey.control,
        LogicalKeyboardKey.shift,
        LogicalKeyboardKey.keyZ,
      ): const RedoIntent(),
      LogicalKeySet(
        LogicalKeyboardKey.alt,
        LogicalKeyboardKey.f4,
      ): const CloseWindowIntent(),
      LogicalKeySet(
        LogicalKeyboardKey.control,
        LogicalKeyboardKey.alt,
        LogicalKeyboardKey.keyT,
      ): const OpenTerminalIntent(),
      LogicalKeySet(
        LogicalKeyboardKey.meta,
        LogicalKeyboardKey.keyL,
      ): const LockScreenIntent(),
    };

    final combos = [
      _ComboRow(
        label: 'Ctrl+Z',
        description: 'Undo last action',
        keys: [LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ],
        intent: const UndoIntent(),
        counter: _undoCount,
        icon: Icons.undo,
      ),
      _ComboRow(
        label: 'Ctrl+Shift+Z',
        description: 'Redo last undone action',
        keys: [
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.shift,
          LogicalKeyboardKey.keyZ,
        ],
        intent: const RedoIntent(),
        counter: _redoCount,
        icon: Icons.redo,
      ),
      _ComboRow(
        label: 'Alt+F4',
        description: 'Close window (Windows/Linux)',
        keys: [LogicalKeyboardKey.alt, LogicalKeyboardKey.f4],
        intent: const CloseWindowIntent(),
        counter: _altF4Count,
        icon: Icons.close,
      ),
      _ComboRow(
        label: 'Ctrl+Alt+T',
        description: 'Open terminal (Linux)',
        keys: [
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.alt,
          LogicalKeyboardKey.keyT,
        ],
        intent: const OpenTerminalIntent(),
        counter: _terminalCount,
        icon: Icons.terminal,
      ),
      _ComboRow(
        label: 'Meta+L',
        description: 'Lock screen (Windows/Linux)',
        keys: [LogicalKeyboardKey.meta, LogicalKeyboardKey.keyL],
        intent: const LockScreenIntent(),
        counter: _lockCount,
        icon: Icons.lock,
      ),
    ];

    return Shortcuts(
      shortcuts: shortcuts,
      child: Actions(
        actions: <Type, Action<Intent>>{
          UndoIntent: UndoAction(),
          RedoIntent: RedoAction(),
          CloseWindowIntent: CloseWindowAction(),
          OpenTerminalIntent: OpenTerminalAction(),
          LockScreenIntent: LockScreenAction(),
        },
        child: Focus(
          autofocus: false,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _SectionTitle('Multi-Key Combo Gallery'),
              _InfoCard(
                child: Text(
                  'Five LogicalKeySets of varying complexity are all wired '
                  'into one Shortcuts widget. Each has a dedicated trigger '
                  'button. The event log on the Live Binding tab captures all '
                  'invocations.',
                  style: TextStyle(color: cs.onSurface),
                ),
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (innerCtx) => Column(
                  children: combos.map((c) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ComboCard(row: c, ctx: innerCtx),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              _SectionTitle('Shortcut Map Construction'),
              _CodeBlock(
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    LogicalKeySet(\n'
                '      LogicalKeyboardKey.control,\n'
                '      LogicalKeyboardKey.keyZ,\n'
                '    ): const UndoIntent(),\n'
                '    LogicalKeySet(\n'
                '      LogicalKeyboardKey.control,\n'
                '      LogicalKeyboardKey.shift,\n'
                '      LogicalKeyboardKey.keyZ,\n'
                '    ): const RedoIntent(),\n'
                '    LogicalKeySet(\n'
                '      LogicalKeyboardKey.alt,\n'
                '      LogicalKeyboardKey.f4,\n'
                '    ): const CloseWindowIntent(),\n'
                '    // ... more combos\n'
                '  },\n'
                '  child: Actions(actions: { ... }, child: child),\n'
                ')',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComboRow {
  const _ComboRow({
    required this.label,
    required this.description,
    required this.keys,
    required this.intent,
    required this.counter,
    required this.icon,
  });

  final String label;
  final String description;
  final List<LogicalKeyboardKey> keys;
  final Intent intent;
  final ValueNotifier<int> counter;
  final IconData icon;
}

class _ComboCard extends StatelessWidget {
  const _ComboCard({required this.row, required this.ctx});

  final _ComboRow row;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _InfoCard(
      child: Row(
        children: [
          Icon(row.icon, color: cs.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  row.description,
                  style: TextStyle(
                    color: cs.onSurface.withAlpha(160),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  children: row.keys
                      .map((k) => _KeyChip(k.keyLabel, modifier: true))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: row.counter,
                builder: (context2, count, child2) =>Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: cs.primary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              FilledButton.tonal(
                onPressed: () => Actions.invoke(ctx, row.intent),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  minimumSize: Size.zero,
                ),
                child: const Text('Trigger', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 4 — Key Constants Gallery
// ---------------------------------------------------------------------------
class _KeyGalleryTab extends StatelessWidget {
  const _KeyGalleryTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final groups = <_KeyGroup>[
      _KeyGroup(
        name: 'Modifier Keys',
        color: cs.primaryContainer,
        onColor: cs.onPrimaryContainer,
        keys: [
          'control',
          'shift',
          'alt',
          'meta',
          'controlLeft',
          'controlRight',
          'shiftLeft',
          'shiftRight',
          'altLeft',
          'altRight',
          'metaLeft',
          'metaRight',
          'capsLock',
          'numLock',
        ],
        logical: [
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.shift,
          LogicalKeyboardKey.alt,
          LogicalKeyboardKey.meta,
          LogicalKeyboardKey.controlLeft,
          LogicalKeyboardKey.controlRight,
          LogicalKeyboardKey.shiftLeft,
          LogicalKeyboardKey.shiftRight,
          LogicalKeyboardKey.altLeft,
          LogicalKeyboardKey.altRight,
          LogicalKeyboardKey.metaLeft,
          LogicalKeyboardKey.metaRight,
          LogicalKeyboardKey.capsLock,
          LogicalKeyboardKey.numLock,
        ],
      ),
      _KeyGroup(
        name: 'Navigation Keys',
        color: cs.secondaryContainer,
        onColor: cs.onSecondaryContainer,
        keys: [
          'arrowUp',
          'arrowDown',
          'arrowLeft',
          'arrowRight',
          'home',
          'end',
          'pageUp',
          'pageDown',
          'tab',
          'escape',
          'enter',
          'backspace',
        ],
        logical: [
          LogicalKeyboardKey.arrowUp,
          LogicalKeyboardKey.arrowDown,
          LogicalKeyboardKey.arrowLeft,
          LogicalKeyboardKey.arrowRight,
          LogicalKeyboardKey.home,
          LogicalKeyboardKey.end,
          LogicalKeyboardKey.pageUp,
          LogicalKeyboardKey.pageDown,
          LogicalKeyboardKey.tab,
          LogicalKeyboardKey.escape,
          LogicalKeyboardKey.enter,
          LogicalKeyboardKey.backspace,
        ],
      ),
      _KeyGroup(
        name: 'Function Keys',
        color: cs.tertiaryContainer,
        onColor: cs.onTertiaryContainer,
        keys: [
          'f1', 'f2', 'f3', 'f4', 'f5', 'f6',
          'f7', 'f8', 'f9', 'f10', 'f11', 'f12',
        ],
        logical: [
          LogicalKeyboardKey.f1,
          LogicalKeyboardKey.f2,
          LogicalKeyboardKey.f3,
          LogicalKeyboardKey.f4,
          LogicalKeyboardKey.f5,
          LogicalKeyboardKey.f6,
          LogicalKeyboardKey.f7,
          LogicalKeyboardKey.f8,
          LogicalKeyboardKey.f9,
          LogicalKeyboardKey.f10,
          LogicalKeyboardKey.f11,
          LogicalKeyboardKey.f12,
        ],
      ),
      _KeyGroup(
        name: 'Editing Keys',
        color: cs.errorContainer,
        onColor: cs.onErrorContainer,
        keys: [
          'delete',
          'insert',
          'space',
          'slash',
          'semicolon',
          'comma',
          'period',
          'bracketLeft',
          'bracketRight',
          'backslash',
          'quote',
          'backquote',
        ],
        logical: [
          LogicalKeyboardKey.delete,
          LogicalKeyboardKey.insert,
          LogicalKeyboardKey.space,
          LogicalKeyboardKey.slash,
          LogicalKeyboardKey.semicolon,
          LogicalKeyboardKey.comma,
          LogicalKeyboardKey.period,
          LogicalKeyboardKey.bracketLeft,
          LogicalKeyboardKey.bracketRight,
          LogicalKeyboardKey.backslash,
          LogicalKeyboardKey.quote,
          LogicalKeyboardKey.backquote,
        ],
      ),
      _KeyGroup(
        name: 'Numpad Keys',
        color: cs.surfaceContainerHighest,
        onColor: cs.onSurface,
        keys: [
          'numpad0', 'numpad1', 'numpad2', 'numpad3', 'numpad4',
          'numpad5', 'numpad6', 'numpad7', 'numpad8', 'numpad9',
          'numpadAdd', 'numpadSubtract',
          'numpadMultiply', 'numpadDivide',
          'numpadEnter', 'numpadDecimal',
        ],
        logical: [
          LogicalKeyboardKey.numpad0,
          LogicalKeyboardKey.numpad1,
          LogicalKeyboardKey.numpad2,
          LogicalKeyboardKey.numpad3,
          LogicalKeyboardKey.numpad4,
          LogicalKeyboardKey.numpad5,
          LogicalKeyboardKey.numpad6,
          LogicalKeyboardKey.numpad7,
          LogicalKeyboardKey.numpad8,
          LogicalKeyboardKey.numpad9,
          LogicalKeyboardKey.numpadAdd,
          LogicalKeyboardKey.numpadSubtract,
          LogicalKeyboardKey.numpadMultiply,
          LogicalKeyboardKey.numpadDivide,
          LogicalKeyboardKey.numpadEnter,
          LogicalKeyboardKey.numpadDecimal,
        ],
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionTitle('LogicalKeyboardKey Constants Gallery'),
        _InfoCard(
          child: Text(
            'LogicalKeyboardKey provides hundreds of constants covering all '
            'standard keyboard keys. Below is a curated set grouped by '
            'category. Each chip shows the constant name and keyLabel. '
            'These constants are the building blocks passed to '
            'LogicalKeySet constructors.',
            style: TextStyle(color: cs.onSurface),
          ),
        ),
        const SizedBox(height: 16),
        ...groups.map((g) => _KeyGroupWidget(group: g)),
      ],
    );
  }
}

class _KeyGroup {
  const _KeyGroup({
    required this.name,
    required this.color,
    required this.onColor,
    required this.keys,
    required this.logical,
  });

  final String name;
  final Color color;
  final Color onColor;
  final List<String> keys;
  final List<LogicalKeyboardKey> logical;
}

class _KeyGroupWidget extends StatelessWidget {
  const _KeyGroupWidget({required this.group});

  final _KeyGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: group.color.withAlpha(60),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: group.color),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: group.onColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List.generate(
                group.keys.length,
                (i) => Tooltip(
                  message: 'keyId: 0x${group.logical[i].keyId.toRadixString(16)}\n'
                      'keyLabel: ${group.logical[i].keyLabel}',
                  child: Chip(
                    label: Text(
                      group.keys[i],
                      style: const TextStyle(fontSize: 11),
                    ),
                    backgroundColor: group.color.withAlpha(40),
                    side: BorderSide(color: group.color.withAlpha(180)),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    visualDensity: VisualDensity.compact,
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

// ---------------------------------------------------------------------------
// TAB 5 — fromSet Constructor
// ---------------------------------------------------------------------------
class _FromSetTab extends StatelessWidget {
  const _FromSetTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Demonstrate fromSet
    final fromSetCtrlS = LogicalKeySet.fromSet({
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.keyS,
    });

    final fromSetCtrlShiftZ = LogicalKeySet.fromSet({
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.keyZ,
    });

    final fromSetAlt1 = LogicalKeySet.fromSet({
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.digit1,
    });

    final fromSetF5 = LogicalKeySet.fromSet({
      LogicalKeyboardKey.f5,
    });

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionTitle('fromSet Constructor'),
        _InfoCard(
          child: Text(
            'LogicalKeySet.fromSet() accepts a Set<LogicalKeyboardKey> '
            'rather than up to four positional arguments. This is useful when '
            'the set of keys is computed dynamically at runtime, e.g. from '
            'configuration files or user preferences.',
            style: TextStyle(color: cs.onSurface),
          ),
        ),
        const SizedBox(height: 16),
        _SectionTitle('Construction Examples'),
        _CodeBlock(
          '// fromSet with 2 keys\n'
          'final ctrlS = LogicalKeySet.fromSet({\n'
          '  LogicalKeyboardKey.control,\n'
          '  LogicalKeyboardKey.keyS,\n'
          '});\n\n'
          '// fromSet with 3 keys\n'
          'final ctrlShiftZ = LogicalKeySet.fromSet({\n'
          '  LogicalKeyboardKey.control,\n'
          '  LogicalKeyboardKey.shift,\n'
          '  LogicalKeyboardKey.keyZ,\n'
          '});\n\n'
          '// fromSet with 1 key (single-key shortcut)\n'
          'final f5 = LogicalKeySet.fromSet({\n'
          '  LogicalKeyboardKey.f5,\n'
          '});\n\n'
          '// Dynamic construction from configuration\n'
          'Set<LogicalKeyboardKey> userKeys = loadShortcutFromPrefs();\n'
          'final customKey = LogicalKeySet.fromSet(userKeys);',
        ),
        const SizedBox(height: 20),
        _SectionTitle('Resulting Key Sets'),
        _FromSetCard(
          constructorExpr:
              'LogicalKeySet.fromSet({control, keyS})',
          keySet: fromSetCtrlS,
        ),
        const SizedBox(height: 10),
        _FromSetCard(
          constructorExpr:
              'LogicalKeySet.fromSet({control, shift, keyZ})',
          keySet: fromSetCtrlShiftZ,
        ),
        const SizedBox(height: 10),
        _FromSetCard(
          constructorExpr:
              'LogicalKeySet.fromSet({alt, digit1})',
          keySet: fromSetAlt1,
        ),
        const SizedBox(height: 10),
        _FromSetCard(
          constructorExpr: 'LogicalKeySet.fromSet({f5})',
          keySet: fromSetF5,
        ),
        const SizedBox(height: 20),
        _SectionTitle('Equality with Positional Constructor'),
        _InfoCard(
          color: cs.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LogicalKeySet(control, keyS) ==\nLogicalKeySet.fromSet({control, keyS})',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Result: ${LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS) == fromSetCtrlS}',
                style: TextStyle(
                  color: cs.onPrimaryContainer,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Both constructors produce equal objects because equality '
                'is based on the Set of keys, not construction method.',
                style: TextStyle(color: cs.onPrimaryContainer),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionTitle('Set Ordering Invariance'),
        _CodeBlock(
          '// All three are equal:\n'
          'LogicalKeySet(control, shift, keyZ)\n'
          'LogicalKeySet.fromSet({shift, control, keyZ})\n'
          'LogicalKeySet.fromSet({keyZ, shift, control})\n\n'
          '// Proof:\n'
          'assert(a == b && b == c); // true',
        ),
        const SizedBox(height: 8),
        _InfoCard(
          child: Row(
            children: [
              Icon(Icons.check_circle, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Ordering invariance verified: '
                  '${LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyZ) == LogicalKeySet.fromSet({LogicalKeyboardKey.shift, LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ})}',
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FromSetCard extends StatelessWidget {
  const _FromSetCard({
    required this.constructorExpr,
    required this.keySet,
  });

  final String constructorExpr;
  final LogicalKeySet keySet;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            constructorExpr,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: cs.primary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '.keys → Set of ${keySet.keys.length}:',
            style: TextStyle(
              fontSize: 12,
              color: cs.onSurface.withAlpha(160),
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: keySet.keys
                .map((k) => _KeyChip(k.keyLabel, modifier: true))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 6 — Comparison Table
// ---------------------------------------------------------------------------
class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionTitle('LogicalKeySet vs SingleActivator vs CharacterActivator'),
        _InfoCard(
          child: Text(
            'Flutter provides three ShortcutActivator implementations. '
            'Choose the right one based on your shortcut requirements.',
            style: TextStyle(color: cs.onSurface),
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _ComparisonTable(),
        ),
        const SizedBox(height: 20),
        _SectionTitle('Code Examples'),
        const _CodeBlock(
          '// --- LogicalKeySet (deprecated; still functional) ---\n'
          'final activator = LogicalKeySet(\n'
          '  LogicalKeyboardKey.control,\n'
          '  LogicalKeyboardKey.keyS,\n'
          ');\n\n'
          '// --- SingleActivator (recommended replacement) ---\n'
          'const activator = SingleActivator(\n'
          '  LogicalKeyboardKey.keyS,\n'
          '  control: true,\n'
          '  // meta: false, shift: false, alt: false (defaults)\n'
          '  // includeRepeats: true (default)\n'
          ');\n\n'
          '// --- CharacterActivator (character-based) ---\n'
          'const activator = CharacterActivator(\n'
          '  \'?\',\n'
          '  // meta: false, control: false, alt: false (defaults)\n'
          ');',
        ),
        const SizedBox(height: 20),
        _SectionTitle('Migration Guide: LogicalKeySet → SingleActivator'),
        _InfoCard(
          color: cs.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Before (LogicalKeySet):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              _CodeBlock(
                'LogicalKeySet(\n'
                '  LogicalKeyboardKey.control,\n'
                '  LogicalKeyboardKey.keyS,\n'
                ')',
              ),
              const SizedBox(height: 8),
              Text(
                'After (SingleActivator):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              const _CodeBlock(
                'const SingleActivator(\n'
                '  LogicalKeyboardKey.keyS,\n'
                '  control: true,\n'
                ')',
              ),
              const SizedBox(height: 8),
              Text(
                'SingleActivator is const-constructible and more expressive. '
                'It also handles left/right modifier distinction via '
                'includeRepeats and exact flag.',
                style: TextStyle(color: cs.onPrimaryContainer),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final rows = [
      _CompRow('Status', 'Deprecated', 'Recommended', 'Recommended'),
      _CompRow(
        'Modifier support',
        'Any key as modifier',
        'control/shift/alt/meta flags',
        'control/meta/alt flags',
      ),
      _CompRow(
        'Character support',
        'No (key constants only)',
        'No (key constants only)',
        'Yes (Unicode character)',
      ),
      _CompRow(
        'Key ordering',
        'Unordered set',
        'N/A (trigger + flags)',
        'N/A (character + flags)',
      ),
      _CompRow(
        'Const constructor',
        'No',
        'Yes',
        'Yes',
      ),
      _CompRow(
        'Left/right distinction',
        'Via controlLeft etc.',
        'No (both sides)',
        'No (both sides)',
      ),
      _CompRow(
        'Repeat key support',
        'Implicit',
        'includeRepeats flag',
        'Not applicable',
      ),
      _CompRow(
        'Max keys',
        '4 (positional) / unlimited (fromSet)',
        '1 trigger + 4 booleans',
        '1 character + 3 booleans',
      ),
      _CompRow(
        'Use case',
        'Legacy code; dynamic key sets',
        'Standard modifier combos',
        'Punctuation / text shortcuts',
      ),
    ];

    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: cs.onPrimary,
      fontSize: 12,
    );

    final cellStyle = TextStyle(fontSize: 11, color: cs.onSurface);

    final deprecatedStyle = TextStyle(
      fontSize: 11,
      color: cs.error,
      fontStyle: FontStyle.italic,
    );

    return Table(
      border: TableBorder.all(color: cs.outlineVariant, width: 1),
      columnWidths: const {
        0: FixedColumnWidth(140),
        1: FixedColumnWidth(160),
        2: FixedColumnWidth(180),
        3: FixedColumnWidth(180),
      },
      children: [
        // Header
        TableRow(
          decoration: BoxDecoration(color: cs.primary),
          children: [
            _tableCell('Attribute', headerStyle),
            _tableCell('LogicalKeySet', headerStyle),
            _tableCell('SingleActivator', headerStyle),
            _tableCell('CharacterActivator', headerStyle),
          ],
        ),
        // Data rows
        ...rows.asMap().entries.map((entry) {
          final i = entry.key;
          final r = entry.value;
          final bg = i.isEven
              ? cs.surfaceContainerHighest.withAlpha(60)
              : Colors.transparent;
          return TableRow(
            decoration: BoxDecoration(color: bg),
            children: [
              _tableCell(
                r.attribute,
                cellStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              _tableCell(
                r.logicalKeySet,
                r.attribute == 'Status' ? deprecatedStyle : cellStyle,
              ),
              _tableCell(r.singleActivator, cellStyle),
              _tableCell(r.characterActivator, cellStyle),
            ],
          );
        }),
      ],
    );
  }

  Widget _tableCell(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: style),
    );
  }
}

class _CompRow {
  const _CompRow(
      this.attribute, this.logicalKeySet, this.singleActivator,
      this.characterActivator);

  final String attribute;
  final String logicalKeySet;
  final String singleActivator;
  final String characterActivator;
}

// ---------------------------------------------------------------------------
// TAB 7 — CustomPainter Diagram
// ---------------------------------------------------------------------------
class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionTitle('Shortcut Resolution Pipeline'),
        _InfoCard(
          child: Text(
            'When the user presses a key, the event travels through several '
            'layers before reaching the action. The diagram below shows the '
            'complete pipeline from raw hardware event to Intent invocation.',
            style: TextStyle(color: cs.onSurface),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomPaint(
            size: const Size(double.infinity, 110),
            painter: _ShortcutPipelinePainter(accentColor: cs.primary),
          ),
        ),
        const SizedBox(height: 24),
        _SectionTitle('Step-by-Step Explanation'),
        ..._buildSteps(context, cs),
        const SizedBox(height: 20),
        _SectionTitle('accepts() Implementation Detail'),
        const _CodeBlock(
          '// Pseudocode of LogicalKeySet.accepts()\n'
          'bool accepts(KeyEvent event, HardwareKeyboard keyboard) {\n'
          '  if (event is! KeyDownEvent && event is! KeyRepeatEvent) {\n'
          '    return false;\n'
          '  }\n'
          '  // The currently pressed logical keys\n'
          '  final pressed = keyboard.logicalKeysPressed;\n'
          '  // Must be an exact match with the stored key set\n'
          '  return pressed.length == keys.length &&\n'
          '         pressed.containsAll(keys);\n'
          '}',
        ),
        const SizedBox(height: 20),
        _SectionTitle('ShortcutManager Resolution Order'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _step(context, '1',
                  'Walk up the widget tree to find all Shortcuts widgets.'),
              _step(context, '2',
                  'For each Shortcuts widget, try each ShortcutActivator.'),
              _step(context, '3',
                  'Call activator.accepts(event, HardwareKeyboard.instance).'),
              _step(context, '4',
                  'First match wins; dispatch the mapped Intent.'),
              _step(context, '5',
                  'Actions walk up the tree to find a handler for the Intent.'),
              _step(context, '6',
                  'Matched Action.invoke() is called with the Intent.'),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSteps(BuildContext context, ColorScheme cs) {
    final steps = [
      ('HardwareKeyboard', 'Receives raw physical KeyEvent from the platform '
          '(KeyDownEvent, KeyUpEvent, KeyRepeatEvent).'),
      ('RawKeyboard / Focus', 'The legacy RawKeyboard layer and the FocusNode '
          'that has keyboard focus propagate the event.'),
      ('Shortcuts widget', 'Intercepts the event and passes it to its '
          'ShortcutManager for resolution.'),
      ('ShortcutManager', 'Iterates the shortcuts map and calls '
          'activator.accepts() for each ShortcutActivator.'),
      ('LogicalKeySet.accepts()', 'Compares the set of currently pressed '
          'LogicalKeyboardKey values against the stored set. Returns true only '
          'on exact match.'),
      ('Intent → Action', 'On match, the mapped Intent is dispatched via '
          'Actions.invoke(). The Action\'s invoke() method is called.'),
    ];

    return steps.asMap().entries.map((entry) {
      final i = entry.key;
      final s = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.$1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    s.$2,
                    style: TextStyle(
                      color: cs.onSurface.withAlpha(180),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _step(BuildContext context, String num, String text) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: cs.primaryContainer,
            child: Text(
              num,
              style: TextStyle(
                fontSize: 11,
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 8 — Platform Modifier Keys
// ---------------------------------------------------------------------------
class _PlatformsTab extends StatelessWidget {
  const _PlatformsTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionTitle('Platform Modifier Key Mapping'),
        _InfoCard(
          child: Text(
            'The meaning of modifier keys differs across platforms. '
            'LogicalKeySet uses platform-independent logical key constants, '
            'but it is important to understand what physical keys they map to '
            'on each platform when designing cross-platform shortcuts.',
            style: TextStyle(color: cs.onSurface),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _PlatformTable(cs: cs),
        ),
        const SizedBox(height: 20),
        _SectionTitle('Platform-Specific Notes'),
        _platformNote(
          context,
          'macOS',
          Icons.apple,
          cs.tertiaryContainer,
          cs.onTertiaryContainer,
          'The Command key maps to LogicalKeyboardKey.meta. Most app-level '
          'shortcuts (copy/paste/save) use Meta, not Control. Option maps to '
          'Alt. When porting Windows shortcuts, swap Ctrl → Meta.',
        ),
        const SizedBox(height: 8),
        _platformNote(
          context,
          'Windows',
          Icons.window,
          cs.primaryContainer,
          cs.onPrimaryContainer,
          'Control is the primary modifier. The Windows key maps to Meta '
          'but is rarely used in app shortcuts. Alt is used for menu access '
          '(Alt+F opens File menu). Alt+F4 closes windows.',
        ),
        const SizedBox(height: 8),
        _platformNote(
          context,
          'Linux',
          Icons.terminal,
          cs.secondaryContainer,
          cs.onSecondaryContainer,
          'Broadly similar to Windows. Super/Windows key maps to Meta. '
          'Ctrl+Alt+T opens a terminal in many desktop environments. '
          'Alt key behaviour may vary by desktop environment.',
        ),
        const SizedBox(height: 8),
        _platformNote(
          context,
          'iOS / Android',
          Icons.phone_iphone,
          cs.surfaceContainerHighest,
          cs.onSurface,
          'Physical keyboard shortcuts work on tablets with keyboards. '
          'The OS captures many modifier combos before Flutter sees them. '
          'LogicalKeySet shortcuts should be tested with a paired Bluetooth '
          'keyboard. On-screen keyboard events do not trigger shortcuts.',
        ),
        const SizedBox(height: 8),
        _platformNote(
          context,
          'Web',
          Icons.web,
          cs.errorContainer,
          cs.onErrorContainer,
          'The browser intercepts many key combos (Ctrl+T, Ctrl+W, etc.). '
          'LogicalKeySet shortcuts compete with browser shortcuts. Use '
          'allowInteraction in FocusNode or ServicesBinding.keyEventResult '
          'to handle conflicts. Meta key behaviour differs between macOS '
          'browser and Windows browser.',
        ),
        const SizedBox(height: 20),
        _SectionTitle('Cross-Platform Shortcut Strategy'),
        _CodeBlock(
          '// Prefer SingleActivator with platform detection:\n'
          'final isMac = Platform.isMacOS || kIsWeb && ...; // simplification\n\n'
          'final saveShortcut = isMac\n'
          '    ? const SingleActivator(\n'
          '        LogicalKeyboardKey.keyS, meta: true)\n'
          '    : const SingleActivator(\n'
          '        LogicalKeyboardKey.keyS, control: true);\n\n'
          '// Or use LogicalKeySet with platform-specific keys:\n'
          'final key = isMac\n'
          '    ? LogicalKeyboardKey.meta\n'
          '    : LogicalKeyboardKey.control;\n'
          'final legacyShortcut = LogicalKeySet(key, LogicalKeyboardKey.keyS);',
        ),
      ],
    );
  }

  Widget _platformNote(
    BuildContext context,
    String platform,
    IconData icon,
    Color bg,
    Color fg,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg.withAlpha(60),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: bg),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: fg, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: fg,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(text, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformTable extends StatelessWidget {
  const _PlatformTable({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: cs.onPrimary,
      fontSize: 12,
    );

    final cellStyle = const TextStyle(fontSize: 11);

    final platforms = ['macOS', 'Windows', 'Linux', 'iOS', 'Android', 'Web'];
    final rows = <_PlatRow>[
      _PlatRow('Ctrl equiv.', ['⌘ Command', 'Ctrl', 'Ctrl', 'Ctrl', 'Ctrl', 'Ctrl']),
      _PlatRow('Alt equiv.', ['⌥ Option', 'Alt', 'Alt', 'Option', 'Alt', 'Alt']),
      _PlatRow('Meta key', ['⌘ Command', 'Win key', 'Super', 'Globe', 'Search', 'OS key']),
      _PlatRow('Shift', ['Shift', 'Shift', 'Shift', 'Shift', 'Shift', 'Shift']),
      _PlatRow('CapsLock', ['CapsLock', 'CapsLock', 'CapsLock', 'CapsLock', 'CapsLock', 'N/A']),
      _PlatRow(
        'LogicalKeyboardKey',
        [
          '.meta',
          '.control',
          '.control',
          '.meta',
          '.meta',
          '.control',
        ],
      ),
    ];

    return Table(
      border: TableBorder.all(color: cs.outlineVariant, width: 1),
      columnWidths: const {
        0: FixedColumnWidth(130),
        1: FixedColumnWidth(100),
        2: FixedColumnWidth(100),
        3: FixedColumnWidth(100),
        4: FixedColumnWidth(100),
        5: FixedColumnWidth(100),
        6: FixedColumnWidth(100),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: cs.primary),
          children: [
            _cell('Modifier', headerStyle),
            ...platforms.map((p) => _cell(p, headerStyle)),
          ],
        ),
        ...rows.asMap().entries.map((entry) {
          final i = entry.key;
          final r = entry.value;
          final bg = i.isEven
              ? cs.surfaceContainerHighest.withAlpha(60)
              : Colors.transparent;
          return TableRow(
            decoration: BoxDecoration(color: bg),
            children: [
              _cell(r.modifier,
                  cellStyle.copyWith(fontWeight: FontWeight.bold)),
              ...r.values.map((v) => _cell(v, cellStyle)),
            ],
          );
        }),
      ],
    );
  }

  Widget _cell(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Text(text, style: style),
    );
  }
}

class _PlatRow {
  const _PlatRow(this.modifier, this.values);

  final String modifier;
  final List<String> values;
}

// ---------------------------------------------------------------------------
// TAB 9 — Pitfalls & API Cheat Sheet
// ---------------------------------------------------------------------------
class _PitfallsApiTab extends StatelessWidget {
  const _PitfallsApiTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionTitle('Common Pitfalls'),
        _pitfallCard(
          context,
          icon: Icons.sort,
          color: cs.tertiaryContainer,
          onColor: cs.onTertiaryContainer,
          title: 'Ordering Does Not Matter',
          body: 'LogicalKeySet stores keys in a Set. '
              'LogicalKeySet(control, keyS) and LogicalKeySet(keyS, control) '
              'are identical. Do not assume positional ordering when comparing '
              'or debugging key sets.',
          code: 'assert(\n'
              '  LogicalKeySet(control, keyS) ==\n'
              '  LogicalKeySet(keyS, control)\n'
              '); // true — order is irrelevant',
        ),
        const SizedBox(height: 10),
        _pitfallCard(
          context,
          icon: Icons.keyboard_return,
          color: cs.secondaryContainer,
          onColor: cs.onSecondaryContainer,
          title: 'Single-Key Combos: Prefer SingleActivator',
          body: 'LogicalKeySet(f5) is valid but heavyweight for a single key. '
              'Use SingleActivator(LogicalKeyboardKey.f5) for single-key '
              'shortcuts. SingleActivator is const-constructible and more '
              'efficient.',
          code: '// Avoid:\n'
              'LogicalKeySet(LogicalKeyboardKey.f5)\n\n'
              '// Prefer:\n'
              'const SingleActivator(LogicalKeyboardKey.f5)',
        ),
        const SizedBox(height: 10),
        _pitfallCard(
          context,
          icon: Icons.lock_outline,
          color: cs.errorContainer,
          onColor: cs.onErrorContainer,
          title: 'Lock Key Interactions',
          body: 'CapsLock and NumLock are physical keys that stay pressed '
              'in the key state while active. A LogicalKeySet that includes '
              'LogicalKeyboardKey.capsLock will only trigger when CapsLock '
              'is physically held, not when CapsLock is toggled on. This is '
              'a common source of confusion.',
          code: '// CapsLock as modifier (held down, not toggled):\n'
              'LogicalKeySet(\n'
              '  LogicalKeyboardKey.capsLock,\n'
              '  LogicalKeyboardKey.keyA,\n'
              ')',
        ),
        const SizedBox(height: 10),
        _pitfallCard(
          context,
          icon: Icons.devices,
          color: cs.primaryContainer,
          onColor: cs.onPrimaryContainer,
          title: 'Left vs Right Modifier Keys',
          body: 'LogicalKeyboardKey.control matches EITHER left or right '
              'Ctrl because it is a logical (platform-abstracted) key. If '
              'you need to distinguish left from right, use controlLeft or '
              'controlRight. Note that this makes the LogicalKeySet '
              'platform-layout-sensitive.',
          code: '// Platform-agnostic (any Ctrl):\n'
              'LogicalKeySet(LogicalKeyboardKey.control, ...)\n\n'
              '// Left Ctrl only:\n'
              'LogicalKeySet(LogicalKeyboardKey.controlLeft, ...)',
        ),
        const SizedBox(height: 10),
        _pitfallCard(
          context,
          icon: Icons.warning_amber,
          color: cs.surfaceContainerHighest,
          onColor: cs.onSurface,
          title: 'Max 4 Keys in Positional Constructor',
          body: 'The positional constructor accepts 1 to 4 LogicalKeyboardKey '
              'arguments. For more keys, use LogicalKeySet.fromSet(). In '
              'practice, shortcuts with more than 3 keys are extremely rare '
              'and should be avoided for usability.',
          code: '// OK — up to 4 positional:\n'
              'LogicalKeySet(key1, key2, key3, key4)\n\n'
              '// For 5+ keys use fromSet:\n'
              'LogicalKeySet.fromSet({k1, k2, k3, k4, k5})',
        ),
        const SizedBox(height: 20),
        _SectionTitle('API Cheat Sheet'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _apiRow(context, 'Constructor (positional)',
                  'LogicalKeySet(key1, [key2, key3, key4])'),
              _apiDivider(cs),
              _apiRow(context, 'Constructor (set)',
                  'LogicalKeySet.fromSet(Set<LogicalKeyboardKey> keys)'),
              _apiDivider(cs),
              _apiRow(context, '.keys',
                  'Set<LogicalKeyboardKey> — the stored key set'),
              _apiDivider(cs),
              _apiRow(
                context,
                '.accepts(event, state)',
                'bool — true if pressed keys exactly match .keys\n'
                    '(inherited from ShortcutActivator)',
              ),
              _apiDivider(cs),
              _apiRow(
                context,
                '.triggers',
                'Iterable<LogicalKeyboardKey>? — returns .keys;\n'
                    'used by ShortcutManager for lookup optimisation',
              ),
              _apiDivider(cs),
              _apiRow(
                context,
                'operator ==',
                'Set-based equality — two LogicalKeySets are equal\n'
                    'iff their key sets are equal',
              ),
              _apiDivider(cs),
              _apiRow(context, 'hashCode',
                  'Set-based hash — consistent with operator =='),
              _apiDivider(cs),
              _apiRow(
                context,
                'Shortcuts widget',
                'Map<ShortcutActivator, Intent> shortcuts\n'
                    'LogicalKeySet is a valid map key',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionTitle('Full Minimal Usage Example'),
        const _CodeBlock(
          'import \'package:flutter/material.dart\';\n'
          'import \'package:flutter/services.dart\';\n\n'
          'class SaveIntent extends Intent { const SaveIntent(); }\n\n'
          'class SaveAction extends Action<SaveIntent> {\n'
          '  @override\n'
          '  Object? invoke(SaveIntent intent) {\n'
          '    // perform save\n'
          '    return null;\n'
          '  }\n'
          '}\n\n'
          'Widget build(BuildContext context) {\n'
          '  return Shortcuts(\n'
          '    shortcuts: {\n'
          '      LogicalKeySet(\n'
          '        LogicalKeyboardKey.control,\n'
          '        LogicalKeyboardKey.keyS,\n'
          '      ): const SaveIntent(),\n'
          '    },\n'
          '    child: Actions(\n'
          '      actions: { SaveIntent: SaveAction() },\n'
          '      child: Focus(\n'
          '        autofocus: true,\n'
          '        child: YourAppBody(),\n'
          '      ),\n'
          '    ),\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 20),
        _SectionTitle('Key Takeaways'),
        _InfoCard(
          color: cs.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _takeaway(context, cs,
                  'LogicalKeySet is still functional but deprecated — '
                  'prefer SingleActivator for new code.'),
              _takeaway(context, cs,
                  'Keys in a LogicalKeySet are unordered — the set is what '
                  'matters, not insertion order.'),
              _takeaway(context, cs,
                  'accepts() requires an exact key-set match; extra pressed '
                  'keys cause it to return false.'),
              _takeaway(context, cs,
                  'Use fromSet() when the key set is dynamic or has more '
                  'than 4 keys.'),
              _takeaway(context, cs,
                  'Platform differences require care — especially macOS Meta '
                  'vs Windows/Linux Control.'),
              _takeaway(context, cs,
                  'For character-based shortcuts (e.g. \'?\'), use '
                  'CharacterActivator instead.'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _pitfallCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required Color onColor,
    required String title,
    required String body,
    required String code,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: onColor, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: onColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(body, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          _CodeBlock(code),
        ],
      ),
    );
  }

  Widget _apiRow(BuildContext context, String name, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(desc, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _apiDivider(ColorScheme cs) {
    return Divider(color: cs.outlineVariant, height: 1);
  }

  Widget _takeaway(BuildContext context, ColorScheme cs, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: cs.primary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: cs.onPrimaryContainer, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
