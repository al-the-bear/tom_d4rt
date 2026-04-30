import 'package:flutter/material.dart';

const _canvas = Color(0xFFF4F7FC);
const _ink = Color(0xFF1E3957);
const _cobalt = Color(0xFF2E6EA7);
const _mint = Color(0xFF2E866B);
const _amber = Color(0xFFB38432);
const _rose = Color(0xFF9D5E78);
const _violet = Color(0xFF615AB4);

dynamic build(BuildContext context) {
  return const _PageStorageDeepDemoApp();
}

class _PageStorageDeepDemoApp extends StatelessWidget {
  const _PageStorageDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cobalt),
        scaffoldBackgroundColor: _canvas,
      ),
      home: const _PageStorageDeepDemoPage(),
    );
  }
}

class _PageStorageDeepDemoPage extends StatefulWidget {
  const _PageStorageDeepDemoPage();

  @override
  State<_PageStorageDeepDemoPage> createState() => _PageStorageDeepDemoPageState();
}

class _PageStorageDeepDemoPageState extends State<_PageStorageDeepDemoPage> {
  bool _compact = false;
  bool _guides = true;
  bool _notes = true;
  bool _dense = false;

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
            const Text('PageStorage Deep Demo'),
            Text(
              'scope-aware persistence | keys + PageStorage.of/maybeOf',
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
            _HeaderDeck(
              compact: _compact,
              guides: _guides,
              notes: _notes,
              dense: _dense,
              onCompactChanged: (v) => setState(() => _compact = v),
              onGuidesChanged: (v) => setState(() => _guides = v),
              onNotesChanged: (v) => setState(() => _notes = v),
              onDenseChanged: (v) => setState(() => _dense = v),
            ),
            const SizedBox(height: 12),
            _DemoSectionShell(
              index: 1,
              tone: _cobalt,
              title: 'PageStorage Scope Studio',
              subtitle:
                  'Compare views inside and outside PageStorage to understand persistence boundaries. '
                  'Demonstrates preserved scroll offsets and transient state when subtree is remounted.',
              child: _ScopeStudioScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
                dense: _dense,
              ),
            ),
            const SizedBox(height: 12),
            _DemoSectionShell(
              index: 2,
              tone: _mint,
              title: 'Bucket Access Lab (of/maybeOf)',
              subtitle:
                  'Probe contexts with PageStorage.of(context) and PageStorage.maybeOf(context), '
                  'visualizing where a bucket exists and where it does not.',
              child: _AccessLabScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
              ),
            ),
            const SizedBox(height: 12),
            _DemoSectionShell(
              index: 3,
              tone: _amber,
              title: 'Keyed Scroll Gallery',
              subtitle:
                  'Three galleries with independent PageStorageKey values preserve scroll offsets across tab switches and mount cycles.',
              child: _KeyedScrollGalleryScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
              ),
            ),
            const SizedBox(height: 12),
            _DemoSectionShell(
              index: 4,
              tone: _rose,
              title: 'Lifecycle Swap Workshop',
              subtitle:
                  'Route-like pane swapping with shared PageStorage demonstrates continuity of drafts, toggles, and list position.',
              child: _LifecycleSwapScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
              ),
            ),
            const SizedBox(height: 12),
            _DemoSectionShell(
              index: 5,
              tone: _violet,
              title: 'Practical Use Cases Board',
              subtitle:
                  'Filter rail, draft pad, and progress lanes show PageStorage usage in realistic interaction-heavy UI modules.',
              child: _PracticalBoardScene(
                compact: _compact,
                guides: _guides,
                notes: _notes,
              ),
            ),
            const SizedBox(height: 12),
            const _SummaryCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _HeaderDeck extends StatelessWidget {
  const _HeaderDeck({
    required this.compact,
    required this.guides,
    required this.notes,
    required this.dense,
    required this.onCompactChanged,
    required this.onGuidesChanged,
    required this.onNotesChanged,
    required this.onDenseChanged,
  });

  final bool compact;
  final bool guides;
  final bool notes;
  final bool dense;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuidesChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onDenseChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF203A58), Color(0xFF2E6EA7), Color(0xFF2E866B), Color(0xFF615AB4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PageStorage Control Deck',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'PageStorage is a widget that exposes a PageStorageBucket to descendants. '
            'Widgets with PageStorageKey can persist values (notably scroll positions), and '
            'you can also persist custom values via PageStorage.of(context).writeState/readState.',
            style: TextStyle(color: Color(0xFFDDEBF7), height: 1.35),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _DeckToggle(label: 'Compact scenes', value: compact, onChanged: onCompactChanged),
              _DeckToggle(label: 'Guide overlays', value: guides, onChanged: onGuidesChanged),
              _DeckToggle(label: 'Instruction notes', value: notes, onChanged: onNotesChanged),
              _DeckToggle(label: 'Dense cards', value: dense, onChanged: onDenseChanged),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeckToggle extends StatelessWidget {
  const _DeckToggle({required this.label, required this.value, required this.onChanged});

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(value: value, onChanged: onChanged, activeThumbColor: Colors.white),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _DemoSectionShell extends StatelessWidget {
  const _DemoSectionShell({
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

class _ScopeStudioScene extends StatefulWidget {
  const _ScopeStudioScene({
    required this.compact,
    required this.guides,
    required this.notes,
    required this.dense,
  });

  final bool compact;
  final bool guides;
  final bool notes;
  final bool dense;

  @override
  State<_ScopeStudioScene> createState() => _ScopeStudioSceneState();
}

class _ScopeStudioSceneState extends State<_ScopeStudioScene> {
  PageStorageBucket _bucket = PageStorageBucket();
  bool _mountInside = true;
  bool _mountOutside = true;
  int _insideTab = 0;
  int _outsideTab = 0;
  final List<String> _trace = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1160.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _MiniTitle('Scope Controls'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _mountInside = !_mountInside);
                              _log(_mountInside ? 'mounted INSIDE scope' : 'unmounted INSIDE scope');
                            },
                            child: Text(_mountInside ? 'Unmount inside scope' : 'Mount inside scope'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _mountOutside = !_mountOutside);
                              _log(_mountOutside ? 'mounted OUTSIDE scope' : 'unmounted OUTSIDE scope');
                            },
                            child: Text(_mountOutside ? 'Unmount outside scope' : 'Mount outside scope'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _bucket = PageStorageBucket());
                              _log('reset inside PageStorage bucket');
                            },
                            child: const Text('Reset inside bucket'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _DataTable(rows: [
                        _DataRow('inside mounted', '$_mountInside'),
                        _DataRow('outside mounted', '$_mountOutside'),
                        _DataRow('inside tab', '$_insideTab'),
                        _DataRow('outside tab', '$_outsideTab'),
                        _DataRow('inside bucket hash', '${_bucket.hashCode}'),
                      ]),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _BulletCard(
                          tone: _cobalt,
                          lines: const [
                            'Only descendants of PageStorage can resolve PageStorage.of(context).',
                            'Keyed scrollables inside that scope can restore positions after rebuild/remount.',
                            'Widgets outside scope lose state unless they maintain it independently.',
                          ],
                        ),
                      const SizedBox(height: 10),
                      const _MiniTitle('Scope Trace'),
                      const SizedBox(height: 6),
                      SizedBox(height: 230, child: _TracePanel(lines: _trace)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _ScopeColumn(
                        title: 'Inside PageStorage scope',
                        tone: _cobalt,
                        mounted: _mountInside,
                        onTabChanged: (v) {
                          setState(() => _insideTab = v);
                          _log('inside scope tab -> $v');
                        },
                        tabIndex: _insideTab,
                        wrapped: true,
                        bucket: _bucket,
                        dense: widget.dense,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ScopeColumn(
                        title: 'Outside PageStorage scope',
                        tone: _amber,
                        mounted: _mountOutside,
                        onTabChanged: (v) {
                          setState(() => _outsideTab = v);
                          _log('outside scope tab -> $v');
                        },
                        tabIndex: _outsideTab,
                        wrapped: false,
                        bucket: null,
                        dense: widget.dense,
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

  void _log(String message) {
    setState(() {
      _trace.insert(0, '${_stamp()} | $message');
      _cap(_trace, 70);
    });
  }
}

class _ScopeColumn extends StatelessWidget {
  const _ScopeColumn({
    required this.title,
    required this.tone,
    required this.mounted,
    required this.onTabChanged,
    required this.tabIndex,
    required this.wrapped,
    required this.bucket,
    required this.dense,
  });

  final String title;
  final Color tone;
  final bool mounted;
  final ValueChanged<int> onTabChanged;
  final int tabIndex;
  final bool wrapped;
  final PageStorageBucket? bucket;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (!mounted) {
      body = _MutedEmptyCard(
        tone: tone,
        title: 'Subtree unmounted',
        body: 'Mount again and compare whether list offsets were restored.',
      );
    } else {
      body = _ScopePaneBody(
        tone: tone,
        tabIndex: tabIndex,
        onTabChanged: onTabChanged,
        dense: dense,
        keyPrefix: wrapped ? 'inside' : 'outside',
      );
    }

    if (wrapped && bucket != null && mounted) {
      body = PageStorage(bucket: bucket!, child: body);
    }

    return Container(
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.25), width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Icon(Icons.layers, color: tone),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: tone, fontWeight: FontWeight.w800),
                  ),
                ),
                _ToneBadge(tone: tone, text: wrapped ? 'PageStorage ON' : 'PageStorage OFF'),
              ],
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}

class _ScopePaneBody extends StatefulWidget {
  const _ScopePaneBody({
    required this.tone,
    required this.tabIndex,
    required this.onTabChanged,
    required this.dense,
    required this.keyPrefix,
  });

  final Color tone;
  final int tabIndex;
  final ValueChanged<int> onTabChanged;
  final bool dense;
  final String keyPrefix;

  @override
  State<_ScopePaneBody> createState() => _ScopePaneBodyState();
}

class _ScopePaneBodyState extends State<_ScopePaneBody> {
  bool _flagA = false;
  bool _flagB = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('Catalog')),
              ButtonSegment(value: 1, label: Text('Timeline')),
              ButtonSegment(value: 2, label: Text('Checklist')),
            ],
            selected: {widget.tabIndex},
            onSelectionChanged: (values) => widget.onTabChanged(values.first),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: _flagA,
                  onChanged: (v) => setState(() => _flagA = v),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Flag A'),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: _flagB,
                  onChanged: (v) => setState(() => _flagB = v),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Flag B'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: IndexedStack(
              index: widget.tabIndex,
              children: [
                _PaneList(
                  key: PageStorageKey('${widget.keyPrefix}.catalog.scroll'),
                  tone: widget.tone,
                  dense: widget.dense,
                  titlePrefix: 'Catalog',
                ),
                _PaneList(
                  key: PageStorageKey('${widget.keyPrefix}.timeline.scroll'),
                  tone: widget.tone,
                  dense: widget.dense,
                  titlePrefix: 'Timeline',
                ),
                _PaneList(
                  key: PageStorageKey('${widget.keyPrefix}.checklist.scroll'),
                  tone: widget.tone,
                  dense: widget.dense,
                  titlePrefix: 'Checklist',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaneList extends StatelessWidget {
  const _PaneList({
    super.key,
    required this.tone,
    required this.dense,
    required this.titlePrefix,
  });

  final Color tone;
  final bool dense;
  final String titlePrefix;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: key,
      children: [
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 1', body: 'Scroll down, switch tab, and return.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 2', body: 'This pane uses a stable PageStorageKey.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 3', body: 'Values are bucket-scoped, not global.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 4', body: 'Inside scope should restore offsets.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 5', body: 'Outside scope often restarts positions.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 6', body: 'Try unmounting and remounting each side.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 7', body: 'Reset inside bucket to wipe remembered data.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 8', body: 'Keep keys unique per scrollable branch.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 9', body: 'Use explicit write/read for custom values.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 10', body: 'PageStorage is in-memory UX continuity.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 11', body: 'Useful for tabs, shells, and routes.'),
        _PaneCard(tone: tone, dense: dense, title: '$titlePrefix card 12', body: 'Not a replacement for permanent storage.'),
      ],
    );
  }
}

class _PaneCard extends StatelessWidget {
  const _PaneCard({required this.tone, required this.dense, required this.title, required this.body});

  final Color tone;
  final bool dense;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(dense ? 9 : 13),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.26)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(height: 1.3)),
        ],
      ),
    );
  }
}

class _AccessLabScene extends StatefulWidget {
  const _AccessLabScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_AccessLabScene> createState() => _AccessLabSceneState();
}

class _AccessLabSceneState extends State<_AccessLabScene> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<String> _trace = <String>[];
  final TextEditingController _fieldController = TextEditingController();
  String _lastRead = '(none)';

  @override
  void dispose() {
    _fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 900.0 : 1080.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _MiniTitle('Context Probe Controls'),
                      const SizedBox(height: 8),
                      _DataTable(rows: [
                        _DataRow('bucket hash', '${_bucket.hashCode}'),
                        _DataRow('trace lines', '${_trace.length}'),
                        _DataRow('last read value', _lastRead),
                      ]),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _BulletCard(
                          tone: _mint,
                          lines: const [
                            'PageStorage.maybeOf(context) returns null if no PageStorage ancestor exists.',
                            'PageStorage.of(context) throws if missing; use it when you require a guaranteed scope.',
                            'Use nested Builder to capture context exactly where probe should run.',
                          ],
                        ),
                      const SizedBox(height: 10),
                      const _MiniTitle('Probe Trace'),
                      const SizedBox(height: 6),
                      SizedBox(height: 220, child: _TracePanel(lines: _trace)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _ProbeColumn(
                        title: 'Inside PageStorage',
                        tone: _mint,
                        child: PageStorage(
                          bucket: _bucket,
                          child: Builder(
                            builder: (insideContext) {
                              return _ProbeBody(
                                tone: _mint,
                                controller: _fieldController,
                                onMaybeProbe: () => _runProbe('inside maybeOf', insideContext, force: false),
                                onForceProbe: () => _runProbe('inside of', insideContext, force: true),
                                onWrite: () {
                                  PageStorage.of(insideContext).writeState(
                                    insideContext,
                                    _fieldController.text,
                                    identifier: 'access.lab.text',
                                  );
                                  _append('inside writeState access.lab.text');
                                },
                                onRead: () {
                                  final value = PageStorage.of(insideContext).readState(
                                    insideContext,
                                    identifier: 'access.lab.text',
                                  );
                                  setState(() => _lastRead = '$value');
                                  _append('inside readState access.lab.text -> $value');
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ProbeColumn(
                        title: 'Outside PageStorage',
                        tone: _amber,
                        child: Builder(
                          builder: (outsideContext) {
                            return _ProbeBody(
                              tone: _amber,
                              controller: _fieldController,
                              onMaybeProbe: () => _runProbe('outside maybeOf', outsideContext, force: false),
                              onForceProbe: () => _runProbe('outside of', outsideContext, force: true),
                              onWrite: () => _append('outside write attempt skipped (no guaranteed scope)'),
                              onRead: () => _append('outside read attempt skipped (no guaranteed scope)'),
                            );
                          },
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

  void _runProbe(String label, BuildContext context, {required bool force}) {
    if (!force) {
      final bucket = PageStorage.maybeOf(context);
      _append('$label -> ${bucket == null ? 'null' : 'bucket(${bucket.hashCode})'}');
      return;
    }
    try {
      final bucket = PageStorage.of(context);
      _append('$label -> bucket(${bucket.hashCode})');
    } catch (error) {
      _append('$label threw -> $error');
    }
  }

  void _append(String line) {
    setState(() {
      _trace.insert(0, '${_stamp()} | $line');
      _cap(_trace, 80);
    });
  }
}

class _ProbeColumn extends StatelessWidget {
  const _ProbeColumn({required this.title, required this.tone, required this.child});

  final String title;
  final Color tone;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.25), width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: tone),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: tone, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Padding(padding: const EdgeInsets.all(8), child: child)),
        ],
      ),
    );
  }
}

class _ProbeBody extends StatelessWidget {
  const _ProbeBody({
    required this.tone,
    required this.controller,
    required this.onMaybeProbe,
    required this.onForceProbe,
    required this.onWrite,
    required this.onRead,
  });

  final Color tone;
  final TextEditingController controller;
  final VoidCallback onMaybeProbe;
  final VoidCallback onForceProbe;
  final VoidCallback onWrite;
  final VoidCallback onRead;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          key: const PageStorageKey('access.field'),
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Shared text payload',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.tonal(onPressed: onMaybeProbe, child: const Text('maybeOf(context)')),
            FilledButton.tonal(onPressed: onForceProbe, child: const Text('of(context)')),
            FilledButton.tonal(onPressed: onWrite, child: const Text('writeState')), 
            FilledButton.tonal(onPressed: onRead, child: const Text('readState')), 
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView(
            key: PageStorageKey('probe.preview.$tone'),
            children: [
              _SmallGuidanceTile(
                tone: tone,
                title: 'Probe result interpretation',
                body: 'null from maybeOf means no PageStorage in ancestor chain.',
              ),
              _SmallGuidanceTile(
                tone: tone,
                title: 'of() behavior',
                body: 'Use when scope is required and absence should be treated as programming error.',
              ),
              _SmallGuidanceTile(
                tone: tone,
                title: 'Nested contexts',
                body: 'Builder helps obtain a context inside specific widget branches.',
              ),
              _SmallGuidanceTile(
                tone: tone,
                title: 'State strategy',
                body: 'PageStorage works best for page/session continuity, not long-term persistence.',
              ),
              _SmallGuidanceTile(
                tone: tone,
                title: 'Key strategy',
                body: 'Stable identifiers and key namespaces reduce collisions in large screens.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SmallGuidanceTile extends StatelessWidget {
  const _SmallGuidanceTile({required this.tone, required this.title, required this.body});

  final Color tone;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(height: 1.3)),
        ],
      ),
    );
  }
}

class _KeyedScrollGalleryScene extends StatefulWidget {
  const _KeyedScrollGalleryScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_KeyedScrollGalleryScene> createState() => _KeyedScrollGallerySceneState();
}

class _KeyedScrollGallerySceneState extends State<_KeyedScrollGalleryScene> {
  PageStorageBucket _bucket = PageStorageBucket();
  int _tab = 0;
  bool _mounted = true;
  final List<String> _trace = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1160.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _MiniTitle('Gallery Controls'),
                      const SizedBox(height: 8),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Discover')),
                          ButtonSegment(value: 1, label: Text('Archive')),
                          ButtonSegment(value: 2, label: Text('Compare')),
                        ],
                        selected: {_tab},
                        onSelectionChanged: (values) {
                          final value = values.first;
                          setState(() => _tab = value);
                          _log('switched gallery tab -> $value');
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
                              _log(_mounted ? 'mounted gallery subtree' : 'unmounted gallery subtree');
                            },
                            child: Text(_mounted ? 'Unmount gallery' : 'Mount gallery'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _bucket = PageStorageBucket());
                              _log('reset gallery bucket');
                            },
                            child: const Text('Reset gallery bucket'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _DataTable(rows: [
                        _DataRow('tab', '$_tab'),
                        _DataRow('mounted', '$_mounted'),
                        _DataRow('bucket hash', '${_bucket.hashCode}'),
                        _DataRow('trace entries', '${_trace.length}'),
                      ]),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _BulletCard(
                          tone: _amber,
                          lines: const [
                            'Each gallery list has a unique PageStorageKey tied to its role.',
                            'Switch tabs and return to verify independent offset restoration.',
                            'Resetting the bucket invalidates previously persisted list positions.',
                          ],
                        ),
                      const SizedBox(height: 10),
                      const _MiniTitle('Gallery Trace'),
                      const SizedBox(height: 6),
                      SizedBox(height: 220, child: _TracePanel(lines: _trace)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _mounted
                    ? PageStorage(
                        bucket: _bucket,
                        child: _GalleryBody(tab: _tab),
                      )
                    : const _MutedEmptyCard(
                        tone: _amber,
                        title: 'Gallery unmounted',
                        body: 'Remount and verify restoration in each keyed list pane.',
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _log(String line) {
    setState(() {
      _trace.insert(0, '${_stamp()} | $line');
      _cap(_trace, 70);
    });
  }
}

class _GalleryBody extends StatelessWidget {
  const _GalleryBody({required this.tab});

  final int tab;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _amber.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _amber.withValues(alpha: 0.24)),
          ),
          child: Text(
            switch (tab) {
              0 => 'Discover: broad card feed with preserved position',
              1 => 'Archive: denser list preserving independent offset',
              _ => 'Compare: side-by-side notes and cards preserving offset',
            },
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: IndexedStack(
            index: tab,
            children: const [
              _DiscoverGalleryPane(),
              _ArchiveGalleryPane(),
              _CompareGalleryPane(),
            ],
          ),
        ),
      ],
    );
  }
}

class _DiscoverGalleryPane extends StatelessWidget {
  const _DiscoverGalleryPane();

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('gallery.discover.scroll'),
      children: const [
        _GalleryCard(title: 'Discover 1', body: 'Experiment board for layout states.'),
        _GalleryCard(title: 'Discover 2', body: 'Widget previews with dynamic controls.'),
        _GalleryCard(title: 'Discover 3', body: 'A/B card alternatives for onboarding.'),
        _GalleryCard(title: 'Discover 4', body: 'Color and contrast trial combinations.'),
        _GalleryCard(title: 'Discover 5', body: 'Content hierarchy prototypes.'),
        _GalleryCard(title: 'Discover 6', body: 'Performance-safe visual arrangements.'),
        _GalleryCard(title: 'Discover 7', body: 'Navigation hints and sticky affordances.'),
        _GalleryCard(title: 'Discover 8', body: 'Interactive state transitions samples.'),
        _GalleryCard(title: 'Discover 9', body: 'Microcopy framing options.'),
        _GalleryCard(title: 'Discover 10', body: 'Spacing rhythm experiments.'),
        _GalleryCard(title: 'Discover 11', body: 'Action density prototypes.'),
        _GalleryCard(title: 'Discover 12', body: 'Component grouping alternatives.'),
      ],
    );
  }
}

class _ArchiveGalleryPane extends StatelessWidget {
  const _ArchiveGalleryPane();

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('gallery.archive.scroll'),
      children: const [
        _GalleryCard(title: 'Archive 1', body: 'Week 1 snapshots and notes.'),
        _GalleryCard(title: 'Archive 2', body: 'Week 2 snapshots and notes.'),
        _GalleryCard(title: 'Archive 3', body: 'Week 3 snapshots and notes.'),
        _GalleryCard(title: 'Archive 4', body: 'Week 4 snapshots and notes.'),
        _GalleryCard(title: 'Archive 5', body: 'Week 5 snapshots and notes.'),
        _GalleryCard(title: 'Archive 6', body: 'Week 6 snapshots and notes.'),
        _GalleryCard(title: 'Archive 7', body: 'Week 7 snapshots and notes.'),
        _GalleryCard(title: 'Archive 8', body: 'Week 8 snapshots and notes.'),
        _GalleryCard(title: 'Archive 9', body: 'Week 9 snapshots and notes.'),
        _GalleryCard(title: 'Archive 10', body: 'Week 10 snapshots and notes.'),
        _GalleryCard(title: 'Archive 11', body: 'Week 11 snapshots and notes.'),
        _GalleryCard(title: 'Archive 12', body: 'Week 12 snapshots and notes.'),
      ],
    );
  }
}

class _CompareGalleryPane extends StatelessWidget {
  const _CompareGalleryPane();

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('gallery.compare.scroll'),
      children: const [
        _GalleryCard(title: 'Compare 1', body: 'Variant A vs B readability.'),
        _GalleryCard(title: 'Compare 2', body: 'Button hierarchy clarity test.'),
        _GalleryCard(title: 'Compare 3', body: 'Inline actions vs overflow menu.'),
        _GalleryCard(title: 'Compare 4', body: 'Compact vs spacious card modes.'),
        _GalleryCard(title: 'Compare 5', body: 'Dense typography vs calm typography.'),
        _GalleryCard(title: 'Compare 6', body: 'Panel grouping alternatives.'),
        _GalleryCard(title: 'Compare 7', body: 'Onboarding sequence options.'),
        _GalleryCard(title: 'Compare 8', body: 'Progressive disclosure checks.'),
        _GalleryCard(title: 'Compare 9', body: 'Form affordance alternatives.'),
        _GalleryCard(title: 'Compare 10', body: 'Motion style contrast.'),
        _GalleryCard(title: 'Compare 11', body: 'Error state visual clarity.'),
        _GalleryCard(title: 'Compare 12', body: 'Review summary arrangements.'),
      ],
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _amber.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: _amber, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(height: 1.3)),
        ],
      ),
    );
  }
}

class _LifecycleSwapScene extends StatefulWidget {
  const _LifecycleSwapScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_LifecycleSwapScene> createState() => _LifecycleSwapSceneState();
}

class _LifecycleSwapSceneState extends State<_LifecycleSwapScene> {
  PageStorageBucket _bucket = PageStorageBucket();
  final List<String> _trace = <String>[];
  int _pane = 0;
  bool _mounted = true;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1180.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _MiniTitle('Lifecycle Controls'),
                      const SizedBox(height: 8),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Plan')),
                          ButtonSegment(value: 1, label: Text('Draft')),
                          ButtonSegment(value: 2, label: Text('Review')),
                        ],
                        selected: {_pane},
                        onSelectionChanged: (values) {
                          final value = values.first;
                          setState(() => _pane = value);
                          _log('active pane -> $value');
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
                              _log(_mounted ? 'mounted lifecycle subtree' : 'unmounted lifecycle subtree');
                            },
                            child: Text(_mounted ? 'Unmount subtree' : 'Mount subtree'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _bucket = PageStorageBucket());
                              _log('reset lifecycle bucket');
                            },
                            child: const Text('Reset lifecycle bucket'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _DataTable(rows: [
                        _DataRow('pane', '$_pane'),
                        _DataRow('mounted', '$_mounted'),
                        _DataRow('bucket hash', '${_bucket.hashCode}'),
                        _DataRow('events', '${_trace.length}'),
                      ]),
                      const SizedBox(height: 10),
                      if (widget.notes)
                        _BulletCard(
                          tone: _rose,
                          lines: const [
                            'Swap pane widgets while preserving each pane\'s scroll key and draft field key.',
                            'This resembles route/tab transitions where pages are rebuilt but should retain context.',
                            'Resetting the bucket intentionally starts a fresh session.',
                          ],
                        ),
                      const SizedBox(height: 10),
                      const _MiniTitle('Lifecycle Trace'),
                      const SizedBox(height: 6),
                      SizedBox(height: 230, child: _TracePanel(lines: _trace)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _mounted
                    ? PageStorage(
                        bucket: _bucket,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 320),
                          child: _LifecyclePane(
                            key: ValueKey<int>(_pane),
                            pane: _pane,
                          ),
                        ),
                      )
                    : const _MutedEmptyCard(
                        tone: _rose,
                        title: 'Lifecycle subtree offline',
                        body: 'Mount again to validate continuity using the same bucket.',
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _log(String line) {
    setState(() {
      _trace.insert(0, '${_stamp()} | $line');
      _cap(_trace, 70);
    });
  }
}

class _LifecyclePane extends StatefulWidget {
  const _LifecyclePane({super.key, required this.pane});

  final int pane;

  @override
  State<_LifecyclePane> createState() => _LifecyclePaneState();
}

class _LifecyclePaneState extends State<_LifecyclePane> {
  late final TextEditingController _controller;
  bool _flag = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tone = widget.pane == 0
        ? _rose
        : widget.pane == 1
            ? _mint
            : _violet;

    final name = switch (widget.pane) {
      0 => 'Plan Pane',
      1 => 'Draft Pane',
      _ => 'Review Pane',
    };

    return Container(
      key: PageStorageKey('lifecycle.pane.${widget.pane}'),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.26), width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Icon(Icons.view_agenda, color: tone),
                const SizedBox(width: 8),
                Expanded(child: Text(name, style: TextStyle(color: tone, fontWeight: FontWeight.w800))),
                _ToneBadge(tone: tone, text: 'pane ${widget.pane + 1}'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              key: PageStorageKey('lifecycle.scroll.${widget.pane}'),
              padding: const EdgeInsets.all(10),
              children: [
                TextField(
                  key: PageStorageKey('lifecycle.field.${widget.pane}'),
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: '$name notes',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  value: _flag,
                  onChanged: (v) => setState(() => _flag = v),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Enable lane context flag'),
                ),
                const SizedBox(height: 8),
                _LifecycleTile(tone: tone, title: '$name item 1', body: 'Simulated route section with persistent scroll key.'),
                _LifecycleTile(tone: tone, title: '$name item 2', body: 'Switch pane and come back to verify continuity.'),
                _LifecycleTile(tone: tone, title: '$name item 3', body: 'Toggle flag and compare local vs restored states.'),
                _LifecycleTile(tone: tone, title: '$name item 4', body: 'Keep key strings stable across rebuild cycles.'),
                _LifecycleTile(tone: tone, title: '$name item 5', body: 'Use explicit storage for custom, keyless values.'),
                _LifecycleTile(tone: tone, title: '$name item 6', body: 'PageStorage works per bucket boundary.'),
                _LifecycleTile(tone: tone, title: '$name item 7', body: 'Changing bucket acts like fresh session reset.'),
                _LifecycleTile(tone: tone, title: '$name item 8', body: 'Perfect for wizard-like step transitions.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleTile extends StatelessWidget {
  const _LifecycleTile({required this.tone, required this.title, required this.body});

  final Color tone;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(height: 1.3)),
        ],
      ),
    );
  }
}

class _PracticalBoardScene extends StatefulWidget {
  const _PracticalBoardScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_PracticalBoardScene> createState() => _PracticalBoardSceneState();
}

class _PracticalBoardSceneState extends State<_PracticalBoardScene> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<String> _trace = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1080.0 : 1280.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: PageStorage(
                  bucket: _bucket,
                  child: Row(
                    children: [
                      Expanded(
                        child: _FiltersModule(
                          onLog: (line) => _log('filters: $line'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _DraftsModule(
                          onLog: (line) => _log('drafts: $line'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _ProgressModule(
                          onLog: (line) => _log('progress: $line'),
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
            child: _SurfacePanel(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _MiniTitle('Practical Guidance'),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _BulletCard(
                        tone: _violet,
                        lines: const [
                          'Filters module: restore rail position and selected chips between tab switches.',
                          'Draft module: preserve local text editing context in page-level flows.',
                          'Progress module: maintain slider/list state across interactive panel changes.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _DataTable(rows: [
                      _DataRow('bucket hash', '${_bucket.hashCode}'),
                      _DataRow('trace entries', '${_trace.length}'),
                      _DataRow('time', _stamp().substring(0, 8)),
                    ]),
                    const SizedBox(height: 8),
                    const _MiniTitle('Module Trace'),
                    const SizedBox(height: 6),
                    Expanded(child: _TracePanel(lines: _trace)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _log(String line) {
    setState(() {
      _trace.insert(0, '${_stamp()} | $line');
      _cap(_trace, 80);
    });
  }
}

class _FiltersModule extends StatefulWidget {
  const _FiltersModule({required this.onLog});

  final ValueChanged<String> onLog;

  @override
  State<_FiltersModule> createState() => _FiltersModuleState();
}

class _FiltersModuleState extends State<_FiltersModule> {
  final Set<String> _chips = <String>{};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cobalt.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.filter_alt_outlined, color: _cobalt, size: 20),
              const SizedBox(width: 6),
              const Expanded(
                child: Text('Filters Rail', style: TextStyle(color: _cobalt, fontWeight: FontWeight.w800)),
              ),
              _ToneBadge(tone: _cobalt, text: '${_chips.length} selected'),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _chip('Urgent'),
              _chip('Bug'),
              _chip('Feature'),
              _chip('UX'),
              _chip('Infra'),
              _chip('Refactor'),
              _chip('Release'),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              key: const PageStorageKey('practical.filters.scroll'),
              children: const [
                _PlainLineCard('Rail row 1', 'Filter results summary strip'),
                _PlainLineCard('Rail row 2', 'Backlog segment with medium priority'),
                _PlainLineCard('Rail row 3', 'Current sprint visible tasks'),
                _PlainLineCard('Rail row 4', 'Cross-team dependency signal'),
                _PlainLineCard('Rail row 5', 'Ops and monitoring reminders'),
                _PlainLineCard('Rail row 6', 'Security review checkpoints'),
                _PlainLineCard('Rail row 7', 'Test plan review reminders'),
                _PlainLineCard('Rail row 8', 'Polish and cleanup notes'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    final selected = _chips.contains(label);
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {
        setState(() {
          if (v) {
            _chips.add(label);
          } else {
            _chips.remove(label);
          }
        });
        widget.onLog('${v ? 'select' : 'deselect'} $label');
      },
    );
  }
}

class _DraftsModule extends StatefulWidget {
  const _DraftsModule({required this.onLog});

  final ValueChanged<String> onLog;

  @override
  State<_DraftsModule> createState() => _DraftsModuleState();
}

class _DraftsModuleState extends State<_DraftsModule> {
  final TextEditingController _a = TextEditingController();
  final TextEditingController _b = TextEditingController();
  bool _ready = false;

  @override
  void dispose() {
    _a.dispose();
    _b.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _mint.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.note_alt_outlined, color: _mint, size: 20),
              const SizedBox(width: 6),
              const Expanded(
                child: Text('Draft Pad', style: TextStyle(color: _mint, fontWeight: FontWeight.w800)),
              ),
              _ToneBadge(tone: _mint, text: _ready ? 'ready' : 'editing'),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            key: const PageStorageKey('practical.draft.a'),
            controller: _a,
            decoration: const InputDecoration(labelText: 'Draft headline', border: OutlineInputBorder()),
            onChanged: (_) => widget.onLog('headline changed'),
          ),
          const SizedBox(height: 8),
          TextField(
            key: const PageStorageKey('practical.draft.b'),
            controller: _b,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(labelText: 'Draft details', border: OutlineInputBorder()),
            onChanged: (_) => widget.onLog('details changed'),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: _ready,
            onChanged: (v) {
              setState(() => _ready = v);
              widget.onLog('ready = $v');
            },
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('Ready for review'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              key: const PageStorageKey('practical.drafts.scroll'),
              children: const [
                _PlainLineCard('Draft note 1', 'Context for reviewer handoff'),
                _PlainLineCard('Draft note 2', 'Clarify expected outputs'),
                _PlainLineCard('Draft note 3', 'Mark risky dependencies'),
                _PlainLineCard('Draft note 4', 'Capture unresolved questions'),
                _PlainLineCard('Draft note 5', 'Attach benchmark references'),
                _PlainLineCard('Draft note 6', 'Summarize completion criteria'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressModule extends StatefulWidget {
  const _ProgressModule({required this.onLog});

  final ValueChanged<String> onLog;

  @override
  State<_ProgressModule> createState() => _ProgressModuleState();
}

class _ProgressModuleState extends State<_ProgressModule> {
  double _analysis = 0.3;
  double _build = 0.55;
  double _verify = 0.72;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _violet.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stacked_bar_chart, color: _violet, size: 20),
              const SizedBox(width: 6),
              const Expanded(
                child: Text('Progress Lanes', style: TextStyle(color: _violet, fontWeight: FontWeight.w800)),
              ),
              _ToneBadge(tone: _violet, text: 'live'),
            ],
          ),
          const SizedBox(height: 8),
          _TrackSlider(
            label: 'Analysis',
            value: _analysis,
            onChanged: (v) {
              setState(() => _analysis = v);
              widget.onLog('analysis=${v.toStringAsFixed(2)}');
            },
          ),
          _TrackSlider(
            label: 'Build',
            value: _build,
            onChanged: (v) {
              setState(() => _build = v);
              widget.onLog('build=${v.toStringAsFixed(2)}');
            },
          ),
          _TrackSlider(
            label: 'Verify',
            value: _verify,
            onChanged: (v) {
              setState(() => _verify = v);
              widget.onLog('verify=${v.toStringAsFixed(2)}');
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              key: const PageStorageKey('practical.progress.scroll'),
              children: [
                _ProgressLaneCard(label: 'Analysis lane', value: _analysis, tone: _violet),
                _ProgressLaneCard(label: 'Build lane', value: _build, tone: _mint),
                _ProgressLaneCard(label: 'Verify lane', value: _verify, tone: _amber),
                const _PlainLineCard('Lane memo', 'Adjust sliders then switch sections to inspect continuity.'),
                const _PlainLineCard('Lane memo', 'PageStorageKey keeps this panel position in long boards.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackSlider extends StatelessWidget {
  const _TrackSlider({required this.label, required this.value, required this.onChanged});

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

class _ProgressLaneCard extends StatelessWidget {
  const _ProgressLaneCard({required this.label, required this.value, required this.tone});

  final String label;
  final double value;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
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

class _PlainLineCard extends StatelessWidget {
  const _PlainLineCard(this.title, this.body);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F6FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD3E1F1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: _ink)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(height: 1.3)),
        ],
      ),
    );
  }
}

class _SurfacePanel extends StatelessWidget {
  const _SurfacePanel({required this.guides, required this.child});

  final bool guides;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC9D8E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF9FCFF), Color(0xFFEEF4FB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guides) const CustomPaint(painter: _GridGuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GridGuidePainter extends CustomPainter {
  const _GridGuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x12000000);
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

class _MiniTitle extends StatelessWidget {
  const _MiniTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w800));
  }
}

class _DataRow {
  const _DataRow(this.label, this.value);

  final String label;
  final String value;
}

class _DataTable extends StatelessWidget {
  const _DataTable({required this.rows});

  final List<_DataRow> rows;

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
                    SizedBox(width: 150, child: Text(row.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
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

class _BulletCard extends StatelessWidget {
  const _BulletCard({required this.tone, required this.lines});

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

class _TracePanel extends StatelessWidget {
  const _TracePanel({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD0DEEB)),
      ),
      child: lines.isEmpty
          ? const Text('No trace messages yet.', style: TextStyle(color: Color(0xFF62798D)))
          : ListView.builder(
              key: const PageStorageKey('trace.panel.scroll'),
              itemCount: lines.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(lines[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ),
            ),
    );
  }
}

class _MutedEmptyCard extends StatelessWidget {
  const _MutedEmptyCard({required this.tone, required this.title, required this.body});

  final Color tone;
  final String title;
  final String body;

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
            Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
            const SizedBox(height: 6),
            Text(body, textAlign: TextAlign.center, style: const TextStyle(height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class _ToneBadge extends StatelessWidget {
  const _ToneBadge({required this.tone, required this.text});

  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3858),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: PageStorage', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'PageStorage provides bucket-scoped, in-memory persistence for descendant widgets. '
            'Use PageStorageKey for automatic restoration (for example scroll offsets), and PageStorage.of(context) '
            'for explicit write/read flows where you want custom values tied to UI context.',
            style: TextStyle(color: Color(0xFFD8E9F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

void _cap(List<String> lines, int max) {
  if (lines.length > max) {
    lines.removeRange(max, lines.length);
  }
}

String _stamp() => DateTime.now().toIso8601String().substring(11, 19);
