// D4rt test script: Tests CupertinoPage from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoPage test executing');

  // ===== 1. Basic CupertinoPage with required child =====
  print('--- Basic CupertinoPage ---');
  final basicPage = CupertinoPage(
    child: Center(child: Text('Basic Page Content')),
  );
  print('  basic page created');
  print('  child type: ${basicPage.child.runtimeType}');
  print('  maintainState: ${basicPage.maintainState}');
  print('  fullscreenDialog: ${basicPage.fullscreenDialog}');
  print('  canPop: ${basicPage.canPop}');
  print('  allowSnapshotting: ${basicPage.allowSnapshotting}');

  // ===== 2. CupertinoPage with title =====
  print('--- With title ---');
  final titledPage = CupertinoPage(
    title: 'Settings',
    child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Settings')),
      child: Center(child: Text('Settings Page')),
    ),
  );
  print('  titled page created');
  print('  title: ${titledPage.title}');

  // ===== 3. Fullscreen dialog page =====
  print('--- Fullscreen dialog ---');
  final dialogPage = CupertinoPage(
    fullscreenDialog: true,
    title: 'New Item',
    child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('New Item'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Cancel'),
          onPressed: () {},
        ),
      ),
      child: Center(child: Text('Dialog content')),
    ),
  );
  print('  fullscreenDialog: ${dialogPage.fullscreenDialog}');

  // ===== 4. Non-poppable page (canPop: false) =====
  print('--- Cannot pop ---');
  final nonPoppable = CupertinoPage(
    canPop: false,
    child: Center(child: Text('Cannot go back')),
  );
  print('  canPop: ${nonPoppable.canPop}');

  // ===== 5. maintainState false =====
  print('--- maintainState false ---');
  final noMaintain = CupertinoPage(
    maintainState: false,
    child: Center(child: Text('State not maintained')),
  );
  print('  maintainState: ${noMaintain.maintainState}');

  // ===== 6. allowSnapshotting false =====
  print('--- allowSnapshotting false ---');
  final noSnapshot = CupertinoPage(
    allowSnapshotting: false,
    child: Center(child: Text('No snapshots')),
  );
  print('  allowSnapshotting: ${noSnapshot.allowSnapshotting}');

  // ===== 7. CupertinoPage creates route =====
  print('--- createRoute ---');
  final routePage = CupertinoPage(
    title: 'Route Page',
    child: Center(child: Text('Route content')),
  );
  final route = routePage.createRoute(context);
  print('  route created: ${route.runtimeType}');

  // ===== 8. Multiple pages for navigation stack simulation =====
  print('--- Multiple pages ---');
  final pages = <CupertinoPage>[];
  for (var i = 0; i < 5; i++) {
    pages.add(CupertinoPage(
      title: 'Page $i',
      child: Center(child: Text('Content $i')),
    ));
  }
  print('  created ${pages.length} pages');
  for (final page in pages) {
    print('    title: ${page.title}');
  }

  // ===== 9. All properties combined =====
  print('--- All properties ---');
  final fullPage = CupertinoPage(
    title: 'Full Config',
    maintainState: true,
    fullscreenDialog: false,
    allowSnapshotting: true,
    canPop: true,
    child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Full Config')),
      child: Center(child: Text('Fully configured page')),
    ),
  );
  print('  title: ${fullPage.title}');
  print('  maintainState: ${fullPage.maintainState}');
  print('  fullscreenDialog: ${fullPage.fullscreenDialog}');
  print('  allowSnapshotting: ${fullPage.allowSnapshotting}');
  print('  canPop: ${fullPage.canPop}');

  print('CupertinoPage test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('CupertinoPage Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CupertinoPage Tests', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text('Basic: child=${basicPage.child.runtimeType}'),
              Text('Titled: title=${titledPage.title}'),
              Text('Dialog: fullscreen=${dialogPage.fullscreenDialog}'),
              Text('NonPop: canPop=${nonPoppable.canPop}'),
              Text('NoMaintain: maintainState=${noMaintain.maintainState}'),
              Text('NoSnap: allowSnapshotting=${noSnapshot.allowSnapshotting}'),
              Text('Route type: ${route.runtimeType}'),
              Text('Pages count: ${pages.length}'),
              SizedBox(height: 12.0),
              Text('Full config:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('  title: ${fullPage.title}'),
              Text('  maintainState: ${fullPage.maintainState}'),
              Text('  fullscreenDialog: ${fullPage.fullscreenDialog}'),
              Text('  canPop: ${fullPage.canPop}'),
            ],
          ),
        ),
      ),
    ),
  );
}
