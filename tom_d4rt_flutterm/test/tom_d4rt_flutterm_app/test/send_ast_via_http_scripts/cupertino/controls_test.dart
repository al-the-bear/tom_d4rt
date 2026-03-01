// D4rt test script: Tests CupertinoSwitch, CupertinoSlider, CupertinoActivityIndicator from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino controls test executing');

  // ========== CUPERTINOSWITCH ==========
  print('--- CupertinoSwitch Tests ---');

  // Test basic CupertinoSwitch (on)
  final onSwitch = CupertinoSwitch(
    value: true,
    onChanged: (bool value) {
      print('Switch changed: $value');
    },
  );
  print('Basic CupertinoSwitch (on) created');

  // Test basic CupertinoSwitch (off)
  final offSwitch = CupertinoSwitch(value: false, onChanged: (value) {});
  print('Basic CupertinoSwitch (off) created');

  // Test CupertinoSwitch disabled
  final disabledSwitch = CupertinoSwitch(value: true, onChanged: null);
  print('CupertinoSwitch disabled created');

  // Test CupertinoSwitch with activeColor
  final activeColorSwitch = CupertinoSwitch(
    value: true,
    activeColor: CupertinoColors.systemPurple,
    onChanged: (value) {},
  );
  print('CupertinoSwitch with activeColor created');

  // Test CupertinoSwitch with trackColor
  final trackColorSwitch = CupertinoSwitch(
    value: false,
    trackColor: CupertinoColors.systemGrey3,
    onChanged: (value) {},
  );
  print('CupertinoSwitch with trackColor created');

  // Test CupertinoSwitch with thumbColor
  final thumbColorSwitch = CupertinoSwitch(
    value: true,
    thumbColor: CupertinoColors.systemOrange,
    onChanged: (value) {},
  );
  print('CupertinoSwitch with thumbColor created');

  // Test CupertinoSwitch with focusColor
  final focusColorSwitch = CupertinoSwitch(
    value: true,
    focusColor: CupertinoColors.systemBlue.withOpacity(0.3),
    onChanged: (value) {},
  );
  print('CupertinoSwitch with focusColor created');

  // Test CupertinoSwitch with onLabelColor
  final onLabelSwitch = CupertinoSwitch(
    value: true,
    onLabelColor: CupertinoColors.white,
    onChanged: (value) {},
  );
  print('CupertinoSwitch with onLabelColor created');

  // Test CupertinoSwitch with offLabelColor
  final offLabelSwitch = CupertinoSwitch(
    value: false,
    offLabelColor: CupertinoColors.black,
    onChanged: (value) {},
  );
  print('CupertinoSwitch with offLabelColor created');

  // Test CupertinoSwitch with dragStartBehavior
  final dragStartSwitch = CupertinoSwitch(
    value: true,
    dragStartBehavior: DragStartBehavior.down,
    onChanged: (value) {},
  );
  print('CupertinoSwitch with dragStartBehavior created');

  // Test CupertinoSwitch with applyTheme
  final themedSwitch = CupertinoSwitch(
    value: true,
    applyTheme: true,
    onChanged: (value) {},
  );
  print('CupertinoSwitch with applyTheme created');

  // Test CupertinoSwitch with focusNode
  final focusedSwitch = CupertinoSwitch(
    value: true,
    focusNode: FocusNode(),
    onChanged: (value) {},
  );
  print('CupertinoSwitch with focusNode created');

  // Test CupertinoSwitch with autofocus
  final autofocusSwitch = CupertinoSwitch(
    value: true,
    autofocus: true,
    onChanged: (value) {},
  );
  print('CupertinoSwitch with autofocus created');

  // Test CupertinoSwitch with onFocusChange
  final focusChangeSwitch = CupertinoSwitch(
    value: true,
    onFocusChange: (hasFocus) {
      print('Focus changed: $hasFocus');
    },
    onChanged: (value) {},
  );
  print('CupertinoSwitch with onFocusChange created');

  // ========== CUPERTINOSLIDER ==========
  print('--- CupertinoSlider Tests ---');

  // Test basic CupertinoSlider
  final basicSlider = CupertinoSlider(
    value: 0.5,
    onChanged: (double value) {
      print('Slider value: $value');
    },
  );
  print('Basic CupertinoSlider created');

  // Test CupertinoSlider with min/max
  final rangeSlider = CupertinoSlider(
    value: 50.0,
    min: 0.0,
    max: 100.0,
    onChanged: (value) {},
  );
  print('CupertinoSlider with min/max created');

  // Test CupertinoSlider with divisions
  final divisionsSlider = CupertinoSlider(
    value: 0.5,
    divisions: 10,
    onChanged: (value) {},
  );
  print('CupertinoSlider with divisions created');

  // Test CupertinoSlider disabled
  final disabledSlider = CupertinoSlider(value: 0.3, onChanged: null);
  print('CupertinoSlider disabled created');

  // Test CupertinoSlider with activeColor
  final activeColorSlider = CupertinoSlider(
    value: 0.7,
    activeColor: CupertinoColors.systemGreen,
    onChanged: (value) {},
  );
  print('CupertinoSlider with activeColor created');

  // Test CupertinoSlider with thumbColor
  final thumbColorSlider = CupertinoSlider(
    value: 0.5,
    thumbColor: CupertinoColors.systemPink,
    onChanged: (value) {},
  );
  print('CupertinoSlider with thumbColor created');

  // Test CupertinoSlider with onChangeStart
  final startChangeSlider = CupertinoSlider(
    value: 0.5,
    onChangeStart: (value) {
      print('Slider started at: $value');
    },
    onChanged: (value) {},
  );
  print('CupertinoSlider with onChangeStart created');

  // Test CupertinoSlider with onChangeEnd
  final endChangeSlider = CupertinoSlider(
    value: 0.5,
    onChangeEnd: (value) {
      print('Slider ended at: $value');
    },
    onChanged: (value) {},
  );
  print('CupertinoSlider with onChangeEnd created');

  // ========== CUPERTINOACTIVITYINDICATOR ==========
  print('--- CupertinoActivityIndicator Tests ---');

  // Test basic CupertinoActivityIndicator
  final basicIndicator = CupertinoActivityIndicator();
  print('Basic CupertinoActivityIndicator created');

  // Test CupertinoActivityIndicator with radius
  final radiusIndicator = CupertinoActivityIndicator(radius: 20.0);
  print('CupertinoActivityIndicator with radius created');

  // Test CupertinoActivityIndicator with color
  final colorIndicator = CupertinoActivityIndicator(
    color: CupertinoColors.systemRed,
  );
  print('CupertinoActivityIndicator with color created');

  // Test CupertinoActivityIndicator with animating
  final animatingIndicator = CupertinoActivityIndicator(animating: true);
  print('CupertinoActivityIndicator with animating created');

  // Test CupertinoActivityIndicator not animating
  final notAnimatingIndicator = CupertinoActivityIndicator(animating: false);
  print('CupertinoActivityIndicator with animating=false created');

  // Test CupertinoActivityIndicator.partiallyRevealed
  final partialIndicator = CupertinoActivityIndicator.partiallyRevealed(
    progress: 0.5,
  );
  print('CupertinoActivityIndicator.partiallyRevealed created');

  // Test CupertinoActivityIndicator.partiallyRevealed with radius
  final partialRadiusIndicator = CupertinoActivityIndicator.partiallyRevealed(
    radius: 24.0,
    progress: 0.75,
  );
  print('CupertinoActivityIndicator.partiallyRevealed with radius created');

  // Test CupertinoActivityIndicator.partiallyRevealed with color
  final partialColorIndicator = CupertinoActivityIndicator.partiallyRevealed(
    color: CupertinoColors.systemGreen,
    progress: 0.3,
  );
  print('CupertinoActivityIndicator.partiallyRevealed with color created');

  // ========== CUPERTINOCHECKBOX ==========
  print('--- CupertinoCheckbox Tests ---');

  // Test basic CupertinoCheckbox (checked)
  final checkedBox = CupertinoCheckbox(
    value: true,
    onChanged: (bool? value) {
      print('Checkbox changed: $value');
    },
  );
  print('CupertinoCheckbox (checked) created');

  // Test CupertinoCheckbox (unchecked)
  final uncheckedBox = CupertinoCheckbox(value: false, onChanged: (value) {});
  print('CupertinoCheckbox (unchecked) created');

  // Test CupertinoCheckbox (tristate)
  final tristateBox = CupertinoCheckbox(
    value: null,
    tristate: true,
    onChanged: (value) {},
  );
  print('CupertinoCheckbox (tristate) created');

  // Test CupertinoCheckbox disabled
  final disabledBox = CupertinoCheckbox(value: true, onChanged: null);
  print('CupertinoCheckbox disabled created');

  // Test CupertinoCheckbox with activeColor
  final activeColorBox = CupertinoCheckbox(
    value: true,
    activeColor: CupertinoColors.systemPurple,
    onChanged: (value) {},
  );
  print('CupertinoCheckbox with activeColor created');

  // Test CupertinoCheckbox with checkColor
  final checkColorBox = CupertinoCheckbox(
    value: true,
    checkColor: CupertinoColors.systemYellow,
    onChanged: (value) {},
  );
  print('CupertinoCheckbox with checkColor created');

  // Test CupertinoCheckbox with inactiveColor
  final inactiveColorBox = CupertinoCheckbox(
    value: false,
    inactiveColor: CupertinoColors.systemGrey2,
    onChanged: (value) {},
  );
  print('CupertinoCheckbox with inactiveColor created');

  // Test CupertinoCheckbox with focusColor
  final focusColorBox = CupertinoCheckbox(
    value: true,
    focusColor: CupertinoColors.systemBlue.withOpacity(0.3),
    onChanged: (value) {},
  );
  print('CupertinoCheckbox with focusColor created');

  // Test CupertinoCheckbox with shape
  final shapeBox = CupertinoCheckbox(
    value: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    onChanged: (value) {},
  );
  print('CupertinoCheckbox with shape created');

  // Test CupertinoCheckbox with side
  final sideBox = CupertinoCheckbox(
    value: false,
    side: BorderSide(color: CupertinoColors.systemRed, width: 2.0),
    onChanged: (value) {},
  );
  print('CupertinoCheckbox with side created');

  // ========== CUPERTINORADIO ==========
  print('--- CupertinoRadio Tests ---');

  // Test basic CupertinoRadio (selected)
  final selectedRadio = CupertinoRadio<int>(
    value: 1,
    groupValue: 1,
    onChanged: (int? value) {
      print('Radio changed: $value');
    },
  );
  print('CupertinoRadio (selected) created');

  // Test CupertinoRadio (unselected)
  final unselectedRadio = CupertinoRadio<int>(
    value: 2,
    groupValue: 1,
    onChanged: (value) {},
  );
  print('CupertinoRadio (unselected) created');

  // Test CupertinoRadio disabled
  final disabledRadio = CupertinoRadio<int>(
    value: 1,
    groupValue: 1,
    onChanged: null,
  );
  print('CupertinoRadio disabled created');

  // Test CupertinoRadio with activeColor
  final activeColorRadio = CupertinoRadio<int>(
    value: 1,
    groupValue: 1,
    activeColor: CupertinoColors.systemOrange,
    onChanged: (value) {},
  );
  print('CupertinoRadio with activeColor created');

  // Test CupertinoRadio with inactiveColor
  final inactiveColorRadio = CupertinoRadio<int>(
    value: 2,
    groupValue: 1,
    inactiveColor: CupertinoColors.systemGrey3,
    onChanged: (value) {},
  );
  print('CupertinoRadio with inactiveColor created');

  // Test CupertinoRadio with fillColor
  final fillColorRadio = CupertinoRadio<int>(
    value: 1,
    groupValue: 1,
    fillColor: CupertinoColors.systemPink,
    onChanged: (value) {},
  );
  print('CupertinoRadio with fillColor created');

  // Test CupertinoRadio with focusColor
  final focusColorRadio = CupertinoRadio<int>(
    value: 1,
    groupValue: 1,
    focusColor: CupertinoColors.systemBlue.withOpacity(0.2),
    onChanged: (value) {},
  );
  print('CupertinoRadio with focusColor created');

  // Test CupertinoRadio with useCheckmarkStyle
  final checkmarkRadio = CupertinoRadio<int>(
    value: 1,
    groupValue: 1,
    useCheckmarkStyle: true,
    onChanged: (value) {},
  );
  print('CupertinoRadio with useCheckmarkStyle created');

  // Test CupertinoRadio with toggleable
  final toggleableRadio = CupertinoRadio<int>(
    value: 1,
    groupValue: 1,
    toggleable: true,
    onChanged: (value) {},
  );
  print('CupertinoRadio with toggleable created');

  print('Cupertino controls test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Controls Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Switches:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  onSwitch,
                  SizedBox(width: 16.0),
                  offSwitch,
                  SizedBox(width: 16.0),
                  activeColorSwitch,
                ],
              ),

              SizedBox(height: 24.0),
              Text(
                'Sliders:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              basicSlider,
              SizedBox(height: 8.0),
              activeColorSlider,

              SizedBox(height: 24.0),
              Text(
                'Activity Indicators:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  basicIndicator,
                  SizedBox(width: 16.0),
                  radiusIndicator,
                  SizedBox(width: 16.0),
                  colorIndicator,
                ],
              ),

              SizedBox(height: 24.0),
              Text(
                'Checkboxes:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  checkedBox,
                  SizedBox(width: 16.0),
                  uncheckedBox,
                  SizedBox(width: 16.0),
                  activeColorBox,
                ],
              ),

              SizedBox(height: 24.0),
              Text(
                'Radios:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  selectedRadio,
                  SizedBox(width: 16.0),
                  unselectedRadio,
                  SizedBox(width: 16.0),
                  activeColorRadio,
                ],
              ),

              SizedBox(height: 24.0),
              Text(
                'Disabled Controls:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  disabledSwitch,
                  SizedBox(width: 16.0),
                  disabledBox,
                  SizedBox(width: 16.0),
                  disabledRadio,
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
