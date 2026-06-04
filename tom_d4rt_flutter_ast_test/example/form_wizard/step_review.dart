// Step 4 of the form_wizard sample — review.
//
// Read-only summary of everything the previous steps committed to
// the wizard controller's data map. The submit button lives on the
// wizard shell (home.dart) — this step only renders the captured
// entries.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'wizard.dart';

class ReviewStep extends StatelessWidget {
  /// Carried for API consistency with the other steps — the wizard
  /// shell calls `validate()` on every step's form key before
  /// advancing. The review step's form is empty so `validate()`
  /// always returns true, but having the key in place lets the
  /// shell keep its uniform per-step branching.
  final GlobalKey<FormState> formKey;
  final WizardController wizard;

  const ReviewStep({
    super.key,
    required this.formKey,
    required this.wizard,
  });

  String _displayValue(Object? value) {
    if (value == null) return '—';
    if (value is bool) return value ? 'yes' : 'no';
    if (value is String) {
      if (value.isEmpty) return '(empty)';
      return value;
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final entries = wizard.entries;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Review',
            key: const Key('review-heading'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          if (entries.isEmpty)
            const Text(
              'Nothing collected yet.',
              key: Key('review-empty'),
            )
          else
            Column(
              key: const Key('review-list'),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (final MapEntry<String, Object?> e in entries)
                  Padding(
                    key: Key('review-row-${e.key}'),
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 140.0,
                          child: Text(
                            e.key,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _displayValue(e.value),
                            key: Key('review-value-${e.key}'),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
