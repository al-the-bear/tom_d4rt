// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NetworkImageLoadException from package:flutter/painting.dart
// Deep Demo: Visual exploration of HTTP failure cases that raise
// NetworkImageLoadException, including anatomy, status code reference,
// catching patterns, URI handling, diagnostics, real-world handler patterns,
// footguns, and a final recap.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NetworkImageLoadException Deep Demo executing');

  // ============================================================
  // SECTION DATA: A canonical set of exceptions for cards.
  // ============================================================
  // We construct several NetworkImageLoadException instances that
  // represent the most common HTTP failure categories so that we
  // can render each as a card and reuse the data across sections.
  // ============================================================
  final List<NetworkImageLoadException> exceptions =
      <NetworkImageLoadException>[
    NetworkImageLoadException(
      statusCode: 400,
      uri: Uri.parse('https://cdn.example.com/images/avatars/u_42.png'),
    ),
    NetworkImageLoadException(
      statusCode: 401,
      uri: Uri.parse('https://api.example.com/private/asset/secret.jpg'),
    ),
    NetworkImageLoadException(
      statusCode: 403,
      uri: Uri.parse('https://images.example.com/locked/banner.webp'),
    ),
    NetworkImageLoadException(
      statusCode: 404,
      uri: Uri.parse('https://cdn.example.com/missing/photo.png'),
    ),
    NetworkImageLoadException(
      statusCode: 500,
      uri: Uri.parse('https://broken.example.com/internal/icon.gif'),
    ),
    NetworkImageLoadException(
      statusCode: 503,
      uri: Uri.parse('https://overloaded.example.com/maintenance/logo.svg'),
    ),
  ];

  for (final NetworkImageLoadException e in exceptions) {
    print('Built exception: status=${e.statusCode} uri=${e.uri}');
    print('  toString=$e');
  }
  print('Total seeded exceptions: ${exceptions.length}');

  // ============================================================
  // SECTION 1: Title banner with class summary
  // ============================================================
  print('=== Section 1: Title banner ===');

  final Widget titleBanner = Container(
    width: double.infinity,
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.red.shade700,
          Colors.deepOrange.shade500,
          Colors.amber.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
          blurRadius: 28.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.broken_image, size: 44.0, color: Colors.white),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'NetworkImageLoadException',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Thrown by NetworkImage when an HTTP image request fails '
          'with a non-200 status code. Implements Exception and Diagnosticable. '
          'Carries the offending Uri and the received statusCode.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'package:flutter/painting.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title banner constructed');

  // ============================================================
  // SECTION 2: Anatomy - statusCode, uri, derived _message
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final NetworkImageLoadException anatomyExample = exceptions[3]; // 404
  print('Anatomy example uri=${anatomyExample.uri} '
      'status=${anatomyExample.statusCode}');

  final Widget anatomyCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.red.shade50,
          Colors.orange.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '2. Anatomy of an Exception Instance',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _buildFieldRow(
          'statusCode',
          anatomyExample.statusCode.toString(),
          'int — HTTP status code returned by the server',
          Colors.red.shade700,
        ),
        SizedBox(height: 8.0),
        _buildFieldRow(
          'uri',
          anatomyExample.uri.toString(),
          'Uri — the resolved Uri the loader attempted to fetch',
          Colors.deepOrange.shade700,
        ),
        SizedBox(height: 8.0),
        _buildFieldRow(
          'toString()',
          anatomyExample.toString(),
          'String — generated message including status and uri',
          Colors.amber.shade800,
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Text(
            'Constructor signature:\n'
            '  NetworkImageLoadException({\n'
            '    required int statusCode,\n'
            '    required Uri uri,\n'
            '  })',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.red.shade900,
            ),
          ),
        ),
      ],
    ),
  );
  print('Anatomy card constructed');

  // ============================================================
  // SECTION 3: Constructor example - one card per status
  // ============================================================
  print('=== Section 3: Constructor cards ===');

  final List<Widget> exceptionCards = exceptions
      .map((NetworkImageLoadException e) => _buildExceptionCard(e))
      .toList();
  print('Built ${exceptionCards.length} exception cards');

  final Widget exceptionsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.grey.shade100,
          Colors.red.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade100, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '3. Constructed Instances',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Six NetworkImageLoadException values built directly via '
          'the constructor. 4xx errors are amber; 5xx errors are red.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        ...exceptionCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 4: HTTP status reference table
  // ============================================================
  print('=== Section 4: Status reference ===');

  final List<List<dynamic>> statusReference = <List<dynamic>>[
    <dynamic>[400, 'Bad Request', 'Malformed URL or unsupported parameters'],
    <dynamic>[401, 'Unauthorized', 'Missing or invalid auth credentials'],
    <dynamic>[403, 'Forbidden', 'Auth ok, but access to resource is denied'],
    <dynamic>[404, 'Not Found', 'Resource is missing or has been removed'],
    <dynamic>[408, 'Request Timeout', 'Server gave up waiting for client'],
    <dynamic>[429, 'Too Many Requests', 'Rate limit exceeded'],
    <dynamic>[500, 'Server Error', 'Generic server-side failure'],
    <dynamic>[502, 'Bad Gateway', 'Upstream proxy returned an invalid response'],
    <dynamic>[503, 'Service Unavailable', 'Service temporarily down/overloaded'],
    <dynamic>[504, 'Gateway Timeout', 'Upstream server did not reply in time'],
  ];

  final List<Widget> statusChips = statusReference
      .map((List<dynamic> row) => _buildStatusChip(
            row[0] as int,
            row[1] as String,
            row[2] as String,
          ))
      .toList();

  final Widget statusReferenceSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.amber.shade50,
          Colors.red.shade50,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '4. HTTP Status Reference',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Any non-200 status code raises NetworkImageLoadException. '
          'These are the codes that occur most often in image pipelines.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 60.0,
                child: Text('Code',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.red.shade900)),
              ),
              SizedBox(
                width: 140.0,
                child: Text('Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.red.shade900)),
              ),
              Expanded(
                child: Text('Typical cause',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.red.shade900)),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        ...statusChips,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Catching the exception via errorBuilder
  // ============================================================
  print('=== Section 5: Catching ===');

  final String errorBuilderCode = 'Image.network(\n'
      '  url,\n'
      '  errorBuilder: (BuildContext ctx, Object err, StackTrace? st) {\n'
      '    if (err is NetworkImageLoadException) {\n'
      '      // Specific HTTP failure: branch on err.statusCode.\n'
      '      if (err.statusCode == 404) {\n'
      '        return _placeholder("Image not found");\n'
      '      }\n'
      '      if (err.statusCode == 401 || err.statusCode == 403) {\n'
      '        return _placeholder("Access denied");\n'
      '      }\n'
      '      if (err.statusCode >= 500) {\n'
      '        return _placeholder("Service unavailable");\n'
      '      }\n'
      '      return _placeholder("HTTP \${err.statusCode}");\n'
      '    }\n'
      '    // Other failures: SocketException, FormatException, ...\n'
      '    return Icon(Icons.error_outline);\n'
      '  },\n'
      ')';

  final Widget catchingSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.grey.shade900,
          Colors.red.shade900,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '5. Catching with Image.network errorBuilder',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade200,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Image widgets surface load failures via errorBuilder. '
          'Type-test against NetworkImageLoadException to branch on '
          'statusCode without parsing strings.',
          style: TextStyle(fontSize: 12.0, color: Colors.amber.shade100),
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(errorBuilderCode, Colors.amber.shade100),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Differences vs other image errors
  // ============================================================
  print('=== Section 6: Differences ===');

  final List<List<String>> errorComparison = <List<String>>[
    <String>[
      'NetworkImageLoadException',
      'Server replied non-200',
      'statusCode + uri available',
    ],
    <String>[
      'HttpException',
      'Generic dart:io HTTP failure',
      'Often wraps lower-level transport issues',
    ],
    <String>[
      'SocketException',
      'TCP/DNS/connection refused',
      'No HTTP response was received',
    ],
    <String>[
      'FormatException',
      'Body did not parse as image',
      'Server returned 200 but bytes were not an image',
    ],
    <String>[
      'TimeoutException',
      'Request did not finish in time',
      'Use HttpClient.connectionTimeout / future.timeout',
    ],
    <String>[
      'OSError',
      'OS-level I/O error',
      'Disk cache write failures, permission issues',
    ],
  ];

  final List<Widget> errorComparisonRows = errorComparison
      .map((List<String> row) =>
          _buildComparisonRow(row[0], row[1], row[2]))
      .toList();

  final Widget differencesSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.orange.shade50,
          Colors.amber.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '6. Differences vs Other Image Errors',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 170.0,
                child: Text('Error type',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.deepOrange.shade900)),
              ),
              SizedBox(
                width: 150.0,
                child: Text('Trigger',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.deepOrange.shade900)),
              ),
              Expanded(
                child: Text('Notes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.deepOrange.shade900)),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        ...errorComparisonRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: URI handling - secure/insecure, query, escapes
  // ============================================================
  print('=== Section 7: URI handling ===');

  final List<Uri> uriSamples = <Uri>[
    Uri.parse('https://cdn.example.com/photos/cat.png'),
    Uri.parse('http://insecure.example.com/legacy.jpg'),
    Uri.parse(
        'https://images.example.com/p/banner.webp?w=600&h=400&fit=cover'),
    Uri.parse('https://files.example.com/My%20Folder/Image%20%231.png'),
    Uri.parse(
        'https://auth.example.com/cdn/asset.png?token=abc.def.ghi&exp=123'),
    Uri.parse('https://shard-3.example.com:8443/raw/asset_v2.bin'),
  ];

  for (final Uri u in uriSamples) {
    final NetworkImageLoadException uriExample = NetworkImageLoadException(
      statusCode: 404,
      uri: u,
    );
    print('Uri example scheme=${u.scheme} host=${u.host} '
        'path=${u.path} query=${u.query} -> $uriExample');
  }

  final List<Widget> uriCards = uriSamples
      .map((Uri u) => _buildUriCard(u))
      .toList();

  final Widget uriHandlingSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.red.shade50,
          Colors.amber.shade50,
          Colors.orange.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '7. URI Handling',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'NetworkImageLoadException keeps the entire Uri object. The Uri '
          'preserves scheme, port, path, query, fragment, and percent '
          'escapes — never reconstruct it from a string.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        ...uriCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Diagnostic dump - render toString() in monospace
  // ============================================================
  print('=== Section 8: Diagnostic dump ===');

  final NetworkImageLoadException dumpExample = NetworkImageLoadException(
    statusCode: 503,
    uri: Uri.parse('https://overloaded.example.com/maintenance/logo.svg'),
  );
  final String dumpString = dumpExample.toString();
  print('dumpExample.toString() = $dumpString');

  final Widget diagnosticSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.grey.shade800,
          Colors.red.shade900,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '8. Diagnostic Dump',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade200,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'NetworkImageLoadException implements Diagnosticable. The '
          'default toString() reports both statusCode and uri.',
          style: TextStyle(fontSize: 12.0, color: Colors.amber.shade100),
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          'final NetworkImageLoadException e =\n'
          '    NetworkImageLoadException(\n'
          '      statusCode: ${dumpExample.statusCode},\n'
          '      uri: Uri.parse(\'${dumpExample.uri}\'),\n'
          '    );\n'
          '\n'
          'print(e.toString());\n'
          '// $dumpString',
          Colors.amber.shade100,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade400, width: 1.0),
          ),
          child: Text(
            dumpString,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.amber.shade100,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Real-world handler patterns
  // ============================================================
  print('=== Section 9: Real-world handler patterns ===');

  final String retryPolicyCode = 'Future<Uint8List> loadWithRetry(\n'
      '  Uri uri, {\n'
      '  int maxAttempts = 3,\n'
      '}) async {\n'
      '  Object? lastError;\n'
      '  for (int attempt = 1; attempt <= maxAttempts; attempt++) {\n'
      '    try {\n'
      '      return await _fetchBytes(uri);\n'
      '    } on NetworkImageLoadException catch (e) {\n'
      '      lastError = e;\n'
      '      // Only retry transient codes.\n'
      '      final bool transient =\n'
      '          e.statusCode == 408 ||\n'
      '          e.statusCode == 429 ||\n'
      '          e.statusCode >= 500;\n'
      '      if (!transient) rethrow;\n'
      '      await Future<void>.delayed(\n'
      '        Duration(milliseconds: 200 * attempt),\n'
      '      );\n'
      '    }\n'
      '  }\n'
      '  throw lastError!;\n'
      '}';

  final String fallbackAssetCode = 'Image.network(\n'
      '  remoteUrl,\n'
      '  errorBuilder: (BuildContext ctx, Object err, StackTrace? st) {\n'
      '    if (err is NetworkImageLoadException) {\n'
      '      // Show a bundled asset as a graceful fallback.\n'
      '      return Image.asset(\'assets/placeholder.png\');\n'
      '    }\n'
      '    return Container(color: Colors.grey);\n'
      '  },\n'
      ')';

  final String telemetryCode = 'void reportImageFailure(Object err) {\n'
      '  if (err is NetworkImageLoadException) {\n'
      '    analytics.event(\n'
      '      name: \'image_load_failed\',\n'
      '      data: <String, Object?>{\n'
      '        \'status\': err.statusCode,\n'
      '        \'host\': err.uri.host,\n'
      '        \'path\': err.uri.path,\n'
      '      },\n'
      '    );\n'
      '  }\n'
      '}';

  final String userMessageCode = 'String userMessageFor(Object err) {\n'
      '  if (err is NetworkImageLoadException) {\n'
      '    if (err.statusCode == 404) return \'Image is no longer available.\';\n'
      '    if (err.statusCode == 401) return \'Please sign in to view this image.\';\n'
      '    if (err.statusCode == 403) return \'You do not have access to this image.\';\n'
      '    if (err.statusCode >= 500) return \'Service is temporarily unavailable.\';\n'
      '    return \'Image could not be loaded (\${err.statusCode}).\';\n'
      '  }\n'
      '  return \'Image could not be loaded.\';\n'
      '}';

  final Widget patternsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.amber.shade50,
          Colors.orange.shade100,
          Colors.red.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.2),
          blurRadius: 18.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '9. Real-world Handler Patterns',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _buildPatternBlock(
          'Retry policy (transient only)',
          retryPolicyCode,
          Colors.red.shade700,
        ),
        SizedBox(height: 12.0),
        _buildPatternBlock(
          'Fallback asset',
          fallbackAssetCode,
          Colors.deepOrange.shade700,
        ),
        SizedBox(height: 12.0),
        _buildPatternBlock(
          'Telemetry hook',
          telemetryCode,
          Colors.amber.shade800,
        ),
        SizedBox(height: 12.0),
        _buildPatternBlock(
          'User-friendly message mapping',
          userMessageCode,
          Colors.brown.shade700,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final List<List<String>> footguns = <List<String>>[
    <String>[
      'Assuming statusCode is "always populated"',
      'It is — it is required and non-nullable. The footgun is the '
          'opposite: assuming a statusCode of 0 means "no response". A '
          'NetworkImageLoadException always implies the server replied; '
          'transport failures use a different exception type.',
    ],
    <String>[
      'Regex-parsing the message string',
      'The toString() format is not part of the public contract. Always '
          'inspect statusCode and uri directly instead of grepping the '
          'message — the wording can change between Flutter versions.',
    ],
    <String>[
      'Missing errorBuilder',
      'Without errorBuilder on Image.network, the exception bubbles up '
          'and renders the red error widget in debug, or a blank box in '
          'release. Always provide a fallback for user-facing images.',
    ],
    <String>[
      'Image cache poisoning',
      'PaintingBinding.instance.imageCache caches failed loads. Call '
          'imageCache.evict(NetworkImage(url)) (or clearLiveImages) after '
          'you fix a permission issue, otherwise the broken state sticks.',
    ],
    <String>[
      'Trusting the raw uri in the UI',
      'Uri may include tokens or signed query strings. Never display the '
          'full uri to the end user — log err.uri.host and err.uri.path '
          'separately, and strip the query string before showing it.',
    ],
    <String>[
      'Catching Exception too broadly',
      'A bare on Exception catches NetworkImageLoadException together '
          'with FormatException, HttpException, etc. Catch the specific '
          'type when you want status-code branching.',
    ],
  ];

  final List<Widget> footgunCards = footguns
      .map((List<String> row) => _buildFootgunCard(row[0], row[1]))
      .toList();

  final Widget footgunsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.red.shade100,
          Colors.deepOrange.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade400, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade900, size: 28.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                '10. Footguns',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...footgunCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final List<List<String>> recapPoints = <List<String>>[
    <String>[
      'Type',
      'Concrete subclass of Exception, also Diagnosticable.',
    ],
    <String>[
      'Origin',
      'Thrown inside NetworkImage._loadAsync when status != 200.',
    ],
    <String>[
      'Fields',
      'statusCode (int) and uri (Uri); both required.',
    ],
    <String>[
      'Catch site',
      'Image.network errorBuilder, or your own try/catch around fetches.',
    ],
    <String>[
      'Branching',
      'Always read err.statusCode — never parse toString().',
    ],
    <String>[
      'Recovery',
      'Retry transient (5xx, 408, 429), fall back for permanent (4xx).',
    ],
    <String>[
      'Telemetry',
      'Log host and path of err.uri, never the raw query string.',
    ],
  ];

  final List<Widget> recapItems = recapPoints
      .map((List<String> row) => _buildRecapRow(row[0], row[1]))
      .toList();

  final Widget recapSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.red.shade700,
          Colors.deepOrange.shade400,
          Colors.amber.shade300,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
          blurRadius: 28.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book_rounded, color: Colors.white, size: 30.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                '11. Recap',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...recapItems,
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'NetworkImageLoadException is the structured signal that the '
            'image pipeline tried, the server answered, and the answer '
            'was not 200 OK. Treat it as data — branch on statusCode, '
            'log the uri host/path, and prefer asset fallbacks for the '
            'human in front of the screen.',
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

  print('NetworkImageLoadException Deep Demo build() complete');

  // ============================================================
  // FINAL LAYOUT: Scaffold > SingleChildScrollView > Column
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
          anatomyCard,
          exceptionsSection,
          statusReferenceSection,
          catchingSection,
          differencesSection,
          uriHandlingSection,
          diagnosticSection,
          patternsSection,
          footgunsSection,
          recapSection,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

// Helper: Build a "label : value" row with description for the anatomy card.
Widget _buildFieldRow(
  String label,
  String value,
  String description,
  Color accent,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a single exception card. Color depends on status class.
Widget _buildExceptionCard(NetworkImageLoadException e) {
  final bool isServerError = e.statusCode >= 500;
  final Color accent = isServerError ? Colors.red.shade700 : Colors.amber.shade800;
  final Color fillStart = isServerError ? Colors.red.shade50 : Colors.amber.shade50;
  final Color fillEnd =
      isServerError ? Colors.red.shade100 : Colors.amber.shade100;
  final IconData icon = isServerError ? Icons.dns : Icons.broken_image;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[fillStart, fillEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accent, width: 2.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: accent, size: 18.0),
              SizedBox(height: 2.0),
              Text(
                e.statusCode.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: accent,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isServerError ? 'Server-side failure (5xx)' : 'Client-side failure (4xx)',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                e.uri.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade900,
                ),
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  e.toString(),
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade800,
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

// Helper: Build a row in the HTTP status reference table.
Widget _buildStatusChip(int code, String name, String reason) {
  final bool serverError = code >= 500;
  final Color accent =
      serverError ? Colors.red.shade700 : Colors.amber.shade800;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 60.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              code.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        SizedBox(
          width: 132.0,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: accent,
            ),
          ),
        ),
        Expanded(
          child: Text(
            reason,
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a row in the differences-vs-other-errors table.
Widget _buildComparisonRow(String type, String trigger, String notes) {
  final bool isFocus = type == 'NetworkImageLoadException';
  final Color rowAccent =
      isFocus ? Colors.red.shade700 : Colors.deepOrange.shade400;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    margin: EdgeInsets.symmetric(vertical: 2.0),
    decoration: BoxDecoration(
      color: isFocus
          ? Colors.red.shade50
          : Colors.white.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(6.0),
      border: isFocus
          ? Border.all(color: Colors.red.shade300, width: 1.0)
          : null,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
              color: rowAccent,
            ),
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            trigger,
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade900),
          ),
        ),
        Expanded(
          child: Text(
            notes,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a card showing how a Uri decomposes.
Widget _buildUriCard(Uri uri) {
  final bool isSecure = uri.scheme == 'https';
  final Color accent = isSecure ? Colors.green.shade700 : Colors.red.shade700;
  final IconData icon = isSecure ? Icons.lock : Icons.lock_open;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 16.0),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                isSecure ? 'secure' : 'insecure',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          uri.toString(),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        _buildUriPart('scheme', uri.scheme),
        _buildUriPart('host', uri.host),
        _buildUriPart('port', uri.port.toString()),
        _buildUriPart('path', uri.path),
        _buildUriPart('query', uri.query.isEmpty ? '(none)' : uri.query),
      ],
    ),
  );
}

// Helper: Build a single "label : value" row inside a Uri card.
Widget _buildUriPart(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 60.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a labelled handler-pattern code block.
Widget _buildPatternBlock(String title, String code, Color accent) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        _buildCodeBlock(code, Colors.amber.shade100),
      ],
    ),
  );
}

// Helper: Build a footgun warning card.
Widget _buildFootgunCard(String title, String body) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade400, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.dangerous_outlined,
                color: Colors.red.shade700, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade800,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a single "label - value" row in the recap card.
Widget _buildRecapRow(String label, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 90.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            body,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a dark monospaced code block.
Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.amber.shade700, width: 1.0),
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
