import 'package:flutter/cupertino.dart';

/// Demonstrates basic Cupertino controls: Switch, Slider, Segmented.
dynamic build(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool switchVal = true;
      double sliderVal = 0.5;
      int segmentVal = 0;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Cupertino Controls', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Switch'),
              const SizedBox(width: 8),
              CupertinoSwitch(value: switchVal, onChanged: (v) {}),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 200,
            child: CupertinoSlider(value: sliderVal, onChanged: (v) {}),
          ),
          const SizedBox(height: 12),
          CupertinoSegmentedControl<int>(
            groupValue: segmentVal,
            children: const {0: Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('One')), 1: Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('Two'))},
            onValueChanged: (v) {},
          ),
          const SizedBox(height: 12),
          const Text('iOS-style input controls', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
        ],
      );
    },
  );
}
