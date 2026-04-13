import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  return const _DefaultTextEditingShortcutsDemoApp();
}

class _DefaultTextEditingShortcutsDemoApp extends StatelessWidget {
  const _DefaultTextEditingShortcutsDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A5D6D)),
        useMaterial3: true,
      ),
      home: const _DefaultTextEditingShortcutsDemoPage(),
    );
  }
}

class _DefaultTextEditingShortcutsDemoPage extends StatefulWidget {
  const _DefaultTextEditingShortcutsDemoPage();

  @override
  State<_DefaultTextEditingShortcutsDemoPage> createState() => _DefaultTextEditingShortcutsDemoPageState();
}

class _DefaultTextEditingShortcutsDemoPageState extends State<_DefaultTextEditingShortcutsDemoPage> {
  final FocusNode _overrideNodeA = FocusNode(debugLabel: 'override-a');
  final FocusNode _overrideNodeB = FocusNode(debugLabel: 'override-b');
  final FocusNode _overrideNodeC = FocusNode(debugLabel: 'override-c');

  final TextEditingController _baselineControllerA = TextEditingController(
    text: 'Try selecting words with Shift+Arrow, Ctrl+A for select-all, and Backspace/Delete behaviors.',
  );
  final TextEditingController _baselineControllerB = TextEditingController(
    text: 'DefaultTextEditingShortcuts installs a platform-aware Shortcuts map for text editing intents.',
  );

  final TextEditingController _overrideControllerA = TextEditingController(text: 'Alt+Down should move focus to the next field.');
  final TextEditingController _overrideControllerB = TextEditingController(text: 'Alt+Up should move focus to the previous field.');
  final TextEditingController _overrideControllerC = TextEditingController(text: 'Cursor movement keys still work normally unless remapped.');

  final TextEditingController _counterSceneController = TextEditingController(
    text: 'ArrowUp and ArrowDown are remapped to counter actions in this scene.',
  );

  final TextEditingController _logSceneController = TextEditingController(
    text: 'Press Ctrl+Enter to commit, Ctrl+L to clear log, F2 to insert a timestamp marker.',
  );

  final TextEditingController _moduleControllerOps = TextEditingController(text: 'Operations backlog note...');
  final TextEditingController _moduleControllerCreative = TextEditingController(text: 'Creative campaign note...');
  final TextEditingController _moduleControllerResearch = TextEditingController(text: 'Research summary note...');

  final List<String> _commandLog = [];
  int _counterValue = 0;

  @override
  void dispose() {
    _overrideNodeA.dispose();
    _overrideNodeB.dispose();
    _overrideNodeC.dispose();

    _baselineControllerA.dispose();
    _baselineControllerB.dispose();
    _overrideControllerA.dispose();
    _overrideControllerB.dispose();
    _overrideControllerC.dispose();
    _counterSceneController.dispose();
    _logSceneController.dispose();
    _moduleControllerOps.dispose();
    _moduleControllerCreative.dispose();
    _moduleControllerResearch.dispose();
    super.dispose();
  }

  void _appendLog(String entry) {
    setState(() {
      _commandLog.insert(0, entry);
      if (_commandLog.length > 8) {
        _commandLog.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const cOcean = Color(0xFF0A5D6D);
    const cCoral = Color(0xFFE17055);
    const cForest = Color(0xFF2E7D62);
    const cSlate = Color(0xFF364B57);
    const cViolet = Color(0xFF6F5AA6);
    const cSand = Color(0xFFF5F2EA);

    return Scaffold(
      backgroundColor: cSand,
      appBar: AppBar(
        backgroundColor: cOcean,
        foregroundColor: Colors.white,
        toolbarHeight: 74,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DefaultTextEditingShortcuts Deep Demo'),
            SizedBox(height: 2),
            Text(
              'Default keyboard shortcuts, overrides, intents, and editing workflows',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HeroBanner(),
            const SizedBox(height: 14),
            const _SceneCard(
              index: 1,
              title: 'Concept: What DefaultTextEditingShortcuts Provides',
              subtitle:
                  'A platform-aware shortcut layer for text editing intents, typically inserted by WidgetsApp/MaterialApp.',
              accent: cOcean,
              child: _ConceptScene(),
            ),
            const SizedBox(height: 12),
            _SceneCard(
              index: 2,
              title: 'Baseline Default Editing Behavior',
              subtitle:
                  'Real text fields under DefaultTextEditingShortcuts to exercise select, move, delete, and clipboard key flows.',
              accent: cCoral,
              child: _BaselineScene(
                controllerA: _baselineControllerA,
                controllerB: _baselineControllerB,
              ),
            ),
            const SizedBox(height: 12),
            _SceneCard(
              index: 3,
              title: 'Override Specific Keys with Nested Shortcuts',
              subtitle:
                  'Remap Alt+Up and Alt+Down to focus traversal while preserving default text editing shortcuts.',
              accent: cForest,
              child: _OverrideFocusScene(
                nodeA: _overrideNodeA,
                nodeB: _overrideNodeB,
                nodeC: _overrideNodeC,
                controllerA: _overrideControllerA,
                controllerB: _overrideControllerB,
                controllerC: _overrideControllerC,
              ),
            ),
            const SizedBox(height: 12),
            _SceneCard(
              index: 4,
              title: 'Custom Intents and Actions',
              subtitle:
                  'Arrow keys trigger custom app intents in one focused editor, showing how to layer app behavior over text fields.',
              accent: cViolet,
              child: _CounterIntentScene(
                controller: _counterSceneController,
                counterValue: _counterValue,
                onIncrement: () {
                  setState(() {
                    _counterValue += 1;
                  });
                },
                onDecrement: () {
                  setState(() {
                    _counterValue -= 1;
                  });
                },
                onReset: () {
                  setState(() {
                    _counterValue = 0;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            _SceneCard(
              index: 5,
              title: 'Editor Command Palette with Shortcut Log',
              subtitle:
                  'Map custom key combinations to command intents and visualize exact command dispatches in a live log.',
              accent: cSlate,
              child: _CommandLogScene(
                controller: _logSceneController,
                commandLog: _commandLog,
                onCommit: (text) {
                  _appendLog('commit: $text');
                },
                onClear: () {
                  setState(() {
                    _commandLog.clear();
                  });
                  _appendLog('log cleared');
                },
                onMarker: () {
                  final now = DateTime.now();
                  _appendLog('marker inserted at ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}');
                },
              ),
            ),
            const SizedBox(height: 12),
            _SceneCard(
              index: 6,
              title: 'Practical Module Architecture',
              subtitle:
                  'Three modules reuse one editor surface but inject different shortcut overlays and command semantics.',
              accent: const Color(0xFF7A5A3C),
              child: _ModuleArchitectureScene(
                opsController: _moduleControllerOps,
                creativeController: _moduleControllerCreative,
                researchController: _moduleControllerResearch,
              ),
            ),
            const SizedBox(height: 16),
            const _RecapCard(),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0A5D6D),
            Color(0xFF2B8393),
            Color(0xFF6E5AA7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DefaultTextEditingShortcuts',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This widget installs the default keyboard shortcut mappings used by text editing widgets. '
            'It maps key combinations to text editing intents and can be locally overridden by nested Shortcuts.',
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFFF1FAFF),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _TagChip(label: 'Shortcuts + Actions'),
              _TagChip(label: 'TextField Intents'),
              _TagChip(label: 'Platform-aware defaults'),
              _TagChip(label: 'Nested overrides'),
              _TagChip(label: 'Custom command layers'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.28)),
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
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$index',
                  style: TextStyle(color: accent, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, height: 1.45, color: accent.withValues(alpha: 0.8)),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'DefaultTextEditingShortcuts is usually provided by app shells, but local widgets can still insert it to ensure '
          'the default text-editing shortcut set is present under custom shortcut layers.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _ShortcutCategoryCard(
              title: 'Selection movement',
              accent: Color(0xFF0A5D6D),
              line1: 'Arrow keys -> move caret',
              line2: 'Shift+Arrow -> extend selection',
              line3: 'Ctrl+Arrow / Alt+Arrow -> word/line/document boundaries',
            ),
            _ShortcutCategoryCard(
              title: 'Deletion behavior',
              accent: Color(0xFFE17055),
              line1: 'Backspace/Delete -> character delete',
              line2: 'Ctrl+Backspace/Delete -> word deletion',
              line3: 'Alt+Backspace/Delete -> line boundary deletion',
            ),
            _ShortcutCategoryCard(
              title: 'Clipboard intents',
              accent: Color(0xFF2E7D62),
              line1: 'Ctrl/Cmd+C, X, V -> copy/cut/paste',
              line2: 'Ctrl+A -> select all',
              line3: 'Shift+Delete and Insert variants supported on some platforms',
            ),
            _ShortcutCategoryCard(
              title: 'Extensibility model',
              accent: Color(0xFF6F5AA6),
              line1: 'Add Shortcuts lower in tree to override only desired keys',
              line2: 'Map to built-in intents or custom intents',
              line3: 'Use Actions to execute behavior per intent type',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F7FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFB9D2DE)),
          ),
          child: const SelectableText(
            'DefaultTextEditingShortcuts(\n'
            '  child: Shortcuts( // optional overrides\n'
            '    shortcuts: {\n'
            '      SingleActivator(LogicalKeyboardKey.arrowDown, alt: true): NextFocusIntent(),\n'
            '    },\n'
            '    child: Actions(...),\n'
            '  ),\n'
            ')',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _ShortcutCategoryCard extends StatelessWidget {
  const _ShortcutCategoryCard({
    required this.title,
    required this.accent,
    required this.line1,
    required this.line2,
    required this.line3,
  });

  final String title;
  final Color accent;
  final String line1;
  final String line2;
  final String line3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 298,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.27)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 13)),
            const SizedBox(height: 6),
            Text(line1, style: const TextStyle(fontSize: 11.5, height: 1.35)),
            const SizedBox(height: 3),
            Text(line2, style: const TextStyle(fontSize: 11.5, height: 1.35)),
            const SizedBox(height: 3),
            Text(line3, style: const TextStyle(fontSize: 11.5, height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class _BaselineScene extends StatelessWidget {
  const _BaselineScene({
    required this.controllerA,
    required this.controllerB,
  });

  final TextEditingController controllerA;
  final TextEditingController controllerB;

  @override
  Widget build(BuildContext context) {
    return DefaultTextEditingShortcuts(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _InfoLine(
            'This baseline area intentionally uses default behavior only. Try common editing shortcuts directly in the fields.',
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6F4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF2C1B6)),
            ),
            child: const SelectableText(
              'Try these in either field:\n'
              '- Ctrl/Cmd+A: Select all\n'
              '- Shift+Arrow: Extend selection\n'
              '- Ctrl+Arrow: Jump by word\n'
              '- Ctrl+Backspace/Delete: Delete by word\n'
              '- Ctrl/Cmd+C/X/V: Clipboard actions',
              style: TextStyle(fontSize: 12, height: 1.45),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controllerA,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Baseline editor A',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controllerB,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Baseline editor B',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverrideFocusScene extends StatelessWidget {
  const _OverrideFocusScene({
    required this.nodeA,
    required this.nodeB,
    required this.nodeC,
    required this.controllerA,
    required this.controllerB,
    required this.controllerC,
  });

  final FocusNode nodeA;
  final FocusNode nodeB;
  final FocusNode nodeC;
  final TextEditingController controllerA;
  final TextEditingController controllerB;
  final TextEditingController controllerC;

  @override
  Widget build(BuildContext context) {
    return DefaultTextEditingShortcuts(
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.arrowDown, alt: true): NextFocusIntent(),
          SingleActivator(LogicalKeyboardKey.arrowUp, alt: true): PreviousFocusIntent(),
        },
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InfoLine(
                'Override example: Alt+Down and Alt+Up are remapped to focus traversal. '
                'All other default text editing shortcuts remain active from DefaultTextEditingShortcuts.',
              ),
              const SizedBox(height: 10),
              _OverrideFieldCard(
                title: 'Field 1',
                focusNode: nodeA,
                controller: controllerA,
                accent: const Color(0xFF2E7D62),
              ),
              const SizedBox(height: 8),
              _OverrideFieldCard(
                title: 'Field 2',
                focusNode: nodeB,
                controller: controllerB,
                accent: const Color(0xFF2E7D62),
              ),
              const SizedBox(height: 8),
              _OverrideFieldCard(
                title: 'Field 3',
                focusNode: nodeC,
                controller: controllerC,
                accent: const Color(0xFF2E7D62),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverrideFieldCard extends StatelessWidget {
  const _OverrideFieldCard({
    required this.title,
    required this.focusNode,
    required this.controller,
    required this.accent,
  });

  final String title;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: accent)),
          const SizedBox(height: 6),
          TextField(
            focusNode: focusNode,
            controller: controller,
            maxLines: 2,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: 'Alt+Up / Alt+Down focus traversal active',
            ),
          ),
        ],
      ),
    );
  }
}

class _IncreaseCounterIntent extends Intent {
  const _IncreaseCounterIntent();
}

class _DecreaseCounterIntent extends Intent {
  const _DecreaseCounterIntent();
}

class _ResetCounterIntent extends Intent {
  const _ResetCounterIntent();
}

class _CounterIntentScene extends StatelessWidget {
  const _CounterIntentScene({
    required this.controller,
    required this.counterValue,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  });

  final TextEditingController controller;
  final int counterValue;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return DefaultTextEditingShortcuts(
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.arrowUp): _IncreaseCounterIntent(),
          SingleActivator(LogicalKeyboardKey.arrowDown): _DecreaseCounterIntent(),
          SingleActivator(LogicalKeyboardKey.escape): _ResetCounterIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _IncreaseCounterIntent: CallbackAction<_IncreaseCounterIntent>(
              onInvoke: (intent) {
                onIncrement();
                return null;
              },
            ),
            _DecreaseCounterIntent: CallbackAction<_DecreaseCounterIntent>(
              onInvoke: (intent) {
                onDecrement();
                return null;
              },
            ),
            _ResetCounterIntent: CallbackAction<_ResetCounterIntent>(
              onInvoke: (intent) {
                onReset();
                return null;
              },
            ),
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InfoLine(
                'Inside this focus area, ArrowUp increments and ArrowDown decrements a counter intent. '
                'This demonstrates custom shortcut overlays for text widgets.',
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2EEFA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD2C7EC)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.keyboard_alt_rounded, color: Color(0xFF6F5AA6)),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Use keyboard: ArrowUp (+1), ArrowDown (-1), Escape (reset).',
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F5AA6).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'counter: $counterValue',
                        style: const TextStyle(
                          color: Color(0xFF6F5AA6),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Counter shortcut editor',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommitIntent extends Intent {
  const _CommitIntent();
}

class _ClearLogIntent extends Intent {
  const _ClearLogIntent();
}

class _InsertMarkerIntent extends Intent {
  const _InsertMarkerIntent();
}

class _CommandLogScene extends StatelessWidget {
  const _CommandLogScene({
    required this.controller,
    required this.commandLog,
    required this.onCommit,
    required this.onClear,
    required this.onMarker,
  });

  final TextEditingController controller;
  final List<String> commandLog;
  final ValueChanged<String> onCommit;
  final VoidCallback onClear;
  final VoidCallback onMarker;

  @override
  Widget build(BuildContext context) {
    return DefaultTextEditingShortcuts(
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter, control: true): _CommitIntent(),
          SingleActivator(LogicalKeyboardKey.keyL, control: true): _ClearLogIntent(),
          SingleActivator(LogicalKeyboardKey.f2): _InsertMarkerIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _CommitIntent: CallbackAction<_CommitIntent>(
              onInvoke: (intent) {
                onCommit(controller.text);
                return null;
              },
            ),
            _ClearLogIntent: CallbackAction<_ClearLogIntent>(
              onInvoke: (intent) {
                onClear();
                return null;
              },
            ),
            _InsertMarkerIntent: CallbackAction<_InsertMarkerIntent>(
              onInvoke: (intent) {
                onMarker();
                return null;
              },
            ),
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InfoLine(
                'This panel simulates an editor command layer. Shortcut dispatches are logged to make shortcut-to-action behavior explicit.',
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4F8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFCBD6DE)),
                ),
                child: const SelectableText(
                  'Shortcuts: Ctrl+Enter => commit text, Ctrl+L => clear log, F2 => insert marker',
                  style: TextStyle(fontSize: 12.2),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Command editor',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFCBD6DE)),
                ),
                child: commandLog.isEmpty
                    ? const Text(
                        'No commands yet. Trigger shortcuts to populate log.',
                        style: TextStyle(fontSize: 12.2, color: Color(0xFF5A6D79)),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recent commands',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
                          ),
                          const SizedBox(height: 6),
                          Text(commandLog[0], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                          if (commandLog.length > 1)
                            Text(commandLog[1], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                          if (commandLog.length > 2)
                            Text(commandLog[2], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                          if (commandLog.length > 3)
                            Text(commandLog[3], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                          if (commandLog.length > 4)
                            Text(commandLog[4], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                          if (commandLog.length > 5)
                            Text(commandLog[5], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                          if (commandLog.length > 6)
                            Text(commandLog[6], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                          if (commandLog.length > 7)
                            Text(commandLog[7], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
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

class _ModuleArchitectureScene extends StatelessWidget {
  const _ModuleArchitectureScene({
    required this.opsController,
    required this.creativeController,
    required this.researchController,
  });

  final TextEditingController opsController;
  final TextEditingController creativeController;
  final TextEditingController researchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Each module below reuses the same editor scaffold but applies different shortcut overlays. '
          'Default text editing mappings remain available from DefaultTextEditingShortcuts.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ModuleEditorCard(
              title: 'Operations module',
              accent: const Color(0xFF0A5D6D),
              controller: opsController,
              commandHint: 'Alt+Down / Alt+Up focus movement between ops forms',
              shortcuts: const <ShortcutActivator, Intent>{
                SingleActivator(LogicalKeyboardKey.arrowDown, alt: true): NextFocusIntent(),
                SingleActivator(LogicalKeyboardKey.arrowUp, alt: true): PreviousFocusIntent(),
              },
            ),
            _ModuleEditorCard(
              title: 'Creative module',
              accent: const Color(0xFFE17055),
              controller: creativeController,
              commandHint: 'Ctrl+Enter commit action for creative drafts',
              shortcuts: const <ShortcutActivator, Intent>{
                SingleActivator(LogicalKeyboardKey.enter, control: true): _CommitIntent(),
              },
            ),
            _ModuleEditorCard(
              title: 'Research module',
              accent: const Color(0xFF2E7D62),
              controller: researchController,
              commandHint: 'F2 marker insertion for experiment notes',
              shortcuts: const <ShortcutActivator, Intent>{
                SingleActivator(LogicalKeyboardKey.f2): _InsertMarkerIntent(),
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _ModuleEditorCard extends StatelessWidget {
  const _ModuleEditorCard({
    required this.title,
    required this.accent,
    required this.controller,
    required this.commandHint,
    required this.shortcuts,
  });

  final String title;
  final Color accent;
  final TextEditingController controller;
  final String commandHint;
  final Map<ShortcutActivator, Intent> shortcuts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DefaultTextEditingShortcuts(
        child: Shortcuts(
          shortcuts: shortcuts,
          child: Actions(
            actions: <Type, Action<Intent>>{
              _CommitIntent: CallbackAction<_CommitIntent>(
                onInvoke: (intent) {
                  return null;
                },
              ),
              _InsertMarkerIntent: CallbackAction<_InsertMarkerIntent>(
                onInvoke: (intent) {
                  final text = controller.text;
                  controller.text = '$text [marker]';
                  controller.selection = TextSelection.collapsed(offset: controller.text.length);
                  return null;
                },
              ),
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent.withValues(alpha: 0.28)),
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
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: accent)),
                  const SizedBox(height: 4),
                  Text(commandHint, style: TextStyle(fontSize: 11.2, color: accent.withValues(alpha: 0.82))),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Reusable module editor',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFE9F3F7), Color(0xFFF8EDE6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFB7CAD5)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF314B5B)),
          ),
          SizedBox(height: 8),
          Text(
            '1) DefaultTextEditingShortcuts maps common keyboard editing combinations to intents.\n'
            '2) Nested Shortcuts can override specific keys while leaving defaults intact.\n'
            '3) Custom intents/actions layer app commands over focused text editors.\n'
            '4) Command logging makes shortcut dispatch behavior easy to inspect.\n'
            '5) Feature modules can inject different shortcut overlays without rewriting editor widgets.',
            style: TextStyle(fontSize: 12.4, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.5, height: 1.45));
  }
}
