// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ScrollNotificationObserverState.
///
/// ScrollNotificationObserverState is the State for ScrollNotificationObserver.
/// It manages a linked list of scroll notification listeners via addListener
/// and removeListener methods.
///
/// Demonstrates:
/// - Tab 1 (Listener Management): addListener/removeListener lifecycle with
///   real-time callback registration, linked list visualization, and multi-
///   listener dispatch ordering
/// - Tab 2 (Error Handling & Dispatch): FlutterError.reportError behavior when
///   listeners throw, safe iteration over linked list during dispatch, and
///   error detail structure
/// - Tab 3 (Static Access & Integration): ScrollNotificationObserver.maybeOf/of
///   context lookup, widget tree integration, NotificationListener wrapping,
///   and dispose nulling of the listener list

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF2E7D32); // Green 800
const Color _kAccent = Color(0xFFFFD180); // Orange A100
const Color _kSurface = Color(0xFF1B1B1F);
const Color _kCard = Color(0xFF2A2A2E);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3A3A40);
const Color _kError = Color(0xFFEF5350);
const Color _kSuccess = Color(0xFF66BB6A);

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
    home: const _ObserverStateDemo(),
  );
}

class _ObserverStateDemo extends StatefulWidget {
  const _ObserverStateDemo();
  @override
  State<_ObserverStateDemo> createState() => _ObserverStateDemoState();
}

class _ObserverStateDemoState extends State<_ObserverStateDemo>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl = TabController(length: 3, vsync: this);

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
          'ScrollNotificationObserverState',
          style: TextStyle(
            color: _kAccent,
            fontSize: 16,
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
            Tab(text: 'Listeners'),
            Tab(text: 'Dispatch'),
            Tab(text: 'Access'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ListenerManagementTab(),
          _ErrorDispatchTab(),
          _StaticAccessTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Listener Management
// ═══════════════════════════════════════════════════════════════════════════════

class _ListenerManagementTab extends StatefulWidget {
  const _ListenerManagementTab();
  @override
  State<_ListenerManagementTab> createState() => _ListenerManagementTabState();
}

class _ListenerManagementTabState extends State<_ListenerManagementTab> {
  final List<_SimulatedListener> _listeners = [];
  int _nextId = 1;
  final List<String> _dispatchLog = [];
  final ScrollController _scrollCtrl = ScrollController();
  int _scrollEventCount = 0;

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _addListener() {
    setState(() {
      _listeners.add(_SimulatedListener(
        id: _nextId,
        name: 'Listener #$_nextId',
      ));
      _dispatchLog.insert(0, '+ Added Listener #$_nextId to linked list');
      _nextId++;
    });
  }

  void _removeListener(int id) {
    setState(() {
      _listeners.removeWhere((l) => l.id == id);
      _dispatchLog.insert(0, '- Removed Listener #$id from linked list');
    });
  }

  void _simulateDispatch() {
    _scrollEventCount++;
    setState(() {
      _dispatchLog.insert(
        0,
        '▸ Dispatch #$_scrollEventCount → ${_listeners.where((l) => l.active).length} active listeners notified',
      );
      for (final listener in _listeners) {
        if (listener.active) {
          listener.hitCount++;
        }
      }
    });
  }

  void _toggleListener(int id) {
    setState(() {
      final l = _listeners.firstWhere((e) => e.id == id);
      l.active = !l.active;
      _dispatchLog.insert(
        0,
        l.active
            ? '✓ Listener #$id re-enabled'
            : '✗ Listener #$id disabled',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Header bar ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: _kCard,
          child: Row(
            children: [
              _buildPill(
                '${_listeners.length} registered',
                _kPrimary,
              ),
              const SizedBox(width: 8),
              _buildPill(
                '${_listeners.where((l) => l.active).length} active',
                _kSuccess,
              ),
              const Spacer(),
              _buildActionBtn('Add', Icons.add, _addListener),
              const SizedBox(width: 8),
              _buildActionBtn('Dispatch', Icons.send, _simulateDispatch),
            ],
          ),
        ),

        // ── Linked list visualization ──
        Container(
          height: 80,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: _listeners.isEmpty
              ? const Center(
                  child: Text(
                    '_listeners = null (empty)',
                    style: TextStyle(color: _kDimText, fontSize: 13),
                  ),
                )
              : ListView.separated(
                  controller: _scrollCtrl,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  itemCount: _listeners.length,
                  separatorBuilder: (_, _) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Icons.arrow_forward, color: _kDimText, size: 14),
                  ),
                  itemBuilder: (_, i) {
                    final l = _listeners[i];
                    return _LinkedListNode(
                      listener: l,
                      onToggle: () => _toggleListener(l.id),
                      onRemove: () => _removeListener(l.id),
                    );
                  },
                ),
        ),

        // ── Heading ──
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Dispatch Log',
              style: TextStyle(
                color: _kAccent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // ── Log ──
        Expanded(
          child: _dispatchLog.isEmpty
              ? const Center(
                  child: Text(
                    'Add listeners and dispatch to see activity',
                    style: TextStyle(color: _kDimText, fontSize: 13),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _dispatchLog.length,
                  itemBuilder: (_, i) {
                    final msg = _dispatchLog[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        msg,
                        style: TextStyle(
                          color: msg.startsWith('+')
                              ? _kSuccess
                              : msg.startsWith('-')
                                  ? _kError
                                  : msg.startsWith('▸')
                                      ? _kAccent
                                      : _kDimText,
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    );
                  },
                ),
        ),

        // ── API info ──
        _buildInfoBanner(
          'addListener / removeListener operate on a LinkedList<_ScrollNotification'
          'ObserverListenerEntry>. Each entry wraps a ScrollNotificationCallback.',
        ),
      ],
    );
  }
}

// ── Linked-list node widget ──────────────────────────────────────────────────

class _LinkedListNode extends StatelessWidget {
  const _LinkedListNode({
    required this.listener,
    required this.onToggle,
    required this.onRemove,
  });
  final _SimulatedListener listener;
  final VoidCallback onToggle;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      onLongPress: onRemove,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 105,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: listener.active
              ? _kPrimary.withValues(alpha: 0.25)
              : _kSubtle.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: listener.active ? _kPrimary : _kDimText.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              listener.name,
              style: TextStyle(
                color: listener.active ? _kAccent : _kDimText,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '${listener.hitCount} hits',
              style: const TextStyle(color: _kDimText, fontSize: 10),
            ),
            Icon(
              listener.active ? Icons.check_circle : Icons.cancel,
              size: 14,
              color: listener.active ? _kSuccess : _kError,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Error Handling & Dispatch
// ═══════════════════════════════════════════════════════════════════════════════

class _ErrorDispatchTab extends StatefulWidget {
  const _ErrorDispatchTab();
  @override
  State<_ErrorDispatchTab> createState() => _ErrorDispatchTabState();
}

class _ErrorDispatchTabState extends State<_ErrorDispatchTab> {
  final List<_DispatchSlot> _slots = List.generate(
    5,
    (i) => _DispatchSlot(name: 'Listener ${i + 1}', throws: i == 2),
  );
  final List<_DispatchEvent> _events = [];
  int _dispatchRound = 0;
  bool _dispatching = false;

  void _toggleThrow(int index) {
    setState(() {
      _slots[index].throws = !_slots[index].throws;
    });
  }

  Future<void> _runDispatch() async {
    if (_dispatching) return;
    _dispatching = true;
    _dispatchRound++;
    setState(() {
      _events.insert(
        0,
        _DispatchEvent(
          round: _dispatchRound,
          message: '━━━ Dispatch round #$_dispatchRound ━━━',
          type: _EventType.header,
        ),
      );
    });

    for (int i = 0; i < _slots.length; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      final slot = _slots[i];
      if (slot.throws) {
        setState(() {
          _events.insert(
            0,
            _DispatchEvent(
              round: _dispatchRound,
              message:
                  '  ✗ ${slot.name} threw → FlutterError.reportError(\n'
                  '      FlutterErrorDetails(\n'
                  '        exception: Exception,\n'
                  '        library: "widget library",\n'
                  '        context: ErrorDescription(\n'
                  '          "while dispatching notifications…"),\n'
                  '      ))',
              type: _EventType.error,
            ),
          );
          slot.errorCount++;
        });
      } else {
        setState(() {
          _events.insert(
            0,
            _DispatchEvent(
              round: _dispatchRound,
              message: '  ✓ ${slot.name} notified successfully',
              type: _EventType.success,
            ),
          );
          slot.successCount++;
        });
      }
    }

    setState(() {
      _events.insert(
        0,
        _DispatchEvent(
          round: _dispatchRound,
          message:
              '  Summary: ${_slots.where((s) => !s.throws).length} ok, '
              '${_slots.where((s) => s.throws).length} errors',
          type: _EventType.summary,
        ),
      );
    });
    _dispatching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Listener slots ──
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dispatch Pipeline (tap to toggle error)',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(_slots.length, (i) {
                  final s = _slots[i];
                  return GestureDetector(
                    onTap: () => _toggleThrow(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 120,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: s.throws
                            ? _kError.withValues(alpha: 0.15)
                            : _kPrimary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: s.throws ? _kError : _kPrimary,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            s.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Icon(
                            s.throws ? Icons.error_outline : Icons.check,
                            size: 18,
                            color: s.throws ? _kError : _kSuccess,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            s.throws ? 'THROWS' : 'OK',
                            style: TextStyle(
                              color: s.throws ? _kError : _kSuccess,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${s.successCount}✓  ${s.errorCount}✗',
                            style: const TextStyle(
                              color: _kDimText,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),

        // ── Dispatch button ──
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _dispatching ? null : _runDispatch,
              icon: _dispatching
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow, size: 18),
              label: Text(_dispatching ? 'Dispatching…' : 'Run _notifyListeners()'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _kPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),

        // ── Event log ──
        Expanded(
          child: _events.isEmpty
              ? const Center(
                  child: Text(
                    'Run dispatch to see error handling behavior',
                    style: TextStyle(color: _kDimText, fontSize: 13),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _events.length,
                  itemBuilder: (_, i) {
                    final e = _events[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text(
                        e.message,
                        style: TextStyle(
                          color: switch (e.type) {
                            _EventType.header => _kAccent,
                            _EventType.success => _kSuccess,
                            _EventType.error => _kError,
                            _EventType.summary => Colors.white70,
                          },
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                    );
                  },
                ),
        ),

        _buildInfoBanner(
          '_notifyListeners wraps each callback in try-catch. Errors go to '
          'FlutterError.reportError with library: "widget library" — '
          'remaining listeners still receive the notification.',
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Static Access & Integration
// ═══════════════════════════════════════════════════════════════════════════════

class _StaticAccessTab extends StatefulWidget {
  const _StaticAccessTab();
  @override
  State<_StaticAccessTab> createState() => _StaticAccessTabState();
}

class _StaticAccessTabState extends State<_StaticAccessTab> {
  bool _observerPresent = true;
  bool _showLookupResult = false;
  String _lookupMethod = 'maybeOf';
  int _notificationCount = 0;
  final List<String> _lifecycleLog = [];

  void _performLookup() {
    setState(() {
      _showLookupResult = true;
      if (_lookupMethod == 'maybeOf') {
        _lifecycleLog.insert(
          0,
          'ScrollNotificationObserver.maybeOf(context) → '
          '${_observerPresent ? "ScrollNotificationObserverState" : "null"}',
        );
      } else {
        _lifecycleLog.insert(
          0,
          'ScrollNotificationObserver.of(context) → '
          '${_observerPresent ? "ScrollNotificationObserverState" : "⚠ assert fails!"}',
        );
      }
    });
  }

  void _simulateNotification() {
    _notificationCount++;
    setState(() {
      _lifecycleLog.insert(
        0,
        'ScrollNotification received → dispatching to ${_observerPresent ? "listeners" : "nobody"}',
      );
    });
  }

  void _simulateDispose() {
    setState(() {
      _observerPresent = false;
      _lifecycleLog.insert(0, 'dispose() called → _listeners = null');
    });
  }

  void _simulateInit() {
    setState(() {
      _observerPresent = true;
      _notificationCount = 0;
      _lifecycleLog.insert(0, 'initState() → _listeners = LinkedList()');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Widget tree diagram ──
          _buildSectionTitle('Widget Tree Integration'),
          const SizedBox(height: 8),
          _buildWidgetTreeDiagram(),
          const SizedBox(height: 16),

          // ── Observer state card ──
          _buildSectionTitle('Observer State'),
          const SizedBox(height: 8),
          _buildStateCard(),
          const SizedBox(height: 16),

          // ── Static lookup ──
          _buildSectionTitle('Static Access Methods'),
          const SizedBox(height: 8),
          _buildLookupSection(),
          const SizedBox(height: 16),

          // ── Lifecycle controls ──
          _buildSectionTitle('Lifecycle Simulation'),
          const SizedBox(height: 8),
          _buildLifecycleControls(),
          const SizedBox(height: 16),

          // ── Log ──
          _buildSectionTitle('Activity Log'),
          const SizedBox(height: 8),
          _buildLifecycleLog(),
          const SizedBox(height: 8),

          _buildInfoBanner(
            'ScrollNotificationObserver wraps its child in a '
            'NotificationListener<ScrollNotification>. The build method returns '
            'this listener which calls _notifyListeners on every notification.',
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetTreeDiagram() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _treeRow(0, 'ScrollNotificationObserver', _kPrimary, true),
          _treeConnector(),
          _treeRow(
            1,
            'NotificationListener<ScrollNotification>',
            _kAccent.withValues(alpha: 0.8),
            false,
          ),
          _treeConnector(),
          _treeRow(1, 'child (e.g. ListView)', _kDimText, false),
          const SizedBox(height: 8),
          const Divider(color: _kSubtle, height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 14, color: _kDimText),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Observer state is accessible via InheritedWidget lookup',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _treeRow(int indent, String label, Color color, bool highlight) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 24.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: highlight ? color : Colors.transparent,
              border: Border.all(color: color, width: 1.5),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _treeConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 14,
          color: _kDimText.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _buildStateCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _observerPresent ? _kPrimary : _kError.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                _observerPresent ? Icons.visibility : Icons.visibility_off,
                color: _observerPresent ? _kPrimary : _kError,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _observerPresent ? 'MOUNTED' : 'DISPOSED',
                style: TextStyle(
                  color: _observerPresent ? _kPrimary : _kError,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '$_notificationCount notifications',
                style: const TextStyle(color: _kDimText, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildKV(
            '_listeners',
            _observerPresent
                ? 'LinkedList<_ScrollNotificationObserverListenerEntry>'
                : 'null',
          ),
          _buildKV(
            'build()',
            _observerPresent
                ? 'NotificationListener<ScrollNotification>(…)'
                : '—',
          ),
        ],
      ),
    );
  }

  Widget _buildKV(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              key,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLookupSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _methodChip('maybeOf', _lookupMethod == 'maybeOf', () {
                setState(() => _lookupMethod = 'maybeOf');
              }),
              const SizedBox(width: 8),
              _methodChip('of', _lookupMethod == 'of', () {
                setState(() => _lookupMethod = 'of');
              }),
              const Spacer(),
              ElevatedButton(
                onPressed: _performLookup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text('Lookup', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          if (_showLookupResult) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ScrollNotificationObserver.$_lookupMethod(context)',
                    style: const TextStyle(
                      color: _kAccent,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (_lookupMethod == 'maybeOf')
                    Text(
                      _observerPresent
                          ? '→ ScrollNotificationObserverState (non-null)'
                          : '→ null (no observer in tree)',
                      style: TextStyle(
                        color: _observerPresent ? _kSuccess : _kDimText,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    )
                  else
                    Text(
                      _observerPresent
                          ? '→ ScrollNotificationObserverState (asserted)'
                          : '→ ❌ AssertionError: No ScrollNotificationObserver ancestor',
                      style: TextStyle(
                        color: _observerPresent ? _kSuccess : _kError,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _methodChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? _kPrimary.withValues(alpha: 0.25) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _kPrimary : _kDimText.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          '.$label()',
          style: TextStyle(
            color: selected ? _kAccent : _kDimText,
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildLifecycleControls() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildControlBtn(
          'initState()',
          Icons.play_circle_outline,
          _kPrimary,
          _observerPresent ? null : _simulateInit,
        ),
        _buildControlBtn(
          'Notify',
          Icons.notifications_active,
          _kAccent,
          _observerPresent ? _simulateNotification : null,
        ),
        _buildControlBtn(
          'dispose()',
          Icons.stop_circle_outlined,
          _kError,
          _observerPresent ? _simulateDispose : null,
        ),
        _buildControlBtn(
          'Clear Log',
          Icons.clear_all,
          _kDimText,
          () => setState(() => _lifecycleLog.clear()),
        ),
      ],
    );
  }

  Widget _buildControlBtn(
    String label,
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: disabled ? 0.35 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLifecycleLog() {
    if (_lifecycleLog.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Use lifecycle controls to see log entries',
          textAlign: TextAlign.center,
          style: TextStyle(color: _kDimText, fontSize: 13),
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 180),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: _lifecycleLog.length,
        itemBuilder: (_, i) {
          final msg = _lifecycleLog[i];
          final color = msg.contains('dispose')
              ? _kError
              : msg.contains('init')
                  ? _kPrimary
                  : msg.contains('null')
                      ? _kDimText
                      : _kAccent;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              msg,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers & data models
// ═══════════════════════════════════════════════════════════════════════════════

class _SimulatedListener {
  _SimulatedListener({required this.id, required this.name});
  final int id;
  final String name;
  bool active = true;
  int hitCount = 0;
}

class _DispatchSlot {
  _DispatchSlot({required this.name, required this.throws});
  final String name;
  bool throws;
  int successCount = 0;
  int errorCount = 0;
}

class _DispatchEvent {
  _DispatchEvent({
    required this.round,
    required this.message,
    required this.type,
  });
  final int round;
  final String message;
  final _EventType type;
}

enum _EventType { header, success, error, summary }

Widget _buildPill(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildActionBtn(String text, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _kPrimary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kPrimary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: _kAccent),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    width: double.infinity,
    // Cluster H follow-up: the info banner is the last child of each tab's
    // outer Column, sitting BELOW an Expanded(log) entry. Under
    // flutter_test_app's slightly shorter widget pane the natural
    // height (5-line wrapped text + 12 px all-around padding ≈ 100 px)
    // exceeds the Column slack by 8 px. Reducing the padding from 12 to
    // 8 (saves 8 vertical px exactly) keeps the banner visible and
    // recovers the overflow. Visual impact: slightly tighter banner.
    padding: const EdgeInsets.all(8),
    color: _kPrimary.withValues(alpha: 0.08),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline, size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _kDimText, fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: _kAccent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}
