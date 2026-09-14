// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — StreamBuilderBase
// Demonstrates StreamBuilderBase — the abstract base class that
// StreamBuilder extends. Covers the raw lifecycle hooks (initial,
// afterConnected, afterData, afterError, afterDone, afterDisconnected),
// ConnectionState flow, custom StreamBuilderBase implementations,
// and the relationship to AsyncSnapshot / StreamBuilder.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StreamBuilderBase Deep Demo executing');

  // ============================================================
  // SECTION 1: What is StreamBuilderBase?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.stream,
      'title': 'Abstract Stream Widget',
      'body': 'StreamBuilderBase<T, S> is the abstract base class that '
          'provides a framework for widgets that rebuild in response '
          'to stream events. T is the stream data type, S is the '
          'summary type that accumulates stream state.',
      'accent': Colors.pink[800]!,
    },
    {
      'icon': Icons.summarize,
      'title': 'Summary State Pattern',
      'body': 'Instead of exposing raw stream events, StreamBuilderBase '
          'maintains a "summary" (S) that evolves through lifecycle '
          'hooks. Each hook receives the current summary and returns '
          'the next summary — a functional state accumulator.',
      'accent': Colors.blueGrey[700]!,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Six Lifecycle Hooks',
      'body': 'The class defines six overridable methods: initial(), '
          'afterConnected(), afterData(), afterError(), afterDone(), '
          'and afterDisconnected(). Together they model every phase '
          'of a stream subscription lifecycle.',
      'accent': Colors.pink[700]!,
    },
    {
      'icon': Icons.build_circle,
      'title': 'StreamBuilder Relationship',
      'body': 'Flutter\'s StreamBuilder is just a concrete implementation '
          'of StreamBuilderBase where S = AsyncSnapshot<T>. If you '
          'need a different summary model, subclass StreamBuilderBase '
          'directly.',
      'accent': Colors.blueGrey[600]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: Lifecycle Hooks
  // ============================================================
  print('=== Section 2: Lifecycle Hooks ===');

  final hooks = <Map<String, dynamic>>[
    {
      'step': '1',
      'name': 'initial()',
      'returns': 'S',
      'description': 'Called once. Returns the initial summary value '
          'before any stream is connected. Like the starting state '
          'of a reducer.',
      'timing': 'initState / didUpdateWidget',
      'color': Colors.pink[800]!,
    },
    {
      'step': '2',
      'name': 'afterConnected(S current)',
      'returns': 'S',
      'description': 'Called immediately after subscribing to the stream. '
          'Receives the current summary, returns the updated summary. '
          'Use to mark "connecting" state.',
      'timing': 'After stream.listen()',
      'color': Colors.blueGrey[700]!,
    },
    {
      'step': '3',
      'name': 'afterData(S current, T data)',
      'returns': 'S',
      'description': 'Called when the stream emits a data event. Receives '
          'the current summary and the new data, returns the updated '
          'summary. The most frequently called hook.',
      'timing': 'On each data event',
      'color': Colors.pink[700]!,
    },
    {
      'step': '4',
      'name': 'afterError(S current, Object error, StackTrace)',
      'returns': 'S',
      'description': 'Called when the stream emits an error. Receives the '
          'current summary, error object, and stack trace. Returns '
          'updated summary with error state.',
      'timing': 'On each error event',
      'color': Colors.red[700]!,
    },
    {
      'step': '5',
      'name': 'afterDone(S current)',
      'returns': 'S',
      'description': 'Called when the stream closes normally. Receives '
          'current summary, returns final summary. After this, no '
          'more data or error events arrive.',
      'timing': 'On stream close',
      'color': Colors.blueGrey[600]!,
    },
    {
      'step': '6',
      'name': 'afterDisconnected(S current)',
      'returns': 'S',
      'description': 'Called when the subscription is cancelled — either '
          'because the widget is disposed or the stream property '
          'changed. Use to mark "disconnected" state.',
      'timing': 'On dispose / stream change',
      'color': Colors.pink[600]!,
    },
  ];

  print('  Hooks: ${hooks.length}');

  // ============================================================
  // SECTION 3: ConnectionState
  // ============================================================
  print('=== Section 3: ConnectionState ===');

  final connectionStates = <Map<String, dynamic>>[
    {
      'state': 'none',
      'description': 'Not connected to any stream. The widget was '
          'created with a null stream, or before subscription.',
      'icon': Icons.cloud_off,
      'color': Colors.grey[600]!,
      'visual': 'Idle indicator',
    },
    {
      'state': 'waiting',
      'description': 'Connected to a stream but no data received yet. '
          'The subscription is active, waiting for the first event.',
      'icon': Icons.hourglass_empty,
      'color': Colors.orange[700]!,
      'visual': 'Loading spinner',
    },
    {
      'state': 'active',
      'description': 'Connected and receiving data. The most recent '
          'event was a data event. The build method has fresh data.',
      'icon': Icons.check_circle,
      'color': Colors.green[700]!,
      'visual': 'Live data display',
    },
    {
      'state': 'done',
      'description': 'Stream has closed. The last data or error is '
          'still available in the summary, but no new events will '
          'arrive.',
      'icon': Icons.stop_circle,
      'color': Colors.blue[700]!,
      'visual': 'Final value display',
    },
  ];

  print('  Connection states: ${connectionStates.length}');

  // ============================================================
  // SECTION 4: Custom Implementation
  // ============================================================
  print('=== Section 4: Custom Implementation ===');

  final implCode = '''class CountStreamBuilder
    extends StreamBuilderBase<int, int> {
  const CountStreamBuilder({
    super.key,
    required super.stream,
  });

  @override
  int initial() => 0;

  @override
  int afterConnected(int current) => current;

  @override
  int afterData(int current, int data) => data;

  @override
  int afterError(
    int current,
    Object error,
    StackTrace stackTrace,
  ) => -1;

  @override
  int afterDone(int current) => current;

  @override
  int afterDisconnected(int current) => current;

  @override
  Widget build(BuildContext context, int summary) {
    return Text(
      'Count: \$summary',
      style: TextStyle(fontSize: 24),
    );
  }
}''';

  // A more complex summary type example
  final complexImpl = '''// Custom summary holding data + metadata
class StreamSummary<T> {
  final T? data;
  final Object? error;
  final bool isDone;
  final int eventCount;
  final DateTime? lastUpdate;

  StreamSummary({
    this.data,
    this.error,
    this.isDone = false,
    this.eventCount = 0,
    this.lastUpdate,
  });
}

class RichStreamBuilder<T>
    extends StreamBuilderBase<T, StreamSummary<T>> {
  // ...override all 6 hooks plus build()
}''';

  print('  Implementation code ready');

  // ============================================================
  // SECTION 5: StreamBuilder Wraps StreamBuilderBase
  // ============================================================
  print('=== Section 5: StreamBuilder ===');

  final sbComparison = <Map<String, dynamic>>[
    {
      'feature': 'Summary type (S)',
      'base': 'Custom — you define it',
      'streamBuilder': 'AsyncSnapshot<T>',
    },
    {
      'feature': 'Lifecycle hooks',
      'base': '6 individual hooks',
      'streamBuilder': 'Mapped to AsyncSnapshot fields',
    },
    {
      'feature': 'builder parameter',
      'base': 'build(context, summary)',
      'streamBuilder': 'builder(context, snapshot)',
    },
    {
      'feature': 'Error access',
      'base': 'Via afterError hook',
      'streamBuilder': 'snapshot.error',
    },
    {
      'feature': 'Flexibility',
      'base': 'Full control over state',
      'streamBuilder': 'Simpler but fixed model',
    },
    {
      'feature': 'Use when',
      'base': 'Need custom accumulation',
      'streamBuilder': 'Standard stream→widget',
    },
  ];

  print('  Comparison rows: ${sbComparison.length}');

  // ============================================================
  // SECTION 6: Stream Event Flow
  // ============================================================
  print('=== Section 6: Event Flow ===');

  // Simulate a stream event sequence
  final eventSequence = <Map<String, dynamic>>[
    {'type': 'initial', 'value': '0', 'hook': 'initial()', 'color': Colors.grey[600]!},
    {'type': 'connected', 'value': '0', 'hook': 'afterConnected(0)', 'color': Colors.orange[700]!},
    {'type': 'data', 'value': '42', 'hook': 'afterData(0, 42)', 'color': Colors.green[700]!},
    {'type': 'data', 'value': '85', 'hook': 'afterData(42, 85)', 'color': Colors.green[600]!},
    {'type': 'error', 'value': 'err', 'hook': 'afterError(85, e, st)', 'color': Colors.red[700]!},
    {'type': 'data', 'value': '99', 'hook': 'afterData(-1, 99)', 'color': Colors.green[700]!},
    {'type': 'done', 'value': '99', 'hook': 'afterDone(99)', 'color': Colors.blue[700]!},
    {'type': 'disconnected', 'value': '99', 'hook': 'afterDisconnected(99)', 'color': Colors.pink[700]!},
  ];

  print('  Event sequence: ${eventSequence.length}');

  // ============================================================
  // SECTION 7: Usage Patterns
  // ============================================================
  print('=== Section 7: Usage Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Accumulating Stream',
      'description': 'Sum all values from a stream rather '
          'than showing only the latest. The summary accumulates.',
      'code': '@override\n'
          'int afterData(int current, int data) {\n'
          '  return current + data; // accumulate\n'
          '}',
      'color': Colors.pink[800]!,
    },
    {
      'title': 'Buffered History',
      'description': 'Keep the last N events in the summary '
          'for a scrolling log or chart.',
      'code': '@override\n'
          'List<T> afterData(\n'
          '    List<T> current, T data) {\n'
          '  return [...current.takeLast(99), data];\n'
          '}',
      'color': Colors.blueGrey[700]!,
    },
    {
      'title': 'Typed Error Handling',
      'description': 'Distinguish error types in the summary '
          'for different UI states.',
      'code': '@override\n'
          'MySummary afterError(\n'
          '    MySummary current,\n'
          '    Object error,\n'
          '    StackTrace st) {\n'
          '  if (error is TimeoutException) {\n'
          '    return current.withTimeout();\n'
          '  }\n'
          '  return current.withError(error);\n'
          '}',
      'color': Colors.pink[700]!,
    },
    {
      'title': 'Stream Switching',
      'description': 'Handle stream changes gracefully via '
          'afterDisconnected / afterConnected.',
      'code': '@override\n'
          'S afterDisconnected(S current) {\n'
          '  return current.markStale();\n'
          '}\n\n'
          '@override\n'
          'S afterConnected(S current) {\n'
          '  return current.markRefreshing();\n'
          '}',
      'color': Colors.blueGrey[600]!,
    },
  ];

  print('  Usage patterns: ${patterns.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Immutable Summaries',
      'detail': 'Return new summary objects from hooks rather than '
          'mutating the current one. This ensures proper widget '
          'rebuilds and simplifies debugging.',
      'icon': Icons.lock,
      'color': Colors.pink[800]!,
    },
    {
      'title': 'Handle All States',
      'detail': 'Your build() method receives the summary. Always '
          'handle the initial, loading, data, error, and done '
          'states explicitly to avoid visual glitches.',
      'icon': Icons.checklist,
      'color': Colors.blueGrey[700]!,
    },
    {
      'title': 'Don\'t Create Streams in build()',
      'detail': 'Pass the stream from outside or create it in '
          'initState. Creating a new stream each build causes '
          'repeated subscribe/unsubscribe cycles.',
      'icon': Icons.warning_amber,
      'color': Colors.pink[700]!,
    },
    {
      'title': 'Use StreamBuilder for Simple Cases',
      'detail': 'If AsyncSnapshot covers your needs, prefer '
          'StreamBuilder. Subclass StreamBuilderBase only when '
          'you need custom accumulation or typed summaries.',
      'icon': Icons.thumb_up,
      'color': Colors.blueGrey[600]!,
    },
    {
      'title': 'Consider FutureBuilder for Single Values',
      'detail': 'If you only need one async result, FutureBuilder '
          'is simpler. StreamBuilderBase is for continuous events.',
      'icon': Icons.hourglass_bottom,
      'color': Colors.pink[600]!,
    },
  ];

  print('  Best practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink[800]!, Colors.blueGrey[600]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.stream, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text('StreamBuilderBase',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'The abstract foundation behind StreamBuilder — '
                'providing six lifecycle hooks that transform stream '
                'events into a custom summary for widget building.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.pink[800]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Lifecycle Hooks ----
        _sectionHeader('2. Lifecycle Hooks', Icons.timeline, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        ...hooks.map((h) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: h['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(h['step'] as String,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (h['color'] as Color).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border(left: BorderSide(color: h['color'] as Color, width: 3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(h['name'] as String,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: h['color'] as Color)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text('→ ${h['returns']}',
                                    style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(h['description'] as String, style: TextStyle(fontSize: 12)),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 12, color: Colors.grey[500]),
                              SizedBox(width: 4),
                              Text(h['timing'] as String,
                                  style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey[600])),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: ConnectionState ----
        _sectionHeader('3. ConnectionState', Icons.cloud_queue, Colors.pink[800]!),
        SizedBox(height: 10),
        ...connectionStates.map((cs) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (cs['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: (cs['color'] as Color).withValues(alpha: 0.3)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (cs['color'] as Color).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(cs['icon'] as IconData, color: cs['color'] as Color, size: 26),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: cs['color'] as Color,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(cs['state'] as String,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                              SizedBox(width: 8),
                              Text(cs['visual'] as String,
                                  style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey[500])),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(cs['description'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Custom Implementation ----
        _sectionHeader('4. Custom Implementation', Icons.code, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        Text('A minimal StreamBuilderBase subclass with int summary:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(implCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.pinkAccent[100])),
        ),
        SizedBox(height: 14),
        Text('A richer summary type for production use:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(complexImpl,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.cyanAccent[100])),
        ),

        SizedBox(height: 20),

        // ---- Section 5: StreamBuilder Comparison ----
        _sectionHeader('5. vs StreamBuilder', Icons.compare_arrows, Colors.pink[800]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.pink[800],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text('Feature', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('StreamBuilderBase', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('StreamBuilder', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(sbComparison.length, (i) {
                final c = sbComparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.pink[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(c['feature'] as String,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                      Expanded(flex: 3, child: Text(c['base'] as String,
                          style: TextStyle(fontSize: 11))),
                      Expanded(flex: 3, child: Text(c['streamBuilder'] as String,
                          style: TextStyle(fontSize: 11))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 6: Event Flow Visualization ----
        _sectionHeader('6. Event Flow', Icons.auto_awesome, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        Text('Trace of a stream lifecycle with int summary (starting at 0):',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        ...List.generate(eventSequence.length, (i) {
          final e = eventSequence[i];
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: (e['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(left: BorderSide(color: e['color'] as Color, width: 4)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: e['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(e['type'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(e['hook'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: e['color'] as Color)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text('S = ${e['value']}',
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              if (i < eventSequence.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Icon(Icons.arrow_downward, size: 16, color: Colors.grey[400]),
                ),
            ],
          );
        }),

        SizedBox(height: 20),

        // ---- Section 7: Usage Patterns ----
        _sectionHeader('7. Usage Patterns', Icons.pattern, Colors.pink[800]!),
        SizedBox(height: 10),
        ...patterns.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                    SizedBox(height: 4),
                    Text(p['description'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(p['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.pinkAccent[100])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.stream, color: Colors.pink[600], size: 28),
              SizedBox(height: 6),
              Text(
                'StreamBuilderBase: the foundational abstraction for '
                'connecting streams to widgets — six hooks, one summary, '
                'complete lifecycle control.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
