// Step 1 of the form_wizard sample — account credentials.
//
// Uses Flutter's canonical Form + TextFormField wiring:
//   * each field's `initialValue` is restored from the wizard's
//     `data` map so navigating back and forth preserves user input
//   * `onSaved` writes the field value back into the wizard when
//     the shell calls `formKey.currentState!.save()` after a
//     successful validate.
//
// `autovalidateMode: AutovalidateMode.onUserInteraction` keeps the
// first render clean (no red error text before the user has done
// anything) and switches to live validation as soon as a field
// receives input or the wizard tries to advance.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'wizard.dart';

class AccountStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final WizardController wizard;

  const AccountStep({
    super.key,
    required this.formKey,
    required this.wizard,
  });

  String? _validateEmail(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Email is required';
    final dotAt = v.indexOf('@');
    if (dotAt <= 0) return 'Email must contain "@"';
    final dot = v.indexOf('.', dotAt + 1);
    if (dot < 0 || dot >= v.length - 1) {
      return 'Email must contain a domain';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final v = value ?? '';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Account',
            key: const Key('account-heading'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            key: const Key('email-field'),
            initialValue: wizard.read('email') as String? ?? '',
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            onSaved: (String? value) {
              wizard.update('email', value ?? '');
            },
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            key: const Key('password-field'),
            initialValue: wizard.read('password') as String? ?? '',
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            validator: _validatePassword,
            onSaved: (String? value) {
              wizard.update('password', value ?? '');
            },
          ),
        ],
      ),
    );
  }
}
