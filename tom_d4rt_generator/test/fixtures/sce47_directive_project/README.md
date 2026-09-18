# sce47 directive pre-scan fixture

A project-shaped directory for `preScanUserVariantDirectives`: it has the
`lib/src/d4rt_user_relaxers/` folder the scan reads, and nothing else.

**It deliberately has no `pubspec.yaml`.** The analyzer finds a package config
by walking UP from the file being resolved; a pubspec here would stop that walk
at this directory, and `package:tom_d4rt/d4rt.dart` — which the directive
imports for the `D4UserRelaxer` marker — would not resolve. Without the marker
resolving, the scanner reads the class's supertype as `Object` and silently
finds no directive, which is indistinguishable from the defect sce47 fixed.

Sitting inside `tom_d4rt_generator` means the generator's own resolved
`.dart_tool/package_config.json` applies, which is the same arrangement
`user_proxy_relaxer_scanner_test.dart` relies on for its fixture.
