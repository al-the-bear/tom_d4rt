// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PageController from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageController test executing');

  // Test basic PageController
  final controller1 = PageController();
  print('Basic PageController created');
  print('PageController initialPage: ${controller1.initialPage}');
  print('PageController viewportFraction: ${controller1.viewportFraction}');
  print('PageController keepPage: ${controller1.keepPage}');

  // Test PageController with initialPage
  final controller2 = PageController(initialPage: 2);
  print('PageController(initialPage: 2) created');
  print('PageController initialPage: ${controller2.initialPage}');

  // Test PageController with viewportFraction
  final controller3 = PageController(viewportFraction: 0.8);
  print('PageController(viewportFraction: 0.8) created');
  print('PageController viewportFraction: ${controller3.viewportFraction}');

  // Test PageController with all properties
  final controller4 = PageController(
    initialPage: 1,
    viewportFraction: 0.85,
    keepPage: false,
  );
  print(
    'PageController(initialPage: 1, viewportFraction: 0.85, keepPage: false) created',
  );
  print('PageController initialPage: ${controller4.initialPage}');
  print('PageController viewportFraction: ${controller4.viewportFraction}');
  print('PageController keepPage: ${controller4.keepPage}');

  // Test PageController used in PageView
  final pageView1 = SizedBox(
    height: 150.0,
    child: PageView(
      controller: controller3,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.blue,
          child: Center(
            child: Text(
              'Page 0',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.green,
          child: Center(
            child: Text(
              'Page 1',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.orange,
          child: Center(
            child: Text(
              'Page 2',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      ],
    ),
  );
  print('PageView with PageController(viewportFraction: 0.8) created');

  // Test PageView.builder with controller
  final controller5 = PageController(initialPage: 0, viewportFraction: 0.9);
  final pageView2 = SizedBox(
    height: 120.0,
    child: PageView.builder(
      controller: controller5,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(4.0),
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'Builder Page $index',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        );
      },
    ),
  );
  print('PageView.builder with PageController created');

  print('PageController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PageController Tests'),
      SizedBox(height: 8.0),
      pageView1,
      SizedBox(height: 8.0),
      pageView2,
    ],
  );
}
