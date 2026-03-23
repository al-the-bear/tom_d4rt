// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AutofillGroup, AutofillHints, AutofillConfiguration
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Autofill test executing');

  // ========== AutofillHints ==========
  print('--- AutofillHints Tests ---');
  print('email: ${AutofillHints.email}');
  print('username: ${AutofillHints.username}');
  print('password: ${AutofillHints.password}');
  print('newPassword: ${AutofillHints.newPassword}');
  print('name: ${AutofillHints.name}');
  print('givenName: ${AutofillHints.givenName}');
  print('familyName: ${AutofillHints.familyName}');
  print('telephoneNumber: ${AutofillHints.telephoneNumber}');
  print('postalCode: ${AutofillHints.postalCode}');
  print('streetAddressLine1: ${AutofillHints.streetAddressLine1}');
  print('countryName: ${AutofillHints.countryName}');
  print('creditCardNumber: ${AutofillHints.creditCardNumber}');
  print('creditCardExpirationDate: ${AutofillHints.creditCardExpirationDate}');

  // ========== AutofillGroup ==========
  print('--- AutofillGroup Tests ---');
  final autofillGroup = AutofillGroup(
    child: Column(
      children: [
        TextField(
          autofillHints: [AutofillHints.email],
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          autofillHints: [AutofillHints.password],
          decoration: InputDecoration(labelText: 'Password'),
        ),
      ],
    ),
  );
  print('AutofillGroup created with 2 fields');

  // AutofillGroup with onDisposeAction
  final autofillCommit = AutofillGroup(
    onDisposeAction: AutofillContextAction.commit,
    child: TextField(autofillHints: [AutofillHints.username]),
  );
  print('AutofillGroup with commit action');

  final autofillCancel = AutofillGroup(
    onDisposeAction: AutofillContextAction.cancel,
    child: TextField(),
  );
  print('AutofillGroup with cancel action');

  // ========== AutofillContextAction ==========
  print('--- AutofillContextAction Tests ---');
  for (final action in AutofillContextAction.values) {
    print('AutofillContextAction: ${action.name}');
  }

  print('All autofill tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Autofill Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              TextField(
                autofillHints: [AutofillHints.email],
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 8.0),
              TextField(
                autofillHints: [AutofillHints.password],
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
