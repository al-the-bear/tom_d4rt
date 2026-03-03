// D4rt test script: Tests TextEditingController and ScrollController from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextEditingController and ScrollController test executing');

  // Test TextEditingController with initial text
  final textController1 = TextEditingController(text: 'Hello');
  print('TextEditingController(text: Hello) created');
  print('TextEditingController.text = ${textController1.text}');

  // Test TextEditingController empty
  final textController2 = TextEditingController();
  print('TextEditingController() empty created');
  print('TextEditingController.text = "${textController2.text}"');

  // Test TextEditingController with longer text
  final textController3 = TextEditingController(text: 'The quick brown fox');
  print('TextEditingController(text: The quick brown fox) created');
  print('TextEditingController.text = ${textController3.text}');

  // Test ScrollController with initialScrollOffset
  final scrollController1 = ScrollController(initialScrollOffset: 100.0);
  print('ScrollController(initialScrollOffset: 100.0) created');
  print(
    'ScrollController.initialScrollOffset = ${scrollController1.initialScrollOffset}',
  );

  // Test ScrollController default
  final scrollController2 = ScrollController();
  print('ScrollController() default created');
  print(
    'ScrollController.initialScrollOffset = ${scrollController2.initialScrollOffset}',
  );

  // Test ScrollController with keepScrollOffset false
  final scrollController3 = ScrollController(keepScrollOffset: false);
  print('ScrollController(keepScrollOffset: false) created');
  print(
    'ScrollController.keepScrollOffset = ${scrollController3.keepScrollOffset}',
  );

  // Build widgets using the controllers
  final textField1 = TextField(controller: textController1);
  print('TextField with textController1 created');

  final textField2 = TextField(controller: textController2);
  print('TextField with textController2 created');

  final textField3 = TextField(controller: textController3);
  print('TextField with textController3 created');

  print('TextEditingController and ScrollController test completed');
  return Column(
    children: [
      textField1,
      textField2,
      textField3,
      SizedBox(
        height: 100,
        child: SingleChildScrollView(
          controller: scrollController1,
          child: Container(height: 300, color: Colors.blue),
        ),
      ),
      SizedBox(
        height: 100,
        child: SingleChildScrollView(
          controller: scrollController2,
          child: Container(height: 300, color: Colors.green),
        ),
      ),
    ],
  );
}
