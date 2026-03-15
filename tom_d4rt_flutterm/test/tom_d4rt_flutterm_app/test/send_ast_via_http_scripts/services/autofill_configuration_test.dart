import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  final emailConfig = AutofillConfiguration(
    uniqueIdentifier: 'email_field',
    autofillHints: const [AutofillHints.email],
    currentEditingValue: const TextEditingValue(text: 'a@example.com'),
    hintText: 'Email',
  );

  final passwordConfig = AutofillConfiguration(
    uniqueIdentifier: 'password_field',
    autofillHints: const [AutofillHints.password, AutofillHints.newPassword],
    currentEditingValue: const TextEditingValue(text: 'secret'),
    hintText: 'Password',
  );

  final disabled = AutofillConfiguration.disabled;

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('email.enabled=${emailConfig.enabled}'),
      Text('email.id=${emailConfig.uniqueIdentifier}'),
      Text('email.hints=${emailConfig.autofillHints.join(',')}'),
      Text('email.value=${emailConfig.currentEditingValue.text}'),
      Text('password.hints=${passwordConfig.autofillHints.length}'),
      Text('password.value=${passwordConfig.currentEditingValue.text}'),
      Text('disabled.enabled=${disabled.enabled}'),
      Text('disabled.id=${disabled.uniqueIdentifier}'),
    ],
  );
}
