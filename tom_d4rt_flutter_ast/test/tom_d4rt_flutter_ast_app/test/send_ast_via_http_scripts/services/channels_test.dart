// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Platform Channels Cartography & Codec Atlas Workshop
// A hand-authored visual journey through Flutter's services channel surface:
// MethodChannel, EventChannel, BasicMessageChannel, the codec family,
// SystemChannels constants, and real-world Dart<->Platform flow narratives.
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// =============================================================================
// PALETTE HELPERS
// Each top-level section gets its own coordinated palette. Keeping the palette
// constants here makes the section builders read like recipes.
// =============================================================================

const Color _kInk = Color(0xFF101820);
const Color _kPaper = Color(0xFFF7F4EE);
const Color _kMuted = Color(0xFF6B7280);
const Color _kCardShadow = Color(0x14000000);

// Section palettes (background, border, accent, deep)
const List<Color> _kPalMethod = [
  Color(0xFFE3F2FD),
  Color(0xFF64B5F6),
  Color(0xFF1976D2),
  Color(0xFF0D47A1),
];
const List<Color> _kPalEvent = [
  Color(0xFFFFF3E0),
  Color(0xFFFFB74D),
  Color(0xFFF57C00),
  Color(0xFFE65100),
];
const List<Color> _kPalBasic = [
  Color(0xFFE8F5E9),
  Color(0xFF81C784),
  Color(0xFF388E3C),
  Color(0xFF1B5E20),
];
const List<Color> _kPalCodec = [
  Color(0xFFF3E5F5),
  Color(0xFFCE93D8),
  Color(0xFF8E24AA),
  Color(0xFF4A148C),
];
const List<Color> _kPalBytes = [
  Color(0xFFFCE4EC),
  Color(0xFFF48FB1),
  Color(0xFFD81B60),
  Color(0xFF880E4F),
];
const List<Color> _kPalSystem = [
  Color(0xFFE0F7FA),
  Color(0xFF4DD0E1),
  Color(0xFF00838F),
  Color(0xFF006064),
];
const List<Color> _kPalFlows = [
  Color(0xFFEDE7F6),
  Color(0xFF9575CD),
  Color(0xFF5E35B1),
  Color(0xFF311B92),
];
const List<Color> _kPalRecipe = [
  Color(0xFFFFF8E1),
  Color(0xFFFFD54F),
  Color(0xFFF9A825),
  Color(0xFFF57F17),
];
const List<Color> _kPalGlossary = [
  Color(0xFFECEFF1),
  Color(0xFF90A4AE),
  Color(0xFF455A64),
  Color(0xFF263238),
];

// =============================================================================
// TOP-LEVEL WIDGET HELPERS (no Stateful/Stateless subclassing allowed)
// =============================================================================

Widget _sectionShell({
  required String number,
  required String title,
  required String subtitle,
  required List<Color> palette,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: palette[0],
      border: Border.all(color: palette[1], width: 1.2),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: palette[2],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: palette[3],
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12.5, color: _kMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...children,
      ],
    ),
  );
}

Widget _chip(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11.0, color: fg, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _kvRow(String key, String value, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: accent,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: Color(0xFFE0F2F1),
        height: 1.45,
      ),
    ),
  );
}

Widget _diagramBox(String label, Color bg, Color border, {double width = 130}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: bg,
      border: Border.all(color: border, width: 1.4),
      borderRadius: BorderRadius.circular(8.0),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _arrow(String label, Color color, {bool reverse = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          reverse ? '<--' : '-->',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          label,
          style: TextStyle(fontSize: 10.0, color: color),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String title,
  required String description,
  required List<String> steps,
  required List<Color> palette,
}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: palette[1], width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, size: 16.0, color: palette[2]),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: palette[3],
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(description, style: TextStyle(fontSize: 12.0, color: _kInk)),
        SizedBox(height: 8.0),
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${i + 1}. ',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: palette[2],
                  ),
                ),
                Expanded(
                  child: Text(
                    steps[i],
                    style: TextStyle(fontSize: 12.0, color: _kInk),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _tableHeader(List<String> labels, Color bg, Color fg) {
  return Container(
    color: bg,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Row(
      children: [
        for (final l in labels)
          Expanded(
            child: Text(
              l,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: fg,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, {Color? bg}) {
  return Container(
    color: bg ?? Color(0xFFFFFFFF),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
    child: Row(
      children: [
        for (final c in cells)
          Expanded(
            child: Text(
              c,
              style: TextStyle(fontSize: 11.5, fontFamily: 'monospace'),
            ),
          ),
      ],
    ),
  );
}

Widget _byteCell(String hex, Color bg, Color fg) {
  return Container(
    width: 36.0,
    height: 30.0,
    margin: EdgeInsets.all(2.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: fg.withOpacity(0.4), width: 0.8),
    ),
    child: Text(
      hex,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: fg,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _byteRow(List<String> hexes, Color bg, Color fg, String comment) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(children: [for (final h in hexes) _byteCell(h, bg, fg)]),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            comment,
            style: TextStyle(fontSize: 11.5, color: _kMuted),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION 1: METHODCHANNEL ANATOMY
  // ===========================================================================
  final mcDefault = MethodChannel('com.example/cartography.default');
  final mcJson = MethodChannel(
    'com.example/cartography.json',
    JSONMethodCodec(),
  );
  final mcStandard = MethodChannel(
    'com.example/cartography.standard',
    StandardMethodCodec(),
  );

  final mcCalls = <MethodCall>[
    MethodCall('startEngine'),
    MethodCall('getBattery'),
    MethodCall('open', {'path': '/etc/hosts', 'mode': 'r'}),
    MethodCall('share', ['hello', 'world', 42, true]),
    MethodCall('vibrate', 250),
    MethodCall('platformVersion', null),
  ];

  // ===========================================================================
  // SECTION 2: EVENTCHANNEL ANATOMY
  // ===========================================================================
  final ecBattery = EventChannel('com.example/battery.level');
  final ecLocation = EventChannel('com.example/location.stream');
  final ecAccel = EventChannel(
    'com.example/sensors.accel',
    JSONMethodCodec(),
  );
  final ecConnectivity = EventChannel('com.example/connectivity');

  final eventSnapshots = <Map<String, String>>[
    {
      'channel': ecBattery.name,
      'codec': ecBattery.codec.runtimeType.toString(),
      'tick': 'level:87%',
    },
    {
      'channel': ecLocation.name,
      'codec': ecLocation.codec.runtimeType.toString(),
      'tick': 'lat:48.137 lng:11.575',
    },
    {
      'channel': ecAccel.name,
      'codec': ecAccel.codec.runtimeType.toString(),
      'tick': 'x:0.01 y:-9.79 z:0.42',
    },
    {
      'channel': ecConnectivity.name,
      'codec': ecConnectivity.codec.runtimeType.toString(),
      'tick': 'state:wifi',
    },
  ];

  // ===========================================================================
  // SECTION 3: BASICMESSAGECHANNEL ANATOMY
  // ===========================================================================
  final bmcString = BasicMessageChannel<String>(
    'com.example/messages.string',
    StringCodec(),
  );
  final bmcJson = BasicMessageChannel<dynamic>(
    'com.example/messages.json',
    JSONMessageCodec(),
  );
  final bmcBinary = BasicMessageChannel<ByteData>(
    'com.example/messages.binary',
    BinaryCodec(),
  );
  final bmcStandard = BasicMessageChannel<Object?>(
    'com.example/messages.standard',
    StandardMessageCodec(),
  );

  // ===========================================================================
  // SECTION 4: CODEC FAMILY COMPARISON
  // ===========================================================================
  final codecRows = <List<String>>[
    [
      'StandardMessageCodec',
      'binary',
      'maps/lists/nums/Uint8List',
      'default for Method/BasicMessage',
    ],
    [
      'JSONMessageCodec',
      'UTF-8 text',
      'JSON-serializable',
      'web-friendly, debuggable',
    ],
    ['StringCodec', 'UTF-8 text', 'String', 'tiny and explicit'],
    ['BinaryCodec', 'identity', 'ByteData (raw)', 'no envelope at all'],
    [
      'StandardMethodCodec',
      'binary',
      'MethodCall envelope',
      'wraps StandardMessageCodec',
    ],
    [
      'JSONMethodCodec',
      'UTF-8 text',
      'MethodCall envelope',
      'wraps JSONMessageCodec',
    ],
  ];

  // ===========================================================================
  // SECTION 5: SYSTEMCHANNELS CATALOG
  // ===========================================================================
  final systemChannelCards = <Map<String, String>>[
    {
      'name': SystemChannels.platform.name,
      'codec': SystemChannels.platform.codec.runtimeType.toString(),
      'role': 'Clipboard, haptic feedback, system chrome, sound',
    },
    {
      'name': SystemChannels.navigation.name,
      'codec': SystemChannels.navigation.codec.runtimeType.toString(),
      'role': 'Route push/pop notifications to engine',
    },
    {
      'name': SystemChannels.lifecycle.name,
      'codec': SystemChannels.lifecycle.codec.runtimeType.toString(),
      'role': 'App lifecycle: resumed, inactive, paused, detached',
    },
    {
      'name': SystemChannels.textInput.name,
      'codec': SystemChannels.textInput.codec.runtimeType.toString(),
      'role': 'IME control: show, hide, setEditingState',
    },
    {
      'name': SystemChannels.accessibility.name,
      'codec': SystemChannels.accessibility.codec.runtimeType.toString(),
      'role': 'TalkBack/VoiceOver announcements and focus',
    },
    {
      'name': SystemChannels.keyEvent.name,
      'codec': SystemChannels.keyEvent.codec.runtimeType.toString(),
      'role': 'Hardware key events from the platform',
    },
    {
      'name': SystemChannels.system.name,
      'codec': SystemChannels.system.codec.runtimeType.toString(),
      'role': 'Generic system messages, memory pressure',
    },
  ];

  // ===========================================================================
  // Final composition
  // ===========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Platform Channels Cartography',
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHero(),
            _buildOverview(),
            _buildMethodChannelSection(mcDefault, mcJson, mcStandard, mcCalls),
            _buildEventChannelSection(eventSnapshots),
            _buildBasicMessageSection(
              bmcString,
              bmcJson,
              bmcBinary,
              bmcStandard,
            ),
            _buildCodecComparisonSection(codecRows),
            _buildByteStreamSection(),
            _buildSystemChannelsSection(systemChannelCards),
            _buildFlowsSection(),
            _buildRecipeSection(),
            _buildGlossarySection(),
            _buildEpilogue(),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// HERO
// =============================================================================

Widget _buildHero() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF1976D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: _kCardShadow,
          blurRadius: 18.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _chip('Deep Demo', Color(0x33FFFFFF), Color(0xFFFFFFFF)),
            SizedBox(width: 8.0),
            _chip('services', Color(0x33FFFFFF), Color(0xFFFFFFFF)),
            SizedBox(width: 8.0),
            _chip('codecs', Color(0x33FFFFFF), Color(0xFFFFFFFF)),
          ],
        ),
        SizedBox(height: 18.0),
        Text(
          'Platform Channels Cartography',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A visual atlas of Flutter\'s services channels, codecs, and SystemChannels constants.',
          style: TextStyle(fontSize: 15.5, color: Color(0xFFBBDEFB)),
        ),
        SizedBox(height: 18.0),
        Row(
          children: [
            Icon(
              Icons.travel_explore,
              color: Color(0xFFFFFFFF),
              size: 18.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'MethodChannel  -  EventChannel  -  BasicMessageChannel',
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xFFE3F2FD),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            Icon(Icons.map, color: Color(0xFFFFFFFF), size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Standard / JSON / String / Binary codecs',
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xFFE3F2FD),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// OVERVIEW
// =============================================================================

Widget _buildOverview() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFF1976D2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.public,
                color: Color(0xFFFFFFFF),
                size: 18.0,
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              'Why channels?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _kInk,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Flutter renders pixels, but the host OS owns hardware, credentials, '
          'sensors, share sheets, and a thousand other things. Platform channels '
          'are the bridge: a typed, encoded message bus between Dart and the '
          'native engine. This atlas tours the three channel types, the six '
          'codecs that bend bytes into meaning, and the SystemChannels constants '
          'that already speak to the engine on your behalf.',
          style: TextStyle(fontSize: 13.5, height: 1.55, color: _kInk),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _overviewPillar(
                'MethodChannel',
                'Async request/response',
                Icons.swap_horiz,
                Color(0xFF1976D2),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _overviewPillar(
                'EventChannel',
                'Stream of values',
                Icons.podcasts,
                Color(0xFFF57C00),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _overviewPillar(
                'BasicMessageChannel',
                'Fire-and-forget pings',
                Icons.send,
                Color(0xFF388E3C),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _overviewPillar(String title, String tag, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withOpacity(0.35), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(tag, style: TextStyle(fontSize: 11.5, color: _kMuted)),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1: METHODCHANNEL
// =============================================================================

Widget _buildMethodChannelSection(
  MethodChannel def,
  MethodChannel json,
  MethodChannel standard,
  List<MethodCall> calls,
) {
  return _sectionShell(
    number: '1',
    title: 'MethodChannel Anatomy',
    subtitle: 'A typed RPC pipe with a name, a codec, and a pair of handlers.',
    palette: _kPalMethod,
    children: [
      _codeBlock(
        '// Construct (illustration only - no invokeMethod in D4rt)\n'
        'final mc = MethodChannel("com.example/cartography.default");\n'
        'final mcJ = MethodChannel(\n'
        '  "com.example/cartography.json",\n'
        '  JSONMethodCodec(),\n'
        ');',
      ),
      SizedBox(height: 12.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Channel instances',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _kPalMethod[3],
              ),
            ),
            SizedBox(height: 6.0),
            _kvRow('default.name', def.name, _kPalMethod[3]),
            _kvRow('default.codec', def.codec.runtimeType.toString(),
                _kPalMethod[3]),
            _kvRow('json.name', json.name, _kPalMethod[3]),
            _kvRow('json.codec', json.codec.runtimeType.toString(),
                _kPalMethod[3]),
            _kvRow('standard.name', standard.name, _kPalMethod[3]),
            _kvRow('standard.codec',
                standard.codec.runtimeType.toString(), _kPalMethod[3]),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      Text(
        'MethodCall envelopes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalMethod[3],
          fontSize: 14.0,
        ),
      ),
      SizedBox(height: 8.0),
      for (final c in calls)
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 6.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(color: _kPalMethod[1], width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: _kPalMethod[2],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  c.method,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'arguments = ${c.arguments}',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11.5),
                ),
              ),
            ],
          ),
        ),
      SizedBox(height: 16.0),
      Text(
        'Round-trip diagram',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalMethod[3],
          fontSize: 14.0,
        ),
      ),
      SizedBox(height: 8.0),
      _methodTimelineDiagram(),
    ],
  );
}

Widget _methodTimelineDiagram() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kPalMethod[1], width: 1.0),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _diagramBox('Dart\nFlutter UI', _kPalMethod[0], _kPalMethod[2]),
            _arrow('invokeMethod', _kPalMethod[2]),
            _diagramBox(
              'Codec\nEnvelope',
              Color(0xFFFFFFFF),
              _kPalMethod[1],
              width: 110,
            ),
            _arrow('binary', _kPalMethod[2]),
            _diagramBox('Native\nHandler', _kPalMethod[0], _kPalMethod[2]),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _diagramBox('Dart\nFuture', _kPalMethod[0], _kPalMethod[2]),
            _arrow('result', _kPalMethod[2], reverse: true),
            _diagramBox(
              'Codec\nDecode',
              Color(0xFFFFFFFF),
              _kPalMethod[1],
              width: 110,
            ),
            _arrow('reply', _kPalMethod[2], reverse: true),
            _diagramBox('Native\nReply', _kPalMethod[0], _kPalMethod[2]),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Errors travel the same path but wrapped in PlatformException.',
          style: TextStyle(fontSize: 11.5, color: _kMuted),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2: EVENTCHANNEL
// =============================================================================

Widget _buildEventChannelSection(List<Map<String, String>> snapshots) {
  return _sectionShell(
    number: '2',
    title: 'EventChannel Anatomy',
    subtitle:
        'A one-way pipe from native to Dart. Listen once, receive forever.',
    palette: _kPalEvent,
    children: [
      _codeBlock(
        '// Construct (illustration only)\n'
        'final battery = EventChannel("com.example/battery.level");\n'
        '// In production:\n'
        '// battery.receiveBroadcastStream().listen((tick) { ... });',
      ),
      SizedBox(height: 12.0),
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: _kPalEvent[1], width: 1.0),
        ),
        child: Column(
          children: [
            _tableHeader(
              ['Channel', 'Codec', 'Sample tick'],
              _kPalEvent[2],
              Color(0xFFFFFFFF),
            ),
            for (int i = 0; i < snapshots.length; i++)
              _tableRow(
                [
                  snapshots[i]['channel']!,
                  snapshots[i]['codec']!,
                  snapshots[i]['tick']!,
                ],
                bg: i.isEven ? Color(0xFFFFFFFF) : Color(0xFFFFF8E1),
              ),
          ],
        ),
      ),
      SizedBox(height: 14.0),
      Text(
        'Stream lifecycle (visual)',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalEvent[3],
          fontSize: 14.0,
        ),
      ),
      SizedBox(height: 8.0),
      _streamLifecycleDiagram(),
      SizedBox(height: 12.0),
      _calloutNote(
        'EventChannel encodes ".listen" as the system "listen" method internally, '
        'and ".cancel" when the last subscriber leaves. The codec is a MethodCodec, '
        'not a MessageCodec, despite being one-way.',
        _kPalEvent,
      ),
    ],
  );
}

Widget _streamLifecycleDiagram() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kPalEvent[1], width: 1.0),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _diagramBox('Subscribe', _kPalEvent[0], _kPalEvent[2]),
            _arrow('listen()', _kPalEvent[2]),
            _diagramBox('Native\nstartObserving', _kPalEvent[0], _kPalEvent[2]),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _diagramBox('Native\nevent #1', _kPalEvent[0], _kPalEvent[2]),
            _arrow('tick', _kPalEvent[2], reverse: true),
            _diagramBox('Sink', _kPalEvent[0], _kPalEvent[2]),
            _arrow('onData', _kPalEvent[2], reverse: true),
            _diagramBox('Dart\nconsumer', _kPalEvent[0], _kPalEvent[2]),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _diagramBox('cancel()', _kPalEvent[0], _kPalEvent[2]),
            _arrow('teardown', _kPalEvent[2]),
            _diagramBox('Native\nstopObserving', _kPalEvent[0], _kPalEvent[2]),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3: BASICMESSAGECHANNEL
// =============================================================================

Widget _buildBasicMessageSection(
  BasicMessageChannel<String> s,
  BasicMessageChannel<dynamic> j,
  BasicMessageChannel<ByteData> b,
  BasicMessageChannel<Object?> std,
) {
  final rows = <List<String>>[
    ['string', s.name, s.codec.runtimeType.toString(), 'String'],
    ['json', j.name, j.codec.runtimeType.toString(), 'dynamic'],
    ['binary', b.name, b.codec.runtimeType.toString(), 'ByteData'],
    ['standard', std.name, std.codec.runtimeType.toString(), 'Object?'],
  ];
  return _sectionShell(
    number: '3',
    title: 'BasicMessageChannel Anatomy',
    subtitle:
        'Symmetric send/receive without method names - just typed payloads.',
    palette: _kPalBasic,
    children: [
      _codeBlock(
        'final s = BasicMessageChannel<String>(\n'
        '  "com.example/messages.string", StringCodec(),\n'
        ');\n'
        'final j = BasicMessageChannel<dynamic>(\n'
        '  "com.example/messages.json", JSONMessageCodec(),\n'
        ');',
      ),
      SizedBox(height: 12.0),
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: _kPalBasic[1], width: 1.0),
        ),
        child: Column(
          children: [
            _tableHeader(
              ['Flavor', 'Name', 'Codec', 'Type parameter'],
              _kPalBasic[2],
              Color(0xFFFFFFFF),
            ),
            for (int i = 0; i < rows.length; i++)
              _tableRow(
                rows[i],
                bg: i.isEven ? Color(0xFFFFFFFF) : Color(0xFFE8F5E9),
              ),
          ],
        ),
      ),
      SizedBox(height: 14.0),
      _calloutNote(
        'Unlike MethodChannel, BasicMessageChannel has no envelope: every send '
        'is just a payload encoded by the codec. Replies are optional and '
        'arrive via the same codec.',
        _kPalBasic,
      ),
      SizedBox(height: 12.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _miniCallout(
              'Use it for',
              'Continuous push of small typed payloads, '
              'progress reports, log forwarding, ping/pong handshakes.',
              _kPalBasic,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: _miniCallout(
              'Skip it when',
              'You need named methods (use MethodChannel) '
              'or a stream subscription (use EventChannel).',
              _kPalBasic,
            ),
          ),
        ],
      ),
    ],
  );
}

// =============================================================================
// SECTION 4: CODEC COMPARISON
// =============================================================================

Widget _buildCodecComparisonSection(List<List<String>> rows) {
  return _sectionShell(
    number: '4',
    title: 'Codec Atlas',
    subtitle:
        'Six codecs: four for messages, two for method envelopes that wrap them.',
    palette: _kPalCodec,
    children: [
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: _kPalCodec[1], width: 1.0),
        ),
        child: Column(
          children: [
            _tableHeader(
              ['Codec', 'Wire format', 'Payload types', 'Best for'],
              _kPalCodec[2],
              Color(0xFFFFFFFF),
            ),
            for (int i = 0; i < rows.length; i++)
              _tableRow(
                rows[i],
                bg: i.isEven ? Color(0xFFFFFFFF) : Color(0xFFF3E5F5),
              ),
          ],
        ),
      ),
      SizedBox(height: 14.0),
      Text(
        'Family tree',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalCodec[3],
          fontSize: 14.0,
        ),
      ),
      SizedBox(height: 8.0),
      _codecFamilyTree(),
      SizedBox(height: 14.0),
      Text(
        'Instantiation snapshot',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalCodec[3],
          fontSize: 14.0,
        ),
      ),
      SizedBox(height: 8.0),
      _codecInstanceTable(),
    ],
  );
}

Widget _codecFamilyTree() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kPalCodec[1], width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _diagramBox('MessageCodec<T>\n(interface)', _kPalCodec[0],
                _kPalCodec[2],
                width: 170),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _diagramBox('Standard', _kPalCodec[0], _kPalCodec[2]),
            _diagramBox('JSON', _kPalCodec[0], _kPalCodec[2]),
            _diagramBox('String', _kPalCodec[0], _kPalCodec[2]),
            _diagramBox('Binary', _kPalCodec[0], _kPalCodec[2]),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _diagramBox(
              'MethodCodec\n(interface)',
              _kPalCodec[0],
              _kPalCodec[2],
              width: 170,
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _diagramBox('Standard\nMethodCodec', _kPalCodec[0], _kPalCodec[2]),
            _diagramBox('JSON\nMethodCodec', _kPalCodec[0], _kPalCodec[2]),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Method codecs internally use the matching message codec to encode '
          'the arguments inside the MethodCall envelope.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.5, color: _kMuted),
        ),
      ],
    ),
  );
}

Widget _codecInstanceTable() {
  // Construct codecs to surface real runtimeTypes.
  final List<List<String>> rows = [
    [
      'StandardMessageCodec()',
      StandardMessageCodec().runtimeType.toString(),
      'MessageCodec',
    ],
    [
      'JSONMessageCodec()',
      JSONMessageCodec().runtimeType.toString(),
      'MessageCodec',
    ],
    ['StringCodec()', StringCodec().runtimeType.toString(), 'MessageCodec'],
    ['BinaryCodec()', BinaryCodec().runtimeType.toString(), 'MessageCodec'],
    [
      'StandardMethodCodec()',
      StandardMethodCodec().runtimeType.toString(),
      'MethodCodec',
    ],
    [
      'JSONMethodCodec()',
      JSONMethodCodec().runtimeType.toString(),
      'MethodCodec',
    ],
  ];
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kPalCodec[1], width: 1.0),
    ),
    child: Column(
      children: [
        _tableHeader(
          ['Constructor', 'runtimeType', 'Family'],
          _kPalCodec[2],
          Color(0xFFFFFFFF),
        ),
        for (int i = 0; i < rows.length; i++)
          _tableRow(
            rows[i],
            bg: i.isEven ? Color(0xFFFFFFFF) : Color(0xFFF3E5F5),
          ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5: BYTE STREAMS (visual encoding examples)
// =============================================================================

Widget _buildByteStreamSection() {
  return _sectionShell(
    number: '5',
    title: 'Encoding Examples',
    subtitle:
        'How a payload like {"ok": true, "n": 42} becomes bytes on the wire.',
    palette: _kPalBytes,
    children: [
      Text(
        'StandardMessageCodec (excerpt)',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalBytes[3],
          fontSize: 13.5,
        ),
      ),
      SizedBox(height: 4.0),
      _byteRow(
        ['0D', '02', '02', '6F', '6B', '01'],
        _kPalBytes[0],
        _kPalBytes[3],
        'Map (0x0D), size=2, key "ok" (type 0x02 + 2 + "ok"), value true (0x01)',
      ),
      _byteRow(
        ['02', '01', '6E', '03', '2A', '00', '00', '00'],
        _kPalBytes[0],
        _kPalBytes[3],
        'Key "n" (type 0x02 + 1 + "n"), value int32 (0x03) = 0x0000002A = 42',
      ),
      SizedBox(height: 12.0),
      Text(
        'JSONMessageCodec',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalBytes[3],
          fontSize: 13.5,
        ),
      ),
      SizedBox(height: 4.0),
      _byteRow(
        ['7B', '22', '6F', '6B', '22', '3A', '74', '72', '75', '65'],
        _kPalBytes[0],
        _kPalBytes[3],
        '`{"ok":true` - literal UTF-8 text, no envelope tags.',
      ),
      _byteRow(
        ['2C', '22', '6E', '22', '3A', '34', '32', '7D'],
        _kPalBytes[0],
        _kPalBytes[3],
        '`,"n":42}` - human-readable closing.',
      ),
      SizedBox(height: 12.0),
      Text(
        'StringCodec',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalBytes[3],
          fontSize: 13.5,
        ),
      ),
      SizedBox(height: 4.0),
      _byteRow(
        ['68', '65', '6C', '6C', '6F'],
        _kPalBytes[0],
        _kPalBytes[3],
        '"hello" as raw UTF-8 bytes. That\'s the entire wire format.',
      ),
      SizedBox(height: 12.0),
      Text(
        'BinaryCodec',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _kPalBytes[3],
          fontSize: 13.5,
        ),
      ),
      SizedBox(height: 4.0),
      _byteRow(
        ['DE', 'AD', 'BE', 'EF'],
        _kPalBytes[0],
        _kPalBytes[3],
        'Identity: ByteData in, same bytes out. Useful for images and tensors.',
      ),
      SizedBox(height: 12.0),
      _calloutNote(
        'The Standard codec is binary and compact; JSON is fat but '
        'inspectable; String and Binary are zero-overhead specialists.',
        _kPalBytes,
      ),
    ],
  );
}

// =============================================================================
// SECTION 6: SYSTEMCHANNELS CATALOG
// =============================================================================

Widget _buildSystemChannelsSection(List<Map<String, String>> cards) {
  return _sectionShell(
    number: '6',
    title: 'SystemChannels Catalog',
    subtitle:
        'The built-in channels Flutter already wires up to the engine for you.',
    palette: _kPalSystem,
    children: [
      Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          for (final c in cards) _systemChannelCard(c),
        ],
      ),
      SizedBox(height: 14.0),
      _calloutNote(
        'These constants are MethodChannels (mostly with JSON codec) living on '
        'well-known names like "flutter/platform". Reuse them directly when '
        'speaking to the engine; only create custom channels for plugin code.',
        _kPalSystem,
      ),
    ],
  );
}

Widget _systemChannelCard(Map<String, String> data) {
  return Container(
    width: 260.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kPalSystem[1], width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dns, size: 16.0, color: _kPalSystem[2]),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                data['name'] ?? '',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: _kPalSystem[3],
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        _chip(
          data['codec'] ?? '',
          _kPalSystem[0],
          _kPalSystem[3],
        ),
        SizedBox(height: 8.0),
        Text(
          data['role'] ?? '',
          style: TextStyle(fontSize: 11.5, color: _kInk),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7: REAL-WORLD FLOWS
// =============================================================================

Widget _buildFlowsSection() {
  return _sectionShell(
    number: '7',
    title: 'Real-World Flow Narratives',
    subtitle:
        'How channels stitch together to deliver everyday Flutter features.',
    palette: _kPalFlows,
    children: [
      _flowCard(
        title: 'Camera capture',
        steps: [
          'UI calls method "open" on com.example.camera/control',
          'StandardMethodCodec packs args into bytes',
          'Native opens AVCaptureSession / Camera2',
          'EventChannel com.example.camera/frames streams previews',
          'UI cancels stream + calls "close" on shutdown',
        ],
        palette: _kPalFlows,
      ),
      _flowCard(
        title: 'Share intent',
        steps: [
          'UI calls SystemChannels.platform "Share.invoke"',
          'JSONMethodCodec sends ["text", "url"] over the wire',
          'Platform displays system share sheet',
          'PlatformException returned if user cancels',
          'Result Future completes with chosen activity',
        ],
        palette: _kPalFlows,
      ),
      _flowCard(
        title: 'Local notifications',
        steps: [
          'Plugin MethodChannel "dexterous.com/flutter/local_notifications"',
          'MethodCall("scheduleNotification", { id, title, body, when })',
          'Native enqueues AlarmManager / UNUserNotification',
          'BasicMessageChannel reports delivery status',
          'On tap, native invokes Dart MethodCallHandler "selectNotification"',
        ],
        palette: _kPalFlows,
      ),
      _flowCard(
        title: 'IME text editing',
        steps: [
          'Focus -> SystemChannels.textInput.show',
          'setEditingState pushes TextEditingValue to engine',
          'Native IME sends "updateEditingState" back',
          'Framework reconciles and dispatches text changes',
          'On unfocus -> SystemChannels.textInput.hide',
        ],
        palette: _kPalFlows,
      ),
    ],
  );
}

Widget _flowCard({
  required String title,
  required List<String> steps,
  required List<Color> palette,
}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: palette[1], width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, size: 16.0, color: palette[2]),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: palette[3],
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22.0,
                  height: 22.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: palette[2],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    steps[i],
                    style: TextStyle(fontSize: 12.5, color: _kInk),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8: RECIPES
// =============================================================================

Widget _buildRecipeSection() {
  return _sectionShell(
    number: '8',
    title: 'Recipe Cards',
    subtitle:
        'Compact patterns for choosing the right channel and the right codec.',
    palette: _kPalRecipe,
    children: [
      _recipeCard(
        title: 'Pick a channel',
        description:
            'Ask: is it request/response, push, or symmetric messaging?',
        steps: [
          'Request/response -> MethodChannel',
          'One-way push -> EventChannel',
          'Symmetric / fire-and-forget -> BasicMessageChannel',
        ],
        palette: _kPalRecipe,
      ),
      _recipeCard(
        title: 'Pick a codec',
        description: 'Match payload shape and inspectability needs.',
        steps: [
          'Mixed numbers / maps / lists -> StandardMessageCodec',
          'Web/debuggable JSON -> JSONMessageCodec',
          'Plain text -> StringCodec',
          'Raw bytes (images, audio) -> BinaryCodec',
        ],
        palette: _kPalRecipe,
      ),
      _recipeCard(
        title: 'Name a channel',
        description:
            'Use reverse-DNS + a logical sub-path. Keep names stable.',
        steps: [
          'com.acme.app/feature',
          'com.acme.app/feature.subfeature',
          'Avoid spaces, slashes inside the path, or version numbers.',
          'Bundle related methods on the same channel for efficiency.',
        ],
        palette: _kPalRecipe,
      ),
      _recipeCard(
        title: 'Handle errors',
        description: 'Channels surface failures as PlatformException objects.',
        steps: [
          'Always wrap invokeMethod in try/catch',
          'PlatformException.code is a stable string identifier',
          'MissingPluginException = no handler attached',
          'Propagate user-facing messages from PlatformException.message',
        ],
        palette: _kPalRecipe,
      ),
      _recipeCard(
        title: 'Test channels',
        description:
            'Use TestDefaultBinaryMessenger to mock platform responses.',
        steps: [
          'setMockMethodCallHandler on the channel under test',
          'Return canned values or throw PlatformException',
          'Verify side effects via the framework binding',
          'Always tear down handlers in tearDown',
        ],
        palette: _kPalRecipe,
      ),
    ],
  );
}

// =============================================================================
// SECTION 9: GLOSSARY
// =============================================================================

Widget _buildGlossarySection() {
  final entries = <List<String>>[
    [
      'BinaryMessenger',
      'Low-level transport that ships ByteData between Dart and the engine.',
    ],
    [
      'MethodCall',
      'A pair of (method, arguments) sent by MethodChannel/EventChannel.',
    ],
    [
      'PlatformException',
      'Structured error returned over MethodChannel: code + message + details.',
    ],
    [
      'MissingPluginException',
      'Special error when no handler is registered for a method.',
    ],
    [
      'envelope',
      'A byte prefix that distinguishes success/error replies in MethodCodec.',
    ],
    [
      'broadcast stream',
      'Multi-subscriber Dart Stream emitted by EventChannel.',
    ],
    [
      'background isolate',
      'Side isolate that uses BackgroundIsolateBinaryMessenger to reach plugins.',
    ],
    [
      'mock messenger',
      'Test double that intercepts messages before they reach native code.',
    ],
  ];
  return _sectionShell(
    number: '9',
    title: 'Glossary',
    subtitle: 'Vocabulary you will encounter in plugin source code.',
    palette: _kPalGlossary,
    children: [
      for (final e in entries)
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 6.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(color: _kPalGlossary[1], width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 160.0,
                child: Text(
                  e[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _kPalGlossary[3],
                    fontSize: 12.5,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  e[1],
                  style: TextStyle(fontSize: 12.5, color: _kInk),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

// =============================================================================
// EPILOGUE
// =============================================================================

Widget _buildEpilogue() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF37474F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, color: Color(0xFFFFCA28), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Epilogue',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Channels are surprisingly small: a name, a codec, a messenger. The '
          'leverage comes from composing them - MethodChannel for control, '
          'EventChannel for telemetry, BasicMessageChannel for the loose joints '
          'in between. Once you can read this atlas, plugins become small.',
          style: TextStyle(
            color: Color(0xFFECEFF1),
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            _chip(
              'visual',
              Color(0x33FFFFFF),
              Color(0xFFFFFFFF),
            ),
            SizedBox(width: 6.0),
            _chip(
              'no-async',
              Color(0x33FFFFFF),
              Color(0xFFFFFFFF),
            ),
            SizedBox(width: 6.0),
            _chip(
              'analyzer-clean',
              Color(0x33FFFFFF),
              Color(0xFFFFFFFF),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Animation snapshot: AlwaysStoppedAnimation<double>(${AlwaysStoppedAnimation<double>(1.0).value})  '
          'in duration ${Duration.zero}.',
          style: TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SHARED CALLOUTS
// =============================================================================

Widget _calloutNote(String text, List<Color> palette) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: palette[0],
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: palette[2], width: 4.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.lightbulb_outline, size: 18.0, color: palette[2]),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.5, color: _kInk, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

Widget _miniCallout(String title, String body, List<Color> palette) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: palette[1], width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: palette[3],
            fontSize: 12.5,
          ),
        ),
        SizedBox(height: 6.0),
        Text(body, style: TextStyle(fontSize: 12.0, color: _kInk)),
      ],
    ),
  );
}
