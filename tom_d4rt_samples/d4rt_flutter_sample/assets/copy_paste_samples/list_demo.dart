// Copy-paste snippet: a scrollable list built from a Dart collection.
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  final fruits = <String>['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  return Scaffold(
    appBar: AppBar(title: const Text('List')),
    body: ListView.builder(
      itemCount: fruits.length,
      itemBuilder: (context, i) => ListTile(
        leading: CircleAvatar(child: Text('${i + 1}')),
        title: Text(fruits[i]),
      ),
    ),
  );
}
