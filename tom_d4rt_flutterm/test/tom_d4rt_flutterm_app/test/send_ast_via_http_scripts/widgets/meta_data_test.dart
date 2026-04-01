import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show BoxHitTestResult, RenderMetaData;

const _pageBg = Color(0xFFF4F8FC);
const _ink = Color(0xFF18364C);
const _blue = Color(0xFF2A6AA0);
const _teal = Color(0xFF2E8272);
const _amber = Color(0xFFAA7A2F);
const _rose = Color(0xFF9B5C72);
const _violet = Color(0xFF6359AE);

dynamic build(BuildContext context) {
  return const _MetaDataDeepDemoApp();
}

class _MetaDataDeepDemoApp extends StatelessWidget {
  const _MetaDataDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _pageBg,
      ),
      home: const _MetaDataDeepDemoPage(),
    );
  }
}

class _MetaDataDeepDemoPage extends StatefulWidget {
  const _MetaDataDeepDemoPage();

  @override
  State<_MetaDataDeepDemoPage> createState() => _MetaDataDeepDemoPageState();
}

class _MetaDataDeepDemoPageState extends State<_MetaDataDeepDemoPage> {
  bool _compact = false;
  bool _guides = true;
  bool _notes = true;
  bool _rtl = false;
  double _zoom = 1;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 94,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('MetaData Deep Demo'),
              Text(
                'hit-test tagging | behavior routing | interpreter instrumentation with visual probes',
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
                title: 'Fundamentals Board',
                subtitle:
                    'Core MetaData tagging over interactive cards with live hit-test path decode and purpose-oriented metadata payloads.',
                child: _FundamentalsScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _teal,
                title: 'Overlap Behavior Lab',
                subtitle:
                    'Stacked layers with independent HitTestBehavior controls to show how opaque, translucent, and deferToChild impact metadata collection.',
                child: _OverlapBehaviorScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Hover Inspector Map',
                subtitle:
                    'Pointer navigation map where MetaData tags are decoded into instructional details and event timeline records.',
                child: _HoverInspectorScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Metadata Catalog Studio',
                subtitle:
                    'Metadata-tagged catalog modules demonstrating semantic zones, payload variety, and trace-friendly records for list and panel layouts.',
                child: _CatalogScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _violet,
                title: 'Practical Operations Console',
                subtitle:
                    'Production-style command, metrics, and controls lanes with MetaData-driven diagnostics and interpreter-friendly event logs.',
                child: _PracticalScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
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
          colors: [Color(0xFF19374D), Color(0xFF2A699D), Color(0xFF35806F), Color(0xFF665AB2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MetaData Control Deck',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'MetaData attaches payload information to render nodes for hit-test collection. '
            'This is useful for diagnostics, analytics, and route-aware interaction instrumentation.',
            style: TextStyle(color: Color(0xFFDDECF8), height: 1.35),
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
          Text('Global scene zoom: ${zoom.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: zoom,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onZoomChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.32),
          ),
        ],
      ),
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

class _MetaTag {
  const _MetaTag({
    required this.id,
    required this.zone,
    required this.purpose,
    required this.detail,
    required this.priority,
  });

  final String id;
  final String zone;
  final String purpose;
  final String detail;
  final int priority;

  @override
  String toString() {
    return 'MetaTag(id: $id, zone: $zone, purpose: $purpose, detail: $detail, priority: $priority)';
  }
}

class _MetaHitView {
  const _MetaHitView({required this.depth, required this.behavior, required this.payload, required this.targetType});

  final int depth;
  final String behavior;
  final String payload;
  final String targetType;
}

class _ProbePacket {
  const _ProbePacket({required this.phase, required this.localPosition, required this.hits});

  final String phase;
  final Offset localPosition;
  final List<_MetaHitView> hits;
}

List<_MetaHitView> _collectMetaHits(RenderBox box, Offset localPosition) {
  final result = BoxHitTestResult();
  box.hitTest(result, position: localPosition);
  final out = <_MetaHitView>[];
  int depth = 0;
  for (final entry in result.path) {
    final target = entry.target;
    if (target is RenderMetaData) {
      final payload = target.metaData;
      final behavior = target.behavior.name;
      out.add(
        _MetaHitView(
          depth: depth,
          behavior: behavior,
          payload: payload.toString(),
          targetType: target.runtimeType.toString(),
        ),
      );
    }
    depth += 1;
  }
  return out;
}

class _MetaProbeSurface extends StatelessWidget {
  const _MetaProbeSurface({
    required this.child,
    required this.onProbe,
    this.trackMove = false,
    this.trackHover = false,
  });

  final Widget child;
  final ValueChanged<_ProbePacket> onProbe;
  final bool trackMove;
  final bool trackHover;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (probeContext) {
        void sendProbe(String phase, Offset local) {
          final renderObject = probeContext.findRenderObject();
          if (renderObject is! RenderBox) {
            return;
          }
          final hits = _collectMetaHits(renderObject, local);
          onProbe(_ProbePacket(phase: phase, localPosition: local, hits: hits));
        }

        return Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (event) => sendProbe('down', event.localPosition),
          onPointerMove: trackMove ? (event) => sendProbe('move', event.localPosition) : null,
          onPointerHover: trackHover ? (event) => sendProbe('hover', event.localPosition) : null,
          child: child,
        );
      },
    );
  }
}

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.compact, required this.guides, required this.notes, required this.zoom});

  final bool compact;
  final bool guides;
  final bool notes;
  final double zoom;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  _ProbePacket? _lastProbe;
  bool _trackMove = false;
  String _focus = 'all';
  final List<String> _timeline = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 920.0 : 1080.0;
    return SizedBox(
      height: h,
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
                      const Text('Fundamental controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: _focus,
                        decoration: const InputDecoration(labelText: 'Focus lane', border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(value: 'all', child: Text('all lanes')),
                          DropdownMenuItem(value: 'routing', child: Text('routing lane')),
                          DropdownMenuItem(value: 'analytics', child: Text('analytics lane')),
                          DropdownMenuItem(value: 'feedback', child: Text('feedback lane')),
                        ],
                        onChanged: (v) => setState(() => _focus = v ?? _focus),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _trackMove,
                        onChanged: (v) => setState(() => _trackMove = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Track pointer move probes'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('phase', _lastProbe?.phase ?? 'none'),
                          _DataRowItem('pointer local', _formatOffset(_lastProbe?.localPosition)),
                          _DataRowItem('metadata hits', '${_lastProbe?.hits.length ?? 0}'),
                          _DataRowItem('focus lane', _focus),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_lastProbe != null)
                        _HitStackCard(
                          title: 'Decoded metadata path',
                          tone: _blue,
                          hits: _lastProbe!.hits,
                        ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'Use MetaData when interaction instrumentation needs payloads attached directly to hit-test paths.',
                            'Payloads can describe route IDs, logical zones, diagnostics tags, or operational ownership.',
                            'Pair MetaData with visual modules so probe output can be mapped quickly to on-screen regions.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Probe timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 190, child: _LogCard(lines: _timeline)),
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
                child: Transform.scale(
                  scale: widget.zoom,
                  alignment: Alignment.topCenter,
                  child: _MetaProbeSurface(
                    trackMove: _trackMove,
                    onProbe: (probe) {
                      setState(() {
                        _lastProbe = probe;
                        _timeline.insert(0, '${_clock()} | ${probe.phase} @ ${_formatOffset(probe.localPosition)} | hits=${probe.hits.length}');
                        if (_timeline.length > 36) {
                          _timeline.removeRange(36, _timeline.length);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(child: _ToneBackdrop(tone: _blue, label: 'Fundamentals board')),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _FundamentalCard(
                                tone: _blue,
                                title: 'Route Header',
                                subtitle: 'Navigation entry instrumentation',
                                lane: 'routing',
                                visible: _focus == 'all' || _focus == 'routing',
                                tag: const _MetaTag(
                                  id: 'route.header',
                                  zone: 'routing',
                                  purpose: 'route title and owner',
                                  detail: 'top-level route metadata for pointer diagnostics',
                                  priority: 1,
                                ),
                              ),
                              _FundamentalCard(
                                tone: _teal,
                                title: 'Session Counter',
                                subtitle: 'Analytics marker and KPI source',
                                lane: 'analytics',
                                visible: _focus == 'all' || _focus == 'analytics',
                                tag: const _MetaTag(
                                  id: 'analytics.counter',
                                  zone: 'analytics',
                                  purpose: 'runtime metric region',
                                  detail: 'collects KPI tap context for interpreter review',
                                  priority: 2,
                                ),
                              ),
                              _FundamentalCard(
                                tone: _amber,
                                title: 'Approval Queue',
                                subtitle: 'Action lane state marker',
                                lane: 'routing',
                                visible: _focus == 'all' || _focus == 'routing',
                                tag: const _MetaTag(
                                  id: 'ops.queue',
                                  zone: 'routing',
                                  purpose: 'queue command destination',
                                  detail: 'maps pending work to route bucket',
                                  priority: 2,
                                ),
                              ),
                              _FundamentalCard(
                                tone: _rose,
                                title: 'Feedback Strip',
                                subtitle: 'Inline experience telemetry',
                                lane: 'feedback',
                                visible: _focus == 'all' || _focus == 'feedback',
                                tag: const _MetaTag(
                                  id: 'feedback.strip',
                                  zone: 'feedback',
                                  purpose: 'in-app sentiment panel',
                                  detail: 'captures interaction hotspot for quality review',
                                  priority: 3,
                                ),
                              ),
                              _FundamentalCard(
                                tone: _violet,
                                title: 'Bridge Health',
                                subtitle: 'Interpreter bridge monitor',
                                lane: 'analytics',
                                visible: _focus == 'all' || _focus == 'analytics',
                                tag: const _MetaTag(
                                  id: 'bridge.health',
                                  zone: 'analytics',
                                  purpose: 'bridge quality metrics',
                                  detail: 'links pointer events to bridge state panel',
                                  priority: 1,
                                ),
                              ),
                              _FundamentalCard(
                                tone: _teal,
                                title: 'Command Footer',
                                subtitle: 'Final submit lane',
                                lane: 'feedback',
                                visible: _focus == 'all' || _focus == 'feedback',
                                tag: const _MetaTag(
                                  id: 'command.footer',
                                  zone: 'feedback',
                                  purpose: 'commit action metadata',
                                  detail: 'anchors end-of-flow interactions to contextual metadata',
                                  priority: 2,
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
            ),
          ),
        ],
      ),
    );
  }
}

class _FundamentalCard extends StatefulWidget {
  const _FundamentalCard({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.lane,
    required this.tag,
    required this.visible,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final String lane;
  final _MetaTag tag;
  final bool visible;

  @override
  State<_FundamentalCard> createState() => _FundamentalCardState();
}

class _FundamentalCardState extends State<_FundamentalCard> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) {
      return const SizedBox.shrink();
    }
    return MetaData(
      metaData: widget.tag,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 286,
        height: 202,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.tone.withValues(alpha: 0.34), width: 1.4),
          boxShadow: [
            BoxShadow(color: widget.tone.withValues(alpha: 0.14), blurRadius: 9, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
                _LaneChip(tone: widget.tone, label: widget.lane),
              ],
            ),
            const SizedBox(height: 4),
            Text(widget.subtitle, style: const TextStyle(color: Color(0xFF425A6E), fontSize: 12)),
            const SizedBox(height: 8),
            MetaData(
              metaData: '${widget.tag.id}.button',
              behavior: HitTestBehavior.deferToChild,
              child: FilledButton.tonal(
                onPressed: () => setState(() => _counter += 1),
                style: FilledButton.styleFrom(foregroundColor: widget.tone),
                child: const Text('Trigger local action'),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.tone.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('id: ${widget.tag.id}', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w700, fontSize: 11)),
                    Text('purpose: ${widget.tag.purpose}', style: const TextStyle(fontSize: 11)),
                    Text('priority: ${widget.tag.priority}', style: const TextStyle(fontSize: 11)),
                    const Spacer(),
                    Text('local presses: $_counter', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverlapBehaviorScene extends StatefulWidget {
  const _OverlapBehaviorScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_OverlapBehaviorScene> createState() => _OverlapBehaviorSceneState();
}

class _OverlapBehaviorSceneState extends State<_OverlapBehaviorScene> {
  _ProbePacket? _probe;
  HitTestBehavior _front = HitTestBehavior.opaque;
  HitTestBehavior _middle = HitTestBehavior.translucent;
  HitTestBehavior _back = HitTestBehavior.deferToChild;
  bool _showGrid = true;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 940.0 : 1120.0;
    return SizedBox(
      height: h,
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
                      const Text('Layer behavior controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _BehaviorEditor(
                        title: 'Front layer behavior',
                        value: _front,
                        onChanged: (v) => setState(() => _front = v),
                      ),
                      const SizedBox(height: 8),
                      _BehaviorEditor(
                        title: 'Middle layer behavior',
                        value: _middle,
                        onChanged: (v) => setState(() => _middle = v),
                      ),
                      const SizedBox(height: 8),
                      _BehaviorEditor(
                        title: 'Back layer behavior',
                        value: _back,
                        onChanged: (v) => setState(() => _back = v),
                      ),
                      SwitchListTile(
                        value: _showGrid,
                        onChanged: (v) => setState(() => _showGrid = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show position grid overlay'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('phase', _probe?.phase ?? 'none'),
                          _DataRowItem('pointer local', _formatOffset(_probe?.localPosition)),
                          _DataRowItem('metadata hits', '${_probe?.hits.length ?? 0}'),
                          _DataRowItem('front', _front.name),
                          _DataRowItem('middle', _middle.name),
                          _DataRowItem('back', _back.name),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_probe != null)
                        _HitStackCard(
                          title: 'Overlap hit-test metadata stack',
                          tone: _teal,
                          hits: _probe!.hits,
                        ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _teal,
                          lines: const [
                            'Opaque behavior captures hit testing over the entire metadata box region.',
                            'Translucent keeps the node in the hit-test path while still allowing targets behind to participate.',
                            'DeferToChild only contributes if the wrapped child reports a hit result.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Behavior events', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 200, child: _LogCard(lines: _events)),
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
                child: _MetaProbeSurface(
                  onProbe: (packet) {
                    setState(() {
                      _probe = packet;
                      _events.insert(0, '${_clock()} | ${packet.phase} ${_formatOffset(packet.localPosition)} | ${packet.hits.length} hits');
                      if (_events.length > 38) {
                        _events.removeRange(38, _events.length);
                      }
                    });
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(child: _ToneBackdrop(tone: _teal, label: 'Overlap behavior board')),
                      if (_showGrid) const Positioned.fill(child: CustomPaint(painter: _GridPainter())),
                      Align(
                        alignment: const Alignment(-0.18, -0.14),
                        child: MetaData(
                          metaData: const _MetaTag(
                            id: 'overlap.front',
                            zone: 'overlap',
                            purpose: 'front visual lane',
                            detail: 'first responder in stack layout',
                            priority: 1,
                          ),
                          behavior: _front,
                          child: _OverlapLayer(
                            tone: _teal,
                            title: 'Front Layer',
                            subtitle: 'behavior: ${_front.name}',
                            width: 360,
                            height: 220,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.08, 0.00),
                        child: MetaData(
                          metaData: const _MetaTag(
                            id: 'overlap.middle',
                            zone: 'overlap',
                            purpose: 'middle visual lane',
                            detail: 'second layer in stack sequence',
                            priority: 2,
                          ),
                          behavior: _middle,
                          child: _OverlapLayer(
                            tone: _amber,
                            title: 'Middle Layer',
                            subtitle: 'behavior: ${_middle.name}',
                            width: 330,
                            height: 200,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.32, 0.18),
                        child: MetaData(
                          metaData: const _MetaTag(
                            id: 'overlap.back',
                            zone: 'overlap',
                            purpose: 'back visual lane',
                            detail: 'deep layer with context payload',
                            priority: 3,
                          ),
                          behavior: _back,
                          child: _OverlapLayer(
                            tone: _rose,
                            title: 'Back Layer',
                            subtitle: 'behavior: ${_back.name}',
                            width: 300,
                            height: 180,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Container(
                          width: 260,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _teal.withValues(alpha: 0.32)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tap around the overlap zones', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                              SizedBox(height: 4),
                              Text('Watch how metadata path entries differ by behavior mode and depth ordering.', style: TextStyle(fontSize: 11)),
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
        ],
      ),
    );
  }
}

class _BehaviorEditor extends StatelessWidget {
  const _BehaviorEditor({required this.title, required this.value, required this.onChanged});

  final String title;
  final HitTestBehavior value;
  final ValueChanged<HitTestBehavior> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<HitTestBehavior>(
      initialValue: value,
      decoration: InputDecoration(labelText: title, border: const OutlineInputBorder()),
      items: const [
        DropdownMenuItem(value: HitTestBehavior.opaque, child: Text('opaque')),
        DropdownMenuItem(value: HitTestBehavior.translucent, child: Text('translucent')),
        DropdownMenuItem(value: HitTestBehavior.deferToChild, child: Text('deferToChild')),
      ],
      onChanged: (v) => onChanged(v ?? value),
    );
  }
}

class _OverlapLayer extends StatelessWidget {
  const _OverlapLayer({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.width,
    required this.height,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.70), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 12)),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: MetaData(
                  metaData: '$title.action.left',
                  behavior: HitTestBehavior.deferToChild,
                  child: FilledButton.tonal(onPressed: () {}, child: const Text('left action')),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MetaData(
                  metaData: '$title.action.right',
                  behavior: HitTestBehavior.deferToChild,
                  child: FilledButton.tonal(onPressed: () {}, child: const Text('right action')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HoverInspectorScene extends StatefulWidget {
  const _HoverInspectorScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_HoverInspectorScene> createState() => _HoverInspectorSceneState();
}

class _HoverInspectorSceneState extends State<_HoverInspectorScene> {
  _ProbePacket? _probe;
  bool _hoverEnabled = true;
  String _activeNode = 'none';
  final List<String> _timeline = <String>[];
  int _refresh = 0;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 960.0 : 1140.0;
    return SizedBox(
      height: h,
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
                      const Text('Hover inspector controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _hoverEnabled,
                        onChanged: (v) => setState(() => _hoverEnabled = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable hover probe events'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => setState(() => _refresh += 1),
                            child: Text('Refresh map ($_refresh)'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => setState(() => _timeline.clear()),
                            child: const Text('Clear timeline'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('active node', _activeNode),
                          _DataRowItem('phase', _probe?.phase ?? 'none'),
                          _DataRowItem('position', _formatOffset(_probe?.localPosition)),
                          _DataRowItem('metadata hits', '${_probe?.hits.length ?? 0}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_probe != null)
                        _HitStackCard(
                          title: 'Hover path metadata stack',
                          tone: _amber,
                          hits: _probe!.hits,
                        ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'Hover probes are useful for diagnostics overlays where taps are not always the primary interaction.',
                            'MetaData payloads can include stable IDs that align logs with UI map nodes and ownership groups.',
                            'For interpreter workflows, this gives visual and textual traceability without invasive widget rewrites.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Hover timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 220, child: _LogCard(lines: _timeline)),
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
                child: _MetaProbeSurface(
                  trackHover: _hoverEnabled,
                  onProbe: (packet) {
                    setState(() {
                      _probe = packet;
                      _timeline.insert(0, '${_clock()} | ${packet.phase} @ ${_formatOffset(packet.localPosition)} | hits=${packet.hits.length}');
                      if (_timeline.length > 42) {
                        _timeline.removeRange(42, _timeline.length);
                      }
                    });
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(child: _ToneBackdrop(tone: _amber, label: 'Hover inspector map')),
                      _HoverNode(
                        align: const Alignment(-0.82, -0.66),
                        tone: _blue,
                        title: 'gateway',
                        tag: const _MetaTag(
                          id: 'map.gateway',
                          zone: 'map',
                          purpose: 'entry node',
                          detail: 'root of route decision map',
                          priority: 1,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      _HoverNode(
                        align: const Alignment(-0.42, -0.48),
                        tone: _teal,
                        title: 'routing',
                        tag: const _MetaTag(
                          id: 'map.routing',
                          zone: 'map',
                          purpose: 'routing branch',
                          detail: 'navigation branch assignment',
                          priority: 2,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      _HoverNode(
                        align: const Alignment(0.00, -0.62),
                        tone: _violet,
                        title: 'auth',
                        tag: const _MetaTag(
                          id: 'map.auth',
                          zone: 'map',
                          purpose: 'authorization branch',
                          detail: 'privilege gates and token checks',
                          priority: 2,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      _HoverNode(
                        align: const Alignment(0.42, -0.42),
                        tone: _rose,
                        title: 'audit',
                        tag: const _MetaTag(
                          id: 'map.audit',
                          zone: 'map',
                          purpose: 'audit branch',
                          detail: 'history and compliance traces',
                          priority: 3,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      _HoverNode(
                        align: const Alignment(0.76, -0.08),
                        tone: _amber,
                        title: 'delivery',
                        tag: const _MetaTag(
                          id: 'map.delivery',
                          zone: 'map',
                          purpose: 'delivery branch',
                          detail: 'queue dispatch and status',
                          priority: 2,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      _HoverNode(
                        align: const Alignment(0.44, 0.30),
                        tone: _teal,
                        title: 'metrics',
                        tag: const _MetaTag(
                          id: 'map.metrics',
                          zone: 'map',
                          purpose: 'metrics collector',
                          detail: 'event and state aggregation',
                          priority: 3,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      _HoverNode(
                        align: const Alignment(0.04, 0.48),
                        tone: _blue,
                        title: 'feedback',
                        tag: const _MetaTag(
                          id: 'map.feedback',
                          zone: 'map',
                          purpose: 'feedback sink',
                          detail: 'quality and journey notes',
                          priority: 3,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      _HoverNode(
                        align: const Alignment(-0.38, 0.32),
                        tone: _violet,
                        title: 'bridge',
                        tag: const _MetaTag(
                          id: 'map.bridge',
                          zone: 'map',
                          purpose: 'interpreter bridge',
                          detail: 'runtime bridge status relay',
                          priority: 1,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      _HoverNode(
                        align: const Alignment(-0.76, 0.02),
                        tone: _rose,
                        title: 'archive',
                        tag: const _MetaTag(
                          id: 'map.archive',
                          zone: 'map',
                          purpose: 'archive writer',
                          detail: 'persistent timeline sink',
                          priority: 2,
                        ),
                        onActive: (v) => setState(() => _activeNode = v),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Container(
                          width: 272,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _amber.withValues(alpha: 0.35)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Node map behavior', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                              SizedBox(height: 4),
                              Text('Move pointer over nodes and inspect metadata path changes across map zones.', style: TextStyle(fontSize: 11)),
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
        ],
      ),
    );
  }
}

class _HoverNode extends StatefulWidget {
  const _HoverNode({
    required this.align,
    required this.tone,
    required this.title,
    required this.tag,
    required this.onActive,
  });

  final Alignment align;
  final Color tone;
  final String title;
  final _MetaTag tag;
  final ValueChanged<String> onActive;

  @override
  State<_HoverNode> createState() => _HoverNodeState();
}

class _HoverNodeState extends State<_HoverNode> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.align,
      child: MetaData(
        metaData: widget.tag,
        behavior: HitTestBehavior.translucent,
        child: MouseRegion(
          onEnter: (_) {
            setState(() => _hovered = true);
            widget.onActive(widget.title);
          },
          onExit: (_) {
            setState(() => _hovered = false);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: _hovered ? 132 : 114,
            height: _hovered ? 86 : 72,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: widget.tone, width: _hovered ? 2.4 : 1.4),
              boxShadow: [
                BoxShadow(color: widget.tone.withValues(alpha: _hovered ? 0.22 : 0.12), blurRadius: _hovered ? 12 : 7, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 12)),
                const SizedBox(height: 3),
                Text(widget.tag.id, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10)),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: widget.tone.withValues(alpha: _hovered ? 1 : 0.45)),
                    const SizedBox(width: 4),
                    Text(_hovered ? 'active' : 'idle', style: const TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CatalogScene extends StatefulWidget {
  const _CatalogScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_CatalogScene> createState() => _CatalogSceneState();
}

class _CatalogSceneState extends State<_CatalogScene> {
  _ProbePacket? _probe;
  String _filter = 'all';
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1180.0;
    return SizedBox(
      height: h,
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
                      const Text('Catalog controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: _filter,
                        decoration: const InputDecoration(labelText: 'Zone filter', border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(value: 'all', child: Text('all zones')),
                          DropdownMenuItem(value: 'catalog', child: Text('catalog zone')),
                          DropdownMenuItem(value: 'ops', child: Text('ops zone')),
                          DropdownMenuItem(value: 'support', child: Text('support zone')),
                        ],
                        onChanged: (v) => setState(() => _filter = v ?? _filter),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('phase', _probe?.phase ?? 'none'),
                          _DataRowItem('position', _formatOffset(_probe?.localPosition)),
                          _DataRowItem('hits', '${_probe?.hits.length ?? 0}'),
                          _DataRowItem('zone filter', _filter),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_probe != null)
                        _HitStackCard(
                          title: 'Catalog metadata stack',
                          tone: _rose,
                          hits: _probe!.hits,
                        ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'In list-heavy interfaces, MetaData can tag item cards, controls, and nested modules with stable diagnostics IDs.',
                            'Filter-friendly payloads improve triage when logs are inspected by zone or by operational ownership.',
                            'For interpreter demos, visual catalogs help verify that payloads remain attached under scroll and nested interaction.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Catalog event log', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 230, child: _LogCard(lines: _events)),
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
                child: _MetaProbeSurface(
                  onProbe: (probe) {
                    setState(() {
                      _probe = probe;
                      _events.insert(0, '${_clock()} | ${probe.phase} | ${_formatOffset(probe.localPosition)} | ${probe.hits.length} hits');
                      if (_events.length > 44) {
                        _events.removeRange(44, _events.length);
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            _CatalogCard(
                              tone: _blue,
                              title: 'Routing Summary',
                              subtitle: 'Zone map and route ownership summary.',
                              zone: 'catalog',
                              visible: _filter == 'all' || _filter == 'catalog',
                              tag: const _MetaTag(
                                id: 'catalog.routing.summary',
                                zone: 'catalog',
                                purpose: 'overview panel',
                                detail: 'route ownership baseline module',
                                priority: 1,
                              ),
                            ),
                            _CatalogCard(
                              tone: _teal,
                              title: 'Ops Queue',
                              subtitle: 'Processing queue with pending task hints.',
                              zone: 'ops',
                              visible: _filter == 'all' || _filter == 'ops',
                              tag: const _MetaTag(
                                id: 'catalog.ops.queue',
                                zone: 'ops',
                                purpose: 'queue panel',
                                detail: 'current processing queue metadata',
                                priority: 2,
                              ),
                            ),
                            _CatalogCard(
                              tone: _amber,
                              title: 'Audit Timelines',
                              subtitle: 'Recent compliance checkpoints and changes.',
                              zone: 'support',
                              visible: _filter == 'all' || _filter == 'support',
                              tag: const _MetaTag(
                                id: 'catalog.audit.timeline',
                                zone: 'support',
                                purpose: 'history panel',
                                detail: 'timeline feed instrumentation',
                                priority: 2,
                              ),
                            ),
                            _CatalogCard(
                              tone: _rose,
                              title: 'Feedback Mailbox',
                              subtitle: 'User quality notes and internal triage.',
                              zone: 'support',
                              visible: _filter == 'all' || _filter == 'support',
                              tag: const _MetaTag(
                                id: 'catalog.feedback.mailbox',
                                zone: 'support',
                                purpose: 'feedback aggregation',
                                detail: 'quality mailbox collector',
                                priority: 3,
                              ),
                            ),
                            _CatalogCard(
                              tone: _violet,
                              title: 'Bridge Report',
                              subtitle: 'Interpreter bridge snapshots and drift alerts.',
                              zone: 'ops',
                              visible: _filter == 'all' || _filter == 'ops',
                              tag: const _MetaTag(
                                id: 'catalog.bridge.report',
                                zone: 'ops',
                                purpose: 'bridge diagnostics panel',
                                detail: 'links bridge checks to card actions',
                                priority: 1,
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
          ),
        ],
      ),
    );
  }
}

class _CatalogCard extends StatefulWidget {
  const _CatalogCard({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.zone,
    required this.visible,
    required this.tag,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final String zone;
  final bool visible;
  final _MetaTag tag;

  @override
  State<_CatalogCard> createState() => _CatalogCardState();
}

class _CatalogCardState extends State<_CatalogCard> {
  bool _expanded = false;
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MetaData(
        metaData: widget.tag,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.tone.withValues(alpha: 0.33)),
            boxShadow: [
              BoxShadow(color: widget.tone.withValues(alpha: 0.12), blurRadius: 7, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
                  _LaneChip(tone: widget.tone, label: widget.zone),
                ],
              ),
              const SizedBox(height: 4),
              Text(widget.subtitle, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: MetaData(
                      metaData: '${widget.tag.id}.primary',
                      behavior: HitTestBehavior.deferToChild,
                      child: FilledButton.tonal(
                        onPressed: () => setState(() => _clicks += 1),
                        child: const Text('Primary action'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MetaData(
                      metaData: '${widget.tag.id}.expand',
                      behavior: HitTestBehavior.deferToChild,
                      child: FilledButton.tonal(
                        onPressed: () => setState(() => _expanded = !_expanded),
                        child: Text(_expanded ? 'Collapse' : 'Expand'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              if (_expanded)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.tone.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('meta id: ${widget.tag.id}', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w700, fontSize: 12)),
                      Text('purpose: ${widget.tag.purpose}', style: const TextStyle(fontSize: 11)),
                      Text('detail: ${widget.tag.detail}', style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              const SizedBox(height: 4),
              Text('action count: $_clicks', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
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
  _ProbePacket? _probe;
  final List<String> _events = <String>[];
  bool _trackMove = false;
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1180.0 : 1380.0;
    return SizedBox(
      height: h,
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
                        FilterChip(
                          selected: _trackMove,
                          label: const Text('Track move probes'),
                          onSelected: (v) => setState(() => _trackMove = v),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _revision += 1),
                          child: Text('Refresh modules ($_revision)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _events.clear()),
                          child: const Text('Clear event log'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _MetaProbeSurface(
                        trackMove: _trackMove,
                        onProbe: (packet) {
                          setState(() {
                            _probe = packet;
                            _events.insert(0, '${_clock()} | ${packet.phase} @ ${_formatOffset(packet.localPosition)} | ${packet.hits.length} hits');
                            if (_events.length > 52) {
                              _events.removeRange(52, _events.length);
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: _OperationsModule(
                                tone: _blue,
                                title: 'Command Orchestrator',
                                subtitle: 'Route command execution and retries.',
                                revision: _revision,
                                lane: 'command',
                                onEvent: (e) => _pushEvent('orchestrator: $e'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _OperationsModule(
                                tone: _teal,
                                title: 'Metric Dashboard',
                                subtitle: 'Monitor bridge and queue quality indicators.',
                                revision: _revision,
                                lane: 'metrics',
                                onEvent: (e) => _pushEvent('metrics: $e'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _OperationsModule(
                                tone: _violet,
                                title: 'Recovery Controls',
                                subtitle: 'Apply mitigations and route safeguards.',
                                revision: _revision,
                                lane: 'recovery',
                                onEvent: (e) => _pushEvent('recovery: $e'),
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
                    const Text('Operations diagnostics', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _DataTableCard(
                      rows: [
                        _DataRowItem('phase', _probe?.phase ?? 'none'),
                        _DataRowItem('position', _formatOffset(_probe?.localPosition)),
                        _DataRowItem('hits', '${_probe?.hits.length ?? 0}'),
                        _DataRowItem('revision', '$_revision'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_probe != null)
                      _HitStackCard(
                        title: 'Practical metadata stack',
                        tone: _violet,
                        hits: _probe!.hits,
                      ),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _violet,
                        lines: const [
                          'Attach MetaData to module boundaries, control actions, and status tiles for targeted diagnostics.',
                          'Stable metadata IDs make replay and bug triage easier when interpreter logs are reviewed later.',
                          'Use behavior modes intentionally: opaque for module shells, deferToChild for precise controls.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Operational event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _LogCard(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pushEvent(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      if (_events.length > 52) {
        _events.removeRange(52, _events.length);
      }
    });
  }
}

class _OperationsModule extends StatefulWidget {
  const _OperationsModule({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.revision,
    required this.lane,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final int revision;
  final String lane;
  final ValueChanged<String> onEvent;

  @override
  State<_OperationsModule> createState() => _OperationsModuleState();
}

class _OperationsModuleState extends State<_OperationsModule> {
  double _pressure = 0.4;
  bool _flagA = false;
  bool _flagB = true;
  int _ack = 0;

  @override
  Widget build(BuildContext context) {
    return MetaData(
      metaData: _MetaTag(
        id: 'practical.${widget.lane}.module',
        zone: 'practical',
        purpose: 'module shell',
        detail: widget.title,
        priority: 1,
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.tone.withValues(alpha: 0.34)),
          boxShadow: [
            BoxShadow(color: widget.tone.withValues(alpha: 0.14), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
                _LaneChip(tone: widget.tone, label: widget.lane),
              ],
            ),
            const SizedBox(height: 3),
            Text(widget.subtitle, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            MetaData(
              metaData: 'practical.${widget.lane}.pressure',
              behavior: HitTestBehavior.deferToChild,
              child: _MiniSlider(
                label: 'Pressure',
                value: _pressure,
                min: 0,
                max: 1,
                onChanged: (v) {
                  setState(() => _pressure = v);
                  widget.onEvent('pressure=${v.toStringAsFixed(2)}');
                },
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: MetaData(
                    metaData: 'practical.${widget.lane}.flagA',
                    behavior: HitTestBehavior.deferToChild,
                    child: SwitchListTile(
                      value: _flagA,
                      onChanged: (v) {
                        setState(() => _flagA = v);
                        widget.onEvent('flagA=$v');
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Flag A', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: MetaData(
                    metaData: 'practical.${widget.lane}.flagB',
                    behavior: HitTestBehavior.deferToChild,
                    child: SwitchListTile(
                      value: _flagB,
                      onChanged: (v) {
                        setState(() => _flagB = v);
                        widget.onEvent('flagB=$v');
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Flag B', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: MetaData(
                metaData: 'practical.${widget.lane}.insight',
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.tone.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('revision: ${widget.revision}', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w700, fontSize: 11)),
                      Text('pressure: ${_pressure.toStringAsFixed(2)}', style: const TextStyle(fontSize: 11)),
                      Text('flags: A=$_flagA B=$_flagB', style: const TextStyle(fontSize: 11)),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () {
                                setState(() => _ack += 1);
                                widget.onEvent('ack count=$_ack');
                              },
                              child: const Text('Acknowledge'),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () {
                                widget.onEvent('snapshot issued');
                              },
                              child: const Text('Snapshot'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text('acknowledgements: $_ack', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _HitStackCard extends StatelessWidget {
  const _HitStackCard({required this.title, required this.tone, required this.hits});

  final String title;
  final Color tone;
  final List<_MetaHitView> hits;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (hits.isEmpty)
            const Text('No RenderMetaData entries at this pointer position.', style: TextStyle(fontSize: 12))
          else
            ...hits.map(
              (hit) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  'depth ${hit.depth} | behavior ${hit.behavior} | ${hit.targetType} | ${hit.payload}',
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LaneChip extends StatelessWidget {
  const _LaneChip({required this.tone, required this.label});

  final Color tone;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }
}

class _ToneBackdrop extends StatelessWidget {
  const _ToneBackdrop({required this.tone, required this.label});

  final Color tone;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tone.withValues(alpha: 0.14), Colors.white, tone.withValues(alpha: 0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 11)),
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
          if (guides) const CustomPaint(painter: _GridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

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

class _DataRowItem {
  const _DataRowItem(this.label, this.value);

  final String label;
  final String value;
}

class _DataTableCard extends StatelessWidget {
  const _DataTableCard({required this.rows});

  final List<_DataRowItem> rows;

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
                    SizedBox(width: 130, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
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

class _MiniSlider extends StatelessWidget {
  const _MiniSlider({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 64, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(child: Slider(value: value, min: min, max: max, onChanged: onChanged)),
      ],
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.lines});

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

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

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
          Text('Recap: MetaData', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'MetaData is a powerful, low-ceremony way to attach contextual payloads directly to hit-test paths. '
            'When combined with clear visual structure, it becomes a strong tool for diagnostics, analytics correlation, and interaction-aware interpreter workflows.',
            style: TextStyle(color: Color(0xFFD8E9F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);

String _formatOffset(Offset? offset) {
  if (offset == null) {
    return 'n/a';
  }
  return '${offset.dx.toStringAsFixed(1)}, ${offset.dy.toStringAsFixed(1)}';
}

