// ignore_for_file: avoid_print
// D4rt deep demo: BackgroundIsolateBinaryMessenger — enables platform channel
// communication from background Dart isolates, which normally cannot access
// the root isolate's binary messenger.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Slate / Graphite palette ───
  const Color slate = Color(0xFF708090);
  const Color graphite = Color(0xFF4A4A4A);
  const Color charcoal = Color(0xFF36454F);
  const Color paleSlate = Color(0xFFEEF0F2);
  const Color deepGraphite = Color(0xFF2C2C2C);
  const Color silver = Color(0xFFC0C0C0);
  const Color gunmetal = Color(0xFF2A3439);
  const Color flint = Color(0xFF686C6E);
  const Color ash = Color(0xFFB2BEB5);
  const Color smoke = Color(0xFFF5F5F5);

  print('[bg] ===== BACKGROUND ISOLATE BINARY MESSENGER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget bgBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gunmetal, charcoal],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: gunmetal.withValues(alpha: 0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: deepGraphite,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: silver, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget bgNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: smoke,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ash.withValues(alpha: 0.5)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: charcoal.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget bgCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: paleSlate.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: slate, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: charcoal,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: graphite)),
          ),
        ],
      ),
    );
  }

  Widget bgCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ash.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: charcoal.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: slate.withValues(alpha: 0.07),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: charcoal)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget bgRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? slate.withValues(alpha: 0.07) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: ash.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? charcoal : graphite)),
          );
        }).toList(),
      ),
    );
  }

  Widget bgFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? charcoal : slate,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.east, size: 12, color: silver),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  Widget bgIsolateBox(String label, Color color, {bool isRoot = false}) {
    return Container(
      width: double.infinity,
      height: 44,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isRoot ? const Color(0xFF4CAF50) : color.withValues(alpha: 0.6),
          width: isRoot ? 2 : 1,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isRoot) ...[
              const Icon(Icons.star, size: 12, color: Colors.white),
              const SizedBox(width: 4),
            ],
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color.computeLuminance() > 0.5
                        ? charcoal
                        : Colors.white)),
          ],
        ),
      ),
    );
  }

  // ━━━━━━ SECTION 1: What is BackgroundIsolateBinaryMessenger? ━━━━━━
  print('[bg-01] Section 1: What is it?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('01', 'What Is BackgroundIsolateBinaryMessenger?'),
      bgNote(
        'BackgroundIsolateBinaryMessenger allows background Dart isolates to '
        'communicate with platform code (Android/iOS native) through binary '
        'messages. Normally only the root isolate (the main UI isolate) can '
        'use platform channels. This class bridges that gap by routing '
        'messages from background isolates through the root isolate\'s '
        'binary messenger.',
      ),
      bgCard(
        'The Isolate Communication Problem',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bgIsolateBox('Root Isolate (UI) — has BinaryMessenger ✓',
                slate.withValues(alpha: 0.15), isRoot: true),
            bgIsolateBox('Background Isolate A — NO BinaryMessenger ✗',
                const Color(0xFFFFCDD2)),
            bgIsolateBox('Background Isolate B — NO BinaryMessenger ✗',
                const Color(0xFFFFCDD2)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb, size: 14, color: Color(0xFF4CAF50)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'BackgroundIsolateBinaryMessenger solves this by '
                      'providing a BinaryMessenger instance for background isolates.',
                      style: TextStyle(fontSize: 11, color: charcoal),
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

  // ━━━━━━ SECTION 2: The root isolate constraint ━━━━━━
  print('[bg-02] Section 2: Root isolate constraint');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('02', 'Why Only the Root Isolate?'),
      bgNote(
        'Flutter\'s engine binds platform channels to the root isolate '
        'because that\'s where the framework event loop runs. Platform '
        'messages arrive via C++ engine callbacks, which are wired to the '
        'main Dart isolate. Background isolates have no engine binding.',
      ),
      bgCard(
        'Engine Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: slate.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: slate.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.memory, size: 20, color: charcoal),
                        const SizedBox(height: 4),
                        Text('Flutter Engine',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: charcoal)),
                        const SizedBox(height: 6),
                        Text('C++ layer binds platform channels to exactly '
                            'one Dart isolate — the root.',
                            style: TextStyle(fontSize: 10, color: graphite),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: gunmetal.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: gunmetal.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.account_tree, size: 20, color: slate),
                        const SizedBox(height: 4),
                        Text('Background Isolate',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: slate)),
                        const SizedBox(height: 6),
                        Text('Has no engine binding. Cannot directly call '
                            'MethodChannel.invokeMethod.',
                            style: TextStyle(fontSize: 10, color: graphite),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Initialization ━━━━━━
  print('[bg-03] Section 3: Initialization');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('03', 'Initialization Protocol'),
      bgNote(
        'Before using platform channels from a background isolate, you must '
        'call BackgroundIsolateBinaryMessenger.ensureInitialized() with the '
        'root isolate\'s token. This token is obtained via '
        'RootIsolateToken.instance on the root isolate and passed to the '
        'background isolate via its entry point.',
      ),
      bgCard(
        'Initialization Sequence',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bgStepItem(1, 'Root: Get token',
                'RootIsolateToken.instance! → passes to spawn',
                slate),
            _bgStepItem(2, 'Spawn isolate',
                'Isolate.spawn(entryPoint, token)',
                graphite),
            _bgStepItem(3, 'Background: Initialize',
                'BackgroundIsolateBinaryMessenger.ensureInitialized(token)',
                flint),
            _bgStepItem(4, 'Ready',
                'Platform channels now available in background isolate',
                charcoal),
          ],
        ),
      ),
      bgCard(
        'Code Pattern',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleSlate,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('// Root isolate:',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: flint)),
              Text('final token = RootIsolateToken.instance!;',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: charcoal)),
              Text('Isolate.spawn(bgEntry, token);',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: charcoal)),
              const SizedBox(height: 8),
              Text('// Background isolate entry:',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: flint)),
              Text('void bgEntry(RootIsolateToken token) {',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: charcoal)),
              Text('  BackgroundIsolateBinaryMessenger',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: charcoal)),
              Text('    .ensureInitialized(token);',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: charcoal)),
              Text('  // Now use MethodChannel, etc.',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: flint)),
              Text('}',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: charcoal)),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Message routing ━━━━━━
  print('[bg-04] Section 4: Message routing');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('04', 'Message Routing Architecture'),
      bgNote(
        'Messages from the background isolate are forwarded to the root '
        'isolate\'s engine binding, then to the platform. Responses travel '
        'the reverse path. This is transparent — the background isolate uses '
        'the same MethodChannel/BasicMessageChannel API as the root.',
      ),
      bgCard(
        'Routing Diagram',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bgFlow([
              'BG Isolate',
              'BinaryMessenger',
              'Root Isolate',
              'Engine',
              'Platform',
            ]),
            const SizedBox(height: 12),
            bgRow(['Hop', 'Transport', 'Overhead'], isHeader: true),
            bgRow(['BG → Root', 'Dart SendPort', 'Inter-isolate copy']),
            bgRow(['Root → Engine', 'Native binding', 'C++ call']),
            bgRow(['Engine → Platform', 'JNI / ObjC', 'Platform bridge']),
            bgRow(['Response', 'Reverse path', 'Same hops back']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: BinaryMessenger interface ━━━━━━
  print('[bg-05] Section 5: BinaryMessenger interface');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('05', 'BinaryMessenger Interface'),
      bgNote(
        'BackgroundIsolateBinaryMessenger implements BinaryMessenger, the same '
        'interface that ServicesBinding.defaultBinaryMessenger provides on the '
        'root isolate. This means all channel types work transparently.',
      ),
      bgCard(
        'BinaryMessenger Contract',
        Column(
          children: [
            bgRow(['Method', 'Signature', 'Purpose'], isHeader: true),
            bgRow(['send', 'Future<ByteData?> send(String, ByteData?)',
                'Send a message']),
            bgRow(['setMessageHandler', 'void set…(String, handler)',
                'Listen for messages']),
            bgRow(['handlePlatformMessage', 'Future handle…(…)',
                'Process incoming']),
          ],
        ),
      ),
      bgCard(
        'Channel Types That Work',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bgChannelChip('MethodChannel', 'Method calls with JSON/Standard codec', slate),
            _bgChannelChip('BasicMessageChannel', 'Simple typed messages', graphite),
            _bgChannelChip('EventChannel', 'Streams from platform', flint),
            _bgChannelChip('OptionalMethodChannel', 'Nullable method calls', charcoal),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Use case — image processing ━━━━━━
  print('[bg-06] Section 6: Image processing use case');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('06', 'Use Case: Heavy Image Processing'),
      bgNote(
        'A background isolate processes images (resize, filter, compress) '
        'then needs to save using a native file system API. The '
        'BackgroundIsolateBinaryMessenger lets it call a platform channel '
        'to write to a secure directory or use native image codecs.',
      ),
      bgCard(
        'Image Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bgFlow(['Load image', 'Spawn isolate', 'Init messenger',
                'Process', 'Save via channel']),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _bgUseCasePanel('Root Isolate',
                      'Coordinates UI updates\nShows progress spinner',
                      Icons.phone_android, slate),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _bgUseCasePanel('Background Isolate',
                      'Resizes, filters, encodes\nCalls native save API',
                      Icons.image, charcoal),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Use case — database operations ━━━━━━
  print('[bg-07] Section 7: Database use case');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('07', 'Use Case: Background Database Access'),
      bgNote(
        'SQLite or platform-specific database access from a background '
        'isolate. The isolate performs heavy queries (aggregations, '
        'migrations) while the UI stays responsive. Platform channels '
        'access native database engine features.',
      ),
      bgCard(
        'Database Isolate Pattern',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: slate.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: slate.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.storage, size: 22, color: charcoal),
                        const SizedBox(height: 4),
                        Text('DB Isolate',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: charcoal)),
                        const SizedBox(height: 6),
                        _bgTaskChip('Heavy query', const Color(0xFF1565C0)),
                        _bgTaskChip('Bulk insert', const Color(0xFF2E7D32)),
                        _bgTaskChip('Migration', const Color(0xFFE65100)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: [
                      Icon(Icons.swap_horiz, size: 18, color: silver),
                      Text('channel',
                          style: TextStyle(fontSize: 8, color: flint)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: gunmetal.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: gunmetal.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.code, size: 22, color: slate),
                        const SizedBox(height: 4),
                        Text('Native DB',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: slate)),
                        const SizedBox(height: 6),
                        _bgTaskChip('SQLite native', const Color(0xFF546E7A)),
                        _bgTaskChip('Encryption', const Color(0xFF6D4C41)),
                        _bgTaskChip('WAL mode', const Color(0xFF37474F)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Use case — ML inference ━━━━━━
  print('[bg-08] Section 8: ML inference use case');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('08', 'Use Case: Machine Learning Inference'),
      bgNote(
        'ML models often need native accelerators (CoreML, TFLite). '
        'A background isolate preprocesses data, then calls the native '
        'ML runtime via platform channels using the background messenger.',
      ),
      bgCard(
        'ML Inference Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bgStepItem(1, 'Capture camera frame', 'CameraPlugin → root isolate', slate),
            _bgStepItem(2, 'Send to BG isolate', 'Raw bytes via SendPort', graphite),
            _bgStepItem(3, 'Pre-process', 'Resize, normalize, quantize', flint),
            _bgStepItem(4, 'Call native ML channel', 'Via BackgroundIsolateBinaryMessenger', charcoal),
            _bgStepItem(5, 'Get prediction', 'Model output returned', gunmetal),
            _bgStepItem(6, 'Send result to UI', 'Via SendPort back to root', deepGraphite),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: compute() comparison ━━━━━━
  print('[bg-09] Section 9: compute() comparison');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('09', 'Comparison: compute() vs Manual Isolate'),
      bgNote(
        'compute() is simpler but doesn\'t support platform channels. '
        'For tasks needing native API access, you must manually spawn '
        'an isolate and initialize BackgroundIsolateBinaryMessenger.',
      ),
      bgCard(
        'compute() vs Manual Isolate + Messenger',
        Column(
          children: [
            bgRow(['Feature', 'compute()', 'Manual + Messenger'], isHeader: true),
            bgRow(['Simplicity', 'Very easy', 'More setup']),
            bgRow(['Platform channels', 'No ✗', 'Yes ✓']),
            bgRow(['Persistent state', 'No (one-shot)', 'Yes (long-lived)']),
            bgRow(['Multiple tasks', 'One per call', 'Many on same isolate']),
            bgRow(['Plugin access', 'No', 'Yes (after init)']),
            bgRow(['Token passing', 'Not needed', 'RootIsolateToken required']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Error handling ━━━━━━
  print('[bg-10] Section 10: Error handling');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('10', 'Error Handling'),
      bgNote(
        'Platform channel calls from background isolates can fail for several '
        'reasons: messenger not initialized, channel not registered on the '
        'platform side, or serialization errors. All throw PlatformException '
        'or MissingPluginException.',
      ),
      bgCard(
        'Error Scenarios',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bgErrorItem('UninitializedError',
                'ensureInitialized() not called before channel use',
                Icons.error, const Color(0xFFD32F2F)),
            _bgErrorItem('MissingPluginException',
                'Plugin not registered on platform side for BG isolate',
                Icons.extension_off, const Color(0xFFE65100)),
            _bgErrorItem('PlatformException',
                'Native code threw an exception during execution',
                Icons.warning, const Color(0xFFF57F17)),
            _bgErrorItem('ArgumentError',
                'Sent non-serializable data through channel',
                Icons.dangerous, const Color(0xFF6D4C41)),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Performance ━━━━━━
  print('[bg-11] Section 11: Performance');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('11', 'Performance Characteristics'),
      bgNote(
        'Background messenger adds one extra hop: BG → Root → Platform '
        'instead of Root → Platform. The inter-isolate copy is the main '
        'overhead. For small payloads it\'s negligible; for large data, '
        'consider using TransferableTypedData to avoid copying.',
      ),
      bgCard(
        'Performance Comparison',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bgRow(['Path', 'Hops', 'Approx Latency'], isHeader: true),
            bgRow(['Root → Platform', '1', '~0.5ms']),
            bgRow(['BG → Root → Platform', '2', '~1-2ms small data']),
            bgRow(['BG → Root (large data)', '2', '~5-10ms with copy']),
            bgRow(['BG → Root (transferable)', '2', '~1-3ms zero-copy']),
          ],
        ),
      ),
      bgCard(
        'Optimization Tips',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bgCode('TransferableTypedData', 'Zero-copy for large byte arrays'),
            bgCode('Batch messages', 'Combine small calls into one'),
            bgCode('Cache on BG side', 'Avoid redundant platform calls'),
            bgCode('Keep isolate alive', 'Reuse instead of respawning'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Lifecycle management ━━━━━━
  print('[bg-12] Section 12: Lifecycle management');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('12', 'Isolate Lifecycle Management'),
      bgNote(
        'The background isolate should be properly managed: initialized once, '
        'kept alive for repeated tasks, and killed when no longer needed. '
        'The messenger is tied to the isolate\'s lifetime.',
      ),
      bgCard(
        'Lifecycle States',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bgFlow(['Spawn', 'Init messenger', 'Work', 'Work', 'Kill']),
            const SizedBox(height: 12),
            bgRow(['State', 'Messenger', 'Channels'], isHeader: true),
            bgRow(['Spawned', 'Not ready', 'Unavailable']),
            bgRow(['Initialized', 'Ready', 'Available']),
            bgRow(['Working', 'Active', 'In use']),
            bgRow(['Killed', 'Destroyed', 'Dead']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Plugin registration ━━━━━━
  print('[bg-13] Section 13: Plugin registration');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('13', 'Plugin Registration for Background Isolates'),
      bgNote(
        'Not all plugins support background isolate usage. The plugin must '
        'register its channel handler on the platform side for all isolates, '
        'not just the root. Some plugins have explicit background support.',
      ),
      bgCard(
        'Plugin Compatibility',
        Column(
          children: [
            bgRow(['Plugin Type', 'BG Support', 'Notes'], isHeader: true),
            bgRow(['PathProvider', 'Yes', 'File paths are static']),
            bgRow(['SharedPrefs', 'Yes', 'Read/write from any isolate']),
            bgRow(['Camera', 'Partial', 'Capture on root, process on BG']),
            bgRow(['URL Launcher', 'No', 'UI action, root only']),
            bgRow(['Custom plugin', 'If designed', 'Must register BG handler']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Security ━━━━━━
  print('[bg-14] Section 14: Security');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('14', 'Security Considerations'),
      bgNote(
        'The RootIsolateToken is a capability token — possessing it grants '
        'platform channel access. It should not be leaked to untrusted code '
        'or stored where third-party code could access it.',
      ),
      bgCard(
        'Security Guidelines',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bgSecurityItem('Token scope',
                'Only pass to isolates you control',
                Icons.vpn_key, slate),
            _bgSecurityItem('Channel validation',
                'Platform side should validate all messages',
                Icons.verified_user, graphite),
            _bgSecurityItem('Data isolation',
                'BG isolate has separate memory; cannot read UI state',
                Icons.lock, flint),
            _bgSecurityItem('No global access',
                'Token cannot be used to access arbitrary channels',
                Icons.block, charcoal),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing patterns ━━━━━━
  print('[bg-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('15', 'Testing Patterns'),
      bgNote(
        'Testing background isolate channel code requires special setup: '
        'either mock the messenger in unit tests or use integration tests '
        'that actually spawn isolates. The TestDefaultBinaryMessenger helps.',
      ),
      bgCard(
        'Testing Strategies',
        Column(
          children: [
            bgRow(['Level', 'Approach', 'What It Tests'], isHeader: true),
            bgRow(['Unit', 'Mock BinaryMessenger', 'Logic + serialization']),
            bgRow(['Integration', 'Real isolate + channel', 'Full path']),
            bgRow(['Widget', 'Not applicable', 'No UI in BG isolate']),
            bgRow(['E2E', 'Full app test', 'Real platform behavior']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[bg-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bgBanner('16', 'Summary Dashboard'),
      bgCard(
        'BackgroundIsolateBinaryMessenger — Complete',
        Column(
          children: [
            bgRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            bgRow(['What', 'S01', 'Platform channels from BG isolates']),
            bgRow(['Why needed', 'S02', 'Root isolate owns engine binding']),
            bgRow(['Init', 'S03', 'ensureInitialized(token)']),
            bgRow(['Routing', 'S04', 'BG → Root → Engine → Platform']),
            bgRow(['API', 'S05', 'Implements BinaryMessenger']),
            bgRow(['Images', 'S06', 'Process + native save']),
            bgRow(['Database', 'S07', 'Heavy queries off UI thread']),
            bgRow(['ML', 'S08', 'Native accelerator access']),
            bgRow(['vs compute', 'S09', 'compute has no channels']),
            bgRow(['Errors', 'S10', 'Uninit, Missing, Platform']),
            bgRow(['Performance', 'S11', 'Extra hop, TransferableData']),
            bgRow(['Lifecycle', 'S12', 'Spawn → init → work → kill']),
            bgRow(['Plugins', 'S13', 'Not all support BG']),
            bgRow(['Security', 'S14', 'Token is a capability']),
            bgRow(['Testing', 'S15', 'Mock messenger or integration']),
          ],
        ),
      ),
      bgCard(
        'Slate / Graphite Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bgColorSwatch('Slate', slate),
            _bgColorSwatch('Graphite', graphite),
            _bgColorSwatch('Charcoal', charcoal),
            _bgColorSwatch('Gunmetal', gunmetal),
            _bgColorSwatch('Silver', silver),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gunmetal, charcoal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('BackgroundIsolateBinaryMessenger — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From root isolate constraints through initialization, message '
              'routing, real-world use cases, performance, security, and testing '
              '— the full background isolate platform channel story.',
              style: TextStyle(color: ash, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[bg] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('BackgroundIsolateBinaryMessenger'),
        backgroundColor: gunmetal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF6F7F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _bgStepItem(int num, String phase, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phase,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF4A4A4A))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _bgChannelChip(String name, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(Icons.cable, size: 14, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF4A4A4A))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _bgUseCasePanel(String title, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(height: 4),
        Text(title,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color)),
        const SizedBox(height: 4),
        Text(desc,
            style: const TextStyle(fontSize: 10, color: Color(0xFF4A4A4A)),
            textAlign: TextAlign.center),
      ],
    ),
  );
}

Widget _bgTaskChip(String text, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 3),
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center),
  );
}

Widget _bgErrorItem(String title, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF4A4A4A))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _bgSecurityItem(String title, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF4A4A4A))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _bgColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
