// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ConnectionState
// Demonstrates ConnectionState, the enum that describes the
// current state of connection to an asynchronous computation
// in FutureBuilder and StreamBuilder. Covers all four enum
// values (none, waiting, active, done), snapshot anatomy,
// state transitions, visual state-machine diagrams,
// practical patterns, and common pitfalls.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ConnectionState Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ConnectionState?
  // ============================================================
  print('=== Section 1: What is ConnectionState? ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.power,
      'title': 'The Async Connection Lifecycle',
      'body': 'ConnectionState is an enum with four values that '
          'describe the lifecycle of a connection to an asynchronous '
          'computation — a Future or a Stream. FutureBuilder and '
          'StreamBuilder expose this state through AsyncSnapshot, '
          'letting you build different widgets for each phase.',
      'accent': Colors.deepPurple[700]!,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Part of AsyncSnapshot',
      'body': 'AsyncSnapshot<T> wraps three things:\n'
          '• connectionState — the ConnectionState enum\n'
          '• data — the latest value (T?)\n'
          '• error — the latest error (Object?)\n'
          'The connectionState tells you which phase the '
          'async operation is in so you can choose what to render.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.linear_scale,
      'title': 'Four States, Simple Progression',
      'body': 'The four values are: none (not connected to anything), '
          'waiting (connected but no data yet), active (data is '
          'flowing — streams only), and done (the computation has '
          'finished with either data or error). For a Future, the '
          'progression is: none → waiting → done. For a Stream: '
          'none → waiting → active → done.',
      'accent': Colors.purple[600]!,
    },
    {
      'icon': Icons.widgets,
      'title': 'Widget Builders Use It',
      'body': 'FutureBuilder and StreamBuilder call their builder '
          'function every time the ConnectionState changes. Your '
          'builder receives the AsyncSnapshot and switches on '
          'snapshot.connectionState to decide: show a spinner '
          '(waiting), show data (active/done), or show an error.',
      'accent': Colors.purple[500]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Four Enum Values
  // ============================================================
  print('=== Section 2: The Four Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'name': 'none',
      'index': 0,
      'icon': Icons.power_off,
      'color': Colors.grey[600]!,
      'bgColor': Colors.grey[100]!,
      'meaning': 'Not currently connected to any asynchronous '
          'computation. This is the initial state before a Future or '
          'Stream is provided, or when the builder is configured with '
          'null as the future/stream.',
      'snapshot': 'data: null, error: null',
      'example': 'FutureBuilder<int>(\n'
          '  future: null,  // ← none\n'
          '  builder: ...\n'
          ')',
    },
    {
      'name': 'waiting',
      'index': 1,
      'icon': Icons.hourglass_empty,
      'color': Colors.orange[700]!,
      'bgColor': Colors.orange[50]!,
      'meaning': 'Connected to an async computation but no result '
          'yet. For FutureBuilder, this is the state between receiving '
          'a non-null future and the future completing. For '
          'StreamBuilder, this is after subscribing but before the '
          'first event arrives.',
      'snapshot': 'data: null (or previous), error: null',
      'example': 'FutureBuilder<String>(\n'
          '  future: fetchData(), // pending\n'
          '  builder: (ctx, snap) {\n'
          '    // snap.connectionState == waiting\n'
          '    return CircularProgressIndicator();\n'
          '  },\n'
          ')',
    },
    {
      'name': 'active',
      'index': 2,
      'icon': Icons.podcasts,
      'color': Colors.green[700]!,
      'bgColor': Colors.green[50]!,
      'meaning': 'Connected to an active Stream that has emitted at '
          'least one event but has not yet closed. Each new event '
          'triggers a rebuild with the latest data. This state is '
          'NOT used by FutureBuilder — Futures go directly from '
          'waiting to done.',
      'snapshot': 'data: latest event, error: null (or latest error)',
      'example': 'StreamBuilder<int>(\n'
          '  stream: counterStream(),\n'
          '  builder: (ctx, snap) {\n'
          '    // snap.connectionState == active\n'
          '    return Text(\'\${snap.data}\');\n'
          '  },\n'
          ')',
    },
    {
      'name': 'done',
      'index': 3,
      'icon': Icons.check_circle,
      'color': Colors.deepPurple[700]!,
      'bgColor': Colors.deepPurple[50]!,
      'meaning': 'The async computation has finished. For a Future: '
          'it resolved with data or rejected with an error. For a '
          'Stream: it emitted a done event (closed). After done, no '
          'further updates occur unless the future/stream is replaced.',
      'snapshot': 'data: final value, error: final error (if any)',
      'example': 'FutureBuilder<User>(\n'
          '  future: loadUser(),\n'
          '  builder: (ctx, snap) {\n'
          '    if (snap.connectionState == done) {\n'
          '      return UserCard(snap.data!);\n'
          '    }\n'
          '    return CircularProgressIndicator();\n'
          '  },\n'
          ')',
    },
  ];

  print('  Prepared ${enumValues.length} enum value descriptions');

  // ============================================================
  // SECTION 3: FutureBuilder Lifecycle
  // ============================================================
  print('=== Section 3: FutureBuilder Lifecycle ===');

  final futureSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Widget Created',
      'state': 'none',
      'color': Colors.grey[500]!,
      'detail': 'initState() runs. If future is null, state stays '
          'none. If future is non-null, state immediately moves to '
          'waiting.',
    },
    {
      'step': '2',
      'label': 'Future Assigned',
      'state': 'waiting',
      'color': Colors.orange[600]!,
      'detail': 'The builder subscribes to the Future via .then() '
          'and .catchError(). Builder is called with connectionState '
          '== waiting. Typically render a loading indicator here.',
    },
    {
      'step': '3a',
      'label': 'Future Resolves',
      'state': 'done ✓',
      'color': Colors.green[700]!,
      'detail': 'The Future completes successfully. Builder is '
          'called with connectionState == done, snapshot.data '
          'contains the result, snapshot.hasData is true.',
    },
    {
      'step': '3b',
      'label': 'Future Rejects',
      'state': 'done ✗',
      'color': Colors.red[600]!,
      'detail': 'The Future completes with an error. Builder is '
          'called with connectionState == done, snapshot.error '
          'contains the error, snapshot.hasError is true.',
    },
    {
      'step': '4',
      'label': 'Future Replaced',
      'state': 'waiting',
      'color': Colors.orange[600]!,
      'detail': 'If the parent rebuilds with a different Future '
          'instance, the old subscription is dropped and state '
          'resets to waiting for the new Future. If the same '
          'instance is provided, no change.',
    },
  ];

  print('  Prepared ${futureSteps.length} FutureBuilder lifecycle steps');

  // ============================================================
  // SECTION 4: StreamBuilder Lifecycle
  // ============================================================
  print('=== Section 4: StreamBuilder Lifecycle ===');

  final streamSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Widget Created',
      'state': 'none',
      'color': Colors.grey[500]!,
      'detail': 'initState() runs. If stream is null, state stays '
          'none. Otherwise moves to waiting.',
    },
    {
      'step': '2',
      'label': 'Stream Subscribed',
      'state': 'waiting',
      'color': Colors.orange[600]!,
      'detail': 'The widget calls stream.listen(). No events '
          'received yet. Builder called with waiting.',
    },
    {
      'step': '3',
      'label': 'Data Event',
      'state': 'active',
      'color': Colors.green[700]!,
      'detail': 'Each data event triggers a rebuild with '
          'connectionState == active and snapshot.data set to '
          'the latest value. Multiple rebuilds as events arrive.',
    },
    {
      'step': '3e',
      'label': 'Error Event',
      'state': 'active',
      'color': Colors.red[500]!,
      'detail': 'A stream error triggers a rebuild with active '
          'state but snapshot.hasError == true. The stream is '
          'still open unless it\'s a fatal error.',
    },
    {
      'step': '4',
      'label': 'Stream Closes',
      'state': 'done',
      'color': Colors.deepPurple[600]!,
      'detail': 'The stream emits a done event. Builder is called '
          'with connectionState == done. snapshot.data holds the '
          'last value; snapshot.error holds the last error (if any).',
    },
    {
      'step': '5',
      'label': 'Stream Replaced',
      'state': 'waiting',
      'color': Colors.orange[600]!,
      'detail': 'If the parent provides a new Stream instance, the '
          'old subscription is cancelled and state resets to waiting. '
          'Previous snapshot data may be preserved via initialData.',
    },
  ];

  print('  Prepared ${streamSteps.length} StreamBuilder lifecycle steps');

  // ============================================================
  // SECTION 5: State Transition Diagram
  // ============================================================
  print('=== Section 5: State Transition Diagram ===');

  final transitionText = {
    'future': [
      'none ──(future!=null)──▸ waiting ──(resolve)──▸ done(data)',
      '                                   ──(reject)──▸ done(error)',
      'done ──(new future)──▸ waiting',
    ],
    'stream': [
      'none ──(stream!=null)──▸ waiting ──(data event)──▸ active',
      '                                                     │',
      '          active ◀──(data event)──┤                   │',
      '          active ◀──(error event)─┘                   │',
      '          active ──(done event)──▸ done               │',
      '          done ──(new stream)──▸ waiting',
    ],
  };

  print('  Prepared transition diagrams');

  // ============================================================
  // SECTION 6: AsyncSnapshot Anatomy
  // ============================================================
  print('=== Section 6: AsyncSnapshot Anatomy ===');

  final snapshotMembers = <Map<String, dynamic>>[
    {
      'member': 'connectionState',
      'type': 'ConnectionState',
      'desc': 'Which phase the async operation is in.',
      'icon': Icons.power,
    },
    {
      'member': 'data',
      'type': 'T?',
      'desc': 'The latest data received. Null if no data yet.',
      'icon': Icons.data_object,
    },
    {
      'member': 'error',
      'type': 'Object?',
      'desc': 'The latest error. Null if no error.',
      'icon': Icons.error_outline,
    },
    {
      'member': 'stackTrace',
      'type': 'StackTrace?',
      'desc': 'Stack trace associated with the error, if any.',
      'icon': Icons.layers,
    },
    {
      'member': 'hasData',
      'type': 'bool',
      'desc': 'True when data is non-null. Convenience getter.',
      'icon': Icons.check,
    },
    {
      'member': 'hasError',
      'type': 'bool',
      'desc': 'True when error is non-null. Convenience getter.',
      'icon': Icons.warning,
    },
    {
      'member': 'requireData',
      'type': 'T',
      'desc': 'Returns data or throws if null. Use after checking.',
      'icon': Icons.verified,
    },
  ];

  print('  Listed ${snapshotMembers.length} AsyncSnapshot members');

  // ============================================================
  // SECTION 7: Correct Builder Pattern
  // ============================================================
  print('=== Section 7: Correct Builder Pattern ===');

  final builderPatterns = <Map<String, dynamic>>[
    {
      'title': 'Recommended: Check connectionState',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
      'code': 'builder: (context, snapshot) {\n'
          '  switch (snapshot.connectionState) {\n'
          '    case ConnectionState.none:\n'
          '      return Text(\'Not connected\');\n'
          '    case ConnectionState.waiting:\n'
          '      return CircularProgressIndicator();\n'
          '    case ConnectionState.active:\n'
          '      return Text(\'\${snapshot.data}\');\n'
          '    case ConnectionState.done:\n'
          '      if (snapshot.hasError) {\n'
          '        return Text(\'Error: \${snapshot.error}\');\n'
          '      }\n'
          '      return Text(\'Done: \${snapshot.data}\');\n'
          '  }\n'
          '}',
      'note': 'Exhaustive switch handles every state explicitly. '
          'No missing cases, no default fallthrough.',
    },
    {
      'title': 'Common: Check hasData/hasError first',
      'icon': Icons.info,
      'color': Colors.blue[600]!,
      'code': 'builder: (context, snapshot) {\n'
          '  if (snapshot.hasError) {\n'
          '    return ErrorWidget(snapshot.error!);\n'
          '  }\n'
          '  if (snapshot.hasData) {\n'
          '    return DataWidget(snapshot.data!);\n'
          '  }\n'
          '  return CircularProgressIndicator();\n'
          '}',
      'note': 'Simpler, but conflates none/waiting/active into a '
          'single loading state. Works for simple use cases.',
    },
    {
      'title': 'Anti-Pattern: Ignore connectionState',
      'icon': Icons.cancel,
      'color': Colors.red[600]!,
      'code': 'builder: (context, snapshot) {\n'
          '  // snapshot.data can be null even after done!\n'
          '  return Text(snapshot.data.toString());\n'
          '}',
      'note': 'Crashes or shows "null" during loading. Always check '
          'state or hasData before accessing data.',
    },
  ];

  print('  Prepared ${builderPatterns.length} builder patterns');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final realPatterns = <Map<String, dynamic>>[
    {
      'title': 'Loading Screen',
      'icon': Icons.hourglass_bottom,
      'color': Colors.orange[600]!,
      'body': 'Show a full-screen loader while connectionState is '
          'waiting. Transition to content on done. Handle errors '
          'with a retry button that replaces the Future.',
    },
    {
      'title': 'Live Data Feed',
      'icon': Icons.podcasts,
      'color': Colors.green[600]!,
      'body': 'Use StreamBuilder with a Firestore or WebSocket '
          'stream. During active, display updating data. During '
          'waiting, show "Connecting...". On done, show '
          '"Connection closed" with reconnect option.',
    },
    {
      'title': 'Form Submission',
      'icon': Icons.send,
      'color': Colors.blue[600]!,
      'body': 'Wrap a submit button in FutureBuilder. state==none: '
          'show button. state==waiting: show spinner on button '
          '(disable tap). state==done+data: show success. '
          'state==done+error: show error message.',
    },
    {
      'title': 'Initial Data',
      'icon': Icons.data_array,
      'color': Colors.teal[600]!,
      'body': 'Pass initialData to FutureBuilder/StreamBuilder to '
          'provide data before the async operation completes. '
          'snapshot.data starts non-null, so hasData is true even '
          'during waiting. Useful for cached-first patterns.',
    },
    {
      'title': 'Chained Builders',
      'icon': Icons.account_tree,
      'color': Colors.deepPurple[600]!,
      'body': 'Nest a StreamBuilder inside a FutureBuilder: load '
          'config (Future), then listen to updates (Stream). The '
          'inner builder only subscribes when the outer reaches done.',
    },
  ];

  print('  Prepared ${realPatterns.length} real-world patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Create Futures in build()',
      'body': 'If you write FutureBuilder(future: fetchData(), ...) '
          'inside build(), a new Future is created on every rebuild, '
          'restarting the cycle. Create the Future in initState() or '
          'a state variable instead.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'active Is Stream-Only',
      'body': 'FutureBuilder never enters the active state. It goes '
          'directly from waiting to done. If you switch on '
          'connectionState for FutureBuilder, the active case is '
          'unreachable — but Dart still requires you handle it.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'snapshot.data Persists',
      'body': 'When a Stream emits an error, connection state stays '
          'active but snapshot.error is set. However, snapshot.data '
          'still holds the last successful value. You can show stale '
          'data + error banner rather than a full error screen.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Hot Reload Resets State',
      'body': 'Hot reload recreates the State object, triggering '
          'initState() again. If your Future/Stream is created there, '
          'the builder restarts from waiting. Use didUpdateWidget to '
          'preserve continuity across hot reloads.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'ConnectionState.values Order',
      'body': 'The enum values are indexed 0–3: none(0), waiting(1), '
          'active(2), done(3). You can use comparisons like '
          'connectionState.index >= ConnectionState.active.index '
          'for threshold checks.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use requireData Carefully',
      'body': 'snapshot.requireData throws a StateError if data is '
          'null. Only use it after confirming hasData == true or '
          'connectionState == done with no error. It\'s a convenience '
          'for the happy path.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('ConnectionState'),
      backgroundColor: Colors.deepPurple[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple[700]!, Colors.purple[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.power, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ConnectionState',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The four-value enum describing the lifecycle '
                  'of an asynchronous connection in FutureBuilder '
                  'and StreamBuilder: none → waiting → active → done.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _heading('1', 'What is ConnectionState?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Enum Values ──
          _heading('2', 'The Four Enum Values'),
          SizedBox(height: 12),
          ...enumValues.map((ev) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ev['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (ev['color'] as Color).withOpacity(0.5)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: ev['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(ev['icon'] as IconData,
                              color: Colors.white, size: 20),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ConnectionState.${ev['name']}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    color: ev['color'] as Color),
                              ),
                              Text('index: ${ev['index']}',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(ev['meaning'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Snapshot: ${ev['snapshot']}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[700])),
                            SizedBox(height: 4),
                            Text(ev['example'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[700])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: FutureBuilder Lifecycle ──
          _heading('3', 'FutureBuilder Lifecycle'),
          SizedBox(height: 12),
          ...futureSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: step['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(step['step'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ),
                      Container(
                          width: 2, height: 30, color: Colors.grey[300]),
                    ]),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(step['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (step['color'] as Color)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(step['state'] as String,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: step['color'] as Color)),
                              ),
                            ]),
                            SizedBox(height: 6),
                            Text(step['detail'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: StreamBuilder Lifecycle ──
          _heading('4', 'StreamBuilder Lifecycle'),
          SizedBox(height: 12),
          ...streamSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: step['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(step['step'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ),
                      Container(
                          width: 2, height: 30, color: Colors.grey[300]),
                    ]),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(step['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (step['color'] as Color)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(step['state'] as String,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: step['color'] as Color)),
                              ),
                            ]),
                            SizedBox(height: 6),
                            Text(step['detail'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Transition Diagram ──
          _heading('5', 'State Transition Diagrams'),
          SizedBox(height: 12),
          _buildDiagram('FutureBuilder Transitions',
              transitionText['future']!, Colors.deepPurple[600]!),
          SizedBox(height: 12),
          _buildDiagram('StreamBuilder Transitions',
              transitionText['stream']!, Colors.green[700]!),

          SizedBox(height: 24),

          // ── Section 6: AsyncSnapshot Anatomy ──
          _heading('6', 'AsyncSnapshot<T> Anatomy'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _cell('Member', bold: true, white: true, flex: 2),
                  _cell('Type', bold: true, white: true, flex: 2),
                  _cell('Description', bold: true, white: true, flex: 4),
                ]),
              ),
              ...snapshotMembers.asMap().entries.map((entry) {
                final idx = entry.key;
                final m = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [
                          Icon(m['icon'] as IconData,
                              size: 14, color: Colors.deepPurple[400]),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text('.${m['member']}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace')),
                          ),
                        ]),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(m['type'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.purple[700])),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(m['desc'] as String,
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[700])),
                      ),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Builder Patterns ──
          _heading('7', 'Correct Builder Patterns'),
          SizedBox(height: 12),
          ...builderPatterns.map((bp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: bp['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(bp['icon'] as IconData,
                            color: bp['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(bp['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(bp['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[800],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(bp['note'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _heading('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...realPatterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips & Gotchas ──
          _heading('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of ConnectionState Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _heading(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.deepPurple[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Table cell
// ──────────────────────────────────────────────────────────
Widget _cell(String text,
    {bool bold = false, bool white = false, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: white ? Colors.white : Colors.grey[800],
        height: 1.3,
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Transition diagram card
// ──────────────────────────────────────────────────────────
Widget _buildDiagram(String title, List<String> lines, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13)),
        SizedBox(height: 8),
        ...lines.map((line) => Text(line,
            style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Colors.green[300],
                height: 1.5))),
      ],
    ),
  );
}
