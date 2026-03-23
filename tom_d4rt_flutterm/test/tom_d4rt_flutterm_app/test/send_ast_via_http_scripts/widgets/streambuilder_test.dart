// ignore_for_file: avoid_print
// D4rt test script: Tests StreamBuilder from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StreamBuilder test executing');

  // Test StreamBuilder<String> with Stream.value
  final sb1 = StreamBuilder<String>(
    stream: Stream.value('test'),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Text(snapshot.data ?? 'waiting');
    },
  );
  print('StreamBuilder<String>(Stream.value(test)) created');

  // Test StreamBuilder<int> with Stream.value
  final sb2 = StreamBuilder<int>(
    stream: Stream.value(42),
    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      return Text('Stream int: ${snapshot.data ?? 0}');
    },
  );
  print('StreamBuilder<int>(Stream.value(42)) created');

  // Test StreamBuilder<String> with null stream
  final sb3 = StreamBuilder<String>(
    stream: null,
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Text('No stream: ${snapshot.connectionState}');
    },
  );
  print('StreamBuilder<String>(stream: null) created');

  // Test StreamBuilder with initialData
  final sb4 = StreamBuilder<String>(
    stream: Stream.value('Updated'),
    initialData: 'Initial',
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Text('Data: ${snapshot.data}');
    },
  );
  print('StreamBuilder<String> with initialData created');

  // Test StreamBuilder with Stream.empty
  final sb5 = StreamBuilder<String>(
    stream: Stream.empty(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Text('Empty stream: ${snapshot.connectionState}');
    },
  );
  print('StreamBuilder<String>(Stream.empty()) created');

  print('StreamBuilder test completed');
  return Column(children: [sb1, sb2, sb3, sb4, sb5]);
}
