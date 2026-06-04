// Controller for the form_wizard sample (example #15).
//
// Owns a 4-step wizard's worth of state:
//   * `currentStep` — 0..3 index into the step list
//   * `data` — accumulated map of field name → value (collected step
//     by step so the final review step can render a summary)
//   * `submitting` / `submitDone` — drive the fake-network overlay
//     and the post-submit confirmation banner
//
// Mutations notify listeners via the ChangeNotifier mixin. Each
// public mutation also emits a trail line so the tester can assert
// the controller saw the expected transitions:
//   `wizard.init`
//   `wizard.next step=N` / `wizard.prev step=N` / `wizard.goto step=N`
//   `wizard.update key="email" len=12`
//   `wizard.submit.start`
//   `wizard.submit.done`
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Total number of steps in the wizard. Centralised so the progress
/// bar and the "Next/Submit" button branching can reuse the same
/// value without drifting.
const int kStepCount = 4;

class WizardController extends ChangeNotifier {
  int _currentStep = 0;
  final Map<String, Object?> _data = <String, Object?>{};
  bool _submitting = false;
  bool _submitDone = false;

  WizardController() {
    // Seed defaults for non-text controls so the review step can
    // render them even if the user never explicitly toggled them.
    // Writing here is safe because no listener is attached yet —
    // this avoids the "setState called during build" trap that
    // would fire if a step's `initState` tried to seed defaults
    // while the parent `ListenableBuilder` is still building.
    _data['notifications'] = true;
    print('wizard.init');
  }

  int get currentStep => _currentStep;
  bool get submitting => _submitting;
  bool get submitDone => _submitDone;
  bool get isFirstStep => _currentStep == 0;
  bool get isLastStep => _currentStep == kStepCount - 1;

  /// Progress in [0.0, 1.0]. The wizard hits 1.0 only once the user
  /// has acknowledged the review step (i.e. on submit-done).
  double get progress {
    if (_submitDone) return 1.0;
    // Each completed step contributes 1/kStepCount of the bar; the
    // current step is "in progress" so we credit a half-slot to
    // give the user visual feedback while they're filling fields.
    return (_currentStep + 0.5) / kStepCount;
  }

  Object? read(String key) => _data[key];

  /// Used by the review step to render a list of collected entries.
  /// Returned in insertion order so the summary reads top-to-bottom
  /// in the same order the user filled the fields.
  List<MapEntry<String, Object?>> get entries =>
      _data.entries.toList(growable: false);

  void update(String key, Object? value) {
    _data[key] = value;
    final repr = value is String ? value : value.toString();
    final len = repr is String ? repr.length : 0;
    print('wizard.update key="$key" len=$len');
    notifyListeners();
  }

  void next() {
    if (_currentStep >= kStepCount - 1) return;
    _currentStep += 1;
    print('wizard.next step=$_currentStep');
    notifyListeners();
  }

  void previous() {
    if (_currentStep <= 0) return;
    _currentStep -= 1;
    print('wizard.prev step=$_currentStep');
    notifyListeners();
  }

  void goTo(int step) {
    if (step < 0 || step >= kStepCount || step == _currentStep) return;
    _currentStep = step;
    print('wizard.goto step=$_currentStep');
    notifyListeners();
  }

  Future<void> submit({
    Duration delay = const Duration(milliseconds: 600),
  }) async {
    if (_submitting || _submitDone) return;
    _submitting = true;
    print('wizard.submit.start');
    notifyListeners();
    await Future<void>.delayed(delay);
    _submitting = false;
    _submitDone = true;
    print('wizard.submit.done');
    notifyListeners();
  }
}
