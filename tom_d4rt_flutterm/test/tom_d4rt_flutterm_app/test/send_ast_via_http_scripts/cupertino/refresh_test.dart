// D4rt test script: Tests CupertinoSliverRefreshControl from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoSliverRefreshControl test executing');

  // ========== CUPERTINOSLIVERREFRESHCONTROL ==========
  print('--- CupertinoSliverRefreshControl Tests ---');

  // Test basic CupertinoSliverRefreshControl
  final basicRefreshControl = CupertinoSliverRefreshControl(
    onRefresh: () async {
      print('Refreshing...');
    },
  );
  print('Basic CupertinoSliverRefreshControl created');

  // Test CupertinoSliverRefreshControl with refreshTriggerPullDistance
  final triggerRefreshControl = CupertinoSliverRefreshControl(
    refreshTriggerPullDistance: 150.0,
    onRefresh: () async {
      print('Custom trigger refresh');
    },
  );
  print(
    'CupertinoSliverRefreshControl with refreshTriggerPullDistance created',
  );

  // Test CupertinoSliverRefreshControl with refreshIndicatorExtent
  final extentRefreshControl = CupertinoSliverRefreshControl(
    refreshIndicatorExtent: 80.0,
    onRefresh: () async {
      print('Custom extent refresh');
    },
  );
  print('CupertinoSliverRefreshControl with refreshIndicatorExtent created');

  // Test CupertinoSliverRefreshControl with both distances
  final customRefreshControl = CupertinoSliverRefreshControl(
    refreshTriggerPullDistance: 120.0,
    refreshIndicatorExtent: 60.0,
    onRefresh: () async {
      print('Custom distances refresh');
    },
  );
  print('CupertinoSliverRefreshControl with custom distances created');

  // Test CupertinoSliverRefreshControl with custom builder
  final builderRefreshControl = CupertinoSliverRefreshControl(
    onRefresh: () async {
      print('Builder refresh');
    },
    builder:
        (
          BuildContext context,
          RefreshIndicatorMode refreshState,
          double pulledExtent,
          double refreshTriggerPullDistance,
          double refreshIndicatorExtent,
        ) {
          return Center(child: CupertinoActivityIndicator());
        },
  );
  print('CupertinoSliverRefreshControl with custom builder created');

  // Test CupertinoSliverRefreshControl without onRefresh (display only)
  final displayOnlyRefreshControl = CupertinoSliverRefreshControl();
  print('CupertinoSliverRefreshControl without onRefresh created');

  print('All CupertinoSliverRefreshControl construction tests passed');

  // ========== RETURN WIDGET ==========
  // Build a CustomScrollView with CupertinoSliverRefreshControl
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Refresh Test')),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(
              refreshTriggerPullDistance: 100.0,
              refreshIndicatorExtent: 60.0,
              onRefresh: () async {
                print('Pull-to-refresh triggered');
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'CupertinoSliverRefreshControl:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Pull down to refresh'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 1'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 2'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 3'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 4'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 5'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 6'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 7'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 8'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 9'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Item 10'),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.0),
                      Text(
                        'Tests Completed:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('• CupertinoSliverRefreshControl default'),
                      Text(
                        '• CupertinoSliverRefreshControl with refreshTriggerPullDistance',
                      ),
                      Text(
                        '• CupertinoSliverRefreshControl with refreshIndicatorExtent',
                      ),
                      Text(
                        '• CupertinoSliverRefreshControl with custom builder',
                      ),
                      Text('• CupertinoSliverRefreshControl display only'),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    ),
  );
}
