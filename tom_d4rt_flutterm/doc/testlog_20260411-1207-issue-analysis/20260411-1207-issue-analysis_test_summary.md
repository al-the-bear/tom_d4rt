# 20260411-1207-issue-analysis Test Summary

| # | Batch | testfile | failure (yes/no) | log output (yes/no) | error info | log info |
|---|---|---|---|---|---|---|
| 1 | Batch-1 | essential_classes_test.dart | no | yes | E=0; first error: none | FW=4, TR=0, OV=4; first log: FRAMEWORK ERROR in cupertino/controls_test.dart |
| 2 | Batch-1 | important_classes_test.dart | yes | yes | E=3; first error: animation/tweensequence_test.dart [E] | FW=7, TR=0, OV=0; first log: FRAMEWORK ERROR in widgets/slidetransition_test.dart |
| 3 | Batch-1 | secondary_classes_test.dart | yes | yes | E=150; first error: semantics/semantics_config_test.dart [E] | FW=47, TR=290, OV=39; first log: FRAMEWORK ERROR in cupertino/cupertino_secondary_test.dart |
| 4 | Batch-1 | hardly_relevant_classes_1_test.dart | yes | yes | E=10; first error: animation/reverse_tween_test.dart [E] | FW=7, TR=0, OV=4; first log: Null check operator used on a null value in ReverseTween |
| 5 | Batch-1 | hardly_relevant_classes_2_test.dart | yes | yes | E=19; first error: material/autocomplete_test.dart [E] | FW=21, TR=0, OV=14; first log: FRAMEWORK ERROR in material/button_bar_theme_test.dart |
| 6 | Batch-2 | hardly_relevant_classes_3_test.dart | yes | yes | E=6; first error: rendering/child_layout_helper_test.dart [E] | FW=14, TR=0, OV=5; first log: FRAMEWORK ERROR in rendering/floating_header_snap_configuration_test.dart |
| 7 | Batch-2 | hardly_relevant_classes_4_test.dart | yes | yes | E=107; first error: widgets/context_action_test.dart [E] | FW=20, TR=212, OV=17; first log: FRAMEWORK ERROR in widgets/action_listener_test.dart |
| 8 | Batch-2 | hardly_relevant_classes_5_test.dart | yes | yes | E=39; first error: widgets/raw_keyboard_listener_test.dart [E] | FW=102, TR=0, OV=6; first log: FRAMEWORK ERROR in widgets/raw_dialog_route_test.dart |

## Legend

- E: count of explicit [E] failing test lines in the suite log
- FW: count of FRAMEWORK ERROR blocks in the suite log
- TR: count of transport-related errors (Transport failure / HttpException connection closed / SocketException refused)
- OV: overflow mentions in the suite log
