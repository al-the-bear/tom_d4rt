// Tool to create AstBundle JSON and send to the Flutter test app
import 'dart:convert';
import 'dart:io';

import 'package:tom_d4rt_flutterm/tom_d4rt_flutterm.dart';

void main() async {
  final d4rt = FlutterD4rt();

  // Create a widget that uses Color.fromARGB (dart:ui type)
  final bundle = await d4rt.interpreter.createBundleFromSource('''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Container(
    width: 200.0,
    height: 100.0,
    color: Color.fromARGB(255, 255, 100, 50),
    child: Center(
      child: Text(
        'dart:ui Color works!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
''');

  final json = jsonEncode(bundle.toJson());
  print('Bundle size: ${json.length} bytes');

  // Send to the app
  final client = HttpClient();
  final request = await client.postUrl(
    Uri.parse('http://localhost:4247/build'),
  );
  request.headers.contentType = ContentType.json;
  request.write(json);
  final response = await request.close();
  final responseBody = await utf8.decoder.bind(response).join();

  print('Response: ${response.statusCode}');
  print('Body: $responseBody');

  client.close();
}
