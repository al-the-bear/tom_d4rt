// Step 2 of the form_wizard sample — profile.
//
// Same Form + onSaved pattern as the account step: `initialValue`
// pulls previously committed text from the wizard, `validator`
// blocks bad data, `onSaved` flushes to the wizard once the shell
// calls `formKey.currentState!.save()`.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'wizard.dart';

class ProfileStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final WizardController wizard;

  const ProfileStep({
    super.key,
    required this.formKey,
    required this.wizard,
  });

  String? _validateName(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Name is required';
    if (v.length < 2) return 'Name is too short';
    return null;
  }

  String? _validatePhone(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return null; // optional
    for (int i = 0; i < v.length; i++) {
      final c = v.codeUnitAt(i);
      final isDigit = c >= 0x30 && c <= 0x39;
      final isSep = c == 0x20 /* space */ ||
          c == 0x2B /* + */ ||
          c == 0x2D /* - */;
      if (!isDigit && !isSep) {
        return 'Phone may contain digits, spaces, + and -';
      }
    }
    int digitCount = 0;
    for (int i = 0; i < v.length; i++) {
      final c = v.codeUnitAt(i);
      if (c >= 0x30 && c <= 0x39) digitCount += 1;
    }
    if (digitCount < 6) return 'Phone number is too short';
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
            'Profile',
            key: const Key('profile-heading'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            key: const Key('name-field'),
            initialValue: wizard.read('name') as String? ?? '',
            decoration: const InputDecoration(
              labelText: 'Full name',
              border: OutlineInputBorder(),
            ),
            validator: _validateName,
            onSaved: (String? value) =>
                wizard.update('name', value ?? ''),
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            key: const Key('phone-field'),
            initialValue: wizard.read('phone') as String? ?? '',
            decoration: const InputDecoration(
              labelText: 'Phone (optional)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator: _validatePhone,
            onSaved: (String? value) =>
                wizard.update('phone', value ?? ''),
          ),
        ],
      ),
    );
  }
}
