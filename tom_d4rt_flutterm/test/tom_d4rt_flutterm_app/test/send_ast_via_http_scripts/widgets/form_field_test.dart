// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Form, FormField, TextFormField, FormState,
// InputDecoration advanced, InputBorder types, OutlineInputBorder, UnderlineInputBorder
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Form field test executing');

  final formKey = GlobalKey<FormState>();

  // ========== Form ==========
  print('--- Form Tests ---');
  print('FormState key created');

  // ========== TextFormField advanced ==========
  print('--- TextFormField Advanced Tests ---');

  // ========== InputDecoration advanced ==========
  print('--- InputDecoration Advanced Tests ---');
  final decoration1 = InputDecoration(
    labelText: 'Username',
    labelStyle: TextStyle(color: Colors.blue),
    floatingLabelStyle: TextStyle(color: Colors.blue[700]),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    hintText: 'Enter username',
    hintStyle: TextStyle(color: Colors.grey),
    hintMaxLines: 1,
    helperText: 'Must be unique',
    helperStyle: TextStyle(color: Colors.grey[600]),
    helperMaxLines: 1,
    errorText: null,
    errorStyle: TextStyle(color: Colors.red),
    errorMaxLines: 2,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    prefixIcon: Icon(Icons.person),
    prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
    suffixIcon: Icon(Icons.clear),
    suffixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
    prefix: Text('@'),
    suffix: Text('.com'),
    counterText: '0/20',
    counterStyle: TextStyle(fontSize: 12),
    filled: true,
    fillColor: Colors.grey[100],
    focusColor: Colors.blue[50],
    hoverColor: Colors.blue[25],
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    isDense: false,
    isCollapsed: false,
    alignLabelWithHint: false,
    constraints: BoxConstraints(maxWidth: 400),
  );
  print('InputDecoration advanced created');
  print('  floatingLabelBehavior: ${decoration1.floatingLabelBehavior}');

  // ========== InputDecoration.collapsed ==========
  print('--- InputDecoration.collapsed Tests ---');
  final decorationCollapsed = InputDecoration.collapsed(
    hintText: 'Collapsed hint',
    hintStyle: TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.white,
    border: InputBorder.none,
  );
  print('InputDecoration.collapsed created: $decorationCollapsed');

  // ========== OutlineInputBorder ==========
  print('--- OutlineInputBorder Tests ---');
  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(12),
    gapPadding: 4.0,
  );
  print('OutlineInputBorder created');
  print('  borderRadius: ${outlineBorder.borderRadius}');
  print('  gapPadding: ${outlineBorder.gapPadding}');
  print('  isOutline: ${outlineBorder.isOutline}');

  // ========== UnderlineInputBorder ==========
  print('--- UnderlineInputBorder Tests ---');
  final underlineBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2),
    borderRadius: BorderRadius.circular(4),
  );
  print('UnderlineInputBorder created');
  print('  isOutline: ${underlineBorder.isOutline}');

  // ========== FloatingLabelBehavior ==========
  print('--- FloatingLabelBehavior Tests ---');
  for (final behavior in FloatingLabelBehavior.values) {
    print('  FloatingLabelBehavior.$behavior');
  }

  // ========== FloatingLabelAlignment ==========
  print('--- FloatingLabelAlignment Tests ---');
  print('  start: ${FloatingLabelAlignment.start}');
  print('  center: ${FloatingLabelAlignment.center}');

  // ========== Form + FormField widget ==========
  print('--- Form Widget Tests ---');
  final form = Form(
    key: formKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onWillPop: () async => true,
    onChanged: () => print('  Form changed'),
    child: Column(
      children: [
        TextFormField(
          decoration: decoration1,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            if (value.length < 3) return 'Too short';
            return null;
          },
          onSaved: (value) => print('  Saved: $value'),
          onFieldSubmitted: (value) => print('  Submitted: $value'),
          onChanged: (value) => print('  Changed: $value'),
          initialValue: '',
          autovalidateMode: AutovalidateMode.disabled,
          maxLength: 20,
          maxLines: 1,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          obscureText: false,
          enableSuggestions: true,
          autocorrect: true,
          readOnly: false,
          enabled: true,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: underlineBorder,
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && !value.contains('@')) return 'Invalid email';
            return null;
          },
        ),
      ],
    ),
  );
  print('Form with TextFormField created');

  // ========== AutovalidateMode ==========
  print('--- AutovalidateMode Tests ---');
  for (final mode in AutovalidateMode.values) {
    print('  AutovalidateMode.$mode');
  }

  print('All form field tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(padding: EdgeInsets.all(16), child: form),
    ),
  );
}
