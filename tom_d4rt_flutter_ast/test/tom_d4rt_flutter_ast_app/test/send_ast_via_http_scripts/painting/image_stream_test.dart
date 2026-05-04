// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for ImageStream from painting library.
// Walks through ImageStream / ImageStreamCompleter / ImageInfo /
// ImageStreamListener / ImageChunkEvent without actually subscribing to a
// real image. Most visuals come from teaching cards.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageStream Deep Demo executing');

  // ============================================================
  // Construct one real ImageStream (no listeners, no completer).
  // ============================================================
  final stream = ImageStream();
  print('Constructed ImageStream: ${stream.runtimeType}');
  print('Initial completer is null: ${stream.completer == null}');
  print('hashCode: ${stream.hashCode}');
  print('Key: ${stream.key.runtimeType}');

  // Theme palette: blue -> violet, evoking pixel data flowing through a pipe.
  final blueDeep = Color(0xFF1E3A8A);
  final blueMid = Color(0xFF3B82F6);
  final indigoMid = Color(0xFF6366F1);
  final violetMid = Color(0xFF8B5CF6);
  final violetDeep = Color(0xFF6D28D9);
  final cyanAccent = Color(0xFF22D3EE);
  final pinkAccent = Color(0xFFEC4899);
  final amberAccent = Color(0xFFF59E0B);
  final emeraldAccent = Color(0xFF10B981);
  final slateBg = Color(0xFF0F172A);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');
  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [blueDeep, indigoMid, violetMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: violetDeep.withValues(alpha: 0.55),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: blueDeep.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.image_outlined, size: 64.0, color: Colors.white),
        SizedBox(height: 12.0),
        Text(
          'ImageStream',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'package:flutter/painting.dart',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white70,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            'handle to async image decoding',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pill('addListener', cyanAccent),
            SizedBox(width: 8.0),
            _pill('removeListener', pinkAccent),
            SizedBox(width: 8.0),
            _pill('completer', amberAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy pipeline diagram
  // ============================================================
  print('=== Section 2: Anatomy pipeline ===');
  final anatomyDiagram = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoMid.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigoMid.withValues(alpha: 0.18),
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
            Icon(Icons.account_tree, color: indigoMid, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy: from provider to pixels',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: blueDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _pipeNode(
              'ImageProvider',
              'NetworkImage\nAssetImage\nMemoryImage',
              Icons.cloud_download,
              blueMid,
            ),
            _pipeArrow('resolve(config)'),
            _pipeNode(
              'ImageStream',
              'public handle\nlisteners list',
              Icons.stream,
              indigoMid,
            ),
            _pipeArrow('setCompleter'),
            _pipeNode(
              'Completer',
              'decodes bytes\nemits frames',
              Icons.memory,
              violetMid,
            ),
            _pipeArrow('reportImage'),
            _pipeNode(
              'Listeners',
              'onImage\nonChunk\nonError',
              Icons.podcasts,
              pinkAccent,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: blueMid.withValues(alpha: 0.3)),
          ),
          child: Text(
            'ImageStream is the public face. ImageStreamCompleter is the engine '
            'behind the curtain. Multiple listeners can attach to one stream and '
            'all will receive the same ImageInfo when the image is ready.',
            style: TextStyle(
              fontSize: 12.0,
              color: blueDeep,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Construction card with hashcode chip
  // ============================================================
  print('=== Section 3: Construction ===');
  final constructionCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.blue.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: blueMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: blueMid.withValues(alpha: 0.25),
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
            Icon(Icons.handyman, color: blueDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Constructor: final s = ImageStream();',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: blueDeep,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _statChip('runtimeType', '${stream.runtimeType}', cyanAccent),
            _statChip(
              'completer',
              stream.completer == null ? 'null' : 'set',
              amberAccent,
            ),
            _statChip('hashCode', '${stream.hashCode}', emeraldAccent),
            _statChip('key.runtimeType', '${stream.key.runtimeType}', pinkAccent),
            _statChip('listeners', 'empty', violetMid),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: blueMid.withValues(alpha: 0.4)),
          ),
          child: Text(
            'A freshly constructed ImageStream has no completer attached. The '
            'completer is set later via setCompleter(...) — usually by an '
            'ImageProvider during resolve(). Until then, attached listeners '
            'are buffered until the completer arrives.',
            style: TextStyle(fontSize: 12.0, color: blueDeep, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: ImageStreamListener field cards
  // ============================================================
  print('=== Section 4: ImageStreamListener fields ===');
  final listenerFields = <Widget>[
    _listenerFieldCard(
      'onImage',
      'ImageListener',
      '(ImageInfo image, bool synchronousCall) { ... }',
      'Called when a new frame is ready. synchronousCall is true when the '
          'image was already cached and dispatched immediately.',
      Icons.image,
      blueMid,
    ),
    _listenerFieldCard(
      'onChunk',
      'ImageChunkListener?',
      '(ImageChunkEvent event) { ... }',
      'Called repeatedly during decoding for streamed sources (network) so '
          'you can render a progress bar.',
      Icons.download,
      indigoMid,
    ),
    _listenerFieldCard(
      'onError',
      'ImageErrorListener?',
      '(Object exception, StackTrace? stack) { ... }',
      'Called when decoding fails. If null, the framework rethrows the error '
          'into FlutterError.onError.',
      Icons.error_outline,
      pinkAccent,
    ),
  ];

  final listenerSection = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: violetMid.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetMid.withValues(alpha: 0.2),
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
            Icon(Icons.podcasts, color: violetDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ImageStreamListener fields',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: violetDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final card in listenerFields) ...[
          card,
          SizedBox(height: 10.0),
        ],
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Lifecycle states with gradient progression strip
  // ============================================================
  print('=== Section 5: Lifecycle ===');
  final lifecycleStages = [
    {
      'name': 'NOT STARTED',
      'desc': 'ImageStream() constructed,\nno completer yet',
      'icon': Icons.hourglass_empty,
      'color': Colors.grey.shade500,
      'progress': 0.0,
    },
    {
      'name': 'RESOLVING',
      'desc': 'provider.resolve(config)\nfetching bytes',
      'icon': Icons.travel_explore,
      'color': blueMid,
      'progress': 0.25,
    },
    {
      'name': 'HAS COMPLETER',
      'desc': 'setCompleter() called,\nbuffered listeners attach',
      'icon': Icons.link,
      'color': indigoMid,
      'progress': 0.5,
    },
    {
      'name': 'FIRST FRAME',
      'desc': 'ImageInfo dispatched,\nonImage fires',
      'icon': Icons.flash_on,
      'color': violetMid,
      'progress': 0.85,
    },
    {
      'name': 'DONE',
      'desc': 'static image complete\nor animated frame loop',
      'icon': Icons.check_circle,
      'color': emeraldAccent,
      'progress': 1.0,
    },
  ];

  final lifecycleCards = <Widget>[];
  for (final stage in lifecycleStages) {
    final c = stage['color'] as Color;
    lifecycleCards.add(
      Container(
        width: 140.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              c.withValues(alpha: 0.12),
              c.withValues(alpha: 0.28),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: c, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.3),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(stage['icon'] as IconData, color: c, size: 32.0),
            SizedBox(height: 6.0),
            Text(
              stage['name'] as String,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: c,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.0),
            Text(
              stage['desc'] as String,
              style: TextStyle(fontSize: 9.5, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Container(
              height: 6.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: stage['progress'] as double,
                child: Container(
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final lifecycleSection = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.purple.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoMid.withValues(alpha: 0.35), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: blueMid.withValues(alpha: 0.18),
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
            Icon(Icons.timeline, color: indigoMid, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Lifecycle states',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: blueDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          height: 14.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade400,
                blueMid,
                indigoMid,
                violetMid,
                emeraldAccent,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0),
            boxShadow: [
              BoxShadow(
                color: indigoMid.withValues(alpha: 0.3),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(alignment: WrapAlignment.center, children: lifecycleCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: ImageInfo fields
  // ============================================================
  print('=== Section 6: ImageInfo ===');
  final imageInfoCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanAccent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanAccent.withValues(alpha: 0.3),
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
            Icon(Icons.info_outline, color: blueDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ImageInfo — payload of onImage',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: blueDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _imageInfoRow(
          'image',
          'ui.Image',
          'the actual decoded raster',
          Icons.image,
          blueMid,
        ),
        SizedBox(height: 8.0),
        _imageInfoRow(
          'scale',
          'double',
          'logical px / device px (e.g. 2.0 for @2x)',
          Icons.zoom_in,
          indigoMid,
        ),
        SizedBox(height: 8.0),
        _imageInfoRow(
          'debugLabel',
          'String?',
          'human-readable origin tag',
          Icons.label_outline,
          violetMid,
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: cyanAccent.withValues(alpha: 0.5)),
          ),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: [
              _statChip('image.width', '512', blueMid),
              _statChip('image.height', '512', blueMid),
              _statChip('scale', '2.0', indigoMid),
              _statChip('debugLabel', '"network:cat.jpg"', violetMid),
              _statChip('sizeBytes', '~512 KB', amberAccent),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: ImageChunkEvent — fake progress bar
  // ============================================================
  print('=== Section 7: ImageChunkEvent ===');
  final fakeChunks = [
    {'loaded': 32 * 1024, 'total': 512 * 1024},
    {'loaded': 128 * 1024, 'total': 512 * 1024},
    {'loaded': 256 * 1024, 'total': 512 * 1024},
    {'loaded': 384 * 1024, 'total': 512 * 1024},
    {'loaded': 512 * 1024, 'total': 512 * 1024},
  ];

  final chunkBars = <Widget>[];
  for (final ev in fakeChunks) {
    final loaded = ev['loaded'] as int;
    final total = ev['total'] as int;
    final pct = loaded / total;
    print(
      'ImageChunkEvent loaded=$loaded total=$total pct=${(pct * 100).toStringAsFixed(0)}%',
    );
    chunkBars.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            SizedBox(
              width: 90.0,
              child: Text(
                '${(loaded / 1024).round()} / ${(total / 1024).round()} KB',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: blueDeep,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 14.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: pct,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [blueMid, violetMid],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            SizedBox(
              width: 44.0,
              child: Text(
                '${(pct * 100).toStringAsFixed(0)}%',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: violetDeep,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final chunkSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: violetMid.withValues(alpha: 0.25),
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
            Icon(Icons.download, color: indigoMid, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ImageChunkEvent — streamed progress',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: blueDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: indigoMid.withValues(alpha: 0.3)),
          ),
          child: Text(
            'cumulativeBytesLoaded: int — bytes received so far\n'
            'expectedTotalBytes: int? — null for sources where size is unknown',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: violetDeep,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        ...chunkBars,
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Real-world flow
  // ============================================================
  print('=== Section 8: Real-world flow ===');
  final realWorldFlow = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.indigo.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: blueMid.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: blueMid.withValues(alpha: 0.25),
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
            Icon(Icons.public, color: blueDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Real-world flow: how Image widget uses ImageStream',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: blueDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _flowStep(
          1,
          'You write Image.network(url)',
          'Image widget creates a NetworkImage provider internally.',
          Icons.code,
          blueMid,
        ),
        _flowStep(
          2,
          '_ImageState resolves the provider',
          'In didChangeDependencies it calls provider.resolve(createLocalImageConfiguration).',
          Icons.refresh,
          indigoMid,
        ),
        _flowStep(
          3,
          'resolve() returns an ImageStream',
          'Same key-shaped requests share one cached stream from imageCache.',
          Icons.share,
          violetMid,
        ),
        _flowStep(
          4,
          '_ImageState attaches a listener',
          'addListener(ImageStreamListener(onImage, onChunk, onError)).',
          Icons.podcasts,
          pinkAccent,
        ),
        _flowStep(
          5,
          'Completer reports ImageInfo',
          'onImage fires; widget setStates and paints the frame.',
          Icons.flash_on,
          amberAccent,
        ),
        _flowStep(
          6,
          'On dispose / new url',
          'removeListener(...) is called to avoid leaking the State.',
          Icons.cleaning_services,
          emeraldAccent,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Code snippets
  // ============================================================
  print('=== Section 9: Code snippets ===');
  final codeSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slateBg,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: slateBg.withValues(alpha: 0.6),
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
            Icon(Icons.terminal, color: cyanAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Wiring an ImageStreamListener',
              style: TextStyle(
                color: cyanAccent,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// 1. Get a stream from a provider.\n'
          'final ImageProvider provider = NetworkImage(url);\n'
          'final ImageConfiguration cfg =\n'
          '    createLocalImageConfiguration(context);\n'
          'final ImageStream stream = provider.resolve(cfg);',
          cyanAccent,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// 2. Build a listener with the three callbacks.\n'
          'final listener = ImageStreamListener(\n'
          '  (ImageInfo info, bool sync) {\n'
          '    setState(() => _info = info);\n'
          '  },\n'
          '  onChunk: (ImageChunkEvent ev) {\n'
          '    setState(() => _bytes = ev.cumulativeBytesLoaded);\n'
          '  },\n'
          '  onError: (Object e, StackTrace? st) {\n'
          '    debugPrint(\'image failed: \$e\');\n'
          '  },\n'
          ');',
          Color(0xFFA5F3FC),
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// 3. Attach and detach symmetrically.\n'
          'stream.addListener(listener);\n'
          '\n'
          '@override\n'
          'void dispose() {\n'
          '  stream.removeListener(listener);\n'
          '  super.dispose();\n'
          '}',
          Color(0xFFC4B5FD),
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// 4. Equality matters: removeListener uses ==.\n'
          '// Always remove the SAME listener instance you added.\n'
          'final l1 = ImageStreamListener(_onImage);\n'
          'final l2 = ImageStreamListener(_onImage);\n'
          'stream.addListener(l1);\n'
          'stream.removeListener(l2); // l1 == l2 if onImage equal',
          Color(0xFFFBCFE8),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');
  final footguns = [
    {
      'title': 'Forgetting removeListener in dispose',
      'desc': 'The completer keeps a strong reference to your listener, which '
          'may capture State. Result: leaked widget tree until the cache evicts.',
      'icon': Icons.memory,
      'color': pinkAccent,
    },
    {
      'title': 'Setting completer twice',
      'desc': 'ImageStream.setCompleter is meant to be called once. Calling it '
          'again throws — the stream has already wired up its buffered listeners.',
      'icon': Icons.link_off,
      'color': amberAccent,
    },
    {
      'title': 'Long-lived providers leak streams',
      'desc': 'Holding a custom ImageProvider as a static can pin streams in '
          'imageCache forever. Prefer letting Flutter manage cache lifetime.',
      'icon': Icons.warning_amber_rounded,
      'color': Colors.orange.shade700,
    },
    {
      'title': 'Misreading synchronousCall',
      'desc': 'When the image was already in cache, onImage fires before '
          'addListener returns. If you setState there, you may setState during '
          'build — guard the call.',
      'icon': Icons.flash_on,
      'color': violetMid,
    },
    {
      'title': 'Different listener instance',
      'desc': 'ImageStreamListener uses == on its callbacks. Anonymous closures '
          'are not equal across rebuilds — store the listener on State.',
      'icon': Icons.compare_arrows,
      'color': cyanAccent,
    },
    {
      'title': 'Null expectedTotalBytes',
      'desc': 'Servers without Content-Length send chunks with null total. '
          'Render an indeterminate spinner instead of a 0% bar.',
      'icon': Icons.help_outline,
      'color': indigoMid,
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    final c = fg['color'] as Color;
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              c.withValues(alpha: 0.08),
              c.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: c.withValues(alpha: 0.6), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.18),
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
                color: c.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(fg['icon'] as IconData, color: c, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: blueDeep,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.black87,
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

  final footgunSection = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: pinkAccent.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: pinkAccent.withValues(alpha: 0.18),
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
            Icon(Icons.dangerous_outlined, color: pinkAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: blueDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        ...footgunCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Recap
  // ============================================================
  print('=== Section 11: Recap ===');
  final recapBullets = [
    'ImageStream is the public handle; ImageStreamCompleter does the work.',
    'addListener / removeListener manage a list of ImageStreamListener.',
    'ImageStreamListener carries onImage, onChunk, onError callbacks.',
    'onImage receives ImageInfo + a synchronousCall flag.',
    'ImageInfo wraps ui.Image, scale, and an optional debugLabel.',
    'ImageChunkEvent carries cumulativeBytesLoaded / expectedTotalBytes.',
    'Provider.resolve(config) is the canonical way to obtain a stream.',
    'Always pair addListener with removeListener — typically in dispose.',
  ];

  final recapList = <Widget>[];
  for (var i = 0; i < recapBullets.length; i++) {
    final bullet = recapBullets[i];
    recapList.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24.0,
              height: 24.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [blueMid, violetMid],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: violetMid.withValues(alpha: 0.35),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                bullet,
                style: TextStyle(
                  fontSize: 12.5,
                  color: blueDeep,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final recapCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [violetMid, indigoMid, blueDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: violetDeep.withValues(alpha: 0.5),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: blueDeep.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist_rtl, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: recapList,
          ),
        ),
      ],
    ),
  );

  print('ImageStream Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),
          _sectionHeader('1. Anatomy', Icons.account_tree, indigoMid),
          SizedBox(height: 8.0),
          anatomyDiagram,
          SizedBox(height: 28.0),
          _sectionHeader('2. Construction', Icons.handyman, blueMid),
          SizedBox(height: 8.0),
          constructionCard,
          SizedBox(height: 28.0),
          _sectionHeader('3. Listener fields', Icons.podcasts, violetMid),
          SizedBox(height: 8.0),
          listenerSection,
          SizedBox(height: 28.0),
          _sectionHeader('4. Lifecycle', Icons.timeline, indigoMid),
          SizedBox(height: 8.0),
          lifecycleSection,
          SizedBox(height: 28.0),
          _sectionHeader('5. ImageInfo', Icons.info_outline, cyanAccent),
          SizedBox(height: 8.0),
          imageInfoCard,
          SizedBox(height: 28.0),
          _sectionHeader('6. ImageChunkEvent', Icons.download, indigoMid),
          SizedBox(height: 8.0),
          chunkSection,
          SizedBox(height: 28.0),
          _sectionHeader('7. Real-world flow', Icons.public, blueDeep),
          SizedBox(height: 8.0),
          realWorldFlow,
          SizedBox(height: 28.0),
          _sectionHeader('8. Code snippets', Icons.terminal, slateBg),
          SizedBox(height: 8.0),
          codeSection,
          SizedBox(height: 28.0),
          _sectionHeader('9. Footguns', Icons.dangerous_outlined, pinkAccent),
          SizedBox(height: 8.0),
          footgunSection,
          SizedBox(height: 28.0),
          _sectionHeader('10. Recap', Icons.checklist_rtl, violetDeep),
          SizedBox(height: 8.0),
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

Widget _pill(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10.5,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _pipeNode(
  String title,
  String subtitle,
  IconData icon,
  Color color,
) {
  return Container(
    width: 110.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26.0),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(fontSize: 9.0, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _pipeArrow(String label) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.east, color: Colors.indigo.shade400, size: 22.0),
        SizedBox(height: 2.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 8.5,
            color: Colors.indigo.shade400,
            fontFamily: 'monospace',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _statChip(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.8),
          color.withValues(alpha: 0.95),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.white,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _listenerFieldCard(
  String name,
  String type,
  String signature,
  String desc,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
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
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: color,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  signature,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFFA5F3FC),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.black87,
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

Widget _imageInfoRow(
  String name,
  String type,
  String desc,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20.0),
        SizedBox(width: 10.0),
        SizedBox(
          width: 90.0,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 10.5,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 11.5, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

Widget _flowStep(
  int index,
  String title,
  String desc,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.7),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            '$index',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 16.0),
                    SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black87,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.05),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFF334155), width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}
