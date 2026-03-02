// D4rt test script: Tests FutureBuilder from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FutureBuilder test executing');

  // Test FutureBuilder<String> with Future.value
  final fb1 = FutureBuilder<String>(
    future: Future.value('Hello'),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.hasData) return Text(snapshot.data!);
      return CircularProgressIndicator();
    },
  );
  print('FutureBuilder<String>(Future.value(Hello)) created');

  // Test FutureBuilder<int> with Future.value
  final fb2 = FutureBuilder<int>(
    future: Future.value(42),
    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      if (snapshot.hasData) return Text('Value: ${snapshot.data}');
      return CircularProgressIndicator();
    },
  );
  print('FutureBuilder<int>(Future.value(42)) created');

  // Test FutureBuilder<String> with null future
  final fb3 = FutureBuilder<String>(
    future: null,
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Text('No future: ${snapshot.connectionState}');
    },
  );
  print('FutureBuilder<String>(future: null) created');

  // Test FutureBuilder with initialData
  final fb4 = FutureBuilder<String>(
    future: Future.value('Updated'),
    initialData: 'Initial',
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Text('Data: ${snapshot.data}');
    },
  );
  print('FutureBuilder<String> with initialData created');

  // Test FutureBuilder<bool> with Future.value
  final fb5 = FutureBuilder<bool>(
    future: Future.value(true),
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.hasData) {
        return Icon(
          snapshot.data! ? Icons.check : Icons.close,
          color: snapshot.data! ? Colors.green : Colors.red,
        );
      }
      return CircularProgressIndicator();
    },
  );
  print('FutureBuilder<bool>(Future.value(true)) created');

  print('FutureBuilder test completed');
  return Column(children: [
    fb1,
    fb2,
    fb3,
    fb4,
    fb5,
  ]);
}
