// D4rt test script: Tests CupertinoPageRoute, CupertinoPageTransition, CupertinoFullscreenDialogTransition from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino route test executing');

  // ========== CUPERTINOPAGEROUTE ==========
  print('--- CupertinoPageRoute Tests ---');

  // Test basic CupertinoPageRoute
  final basicRoute = CupertinoPageRoute(
    builder: (context) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Basic Route')),
      child: Center(child: Text('Basic Page')),
    ),
  );
  print('Basic CupertinoPageRoute created');

  // Test CupertinoPageRoute with title
  final titledRoute = CupertinoPageRoute(
    title: 'Details',
    builder: (context) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Details')),
      child: Center(child: Text('Details Page')),
    ),
  );
  print('CupertinoPageRoute with title created');

  // Test CupertinoPageRoute with maintainState
  final maintainStateRoute = CupertinoPageRoute(
    maintainState: true,
    builder: (context) =>
        CupertinoPageScaffold(child: Center(child: Text('Maintained'))),
  );
  print('CupertinoPageRoute with maintainState created');

  // Test CupertinoPageRoute with allowSnapshotting
  final snapshotRoute = CupertinoPageRoute(
    allowSnapshotting: true,
    builder: (context) =>
        CupertinoPageScaffold(child: Center(child: Text('Snapshotable'))),
  );
  print('CupertinoPageRoute with allowSnapshotting created');

  // Test CupertinoPageRoute without snapshot
  final noSnapshotRoute = CupertinoPageRoute(
    allowSnapshotting: false,
    builder: (context) =>
        CupertinoPageScaffold(child: Center(child: Text('No Snapshot'))),
  );
  print('CupertinoPageRoute with allowSnapshotting=false created');

  // Test CupertinoPageRoute with fullscreenDialog
  final fullscreenDialogRoute = CupertinoPageRoute(
    fullscreenDialog: true,
    builder: (context) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Cancel'),
          onPressed: () {},
        ),
        middle: Text('New Item'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Done'),
          onPressed: () {},
        ),
      ),
      child: Center(child: Text('Fullscreen Dialog')),
    ),
  );
  print('CupertinoPageRoute with fullscreenDialog created');

  // Test CupertinoPageRoute with settings
  final settingsRoute = CupertinoPageRoute(
    settings: RouteSettings(name: '/custom', arguments: {'id': 123}),
    builder: (context) =>
        CupertinoPageScaffold(child: Center(child: Text('With Settings'))),
  );
  print('CupertinoPageRoute with settings created');

  // Test CupertinoPageRoute with barrierDismissible
  final dismissibleRoute = CupertinoPageRoute(
    barrierDismissible: false,
    builder: (context) =>
        CupertinoPageScaffold(child: Center(child: Text('Not Dismissible'))),
  );
  print('CupertinoPageRoute with barrierDismissible created');

  // ========== CUPERTINOPAGETRANSITION ==========
  print('--- CupertinoPageTransition Tests ---');

  // Create animation controller simulation
  final animationController = AnimationController(
    vsync: TestVsync(),
    duration: Duration(milliseconds: 300),
  );

  // Probing animation for testing
  final animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInOut,
  );

  // Test basic CupertinoPageTransition
  final basicTransition = CupertinoPageTransition(
    primaryRouteAnimation: animation,
    secondaryRouteAnimation: animation,
    linearTransition: false,
    child: Center(child: Text('Page')),
  );
  print('Basic CupertinoPageTransition created');

  // Test CupertinoPageTransition with linearTransition
  final linearTransition = CupertinoPageTransition(
    primaryRouteAnimation: animation,
    secondaryRouteAnimation: animation,
    linearTransition: true,
    child: Center(child: Text('Linear')),
  );
  print('CupertinoPageTransition with linearTransition created');

  // ========== CUPERTINOFULLSCREENDIALOGTRANSITION ==========
  print('--- CupertinoFullscreenDialogTransition Tests ---');

  // Test basic CupertinoFullscreenDialogTransition
  final basicFullscreenTransition = CupertinoFullscreenDialogTransition(
    primaryRouteAnimation: animation,
    secondaryRouteAnimation: animation,
    linearTransition: false,
    child: Center(child: Text('Fullscreen Dialog')),
  );
  print('Basic CupertinoFullscreenDialogTransition created');

  // Test CupertinoFullscreenDialogTransition with linearTransition
  final linearFullscreenTransition = CupertinoFullscreenDialogTransition(
    primaryRouteAnimation: animation,
    secondaryRouteAnimation: animation,
    linearTransition: true,
    child: Center(child: Text('Linear Fullscreen')),
  );
  print('CupertinoFullscreenDialogTransition with linearTransition created');

  print('Cupertino route test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Page Routes')),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(
              'CupertinoPageRoute Examples',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),

            // Basic navigation
            Text(
              'Standard Push:',
              style: TextStyle(color: CupertinoColors.systemGrey),
            ),
            SizedBox(height: 8.0),
            CupertinoButton.filled(
              child: Text('Push Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    title: 'Pushed Page',
                    builder: (context) => CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                        middle: Text('Pushed Page'),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'This page was pushed with CupertinoPageRoute',
                            ),
                            SizedBox(height: 20.0),
                            CupertinoButton(
                              child: Text('Go Back'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),

            // Fullscreen dialog
            Text(
              'Fullscreen Dialog:',
              style: TextStyle(color: CupertinoColors.systemGrey),
            ),
            SizedBox(height: 8.0),
            CupertinoButton.filled(
              child: Text('Present Modal'),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                        leading: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        middle: Text('New Item'),
                        trailing: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            'Done',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CupertinoTextField(
                                placeholder: 'Enter item name',
                                padding: EdgeInsets.all(16.0),
                              ),
                              SizedBox(height: 16.0),
                              Text('This is a fullscreen dialog modal'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),

            // Named route settings
            Text(
              'With Route Settings:',
              style: TextStyle(color: CupertinoColors.systemGrey),
            ),
            SizedBox(height: 8.0),
            CupertinoButton.filled(
              child: Text('Push with Arguments'),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    settings: RouteSettings(
                      name: '/details',
                      arguments: {'itemId': 42, 'name': 'Test Item'},
                    ),
                    builder: (context) {
                      final args =
                          ModalRoute.of(context)?.settings.arguments
                              as Map<String, dynamic>?;
                      return CupertinoPageScaffold(
                        navigationBar: CupertinoNavigationBar(
                          middle: Text('Details'),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Route: ${ModalRoute.of(context)?.settings.name}',
                              ),
                              SizedBox(height: 8.0),
                              Text('Item ID: ${args?['itemId']}'),
                              Text('Name: ${args?['name']}'),
                              SizedBox(height: 20.0),
                              CupertinoButton(
                                child: Text('Go Back'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 24.0),

            Divider(),
            SizedBox(height: 16.0),

            // Transition info
            Text(
              'Page Transitions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CupertinoPageTransition',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Used for standard page transitions with horizontal slide animation.',
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'CupertinoFullscreenDialogTransition',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Used for modal dialogs with vertical slide up animation.',
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Multiple navigation
            Text(
              'Chained Navigation:',
              style: TextStyle(color: CupertinoColors.systemGrey),
            ),
            SizedBox(height: 8.0),
            CupertinoButton.filled(
              child: Text('Push Multiple Pages'),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    title: 'Page 1',
                    builder: (context) => CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                        middle: Text('Page 1'),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('First Page'),
                            SizedBox(height: 20.0),
                            CupertinoButton.filled(
                              child: Text('Go to Page 2'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    title: 'Page 2',
                                    builder: (context) => CupertinoPageScaffold(
                                      navigationBar: CupertinoNavigationBar(
                                        middle: Text('Page 2'),
                                        previousPageTitle: 'Page 1',
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Second Page'),
                                            SizedBox(height: 20.0),
                                            CupertinoButton(
                                              child: Text('Pop to Root'),
                                              onPressed: () =>
                                                  Navigator.popUntil(
                                                    context,
                                                    (route) => route.isFirst,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20.0),
          ],
        ),
      ),
    ),
  );
}

// Helper class for animation controller (since TickerProvider is not easily available in test)
class TestVsync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker((elapsed) {});
  }
}
