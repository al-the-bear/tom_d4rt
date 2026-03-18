// D4rt test script: Tests CupertinoSheetRoute from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoSheetRoute test executing');

  // ===== 1. Show sheet route via button =====
  print('--- CupertinoSheetRoute via showCupertinoSheet ---');
  final showSheetButton = CupertinoButton(
    child: Text('Show Sheet'),
    onPressed: () {
      showCupertinoSheet(
        context: context, builder: (sheetContext) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Sheet'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text('Done'),
              onPressed: () => Navigator.of(sheetContext).pop(),
            ),
          ),
          child: Center(child: Text('Sheet content')),
        ),
      );
    },
  );
  print('  show sheet button created');

  // ===== 2. CupertinoSheetRoute with builder =====
  print('--- CupertinoSheetRoute direct construction ---');
  final sheetRoute = CupertinoSheetRoute(
    builder: (routeContext) => CupertinoPageScaffold(
      child: Center(child: Text('Direct route content')),
    ),
  );
  print('  sheet route created: ${sheetRoute.runtimeType}');

  // ===== 3. With enableDrag: false =====
  print('--- enableDrag: false ---');
  final noDragRoute = CupertinoSheetRoute(
    enableDrag: false,
    builder: (routeContext) => CupertinoPageScaffold(
      child: Center(child: Text('No drag')),
    ),
  );
  print('  no-drag route created [${noDragRoute.hashCode }]');

  // ===== 4. With showDragHandle: true =====
  print('--- showDragHandle: true ---');
  final dragHandleButton = CupertinoButton(
    child: Text('Sheet with Handle'),
    onPressed: () {
      showCupertinoSheet(
        context: context, builder: (ctx) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Drag Handle')),
          child: Center(child: Text('Has drag handle')),
        ),
      );
    },
  );
  print('  drag handle sheet button created');

  // ===== 5. Nested sheets =====
  print('--- Nested sheets ---');
  final nestedButton = CupertinoButton(
    child: Text('Nested Sheet'),
    onPressed: () {
      showCupertinoSheet(
        context: context, builder: (ctx1) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Sheet 1')),
          child: Center(
            child: CupertinoButton(
              child: Text('Open Sheet 2'),
              onPressed: () {
                showCupertinoSheet(
                  context: ctx1, builder: (ctx2) => CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(middle: Text('Sheet 2')),
                    child: Center(child: Text('Nested sheet content')),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
  print('  nested sheet button created');

  // ===== 6. Sheet with list content =====
  print('--- Sheet with list content ---');
  final listSheetButton = CupertinoButton(
    child: Text('List Sheet'),
    onPressed: () {
      showCupertinoSheet(
        context: context, builder: (ctx) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Options')),
          child: SafeArea(
            child: CupertinoListSection.insetGrouped(
              children: [
                for (var i = 0; i < 8; i++)
                  CupertinoListTile(
                    title: Text('Option $i'),
                    trailing: CupertinoListTileChevron(),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
  print('  list sheet button created');

  print('CupertinoSheetRoute test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('SheetRoute Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              showSheetButton,
              SizedBox(height: 12.0),
              dragHandleButton,
              SizedBox(height: 12.0),
              nestedButton,
              SizedBox(height: 12.0),
              listSheetButton,
              SizedBox(height: 24.0),
              Text('Route type: ${sheetRoute.runtimeType}'),
            ],
          ),
        ),
      ),
    ),
  );
}
