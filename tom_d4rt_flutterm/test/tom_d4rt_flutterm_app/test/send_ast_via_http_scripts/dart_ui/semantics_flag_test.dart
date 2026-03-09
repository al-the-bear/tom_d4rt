// D4rt test script: Tests SemanticsFlag from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsFlag test executing');

  final flags = [
    ui.SemanticsFlag.hasCheckedState,
    ui.SemanticsFlag.isChecked,
    ui.SemanticsFlag.isSelected,
    ui.SemanticsFlag.isButton,
    ui.SemanticsFlag.isTextField,
    ui.SemanticsFlag.isFocused,
    ui.SemanticsFlag.hasEnabledState,
    ui.SemanticsFlag.isEnabled,
    ui.SemanticsFlag.isInMutuallyExclusiveGroup,
    ui.SemanticsFlag.isHeader,
    ui.SemanticsFlag.isObscured,
    ui.SemanticsFlag.isImage,
    ui.SemanticsFlag.isLiveRegion,
    ui.SemanticsFlag.hasToggledState,
    ui.SemanticsFlag.isToggled,
    ui.SemanticsFlag.hasImplicitScrolling,
    ui.SemanticsFlag.isReadOnly,
    ui.SemanticsFlag.isFocusable,
    ui.SemanticsFlag.isLink,
    ui.SemanticsFlag.isSlider,
    ui.SemanticsFlag.isKeyboardKey,
    ui.SemanticsFlag.isHidden,
  ];
  print('SemanticsFlag count: ${flags.length}');
  for (final f in flags) {
    print('  flag: $f, index=${f.index}');
  }
  print('SemanticsFlag.values: ${ui.SemanticsFlag.values.length}');

  print('SemanticsFlag test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SemanticsFlag Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('${flags.length} flags tested'),
    Text('Total values: ${ui.SemanticsFlag.values.length}'),
  ]);
}
