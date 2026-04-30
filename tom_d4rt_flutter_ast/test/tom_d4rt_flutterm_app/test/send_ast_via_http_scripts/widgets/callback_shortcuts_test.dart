import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  return const _CallbackShortcutsDeepDemo();
}

enum _DemoStage {
  primer,
  precedenceArena,
  remapLab,
  listNavigation,
  shortcutsBridge,
  compendium,
}

enum _CanvasStyle {
  waves,
  blueprint,
  constellation,
}

class _Palette {
  final String name;
  final Color shell;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.shell,
    required this.canvas,
    required this.card,
    required this.ink,
    required this.muted,
    required this.accentA,
    required this.accentB,
    required this.accentC,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Marina Studio',
    shell: Color(0xFF142834),
    canvas: Color(0xFFF1F8FC),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF203A46),
    muted: Color(0xFF6E8797),
    accentA: Color(0xFF1D88DE),
    accentB: Color(0xFF169C76),
    accentC: Color(0xFFD3901A),
  ),
  _Palette(
    name: 'Forest Console',
    shell: Color(0xFF1B241D),
    canvas: Color(0xFFF4FAF5),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF2A382F),
    muted: Color(0xFF748679),
    accentA: Color(0xFF2E8E3B),
    accentB: Color(0xFF1E8C97),
    accentC: Color(0xFFB88725),
  ),
  _Palette(
    name: 'Copper Ops',
    shell: Color(0xFF2B221D),
    canvas: Color(0xFFFCF6EE),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF3B2F28),
    muted: Color(0xFF8B7C73),
    accentA: Color(0xFFB76433),
    accentB: Color(0xFF2F89A2),
    accentC: Color(0xFF9C8518),
  ),
];

class _ActionSpec {
  final String id;
  final String title;
  final String hint;
  final IconData icon;
  final Color tone;

  const _ActionSpec({
    required this.id,
    required this.title,
    required this.hint,
    required this.icon,
    required this.tone,
  });
}

class _ShortcutBinding {
  final ShortcutActivator activator;
  final _ActionSpec action;

  const _ShortcutBinding({
    required this.activator,
    required this.action,
  });
}

class _EventLog {
  final DateTime at;
  final String lane;
  final String message;
  final Color tone;

  const _EventLog({
    required this.at,
    required this.lane,
    required this.message,
    required this.tone,
  });
}

class _Profile {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color tone;
  final List<_ShortcutBinding> bindings;

  const _Profile({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.tone,
    required this.bindings,
  });
}

class _CallbackShortcutsDeepDemo extends StatefulWidget {
  const _CallbackShortcutsDeepDemo();

  @override
  State<_CallbackShortcutsDeepDemo> createState() => _CallbackShortcutsDeepDemoState();
}

class _CallbackShortcutsDeepDemoState extends State<_CallbackShortcutsDeepDemo> {
  _DemoStage _stage = _DemoStage.primer;
  int _paletteIndex = 0;
  _CanvasStyle _canvasStyle = _CanvasStyle.waves;

  bool _showTimeline = true;
  bool _showGuidance = true;
  bool _showMetrics = true;
  bool _verbose = false;

  bool _outerFocused = true;
  bool _innerFocused = false;
  bool _listFocused = false;
  bool _bridgeLocalFocused = true;

  int _tapCount = 0;
  int _shortcutCount = 0;
  int _profileSwitchCount = 0;
  int _focusSwitchCount = 0;
  int _selectedListRow = 0;

  final FocusNode _primerFocusNode = FocusNode(debugLabel: 'callback.primer');
  final FocusNode _outerFocusNode = FocusNode(debugLabel: 'callback.outer');
  final FocusNode _innerFocusNode = FocusNode(debugLabel: 'callback.inner');
  final FocusNode _listFocusNode = FocusNode(debugLabel: 'callback.list');
  final FocusNode _bridgeLocalFocusNode = FocusNode(debugLabel: 'callback.bridge.local');
  final FocusNode _bridgeGlobalFocusNode = FocusNode(debugLabel: 'callback.bridge.global');

  final Map<String, int> _actionCounts = <String, int>{};
  final List<_EventLog> _events = <_EventLog>[];

  int _profileIndex = 0;

  final List<String> _tasks = <String>[
    'Sync dashboard metrics',
    'Validate payment callbacks',
    'Inspect keyboard routing',
    'Write callback docs',
    'Test nested focus domains',
    'Publish demo snapshots',
    'Check interpreter bridge logs',
    'Cleanup temporary sessions',
    'Prepare release summary',
    'Archive scenario captures',
  ];

  late final List<_Profile> _profiles = _buildProfiles();

  _Palette get _p => _palettes[_paletteIndex];

  static const _stageTitles = <String>[
    '1 Primer Studio',
    '2 Precedence Arena',
    '3 Dynamic Remap Lab',
    '4 List Navigation Theater',
    '5 Callback and Shortcuts Bridge',
    '6 Verification Compendium',
  ];

  @override
  void initState() {
    super.initState();
    _addEvent('system', 'CallbackShortcuts deep demo initialized.', _p.accentA);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _primerFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _primerFocusNode.dispose();
    _outerFocusNode.dispose();
    _innerFocusNode.dispose();
    _listFocusNode.dispose();
    _bridgeLocalFocusNode.dispose();
    _bridgeGlobalFocusNode.dispose();
    super.dispose();
  }

  List<_Profile> _buildProfiles() {
    return <_Profile>[
      _Profile(
        name: 'Editing Profile',
        subtitle: 'Common text and editing actions',
        icon: Icons.edit_note,
        tone: const Color(0xFF2E7D32),
        bindings: <_ShortcutBinding>[
          _ShortcutBinding(
            activator: const SingleActivator(LogicalKeyboardKey.keyS, control: true),
            action: _ActionSpec(
              id: 'edit.save',
              title: 'Save Draft',
              hint: 'Persist current workspace content',
              icon: Icons.save_outlined,
              tone: const Color(0xFF2E7D32),
            ),
          ),
          _ShortcutBinding(
            activator: const SingleActivator(LogicalKeyboardKey.keyZ, control: true),
            action: _ActionSpec(
              id: 'edit.undo',
              title: 'Undo Step',
              hint: 'Rollback one recent mutation',
              icon: Icons.undo,
              tone: const Color(0xFF1565C0),
            ),
          ),
          _ShortcutBinding(
            activator: const CharacterActivator('?'),
            action: _ActionSpec(
              id: 'edit.help',
              title: 'Open Help Overlay',
              hint: 'Show keyboard cheat sheet',
              icon: Icons.help_outline,
              tone: const Color(0xFFEF6C00),
            ),
          ),
        ],
      ),
      _Profile(
        name: 'Navigation Profile',
        subtitle: 'Move focus and open route entries',
        icon: Icons.alt_route,
        tone: const Color(0xFF2E7D9D),
        bindings: <_ShortcutBinding>[
          _ShortcutBinding(
            activator: const SingleActivator(LogicalKeyboardKey.arrowUp),
            action: _ActionSpec(
              id: 'nav.up',
              title: 'Move Up',
              hint: 'Select previous row in list',
              icon: Icons.keyboard_arrow_up,
              tone: const Color(0xFF2E7D9D),
            ),
          ),
          _ShortcutBinding(
            activator: const SingleActivator(LogicalKeyboardKey.arrowDown),
            action: _ActionSpec(
              id: 'nav.down',
              title: 'Move Down',
              hint: 'Select next row in list',
              icon: Icons.keyboard_arrow_down,
              tone: const Color(0xFF1565C0),
            ),
          ),
          _ShortcutBinding(
            activator: const SingleActivator(LogicalKeyboardKey.enter),
            action: _ActionSpec(
              id: 'nav.open',
              title: 'Open Selection',
              hint: 'Run selected list command',
              icon: Icons.play_arrow_rounded,
              tone: const Color(0xFF6A1B9A),
            ),
          ),
        ],
      ),
      _Profile(
        name: 'Ops Profile',
        subtitle: 'Operational and debug flow commands',
        icon: Icons.settings_suggest,
        tone: const Color(0xFF8E4A15),
        bindings: <_ShortcutBinding>[
          _ShortcutBinding(
            activator: const SingleActivator(LogicalKeyboardKey.keyR, control: true),
            action: _ActionSpec(
              id: 'ops.run',
              title: 'Run Routine',
              hint: 'Execute staged operation',
              icon: Icons.play_circle_outline,
              tone: const Color(0xFF8E4A15),
            ),
          ),
          _ShortcutBinding(
            activator: const SingleActivator(LogicalKeyboardKey.keyL, alt: true),
            action: _ActionSpec(
              id: 'ops.logs',
              title: 'Toggle Logs',
              hint: 'Switch timeline visibility',
              icon: Icons.receipt_long,
              tone: const Color(0xFF37474F),
            ),
          ),
          _ShortcutBinding(
            activator: const CharacterActivator('!'),
            action: _ActionSpec(
              id: 'ops.alert',
              title: 'Raise Alert',
              hint: 'Add high-priority event marker',
              icon: Icons.warning_amber_rounded,
              tone: const Color(0xFFC62828),
            ),
          ),
        ],
      ),
    ];
  }

  void _addEvent(String lane, String message, Color tone) {
    final log = _EventLog(at: DateTime.now(), lane: lane, message: message, tone: tone);
    setState(() {
      _events.insert(0, log);
      if (_events.length > 180) {
        _events.removeRange(180, _events.length);
      }
    });
    if (_verbose) {
      debugPrint('[CallbackShortcuts][$lane] $message');
    }
  }

  void _triggerAction(_ActionSpec action, {required String lane, required String source}) {
    setState(() {
      _shortcutCount += 1;
      _actionCounts[action.id] = (_actionCounts[action.id] ?? 0) + 1;
    });
    _addEvent(lane, '${action.title} via $source', action.tone);
  }

  void _recordTap(String lane, String detail, Color tone) {
    setState(() => _tapCount += 1);
    _addEvent(lane, detail, tone);
  }

  void _switchStage(int index) {
    setState(() => _stage = _DemoStage.values[index]);
    _addEvent('stage', 'Switched to ${_stageTitles[index]}', _p.accentB);
  }

  void _switchPalette(int index) {
    setState(() => _paletteIndex = index);
    _addEvent('palette', 'Changed palette to ${_palettes[index].name}', _palettes[index].accentA);
  }

  Map<ShortcutActivator, VoidCallback> _profileCallbacks(_Profile profile, String lane) {
    final callbacks = <ShortcutActivator, VoidCallback>{};
    for (final binding in profile.bindings) {
      callbacks[binding.activator] = () => _triggerAction(binding.action, lane: lane, source: 'keyboard');
    }
    return callbacks;
  }

  String _activatorLabel(ShortcutActivator activator) {
    if (activator is SingleActivator) {
      final parts = <String>[];
      if (activator.control) {
        parts.add('Ctrl');
      }
      if (activator.shift) {
        parts.add('Shift');
      }
      if (activator.alt) {
        parts.add('Alt');
      }
      if (activator.meta) {
        parts.add('Meta');
      }
      parts.add(activator.trigger.keyLabel.isNotEmpty ? activator.trigger.keyLabel.toUpperCase() : activator.trigger.debugName ?? 'Key');
      return parts.join(' + ');
    }
    if (activator is CharacterActivator) {
      return "Character '${activator.character}'";
    }
    if (activator is LogicalKeySet) {
      final labels = activator.keys.map((key) => key.keyLabel.isNotEmpty ? key.keyLabel : key.debugName ?? 'Key').toList();
      return labels.join(' + ');
    }
    return activator.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.canvas,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: _stageBody()),
                  if (_showTimeline)
                    SizedBox(
                      width: 380,
                      child: _timelinePanel(),
                    ),
                ],
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.shell, _p.accentA.withValues(alpha: 0.88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.keyboard_command_key, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'CallbackShortcuts Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Declarative Keyboard Callback Layer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'CallbackShortcuts connects ShortcutActivator bindings to simple callbacks. '
            'This deep demo visualizes focus domains, nested precedence, dynamic mapping profiles, '
            'and integration with Shortcuts/Actions while keeping interaction-first interpreter testing.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 12.2,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      color: _p.accentA.withValues(alpha: 0.08),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Stage', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _stageTitles.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          _toggleChip('timeline', _showTimeline, (v) => _showTimeline = v),
          _toggleChip('guidance', _showGuidance, (v) => _showGuidance = v),
          _toggleChip('metrics', _showMetrics, (v) => _showMetrics = v),
          _toggleChip('verbose', _verbose, (v) => _verbose = v),
        ],
      ),
    );
  }

  Widget _stageChip(int index) {
    final active = _stage.index == index;
    return ChoiceChip(
      selected: active,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(
        color: active ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => _switchStage(index),
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () => _switchPalette(index),
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accentA,
          border: Border.all(
            color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      selectedColor: _p.accentA.withValues(alpha: 0.19),
      backgroundColor: Colors.white,
      checkmarkColor: _p.accentA,
      label: Text(label),
      labelStyle: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) => setState(() => assign(selected)),
    );
  }

  Widget _stageBody() {
    switch (_stage) {
      case _DemoStage.primer:
        return _primerStage();
      case _DemoStage.precedenceArena:
        return _precedenceStage();
      case _DemoStage.remapLab:
        return _remapStage();
      case _DemoStage.listNavigation:
        return _listNavigationStage();
      case _DemoStage.shortcutsBridge:
        return _bridgeStage();
      case _DemoStage.compendium:
        return _compendiumStage();
    }
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: _p.ink,
        fontSize: 19,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _panel({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tint ?? _p.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _p.muted.withValues(alpha: 0.22)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _p.shell.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12.8)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 10.8, height: 1.33)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _primerStage() {
    final bindings = <_ShortcutBinding>[
      _ShortcutBinding(
        activator: const SingleActivator(LogicalKeyboardKey.keyS, control: true),
        action: _ActionSpec(
          id: 'primer.save',
          title: 'Save Scene',
          hint: 'Persist interactive state',
          icon: Icons.save_outlined,
          tone: _p.accentA,
        ),
      ),
      _ShortcutBinding(
        activator: const SingleActivator(LogicalKeyboardKey.enter, alt: true),
        action: _ActionSpec(
          id: 'primer.run',
          title: 'Run Action',
          hint: 'Execute focused quick command',
          icon: Icons.play_arrow_rounded,
          tone: _p.accentB,
        ),
      ),
      _ShortcutBinding(
        activator: const CharacterActivator('?'),
        action: _ActionSpec(
          id: 'primer.help',
          title: 'Open Help',
          hint: 'Reveal command hints and overlays',
          icon: Icons.help_outline,
          tone: _p.accentC,
        ),
      ),
    ];

    final callbackMap = <ShortcutActivator, VoidCallback>{};
    for (final binding in bindings) {
      callbackMap[binding.activator] = () => _triggerAction(binding.action, lane: 'primer', source: 'keyboard');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Primer Studio'),
          const SizedBox(height: 8),
          Text(
            'Start with one focusable region wrapped by CallbackShortcuts. '
            'Press mapped keys while this surface is focused, or use the cards to trigger the same callbacks manually.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Primary Callback Zone',
                  subtitle: 'Click inside first to focus this area, then type mapped keys.',
                  tint: _p.accentA.withValues(alpha: 0.04),
                  child: SizedBox(
                    height: 430,
                    child: CallbackShortcuts(
                      bindings: callbackMap,
                      child: Focus(
                        focusNode: _primerFocusNode,
                        autofocus: true,
                        onFocusChange: (focused) {
                          _addEvent('primer-focus', focused ? 'Primer focus acquired' : 'Primer focus lost', _p.accentA);
                        },
                        child: GestureDetector(
                          onTap: () {
                            _primerFocusNode.requestFocus();
                            _recordTap('primer', 'Tapped primer focus surface', _p.accentA);
                          },
                          child: _deviceShell(
                            title: 'Primer keyboard zone',
                            selectedLabel: _primerFocusNode.hasFocus ? 'focused' : 'click to focus',
                            body: Stack(
                              children: <Widget>[
                                Positioned.fill(child: _background(_canvasStyle)),
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Mapped callbacks',
                                          style: TextStyle(color: _p.ink, fontSize: 12.6, fontWeight: FontWeight.w800),
                                        ),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: bindings
                                              .map(
                                                (binding) => _bindingPill(
                                                  label: _activatorLabel(binding.activator),
                                                  detail: binding.action.title,
                                                  tone: binding.action.tone,
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        const SizedBox(height: 14),
                                        _actionCardGrid(bindings, lane: 'primer-manual'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 350,
                  child: _panel(
                    title: 'How CallbackShortcuts Works',
                    subtitle: 'Conceptual notes from this primer stage.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('CallbackShortcuts binds ShortcutActivator keys directly to callbacks.'),
                        _bullet('Focus decides whether key events are handled in this branch.'),
                        _bullet('Use it for lightweight handlers without custom Intent/Action classes.'),
                        _bullet('Manual trigger cards in this demo call the same callback handlers.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (_showMetrics) ...<Widget>[
            const SizedBox(height: 12),
            _globalMetricsPanel(),
          ],
        ],
      ),
    );
  }

  Widget _precedenceStage() {
    final outerSave = _ActionSpec(
      id: 'outer.save',
      title: 'Outer Save',
      hint: 'Outer domain save routine',
      icon: Icons.save_alt_rounded,
      tone: _p.accentA,
    );
    final outerRun = _ActionSpec(
      id: 'outer.run',
      title: 'Outer Run',
      hint: 'Outer workflow execution',
      icon: Icons.play_circle,
      tone: _p.accentB,
    );
    final innerSave = _ActionSpec(
      id: 'inner.save',
      title: 'Inner Save Override',
      hint: 'Inner panel takes precedence when focused',
      icon: Icons.save_as_outlined,
      tone: _p.accentC,
    );
    final innerRun = _ActionSpec(
      id: 'inner.run',
      title: 'Inner Run Override',
      hint: 'Inner panel execution callback',
      icon: Icons.flash_on,
      tone: _p.accentC,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Precedence Arena'),
          const SizedBox(height: 8),
          Text(
            'Nested CallbackShortcuts can bind identical activators. '
            'The focused region wins, so inner mappings override outer ones only while inner focus is active.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Focus Routing Controls',
            subtitle: 'Switch focus target and then test Ctrl+S or Alt+Enter.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.tonalIcon(
                  onPressed: () {
                    _outerFocusNode.requestFocus();
                    setState(() {
                      _outerFocused = true;
                      _innerFocused = false;
                      _focusSwitchCount += 1;
                    });
                    _addEvent('focus', 'Focus moved to outer domain', _p.accentA);
                  },
                  icon: const Icon(Icons.layers_outlined),
                  label: const Text('Focus Outer'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    _innerFocusNode.requestFocus();
                    setState(() {
                      _outerFocused = false;
                      _innerFocused = true;
                      _focusSwitchCount += 1;
                    });
                    _addEvent('focus', 'Focus moved to inner domain', _p.accentB);
                  },
                  icon: const Icon(Icons.filter_none),
                  label: const Text('Focus Inner'),
                ),
                _miniMetric('focus switches', '$_focusSwitchCount', _p.accentC),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Nested CallbackShortcuts Surface',
            subtitle: 'Outer and inner layers share the same activators with distinct callbacks.',
            tint: _p.accentB.withValues(alpha: 0.05),
            child: SizedBox(
              height: 470,
              child: CallbackShortcuts(
                bindings: <ShortcutActivator, VoidCallback>{
                  const SingleActivator(LogicalKeyboardKey.keyS, control: true):
                      () => _triggerAction(outerSave, lane: 'outer', source: 'keyboard'),
                  const SingleActivator(LogicalKeyboardKey.enter, alt: true):
                      () => _triggerAction(outerRun, lane: 'outer', source: 'keyboard'),
                },
                child: Focus(
                  focusNode: _outerFocusNode,
                  onFocusChange: (focused) {
                    setState(() => _outerFocused = focused);
                  },
                  child: GestureDetector(
                    onTap: () {
                      _outerFocusNode.requestFocus();
                      _recordTap('outer', 'Outer surface tapped', _p.accentA);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _outerFocused ? _p.accentA : _p.muted.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(child: _background(_canvasStyle)),
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Outer Domain',
                                    style: TextStyle(color: _p.ink, fontSize: 12.8, fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 8),
                                  _bindingPill(
                                    label: 'Ctrl + S',
                                    detail: 'Outer Save',
                                    tone: _p.accentA,
                                  ),
                                  const SizedBox(height: 6),
                                  _bindingPill(
                                    label: 'Alt + Enter',
                                    detail: 'Outer Run',
                                    tone: _p.accentB,
                                  ),
                                  const SizedBox(height: 14),
                                  Expanded(
                                    child: CallbackShortcuts(
                                      bindings: <ShortcutActivator, VoidCallback>{
                                        const SingleActivator(LogicalKeyboardKey.keyS, control: true):
                                            () => _triggerAction(innerSave, lane: 'inner', source: 'keyboard'),
                                        const SingleActivator(LogicalKeyboardKey.enter, alt: true):
                                            () => _triggerAction(innerRun, lane: 'inner', source: 'keyboard'),
                                      },
                                      child: Focus(
                                        focusNode: _innerFocusNode,
                                        onFocusChange: (focused) {
                                          setState(() => _innerFocused = focused);
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            _innerFocusNode.requestFocus();
                                            _recordTap('inner', 'Inner surface tapped', _p.accentC);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(alpha: 0.76),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: _innerFocused ? _p.accentC : _p.muted.withValues(alpha: 0.26),
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Inner Domain (Override Layer)',
                                                    style: TextStyle(
                                                      color: _p.ink,
                                                      fontSize: 12.2,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 7),
                                                  _bindingPill(
                                                    label: 'Ctrl + S',
                                                    detail: 'Inner Save Override',
                                                    tone: _p.accentC,
                                                  ),
                                                  const SizedBox(height: 6),
                                                  _bindingPill(
                                                    label: 'Alt + Enter',
                                                    detail: 'Inner Run Override',
                                                    tone: _p.accentC,
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Wrap(
                                                    spacing: 8,
                                                    runSpacing: 8,
                                                    children: <Widget>[
                                                      _miniMetric('outer focused', _outerFocused ? 'yes' : 'no', _p.accentA),
                                                      _miniMetric('inner focused', _innerFocused ? 'yes' : 'no', _p.accentC),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    'Tap either panel to move focus and test precedence.',
                                                    style: TextStyle(color: _p.muted, fontSize: 10.6),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remapStage() {
    final profile = _profiles[_profileIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Dynamic Remap Lab'),
          const SizedBox(height: 8),
          Text(
            'Swap callback profiles to demonstrate runtime keymap reconfiguration without rewriting widget structure.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Profile Switcher',
            subtitle: 'Each profile has different activators and callback intentions.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (var i = 0; i < _profiles.length; i++)
                  ChoiceChip(
                    selected: _profileIndex == i,
                    label: Text(_profiles[i].name),
                    onSelected: (_) {
                      setState(() {
                        _profileIndex = i;
                        _profileSwitchCount += 1;
                      });
                      _addEvent('profile', 'Switched to ${_profiles[i].name}', _profiles[i].tone);
                    },
                  ),
                _miniMetric('profile switches', '$_profileSwitchCount', _p.accentB),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: profile.name,
                  subtitle: profile.subtitle,
                  tint: profile.tone.withValues(alpha: 0.08),
                  child: SizedBox(
                    height: 440,
                    child: CallbackShortcuts(
                      bindings: _profileCallbacks(profile, 'profile'),
                      child: Focus(
                        autofocus: true,
                        onFocusChange: (focused) {
                          _addEvent(
                            'profile-focus',
                            focused ? 'Profile focus acquired' : 'Profile focus lost',
                            profile.tone,
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            _recordTap('profile', 'Tapped profile workbench', profile.tone);
                          },
                          child: _deviceShell(
                            title: 'Profile workbench',
                            selectedLabel: profile.name,
                            body: Stack(
                              children: <Widget>[
                                Positioned.fill(child: _background(_canvasStyle)),
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(profile.icon, color: profile.tone),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Active profile bindings',
                                              style: TextStyle(
                                                color: _p.ink,
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: profile.bindings.length,
                                            itemBuilder: (context, index) {
                                              final binding = profile.bindings[index];
                                              final count = _actionCounts[binding.action.id] ?? 0;
                                              return Container(
                                                margin: const EdgeInsets.only(bottom: 8),
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withValues(alpha: 0.8),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: binding.action.tone.withValues(alpha: 0.3)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(binding.action.icon, color: binding.action.tone, size: 18),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            binding.action.title,
                                                            style: TextStyle(
                                                              color: _p.ink,
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 11.7,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 2),
                                                          Text(
                                                            binding.action.hint,
                                                            style: TextStyle(color: _p.muted, fontSize: 10.3),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      _activatorLabel(binding.activator),
                                                      style: TextStyle(
                                                        color: _p.accentA,
                                                        fontFamily: 'monospace',
                                                        fontSize: 10.2,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    FilledButton.tonal(
                                                      onPressed: () {
                                                        _triggerAction(binding.action, lane: 'profile', source: 'manual');
                                                      },
                                                      child: Text('run ($count)'),
                                                    ),
                                                  ],
                                                ),
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 360,
                  child: _panel(
                    title: 'Remap Guidance',
                    subtitle: 'Practical remapping design recommendations.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('Keep profile structures declarative and easy to diff.'),
                        _bullet('Expose profile switching through explicit UI state changes.'),
                        _bullet('Use timeline logs to validate callback routing after remap.'),
                        _bullet('Prefer CallbackShortcuts for simple callback actions, then migrate to Actions when needed.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _listNavigationStage() {
    final upAction = _ActionSpec(
      id: 'list.up',
      title: 'Move Selection Up',
      hint: 'Select previous task item',
      icon: Icons.keyboard_arrow_up,
      tone: _p.accentA,
    );
    final downAction = _ActionSpec(
      id: 'list.down',
      title: 'Move Selection Down',
      hint: 'Select next task item',
      icon: Icons.keyboard_arrow_down,
      tone: _p.accentB,
    );
    final openAction = _ActionSpec(
      id: 'list.open',
      title: 'Open Selected Task',
      hint: 'Run selected task workflow',
      icon: Icons.play_arrow,
      tone: _p.accentC,
    );

    final callbacks = <ShortcutActivator, VoidCallback>{
      const SingleActivator(LogicalKeyboardKey.arrowUp): () {
        setState(() {
          _selectedListRow = (_selectedListRow - 1).clamp(0, _tasks.length - 1);
        });
        _triggerAction(upAction, lane: 'list', source: 'keyboard');
      },
      const SingleActivator(LogicalKeyboardKey.arrowDown): () {
        setState(() {
          _selectedListRow = (_selectedListRow + 1).clamp(0, _tasks.length - 1);
        });
        _triggerAction(downAction, lane: 'list', source: 'keyboard');
      },
      const SingleActivator(LogicalKeyboardKey.enter): () {
        _triggerAction(openAction, lane: 'list', source: 'keyboard');
        _addEvent('list', 'Opened task: ${_tasks[_selectedListRow]}', _p.accentC);
      },
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('List Navigation Theater'),
          const SizedBox(height: 8),
          Text(
            'CallbackShortcuts can drive navigable collections: arrows move selection, enter activates focused item.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'List Command Legend',
            subtitle: 'Focus the panel and use arrow keys + Enter.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _bindingPill(label: 'Arrow Up', detail: 'Move selection up', tone: _p.accentA),
                _bindingPill(label: 'Arrow Down', detail: 'Move selection down', tone: _p.accentB),
                _bindingPill(label: 'Enter', detail: 'Open selected task', tone: _p.accentC),
                _miniMetric('selected row', '${_selectedListRow + 1}', _p.accentA),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Keyboard List Surface',
            subtitle: 'This region uses CallbackShortcuts to coordinate list interactions.',
            tint: _p.accentC.withValues(alpha: 0.05),
            child: SizedBox(
              height: 500,
              child: CallbackShortcuts(
                bindings: callbacks,
                child: Focus(
                  focusNode: _listFocusNode,
                  onFocusChange: (focused) => setState(() => _listFocused = focused),
                  child: GestureDetector(
                    onTap: () {
                      _listFocusNode.requestFocus();
                      _recordTap('list', 'List surface tapped', _p.accentA);
                    },
                    child: _deviceShell(
                      title: 'Task navigator',
                      selectedLabel: _listFocused ? 'focused' : 'click to focus',
                      body: Stack(
                        children: <Widget>[
                          Positioned.fill(child: _background(_canvasStyle)),
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Operator task queue',
                                    style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12.7),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _tasks.length,
                                      itemBuilder: (context, index) {
                                        final selected = index == _selectedListRow;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() => _selectedListRow = index);
                                            _recordTap('list', 'Selected row ${index + 1}', _p.accentB);
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 160),
                                            margin: const EdgeInsets.only(bottom: 8),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: (selected ? _p.accentA : _p.accentB).withValues(alpha: selected ? 0.2 : 0.11),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: selected
                                                    ? _p.accentA.withValues(alpha: 0.52)
                                                    : _p.muted.withValues(alpha: 0.24),
                                              ),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: selected
                                                      ? _p.accentA.withValues(alpha: 0.36)
                                                      : _p.accentB.withValues(alpha: 0.25),
                                                  child: Text('${index + 1}', style: TextStyle(color: _p.ink, fontSize: 10)),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    _tasks[index],
                                                    style: TextStyle(
                                                      color: _p.ink,
                                                      fontSize: 11.9,
                                                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                if (selected)
                                                  Icon(Icons.play_circle_fill_rounded, color: _p.accentC, size: 18),
                                              ],
                                            ),
                                          ),
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
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bridgeStage() {
    final localAction = _ActionSpec(
      id: 'bridge.local.inspect',
      title: 'Local Inspect',
      hint: 'Handled by local CallbackShortcuts',
      icon: Icons.find_in_page_outlined,
      tone: _p.accentA,
    );
    final globalAction = _ActionSpec(
      id: 'bridge.global.help',
      title: 'Global Help',
      hint: 'Handled by Shortcuts + Actions fallback',
      icon: Icons.help_center_outlined,
      tone: _p.accentB,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Callback and Shortcuts Bridge'),
          const SizedBox(height: 8),
          Text(
            'CallbackShortcuts can coexist with Shortcuts/Actions. This stage demonstrates local callback handling and '
            'global fallback actions in one visual flow.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Bridge Surface',
                  subtitle: 'Ctrl+I is local callback, F1 triggers global action.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 470,
                    child: Shortcuts(
                      shortcuts: <ShortcutActivator, Intent>{
                        const SingleActivator(LogicalKeyboardKey.f1): const _GlobalHelpIntent(),
                      },
                      child: Actions(
                        actions: <Type, Action<Intent>>{
                          _GlobalHelpIntent: CallbackAction<_GlobalHelpIntent>(
                            onInvoke: (intent) {
                              _triggerAction(globalAction, lane: 'bridge-global', source: 'actions');
                              return null;
                            },
                          ),
                        },
                        child: CallbackShortcuts(
                          bindings: <ShortcutActivator, VoidCallback>{
                            const SingleActivator(LogicalKeyboardKey.keyI, control: true):
                                () => _triggerAction(localAction, lane: 'bridge-local', source: 'keyboard'),
                          },
                          child: FocusScope(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Focus(
                                        focusNode: _bridgeLocalFocusNode,
                                        onFocusChange: (focused) => setState(() => _bridgeLocalFocused = focused),
                                        child: GestureDetector(
                                          onTap: () {
                                            _bridgeLocalFocusNode.requestFocus();
                                            _recordTap('bridge', 'Local focus panel tapped', _p.accentA);
                                          },
                                          child: Container(
                                            height: 180,
                                            margin: const EdgeInsets.only(right: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: _bridgeLocalFocused
                                                    ? _p.accentA
                                                    : _p.muted.withValues(alpha: 0.26),
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Local Callback Zone',
                                                    style: TextStyle(
                                                      color: _p.ink,
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  _bindingPill(
                                                    label: 'Ctrl + I',
                                                    detail: 'Local inspect callback',
                                                    tone: _p.accentA,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Focus here and press Ctrl+I. This should hit CallbackShortcuts.',
                                                    style: TextStyle(color: _p.muted, fontSize: 10.7),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Focus(
                                        focusNode: _bridgeGlobalFocusNode,
                                        child: GestureDetector(
                                          onTap: () {
                                            _bridgeGlobalFocusNode.requestFocus();
                                            _recordTap('bridge', 'Global focus panel tapped', _p.accentB);
                                          },
                                          child: Container(
                                            height: 180,
                                            margin: const EdgeInsets.only(left: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: _p.muted.withValues(alpha: 0.26), width: 2),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Global Actions Zone',
                                                    style: TextStyle(
                                                      color: _p.ink,
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  _bindingPill(
                                                    label: 'F1',
                                                    detail: 'Global help via Actions',
                                                    tone: _p.accentB,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Press F1 to trigger Shortcuts -> Actions fallback flow.',
                                                    style: TextStyle(color: _p.muted, fontSize: 10.7),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: _panel(
                                    title: 'Bridge Notes',
                                    subtitle: 'When to use CallbackShortcuts vs Shortcuts/Actions',
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        _bullet('Use CallbackShortcuts for concise local command wiring.'),
                                        _bullet('Use Shortcuts/Actions for intent-centric app architecture.'),
                                        _bullet('Combine both when local overrides and global intents coexist.'),
                                        _bullet('Focus placement still determines who receives the key event first.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 360,
                  child: _panel(
                    title: 'Bridge Checklist',
                    subtitle: 'Validation points demonstrated in this stage.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _check('Local Ctrl+I command handled through CallbackShortcuts callback map.'),
                        _check('Global F1 command handled through Shortcuts and Actions.'),
                        _check('Two focus surfaces demonstrate event ownership boundaries.'),
                        _check('Timeline records make the routing path visible in interpreter runs.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _compendiumStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'CallbackShortcuts Coverage Matrix',
            subtitle: 'Concept and usage coverage from this deep demo.',
            child: Column(
              children: <Widget>[
                _matrix('Core purpose', 'Bind ShortcutActivator keys directly to callbacks in widget subtree.'),
                _matrix('Focus routing', 'Only focused branches receive and resolve keyboard events.'),
                _matrix('Nested precedence', 'Inner focused CallbackShortcuts can override outer bindings.'),
                _matrix('Dynamic maps', 'Profiles can swap binding maps at runtime with state updates.'),
                _matrix('Collection control', 'Arrows and Enter can drive list selection and execution flows.'),
                _matrix('Bridge strategy', 'CallbackShortcuts can coexist with Shortcuts/Actions intents.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Implementation guidance for production keyboard systems.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do centralize local shortcut maps near the focused widget subtree',
                  detail: 'Local ownership keeps callback behavior easy to reason about.',
                ),
                _doDont(
                  good: true,
                  title: 'Do validate focus transitions in visual demos',
                  detail: 'Most shortcut confusion comes from missing or unexpected focus.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont overload one map with unrelated global commands',
                  detail: 'Use Shortcuts and Actions for cross-cutting intent architecture.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont rely on print-only verification for key routing',
                  detail: 'Use visible state updates and event timelines for confident behavior checks.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common usage questions answered.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When is CallbackShortcuts preferable to Shortcuts/Actions?',
                  a: 'When command handling is local and callback-based without needing custom intent classes.',
                ),
                _qa(
                  q: 'Can I use CharacterActivator and SingleActivator together?',
                  a: 'Yes. This demo combines both in primer and profile stages.',
                ),
                _qa(
                  q: 'How do nested shortcut regions resolve key conflicts?',
                  a: 'The currently focused branch handles the event, so inner focused regions can override outer callbacks.',
                ),
                _qa(
                  q: 'How should I test interpreter behavior?',
                  a: 'Use visual focus surfaces, state counters, and timeline logs to validate actual interaction routing.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Deep Demo Outcome Checklist',
            subtitle: 'Batch completion markers for this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Multiple visual stages show callback mapping, precedence, and integration patterns.'),
                _check('Each stage explains when and why CallbackShortcuts usage is appropriate.'),
                _check('Keyboard interaction is demonstrated through focused widgets and live counters.'),
                _check('Instructional sections provide practical implementation and architecture guidance.'),
                _check('Timeline panel captures callback execution flow for interpreter verification.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _p.accentC.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.accentC.withValues(alpha: 0.32)),
            ),
            child: Text(
              'CallbackShortcuts is an excellent local command layer for keyboard interaction. '
              'By combining focus-aware visuals, nested precedence experiments, and profile-based remapping, '
              'this demo provides a practical and comprehensive reference for interpreter-side interaction testing.',
              style: TextStyle(color: _p.ink, fontSize: 11.8, height: 1.36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCardGrid(List<_ShortcutBinding> bindings, {required String lane}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: bindings
          .map(
            (binding) => SizedBox(
              width: 220,
              child: _actionCard(
                action: binding.action,
                shortcutLabel: _activatorLabel(binding.activator),
                onRun: () => _triggerAction(binding.action, lane: lane, source: 'manual'),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _actionCard({
    required _ActionSpec action,
    required String shortcutLabel,
    required VoidCallback onRun,
  }) {
    final count = _actionCounts[action.id] ?? 0;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: action.tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: action.tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(action.icon, color: action.tone, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  action.title,
                  style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 11.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(action.hint, style: TextStyle(color: _p.muted, fontSize: 10.2)),
          const SizedBox(height: 6),
          Text(
            shortcutLabel,
            style: TextStyle(
              color: _p.accentA,
              fontFamily: 'monospace',
              fontSize: 10.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              FilledButton.tonal(onPressed: onRun, child: const Text('Trigger')),
              const Spacer(),
              Text(
                'count: $count',
                style: TextStyle(color: _p.muted, fontSize: 10.2, fontFamily: 'monospace'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bindingPill({required String label, required String detail, required Color tone}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tone.withValues(alpha: 0.32)),
      ),
      child: Text(
        '$label  ·  $detail',
        style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 10.5),
      ),
    );
  }

  Widget _globalMetricsPanel() {
    return _panel(
      title: 'Global Metrics',
      subtitle: 'Interaction counters for shortcut callbacks and manual triggers.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _miniMetric('shortcut callbacks', '$_shortcutCount', _p.accentA),
          _miniMetric('manual taps', '$_tapCount', _p.accentB),
          _miniMetric('profile switches', '$_profileSwitchCount', _p.accentC),
          _miniMetric('focus switches', '$_focusSwitchCount', _p.accentA),
          _miniMetric('event logs', '${_events.length}', _p.accentB),
        ],
      ),
    );
  }

  Widget _miniMetric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(color: _p.ink, fontSize: 10.2, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.chevron_right, size: 16, color: _p.accentA),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.1))),
        ],
      ),
    );
  }

  Widget _matrix(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              key,
              style: TextStyle(
                color: _p.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.8,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 11.2, height: 1.33))),
        ],
      ),
    );
  }

  Widget _doDont({required bool good, required String title, required String detail}) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.26)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.32)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qa({required String q, required String a}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Q: $q', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.9)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.33)),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 17),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.3))),
        ],
      ),
    );
  }

  Widget _timelinePanel() {
    return Container(
      decoration: BoxDecoration(
        color: _p.card,
        border: Border(left: BorderSide(color: _p.muted.withValues(alpha: 0.25))),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _p.accentA.withValues(alpha: 0.08),
              border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Shortcut Timeline', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text(
                  'Event stream for callbacks, focus transitions, and profile changes.',
                  style: TextStyle(color: _p.muted, fontSize: 10.7),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _miniMetric('events', '${_events.length}', _p.accentA),
                    _miniMetric('shortcuts', '$_shortcutCount', _p.accentB),
                    _miniMetric('focus', '$_focusSwitchCount', _p.accentC),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: event.tone.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: event.tone.withValues(alpha: 0.26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              event.lane,
                              style: TextStyle(
                                color: _p.ink,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w700,
                                fontSize: 10.4,
                              ),
                            ),
                          ),
                          Text(
                            _clock(event.at),
                            style: TextStyle(
                              color: _p.muted,
                              fontFamily: 'monospace',
                              fontSize: 10.1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(event.message, style: TextStyle(color: _p.ink, fontSize: 11.1, height: 1.31)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _clock(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    final s = t.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _deviceShell({
    required String title,
    required String selectedLabel,
    required Widget body,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _p.canvas,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
            ),
            child: Row(
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.muted, fontSize: 10.8)),
                const Spacer(),
                Text(
                  selectedLabel,
                  style: TextStyle(color: _p.muted, fontSize: 10.3, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget _background(_CanvasStyle style) {
    switch (style) {
      case _CanvasStyle.waves:
        return _waveBackground();
      case _CanvasStyle.blueprint:
        return _blueprintBackground();
      case _CanvasStyle.constellation:
        return _constellationBackground();
    }
  }

  Widget _waveBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentA.withValues(alpha: 0.22), _p.accentB.withValues(alpha: 0.22)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(painter: _WavePainter(color: Colors.white.withValues(alpha: 0.2))),
    );
  }

  Widget _blueprintBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentB.withValues(alpha: 0.23), _p.accentC.withValues(alpha: 0.22)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CustomPaint(painter: _GridPainter(color: Colors.white.withValues(alpha: 0.22))),
    );
  }

  Widget _constellationBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentC.withValues(alpha: 0.22), _p.accentA.withValues(alpha: 0.22)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: CustomPaint(painter: _StarsPainter(color: Colors.white.withValues(alpha: 0.2)))),
          Positioned(left: 24, top: 24, child: _ring(88, Colors.white.withValues(alpha: 0.16))),
          Positioned(right: 30, top: 40, child: _ring(68, Colors.white.withValues(alpha: 0.15))),
          Positioned(left: 110, bottom: 28, child: _ring(110, Colors.white.withValues(alpha: 0.13))),
        ],
      ),
    );
  }

  Widget _ring(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 6),
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: _p.shell.withValues(alpha: 0.07),
      child: Row(
        children: <Widget>[
          Text(_stageTitles[_stage.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          Wrap(
            spacing: 8,
            children: <Widget>[
              DropdownButton<_CanvasStyle>(
                value: _canvasStyle,
                borderRadius: BorderRadius.circular(8),
                items: const <DropdownMenuItem<_CanvasStyle>>[
                  DropdownMenuItem(value: _CanvasStyle.waves, child: Text('Waves')),
                  DropdownMenuItem(value: _CanvasStyle.blueprint, child: Text('Blueprint')),
                  DropdownMenuItem(value: _CanvasStyle.constellation, child: Text('Constellation')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _canvasStyle = value);
                    _addEvent('canvas', 'Canvas style changed to $value', _p.accentC);
                  }
                },
              ),
              Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11.1)),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlobalHelpIntent extends Intent {
  const _GlobalHelpIntent();
}

class _WavePainter extends CustomPainter {
  const _WavePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 7; i++) {
      final path = Path();
      final baseY = 22.0 + i * 28;
      path.moveTo(0, baseY);
      for (var x = 0.0; x <= size.width; x += 20) {
        final y = baseY + 8 * (i.isEven ? 1 : -1) * math.sin(x / 40);
        path.lineTo(x, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += 24;
    }

    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += 24;
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _StarsPainter extends CustomPainter {
  const _StarsPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var i = 0; i < 70; i++) {
      final dx = (i * 37 % 1000) / 1000 * size.width;
      final dy = (i * 59 % 1000) / 1000 * size.height;
      final radius = 0.7 + ((i * 13 % 10) / 10) * 1.6;
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarsPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
