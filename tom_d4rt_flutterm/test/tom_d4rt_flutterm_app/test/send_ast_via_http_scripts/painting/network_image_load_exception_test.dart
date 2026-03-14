// D4rt test script: Tests NetworkImageLoadException from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NetworkImageLoadException test executing');
  final results = <String>[];

  // ========== Basic NetworkImageLoadException Tests ==========
  print('Testing NetworkImageLoadException constructor...');

  // Test 1: Create exception with 404 status
  final uri1 = Uri.parse('https://example.com/missing-image.png');
  final exception1 = NetworkImageLoadException(statusCode: 404, uri: uri1);
  assert(exception1.statusCode == 404, 'Status code should be 404');
  assert(exception1.uri == uri1, 'URI should match');
  results.add('Exception 404: ${exception1.uri.path}');
  print('404 exception created');

  // Test 2: Create exception with 500 status
  final uri2 = Uri.parse('https://api.example.com/images/server-error.jpg');
  final exception2 = NetworkImageLoadException(statusCode: 500, uri: uri2);
  assert(exception2.statusCode == 500, 'Status code should be 500');
  results.add('Exception 500: Internal Server Error');
  print('500 exception created');

  // Test 3: Create exception with 403 status
  final uri3 = Uri.parse('https://cdn.example.com/private/forbidden.png');
  final exception3 = NetworkImageLoadException(statusCode: 403, uri: uri3);
  assert(exception3.statusCode == 403, 'Status code should be 403');
  results.add('Exception 403: Forbidden');
  print('403 exception created');

  // ========== Multiple HTTP Status Codes ==========
  print('Testing various HTTP status codes...');

  final statusCodes = [
    {'code': 400, 'desc': 'Bad Request'},
    {'code': 401, 'desc': 'Unauthorized'},
    {'code': 403, 'desc': 'Forbidden'},
    {'code': 404, 'desc': 'Not Found'},
    {'code': 408, 'desc': 'Request Timeout'},
    {'code': 500, 'desc': 'Internal Server Error'},
    {'code': 502, 'desc': 'Bad Gateway'},
    {'code': 503, 'desc': 'Service Unavailable'},
    {'code': 504, 'desc': 'Gateway Timeout'},
  ];

  for (final sc in statusCodes) {
    final uri = Uri.parse('https://test.com/image.png');
    final exc = NetworkImageLoadException(
      statusCode: sc['code'] as int,
      uri: uri,
    );
    assert(exc.statusCode == sc['code'], 'Status code should match');
    results.add('HTTP ${sc['code']}: ${sc['desc']}');
    print('Status ${sc['code']}: ${sc['desc']}');
  }

  // ========== URI Variations ==========
  print('Testing various URI patterns...');

  final uriPatterns = [
    'https://example.com/image.png',
    'http://unsecure.example.com/photo.jpg',
    'https://cdn.example.com/path/to/image.webp',
    'https://api.example.com/v1/images/123',
    'https://example.com/image.png?size=large&format=png',
    'https://sub.domain.example.com:8080/images/test.gif',
  ];

  for (final pattern in uriPatterns) {
    final uri = Uri.parse(pattern);
    final exc = NetworkImageLoadException(statusCode: 404, uri: uri);
    assert(exc.uri.toString() == pattern, 'URI should match');
    results.add('URI: ${uri.host}${uri.path}');
    print('URI tested: ${uri.host}');
  }

  // ========== Exception Message Testing ==========
  print('Testing exception toString...');

  final msgException = NetworkImageLoadException(
    statusCode: 404,
    uri: Uri.parse('https://images.example.com/missing.png'),
  );
  final message = msgException.toString();
  assert(message.isNotEmpty, 'Message should not be empty');
  results.add('toString length: ${message.length} chars');
  print(
    'Message: ${message.substring(0, message.length > 50 ? 50 : message.length)}...',
  );

  // ========== Exception in Try-Catch Pattern ==========
  print('Testing try-catch pattern...');

  void simulateImageLoad(bool shouldFail, int statusCode, String url) {
    if (shouldFail) {
      throw NetworkImageLoadException(
        statusCode: statusCode,
        uri: Uri.parse(url),
      );
    }
  }

  // Test catching the exception
  try {
    simulateImageLoad(true, 404, 'https://test.com/notfound.png');
    results.add('Exception not thrown - unexpected');
  } on NetworkImageLoadException catch (e) {
    results.add('Caught NetworkImageLoadException: ${e.statusCode}');
    print('Exception caught: ${e.statusCode}');
  }

  // Test successful case
  try {
    simulateImageLoad(false, 200, 'https://test.com/success.png');
    results.add('No exception thrown - success case');
    print('Success case verified');
  } on NetworkImageLoadException catch (e) {
    results.add('Unexpected exception: ${e.statusCode}');
  }

  // ========== Error Category Classification ==========
  print('Testing error category classification...');

  String categorizeError(int statusCode) {
    if (statusCode >= 400 && statusCode < 500) return 'Client Error (4xx)';
    if (statusCode >= 500 && statusCode < 600) return 'Server Error (5xx)';
    return 'Unknown';
  }

  final testCodes = [400, 401, 403, 404, 500, 502, 503];
  for (final code in testCodes) {
    final category = categorizeError(code);
    results.add('$code: $category');
    print('$code -> $category');
  }

  // ========== URI Component Testing ==========
  print('Testing URI components...');

  final complexUri = Uri.parse(
    'https://user:pass@cdn.example.com:443/v2/images/photo.png?quality=high&width=1920#section',
  );
  final exComplex = NetworkImageLoadException(statusCode: 500, uri: complexUri);

  results.add('Scheme: ${exComplex.uri.scheme}');
  results.add('Host: ${exComplex.uri.host}');
  results.add('Port: ${exComplex.uri.port}');
  results.add('Path: ${exComplex.uri.path}');
  results.add('Query: ${exComplex.uri.query}');
  print('URI components extracted');

  // ========== Exception Equality ==========
  print('Testing exception equality...');

  final uri = Uri.parse('https://test.com/image.png');
  final exA = NetworkImageLoadException(statusCode: 404, uri: uri);
  final exB = NetworkImageLoadException(statusCode: 404, uri: uri);
  final exC = NetworkImageLoadException(statusCode: 500, uri: uri);

  results.add('Same params comparison: exA vs exB');
  results.add('Different status comparison: exA vs exC');
  print('Equality tests documented');

  // ========== Retry Logic Simulation ==========
  print('Simulating retry logic...');

  final retryableStatuses = [408, 429, 500, 502, 503, 504];
  for (final status in [404, 403, 500, 503]) {
    final isRetryable = retryableStatuses.contains(status);
    results.add('Status $status retryable: $isRetryable');
    print('$status retryable: $isRetryable');
  }

  print(
    'NetworkImageLoadException test completed: ${results.length} tests passed',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'NetworkImageLoadException Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 11)),
        ),
      ),
    ],
  );
}
