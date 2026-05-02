// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// Deep demo for DragTargetDetails<T>.
//
// Unlike the prior version of this file, every drag/drop is *live*: real
// Draggable<T> sources are paired with real DragTarget<T> sinks, and every
// callback (onWillAcceptWithDetails, onAcceptWithDetails, onMove, onLeave)
// is exercised against the running widget tree.  The state mutated by those
// callbacks drives the visible UI: an event log, last-drop banners, a
// data-inspector card, lane totals, a coordinate marker, a trash list, a
// shelf, a rank row, and so on.
//
// Twelve sections (see DESIGN PLAN in the conversation):
//   1) Anatomy banner                7) Offset tracker (global vs local)
//   2) Int drop zone                 8) Data inspector card
//   3) Multi-basket typed strings    9) Trash can recipe
//   4) Parcel dispatcher (custom T) 10) File shelf (custom T, sorted)
//   5) Hover preview via onMove     11) Rank reorder slots
//   6) Accept/reject visualizer     12) Pitfalls + reference table
// =============================================================================

// -------- Custom payload types used as <T> for Draggable/DragTarget --------

class Parcel {
  final String label;
  final String kind; // 'mail' | 'box' | 'fragile'
  final double weightKg;
  const Parcel(this.label, this.kind, this.weightKg);

  @override
  String toString() => 'Parcel($label,$kind,${weightKg}kg)';
}

class MyFile {
  final String name;
  final String ext;
  final int sizeKb;
  const MyFile(this.name, this.ext, this.sizeKb);

  @override
  String toString() => 'MyFile($name.$ext,${sizeKb}kb)';
}

// A single LogEntry that any callback can append.  We capture data, offset,
// the source zone label, and an outcome marker so the event log card can
// render a colour for every line.
class LogEntry {
  final String zone;
  final String outcome; // 'accept' | 'reject' | 'leave' | 'move'
  final String dataDesc;
  final Offset offset;
  final DateTime ts;
  LogEntry({
    required this.zone,
    required this.outcome,
    required this.dataDesc,
    required this.offset,
    required this.ts,
  });
}

// Helper: turn an Offset into a short, readable string.
String fmtOffset(Offset o) =>
    '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';

// -----------------------------------------------------------------------------
// Top-level harness entry point required by the harness contract.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('DragTargetDetails deep-demo: build() invoked');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DragTargetDetails Live Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const _DragDetailsHome(),
  );
}

// -----------------------------------------------------------------------------
// Stateful root widget.  All sections share a single state object so that
// drops in one card can update banners and the inspector in other cards.
// -----------------------------------------------------------------------------
class _DragDetailsHome extends StatefulWidget {
  const _DragDetailsHome();

  @override
  State<_DragDetailsHome> createState() => _DragDetailsHomeState();
}

class _DragDetailsHomeState extends State<_DragDetailsHome> {
  // ---- Section 1 / 8 — global "last drop" inspector --------------------------
  Type? lastDataType;
  String? lastDataDesc;
  Offset? lastOffset;
  String? lastZone;
  int totalDrops = 0;
  int totalRejects = 0;

  // ---- Section 2 — running int sum ------------------------------------------
  int intSum = 0;
  final List<int> intHistory = <int>[];
  Offset? lastIntOffset;

  // ---- Section 3 — multi-basket String state --------------------------------
  final Map<String, List<String>> basket = {
    'fruits': <String>[],
    'veggies': <String>[],
    'grains': <String>[],
  };
  final Map<String, Offset?> basketOffsets = {
    'fruits': null,
    'veggies': null,
    'grains': null,
  };

  // ---- Section 4 — Parcel dispatcher state ----------------------------------
  final Map<String, double> parcelLaneWeight = {
    'mail': 0.0,
    'box': 0.0,
    'fragile': 0.0,
  };
  final Map<String, int> parcelLaneCount = {
    'mail': 0,
    'box': 0,
    'fragile': 0,
  };
  final Map<String, Offset?> parcelLaneOffset = {
    'mail': null,
    'box': null,
    'fragile': null,
  };

  // ---- Section 5 — hover preview --------------------------------------------
  Offset? hoverGlobal;
  Offset? hoverLocal;
  bool hoverWouldAccept = false;
  final GlobalKey hoverPadKey = GlobalKey();

  // ---- Section 6 — accept/reject visualizer ---------------------------------
  final List<String> visualLog = <String>[];

  // ---- Section 7 — offset tracker -------------------------------------------
  final List<Offset> trackerLocalDots = <Offset>[];
  final GlobalKey trackerKey = GlobalKey();
  Offset? trackerLastGlobal;
  Offset? trackerLastLocal;

  // ---- Section 9 — trash --------------------------------------------------
  final List<({String item, Offset offset})> trashed = [];

  // ---- Section 10 — file shelf ----------------------------------------------
  final List<({MyFile file, double dropX})> shelf = [];
  final GlobalKey shelfKey = GlobalKey();

  // ---- Section 11 — rank reorder slots --------------------------------------
  final List<int?> rankSlots = <int?>[null, null, null, null, null];
  final List<GlobalKey> rankKeys =
      List<GlobalKey>.generate(5, (_) => GlobalKey());
  String rankNote = 'Drop a number onto the row; the closest slot wins.';

  // ---- Cross-cutting event log ----------------------------------------------
  final List<LogEntry> events = <LogEntry>[];

  void _record({
    required String zone,
    required String outcome,
    required String dataDesc,
    required Offset offset,
    required Type dataType,
  }) {
    events.insert(
      0,
      LogEntry(
        zone: zone,
        outcome: outcome,
        dataDesc: dataDesc,
        offset: offset,
        ts: DateTime.now(),
      ),
    );
    if (events.length > 40) {
      events.removeRange(40, events.length);
    }
    lastDataType = dataType;
    lastDataDesc = dataDesc;
    lastOffset = offset;
    lastZone = zone;
    if (outcome == 'accept') {
      totalDrops++;
    } else if (outcome == 'reject') {
      totalRejects++;
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return Scaffold(
      appBar: AppBar(
        title: const Text('DragTargetDetails<T> — Live Deep Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnatomyBanner(context),
              const SizedBox(height: 16),
              _buildIntDropZone(context),
              const SizedBox(height: 16),
              _buildBasketSection(context),
              const SizedBox(height: 16),
              _buildParcelDispatcher(context),
              const SizedBox(height: 16),
              _buildHoverPreview(context),
              const SizedBox(height: 16),
              _buildAcceptRejectVisualizer(context),
              const SizedBox(height: 16),
              _buildOffsetTracker(context),
              const SizedBox(height: 16),
              _buildInspectorCard(context),
              const SizedBox(height: 16),
              _buildTrashRecipe(context),
              const SizedBox(height: 16),
              _buildFileShelf(context),
              const SizedBox(height: 16),
              _buildRankSlots(context),
              const SizedBox(height: 16),
              _buildPitfallsAndReference(context),
              const SizedBox(height: 16),
              _buildEventLogCard(context),
              const SizedBox(height: 16),
              _buildPlatformFooter(context, platform),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 1 — Anatomy banner with live ticker
  // ===========================================================================
  Widget _buildAnatomyBanner(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.primaryContainer,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.science, color: scheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Text(
                  '1 — Anatomy of DragTargetDetails<T>',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'A DragTargetDetails<T> is an immutable record passed by '
              'Flutter into onAcceptWithDetails / onWillAcceptWithDetails / '
              'onMoveWithDetails. It exposes two fields:\n'
              '  • data: T  — the payload carried by the matching Draggable<T>\n'
              '  • offset: Offset — pointer position in *global* coordinates '
              'at the moment of the event.\n\n'
              'In every section below, real callbacks read those fields and '
              'mutate the state you see on screen.',
              style: TextStyle(color: scheme.onPrimaryContainer),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _statChip('Drops', '$totalDrops', Colors.green),
                _statChip('Rejections', '$totalRejects', Colors.red),
                _statChip(
                  'Last zone',
                  lastZone ?? '—',
                  Colors.blueGrey,
                ),
                _statChip(
                  'Last data',
                  lastDataDesc ?? '—',
                  Colors.deepOrange,
                ),
                _statChip(
                  'Last offset',
                  lastOffset == null ? '—' : fmtOffset(lastOffset!),
                  Colors.indigo,
                ),
                _statChip(
                  'Data type',
                  lastDataType?.toString() ?? '—',
                  Colors.teal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statChip(String k, String v, Color c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: c.withOpacity(0.15),
          border: Border.all(color: c, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$k: $v',
          style: TextStyle(color: c, fontWeight: FontWeight.w600),
        ),
      );

  // ===========================================================================
  // SECTION 2 — Simple Draggable<int> + DragTarget<int>
  // ===========================================================================
  Widget _buildIntDropZone(BuildContext context) {
    return _SectionCard(
      title: '2 — Draggable<int> into DragTarget<int>',
      subtitle:
          'Each int chip is a Draggable<int>. The drop zone is a DragTarget<int>; '
          'its onAcceptWithDetails reads details.data (int) and details.offset.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final n in [1, 2, 3, 5, 8, 13, 21])
                Draggable<int>(
                  data: n,
                  feedback: _IntChip(n: n, dragging: true),
                  childWhenDragging: _IntChip(n: n, faded: true),
                  child: _IntChip(n: n),
                ),
            ],
          ),
          const SizedBox(height: 12),
          DragTarget<int>(
            onWillAcceptWithDetails: (details) {
              // Reject zero (won't happen here, but documents the API).
              return details.data != 0;
            },
            onAcceptWithDetails: (details) {
              setState(() {
                intSum += details.data;
                intHistory.add(details.data);
                lastIntOffset = details.offset;
                _record(
                  zone: 'int-zone',
                  outcome: 'accept',
                  dataDesc: '${details.data}',
                  offset: details.offset,
                  dataType: details.data.runtimeType,
                );
              });
            },
            onLeave: (data) {
              setState(() {
                _record(
                  zone: 'int-zone',
                  outcome: 'leave',
                  dataDesc: '$data',
                  offset: Offset.zero,
                  dataType: int,
                );
              });
            },
            builder: (ctx, candidate, rejected) {
              final hovering = candidate.isNotEmpty;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 110,
                decoration: BoxDecoration(
                  color: hovering
                      ? Colors.green.withOpacity(0.18)
                      : Colors.grey.withOpacity(0.08),
                  border: Border.all(
                    color: hovering ? Colors.green : Colors.grey,
                    width: hovering ? 3 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  hovering
                      ? 'Release to add ${candidate.first}'
                      : 'Drop ints here  —  running sum: $intSum',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            'History: ${intHistory.isEmpty ? "(none)" : intHistory.join(" + ")}'
            '${intHistory.isEmpty ? "" : " = $intSum"}',
            style: const TextStyle(fontFamily: 'monospace'),
          ),
          if (lastIntOffset != null) ...[
            const SizedBox(height: 4),
            Text(
              'Last drop global offset: ${fmtOffset(lastIntOffset!)}',
              style: const TextStyle(color: Colors.indigo),
            ),
          ],
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  intSum = 0;
                  intHistory.clear();
                  lastIntOffset = null;
                });
              },
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset int zone'),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 3 — Multi-basket typed Strings
  // ===========================================================================
  Widget _buildBasketSection(BuildContext context) {
    final fruits = ['apple', 'banana', 'cherry'];
    final veggies = ['carrot', 'kale', 'onion'];
    final grains = ['rice', 'oats', 'wheat'];

    return _SectionCard(
      title: '3 — Three typed baskets (Draggable<String>)',
      subtitle:
          'Each basket is a DragTarget<String> that uses '
          'onWillAcceptWithDetails to reject items from the wrong category.',
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in [...fruits, ...veggies, ...grains])
                Draggable<String>(
                  data: s,
                  feedback: _StrChip(label: s, dragging: true),
                  childWhenDragging: _StrChip(label: s, faded: true),
                  child: _StrChip(label: s),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _basketTarget('fruits', fruits, Colors.redAccent),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _basketTarget('veggies', veggies, Colors.green),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _basketTarget('grains', grains, Colors.brown),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _basketTarget(String name, List<String> allowed, Color color) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (details) {
        // Only accept strings in this basket's allow-list.
        return allowed.contains(details.data);
      },
      onAcceptWithDetails: (details) {
        setState(() {
          basket[name]!.add(details.data);
          basketOffsets[name] = details.offset;
          _record(
            zone: 'basket-$name',
            outcome: 'accept',
            dataDesc: details.data,
            offset: details.offset,
            dataType: String,
          );
        });
      },
      onLeave: (data) {
        if (data != null && !allowed.contains(data)) {
          setState(() {
            _record(
              zone: 'basket-$name',
              outcome: 'reject',
              dataDesc: data,
              offset: Offset.zero,
              dataType: String,
            );
          });
        }
      },
      builder: (ctx, candidate, rejected) {
        final hovering = candidate.isNotEmpty;
        final rejecting = rejected.isNotEmpty;
        return Container(
          height: 150,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hovering
                ? color.withOpacity(0.20)
                : rejecting
                    ? Colors.red.withOpacity(0.15)
                    : color.withOpacity(0.05),
            border: Border.all(
              color: rejecting ? Colors.red : color,
              width: hovering || rejecting ? 3 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Count: ${basket[name]!.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    basket[name]!.isEmpty
                        ? '(empty)'
                        : basket[name]!.join(', '),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              if (basketOffsets[name] != null)
                Text(
                  'last @ ${fmtOffset(basketOffsets[name]!)}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    fontFamily: 'monospace',
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // SECTION 4 — Custom-typed Parcel dispatcher
  // ===========================================================================
  Widget _buildParcelDispatcher(BuildContext context) {
    final parcels = const <Parcel>[
      Parcel('P-1', 'mail', 0.2),
      Parcel('P-2', 'mail', 0.1),
      Parcel('P-3', 'box', 1.4),
      Parcel('P-4', 'box', 2.7),
      Parcel('P-5', 'fragile', 0.8),
      Parcel('P-6', 'fragile', 1.2),
    ];

    return _SectionCard(
      title: '4 — Custom <T = Parcel> dispatcher',
      subtitle:
          'Three DragTarget<Parcel> lanes. onAcceptWithDetails reads '
          'details.data.kind to decide whether to accept and details.data.weightKg '
          'to update the lane total. Position from details.offset is shown.',
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in parcels)
                Draggable<Parcel>(
                  data: p,
                  feedback: _ParcelChip(parcel: p, dragging: true),
                  childWhenDragging: _ParcelChip(parcel: p, faded: true),
                  child: _ParcelChip(parcel: p),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _parcelLane('mail', Colors.blue)),
              const SizedBox(width: 8),
              Expanded(child: _parcelLane('box', Colors.orange)),
              const SizedBox(width: 8),
              Expanded(child: _parcelLane('fragile', Colors.purple)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _parcelLane(String kind, Color color) {
    return DragTarget<Parcel>(
      onWillAcceptWithDetails: (details) => details.data.kind == kind,
      onAcceptWithDetails: (details) {
        setState(() {
          parcelLaneCount[kind] = parcelLaneCount[kind]! + 1;
          parcelLaneWeight[kind] =
              parcelLaneWeight[kind]! + details.data.weightKg;
          parcelLaneOffset[kind] = details.offset;
          _record(
            zone: 'parcel-$kind',
            outcome: 'accept',
            dataDesc: details.data.toString(),
            offset: details.offset,
            dataType: Parcel,
          );
        });
      },
      builder: (ctx, candidate, rejected) {
        final hovering = candidate.isNotEmpty;
        return Container(
          height: 130,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hovering
                ? color.withOpacity(0.20)
                : color.withOpacity(0.06),
            border: Border.all(
              color: color,
              width: hovering ? 3 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                kind.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${parcelLaneCount[kind]} parcels',
                textAlign: TextAlign.center,
              ),
              Text(
                '${parcelLaneWeight[kind]!.toStringAsFixed(1)} kg',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (parcelLaneOffset[kind] != null)
                Text(
                  'last @ ${fmtOffset(parcelLaneOffset[kind]!)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    fontFamily: 'monospace',
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // SECTION 5 — Hover preview using onMove (DragTargetDetails<int>)
  // ===========================================================================
  Widget _buildHoverPreview(BuildContext context) {
    return _SectionCard(
      title: '5 — Live hover preview using onMove',
      subtitle:
          'onMove fires with DragTargetDetails on every pointer movement '
          'inside the target.  We convert details.offset (global) to local '
          'and draw a crosshair where the pointer currently is.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final n in [10, 20, 30, 40, 50])
                Draggable<int>(
                  data: n,
                  feedback: _IntChip(n: n, dragging: true),
                  childWhenDragging: _IntChip(n: n, faded: true),
                  child: _IntChip(n: n),
                ),
            ],
          ),
          const SizedBox(height: 12),
          DragTarget<int>(
            key: hoverPadKey,
            onWillAcceptWithDetails: (details) {
              setState(() {
                hoverWouldAccept = details.data >= 20;
              });
              return details.data >= 20;
            },
            onMove: (details) {
              final box =
                  hoverPadKey.currentContext?.findRenderObject() as RenderBox?;
              setState(() {
                hoverGlobal = details.offset;
                hoverLocal = box?.globalToLocal(details.offset);
                _record(
                  zone: 'hover-pad',
                  outcome: 'move',
                  dataDesc: '${details.data}',
                  offset: details.offset,
                  dataType: int,
                );
              });
            },
            onLeave: (_) {
              setState(() {
                hoverGlobal = null;
                hoverLocal = null;
                hoverWouldAccept = false;
              });
            },
            onAcceptWithDetails: (details) {
              setState(() {
                hoverGlobal = null;
                hoverLocal = null;
                hoverWouldAccept = false;
                _record(
                  zone: 'hover-pad',
                  outcome: 'accept',
                  dataDesc: '${details.data}',
                  offset: details.offset,
                  dataType: int,
                );
              });
            },
            builder: (ctx, candidate, rejected) {
              return SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: hoverWouldAccept
                            ? Colors.green.withOpacity(0.10)
                            : (hoverGlobal != null
                                ? Colors.red.withOpacity(0.10)
                                : Colors.grey.withOpacity(0.05)),
                        border: Border.all(
                          color: hoverWouldAccept
                              ? Colors.green
                              : (hoverGlobal != null
                                  ? Colors.red
                                  : Colors.grey),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        hoverGlobal == null
                            ? 'Hover an int chip here\n(only ≥ 20 is accepted)'
                            : hoverWouldAccept
                                ? 'Release to accept'
                                : 'Will reject',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (hoverLocal != null)
                      Positioned(
                        left: hoverLocal!.dx - 8,
                        top: hoverLocal!.dy - 8,
                        child: IgnorePointer(
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          if (hoverGlobal != null)
            Text(
              'global: ${fmtOffset(hoverGlobal!)}    '
              'local: ${hoverLocal == null ? "—" : fmtOffset(hoverLocal!)}',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 6 — Accept/reject visualizer (evens vs odds)
  // ===========================================================================
  Widget _buildAcceptRejectVisualizer(BuildContext context) {
    return _SectionCard(
      title: '6 — Accept vs reject visualizer',
      subtitle:
          'Two DragTarget<int>: the green target accepts evens, the red '
          'target accepts odds. The log distinguishes accept (✓) from '
          'reject-via-onWillAcceptWithDetails-false (✗).',
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final n in [4, 7, 10, 11, 14, 17])
                Draggable<int>(
                  data: n,
                  feedback: _IntChip(n: n, dragging: true),
                  childWhenDragging: _IntChip(n: n, faded: true),
                  child: _IntChip(n: n),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _arTarget(
                  label: 'evens only',
                  color: Colors.green,
                  predicate: (n) => n % 2 == 0,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _arTarget(
                  label: 'odds only',
                  color: Colors.red,
                  predicate: (n) => n % 2 == 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 110,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: visualLog.isEmpty
                  ? const Center(child: Text('(no events yet)'))
                  : ListView(
                      reverse: true,
                      children: [
                        for (final line in visualLog.reversed)
                          Text(
                            line,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              color: line.startsWith('✓')
                                  ? Colors.green[800]
                                  : Colors.red[800],
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _arTarget({
    required String label,
    required Color color,
    required bool Function(int) predicate,
  }) {
    return DragTarget<int>(
      onWillAcceptWithDetails: (details) {
        final ok = predicate(details.data);
        if (!ok) {
          // Log a rejection synchronously.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            setState(() {
              visualLog.add('✗ rejected ${details.data} at $label');
              _record(
                zone: label,
                outcome: 'reject',
                dataDesc: '${details.data}',
                offset: details.offset,
                dataType: int,
              );
            });
          });
        }
        return ok;
      },
      onAcceptWithDetails: (details) {
        setState(() {
          visualLog.add(
              '✓ accepted ${details.data} at $label ${fmtOffset(details.offset)}');
          _record(
            zone: label,
            outcome: 'accept',
            dataDesc: '${details.data}',
            offset: details.offset,
            dataType: int,
          );
        });
      },
      builder: (ctx, candidate, rejected) {
        final hovering = candidate.isNotEmpty;
        final rejecting = rejected.isNotEmpty;
        return Container(
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: hovering
                ? color.withOpacity(0.25)
                : rejecting
                    ? Colors.red.withOpacity(0.20)
                    : color.withOpacity(0.05),
            border: Border.all(
              color: rejecting ? Colors.red : color,
              width: hovering || rejecting ? 3 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // SECTION 7 — Offset tracker (global vs local conversion)
  // ===========================================================================
  Widget _buildOffsetTracker(BuildContext context) {
    return _SectionCard(
      title: '7 — Offset tracker: global vs local',
      subtitle:
          'details.offset is in *global* coordinates. We convert to local via '
          'RenderBox.globalToLocal and place a dot exactly where you dropped.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final c
                  in ['•A', '•B', '•C', '•D', '•E', '•F'])
                Draggable<String>(
                  data: c,
                  feedback: _StrChip(label: c, dragging: true),
                  childWhenDragging: _StrChip(label: c, faded: true),
                  child: _StrChip(label: c),
                ),
            ],
          ),
          const SizedBox(height: 12),
          DragTarget<String>(
            key: trackerKey,
            onAcceptWithDetails: (details) {
              final box =
                  trackerKey.currentContext?.findRenderObject() as RenderBox?;
              final local = box?.globalToLocal(details.offset);
              setState(() {
                trackerLastGlobal = details.offset;
                trackerLastLocal = local;
                if (local != null) {
                  trackerLocalDots.add(local);
                  if (trackerLocalDots.length > 30) {
                    trackerLocalDots.removeAt(0);
                  }
                }
                _record(
                  zone: 'tracker',
                  outcome: 'accept',
                  dataDesc: details.data,
                  offset: details.offset,
                  dataType: String,
                );
              });
            },
            builder: (ctx, candidate, rejected) {
              final hovering = candidate.isNotEmpty;
              return SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: hovering
                            ? Colors.indigo.withOpacity(0.10)
                            : Colors.indigo.withOpacity(0.04),
                        border: Border.all(color: Colors.indigo, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        trackerLocalDots.isEmpty
                            ? 'Drop labels here to drop a dot'
                            : '${trackerLocalDots.length} drops recorded',
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    for (final p in trackerLocalDots)
                      Positioned(
                        left: p.dx - 4,
                        top: p.dy - 4,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.indigo,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          if (trackerLastGlobal != null)
            Text(
              'last global: ${fmtOffset(trackerLastGlobal!)}    '
              'last local: ${trackerLastLocal == null ? "—" : fmtOffset(trackerLastLocal!)}',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  trackerLocalDots.clear();
                  trackerLastGlobal = null;
                  trackerLastLocal = null;
                });
              },
              icon: const Icon(Icons.clear),
              label: const Text('Clear dots'),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 8 — Data inspector card
  // ===========================================================================
  Widget _buildInspectorCard(BuildContext context) {
    return _SectionCard(
      title: '8 — Data inspector — last DragTargetDetails',
      subtitle:
          'Whichever zone produced the most recent DragTargetDetails, '
          'its fields are dissected here.',
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: lastOffset == null
            ? const Text('No drops yet — interact with any section above.')
            : Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                },
                children: [
                  _row('zone', lastZone ?? '—'),
                  _row('runtime type', 'DragTargetDetails<$lastDataType>'),
                  _row('data', lastDataDesc ?? '—'),
                  _row('data.runtimeType', '$lastDataType'),
                  _row('offset', fmtOffset(lastOffset!)),
                  _row('offset.dx', lastOffset!.dx.toStringAsFixed(2)),
                  _row('offset.dy', lastOffset!.dy.toStringAsFixed(2)),
                  _row(
                    'distance from origin',
                    lastOffset!.distance.toStringAsFixed(2),
                  ),
                  _row('total accepts', '$totalDrops'),
                  _row('total rejects', '$totalRejects'),
                ],
              ),
      ),
    );
  }

  TableRow _row(String k, String v) => TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Text(
              k,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Text(v, style: const TextStyle(fontFamily: 'monospace')),
          ),
        ],
      );

  // ===========================================================================
  // SECTION 9 — Trash can recipe
  // ===========================================================================
  Widget _buildTrashRecipe(BuildContext context) {
    final items = const [
      'note.txt',
      'photo.png',
      'archive.zip',
      'sketch.svg',
      'todo.md',
    ];
    return _SectionCard(
      title: '9 — Recipe: trash can',
      subtitle:
          'Drop any String onto the bin; the bin records the value plus '
          'the global details.offset and lets you restore it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in items)
                if (!trashed.any((e) => e.item == s))
                  Draggable<String>(
                    data: s,
                    feedback: _StrChip(label: s, dragging: true),
                    childWhenDragging: _StrChip(label: s, faded: true),
                    child: _StrChip(label: s),
                  ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                child: DragTarget<String>(
                  onAcceptWithDetails: (details) {
                    setState(() {
                      trashed.add((
                        item: details.data,
                        offset: details.offset,
                      ));
                      _record(
                        zone: 'trash',
                        outcome: 'accept',
                        dataDesc: details.data,
                        offset: details.offset,
                        dataType: String,
                      );
                    });
                  },
                  builder: (ctx, candidate, rejected) {
                    final hovering = candidate.isNotEmpty;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      height: 110,
                      decoration: BoxDecoration(
                        color: hovering
                            ? Colors.red.withOpacity(0.20)
                            : Colors.red.withOpacity(0.05),
                        border: Border.all(
                          color: Colors.red,
                          width: hovering ? 3 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            hovering ? Icons.delete_forever : Icons.delete,
                            size: 36,
                            color: Colors.red[700],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Trash (${trashed.length})',
                            style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: trashed.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('(no trashed items)'),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final t in trashed)
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.05),
                                border: Border.all(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${t.item}  ·  ${fmtOffset(t.offset)}',
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        trashed.removeWhere(
                                            (e) => e.item == t.item);
                                      });
                                    },
                                    child: const Text('restore'),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 10 — File shelf, sorted by drop x
  // ===========================================================================
  Widget _buildFileShelf(BuildContext context) {
    final files = const [
      MyFile('readme', 'md', 4),
      MyFile('icon', 'png', 12),
      MyFile('main', 'dart', 56),
      MyFile('logs', 'txt', 88),
      MyFile('data', 'csv', 120),
    ];
    final shelved = shelf.map((e) => e.file.toString()).toSet();
    return _SectionCard(
      title: '10 — Recipe: file shelf (custom <T = MyFile>)',
      subtitle:
          'A DragTarget<MyFile> shelf that orders accepted files by the '
          'x-coordinate of details.offset (after globalToLocal). Drop on the '
          'left to insert near the top.',
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final f in files)
                if (!shelved.contains(f.toString()))
                  Draggable<MyFile>(
                    data: f,
                    feedback: _FileChip(file: f, dragging: true),
                    childWhenDragging: _FileChip(file: f, faded: true),
                    child: _FileChip(file: f),
                  ),
            ],
          ),
          const SizedBox(height: 12),
          DragTarget<MyFile>(
            key: shelfKey,
            onAcceptWithDetails: (details) {
              final box =
                  shelfKey.currentContext?.findRenderObject() as RenderBox?;
              final local = box?.globalToLocal(details.offset);
              final localX = local?.dx ?? 0.0;
              setState(() {
                shelf.add((file: details.data, dropX: localX));
                shelf.sort((a, b) => a.dropX.compareTo(b.dropX));
                _record(
                  zone: 'shelf',
                  outcome: 'accept',
                  dataDesc: details.data.toString(),
                  offset: details.offset,
                  dataType: MyFile,
                );
              });
            },
            builder: (ctx, candidate, rejected) {
              final hovering = candidate.isNotEmpty;
              return Container(
                height: 130,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: hovering
                      ? Colors.teal.withOpacity(0.18)
                      : Colors.teal.withOpacity(0.05),
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: shelf.isEmpty
                    ? const Center(child: Text('Drop files here'))
                    : ListView(
                        children: [
                          for (var i = 0; i < shelf.length; i++)
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.teal, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${i + 1}. ${shelf[i].file.name}.${shelf[i].file.ext}'
                                ' · ${shelf[i].file.sizeKb}kb · '
                                'x=${shelf[i].dropX.toStringAsFixed(1)}',
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
              );
            },
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => setState(() => shelf.clear()),
              icon: const Icon(Icons.clear_all),
              label: const Text('Empty shelf'),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 11 — Rank reorder slots (nearest-slot wins)
  // ===========================================================================
  Widget _buildRankSlots(BuildContext context) {
    return _SectionCard(
      title: '11 — Recipe: rank reorder by nearest slot',
      subtitle:
          'A row of five DragTarget<int> slots. The slot whose center is '
          'nearest to details.offset accepts; others reject.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final n in [101, 102, 103, 104, 105])
                Draggable<int>(
                  data: n,
                  feedback: _IntChip(n: n, dragging: true),
                  childWhenDragging: _IntChip(n: n, faded: true),
                  child: _IntChip(n: n),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < rankSlots.length; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: DragTarget<int>(
                      key: rankKeys[i],
                      onWillAcceptWithDetails: (details) {
                        return _isNearestSlot(i, details.offset);
                      },
                      onAcceptWithDetails: (details) {
                        setState(() {
                          rankSlots[i] = details.data;
                          rankNote =
                              'Slot $i accepted ${details.data} at ${fmtOffset(details.offset)}';
                          _record(
                            zone: 'rank-slot-$i',
                            outcome: 'accept',
                            dataDesc: '${details.data}',
                            offset: details.offset,
                            dataType: int,
                          );
                        });
                      },
                      builder: (ctx, candidate, rejected) {
                        final hovering = candidate.isNotEmpty;
                        return Container(
                          height: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: hovering
                                ? Colors.deepPurple.withOpacity(0.20)
                                : Colors.deepPurple.withOpacity(0.05),
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: hovering ? 3 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            rankSlots[i]?.toString() ?? '—',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(rankNote, style: const TextStyle(fontStyle: FontStyle.italic)),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  for (var i = 0; i < rankSlots.length; i++) {
                    rankSlots[i] = null;
                  }
                  rankNote = 'Slots reset.';
                });
              },
              icon: const Icon(Icons.restore),
              label: const Text('Reset slots'),
            ),
          ),
        ],
      ),
    );
  }

  // Returns true iff the slot at index `i` is the closest to `globalOffset`.
  bool _isNearestSlot(int i, Offset globalOffset) {
    double? best;
    int bestIdx = -1;
    for (var j = 0; j < rankKeys.length; j++) {
      final ctx = rankKeys[j].currentContext;
      final box = ctx?.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final topLeft = box.localToGlobal(Offset.zero);
      final center = topLeft + box.size.center(Offset.zero);
      final d = (center - globalOffset).distance;
      if (best == null || d < best) {
        best = d;
        bestIdx = j;
      }
    }
    return bestIdx == i;
  }

  // ===========================================================================
  // SECTION 12 — Pitfalls + reference table
  // ===========================================================================
  Widget _buildPitfallsAndReference(BuildContext context) {
    return _SectionCard(
      title: '12 — Pitfalls and reference table',
      subtitle: 'Common mistakes and a one-glance API recap.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Pitfall(
            title: 'Forgetting <T>',
            body: 'DragTarget<int>() with Draggable<num>() will not match. '
                'Both generics must agree, otherwise onWillAcceptWithDetails '
                'is never even called.',
          ),
          const _Pitfall(
            title: 'Confusing global vs local offset',
            body: 'details.offset is *global*. To draw inside the target you '
                'must convert via RenderBox.globalToLocal(details.offset).',
          ),
          const _Pitfall(
            title: 'Mutating the data field',
            body: 'DragTargetDetails is immutable. Treat details.data as '
                'read-only; clone it before modifying.',
          ),
          const _Pitfall(
            title: 'Relying on onAccept (deprecated)',
            body: 'Prefer onAcceptWithDetails — onAccept omits the offset.',
          ),
          const SizedBox(height: 8),
          DefaultTextStyle(
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            child: Table(
              border: TableBorder.all(color: Colors.black26),
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: const [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: Text('field/cb',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: Text('purpose',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(6), child: Text('data')),
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text('payload of type T from Draggable<T>.data')),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(6), child: Text('offset')),
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                          'global Offset of the pointer at the event time')),
                ]),
                TableRow(children: [
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text('onWillAcceptWithDetails')),
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                          'predicate decides whether the target highlights')),
                ]),
                TableRow(children: [
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text('onAcceptWithDetails')),
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                          'fires on a successful drop with the full details')),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(6), child: Text('onMove')),
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                          'streams DragTargetDetails as the pointer moves')),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(6), child: Text('onLeave')),
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text('fires when a candidate exits the target')),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Cross-cutting event log
  // ===========================================================================
  Widget _buildEventLogCard(BuildContext context) {
    return _SectionCard(
      title: 'Event log (most recent on top)',
      subtitle:
          'Every callback in every section appends here. Colours match the '
          'outcome (green=accept, red=reject, orange=move, grey=leave).',
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 240,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8),
        ),
        child: events.isEmpty
            ? const Center(child: Text('(no events yet — drag something!)'))
            : ListView.builder(
                itemCount: events.length,
                itemBuilder: (ctx, i) {
                  final e = events[i];
                  final color = switch (e.outcome) {
                    'accept' => Colors.green[800]!,
                    'reject' => Colors.red[800]!,
                    'move' => Colors.orange[800]!,
                    'leave' => Colors.grey[700]!,
                    _ => Colors.black,
                  };
                  final hh = e.ts.hour.toString().padLeft(2, '0');
                  final mm = e.ts.minute.toString().padLeft(2, '0');
                  final ss = e.ts.second.toString().padLeft(2, '0');
                  return Text(
                    '$hh:$mm:$ss  ${e.outcome.padRight(7)}  '
                    '${e.zone.padRight(20)}  '
                    'data=${e.dataDesc}  off=${fmtOffset(e.offset)}',
                    style: TextStyle(
                      color: color,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  );
                },
              ),
      ),
    );
  }

  // ===========================================================================
  // Platform footer (uses Theme.of(context).platform per the rules)
  // ===========================================================================
  Widget _buildPlatformFooter(BuildContext context, TargetPlatform platform) {
    final tip = switch (platform) {
      TargetPlatform.android ||
      TargetPlatform.iOS =>
        'On touch platforms, prefer LongPressDraggable so taps still work.',
      TargetPlatform.macOS ||
      TargetPlatform.linux ||
      TargetPlatform.windows =>
        'On desktop, regular Draggable feels native because of the cursor.',
      TargetPlatform.fuchsia => 'Fuchsia: behaves like a desktop platform.',
    };
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.devices_other),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Detected platform: $platform — $tip',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Reusable bits
// =============================================================================
class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _IntChip extends StatelessWidget {
  final int n;
  final bool dragging;
  final bool faded;
  const _IntChip({required this.n, this.dragging = false, this.faded = false});

  @override
  Widget build(BuildContext context) {
    final body = Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: dragging ? Colors.amber : Colors.amber[200],
        border: Border.all(color: Colors.amber[800]!, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: dragging
            ? const [BoxShadow(color: Colors.black26, blurRadius: 8)]
            : null,
      ),
      child: Text(
        '$n',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
    if (dragging) {
      // The Draggable.feedback widget is rendered outside the widget tree, so
      // wrap it in a Material to avoid the "no Material" assertion.
      return Material(color: Colors.transparent, child: body);
    }
    return Opacity(opacity: faded ? 0.3 : 1.0, child: body);
  }
}

class _StrChip extends StatelessWidget {
  final String label;
  final bool dragging;
  final bool faded;
  const _StrChip({
    required this.label,
    this.dragging = false,
    this.faded = false,
  });

  @override
  Widget build(BuildContext context) {
    final body = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: dragging ? Colors.lightBlue[200] : Colors.lightBlue[50],
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: dragging
            ? const [BoxShadow(color: Colors.black26, blurRadius: 8)]
            : null,
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
    if (dragging) return Material(color: Colors.transparent, child: body);
    return Opacity(opacity: faded ? 0.3 : 1.0, child: body);
  }
}

class _ParcelChip extends StatelessWidget {
  final Parcel parcel;
  final bool dragging;
  final bool faded;
  const _ParcelChip({
    required this.parcel,
    this.dragging = false,
    this.faded = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (parcel.kind) {
      'mail' => Colors.blue,
      'box' => Colors.orange,
      _ => Colors.purple,
    };
    final body = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: dragging ? color.withOpacity(0.40) : color.withOpacity(0.15),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: dragging
            ? const [BoxShadow(color: Colors.black26, blurRadius: 8)]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            parcel.label,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            '${parcel.kind} · ${parcel.weightKg}kg',
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
    if (dragging) return Material(color: Colors.transparent, child: body);
    return Opacity(opacity: faded ? 0.3 : 1.0, child: body);
  }
}

class _FileChip extends StatelessWidget {
  final MyFile file;
  final bool dragging;
  final bool faded;
  const _FileChip({
    required this.file,
    this.dragging = false,
    this.faded = false,
  });

  @override
  Widget build(BuildContext context) {
    final body = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: dragging ? Colors.teal[200] : Colors.teal[50],
        border: Border.all(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: dragging
            ? const [BoxShadow(color: Colors.black26, blurRadius: 8)]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.insert_drive_file, size: 16, color: Colors.teal),
          const SizedBox(width: 4),
          Text(
            '${file.name}.${file.ext}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          const SizedBox(width: 4),
          Text(
            '${file.sizeKb}kb',
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),
        ],
      ),
    );
    if (dragging) return Material(color: Colors.transparent, child: body);
    return Opacity(opacity: faded ? 0.3 : 1.0, child: body);
  }
}

class _Pitfall extends StatelessWidget {
  final String title;
  final String body;
  const _Pitfall({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.10),
        border: Border.all(color: Colors.amber, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber, color: Colors.amber, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
