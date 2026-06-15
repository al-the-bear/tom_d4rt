// config_overrides — library globals replaced via @D4rtGlobalsUserBridge.
//
// The native defaults in app_config.dart are NativeLedger / 25 / native:… etc.
// AppConfigUserBridge overrides them, so the script observes the script-side
// values instead. `version` has no override, so it shows the native default —
// proof that only the annotated members are replaced.

import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';

void main(List<String> args) {
  print('appName:     $appName');     // overridden → ScriptLedger
  print('maxItems:    $maxItems');    // overridden → 100
  print('currentTime: $currentTime'); // overridden getter → fixed 2026-01-01

  print('describe():  ${describe("invoice")}'); // overridden → script: invoice
  print('taxCents(1000): ${taxCents(1000)}');    // overridden default rate 10%
  print('taxCents(1000, rate: 0.2): ${taxCents(1000, rate: 0.2)}');
}
