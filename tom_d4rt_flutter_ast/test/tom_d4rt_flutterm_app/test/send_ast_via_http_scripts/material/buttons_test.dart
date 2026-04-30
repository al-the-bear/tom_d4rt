// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OutlinedButton, IconButton, FilledButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Buttons test executing');

  // Test OutlinedButton
  final basicOutlined = OutlinedButton(
    onPressed: () {
      print('OutlinedButton pressed');
    },
    child: Text('Outlined'),
  );
  print('Basic OutlinedButton created');

  // Test OutlinedButton with icon
  final outlinedWithIcon = OutlinedButton.icon(
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('Add Item'),
  );
  print('OutlinedButton.icon created');

  // Test OutlinedButton with style
  final styledOutlined = OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.purple,
      side: BorderSide(color: Colors.purple, width: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
    child: Text('Styled'),
  );
  print('OutlinedButton with custom style created');

  // Test disabled OutlinedButton
  final disabledOutlined = OutlinedButton(
    onPressed: null,
    child: Text('Disabled'),
  );
  print('Disabled OutlinedButton created');

  // Test IconButton
  final basicIconButton = IconButton(
    onPressed: () {
      print('IconButton pressed');
    },
    icon: Icon(Icons.favorite),
  );
  print('Basic IconButton created');

  // Test IconButton with tooltip
  final tooltipIconButton = IconButton(
    onPressed: () {},
    icon: Icon(Icons.share),
    tooltip: 'Share',
  );
  print('IconButton with tooltip created');

  // Test IconButton with color
  final coloredIconButton = IconButton(
    onPressed: () {},
    icon: Icon(Icons.star),
    color: Colors.amber,
  );
  print('IconButton with color=amber created');

  // Test IconButton with iconSize
  final largeIconButton = IconButton(
    onPressed: () {},
    icon: Icon(Icons.home),
    iconSize: 40.0,
  );
  print('IconButton with iconSize=40 created');

  // Test IconButton with splashRadius
  final splashIconButton = IconButton(
    onPressed: () {},
    icon: Icon(Icons.search),
    splashRadius: 30.0,
  );
  print('IconButton with splashRadius=30 created: $splashIconButton');

  // Test IconButton with constraints
  final constrainedIconButton = IconButton(
    onPressed: () {},
    icon: Icon(Icons.menu),
    constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
  );
  print('IconButton with constraints created: $constrainedIconButton');

  // Test IconButton with padding
  final paddedIconButton = IconButton(
    onPressed: () {},
    icon: Icon(Icons.settings),
    padding: EdgeInsets.all(16.0),
  );
  print('IconButton with padding=16 created: $paddedIconButton');

  // Test IconButton with alignment
  final alignedIconButton = IconButton(
    onPressed: () {},
    icon: Icon(Icons.arrow_forward),
    alignment: Alignment.centerRight,
  );
  print('IconButton with alignment created: $alignedIconButton');

  // Test IconButton.filled
  final filledIconButton = IconButton.filled(
    onPressed: () {},
    icon: Icon(Icons.add),
  );
  print('IconButton.filled created');

  // Test IconButton.filledTonal
  final tonalIconButton = IconButton.filledTonal(
    onPressed: () {},
    icon: Icon(Icons.edit),
  );
  print('IconButton.filledTonal created');

  // Test IconButton.outlined
  final outlinedIconButton = IconButton.outlined(
    onPressed: () {},
    icon: Icon(Icons.delete),
  );
  print('IconButton.outlined created');

  // Test IconButton with selectedIcon
  final toggleIconButton = IconButton(
    onPressed: () {},
    icon: Icon(Icons.favorite_border),
    selectedIcon: Icon(Icons.favorite),
    isSelected: false,
  );
  print('IconButton with selectedIcon created: $toggleIconButton');

  // Test FilledButton
  final basicFilled = FilledButton(
    onPressed: () {
      print('FilledButton pressed');
    },
    child: Text('Filled'),
  );
  print('Basic FilledButton created');

  // Test FilledButton.icon
  final filledWithIcon = FilledButton.icon(
    onPressed: () {},
    icon: Icon(Icons.send),
    label: Text('Send'),
  );
  print('FilledButton.icon created');

  // Test FilledButton.tonal
  final tonalFilled = FilledButton.tonal(
    onPressed: () {},
    child: Text('Tonal'),
  );
  print('FilledButton.tonal created');

  // Test FilledButton.tonalIcon
  final tonalFilledIcon = FilledButton.tonalIcon(
    onPressed: () {},
    icon: Icon(Icons.download),
    label: Text('Download'),
  );
  print('FilledButton.tonalIcon created');

  // Test FilledButton with style
  final styledFilled = FilledButton(
    onPressed: () {},
    style: FilledButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      minimumSize: Size(150.0, 50.0),
    ),
    child: Text('Custom'),
  );
  print('FilledButton with custom style created');

  // Test disabled FilledButton
  final disabledFilled = FilledButton(onPressed: null, child: Text('Disabled'));
  print('Disabled FilledButton created');

  // Test button styling with ButtonStyle
  final customStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.blue.shade700;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.blue.shade600;
      }
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey;
      }
      return Colors.blue;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );
  print('Custom ButtonStyle created with state handling');

  final customStyledButton = ElevatedButton(
    onPressed: () {},
    style: customStyle,
    child: Text('Custom Styled'),
  );
  print('Button with custom ButtonStyle created');

  print('Buttons test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buttons Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('OutlinedButton:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicOutlined,
            outlinedWithIcon,
            styledOutlined,
            disabledOutlined,
          ],
        ),
        SizedBox(height: 24.0),

        Text('IconButton:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicIconButton,
            tooltipIconButton,
            coloredIconButton,
            largeIconButton,
            filledIconButton,
            tonalIconButton,
            outlinedIconButton,
          ],
        ),
        SizedBox(height: 24.0),

        Text('FilledButton:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            basicFilled,
            filledWithIcon,
            tonalFilled,
            tonalFilledIcon,
            styledFilled,
            disabledFilled,
          ],
        ),
        SizedBox(height: 24.0),

        Text(
          'Custom ButtonStyle:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        customStyledButton,
        SizedBox(height: 24.0),

        Text('Key Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• onPressed - tap callback (null = disabled)'),
        Text('• child - button content'),
        Text('• style - ButtonStyle customization'),
        Text('• icon - for icon variants'),
        Text('• label - for icon variants'),
      ],
    ),
  );
}
