// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformViewsRegistry from services
// Deep Demo: Visual exploration of the platform-views id allocator that
// bridges Flutter widgets to native (Android / iOS / web) views.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('PlatformViewsRegistry Deep Demo executing');

  // Palette: slate / cyan / amber.
  final Color slate900 = Color(0xFF0F172A);
  final Color slate800 = Color(0xFF1E293B);
  final Color slate700 = Color(0xFF334155);
  final Color slate300 = Color(0xFFCBD5E1);
  final Color slate100 = Color(0xFFF1F5F9);
  final Color cyan600 = Color(0xFF0891B2);
  final Color cyan500 = Color(0xFF06B6D4);
  final Color cyan300 = Color(0xFF67E8F9);
  final Color cyan100 = Color(0xFFCFFAFE);
  final Color amber700 = Color(0xFFB45309);
  final Color amber500 = Color(0xFFF59E0B);
  final Color amber300 = Color(0xFFFCD34D);
  final Color amber100 = Color(0xFFFEF3C7);
  final Color emerald = Color(0xFF10B981);
  final Color rose = Color(0xFFE11D48);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');
  final Widget titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, cyan600, amber700],
        stops: [0.0, 0.65, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.5),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: cyan500.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: slate100.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: slate100.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.layers_outlined,
                size: 44.0,
                color: amber300,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PlatformViewsRegistry',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: cyan100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: slate900.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cyan300.withValues(alpha: 0.4)),
          ),
          child: Text(
            'Singleton id-allocator that hands Flutter widgets unique '
            'integer handles for native (Android / iOS / web) views.',
            style: TextStyle(
              color: slate100,
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _chip('singleton', amber300, slate900),
            _chip('integer ids', cyan300, slate900),
            _chip('process unique', amber100, slate900),
            _chip('engine bridge', cyan100, slate900),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy ===');
  final Widget anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate100, cyan100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyan500.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyan500.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_outlined, color: cyan600, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: slate900,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Row(
          children: [
            // Global accessor
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: slate900,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: slate900.withValues(alpha: 0.4),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'top-level',
                      style: TextStyle(
                        color: amber300,
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'platformViewsRegistry',
                      style: TextStyle(
                        color: cyan300,
                        fontSize: 14.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'global getter',
                      style: TextStyle(color: slate300, fontSize: 11.0),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.arrow_forward, color: cyan600, size: 28.0),
            ),
            // Singleton class
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cyan500, cyan600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: cyan500.withValues(alpha: 0.5),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'class',
                      style: TextStyle(
                        color: amber100,
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'PlatformViewsRegistry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: slate900.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '_instance: PlatformViewsRegistry',
                        style: TextStyle(
                          color: amber300,
                          fontSize: 10.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.south, color: cyan600, size: 28.0),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: slate800,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: amber500, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: amber500.withValues(alpha: 0.25),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.numbers, color: amber300, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'method',
                      style: TextStyle(
                        color: amber100,
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'int getNextPlatformViewId()',
                      style: TextStyle(
                        color: cyan300,
                        fontSize: 14.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Each call returns a fresh, monotonic, '
                      'process-unique integer.',
                      style: TextStyle(color: slate300, fontSize: 11.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: ID-allocation cards
  // ============================================================
  print('=== Section 3: ID allocation ===');

  // Real calls to the registry.
  final List<int> allocatedIds = [
    platformViewsRegistry.getNextPlatformViewId(),
    platformViewsRegistry.getNextPlatformViewId(),
    platformViewsRegistry.getNextPlatformViewId(),
    platformViewsRegistry.getNextPlatformViewId(),
    platformViewsRegistry.getNextPlatformViewId(),
    platformViewsRegistry.getNextPlatformViewId(),
  ];
  print('Allocated ids: $allocatedIds');

  bool strictlyMonotonic = true;
  for (int i = 1; i < allocatedIds.length; i++) {
    if (allocatedIds[i] <= allocatedIds[i - 1]) {
      strictlyMonotonic = false;
    }
  }
  print('Strictly monotonic increase: $strictlyMonotonic');

  final List<Widget> idCards = <Widget>[];
  for (int i = 0; i < allocatedIds.length; i++) {
    idCards.add(_idCard(i, allocatedIds[i], slate900, cyan500, amber300));
  }

  final Widget idCodeBox = Container(
    margin: EdgeInsets.only(top: 14.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slate900,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cyan500.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: amber300, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'allocation transcript',
              style: TextStyle(
                color: amber300,
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        for (int i = 0; i < allocatedIds.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              'final id$i = platformViewsRegistry.getNextPlatformViewId(); '
              '// => ${allocatedIds[i]}',
              style: TextStyle(
                color: cyan300,
                fontSize: 12.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: (strictlyMonotonic ? emerald : rose).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: strictlyMonotonic ? emerald : rose,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(
                strictlyMonotonic ? Icons.check_circle : Icons.error,
                color: strictlyMonotonic ? emerald : rose,
                size: 16.0,
              ),
              SizedBox(width: 8.0),
              Text(
                strictlyMonotonic
                    ? 'strictly monotonic increase verified'
                    : 'NON-monotonic ids — would violate the contract',
                style: TextStyle(
                  color: strictlyMonotonic ? emerald : rose,
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Cross-platform widgets that consume the id
  // ============================================================
  print('=== Section 4: Cross-platform widgets ===');
  final List<Map<String, Object>> widgetSpecs = [
    {
      'name': 'AndroidView',
      'platform': 'Android',
      'icon': Icons.android,
      'tint': emerald,
      'sig':
          'AndroidView({\n'
          '  required String viewType,\n'
          '  PlatformViewCreatedCallback? onPlatformViewCreated,\n'
          '  Map<String, dynamic>? creationParams,\n'
          '  MessageCodec<dynamic>? creationParamsCodec,\n'
          '  ...\n'
          '})',
    },
    {
      'name': 'UiKitView',
      'platform': 'iOS / macOS',
      'icon': Icons.phone_iphone,
      'tint': cyan500,
      'sig':
          'UiKitView({\n'
          '  required String viewType,\n'
          '  PlatformViewCreatedCallback? onPlatformViewCreated,\n'
          '  Map<String, dynamic>? creationParams,\n'
          '  MessageCodec<dynamic>? creationParamsCodec,\n'
          '  ...\n'
          '})',
    },
    {
      'name': 'HtmlElementView',
      'platform': 'Web',
      'icon': Icons.public,
      'tint': amber500,
      'sig':
          'HtmlElementView({\n'
          '  required String viewType,\n'
          '  PlatformViewCreatedCallback? onPlatformViewCreated,\n'
          '  Map<String, dynamic>? creationParams,\n'
          '  ...\n'
          '})',
    },
    {
      'name': 'PlatformViewLink',
      'platform': 'Custom controller',
      'icon': Icons.link,
      'tint': rose,
      'sig':
          'PlatformViewLink({\n'
          '  required String viewType,\n'
          '  required PlatformViewSurfaceFactory surfaceFactory,\n'
          '  required CreatePlatformViewCallback onCreatePlatformView,\n'
          '  ...\n'
          '})',
    },
  ];
  final List<Widget> widgetCards = <Widget>[];
  for (final spec in widgetSpecs) {
    widgetCards.add(
      _widgetSpecCard(
        spec['name'] as String,
        spec['platform'] as String,
        spec['icon'] as IconData,
        spec['tint'] as Color,
        spec['sig'] as String,
        slate900,
        slate300,
        amber300,
        cyan300,
      ),
    );
  }

  // ============================================================
  // SECTION 5: Embedding flow diagram
  // ============================================================
  print('=== Section 5: Embedding flow ===');
  final Widget embeddingFlow = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate800, slate900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: cyan500.withValues(alpha: 0.25),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.alt_route, color: amber300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Embedding flow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        _flowLayer(
          'Dart layer',
          'AndroidView(viewType: "map", onPlatformViewCreated: ...)',
          Icons.flutter_dash,
          cyan500,
          slate900,
          amber300,
        ),
        _flowConnector(amber300),
        _flowLayer(
          'Flutter engine',
          'allocates id via platformViewsRegistry, marshals over MethodChannel',
          Icons.settings_input_component,
          amber500,
          slate900,
          cyan300,
        ),
        _flowConnector(amber300),
        _flowLayer(
          'Native side',
          'Android: PlatformViewFactory   |   iOS: FlutterPlatformViewFactory',
          Icons.devices_other,
          emerald,
          slate900,
          amber100,
        ),
        _flowConnector(amber300),
        _flowLayer(
          'Composited',
          'Native pixels composited back into the Flutter scene',
          Icons.layers,
          rose,
          slate900,
          amber100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Hybrid composition vs virtual displays
  // ============================================================
  print('=== Section 6: Hybrid vs virtual displays ===');
  final List<List<String>> hybridRows = [
    ['Mode', 'Hybrid composition', 'Virtual display'],
    [
      'Default in',
      'AndroidView (newer)',
      'AndroidView (legacy)',
    ],
    [
      'Rendering',
      'Native view in same window',
      'Off-screen virtual display',
    ],
    [
      'Input',
      'Direct, native gestures',
      'Synthesized, may drop events',
    ],
    [
      'Performance',
      'Higher CPU overhead',
      'Lower CPU, GPU texture',
    ],
    [
      'Accessibility',
      'Native a11y tree merged',
      'Limited a11y bridging',
    ],
    [
      'Text input',
      'Native IME works',
      'Often broken / lossy',
    ],
  ];
  final Widget hybridTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amber100, slate100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amber500, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amber500.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.android, color: emerald, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Hybrid composition vs Virtual displays (Android only)',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: slate900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (int i = 0; i < hybridRows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: i == 0
                  ? slate900
                  : (i.isEven
                        ? slate100.withValues(alpha: 0.7)
                        : Colors.white.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(6.0),
            ),
            margin: EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    hybridRows[i][0],
                    style: TextStyle(
                      color: i == 0 ? amber300 : slate900,
                      fontSize: 12.0,
                      fontWeight: i == 0
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    hybridRows[i][1],
                    style: TextStyle(
                      color: i == 0 ? cyan300 : slate800,
                      fontSize: 12.0,
                      fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    hybridRows[i][2],
                    style: TextStyle(
                      color: i == 0 ? cyan300 : slate800,
                      fontSize: 12.0,
                      fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Real-world mock embedding
  // ============================================================
  print('=== Section 7: Real-world mock ===');
  final Widget realWorldMock = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cyan100, amber100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyan500.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyan500.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.preview, color: cyan600, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'A Flutter Column embedding three native views',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: slate900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _embeddedMockCard(
          'GoogleMap (AndroidView / UiKitView)',
          Icons.map,
          emerald,
          'Native Maps SDK pixel buffer composited under Flutter UI.',
          allocatedIds[0],
          slate900,
          slate300,
          amber300,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: slate300),
          ),
          child: Row(
            children: [
              Icon(Icons.text_fields, color: slate700, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'Flutter Text("Hello above the native ad")',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: slate800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _embeddedMockCard(
          'BannerAd (AndroidView / UiKitView)',
          Icons.campaign,
          amber500,
          'Native ad SDK view — native click handling required.',
          allocatedIds[1],
          slate900,
          slate300,
          amber300,
        ),
        SizedBox(height: 12.0),
        _embeddedMockCard(
          'WebView (AndroidView / UiKitView / HtmlElementView)',
          Icons.web,
          cyan600,
          'Embedded Chromium / WKWebView / <iframe> on web.',
          allocatedIds[2],
          slate900,
          slate300,
          amber300,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Lifecycle
  // ============================================================
  print('=== Section 8: Lifecycle ===');
  final List<Map<String, Object>> lifecycleSteps = [
    {
      'n': '1',
      'title': 'Allocate id',
      'body': 'Widget calls platformViewsRegistry.getNextPlatformViewId() '
          'to obtain a fresh integer handle.',
      'icon': Icons.confirmation_number_outlined,
      'tint': cyan500,
    },
    {
      'n': '2',
      'title': 'Create',
      'body': 'Engine sends the id + viewType + creationParams to the '
          'native side, which builds the native view. '
          'onPlatformViewCreated(id) fires.',
      'icon': Icons.add_circle_outline,
      'tint': emerald,
    },
    {
      'n': '3',
      'title': 'Update',
      'body': 'Subsequent layout / param updates target the same id; '
          'controllers (e.g. WebViewController) keep the binding alive.',
      'icon': Icons.sync,
      'tint': amber500,
    },
    {
      'n': '4',
      'title': 'Dispose',
      'body': 'Widget unmounts -> engine instructs native side to dispose '
          'the view for that id. The id is permanently retired (never reused).',
      'icon': Icons.delete_outline,
      'tint': rose,
    },
  ];
  final List<Widget> lifecycleCards = <Widget>[];
  for (final step in lifecycleSteps) {
    lifecycleCards.add(
      _lifecycleCard(
        step['n'] as String,
        step['title'] as String,
        step['body'] as String,
        step['icon'] as IconData,
        step['tint'] as Color,
        slate900,
        slate100,
      ),
    );
  }

  // ============================================================
  // SECTION 9: Threading and messaging
  // ============================================================
  print('=== Section 9: Threading & messaging ===');
  final Widget threadingDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, slate800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: cyan500.withValues(alpha: 0.3),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_calls, color: amber300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'How the id flows over the engine boundary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _threadColumn(
                'UI thread',
                [
                  'platformViewsRegistry',
                  '.getNextPlatformViewId()',
                  ' -> int id',
                  'AndroidView(viewType, id)',
                  'BinaryMessenger.send(',
                  '  "flutter/platform_views",',
                  '  encode(create, id))',
                ],
                cyan300,
                slate900,
                amber300,
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              children: [
                SizedBox(height: 30.0),
                Icon(Icons.east, color: amber300, size: 28.0),
                SizedBox(height: 16.0),
                Icon(Icons.east, color: amber300, size: 28.0),
              ],
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _threadColumn(
                'Platform thread',
                [
                  'BinaryMessenger',
                  'PlatformViewsHandler',
                  'PlatformViewFactory',
                  '.create(context, id, args)',
                  '-> NativeView',
                  'register(id -> view)',
                  'reply(success)',
                ],
                amber300,
                slate900,
                cyan300,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: cyan500.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: cyan500.withValues(alpha: 0.5)),
          ),
          child: Text(
            'The id is the *only* thing both sides share — '
            'losing track of it leaks the native view forever.',
            style: TextStyle(
              color: cyan100,
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footguns ===');
  final List<Map<String, Object>> footguns = [
    {
      'title': 'Ids leak across hot reload',
      'icon': Icons.local_fire_department,
      'tint': rose,
      'body': 'Hot reload keeps the same Dart isolate, so the registry '
          'counter keeps climbing. Native views from before reload may '
          'still be alive — orphaned by ids your widgets no longer '
          'remember.',
    },
    {
      'title': 'Never recycle ids manually',
      'icon': Icons.recycling,
      'tint': amber500,
      'body': 'You must NOT pass an old id back into a new platform view. '
          'The engine assumes ids are unique forever; reusing one '
          'corrupts the platform-side registry and may crash the engine.',
    },
    {
      'title': 'Null / missing id',
      'icon': Icons.help_outline,
      'tint': cyan600,
      'body': 'Building an AndroidView/UiKitView yourself without going '
          'through the registry yields no id at all — the platform '
          'factory cannot match a creation request to a widget.',
    },
    {
      'title': 'Lost listeners',
      'icon': Icons.headset_off,
      'tint': slate700,
      'body': 'Forgetting to wire onPlatformViewCreated leaves the '
          'controller (e.g. MapController) unbound — the native view '
          'exists but cannot be driven from Dart.',
    },
    {
      'title': 'Web vs mobile semantics',
      'icon': Icons.public_off,
      'tint': emerald,
      'body': 'On web the id is matched to a registered HtmlElement via '
          'platformViewRegistry.registerViewFactory; on mobile, the id is '
          'matched to a PlatformViewFactory. The two sides are NOT '
          'interchangeable.',
    },
  ];
  final List<Widget> footgunCards = <Widget>[];
  for (final fg in footguns) {
    footgunCards.add(
      _footgunCard(
        fg['title'] as String,
        fg['icon'] as IconData,
        fg['tint'] as Color,
        fg['body'] as String,
        slate900,
        slate100,
      ),
    );
  }

  // ============================================================
  // SECTION 11: Recap
  // ============================================================
  print('=== Section 11: Recap ===');
  final Widget recapCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amber700, cyan600, slate900],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.5),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: amber500.withValues(alpha: 0.25),
          blurRadius: 28.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: amber300, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recapBullet(
          'platformViewsRegistry is the global handle to the singleton '
          'PlatformViewsRegistry.',
          cyan100,
          amber300,
        ),
        _recapBullet(
          'getNextPlatformViewId() returns a process-unique, monotonically '
          'increasing int.',
          cyan100,
          amber300,
        ),
        _recapBullet(
          'AndroidView, UiKitView, HtmlElementView and PlatformViewLink all '
          'consume that id internally.',
          cyan100,
          amber300,
        ),
        _recapBullet(
          'The id is the bridge that connects Dart-side widget lifecycle to '
          'native PlatformViewFactory instances.',
          cyan100,
          amber300,
        ),
        _recapBullet(
          'Never recycle, never invent, never lose the id — once minted it '
          'belongs to one native view for the rest of the process.',
          cyan100,
          amber300,
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: slate900.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: amber300.withValues(alpha: 0.6)),
          ),
          child: Text(
            'Allocated ${allocatedIds.length} ids in this demo: '
            '${allocatedIds.join(", ")}.\n'
            'Strictly monotonic: $strictlyMonotonic.',
            style: TextStyle(
              color: amber100,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );

  print('PlatformViewsRegistry Deep Demo completed successfully');

  // ============================================================
  // Final scaffold
  // ============================================================
  return Scaffold(
    backgroundColor: slate100,
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 16.0),
          _sectionHeader('1. Anatomy', Icons.account_tree, slate900, amber500),
          SizedBox(height: 8.0),
          anatomyDiagram,
          SizedBox(height: 28.0),
          _sectionHeader(
            '2. Id allocation in action',
            Icons.numbers,
            slate900,
            amber500,
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 12.0,
              runSpacing: 12.0,
              children: idCards,
            ),
          ),
          SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: idCodeBox,
          ),
          SizedBox(height: 28.0),
          _sectionHeader(
            '3. Widgets that consume the id',
            Icons.widgets,
            slate900,
            amber500,
          ),
          SizedBox(height: 8.0),
          ...widgetCards,
          SizedBox(height: 28.0),
          _sectionHeader(
            '4. Embedding flow',
            Icons.alt_route,
            slate900,
            amber500,
          ),
          SizedBox(height: 8.0),
          embeddingFlow,
          SizedBox(height: 28.0),
          _sectionHeader(
            '5. Hybrid composition vs virtual displays',
            Icons.android,
            slate900,
            amber500,
          ),
          SizedBox(height: 8.0),
          hybridTable,
          SizedBox(height: 28.0),
          _sectionHeader(
            '6. Real-world mock',
            Icons.preview,
            slate900,
            amber500,
          ),
          SizedBox(height: 8.0),
          realWorldMock,
          SizedBox(height: 28.0),
          _sectionHeader(
            '7. Lifecycle',
            Icons.timeline,
            slate900,
            amber500,
          ),
          SizedBox(height: 8.0),
          ...lifecycleCards,
          SizedBox(height: 28.0),
          _sectionHeader(
            '8. Threading & messaging',
            Icons.swap_calls,
            slate900,
            amber500,
          ),
          SizedBox(height: 8.0),
          threadingDiagram,
          SizedBox(height: 28.0),
          _sectionHeader(
            '9. Footguns',
            Icons.warning_amber,
            slate900,
            amber500,
          ),
          SizedBox(height: 8.0),
          ...footgunCards,
          SizedBox(height: 28.0),
          _sectionHeader(
            '10. Recap',
            Icons.bookmark,
            slate900,
            amber500,
          ),
          recapCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

Widget _chip(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: fg,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _sectionHeader(String text, IconData icon, Color fg, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent, width: 1.0),
          ),
          child: Icon(icon, size: 18.0, color: accent),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: fg,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Container(
          height: 2.0,
          width: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withValues(alpha: 0.0)],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _idCard(int index, int id, Color slateDark, Color cyan, Color amber) {
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDark, cyan],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: slateDark.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
        BoxShadow(
          color: cyan.withValues(alpha: 0.3),
          blurRadius: 18.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tag, color: amber, size: 16.0),
            SizedBox(width: 4.0),
            Text(
              'call #${index + 1}',
              style: TextStyle(
                color: amber,
                fontSize: 10.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: amber.withValues(alpha: 0.4)),
          ),
          child: Text(
            '$id',
            style: TextStyle(
              fontFamily: 'monospace',
              color: amber,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'getNextPlatformViewId()',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 9.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _widgetSpecCard(
  String name,
  String platform,
  IconData icon,
  Color tint,
  String signature,
  Color slateDark,
  Color slateLight,
  Color amber,
  Color cyan,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [tint, tint.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, color: Colors.white, size: 22.0),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      platform,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'consumes id',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Signature body
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: slateDark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14.0),
              bottomRight: Radius.circular(14.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.code, color: amber, size: 14.0),
                  SizedBox(width: 6.0),
                  Text(
                    'constructor signature',
                    style: TextStyle(
                      color: amber,
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                signature,
                style: TextStyle(
                  color: cyan,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: tint.withValues(alpha: 0.5)),
                ),
                child: Text(
                  '// internally calls platformViewsRegistry'
                  '.getNextPlatformViewId()',
                  style: TextStyle(
                    color: slateLight,
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowLayer(
  String label,
  String detail,
  IconData icon,
  Color tint,
  Color slateDark,
  Color amber,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tint.withValues(alpha: 0.85), tint.withValues(alpha: 0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.4),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: slateDark,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: amber, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                detail,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.95),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowConnector(Color tint) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 2.0, height: 14.0, color: tint),
        SizedBox(width: 4.0),
        Icon(Icons.south, color: tint, size: 22.0),
        SizedBox(width: 4.0),
        Container(width: 2.0, height: 14.0, color: tint),
      ],
    ),
  );
}

Widget _embeddedMockCard(
  String label,
  IconData icon,
  Color tint,
  String detail,
  int id,
  Color slateDark,
  Color slateLight,
  Color amber,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: slateDark,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tint, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: tint.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: tint),
              ),
              child: Icon(icon, color: tint, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: amber.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: amber),
              ),
              child: Text(
                'id=$id',
                style: TextStyle(
                  color: amber,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                tint.withValues(alpha: 0.3),
                tint.withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: tint.withValues(alpha: 0.6),
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: Text(
              '[ native view placeholder — requires platform plugin ]',
              style: TextStyle(
                color: slateLight,
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          detail,
          style: TextStyle(color: slateLight, fontSize: 11.5),
        ),
      ],
    ),
  );
}

Widget _lifecycleCard(
  String number,
  String title,
  String body,
  IconData icon,
  Color tint,
  Color slateDark,
  Color slateLight,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: slateLight,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tint, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [tint, tint.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: tint.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: tint, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: slateDark,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                body,
                style: TextStyle(
                  color: slateDark.withValues(alpha: 0.85),
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _threadColumn(
  String label,
  List<String> lines,
  Color textColor,
  Color slateDark,
  Color amber,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: slateDark,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: textColor.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: textColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: amber,
              fontSize: 10.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        for (final line in lines)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              line,
              style: TextStyle(
                color: textColor,
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _footgunCard(
  String title,
  IconData icon,
  Color tint,
  String body,
  Color slateDark,
  Color slateLight,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          tint.withValues(alpha: 0.18),
          tint.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tint.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.2),
          blurRadius: 8.0,
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
            color: tint,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: tint.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: slateDark,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                body,
                style: TextStyle(
                  color: slateDark.withValues(alpha: 0.85),
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recapBullet(String text, Color textColor, Color bulletColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Icon(Icons.check_circle, color: bulletColor, size: 16.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
