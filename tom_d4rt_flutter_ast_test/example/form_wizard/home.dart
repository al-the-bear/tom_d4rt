// Shell for the form_wizard sample (example #15).
//
// Owns the long-lived `WizardController` and the four
// `GlobalKey<FormState>` instances. Listens to the controller via
// `ListenableBuilder` so the progress bar, step body, and Back/Next/
// Submit buttons all rebuild on any controller mutation.
//
// Step transitions are animated by wrapping the active step body in
// an `AnimatedSwitcher` — switching the child's `Key` forces the
// switcher to run its in/out transition.
//
// Submit flow: the review step's "Submit" button calls
// `wizard.submit()` which flips `submitting=true`, awaits a
// `Future.delayed`, then sets `submitDone=true`. While `submitting`
// is true the shell stacks a translucent overlay over the body so
// the user can't double-tap.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'progress_bar.dart';
import 'step_account.dart';
import 'step_preferences.dart';
import 'step_profile.dart';
import 'step_review.dart';
import 'wizard.dart';

class FormWizardHome extends StatefulWidget {
  const FormWizardHome({super.key});

  @override
  State<FormWizardHome> createState() => _FormWizardHomeState();
}

class _FormWizardHomeState extends State<FormWizardHome> {
  late WizardController _wizard;

  // One FormState key per step so validate() / save() route to the
  // right Form. They live on the shell so AnimatedSwitcher can
  // recycle them when the user navigates back.
  final List<GlobalKey<FormState>> _formKeys = <GlobalKey<FormState>>[
    GlobalKey<FormState>(debugLabel: 'step-0-account'),
    GlobalKey<FormState>(debugLabel: 'step-1-profile'),
    GlobalKey<FormState>(debugLabel: 'step-2-preferences'),
    GlobalKey<FormState>(debugLabel: 'step-3-review'),
  ];

  @override
  void initState() {
    super.initState();
    _wizard = WizardController();
  }

  @override
  void dispose() {
    _wizard.dispose();
    super.dispose();
  }

  /// Returns true if the active step's form passed validation and
  /// its values were saved into the wizard. The review step has no
  /// fillable fields so its `save()` is a no-op but still returns
  /// true.
  bool _validateAndSaveCurrent() {
    final state = _formKeys[_wizard.currentStep].currentState;
    if (state == null) return false;
    if (!state.validate()) {
      print('wizard.validate.fail step=${_wizard.currentStep}');
      return false;
    }
    state.save();
    print('wizard.validate.ok step=${_wizard.currentStep}');
    return true;
  }

  void _onNext() {
    if (!_validateAndSaveCurrent()) return;
    _wizard.next();
  }

  void _onPrev() {
    // Going back never blocks on validation — users should always
    // be able to retreat and correct earlier steps. We do still
    // save any valid intermediate state so partial typing survives
    // the round-trip.
    final state = _formKeys[_wizard.currentStep].currentState;
    if (state != null && state.validate()) {
      state.save();
    }
    _wizard.previous();
  }

  Future<void> _onSubmit() async {
    // Final validate sweep — the review step's form passes
    // trivially, but we keep the gate to mirror what a real
    // multi-step submission flow would do.
    if (!_validateAndSaveCurrent()) return;
    await _wizard.submit();
  }

  Widget _buildStepBody() {
    final step = _wizard.currentStep;
    final formKey = _formKeys[step];
    switch (step) {
      case 0:
        return AccountStep(
          key: const ValueKey<int>(0),
          formKey: formKey,
          wizard: _wizard,
        );
      case 1:
        return ProfileStep(
          key: const ValueKey<int>(1),
          formKey: formKey,
          wizard: _wizard,
        );
      case 2:
        return PreferencesStep(
          key: const ValueKey<int>(2),
          formKey: formKey,
          wizard: _wizard,
        );
      case 3:
      default:
        return ReviewStep(
          key: const ValueKey<int>(3),
          formKey: formKey,
          wizard: _wizard,
        );
    }
  }

  Widget _buildActions() {
    final canGoBack = !_wizard.isFirstStep && !_wizard.submitting;
    final isLast = _wizard.isLastStep;
    final isDone = _wizard.submitDone;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          key: const Key('prev-btn'),
          onPressed: canGoBack ? _onPrev : null,
          child: const Text('Back'),
        ),
        if (isLast)
          FilledButton.icon(
            key: const Key('submit-btn'),
            icon: isDone
                ? const Icon(Icons.check)
                : const Icon(Icons.send),
            label: Text(isDone ? 'Submitted' : 'Submit'),
            onPressed:
                (_wizard.submitting || isDone) ? null : _onSubmit,
          )
        else
          FilledButton(
            key: const Key('next-btn'),
            onPressed: _wizard.submitting ? null : _onNext,
            child: const Text('Next'),
          ),
      ],
    );
  }

  Widget _buildOverlay() {
    if (!_wizard.submitting) return const SizedBox.shrink();
    return Positioned.fill(
      key: const Key('submitting-overlay'),
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.30),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 12.0),
              Text(
                'Submitting…',
                key: Key('submitting-label'),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoneBanner() {
    if (!_wizard.submitDone) return const SizedBox.shrink();
    return Container(
      key: const Key('submit-done-banner'),
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      color: Colors.green.shade100,
      child: const Text(
        'Account created!',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _wizard,
      builder: (BuildContext ctx, Widget? _) {
        return Scaffold(
          appBar: AppBar(
            key: const Key('wizard-appbar'),
            title: Text(
              'Sign up — step ${_wizard.currentStep + 1} of $kStepCount',
              key: const Key('wizard-appbar-title'),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  WizardProgressBar(progress: _wizard.progress),
                  _buildDoneBanner(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          child: _buildStepBody(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    child: _buildActions(),
                  ),
                ],
              ),
              _buildOverlay(),
            ],
          ),
        );
      },
    );
  }
}
