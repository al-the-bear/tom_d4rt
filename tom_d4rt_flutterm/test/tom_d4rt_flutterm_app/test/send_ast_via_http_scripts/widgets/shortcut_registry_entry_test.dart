// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ShortcutRegistryEntry.
///
/// ShortcutRegistryEntry is a handle returned by
/// `ShortcutRegistry.addAll` that tracks a set of registered
/// shortcut bindings and provides replaceAll / dispose.
///
/// Demonstrates:
/// - Tab 1 (Lifecycle): Private constructor, registry property,
///   state machine flow (Created → Active → Replaced → Disposed)
/// - Tab 2 (Methods): replaceAll interactive binding editor,
///   dispose state transitions, assertion checks
/// - Tab 3 (Integration): ShortcutRegistrar widget tree,
///   equivalent activators, listener notification flow

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF4527A0); // DeepPurple 800
const Color _kAccent = Color(0xFFA7FFEB); // Teal A100
const Color _kSurface = Color(0xFF121018);
const Color _kCard = Color(0xFF221E2E);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF342E40);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kGreen = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);
const Color _kAmber = Color(0xFFFFD54F);
const Color _kPurpleLight = Color(0xFFCE93D8);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _ShortcutRegistryEntryDemo(),
  );
}

class _ShortcutRegistryEntryDemo extends StatefulWidget {
  const _ShortcutRegistryEntryDemo();
  @override
  State<_ShortcutRegistryEntryDemo> createState() =>
      _ShortcutRegistryEntryDemoState();
}

class _ShortcutRegistryEntryDemoState
    extends State<_ShortcutRegistryEntryDemo>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShortcutRegistryEntry',
          style: TextStyle(
            color: _kAccent,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kPrimary,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(text: 'Lifecycle'),
            Tab(text: 'Methods'),
            Tab(text: 'Integration'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _LifecycleTab(),
          _MethodsTab(),
          _IntegrationTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Lifecycle
// ═══════════════════════════════════════════════════════════════════════════════

class _LifecycleTab extends StatefulWidget {
  const _LifecycleTab();
  @override
  State<_LifecycleTab> createState() => _LifecycleTabState();
}

class _LifecycleTabState extends State<_LifecycleTab>
    with AutomaticKeepAliveClientMixin {
  int _currentPhase = 0;
  bool _expandHandle = false;
  bool _expandPrivate = false;

  static const _phases = [
    _Phase('Created', 'Registry.addAll returns entry', _kHighlight),
    _Phase('Active', 'Shortcuts bound in registry', _kGreen),
    _Phase('Replaced', 'replaceAll() called', _kAmber),
    _Phase('Disposed', 'dispose() removes all bindings', _kWarning),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Entry Handle Pattern'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () =>
                setState(() => _expandHandle = !_expandHandle),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Handle Pattern',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandHandle
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandHandle) ...[
                    const SizedBox(height: 8),
                    _bulletItem('Caller receives an opaque handle',
                        _kHighlight),
                    _bulletItem(
                        'Handle tracks caller\'s registrations',
                        _kGreen),
                    _bulletItem(
                        'Caller replaces or disposes via handle',
                        _kAmber),
                    _bulletItem(
                        'Registry manages all handles internally',
                        _kPurpleLight),
                    const SizedBox(height: 8),
                    _codeBlock(
                      'final entry = ShortcutRegistry.of(ctx)\n'
                      '    .addAll(shortcuts);\n'
                      '// Use entry handle:\n'
                      'entry.replaceAll(newShortcuts);\n'
                      'entry.dispose();',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Private constructor
          _sectionTitle('Private Constructor'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandPrivate = !_expandPrivate),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'const ShortcutRegistryEntry._()',
                        style: TextStyle(
                          color: _kAmber,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandPrivate
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandPrivate) ...[
                    const SizedBox(height: 8),
                    const Text(
                      'Only ShortcutRegistry can create entries. '
                      'This prevents external code from forging '
                      'handles and corrupting the registry state.',
                      style: TextStyle(
                        color: _kDimText, fontSize: 11),
                    ),
                    const SizedBox(height: 8),
                    _codeBlock(
                      'class ShortcutRegistryEntry {\n'
                      '  const ShortcutRegistryEntry._(\n'
                      '    this.registry,\n'
                      '  );\n'
                      '\n'
                      '  /// The registry this entry is in.\n'
                      '  final ShortcutRegistry registry;\n'
                      '}',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // State machine
          _sectionTitle('Entry State Machine'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tap a phase to see details:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(4, (i) {
                    final p = _phases[i];
                    final sel = _currentPhase == i;
                    final past = i < _currentPhase;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _currentPhase = i),
                        child: Column(
                          children: [
                            Container(
                              height: 26,
                              margin: EdgeInsets.only(
                                  right: i < 3 ? 4 : 0),
                              decoration: BoxDecoration(
                                color: sel
                                    ? p.color
                                        .withValues(alpha: 0.2)
                                    : past
                                        ? p.color
                                            .withValues(alpha: 0.08)
                                        : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(4),
                                border: Border.all(
                                  color: sel
                                      ? p.color
                                      : _kSubtle,
                                  width: sel ? 1.5 : 1,
                                ),
                              ),
                              child: Center(
                                child: Text(p.name,
                                    style: TextStyle(
                                      color: sel
                                          ? p.color
                                          : past
                                              ? p.color
                                                  .withValues(
                                                      alpha: 0.5)
                                              : _kDimText,
                                      fontSize: 9,
                                      fontWeight: sel
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                    )),
                              ),
                            ),
                            if (i < 3)
                              Icon(Icons.arrow_forward,
                                  size: 10,
                                  color: _kDimText
                                      .withValues(alpha: 0.3)),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _phases[_currentPhase]
                          .color
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _phases[_currentPhase].name,
                        style: TextStyle(
                          color: _phases[_currentPhase].color,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _phases[_currentPhase].desc,
                        style: const TextStyle(
                          color: _kDimText, fontSize: 10),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getPhaseCode(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Registry property
          _sectionTitle('Registry Property'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: _kAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'final ShortcutRegistry registry',
                      style: TextStyle(
                        color: _kAccent,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Back-reference to the registry that issued '
                  'this entry. Allows the entry to communicate '
                  'with its parent registry for replace and '
                  'dispose operations.',
                  style: TextStyle(
                    color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _attrChip('final', _kHighlight),
                    const SizedBox(width: 6),
                    _attrChip('non-null', _kGreen),
                    const SizedBox(width: 6),
                    _attrChip('set in constructor', _kAmber),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'ShortcutRegistryEntry is a handle that tracks '
            'a caller\'s shortcut registrations. Its private '
            'constructor prevents external creation, and the '
            'registry property maintains the parent link.',
          ),
        ],
      ),
    );
  }

  String _getPhaseCode() {
    switch (_currentPhase) {
      case 0:
        return '// ShortcutRegistry.addAll:\n'
            'final entry = ShortcutRegistryEntry._(this);\n'
            '_entries[entry] = value;';
      case 1:
        return '// Shortcuts are now active in registry.\n'
            '// Key events checked against these bindings.\n'
            'registry.shortcuts // includes entry\'s map';
      case 2:
        return '// entry.replaceAll(newMap):\n'
            'registry._replaceAll(entry, newMap);\n'
            '// Old bindings removed, new ones added.';
      default:
        return '// entry.dispose():\n'
            'registry._disposeEntry(this);\n'
            '// All bindings for this entry removed.\n'
            '// Entry is no longer usable.';
    }
  }
}

class _Phase {
  final String name;
  final String desc;
  final Color color;
  const _Phase(this.name, this.desc, this.color);
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Methods
// ═══════════════════════════════════════════════════════════════════════════════

class _MethodsTab extends StatefulWidget {
  const _MethodsTab();
  @override
  State<_MethodsTab> createState() => _MethodsTabState();
}

class _MethodsTabState extends State<_MethodsTab>
    with AutomaticKeepAliveClientMixin {
  // replaceAll state
  int _replaceVersion = 0;
  bool _disposed = false;
  bool _expandReplaceAll = true;
  bool _expandDispose = false;
  bool _expandAssertions = false;

  static const _versions = [
    {'keys': 'Ctrl+A → ActivateIntent', 'count': '1'},
    {'keys': 'Ctrl+S → SaveIntent, Ctrl+Z → UndoIntent', 'count': '2'},
    {'keys': 'Ctrl+C → CopyIntent, Ctrl+V → PasteIntent, Ctrl+X → CutIntent', 'count': '3'},
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // replaceAll
          _sectionTitle('replaceAll()'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandReplaceAll = !_expandReplaceAll),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'void replaceAll('
                        'Map<ShortcutActivator, Intent>)',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandReplaceAll
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandReplaceAll) ...[
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _kSurface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Version ${_replaceVersion + 1}',
                                style: TextStyle(
                                  color: _disposed
                                      ? _kWarning
                                      : _kGreen,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                _disposed
                                    ? 'DISPOSED'
                                    : 'ACTIVE',
                                style: TextStyle(
                                  color: _disposed
                                      ? _kWarning
                                      : _kGreen,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _versions[_replaceVersion]['keys']!,
                            style: const TextStyle(
                              color: _kAccent,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_versions[_replaceVersion]['count']} binding(s)',
                            style: const TextStyle(
                              color: _kDimText,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _disposed
                                ? null
                                : () {
                                    setState(() {
                                      _replaceVersion =
                                          (_replaceVersion + 1) %
                                              _versions.length;
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _kPrimary
                                  .withValues(alpha: 0.4),
                              foregroundColor: _kAccent,
                              disabledBackgroundColor: _kSubtle,
                              disabledForegroundColor:
                                  _kDimText.withValues(
                                      alpha: 0.4),
                            ),
                            child: const Text('replaceAll()',
                                style: TextStyle(fontSize: 11)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _disposed = false;
                                _replaceVersion = 0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _kHighlight
                                  .withValues(alpha: 0.15),
                              foregroundColor: _kHighlight,
                            ),
                            child: const Text('Reset',
                                style: TextStyle(fontSize: 11)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // dispose
          _sectionTitle('dispose()'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandDispose = !_expandDispose),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _disposed
                      ? _kWarning.withValues(alpha: 0.5)
                      : _kSubtle,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'void dispose()',
                        style: TextStyle(
                          color: _kWarning,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('@mustCallSuper',
                          style: TextStyle(
                            color: _kDimText,
                            fontSize: 9,
                            fontStyle: FontStyle.italic,
                          )),
                      const Spacer(),
                      Icon(
                        _expandDispose
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandDispose) ...[
                    const SizedBox(height: 10),
                    // Dispose transition
                    Row(
                      children: [
                        _stateBox(
                            'Active',
                            _disposed ? _kDimText : _kGreen,
                            !_disposed),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward,
                            size: 14, color: _kDimText),
                        const SizedBox(width: 8),
                        _stateBox(
                            'Disposed',
                            _disposed ? _kWarning : _kDimText,
                            _disposed),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _disposed
                          ? null
                          : () => setState(() => _disposed = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _kWarning.withValues(alpha: 0.15),
                        foregroundColor: _kWarning,
                        disabledBackgroundColor: _kSubtle,
                        disabledForegroundColor:
                            _kDimText.withValues(alpha: 0.4),
                        minimumSize: const Size(double.infinity, 36),
                      ),
                      child: const Text('Call dispose()',
                          style: TextStyle(fontSize: 11)),
                    ),
                    const SizedBox(height: 6),
                    if (_disposed)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        color: _kWarning.withValues(alpha: 0.08),
                        child: const Text(
                          'All shortcuts removed from registry.\n'
                          'Entry can no longer be used.',
                          style: TextStyle(
                            color: _kWarning, fontSize: 10),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Assertions
          _sectionTitle('Assertion Checks'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandAssertions = !_expandAssertions),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Runtime Assertions',
                          style: TextStyle(
                            color: _kAmber,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandAssertions
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandAssertions) ...[
                    const SizedBox(height: 8),
                    _assertionRow(
                      'replaceAll after dispose',
                      'AssertionError: entry already disposed',
                      _kWarning,
                    ),
                    _assertionRow(
                      'Duplicate activator',
                      'AssertionError: activator already '
                          'registered by another entry',
                      _kAmber,
                    ),
                    _assertionRow(
                      'dispose already called',
                      'AssertionError: entry already disposed',
                      _kWarning,
                    ),
                    const SizedBox(height: 8),
                    _codeBlock(
                      '// Debug mode only:\n'
                      'assert(!_disposed,\n'
                      '  \'Entry has already been disposed\');\n'
                      'assert(!_shortcuts.containsKey(act),\n'
                      '  \'Activator already registered\');',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'replaceAll completely replaces the bindings for this '
            'entry — it does not merge. dispose removes all '
            'bindings and marks the entry unusable. Both methods '
            'trigger a post-frame notification to listeners.',
          ),
        ],
      ),
    );
  }

  Widget _stateBox(String label, Color color, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? color.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: active ? color : _kSubtle,
            width: active ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                color: active ? color : _kDimText,
                fontSize: 10,
                fontWeight:
                    active ? FontWeight.w700 : FontWeight.w400,
              )),
        ),
      ),
    );
  }

  Widget _assertionRow(String trigger, String msg, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber, size: 12, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trigger,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    )),
                Text(msg,
                    style: const TextStyle(
                      color: _kDimText,
                      fontSize: 9,
                      fontFamily: 'monospace',
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Integration
// ═══════════════════════════════════════════════════════════════════════════════

class _IntegrationTab extends StatefulWidget {
  const _IntegrationTab();
  @override
  State<_IntegrationTab> createState() => _IntegrationTabState();
}

class _IntegrationTabState extends State<_IntegrationTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedView = 0;
  bool _expandEquivalent = false;
  bool _expandListener = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget tree
          _sectionTitle('ShortcutRegistrar Widget Tree'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _viewChip('Tree', 0),
                    const SizedBox(width: 6),
                    _viewChip('Code', 1),
                    const SizedBox(width: 6),
                    _viewChip('Flow', 2),
                  ],
                ),
                const SizedBox(height: 10),
                if (_selectedView == 0) _buildTreeView(),
                if (_selectedView == 1) _buildCodeView(),
                if (_selectedView == 2) _buildFlowView(),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Equivalent activators
          _sectionTitle('Equivalent Activators'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandEquivalent = !_expandEquivalent),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Overlapping Bindings',
                          style: TextStyle(
                            color: _kAmber,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandEquivalent
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandEquivalent) ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _kSurface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          _conflictRow(
                            'Entry A',
                            'SingleActivator(keyA)',
                            _kHighlight,
                          ),
                          const SizedBox(height: 4),
                          _conflictRow(
                            'Entry B',
                            'CharacterActivator(\'a\')',
                            _kGreen,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.warning_amber,
                                  size: 12, color: _kAmber),
                              const SizedBox(width: 6),
                              const Expanded(
                                child: Text(
                                  'Both match "a" key press — '
                                  'both intents will be invoked',
                                  style: TextStyle(
                                    color: _kAmber,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Different entries with equivalent activators '
                      'are allowed. Both remain active and both '
                      'execute when the key event matches.',
                      style: TextStyle(
                        color: _kDimText, fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Listener notification
          _sectionTitle('Listener Notification'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandListener = !_expandListener),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Post-Frame Notification',
                          style: TextStyle(
                            color: _kPurpleLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      const Spacer(),
                      Icon(
                        _expandListener
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandListener) ...[
                    const SizedBox(height: 8),
                    _timelineStep(
                      1, 'Entry calls replaceAll / dispose',
                      _kHighlight,
                    ),
                    _timelineStep(
                      2, 'Registry schedules post-frame callback',
                      _kGreen,
                    ),
                    _timelineStep(
                      3, 'Current frame completes rendering',
                      _kAmber,
                    ),
                    _timelineStep(
                      4, 'Listeners notified of shortcut changes',
                      _kPurpleLight,
                    ),
                    _timelineStep(
                      5,
                      'ShortcutRegistrar rebuilds Shortcuts '
                      'widget',
                      _kAccent,
                    ),
                    const SizedBox(height: 8),
                    _codeBlock(
                      '// Registry batches notifications:\n'
                      'SchedulerBinding.instance\n'
                      '    .addPostFrameCallback((_) {\n'
                      '  notifyListeners();\n'
                      '});',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Lookup methods
          _sectionTitle('Registry Lookup'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _lookupRow(
                  'ShortcutRegistry.of(context)',
                  'Returns nearest registry; throws if none',
                  _kHighlight,
                ),
                const SizedBox(height: 4),
                _lookupRow(
                  'ShortcutRegistry.maybeOf(context)',
                  'Returns null when no registrar found',
                  _kGreen,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'ShortcutRegistrar places a ShortcutRegistry in the '
            'widget tree via InheritedWidget. Descendant widgets '
            'use addAll to register shortcuts and receive an '
            'entry handle for lifecycle management.',
          ),
        ],
      ),
    );
  }

  Widget _viewChip(String label, int value) {
    final sel = _selectedView == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedView = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: sel
              ? _kPrimary.withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                sel ? _kAccent : _kDimText.withValues(alpha: 0.3),
          ),
        ),
        child: Text(label,
            style: TextStyle(
              color: sel ? _kAccent : _kDimText,
              fontSize: 10,
              fontWeight:
                  sel ? FontWeight.w600 : FontWeight.w400,
            )),
      ),
    );
  }

  Widget _buildTreeView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _treeRow(0, 'MaterialApp', _kDimText),
          _treeRow(1, 'ShortcutRegistrar', _kPrimary),
          _treeRow(2, 'Shortcuts', _kHighlight),
          _treeRow(3, 'Actions', _kGreen),
          _treeRow(4, 'Widget A', _kAmber),
          _treeArrow(5, 'addAll → entry'),
          _treeRow(4, 'Widget B', _kPurpleLight),
          _treeArrow(5, 'addAll → entry'),
        ],
      ),
    );
  }

  Widget _buildCodeView() {
    return _codeBlock(
      'ShortcutRegistrar(\n'
      '  child: Scaffold(\n'
      '    body: Builder(builder: (ctx) {\n'
      '      // Register shortcuts:\n'
      '      final entry = ShortcutRegistry\n'
      '          .of(ctx).addAll({\n'
      '        SingleActivator(LogicalKey.keyA,\n'
      '          control: true): ActivateIntent(),\n'
      '      });\n'
      '      // Later: entry.dispose();\n'
      '      return child;\n'
      '    }),\n'
      '  ),\n'
      ')',
    );
  }

  Widget _buildFlowView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _flowStep('Widget', 'Calls addAll with shortcuts', _kHighlight),
        _flowArrow(),
        _flowStep(
            'Registry', 'Creates entry, stores map', _kGreen),
        _flowArrow(),
        _flowStep(
            'Entry', 'Handle returned to widget', _kAmber),
        _flowArrow(),
        _flowStep('Replace/Dispose',
            'Widget manages via handle', _kPurpleLight),
        _flowArrow(),
        _flowStep('Notify',
            'Post-frame listener callback', _kAccent),
      ],
    );
  }

  Widget _treeRow(int depth, String name, Color color) {
    final indent = '  ' * depth;
    final prefix = depth == 0 ? '' : '└ ';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        '$indent$prefix$name',
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _treeArrow(int depth, String text) {
    final indent = '  ' * depth;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        '$indent↳ $text',
        style: const TextStyle(
          color: _kAccent,
          fontSize: 9,
          fontFamily: 'monospace',
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _flowStep(String title, String desc, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border:
            Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  )),
              Text(desc,
                  style: const TextStyle(
                    color: _kDimText, fontSize: 9)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _flowArrow() {
    return const Padding(
      padding: EdgeInsets.only(left: 2),
      child: Icon(Icons.arrow_downward,
          size: 12, color: _kDimText),
    );
  }

  Widget _conflictRow(
      String entry, String activator, Color color) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(entry,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(width: 8),
        Expanded(
          child: Text(activator,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 10,
                fontFamily: 'monospace',
              )),
        ),
      ],
    );
  }

  Widget _lookupRow(String method, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 5,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(method,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    )),
                Text(desc,
                    style: const TextStyle(
                      color: _kDimText, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineStep(
      int step, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                  color: color.withValues(alpha: 0.5)),
            ),
            child: Center(
              child: Text('$step',
                  style: TextStyle(
                    color: color,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(desc,
                  style: const TextStyle(
                    color: _kDimText, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _sectionTitle(String title) {
  return Text(title,
      style: const TextStyle(
        color: _kAccent,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ));
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(code,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontFamily: 'monospace',
        )),
  );
}

Widget _infoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline,
            size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  color: _kDimText, fontSize: 11)),
        ),
      ],
    ),
  );
}

Widget _bulletItem(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                color: _kDimText, fontSize: 11)),
        ),
      ],
    ),
  );
}

Widget _attrChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        )),
  );
}
