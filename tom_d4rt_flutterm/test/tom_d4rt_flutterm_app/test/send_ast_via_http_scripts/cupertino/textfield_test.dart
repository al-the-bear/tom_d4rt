// D4rt test script: Tests CupertinoTextField
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextField test executing');

  // Default constructor
  final tf1 = CupertinoTextField(
    placeholder: 'Enter text',
    padding: EdgeInsets.all(12.0),
  );
  print('CupertinoTextField created: ${tf1.runtimeType}');
  print('placeholder: ${tf1.placeholder}');
  print('padding: ${tf1.padding}');
  print('obscureText: ${tf1.obscureText}');
  print('autocorrect: ${tf1.autocorrect}');
  print('maxLines: ${tf1.maxLines}');
  print('enabled: ${tf1.enabled}');
  print('readOnly: ${tf1.readOnly}');
  print('textAlign: ${tf1.textAlign}');

  // With more options
  final tf2 = CupertinoTextField(
    placeholder: 'Password',
    obscureText: true,
    maxLines: 1,
    keyboardType: TextInputType.visiblePassword,
    textAlign: TextAlign.center,
    readOnly: false,
    autocorrect: false,
    prefix: Icon(CupertinoIcons.lock),
    suffix: Icon(CupertinoIcons.eye),
    clearButtonMode: OverlayVisibilityMode.editing,
  );
  print('tf2 obscureText: ${tf2.obscureText}');
  print('tf2 autocorrect: ${tf2.autocorrect}');
  print('tf2 clearButtonMode: ${tf2.clearButtonMode}');

  // Borderless variant
  final tf3 = CupertinoTextField.borderless(
    placeholder: 'Borderless',
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  );
  print('CupertinoTextField.borderless: ${tf3.runtimeType}');
  print('tf3 placeholder: ${tf3.placeholder}');

  // With controller
  final controller = TextEditingController(text: 'Initial');
  final tf4 = CupertinoTextField(controller: controller);
  print('controller text: ${controller.text}');
  controller.dispose();

  print('CupertinoTextField test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('TextField Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoTextField(placeholder: 'Default', padding: EdgeInsets.all(12)),
              SizedBox(height: 12),
              CupertinoTextField(placeholder: 'Password', obscureText: true, padding: EdgeInsets.all(12)),
              SizedBox(height: 12),
              CupertinoTextField.borderless(placeholder: 'Borderless'),
              SizedBox(height: 12),
              CupertinoTextField(
                placeholder: 'With prefix',
                prefix: Icon(CupertinoIcons.search),
                padding: EdgeInsets.all(12),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
