// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Wrap widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Wrap test executing');

  // Test basic Wrap
  final basicWrap = Wrap(
    children: List.generate(10, (index) {
      return Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        color: Colors.blue.shade100,
        child: Text('Item $index'),
      );
    }),
  );
  print('Basic Wrap with 10 items created');

  // Test Wrap with spacing
  final spacedWrap = Wrap(
    spacing: 8.0, // horizontal gap
    runSpacing: 12.0, // vertical gap
    children: List.generate(8, (index) {
      return Chip(label: Text('Chip $index'));
    }),
  );
  print('Wrap with spacing=8 and runSpacing=12 created');

  // Test Wrap with alignment
  final centerWrap = Wrap(
    alignment: WrapAlignment.center,
    spacing: 8.0,
    children: List.generate(5, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.green.shade200,
        child: Text('Center $index'),
      );
    }),
  );
  print('Wrap with alignment=center created');

  final endWrap = Wrap(
    alignment: WrapAlignment.end,
    spacing: 8.0,
    children: List.generate(5, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.orange.shade200,
        child: Text('End $index'),
      );
    }),
  );
  print('Wrap with alignment=end created');

  final spaceAroundWrap = Wrap(
    alignment: WrapAlignment.spaceAround,
    spacing: 8.0,
    children: List.generate(4, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.purple.shade200,
        child: Text('Around $index'),
      );
    }),
  );
  print('Wrap with alignment=spaceAround created');

  final spaceBetween = Wrap(
    alignment: WrapAlignment.spaceBetween,
    children: List.generate(3, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.red.shade200,
        child: Text('Between $index'),
      );
    }),
  );
  print('Wrap with alignment=spaceBetween created');

  final spaceEvenly = Wrap(
    alignment: WrapAlignment.spaceEvenly,
    children: List.generate(3, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.teal.shade200,
        child: Text('Evenly $index'),
      );
    }),
  );
  print('Wrap with alignment=spaceEvenly created');

  // Test Wrap with direction
  final horizontalWrap = Wrap(
    direction: Axis.horizontal,
    spacing: 8.0,
    runSpacing: 8.0,
    children: List.generate(6, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.cyan.shade200,
        child: Text('H$index'),
      );
    }),
  );
  print('Wrap with direction=horizontal created');

  final verticalWrap = Wrap(
    direction: Axis.vertical,
    spacing: 8.0,
    runSpacing: 8.0,
    children: List.generate(6, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.pink.shade200,
        child: Text('V$index'),
      );
    }),
  );
  print('Wrap with direction=vertical created');

  // Test Wrap with runAlignment
  final runAlignedWrap = Wrap(
    runAlignment: WrapAlignment.center,
    spacing: 8.0,
    runSpacing: 8.0,
    children: [
      Container(width: 60, height: 30, color: Colors.red),
      Container(width: 80, height: 40, color: Colors.green),
      Container(width: 100, height: 50, color: Colors.blue),
      Container(width: 70, height: 35, color: Colors.orange),
      Container(width: 90, height: 45, color: Colors.purple),
    ],
  );
  print('Wrap with runAlignment=center created');

  // Test Wrap with crossAxisAlignment
  final crossAlignedWrap = Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 8.0,
    children: [
      Container(width: 40, height: 20, color: Colors.red.shade300),
      Container(width: 40, height: 40, color: Colors.green.shade300),
      Container(width: 40, height: 60, color: Colors.blue.shade300),
      Container(width: 40, height: 30, color: Colors.orange.shade300),
    ],
  );
  print('Wrap with crossAxisAlignment=center created');

  final crossStartWrap = Wrap(
    crossAxisAlignment: WrapCrossAlignment.start,
    spacing: 8.0,
    children: [
      Container(width: 40, height: 20, color: Colors.red.shade400),
      Container(width: 40, height: 40, color: Colors.green.shade400),
      Container(width: 40, height: 60, color: Colors.blue.shade400),
    ],
  );
  print('Wrap with crossAxisAlignment=start created');

  final crossEndWrap = Wrap(
    crossAxisAlignment: WrapCrossAlignment.end,
    spacing: 8.0,
    children: [
      Container(width: 40, height: 20, color: Colors.red.shade500),
      Container(width: 40, height: 40, color: Colors.green.shade500),
      Container(width: 40, height: 60, color: Colors.blue.shade500),
    ],
  );
  print('Wrap with crossAxisAlignment=end created');

  // Test Wrap with textDirection
  final rtlWrap = Wrap(
    textDirection: TextDirection.rtl,
    spacing: 8.0,
    children: List.generate(5, (index) {
      return Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.amber.shade200,
        child: Text('RTL $index'),
      );
    }),
  );
  print('Wrap with textDirection=rtl created');

  // Test Wrap with verticalDirection
  final upWrap = Wrap(
    verticalDirection: VerticalDirection.up,
    direction: Axis.vertical,
    spacing: 8.0,
    children: List.generate(3, (index) {
      return Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.indigo.shade200,
        child: Text('Up $index'),
      );
    }),
  );
  print('Wrap with verticalDirection=up created');

  // Test Wrap with Chips
  final chipWrap = Wrap(
    spacing: 8.0,
    runSpacing: 4.0,
    children: [
      Chip(label: Text('Flutter')),
      Chip(label: Text('Dart')),
      Chip(label: Text('Mobile')),
      Chip(label: Text('Web')),
      Chip(label: Text('Desktop')),
      Chip(label: Text('Embedded')),
      ActionChip(label: Text('Action'), onPressed: () {}),
      FilterChip(label: Text('Filter'), selected: true, onSelected: (_) {}),
    ],
  );
  print('Wrap with various Chip types created');

  print('Wrap test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Wrap Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Basic Wrap:', style: TextStyle(fontWeight: FontWeight.bold)),
        basicWrap,
        SizedBox(height: 16.0),

        Text(
          'Wrap with Spacing:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        spacedWrap,
        SizedBox(height: 16.0),

        Text(
          'WrapAlignment.center:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerWrap,
        SizedBox(height: 16.0),

        Text(
          'WrapAlignment.end:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        endWrap,
        SizedBox(height: 16.0),

        Text(
          'WrapAlignment.spaceAround:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        spaceAroundWrap,
        SizedBox(height: 16.0),

        Text(
          'CrossAxisAlignment:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('start', style: TextStyle(fontSize: 10)),
                  crossStartWrap,
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('center', style: TextStyle(fontSize: 10)),
                  crossAlignedWrap,
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('end', style: TextStyle(fontSize: 10)),
                  crossEndWrap,
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),

        Text('Wrap with Chips:', style: TextStyle(fontWeight: FontWeight.bold)),
        chipWrap,
        SizedBox(height: 16.0),

        Text(
          'Vertical Direction:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(height: 120.0, child: verticalWrap),
      ],
    ),
  );
}
