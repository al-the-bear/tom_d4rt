// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageStreamListener from painting
// Deep Demo: Visual demonstration of ImageStreamListener — the 3-callback bundle
// subscribed to an ImageStream (onImage, onChunk, onError).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageStreamListener Deep Demo executing');

  // Cyan/teal "stream" palette.
  final Color streamPrimary = Colors.cyan.shade700;
  final Color streamSecondary = Colors.teal.shade600;
  final Color streamAccent = Colors.cyan.shade300;
  final Color streamDeep = Colors.teal.shade900;

  // ============================================================
  // Define standalone callback variables so we can demonstrate
  // operator== / hashCode equality (which is identity-based for the
  // 3 callbacks).
  // ============================================================
  void onImageA(ImageInfo info, bool sync) {
    print('onImageA fired: ${info.image.width}x${info.image.height} sync=$sync');
  }
  void onImageB(ImageInfo info, bool sync) {
    print('onImageB fired (different instance) sync=$sync info=$info');
  }
  void onChunkA(ImageChunkEvent ev) {
    print('onChunkA: loaded=${ev.cumulativeBytesLoaded}/${ev.expectedTotalBytes}');
  }
  void onErrorA(Object e, StackTrace? s) {
    print('onErrorA: $e (stack=${s != null})');
  }

  // ============================================================
  // SECTION 3 prep: Construct 5 distinct ImageStreamListener instances.
  // We do not fire any image events — we only present them as data.
  // ============================================================
  print('=== Section 3 prep: building ImageStreamListener instances ===');

  final ImageStreamListener listenerMinimal = ImageStreamListener(onImageA);
  final ImageStreamListener listenerWithChunk = ImageStreamListener(
    onImageA,
    onChunk: onChunkA,
  );
  final ImageStreamListener listenerWithError = ImageStreamListener(
    onImageA,
    onError: onErrorA,
  );
  final ImageStreamListener listenerAll = ImageStreamListener(
    onImageA,
    onChunk: onChunkA,
    onError: onErrorA,
  );
  // Same callback set as listenerAll (for == comparison).
  final ImageStreamListener listenerAllTwin = ImageStreamListener(
    onImageA,
    onChunk: onChunkA,
    onError: onErrorA,
  );
  // A different listener using a different onImage to contrast equality.
  final ImageStreamListener listenerDifferent = ImageStreamListener(
    onImageB,
    onChunk: onChunkA,
    onError: onErrorA,
  );

  print('listenerMinimal:    onImage=yes, onChunk=${listenerMinimal.onChunk != null}, onError=${listenerMinimal.onError != null}');
  print('listenerWithChunk:  onImage=yes, onChunk=${listenerWithChunk.onChunk != null}, onError=${listenerWithChunk.onError != null}');
  print('listenerWithError:  onImage=yes, onChunk=${listenerWithError.onChunk != null}, onError=${listenerWithError.onError != null}');
  print('listenerAll:        onImage=yes, onChunk=${listenerAll.onChunk != null}, onError=${listenerAll.onError != null}');
  print('listenerAllTwin:    onImage=yes, onChunk=${listenerAllTwin.onChunk != null}, onError=${listenerAllTwin.onError != null}');
  print('listenerDifferent:  onImage=yes, onChunk=${listenerDifferent.onChunk != null}, onError=${listenerDifferent.onError != null}');

  // Equality probes (used in section 8).
  final bool eqAllSame = listenerAll == listenerAllTwin;
  final bool eqAllDiff = listenerAll == listenerDifferent;
  final bool eqMinAll = listenerMinimal == listenerAll;
  print('listenerAll == listenerAllTwin   => $eqAllSame');
  print('listenerAll == listenerDifferent => $eqAllDiff');
  print('listenerMinimal == listenerAll   => $eqMinAll');
  print('listenerAll.hashCode             => ${listenerAll.hashCode}');
  print('listenerAllTwin.hashCode         => ${listenerAllTwin.hashCode}');
  print('listenerDifferent.hashCode       => ${listenerDifferent.hashCode}');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final Widget titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [streamDeep, streamPrimary, streamAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: streamPrimary.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: streamDeep.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.image_search, size: 64.0, color: Colors.white),
        SizedBox(height: 10.0),
        Text(
          'ImageStreamListener',
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
            fontSize: 14.0,
            color: Colors.white70,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Three callbacks. One stream. Many frames.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy — 3-callback box
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: streamPrimary, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: streamPrimary.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: streamDeep, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of ImageStreamListener',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: streamDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCallbackBox(
              'onImage',
              'ImageListener',
              'Required',
              Icons.image,
              Colors.cyan,
              true,
            ),
            _buildCallbackBox(
              'onChunk',
              'ImageChunkListener?',
              'Optional',
              Icons.downloading,
              Colors.teal,
              false,
            ),
            _buildCallbackBox(
              'onError',
              'ImageErrorListener?',
              'Optional',
              Icons.error_outline,
              Colors.deepOrange,
              false,
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: streamAccent, width: 1.0),
          ),
          child: Text(
            'ImageStreamListener(this.onImage, {this.onChunk, this.onError})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: streamDeep,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: 5 instances visualization
  // ============================================================
  print('=== Section 3: Instance gallery ===');

  final List<Widget> instanceCards = <Widget>[
    _buildInstanceCard(
      'minimal',
      'onImage only',
      listenerMinimal.onChunk != null,
      listenerMinimal.onError != null,
      Colors.cyan,
    ),
    _buildInstanceCard(
      'with onChunk',
      'progress aware',
      listenerWithChunk.onChunk != null,
      listenerWithChunk.onError != null,
      Colors.teal,
    ),
    _buildInstanceCard(
      'with onError',
      'failure aware',
      listenerWithError.onChunk != null,
      listenerWithError.onError != null,
      Colors.deepOrange,
    ),
    _buildInstanceCard(
      'all three',
      'fully wired',
      listenerAll.onChunk != null,
      listenerAll.onError != null,
      Colors.indigo,
    ),
    _buildInstanceCard(
      'twin of "all"',
      'same callbacks',
      listenerAllTwin.onChunk != null,
      listenerAllTwin.onError != null,
      Colors.purple,
    ),
  ];

  // ============================================================
  // SECTION 4: ImageListener signature
  // ============================================================
  print('=== Section 4: ImageListener signature ===');

  final Widget signatureOnImage = _buildSignatureCard(
    'ImageListener',
    'void Function(ImageInfo image, bool synchronousCall)',
    'Fires whenever a new fully-decoded frame is available. '
        'For static images this happens once. For animated images '
        '(GIF/WebP) it can fire many times — once per frame.',
    'image: decoded ui.Image + scale + debugLabel.\n'
        'synchronousCall: true if this listener was added AFTER\n'
        '  the stream already had a frame, so the stream invokes\n'
        '  the listener immediately within addListener().',
    Icons.image,
    Colors.cyan,
  );

  // ============================================================
  // SECTION 5: ImageChunkListener signature
  // ============================================================
  print('=== Section 5: ImageChunkListener signature ===');

  final Widget signatureOnChunk = _buildSignatureCard(
    'ImageChunkListener',
    'void Function(ImageChunkEvent event)',
    'Fires periodically while the image is still decoding/downloading. '
        'Use it to drive a progress indicator. Not all providers report chunks.',
    'event.cumulativeBytesLoaded: bytes received so far.\n'
        'event.expectedTotalBytes:   total expected bytes (nullable).\n'
        '  → progress = cumulativeBytesLoaded / expectedTotalBytes\n'
        '  (treat null as indeterminate).',
    Icons.downloading,
    Colors.teal,
  );

  // ============================================================
  // SECTION 6: ImageErrorListener signature
  // ============================================================
  print('=== Section 6: ImageErrorListener signature ===');

  final Widget signatureOnError = _buildSignatureCard(
    'ImageErrorListener',
    'void Function(Object exception, StackTrace? stackTrace)',
    'Fires when the stream fails to decode. If absent, the framework '
        'reports the error to FlutterError.onError instead, which usually '
        'surfaces a red error widget.',
    'exception:  the actual error (often a NetworkImageLoadException\n'
        '            or a decoding failure).\n'
        'stackTrace: nullable — present when the framework captured one.\n'
        'Tip: always provide onError for network images.',
    Icons.error_outline,
    Colors.deepOrange,
  );

  // ============================================================
  // SECTION 7: Real-world wiring
  // ============================================================
  print('=== Section 7: Real-world wiring ===');

  final Widget wiringBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
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
            Icon(Icons.cable, color: streamAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Real-world wiring',
              style: TextStyle(
                color: streamAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Resolve a provider to a stream and subscribe.\n'
          'final ImageProvider provider = AssetImage(\'foo.png\');\n'
          'final ImageStream stream = provider.resolve(\n'
          '  createLocalImageConfiguration(context),\n'
          ');\n'
          '\n'
          'final listener = ImageStreamListener(\n'
          '  (ImageInfo info, bool sync) {\n'
          '    // do something with info.image\n'
          '  },\n'
          '  onChunk: (ImageChunkEvent ev) {\n'
          '    // update progress UI\n'
          '  },\n'
          '  onError: (Object e, StackTrace? s) {\n'
          '    // surface the error\n'
          '  },\n'
          ');\n'
          '\n'
          'stream.addListener(listener);\n'
          '// later, in dispose():\n'
          'stream.removeListener(listener);',
          Colors.cyanAccent,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Equality / hashCode
  // ============================================================
  print('=== Section 8: Equality / hashCode ===');

  final Widget equalityBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: streamSecondary, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: streamSecondary.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: streamDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'operator== / hashCode',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: streamDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Two listeners are equal when all three callback references are identical.',
          style: TextStyle(fontSize: 12.0, color: streamDeep),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildEqualityCard(
              'all == twin',
              'same onImage,\nsame onChunk,\nsame onError',
              eqAllSame,
              Colors.green,
            ),
            _buildEqualityCard(
              'all == different',
              'different onImage\n(onImageA vs onImageB)',
              eqAllDiff,
              Colors.red,
            ),
            _buildEqualityCard(
              'minimal == all',
              'extra onChunk\n+ extra onError',
              eqMinAll,
              Colors.red,
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: streamAccent, width: 1.0),
          ),
          child: Text(
            'hashCode(all)        = ${listenerAll.hashCode}\n'
            'hashCode(twin)       = ${listenerAllTwin.hashCode}\n'
            'hashCode(different)  = ${listenerDifferent.hashCode}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: streamDeep,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Lifecycle visualization
  // ============================================================
  print('=== Section 9: Lifecycle ===');

  final List<Map<String, dynamic>> lifecycleSteps = [
    {
      'n': '1',
      'title': 'provider',
      'desc': 'AssetImage / NetworkImage / FileImage',
      'icon': Icons.source,
    },
    {
      'n': '2',
      'title': 'resolve(config)',
      'desc': 'returns an ImageStream',
      'icon': Icons.alt_route,
    },
    {
      'n': '3',
      'title': 'addListener',
      'desc': 'subscribe an ImageStreamListener',
      'icon': Icons.add_link,
    },
    {
      'n': '4',
      'title': 'onChunk × N',
      'desc': 'progress events while loading',
      'icon': Icons.downloading,
    },
    {
      'n': '5',
      'title': 'onImage',
      'desc': 'frame is ready (synchronousCall flag)',
      'icon': Icons.image,
    },
    {
      'n': '6',
      'title': 'onError?',
      'desc': 'fires instead of onImage if decode fails',
      'icon': Icons.error_outline,
    },
    {
      'n': '7',
      'title': 'removeListener',
      'desc': 'unsubscribe in dispose() — same instance!',
      'icon': Icons.link_off,
    },
  ];

  final List<Widget> lifecycleNodes = <Widget>[];
  for (int i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    lifecycleNodes.add(
      _buildLifecycleNode(
        step['n'] as String,
        step['title'] as String,
        step['desc'] as String,
        step['icon'] as IconData,
        i.isEven ? streamPrimary : streamSecondary,
      ),
    );
    if (i < lifecycleSteps.length - 1) {
      lifecycleNodes.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Icon(
            Icons.arrow_downward,
            color: streamAccent,
            size: 22.0,
          ),
        ),
      );
    }
  }

  final Widget lifecycleBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.white, Colors.teal.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: streamPrimary, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: streamPrimary.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timeline, color: streamDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Lifecycle',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: streamDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        ...lifecycleNodes,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final List<Map<String, dynamic>> footguns = [
    {
      'title': 'You MUST removeListener',
      'desc':
          'ImageStream holds a strong reference to your listener. Forget to '
              'remove it in dispose() and your widget (and its closures) are leaked.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'title': 'Same instance for add/remove',
      'desc':
          'addListener and removeListener compare by ==. Build a new closure '
              'every frame and removeListener will silently do nothing. Store '
              'the listener in a field.',
      'icon': Icons.fingerprint,
      'color': Colors.deepPurple,
    },
    {
      'title': 'synchronousCall vs setState',
      'desc':
          'If the stream already has a frame, addListener calls onImage '
              'SYNCHRONOUSLY. Calling setState() from there during build '
              'throws "setState during build". Schedule it (e.g. via the '
              'sync flag) or use precacheImage.',
      'icon': Icons.sync_problem,
      'color': Colors.red,
    },
    {
      'title': 'onError or you get a red box',
      'desc':
          'No onError? Decode failures are reported via FlutterError.onError '
              'and typically show as the red error widget in debug builds.',
      'icon': Icons.broken_image,
      'color': Colors.deepOrange,
    },
    {
      'title': 'onChunk is best-effort',
      'desc':
          'Local providers (AssetImage, MemoryImage) usually never call '
              'onChunk. Don\'t depend on it firing — handle the case where '
              'expectedTotalBytes is null too.',
      'icon': Icons.report_problem,
      'color': Colors.amber.shade800,
    },
  ];

  final List<Widget> footgunCards = <Widget>[];
  for (final fg in footguns) {
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (fg['color'] as Color).withValues(alpha: 0.08),
              (fg['color'] as Color).withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: (fg['color'] as Color).withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (fg['color'] as Color).withValues(alpha: 0.2),
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
                color: (fg['color'] as Color).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                fg['icon'] as IconData,
                color: fg['color'] as Color,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: fg['color'] as Color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                      height: 1.35,
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

  final Widget footgunsBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gpp_maybe, color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        ...footgunCards,
      ],
    ),
  );

  print('ImageStreamListener Deep Demo completed successfully');

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
          // 1. Title banner
          titleBanner,
          SizedBox(height: 24.0),

          // 2. Anatomy
          _buildSectionLabel('1. Title & Overview', streamDeep),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [streamAccent.withValues(alpha: 0.2), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: streamAccent, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: streamAccent.withValues(alpha: 0.2),
                  blurRadius: 8.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Text(
              'ImageStreamListener bundles three callbacks that subscribe '
              'to an ImageStream. The framework invokes them as the stream '
              'produces chunks, frames, and errors. The class is just a '
              'value-object: it has no logic of its own beyond equality.',
              style: TextStyle(
                fontSize: 13.0,
                color: streamDeep,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 24.0),

          _buildSectionLabel('2. Anatomy', streamDeep),
          anatomy,
          SizedBox(height: 24.0),

          _buildSectionLabel('3. Five Instances', streamDeep),
          Wrap(
            alignment: WrapAlignment.center,
            children: instanceCards,
          ),
          SizedBox(height: 24.0),

          _buildSectionLabel('4. ImageListener (onImage)', streamDeep),
          signatureOnImage,
          SizedBox(height: 24.0),

          _buildSectionLabel('5. ImageChunkListener (onChunk)', streamDeep),
          signatureOnChunk,
          SizedBox(height: 24.0),

          _buildSectionLabel('6. ImageErrorListener (onError)', streamDeep),
          signatureOnError,
          SizedBox(height: 24.0),

          _buildSectionLabel('7. Real-world wiring', streamDeep),
          wiringBlock,
          SizedBox(height: 24.0),

          _buildSectionLabel('8. Equality & hashCode', streamDeep),
          equalityBlock,
          SizedBox(height: 24.0),

          _buildSectionLabel('9. Lifecycle', streamDeep),
          lifecycleBlock,
          SizedBox(height: 24.0),

          _buildSectionLabel('10. Footguns', streamDeep),
          footgunsBlock,
          SizedBox(height: 32.0),

          // Footer
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [streamPrimary, streamDeep],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: streamDeep.withValues(alpha: 0.4),
                  blurRadius: 8.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Demo built — 5 listeners constructed, 0 frames fired.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
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

// ============================================================
// Helpers
// ============================================================

Widget _buildSectionLabel(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCallbackBox(
  String name,
  String typeName,
  String requirement,
  IconData icon,
  Color color,
  bool required,
) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.30),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, size: 36.0, color: color),
        SizedBox(height: 6.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          typeName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.0,
            fontFamily: 'monospace',
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: required ? Colors.red.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            requirement,
            style: TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.bold,
              color: required ? Colors.red.shade900 : Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInstanceCard(
  String name,
  String tag,
  bool hasChunk,
  bool hasError,
  Color color,
) {
  return Container(
    width: 150.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
            Icon(Icons.headphones, color: color, size: 18.0),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          tag,
          style: TextStyle(
            fontSize: 10.0,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        _buildSlotRow('onImage', true, color),
        _buildSlotRow('onChunk', hasChunk, color),
        _buildSlotRow('onError', hasError, color),
      ],
    ),
  );
}

Widget _buildSlotRow(String label, bool present, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Icon(
          present ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 14.0,
          color: present ? color : Colors.grey.shade400,
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: present ? Colors.grey.shade900 : Colors.grey.shade500,
            fontWeight: present ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSignatureCard(
  String name,
  String signature,
  String description,
  String paramExplain,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.20),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.5),
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
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            signature,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyanAccent,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: color.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            paramExplain,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade700, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildEqualityCard(
  String title,
  String detail,
  bool result,
  Color resultColor,
) {
  return Container(
    width: 110.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: resultColor, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: resultColor.withValues(alpha: 0.2),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: resultColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                result ? Icons.check : Icons.close,
                color: resultColor,
                size: 14.0,
              ),
              SizedBox(width: 4.0),
              Text(
                result ? 'true' : 'false',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleNode(
  String number,
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 2.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Row(
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Icon(icon, color: color, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
