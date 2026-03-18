// D4rt test script: Tests CupertinoSheetTransition from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoSheetTransition test executing');

  // ===== 1. Basic CupertinoSheetTransition =====
  print('--- Basic CupertinoSheetTransition ---');
  final primaryAnim = AnimationController(
    vsync: Navigator.of(context),
    duration: Duration(milliseconds: 400),
    value: 1.0,
  );
  final secondaryAnim = AnimationController(
    vsync: Navigator.of(context),
    duration: Duration(milliseconds: 400),
    value: 0.0,
  );

  final basicTransition = CupertinoSheetTransition(
    primaryRouteAnimation: primaryAnim,
    secondaryRouteAnimation: secondaryAnim,
    linearTransition: false,
    child: Container(
      color: CupertinoColors.white,
      child: Center(child: Text('Sheet Content')),
    ),
  );
  print('  basic transition created');
  print('  child type: ${basicTransition.child.runtimeType}');

  // ===== 2. With linearTransition: true =====
  print('--- Linear transition ---');
  final linearTransition = CupertinoSheetTransition(
    primaryRouteAnimation: primaryAnim,
    secondaryRouteAnimation: secondaryAnim,
    linearTransition: true,
    child: Container(
      color: CupertinoColors.systemGrey6,
      child: Center(child: Text('Linear Sheet')),
    ),
  );
  print('  linear transition created');

  // ===== 3. With topGap =====
  print('--- With topGap ---');
  final gappedTransition = CupertinoSheetTransition(
    primaryRouteAnimation: primaryAnim,
    secondaryRouteAnimation: secondaryAnim,
    linearTransition: false,
    topGap: 56.0,
    child: Container(
      color: CupertinoColors.white,
      child: Center(child: Text('Gapped Sheet')),
    ),
  );
  print('  transition with topGap: 56.0 created');

  // ===== 4. Animation at different phases =====
  print('--- Animation phases ---');
  final phases = [0.0, 0.25, 0.5, 0.75, 1.0];
  for (final phase in phases) {
    final phaseAnim = AlwaysStoppedAnimation(phase);
    final phaseTransition = CupertinoSheetTransition(
      primaryRouteAnimation: phaseAnim,
      secondaryRouteAnimation: AlwaysStoppedAnimation(0.0),
      linearTransition: false,
      child: SizedBox(height: 50.0, child: Text('Phase $phase')),
    );
    print('  phase $phase transition created: ${phaseTransition.runtimeType}');
  }

  // ===== 5. With rich child content =====
  print('--- Rich child content ---');
  final richTransition = CupertinoSheetTransition(
    primaryRouteAnimation: primaryAnim,
    secondaryRouteAnimation: secondaryAnim,
    linearTransition: false,
    child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Sheet'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Close'),
          onPressed: () {},
        ),
      ),
      child: SafeArea(
        child: CupertinoListSection.insetGrouped(
          children: [
            CupertinoListTile(title: Text('Item 1')),
            CupertinoListTile(title: Text('Item 2')),
            CupertinoListTile(title: Text('Item 3')),
          ],
        ),
      ),
    ),
  );
  print('  rich transition with scaffold created');

  // ===== 6. Secondary animation active (push another route) =====
  print('--- Secondary animation active ---');
  final secondaryActive = CupertinoSheetTransition(
    primaryRouteAnimation: AlwaysStoppedAnimation(1.0),
    secondaryRouteAnimation: AlwaysStoppedAnimation(0.5),
    linearTransition: false,
    child: Center(child: Text('Being pushed back')),
  );
  print('  secondary-active transition created [${secondaryActive.hashCode }]');

  primaryAnim.dispose();
  secondaryAnim.dispose();

  print('CupertinoSheetTransition test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('SheetTransition')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200.0, child: basicTransition),
              SizedBox(height: 8.0),
              SizedBox(height: 200.0, child: linearTransition),
              SizedBox(height: 8.0),
              SizedBox(height: 200.0, child: gappedTransition),
              SizedBox(height: 8.0),
              SizedBox(height: 200.0, child: richTransition),
            ],
          ),
        ),
      ),
    ),
  );
}
