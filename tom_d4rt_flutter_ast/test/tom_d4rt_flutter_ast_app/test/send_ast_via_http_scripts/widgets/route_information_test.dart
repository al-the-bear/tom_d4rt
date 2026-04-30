// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RouteInformation  –  Deep Visual Demo
//
//  Palette: DeepPurple 600 / Lime 500
//  Tabs  : Theory · Builder · Nav 2 Flow
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RouteInformation demo building');
  return _RouteInformationDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF5E35B1); // DeepPurple 600
const _kAccent = Color(0xFFCDDC39); // Lime 500
const _kSurface = Color(0xFFEDE7F6); // DeepPurple 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF311B92); // DeepPurple 900
const _kMuted = Color(0xFFB39DDB); // DeepPurple 200
const _kCodeBg = Color(0xFFF9FBE7); // Lime 50
const _kHighlight = Color(0xFFFFF8E1); // Amber 50
const _kUriColor = Color(0xFF00897B); // Teal 600
const _kStateColor = Color(0xFFE65100); // Orange 900
const _kStepA = Color(0xFF1565C0);
const _kStepB = Color(0xFF2E7D32);
const _kStepC = Color(0xFFC62828);
const _kStepD = Color(0xFF6A1B9A);

class _RouteInformationDemo extends StatefulWidget {
  @override
  State<_RouteInformationDemo> createState() =>
      _RouteInformationDemoState();
}

class _RouteInformationDemoState extends State<_RouteInformationDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: Text('RouteInformation',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Builder'),
            Tab(text: 'Nav 2 Flow'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _BuilderTab(),
          _Nav2FlowTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 1  –  Theory
// ═══════════════════════════════════════════════════════════
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Overview ────────────────────────────────────
        _sectionCard(
          'What is RouteInformation?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RouteInformation is a data class that carries the current '
                'route\'s URI and optional state from the platform (browser '
                'URL, Android intent, etc.) into the Flutter router. It is '
                'the bridge between the operating system\'s navigation model '
                'and Flutter\'s Navigator 2.0.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'class RouteInformation {\n'
                '  RouteInformation({\n'
                '    String? location,    // deprecated\n'
                '    Uri? uri,            // preferred\n'
                '    Object? state,       // opaque state\n'
                '  });\n'
                '\n'
                '  Uri get uri;           // parsed URI\n'
                '  String get location;   // string form (deprecated)\n'
                '  Object? get state;     // serializable state\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Properties ──────────────────────────────────
        _sectionCard(
          'Key Properties',
          Column(
            children: [
              _propRow(
                'uri',
                'Uri',
                'The full URI (path + query + fragment). This is the primary '
                'way to read the route. Includes scheme, host, path, query '
                'parameters, and fragment.',
                _kUriColor,
                Icons.link,
              ),
              SizedBox(height: 8),
              _propRow(
                'state',
                'Object?',
                'An opaque state object associated with the route. On web, '
                'this maps to the browser\'s History.state. Can hold any '
                'serializable data.',
                _kStateColor,
                Icons.data_object,
              ),
              SizedBox(height: 8),
              _propRow(
                'location',
                'String',
                'Deprecated: Use uri.toString() instead. Returns the string '
                'representation of the URI. Included for backward '
                'compatibility with older Router implementations.',
                Colors.grey.shade600,
                Icons.text_fields,
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── URI anatomy ─────────────────────────────────
        _sectionCard(
          'Anatomy of a Route URI',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kCodeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '/products/42?color=blue&size=L#reviews',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _kDarkText),
                    ),
                    SizedBox(height: 10),
                    _uriPart('/products/42', 'path', _kPrimary),
                    SizedBox(height: 4),
                    _uriPart('color=blue&size=L', 'queryParameters',
                        _kUriColor),
                    SizedBox(height: 4),
                    _uriPart('reviews', 'fragment', _kStepC),
                    SizedBox(height: 4),
                    _uriPart('2', 'pathSegments[1]', _kStepD),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Role in Navigator 2.0 ──────────────────────
        _sectionCard(
          'Role in Navigator 2.0',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _roleStep(1, 'Platform URL Change',
                  'Browser/OS provides a new URL or the app calls Router.navigate().',
                  _kStepA, Icons.public),
              SizedBox(height: 6),
              _roleStep(2, 'RouteInformationProvider',
                  'Wraps the platform-provided URI + state into a RouteInformation object.',
                  _kStepB, Icons.input),
              SizedBox(height: 6),
              _roleStep(3, 'RouteInformationParser',
                  'Parses RouteInformation into an app-specific configuration object (e.g., a route tree).',
                  _kStepC, Icons.settings),
              SizedBox(height: 6),
              _roleStep(4, 'RouterDelegate',
                  'Builds the Navigator/page stack from the parsed configuration.',
                  _kStepD, Icons.account_tree),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kHighlight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Color(0xFFFFC107).withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline,
                        size: 16, color: Color(0xFFF57F17)),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'RouteInformation flows in both directions: '
                        'platform → app (initial load, back button) and '
                        'app → platform (updating the browser URL bar).',
                        style: TextStyle(
                            fontSize: 12,
                            color: _kDarkText,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Comparison with RouteSettings ───────────────
        _sectionCard(
          'RouteInformation vs RouteSettings',
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              _tableRow(
                  ['Aspect', 'RouteInformation', 'RouteSettings'],
                  isHeader: true),
              _tableRow([
                'Used by',
                'Navigator 2.0 (Router)',
                'Navigator 1.0 (push/pop)',
              ]),
              _tableRow([
                'Identifier',
                'uri (Uri)',
                'name (String?)',
              ]),
              _tableRow([
                'State',
                'state (Object?)',
                'arguments (Object?)',
              ]),
              _tableRow([
                'Platform aware',
                'Yes — maps to browser URL',
                'No — internal only',
              ]),
              _tableRow([
                'Query params',
                'Built-in via Uri',
                'Must encode manually',
              ]),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Best practices ──────────────────────────────
        _sectionCard(
          'Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bp(true,
                  'Use the uri property instead of the deprecated '
                  'location string for richer URL handling.'),
              _bp(true,
                  'Keep the state object serializable — on web it goes '
                  'through the History API which requires JSON-safe data.'),
              _bp(true,
                  'Parse query parameters from uri.queryParameters rather '
                  'than manually splitting the location string.'),
              _bp(false,
                  'Do NOT include sensitive information in the URI — it is '
                  'visible in the browser address bar.'),
              _bp(false,
                  'Do NOT rely on state persisting across app restarts on '
                  'mobile — it is only guaranteed for the current session.'),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Builder
// ═══════════════════════════════════════════════════════════
class _BuilderTab extends StatefulWidget {
  @override
  State<_BuilderTab> createState() => _BuilderTabState();
}

class _BuilderTabState extends State<_BuilderTab> {
  final TextEditingController _pathCtrl =
      TextEditingController(text: '/products/42');
  final TextEditingController _fragCtrl =
      TextEditingController(text: 'reviews');
  final TextEditingController _stateCtrl =
      TextEditingController(text: 'scrollPos: 142');

  // Query parameter entries
  final List<_QueryParam> _queryParams = [
    _QueryParam('color', 'blue'),
    _QueryParam('size', 'L'),
  ];

  int _buildCount = 0;
  final List<_BuildEvent> _builds = [];

  void _addParam() {
    setState(() {
      _queryParams.add(_QueryParam('key', 'value'));
    });
  }

  void _removeParam(int i) {
    setState(() {
      _queryParams.removeAt(i);
    });
  }

  void _buildRouteInfo() {
    _buildCount++;
    final path = _pathCtrl.text.isEmpty ? '/' : _pathCtrl.text;
    final frag = _fragCtrl.text;
    final qp = {
      for (final p in _queryParams)
        if (p.key.isNotEmpty) p.key: p.value
    };

    final uri = Uri(
      path: path,
      queryParameters: qp.isEmpty ? null : qp,
      fragment: frag.isEmpty ? null : frag,
    );

    setState(() {
      _builds.insert(
        0,
        _BuildEvent(
          id: _buildCount,
          fullUri: uri.toString(),
          path: uri.path,
          query: uri.query,
          fragment: uri.fragment,
          paramCount: qp.length,
          segments: uri.pathSegments,
          state: _stateCtrl.text,
          time: DateTime.now(),
        ),
      );
      if (_builds.length > 20) _builds.removeLast();
    });

    print('Built RouteInformation: ${uri.toString()}, '
        'state=${_stateCtrl.text}');
  }

  @override
  void dispose() {
    _pathCtrl.dispose();
    _fragCtrl.dispose();
    _stateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Compute live URI preview
    final path = _pathCtrl.text.isEmpty ? '/' : _pathCtrl.text;
    final frag = _fragCtrl.text;
    final qp = {
      for (final p in _queryParams)
        if (p.key.isNotEmpty) p.key: p.value
    };
    final previewUri = Uri(
      path: path,
      queryParameters: qp.isEmpty ? null : qp,
      fragment: frag.isEmpty ? null : frag,
    );

    return Row(
      children: [
        // Left: builder controls
        Expanded(
          flex: 3,
          child: ListView(
            padding: EdgeInsets.all(14),
            children: [
              // ── URI preview ───────────────────────────
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kPrimary.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Live URI Preview',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: _kPrimary)),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _kCardBg,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: _kPrimary.withOpacity(0.2)),
                      ),
                      child: Text(
                        previewUri.toString(),
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _kUriColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Path input ────────────────────────────
              _sectionCard(
                'Path',
                TextField(
                  controller: _pathCtrl,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: '/products/42',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    prefixIcon: Icon(Icons.route, size: 18),
                  ),
                  style: TextStyle(
                      fontFamily: 'monospace', fontSize: 13),
                ),
              ),
              SizedBox(height: 12),

              // ── Query Parameters ──────────────────────
              _sectionCard(
                'Query Parameters',
                Column(
                  children: [
                    ...List.generate(_queryParams.length, (i) {
                      final p = _queryParams[i];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller:
                                    TextEditingController(text: p.key),
                                onChanged: (v) {
                                  _queryParams[i] =
                                      _QueryParam(v, p.value);
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  labelText: 'Key',
                                  labelStyle: TextStyle(fontSize: 10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(6)),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                ),
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 11),
                              ),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                controller:
                                    TextEditingController(text: p.value),
                                onChanged: (v) {
                                  _queryParams[i] =
                                      _QueryParam(p.key, v);
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  labelText: 'Value',
                                  labelStyle: TextStyle(fontSize: 10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(6)),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                ),
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 11),
                              ),
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => _removeParam(i),
                              child: Icon(Icons.close,
                                  size: 18, color: _kStepC),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 4),
                    GestureDetector(
                      onTap: _addParam,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _kAccent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _kAccent.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, size: 14, color: _kPrimary),
                            SizedBox(width: 4),
                            Text('Add Parameter',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _kPrimary)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Fragment ──────────────────────────────
              _sectionCard(
                'Fragment (#)',
                TextField(
                  controller: _fragCtrl,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'section-name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    prefixIcon: Icon(Icons.tag, size: 18),
                  ),
                  style: TextStyle(
                      fontFamily: 'monospace', fontSize: 13),
                ),
              ),
              SizedBox(height: 12),

              // ── State ─────────────────────────────────
              _sectionCard(
                'State (Object?)',
                TextField(
                  controller: _stateCtrl,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Any serializable data',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    prefixIcon: Icon(Icons.data_object, size: 18),
                  ),
                  style: TextStyle(
                      fontFamily: 'monospace', fontSize: 13),
                ),
              ),
              SizedBox(height: 12),

              // ── Build button ──────────────────────────
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: _buildRouteInfo,
                  icon: Icon(Icons.build, size: 16),
                  label: Text('Build RouteInformation'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),

              // ── Parsed components ─────────────────────
              _sectionCard(
                'Parsed URI Components',
                Column(
                  children: [
                    _parsedRow('path', previewUri.path, _kPrimary),
                    SizedBox(height: 4),
                    _parsedRow('query', previewUri.query, _kUriColor),
                    SizedBox(height: 4),
                    _parsedRow('fragment', previewUri.fragment, _kStepC),
                    SizedBox(height: 4),
                    _parsedRow(
                        'pathSegments',
                        previewUri.pathSegments.join(', '),
                        _kStepD),
                    SizedBox(height: 4),
                    if (previewUri.queryParameters.isNotEmpty) ...[
                      ...previewUri.queryParameters.entries.map((e) =>
                          Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: _parsedRow(
                                'qp[${e.key}]', e.value, _kUriColor),
                          )),
                    ],
                    SizedBox(height: 4),
                    _parsedRow('state', _stateCtrl.text, _kStateColor),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Quick examples ────────────────────────
              _sectionCard(
                'Quick Examples',
                Column(
                  children: [
                    _exampleBtn(
                        '/home', 'Simple path', Icons.home),
                    SizedBox(height: 4),
                    _exampleBtn(
                        '/users/123/profile',
                        'Nested path with ID',
                        Icons.person),
                    SizedBox(height: 4),
                    _exampleBtn(
                        '/search?q=flutter&lang=dart',
                        'With query params',
                        Icons.search),
                    SizedBox(height: 4),
                    _exampleBtn(
                        '/docs/api#authentication',
                        'With fragment',
                        Icons.description),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),

        // Right: build history
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: _kCardBg,
            border: Border(left: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: _kPrimary.withOpacity(0.06),
                child: Row(
                  children: [
                    Icon(Icons.history, size: 16, color: _kPrimary),
                    SizedBox(width: 6),
                    Text('Build History',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _kDarkText)),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('$_buildCount',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _builds.isEmpty
                    ? Center(
                        child: Text(
                          'Build RouteInformation\nobjects to see history',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: _kMuted, fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(6),
                        itemCount: _builds.length,
                        itemBuilder: (_, i) {
                          final b = _builds[i];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _kPrimary.withOpacity(0.03),
                                borderRadius:
                                    BorderRadius.circular(6),
                                border: Border.all(
                                    color:
                                        _kPrimary.withOpacity(0.1)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: _kPrimary
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text('#${b.id}',
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w700,
                                                fontSize: 9,
                                                color: _kPrimary)),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${b.time.hour.toString().padLeft(2, '0')}:'
                                        '${b.time.minute.toString().padLeft(2, '0')}:'
                                        '${b.time.second.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: _kMuted),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(b.fullUri,
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _kUriColor)),
                                  SizedBox(height: 2),
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 2,
                                    children: [
                                      _miniTag('segs:${b.segments.length}',
                                          _kPrimary),
                                      _miniTag('qp:${b.paramCount}',
                                          _kUriColor),
                                      if (b.fragment.isNotEmpty)
                                        _miniTag('#${b.fragment}',
                                            _kStepC),
                                      if (b.state.isNotEmpty)
                                        _miniTag('state', _kStateColor),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _parsedRow(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: color, width: 2)),
      ),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: _kMuted)),
          Spacer(),
          Flexible(
            child: Text(
              value.isEmpty ? '(empty)' : value,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: value.isEmpty ? _kMuted : color),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _exampleBtn(String uri, String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        final parsed = Uri.parse(uri);
        _pathCtrl.text = parsed.path;
        _fragCtrl.text = parsed.fragment;
        _queryParams.clear();
        parsed.queryParameters.forEach((k, v) {
          _queryParams.add(_QueryParam(k, v));
        });
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _kPrimary.withOpacity(0.04),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kPrimary.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: _kPrimary),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _kDarkText)),
                  Text(uri,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _kUriColor)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 12, color: _kMuted),
          ],
        ),
      ),
    );
  }

  Widget _miniTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(label,
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 8,
              color: color,
              fontWeight: FontWeight.w600)),
    );
  }
}

class _QueryParam {
  String key;
  String value;
  _QueryParam(this.key, this.value);
}

class _BuildEvent {
  final int id;
  final String fullUri;
  final String path;
  final String query;
  final String fragment;
  final int paramCount;
  final List<String> segments;
  final String state;
  final DateTime time;
  _BuildEvent({
    required this.id,
    required this.fullUri,
    required this.path,
    required this.query,
    required this.fragment,
    required this.paramCount,
    required this.segments,
    required this.state,
    required this.time,
  });
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Navigator 2.0 Flow
// ═══════════════════════════════════════════════════════════
class _Nav2FlowTab extends StatefulWidget {
  @override
  State<_Nav2FlowTab> createState() => _Nav2FlowTabState();
}

class _Nav2FlowTabState extends State<_Nav2FlowTab> {
  int _activeStep = -1;
  String _currentUrl = '/products/42?color=blue#details';

  final List<_FlowStepData> _steps = [
    _FlowStepData(
      title: 'Platform',
      subtitle: 'Browser / OS',
      detail: 'The platform provides the initial URL when the app starts, '
          'or when the user types a new URL in the browser bar, or when the '
          'OS delivers a deep link.',
      icon: Icons.public,
      color: Color(0xFF1565C0),
    ),
    _FlowStepData(
      title: 'RouteInformationProvider',
      subtitle: 'PlatformRouteInformationProvider',
      detail: 'Wraps the platform URL into a RouteInformation object. Also '
          'listens for programmatic navigation and pushes updated URLs back '
          'to the platform.',
      icon: Icons.input,
      color: Color(0xFF2E7D32),
    ),
    _FlowStepData(
      title: 'RouteInformation',
      subtitle: 'Data Transfer Object',
      detail: 'Carries the URI and state between the provider and the '
          'parser. This is the focus of this demo — it is the neutral '
          'handoff object.',
      icon: Icons.swap_horiz,
      color: Color(0xFF5E35B1),
    ),
    _FlowStepData(
      title: 'RouteInformationParser',
      subtitle: 'parseRouteInformation()',
      detail: 'Converts the RouteInformation into an app-specific '
          'configuration (e.g., a route tree, a path enum, or a typed '
          'route object).',
      icon: Icons.settings,
      color: Color(0xFFC62828),
    ),
    _FlowStepData(
      title: 'RouterDelegate',
      subtitle: 'setNewRoutePath()',
      detail: 'Receives the parsed configuration and builds the Navigator\'s '
          'page stack accordingly. Calls notifyListeners() to rebuild.',
      icon: Icons.account_tree,
      color: Color(0xFF6A1B9A),
    ),
    _FlowStepData(
      title: 'Widget Tree',
      subtitle: 'Navigator + Pages',
      detail: 'The final widget tree renders the correct pages based on the '
          'configuration provided by the RouterDelegate.',
      icon: Icons.widgets,
      color: Color(0xFFEF6C00),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── URL input ───────────────────────────────────
        _sectionCard(
          'Current URL',
          Row(
            children: [
              Icon(Icons.link, size: 16, color: _kUriColor),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: _kCodeBg,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: _kUriColor.withOpacity(0.3)),
                  ),
                  child: Text(_currentUrl,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _kUriColor)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),

        // ── Quick URL presets ───────────────────────────
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _urlPreset('/home', Icons.home),
            _urlPreset('/users/7/profile', Icons.person),
            _urlPreset('/search?q=widgets&page=2', Icons.search),
            _urlPreset('/docs/api#auth', Icons.menu_book),
            _urlPreset('/settings', Icons.settings),
          ],
        ),
        SizedBox(height: 14),

        // ── Flow pipeline ───────────────────────────────
        _sectionCard(
          'Navigator 2.0 Pipeline',
          Column(
            children: [
              ...List.generate(_steps.length, (i) {
                final step = _steps[i];
                final active = _activeStep == i;
                return Column(
                  children: [
                    if (i > 0)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 2,
                              height: 20,
                              color: step.color.withOpacity(0.3),
                            ),
                            if (i == 2) ...[
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _kPrimary.withOpacity(0.08),
                                  borderRadius:
                                      BorderRadius.circular(4),
                                ),
                                child: Text('RouteInformation here',
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                        color: _kPrimary)),
                              ),
                            ],
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap: () => setState(() =>
                          _activeStep = _activeStep == i ? -1 : i),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: active
                              ? step.color.withOpacity(0.08)
                              : _kCardBg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: active
                                ? step.color
                                : Colors.grey.shade300,
                            width: active ? 2 : 1,
                          ),
                          boxShadow: active
                              ? [
                                  BoxShadow(
                                    color:
                                        step.color.withOpacity(0.15),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  )
                                ]
                              : [],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: step.color.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(step.icon,
                                  color: step.color, size: 20),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 1),
                                        decoration: BoxDecoration(
                                          color: step.color
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text('${i + 1}',
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w700,
                                                fontSize: 9,
                                                color: step.color)),
                                      ),
                                      SizedBox(width: 6),
                                      Text(step.title,
                                          style: TextStyle(
                                              fontWeight:
                                                  FontWeight.w700,
                                              fontSize: 13,
                                              color: _kDarkText)),
                                    ],
                                  ),
                                  Text(step.subtitle,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: _kMuted)),
                                  if (active) ...[
                                    SizedBox(height: 6),
                                    Text(step.detail,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: _kDarkText,
                                            height: 1.4)),
                                    // Show what this step does with the URL
                                    SizedBox(height: 6),
                                    _stepUrlView(i),
                                  ],
                                ],
                              ),
                            ),
                            Icon(
                              active
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: _kMuted,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Bidirectional flow ──────────────────────────
        _sectionCard(
          'Bidirectional Flow',
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kStepB.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kStepB.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_downward,
                            size: 16, color: _kStepA),
                        SizedBox(width: 6),
                        Text('Platform → App (Inbound)',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: _kStepA)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'When the user navigates to a URL (browser, deep link), '
                      'RouteInformation flows from the platform into the app.',
                      style: TextStyle(
                          fontSize: 11, color: _kDarkText, height: 1.3),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kStepD.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kStepD.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_upward,
                            size: 16, color: _kStepD),
                        SizedBox(width: 6),
                        Text('App → Platform (Outbound)',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: _kStepD)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'When the app navigates (e.g., user taps a list item), '
                      'the RouterDelegate reports the new configuration. The '
                      'parser converts it back to RouteInformation and the '
                      'provider pushes the new URL to the platform.',
                      style: TextStyle(
                          fontSize: 11, color: _kDarkText, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _stepUrlView(int step) {
    final uri = Uri.parse(_currentUrl);
    switch (step) {
      case 0: // Platform
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'URL bar: $_currentUrl',
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: _kUriColor),
          ),
        );
      case 1: // Provider
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'RouteInformation(\n'
            '  uri: Uri.parse("$_currentUrl"),\n'
            '  state: null,\n'
            ')',
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: _kDarkText),
          ),
        );
      case 2: // RouteInformation itself
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kPrimary.withOpacity(0.06),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _miniProp('uri.path', uri.path, _kPrimary),
              _miniProp('uri.query', uri.query, _kUriColor),
              _miniProp('uri.fragment', uri.fragment, _kStepC),
            ],
          ),
        );
      case 3: // Parser
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'AppRouteConfig(\n'
            '  page: "${uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : 'home'}",\n'
            '  id: ${uri.pathSegments.length > 1 ? uri.pathSegments[1] : 'null'},\n'
            ')',
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: _kDarkText),
          ),
        );
      case 4: // Delegate
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'pages: [\n'
            '  MaterialPage(child: HomePage()),\n'
            '  MaterialPage(child: ${uri.pathSegments.isNotEmpty ? "${uri.pathSegments[0][0].toUpperCase()}${uri.pathSegments[0].substring(1)}Page" : "HomePage"}()),\n'
            ']',
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: _kDarkText),
          ),
        );
      case 5: // Widget tree
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Navigator(\n'
            '  pages: [HomePage, ${uri.pathSegments.isNotEmpty ? "${uri.pathSegments[0][0].toUpperCase()}${uri.pathSegments[0].substring(1)}Page" : "HomePage"}],\n'
            ')',
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: _kDarkText),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _urlPreset(String url, IconData icon) {
    return GestureDetector(
      onTap: () => setState(() {
        _currentUrl = url;
        _activeStep = -1;
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _kPrimary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kPrimary.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: _kPrimary),
            SizedBox(width: 4),
            Text(url,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: _kPrimary)),
          ],
        ),
      ),
    );
  }

  Widget _miniProp(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text('$label: ',
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: _kMuted)),
          Text(value.isEmpty ? '(empty)' : value,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: value.isEmpty ? _kMuted : color)),
        ],
      ),
    );
  }
}

class _FlowStepData {
  final String title;
  final String subtitle;
  final String detail;
  final IconData icon;
  final Color color;
  _FlowStepData({
    required this.title,
    required this.subtitle,
    required this.detail,
    required this.icon,
    required this.color,
  });
}

// ═══════════════════════════════════════════════════════════
//  Shared helpers
// ═══════════════════════════════════════════════════════════

Widget _sectionCard(String title, Widget child) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: _kPrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: _kDarkText)),
            ),
          ],
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kAccent.withOpacity(0.3)),
    ),
    child: Text(code,
        style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _kDarkText,
            height: 1.5)),
  );
}

Widget _propRow(String name, String type, String desc, Color color,
    IconData icon) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: color)),
                  SizedBox(width: 6),
                  Text(type,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _kMuted)),
                ],
              ),
              SizedBox(height: 3),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11, color: _kDarkText, height: 1.3)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _uriPart(String value, String label, Color color) {
  return Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
            color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 6),
      Text(label,
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: _kMuted)),
      SizedBox(width: 6),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(value,
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color)),
      ),
    ],
  );
}

Widget _roleStep(int step, String title, String desc, Color color,
    IconData icon) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.15)),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text('$step',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: color)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: _kDarkText)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11, color: _kMuted, height: 1.3)),
            ],
          ),
        ),
        Icon(icon, size: 18, color: color),
      ],
    ),
  );
}

TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
  return TableRow(
    decoration: isHeader
        ? BoxDecoration(color: _kPrimary.withOpacity(0.08))
        : null,
    children: cells.map((c) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Text(c,
            style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isHeader ? FontWeight.w700 : FontWeight.w400,
                color: isHeader ? _kPrimary : _kDarkText)),
      );
    }).toList(),
  );
}

Widget _bp(bool isGood, String text) {
  final color = isGood ? Color(0xFF2E7D32) : Color(0xFFC62828);
  final icon =
      isGood ? Icons.check_circle_outline : Icons.cancel_outlined;
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontSize: 12, color: _kDarkText, height: 1.4)),
        ),
      ],
    ),
  );
}
