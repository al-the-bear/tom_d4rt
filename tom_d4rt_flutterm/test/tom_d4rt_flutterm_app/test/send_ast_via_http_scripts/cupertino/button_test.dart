// D4rt test script: Tests CupertinoButton from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoButton test executing');

  // ========== CUPERTINOBUTTON ==========
  print('--- CupertinoButton Tests ---');

  // Test basic CupertinoButton
  final basicButton = CupertinoButton(
    child: Text('Basic Button'),
    onPressed: () {
      print('Button pressed');
    },
  );
  print('Basic CupertinoButton created');

  // Test CupertinoButton with color
  final coloredButton = CupertinoButton(
    color: CupertinoColors.systemBlue,
    child: Text('Blue Button'),
    onPressed: () {},
  );
  print('CupertinoButton with color created');

  // Test CupertinoButton disabled
  final disabledButton = CupertinoButton(
    onPressed: null,
    child: Text('Disabled Button'),
  );
  print('CupertinoButton disabled created');

  // Test CupertinoButton with disabledColor
  final disabledColorButton = CupertinoButton(
    disabledColor: CupertinoColors.systemGrey3,
    onPressed: null,
    child: Text('Custom Disabled'),
  );
  print('CupertinoButton with disabledColor created [${disabledColorButton.hashCode }]');

  // Test CupertinoButton with padding
  final paddedButton = CupertinoButton(
    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
    child: Text('Padded Button'),
    onPressed: () {},
  );
  print('CupertinoButton with padding created');

  // Test CupertinoButton with minSize
  final minSizeButton = CupertinoButton(
    onPressed: () {}, minimumSize: Size(60.0, 60.0),
    child: Text('Min Size'),
  );
  print('CupertinoButton with minSize created [${minSizeButton.hashCode }]');

  // Test CupertinoButton with pressedOpacity
  final opacityButton = CupertinoButton(
    pressedOpacity: 0.3,
    child: Text('Custom Opacity'),
    onPressed: () {},
  );
  print('CupertinoButton with pressedOpacity created [${opacityButton.hashCode }]');

  // Test CupertinoButton with borderRadius
  final roundedButton = CupertinoButton(
    borderRadius: BorderRadius.circular(20.0),
    color: CupertinoColors.systemPurple,
    child: Text('Rounded'),
    onPressed: () {},
  );
  print('CupertinoButton with borderRadius created');

  // Test CupertinoButton with alignment
  final alignedButton = CupertinoButton(
    alignment: Alignment.centerLeft,
    child: Text('Left Aligned'),
    onPressed: () {},
  );
  print('CupertinoButton with alignment created [${alignedButton.hashCode }]');

  // Test CupertinoButton with Icon
  final iconButton = CupertinoButton(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(CupertinoIcons.add), SizedBox(width: 8.0), Text('Add')],
    ),
    onPressed: () {},
  );
  print('CupertinoButton with Icon created');

  // Test CupertinoButton.filled
  final filledButton = CupertinoButton.filled(
    child: Text('Filled Button'),
    onPressed: () {},
  );
  print('CupertinoButton.filled created');

  // Test CupertinoButton.filled with custom padding
  final filledPaddedButton = CupertinoButton.filled(
    padding: EdgeInsets.all(16.0),
    child: Text('Filled Padded'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with padding created');

  // Test CupertinoButton.filled disabled
  final filledDisabledButton = CupertinoButton.filled(
    onPressed: null,
    child: Text('Filled Disabled'),
  );
  print('CupertinoButton.filled disabled created');

  // Test CupertinoButton.filled with disabledColor
  final filledDisabledColorButton = CupertinoButton.filled(
    disabledColor: CupertinoColors.systemGrey,
    onPressed: null,
    child: Text('Custom Disabled'),
  );
  print('CupertinoButton.filled with disabledColor created [${filledDisabledColorButton.hashCode }]');

  // Test CupertinoButton.filled with minimumSize
  final filledMinSizeButton = CupertinoButton.filled(
    minimumSize: Size(50.0, 50.0),
    child: Text('Small'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with minSize created [${filledMinSizeButton.hashCode }]');

  // Test CupertinoButton.filled with pressedOpacity
  final filledOpacityButton = CupertinoButton.filled(
    pressedOpacity: 0.5,
    child: Text('Half Opacity'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with pressedOpacity created [${filledOpacityButton.hashCode }]');

  // Test CupertinoButton.filled with borderRadius
  final filledRoundedButton = CupertinoButton.filled(
    borderRadius: BorderRadius.circular(25.0),
    child: Text('Very Rounded'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with borderRadius created');

  // Test CupertinoButton.filled with alignment
  final filledAlignedButton = CupertinoButton.filled(
    alignment: Alignment.center,
    child: Text('Centered'),
    onPressed: () {},
  );
  print('CupertinoButton.filled with alignment created [${filledAlignedButton.hashCode }]');

  // Test different colored filled buttons
  final redFilledButton = CupertinoButton.filled(
    child: Text('Red Filled'),
    onPressed: () {},
  );
  print('Various colored CupertinoButton.filled created [${redFilledButton.hashCode }]');

  print('CupertinoButton test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CupertinoButton Test'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Basic Buttons:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              basicButton,
              SizedBox(height: 8.0),
              coloredButton,
              SizedBox(height: 8.0),
              disabledButton,

              SizedBox(height: 24.0),
              Text(
                'Styled Buttons:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              paddedButton,
              SizedBox(height: 8.0),
              roundedButton,
              SizedBox(height: 8.0),
              iconButton,

              SizedBox(height: 24.0),
              Text(
                'Filled Buttons:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              filledButton,
              SizedBox(height: 8.0),
              filledPaddedButton,
              SizedBox(height: 8.0),
              filledDisabledButton,
              SizedBox(height: 8.0),
              filledRoundedButton,

              SizedBox(height: 24.0),
              Text(
                'Button Grid:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  CupertinoButton(
                    color: CupertinoColors.systemRed,
                    child: Text('Red'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    color: CupertinoColors.systemOrange,
                    child: Text('Orange'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    color: CupertinoColors.systemGreen,
                    child: Text('Green'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    color: CupertinoColors.systemTeal,
                    child: Text('Teal'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    color: CupertinoColors.systemIndigo,
                    child: Text('Indigo'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
