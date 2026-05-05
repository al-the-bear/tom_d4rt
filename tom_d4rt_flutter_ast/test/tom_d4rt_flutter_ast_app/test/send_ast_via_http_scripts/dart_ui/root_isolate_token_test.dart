// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: RootIsolateToken from dart:ui — Isolate Forest edition.
//
// Theme: "Isolate Forest" — a moody forest of background isolates, each tied
// back to the root isolate by a luminous token thread. The token is the
// handshake that lets a spawned isolate participate in platform-channel
// conversations. Without it, the BinaryMessenger has no anchor and platform
// plugins refuse to talk.
//
// This file paints a long-form visual essay describing:
//   * the role of RootIsolateToken.instance,
//   * how BackgroundIsolateBinaryMessenger.ensureInitialized binds an isolate,
//   * common scenarios for offloading work,
//   * comparisons with Isolate.spawn, compute(), and Worker pools,
//   * pitfalls, glossary, and a decision flowchart.
//
// The widget tree is a Scaffold with a CustomScrollView. No state, no async,
// no controllers — purely declarative. We *describe* isolate spawning rather
// than performing it, because the d4rt sandbox doesn't let us spawn real ones.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // PALETTE — "Isolate Forest"
  // ---------------------------------------------------------------------------
  final Color forestNight = const Color(0xFF0B1A14);
  final Color forestDeep = const Color(0xFF13261D);
  final Color forestMid = const Color(0xFF1E3A2C);
  final Color spawnMagenta = const Color(0xFFD940A0);
  final Color spawnBlush = const Color(0xFFF7B5DC);
  final Color tokenAmber = const Color(0xFFE8B341);
  final Color tokenGlow = const Color(0xFFFFD978);
  final Color bgTeal = const Color(0xFF2EB6A6);
  final Color bgTealDeep = const Color(0xFF146E63);
  final Color rootEmerald = const Color(0xFF1FAA6B);
  final Color rootMint = const Color(0xFF7FE3B5);
  final Color paperBone = const Color(0xFFEFE7D2);
  final Color paperWarm = const Color(0xFFD9CFA9);
  final Color inkCharcoal = const Color(0xFF14211B);
  final Color warningRust = const Color(0xFFB6432A);
  final Color cautionMustard = const Color(0xFFC8A028);
  final Color shadowMoss = const Color(0xFF0A1410);

  // ---------------------------------------------------------------------------
  // SAFE PROBE — RootIsolateToken.instance.
  // ensureInitialized is *only* described visually; calling it on the root
  // isolate (or in the d4rt sandbox) would throw. We try the instance getter
  // and capture the outcome as a string for the hero card.
  // ---------------------------------------------------------------------------
  String tokenProbe;
  String tokenType;
  String tokenIdentity;
  bool tokenAvailable;
  try {
    final dynamic t1 = ui.RootIsolateToken.instance;
    final dynamic t2 = ui.RootIsolateToken.instance;
    tokenProbe = (t1 == null) ? 'null (non-root isolate)' : 'present';
    tokenType = (t1 == null) ? 'n/a' : t1.runtimeType.toString();
    tokenIdentity = identical(t1, t2) ? 'identical (singleton)' : 'distinct';
    tokenAvailable = t1 != null;
  } catch (e) {
    tokenProbe = 'threw: ${e.runtimeType}';
    tokenType = 'unknown';
    tokenIdentity = 'unknown';
    tokenAvailable = false;
  }

  // Mention BackgroundIsolateBinaryMessenger in a try/catch so the page also
  // documents that *attempting* the call on the main isolate is a known no-op.
  String ensureProbe;
  try {
    // We deliberately do NOT actually call ensureInitialized: it is illegal on
    // the root isolate. Instead we encode the documentation outcome.
    ensureProbe = 'skipped (would throw on main isolate)';
  } catch (e) {
    ensureProbe = 'threw: ${e.runtimeType}';
  }

  print('RootIsolateToken visual demo — Isolate Forest');
  print('=' * 60);
  print('token probe: $tokenProbe');
  print('token type:  $tokenType');
  print('singleton:   $tokenIdentity');
  print('ensure call: $ensureProbe');
  print('=' * 60);

  // ---------------------------------------------------------------------------
  // PALETTE TABLE DATA
  // ---------------------------------------------------------------------------
  final List<List<dynamic>> paletteRows = <List<dynamic>>[
    <dynamic>['forestNight', forestNight, 'page background; deepest canopy'],
    <dynamic>['forestDeep', forestDeep, 'card surface; under-canopy'],
    <dynamic>['forestMid', forestMid, 'panel inset; mid canopy'],
    <dynamic>['rootEmerald', rootEmerald, 'root isolate node'],
    <dynamic>['rootMint', rootMint, 'root isolate halo'],
    <dynamic>['bgTeal', bgTeal, 'background isolate node'],
    <dynamic>['bgTealDeep', bgTealDeep, 'background isolate halo'],
    <dynamic>['spawnMagenta', spawnMagenta, 'spawn arrow / accent'],
    <dynamic>['spawnBlush', spawnBlush, 'spawn arrow soft tail'],
    <dynamic>['tokenAmber', tokenAmber, 'token thread / handshake'],
    <dynamic>['tokenGlow', tokenGlow, 'token glow highlight'],
    <dynamic>['paperBone', paperBone, 'primary text on dark'],
    <dynamic>['paperWarm', paperWarm, 'secondary text on dark'],
    <dynamic>['warningRust', warningRust, 'pitfall callouts'],
    <dynamic>['cautionMustard', cautionMustard, 'caution callouts'],
    <dynamic>['shadowMoss', shadowMoss, 'shadow / outline'],
  ];

  // ---------------------------------------------------------------------------
  // API SURFACE TABLE
  // ---------------------------------------------------------------------------
  final List<List<String>> apiRows = <List<String>>[
    <String>[
      'RootIsolateToken',
      'class',
      'Opaque handle bound to the root isolate of the engine. Sendable.'
    ],
    <String>[
      'RootIsolateToken.instance',
      'static getter',
      'Returns the token for the current root isolate, or null off-root.'
    ],
    <String>[
      'BackgroundIsolateBinaryMessenger',
      'class',
      'A BinaryMessenger usable from a non-root isolate after ensureInitialized.'
    ],
    <String>[
      'BackgroundIsolateBinaryMessenger.ensureInitialized(token)',
      'static method',
      'Binds the calling isolate to the root isolate using the supplied token.'
    ],
    <String>[
      'ServicesBinding.instance.defaultBinaryMessenger',
      'getter',
      'Resolves to the BackgroundIsolateBinaryMessenger when initialized.'
    ],
    <String>[
      'MethodChannel.invokeMethod',
      'instance method',
      'Becomes safe on a background isolate once the messenger is initialized.'
    ],
    <String>[
      'Isolate.spawn',
      'static method',
      'Standard Dart API used to start the background worker that holds the token.'
    ],
    <String>[
      'compute<Q,R>(fn, msg)',
      'top-level function',
      'Higher-level helper — does NOT wire RootIsolateToken; channels won\'t work.'
    ],
  ];

  // ---------------------------------------------------------------------------
  // SCENARIO PANELS — what kinds of work need a bound background isolate
  // ---------------------------------------------------------------------------
  final List<List<String>> scenarios = <List<String>>[
    <String>[
      'Image processing',
      'Decode large JPEG/PNG, resize, apply convolution kernels.',
      'Needs platform channel? Sometimes — to read EXIF via plugins.',
      'Without token: image bytes work, but EXIF plugin call hangs.',
    ],
    <String>[
      'JSON parsing',
      'Deserialize multi-megabyte payloads off the UI thread.',
      'Needs platform channel? Usually no — pure Dart.',
      'Token is optional but recommended if logging via plugin sinks.',
    ],
    <String>[
      'ML inference',
      'Run a quantized model via tflite_flutter or similar.',
      'Needs platform channel? Yes — the plugin marshals tensors.',
      'Without token: every invokeMethod call throws MissingPluginException.',
    ],
    <String>[
      'File I/O',
      'Stream gigabytes through compression or hashing.',
      'Needs platform channel? Yes — path_provider, permission_handler.',
      'Bind once at isolate startup and reuse channels for the session.',
    ],
    <String>[
      'Archive extraction',
      'Unzip / untar bundles into application support dir.',
      'Needs platform channel? Yes — path_provider for target dir.',
      'Pattern: spawn -> ensureInitialized -> getApplicationSupportDirectory.',
    ],
    <String>[
      'Audio analysis',
      'FFT large PCM buffers to detect onsets.',
      'Needs platform channel? Sometimes — for audio permissions.',
      'Token enables permission_handler in the worker isolate.',
    ],
    <String>[
      'Cryptography',
      'PBKDF2, scrypt, large-key generation.',
      'Needs platform channel? Rarely — unless using secure_storage.',
      'When using secure_storage: bind the token at isolate boot.',
    ],
    <String>[
      'Background sync',
      'Reconcile a remote API with a local SQLite database.',
      'Needs platform channel? Yes — sqflite uses MethodChannel.',
      'Without token: the first INSERT call deadlocks.',
    ],
  ];

  // ---------------------------------------------------------------------------
  // COMPARISON TABLE: RootIsolateToken vs Isolate.spawn vs compute vs Worker
  // ---------------------------------------------------------------------------
  final List<List<String>> compareRows = <List<String>>[
    <String>[
      'RootIsolateToken',
      'Sendable handle',
      'Required for platform channels in non-root isolates',
      'Pair with Isolate.spawn manually',
    ],
    <String>[
      'Isolate.spawn',
      'Low-level API',
      'Full control of port plumbing and messages',
      'Verbose — but the only way to keep an isolate alive long-term',
    ],
    <String>[
      'compute()',
      'High-level helper',
      'One-shot computation, returns a Future',
      'Does NOT wire RootIsolateToken automatically',
    ],
    <String>[
      'Worker pool (custom)',
      'Reusable workers',
      'Amortized spawn cost across many tasks',
      'Bind token once per worker, then accept jobs over a port',
    ],
    <String>[
      'IsolateNameServer',
      'Coordination registry',
      'Look up SendPorts by name across plugins',
      'Often used together with the token for plugin callbacks',
    ],
  ];

  // ---------------------------------------------------------------------------
  // PITFALL TABLE
  // ---------------------------------------------------------------------------
  final List<List<String>> pitfallRows = <List<String>>[
    <String>[
      'Forgetting ensureInitialized',
      'invokeMethod throws MissingPluginException or hangs forever.',
      'Call ensureInitialized as the FIRST statement inside the entry point.',
    ],
    <String>[
      'Calling ensureInitialized on the root isolate',
      'Throws StateError — the messenger is already the platform one.',
      'Guard with `if (RootIsolateToken.instance != null && /* off-root */)`.',
    ],
    <String>[
      'Sending a non-Sendable type',
      'Isolate.spawn argument fails to transfer; isolate dies silently.',
      'Stick to primitives, lists, maps, and types like RootIsolateToken.',
    ],
    <String>[
      'Caching the messenger across isolates',
      'BinaryMessenger is per-isolate; sharing it crashes.',
      'Each isolate calls ensureInitialized independently.',
    ],
    <String>[
      'Using compute() expecting plugins to work',
      'compute does not wire the token; channels misbehave.',
      'For plugin-using work, hand-roll Isolate.spawn with the token.',
    ],
    <String>[
      'Discarding the token after spawn',
      'Subsequent isolates can\'t bind without the original token reference.',
      'Capture it once per spawn batch and pass explicitly.',
    ],
  ];

  // ---------------------------------------------------------------------------
  // GLOSSARY
  // ---------------------------------------------------------------------------
  final List<List<String>> glossary = <List<String>>[
    <String>[
      'Isolate',
      'A Dart unit of execution with its own heap and event loop.',
    ],
    <String>[
      'Root isolate',
      'The first isolate the engine starts; owns the platform messenger.',
    ],
    <String>[
      'Background isolate',
      'Any isolate spawned from the root; needs a token to talk to plugins.',
    ],
    <String>[
      'BinaryMessenger',
      'The pipe through which method-channel bytes travel.',
    ],
    <String>[
      'Platform channel',
      'A typed protocol layered over BinaryMessenger (MethodChannel etc).',
    ],
    <String>[
      'Sendable',
      'A value that can cross isolate boundaries without copying everything.',
    ],
    <String>[
      'SendPort / ReceivePort',
      'The two halves of a Dart-native message pipe between isolates.',
    ],
    <String>[
      'IsolateNameServer',
      'A static registry that maps names to SendPorts across the engine.',
    ],
    <String>[
      'compute()',
      'Sugar over Isolate.spawn for one-shot pure-Dart computations.',
    ],
    <String>[
      'Worker pool',
      'A reusable set of isolates that consume jobs off a queue.',
    ],
  ];

  // ---------------------------------------------------------------------------
  // DECISION FLOWCHART ROWS
  // ---------------------------------------------------------------------------
  final List<List<String>> decisionRows = <List<String>>[
    <String>[
      'Q1',
      'Will the work block the UI for > 16 ms?',
      'No -> stay on the root isolate. Yes -> continue.',
    ],
    <String>[
      'Q2',
      'Does the work touch a platform plugin?',
      'No -> compute() is enough. Yes -> continue.',
    ],
    <String>[
      'Q3',
      'Is the work one-shot or recurring?',
      'One-shot -> Isolate.spawn + token + entry point.',
    ],
    <String>[
      'Q4',
      'Is the work recurring?',
      'Spin up a worker pool; bind token per worker on boot.',
    ],
    <String>[
      'Q5',
      'Will workers callback into Dart from native?',
      'Yes -> register a SendPort via IsolateNameServer in addition to token.',
    ],
  ];

  // ---------------------------------------------------------------------------
  // ASCII ISOLATE DIAGRAM
  // ---------------------------------------------------------------------------
  final List<String> asciiDiagram = <String>[
    '+---------------------------+        +---------------------------+',
    '|     ROOT  ISOLATE         |        |   BACKGROUND  ISOLATE     |',
    '|   (engine main thread)    |        |  (spawned by Isolate.spawn)|',
    '|---------------------------|        |---------------------------|',
    '|  RootIsolateToken.instance|  ====> |  ensureInitialized(token) |',
    '|        is non-null        |  TOKEN |  binds BinaryMessenger    |',
    '|                           |        |                           |',
    '|  Platform Channels: OK    |        |  Platform Channels: OK    |',
    '|  UI / Widgets: OK         |        |  UI / Widgets: forbidden  |',
    '|  setState: OK             |        |  setState: forbidden      |',
    '+-------------+-------------+        +-------------+-------------+',
    '              |                                    |',
    '              | SendPort / ReceivePort messages    |',
    '              +------------------------------------+',
    '                       (Dart-native pipe)',
  ];

  // ---------------------------------------------------------------------------
  // SEQUENCE DIAGRAM ROWS
  // ---------------------------------------------------------------------------
  final List<List<String>> sequenceRows = <List<String>>[
    <String>['1', 'main', 'capture token = RootIsolateToken.instance!'],
    <String>['2', 'main', 'create ReceivePort rp'],
    <String>['3', 'main', 'Isolate.spawn(entry, [token, rp.sendPort])'],
    <String>['4', 'bg ', 'entry receives [token, parentSendPort]'],
    <String>['5', 'bg ', 'BackgroundIsolateBinaryMessenger.ensureInitialized(token)'],
    <String>['6', 'bg ', 'create local ReceivePort and send sendPort to parent'],
    <String>['7', 'main', 'rp.listen receives bg sendPort'],
    <String>['8', 'main', 'send Job over bg sendPort'],
    <String>['9', 'bg ', 'process Job using MethodChannel("plugin").invokeMethod'],
    <String>['10', 'bg ', 'reply with Result through parent sendPort'],
    <String>['11', 'main', 'consume Result, update UI on root isolate'],
    <String>['12', 'main', 'optionally tear down bg via Isolate.kill'],
  ];

  // ---------------------------------------------------------------------------
  // CODE SNIPPET (rendered as monospace text — describing, not executing)
  // ---------------------------------------------------------------------------
  final List<String> snippetLines = <String>[
    '// Spawn a background isolate that can use platform channels.',
    'import \'dart:isolate\';',
    'import \'dart:ui\';',
    'import \'package:flutter/services.dart\';',
    '',
    'Future<void> spawnWorker() async {',
    '  final RootIsolateToken token = RootIsolateToken.instance!;',
    '  final ReceivePort rp = ReceivePort();',
    '  await Isolate.spawn<List<Object>>(',
    '    _entry,',
    '    <Object>[token, rp.sendPort],',
    '  );',
    '  rp.listen((dynamic msg) {',
    '    // Messages from the worker land here.',
    '  });',
    '}',
    '',
    'void _entry(List<Object> args) {',
    '  final RootIsolateToken token = args[0] as RootIsolateToken;',
    '  final SendPort parent = args[1] as SendPort;',
    '  BackgroundIsolateBinaryMessenger.ensureInitialized(token);',
    '  // From here onward, MethodChannel("io.your.plugin") works.',
    '  parent.send(\'ready\');',
    '}',
  ];

  // ---------------------------------------------------------------------------
  // TIMELINE / LIFECYCLE BARS
  // ---------------------------------------------------------------------------
  final List<List<dynamic>> lifecycleBars = <List<dynamic>>[
    <dynamic>['boot', 0.05, rootEmerald, 'Engine launches; root isolate created'],
    <dynamic>['runApp', 0.10, rootMint, 'Widgets mount; messenger ready'],
    <dynamic>['idle', 0.20, forestMid, 'UI runs frames; no background work yet'],
    <dynamic>['spawn', 0.05, spawnMagenta, 'Isolate.spawn(entry, [token, port])'],
    <dynamic>['ensure', 0.05, tokenAmber, 'ensureInitialized(token) in worker'],
    <dynamic>['working', 0.30, bgTeal, 'Background plugin calls + computation'],
    <dynamic>['reply', 0.05, spawnBlush, 'SendPort delivers result'],
    <dynamic>['idle2', 0.15, forestMid, 'UI consumes result; bg holds for next job'],
    <dynamic>['kill', 0.05, warningRust, 'Optional Isolate.kill teardown'],
  ];

  // ---------------------------------------------------------------------------
  // BUILD HELPERS — small named widgets via local functions
  // ---------------------------------------------------------------------------

  Widget chip(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withValues(alpha: 0.35), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget swatch(String name, Color color, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: forestDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: shadowMoss, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: paperBone.withValues(alpha: 0.25), width: 1),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    color: paperBone,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: TextStyle(
                    color: paperWarm,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String number, String title, String subtitle, Color accent) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            accent.withValues(alpha: 0.35),
            forestDeep.withValues(alpha: 0.0),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: accent, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: forestNight,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: paperBone,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: paperWarm,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pill(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget asciiBox(List<String> lines, Color color) {
    final List<Widget> rendered = <Widget>[];
    for (int i = 0; i < lines.length; i = i + 1) {
      rendered.add(Text(
        lines[i],
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontFamily: 'monospace',
          height: 1.25,
        ),
      ));
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: forestNight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tokenAmber.withValues(alpha: 0.55), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rendered,
      ),
    );
  }

  // Hero card — the centerpiece. A "graph" of root <-> background isolates,
  // joined by a bright token thread.
  Widget heroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            forestDeep,
            forestMid,
            forestNight,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tokenAmber.withValues(alpha: 0.45), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tokenAmber.withValues(alpha: 0.18),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              chip('dart:ui', tokenAmber, forestNight),
              const SizedBox(width: 6),
              chip('Isolate Forest', spawnMagenta, paperBone),
              const SizedBox(width: 6),
              chip('v3.0+', bgTeal, forestNight),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'RootIsolateToken',
            style: TextStyle(
              color: paperBone,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A handshake the root isolate hands to its children so they can speak to plugins.',
            style: TextStyle(
              color: paperWarm,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 18),
          // The graph: two big circles + a token thread between them.
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // ROOT NODE
              Container(
                width: 110,
                height: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: <Color>[
                      rootMint,
                      rootEmerald,
                      forestDeep,
                    ],
                  ),
                  border: Border.all(color: rootMint, width: 2),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: rootEmerald.withValues(alpha: 0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'ROOT',
                      style: TextStyle(
                        color: forestNight,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'isolate',
                      style: TextStyle(
                        color: forestNight,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // The token thread
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: tokenAmber,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        'TOKEN',
                        style: TextStyle(
                          color: forestNight,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            rootEmerald,
                            tokenGlow,
                            tokenAmber,
                            bgTeal,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: tokenAmber.withValues(alpha: 0.55),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '>>>>  spawn + token  >>>>',
                      style: TextStyle(
                        color: spawnBlush,
                        fontSize: 10,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // BACKGROUND NODE
              Container(
                width: 110,
                height: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: <Color>[
                      bgTeal,
                      bgTealDeep,
                      forestDeep,
                    ],
                  ),
                  border: Border.all(color: bgTeal, width: 2),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: bgTealDeep.withValues(alpha: 0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'BG',
                      style: TextStyle(
                        color: forestNight,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'isolate',
                      style: TextStyle(
                        color: forestNight,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Probe results
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: forestNight.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: tokenAmber.withValues(alpha: 0.3), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'LIVE PROBE',
                  style: TextStyle(
                    color: tokenAmber,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'instance',
                            style: TextStyle(color: paperWarm, fontSize: 10),
                          ),
                          Text(
                            tokenProbe,
                            style: TextStyle(
                              color: tokenAvailable ? rootMint : warningRust,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'runtimeType',
                            style: TextStyle(color: paperWarm, fontSize: 10),
                          ),
                          Text(
                            tokenType,
                            style: TextStyle(
                              color: paperBone,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'singleton',
                            style: TextStyle(color: paperWarm, fontSize: 10),
                          ),
                          Text(
                            tokenIdentity,
                            style: TextStyle(
                              color: paperBone,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'ensureInitialized: $ensureProbe',
                  style: TextStyle(
                    color: cautionMustard,
                    fontSize: 11,
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

  // ---------------------------------------------------------------------------
  // SECTION BUILDERS — assembled in `slivers` below.
  // ---------------------------------------------------------------------------

  // Palette section: a swatch grid.
  final List<Widget> swatchWidgets = <Widget>[];
  for (int i = 0; i < paletteRows.length; i = i + 1) {
    final List<dynamic> row = paletteRows[i];
    swatchWidgets.add(swatch(row[0] as String, row[1] as Color, row[2] as String));
  }

  // API section: a striped table.
  final List<Widget> apiWidgets = <Widget>[];
  apiWidgets.add(Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: tokenAmber.withValues(alpha: 0.18),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            'symbol',
            style: TextStyle(
              color: tokenAmber,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'kind',
            style: TextStyle(
              color: tokenAmber,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            'description',
            style: TextStyle(
              color: tokenAmber,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    ),
  ));
  for (int i = 0; i < apiRows.length; i = i + 1) {
    final List<String> r = apiRows[i];
    final Color stripe = (i % 2 == 0) ? forestDeep : forestMid;
    apiWidgets.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: stripe,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              r[0],
              style: TextStyle(
                color: spawnBlush,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              r[1],
              style: TextStyle(color: paperWarm, fontSize: 11),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              r[2],
              style: TextStyle(color: paperBone, fontSize: 11.5, height: 1.35),
            ),
          ),
        ],
      ),
    ));
  }

  // Scenario panels.
  final List<Widget> scenarioWidgets = <Widget>[];
  for (int i = 0; i < scenarios.length; i = i + 1) {
    final List<String> s = scenarios[i];
    scenarioWidgets.add(Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: forestDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: bgTeal, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bgTeal,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: forestNight,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  s[0],
                  style: TextStyle(
                    color: paperBone,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            s[1],
            style: TextStyle(color: paperBone, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 4),
          Text(
            s[2],
            style: TextStyle(
              color: cautionMustard,
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            s[3],
            style: TextStyle(color: spawnBlush, fontSize: 11.5),
          ),
        ],
      ),
    ));
  }

  // Comparison table.
  final List<Widget> compareWidgets = <Widget>[];
  compareWidgets.add(Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: spawnMagenta.withValues(alpha: 0.22),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            'tool',
            style: TextStyle(
              color: spawnBlush,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'category',
            style: TextStyle(
              color: spawnBlush,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            'role',
            style: TextStyle(
              color: spawnBlush,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            'note',
            style: TextStyle(
              color: spawnBlush,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    ),
  ));
  for (int i = 0; i < compareRows.length; i = i + 1) {
    final List<String> r = compareRows[i];
    final Color stripe = (i % 2 == 0) ? forestDeep : forestMid;
    compareWidgets.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: stripe,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              r[0],
              style: TextStyle(
                color: spawnBlush,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              r[1],
              style: TextStyle(color: paperWarm, fontSize: 11),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              r[2],
              style: TextStyle(color: paperBone, fontSize: 11.5, height: 1.35),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              r[3],
              style: TextStyle(color: cautionMustard, fontSize: 11.5, height: 1.35),
            ),
          ),
        ],
      ),
    ));
  }

  // Sequence diagram.
  final List<Widget> sequenceWidgets = <Widget>[];
  for (int i = 0; i < sequenceRows.length; i = i + 1) {
    final List<String> step = sequenceRows[i];
    final bool isMain = step[1].trim() == 'main';
    final Color sideColor = isMain ? rootEmerald : bgTeal;
    sequenceWidgets.add(Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: forestDeep,
        borderRadius: BorderRadius.circular(4),
        border: Border(
          left: BorderSide(color: sideColor, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 28,
            alignment: Alignment.center,
            child: Text(
              step[0],
              style: TextStyle(
                color: tokenAmber,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: sideColor.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              step[1],
              style: TextStyle(
                color: sideColor,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              step[2],
              style: TextStyle(
                color: paperBone,
                fontSize: 11.5,
                fontFamily: 'monospace',
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  // Pitfalls.
  final List<Widget> pitfallWidgets = <Widget>[];
  for (int i = 0; i < pitfallRows.length; i = i + 1) {
    final List<String> p = pitfallRows[i];
    pitfallWidgets.add(Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: forestNight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: warningRust.withValues(alpha: 0.6), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: warningRust,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '!',
                  style: TextStyle(
                    color: paperBone,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  p[0],
                  style: TextStyle(
                    color: paperBone,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'symptom: ${p[1]}',
            style: TextStyle(color: cautionMustard, fontSize: 11.5, height: 1.35),
          ),
          const SizedBox(height: 2),
          Text(
            'fix: ${p[2]}',
            style: TextStyle(color: rootMint, fontSize: 11.5, height: 1.35),
          ),
        ],
      ),
    ));
  }

  // Glossary.
  final List<Widget> glossaryWidgets = <Widget>[];
  for (int i = 0; i < glossary.length; i = i + 1) {
    final List<String> g = glossary[i];
    final Color stripe = (i % 2 == 0) ? forestDeep : forestMid;
    glossaryWidgets.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: stripe,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              g[0],
              style: TextStyle(
                color: tokenGlow,
                fontWeight: FontWeight.w800,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              g[1],
              style: TextStyle(color: paperBone, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    ));
  }

  // Decision flowchart.
  final List<Widget> decisionWidgets = <Widget>[];
  for (int i = 0; i < decisionRows.length; i = i + 1) {
    final List<String> d = decisionRows[i];
    decisionWidgets.add(Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: forestDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: bgTeal.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bgTealDeep,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: bgTeal, width: 2),
            ),
            child: Text(
              d[0],
              style: TextStyle(
                color: paperBone,
                fontWeight: FontWeight.w900,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  d[1],
                  style: TextStyle(
                    color: paperBone,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  d[2],
                  style: TextStyle(
                    color: paperWarm,
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // Lifecycle bars.
  final List<Widget> lifecycleWidgets = <Widget>[];
  for (int i = 0; i < lifecycleBars.length; i = i + 1) {
    final List<dynamic> bar = lifecycleBars[i];
    final String label = bar[0] as String;
    final double weight = bar[1] as double;
    final Color color = bar[2] as Color;
    final String desc = bar[3] as String;
    lifecycleWidgets.add(Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: forestNight,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: weight * 3.0 > 1.0 ? 1.0 : weight * 3.0,
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 220,
            child: Text(
              desc,
              style: TextStyle(color: paperWarm, fontSize: 10.5),
            ),
          ),
        ],
      ),
    ));
  }

  // Snippet.
  final List<Widget> snippetWidgets = <Widget>[];
  for (int i = 0; i < snippetLines.length; i = i + 1) {
    final String line = snippetLines[i];
    final bool isComment = line.trim().startsWith('//');
    final bool isImport = line.trim().startsWith('import');
    Color lineColor;
    if (isComment) {
      lineColor = paperWarm.withValues(alpha: 0.7);
    } else if (isImport) {
      lineColor = spawnBlush;
    } else {
      lineColor = paperBone;
    }
    snippetWidgets.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 28,
          child: Text(
            '${i + 1}',
            style: TextStyle(
              color: tokenAmber.withValues(alpha: 0.6),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            line.isEmpty ? ' ' : line,
            style: TextStyle(
              color: lineColor,
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ));
  }

  // ---------------------------------------------------------------------------
  // PROSE BLOCKS — long-form essays explaining the *why*.
  // ---------------------------------------------------------------------------

  Widget proseBlock(String body, Color side) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: forestDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border(
          left: BorderSide(color: side, width: 3),
        ),
      ),
      child: Text(
        body,
        style: TextStyle(
          color: paperBone,
          fontSize: 12.5,
          height: 1.55,
        ),
      ),
    );
  }

  final String proseWhyTokenExists =
      'Flutter\'s engine starts a single root isolate. That isolate owns a '
      'BinaryMessenger that, in turn, owns the platform-channel pipes — the '
      'invisible cables that carry method calls, event streams, and standard '
      'codec messages between your Dart code and the host platform. When you '
      'spawn another isolate using Isolate.spawn, you get a fresh heap and a '
      'fresh event loop, but you do NOT automatically get a BinaryMessenger '
      'that knows how to find the host. The new isolate can crunch numbers, '
      'parse JSON, and shuffle bytes around all day, but the moment it tries '
      'to call MethodChannel.invokeMethod or send an event over an '
      'EventChannel, it has nowhere to send the bytes. RootIsolateToken is '
      'the bridge. It is a cheap, opaque, Sendable handle whose only job is '
      'to identify the root isolate so a child isolate can hand it back to '
      'BackgroundIsolateBinaryMessenger.ensureInitialized and say "please '
      'wire me up to that one". The result is a per-isolate BinaryMessenger '
      'that proxies to the root isolate\'s real one.';

  final String proseHowToUse =
      'In practice, the pattern is: capture RootIsolateToken.instance on the '
      'root isolate, then send it as part of the spawn payload. The first '
      'thing the entry point does — before importing any plugin code, before '
      'creating any MethodChannel, before logging anything that might route '
      'through a plugin sink — is call '
      'BackgroundIsolateBinaryMessenger.ensureInitialized(token). After that '
      'call, you may use MethodChannel.invokeMethod on the isolate exactly '
      'as you would on the root. The binding is sticky for the lifetime of '
      'that isolate, so you only need to do it once.';

  final String proseWhatNotToDo =
      'Do NOT call ensureInitialized on the root isolate itself — it is a '
      'StateError because the messenger is already wired. Do NOT cache a '
      'BinaryMessenger reference and pass it across isolate boundaries; the '
      'messenger is per-isolate and not Sendable in any meaningful way. Do '
      'NOT assume compute() handles the token for you; it does not, and '
      'plugin calls inside a compute callback will misbehave. Do NOT spawn '
      'an isolate before runApp; the engine\'s root isolate may not be in a '
      'state where RootIsolateToken.instance is non-null.';

  final String proseWhenToReachForIt =
      'You only need RootIsolateToken when you have a *background* isolate '
      'that wants to talk to the *host platform*. A worker that just hashes '
      'bytes does not need it; a worker that calls path_provider, sqflite, '
      'shared_preferences, secure_storage, or any other plugin DOES. The '
      'rule of thumb: if your worker imports anything from package:flutter '
      'that ultimately routes through a MethodChannel, bind the token. If '
      'it doesn\'t, save yourself the ceremony.';

  final String proseSandboxNote =
      'In sandboxed environments — like the d4rt interpreter that hosts '
      'this demo — RootIsolateToken.instance may return a real token, may '
      'return null, or may throw, depending on how the sandbox proxies '
      'dart:ui. The visual probe on the hero card shows what actually '
      'happened on this run. The accompanying ensureInitialized line is '
      'never executed against the live sandbox: doing so on the root '
      'isolate is forbidden, and the sandbox does not let us spawn a real '
      'background isolate to call it on. Treat the rest of this page as a '
      'visual textbook rather than a live demo.';

  // ---------------------------------------------------------------------------
  // FOOTER
  // ---------------------------------------------------------------------------
  Widget footer() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: forestNight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tokenAmber.withValues(alpha: 0.45), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Isolate Forest // dart:ui RootIsolateToken visual essay',
            style: TextStyle(
              color: tokenGlow,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'A Sendable handle is the difference between a chatty plugin and a silent one.',
            style: TextStyle(
              color: paperWarm,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            children: <Widget>[
              pill('RootIsolateToken', tokenAmber, forestNight),
              pill('BackgroundIsolateBinaryMessenger', bgTeal, forestNight),
              pill('Isolate.spawn', spawnMagenta, paperBone),
              pill('SendPort', rootEmerald, forestNight),
              pill('platform channel', spawnBlush, forestNight),
              pill('Sendable', tokenGlow, forestNight),
              pill('worker pool', bgTealDeep, paperBone),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FINAL TREE
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: forestNight,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // --------------- HERO ---------------
            heroCard(),

            // --------------- 01 PALETTE ---------------
            sectionHeader(
              '01',
              'Palette',
              'Isolate Forest — moss, ember-amber, magenta spawn flares.',
              tokenAmber,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: forestNight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: shadowMoss, width: 1),
              ),
              child: Column(children: swatchWidgets),
            ),

            // --------------- 02 API SURFACE ---------------
            sectionHeader(
              '02',
              'API Surface',
              'The handful of symbols you actually touch.',
              spawnMagenta,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: shadowMoss, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Column(children: apiWidgets),
              ),
            ),

            // --------------- 03 WHY THE TOKEN EXISTS ---------------
            sectionHeader(
              '03',
              'Why the token exists',
              'Background isolates have no BinaryMessenger by default.',
              rootEmerald,
            ),
            proseBlock(proseWhyTokenExists, rootEmerald),
            proseBlock(proseHowToUse, bgTeal),
            proseBlock(proseWhatNotToDo, warningRust),
            proseBlock(proseWhenToReachForIt, tokenAmber),
            proseBlock(proseSandboxNote, cautionMustard),

            // --------------- 04 ASCII DIAGRAM ---------------
            sectionHeader(
              '04',
              'Isolate relationship',
              'A tiny ASCII map of who-talks-to-whom.',
              tokenGlow,
            ),
            asciiBox(asciiDiagram, paperBone),

            // --------------- 05 SCENARIOS ---------------
            sectionHeader(
              '05',
              'Scenario panels',
              'Real-world reasons to spawn a background isolate.',
              bgTeal,
            ),
            Column(children: scenarioWidgets),

            // --------------- 06 COMPARISON ---------------
            sectionHeader(
              '06',
              'Comparison',
              'RootIsolateToken vs Isolate.spawn vs compute() vs Worker pool.',
              spawnMagenta,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: shadowMoss, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Column(children: compareWidgets),
              ),
            ),

            // --------------- 07 SEQUENCE DIAGRAM ---------------
            sectionHeader(
              '07',
              'Sequence: spawn -> token -> ensureInitialized -> work',
              'Step-by-step trace of a healthy round trip.',
              rootMint,
            ),
            Column(children: sequenceWidgets),

            // --------------- 08 LIFECYCLE BARS ---------------
            sectionHeader(
              '08',
              'Lifecycle timeline',
              'A relative-cost view of an isolate session.',
              tokenAmber,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: forestDeep,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: shadowMoss, width: 1),
              ),
              child: Column(children: lifecycleWidgets),
            ),

            // --------------- 09 PITFALLS ---------------
            sectionHeader(
              '09',
              'Pitfalls',
              'Each one is a real bug somebody shipped.',
              warningRust,
            ),
            Column(children: pitfallWidgets),

            // --------------- 10 GLOSSARY ---------------
            sectionHeader(
              '10',
              'Glossary',
              'Vocabulary you\'ll meet around isolates.',
              tokenGlow,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: shadowMoss, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Column(children: glossaryWidgets),
              ),
            ),

            // --------------- 11 DECISION FLOWCHART ---------------
            sectionHeader(
              '11',
              'Decision flowchart',
              'Pick the right concurrency tool in five questions.',
              bgTeal,
            ),
            Column(children: decisionWidgets),

            // --------------- 12 CODE SNIPPET ---------------
            sectionHeader(
              '12',
              'Code snippet',
              'A canonical spawn-with-token example, line-numbered.',
              spawnMagenta,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: forestNight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: tokenAmber.withValues(alpha: 0.45), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snippetWidgets,
              ),
            ),

            // --------------- FOOTER ---------------
            footer(),
          ],
        ),
      ),
    ),
  );
}
