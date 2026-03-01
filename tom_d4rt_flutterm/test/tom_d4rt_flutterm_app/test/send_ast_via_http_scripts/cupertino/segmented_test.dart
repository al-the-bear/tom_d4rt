// D4rt test script: Tests CupertinoSegmentedControl, CupertinoSlidingSegmentedControl from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino segmented control test executing');

  // ========== CUPERTINODINGSEGMENTEDCONTROL ==========
  print('--- CupertinoSlidingSegmentedControl Tests ---');

  // Test basic CupertinoSlidingSegmentedControl
  final basicSlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    children: {0: Text('First'), 1: Text('Second'), 2: Text('Third')},
    groupValue: 0,
    onValueChanged: (value) {
      print('Sliding value changed to: $value');
    },
  );
  print('Basic CupertinoSlidingSegmentedControl created');

  // Test CupertinoSlidingSegmentedControl with two items
  final twoItemSlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    children: {0: Text('Yes'), 1: Text('No')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with two items created');

  // Test CupertinoSlidingSegmentedControl with icons
  final iconSlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Icon(CupertinoIcons.list_bullet),
      1: Icon(CupertinoIcons.square_grid_2x2),
      2: Icon(CupertinoIcons.rectangle_grid_1x2),
    },
    groupValue: 1,
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with icons created');

  // Test CupertinoSlidingSegmentedControl with icon and text
  final iconTextSlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.sun_max, size: 16.0),
          SizedBox(width: 4.0),
          Text('Day'),
        ],
      ),
      1: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.moon, size: 16.0),
          SizedBox(width: 4.0),
          Text('Night'),
        ],
      ),
    },
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with icon and text created');

  // Test CupertinoSlidingSegmentedControl with thumbColor
  final thumbColorSlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    thumbColor: CupertinoColors.systemBlue,
    children: {0: Text('One'), 1: Text('Two')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with thumbColor created');

  // Test CupertinoSlidingSegmentedControl with backgroundColor
  final bgSlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    backgroundColor: CupertinoColors.systemGrey5,
    children: {0: Text('A'), 1: Text('B'), 2: Text('C')},
    groupValue: 1,
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with backgroundColor created');

  // Test CupertinoSlidingSegmentedControl with padding
  final paddedSlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    padding: EdgeInsets.all(4.0),
    children: {0: Text('First'), 1: Text('Second')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with padding created');

  // Test CupertinoSlidingSegmentedControl with string keys
  final stringSlidingSegmented = CupertinoSlidingSegmentedControl<String>(
    children: {
      'all': Text('All'),
      'active': Text('Active'),
      'completed': Text('Completed'),
    },
    groupValue: 'all',
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with string keys created');

  // Test CupertinoSlidingSegmentedControl with no selection (null)
  final nullSlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    children: {0: Text('None'), 1: Text('Some'), 2: Text('All')},
    groupValue: null,
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with null groupValue created');

  // Test CupertinoSlidingSegmentedControl with many items
  final manySlidingSegmented = CupertinoSlidingSegmentedControl<int>(
    children: {
      0: Text('Mon'),
      1: Text('Tue'),
      2: Text('Wed'),
      3: Text('Thu'),
      4: Text('Fri'),
    },
    groupValue: 2,
    onValueChanged: (value) {},
  );
  print('CupertinoSlidingSegmentedControl with many items created');

  // ========== CUPERTINOSEGMENTEDCONTROL ==========
  print('--- CupertinoSegmentedControl Tests ---');

  // Test basic CupertinoSegmentedControl
  final basicSegmented = CupertinoSegmentedControl<int>(
    children: {0: Text('First'), 1: Text('Second'), 2: Text('Third')},
    groupValue: 0,
    onValueChanged: (value) {
      print('Segmented value changed to: $value');
    },
  );
  print('Basic CupertinoSegmentedControl created');

  // Test CupertinoSegmentedControl with two items
  final twoItemSegmented = CupertinoSegmentedControl<int>(
    children: {0: Text('On'), 1: Text('Off')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with two items created');

  // Test CupertinoSegmentedControl with unselectedColor
  final unselectedColorSegmented = CupertinoSegmentedControl<int>(
    unselectedColor: CupertinoColors.white,
    children: {0: Text('A'), 1: Text('B')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with unselectedColor created');

  // Test CupertinoSegmentedControl with selectedColor
  final selectedColorSegmented = CupertinoSegmentedControl<int>(
    selectedColor: CupertinoColors.systemGreen,
    children: {0: Text('Green'), 1: Text('Default')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with selectedColor created');

  // Test CupertinoSegmentedControl with borderColor
  final borderColorSegmented = CupertinoSegmentedControl<int>(
    borderColor: CupertinoColors.systemRed,
    children: {0: Text('Red'), 1: Text('Border')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with borderColor created');

  // Test CupertinoSegmentedControl with pressedColor
  final pressedColorSegmented = CupertinoSegmentedControl<int>(
    pressedColor: CupertinoColors.systemGrey3,
    children: {0: Text('Press'), 1: Text('Me')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with pressedColor created');

  // Test CupertinoSegmentedControl with padding
  final paddedSegmented = CupertinoSegmentedControl<int>(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    children: {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Padded'),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Items'),
      ),
    },
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with padding created');

  // Test CupertinoSegmentedControl with icons
  final iconSegmented = CupertinoSegmentedControl<int>(
    children: {
      0: Icon(CupertinoIcons.star),
      1: Icon(CupertinoIcons.heart),
      2: Icon(CupertinoIcons.bookmark),
    },
    groupValue: 1,
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with icons created');

  // Test CupertinoSegmentedControl with string keys
  final stringSegmented = CupertinoSegmentedControl<String>(
    children: {
      'small': Text('S'),
      'medium': Text('M'),
      'large': Text('L'),
      'xlarge': Text('XL'),
    },
    groupValue: 'medium',
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with string keys created');

  // Test CupertinoSegmentedControl with all colors customized
  final customColorsSegmented = CupertinoSegmentedControl<int>(
    unselectedColor: CupertinoColors.systemGrey6,
    selectedColor: CupertinoColors.systemPurple,
    borderColor: CupertinoColors.systemPurple,
    pressedColor: CupertinoColors.systemPurple.withOpacity(0.2),
    children: {0: Text('Custom'), 1: Text('Colors')},
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('CupertinoSegmentedControl with all colors customized created');

  print('Cupertino segmented control test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Segmented Controls')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sliding Segmented Controls
              Text(
                'CupertinoSlidingSegmentedControl',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 12.0),

              // Basic sliding
              Text(
                'Basic:',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSlidingSegmentedControl<int>(
                children: {0: Text('All'), 1: Text('Missed')},
                groupValue: 0,
                onValueChanged: (value) {},
              ),
              SizedBox(height: 16.0),

              // Three items
              Text(
                'Three Items:',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSlidingSegmentedControl<int>(
                children: {0: Text('Day'), 1: Text('Week'), 2: Text('Month')},
                groupValue: 1,
                onValueChanged: (value) {},
              ),
              SizedBox(height: 16.0),

              // With icons
              Text(
                'Icons:',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSlidingSegmentedControl<int>(
                children: {
                  0: Icon(CupertinoIcons.list_bullet),
                  1: Icon(CupertinoIcons.square_grid_2x2),
                },
                groupValue: 0,
                onValueChanged: (value) {},
              ),
              SizedBox(height: 16.0),

              // Custom thumb color
              Text(
                'Custom Thumb Color:',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSlidingSegmentedControl<int>(
                thumbColor: CupertinoColors.systemGreen,
                children: {0: Text('Active'), 1: Text('Inactive')},
                groupValue: 0,
                onValueChanged: (value) {},
              ),
              SizedBox(height: 24.0),

              // Segmented Controls (iOS 12 style)
              Divider(),
              SizedBox(height: 16.0),
              Text(
                'CupertinoSegmentedControl',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 12.0),

              // Basic segmented
              Text(
                'Basic:',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSegmentedControl<int>(
                children: {0: Text('One'), 1: Text('Two'), 2: Text('Three')},
                groupValue: 0,
                onValueChanged: (value) {},
              ),
              SizedBox(height: 16.0),

              // Custom colors
              Text(
                'Custom Colors (Green):',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSegmentedControl<int>(
                selectedColor: CupertinoColors.systemGreen,
                borderColor: CupertinoColors.systemGreen,
                pressedColor: CupertinoColors.systemGreen.withOpacity(0.2),
                children: {0: Text('Option A'), 1: Text('Option B')},
                groupValue: 0,
                onValueChanged: (value) {},
              ),
              SizedBox(height: 16.0),

              // Custom colors (Red)
              Text(
                'Custom Colors (Red):',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSegmentedControl<int>(
                selectedColor: CupertinoColors.systemRed,
                borderColor: CupertinoColors.systemRed,
                children: {0: Text('Delete'), 1: Text('Keep')},
                groupValue: 1,
                onValueChanged: (value) {},
              ),
              SizedBox(height: 16.0),

              // Sizes
              Text(
                'Size Selector:',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSegmentedControl<String>(
                children: {
                  'xs': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('XS'),
                  ),
                  's': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('S'),
                  ),
                  'm': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('M'),
                  ),
                  'l': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('L'),
                  ),
                  'xl': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('XL'),
                  ),
                },
                groupValue: 'm',
                onValueChanged: (value) {},
              ),
              SizedBox(height: 16.0),

              // Icons
              Text(
                'With Icons:',
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 8.0),
              CupertinoSegmentedControl<int>(
                children: {
                  0: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(CupertinoIcons.text_alignleft, size: 20.0),
                  ),
                  1: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(CupertinoIcons.text_aligncenter, size: 20.0),
                  ),
                  2: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(CupertinoIcons.text_alignright, size: 20.0),
                  ),
                },
                groupValue: 1,
                onValueChanged: (value) {},
              ),

              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    ),
  );
}
