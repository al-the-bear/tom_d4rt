import 'package:flutter/material.dart';

const _bg = Color(0xFFF5F8FD);
const _ink = Color(0xFF17384E);
const _blue = Color(0xFF2A6BA1);
const _jade = Color(0xFF2F856E);
const _amber = Color(0xFFAD7C34);
const _rose = Color(0xFF9D5D73);
const _indigo = Color(0xFF635BB2);

dynamic build(BuildContext context) {
  return const _OverlayStateDeepDemoApp();
}

class _OverlayStateDeepDemoApp extends StatelessWidget {
  const _OverlayStateDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _OverlayStateDeepDemoPage(),
    );
  }
}

class _OverlayStateDeepDemoPage extends StatefulWidget {
  const _OverlayStateDeepDemoPage();

  @override
  State<_OverlayStateDeepDemoPage> createState() => _OverlayStateDeepDemoPageState();
}

class _OverlayStateDeepDemoPageState extends State<_OverlayStateDeepDemoPage> {
  bool _compact = false;
  bool _guides = true;
  bool _notes = true;
  bool _rtl = false;
  double _zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 96,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('OverlayState Deep Demo'),
              Text(
                'overlay entry management | insert, rearrange, remove patterns',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.86), fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _GlobalDeck(
                compact: _compact,
                guides: _guides,
                notes: _notes,
                rtl: _rtl,
                zoom: _zoom,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuidesChanged: (v) => setState(() => _guides = v),
                onNotesChanged: (v) => setState(() => _notes = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onZoomChanged: (v) => setState(() => _zoom = v),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 1,
                tone: _blue,
                title: 'Entry Management Studio',
                subtitle:
                    'Use insert(), insertAll(), and remove() to add and remove overlay entries. Observe visual stacking and lifecycle events in real time.',
                child: _EntryManagementScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _jade,
                title: 'Rearrangement Workshop',
                subtitle:
                    'Explore rearrange() with below/above anchors to reorder entries dynamically. Watch stacking order shifts and visual priority changes.',
                child: _RearrangeScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Overlay Access Lab',
                subtitle:
                    'Compare Overlay.of() and Overlay.maybeOf(), test rootOverlay flag behavior, and observe nested overlay scenarios.',
                child: _AccessScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Entry Properties Explorer',
                subtitle:
                    'Tune opaque, maintainState, and canSizeOverlay properties to observe how overlay entries behave differently.',
                child: _PropertiesScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _indigo,
                title: 'Practical Overlay Modules',
                subtitle:
                    'Three module shells demonstrate common overlay patterns: tooltips, notification toasts, and modal dialogs using OverlayState directly.',
                child: _PracticalScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlobalDeck extends StatelessWidget {
  const _GlobalDeck({
    required this.compact,
    required this.guides,
    required this.notes,
    required this.rtl,
    required this.zoom,
    required this.onCompactChanged,
    required this.onGuidesChanged,
    required this.onNotesChanged,
    required this.onRtlChanged,
    required this.onZoomChanged,
  });

  final bool compact;
  final bool guides;
  final bool notes;
  final bool rtl;
  final double zoom;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuidesChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onZoomChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF18384E), Color(0xFF2A6AA2), Color(0xFF2F846E), Color(0xFF635AB1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OverlayState Control Deck', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text(
            'OverlayState manages a stack of OverlayEntry objects for layered UI composition. '
            'Use Overlay.of(context) to access it, then insert(), insertAll(), rearrange(), and remove entries programmatically.',
            style: TextStyle(color: Color(0xFFDDEDF8), height: 1.35),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact scenes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: guides,
                  onChanged: onGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: notes,
                  onChanged: onNotesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Instruction notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Text('Scene zoom: ${zoom.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: zoom,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onZoomChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({required this.index, required this.tone, required this.title, required this.subtitle, required this.child});

  final int index;
  final Color tone;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 7)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A4F61), height: 1.34)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _EntryManagementScene extends StatefulWidget {
  const _EntryManagementScene({required this.compact, required this.guides, required this.notes, required this.zoom});

  final bool compact;
  final bool guides;
  final bool notes;
  final double zoom;

  @override
  State<_EntryManagementScene> createState() => _EntryManagementSceneState();
}

class _EntryManagementSceneState extends State<_EntryManagementScene> {
  final List<_ManagedEntry> _entries = <_ManagedEntry>[];
  final List<String> _events = <String>[];
  int _counter = 0;
  final GlobalKey<_OverlayCanvasState> _canvasKey = GlobalKey<_OverlayCanvasState>();

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1080.0 : 1300.0;
    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Entry controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: _insertEntry,
                            child: const Text('insert()'),
                          ),
                          FilledButton.tonal(
                            onPressed: _insertMultiple,
                            child: const Text('insertAll(3)'),
                          ),
                          FilledButton.tonal(
                            onPressed: _entries.isEmpty ? null : _removeFirst,
                            child: const Text('Remove first'),
                          ),
                          FilledButton.tonal(
                            onPressed: _entries.isEmpty ? null : _removeLast,
                            child: const Text('Remove last'),
                          ),
                          FilledButton.tonal(
                            onPressed: _entries.isEmpty ? null : _clearAll,
                            child: const Text('Clear all'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Active entries', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      _FactTable(rows: [
                        _FactRow('count', '${_entries.length}'),
                        _FactRow('counter', '$_counter'),
                        _FactRow('timeline entries', '${_events.length}'),
                      ]),
                      const SizedBox(height: 8),
                      if (_entries.isNotEmpty)
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: _blue.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _blue.withValues(alpha: 0.2)),
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: _entries.length,
                            itemBuilder: (context, index) {
                              final e = _entries[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: e.color,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text('Entry ${e.id}', style: const TextStyle(fontWeight: FontWeight.w600))),
                                    IconButton(
                                      icon: const Icon(Icons.close, size: 16),
                                      onPressed: () => _removeEntry(e),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'OverlayState.insert() adds a single entry to the overlay stack. Use below/above to position relative to existing entries.',
                            'insertAll() adds multiple entries at once, efficient for batch operations like showing multiple toasts.',
                            'Call entry.remove() or manage removal through custom logic to dispose entries properly.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Entry timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 200, child: _EventLog(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Transform.scale(
                scale: widget.zoom,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Overlay canvas', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: _OverlayCanvas(
                          key: _canvasKey,
                          entries: _entries,
                          onEntryRemoved: _removeEntry,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _insertEntry() {
    _counter++;
    final overlayState = _canvasKey.currentState?.overlayKey.currentState;
    if (overlayState == null) {
      _push('Error: OverlayState not available');
      return;
    }
    final managed = _ManagedEntry(
      id: _counter,
      color: _colorForIndex(_counter),
    );
    managed.entry = OverlayEntry(
      builder: (context) => _OverlayTile(
        id: managed.id,
        color: managed.color,
        onRemove: () => _removeEntry(managed),
      ),
    );
    overlayState.insert(managed.entry!);
    setState(() {
      _entries.add(managed);
    });
    _push('insert entry #${managed.id}');
  }

  void _insertMultiple() {
    final overlayState = _canvasKey.currentState?.overlayKey.currentState;
    if (overlayState == null) {
      _push('Error: OverlayState not available');
      return;
    }
    final newEntries = <_ManagedEntry>[];
    for (int i = 0; i < 3; i++) {
      _counter++;
      final managed = _ManagedEntry(
        id: _counter,
        color: _colorForIndex(_counter),
      );
      managed.entry = OverlayEntry(
        builder: (context) => _OverlayTile(
          id: managed.id,
          color: managed.color,
          onRemove: () => _removeEntry(managed),
        ),
      );
      newEntries.add(managed);
    }
    overlayState.insertAll(newEntries.map((e) => e.entry!));
    setState(() {
      _entries.addAll(newEntries);
    });
    _push('insertAll 3 entries (#${newEntries.first.id}-#${newEntries.last.id})');
  }

  void _removeEntry(_ManagedEntry managed) {
    managed.entry?.remove();
    setState(() {
      _entries.remove(managed);
    });
    _push('remove entry #${managed.id}');
  }

  void _removeFirst() {
    if (_entries.isEmpty) return;
    _removeEntry(_entries.first);
  }

  void _removeLast() {
    if (_entries.isEmpty) return;
    _removeEntry(_entries.last);
  }

  void _clearAll() {
    for (final e in _entries) {
      e.entry?.remove();
    }
    setState(() {
      _entries.clear();
    });
    _push('clear all entries');
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 50);
    });
  }

  Color _colorForIndex(int index) {
    const colors = [_blue, _jade, _amber, _rose, _indigo];
    return colors[index % colors.length];
  }
}

class _ManagedEntry {
  _ManagedEntry({required this.id, required this.color});

  final int id;
  final Color color;
  OverlayEntry? entry;
}

class _OverlayCanvas extends StatefulWidget {
  const _OverlayCanvas({super.key, required this.entries, required this.onEntryRemoved});

  final List<_ManagedEntry> entries;
  final ValueChanged<_ManagedEntry> onEntryRemoved;

  @override
  State<_OverlayCanvas> createState() => _OverlayCanvasState();
}

class _OverlayCanvasState extends State<_OverlayCanvas> {
  final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _blue.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _blue.withValues(alpha: 0.2), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Overlay(
          key: overlayKey,
          initialEntries: [
            OverlayEntry(
              builder: (context) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _blue.withValues(alpha: 0.08),
                      _jade.withValues(alpha: 0.06),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Base overlay layer\n(always present)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF4A6277),
                      fontWeight: FontWeight.w600,
                    ),
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

class _OverlayTile extends StatelessWidget {
  const _OverlayTile({required this.id, required this.color, required this.onRemove});

  final int id;
  final Color color;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final offset = Offset(20.0 + (id % 6) * 35.0, 20.0 + (id % 8) * 40.0);
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: Container(
          width: 160,
          height: 90,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Entry #$id',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                  InkWell(
                    onTap: onRemove,
                    child: const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Tap X to remove',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RearrangeScene extends StatefulWidget {
  const _RearrangeScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_RearrangeScene> createState() => _RearrangeSceneState();
}

class _RearrangeSceneState extends State<_RearrangeScene> {
  final List<_OrderedEntry> _orderedEntries = <_OrderedEntry>[];
  final List<String> _events = <String>[];
  final GlobalKey<_RearrangeCanvasState> _canvasKey = GlobalKey<_RearrangeCanvasState>();
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeEntries();
    });
  }

  void _initializeEntries() {
    final overlayState = _canvasKey.currentState?.overlayKey.currentState;
    if (overlayState == null) return;

    for (int i = 0; i < 4; i++) {
      _counter++;
      final ordered = _OrderedEntry(
        id: _counter,
        color: _colorForIndex(_counter),
        label: 'Layer $_counter',
      );
      ordered.entry = OverlayEntry(
        builder: (context) => _OrderedTile(
          id: ordered.id,
          color: ordered.color,
          label: ordered.label,
          stackPosition: _orderedEntries.indexOf(ordered),
          total: _orderedEntries.length,
        ),
      );
      overlayState.insert(ordered.entry!);
      _orderedEntries.add(ordered);
    }
    setState(() {});
    _push('initialized with 4 entries');
  }

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1080.0 : 1280.0;
    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Rearrange controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: _orderedEntries.length >= 2 ? _moveFirstToLast : null,
                            child: const Text('Move first to last'),
                          ),
                          FilledButton.tonal(
                            onPressed: _orderedEntries.length >= 2 ? _moveLastToFirst : null,
                            child: const Text('Move last to first'),
                          ),
                          FilledButton.tonal(
                            onPressed: _orderedEntries.length >= 2 ? _reverseOrder : null,
                            child: const Text('Reverse order'),
                          ),
                          FilledButton.tonal(
                            onPressed: _orderedEntries.length >= 2 ? _shuffleOrder : null,
                            child: const Text('Shuffle'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Current stack order (bottom to top)', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      if (_orderedEntries.isNotEmpty)
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: _jade.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _jade.withValues(alpha: 0.2)),
                          ),
                          child: ReorderableListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: _orderedEntries.length,
                            onReorder: _onReorder,
                            itemBuilder: (context, index) {
                              final e = _orderedEntries[index];
                              return Container(
                                key: ValueKey(e.id),
                                margin: const EdgeInsets.only(bottom: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: e.color.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: e.color.withValues(alpha: 0.4)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: e.color,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(e.label, style: const TextStyle(fontWeight: FontWeight.w600))),
                                    Text('z=$index', style: TextStyle(color: e.color, fontWeight: FontWeight.w700, fontSize: 12)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _jade,
                          lines: const [
                            'rearrange() reorders existing entries without removing them. Pass the entries in new desired order.',
                            'Use below/above arguments to position relative to a reference entry for partial reordering.',
                            'Drag items in the list above to rearrange visually; watch the canvas update.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Rearrange timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 200, child: _EventLog(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Stacking canvas', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _RearrangeCanvas(
                        key: _canvasKey,
                        entries: _orderedEntries,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _orderedEntries.removeAt(oldIndex);
    _orderedEntries.insert(newIndex, item);
    _applyRearrange();
    _push('reorder: moved entry #${item.id} from $oldIndex to $newIndex');
  }

  void _moveFirstToLast() {
    if (_orderedEntries.length < 2) return;
    final first = _orderedEntries.removeAt(0);
    _orderedEntries.add(first);
    _applyRearrange();
    _push('moved first (#${first.id}) to last');
  }

  void _moveLastToFirst() {
    if (_orderedEntries.length < 2) return;
    final last = _orderedEntries.removeLast();
    _orderedEntries.insert(0, last);
    _applyRearrange();
    _push('moved last (#${last.id}) to first');
  }

  void _reverseOrder() {
    final reversed = _orderedEntries.reversed.toList();
    _orderedEntries.clear();
    _orderedEntries.addAll(reversed);
    _applyRearrange();
    _push('reversed order');
  }

  void _shuffleOrder() {
    _orderedEntries.shuffle();
    _applyRearrange();
    _push('shuffled order');
  }

  void _applyRearrange() {
    final overlayState = _canvasKey.currentState?.overlayKey.currentState;
    if (overlayState == null) return;
    overlayState.rearrange(_orderedEntries.map((e) => e.entry!));
    for (final e in _orderedEntries) {
      e.entry?.markNeedsBuild();
    }
    setState(() {});
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 50);
    });
  }

  Color _colorForIndex(int index) {
    const colors = [_blue, _jade, _amber, _rose, _indigo];
    return colors[index % colors.length];
  }
}

class _OrderedEntry {
  _OrderedEntry({required this.id, required this.color, required this.label});

  final int id;
  final Color color;
  final String label;
  OverlayEntry? entry;
}

class _RearrangeCanvas extends StatefulWidget {
  const _RearrangeCanvas({super.key, required this.entries});

  final List<_OrderedEntry> entries;

  @override
  State<_RearrangeCanvas> createState() => _RearrangeCanvasState();
}

class _RearrangeCanvasState extends State<_RearrangeCanvas> {
  final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _jade.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _jade.withValues(alpha: 0.2), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Overlay(
          key: overlayKey,
          initialEntries: [
            OverlayEntry(
              builder: (context) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _jade.withValues(alpha: 0.08),
                      _amber.withValues(alpha: 0.06),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Rearrange canvas\n(watch layer order change)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF4A6277),
                      fontWeight: FontWeight.w600,
                    ),
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

class _OrderedTile extends StatelessWidget {
  const _OrderedTile({required this.id, required this.color, required this.label, required this.stackPosition, required this.total});

  final int id;
  final Color color;
  final String label;
  final int stackPosition;
  final int total;

  @override
  Widget build(BuildContext context) {
    final baseOffset = 40.0 + stackPosition * 30.0;
    return Positioned(
      left: baseOffset,
      top: baseOffset,
      right: 40.0 + (total - stackPosition - 1) * 15.0,
      bottom: 40.0 + (total - stackPosition - 1) * 15.0,
      child: Material(
        elevation: 4 + stackPosition * 2.0,
        borderRadius: BorderRadius.circular(14),
        color: color.withValues(alpha: 0.95),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Stack index: $stackPosition',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccessScene extends StatefulWidget {
  const _AccessScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_AccessScene> createState() => _AccessSceneState();
}

class _AccessSceneState extends State<_AccessScene> {
  final List<String> _events = <String>[];
  bool _useRootOverlay = false;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 980.0 : 1180.0;
    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Access controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _useRootOverlay,
                        onChanged: (v) {
                          setState(() => _useRootOverlay = v);
                          _push('rootOverlay=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Use rootOverlay flag'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => _testOf(context),
                            child: const Text('Test Overlay.of()'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => _testMaybeOf(context),
                            child: const Text('Test Overlay.maybeOf()'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _FactTable(rows: [
                        _FactRow('rootOverlay', _useRootOverlay.toString()),
                        _FactRow('timeline entries', '${_events.length}'),
                      ]),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'Overlay.of(context) returns the nearest OverlayState ancestor. Throws if none found.',
                            'Overlay.maybeOf(context) returns null instead of throwing if no overlay exists.',
                            'rootOverlay=true traverses to the topmost overlay, useful for app-wide modals.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Access timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 200, child: _EventLog(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nested overlay demonstration', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _NestedOverlayDemo(
                        useRootOverlay: _useRootOverlay,
                        onEvent: _push,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _testOf(BuildContext context) {
    try {
      final overlay = Overlay.of(context, rootOverlay: _useRootOverlay);
      _push('Overlay.of() returned: ${overlay.runtimeType}');
    } catch (e) {
      _push('Overlay.of() threw: $e');
    }
  }

  void _testMaybeOf(BuildContext context) {
    final overlay = Overlay.maybeOf(context, rootOverlay: _useRootOverlay);
    if (overlay != null) {
      _push('Overlay.maybeOf() returned: ${overlay.runtimeType}');
    } else {
      _push('Overlay.maybeOf() returned null');
    }
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 50);
    });
  }
}

class _NestedOverlayDemo extends StatefulWidget {
  const _NestedOverlayDemo({required this.useRootOverlay, required this.onEvent});

  final bool useRootOverlay;
  final ValueChanged<String> onEvent;

  @override
  State<_NestedOverlayDemo> createState() => _NestedOverlayDemoState();
}

class _NestedOverlayDemoState extends State<_NestedOverlayDemo> {
  final GlobalKey<OverlayState> _outerKey = GlobalKey<OverlayState>();
  final GlobalKey<OverlayState> _innerKey = GlobalKey<OverlayState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _amber.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _amber.withValues(alpha: 0.2), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Overlay(
          key: _outerKey,
          initialEntries: [
            OverlayEntry(
              builder: (context) => Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _amber.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.layers, color: _amber),
                          const SizedBox(width: 8),
                          const Text('Outer Overlay', style: TextStyle(fontWeight: FontWeight.w800, color: _amber)),
                          const Spacer(),
                          FilledButton.tonal(
                            onPressed: () => _insertInOuter(),
                            child: const Text('Insert here'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: _rose.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _rose.withValues(alpha: 0.3)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Overlay(
                            key: _innerKey,
                            initialEntries: [
                              OverlayEntry(
                                builder: (innerContext) => Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: _rose.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.layers_outlined, color: _rose),
                                            const SizedBox(width: 8),
                                            const Text('Inner Overlay', style: TextStyle(fontWeight: FontWeight.w800, color: _rose)),
                                            const Spacer(),
                                            FilledButton.tonal(
                                              onPressed: () => _insertInInner(innerContext),
                                              child: const Text('Insert here'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF0F4F8),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          widget.useRootOverlay
                                              ? 'rootOverlay=true: commands target outer overlay'
                                              : 'rootOverlay=false: commands target inner (nearest) overlay',
                                          style: const TextStyle(fontSize: 12),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insertInOuter() {
    final overlay = _outerKey.currentState;
    if (overlay == null) return;
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        right: 20,
        bottom: 20,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          color: _amber,
          child: InkWell(
            onTap: () {
              entry.remove();
              widget.onEvent('removed outer entry');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: const Text('Outer entry (tap to close)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    widget.onEvent('inserted in outer overlay');
  }

  void _insertInInner(BuildContext innerContext) {
    final overlay = widget.useRootOverlay
        ? Overlay.of(innerContext, rootOverlay: true)
        : Overlay.of(innerContext);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: 30,
        top: 120,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          color: widget.useRootOverlay ? _amber : _rose,
          child: InkWell(
            onTap: () {
              entry.remove();
              widget.onEvent('removed ${widget.useRootOverlay ? "root" : "inner"} entry');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                '${widget.useRootOverlay ? "Root" : "Inner"} entry (tap to close)',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    widget.onEvent('inserted in ${widget.useRootOverlay ? "root" : "inner"} overlay');
  }
}

class _PropertiesScene extends StatefulWidget {
  const _PropertiesScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_PropertiesScene> createState() => _PropertiesSceneState();
}

class _PropertiesSceneState extends State<_PropertiesScene> {
  final List<String> _events = <String>[];
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();
  OverlayEntry? _currentEntry;
  bool _opaque = false;
  bool _maintainState = false;
  bool _canSizeOverlay = false;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 980.0 : 1180.0;
    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Entry property controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _opaque,
                        onChanged: (v) {
                          setState(() => _opaque = v);
                          _currentEntry?.opaque = v;
                          _push('opaque=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('opaque'),
                        subtitle: const Text('Hides entries behind this one'),
                      ),
                      SwitchListTile(
                        value: _maintainState,
                        onChanged: (v) {
                          setState(() => _maintainState = v);
                          _currentEntry?.maintainState = v;
                          _push('maintainState=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('maintainState'),
                        subtitle: const Text('Keeps state when offscreen'),
                      ),
                      SwitchListTile(
                        value: _canSizeOverlay,
                        onChanged: (v) {
                          setState(() => _canSizeOverlay = v);
                          _push('canSizeOverlay=$v (requires recreate)');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('canSizeOverlay'),
                        subtitle: const Text('Entry can size the overlay'),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: _currentEntry == null ? _insertEntry : null,
                            child: const Text('Insert entry'),
                          ),
                          FilledButton.tonal(
                            onPressed: _currentEntry != null ? _removeEntry : null,
                            child: const Text('Remove entry'),
                          ),
                          FilledButton.tonal(
                            onPressed: _currentEntry != null ? _rebuildEntry : null,
                            child: const Text('markNeedsBuild()'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _FactTable(rows: [
                        _FactRow('entry present', '${_currentEntry != null}'),
                        _FactRow('opaque', '$_opaque'),
                        _FactRow('maintainState', '$_maintainState'),
                        _FactRow('canSizeOverlay', '$_canSizeOverlay'),
                      ]),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'opaque=true hints that this entry fully covers entries behind it, enabling optimizations.',
                            'maintainState=true keeps entry state alive even when covered by opaque entries.',
                            'canSizeOverlay=true allows the entry to influence the overlay widget size.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Properties timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 200, child: _EventLog(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Properties canvas', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _rose.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _rose.withValues(alpha: 0.2), width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Overlay(
                            key: _overlayKey,
                            initialEntries: [
                              OverlayEntry(
                                builder: (context) => Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        _rose.withValues(alpha: 0.12),
                                        _indigo.withValues(alpha: 0.08),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: GridView.count(
                                    crossAxisCount: 4,
                                    padding: const EdgeInsets.all(12),
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    children: List.generate(
                                      16,
                                      (i) => Container(
                                        decoration: BoxDecoration(
                                          color: (i % 2 == 0 ? _rose : _indigo).withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Tile $i',
                                            style: TextStyle(
                                              color: (i % 2 == 0 ? _rose : _indigo),
                                              fontWeight: FontWeight.w600,
                                            ),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _insertEntry() {
    final overlay = _overlayKey.currentState;
    if (overlay == null) return;
    _currentEntry = OverlayEntry(
      opaque: _opaque,
      maintainState: _maintainState,
      canSizeOverlay: _canSizeOverlay,
      builder: (context) => Positioned(
        left: 30,
        top: 30,
        right: 30,
        bottom: 30,
        child: Material(
          elevation: 12,
          borderRadius: BorderRadius.circular(16),
          color: _rose.withValues(alpha: 0.95),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overlay Entry',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  'opaque: $_opaque\nmaintainState: $_maintainState\ncanSizeOverlay: $_canSizeOverlay',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), height: 1.4),
                ),
                const Spacer(),
                Text(
                  _opaque
                      ? 'Entries behind this are hidden (opaque=true)'
                      : 'Entries behind are still visible (opaque=false)',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(_currentEntry!);
    setState(() {});
    _push('inserted entry (opaque=$_opaque, maintainState=$_maintainState)');
  }

  void _removeEntry() {
    _currentEntry?.remove();
    _currentEntry = null;
    setState(() {});
    _push('removed entry');
  }

  void _rebuildEntry() {
    _currentEntry?.markNeedsBuild();
    _push('markNeedsBuild() called');
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 50);
    });
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  int _revision = 1;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1180.0 : 1400.0;
    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.tonal(
                          onPressed: () => setState(() => _revision += 1),
                          child: Text('Refresh modules ($_revision)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _events.insert(0, '${_clock()} | snapshot captured');
                              _trim(_events, 60);
                            });
                          },
                          child: const Text('Capture snapshot'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _events.clear()),
                          child: const Text('Clear timeline'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _TooltipModule(
                              revision: _revision,
                              onEvent: (e) => _push('tooltip: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ToastModule(
                              revision: _revision,
                              onEvent: (e) => _push('toast: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ModalModule(
                              revision: _revision,
                              onEvent: (e) => _push('modal: $e'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Practical guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _indigo,
                        lines: const [
                          'Tooltips: insert positioned overlays on hover/focus, remove on dismissal.',
                          'Toasts: insertAll for batched notifications, auto-dismiss with Timer.',
                          'Modals: use opaque=true for blocking dialogs, wrap with gesture barrier.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _FactTable(rows: [
                      _FactRow('revision', '$_revision'),
                      _FactRow('timeline entries', '${_events.length}'),
                      _FactRow('clock', _clock()),
                    ]),
                    const SizedBox(height: 8),
                    const Text('Practical timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _EventLog(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 60);
    });
  }
}

class _TooltipModule extends StatefulWidget {
  const _TooltipModule({required this.revision, required this.onEvent});

  final int revision;
  final ValueChanged<String> onEvent;

  @override
  State<_TooltipModule> createState() => _TooltipModuleState();
}

class _TooltipModuleState extends State<_TooltipModule> {
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();
  OverlayEntry? _tooltipEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: _blue, size: 20),
              const SizedBox(width: 6),
              const Expanded(child: Text('Tooltip Module', style: TextStyle(color: _blue, fontWeight: FontWeight.w800))),
              _ToneChip(tone: _blue, label: 'rev ${widget.revision}'),
            ],
          ),
          const SizedBox(height: 6),
          const Text('Hover over targets to show custom tooltips via overlay.', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _blue.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _blue.withValues(alpha: 0.15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Overlay(
                  key: _overlayKey,
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _TooltipTarget(
                              label: 'Target A',
                              color: _blue,
                              onHover: (hovering) => _showTooltip(hovering, 'Tooltip for Target A', const Offset(20, 40)),
                            ),
                            const SizedBox(height: 12),
                            _TooltipTarget(
                              label: 'Target B',
                              color: _jade,
                              onHover: (hovering) => _showTooltip(hovering, 'Tooltip for Target B', const Offset(20, 110)),
                            ),
                            const SizedBox(height: 12),
                            _TooltipTarget(
                              label: 'Target C',
                              color: _amber,
                              onHover: (hovering) => _showTooltip(hovering, 'Tooltip for Target C', const Offset(20, 180)),
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
        ],
      ),
    );
  }

  void _showTooltip(bool show, String text, Offset position) {
    if (show) {
      _tooltipEntry?.remove();
      _tooltipEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: position.dx + 100,
          top: position.dy,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(6),
            color: _ink,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ),
      );
      _overlayKey.currentState?.insert(_tooltipEntry!);
      widget.onEvent('show "$text"');
    } else {
      _tooltipEntry?.remove();
      _tooltipEntry = null;
      widget.onEvent('hide tooltip');
    }
  }
}

class _TooltipTarget extends StatelessWidget {
  const _TooltipTarget({required this.label, required this.color, required this.onHover});

  final String label;
  final Color color;
  final ValueChanged<bool> onHover;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _ToastModule extends StatefulWidget {
  const _ToastModule({required this.revision, required this.onEvent});

  final int revision;
  final ValueChanged<String> onEvent;

  @override
  State<_ToastModule> createState() => _ToastModuleState();
}

class _ToastModuleState extends State<_ToastModule> {
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();
  final List<OverlayEntry> _toasts = <OverlayEntry>[];
  int _toastCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _jade.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.notifications_outlined, color: _jade, size: 20),
              const SizedBox(width: 6),
              const Expanded(child: Text('Toast Module', style: TextStyle(color: _jade, fontWeight: FontWeight.w800))),
              _ToneChip(tone: _jade, label: 'rev ${widget.revision}'),
            ],
          ),
          const SizedBox(height: 6),
          const Text('Stack notification toasts that auto-dismiss.', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              FilledButton.tonal(onPressed: _showToast, child: const Text('Show toast')),
              FilledButton.tonal(onPressed: _toasts.isEmpty ? null : _clearToasts, child: const Text('Clear all')),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _jade.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _jade.withValues(alpha: 0.15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Overlay(
                  key: _overlayKey,
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Toast area',
                          style: TextStyle(color: _jade.withValues(alpha: 0.5), fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast() {
    final overlay = _overlayKey.currentState;
    if (overlay == null) return;
    _toastCounter++;
    final index = _toasts.length;
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 10.0 + index * 50.0,
        left: 10,
        right: 10,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          color: _jade,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Toast #$_toastCounter',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                InkWell(
                  onTap: () {
                    entry.remove();
                    _toasts.remove(entry);
                    widget.onEvent('dismissed toast');
                    _rebuildToasts();
                  },
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _toasts.add(entry);
    widget.onEvent('show toast #$_toastCounter');
  }

  void _clearToasts() {
    for (final t in _toasts) {
      t.remove();
    }
    _toasts.clear();
    widget.onEvent('cleared all toasts');
  }

  void _rebuildToasts() {
    for (final t in _toasts) {
      t.markNeedsBuild();
    }
  }
}

class _ModalModule extends StatefulWidget {
  const _ModalModule({required this.revision, required this.onEvent});

  final int revision;
  final ValueChanged<String> onEvent;

  @override
  State<_ModalModule> createState() => _ModalModuleState();
}

class _ModalModuleState extends State<_ModalModule> {
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();
  OverlayEntry? _modalEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _indigo.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.open_in_new, color: _indigo, size: 20),
              const SizedBox(width: 6),
              const Expanded(child: Text('Modal Module', style: TextStyle(color: _indigo, fontWeight: FontWeight.w800))),
              _ToneChip(tone: _indigo, label: 'rev ${widget.revision}'),
            ],
          ),
          const SizedBox(height: 6),
          const Text('Opaque modal overlays that block interaction.', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: _modalEntry == null ? _showModal : null,
            child: const Text('Show modal'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _indigo.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _indigo.withValues(alpha: 0.15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Overlay(
                  key: _overlayKey,
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.touch_app, color: _indigo.withValues(alpha: 0.3), size: 32),
                            const SizedBox(height: 8),
                            Text(
                              'Tap "Show modal" above',
                              style: TextStyle(color: _indigo.withValues(alpha: 0.5), fontWeight: FontWeight.w600),
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
        ],
      ),
    );
  }

  void _showModal() {
    final overlay = _overlayKey.currentState;
    if (overlay == null) return;
    _modalEntry = OverlayEntry(
      opaque: true,
      builder: (context) => GestureDetector(
        onTap: () {}, // Block taps behind
        child: Container(
          color: Colors.black.withValues(alpha: 0.5),
          child: Center(
            child: Material(
              elevation: 16,
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Modal Dialog', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    const SizedBox(height: 12),
                    const Text('This is an opaque overlay entry blocking background interaction.', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _dismissModal,
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_modalEntry!);
    setState(() {});
    widget.onEvent('show modal');
  }

  void _dismissModal() {
    _modalEntry?.remove();
    _modalEntry = null;
    setState(() {});
    widget.onEvent('dismiss modal');
  }
}

class _PanelSurface extends StatelessWidget {
  const _PanelSurface({required this.guides, required this.child});

  final bool guides;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC6D7E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAFCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guides) const CustomPaint(painter: _GuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x13000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FactRow {
  const _FactRow(this.label, this.value);

  final String label;
  final String value;
}

class _FactTable extends StatelessWidget {
  const _FactTable({required this.rows});

  final List<_FactRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD2E1EF)),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 140, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                    Expanded(child: Text(r.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.tone, required this.lines});

  final Color tone;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.circle, size: 7, color: Color(0xFFBFE3FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFEAF6FF), height: 1.35))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _EventLog extends StatelessWidget {
  const _EventLog({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFDEEC)),
      ),
      child: lines.isEmpty
          ? const Text('No events yet.', style: TextStyle(color: Color(0xFF62798D)))
          : ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(lines[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                );
              },
            ),
    );
  }
}

class _ToneChip extends StatelessWidget {
  const _ToneChip({required this.tone, required this.label});

  final Color tone;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 11)),
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
        color: const Color(0xFF14374E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: OverlayState', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'OverlayState manages a stack of OverlayEntry objects for layered UI composition. '
            'Access it via Overlay.of(context), then use insert(), insertAll(), rearrange(), and remove() to manage entries. '
            'Properties like opaque and maintainState fine-tune rendering behavior for tooltips, toasts, modals, and more.',
            style: TextStyle(color: Color(0xFFD8E9F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

void _trim(List<String> events, int limit) {
  if (events.length > limit) {
    events.removeRange(limit, events.length);
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
