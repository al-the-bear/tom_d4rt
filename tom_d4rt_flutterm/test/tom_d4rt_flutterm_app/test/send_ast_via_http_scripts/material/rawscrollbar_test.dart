// ignore_for_file: avoid_print
// D4rt test script: Tests RawScrollbar from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawScrollbar test executing');

  // Variation 1: Basic RawScrollbar wrapping ListView
  final widget1 = RawScrollbar(
    child: ListView.builder(
      itemCount: 30,
      itemBuilder: (BuildContext ctx, int index) {
        return ListTile(title: Text('Item $index'));
      },
    ),
  );
  print('RawScrollbar(basic, ListView.builder) created');

  // Variation 2: RawScrollbar with thumbVisibility
  final widget2 = RawScrollbar(
    thumbVisibility: true,
    child: ListView(
      children: [
        Container(
          height: 80,
          color: Colors.red.shade100,
          child: Center(child: Text('Red')),
        ),
        Container(
          height: 80,
          color: Colors.blue.shade100,
          child: Center(child: Text('Blue')),
        ),
        Container(
          height: 80,
          color: Colors.green.shade100,
          child: Center(child: Text('Green')),
        ),
        Container(
          height: 80,
          color: Colors.orange.shade100,
          child: Center(child: Text('Orange')),
        ),
        Container(
          height: 80,
          color: Colors.purple.shade100,
          child: Center(child: Text('Purple')),
        ),
        Container(
          height: 80,
          color: Colors.teal.shade100,
          child: Center(child: Text('Teal')),
        ),
      ],
    ),
  );
  print('RawScrollbar(thumbVisibility: true) created');

  // Variation 3: RawScrollbar with thickness
  final widget3 = RawScrollbar(
    thickness: 12.0,
    thumbVisibility: true,
    child: SingleChildScrollView(
      child: Column(
        children: List.generate(20, (i) {
          return Container(
            height: 50,
            color: i % 2 == 0 ? Colors.grey.shade200 : Colors.white,
            child: Center(child: Text('Row $i')),
          );
        }),
      ),
    ),
  );
  print('RawScrollbar(thickness: 12) created');

  // Variation 4: RawScrollbar with thumbColor
  final widget4 = RawScrollbar(
    thumbColor: Colors.red,
    thumbVisibility: true,
    child: ListView.builder(
      itemCount: 25,
      itemBuilder: (ctx, i) => ListTile(title: Text('Red thumb item $i')),
    ),
  );
  print('RawScrollbar(thumbColor: red) created');

  // Variation 5: RawScrollbar with radius
  final widget5 = RawScrollbar(
    radius: Radius.circular(8.0),
    thumbVisibility: true,
    thumbColor: Colors.blue,
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (ctx, i) => ListTile(title: Text('Rounded thumb $i')),
    ),
  );
  print('RawScrollbar(radius: 8) created');

  // Variation 6: RawScrollbar with fadeDuration and timeToFade
  final widget6 = RawScrollbar(
    fadeDuration: Duration(milliseconds: 500),
    timeToFade: Duration(seconds: 2),
    child: ListView.builder(
      itemCount: 15,
      itemBuilder: (ctx, i) => ListTile(title: Text('Fade item $i')),
    ),
  );
  print('RawScrollbar(fadeDuration, timeToFade) created');

  // Variation 7: RawScrollbar with padding
  final widget7 = RawScrollbar(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    thumbVisibility: true,
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (ctx, i) => ListTile(title: Text('Padded item $i')),
    ),
  );
  print('RawScrollbar(padding) created');

  // Variation 8: RawScrollbar with crossAxisMargin and mainAxisMargin
  final widget8 = RawScrollbar(
    crossAxisMargin: 4.0,
    mainAxisMargin: 8.0,
    thumbVisibility: true,
    thumbColor: Colors.green,
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (ctx, i) => ListTile(title: Text('Margined item $i')),
    ),
  );
  print('RawScrollbar(crossAxisMargin, mainAxisMargin) created');

  // Variation 9: RawScrollbar with minThumbLength
  final widget9 = RawScrollbar(
    minThumbLength: 48.0,
    thumbVisibility: true,
    child: ListView.builder(
      itemCount: 100,
      itemBuilder: (ctx, i) => ListTile(title: Text('Min length $i')),
    ),
  );
  print('RawScrollbar(minThumbLength: 48) created');

  // Variation 10: RawScrollbar interactive (trackVisibility)
  final widget10 = RawScrollbar(
    thumbVisibility: true,
    trackVisibility: true,
    trackColor: Colors.grey.shade200,
    trackBorderColor: Colors.grey.shade400,
    trackRadius: Radius.circular(4.0),
    interactive: true,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (ctx, i) => ListTile(title: Text('Track visible $i')),
    ),
  );
  print(
    'RawScrollbar(trackVisibility, trackColor, trackBorderColor, interactive) created',
  );

  print('RawScrollbar test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      SizedBox(height: 8),
      Expanded(child: widget4),
      SizedBox(height: 8),
      Expanded(child: widget10),
    ],
  );
}
