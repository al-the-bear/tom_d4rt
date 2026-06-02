// Step 3 of the form_wizard sample — preferences.
//
// Mixes a TextFormField (favorite color) with a non-Form widget
// (Switch for notifications). The text field follows the same
// Form + onSaved pattern as the other steps; the switch keeps its
// own local state and writes to the wizard's data map directly
// whenever the user toggles it.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'wizard.dart';

class PreferencesStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final WizardController wizard;

  const PreferencesStep({
    super.key,
    required this.formKey,
    required this.wizard,
  });

  @override
  State<PreferencesStep> createState() => _PreferencesStepState();
}

class _PreferencesStepState extends State<PreferencesStep> {
  late bool _notifications;

  @override
  void initState() {
    super.initState();
    // WizardController seeds the default `notifications` value, so
    // we can read it directly without needing to write back from
    // `initState` (which would notify listeners while the parent
    // `ListenableBuilder` is still building and trip the
    // "setState called during build" assertion).
    _notifications =
        widget.wizard.read('notifications') as bool? ?? true;
  }

  String? _validateColor(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Pick a favorite color';
    if (v.length > 32) return 'Color name is too long';
    return null;
  }

  void _onNotificationsChanged(bool value) {
    setState(() => _notifications = value);
    widget.wizard.update('notifications', value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Preferences',
            key: const Key('preferences-heading'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            key: const Key('color-field'),
            initialValue: widget.wizard.read('color') as String? ?? '',
            decoration: const InputDecoration(
              labelText: 'Favorite color',
              border: OutlineInputBorder(),
            ),
            validator: _validateColor,
            onSaved: (String? value) =>
                widget.wizard.update('color', value ?? ''),
          ),
          const SizedBox(height: 12.0),
          SwitchListTile(
            key: const Key('notifications-switch'),
            title: const Text('Email notifications'),
            value: _notifications,
            onChanged: _onNotificationsChanged,
          ),
        ],
      ),
    );
  }
}
