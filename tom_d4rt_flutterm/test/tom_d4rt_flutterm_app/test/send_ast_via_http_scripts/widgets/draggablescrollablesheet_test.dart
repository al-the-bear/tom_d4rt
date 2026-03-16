// D4rt test script: Tests DraggableScrollableSheet from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DraggableScrollableSheet test executing');

  // Variation 1: Basic DraggableScrollableSheet
  final widget1 = DraggableScrollableSheet(
    builder: (context, scrollController) => Container(
      color: Colors.blue,
      child: ListView.builder(
        controller: scrollController,
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
      ),
    ),
  );
  print('DraggableScrollableSheet(basic) created');

  // Variation 2: DraggableScrollableSheet with custom sizes
  final widget2 = DraggableScrollableSheet(
    initialChildSize: 0.5,
    minChildSize: 0.25,
    maxChildSize: 1.0,
    builder: (context, scrollController) => Container(
      color: Colors.green,
      child: ListView.builder(
        controller: scrollController,
        itemCount: 15,
        itemBuilder: (context, index) => ListTile(title: Text('Custom $index')),
      ),
    ),
  );
  print(
    'DraggableScrollableSheet(initialChildSize: 0.5, minChildSize: 0.25, maxChildSize: 1.0) created',
  );

  // Variation 3: DraggableScrollableSheet with snap enabled
  final widget3 = DraggableScrollableSheet(
    initialChildSize: 0.4,
    minChildSize: 0.2,
    maxChildSize: 0.9,
    snap: true,
    builder: (context, scrollController) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: 20,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.star),
          title: Text('Snap Item $index'),
        ),
      ),
    ),
  );
  print('DraggableScrollableSheet(snap: true) created');

  // Variation 4: DraggableScrollableSheet with small range
  final widget4 = DraggableScrollableSheet(
    initialChildSize: 0.3,
    minChildSize: 0.1,
    maxChildSize: 0.5,
    builder: (context, scrollController) => Container(
      color: Colors.orange,
      child: ListView(
        controller: scrollController,
        children: [
          Container(
            height: 60,
            color: Colors.red,
            child: Center(child: Text('Row 1')),
          ),
          Container(
            height: 60,
            color: Colors.blue,
            child: Center(child: Text('Row 2')),
          ),
          Container(
            height: 60,
            color: Colors.green,
            child: Center(child: Text('Row 3')),
          ),
        ],
      ),
    ),
  );
  print('DraggableScrollableSheet(small range 0.1-0.5) created');

  print('DraggableScrollableSheet test completed');
  return Column(
    children: [
      Expanded(
        child: Stack(
          children: [
            Container(color: Colors.grey.shade200),
            widget1,
          ],
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(color: Colors.grey.shade300),
            widget2,
          ],
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(color: Colors.grey.shade200),
            widget3,
          ],
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(color: Colors.grey.shade300),
            widget4,
          ],
        ),
      ),
    ],
  );
}
