// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for CupertinoPage,
// CupertinoPageRoute and the Cupertino page/route transition family
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=============================================================');
  print('CupertinoPage deep visual demo executing');
  print('=============================================================');

  // ---------------------------------------------------------------------------
  // Section 1: CupertinoPage construction gallery.
  // ---------------------------------------------------------------------------
  print('--- Section 1: CupertinoPage construction gallery ---');

  final pageBasic = CupertinoPage<dynamic>(
    child: const Center(child: Text('basic page')),
  );
  print('  pageBasic.maintainState = ${pageBasic.maintainState}');
  print('  pageBasic.fullscreenDialog = ${pageBasic.fullscreenDialog}');
  print('  pageBasic.allowSnapshotting = ${pageBasic.allowSnapshotting}');
  print('  pageBasic.canPop = ${pageBasic.canPop}');

  final pageTitled = CupertinoPage<dynamic>(
    title: 'Settings',
    child: const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Settings')),
      child: Center(child: Text('Settings body')),
    ),
  );
  print('  pageTitled.title = ${pageTitled.title}');

  final pageFullscreenDialog = CupertinoPage<dynamic>(
    title: 'New Item',
    fullscreenDialog: true,
    child: const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('New Item')),
      child: Center(child: Text('Fullscreen dialog body')),
    ),
  );
  print('  pageFullscreenDialog.fullscreenDialog = '
      '${pageFullscreenDialog.fullscreenDialog}');

  final pageNonPoppable = CupertinoPage<dynamic>(
    title: 'Required',
    canPop: false,
    child: const Center(child: Text('cannot pop')),
  );
  print('  pageNonPoppable.canPop = ${pageNonPoppable.canPop}');

  final pageNoMaintain = CupertinoPage<dynamic>(
    title: 'Volatile',
    maintainState: false,
    child: const Center(child: Text('state discarded when off-stack')),
  );
  print('  pageNoMaintain.maintainState = ${pageNoMaintain.maintainState}');

  final pageNoSnapshot = CupertinoPage<dynamic>(
    title: 'Live',
    allowSnapshotting: false,
    child: const Center(child: Text('snapshot suppressed during transition')),
  );
  print('  pageNoSnapshot.allowSnapshotting = ${pageNoSnapshot.allowSnapshotting}');

  final pageWithKey = CupertinoPage<dynamic>(
    key: const ValueKey<String>('keyed-cupertino-page'),
    title: 'Keyed',
    child: const Center(child: Text('has a ValueKey')),
  );
  print('  pageWithKey.key = ${pageWithKey.key}');

  final pageWithRestorationId = CupertinoPage<dynamic>(
    title: 'Restorable',
    restorationId: 'cupertino-page-restoration',
    child: const Center(child: Text('survives process restart')),
  );
  print('  pageWithRestorationId.restorationId = ${pageWithRestorationId.restorationId}');

  final pageWithName = CupertinoPage<dynamic>(
    title: 'Named',
    name: '/cupertino/named',
    child: const Center(child: Text('exposes a route name')),
  );
  print('  pageWithName.name = ${pageWithName.name}');

  final pageWithArguments = CupertinoPage<dynamic>(
    title: 'With Args',
    arguments: <String, Object?>{'q': 42, 'tag': 'cupertino'},
    child: const Center(child: Text('argument bundle attached')),
  );
  print('  pageWithArguments.arguments = ${pageWithArguments.arguments}');

  final pageFullyConfigured = CupertinoPage<dynamic>(
    title: 'Fully Configured',
    name: '/cupertino/full',
    maintainState: true,
    fullscreenDialog: false,
    allowSnapshotting: true,
    canPop: true,
    restorationId: 'cupertino-page-full',
    arguments: const <String, Object?>{'demo': 'full'},
    child: const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Fully Configured')),
      child: Center(child: Text('all knobs set')),
    ),
  );
  print('  pageFullyConfigured.name = ${pageFullyConfigured.name}');
  print('  pageFullyConfigured.title = ${pageFullyConfigured.title}');
  print('  pageFullyConfigured.fullscreenDialog = ${pageFullyConfigured.fullscreenDialog}');

  // ---------------------------------------------------------------------------
  // Section 2: CupertinoPageRoute parameter showcase.
  // ---------------------------------------------------------------------------
  print('--- Section 2: CupertinoPageRoute parameter showcase ---');

  final routeBasic = CupertinoPageRoute<dynamic>(
    builder: (BuildContext _) => const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Basic route')),
      child: Center(child: Text('basic body')),
    ),
  );
  print('  routeBasic.maintainState = ${routeBasic.maintainState}');
  print('  routeBasic.fullscreenDialog = ${routeBasic.fullscreenDialog}');
  print('  routeBasic.title = ${routeBasic.title}');
  print('  routeBasic.allowSnapshotting = ${routeBasic.allowSnapshotting}');
  print('  routeBasic.opaque = ${routeBasic.opaque}');
  print('  routeBasic.barrierDismissible = ${routeBasic.barrierDismissible}');
  print('  routeBasic.barrierColor = ${routeBasic.barrierColor}');
  print('  routeBasic.barrierLabel = ${routeBasic.barrierLabel}');
  print('  routeBasic.popGestureEnabled = ${routeBasic.popGestureEnabled}');
  print('  routeBasic.transitionDuration = ${routeBasic.transitionDuration}');
  print('  routeBasic.reverseTransitionDuration = ${routeBasic.reverseTransitionDuration}');

  final routeTitled = CupertinoPageRoute<dynamic>(
    title: 'Detail',
    builder: (BuildContext _) => const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detail'),
        previousPageTitle: 'Back',
      ),
      child: Center(child: Text('detail body')),
    ),
  );
  print('  routeTitled.title = ${routeTitled.title}');

  final routeFullscreen = CupertinoPageRoute<dynamic>(
    fullscreenDialog: true,
    title: 'Compose',
    builder: (BuildContext _) => const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Compose')),
      child: Center(child: Text('compose body')),
    ),
  );
  print('  routeFullscreen.fullscreenDialog = ${routeFullscreen.fullscreenDialog}');

  final routeUnmaintained = CupertinoPageRoute<dynamic>(
    maintainState: false,
    builder: (BuildContext _) => const Center(child: Text('volatile route')),
  );
  print('  routeUnmaintained.maintainState = ${routeUnmaintained.maintainState}');

  final routeNoSnapshot = CupertinoPageRoute<dynamic>(
    allowSnapshotting: false,
    builder: (BuildContext _) => const Center(child: Text('snapshotless route')),
  );
  print('  routeNoSnapshot.allowSnapshotting = ${routeNoSnapshot.allowSnapshotting}');

  final routeRestorable = CupertinoPageRoute<dynamic>(
    title: 'Restorable',
    builder: (BuildContext _) => const Center(child: Text('restorable route')),
  );
  print('  routeRestorable.runtimeType = ${routeRestorable.runtimeType}');

  // CupertinoPage.createRoute returns a CupertinoPageRoute-flavored adapter.
  final adapterRoute = pageFullyConfigured.createRoute(context);
  print('  adapterRoute.runtimeType = ${adapterRoute.runtimeType}');

  final routeFromPlainPage = pageBasic.createRoute(context);
  print('  routeFromPlainPage.runtimeType = ${routeFromPlainPage.runtimeType}');

  // ---------------------------------------------------------------------------
  // Section 3: Transition snapshot grid at five values of t.
  // ---------------------------------------------------------------------------
  print('--- Section 3: transition snapshot grid ---');

  final tStops = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final pageTransitionSnapshots = <Widget>[];
  for (var i = 0; i < tStops.length; i++) {
    final double t = tStops[i];
    final Animation<double> primary = AlwaysStoppedAnimation<double>(t);
    final Animation<double> secondary =
        const AlwaysStoppedAnimation<double>(0.0);
    final Widget transition = CupertinoPageTransition(
      primaryRouteAnimation: primary,
      secondaryRouteAnimation: secondary,
      linearTransition: false,
      child: _transitionCard('CupertinoPageTransition', t,
          accent: const Color(0xFF0A84FF)),
    );
    pageTransitionSnapshots.add(_clipTransitionSnapshot(transition, t));
    print('  CupertinoPageTransition snapshot @ t=$t built');
  }

  final fullscreenTransitionSnapshots = <Widget>[];
  for (var i = 0; i < tStops.length; i++) {
    final double t = tStops[i];
    final Animation<double> primary = AlwaysStoppedAnimation<double>(t);
    final Animation<double> secondary =
        const AlwaysStoppedAnimation<double>(0.0);
    final Widget transition = CupertinoFullscreenDialogTransition(
      primaryRouteAnimation: primary,
      secondaryRouteAnimation: secondary,
      linearTransition: false,
      child: _transitionCard('CupertinoFullscreenDialogTransition', t,
          accent: const Color(0xFF34C759)),
    );
    fullscreenTransitionSnapshots.add(_clipTransitionSnapshot(transition, t));
    print('  CupertinoFullscreenDialogTransition snapshot @ t=$t built');
  }

  // Linear variant for comparison.
  final linearTransitionSnapshots = <Widget>[];
  for (var i = 0; i < tStops.length; i++) {
    final double t = tStops[i];
    final Animation<double> primary = AlwaysStoppedAnimation<double>(t);
    final Animation<double> secondary =
        const AlwaysStoppedAnimation<double>(0.0);
    final Widget transition = CupertinoPageTransition(
      primaryRouteAnimation: primary,
      secondaryRouteAnimation: secondary,
      linearTransition: true,
      child: _transitionCard('linearTransition: true', t,
          accent: const Color(0xFFFF9F0A)),
    );
    linearTransitionSnapshots.add(_clipTransitionSnapshot(transition, t));
    print('  Linear CupertinoPageTransition snapshot @ t=$t built');
  }

  // Manual easing reference values derived without Tween.animate().
  final manualEasing = <Map<String, double>>[];
  for (var i = 0; i < tStops.length; i++) {
    final double t = tStops[i];
    final double offsetX =
        Tween<double>(begin: 1.0, end: 0.0).transform(Curves.linearToEaseOut.transform(t));
    final double parallax =
        Tween<double>(begin: 0.0, end: -0.3).transform(Curves.linearToEaseOut.transform(t));
    manualEasing.add(<String, double>{
      't': t,
      'offsetX': offsetX,
      'parallax': parallax,
    });
    print('  manual easing t=$t offsetX=$offsetX parallax=$parallax');
  }

  // ---------------------------------------------------------------------------
  // Section 4: Page-vs-Route conceptual diagram.
  // ---------------------------------------------------------------------------
  print('--- Section 4: Page-vs-Route conceptual diagram ---');

  final List<_Concept> concepts = <_Concept>[
    _Concept(
      label: 'Page<T>',
      family: 'declarative',
      tagline: 'Persistent description of a screen in a Navigator 2.0 stack.',
      bullets: <String>[
        'Subclass of RouteSettings; an immutable description.',
        'Provided to Navigator(pages: [...]) and rebuilt every frame.',
        'Pages are diffed by key; equal keys keep the same route.',
        'createRoute() turns a Page into the actual Route<T>.',
      ],
      accent: const Color(0xFF8E8E93),
    ),
    _Concept(
      label: 'MaterialPage<T>',
      family: 'declarative',
      tagline: 'Material-themed Page that builds a MaterialPageRoute.',
      bullets: <String>[
        'Used with Material design transitions (fade/slide up).',
        'Has maintainState, fullscreenDialog, allowSnapshotting.',
        'createRoute() returns a _PageBasedMaterialPageRoute.',
      ],
      accent: const Color(0xFF5856D6),
    ),
    _Concept(
      label: 'CupertinoPage<T>',
      family: 'declarative',
      tagline: 'Cupertino-themed Page that builds a CupertinoPageRoute.',
      bullets: <String>[
        'Used with the iOS-style slide-from-right transition.',
        'Same knobs as MaterialPage plus title.',
        'createRoute() returns a _PageBasedCupertinoPageRoute.',
      ],
      accent: const Color(0xFF0A84FF),
    ),
    _Concept(
      label: 'CupertinoPageRoute<T>',
      family: 'imperative',
      tagline: 'Imperatively-pushed Route with Cupertino transition logic.',
      bullets: <String>[
        'Subclass of PageRoute<T> with CupertinoRouteTransitionMixin.',
        'Built via builder: (context) => Widget.',
        'Supports fullscreenDialog → swaps in fullscreen transition.',
        'Hosts the interactive back-swipe gesture.',
      ],
      accent: const Color(0xFFFF375F),
    ),
    _Concept(
      label: 'CupertinoRouteTransitionMixin<T>',
      family: 'mixin',
      tagline: 'Mixin that supplies buildPage + buildTransitions for iOS look.',
      bullets: <String>[
        'Implements transitionDuration ≈ 500ms.',
        'Decides between page slide and fullscreen rise.',
        'Wires up the popGestureEnabled / startPopGesture machinery.',
      ],
      accent: const Color(0xFF30B0C7),
    ),
    _Concept(
      label: 'CupertinoPageScaffold',
      family: 'layout',
      tagline: 'Top-level Cupertino screen scaffold (nav bar + body).',
      bullets: <String>[
        'Optional CupertinoNavigationBar at the top.',
        'Body painted under it via ObstructingPreferredSizeWidget.',
        'Provides backgroundColor and resizeToAvoidBottomInset.',
      ],
      accent: const Color(0xFFFF9F0A)),
  ];
  for (var i = 0; i < concepts.length; i++) {
    print('  concept ${concepts[i].label} (${concepts[i].family}): '
        '${concepts[i].tagline}');
  }

  // ---------------------------------------------------------------------------
  // Section 5: Mock navigation stack render.
  // ---------------------------------------------------------------------------
  print('--- Section 5: mock navigation stack render ---');

  final List<_StackFrame> stackFrames = <_StackFrame>[
    _StackFrame(
      depth: 0,
      label: 'Home',
      title: 'Cupertino Photos',
      kind: _StackKind.root,
      details: 'Root CupertinoPage — never popped, supplies the back chevron target.',
    ),
    _StackFrame(
      depth: 1,
      label: 'Album',
      title: 'Vacation 2024',
      kind: _StackKind.cupertinoPage,
      details: 'CupertinoPage pushed declaratively; maintainState=true.',
    ),
    _StackFrame(
      depth: 2,
      label: 'Photo',
      title: 'IMG_0421.HEIC',
      kind: _StackKind.cupertinoPage,
      details: 'CupertinoPage with restorationId for deep links.',
    ),
    _StackFrame(
      depth: 3,
      label: 'Share',
      title: 'Share Sheet',
      kind: _StackKind.fullscreenDialog,
      details: 'fullscreenDialog: true — rises from the bottom.',
    ),
    _StackFrame(
      depth: 4,
      label: 'Compose',
      title: 'Compose Message',
      kind: _StackKind.materialPage,
      details: 'MaterialPage interleaved — uses fade-up transition.',
    ),
  ];
  for (var i = 0; i < stackFrames.length; i++) {
    print('  frame depth=${stackFrames[i].depth} '
        'label=${stackFrames[i].label} kind=${stackFrames[i].kind}');
  }

  // ---------------------------------------------------------------------------
  // Section 6: Anatomy reference (labelled diagram).
  // ---------------------------------------------------------------------------
  print('--- Section 6: anatomy reference ---');

  final List<_AnatomyPart> anatomy = <_AnatomyPart>[
    _AnatomyPart(
      letter: 'A',
      name: 'CupertinoNavigationBar',
      blurb: 'Top bar; leading chevron + middle title + trailing actions.',
      color: const Color(0xFFE5E5EA),
    ),
    _AnatomyPart(
      letter: 'B',
      name: 'Body region',
      blurb: 'Child widget — usually a Cupertino-themed ScrollView.',
      color: const Color(0xFFF2F2F7),
    ),
    _AnatomyPart(
      letter: 'C',
      name: 'Bottom inset',
      blurb: 'Reserved by resizeToAvoidBottomInset when the keyboard rises.',
      color: const Color(0xFFD1D1D6),
    ),
    _AnatomyPart(
      letter: 'D',
      name: 'Pop gesture zone',
      blurb: 'Left ~20px slice; only active when popGestureEnabled is true.',
      color: const Color(0xFFAEAEB2),
    ),
    _AnatomyPart(
      letter: 'E',
      name: 'Parallax layer',
      blurb: 'Previous route slides left ~30% — visible during the swipe.',
      color: const Color(0xFF8E8E93),
    ),
  ];
  for (var i = 0; i < anatomy.length; i++) {
    print('  anatomy ${anatomy[i].letter}: ${anatomy[i].name}');
  }

  // ---------------------------------------------------------------------------
  // Section 7: Page vs Route comparison matrix (data table).
  // ---------------------------------------------------------------------------
  print('--- Section 7: comparison matrix ---');

  final List<List<String>> comparisonRows = <List<String>>[
    <String>['property', 'CupertinoPage<T>', 'CupertinoPageRoute<T>'],
    <String>['type', 'Page<T> (RouteSettings)', 'PageRoute<T>'],
    <String>['paradigm', 'declarative (pages list)', 'imperative (push)'],
    <String>['child source', 'child: Widget', 'builder: (ctx) => Widget'],
    <String>['title', 'String? title', 'String? title'],
    <String>['fullscreenDialog', 'bool', 'bool'],
    <String>['maintainState', 'bool', 'bool'],
    <String>['allowSnapshotting', 'bool', 'bool'],
    <String>['canPop', 'bool', 'managed via Navigator'],
    <String>['restorationId', 'String?', 'restorationScopeId via state'],
    <String>['arguments', 'Object? arguments', 'inherited via RouteSettings'],
    <String>['equality', 'compared by key in pages diff', 'identity in stack'],
    <String>['typical usage', 'Navigator(pages: [...])', 'Navigator.push(context, ...)'],
  ];
  for (var i = 0; i < comparisonRows.length; i++) {
    final List<String> row = comparisonRows[i];
    print('  | ${row[0].padRight(18)} | ${row[1].padRight(28)} | ${row[2]} |');
  }

  // ---------------------------------------------------------------------------
  // Section 8: Material comparison Page corpus.
  // ---------------------------------------------------------------------------
  print('--- Section 8: MaterialPage corpus for comparison ---');

  final materialPageBasic = MaterialPage<dynamic>(
    child: const Center(child: Text('Material body')),
  );
  print('  materialPageBasic.maintainState = ${materialPageBasic.maintainState}');

  final materialPageFullscreen = MaterialPage<dynamic>(
    fullscreenDialog: true,
    child: const Center(child: Text('Material fullscreen body')),
  );
  print('  materialPageFullscreen.fullscreenDialog = '
      '${materialPageFullscreen.fullscreenDialog}');

  final materialPageNamed = MaterialPage<dynamic>(
    name: '/material/named',
    child: const Center(child: Text('Material named body')),
  );
  print('  materialPageNamed.name = ${materialPageNamed.name}');

  // ---------------------------------------------------------------------------
  // Section 9: Assemble the final visual tree.
  // ---------------------------------------------------------------------------
  print('--- Section 9: assembling final widget tree ---');

  final Widget intro = _section(
    title: '1. CupertinoPage construction gallery',
    subtitle:
        'Each card shows one CupertinoPage with a different combination of flags.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _pageInspectorCard('basic',
            attrs: <String, String>{
              'child': pageBasic.child.runtimeType.toString(),
              'maintainState': '${pageBasic.maintainState}',
              'fullscreenDialog': '${pageBasic.fullscreenDialog}',
              'allowSnapshotting': '${pageBasic.allowSnapshotting}',
              'canPop': '${pageBasic.canPop}',
            },
            accent: const Color(0xFF0A84FF)),
        const SizedBox(height: 8),
        _pageInspectorCard('titled',
            attrs: <String, String>{
              'title': '${pageTitled.title}',
              'child': pageTitled.child.runtimeType.toString(),
            },
            accent: const Color(0xFF5856D6)),
        const SizedBox(height: 8),
        _pageInspectorCard('fullscreenDialog',
            attrs: <String, String>{
              'title': '${pageFullscreenDialog.title}',
              'fullscreenDialog': '${pageFullscreenDialog.fullscreenDialog}',
            },
            accent: const Color(0xFFFF375F)),
        const SizedBox(height: 8),
        _pageInspectorCard('canPop: false',
            attrs: <String, String>{
              'canPop': '${pageNonPoppable.canPop}',
              'note': 'rejects programmatic + gesture pops',
            },
            accent: const Color(0xFFFF9F0A)),
        const SizedBox(height: 8),
        _pageInspectorCard('maintainState: false',
            attrs: <String, String>{
              'maintainState': '${pageNoMaintain.maintainState}',
              'note': 'state dropped while off-stack',
            },
            accent: const Color(0xFF34C759)),
        const SizedBox(height: 8),
        _pageInspectorCard('allowSnapshotting: false',
            attrs: <String, String>{
              'allowSnapshotting': '${pageNoSnapshot.allowSnapshotting}',
              'note': 'no raster cache during transition',
            },
            accent: const Color(0xFF30B0C7)),
        const SizedBox(height: 8),
        _pageInspectorCard('with key',
            attrs: <String, String>{
              'key': '${pageWithKey.key}',
              'note': 'identity stable across pages-list rebuilds',
            },
            accent: const Color(0xFFAF52DE)),
        const SizedBox(height: 8),
        _pageInspectorCard('with restorationId',
            attrs: <String, String>{
              'restorationId': '${pageWithRestorationId.restorationId}',
            },
            accent: const Color(0xFFFF2D55)),
        const SizedBox(height: 8),
        _pageInspectorCard('with name',
            attrs: <String, String>{
              'name': '${pageWithName.name}',
            },
            accent: const Color(0xFFBF5AF2)),
        const SizedBox(height: 8),
        _pageInspectorCard('with arguments',
            attrs: <String, String>{
              'arguments': '${pageWithArguments.arguments}',
            },
            accent: const Color(0xFF64D2FF)),
        const SizedBox(height: 8),
        _pageInspectorCard('fully configured',
            attrs: <String, String>{
              'title': '${pageFullyConfigured.title}',
              'name': '${pageFullyConfigured.name}',
              'maintainState': '${pageFullyConfigured.maintainState}',
              'fullscreenDialog': '${pageFullyConfigured.fullscreenDialog}',
              'allowSnapshotting': '${pageFullyConfigured.allowSnapshotting}',
              'canPop': '${pageFullyConfigured.canPop}',
              'restorationId': '${pageFullyConfigured.restorationId}',
            },
            accent: const Color(0xFF0A84FF)),
      ],
    ),
  );

  final Widget routesSection = _section(
    title: '2. CupertinoPageRoute parameter showcase',
    subtitle:
        'Imperative routes. Same knobs as the pages above but built via builder.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _routeInspectorCard('routeBasic',
            attrs: <String, String>{
              'maintainState': '${routeBasic.maintainState}',
              'fullscreenDialog': '${routeBasic.fullscreenDialog}',
              'allowSnapshotting': '${routeBasic.allowSnapshotting}',
              'opaque': '${routeBasic.opaque}',
              'barrierDismissible': '${routeBasic.barrierDismissible}',
              'transitionDuration': '${routeBasic.transitionDuration}',
              'reverseTransitionDuration':
                  '${routeBasic.reverseTransitionDuration}',
            },
            accent: const Color(0xFF0A84FF)),
        const SizedBox(height: 8),
        _routeInspectorCard('routeTitled',
            attrs: <String, String>{
              'title': '${routeTitled.title}',
            },
            accent: const Color(0xFF5856D6)),
        const SizedBox(height: 8),
        _routeInspectorCard('routeFullscreen',
            attrs: <String, String>{
              'title': '${routeFullscreen.title}',
              'fullscreenDialog': '${routeFullscreen.fullscreenDialog}',
            },
            accent: const Color(0xFFFF375F)),
        const SizedBox(height: 8),
        _routeInspectorCard('routeUnmaintained',
            attrs: <String, String>{
              'maintainState': '${routeUnmaintained.maintainState}',
            },
            accent: const Color(0xFFFF9F0A)),
        const SizedBox(height: 8),
        _routeInspectorCard('routeNoSnapshot',
            attrs: <String, String>{
              'allowSnapshotting': '${routeNoSnapshot.allowSnapshotting}',
            },
            accent: const Color(0xFF34C759)),
        const SizedBox(height: 8),
        _routeInspectorCard('routeRestorable',
            attrs: <String, String>{
              'runtimeType': '${routeRestorable.runtimeType}',
            },
            accent: const Color(0xFF30B0C7)),
        const SizedBox(height: 8),
        _routeInspectorCard('adapterRoute',
            attrs: <String, String>{
              'note': 'createRoute(context) from pageFullyConfigured',
              'runtimeType': '${adapterRoute.runtimeType}',
            },
            accent: const Color(0xFFAF52DE)),
        const SizedBox(height: 8),
        _routeInspectorCard('routeFromPlainPage',
            attrs: <String, String>{
              'note': 'createRoute(context) from pageBasic',
              'runtimeType': '${routeFromPlainPage.runtimeType}',
            },
            accent: const Color(0xFFBF5AF2)),
      ],
    ),
  );

  final Widget transitionsSection = _section(
    title: '3. Transition snapshot grid',
    subtitle:
        'CupertinoPageTransition vs CupertinoFullscreenDialogTransition at t=0/0.25/0.5/0.75/1.0.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _transitionRowLabel('CupertinoPageTransition (curved)'),
        _transitionRow(pageTransitionSnapshots, tStops),
        const SizedBox(height: 12),
        _transitionRowLabel('CupertinoFullscreenDialogTransition'),
        _transitionRow(fullscreenTransitionSnapshots, tStops),
        const SizedBox(height: 12),
        _transitionRowLabel('CupertinoPageTransition (linearTransition: true)'),
        _transitionRow(linearTransitionSnapshots, tStops),
        const SizedBox(height: 12),
        _manualEasingTable(manualEasing),
      ],
    ),
  );

  final Widget conceptDiagram = _section(
    title: '4. Page-vs-Route conceptual diagram',
    subtitle:
        'Two columns: declarative (Page<T>) on the left, imperative (Route<T>) on the right.',
    child: _conceptDiagram(concepts),
  );

  final Widget stackDiagram = _section(
    title: '5. Mock Navigator stack',
    subtitle:
        'Visualises a stack of CupertinoPage / MaterialPage frames with arrows.',
    child: _stackDiagram(stackFrames),
  );

  final Widget anatomyDiagram = _section(
    title: '6. CupertinoPageScaffold anatomy',
    subtitle: 'Labelled diagram of the regions inside one scaffold.',
    child: _anatomyDiagram(anatomy),
  );

  final Widget comparisonMatrix = _section(
    title: '7. CupertinoPage vs CupertinoPageRoute',
    subtitle: 'Side-by-side comparison.',
    child: _comparisonMatrix(comparisonRows),
  );

  final Widget materialCompare = _section(
    title: '8. MaterialPage<T> for comparison',
    subtitle: 'Sibling Page type with Material transitions.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _pageInspectorCard('MaterialPage basic',
            attrs: <String, String>{
              'maintainState': '${materialPageBasic.maintainState}',
              'fullscreenDialog': '${materialPageBasic.fullscreenDialog}',
            },
            accent: const Color(0xFF34C759)),
        const SizedBox(height: 8),
        _pageInspectorCard('MaterialPage fullscreenDialog',
            attrs: <String, String>{
              'fullscreenDialog': '${materialPageFullscreen.fullscreenDialog}',
            },
            accent: const Color(0xFFFF9F0A)),
        const SizedBox(height: 8),
        _pageInspectorCard('MaterialPage named',
            attrs: <String, String>{
              'name': '${materialPageNamed.name}',
            },
            accent: const Color(0xFF5856D6)),
      ],
    ),
  );

  final Widget header = Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0A84FF), Color(0xFF30B0C7)],
      ),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CupertinoPage / CupertinoPageRoute',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF)),
        ),
        SizedBox(height: 4),
        Text(
          'Deep visual demo — page declarations, route construction, '
          'transition snapshots and the Navigator 2.0 stack model.',
          style: TextStyle(fontSize: 13, color: Color(0xFFFFFFFF)),
        ),
      ],
    ),
  );

  final Widget footer = Container(
    padding: const EdgeInsets.all(12),
    color: const Color(0xFFE5E5EA),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Notes',
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(
          'This demo is a static snapshot. Navigator.push / pop are described '
          'in text only; no runtime animation is driven.',
          style: TextStyle(fontSize: 11),
        ),
        SizedBox(height: 4),
        Text(
          'Transitions use AlwaysStoppedAnimation<double>(t) so the script '
          'stays analyzer- and Ticker-free.',
          style: TextStyle(fontSize: 11),
        ),
      ],
    ),
  );

  print('=============================================================');
  print('CupertinoPage deep visual demo finished assembling widget tree');
  print('=============================================================');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoPage Deep Demo'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              header,
              const SizedBox(height: 16),
              intro,
              const SizedBox(height: 16),
              routesSection,
              const SizedBox(height: 16),
              transitionsSection,
              const SizedBox(height: 16),
              conceptDiagram,
              const SizedBox(height: 16),
              stackDiagram,
              const SizedBox(height: 16),
              anatomyDiagram,
              const SizedBox(height: 16),
              comparisonMatrix,
              const SizedBox(height: 16),
              materialCompare,
              const SizedBox(height: 16),
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Helpers — pure functions returning widgets. No state, no async.
// =============================================================================

Widget _section({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD1D1D6), width: 1),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1C1E)),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Color(0xFF636366)),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget _pageInspectorCard(
  String label, {
  required Map<String, String> attrs,
  required Color accent,
}) {
  final List<Widget> rows = <Widget>[];
  final List<String> keys = attrs.keys.toList();
  for (var i = 0; i < keys.length; i++) {
    final String key = keys[i];
    final String value = attrs[key] ?? '';
    rows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              key,
              style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF636366),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 11, color: Color(0xFF1C1C1E)),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: accent, width: 4)),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: accent),
        ),
        const SizedBox(height: 6),
        ...rows,
      ],
    ),
  );
}

Widget _routeInspectorCard(
  String label, {
  required Map<String, String> attrs,
  required Color accent,
}) {
  return _pageInspectorCard(label, attrs: attrs, accent: accent);
}

Widget _transitionRowLabel(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1C1C1E)),
    ),
  );
}

Widget _transitionRow(List<Widget> snapshots, List<double> tStops) {
  final List<Widget> cells = <Widget>[];
  for (var i = 0; i < snapshots.length; i++) {
    cells.add(Expanded(
      child: Column(
        children: <Widget>[
          Text(
            't = ${tStops[i].toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 10, color: Color(0xFF636366)),
          ),
          const SizedBox(height: 2),
          snapshots[i],
        ],
      ),
    ));
    if (i < snapshots.length - 1) {
      cells.add(const SizedBox(width: 4));
    }
  }
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: cells);
}

Widget _clipTransitionSnapshot(Widget transition, double t) {
  return ClipRect(
    child: SizedBox(
      width: 60,
      height: 90,
      child: Container(
        color: const Color(0xFFEFEFF4),
        child: transition,
      ),
    ),
  );
}

Widget _transitionCard(String name, double t, {required Color accent}) {
  return Container(
    decoration: BoxDecoration(
      color: accent.withAlpha(60),
      border: Border.all(color: accent, width: 1),
    ),
    padding: const EdgeInsets.all(4),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          't=${t.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: accent),
        ),
        const SizedBox(height: 2),
        Text(
          name,
          style: const TextStyle(fontSize: 7, color: Color(0xFF1C1C1E)),
        ),
      ],
    ),
  );
}

Widget _manualEasingTable(List<Map<String, double>> rows) {
  final List<Widget> children = <Widget>[
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Text(
        'Manual easing values (Tween.transform(t), no animate())',
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C1C1E)),
      ),
    ),
    Container(
      color: const Color(0xFFE5E5EA),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: const Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            child: Text('t',
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 110,
            child: Text('offsetX (1→0)',
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 110,
            child: Text('parallax (0→-0.3)',
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ),
  ];
  for (var i = 0; i < rows.length; i++) {
    final Map<String, double> row = rows[i];
    final double t = row['t'] ?? 0.0;
    final double offsetX = row['offsetX'] ?? 0.0;
    final double parallax = row['parallax'] ?? 0.0;
    final bool even = i.isEven;
    children.add(Container(
      color: even ? const Color(0xFFF2F2F7) : const Color(0xFFFFFFFF),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            child: Text(t.toStringAsFixed(2),
                style: const TextStyle(fontSize: 11)),
          ),
          SizedBox(
            width: 110,
            child: Text(offsetX.toStringAsFixed(4),
                style: const TextStyle(fontSize: 11)),
          ),
          SizedBox(
            width: 110,
            child: Text(parallax.toStringAsFixed(4),
                style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    ));
  }
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: children);
}

Widget _conceptDiagram(List<_Concept> concepts) {
  final List<_Concept> declarative = <_Concept>[];
  final List<_Concept> imperative = <_Concept>[];
  final List<_Concept> mixin = <_Concept>[];
  final List<_Concept> layout = <_Concept>[];
  for (var i = 0; i < concepts.length; i++) {
    final _Concept c = concepts[i];
    if (c.family == 'declarative') {
      declarative.add(c);
    } else if (c.family == 'imperative') {
      imperative.add(c);
    } else if (c.family == 'mixin') {
      mixin.add(c);
    } else {
      layout.add(c);
    }
  }

  Widget column(String title, List<_Concept> items, Color titleColor) {
    final List<Widget> kids = <Widget>[
      Text(title,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: titleColor)),
      const SizedBox(height: 6),
    ];
    for (var i = 0; i < items.length; i++) {
      kids.add(_conceptCard(items[i]));
      if (i < items.length - 1) {
        kids.add(const SizedBox(height: 8));
      }
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: kids,
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          column('Declarative (Page<T>)', declarative, const Color(0xFF0A84FF)),
          const SizedBox(width: 8),
          column('Imperative (Route<T>)', imperative, const Color(0xFFFF375F)),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          column('Mixins', mixin, const Color(0xFF30B0C7)),
          const SizedBox(width: 8),
          column('Layout', layout, const Color(0xFFFF9F0A)),
        ],
      ),
    ],
  );
}

Widget _conceptCard(_Concept c) {
  final List<Widget> bullets = <Widget>[];
  for (var i = 0; i < c.bullets.length; i++) {
    bullets.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(CupertinoIcons.circle_fill,
                size: 6, color: Color(0xFF636366)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              c.bullets[i],
              style: const TextStyle(
                  fontSize: 11, color: Color(0xFF1C1C1E)),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(color: c.accent, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          c.label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: c.accent),
        ),
        const SizedBox(height: 2),
        Text(
          c.tagline,
          style: const TextStyle(
              fontSize: 10,
              fontStyle: FontStyle.italic,
              color: Color(0xFF636366)),
        ),
        const SizedBox(height: 6),
        ...bullets,
      ],
    ),
  );
}

Widget _stackDiagram(List<_StackFrame> frames) {
  final List<Widget> children = <Widget>[];
  for (var i = 0; i < frames.length; i++) {
    final _StackFrame frame = frames[i];
    final Color color = _stackKindColor(frame.kind);
    final double leftPad = 8.0 + (frame.depth.toDouble() * 18.0);
    children.add(Padding(
      padding: EdgeInsets.only(left: leftPad, right: 8, top: 4, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(40),
          border: Border.all(color: color, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${frame.depth}',
                style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${frame.label} — ${frame.title}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C1C1E)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_stackKindLabel(frame.kind)}: ${frame.details}',
                    style: const TextStyle(
                        fontSize: 10, color: Color(0xFF636366)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
    if (i < frames.length - 1) {
      children.add(Padding(
        padding: EdgeInsets.only(left: leftPad + 4),
        child: const Icon(CupertinoIcons.down_arrow,
            size: 14, color: Color(0xFF636366)),
      ));
    }
  }
  return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
}

Color _stackKindColor(_StackKind kind) {
  switch (kind) {
    case _StackKind.root:
      return const Color(0xFF8E8E93);
    case _StackKind.cupertinoPage:
      return const Color(0xFF0A84FF);
    case _StackKind.fullscreenDialog:
      return const Color(0xFFFF375F);
    case _StackKind.materialPage:
      return const Color(0xFF34C759);
  }
}

String _stackKindLabel(_StackKind kind) {
  switch (kind) {
    case _StackKind.root:
      return 'root';
    case _StackKind.cupertinoPage:
      return 'CupertinoPage';
    case _StackKind.fullscreenDialog:
      return 'CupertinoPage(fullscreenDialog: true)';
    case _StackKind.materialPage:
      return 'MaterialPage';
  }
}

Widget _anatomyDiagram(List<_AnatomyPart> parts) {
  // A stylised cross-section of a CupertinoPageScaffold.
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(color: const Color(0xFFC7C7CC), width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _anatomyBox('A', const Color(0xFFE5E5EA), height: 32),
              const SizedBox(height: 2),
              Expanded(child: _anatomyBox('B', const Color(0xFFF2F2F7))),
              const SizedBox(height: 2),
              _anatomyBox('C', const Color(0xFFD1D1D6), height: 24),
              const SizedBox(height: 2),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: _anatomyBox('D', const Color(0xFFAEAEB2),
                          height: 26)),
                  const SizedBox(width: 2),
                  Expanded(
                      flex: 6,
                      child: _anatomyBox('E', const Color(0xFF8E8E93),
                          height: 26)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _anatomyLegend(parts),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyBox(String letter, Color color, {double? height}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: const Color(0xFF8E8E93), width: 0.5),
    ),
    alignment: Alignment.center,
    child: Text(
      letter,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1C1C1E)),
    ),
  );
}

List<Widget> _anatomyLegend(List<_AnatomyPart> parts) {
  final List<Widget> out = <Widget>[];
  for (var i = 0; i < parts.length; i++) {
    final _AnatomyPart p = parts[i];
    out.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: p.color,
              border: Border.all(color: const Color(0xFF8E8E93), width: 0.5),
            ),
            alignment: Alignment.center,
            child: Text(
              p.letter,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  p.name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  p.blurb,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF636366)),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
  return out;
}

Widget _comparisonMatrix(List<List<String>> rows) {
  final List<Widget> tableRows = <Widget>[];
  for (var i = 0; i < rows.length; i++) {
    final List<String> row = rows[i];
    final bool isHeader = i == 0;
    final Color bg = isHeader
        ? const Color(0xFFE5E5EA)
        : (i.isEven ? const Color(0xFFF2F2F7) : const Color(0xFFFFFFFF));
    tableRows.add(Container(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              row[0],
              style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      isHeader ? FontWeight.bold : FontWeight.w600,
                  color: const Color(0xFF1C1C1E)),
            ),
          ),
          Expanded(
            child: Text(
              row[1],
              style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      isHeader ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              row[2],
              style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      isHeader ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFC7C7CC), width: 1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: tableRows,
    ),
  );
}

// =============================================================================
// Data classes.
// =============================================================================

class _Concept {
  _Concept({
    required this.label,
    required this.family,
    required this.tagline,
    required this.bullets,
    required this.accent,
  });
  final String label;
  final String family;
  final String tagline;
  final List<String> bullets;
  final Color accent;
}

enum _StackKind { root, cupertinoPage, fullscreenDialog, materialPage }

class _StackFrame {
  _StackFrame({
    required this.depth,
    required this.label,
    required this.title,
    required this.kind,
    required this.details,
  });
  final int depth;
  final String label;
  final String title;
  final _StackKind kind;
  final String details;
}

class _AnatomyPart {
  _AnatomyPart({
    required this.letter,
    required this.name,
    required this.blurb,
    required this.color,
  });
  final String letter;
  final String name;
  final String blurb;
  final Color color;
}
