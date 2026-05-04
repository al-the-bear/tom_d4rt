// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for ImageChunkEvent from painting
// Demonstrates progress events emitted during image decoding/network loading.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageChunkEvent Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.cyan.shade700,
          Colors.blue.shade700,
          Colors.indigo.shade700,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.image_search, size: 56.0, color: Colors.white),
        SizedBox(height: 8.0),
        Text(
          'ImageChunkEvent',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Progress events while images decode',
          style: TextStyle(fontSize: 16.0, color: Colors.white70),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'package:flutter/painting.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title banner ready');

  // ============================================================
  // SECTION 2: Anatomy: 2-field box
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyBox = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.cyan.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Class Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _anatomyField(
          'cumulativeBytesLoaded',
          'int',
          'Bytes downloaded so far. Monotonic non-negative.',
          Colors.cyan.shade700,
        ),
        SizedBox(height: 10.0),
        _anatomyField(
          'expectedTotalBytes',
          'int?',
          'Total size if known. Null when server omits Content-Length.',
          Colors.blue.shade700,
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ImageChunkEvent({\n'
            '  required int cumulativeBytesLoaded,\n'
            '  required int? expectedTotalBytes,\n'
            '})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyan.shade200,
            ),
          ),
        ),
      ],
    ),
  );
  print('Anatomy box ready');

  // ============================================================
  // SECTION 3: Progress timeline (5 ImageChunkEvent instances)
  // ============================================================
  print('=== Section 3: Progress Timeline ===');

  final timelineEvents = <ImageChunkEvent>[
    ImageChunkEvent(cumulativeBytesLoaded: 10000, expectedTotalBytes: 100000),
    ImageChunkEvent(cumulativeBytesLoaded: 50000, expectedTotalBytes: 100000),
    ImageChunkEvent(cumulativeBytesLoaded: 100000, expectedTotalBytes: 100000),
    ImageChunkEvent(cumulativeBytesLoaded: 200000, expectedTotalBytes: null),
    ImageChunkEvent(cumulativeBytesLoaded: 0, expectedTotalBytes: null),
  ];

  final timelineCards = <Widget>[];
  for (var i = 0; i < timelineEvents.length; i = i + 1) {
    final ev = timelineEvents[i];
    final loaded = ev.cumulativeBytesLoaded;
    final total = ev.expectedTotalBytes;
    final hasTotal = total != null;
    final fraction = hasTotal && total > 0 ? loaded / total : 0.0;
    final pct = hasTotal ? '${(fraction * 100).toStringAsFixed(0)}%' : '--';
    print(
      'Timeline[$i] loaded=$loaded total=$total fraction=${fraction.toStringAsFixed(3)}',
    );

    timelineCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan.shade50,
              hasTotal ? Colors.blue.shade50 : Colors.amber.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: hasTotal ? Colors.cyan.shade300 : Colors.amber.shade400,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (hasTotal ? Colors.cyan : Colors.amber).withValues(
                alpha: 0.2,
              ),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade700,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'tick #${i + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'cumulative=$loaded',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'expected=${hasTotal ? total : 'null'}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                Spacer(),
                Text(
                  pct,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: hasTotal
                        ? Colors.cyan.shade900
                        : Colors.amber.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: LinearProgressIndicator(
                value: hasTotal ? fraction.clamp(0.0, 1.0) : null,
                minHeight: 10.0,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  hasTotal ? Colors.cyan.shade600 : Colors.amber.shade700,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              hasTotal
                  ? 'Determinate: ratio = $loaded / $total'
                  : 'Indeterminate: total unknown, percentage unavailable',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.blueGrey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${timelineCards.length} timeline cards');

  // ============================================================
  // SECTION 4: Indeterminate vs Determinate
  // ============================================================
  print('=== Section 4: Indeterminate vs Determinate ===');

  final determinate = ImageChunkEvent(
    cumulativeBytesLoaded: 64000,
    expectedTotalBytes: 128000,
  );
  final indeterminate = ImageChunkEvent(
    cumulativeBytesLoaded: 64000,
    expectedTotalBytes: null,
  );
  print(
    'Determinate: ${determinate.cumulativeBytesLoaded}/${determinate.expectedTotalBytes}',
  );
  print(
    'Indeterminate: ${indeterminate.cumulativeBytesLoaded}/${indeterminate.expectedTotalBytes}',
  );

  final modeComparison = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: _modeCard(
          'Determinate',
          'expectedTotalBytes != null',
          determinate,
          Colors.cyan,
          Icons.percent,
          'Render a fractional bar. UI knows exact progress.',
        ),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: _modeCard(
          'Indeterminate',
          'expectedTotalBytes == null',
          indeterminate,
          Colors.amber,
          Icons.help_outline,
          'No total. Show spinner or pulsing bar.',
        ),
      ),
    ],
  );
  print('Mode comparison ready');

  // ============================================================
  // SECTION 5: loadingBuilder callback signature
  // ============================================================
  print('=== Section 5: loadingBuilder Signature ===');

  final signatureBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.3),
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
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'loadingBuilder signature',
              style: TextStyle(
                color: Colors.cyan.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _codeLine(
          'Image.network(\n'
          '  url,\n'
          '  loadingBuilder: (BuildContext ctx, Widget child,\n'
          '      ImageChunkEvent? progress) {\n'
          '    if (progress == null) return child;\n'
          '    final total = progress.expectedTotalBytes;\n'
          '    return LinearProgressIndicator(\n'
          '      value: total != null\n'
          '          ? progress.cumulativeBytesLoaded / total\n'
          '          : null,\n'
          '    );\n'
          '  },\n'
          ');',
          Colors.cyan.shade100,
        ),
        SizedBox(height: 14.0),
        _step('1', 'progress is null on first frame before bytes start.'),
        _step('2', 'Return child once decoded; the framework swaps it in.'),
        _step('3', 'expectedTotalBytes can be null — branch accordingly.'),
        _step('4', 'Cumulative bytes is monotonically non-decreasing.'),
        _step('5', 'Builder runs on the UI isolate; keep it cheap.'),
      ],
    ),
  );
  print('Signature block ready');

  // ============================================================
  // SECTION 6: Real-world mock with fake progress (4 cards)
  // ============================================================
  print('=== Section 6: Real-world mock ===');

  final mockProgresses = <double>[0.0, 0.25, 0.75, 1.0];
  final mockCards = <Widget>[];
  for (var i = 0; i < mockProgresses.length; i = i + 1) {
    final p = mockProgresses[i];
    final loaded = (p * 240000).round();
    final ev = ImageChunkEvent(
      cumulativeBytesLoaded: loaded,
      expectedTotalBytes: 240000,
    );
    print('Mock[$i] p=$p loaded=${ev.cumulativeBytesLoaded}');

    mockCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.cyan.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.cyan.shade400, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: SizedBox(
                  width: 44.0,
                  height: 44.0,
                  child: CircularProgressIndicator(
                    value: p < 1.0 ? p : null,
                    strokeWidth: 5.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.cyan.shade700,
                    ),
                    backgroundColor: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              p < 1.0 ? 'Loading…' : 'Decoded',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Colors.cyan.shade900,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              '${ev.cumulativeBytesLoaded} / ${ev.expectedTotalBytes}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.blueGrey.shade800,
              ),
            ),
            SizedBox(height: 6.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: LinearProgressIndicator(
                value: p,
                minHeight: 6.0,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.cyan.shade600,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              '${(p * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.cyan.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${mockCards.length} mock cards');

  // ============================================================
  // SECTION 7: Comparison vs Stream<List<int>>
  // ============================================================
  print('=== Section 7: Comparison ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
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
            Icon(Icons.compare_arrows, color: Colors.teal.shade800),
            SizedBox(width: 8.0),
            Text(
              'ImageChunkEvent vs Stream<List<int>>',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              _hdr('Aspect', 110.0),
              _hdr('ImageChunkEvent', 140.0),
              _hdr('Stream<List<int>>', 150.0),
            ],
          ),
        ),
        _row('Layer', 'Image decoder', 'HTTP body bytes', Colors.teal),
        _row('Granularity', 'Decoded chunks', 'Network packets', Colors.cyan),
        _row(
          'Total known?',
          'maybe (nullable)',
          'Content-Length header',
          Colors.blue,
        ),
        _row(
          'Carries pixels?',
          'No, byte counts only',
          'No, raw bytes',
          Colors.indigo,
        ),
        _row('Fired on', 'UI isolate', 'IO isolate / await', Colors.purple),
      ],
    ),
  );
  print('Comparison table ready');

  // ============================================================
  // SECTION 8: Memory — bytes loaded != pixel memory
  // ============================================================
  print('=== Section 8: Memory ===');

  final memoryBox = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.18),
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
            Icon(Icons.memory, color: Colors.deepPurple.shade700),
            SizedBox(width: 8.0),
            Text(
              'Bytes loaded ≠ pixel memory',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _bullet(
          'cumulativeBytesLoaded counts the *encoded* payload (PNG, JPG, WebP).',
        ),
        _bullet(
          'After decode, pixels live in RAM at width × height × 4 bytes (RGBA8).',
        ),
        _bullet(
          'A 200KB JPEG can decode into 4096×4096×4 ≈ 64MB of pixel memory.',
        ),
        _bullet(
          'ImageChunkEvent never reports pixel-buffer size; only download progress.',
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Encoded',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Container(
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade400,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '~200 KB',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Icon(
                Icons.arrow_forward,
                color: Colors.deepPurple.shade700,
                size: 22.0,
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      'Decoded RGBA8',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Container(
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade600,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '~64 MB (4096×4096×4)',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900,
                      ),
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
  print('Memory box ready');

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final footgunBox = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
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
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade700),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _footgun(
          'cumulativeBytesLoaded > expectedTotalBytes is legal',
          'Transcoding/repacking can cause overshoot. Always clamp to 1.0.',
        ),
        _footgun(
          'expectedTotalBytes can be null',
          'Server omits Content-Length, or transfer-encoding is chunked. '
              'Plan an indeterminate UI branch.',
        ),
        _footgun(
          'Builder runs on the UI thread',
          'Avoid heavy work in loadingBuilder. No I/O, no JSON parsing, '
              'no allocating big lists.',
        ),
        _footgun(
          'progress can be null on the first frame',
          'Before the first chunk arrives the builder receives null. '
              'Return child early.',
        ),
        _footgun(
          'Bytes are encoded payload, not pixel memory',
          'A 1% download bar does not mean 1% of RAM is used. See section 8.',
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'final total = ev.expectedTotalBytes;\n'
            'final value = total != null && total > 0\n'
            '  ? (ev.cumulativeBytesLoaded / total).clamp(0.0, 1.0)\n'
            '  : null;',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.orange.shade200,
            ),
          ),
        ),
      ],
    ),
  );
  print('Footgun box ready');

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');

  final recapEvent = ImageChunkEvent(
    cumulativeBytesLoaded: 75000,
    expectedTotalBytes: 100000,
  );
  print('Recap event: ${recapEvent.toString()}');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.cyan.shade600,
          Colors.blue.shade700,
          Colors.indigo.shade800,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.35),
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
        _recapBullet('Two fields: cumulativeBytesLoaded + expectedTotalBytes.'),
        _recapBullet('Total may be null — handle indeterminate UI.'),
        _recapBullet(
          'Surfaced via Image.network(loadingBuilder:) and ImageStreamCompleter.onChunk.',
        ),
        _recapBullet('Bytes are encoded; pixel memory is much larger.'),
        _recapBullet('Builder runs UI-thread; keep it lean.'),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample event:',
                style: TextStyle(color: Colors.cyan.shade100, fontSize: 12.0),
              ),
              SizedBox(height: 4.0),
              Text(
                'cumulativeBytesLoaded = ${recapEvent.cumulativeBytesLoaded}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'expectedTotalBytes   = ${recapEvent.expectedTotalBytes}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'progress             = '
                '${((recapEvent.cumulativeBytesLoaded / recapEvent.expectedTotalBytes!) * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.cyan.shade100,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Recap card ready');

  print('ImageChunkEvent Deep Demo completed successfully');

  // ============================================================
  // Final assembly
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.blueGrey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _sectionHeading('1. Anatomy', Icons.account_tree),
          anatomyBox,
          SizedBox(height: 24.0),
          _sectionHeading('2. Progress timeline', Icons.timeline),
          ...timelineCards,
          SizedBox(height: 24.0),
          _sectionHeading('3. Determinate vs Indeterminate', Icons.tune),
          modeComparison,
          SizedBox(height: 24.0),
          _sectionHeading('4. loadingBuilder signature', Icons.code),
          signatureBlock,
          SizedBox(height: 24.0),
          _sectionHeading('5. Real-world mock', Icons.cloud_download),
          Wrap(alignment: WrapAlignment.center, children: mockCards),
          SizedBox(height: 24.0),
          _sectionHeading('6. ImageChunkEvent vs Stream<List<int>>',
              Icons.compare_arrows),
          comparisonTable,
          SizedBox(height: 24.0),
          _sectionHeading('7. Memory model', Icons.memory),
          memoryBox,
          SizedBox(height: 24.0),
          _sectionHeading('8. Footguns', Icons.warning_amber_rounded),
          footgunBox,
          SizedBox(height: 24.0),
          _sectionHeading('9. Recap', Icons.summarize),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionHeading(String text, IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: Colors.cyan.shade700, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.cyan.shade800, size: 22.0),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyField(
  String name,
  String type,
  String description,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.blueGrey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _modeCard(
  String title,
  String subtitle,
  ImageChunkEvent ev,
  MaterialColor swatch,
  IconData icon,
  String hint,
) {
  final hasTotal = ev.expectedTotalBytes != null;
  final fraction = hasTotal && ev.expectedTotalBytes! > 0
      ? ev.cumulativeBytesLoaded / ev.expectedTotalBytes!
      : 0.0;
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [swatch.shade50, swatch.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: swatch.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: swatch.withValues(alpha: 0.18),
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
            Icon(icon, color: swatch.shade800, size: 22.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: swatch.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: swatch.shade800,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'cumulative=${ev.cumulativeBytesLoaded}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.blueGrey.shade800,
          ),
        ),
        Text(
          'expected=${ev.expectedTotalBytes}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 10.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: LinearProgressIndicator(
            value: hasTotal ? fraction.clamp(0.0, 1.0) : null,
            minHeight: 8.0,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(swatch.shade700),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          hint,
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: swatch.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _codeLine(String code, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: color,
        height: 1.4,
      ),
    ),
  );
}

Widget _step(String n, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22.0,
          height: 22.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.cyan.shade400,
            shape: BoxShape.circle,
          ),
          child: Text(
            n,
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.cyan.shade100,
              fontSize: 12.5,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _hdr(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.teal.shade900,
      ),
    ),
  );
}

Widget _row(String aspect, String chunk, String stream, MaterialColor swatch) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.teal.shade100, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            aspect,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: swatch.shade900,
            ),
          ),
        ),
        SizedBox(
          width: 140.0,
          child: Text(
            chunk,
            style: TextStyle(fontSize: 11.5, color: Colors.blueGrey.shade800),
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            stream,
            style: TextStyle(fontSize: 11.5, color: Colors.blueGrey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.0, right: 8.0),
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade400,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.deepPurple.shade900,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _footgun(String title, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.0, right: 8.0),
          child: Icon(
            Icons.error_outline,
            color: Colors.red.shade700,
            size: 18.0,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.blueGrey.shade800,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.0, right: 8.0),
          child: Icon(Icons.check_circle, color: Colors.cyan.shade100, size: 14.0),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}
