// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FutureBuilder<T> from package:flutter/widgets.dart
// Deep Demo: Visual demonstration of FutureBuilder, AsyncSnapshot, ConnectionState
// and all the canonical builder branching idioms — without any runtime async.
import 'package:flutter/material.dart';

// ============================================================
// Top-level value type used in the data showcase (Section 4)
// ============================================================
class User {
  final String name;
  final int age;
  final String role;
  const User(this.name, this.age, this.role);

  @override
  String toString() => 'User($name, $age, $role)';
}

// ============================================================
// Top-level "user" used by the data showcase
// ============================================================
const User kDemoUser = User('Ada Lovelace', 36, 'Mathematician');

// ============================================================
// The canonical builder we will reuse in the gallery sections.
// It branches on connectionState/hasError/hasData, exactly the
// way the FutureBuilder docs recommend.
// ============================================================
Widget _canonicalBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  if (snapshot.hasError) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, color: Colors.red.shade700, size: 20.0),
        SizedBox(width: 6.0),
        Flexible(
          child: Text(
            'Error: ${snapshot.error}',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.red.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
  if (snapshot.connectionState == ConnectionState.waiting) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16.0,
          height: 16.0,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          'waiting…',
          style: TextStyle(fontSize: 12.0, color: Colors.teal.shade900),
        ),
      ],
    );
  }
  if (snapshot.connectionState == ConnectionState.none) {
    return Text(
      'no future attached',
      style: TextStyle(
        fontSize: 12.0,
        fontStyle: FontStyle.italic,
        color: Colors.blueGrey.shade700,
      ),
    );
  }
  if (snapshot.hasData) {
    return Text(
      'data: ${snapshot.data}',
      style: TextStyle(
        fontSize: 12.0,
        color: Colors.indigo.shade900,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  return Text(
    'empty (state=${snapshot.connectionState.name})',
    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
  );
}

dynamic build(BuildContext context) {
  print('FutureBuilder Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D3B66),
          Color(0xFF0E6BA8),
          Color(0xFF1B998B),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.hourglass_top, size: 64.0, color: Colors.white),
        SizedBox(height: 8.0),
        Text(
          'FutureBuilder<T>',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Asynchronous widgets, materialised one snapshot at a time',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0,
          runSpacing: 6.0,
          children: [
            _buildBannerChip('Future<T>?', Icons.bolt),
            _buildBannerChip('initialData: T?', Icons.flag),
            _buildBannerChip('AsyncWidgetBuilder<T>', Icons.widgets),
            _buildBannerChip('AsyncSnapshot<T>', Icons.camera_alt),
          ],
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Anatomy of a FutureBuilder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnatomyNode('Future<T>', Icons.bolt, Colors.indigo),
            _buildAnatomyPlus(),
            _buildAnatomyNode('initialData', Icons.flag, Colors.teal),
          ],
        ),
        SizedBox(height: 8.0),
        Center(
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.blueGrey.shade600,
          ),
        ),
        SizedBox(height: 8.0),
        Center(
          child: _buildAnatomyNode(
            'AsyncSnapshot<T>',
            Icons.camera_alt,
            Colors.deepPurple,
          ),
        ),
        SizedBox(height: 8.0),
        Center(
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.blueGrey.shade600,
          ),
        ),
        SizedBox(height: 8.0),
        Center(
          child: _buildAnatomyNode(
            'AsyncWidgetBuilder<T>',
            Icons.functions,
            Colors.orange,
          ),
        ),
        SizedBox(height: 8.0),
        Center(
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.blueGrey.shade600,
          ),
        ),
        SizedBox(height: 8.0),
        Center(
          child: _buildAnatomyNode('Widget', Icons.widgets, Colors.green),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'FutureBuilder<T>(\n'
            '  future: someFuture,\n'
            '  initialData: fallback,\n'
            '  builder: (ctx, snap) => …,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyan.shade200,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: ConnectionState gallery
  // Render the canonical builder against synthetic snapshots
  // for each ConnectionState.
  // ============================================================
  print('=== Section 3: ConnectionState gallery ===');

  final builder = _canonicalBuilder;

  final stateGalleryEntries = <Map<String, dynamic>>[
    {
      'state': ConnectionState.none,
      'snapshot': AsyncSnapshot<String>.nothing(),
      'color': Colors.blueGrey,
      'icon': Icons.power_off,
      'label': 'none',
      'desc': 'No future attached (yet)',
    },
    {
      'state': ConnectionState.waiting,
      'snapshot': AsyncSnapshot<String>.waiting(),
      'color': Colors.teal,
      'icon': Icons.hourglass_bottom,
      'label': 'waiting',
      'desc': 'Future in flight, no data',
    },
    {
      'state': ConnectionState.active,
      'snapshot': AsyncSnapshot<String>.withData(
        ConnectionState.active,
        'partial-payload',
      ),
      'color': Colors.amber,
      'icon': Icons.sync,
      'label': 'active',
      'desc': 'Streaming partial data',
    },
    {
      'state': ConnectionState.done,
      'snapshot': AsyncSnapshot<String>.withData(
        ConnectionState.done,
        'final-payload',
      ),
      'color': Colors.green,
      'icon': Icons.check_circle,
      'label': 'done',
      'desc': 'Future completed',
    },
  ];

  final stateGalleryCards = <Widget>[];
  for (final entry in stateGalleryEntries) {
    final snap = entry['snapshot'] as AsyncSnapshot<dynamic>;
    final color = entry['color'] as MaterialColor;
    print(
      'ConnectionState.${(entry['state'] as ConnectionState).name} '
      'hasData=${snap.hasData} hasError=${snap.hasError} data=${snap.data}',
    );
    stateGalleryCards.add(
      Container(
        width: 200.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.shade50,
              color.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.shade400, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  entry['icon'] as IconData,
                  color: color.shade800,
                  size: 22.0,
                ),
                SizedBox(width: 6.0),
                Text(
                  'ConnectionState.${entry['label']}',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: color.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              entry['desc'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.blueGrey.shade800,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: color.shade200),
              ),
              child: builder(context, snap),
            ),
            SizedBox(height: 8.0),
            _buildSnapshotChips(snap),
          ],
        ),
      ),
    );
  }
  print('Created ${stateGalleryCards.length} ConnectionState cards');

  // ============================================================
  // SECTION 4: Snapshot-with-data showcase
  // ============================================================
  print('=== Section 4: Snapshot-with-data showcase ===');

  final dataEntries = <Map<String, dynamic>>[
    {
      'type': 'int',
      'snapshot': AsyncSnapshot<int>.withData(ConnectionState.done, 42),
      'color': Colors.indigo,
      'icon': Icons.tag,
    },
    {
      'type': 'String',
      'snapshot': AsyncSnapshot<String>.withData(
        ConnectionState.done,
        'hello, world',
      ),
      'color': Colors.teal,
      'icon': Icons.text_fields,
    },
    {
      'type': 'List<int>',
      'snapshot': AsyncSnapshot<List<int>>.withData(
        ConnectionState.done,
        <int>[1, 2, 3, 5, 8, 13],
      ),
      'color': Colors.deepPurple,
      'icon': Icons.format_list_numbered,
    },
    {
      'type': 'Map<String,dynamic>',
      'snapshot': AsyncSnapshot<Map<String, dynamic>>.withData(
        ConnectionState.done,
        <String, dynamic>{'ok': true, 'count': 7, 'kind': 'json'},
      ),
      'color': Colors.blue,
      'icon': Icons.data_object,
    },
    {
      'type': 'User',
      'snapshot': AsyncSnapshot<User>.withData(
        ConnectionState.done,
        kDemoUser,
      ),
      'color': Colors.green,
      'icon': Icons.person,
    },
  ];

  final dataCards = <Widget>[];
  for (final e in dataEntries) {
    final snap = e['snapshot'] as AsyncSnapshot<dynamic>;
    final color = e['color'] as MaterialColor;
    print('with-data <${e['type']}> => ${snap.data}');
    dataCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                e['icon'] as IconData,
                color: color.shade800,
                size: 26.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AsyncSnapshot<${e['type']}>',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  _buildCodeBlock(
                    'AsyncSnapshot.withData(\n'
                    '  ConnectionState.done,\n'
                    '  ${_inlineRepr(snap.data)},\n'
                    ')',
                    Colors.cyan.shade300,
                    Colors.grey.shade900,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: color.shade200),
                    ),
                    child: builder(context, snap),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${dataCards.length} with-data cards');

  // ============================================================
  // SECTION 5: Snapshot-with-error showcase
  // ============================================================
  print('=== Section 5: Snapshot-with-error showcase ===');

  final errorEntries = <Map<String, dynamic>>[
    {
      'label': "Exception('boom')",
      'error': Exception('boom'),
      'icon': Icons.error,
    },
    {
      'label': "FormatException('bad input')",
      'error': FormatException('bad input'),
      'icon': Icons.report_gmailerrorred,
    },
    {
      'label': "TimeoutException('30s')",
      'error': _PseudoTimeout('30s'),
      'icon': Icons.timer_off,
    },
    {
      'label': "StateError('cancelled')",
      'error': StateError('cancelled'),
      'icon': Icons.cancel,
    },
  ];

  final errorCards = <Widget>[];
  for (final e in errorEntries) {
    final snap = AsyncSnapshot<String>.withError(
      ConnectionState.done,
      e['error'] as Object,
      StackTrace.empty,
    );
    print('with-error => ${snap.error}');
    errorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.orange.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: Colors.red.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              e['icon'] as IconData,
              color: Colors.red.shade700,
              size: 28.0,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e['label'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade900,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: builder(context, snap),
                  ),
                  SizedBox(height: 6.0),
                  _buildSnapshotChips(snap),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${errorCards.length} with-error cards');

  // ============================================================
  // SECTION 6: initialData pattern
  // ============================================================
  print('=== Section 6: initialData pattern ===');

  // With initialData → snapshot has data immediately, even while waiting.
  final withInitial = AsyncSnapshot<String>.withData(
    ConnectionState.waiting,
    'fallback',
  );
  // Without initialData → no data while waiting.
  final withoutInitial = AsyncSnapshot<String>.waiting();

  final initialDataSection = Column(
    children: [
      _buildInitialDataCard(
        title: 'with initialData: \'fallback\'',
        snippet:
            'FutureBuilder<String>(\n'
            '  future: load(),\n'
            '  initialData: \'fallback\',\n'
            '  builder: (ctx, snap) => …,\n'
            ')',
        snap: withInitial,
        accent: Colors.teal,
        builder: builder,
      ),
      _buildInitialDataCard(
        title: 'without initialData',
        snippet:
            'FutureBuilder<String>(\n'
            '  future: load(),\n'
            '  builder: (ctx, snap) => …,\n'
            ')',
        snap: withoutInitial,
        accent: Colors.deepOrange,
        builder: builder,
      ),
    ],
  );
  print('Created initialData section');

  // ============================================================
  // SECTION 7: Builder branching idiom — code block
  // ============================================================
  print('=== Section 7: Builder branching idiom ===');

  final branchingIdiom = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'The canonical builder branching idiom',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          'builder: (BuildContext context, AsyncSnapshot<T> snapshot) {\n'
          '  if (snapshot.connectionState == ConnectionState.waiting) {\n'
          '    return CircularProgressIndicator();\n'
          '  } else if (snapshot.hasError) {\n'
          '    return Text(\'Error: \${snapshot.error}\');\n'
          '  } else if (snapshot.hasData) {\n'
          '    return Text(\'Data: \${snapshot.data}\');\n'
          '  } else {\n'
          '    return Text(\'No data yet\');\n'
          '  }\n'
          '}',
          Colors.lightGreen.shade300,
          Colors.grey.shade800,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Order matters: check waiting BEFORE hasData/hasError\n'
          '// when initialData is used, otherwise the spinner is\n'
          '// never shown.',
          Colors.amber.shade200,
          Colors.grey.shade800,
        ),
      ],
    ),
  );
  print('Created branching idiom block');

  // ============================================================
  // SECTION 8: Real-world mocks
  // ============================================================
  print('=== Section 8: Real-world mocks ===');

  final imageWaiting = AsyncSnapshot<String>.waiting();
  final jsonDone = AsyncSnapshot<List<Map<String, dynamic>>>.withData(
    ConnectionState.done,
    <Map<String, dynamic>>[
      {'id': 1, 'title': 'Read the docs'},
      {'id': 2, 'title': 'Write a builder'},
      {'id': 3, 'title': 'Handle errors'},
      {'id': 4, 'title': 'Memoise the future'},
      {'id': 5, 'title': 'Ship it'},
    ],
  );
  final errBanner = AsyncSnapshot<String>.withError(
    ConnectionState.done,
    Exception('network unreachable'),
    StackTrace.empty,
  );

  final realWorld = Column(
    children: [
      _buildMockCard(
        title: 'Image placeholder (waiting)',
        accent: Colors.blueGrey,
        body: Container(
          height: 100.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey.shade100,
                Colors.blueGrey.shade300,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: imageWaiting.connectionState == ConnectionState.waiting
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'loading image…',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  )
                : Icon(Icons.image, color: Colors.white, size: 36.0),
          ),
        ),
      ),
      _buildMockCard(
        title: 'JSON list (done, 5 items)',
        accent: Colors.indigo,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final item
                in (jsonDone.data ?? const <Map<String, dynamic>>[]))
              Container(
                margin: EdgeInsets.symmetric(vertical: 3.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.indigo.shade100),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24.0,
                      height: 24.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade200,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '${item['id']}',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        '${item['title']}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      _buildMockCard(
        title: 'Error banner (hasError)',
        accent: Colors.red,
        body: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.shade300),
          ),
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red.shade700,
                size: 22.0,
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Failed to load: ${errBanner.error}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      _buildMockCard(
        title: 'Retry button (after failure)',
        accent: Colors.teal,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade400, Colors.teal.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: Colors.white, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
  print('Created real-world mocks');

  // ============================================================
  // SECTION 9: Comparison table
  // ============================================================
  print('=== Section 9: Comparison table ===');

  final comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.12),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'FutureBuilder vs StreamBuilder vs ValueListenableBuilder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              _buildHeaderCell('Aspect', 110.0),
              _buildHeaderCell('FutureBuilder', 100.0),
              _buildHeaderCell('StreamBuilder', 100.0),
              _buildHeaderCell('ValueListenable', 110.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _buildComparisonRow('source', 'Future<T>', 'Stream<T>', 'Listenable'),
        _buildComparisonRow('emits', 'one value', 'many values', 'one value'),
        _buildComparisonRow('snapshot', 'AsyncSnapshot', 'AsyncSnapshot', 'T'),
        _buildComparisonRow('errors', 'snapshot.error', 'snapshot.error', 'n/a'),
        _buildComparisonRow('initial', 'initialData', 'initialData', 'value'),
        _buildComparisonRow('rebuild', 'on completion', 'on each event',
            'on notify'),
      ],
    ),
  );
  print('Created comparison table');

  // ============================================================
  // SECTION 10: Common pitfalls
  // ============================================================
  print('=== Section 10: Common pitfalls ===');

  final pitfalls = <Map<String, dynamic>>[
    {
      'title': 'Re-creating the future in build()',
      'desc':
          'Calling fetch() inline inside build() creates a new Future each\n'
              'rebuild, retriggering the entire chain. Hoist the future to\n'
              'a State field or initState.',
      'icon': Icons.loop,
      'color': Colors.red,
    },
    {
      'title': 'No memoisation, parent rebuilds',
      'desc':
          'If the parent rebuilds, FutureBuilder receives a new builder/\n'
              'future and may flash a spinner. Cache the future once.',
      'icon': Icons.cached,
      'color': Colors.orange,
    },
    {
      'title': 'Treating snapshot.data as non-null',
      'desc':
          'snapshot.data is T?, not T. Always guard with hasData or\n'
              'connectionState == done before using ! or .data!.field.',
      'icon': Icons.dangerous,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Ignoring stack traces',
      'desc':
          'snapshot.stackTrace is often dropped. Log it next to error\n'
              'so production crashes are debuggable.',
      'icon': Icons.bug_report,
      'color': Colors.purple,
    },
    {
      'title': 'Disposed widget, orphan snapshot',
      'desc':
          'If the widget unmounts mid-flight, FutureBuilder ignores the\n'
              'callback safely — but your own setState in side-channels\n'
              'must still check `mounted`.',
      'icon': Icons.link_off,
      'color': Colors.blueGrey,
    },
  ];

  final pitfallCards = <Widget>[];
  for (final p in pitfalls) {
    final color = p['color'] as MaterialColor;
    pitfallCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(p['icon'] as IconData, color: color.shade800),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    p['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.blueGrey.shade800,
                      height: 1.4,
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
  print('Created ${pitfallCards.length} pitfall cards');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap card ===');

  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D3B66),
          Color(0xFF1B998B),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRecapBullet(
          'FutureBuilder<T> turns a Future<T> into a stream of widget '
          'rebuilds via AsyncSnapshot<T>.',
        ),
        _buildRecapBullet(
          'AsyncSnapshot exposes connectionState, data, error, stackTrace '
          '(plus hasData/hasError convenience getters).',
        ),
        _buildRecapBullet(
          'initialData is rendered immediately while the future is still '
          'in ConnectionState.waiting.',
        ),
        _buildRecapBullet(
          'The canonical builder branches: waiting → spinner, '
          'hasError → message, hasData → content.',
        ),
        _buildRecapBullet(
          'Always memoise the future — never construct it inline in build().',
        ),
      ],
    ),
  );
  print('Created recap card');

  print('FutureBuilder Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF1F8FB),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Title
          titleBanner,
          SizedBox(height: 28.0),

          // 2. Anatomy
          _buildSectionHeader('1. Anatomy', Icons.account_tree),
          anatomy,
          SizedBox(height: 24.0),

          // 3. ConnectionState gallery
          _buildSectionHeader(
            '2. ConnectionState Gallery',
            Icons.timeline,
          ),
          Wrap(alignment: WrapAlignment.center, children: stateGalleryCards),
          SizedBox(height: 24.0),

          // 4. with-data showcase
          _buildSectionHeader('3. AsyncSnapshot.withData', Icons.dataset),
          ...dataCards,
          SizedBox(height: 24.0),

          // 5. with-error showcase
          _buildSectionHeader('4. AsyncSnapshot.withError', Icons.error),
          ...errorCards,
          SizedBox(height: 24.0),

          // 6. initialData
          _buildSectionHeader('5. initialData pattern', Icons.flag),
          initialDataSection,
          SizedBox(height: 24.0),

          // 7. branching idiom
          _buildSectionHeader('6. Builder branching idiom', Icons.code),
          branchingIdiom,
          SizedBox(height: 24.0),

          // 8. real-world mocks
          _buildSectionHeader('7. Real-world mocks', Icons.dashboard),
          realWorld,
          SizedBox(height: 24.0),

          // 9. comparison
          _buildSectionHeader('8. Comparison', Icons.compare_arrows),
          comparison,
          SizedBox(height: 24.0),

          // 10. pitfalls
          _buildSectionHeader('9. Common pitfalls', Icons.warning_amber),
          ...pitfallCards,
          SizedBox(height: 24.0),

          // 11. recap
          _buildSectionHeader('10. Recap', Icons.summarize),
          recap,
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

// Section header (title strip).
Widget _buildSectionHeader(String text, IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0, top: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0E6BA8).withValues(alpha: 0.08),
          Color(0xFF1B998B).withValues(alpha: 0.08),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: Color(0xFF0E6BA8), width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF0D3B66), size: 22.0),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B66),
          ),
        ),
      ],
    ),
  );
}

// Banner chip (top header).
Widget _buildBannerChip(String text, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// Anatomy node (boxed pill in the diagram).
Widget _buildAnatomyNode(String label, IconData icon, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade400, color.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 18.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// Plus separator between anatomy nodes.
Widget _buildAnatomyPlus() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    width: 28.0,
    height: 28.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade300),
    ),
    child: Text(
      '+',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey.shade700,
      ),
    ),
  );
}

// Header cell for the comparison table.
Widget _buildHeaderCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

// One row of the comparison table.
Widget _buildComparisonRow(
  String aspect,
  String fb,
  String sb,
  String vlb,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.indigo.shade100, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        _buildBodyCell(aspect, 110.0, Colors.indigo.shade900,
            FontWeight.w600),
        _buildBodyCell(fb, 100.0, Colors.indigo.shade700, FontWeight.normal),
        _buildBodyCell(sb, 100.0, Colors.teal.shade700, FontWeight.normal),
        _buildBodyCell(
          vlb,
          110.0,
          Colors.deepPurple.shade700,
          FontWeight.normal,
        ),
      ],
    ),
  );
}

Widget _buildBodyCell(
  String text,
  double width,
  Color color,
  FontWeight weight,
) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11.0,
        color: color,
        fontWeight: weight,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// Snapshot info chips: connectionState/hasData/hasError.
Widget _buildSnapshotChips(AsyncSnapshot<dynamic> snap) {
  return Wrap(
    spacing: 4.0,
    runSpacing: 4.0,
    children: [
      _buildChip(
        'state=${snap.connectionState.name}',
        Colors.blue.shade700,
      ),
      _buildChip(
        'hasData=${snap.hasData}',
        snap.hasData ? Colors.green.shade700 : Colors.grey.shade600,
      ),
      _buildChip(
        'hasError=${snap.hasError}',
        snap.hasError ? Colors.red.shade700 : Colors.grey.shade600,
      ),
    ],
  );
}

Widget _buildChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 9.5,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Code-block container, dark-styled.
Widget _buildCodeBlock(String code, Color textColor, Color bgColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

// initialData card (Section 6).
Widget _buildInitialDataCard({
  required String title,
  required String snippet,
  required AsyncSnapshot<dynamic> snap,
  required MaterialColor accent,
  required Widget Function(BuildContext, AsyncSnapshot<dynamic>) builder,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accent.shade50, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, color: accent.shade700),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: accent.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        _buildCodeBlock(snippet, Colors.cyan.shade300, Colors.grey.shade900),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.shade200),
          ),
          child: Builder(
            builder: (BuildContext ctx) => builder(ctx, snap),
          ),
        ),
        SizedBox(height: 6.0),
        _buildSnapshotChips(snap),
      ],
    ),
  );
}

// Mock card scaffold (Section 8).
Widget _buildMockCard({
  required String title,
  required MaterialColor accent,
  required Widget body,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: accent.shade400,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: accent.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        body,
      ],
    ),
  );
}

// Recap bullet (Section 11).
Widget _buildRecapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.tealAccent.shade100,
          size: 18.0,
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// Tiny inline repr for code snippets in Section 4.
String _inlineRepr(Object? data) {
  if (data == null) return 'null';
  if (data is String) return "'$data'";
  if (data is List) {
    final items = data.take(6).map((e) => e.toString()).join(', ');
    return '[$items]';
  }
  if (data is Map) {
    final entries =
        data.entries.take(4).map((e) => '${e.key}: ${e.value}').join(', ');
    return '{$entries}';
  }
  return data.toString();
}

// ============================================================
// A pseudo-TimeoutException so we don't import dart:async at runtime.
// We only need an Object whose toString() looks like
// "TimeoutException: 30s" to render.
// ============================================================
class _PseudoTimeout implements Exception {
  final String duration;
  const _PseudoTimeout(this.duration);

  @override
  String toString() => 'TimeoutException after $duration';
}
