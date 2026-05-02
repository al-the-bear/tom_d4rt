// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live demo gallery - DrawerControllerState programmatic drive
// Nine sections that demonstrate how DrawerControllerState lets calling code
// open(), close(), or query isOpen on a Drawer / DrawerController. Each
// interactive section embeds its own mini-Scaffold inside a fixed-height
// SizedBox so multiple drawers coexist on a single scrolling page. We use
// GlobalKey<DrawerControllerState> to grab the state object that Flutter's
// DrawerController creates internally; this is the same trick that
// ScaffoldState uses under the hood when you write
// Scaffold.of(context).openDrawer().
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION 1 - HERO CARD
  // ---------------------------------------------------------------------------
  // The hero card sits at the top of the page. It does not host any drawer of
  // its own - it just explains the contract of DrawerControllerState in plain
  // English, so the rest of the page can show practical recipes without each
  // section repeating the same prose. Scaffold itself uses a private
  // GlobalKey<DrawerControllerState> internally; when you call
  // Scaffold.of(context).openDrawer() Flutter forwards that to the same
  // open() method we use directly in the recipes below.
  // ===========================================================================

  // ===========================================================================
  // SECTION 2 - DEFAULT DRAWER (Scaffold.of)
  // ---------------------------------------------------------------------------
  // The simplest baseline: a mini-Scaffold with `drawer:` set. The buttons
  // here use Scaffold.of(context).openDrawer() and Scaffold.of(context)
  // .closeDrawer() rather than a GlobalKey<DrawerControllerState>. We keep it
  // around so a reader can compare "I want to use the public Scaffold API"
  // against "I want to drive DrawerControllerState directly".
  // ===========================================================================

  // ===========================================================================
  // SECTION 3 - CUSTOM DRAWERCONTROLLER WITH GLOBALKEY
  // ---------------------------------------------------------------------------
  // We instantiate a DrawerController by hand, give it a
  // GlobalKey<DrawerControllerState>, and add a button row that calls
  // .currentState!.open(), .close(), and reads .isOpen. This is the canonical
  // recipe for "I need programmatic access to the drawer's state object."
  // ===========================================================================
  final leftDrawerKey = GlobalKey<DrawerControllerState>();
  final leftDrawerOpen = ValueNotifier<bool>(false);

  // ===========================================================================
  // SECTION 4 - END DRAWER VARIANT
  // ---------------------------------------------------------------------------
  // Same recipe as section 3 but the DrawerController is configured with
  // alignment: DrawerAlignment.end so the drawer slides in from the right.
  // The state API is identical - open/close/isOpen still work, only the
  // visual side changes.
  // ===========================================================================
  final rightDrawerKey = GlobalKey<DrawerControllerState>();
  final rightDrawerOpen = ValueNotifier<bool>(false);

  // ===========================================================================
  // SECTION 5 - WIDTH SWEEP
  // ---------------------------------------------------------------------------
  // Three side-by-side mini-scaffolds, each owning its own
  // GlobalKey<DrawerControllerState> and a Drawer with a different width
  // (200, 280, 360). This shows that DrawerControllerState is per-controller -
  // each key drives exactly one drawer instance.
  // ===========================================================================
  final width200Key = GlobalKey<DrawerControllerState>();
  final width280Key = GlobalKey<DrawerControllerState>();
  final width360Key = GlobalKey<DrawerControllerState>();
  final width200Open = ValueNotifier<bool>(false);
  final width280Open = ValueNotifier<bool>(false);
  final width360Open = ValueNotifier<bool>(false);

  // ===========================================================================
  // SECTION 6 - DRAG START BEHAVIOR COMPARISON
  // ---------------------------------------------------------------------------
  // Two DrawerControllers in the same mini-app. One uses
  // DragStartBehavior.start, the other DragStartBehavior.down. The
  // DrawerControllerState is unchanged across both - this section is here
  // mostly to illustrate that programmatic open/close is orthogonal to the
  // gesture dispatch policy of the underlying drag recogniser.
  // ===========================================================================
  final dragStartKey = GlobalKey<DrawerControllerState>();
  final dragDownKey = GlobalKey<DrawerControllerState>();
  final dragStartOpen = ValueNotifier<bool>(false);
  final dragDownOpen = ValueNotifier<bool>(false);

  // ===========================================================================
  // SECTION 7 - LOCKED DRAWER (drawerBarrierDismissible: false)
  // ---------------------------------------------------------------------------
  // A DrawerController with drawerBarrierDismissible: false. The user cannot
  // tap the scrim to close it; the only escape is calling
  // lockedKey.currentState!.close() from a button outside the drawer scope.
  // ===========================================================================
  final lockedKey = GlobalKey<DrawerControllerState>();

  // ===========================================================================
  // SECTION 8 - MULTI-DRAWER RECIPE
  // ---------------------------------------------------------------------------
  // A custom Stack that holds two DrawerControllers, one with leading
  // alignment and one with trailing alignment. Four buttons drive both
  // drawers independently using their own GlobalKey<DrawerControllerState>.
  // ===========================================================================
  final multiLeftKey = GlobalKey<DrawerControllerState>();
  final multiRightKey = GlobalKey<DrawerControllerState>();

  // ===========================================================================
  // SECTION 9 - REFERENCE CARD
  // ---------------------------------------------------------------------------
  // A reference card listing every public method/getter on
  // DrawerControllerState that we actually exercised on this page, plus a
  // one-liner explaining each one.
  // ===========================================================================

  print('=== DrawerControllerState Deep Demo ===');
  print('Section 1: hero card explaining DrawerControllerState');
  print('Section 2: default drawer using Scaffold.of(context).openDrawer()');
  print('Section 3: custom DrawerController + GlobalKey<DrawerControllerState>');
  print('Section 4: end drawer variant (alignment: DrawerAlignment.end)');
  print('Section 5: drawer width sweep (200 / 280 / 360)');
  print('Section 6: drag start behavior comparison (start vs down)');
  print('Section 7: locked drawer (dismissible: false)');
  print('Section 8: multi-drawer recipe (leading + trailing)');
  print('Section 9: reference card for DrawerControllerState API');
  print('Total GlobalKey<DrawerControllerState> instances declared: 9');

  // Distinct palettes per section.
  const heroBg1 = Color(0xFF1A237E);
  const heroBg2 = Color(0xFF311B92);

  const sec2Bg = Color(0xFFE3F2FD);
  const sec2Accent = Color(0xFF1565C0);

  const sec3Bg = Color(0xFFE8F5E9);
  const sec3Accent = Color(0xFF2E7D32);

  const sec4Bg = Color(0xFFFFF3E0);
  const sec4Accent = Color(0xFFEF6C00);

  const sec5Bg = Color(0xFFFCE4EC);
  const sec5Accent = Color(0xFFC2185B);

  const sec6Bg = Color(0xFFEDE7F6);
  const sec6Accent = Color(0xFF4527A0);

  const sec7Bg = Color(0xFFFFEBEE);
  const sec7Accent = Color(0xFFC62828);

  const sec8Bg = Color(0xFFE0F7FA);
  const sec8Accent = Color(0xFF00838F);

  const sec9Bg = Color(0xFFF1F8E9);
  const sec9Accent = Color(0xFF558B2F);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DrawerControllerState Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('DrawerControllerState'),
        backgroundColor: heroBg1,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ================================================================
              // SECTION 1 - HERO CARD
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [heroBg1, heroBg2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DrawerControllerState',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'The state object behind every Drawer.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'How to grab one:',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      '  final key = GlobalKey<DrawerControllerState>();',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '  DrawerController(key: key, alignment: ..., child: ...);',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '  key.currentState!.open();   // slide in',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '  key.currentState!.close();  // slide out',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '  // open state mirror via drawerCallback:',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                    Text(
                      '  drawerCallback: (o) => isOpen = o;',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Internally Scaffold owns a GlobalKey<DrawerControllerState> '
                      'and that is exactly what Scaffold.of(context).openDrawer() '
                      'reaches into.',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // SECTION 2 - DEFAULT DRAWER (Scaffold.of)
              // ================================================================
              const Text(
                '2. Default drawer driven via Scaffold.of(context).openDrawer()',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'No GlobalKey here - this is the high-level path the framework '
                'gives you for free. Scaffold.of() walks the element tree to find '
                'the surrounding ScaffoldState, which then delegates into the '
                'private DrawerControllerState that Scaffold owns.',
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  color: sec2Bg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: sec2Accent, width: 1.5),
                ),
                child: SizedBox(
                  height: 360.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Section2',
                      home: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          backgroundColor: sec2Accent,
                          foregroundColor: Colors.white,
                          title: const Text('Section 2 mini-app'),
                          automaticallyImplyLeading: false,
                        ),
                        drawer: const Drawer(
                          child: SafeArea(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Default Drawer',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Driven by Scaffold.of(context)'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        body: Builder(
                          builder: (innerCtx) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'This Scaffold owns a private '
                                    'DrawerControllerState behind the scenes.',
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.menu),
                                        label: const Text('Open'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: sec2Accent,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          print('Section 2 -> '
                                              'Scaffold.of(context).openDrawer()');
                                          Scaffold.of(innerCtx).openDrawer();
                                        },
                                      ),
                                      OutlinedButton.icon(
                                        icon: const Icon(Icons.close),
                                        label: const Text('Close'),
                                        onPressed: () {
                                          print('Section 2 -> '
                                              'Scaffold.of(context).closeDrawer()');
                                          Navigator.of(innerCtx).maybePop();
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: sec2Accent),
                                    ),
                                    child: const Text(
                                      'Note: Scaffold.of returns a ScaffoldState. '
                                      'ScaffoldState delegates open/close to its '
                                      'internal DrawerControllerState. So this '
                                      'section is "the indirect path".',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // SECTION 3 - CUSTOM DRAWERCONTROLLER WITH GLOBALKEY
              // ================================================================
              const Text(
                '3. Custom DrawerController + GlobalKey<DrawerControllerState>',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'This is the canonical recipe. We mount a DrawerController '
                'directly inside the body Stack, give it our own '
                'GlobalKey<DrawerControllerState>, and call .currentState!.open() '
                'and .close() from buttons. No Scaffold drawer slot involved.',
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  color: sec3Bg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: sec3Accent, width: 1.5),
                ),
                child: SizedBox(
                  height: 360.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Section3',
                      home: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          backgroundColor: sec3Accent,
                          foregroundColor: Colors.white,
                          title: const Text('Section 3 mini-app'),
                          automaticallyImplyLeading: false,
                        ),
                        body: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hand-built DrawerController. The buttons '
                                    'below talk to leftDrawerKey.currentState.',
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: sec3Accent,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          print('Section 3 -> '
                                              'leftDrawerKey.currentState.open()');
                                          leftDrawerKey.currentState?.open();
                                        },
                                        child: const Text('Open'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          print('Section 3 -> '
                                              'leftDrawerKey.currentState.close()');
                                          leftDrawerKey.currentState?.close();
                                        },
                                        child: const Text('Close'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          final st = leftDrawerKey.currentState;
                                          final isOpen = leftDrawerOpen.value;
                                          print('Section 3 -> isOpen=$isOpen');
                                          if (isOpen) {
                                            st?.close();
                                          } else {
                                            st?.open();
                                          }
                                        },
                                        child: const Text('Toggle'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: sec3Bg,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: sec3Accent),
                                    ),
                                    child: const Text(
                                      'Tap-outside-the-scrim still closes the '
                                      'drawer because dismissible defaults to '
                                      'true. Section 7 turns that off.',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DrawerController(
                              key: leftDrawerKey,
                              alignment: DrawerAlignment.start,
                              drawerCallback: (isOpened) {
                                leftDrawerOpen.value = isOpened;
                                print('Section 3 callback isOpened=$isOpened');
                              },
                              child: const Drawer(
                                child: SafeArea(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Section 3 Drawer',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Mounted by hand inside a Stack.',
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // SECTION 4 - END DRAWER VARIANT
              // ================================================================
              const Text(
                '4. End drawer variant (alignment: DrawerAlignment.end)',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Same recipe as section 3, only the alignment changes. '
                'DrawerControllerState does not care which side it slides from - '
                'open() / close() / isOpen all behave identically.',
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  color: sec4Bg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: sec4Accent, width: 1.5),
                ),
                child: SizedBox(
                  height: 360.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Section4',
                      home: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          backgroundColor: sec4Accent,
                          foregroundColor: Colors.white,
                          title: const Text('Section 4 mini-app (end)'),
                          automaticallyImplyLeading: false,
                        ),
                        body: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'End drawer slides in from the right. The '
                                    'state object is the same shape, only the '
                                    'alignment is flipped.',
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: sec4Accent,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          print('Section 4 -> '
                                              'rightDrawerKey.currentState.open()');
                                          rightDrawerKey.currentState?.open();
                                        },
                                        child: const Text('Open'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          print('Section 4 -> '
                                              'rightDrawerKey.currentState.close()');
                                          rightDrawerKey.currentState?.close();
                                        },
                                        child: const Text('Close'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          final st =
                                              rightDrawerKey.currentState;
                                          final isOpen = rightDrawerOpen.value;
                                          print('Section 4 -> isOpen=$isOpen');
                                          if (isOpen) {
                                            st?.close();
                                          } else {
                                            st?.open();
                                          }
                                        },
                                        child: const Text('Toggle'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: sec4Bg,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: sec4Accent),
                                    ),
                                    child: const Text(
                                      'Convention: end drawers usually host '
                                      'filters or context panels rather than '
                                      'navigation. The state API does not '
                                      'change.',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DrawerController(
                              key: rightDrawerKey,
                              alignment: DrawerAlignment.end,
                              drawerCallback: (isOpened) {
                                rightDrawerOpen.value = isOpened;
                                print('Section 4 callback isOpened=$isOpened');
                              },
                              child: const Drawer(
                                child: SafeArea(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'End Drawer',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Slides from right with '
                                          'DrawerAlignment.end.',
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // SECTION 5 - WIDTH SWEEP
              // ================================================================
              const Text(
                '5. Drawer width sweep (200 / 280 / 360)',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Three side-by-side mini-apps, each with its own '
                'GlobalKey<DrawerControllerState>. The Drawer widths differ - '
                '200, 280, 360 logical pixels - but the state object is the '
                'same in all three cases.',
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 360.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _section5Tile(
                        bg: sec5Bg,
                        accent: sec5Accent,
                        label: 'width: 200',
                        widthValue: 200.0,
                        keyRef: width200Key,
                        openTracker: width200Open,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _section5Tile(
                        bg: sec5Bg,
                        accent: sec5Accent,
                        label: 'width: 280',
                        widthValue: 280.0,
                        keyRef: width280Key,
                        openTracker: width280Open,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _section5Tile(
                        bg: sec5Bg,
                        accent: sec5Accent,
                        label: 'width: 360',
                        widthValue: 360.0,
                        keyRef: width360Key,
                        openTracker: width360Open,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // SECTION 6 - DRAG START BEHAVIOR COMPARISON
              // ================================================================
              const Text(
                '6. DragStartBehavior comparison (start vs down)',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Two DrawerControllers. The left one uses '
                'DragStartBehavior.start (drag is recognised once it crosses '
                'the slop), the right one uses DragStartBehavior.down (drag '
                'is recognised on the initial pointer-down). The state '
                'object exposed by both keys is identical - drag dispatch is '
                'orthogonal to programmatic open/close.',
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  color: sec6Bg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: sec6Accent, width: 1.5),
                ),
                child: SizedBox(
                  height: 360.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            bottomLeft: Radius.circular(12.0),
                          ),
                          child: _dragBehaviorTile(
                            bg: sec6Bg,
                            accent: sec6Accent,
                            title: 'DragStartBehavior.start',
                            note: 'Drag recogniser fires after the slop '
                                'distance is exceeded.',
                            keyRef: dragStartKey,
                            behavior: DragStartBehavior.start,
                            openTracker: dragStartOpen,
                          ),
                        ),
                      ),
                      Container(width: 1.5, color: sec6Accent),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                          child: _dragBehaviorTile(
                            bg: sec6Bg,
                            accent: sec6Accent,
                            title: 'DragStartBehavior.down',
                            note: 'Drag recogniser fires immediately on '
                                'pointer-down.',
                            keyRef: dragDownKey,
                            behavior: DragStartBehavior.down,
                            openTracker: dragDownOpen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // SECTION 7 - LOCKED DRAWER (dismissible: false)
              // ================================================================
              const Text(
                '7. Locked drawer (drawerBarrierDismissible: false)',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Setting drawerBarrierDismissible: false means tapping the '
                'scrim does nothing. The only way to escape is calling '
                'lockedKey.currentState!.close(). This is the recipe for '
                'modal "do not let the user wander off" drawers.',
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  color: sec7Bg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: sec7Accent, width: 1.5),
                ),
                child: SizedBox(
                  height: 360.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Section7',
                      home: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          backgroundColor: sec7Accent,
                          foregroundColor: Colors.white,
                          title: const Text('Section 7 locked drawer'),
                          automaticallyImplyLeading: false,
                        ),
                        body: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Once open, scrim taps will be ignored. '
                                    'Use the Close button below.',
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: sec7Accent,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          print('Section 7 -> '
                                              'lockedKey.currentState.open()');
                                          lockedKey.currentState?.open();
                                        },
                                        child: const Text('Open (locked)'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          print('Section 7 -> '
                                              'lockedKey.currentState.close()');
                                          lockedKey.currentState?.close();
                                        },
                                        child: const Text(
                                            'Close (only escape)'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: sec7Bg,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: sec7Accent),
                                    ),
                                    child: const Text(
                                      'Use sparingly - users expect drawers '
                                      'to be dismissible. A locked drawer is '
                                      'a stronger signal than a dialog and '
                                      'should map to a real modal flow.',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DrawerController(
                              key: lockedKey,
                              alignment: DrawerAlignment.start,
                              drawerBarrierDismissible: false,
                              child: const Drawer(
                                child: SafeArea(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Locked Drawer',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'drawerBarrierDismissible: false. '
                                          'Only state.close() can close me.',
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // SECTION 8 - MULTI-DRAWER RECIPE
              // ================================================================
              const Text(
                '8. Multi-drawer recipe (leading + trailing)',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'A custom mini-app that owns two DrawerControllers - one '
                'leading, one trailing - each with its own '
                'GlobalKey<DrawerControllerState>. Four buttons drive both '
                'drawers independently.',
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  color: sec8Bg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: sec8Accent, width: 1.5),
                ),
                child: SizedBox(
                  height: 360.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Section8',
                      home: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          backgroundColor: sec8Accent,
                          foregroundColor: Colors.white,
                          title: const Text('Section 8 dual drawers'),
                          automaticallyImplyLeading: false,
                        ),
                        body: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Two drawers, two state keys, four '
                                    'buttons. Open both at once if you want.',
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: sec8Accent,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          print('Section 8 -> '
                                              'multiLeftKey.open()');
                                          multiLeftKey.currentState?.open();
                                        },
                                        child: const Text('Open Left'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          print('Section 8 -> '
                                              'multiLeftKey.close()');
                                          multiLeftKey.currentState?.close();
                                        },
                                        child: const Text('Close Left'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: sec8Accent,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          print('Section 8 -> '
                                              'multiRightKey.open()');
                                          multiRightKey.currentState?.open();
                                        },
                                        child: const Text('Open Right'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          print('Section 8 -> '
                                              'multiRightKey.close()');
                                          multiRightKey.currentState?.close();
                                        },
                                        child: const Text('Close Right'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: sec8Bg,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: sec8Accent),
                                    ),
                                    child: const Text(
                                      'Tip: opening both drawers stacks '
                                      'their scrims. Plan your z-order if '
                                      'you actually intend to support that '
                                      'state.',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DrawerController(
                              key: multiLeftKey,
                              alignment: DrawerAlignment.start,
                              child: const Drawer(
                                child: SafeArea(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Leading drawer',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text('Driven by multiLeftKey.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DrawerController(
                              key: multiRightKey,
                              alignment: DrawerAlignment.end,
                              child: const Drawer(
                                child: SafeArea(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Trailing drawer',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text('Driven by multiRightKey.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // SECTION 9 - REFERENCE CARD
              // ================================================================
              const Text(
                '9. DrawerControllerState reference card',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Public API exercised on this page.',
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: sec9Bg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: sec9Accent, width: 1.5),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'open() -> void',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Slides the drawer in. Animates from closed to open '
                      'using the controller\'s configured curve.',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'close() -> void',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Slides the drawer out. Safe to call when the drawer '
                      'is already closed; the call is a no-op in that case.',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'drawerCallback (DrawerController prop) -> '
                      'void Function(bool isOpened)',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Public DrawerControllerState exposes open() and '
                      'close() but no public isOpen getter; the canonical '
                      'way to know whether the drawer is open is to wire a '
                      'drawerCallback on the DrawerController and shadow '
                      'the bool externally (e.g. with a ValueNotifier). '
                      'That is what the Toggle buttons above use.',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Pattern reminder:',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '  final key = GlobalKey<DrawerControllerState>();',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '  DrawerController(key: key, child: Drawer(...))',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '  key.currentState?.open();',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '  key.currentState?.close();',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '  // shadow the open state externally:',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '  final openNotifier = ValueNotifier<bool>(false);',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '  DrawerController(',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '    key: key,',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '    drawerCallback: (o) => openNotifier.value = o,',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '    child: Drawer(...),',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '  );',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// HELPERS - section 5 width-sweep tile
// ---------------------------------------------------------------------------
// Each tile is its own MaterialApp + Scaffold so its DrawerController is
// hosted by an Overlay that does not collide with siblings.
// ===========================================================================
Widget _section5Tile({
  required Color bg,
  required Color accent,
  required String label,
  required double widthValue,
  required GlobalKey<DrawerControllerState> keyRef,
  required ValueNotifier<bool> openTracker,
}) {
  return Container(
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.5),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Section5-$label',
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: accent,
            foregroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(label, style: const TextStyle(fontSize: 14.0)),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drawer width: ${widthValue.toStringAsFixed(0)} px',
                      style: const TextStyle(fontSize: 12.0),
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          print('Section 5 [$label] -> open()');
                          keyRef.currentState?.open();
                        },
                        child: const Text('Open'),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          print('Section 5 [$label] -> close()');
                          keyRef.currentState?.close();
                        },
                        child: const Text('Close'),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          final st = keyRef.currentState;
                          final isOpen = openTracker.value;
                          print('Section 5 [$label] -> isOpen=$isOpen');
                          if (isOpen) {
                            st?.close();
                          } else {
                            st?.open();
                          }
                        },
                        child: const Text('Toggle'),
                      ),
                    ),
                  ],
                ),
              ),
              DrawerController(
                key: keyRef,
                alignment: DrawerAlignment.start,
                drawerCallback: (isOpened) {
                  openTracker.value = isOpened;
                  print('Section 5 [$label] callback isOpened=$isOpened');
                },
                child: Drawer(
                  width: widthValue,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Width $widthValue',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          const Text(
                            'Same DrawerControllerState API, different '
                            'visual width.',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// HELPERS - section 6 drag-behavior tile
// ---------------------------------------------------------------------------
// Hosts a DrawerController whose underlying drag recogniser uses a specific
// DragStartBehavior.
// ===========================================================================
Widget _dragBehaviorTile({
  required Color bg,
  required Color accent,
  required String title,
  required String note,
  required GlobalKey<DrawerControllerState> keyRef,
  required DragStartBehavior behavior,
  required ValueNotifier<bool> openTracker,
}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Section6-$title',
    home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(title, style: const TextStyle(fontSize: 13.0)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note,
                  style: const TextStyle(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        print('Section 6 [$title] -> open()');
                        keyRef.currentState?.open();
                      },
                      child: const Text('Open'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        print('Section 6 [$title] -> close()');
                        keyRef.currentState?.close();
                      },
                      child: const Text('Close'),
                    ),
                    TextButton(
                      onPressed: () {
                        final st = keyRef.currentState;
                        final isOpen = openTracker.value;
                        print('Section 6 [$title] -> isOpen=$isOpen');
                        if (isOpen) {
                          st?.close();
                        } else {
                          st?.open();
                        }
                      },
                      child: const Text('Toggle'),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: accent),
                  ),
                  child: Text(
                    'dragStartBehavior: $behavior',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          DrawerController(
            key: keyRef,
            alignment: DrawerAlignment.start,
            dragStartBehavior: behavior,
            drawerCallback: (isOpened) {
              openTracker.value = isOpened;
              print('Section 6 [$title] callback isOpened=$isOpened');
            },
            child: Drawer(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        note,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
