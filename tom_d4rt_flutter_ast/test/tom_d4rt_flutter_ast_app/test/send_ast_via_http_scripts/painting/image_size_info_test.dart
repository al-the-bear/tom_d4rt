// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for ImageSizeInfo from painting
// ImageSizeInfo reports an image's source-size vs displayed-size for the
// Flutter `imageSizes` debug telemetry channel. It's how DevTools and the
// "invert oversized images" debugger learn that you decoded a 4096x4096
// image just to paint it at 100x100, wasting ~64 MB of memory.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageSizeInfo Deep Demo executing');

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepOrange.shade700,
          Colors.amber.shade700,
          Colors.orange.shade600,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.image_search, size: 64.0, color: Colors.white),
        SizedBox(height: 12.0),
        Text(
          'ImageSizeInfo',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Source vs Display size telemetry',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white.withValues(alpha: 0.95),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
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

  // ============================================================
  // SECTION 2: Anatomy - 5-field labelled box
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyFields = [
    {
      'name': 'source',
      'type': 'String?',
      'desc': 'Asset path or URL identifying the image',
      'icon': Icons.link,
      'color': Colors.blue,
    },
    {
      'name': 'imageSize',
      'type': 'Size',
      'desc': 'Decoded pixel dimensions (e.g. 4096x4096)',
      'icon': Icons.photo_size_select_large,
      'color': Colors.purple,
    },
    {
      'name': 'displaySize',
      'type': 'Size',
      'desc': 'Painted size on screen (e.g. 100x100)',
      'icon': Icons.crop_square,
      'color': Colors.teal,
    },
    {
      'name': 'decodedSizeInBytes',
      'type': 'int',
      'desc': 'imageSize.width * imageSize.height * 4',
      'icon': Icons.memory,
      'color': Colors.red,
    },
    {
      'name': 'displaySizeInBytes',
      'type': 'int',
      'desc': 'displaySize.width * displaySize.height * 4',
      'icon': Icons.aspect_ratio,
      'color': Colors.green,
    },
  ];

  final anatomyChildren = <Widget>[];
  anatomyChildren.add(
    Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Text(
        'Five fields make up an ImageSizeInfo record:',
        style: TextStyle(
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
          color: Colors.brown.shade800,
        ),
      ),
    ),
  );
  for (final f in anatomyFields) {
    final color = f['color'] as Color;
    anatomyChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(f['icon'] as IconData, color: color, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        f['name'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: color,
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
                          f['type'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.0,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    f['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
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

  final anatomyBox = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: anatomyChildren,
    ),
  );

  // ============================================================
  // SECTION 3: Six ImageSizeInfo example instances
  // ============================================================
  print('=== Section 3: Six ImageSizeInfo instances ===');

  final examples = [
    {
      'source': 'asset://images/banner.png',
      'imageSize': Size(4096.0, 4096.0),
      'displaySize': Size(320.0, 100.0),
      'label': 'Banner (worst offender)',
      'icon': Icons.panorama,
    },
    {
      'source': 'https://cdn.example.com/avatar.jpg',
      'imageSize': Size(1024.0, 1024.0),
      'displaySize': Size(56.0, 56.0),
      'label': 'Avatar',
      'icon': Icons.account_circle,
    },
    {
      'source': 'asset://images/thumb.png',
      'imageSize': Size(256.0, 256.0),
      'displaySize': Size(256.0, 256.0),
      'label': 'Thumbnail (perfect fit)',
      'icon': Icons.check_box,
    },
    {
      'source': 'https://photos.example.com/sunset.jpg',
      'imageSize': Size(8192.0, 8192.0),
      'displaySize': Size(200.0, 200.0),
      'label': 'Photo gallery thumb',
      'icon': Icons.photo_library,
    },
    {
      'source': 'asset://icons/star.png',
      'imageSize': Size(512.0, 512.0),
      'displaySize': Size(24.0, 24.0),
      'label': 'Icon at 24px',
      'icon': Icons.star,
    },
    {
      'source': 'asset://images/logo.png',
      'imageSize': Size(1024.0, 512.0),
      'displaySize': Size(200.0, 100.0),
      'label': 'Logo (non-square)',
      'icon': Icons.brush,
    },
  ];

  final infos = <ImageSizeInfo>[];
  for (final e in examples) {
    final info = ImageSizeInfo(
      source: e['source'] as String,
      imageSize: e['imageSize'] as Size,
      displaySize: e['displaySize'] as Size,
    );
    infos.add(info);
    print(
      'ImageSizeInfo(${info.source}): decoded=${info.decodedSizeInBytes}B '
      'display=${info.displaySizeInBytes}B',
    );
  }

  final exampleCards = <Widget>[];
  for (var i = 0; i < examples.length; i++) {
    final e = examples[i];
    final info = infos[i];
    final imgSize = e['imageSize'] as Size;
    final dispSize = e['displaySize'] as Size;
    final ratio =
        (imgSize.width * imgSize.height) /
        (dispSize.width * dispSize.height);
    final wasteful = ratio > 4.0;
    final color = wasteful ? Colors.red : Colors.green;

    exampleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
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
                Icon(e['icon'] as IconData, color: color, size: 28.0),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    e['label'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    wasteful ? 'WASTEFUL' : 'OK',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              info.source ?? '<null>',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'imageSize',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.purple.shade900,
                          ),
                        ),
                        Text(
                          '${imgSize.width.toInt()} x ${imgSize.height.toInt()}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.grey.shade500,
                  size: 16.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'displaySize',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.teal.shade900,
                          ),
                        ),
                        Text(
                          '${dispSize.width.toInt()} x ${dispSize.height.toInt()}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'over-decode ratio: ${ratio.toStringAsFixed(1)}x',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Memory waste calculator
  // ============================================================
  print('=== Section 4: Memory waste calculator ===');

  final wasteHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade100,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    child: Row(
      children: [
        _buildWasteHeader('Source', 130.0),
        _buildWasteHeader('Decoded', 90.0),
        _buildWasteHeader('Display', 90.0),
        _buildWasteHeader('Wasted', 90.0),
      ],
    ),
  );

  final wasteRows = <Widget>[];
  for (var i = 0; i < infos.length; i++) {
    final info = infos[i];
    final dec = info.decodedSizeInBytes;
    final disp = info.displaySizeInBytes;
    final waste = dec - disp;
    final wastePercent = dec == 0 ? 0.0 : (waste / dec) * 100.0;
    wasteRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.white : Colors.amber.shade50,
          border: Border(
            bottom: BorderSide(color: Colors.amber.shade200, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                (examples[i]['label'] as String).split(' ').first,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.brown.shade900,
                ),
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                _formatBytes(dec),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.purple,
                ),
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                _formatBytes(disp),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.teal,
                ),
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                '${_formatBytes(waste)} (${wastePercent.toStringAsFixed(0)}%)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: wastePercent > 75.0
                      ? Colors.red
                      : Colors.orange.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final wasteTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        wasteHeader,
        ...wasteRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: toJson() showcase
  // ============================================================
  print('=== Section 5: toJson showcase ===');

  final showcaseInfo = infos[0];
  final json = showcaseInfo.toJson();
  print('toJson keys: ${json.keys.toList()}');

  final jsonLines = <String>[];
  jsonLines.add('{');
  final entries = json.entries.toList();
  for (var i = 0; i < entries.length; i++) {
    final entry = entries[i];
    final value = entry.value;
    final formatted = value is String ? '"$value"' : value.toString();
    final comma = i == entries.length - 1 ? '' : ',';
    jsonLines.add('  "${entry.key}": $formatted$comma');
  }
  jsonLines.add('}');

  final jsonShowcase = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
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
            Icon(Icons.data_object, color: Colors.amber.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'info.toJson()',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade300,
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              '// banner.png example',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.green.shade300,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: Colors.amber.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Text(
            jsonLines.join('\n'),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyan.shade200,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Sent over the imageSizes ServiceExtension to DevTools.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.grey.shade400,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: equality - 3 cards
  // ============================================================
  print('=== Section 6: equality ===');

  final eqA = ImageSizeInfo(
    source: 'asset://logo.png',
    imageSize: Size(1024.0, 1024.0),
    displaySize: Size(100.0, 100.0),
  );
  final eqB = ImageSizeInfo(
    source: 'asset://logo.png',
    imageSize: Size(1024.0, 1024.0),
    displaySize: Size(100.0, 100.0),
  );
  final eqC = ImageSizeInfo(
    source: 'asset://logo_v2.png',
    imageSize: Size(1024.0, 1024.0),
    displaySize: Size(100.0, 100.0),
  );

  final eqAB = eqA == eqB;
  final eqAC = eqA == eqC;
  final eqBC = eqB == eqC;
  print('eqA == eqB: $eqAB');
  print('eqA == eqC: $eqAC');
  print('eqB == eqC: $eqBC');

  final equalityCards = Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: _buildEqCard(
          'A == B',
          eqAB,
          'same source, same sizes',
          'asset://logo.png',
          'asset://logo.png',
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: _buildEqCard(
          'A == C',
          eqAC,
          'different source',
          'asset://logo.png',
          'asset://logo_v2.png',
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: _buildEqCard(
          'B == C',
          eqBC,
          'different source',
          'asset://logo.png',
          'asset://logo_v2.png',
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 7: Telemetry pipeline
  // ============================================================
  print('=== Section 7: Telemetry pipeline ===');

  final pipelineSteps = [
    {
      'icon': Icons.image,
      'title': 'ImageProvider',
      'desc': 'decodes asset to ui.Image',
      'color': Colors.blue,
    },
    {
      'icon': Icons.draw,
      'title': 'RenderImage',
      'desc': 'paints at displaySize',
      'color': Colors.purple,
    },
    {
      'icon': Icons.fact_check,
      'title': 'ImageSizeInfo',
      'desc': 'records source vs display',
      'color': Colors.amber.shade800,
    },
    {
      'icon': Icons.cable,
      'title': 'imageSizes ext.',
      'desc': 'ServiceExtension event',
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.dashboard,
      'title': 'DevTools',
      'desc': 'shows oversized list',
      'color': Colors.green,
    },
  ];

  final pipelineRows = <Widget>[];
  for (var i = 0; i < pipelineSteps.length; i++) {
    final step = pipelineSteps[i];
    final color = step['color'] as Color;
    pipelineRows.add(
      Row(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: color, width: 1.5),
            ),
            child: Center(
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Icon(step['icon'] as IconData, color: color, size: 24.0),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color,
                  ),
                ),
                Text(
                  step['desc'] as String,
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
    if (i < pipelineSteps.length - 1) {
      pipelineRows.add(
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
          child: Icon(
            Icons.arrow_downward,
            size: 18.0,
            color: Colors.grey.shade500,
          ),
        ),
      );
    }
  }

  final pipelineBox = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.amber.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: pipelineRows,
    ),
  );

  // ============================================================
  // SECTION 8: Mock DevTools "Image sizes" panel
  // ============================================================
  print('=== Section 8: Mock DevTools panel ===');

  final mockHeader = Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.developer_mode, color: Colors.amber.shade300, size: 16.0),
        SizedBox(width: 8.0),
        Text(
          'DevTools  >  Inspector  >  Image sizes',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade100,
          ),
        ),
        Spacer(),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: Colors.red.shade400,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: Colors.amber.shade400,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            shape: BoxShape.circle,
          ),
        ),
      ],
    ),
  );

  final mockRows = <Widget>[];
  for (var i = 0; i < infos.length; i++) {
    final info = infos[i];
    final dec = info.decodedSizeInBytes;
    final disp = info.displaySizeInBytes;
    final ratio = disp == 0 ? 0.0 : dec / disp;
    final overDecoded = ratio > 4.0;
    mockRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.grey.shade900
              : Colors.grey.shade800.withValues(alpha: 0.85),
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade700, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22.0,
              child: overDecoded
                  ? Icon(Icons.cancel, color: Colors.red.shade300, size: 14.0)
                  : Icon(
                      Icons.check_circle,
                      color: Colors.green.shade300,
                      size: 14.0,
                    ),
            ),
            Expanded(
              child: Text(
                info.source ?? '<null>',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: overDecoded
                      ? Colors.red.shade200
                      : Colors.grey.shade300,
                ),
              ),
            ),
            SizedBox(
              width: 70.0,
              child: Text(
                _formatBytes(dec),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.purple.shade200,
                ),
              ),
            ),
            SizedBox(
              width: 70.0,
              child: Text(
                _formatBytes(disp),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.teal.shade200,
                ),
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                overDecoded
                    ? 'over-decoded ${ratio.toStringAsFixed(0)}x'
                    : 'ok',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: overDecoded
                      ? Colors.red.shade300
                      : Colors.green.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final mockPanel = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        mockHeader,
        ...mockRows,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.warning, color: Colors.amber.shade400, size: 12.0),
              SizedBox(width: 6.0),
              Text(
                '${infos.length} images, '
                '${_countOverDecoded(infos)} flagged as over-decoded',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.amber.shade200,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final footguns = [
    {
      'title': '`source` is nullable',
      'desc':
          'Procedurally generated images (e.g. CustomPainter snapshots) '
          'have no source. Always null-check before logging.',
      'icon': Icons.help_outline,
    },
    {
      'title': 'sizes are double, not int',
      'desc':
          '`imageSize` and `displaySize` use `Size` (double w/h). '
          'Use `.toInt()` for display, but byte math stays in double.',
      'icon': Icons.straighten,
    },
    {
      'title': 'byte calc assumes RGBA8',
      'desc':
          'decodedSizeInBytes = w * h * 4 — exact only for 32-bit RGBA. '
          'Compressed in-memory or grayscale formats will differ.',
      'icon': Icons.warning_amber,
    },
  ];

  final footgunChildren = <Widget>[];
  for (final fg in footguns) {
    footgunChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.red.shade300, width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(fg['icon'] as IconData, color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.red.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.red.shade800,
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

  final footgunBox = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: footgunChildren,
    ),
  );

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');

  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepOrange.shade400,
          Colors.amber.shade600,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.4),
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
            Icon(Icons.flag, color: Colors.white, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRecapLine('5 fields: source, imageSize, displaySize, decoded/display bytes'),
        _buildRecapLine('byte calc = w * h * 4 (RGBA8 assumption)'),
        _buildRecapLine('toJson() feeds the imageSizes ServiceExtension'),
        _buildRecapLine('== compares all of source, imageSize, displaySize'),
        _buildRecapLine('DevTools surfaces over-decoded images via this'),
        _buildRecapLine('reduce decode size with cacheWidth/cacheHeight'),
      ],
    ),
  );

  print('ImageSizeInfo Deep Demo completed');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.amber.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section 1
          titleBanner,
          SizedBox(height: 24.0),

          // Section 2
          _sectionLabel('1. Anatomy'),
          anatomyBox,
          SizedBox(height: 24.0),

          // Section 3
          _sectionLabel('2. Six example instances'),
          ...exampleCards,
          SizedBox(height: 24.0),

          // Section 4
          _sectionLabel('3. Memory waste calculator'),
          wasteTable,
          SizedBox(height: 24.0),

          // Section 5
          _sectionLabel('4. toJson() showcase'),
          jsonShowcase,
          SizedBox(height: 24.0),

          // Section 6
          _sectionLabel('5. Equality (==) demonstration'),
          equalityCards,
          SizedBox(height: 24.0),

          // Section 7
          _sectionLabel('6. Telemetry pipeline'),
          pipelineBox,
          SizedBox(height: 24.0),

          // Section 8
          _sectionLabel('7. Mock DevTools "Image sizes" panel'),
          mockPanel,
          SizedBox(height: 24.0),

          // Section 9
          _sectionLabel('8. Footguns'),
          footgunBox,
          SizedBox(height: 24.0),

          // Section 10
          _sectionLabel('9. Recap'),
          recap,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ------------------------------------------------------------
// Helpers
// ------------------------------------------------------------

Widget _sectionLabel(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange.shade900,
      ),
    ),
  );
}

Widget _buildWasteHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.deepOrange.shade900,
      ),
    ),
  );
}

String _formatBytes(int bytes) {
  if (bytes < 1024) return '${bytes}B';
  if (bytes < 1024 * 1024) {
    return '${(bytes / 1024).toStringAsFixed(1)}KB';
  }
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
}

int _countOverDecoded(List<ImageSizeInfo> list) {
  var n = 0;
  for (final info in list) {
    final dec = info.decodedSizeInBytes;
    final disp = info.displaySizeInBytes;
    if (disp == 0) continue;
    if (dec / disp > 4.0) n += 1;
  }
  return n;
}

Widget _buildEqCard(
  String title,
  bool result,
  String reason,
  String left,
  String right,
) {
  final color = result ? Colors.green : Colors.red;
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              result ? Icons.check_circle : Icons.cancel,
              color: color,
              size: 18.0,
            ),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          result ? 'true' : 'false',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          reason,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade800),
        ),
        SizedBox(height: 6.0),
        Text(
          'L: $left',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: Colors.blueGrey.shade700,
          ),
        ),
        Text(
          'R: $right',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: Colors.blueGrey.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecapLine(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
