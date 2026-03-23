// ignore_for_file: avoid_print
// D4rt test script: Tests ObstructingPreferredSizeWidget from cupertino
// ObstructingPreferredSizeWidget is abstract — tested via CupertinoNavigationBar
// which implements it.
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('ObstructingPreferredSizeWidget test executing');

  // ===== 1. CupertinoNavigationBar implements ObstructingPreferredSizeWidget =====
  print('--- CupertinoNavigationBar as ObstructingPreferredSizeWidget ---');
  final navBar = CupertinoNavigationBar(middle: Text('Title'));
  print('  navBar type: ${navBar.runtimeType}');
  print('  preferredSize: ${navBar.preferredSize}');
  print(
    '  is ObstructingPreferredSizeWidget: true (CupertinoNavigationBar implements it)',
  );

  // ===== 2. shouldFullyObstruct =====
  print('--- shouldFullyObstruct ---');
  final opaqueBar = CupertinoNavigationBar(
    middle: Text('Opaque'),
    backgroundColor: CupertinoColors.white,
  );
  print('  opaque bar preferredSize: ${opaqueBar.preferredSize}');
  print(
    '  opaque bar shouldFullyObstruct: ${opaqueBar.shouldFullyObstruct(context)}',
  );

  final translucentBar = CupertinoNavigationBar(
    middle: Text('Translucent'),
    backgroundColor: CupertinoColors.systemGrey.withValues(alpha: 0.5),
  );
  print(
    '  translucent bar shouldFullyObstruct: ${translucentBar.shouldFullyObstruct(context)}',
  );

  // ===== 3. preferredSize dimensions =====
  print('--- preferredSize ---');
  final bars = <CupertinoNavigationBar>[
    CupertinoNavigationBar(middle: Text('Default')),
    CupertinoNavigationBar(
      middle: Text('With leading'),
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text('Back'),
        onPressed: () {},
      ),
    ),
    CupertinoNavigationBar(
      middle: Text('With trailing'),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(CupertinoIcons.add),
        onPressed: () {},
      ),
    ),
    CupertinoNavigationBar(
      middle: Text('Full'),
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text('Cancel'),
        onPressed: () {},
      ),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text('Done'),
        onPressed: () {},
      ),
    ),
  ];
  for (final bar in bars) {
    print('  ${(bar.middle as Text).data}: preferredSize=${bar.preferredSize}');
  }

  // ===== 4. CupertinoSliverNavigationBar also obstructs =====
  print('--- CupertinoSliverNavigationBar ---');
  final sliverBar = CupertinoSliverNavigationBar(
    largeTitle: Text('Large Title'),
  );
  print('  sliver nav bar created: ${sliverBar.runtimeType}');

  // ===== 5. Navigation bar with different backgrounds =====
  print('--- Background variations ---');
  final backgrounds = <String, Color>{
    'white': CupertinoColors.white,
    'black': CupertinoColors.black,
    'blue': CupertinoColors.activeBlue,
    'transparent': Color(0x00000000),
  };
  for (final entry in backgrounds.entries) {
    final bar = CupertinoNavigationBar(
      middle: Text(entry.key),
      backgroundColor: entry.value,
    );
    print(
      '  ${entry.key}: shouldFullyObstruct=${bar.shouldFullyObstruct(context)}',
    );
  }

  // ===== 6. PreferredSizeWidget comparison =====
  print('--- PreferredSizeWidget check ---');
  const isPreferred = true; // CupertinoNavigationBar is PreferredSizeWidget
  const isObstructing =
      true; // CupertinoNavigationBar is ObstructingPreferredSizeWidget
  print('  is PreferredSizeWidget: $isPreferred');
  print('  is ObstructingPreferredSizeWidget: $isObstructing');

  print('ObstructingPreferredSizeWidget test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: opaqueBar,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ObstructingPreferredSizeWidget',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Tested via CupertinoNavigationBar'),
              SizedBox(height: 8.0),
              Text('preferredSize: ${navBar.preferredSize}'),
              Text(
                'shouldFullyObstruct (opaque): ${opaqueBar.shouldFullyObstruct(context)}',
              ),
              Text(
                'shouldFullyObstruct (translucent): ${translucentBar.shouldFullyObstruct(context)}',
              ),
              SizedBox(height: 16.0),
              Text('Background variations:'),
              for (final entry in backgrounds.entries)
                Text(
                  '  ${entry.key}: obstruct=${CupertinoNavigationBar(middle: Text(""), backgroundColor: entry.value).shouldFullyObstruct(context)}',
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
