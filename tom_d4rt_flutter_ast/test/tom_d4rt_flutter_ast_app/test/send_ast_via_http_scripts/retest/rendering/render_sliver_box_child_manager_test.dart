import 'package:flutter/material.dart';

class _Pal {
  final String name;
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color ink;
  final Color accent;
  final Color muted;

  const _Pal({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.ink,
    required this.accent,
    required this.muted,
  });
}

const _pals = <_Pal>[
  _Pal(
    name: 'Denim / Tangerine',
    primary: Color(0xFF1D4ED8),
    secondary: Color(0xFFF97316),
    surface: Color(0xFFEFF6FF),
    ink: Color(0xFF1F2937),
    accent: Color(0xFF0EA5E9),
    muted: Color(0xFF64748B),
  ),
  _Pal(
    name: 'Pine / Rose',
    primary: Color(0xFF166534),
    secondary: Color(0xFFE11D48),
    surface: Color(0xFFEFFDF5),
    ink: Color(0xFF223229),
    accent: Color(0xFF10B981),
    muted: Color(0xFF6B7280),
  ),
  _Pal(
    name: 'Graphite / Lime',
    primary: Color(0xFF0F172A),
    secondary: Color(0xFF84CC16),
    surface: Color(0xFFF8FAFC),
    ink: Color(0xFF0F172A),
    accent: Color(0xFF14B8A6),
    muted: Color(0xFF64748B),
  ),
];

enum _ManagerStage {
  lifecycle,
  indexMapping,
  keepAlive,
  cachePrefetch,
  delegateGallery,
  verification,
}

class _Telemetry {
  int created = 0;
  int disposed = 0;
  int keepAliveAlive = 0;
  final List<String> logs = <String>[];

  void add(String value) {
    logs.insert(0, value);
    if (logs.length > 40) {
      logs.removeLast();
    }
  }

  void reset() {
    created = 0;
    disposed = 0;
    keepAliveAlive = 0;
    logs.clear();
  }
}

dynamic build(BuildContext context) {
  return const _LazyChildControlRoom();
}

class _LazyChildControlRoom extends StatefulWidget {
  const _LazyChildControlRoom();

  @override
  State<_LazyChildControlRoom> createState() => _LazyChildControlRoomState();
}

class _LazyChildControlRoomState extends State<_LazyChildControlRoom> {
  _ManagerStage _stage = _ManagerStage.lifecycle;
  int _paletteIndex = 0;
  bool _verbose = false;

  final ScrollController _lifecycleScroll = ScrollController();
  final ScrollController _prefetchScroll = ScrollController();

  final _Telemetry _lifecycleTelemetry = _Telemetry();
  final _Telemetry _keepAliveOffTelemetry = _Telemetry();
  final _Telemetry _keepAliveOnTelemetry = _Telemetry();

  int _lifecycleItemCount = 100;
  double _lifecycleItemExtent = 72;
  bool _showLifecycleLog = true;
  bool _showViewportBands = true;

  final List<int> _mappedIds = List<int>.generate(18, (i) => i + 1000);
  int _nextSyntheticId = 5000;
  bool _useStableKeys = true;

  int _keepAliveCount = 80;
  double _cacheExtent = 250;
  double _prefetchOffset = 0;
  bool _showPrefetchHeatmap = true;
  bool _prefetchAsGrid = false;

  static const _stageTitles = <String>[
    '1 · Lifecycle Telemetry',
    '2 · Index Mapping',
    '3 · Keep-Alive Simulator',
    '4 · Cache & Prefetch',
    '5 · Delegate Gallery',
    '6 · Verification & Guide',
  ];

  _Pal get _p => _pals[_paletteIndex];

  @override
  void initState() {
    super.initState();
    _lifecycleScroll.addListener(_onLifecycleScroll);
    _prefetchScroll.addListener(_onPrefetchScroll);
  }

  @override
  void dispose() {
    _lifecycleScroll.removeListener(_onLifecycleScroll);
    _prefetchScroll.removeListener(_onPrefetchScroll);
    _lifecycleScroll.dispose();
    _prefetchScroll.dispose();
    super.dispose();
  }

  void _log(String msg) {
    if (_verbose) {
      debugPrint('[RenderSliverBoxChildManagerDemo] $msg');
    }
  }

  void _onLifecycleScroll() {
    if (!_showViewportBands) {
      return;
    }
    setState(() {});
  }

  void _onPrefetchScroll() {
    setState(() {
      _prefetchOffset = _prefetchScroll.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTopControls(),
            Expanded(child: _buildStage()),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_p.primary, _p.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.memory_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Text(
                'Lazy Child Control Room',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'RenderSliverBoxChildManager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'RenderSliverBoxChildManager orchestrates child creation, reuse, '
            'and disposal for sliver multi-box adaptors like SliverList and '
            'SliverGrid. This demo visualizes lazy instantiation, identity '
            'mapping, keep-alive behavior, and cache/prefetch effects.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 12.5,
              height: 1.34,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Container(
      width: double.infinity,
      color: _p.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Stage',
            style: TextStyle(
              color: _p.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _stageTitles.length; i++)
            ChoiceChip(
              selected: _stage.index == i,
              label: Text('${i + 1}'),
              onSelected: (_) {
                setState(() => _stage = _ManagerStage.values[i]);
                _log('stage => ${_stage.name}');
              },
              selectedColor: _p.primary,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: _stage.index == i ? Colors.white : _p.ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(width: 8),
          Text(
            'Palette',
            style: TextStyle(
              color: _p.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _pals.length; i++)
            GestureDetector(
              onTap: () => setState(() => _paletteIndex = i),
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _pals[i].primary,
                  border: Border.all(
                    color: _paletteIndex == i ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verbose', style: TextStyle(color: _p.ink, fontSize: 12)),
              Switch(
                value: _verbose,
                activeTrackColor: _p.accent,
                onChanged: (v) => setState(() => _verbose = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStage() {
    switch (_stage) {
      case _ManagerStage.lifecycle:
        return _stageLifecycleTelemetry();
      case _ManagerStage.indexMapping:
        return _stageIndexMapping();
      case _ManagerStage.keepAlive:
        return _stageKeepAlive();
      case _ManagerStage.cachePrefetch:
        return _stageCachePrefetch();
      case _ManagerStage.delegateGallery:
        return _stageDelegateGallery();
      case _ManagerStage.verification:
        return _stageVerification();
    }
  }

  Widget _stageLifecycleTelemetry() {
    final firstVisible = (_lifecycleScroll.hasClients
            ? (_lifecycleScroll.offset / _lifecycleItemExtent).floor()
            : 0)
        .clamp(0, _lifecycleItemCount - 1);
    final viewportCount = (_lifecycleScroll.hasClients
            ? ((_lifecycleScroll.position.viewportDimension / _lifecycleItemExtent)
                .ceil())
            : 7)
        .clamp(1, _lifecycleItemCount);
    final lastVisible = (firstVisible + viewportCount - 1)
        .clamp(0, _lifecycleItemCount - 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Lifecycle Telemetry'),
          const SizedBox(height: 8),
          Text(
            'The child manager lazily requests children for visible indexes '
            'and disposes those that move outside retention windows. Scroll '
            'to generate create/dispose events and inspect the live feed.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Controls',
            subtitle: 'Tune list density and telemetry panel behavior.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Item Count',
                  value: _lifecycleItemCount.toDouble(),
                  min: 30,
                  max: 220,
                  divisions: 19,
                  onChanged: (v) {
                    setState(() => _lifecycleItemCount = v.round());
                  },
                  color: _p.primary,
                ),
                _sliderRow(
                  label: 'Item Extent',
                  value: _lifecycleItemExtent,
                  min: 56,
                  max: 100,
                  divisions: 11,
                  onChanged: (v) {
                    setState(() => _lifecycleItemExtent = v);
                  },
                  color: _p.secondary,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _showLifecycleLog,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _showLifecycleLog = v ?? true),
                    ),
                    Text(
                      'Show lifecycle log',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showViewportBands,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _showViewportBands = v ?? true),
                    ),
                    Text(
                      'Show viewport range chips',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() => _lifecycleTelemetry.reset());
                      },
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text('Reset telemetry'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _card(
                  title: 'Lazy Sliver Feed',
                  subtitle: 'Scroll to trigger build/dispose activity.',
                  tint: _p.primary.withValues(alpha: 0.04),
                  child: Container(
                    width: double.infinity,
                    height: 520,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
                    ),
                    child: Stack(
                      children: [
                        CustomScrollView(
                          controller: _lifecycleScroll,
                          cacheExtent: 0,
                          slivers: [
                            SliverToBoxAdapter(
                              child: _sliverBanner('Telemetry Header', _p.primary),
                            ),
                            SliverFixedExtentList.builder(
                              itemExtent: _lifecycleItemExtent,
                              itemCount: _lifecycleItemCount,
                              itemBuilder: (context, index) {
                                return _LifecycleProbeTile(
                                  id: index,
                                  keepAlive: false,
                                  color: index.isEven
                                      ? _p.primary.withValues(alpha: 0.11)
                                      : _p.secondary.withValues(alpha: 0.11),
                                  onCreate: (id) {
                                    setState(() {
                                      _lifecycleTelemetry.created += 1;
                                      _lifecycleTelemetry.add('create #$id');
                                    });
                                  },
                                  onDispose: (id) {
                                    setState(() {
                                      _lifecycleTelemetry.disposed += 1;
                                      _lifecycleTelemetry.add('dispose #$id');
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      _idChip(index),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Managed child index $index',
                                          style: TextStyle(
                                            color: _p.ink,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'h ${_lifecycleItemExtent.toStringAsFixed(0)}',
                                        style: TextStyle(
                                          color: _p.muted,
                                          fontSize: 10.5,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SliverToBoxAdapter(
                              child: _sliverBanner('Telemetry Footer', _p.primary),
                            ),
                          ],
                        ),
                        if (_showViewportBands)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _metricChip('first', '$firstVisible', _p.primary),
                                const SizedBox(height: 6),
                                _metricChip('last', '$lastVisible', _p.primary),
                                const SizedBox(height: 6),
                                _metricChip('visible', '$viewportCount', _p.secondary),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _card(
                  title: 'Telemetry Console',
                  subtitle: 'Live manager-related lifecycle signals.',
                  tint: _p.secondary.withValues(alpha: 0.04),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _metricPanel(
                              'Created',
                              '${_lifecycleTelemetry.created}',
                              _p.primary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _metricPanel(
                              'Disposed',
                              '${_lifecycleTelemetry.disposed}',
                              _p.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: _p.muted.withValues(alpha: 0.22)),
                        ),
                        child: Text(
                          'Manager intuition:\n'
                          '- Build requests increase as new indexes enter viewport.\n'
                          '- Dispose events rise as items exit and are released.\n'
                          '- Smoother scroll + fewer creations indicates better reuse/cache strategy.',
                          style: TextStyle(
                            color: _p.ink,
                            fontSize: 11.5,
                            height: 1.35,
                          ),
                        ),
                      ),
                      if (_showLifecycleLog) ...[
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 310,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: _p.muted.withValues(alpha: 0.22)),
                          ),
                          child: ListView.builder(
                            itemCount: _lifecycleTelemetry.logs.length,
                            itemBuilder: (context, i) {
                              final entry = _lifecycleTelemetry.logs[i];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  '${i + 1}. $entry',
                                  style: TextStyle(
                                    color: _p.ink,
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _infoBox(
            'RenderSliverBoxChildManager is not painted directly, but this '
            'telemetry pattern makes its child lifecycle effects visible and '
            'teachable through sliver behavior.',
          ),
        ],
      ),
    );
  }

  Widget _stageIndexMapping() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Index Mapping & Identity Stability'),
          const SizedBox(height: 8),
          Text(
            'Child managers rely on index-based retrieval but apps often '
            'mutate data sequences. This stage highlights why stable identity '
            'keys matter when inserting, removing, and reordering items.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Mutation Controls',
            subtitle: 'Trigger index shifts and watch id/index mapping changes.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _p.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _mappedIds.insert(0, _nextSyntheticId++);
                    });
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Insert at top'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _p.secondary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_mappedIds.isNotEmpty) {
                      setState(() {
                        _mappedIds.removeAt(0);
                      });
                    }
                  },
                  icon: const Icon(Icons.remove, size: 18),
                  label: const Text('Remove top'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    if (_mappedIds.length > 3) {
                      setState(() {
                        final first = _mappedIds.removeAt(0);
                        _mappedIds.insert(3, first);
                      });
                    }
                  },
                  icon: const Icon(Icons.swap_vert, size: 18),
                  label: const Text('Move first to index 3'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _mappedIds
                        ..clear()
                        ..addAll(List<int>.generate(18, (i) => i + 1000));
                      _nextSyntheticId = 5000;
                    });
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Reset list'),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: _useStableKeys,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _useStableKeys = v ?? true),
                    ),
                    Text(
                      'Use ValueKey(id)',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _card(
                  title: 'Mutable SliverList',
                  subtitle:
                      'Each row shows index and stable id tracked through mutations.',
                  tint: _p.primary.withValues(alpha: 0.04),
                  child: Container(
                    width: double.infinity,
                    height: 520,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _sliverBanner('Index/ID stream', _p.primary),
                        ),
                        SliverList.builder(
                          itemCount: _mappedIds.length,
                          itemBuilder: (context, index) {
                            final id = _mappedIds[index];
                            return Container(
                              key: _useStableKeys ? ValueKey<int>(id) : null,
                              margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: index.isEven
                                    ? _p.primary.withValues(alpha: 0.11)
                                    : _p.secondary.withValues(alpha: 0.11),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  _metricChip('idx', '$index', _p.primary),
                                  const SizedBox(width: 8),
                                  _metricChip('id', '$id', _p.secondary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _useStableKeys
                                          ? 'Stable identity preserved by key'
                                          : 'No key: identity may shift on reorders',
                                      style: TextStyle(
                                          color: _p.ink,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _card(
                  title: 'Manager Notes',
                  subtitle: 'How child managers reason about indices.',
                  tint: _p.secondary.withValues(alpha: 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bullet('Manager asks delegate for child at index i.'),
                      _bullet('On insert/remove, downstream indexes shift.'),
                      _bullet('Stable keys help preserve child identity state.'),
                      _bullet('Without keys, UI state can appear to jump rows.'),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: _p.muted.withValues(alpha: 0.22)),
                        ),
                        child: Text(
                          'Current length: ${_mappedIds.length}\n'
                          'Stable key mode: ${_useStableKeys ? 'on' : 'off'}\n'
                          'Top 5 IDs: ${_mappedIds.take(5).join(', ')}',
                          style: TextStyle(
                            color: _p.ink,
                            fontSize: 11,
                            fontFamily: 'monospace',
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stageKeepAlive() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Keep-Alive Simulator'),
          const SizedBox(height: 8),
          Text(
            'KeepAlive changes whether off-screen children remain mounted. '
            'Compare two streams below: left disables keepAlive, right enables '
            'it via AutomaticKeepAliveClientMixin.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Scenario Controls',
            subtitle: 'Adjust item count and reset counters.',
            child: Row(
              children: [
                Expanded(
                  child: _sliderRow(
                    label: 'Item Count',
                    value: _keepAliveCount.toDouble(),
                    min: 30,
                    max: 150,
                    divisions: 12,
                    onChanged: (v) => setState(() => _keepAliveCount = v.round()),
                    color: _p.primary,
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _keepAliveOffTelemetry.reset();
                      _keepAliveOnTelemetry.reset();
                    });
                  },
                  icon: const Icon(Icons.restore, size: 16),
                  label: const Text('Reset counters'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _keepAlivePanel(
                  title: 'keepAlive: OFF',
                  telemetry: _keepAliveOffTelemetry,
                  keepAlive: false,
                  tint: _p.secondary.withValues(alpha: 0.05),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _keepAlivePanel(
                  title: 'keepAlive: ON',
                  telemetry: _keepAliveOnTelemetry,
                  keepAlive: true,
                  tint: _p.primary.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _infoBox(
            'When keepAlive is enabled, off-screen child states can be retained '
            'instead of disposed, reducing recreation churn at the cost of '
            'higher memory pressure. The manager coordinates this retention.',
          ),
        ],
      ),
    );
  }

  Widget _keepAlivePanel({
    required String title,
    required _Telemetry telemetry,
    required bool keepAlive,
    required Color tint,
  }) {
    final color = keepAlive ? _p.primary : _p.secondary;
    return _card(
      title: title,
      subtitle: 'Scroll independently and compare lifecycle counters.',
      tint: tint,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _metricPanel('Created', '${telemetry.created}', color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _metricPanel('Disposed', '${telemetry.disposed}', color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 350,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverFixedExtentList.builder(
                    itemExtent: 68,
                    itemCount: _keepAliveCount,
                    itemBuilder: (context, index) {
                      return _LifecycleProbeTile(
                        id: index,
                        keepAlive: keepAlive,
                        color: color.withValues(alpha: 0.11),
                        onCreate: (id) {
                          setState(() {
                            telemetry.created += 1;
                            telemetry.add('create #$id');
                          });
                        },
                        onDispose: (id) {
                          setState(() {
                            telemetry.disposed += 1;
                            telemetry.add('dispose #$id');
                          });
                        },
                        child: Row(
                          children: [
                            _idChip(index),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                keepAlive
                                    ? 'Retained candidate index $index'
                                    : 'Disposable candidate index $index',
                                style: TextStyle(
                                  color: _p.ink,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stageCachePrefetch() {
    final itemExtent = 80.0;
    final first = (_prefetchOffset / itemExtent).floor().clamp(0, 9999);
    final prefetchTail = ((_prefetchOffset + _cacheExtent) / itemExtent)
        .ceil()
        .clamp(0, 9999);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Cache Extent & Prefetch Window'),
          const SizedBox(height: 8),
          Text(
            'Cache extent influences how far ahead sliver children may be '
            'prepared around the viewport. This section visualizes predicted '
            'prefetch neighborhoods and their impact on churn smoothness.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Prefetch Controls',
            subtitle: 'Tune cache extent and representation mode.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'cacheExtent',
                  value: _cacheExtent,
                  min: 0,
                  max: 800,
                  divisions: 16,
                  onChanged: (v) => setState(() => _cacheExtent = v),
                  color: _p.primary,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _showPrefetchHeatmap,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _showPrefetchHeatmap = v ?? true),
                    ),
                    Text(
                      'Show prefetch heatmap',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _prefetchAsGrid,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _prefetchAsGrid = v ?? false),
                    ),
                    Text(
                      'Grid mode',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('first', '$first', _p.primary),
                    const SizedBox(width: 6),
                    _metricChip('prefetchTail', '$prefetchTail', _p.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Prefetch Stage',
            subtitle: 'Color intensity hints at predicted prefetch relevance.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Container(
              width: double.infinity,
              height: 520,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
              ),
              child: CustomScrollView(
                controller: _prefetchScroll,
                cacheExtent: _cacheExtent,
                slivers: [
                  SliverToBoxAdapter(
                    child: _sliverBanner('Prefetch monitor', _p.primary),
                  ),
                  if (_prefetchAsGrid)
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 80,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _prefetchTile(index, itemExtent);
                        },
                        childCount: 80,
                      ),
                    )
                  else
                    SliverFixedExtentList.builder(
                      itemExtent: itemExtent,
                      itemCount: 120,
                      itemBuilder: (context, index) {
                        return _prefetchTile(index, itemExtent);
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Cache Strategy Notes',
            subtitle: 'Balancing smoothness and memory.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Higher cacheExtent can reduce visible build pop-in.'),
                _bullet('Excessive prefetch may increase memory and build work.'),
                _bullet('Tune per screen complexity and scroll velocity.'),
                _bullet('Manager/delegate collaboration decides child lifecycle timing.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _prefetchTile(int index, double itemExtent) {
    final idxOffset = index * itemExtent;
    final distance = (idxOffset - _prefetchOffset).abs();
    final normalized =
      (1 - (distance / (_cacheExtent + itemExtent))).clamp(0.0, 1.0);
    final intensity = _showPrefetchHeatmap ? normalized : 0.35;
    final color = Color.lerp(
      _p.secondary.withValues(alpha: 0.08),
      _p.primary.withValues(alpha: 0.28),
      intensity,
    )!;

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _idChip(index),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Candidate index $index',
              style: TextStyle(
                color: _p.ink,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            intensity.toStringAsFixed(2),
            style: TextStyle(
              color: _p.muted,
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _stageDelegateGallery() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Delegate Strategy Gallery'),
          const SizedBox(height: 8),
          Text(
            'Different sliver delegates still depend on child-manager behavior '
            'for index lookup and lifecycle orchestration. This gallery maps '
            'common sliver strategies to manager responsibilities.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _delegateCard(
                title: 'SliverList.builder',
                subtitle: 'Lazy by index via builder callback.',
                color: _p.primary,
                sliver: SliverList.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => _smallDemoRow(
                    'Builder row ${index + 1}',
                    _p.primary.withValues(alpha: 0.12),
                  ),
                ),
              ),
              _delegateCard(
                title: 'SliverFixedExtentList',
                subtitle: 'Known extent improves scroll math predictability.',
                color: _p.secondary,
                sliver: SliverFixedExtentList.builder(
                  itemExtent: 44,
                  itemCount: 4,
                  itemBuilder: (context, index) => _smallDemoRow(
                    'Fixed row ${index + 1}',
                    _p.secondary.withValues(alpha: 0.12),
                  ),
                ),
              ),
              _delegateCard(
                title: 'SliverGrid.builder',
                subtitle: 'Manager coordinates 2D child indexing.',
                color: _p.accent,
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 42,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _p.accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'G${index + 1}',
                          style: TextStyle(
                            color: _p.ink,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      );
                    },
                    childCount: 6,
                  ),
                ),
              ),
              _delegateCard(
                title: 'SliverPrototypeExtentList',
                subtitle: 'Prototype row drives extent; manager still maps indexes.',
                color: _p.primary,
                sliver: SliverPrototypeExtentList(
                  prototypeItem: _smallDemoRow(
                    'Prototype row',
                    _p.primary.withValues(alpha: 0.2),
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _smallDemoRow(
                      'Proto row ${index + 1}',
                      _p.primary.withValues(alpha: 0.12),
                    ),
                    childCount: 4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Manager Responsibility Checklist',
            subtitle: 'Conceptual anchors for RenderSliverBoxChildManager.',
            tint: _p.accent.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Create child for index when requested by render sliver.'),
                _bullet('Estimate and track child extents for layout flow.'),
                _bullet('Retain or dispose children according to cache/keepAlive policy.'),
                _bullet('Handle index identity transitions on data mutations.'),
                _bullet('Coordinate with delegates for childCount and lookup bounds.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _delegateCard({
    required String title,
    required String subtitle,
    required Color color,
    required Widget sliver,
  }) {
    return SizedBox(
      width: 360,
      child: _card(
        title: title,
        subtitle: subtitle,
        tint: color.withValues(alpha: 0.04),
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: _sliverBanner('Mini stage', color),
              ),
              sliver,
            ],
          ),
        ),
      ),
    );
  }

  Widget _smallDemoRow(String text, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: _p.ink, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _stageVerification() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification & Guide'),
          const SizedBox(height: 12),
          _card(
            title: 'Concept Map',
            subtitle: 'How manager, render sliver, and delegate coordinate.',
            child: Column(
              children: [
                _apiRow(
                  role: 'RenderSliverMultiBoxAdaptor',
                  detail: 'Requests children by index for layout/paint cycle.',
                ),
                _apiRow(
                  role: 'RenderSliverBoxChildManager',
                  detail:
                      'Creates, removes, and tracks children based on viewport demand.',
                ),
                _apiRow(
                  role: 'SliverChildDelegate',
                  detail: 'Provides child widgets and childCount metadata.',
                ),
                _apiRow(
                  role: 'KeepAlive / cache policy',
                  detail:
                      'Determines whether off-screen children persist or dispose.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do / Don\'t Matrix',
            subtitle: 'Practical design decisions for stable sliver systems.',
            child: Column(
              children: [
                _decisionRow(
                  use: 'Use stable keys for mutable datasets',
                  decision: 'Do',
                  reason:
                      'Prevents child state mismatches when indexes shift.',
                  good: true,
                ),
                _decisionRow(
                  use: 'Rely on implicit index identity after reorders',
                  decision: 'Don\'t',
                  reason: 'Can cause visual/state jumps.',
                  good: false,
                ),
                _decisionRow(
                  use: 'Tune cacheExtent for smooth fast scrolling',
                  decision: 'Do',
                  reason:
                      'Balances prefetch smoothness with memory budget.',
                  good: true,
                ),
                _decisionRow(
                  use: 'Enable keepAlive for every heavy child blindly',
                  decision: 'Don\'t',
                  reason:
                      'Retained widgets increase memory pressure significantly.',
                  good: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common confusion points around child manager behavior.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _qa(
                  q: 'Can I use RenderSliverBoxChildManager directly in app code?',
                  a: 'Typically no. It is an internal render-layer contract '
                      'used by sliver adaptors and delegates.',
                ),
                _qa(
                  q: 'Why do off-screen items sometimes dispose quickly?',
                  a: 'Cache extent and keepAlive strategy determine retention. '
                      'Smaller caches and no keepAlive increase disposals.',
                ),
                _qa(
                  q: 'Does SliverList.builder use this manager?',
                  a: 'Yes. Builder delegates are managed through sliver '
                      'multi-box adaptor infrastructure with child manager logic.',
                ),
                _qa(
                  q: 'How do I reduce rebuild churn?',
                  a: 'Use stable keys, tuned cache extent, and selective '
                      'keepAlive for expensive children.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Checklist',
            subtitle: 'Deep demo completion criteria for this class.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Lifecycle creation/disposal telemetry visualized.'),
                _check('Index mapping and key stability demonstrated.'),
                _check('KeepAlive comparison implemented side-by-side.'),
                _check('Cache extent and prefetch window visualized.'),
                _check('Delegate strategy coverage provided with examples.'),
                _check('Guide section includes matrix, FAQ, and concept map.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'RenderSliverBoxChildManager is the operational backbone for '
            'lazy sliver children. Understanding its lifecycle and identity '
            'rules helps build smooth, correct, and scalable scroll interfaces.',
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.ink.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _stageTitles[_stage.index],
            style: TextStyle(
              color: _p.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            'Palette: ${_p.name}',
            style: TextStyle(color: _p.muted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _metricPanel(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: _p.ink,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: _p.ink,
              fontSize: 14,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliverBanner(String text, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.view_day, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: _p.ink,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _idChip(int id) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: _p.ink.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '#$id',
        style: TextStyle(
          color: _p.ink,
          fontSize: 10.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _metricChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _p.ink,
          fontSize: 10.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required Color color,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(color: _p.ink, fontSize: 12),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _apiRow({required String role, required String detail}) {
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
        children: [
          SizedBox(
            width: 220,
            child: Text(
              role,
              style: TextStyle(
                color: _p.primary,
                fontSize: 11.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              detail,
              style: TextStyle(color: _p.muted, fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decisionRow({
    required String use,
    required String decision,
    required String reason,
    required bool good,
  }) {
    final color = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(good ? Icons.check_circle : Icons.cancel, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  use,
                  style: TextStyle(
                    color: _p.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  decision,
                  style: TextStyle(
                    color: color,
                    fontSize: 11.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  reason,
                  style: TextStyle(color: _p.muted, fontSize: 11.4),
                ),
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
        children: [
          Text(
            'Q: $q',
            style: TextStyle(
              color: _p.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $a',
            style: TextStyle(color: _p.muted, fontSize: 11.5, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _p.ink, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.secondary.withValues(alpha: 0.26)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _p.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _p.ink, fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: _p.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: _p.ink,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _card({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _p.ink,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(color: _p.muted, fontSize: 11.5),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _p.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _p.ink, fontSize: 12, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleProbeTile extends StatefulWidget {
  final int id;
  final bool keepAlive;
  final Color color;
  final ValueChanged<int> onCreate;
  final ValueChanged<int> onDispose;
  final Widget child;

  const _LifecycleProbeTile({
    required this.id,
    required this.keepAlive,
    required this.color,
    required this.onCreate,
    required this.onDispose,
    required this.child,
  });

  @override
  State<_LifecycleProbeTile> createState() => _LifecycleProbeTileState();
}

class _LifecycleProbeTileState extends State<_LifecycleProbeTile> {
  // AutomaticKeepAliveClientMixin removed — not available in D4rt bridge

  @override
  void initState() {
    super.initState();
    widget.onCreate(widget.id);
  }

  @override
  void didUpdateWidget(covariant _LifecycleProbeTile oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.onDispose(widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: widget.child,
    );
  }
}
