# Script Issues

batch: 0

- No non-immediate batch-0 script issues remained after immediate fixes.
- Immediate batch-0 script fixes were applied and validated for:
  - cupertino/controls_test.dart
  - cupertino/form_test.dart
  - cupertino/textfield_test.dart
  - rendering/viewport_test.dart

batch: 1

- No non-immediate batch-1 script issues remained after immediate fixes.
- Immediate batch-1 script fixes were applied and validated for:
  - animation/reverse_tween_test.dart
  - cupertino/cupertino_desktop_text_selection_controls_test.dart
  - cupertino/cupertino_focus_halo_test.dart
  - cupertino/cupertino_text_selection_handle_controls_test.dart

batch: 2

- No non-immediate batch-2 script issues remained after immediate fixes.
- Immediate batch-2 script fixes were applied and validated for:
  - cupertino/inherited_cupertino_theme_test.dart
  - cupertino/overlay_visibility_mode_test.dart
  - dart_ui/blur_style_test.dart
  - dart_ui/color_space_test.dart
  - dart_ui/key_event_type_test.dart
- Notes:
  - `color_space_test.dart` and `key_event_type_test.dart` were stabilized with script-level mitigations while related interpreter/bridge follow-up analysis was documented in `interpreter_issues.md` and `generator_issues.md`.
