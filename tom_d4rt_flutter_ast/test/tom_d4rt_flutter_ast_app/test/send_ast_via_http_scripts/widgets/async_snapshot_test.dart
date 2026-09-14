// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — AsyncSnapshot
// Demonstrates AsyncSnapshot<T>, the immutable representation of the most
// recent interaction with an asynchronous computation (Future or Stream).
// Covers ConnectionState, data/error handling, FutureBuilder, StreamBuilder,
// snapshot pattern matching, and real-world usage patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AsyncSnapshot Deep Demo executing');

  // ============================================================
  // SECTION 1: What is AsyncSnapshot?
  // ============================================================
  print('=== Section 1: Core Concepts ===');

  final concepts = <Map<String, dynamic>>[
    {
      'icon': Icons.camera_alt,
      'title': 'Snapshot of Async State',
      'body': 'AsyncSnapshot<T> is an immutable snapshot of the latest '
          'state of an asynchronous computation. It captures three '
          'things: the connectionState (waiting, active, done), '
          'any data received, and any error that occurred.',
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.sync,
      'title': 'ConnectionState',
      'body': 'ConnectionState tracks the lifecycle: none (not connected), '
          'waiting (connected, no data yet), active (stream has '
          'emitted at least one event), done (Future completed or '
          'Stream closed). Each state needs different UI handling.',
      'color': Colors.blue,
    },
    {
      'icon': Icons.build,
      'title': 'Used by Builders',
      'body': 'You rarely create AsyncSnapshot yourself. FutureBuilder '
          'and StreamBuilder create snapshots automatically and pass '
          'them to your builder function. The snapshot tells you '
          'what to render at each moment.',
      'color': Colors.teal,
    },
    {
      'icon': Icons.lock,
      'title': 'Immutable & Type-Safe',
      'body': 'Each snapshot is immutable — a new one is created for '
          'each state change. The generic type T ensures data '
          'access is type-safe. Use hasData / hasError to guard '
          'access to data / error fields.',
      'color': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < concepts.length; i++) {
    final c = concepts[i];
    final color = c['color'] as Color;
    print('  Concept: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.02)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: color, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: ConnectionState Deep Dive
  // ============================================================
  print('=== Section 2: ConnectionState ===');

  final connectionStates = <Map<String, dynamic>>[
    {
      'state': 'none',
      'desc': 'Not connected to any asynchronous computation. '
          'snapshot.data and snapshot.error are both null.',
      'icon': Icons.circle_outlined,
      'color': Colors.grey,
      'futureNote': 'Before future is set',
      'streamNote': 'Before stream is set',
    },
    {
      'state': 'waiting',
      'desc': 'Connected but no data/error yet. The Future is '
          'pending or the Stream has not emitted.',
      'icon': Icons.hourglass_top,
      'color': Colors.amber,
      'futureNote': 'Future is running',
      'streamNote': 'Stream subscribed, no events yet',
    },
    {
      'state': 'active',
      'desc': 'The Stream has emitted at least one event. Not '
          'applicable to Futures (they skip to done).',
      'icon': Icons.flash_on,
      'color': Colors.blue,
      'futureNote': 'N/A (skip to done)',
      'streamNote': 'Stream emitting data',
    },
    {
      'state': 'done',
      'desc': 'The Future has completed or the Stream has closed. '
          'snapshot.data or snapshot.error holds the final result.',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'futureNote': 'Future completed',
      'streamNote': 'Stream closed',
    },
  ];

  final stateCards = <Widget>[];
  for (var i = 0; i < connectionStates.length; i++) {
    final cs = connectionStates[i];
    final color = cs['color'] as Color;
    print('  ConnectionState.${cs['state']}');

    stateCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            // State icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cs['icon'] as IconData, color: color, size: 18),
                  Text(
                    cs['state'] as String,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ConnectionState.${cs['state']}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    cs['desc'] as String,
                    style: TextStyle(
                      fontSize: 10.5,
                      height: 1.3,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Future: ${cs['futureNote']}',
                          style: TextStyle(fontSize: 9, color: Colors.blue.shade700),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Stream: ${cs['streamNote']}',
                          style: TextStyle(fontSize: 9, color: Colors.green.shade700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (i < connectionStates.length - 1) {
      stateCards.add(
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Icon(Icons.arrow_downward, size: 16, color: Colors.grey.shade400),
        ),
      );
    }
  }

  final connectionPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepOrange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sync, color: Colors.deepOrange, size: 22),
            const SizedBox(width: 10),
            Text(
              'ConnectionState Lifecycle',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...stateCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: AsyncSnapshot Properties
  // ============================================================
  print('=== Section 3: Snapshot Properties ===');

  final props = <Map<String, dynamic>>[
    {
      'prop': 'connectionState',
      'type': 'ConnectionState',
      'desc': 'Current state of the async computation.',
      'color': Colors.blue,
    },
    {
      'prop': 'data',
      'type': 'T?',
      'desc': 'Latest data received. Null if none received yet.',
      'color': Colors.green,
    },
    {
      'prop': 'error',
      'type': 'Object?',
      'desc': 'Latest error. Null if no error occurred.',
      'color': Colors.red,
    },
    {
      'prop': 'stackTrace',
      'type': 'StackTrace?',
      'desc': 'Stack trace from the error, if available.',
      'color': Colors.orange,
    },
    {
      'prop': 'hasData',
      'type': 'bool',
      'desc': 'True if data is not null. Safe guard before accessing data.',
      'color': Colors.teal,
    },
    {
      'prop': 'hasError',
      'type': 'bool',
      'desc': 'True if error is not null. Use before accessing error.',
      'color': Colors.pink,
    },
    {
      'prop': 'requireData',
      'type': 'T',
      'desc': 'Returns data or throws if null. For when you are certain data exists.',
      'color': Colors.indigo,
    },
  ];

  final propRows = <Widget>[];
  for (var p in props) {
    final color = p['color'] as Color;
    print('  Property: ${p['prop']}');
    propRows.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '.${p['prop']}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                p['type'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                p['desc'] as String,
                style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final propsPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepOrange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.data_object, color: Colors.deepOrange, size: 22),
            const SizedBox(width: 10),
            Text(
              'AsyncSnapshot Properties',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...propRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 4: FutureBuilder with AsyncSnapshot
  // ============================================================
  print('=== Section 4: FutureBuilder Pattern ===');

  final futureBuilderPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timer, color: Colors.blue, size: 22),
            const SizedBox(width: 10),
            Text(
              'FutureBuilder + AsyncSnapshot',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'FutureBuilder creates AsyncSnapshot<T> snapshots as '
          'the Future progresses through waiting → done:',
          style: TextStyle(fontSize: 12, height: 1.4, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'FutureBuilder<String>(\n'
            '  future: fetchUserName(),\n'
            '  builder: (context, snapshot) {\n'
            '    // 1. Check for errors first\n'
            '    if (snapshot.hasError) {\n'
            '      return ErrorWidget(snapshot.error!);\n'
            '    }\n'
            '    // 2. Check if data is available\n'
            '    if (snapshot.hasData) {\n'
            '      return Text("Hello, \${snapshot.data!}");\n'
            '    }\n'
            '    // 3. Still waiting\n'
            '    return CircularProgressIndicator();\n'
            '  },\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              height: 1.5,
              color: Colors.greenAccent,
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Visual flow
        Row(
          children: [
            _asyncStateBox('waiting', Colors.amber, Icons.hourglass_top),
            Icon(Icons.arrow_forward, size: 14, color: Colors.grey.shade400),
            _asyncStateBox('done\n(data)', Colors.green, Icons.check_circle),
            const Text(' or ', style: TextStyle(fontSize: 10)),
            _asyncStateBox('done\n(error)', Colors.red, Icons.error),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: StreamBuilder with AsyncSnapshot
  // ============================================================
  print('=== Section 5: StreamBuilder Pattern ===');

  final streamBuilderPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.stream, color: Colors.green, size: 22),
            const SizedBox(width: 10),
            Text(
              'StreamBuilder + AsyncSnapshot',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'StreamBuilder creates snapshots for each event. '
          'Unlike FutureBuilder, it goes through the active state:',
          style: TextStyle(fontSize: 12, height: 1.4, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'StreamBuilder<int>(\n'
            '  stream: counterStream(),\n'
            '  builder: (context, snapshot) {\n'
            '    switch (snapshot.connectionState) {\n'
            '      case ConnectionState.none:\n'
            '        return Text("No stream");\n'
            '      case ConnectionState.waiting:\n'
            '        return CircularProgressIndicator();\n'
            '      case ConnectionState.active:\n'
            '        if (snapshot.hasError) {\n'
            '          return Text("Error: \${snapshot.error}");\n'
            '        }\n'
            '        return Text("Count: \${snapshot.data}");\n'
            '      case ConnectionState.done:\n'
            '        return Text("Stream closed");\n'
            '    }\n'
            '  },\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              height: 1.5,
              color: Colors.greenAccent,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _asyncStateBox('waiting', Colors.amber, Icons.hourglass_top),
            Icon(Icons.arrow_forward, size: 14, color: Colors.grey.shade400),
            _asyncStateBox('active\n(data)', Colors.blue, Icons.flash_on),
            Icon(Icons.arrow_forward, size: 14, color: Colors.grey.shade400),
            _asyncStateBox('active\n(more)', Colors.blue, Icons.flash_on),
            Icon(Icons.arrow_forward, size: 14, color: Colors.grey.shade400),
            _asyncStateBox('done', Colors.green, Icons.check_circle),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Snapshot Decision Tree
  // ============================================================
  print('=== Section 6: Decision Tree ===');

  final decisionPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.purple, size: 22),
            const SizedBox(width: 10),
            Text(
              'Snapshot Decision Tree',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Follow this decision tree to handle all snapshot states:',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 16),
        // Level 1: hasError?
        _decisionNode(
          'snapshot.hasError?',
          Colors.red,
          Icons.error_outline,
          isQuestion: true,
        ),
        _decisionBranch('Yes → Show error UI'),
        _decisionAction('ErrorWidget or retry button', Colors.red),
        _decisionBranch('No ↓'),
        // Level 2: hasData?
        _decisionNode(
          'snapshot.hasData?',
          Colors.green,
          Icons.data_usage,
          isQuestion: true,
        ),
        _decisionBranch('Yes → Show data UI'),
        _decisionAction('Build your content widget', Colors.green),
        _decisionBranch('No ↓'),
        // Level 3: connectionState?
        _decisionNode(
          'connectionState == done?',
          Colors.orange,
          Icons.help_outline,
          isQuestion: true,
        ),
        _decisionBranch('Yes → Empty/null result'),
        _decisionAction('Show "no data" placeholder', Colors.orange),
        _decisionBranch('No → Still loading'),
        _decisionAction('Show progress indicator', Colors.amber),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Live FutureBuilder Demo
  // ============================================================
  print('=== Section 7: Live FutureBuilder ===');

  final liveFutureDemo = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'FutureBuilder — User Profile',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Simulating a 2-second API call to fetch user profile:',
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder<Map<String, dynamic>>(
          future: Future.delayed(
            const Duration(seconds: 2),
            () => <String, dynamic>{
              'name': 'Jane Developer',
              'role': 'Senior Engineer',
              'projects': 42,
              'status': 'Active',
            },
          ),
          builder: (context, snapshot) {
            print('  FutureBuilder state: ${snapshot.connectionState}');

            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 32),
                      const SizedBox(width: 12),
                      Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasData) {
              final user = snapshot.data!;
              return _buildProfileCard(user);
            }

            // Loading state
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading profile...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ConnectionState: ${snapshot.connectionState}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'API Response Loading',
      'desc': 'Show skeleton/shimmer while waiting, hydrate UI when '
          'data arrives, show retry button on error.',
      'icon': Icons.cloud_download,
      'color': Colors.blue,
    },
    {
      'title': 'Real-time Chat Messages',
      'desc': 'StreamBuilder with AsyncSnapshot for live message '
          'feed. Active state shows latest messages, done means '
          'the chat room was closed.',
      'icon': Icons.chat,
      'color': Colors.green,
    },
    {
      'title': 'File Upload Progress',
      'desc': 'Stream emitting upload percentage. Active snapshot '
          'shows progress bar. Done snapshot shows success/failure.',
      'icon': Icons.upload_file,
      'color': Colors.orange,
    },
    {
      'title': 'Database Query Cache',
      'desc': 'Use initialData parameter to show cached data while '
          'fresh data loads. Snapshot.data is always available.',
      'icon': Icons.storage,
      'color': Colors.purple,
    },
    {
      'title': 'Authentication State',
      'desc': 'StreamBuilder on auth state stream. Snapshot drives '
          'routing: no user → login, has user → home screen.',
      'icon': Icons.lock_open,
      'color': Colors.red,
    },
    {
      'title': 'WebSocket Connection',
      'desc': 'Stream from WebSocket channel. Active=connected and '
          'receiving. Done=disconnected. Error=connection failed.',
      'icon': Icons.wifi,
      'color': Colors.teal,
    },
  ];

  final patternCards = <Widget>[];
  for (var p in patterns) {
    final color = p['color'] as Color;
    print('  Pattern: ${p['title']}');
    patternCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(p['icon'] as IconData, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final patternPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.teal, size: 22),
            const SizedBox(width: 10),
            Text(
              'Real-World Patterns',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...patternCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Common Anti-Patterns
  // ============================================================
  print('=== Section 9: Anti-Patterns ===');

  final antiPatterns = <Map<String, dynamic>>[
    {
      'title': 'Creating Future in build()',
      'bad': 'FutureBuilder(future: fetchData(), ...)',
      'good': 'Store future as field: _future = fetchData();',
      'why': 'Creating a new Future in build() causes infinite rebuilds '
          'because each build creates a new Future reference.',
    },
    {
      'title': 'Ignoring error state',
      'bad': 'if (snapshot.hasData) { ... } else { loading... }',
      'good': 'Check hasError BEFORE hasData',
      'why': 'A snapshot can be done with an error. Without checking, '
          'you show an infinite loading spinner on failure.',
    },
    {
      'title': 'Using .data without guard',
      'bad': 'Text(snapshot.data!.toString())',
      'good': 'if (snapshot.hasData) Text(snapshot.data!...)',
      'why': 'Accessing .data without hasData guard throws when data '
          'is null (waiting/error states).',
    },
  ];

  final antiCards = <Widget>[];
  for (var ap in antiPatterns) {
    print('  Anti-pattern: ${ap['title']}');
    antiCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.dangerous, color: Colors.red, size: 18),
                const SizedBox(width: 8),
                Text(
                  ap['title'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('BAD',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ap['bad'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('GOOD',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ap['good'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ap['why'] as String,
              style: TextStyle(
                fontSize: 10.5,
                height: 1.3,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final antiPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning, color: Colors.red, size: 22),
            const SizedBox(width: 10),
            Text(
              'Anti-Patterns to Avoid',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...antiCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Summary
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryStats = [
    {'label': 'States', 'value': '${connectionStates.length}', 'color': Colors.blue},
    {'label': 'Properties', 'value': '${props.length}', 'color': Colors.deepOrange},
    {'label': 'Patterns', 'value': '${patterns.length}', 'color': Colors.teal},
    {'label': 'Anti-Patterns', 'value': '${antiPatterns.length}', 'color': Colors.red},
  ];

  final statTiles = <Widget>[];
  for (var stat in summaryStats) {
    final color = stat['color'] as Color;
    statTiles.add(
      Container(
        width: 88,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Text(
              stat['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stat['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  final summaryPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.deepOrange.shade200, width: 2),
    ),
    child: Column(
      children: [
        Text(
          'AsyncSnapshot — Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade800,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(alignment: WrapAlignment.center, children: statTiles),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('=== Assembling final layout ===');

  return Scaffold(
    appBar: AppBar(
      title: const Text('AsyncSnapshot Deep Demo'),
      backgroundColor: Colors.deepOrange.shade700,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.deepOrange.shade50,
            child: Column(
              children: [
                Icon(Icons.camera_alt, size: 48, color: Colors.deepOrange.shade700),
                const SizedBox(height: 10),
                Text(
                  'AsyncSnapshot<T>',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Immutable snapshot of the latest state of an '
                  'asynchronous computation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.deepOrange.shade600,
                  ),
                ),
              ],
            ),
          ),
          _asyncSectionHeader('1. Core Concepts'),
          ...conceptCards,
          _asyncSectionHeader('2. ConnectionState'),
          connectionPanel,
          _asyncSectionHeader('3. Properties'),
          propsPanel,
          _asyncSectionHeader('4. FutureBuilder'),
          futureBuilderPanel,
          _asyncSectionHeader('5. StreamBuilder'),
          streamBuilderPanel,
          _asyncSectionHeader('6. Decision Tree'),
          decisionPanel,
          _asyncSectionHeader('7. Live Demo'),
          liveFutureDemo,
          _asyncSectionHeader('8. Real-World Patterns'),
          patternPanel,
          _asyncSectionHeader('9. Anti-Patterns'),
          antiPanel,
          _asyncSectionHeader('10. Summary'),
          summaryPanel,
          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

Widget _asyncSectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 20, 16, 4),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade700,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _asyncStateBox(String label, Color color, IconData icon) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _decisionNode(String text, Color color, IconData icon,
    {bool isQuestion = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: isQuestion ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: isQuestion ? BorderRadius.circular(8) : null,
            border: Border.all(color: color),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _decisionBranch(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 14, top: 2, bottom: 2),
    child: Text(
      text,
      style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
    ),
  );
}

Widget _decisionAction(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(left: 42, top: 2, bottom: 4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.5,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget _buildProfileCard(Map<String, dynamic> user) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: Colors.blue, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                Text(
                  user['role'] as String,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${user['projects']} projects',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        user['status'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
