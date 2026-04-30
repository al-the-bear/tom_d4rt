import 'package:flutter/material.dart';

const _bg = Color(0xFFF7F8FC);
const _ink = Color(0xFF1E3550);
const _blue = Color(0xFF326EA7);
const _jade = Color(0xFF2D876A);
const _amber = Color(0xFFB38332);
const _rose = Color(0xFF9D5878);
const _indigo = Color(0xFF5D58B2);

dynamic build(BuildContext context) {
  return const _PageStorageBucketDeepDemoApp();
}

class _PageStorageBucketDeepDemoApp extends StatelessWidget {
  const _PageStorageBucketDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _PageStorageBucketDeepDemoPage(),
    );
  }
}

class _PageStorageBucketDeepDemoPage extends StatefulWidget {
  const _PageStorageBucketDeepDemoPage();

  @override
  State<_PageStorageBucketDeepDemoPage> createState() => _PageStorageBucketDeepDemoPageState();
}

class _PageStorageBucketDeepDemoPageState extends State<_PageStorageBucketDeepDemoPage> {
  bool _compact = false;
  bool _guides = true;
  bool _notes = true;
  bool _denseCards = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        toolbarHeight: 96,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('PageStorageBucket Deep Demo'),
            Text(
              'page-level persistence | keys + explicit bucket read/write',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.86),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
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
              denseCards: _denseCards,
              onCompactChanged: (v) => setState(() => _compact = v),
              onGuidesChanged: (v) => setState(() => _guides = v),
              onNotesChanged: (v) => setState(() => _notes = v),
              onDenseCardsChanged: (v) => setState(() => _denseCards = v),
            ),
            const SizedBox(height: 12),
            _SceneShell(
              index: 1,
              tone: _blue,
              title: 'Bucket Fundamentals Studio',
              subtitle:
                  'Use one bucket with multiple PageStorageKey widgets to preserve independent scroll positions and panel state when widgets leave and re-enter the tree.',
              child: _BucketFundamentalsScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
                denseCards: _denseCards,
              ),
            ),
            const SizedBox(height: 12),
            _SceneShell(
              index: 2,
              tone: _jade,
              title: 'Read/Write Console',
              subtitle:
                  'Explicitly persist arbitrary values with PageStorageBucket.writeState() and restore with readState() using stable identifiers.',
              child: _ReadWriteConsoleScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
              ),
            ),
            const SizedBox(height: 12),
            _SceneShell(
              index: 3,
              tone: _amber,
              title: 'Multi-Bucket Isolation Lab',
              subtitle:
                  'Compare two buckets with identical UI. State isolation is visible when switching between workspaces that do not share bucket instances.',
              child: _MultiBucketIsolationScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
              ),
            ),
            const SizedBox(height: 12),
            _SceneShell(
              index: 4,
              tone: _rose,
              title: 'Route-Like Persistence Workshop',
              subtitle:
                  'Simulate route transitions using one shared bucket. Each route keeps independent scroll and draft state while being swapped in and out.',
              child: _RouteLikePersistenceScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
              ),
            ),
            const SizedBox(height: 12),
            _SceneShell(
              index: 5,
              tone: _indigo,
              title: 'Practical Modules Gallery',
              subtitle:
                  'Three practical modules (filters, drafts, progress board) demonstrate when PageStorageBucket is ideal for lightweight page/session state.',
              child: _PracticalModulesScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
              ),
            ),
            const SizedBox(height: 12),
            const _RecapCard(),
            const SizedBox(height: 24),
          ],
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
    required this.denseCards,
    required this.onCompactChanged,
    required this.onGuidesChanged,
    required this.onNotesChanged,
    required this.onDenseCardsChanged,
  });

  final bool compact;
  final bool guides;
  final bool notes;
  final bool denseCards;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuidesChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onDenseCardsChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1F3551), Color(0xFF326EA7), Color(0xFF2D876A), Color(0xFF5D58B2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PageStorageBucket Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
          ),
          const SizedBox(height: 8),
          const Text(
            'PageStorageBucket stores page-scoped values for widgets identified by PageStorageKey '
            'or explicit identifiers. It is ideal for preserving scroll offsets, drafts, and lightweight UI choices '
            'while navigating tabs/routes or temporarily removing widgets from the tree.',
            style: TextStyle(color: Color(0xFFDCEBF7), height: 1.35),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _DeckSwitch(
                title: 'Compact scenes',
                value: compact,
                onChanged: onCompactChanged,
              ),
              _DeckSwitch(
                title: 'Guide overlays',
                value: guides,
                onChanged: onGuidesChanged,
              ),
              _DeckSwitch(
                title: 'Instruction notes',
                value: notes,
                onChanged: onNotesChanged,
              ),
              _DeckSwitch(
                title: 'Dense cards',
                value: denseCards,
                onChanged: onDenseCardsChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeckSwitch extends StatelessWidget {
  const _DeckSwitch({required this.title, required this.value, required this.onChanged});

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(value: value, onChanged: onChanged, activeThumbColor: Colors.white),
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
    required this.index,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.child,
  });

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
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
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

class _BucketFundamentalsScene extends StatefulWidget {
  const _BucketFundamentalsScene({
    required this.compact,
    required this.guides,
    required this.notes,
    required this.denseCards,
  });

  final bool compact;
  final bool guides;
  final bool notes;
  final bool denseCards;

  @override
  State<_BucketFundamentalsScene> createState() => _BucketFundamentalsSceneState();
}

class _BucketFundamentalsSceneState extends State<_BucketFundamentalsScene> {
  PageStorageBucket _bucket = PageStorageBucket();
  final List<String> _events = <String>[];
  int _panelIndex = 0;
  bool _mounted = true;
  bool _showDetailBand = true;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 900.0 : 1080.0;
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
                      const _SectionTitle('Fundamentals Controls'),
                      const SizedBox(height: 8),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Catalog')),
                          ButtonSegment(value: 1, label: Text('Timeline')),
                          ButtonSegment(value: 2, label: Text('Checklist')),
                        ],
                        selected: <int>{_panelIndex},
                        onSelectionChanged: (values) {
                          final value = values.first;
                          setState(() => _panelIndex = value);
                          _push('selected panel $value');
                        },
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _mounted = !_mounted);
                              _push(_mounted ? 'mounted demo subtree' : 'unmounted demo subtree');
                            },
                            child: Text(_mounted ? 'Unmount subtree' : 'Mount subtree'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _showDetailBand = !_showDetailBand);
                              _push('detail band = $_showDetailBand');
                            },
                            child: Text(_showDetailBand ? 'Hide detail band' : 'Show detail band'),
                          ),
                          FilledButton.tonal(
                            onPressed: _resetBucket,
                            child: const Text('Reset bucket instance'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _FactTable(rows: [
                        _FactRow('active panel', '$_panelIndex'),
                        _FactRow('subtree mounted', '$_mounted'),
                        _FactRow('detail band', '$_showDetailBand'),
                        _FactRow('events', '${_events.length}'),
                      ]),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'Wrap the subtree with PageStorage(bucket: myBucket, child: ...) to scope persistence.',
                            'Use stable PageStorageKey values per scrollable/form section to keep values distinct.',
                            'If the bucket instance changes, previously persisted values are no longer available.',
                          ],
                        ),
                      const SizedBox(height: 10),
                      const _SectionTitle('Event Timeline'),
                      const SizedBox(height: 6),
                      SizedBox(height: 220, child: _EventLog(lines: _events)),
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
                    const _SectionTitle('Visual Demonstration Surface'),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _mounted
                          ? PageStorage(
                              bucket: _bucket,
                              child: Column(
                                children: [
                                  if (_showDetailBand) _FundamentalsDetailBand(panelIndex: _panelIndex),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: IndexedStack(
                                      index: _panelIndex,
                                      children: [
                                        _FundamentalsCatalogPane(denseCards: widget.denseCards),
                                        const _FundamentalsTimelinePane(),
                                        const _FundamentalsChecklistPane(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : _UnmountedHint(
                              tone: _blue,
                              title: 'Subtree unmounted',
                              description:
                                  'Mount the subtree again to validate whether scroll positions and per-pane state are restored from the same bucket.',
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

  void _resetBucket() {
    setState(() {
      _bucket = PageStorageBucket();
    });
    _push('reset bucket instance (all stored values cleared)');
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 60);
    });
  }
}

class _FundamentalsDetailBand extends StatelessWidget {
  const _FundamentalsDetailBand({required this.panelIndex});

  final int panelIndex;

  @override
  Widget build(BuildContext context) {
    final text = switch (panelIndex) {
      0 => 'Catalog panel: preserving a long scrollable visual list.',
      1 => 'Timeline panel: preserving scroll through reverse-chronology cards.',
      _ => 'Checklist panel: preserving switch states and list position together.',
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _blue.withValues(alpha: 0.24)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: _blue),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _blue, fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }
}

class _FundamentalsCatalogPane extends StatelessWidget {
  const _FundamentalsCatalogPane({required this.denseCards});

  final bool denseCards;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey('fundamentals_catalog_scroll'),
      padding: const EdgeInsets.all(8),
      itemCount: 28,
      itemBuilder: (context, index) {
        final tone = index % 3 == 0
            ? _blue
            : index % 3 == 1
                ? _jade
                : _amber;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(denseCards ? 10 : 14),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tone.withValues(alpha: 0.33)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Catalog tile ${index + 1}', style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(
                'PageStorageKey keeps this list\'s scroll position. Move to another panel, unmount the subtree, then remount to confirm restoration.',
                style: const TextStyle(height: 1.32),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FundamentalsTimelinePane extends StatelessWidget {
  const _FundamentalsTimelinePane();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey('fundamentals_timeline_scroll'),
      padding: const EdgeInsets.all(8),
      itemCount: 34,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final color = index.isEven ? _rose : _indigo;
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.32)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Timeline card demonstrating independent persistent scroll state for another panel using a distinct PageStorageKey.',
                  style: TextStyle(height: 1.3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FundamentalsChecklistPane extends StatefulWidget {
  const _FundamentalsChecklistPane();

  @override
  State<_FundamentalsChecklistPane> createState() => _FundamentalsChecklistPaneState();
}

class _FundamentalsChecklistPaneState extends State<_FundamentalsChecklistPane> {
  final List<bool> _checks = List<bool>.filled(18, false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey('fundamentals_checklist_scroll'),
      padding: const EdgeInsets.all(8),
      itemCount: _checks.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _indigo.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _indigo.withValues(alpha: 0.24)),
          ),
          child: Row(
            children: [
              Switch(
                value: _checks[index],
                onChanged: (v) => setState(() => _checks[index] = v),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Checklist item ${index + 1} | local state + persistent scroll key',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReadWriteConsoleScene extends StatefulWidget {
  const _ReadWriteConsoleScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_ReadWriteConsoleScene> createState() => _ReadWriteConsoleSceneState();
}

class _ReadWriteConsoleSceneState extends State<_ReadWriteConsoleScene> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<String> _events = <String>[];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  double _priority = 0.35;
  bool _pinned = false;
  bool _loaded = false;

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 920.0 : 1100.0;
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
                child: PageStorage(
                  bucket: _bucket,
                  child: Builder(
                    builder: (innerContext) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _SectionTitle('Read/Write Controls'),
                            const SizedBox(height: 8),
                            TextField(
                              key: const PageStorageKey('rw_title_field'),
                              controller: _titleController,
                              decoration: const InputDecoration(
                                labelText: 'Task title',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              key: const PageStorageKey('rw_notes_field'),
                              controller: _notesController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                labelText: 'Notes',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('Priority: ${_priority.toStringAsFixed(2)}'),
                            Slider(
                              value: _priority,
                              onChanged: (v) => setState(() => _priority = v),
                            ),
                            SwitchListTile(
                              value: _pinned,
                              onChanged: (v) => setState(() => _pinned = v),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Pinned'),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                FilledButton.tonal(
                                  onPressed: () => _save(innerContext),
                                  child: const Text('writeState() save'),
                                ),
                                FilledButton.tonal(
                                  onPressed: () => _load(innerContext),
                                  child: const Text('readState() load'),
                                ),
                                FilledButton.tonal(
                                  onPressed: () => _clear(innerContext),
                                  child: const Text('clear identifiers'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _FactTable(rows: [
                              _FactRow('loaded', '$_loaded'),
                              _FactRow('title length', '${_titleController.text.length}'),
                              _FactRow('notes length', '${_notesController.text.length}'),
                              _FactRow('priority', _priority.toStringAsFixed(2)),
                              _FactRow('pinned', '$_pinned'),
                            ]),
                            const SizedBox(height: 10),
                            if (widget.notes)
                              _InstructionCard(
                                tone: _jade,
                                lines: const [
                                  'writeState(context, data, identifier: key) persists any serializable-like value.',
                                  'readState(context, identifier: key) fetches saved value; null means not stored or explicitly cleared.',
                                  'Use stable identifiers to avoid collisions and keep each stored concern separate.',
                                ],
                              ),
                            const SizedBox(height: 10),
                            const _SectionTitle('Console timeline'),
                            const SizedBox(height: 6),
                            SizedBox(height: 220, child: _EventLog(lines: _events)),
                          ],
                        ),
                      );
                    },
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
                    const _SectionTitle('Live Preview + Identifier Buckets'),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _jade.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _jade.withValues(alpha: 0.24)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.edit_note, color: _jade),
                                      const SizedBox(width: 8),
                                      const Expanded(
                                        child: Text(
                                          'Draft Preview',
                                          style: TextStyle(color: _jade, fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      _ToneChip(tone: _jade, label: _loaded ? 'loaded' : 'live'),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _titleController.text.isEmpty ? 'Untitled' : _titleController.text,
                                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _notesController.text.isEmpty
                                        ? 'No notes yet. Use writeState() and readState() to persist/recover this panel.'
                                        : _notesController.text,
                                    style: const TextStyle(height: 1.35),
                                  ),
                                  const Spacer(),
                                  LinearProgressIndicator(
                                    value: _priority,
                                    minHeight: 10,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  const SizedBox(height: 6),
                                  Text('Pinned: ${_pinned ? 'yes' : 'no'}'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFD5E0EB)),
                              ),
                              child: ListView(
                                key: const PageStorageKey('rw_help_scroll'),
                                children: const [
                                  _HelpLine(
                                    title: 'Identifier: rw.title',
                                    body: 'Stores task title text.',
                                  ),
                                  _HelpLine(
                                    title: 'Identifier: rw.notes',
                                    body: 'Stores multi-line notes text.',
                                  ),
                                  _HelpLine(
                                    title: 'Identifier: rw.priority',
                                    body: 'Stores slider value as double.',
                                  ),
                                  _HelpLine(
                                    title: 'Identifier: rw.pinned',
                                    body: 'Stores bool toggle value.',
                                  ),
                                  _HelpLine(
                                    title: 'Guideline',
                                    body: 'Use namespaced identifiers in larger modules to avoid key collisions.',
                                  ),
                                ],
                              ),
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
        ],
      ),
    );
  }

  void _save(BuildContext context) {
    _bucket.writeState(context, _titleController.text, identifier: 'rw.title');
    _bucket.writeState(context, _notesController.text, identifier: 'rw.notes');
    _bucket.writeState(context, _priority, identifier: 'rw.priority');
    _bucket.writeState(context, _pinned, identifier: 'rw.pinned');
    setState(() => _loaded = true);
    _push('writeState saved 4 identifiers');
  }

  void _load(BuildContext context) {
    final loadedTitle = _bucket.readState(context, identifier: 'rw.title');
    final loadedNotes = _bucket.readState(context, identifier: 'rw.notes');
    final loadedPriority = _bucket.readState(context, identifier: 'rw.priority');
    final loadedPinned = _bucket.readState(context, identifier: 'rw.pinned');

    setState(() {
      _titleController.text = loadedTitle is String ? loadedTitle : '';
      _notesController.text = loadedNotes is String ? loadedNotes : '';
      _priority = loadedPriority is double ? loadedPriority : 0.35;
      _pinned = loadedPinned is bool ? loadedPinned : false;
      _loaded = true;
    });

    _push(
      'readState loaded title=${loadedTitle != null}, notes=${loadedNotes != null}, '
      'priority=${loadedPriority != null}, pinned=${loadedPinned != null}',
    );
  }

  void _clear(BuildContext context) {
    _bucket.writeState(context, null, identifier: 'rw.title');
    _bucket.writeState(context, null, identifier: 'rw.notes');
    _bucket.writeState(context, null, identifier: 'rw.priority');
    _bucket.writeState(context, null, identifier: 'rw.pinned');
    setState(() {
      _titleController.clear();
      _notesController.clear();
      _priority = 0.35;
      _pinned = false;
      _loaded = false;
    });
    _push('cleared 4 identifiers by writing null values');
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 60);
    });
  }
}

class _HelpLine extends StatelessWidget {
  const _HelpLine({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F8FD),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD6E5F3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: _ink)),
            const SizedBox(height: 4),
            Text(body, style: const TextStyle(height: 1.3)),
          ],
        ),
      ),
    );
  }
}

class _MultiBucketIsolationScene extends StatefulWidget {
  const _MultiBucketIsolationScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_MultiBucketIsolationScene> createState() => _MultiBucketIsolationSceneState();
}

class _MultiBucketIsolationSceneState extends State<_MultiBucketIsolationScene> {
  final PageStorageBucket _bucketA = PageStorageBucket();
  final PageStorageBucket _bucketB = PageStorageBucket();
  final List<String> _events = <String>[];

  String _activeWorkspace = 'A';
  bool _mountWorkspace = true;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 920.0 : 1100.0;
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
                      const _SectionTitle('Isolation Controls'),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'A', label: Text('Workspace A')),
                          ButtonSegment(value: 'B', label: Text('Workspace B')),
                        ],
                        selected: {_activeWorkspace},
                        onSelectionChanged: (values) {
                          final value = values.first;
                          setState(() => _activeWorkspace = value);
                          _push('switched to workspace $value');
                        },
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _mountWorkspace = !_mountWorkspace);
                              _push(_mountWorkspace ? 'mounted active workspace' : 'unmounted active workspace');
                            },
                            child: Text(_mountWorkspace ? 'Unmount active workspace' : 'Mount active workspace'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _activeWorkspace = _activeWorkspace == 'A' ? 'B' : 'A');
                              _push('quick toggle workspace');
                            },
                            child: const Text('Quick toggle A/B'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _FactTable(rows: [
                        _FactRow('active workspace', _activeWorkspace),
                        _FactRow('mounted', '$_mountWorkspace'),
                        _FactRow('bucket A hash', '${_bucketA.hashCode}'),
                        _FactRow('bucket B hash', '${_bucketB.hashCode}'),
                      ]),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'A bucket is an isolated persistence scope. Different bucket instances do not share values.',
                            'Reuse one bucket for continuity; replace bucket instance to intentionally reset scope.',
                            'Isolation is useful for independent tabs/workspaces with similarly keyed widgets.',
                          ],
                        ),
                      const SizedBox(height: 10),
                      const _SectionTitle('Isolation timeline'),
                      const SizedBox(height: 6),
                      SizedBox(height: 220, child: _EventLog(lines: _events)),
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
                    const _SectionTitle('Workspace visualization'),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _mountWorkspace
                          ? _WorkspaceSurface(
                              workspaceId: _activeWorkspace,
                              bucket: _activeWorkspace == 'A' ? _bucketA : _bucketB,
                            )
                          : const _UnmountedHint(
                              tone: _amber,
                              title: 'Workspace hidden',
                              description:
                                  'Mount again to verify that each workspace restores only its own persisted state from its own bucket.',
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

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 60);
    });
  }
}

class _WorkspaceSurface extends StatefulWidget {
  const _WorkspaceSurface({required this.workspaceId, required this.bucket});

  final String workspaceId;
  final PageStorageBucket bucket;

  @override
  State<_WorkspaceSurface> createState() => _WorkspaceSurfaceState();
}

class _WorkspaceSurfaceState extends State<_WorkspaceSurface> {
  bool _showInsight = true;

  @override
  Widget build(BuildContext context) {
    final tone = widget.workspaceId == 'A' ? _blue : _indigo;
    return Container(
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.24), width: 2),
      ),
      child: PageStorage(
        bucket: widget.bucket,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.14),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Icon(Icons.workspaces, color: tone),
                  const SizedBox(width: 8),
                  Text('Workspace ${widget.workspaceId}', style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Switch(
                    value: _showInsight,
                    onChanged: (v) => setState(() => _showInsight = v),
                  ),
                ],
              ),
            ),
            if (_showInsight)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'This panel reuses keys but a different bucket instance when workspace changes.',
                  style: TextStyle(color: tone, fontWeight: FontWeight.w700),
                ),
              ),
            Expanded(
              child: ListView.builder(
                key: const PageStorageKey('isolation_shared_scroll_key'),
                padding: const EdgeInsets.all(8),
                itemCount: 24,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tone.withValues(alpha: 0.11),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: tone.withValues(alpha: 0.28)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(color: tone, borderRadius: BorderRadius.circular(6)),
                          alignment: Alignment.center,
                          child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Shared key list item ${index + 1}. Bucket isolation ensures workspace-specific persisted scroll positions.',
                            style: const TextStyle(height: 1.3),
                          ),
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
    );
  }
}

class _RouteLikePersistenceScene extends StatefulWidget {
  const _RouteLikePersistenceScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_RouteLikePersistenceScene> createState() => _RouteLikePersistenceSceneState();
}

class _RouteLikePersistenceSceneState extends State<_RouteLikePersistenceScene> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<String> _events = <String>[];
  int _routeIndex = 0;

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
                child: PageStorage(
                  bucket: _bucket,
                  child: Builder(
                    builder: (innerContext) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _SectionTitle('Route Controls'),
                            const SizedBox(height: 8),
                            SegmentedButton<int>(
                              segments: const [
                                ButtonSegment(value: 0, label: Text('Route A')),
                                ButtonSegment(value: 1, label: Text('Route B')),
                                ButtonSegment(value: 2, label: Text('Route C')),
                              ],
                              selected: {_routeIndex},
                              onSelectionChanged: (values) {
                                final value = values.first;
                                setState(() => _routeIndex = value);
                                _push('switched route to $value');
                              },
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                FilledButton.tonal(
                                  onPressed: () => _saveRouteLabel(innerContext),
                                  child: const Text('write route label'),
                                ),
                                FilledButton.tonal(
                                  onPressed: () => _readRouteLabel(innerContext),
                                  child: const Text('read route label'),
                                ),
                                FilledButton.tonal(
                                  onPressed: () => _clearRouteLabel(innerContext),
                                  child: const Text('clear route label'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _FactTable(rows: [
                              _FactRow('active route', '$_routeIndex'),
                              _FactRow('bucket hash', '${_bucket.hashCode}'),
                              _FactRow('events', '${_events.length}'),
                            ]),
                            const SizedBox(height: 10),
                            if (widget.notes)
                              _InstructionCard(
                                tone: _rose,
                                lines: const [
                                  'PageStorage often appears in tab/route-like contexts where content is swapped by index.',
                                  'Each route page should use unique keys so their persisted values do not overlap.',
                                  'You can combine key-based persistence and explicit writeState/readState in one bucket.',
                                ],
                              ),
                            const SizedBox(height: 10),
                            const _SectionTitle('Route timeline'),
                            const SizedBox(height: 6),
                            SizedBox(height: 220, child: _EventLog(lines: _events)),
                          ],
                        ),
                      );
                    },
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
                    const _SectionTitle('Simulated Route Body'),
                    const SizedBox(height: 8),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 320),
                        child: _RoutePane(
                          key: ValueKey<int>(_routeIndex),
                          routeIndex: _routeIndex,
                          bucket: _bucket,
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

  void _saveRouteLabel(BuildContext context) {
    _bucket.writeState(context, 'Route-${_routeIndex + 1}-label', identifier: 'route.label.$_routeIndex');
    _push('saved route label for route $_routeIndex');
  }

  void _readRouteLabel(BuildContext context) {
    final value = _bucket.readState(context, identifier: 'route.label.$_routeIndex');
    _push('loaded route label for route $_routeIndex => $value');
  }

  void _clearRouteLabel(BuildContext context) {
    _bucket.writeState(context, null, identifier: 'route.label.$_routeIndex');
    _push('cleared route label for route $_routeIndex');
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 60);
    });
  }
}

class _RoutePane extends StatefulWidget {
  const _RoutePane({super.key, required this.routeIndex, required this.bucket});

  final int routeIndex;
  final PageStorageBucket bucket;

  @override
  State<_RoutePane> createState() => _RoutePaneState();
}

class _RoutePaneState extends State<_RoutePane> {
  late final TextEditingController _draftController;

  @override
  void initState() {
    super.initState();
    _draftController = TextEditingController();
  }

  @override
  void dispose() {
    _draftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tone = widget.routeIndex == 0
        ? _rose
        : widget.routeIndex == 1
            ? _amber
            : _indigo;
    final routeName = switch (widget.routeIndex) {
      0 => 'Route A',
      1 => 'Route B',
      _ => 'Route C',
    };

    return Container(
      key: PageStorageKey('route-pane-${widget.routeIndex}'),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.26), width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.16),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Icon(Icons.route, color: tone),
                const SizedBox(width: 8),
                Text(routeName, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          Expanded(
            child: PageStorage(
              bucket: widget.bucket,
              child: Builder(
                builder: (innerContext) {
                  return ListView(
                    key: PageStorageKey('route-scroll-${widget.routeIndex}'),
                    padding: const EdgeInsets.all(10),
                    children: [
                      TextField(
                        key: PageStorageKey('route-field-${widget.routeIndex}'),
                        controller: _draftController,
                        decoration: InputDecoration(
                          labelText: '$routeName draft text',
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          widget.bucket.writeState(
                            innerContext,
                            text,
                            identifier: 'route-draft-${widget.routeIndex}',
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {
                              widget.bucket.writeState(
                                innerContext,
                                _draftController.text,
                                identifier: 'route-draft-${widget.routeIndex}',
                              );
                            },
                            child: const Text('Save draft'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              final loaded = widget.bucket.readState(
                                innerContext,
                                identifier: 'route-draft-${widget.routeIndex}',
                              );
                              if (loaded is String) {
                                setState(() => _draftController.text = loaded);
                              }
                            },
                            child: const Text('Load draft'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(
                        18,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: tone.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: tone.withValues(alpha: 0.24)),
                          ),
                          child: Text(
                            '$routeName section ${index + 1} | list scroll is persisted via PageStorageKey.',
                            style: const TextStyle(height: 1.3),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticalModulesScene extends StatefulWidget {
  const _PracticalModulesScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_PracticalModulesScene> createState() => _PracticalModulesSceneState();
}

class _PracticalModulesSceneState extends State<_PracticalModulesScene> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1080.0 : 1280.0;
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
                child: PageStorage(
                  bucket: _bucket,
                  child: Row(
                    children: [
                      Expanded(
                        child: _FilterModule(
                          bucket: _bucket,
                          onEvent: (event) => _push('filters: $event'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _DraftModule(
                          bucket: _bucket,
                          onEvent: (event) => _push('drafts: $event'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _ProgressModule(
                          bucket: _bucket,
                          onEvent: (event) => _push('progress: $event'),
                        ),
                      ),
                    ],
                  ),
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
                    const _SectionTitle('Practical Notes'),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _indigo,
                        lines: const [
                          'PageStorageBucket is lightweight and in-memory. Use it for page UX continuity, not durable app storage.',
                          'Prefer clear identifier naming (module.scope.value) for maintainability in large screens.',
                          'Use one bucket per scope boundary: route, tab shell, or nested workspace.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _FactTable(rows: [
                      _FactRow('bucket hash', '${_bucket.hashCode}'),
                      _FactRow('event count', '${_events.length}'),
                      _FactRow('time', _clock()),
                    ]),
                    const SizedBox(height: 8),
                    const _SectionTitle('Module timeline'),
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

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 70);
    });
  }
}

class _FilterModule extends StatefulWidget {
  const _FilterModule({required this.bucket, required this.onEvent});

  final PageStorageBucket bucket;
  final ValueChanged<String> onEvent;

  @override
  State<_FilterModule> createState() => _FilterModuleState();
}

class _FilterModuleState extends State<_FilterModule> {
  final Set<String> _selected = <String>{};
  static const _tags = ['Bug', 'Feature', 'Urgent', 'UX', 'Infra', 'Docs', 'Release'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _blue.withValues(alpha: 0.3)),
      ),
      child: Builder(
        builder: (innerContext) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.filter_alt_outlined, color: _blue, size: 20),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text('Filter Module', style: TextStyle(color: _blue, fontWeight: FontWeight.w800)),
                  ),
                  _ToneChip(tone: _blue, label: '${_selected.length} tags'),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _tags.map((tag) {
                  final chosen = _selected.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: chosen,
                    onSelected: (v) {
                      setState(() {
                        if (v) {
                          _selected.add(tag);
                        } else {
                          _selected.remove(tag);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      widget.bucket.writeState(innerContext, _selected.toList(), identifier: 'module.filters.tags');
                      widget.onEvent('saved ${_selected.length} tags');
                    },
                    child: const Text('Save filters'),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      final loaded = widget.bucket.readState(innerContext, identifier: 'module.filters.tags');
                      if (loaded is List) {
                        setState(() {
                          _selected
                            ..clear()
                            ..addAll(loaded.whereType<String>());
                        });
                        widget.onEvent('loaded ${_selected.length} tags');
                      }
                    },
                    child: const Text('Load filters'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  key: const PageStorageKey('module_filter_scroll'),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _blue.withValues(alpha: 0.22)),
                      ),
                      child: Text('Filtered row ${index + 1}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DraftModule extends StatefulWidget {
  const _DraftModule({required this.bucket, required this.onEvent});

  final PageStorageBucket bucket;
  final ValueChanged<String> onEvent;

  @override
  State<_DraftModule> createState() => _DraftModuleState();
}

class _DraftModuleState extends State<_DraftModule> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _jade.withValues(alpha: 0.3)),
      ),
      child: Builder(
        builder: (innerContext) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.sticky_note_2_outlined, color: _jade, size: 20),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text('Draft Module', style: TextStyle(color: _jade, fontWeight: FontWeight.w800)),
                  ),
                  _ToneChip(tone: _jade, label: '2 fields'),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                key: const PageStorageKey('draft_field_a_key'),
                controller: _controllerA,
                decoration: const InputDecoration(labelText: 'Draft A', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              TextField(
                key: const PageStorageKey('draft_field_b_key'),
                controller: _controllerB,
                decoration: const InputDecoration(labelText: 'Draft B', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      widget.bucket.writeState(innerContext, _controllerA.text, identifier: 'module.draft.a');
                      widget.bucket.writeState(innerContext, _controllerB.text, identifier: 'module.draft.b');
                      widget.onEvent('saved drafts');
                    },
                    child: const Text('Save drafts'),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      final a = widget.bucket.readState(innerContext, identifier: 'module.draft.a');
                      final b = widget.bucket.readState(innerContext, identifier: 'module.draft.b');
                      setState(() {
                        _controllerA.text = a is String ? a : '';
                        _controllerB.text = b is String ? b : '';
                      });
                      widget.onEvent('loaded drafts');
                    },
                    child: const Text('Load drafts'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  key: const PageStorageKey('module_draft_scroll'),
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _jade.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _jade.withValues(alpha: 0.22)),
                      ),
                      child: Text('Draft context row ${index + 1}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProgressModule extends StatefulWidget {
  const _ProgressModule({required this.bucket, required this.onEvent});

  final PageStorageBucket bucket;
  final ValueChanged<String> onEvent;

  @override
  State<_ProgressModule> createState() => _ProgressModuleState();
}

class _ProgressModuleState extends State<_ProgressModule> {
  double _analysis = 0.2;
  double _implementation = 0.55;
  double _validation = 0.7;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _indigo.withValues(alpha: 0.3)),
      ),
      child: Builder(
        builder: (innerContext) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.timeline, color: _indigo, size: 20),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text('Progress Module', style: TextStyle(color: _indigo, fontWeight: FontWeight.w800)),
                  ),
                  _ToneChip(tone: _indigo, label: '3 tracks'),
                ],
              ),
              const SizedBox(height: 8),
              _ProgressTrack(
                label: 'Analysis',
                value: _analysis,
                onChanged: (v) => setState(() => _analysis = v),
              ),
              _ProgressTrack(
                label: 'Implementation',
                value: _implementation,
                onChanged: (v) => setState(() => _implementation = v),
              ),
              _ProgressTrack(
                label: 'Validation',
                value: _validation,
                onChanged: (v) => setState(() => _validation = v),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      widget.bucket.writeState(innerContext, _analysis, identifier: 'module.progress.analysis');
                      widget.bucket.writeState(innerContext, _implementation, identifier: 'module.progress.implementation');
                      widget.bucket.writeState(innerContext, _validation, identifier: 'module.progress.validation');
                      widget.onEvent('saved progress tracks');
                    },
                    child: const Text('Save progress'),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      final a = widget.bucket.readState(innerContext, identifier: 'module.progress.analysis');
                      final i = widget.bucket.readState(innerContext, identifier: 'module.progress.implementation');
                      final v = widget.bucket.readState(innerContext, identifier: 'module.progress.validation');
                      setState(() {
                        _analysis = a is double ? a : _analysis;
                        _implementation = i is double ? i : _implementation;
                        _validation = v is double ? v : _validation;
                      });
                      widget.onEvent('loaded progress tracks');
                    },
                    child: const Text('Load progress'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  key: const PageStorageKey('module_progress_scroll'),
                  children: [
                    _ProgressTile(label: 'Analysis lane', value: _analysis, color: _indigo),
                    _ProgressTile(label: 'Implementation lane', value: _implementation, color: _jade),
                    _ProgressTile(label: 'Validation lane', value: _validation, color: _amber),
                    const SizedBox(height: 8),
                    const Text(
                      'This module combines explicit bucket persistence and key-based list scroll persistence.',
                      style: TextStyle(height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProgressTrack extends StatelessWidget {
  const _ProgressTrack({required this.label, required this.value, required this.onChanged});

  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${(value * 100).round()}%'),
        Slider(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _ProgressTile extends StatelessWidget {
  const _ProgressTile({required this.label, required this.value, required this.color});

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: value,
            minHeight: 10,
            borderRadius: BorderRadius.circular(999),
          ),
        ],
      ),
    );
  }
}

class _UnmountedHint extends StatelessWidget {
  const _UnmountedHint({required this.tone, required this.title, required this.description});

  final Color tone;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.26), width: 2),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.layers_clear, size: 34, color: tone),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 20)),
            const SizedBox(height: 6),
            Text(description, textAlign: TextAlign.center, style: const TextStyle(height: 1.35)),
          ],
        ),
      ),
    );
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
    final paint = Paint()..color = const Color(0x12000000);
    const step = 22.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: const TextStyle(fontWeight: FontWeight.w800));
  }
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
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(row.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                    Expanded(child: Text(row.value, style: const TextStyle(fontSize: 12))),
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
                    Expanded(
                      child: Text(
                        line,
                        style: const TextStyle(color: Color(0xFFEAF6FF), height: 1.35),
                      ),
                    ),
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
              key: const PageStorageKey('event_log_scroll'),
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    lines[index],
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                  ),
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
        color: const Color(0xFF1A3550),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: PageStorageBucket', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'PageStorageBucket provides in-memory page-scoped persistence. Use it with PageStorage + PageStorageKey to '
            'automatically preserve list positions and lightweight widget state, or call writeState/readState for explicit data entries. '
            'It is ideal for tab/route continuity and temporary UI context restoration.',
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
