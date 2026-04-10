// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo — ShortcutManager
///
/// ShortcutManager is the object that evaluates incoming key events against a
/// map of ShortcutActivator → Intent bindings. It sits inside the Shortcuts
/// widget and decides whether a key event should trigger an action dispatch.
/// Understanding ShortcutManager is essential for building keyboard-driven
/// Flutter apps.
///
/// Sections
/// ─────────
/// 1. ShortcutManager anatomy — constructor, properties, disposal
/// 2. ShortcutActivator hierarchy — SingleActivator, CharacterActivator, LogicalKeySet
/// 3. The Shortcuts → Actions pipeline
/// 4. Modal vs non-modal managers
/// 5. Shortcut precedence & bubbling
/// 6. Live keyboard shortcut demos
/// 7. Custom ShortcutManager subclass
/// 8. Platform-aware shortcut patterns

// ─── palette ───────────────────────────────────────────────
const _kPink       = Color(0xFFE91E63);
const _kPinkLight  = Color(0xFFF8BBD0);
const _kPinkDark   = Color(0xFF880E4F);
const _kIndigo      = Color(0xFF3F51B5);
const _kIndigoLight = Color(0xFFC5CAE9);
const _kIndigoDark  = Color(0xFF1A237E);
const _kSurface    = Color(0xFFFCFAFC);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── 1. Anatomy ────────────────────────────────────────────
class _ManagerProperty {
  const _ManagerProperty(this.name, this.type, this.description);
  final String name;
  final String type;
  final String description;
}

const _kManagerProps = <_ManagerProperty>[
  _ManagerProperty('shortcuts', 'Map<ShortcutActivator, Intent>',
      'The mapping from key combinations to intents. Setting this property '
      'replaces the entire map and notifies listeners.'),
  _ManagerProperty('modal', 'bool',
      'When true, unhandled key events are NOT passed to ancestor Shortcuts '
      'widgets. The manager "swallows" every event, handled or not. '
      'Default is false.'),
  _ManagerProperty('handleKeypress', 'KeyEventResult Function(...)',
      'Called by the Shortcuts widget\'s focus handler. Walks the shortcuts '
      'map to find a matching activator, then returns handled / skipRemainingHandlers / ignored.'),
  _ManagerProperty('dispose()', 'void',
      'Cleans up the ChangeNotifier. After disposal, the manager should not '
      'be used.'),
];

// ─── 2. Activator types ────────────────────────────────────
class _ActivatorInfo {
  const _ActivatorInfo(this.name, this.example, this.description);
  final String name;
  final String example;
  final String description;
}

const _kActivators = <_ActivatorInfo>[
  _ActivatorInfo('SingleActivator',
      'SingleActivator(LogicalKeyboardKey.keyS, control: true)',
      'Most common. Matches a single key with optional modifiers (control, '
      'shift, alt, meta). Triggers on keyDown by default.'),
  _ActivatorInfo('CharacterActivator',
      'CharacterActivator(\'?\')',
      'Matches the logical character produced by the key event, regardless '
      'of the physical key used. Useful for locale-independent shortcuts.'),
  _ActivatorInfo('LogicalKeySet',
      'LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ)',
      'Matches a set of simultaneously held keys (order-independent). '
      'Legacy API — prefer SingleActivator for new code.'),
];

// ─── 3. Pipeline stages ────────────────────────────────────
const _kPipelineStages = <String>[
  'KeyEvent arrives at the Shortcuts widget\'s FocusNode',
  'ShortcutManager.handleKeypress() is called with the event',
  'Manager iterates through shortcuts map, testing each ShortcutActivator',
  'If an activator.accepts(event) → returns the corresponding Intent',
  'The Intent is dispatched to the Actions widget above in the tree',
  'Actions.invoke(intent) finds the matching Action<Intent> and calls invoke()',
  'If no activator matches and modal=false → event bubbles to parent Shortcuts',
];

// ─── 5. Precedence rules ───────────────────────────────────
const _kPrecedenceRules = <String, String>{
  'Innermost wins':
      'If two nested Shortcuts widgets define the same key combination, '
      'the inner one handles it first. The outer one never sees the event.',
  'Map iteration order':
      'Within a single ShortcutManager, activators are tested in map '
      'iteration order (insertion order for LinkedHashMap). First match wins.',
  'Modal blocks bubbling':
      'A modal ShortcutManager prevents unhandled events from reaching '
      'ancestor Shortcuts widgets, even if the ancestor has the binding.',
  'Focus tree scope':
      'Shortcuts only receive events that reach their FocusNode. If a '
      'descendant FocusNode handled the event, Shortcuts never sees it.',
};

// ─── 8. Platform-aware patterns ────────────────────────────
class _PlatformShortcut {
  const _PlatformShortcut(this.action, this.macOS, this.other);
  final String action;
  final String macOS;
  final String other;
}

const _kPlatformShortcuts = <_PlatformShortcut>[
  _PlatformShortcut('Copy', '⌘ C', 'Ctrl+C'),
  _PlatformShortcut('Paste', '⌘ V', 'Ctrl+V'),
  _PlatformShortcut('Undo', '⌘ Z', 'Ctrl+Z'),
  _PlatformShortcut('Redo', '⇧⌘ Z', 'Ctrl+Y'),
  _PlatformShortcut('Select All', '⌘ A', 'Ctrl+A'),
  _PlatformShortcut('Save', '⌘ S', 'Ctrl+S'),
  _PlatformShortcut('Find', '⌘ F', 'Ctrl+F'),
];

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kPinkDark, _kIndigoDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text, style: TextStyle(fontSize: 11, color: _kTextMuted, fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5, color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kPink, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── custom intents & actions for live demo ────────────────
class _IncrementIntent extends Intent {
  const _IncrementIntent();
}

class _DecrementIntent extends Intent {
  const _DecrementIntent();
}

class _ResetIntent extends Intent {
  const _ResetIntent();
}

class _ToggleColorIntent extends Intent {
  const _ToggleColorIntent();
}

// ─── 7. Custom ShortcutManager ─────────────────────────────
class _LoggingShortcutManager extends ShortcutManager {
  _LoggingShortcutManager({required super.shortcuts});

  final List<String> log = [];

  @override
  KeyEventResult handleKeypress(BuildContext context, KeyEvent event) {
    if (event is KeyDownEvent) {
      final label = event.logicalKey.keyLabel;
      log.add('Key: $label at ${DateTime.now().millisecond}ms');
      print('[LoggingManager] handleKeypress: $label');
    }
    return super.handleKeypress(context, event);
  }
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('ShortcutManager deep visual demo');
  print('─' * 48);
  print('Sections: anatomy, activators, pipeline, modal,');
  print('precedence, live demos, custom manager, platform patterns.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kPink, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('ShortcutManager'),
        backgroundColor: _kPinkDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _Body(),
    ),
  );
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  int _counter = 0;
  bool _useAltColor = false;
  final List<String> _eventLog = [];
  final _focusNode = FocusNode(debugLabel: 'ShortcutDemo');

  late final _LoggingShortcutManager _loggingManager;

  @override
  void initState() {
    super.initState();
    _loggingManager = _LoggingShortcutManager(shortcuts: {
      SingleActivator(LogicalKeyboardKey.arrowUp): _IncrementIntent(),
      SingleActivator(LogicalKeyboardKey.arrowDown): _DecrementIntent(),
      SingleActivator(LogicalKeyboardKey.keyR, control: true): _ResetIntent(),
      SingleActivator(LogicalKeyboardKey.keyC, alt: true): _ToggleColorIntent(),
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _loggingManager.dispose();
    super.dispose();
  }

  void _addEvent(String msg) {
    setState(() {
      _eventLog.insert(0, msg);
      if (_eventLog.length > 12) _eventLog.removeLast();
    });
    print('[ShortcutDemo] $msg');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1: Anatomy ──
        _sectionHeader('1 · ShortcutManager Anatomy', Icons.settings_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('CLASS DEFINITION'),
              SizedBox(height: 8),
              _mono('class ShortcutManager with Diagnosticable, ChangeNotifier'),
              SizedBox(height: 10),
              Text(
                'ShortcutManager holds a map of keyboard shortcuts and evaluates '
                'incoming key events against them. It extends ChangeNotifier so '
                'the Shortcuts widget rebuilds when the map changes. You rarely '
                'need to subclass it — but you can to add logging, analytics, or '
                'conditional shortcut handling.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        ..._kManagerProps.map((p) => _card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: _kPinkLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name,
                        style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                            fontSize: 11, color: _kPinkDark)),
                    if (p.type != 'void')
                      Text(p.type, style: TextStyle(fontSize: 9.5, color: _kTextMuted)),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(p.description, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              ),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 2: Activators ──
        _sectionHeader('2 · ShortcutActivator Hierarchy', Icons.keyboard_outlined),
        SizedBox(height: 8),
        ..._kActivators.map((a) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kIndigoLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(a.name,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _kIndigoDark)),
              ),
              SizedBox(height: 8),
              _mono(a.example, color: _kPinkDark),
              SizedBox(height: 6),
              Text(a.description, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('ShortcutActivator INTERFACE'),
              SizedBox(height: 8),
              _mono('abstract class ShortcutActivator {'),
              _mono('  bool accepts(KeyEvent event, HardwareKeyboard state);'),
              _mono('  Iterable<LogicalKeyboardKey>? get triggers;'),
              _mono('  String debugDescribeKeys();'),
              _mono('}'),
              SizedBox(height: 8),
              Text(
                'triggers returns the keys that might activate this shortcut. '
                'The manager uses triggers as a quick pre-filter before calling '
                'accepts(). If triggers is null, every key event is tested.',
                style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35),
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 3: Pipeline ──
        _sectionHeader('3 · The Shortcuts → Actions Pipeline', Icons.route),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _kPipelineStages.asMap().entries.map((e) => Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22, height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: _kPinkDark, shape: BoxShape.circle),
                    child: Text('${e.key + 1}',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(e.value, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('WIDGET TREE STRUCTURE'),
              SizedBox(height: 8),
              _mono('Actions(', color: _kIndigoDark),
              _mono('  actions: { IncrementIntent: IncrementAction() },', color: _kIndigoDark),
              _mono('  child: Shortcuts(', color: _kPinkDark),
              _mono('    shortcuts: {', color: _kPinkDark),
              _mono('      SingleActivator(keyUp): IncrementIntent(),', color: _kPinkDark),
              _mono('    },', color: _kPinkDark),
              _mono('    child: Focus(child: ...),', color: _kTextMuted),
              _mono('  ),', color: _kPinkDark),
              _mono(')', color: _kIndigoDark),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 4: Modal ──
        _sectionHeader('4 · Modal vs Non-Modal Managers', Icons.block),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _modeBadge('Non-modal (default)', _kIndigo),
                  SizedBox(width: 8),
                  _modeBadge('Modal', _kPink),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'A non-modal manager lets unhandled key events propagate up to '
                'ancestor Shortcuts widgets. A modal manager consumes ALL events — '
                'even those that don\'t match any shortcut. This is useful for '
                'dialog-like contexts where you don\'t want parent shortcuts '
                'to fire.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 10),
              _mono('ShortcutManager(modal: true, shortcuts: {...})'),
              SizedBox(height: 6),
              _bullet('Use modal for dialogs, overlays, command palettes'),
              _bullet('Use non-modal (default) for general app shortcuts'),
              _bullet('Modal managers should define an escape-hatch shortcut'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 5: Precedence ──
        _sectionHeader('5 · Shortcut Precedence & Bubbling', Icons.sort),
        SizedBox(height: 8),
        ..._kPrecedenceRules.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.key,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: _kPinkDark)),
              SizedBox(height: 4),
              Text(e.value, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 6: Live demo ──
        _sectionHeader('6 · Live Keyboard Shortcut Demo', Icons.keyboard),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('TAP THE AREA BELOW TO FOCUS, THEN USE KEYBOARD SHORTCUTS'),
              SizedBox(height: 8),
              _bullet('↑ Arrow Up → increment counter'),
              _bullet('↓ Arrow Down → decrement counter'),
              _bullet('Ctrl+R → reset counter'),
              _bullet('Alt+C → toggle color'),
            ],
          ),
        ),
        _card(
          child: Shortcuts.manager(
            manager: _loggingManager,
            child: Actions(
              actions: {
                _IncrementIntent: CallbackAction<_IncrementIntent>(
                  onInvoke: (_) { _addEvent('↑ Increment → ${_counter + 1}'); setState(() => _counter++); return null; },
                ),
                _DecrementIntent: CallbackAction<_DecrementIntent>(
                  onInvoke: (_) { _addEvent('↓ Decrement → ${_counter - 1}'); setState(() => _counter--); return null; },
                ),
                _ResetIntent: CallbackAction<_ResetIntent>(
                  onInvoke: (_) { _addEvent('⟳ Reset → 0'); setState(() => _counter = 0); return null; },
                ),
                _ToggleColorIntent: CallbackAction<_ToggleColorIntent>(
                  onInvoke: (_) {
                    setState(() => _useAltColor = !_useAltColor);
                    _addEvent('Toggle color → ${_useAltColor ? "Indigo" : "Pink"}');
                    return null;
                  },
                ),
              },
              child: Focus(
                focusNode: _focusNode,
                autofocus: true,
                child: GestureDetector(
                  onTap: () => _focusNode.requestFocus(),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _useAltColor ? _kIndigoLight : _kPinkLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _focusNode.hasFocus
                            ? (_useAltColor ? _kIndigo : _kPink)
                            : _kDivider,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text('Counter',
                            style: TextStyle(fontSize: 14, color: _kTextMuted, fontWeight: FontWeight.w600)),
                        SizedBox(height: 8),
                        Text('$_counter',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                              color: _useAltColor ? _kIndigoDark : _kPinkDark,
                            )),
                        SizedBox(height: 8),
                        Text(
                          _focusNode.hasFocus ? 'Focused — use keyboard shortcuts' : 'Tap to focus',
                          style: TextStyle(fontSize: 12, color: _kTextMuted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_eventLog.isNotEmpty)
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('EVENT LOG'),
                SizedBox(height: 6),
                ..._eventLog.map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: _mono(e, color: _kTextDark),
                )),
              ],
            ),
          ),

        SizedBox(height: 12),

        // ── Section 7: Custom ShortcutManager ──
        _sectionHeader('7 · Custom ShortcutManager Subclass', Icons.build_circle_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You can subclass ShortcutManager to add logging, analytics, '
                'conditional handling, or dynamic shortcut resolution. Override '
                'handleKeypress() and call super to preserve default behavior.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 12),
              _mono('class LoggingShortcutManager extends ShortcutManager {'),
              _mono('  final List<String> log = [];'),
              _mono(''),
              _mono('  @override'),
              _mono('  KeyEventResult handleKeypress('),
              _mono('      BuildContext context, KeyEvent event) {'),
              _mono('    if (event is KeyDownEvent) {'),
              _mono('      log.add(event.logicalKey.keyLabel);'),
              _mono('    }'),
              _mono('    return super.handleKeypress(context, event);'),
              _mono('  }'),
              _mono('}'),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('USE CASES FOR CUSTOM MANAGERS'),
              SizedBox(height: 8),
              _bullet('Logging: track which shortcuts users actually press'),
              _bullet('Context-aware: enable/disable shortcuts based on app state'),
              _bullet('Remapping: load user-customizable keybindings from settings'),
              _bullet('Conflict detection: warn when two activators match the same event'),
              _bullet('Chords: implement multi-key sequences (e.g., Ctrl+K → Ctrl+C)'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 8: Platform patterns ──
        _sectionHeader('8 · Platform-Aware Shortcut Patterns', Icons.devices),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flutter defaults handle Ctrl vs ⌘ via the meta property, but '
                'explicit platform-aware shortcut maps make intent clearer. '
                'Use Theme.of(context).platform or defaultTargetPlatform to '
                'choose the right modifier.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('COMMON PLATFORM SHORTCUTS'),
              SizedBox(height: 8),
              _buildPlatformTable(),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('PATTERN: CONDITIONAL MODIFIER'),
              SizedBox(height: 8),
              _mono('final useCmd = defaultTargetPlatform == TargetPlatform.macOS;'),
              _mono(''),
              _mono('Shortcuts('),
              _mono('  shortcuts: {'),
              _mono('    SingleActivator('),
              _mono('      LogicalKeyboardKey.keyS,'),
              _mono('      control: !useCmd,'),
              _mono('      meta: useCmd,'),
              _mono('    ): SaveIntent(),'),
              _mono('  },'),
              _mono('  child: ...,'),
              _mono(')'),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('KEY TAKEAWAY'),
              SizedBox(height: 6),
              Text(
                'ShortcutManager is the brain behind keyboard shortcuts in Flutter. '
                'It separates the "what key was pressed" (ShortcutActivator) from '
                '"what should happen" (Intent → Action). This separation makes '
                'shortcuts testable, rebindable, and composable across widget '
                'subtrees. For most apps, the built-in Shortcuts widget is enough, '
                'but subclassing ShortcutManager unlocks advanced patterns like '
                'logging, user-customizable bindings, and multi-key sequences.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformTable() {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: _kDivider, width: 0.5),
      children: [
        TableRow(
          decoration: BoxDecoration(color: _kPinkLight.withOpacity(0.4)),
          children: ['Action', 'macOS', 'Other'].map((h) => Padding(
            padding: EdgeInsets.all(6),
            child: Text(h, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _kPinkDark)),
          )).toList(),
        ),
        ..._kPlatformShortcuts.map((s) => TableRow(
          children: [s.action, s.macOS, s.other].map((c) => Padding(
            padding: EdgeInsets.all(6),
            child: Text(c, style: TextStyle(fontSize: 12, color: _kTextDark)),
          )).toList(),
        )),
      ],
    );
  }
}

Widget _modeBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Text(text,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
  );
}
