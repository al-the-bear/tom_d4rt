// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FloatingActionButton widget from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FloatingActionButton test executing');

  // Test basic FAB
  final basicFab = FloatingActionButton(
    onPressed: () {
      print('FAB pressed');
    },
    child: Icon(Icons.add),
  );
  print('Basic FloatingActionButton created');

  // Test FAB with tooltip
  final tooltipFab = FloatingActionButton(
    onPressed: () {},
    tooltip: 'Add Item',
    child: Icon(Icons.add),
  );
  print('FAB with tooltip created: $tooltipFab');

  // Test FAB.small
  final smallFab = FloatingActionButton.small(
    onPressed: () {},
    child: Icon(Icons.add),
  );
  print('FloatingActionButton.small created');

  // Test FAB.large
  final largeFab = FloatingActionButton.large(
    onPressed: () {},
    child: Icon(Icons.add),
  );
  print('FloatingActionButton.large created');

  // Test FAB.extended
  final extendedFab = FloatingActionButton.extended(
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('Add Item'),
  );
  print('FloatingActionButton.extended created');

  // Test FAB with custom colors
  final coloredFab = FloatingActionButton(
    onPressed: () {},
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    child: Icon(Icons.favorite),
  );
  print('FAB with custom colors created');

  // Test FAB with elevation
  final elevatedFab = FloatingActionButton(
    onPressed: () {},
    elevation: 12.0,
    highlightElevation: 16.0,
    child: Icon(Icons.star),
  );
  print('FAB with elevation=12 created');

  // Test FAB with focusElevation and hoverElevation
  final hoverFab = FloatingActionButton(
    onPressed: () {},
    focusElevation: 8.0,
    hoverElevation: 10.0,
    child: Icon(Icons.edit),
  );
  print('FAB with focus/hover elevation created: $hoverFab');

  // Test FAB with shape
  final shapedFab = FloatingActionButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    child: Icon(Icons.settings),
  );
  print('FAB with RoundedRectangleBorder created');

  // Test FAB with mini
  final miniFab = FloatingActionButton(
    onPressed: () {},
    mini: true,
    child: Icon(Icons.navigation),
  );
  print('FAB with mini=true created');

  // Test FAB with isExtended
  print('FAB isExtended property for extended FAB');

  // Test FAB with clipBehavior
  final clippedFab = FloatingActionButton(
    onPressed: () {},
    clipBehavior: Clip.antiAlias,
    child: Icon(Icons.crop),
  );
  print('FAB with clipBehavior=antiAlias created: $clippedFab');

  // Test FAB with focusNode
  final focusNode = FocusNode();
  final focusFab = FloatingActionButton(
    onPressed: () {},
    focusNode: focusNode,
    child: Icon(Icons.keyboard),
  );
  print('FAB with focusNode created: $focusFab');

  // Test FAB with autofocus
  final autofocusFab = FloatingActionButton(
    onPressed: () {},
    autofocus: true,
    child: Icon(Icons.auto_fix_high),
  );
  print('FAB with autofocus=true created: $autofocusFab');

  // Test FAB with materialTapTargetSize
  final padddedFab = FloatingActionButton(
    onPressed: () {},
    materialTapTargetSize: MaterialTapTargetSize.padded,
    child: Icon(Icons.touch_app),
  );
  print('FAB with materialTapTargetSize=padded created: $padddedFab');

  // Test FAB with enableFeedback
  final feedbackFab = FloatingActionButton(
    onPressed: () {},
    enableFeedback: true,
    child: Icon(Icons.vibration),
  );
  print('FAB with enableFeedback=true created: $feedbackFab');

  // Test FAB with splashColor
  final splashFab = FloatingActionButton(
    onPressed: () {},
    splashColor: Colors.red.withOpacity(0.5),
    child: Icon(Icons.water_drop),
  );
  print('FAB with custom splashColor created: $splashFab');

  // Test disabled FAB
  final disabledFab = FloatingActionButton(
    onPressed: null,
    child: Icon(Icons.block),
  );
  print('Disabled FAB (onPressed=null) created');

  // Test FAB with heroTag
  final heroFab = FloatingActionButton(
    onPressed: () {},
    heroTag: 'unique-fab-tag',
    child: Icon(Icons.flight),
  );
  print('FAB with heroTag created: $heroFab');

  // Test multiple FABs need different heroTags
  print('Note: Multiple FABs on same route need different heroTags');

  print('FloatingActionButton test completed');

  return Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FloatingActionButton Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('FAB Variants:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Column(
                children: [
                  basicFab,
                  SizedBox(height: 4.0),
                  Text('Regular', style: TextStyle(fontSize: 10.0)),
                ],
              ),
              Column(
                children: [
                  smallFab,
                  SizedBox(height: 4.0),
                  Text('Small', style: TextStyle(fontSize: 10.0)),
                ],
              ),
              Column(
                children: [
                  largeFab,
                  SizedBox(height: 4.0),
                  Text('Large', style: TextStyle(fontSize: 10.0)),
                ],
              ),
              Column(
                children: [
                  miniFab,
                  SizedBox(height: 4.0),
                  Text('Mini', style: TextStyle(fontSize: 10.0)),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.0),

          Text('Extended FAB:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          extendedFab,
          SizedBox(height: 24.0),

          Text('Styled FABs:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [coloredFab, elevatedFab, shapedFab, disabledFab],
          ),
          SizedBox(height: 24.0),

          Text(
            'Key Properties:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• onPressed - tap callback'),
          Text('• child - icon or widget'),
          Text('• tooltip - accessibility text'),
          Text('• backgroundColor - background'),
          Text('• foregroundColor - icon/text color'),
          Text('• elevation - shadow depth'),
          Text('• shape - button shape'),
          Text('• mini - smaller size'),
          Text('• heroTag - animation tag'),
        ],
      ),
    ),
    floatingActionButton: basicFab,
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}
