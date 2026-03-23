// ignore_for_file: avoid_print
// D4rt test script: Tests Cupertino routing classes overview
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino routing test executing');

  // ===== 1. CupertinoPageRoute =====
  print('--- CupertinoPageRoute ---');
  final pageRoute = CupertinoPageRoute(
    builder: (ctx) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Page Route')),
      child: Center(child: Text('Via CupertinoPageRoute')),
    ),
    title: 'Page Route',
  );
  print('  CupertinoPageRoute created: ${pageRoute.runtimeType}');

  // ===== 2. CupertinoPageRoute with fullscreenDialog =====
  print('--- Fullscreen dialog route ---');
  final dialogRoute = CupertinoPageRoute(
    fullscreenDialog: true,
    builder: (ctx) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Dialog'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Close'),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
      ),
      child: Center(child: Text('Fullscreen dialog')),
    ),
  );
  print('  fullscreenDialog route: ${dialogRoute.fullscreenDialog}');

  // ===== 3. CupertinoPage declarative routing =====
  print('--- CupertinoPage ---');
  final page = CupertinoPage(
    child: Center(child: Text('Declarative page')),
    title: 'Declarative',
  );
  print('  CupertinoPage: title=${page.title}');

  // ===== 4. CupertinoSheetRoute =====
  print('--- CupertinoSheetRoute ---');
  final sheetRoute = CupertinoSheetRoute(
    builder: (ctx) => CupertinoPageScaffold(
      child: Center(child: Text('Sheet content')),
    ),
  );
  print('  CupertinoSheetRoute: ${sheetRoute.runtimeType}');

  // ===== 5. Navigator.push with CupertinoPageRoute =====
  print('--- Navigator integration ---');
  final pushButton = CupertinoButton(
    child: Text('Push Page'),
    onPressed: () {
      Navigator.of(context).push(CupertinoPageRoute(
        builder: (ctx) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Pushed')),
          child: SafeArea(
            child: Center(
              child: CupertinoButton(
                child: Text('Go Back'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ),
          ),
        ),
      ));
    },
  );
  print('  push button created');

  // ===== 6. showCupertinoModalPopup =====
  print('--- Modal popup ---');
  final modalButton = CupertinoButton(
    child: Text('Show Modal'),
    onPressed: () {
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) => CupertinoActionSheet(
          title: Text('Options'),
          actions: [
            CupertinoActionSheetAction(
              child: Text('Option 1'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            CupertinoActionSheetAction(
              child: Text('Option 2'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
        ),
      );
    },
  );
  print('  modal button created');

  // ===== 7. showCupertinoDialog =====
  print('--- Cupertino dialog ---');
  final dialogButton = CupertinoButton(
    child: Text('Show Dialog'),
    onPressed: () {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text('Alert'),
          content: Text('This is an alert dialog'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    },
  );
  print('  dialog button created');

  // ===== 8. showCupertinoSheet =====
  print('--- Sheet ---');
  final sheetButton = CupertinoButton(
    child: Text('Show Sheet'),
    onPressed: () {
      showCupertinoSheet(
        context: context, builder: (ctx) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Sheet')),
          child: Center(child: Text('Sheet page')),
        ),
      );
    },
  );
  print('  sheet button created');

  print('Cupertino routing test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Routes Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              pushButton,
              SizedBox(height: 8.0),
              modalButton,
              SizedBox(height: 8.0),
              dialogButton,
              SizedBox(height: 8.0),
              sheetButton,
              SizedBox(height: 24.0),
              Text('Route types:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('CupertinoPageRoute: ${pageRoute.runtimeType}'),
              Text('CupertinoSheetRoute: ${sheetRoute.runtimeType}'),
              Text('CupertinoPage: ${page.runtimeType}'),
            ],
          ),
        ),
      ),
    ),
  );
}
