// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep visual demo: ScrollBehavior, ScrollConfiguration,
// PrimaryScrollController, PageStorage / PageStorageBucket, and the
// ScrollPhysics taxonomy that they expose to descendant scrollables.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  // ----- Palette: deep slate / amber / teal accents (unique). -------------
  const Color cBg = Color(0xFF0F1620);
  const Color cSurface = Color(0xFF1A2433);
  const Color cSurface2 = Color(0xFF243043);
  const Color cBorder = Color(0xFF334155);
  const Color cAmber = Color(0xFFF6B445);
  const Color cAmberSoft = Color(0xFFFCD9A0);
  const Color cTeal = Color(0xFF22C7B8);
  const Color cTealSoft = Color(0xFF7BE5DA);
  const Color cMauve = Color(0xFFB47BD9);
  const Color cRose = Color(0xFFE56E84);
  const Color cText = Color(0xFFE6ECF2);
  const Color cTextDim = Color(0xFF98A4B3);
  const Color cTextFaint = Color(0xFF6C7889);

  // ----- Smoke checks (wrapped, never throws to caller). ------------------
  String behaviorPlatform = 'unknown';
  try {
    final ScrollBehavior probe = const ScrollBehavior();
    behaviorPlatform = probe.getPlatform(context).toString();
    print('[scroll] ScrollBehavior.getPlatform => $behaviorPlatform');
  } catch (e) {
    print('[scroll] probe ScrollBehavior failed: $e');
  }

  String matBehaviorDesc = 'n/a';
  try {
    final ScrollBehavior mat = const MaterialScrollBehavior();
    matBehaviorDesc = mat.runtimeType.toString();
    print('[scroll] MaterialScrollBehavior runtime type => $matBehaviorDesc');
  } catch (e) {
    print('[scroll] probe MaterialScrollBehavior failed: $e');
  }

  // PageStorage write/read smoke test using a synthetic key.
  String bucketEcho = '<empty>';
  try {
    final PageStorageBucket bucket = PageStorageBucket();
    bucket.writeState(context, 'tom-rocks', identifier: 'demo-key');
    final Object? back = bucket.readState(context, identifier: 'demo-key');
    bucketEcho = back?.toString() ?? '<null>';
    print('[scroll] PageStorageBucket round-trip => $bucketEcho');
  } catch (e) {
    print('[scroll] bucket round-trip failed: $e');
  }

  // ----- Reusable text styles. -------------------------------------------
  const TextStyle tHero = TextStyle(
    color: cText,
    fontSize: 30,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
  );
  const TextStyle tSub = TextStyle(
    color: cTextDim,
    fontSize: 14,
    height: 1.45,
  );
  const TextStyle tH2 = TextStyle(
    color: cAmber,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
  );
  const TextStyle tH3 = TextStyle(
    color: cTealSoft,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
  const TextStyle tBody = TextStyle(
    color: cText,
    fontSize: 13,
    height: 1.5,
  );
  const TextStyle tDim = TextStyle(
    color: cTextDim,
    fontSize: 12,
    height: 1.45,
  );
  const TextStyle tFaint = TextStyle(
    color: cTextFaint,
    fontSize: 11,
    height: 1.4,
  );
  const TextStyle tCode = TextStyle(
    color: cAmberSoft,
    fontSize: 12.5,
    fontFamily: 'monospace',
    height: 1.45,
  );
  const TextStyle tChip = TextStyle(
    color: cText,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  // ----- Helper: pill chip. ----------------------------------------------
  Widget pill(String label, Color tint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.16),
        border: Border.all(color: tint.withValues(alpha: 0.55)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: tChip),
    );
  }

  // ----- Helper: section card. -------------------------------------------
  Widget section(String tag, String title, String blurb, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        color: cSurface,
        border: Border.all(color: cBorder),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              pill(tag, cAmber),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: tH2)),
            ],
          ),
          const SizedBox(height: 6),
          Text(blurb, style: tSub),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  // ----- Helper: code block. ---------------------------------------------
  Widget codeBlock(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1119),
        border: Border.all(color: cBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(code, style: tCode),
    );
  }

  // ----- Helper: kv row. -------------------------------------------------
  Widget kv(String k, String v, {Color? tint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              k,
              style: TextStyle(
                color: tint ?? cTealSoft,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(child: Text(v, style: tDim)),
        ],
      ),
    );
  }

  // ----- Helper: simple table cell. --------------------------------------
  Widget cell(String t, {bool head = false, Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: head ? cSurface2 : Colors.transparent,
        border: Border(bottom: BorderSide(color: cBorder)),
      ),
      child: Text(
        t,
        style: TextStyle(
          color: color ?? (head ? cAmber : cText),
          fontSize: 12,
          fontWeight: head ? FontWeight.w800 : FontWeight.w500,
          fontFamily: head ? null : 'monospace',
          height: 1.4,
        ),
      ),
    );
  }

  // ====================================================================
  // SECTION: HERO HEADER
  // ====================================================================
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          cAmber.withValues(alpha: 0.24),
          cTeal.withValues(alpha: 0.18),
          cMauve.withValues(alpha: 0.14),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.swap_vert, color: cAmber, size: 28),
            const SizedBox(width: 10),
            Text('Scroll family — behavior, config, controllers, storage',
                style: tHero),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'A walk through ScrollBehavior, ScrollConfiguration, '
          'PrimaryScrollController, PageStorage and PageStorageBucket — '
          'the Inherited mechanics that decide HOW your scrollables feel.',
          style: tSub,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            pill('ScrollBehavior', cAmber),
            pill('ScrollConfiguration', cTeal),
            pill('PrimaryScrollController', cMauve),
            pill('PageStorage', cRose),
            pill('PageStorageBucket', cTealSoft),
          ],
        ),
        const SizedBox(height: 12),
        Text('probe.getPlatform => $behaviorPlatform', style: tFaint),
        Text('Material runtime  => $matBehaviorDesc', style: tFaint),
        Text('bucket round-trip => $bucketEcho', style: tFaint),
      ],
    ),
  );

  // ====================================================================
  // SECTION: LAYERED DIAGRAM
  // ====================================================================
  Widget layerRow(String name, String role, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.12),
        border: Border.all(color: tint.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 200,
            child: Text(
              name,
              style: TextStyle(
                color: tint,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(child: Text(role, style: tBody)),
        ],
      ),
    );
  }

  final Widget diagram = Column(
    children: <Widget>[
      layerRow('ScrollConfiguration', 'InheritedWidget — exposes a behavior',
          cAmber),
      Center(child: Icon(Icons.south, color: cTextFaint, size: 18)),
      layerRow('ScrollBehavior', 'Picks physics, scrollbar, overscroll, drag',
          cTeal),
      Center(child: Icon(Icons.south, color: cTextFaint, size: 18)),
      layerRow('ScrollPhysics', 'BouncingScrollPhysics, Clamping…', cMauve),
      Center(child: Icon(Icons.south, color: cTextFaint, size: 18)),
      layerRow('ScrollPosition', 'Owned by a ScrollController', cRose),
      Center(child: Icon(Icons.south, color: cTextFaint, size: 18)),
      layerRow('Scrollable', 'The Listview/CustomScrollView/etc.', cTealSoft),
    ],
  );

  // ====================================================================
  // SECTION: PLATFORM COMPARISON TABLE
  // ====================================================================
  Widget tableRow(List<String> cells, {bool head = false}) {
    final List<Widget> kids = <Widget>[];
    for (int i = 0; i < cells.length; i++) {
      kids.add(Expanded(
        flex: i == 0 ? 2 : 3,
        child: cell(cells[i], head: head),
      ));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    );
  }

  final Widget platformTable = Container(
    decoration: BoxDecoration(
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: <Widget>[
        tableRow(<String>['Platform', 'Physics', 'Overscroll', 'Drag devices'],
            head: true),
        tableRow(<String>[
          'Android',
          'ClampingScrollPhysics',
          'GlowingOverscrollIndicator',
          'touch, stylus',
        ]),
        tableRow(<String>[
          'iOS',
          'BouncingScrollPhysics',
          'rubber-band bounce',
          'touch',
        ]),
        tableRow(<String>[
          'macOS',
          'BouncingScrollPhysics',
          'rubber-band bounce',
          'touch, mouse, trackpad',
        ]),
        tableRow(<String>[
          'Linux',
          'ClampingScrollPhysics',
          'glow (none on desktop default)',
          'touch, mouse, trackpad',
        ]),
        tableRow(<String>[
          'Windows',
          'ClampingScrollPhysics',
          'standard',
          'touch, mouse, trackpad',
        ]),
        tableRow(<String>[
          'Fuchsia',
          'BouncingScrollPhysics',
          'bounce',
          'touch, mouse',
        ]),
      ],
    ),
  );

  // ====================================================================
  // SECTION: dragDevices set as chips
  // ====================================================================
  Widget deviceChip(PointerDeviceKind kind, IconData icon, Color tint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.12),
        border: Border.all(color: tint.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: tint),
          const SizedBox(width: 8),
          Text(kind.toString().split('.').last,
              style: TextStyle(
                color: cText,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }

  final Widget dragDevices = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: <Widget>[
      deviceChip(PointerDeviceKind.touch, Icons.touch_app, cAmber),
      deviceChip(PointerDeviceKind.mouse, Icons.mouse, cTeal),
      deviceChip(PointerDeviceKind.stylus, Icons.edit, cMauve),
      deviceChip(PointerDeviceKind.invertedStylus, Icons.brush, cRose),
      deviceChip(PointerDeviceKind.trackpad, Icons.swipe, cTealSoft),
      deviceChip(PointerDeviceKind.unknown, Icons.help, cTextFaint),
    ],
  );

  // ====================================================================
  // SECTION: PER-PLATFORM MOCK PREVIEWS (no real platform override —
  // the cards just illustrate the visual idea using static shapes).
  // ====================================================================
  Widget mockCard({
    required String title,
    required TargetPlatform platform,
    required Color tint,
    required String physics,
    required String overscrollHint,
    required IconData glyph,
  }) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < 4; i++) {
      rows.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        height: 14,
        width: double.infinity,
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.18 + i * 0.05),
          borderRadius: BorderRadius.circular(4),
        ),
      ));
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cSurface2,
        border: Border.all(color: tint.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(glyph, size: 16, color: tint),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                    color: tint,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
          const SizedBox(height: 6),
          Text(platform.toString().split('.').last, style: tFaint),
          const SizedBox(height: 8),
          Container(
            height: 90,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cBg,
              border: Border.all(color: cBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rows,
            ),
          ),
          const SizedBox(height: 8),
          Text('physics: $physics', style: tCode),
          const SizedBox(height: 2),
          Text(overscrollHint, style: tFaint),
        ],
      ),
    );
  }

  final Widget mockGrid = GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 1.4,
    children: <Widget>[
      mockCard(
        title: 'Android glow',
        platform: TargetPlatform.android,
        tint: cAmber,
        physics: 'ClampingScrollPhysics()',
        overscrollHint: 'GlowingOverscrollIndicator at edges',
        glyph: Icons.android,
      ),
      mockCard(
        title: 'iOS bounce',
        platform: TargetPlatform.iOS,
        tint: cTeal,
        physics: 'BouncingScrollPhysics()',
        overscrollHint: 'rubber-band over both edges',
        glyph: Icons.phone_iphone,
      ),
      mockCard(
        title: 'macOS trackpad',
        platform: TargetPlatform.macOS,
        tint: cMauve,
        physics: 'BouncingScrollPhysics()',
        overscrollHint: 'trackpad scroll + bounce',
        glyph: Icons.laptop_mac,
      ),
      mockCard(
        title: 'Windows std.',
        platform: TargetPlatform.windows,
        tint: cRose,
        physics: 'ClampingScrollPhysics()',
        overscrollHint: 'no glow, no bounce',
        glyph: Icons.desktop_windows,
      ),
    ],
  );

  // ====================================================================
  // SECTION: SCROLL CONFIGURATION CODE CARD
  // ====================================================================
  final Widget configCode = codeBlock(
    'ScrollConfiguration(\n'
    '  // never subclass — use the canonical one and copyWith.\n'
    '  behavior: const MaterialScrollBehavior().copyWith(\n'
    '    scrollbars: true,\n'
    '    overscroll: false,\n'
    '    physics: const BouncingScrollPhysics(),\n'
    '    dragDevices: <PointerDeviceKind>{\n'
    '      PointerDeviceKind.touch,\n'
    '      PointerDeviceKind.mouse,\n'
    '      PointerDeviceKind.trackpad,\n'
    '    },\n'
    '  ),\n'
    '  child: ListView(/* … */),\n'
    ')',
  );

  // Live ScrollConfiguration around a tiny preview list.
  Widget previewList(String label) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < 12; i++) {
      tiles.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: cSurface2,
          border: Border.all(color: cBorder),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text('$label · row #$i',
            style: const TextStyle(color: cText, fontSize: 12)),
      ));
    }
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: tiles,
    );
  }

  Widget previewBox(String label, ScrollBehavior behavior, Color tint) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: cBg,
        border: Border.all(color: tint.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ScrollConfiguration(
        behavior: behavior,
        child: previewList(label),
      ),
    );
  }

  // The MaterialScrollBehavior copyWith pieces are passed into a fresh
  // instance — wrapped in try/catch in case the runtime rejects an option.
  Widget makeConfiguredPreview() {
    try {
      final ScrollBehavior tweaked =
          const MaterialScrollBehavior().copyWith(scrollbars: true);
      return previewBox('configured', tweaked, cTeal);
    } catch (e) {
      print('[scroll] configured preview failed: $e');
      return Container(
        height: 160,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: cRose),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text('preview unavailable: $e', style: tFaint),
      );
    }
  }

  final Widget configPreviews = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('default behavior', style: tH3),
            const SizedBox(height: 6),
            previewBox('default', const ScrollBehavior(), cAmber),
          ],
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('material + copyWith', style: tH3),
            const SizedBox(height: 6),
            makeConfiguredPreview(),
          ],
        ),
      ),
    ],
  );

  // ====================================================================
  // SECTION: PRIMARY SCROLL CONTROLLER
  // ====================================================================
  // Two ListViews: one with primary:true (lets the inherited
  // PrimaryScrollController own its position), the other with an
  // explicit local controller. We DO NOT keep these in state — they're
  // build-scoped just to illustrate the wiring.
  final ScrollController explicitCtrl = ScrollController();

  Widget primaryDemoList(String label, bool primary,
      {ScrollController? ctrl}) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < 20; i++) {
      tiles.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                  color: primary ? cAmber : cTeal, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text('$label item #$i',
                style: const TextStyle(color: cText, fontSize: 12)),
          ],
        ),
      ));
    }
    return ListView(
      primary: primary,
      controller: ctrl,
      physics: const AlwaysScrollableScrollPhysics(),
      children: tiles,
    );
  }

  final Widget primaryShowcase = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('primary: true (uses PrimaryScrollController)', style: tH3),
            const SizedBox(height: 6),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: cBg,
                border: Border.all(color: cAmber.withValues(alpha: 0.5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: primaryDemoList('primary', true),
            ),
            const SizedBox(height: 6),
            const Text(
              'Default for vertical Scrollables in a Scaffold body.',
              style: tFaint,
            ),
          ],
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('explicit local ScrollController', style: tH3),
            const SizedBox(height: 6),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: cBg,
                border: Border.all(color: cTeal.withValues(alpha: 0.5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: primaryDemoList('local', false, ctrl: explicitCtrl),
            ),
            const SizedBox(height: 6),
            const Text(
              'Opts out — owns its own ScrollPosition.',
              style: tFaint,
            ),
          ],
        ),
      ),
    ],
  );

  // ====================================================================
  // SECTION: PAGE STORAGE
  // ====================================================================
  // Two PageStorageKey'd ListViews under the same bucket — so the
  // framework remembers each one's scroll offset by key.
  final PageStorageBucket sharedBucket = PageStorageBucket();

  Widget storedList(String tag, Color tint) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < 30; i++) {
      tiles.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Text('$tag · entry $i',
            style: TextStyle(color: cText.withValues(alpha: 0.95), fontSize: 12)),
      ));
    }
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: cBg,
        border: Border.all(color: tint.withValues(alpha: 0.55)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        key: PageStorageKey<String>('list-$tag'),
        physics: const BouncingScrollPhysics(),
        children: tiles,
      ),
    );
  }

  final Widget pageStorageDemo = PageStorage(
    bucket: sharedBucket,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Each ListView has a PageStorageKey. The shared '
          'PageStorageBucket above remembers their offsets across rebuilds, '
          'tab switches, and route pushes.',
          style: tBody,
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('PageStorageKey("list-A")', style: tH3),
                  const SizedBox(height: 6),
                  storedList('A', cAmber),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('PageStorageKey("list-B")', style: tH3),
                  const SizedBox(height: 6),
                  storedList('B', cMauve),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ====================================================================
  // SECTION: BEHAVIOR vs PHYSICS vs NOTIFICATION
  // ====================================================================
  Widget compareCol(String title, Color tint, List<String> bullets) {
    final List<Widget> kids = <Widget>[
      Text(title, style: tH3),
      const SizedBox(height: 6),
    ];
    for (int i = 0; i < bullets.length; i++) {
      kids.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5, right: 8),
              width: 5,
              height: 5,
              decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
            ),
            Expanded(child: Text(bullets[i], style: tDim)),
          ],
        ),
      ));
    }
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cSurface2,
          border: Border.all(color: tint.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: kids),
      ),
    );
  }

  final Widget compareTable = Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      compareCol('ScrollBehavior', cAmber, <String>[
        'Lives at the configuration level',
        'Picks ScrollPhysics for the platform',
        'Adds Scrollbar / Glow wrappers',
        'Defines dragDevices set',
      ]),
      compareCol('ScrollPhysics', cTeal, <String>[
        'The math of the throw / bounce',
        'BouncingScrollPhysics, Clamping, …',
        'Composed with .applyTo(parent)',
        'Owned by the ScrollPosition',
      ]),
      compareCol('ScrollNotification', cMauve, <String>[
        'Bubbles up the widget tree',
        'Start, Update, End, Overscroll',
        'Use NotificationListener<…>',
        'Read-only — observe, do not control',
      ]),
    ],
  );

  // ====================================================================
  // SECTION: PHYSICS REFERENCE TABLE
  // ====================================================================
  final Widget physicsTable = Container(
    decoration: BoxDecoration(
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: <Widget>[
        tableRow(<String>['Class', 'Feel', 'Where it ships'], head: true),
        tableRow(<String>[
          'BouncingScrollPhysics',
          'rubber-band edges',
          'iOS / macOS default',
        ]),
        tableRow(<String>[
          'ClampingScrollPhysics',
          'hard stop at edges',
          'Android / Linux / Windows',
        ]),
        tableRow(<String>[
          'AlwaysScrollableScrollPhysics',
          'scrolls even with little content',
          'pull-to-refresh setups',
        ]),
        tableRow(<String>[
          'NeverScrollableScrollPhysics',
          'inert — disables scrolling',
          'nested non-scrolling lists',
        ]),
        tableRow(<String>[
          'PageScrollPhysics',
          'snaps to viewport pages',
          'PageView default',
        ]),
        tableRow(<String>[
          'FixedExtentScrollPhysics',
          'snaps to fixed-extent items',
          'CupertinoPicker / wheels',
        ]),
        tableRow(<String>[
          'RangeMaintainingScrollPhysics',
          'keeps offset stable on resize',
          'wraps another physics',
        ]),
      ],
    ),
  );

  // ====================================================================
  // SECTION: EDGE CASES
  // ====================================================================
  final Widget edgeCases = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      kv('No PrimaryScrollController',
          'PrimaryScrollController.maybeOf(context) returns null. A '
          'ListView with primary:true falls back to a controller that '
          'is created on demand, but bucketed nesting fails silently.',
          tint: cRose),
      kv('Conflicting buckets',
          'Two PageStorage widgets with the SAME key in scope will '
          'last-write-wins. Use unique PageStorageKey identifiers per '
          'tab / route.',
          tint: cAmber),
      kv('Nested scrollables',
          'Two vertical ListViews under one PrimaryScrollController '
          'cause assertion errors. Give one its own controller, or set '
          'primary:false explicitly.',
          tint: cMauve),
      kv('Horizontal Scrollables',
          'Horizontal lists DO NOT auto-attach to PrimaryScrollController '
          'because that one is reserved for the vertical body axis.',
          tint: cTeal),
      kv('NeverScrollableScrollPhysics',
          'Disables touch dragging, but programmatic '
          'controller.jumpTo(...) still works.',
          tint: cTealSoft),
    ],
  );

  // ====================================================================
  // SECTION: ScrollPhysics inheritance ladder
  // ====================================================================
  Widget physicsLadderRow(int depth, String name, String note, Color tint) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0 * depth, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 240,
            child: Text(
              name,
              style: TextStyle(
                color: tint,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(child: Text(note, style: tDim)),
        ],
      ),
    );
  }

  final Widget physicsLadder = Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cSurface2,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        physicsLadderRow(0, 'ScrollPhysics', 'abstract base', cAmber),
        physicsLadderRow(
            1, 'BouncingScrollPhysics', 'rubber-band edges', cTeal),
        physicsLadderRow(
            1, 'ClampingScrollPhysics', 'glow / hard stop', cTeal),
        physicsLadderRow(
            1, 'AlwaysScrollableScrollPhysics', 'wraps a parent', cMauve),
        physicsLadderRow(
            1, 'NeverScrollableScrollPhysics', 'opt-out', cMauve),
        physicsLadderRow(
            1, 'PageScrollPhysics', 'page-snap', cRose),
        physicsLadderRow(
            2, 'FixedExtentScrollPhysics', 'cupertino wheels', cTealSoft),
        physicsLadderRow(
            1, 'RangeMaintainingScrollPhysics', 'preserves offset', cAmberSoft),
      ],
    ),
  );

  // ====================================================================
  // SECTION: KeyboardDismissBehavior callout
  // ====================================================================
  Widget kbCard(String label, String desc, Color tint, IconData glyph) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.1),
          border: Border.all(color: tint.withValues(alpha: 0.55)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(glyph, size: 16, color: tint),
                const SizedBox(width: 8),
                Text(label,
                    style: TextStyle(
                      color: tint,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    )),
              ],
            ),
            const SizedBox(height: 6),
            Text(desc, style: tBody),
          ],
        ),
      ),
    );
  }

  String dismissManual = '<unknown>';
  String dismissOnDrag = '<unknown>';
  try {
    dismissManual = ScrollViewKeyboardDismissBehavior.manual.toString();
    dismissOnDrag = ScrollViewKeyboardDismissBehavior.onDrag.toString();
    print('[scroll] kb manual=$dismissManual drag=$dismissOnDrag');
  } catch (e) {
    print('[scroll] kb dismiss probe failed: $e');
  }

  final Widget kbBehavior = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          kbCard(
            'manual',
            'Default. Once a soft keyboard is open, it stays open while '
                'the user scrolls. The app must call '
                'FocusManager.primaryFocus?.unfocus() itself.',
            cAmber,
            Icons.keyboard_hide,
          ),
          kbCard(
            'onDrag',
            'The keyboard collapses as soon as a drag gesture begins. '
                'Convenient for chat / form scaffolds where keyboards '
                'compete with content for vertical space.',
            cTeal,
            Icons.swipe_down,
          ),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cSurface2,
          border: Border.all(color: cBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('runtime values', style: tH3),
            const SizedBox(height: 4),
            Text('manual  → $dismissManual', style: tCode),
            Text('onDrag  → $dismissOnDrag', style: tCode),
          ],
        ),
      ),
    ],
  );

  // ====================================================================
  // SECTION: ScrollNotification ladder (read-only, illustrative)
  // ====================================================================
  Widget notifRow(String name, String when, Color tint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 220,
            child: Text(name,
                style: TextStyle(
                  color: tint,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                )),
          ),
          Expanded(child: Text(when, style: tDim)),
        ],
      ),
    );
  }

  final Widget notifLadder = Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cSurface2,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        notifRow('ScrollStartNotification',
            'Drag, programmatic animateTo, or fling begins.', cAmber),
        notifRow('ScrollUpdateNotification',
            'Each frame the offset advances.', cTeal),
        notifRow('OverscrollNotification',
            'Beyond min/max — bounce or glow region.', cMauve),
        notifRow('ScrollEndNotification',
            'Activity finishes — settle, idle, ballistic done.', cRose),
        notifRow('UserScrollNotification',
            'Reports the ScrollDirection — forward, reverse, idle.',
            cTealSoft),
      ],
    ),
  );

  // ====================================================================
  // SECTION: scrollbar / overscroll toggle preview
  // ====================================================================
  Widget toggleCard(String title, bool scrollbars, bool overscroll,
      Color tint) {
    Widget body;
    try {
      final ScrollBehavior tweaked = const MaterialScrollBehavior().copyWith(
        scrollbars: scrollbars,
        overscroll: overscroll,
      );
      body = previewBox(title, tweaked, tint);
    } catch (e) {
      print('[scroll] toggle $title failed: $e');
      body = Container(
        height: 160,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: cRose),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text('failed: $e', style: tFaint),
      );
    }
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: tH3),
            const SizedBox(height: 4),
            Text(
              'scrollbars=$scrollbars · overscroll=$overscroll',
              style: tFaint,
            ),
            const SizedBox(height: 6),
            body,
          ],
        ),
      ),
    );
  }

  final Widget toggleRow = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      toggleCard('default', true, true, cAmber),
      toggleCard('no overscroll', true, false, cTeal),
      toggleCard('no bars', false, true, cMauve),
    ],
  );

  // ====================================================================
  // SECTION: lookup matrix
  // ====================================================================
  Widget lookupRow(String fn, String returns, String when, bool nullable) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cBorder)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(fn,
                style: TextStyle(
                  color: nullable ? cTealSoft : cAmber,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                )),
          ),
          Expanded(
            flex: 2,
            child: Text(returns,
                style: const TextStyle(
                  color: cText,
                  fontSize: 12,
                  fontFamily: 'monospace',
                )),
          ),
          Expanded(flex: 4, child: Text(when, style: tDim)),
        ],
      ),
    );
  }

  final Widget lookupMatrix = Container(
    decoration: BoxDecoration(
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          color: cSurface2,
          child: Row(
            children: <Widget>[
              Expanded(flex: 3, child: Text('lookup', style: tH3)),
              Expanded(flex: 2, child: Text('returns', style: tH3)),
              Expanded(flex: 4, child: Text('when', style: tH3)),
            ],
          ),
        ),
        lookupRow('ScrollConfiguration.of(ctx)', 'ScrollBehavior',
            'never null — defaults exist', false),
        lookupRow('PrimaryScrollController.of(ctx)', 'ScrollController',
            'asserts a controller is in scope', false),
        lookupRow('PrimaryScrollController.maybeOf(ctx)', 'ScrollController?',
            'returns null if absent', true),
        lookupRow('PageStorage.of(ctx)', 'PageStorageBucket?',
            'null if no PageStorage ancestor', true),
        lookupRow('Scrollable.of(ctx)', 'ScrollableState',
            'innermost Scrollable ancestor', false),
        lookupRow('Scrollable.maybeOf(ctx)', 'ScrollableState?',
            'nullable variant', true),
      ],
    ),
  );

  // ====================================================================
  // SECTION: PageStorage state-flow timeline
  // ====================================================================
  Widget timelineStep(int n, String title, String body, Color tint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.18),
              border: Border.all(color: tint),
              shape: BoxShape.circle,
            ),
            child: Text('$n',
                style: TextStyle(
                  color: tint,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: TextStyle(
                      color: cText,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 3),
                Text(body, style: tDim),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget storageTimeline = Container(
    padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
    decoration: BoxDecoration(
      color: cSurface2,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        timelineStep(
          1,
          'Mount',
          'A Scrollable with a PageStorageKey looks up the bucket via '
              'PageStorage.of(context). If found, it tries readState '
              'with its key.',
          cAmber,
        ),
        timelineStep(
          2,
          'Restore',
          'If a previous offset exists in the bucket, the scroll '
              'position is initialised to that value before the first '
              'paint.',
          cTeal,
        ),
        timelineStep(
          3,
          'User scrolls',
          'On every settle, the Scrollable calls bucket.writeState '
              'with its current offset.',
          cMauve,
        ),
        timelineStep(
          4,
          'Tab / route swap',
          'The widget is unmounted but the bucket stays alive higher '
              'up the tree, so the offset survives.',
          cRose,
        ),
        timelineStep(
          5,
          'Remount',
          'Back at step 2 — the offset is reapplied, and the user '
              'lands exactly where they left.',
          cTealSoft,
        ),
      ],
    ),
  );

  // ====================================================================
  // SECTION: scroll glossary
  // ====================================================================
  Widget glossEntry(String term, String def, Color tint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: tint, width: 3),
          bottom: BorderSide(color: cBorder),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(term,
                style: TextStyle(
                  color: tint,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                )),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(def, style: tBody)),
        ],
      ),
    );
  }

  final Widget glossary = Container(
    decoration: BoxDecoration(
      color: cSurface2,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: <Widget>[
        glossEntry('Scrollable',
            'The widget that owns gesture detection and a viewport.', cAmber),
        glossEntry('Viewport',
            'The clip region; renders the slivers that intersect it.',
            cTeal),
        glossEntry('Sliver',
            'A scroll-aware piece of the viewport — list, grid, header.',
            cMauve),
        glossEntry('ScrollPosition',
            'The mutable state — offset, range, viewport metrics.',
            cRose),
        glossEntry('ScrollController',
            'Owns the position; lets you read/animate it from outside.',
            cTealSoft),
        glossEntry('ScrollActivity',
            'What the position is currently doing — drag, ballistic, idle.',
            cAmberSoft),
        glossEntry('ScrollMetrics',
            'A snapshot of position values at a moment in time.', cAmber),
        glossEntry('OverscrollIndicator',
            'The visual feedback when a user pushes beyond min/max.',
            cTeal),
      ],
    ),
  );

  // ====================================================================
  // SECTION: copyWith parameters guide
  // ====================================================================
  Widget paramRow(String name, String type, String def) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cBorder)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(name,
                style: const TextStyle(
                  color: cAmber,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                )),
          ),
          SizedBox(
            width: 130,
            child: Text(type,
                style: const TextStyle(
                  color: cTealSoft,
                  fontSize: 12,
                  fontFamily: 'monospace',
                )),
          ),
          Expanded(child: Text(def, style: tDim)),
        ],
      ),
    );
  }

  final Widget paramsTable = Container(
    decoration: BoxDecoration(
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: <Widget>[
        Container(
          color: cSurface2,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Row(
            children: <Widget>[
              SizedBox(
                  width: 130,
                  child: Text('parameter', style: tH3)),
              SizedBox(width: 130, child: Text('type', style: tH3)),
              Expanded(child: Text('what it does', style: tH3)),
            ],
          ),
        ),
        paramRow('scrollbars', 'bool',
            'Whether to wrap children in a Scrollbar.'),
        paramRow('overscroll', 'bool',
            'Whether to add the platform overscroll indicator (glow).'),
        paramRow('physics', 'ScrollPhysics?',
            'Override the default physics for descendants.'),
        paramRow('platform', 'TargetPlatform?',
            'Force a specific platform — useful for testing.'),
        paramRow('dragDevices', 'Set<PointerDeviceKind>?',
            'Override which input devices may drag.'),
        paramRow('multitouchDragStrategy', 'MultitouchDragStrategy?',
            'How to combine multiple finger drags into a single offset.'),
      ],
    ),
  );

  // ====================================================================
  // SECTION: API CHEAT-SHEET
  // ====================================================================
  final Widget apiCheat = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      kv('ScrollBehavior.copyWith',
          'Returns a derived behavior — toggle scrollbars, overscroll, '
          'physics, dragDevices.'),
      kv('ScrollConfiguration.of(context)',
          'Looks up the nearest behavior in scope.'),
      kv('PrimaryScrollController.of(context)',
          'Asserts a controller exists. Use .maybeOf for nullable lookup.'),
      kv('PageStorage.of(context)',
          'Returns the nearest PageStorageBucket for read/writeState.'),
      kv('PageStorageKey<T>',
          'Use a stable identifier — string, int, custom value type.'),
      kv('ScrollViewKeyboardDismissBehavior',
          'manual = stays open · onDrag = dismisses on drag start.'),
    ],
  );

  // ====================================================================
  // FINAL ASSEMBLY
  // ====================================================================
  return Scaffold(
    backgroundColor: cBg,
    appBar: AppBar(
      backgroundColor: cSurface,
      elevation: 0,
      title: Row(
        children: <Widget>[
          Icon(Icons.layers, color: cAmber, size: 20),
          const SizedBox(width: 8),
          Text('scroll family · ScrollBehavior · PageStorage',
              style: TextStyle(
                color: cText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: cBorder),
      ),
    ),
    body: ScrollConfiguration(
      behavior: const MaterialScrollBehavior(),
      child: PrimaryScrollController(
        controller: ScrollController(),
        child: PageStorage(
          bucket: PageStorageBucket(),
          child: SingleChildScrollView(
            primary: true,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                hero,
                const SizedBox(height: 22),
                section(
                  '01',
                  'Layered diagram',
                  'How a Scrollable resolves its behavior at build time, '
                      'from the InheritedWidget all the way down to the '
                      'tiny ScrollPhysics that decides each tick.',
                  diagram,
                ),
                section(
                  '02',
                  'Platform comparison',
                  'MaterialScrollBehavior picks different physics and '
                      'overscroll affordances per TargetPlatform.',
                  platformTable,
                ),
                section(
                  '03',
                  'dragDevices set',
                  'ScrollBehavior.dragDevices is the set of pointer kinds '
                      'that trigger a drag. Customize via copyWith.',
                  dragDevices,
                ),
                section(
                  '04',
                  'Mock previews per platform',
                  'Visual cue for what overscroll feels like on each major '
                      'platform — these are static cards, not live physics.',
                  mockGrid,
                ),
                section(
                  '05',
                  'ScrollConfiguration code-card',
                  'The canonical pattern: keep MaterialScrollBehavior, '
                      'lean on copyWith, never subclass.',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      configCode,
                      const SizedBox(height: 12),
                      configPreviews,
                    ],
                  ),
                ),
                section(
                  '06',
                  'PrimaryScrollController',
                  'The vertical body controller that ListView, GridView '
                      'and friends pick up automatically when '
                      'primary: true.',
                  primaryShowcase,
                ),
                section(
                  '07',
                  'PageStorage / PageStorageBucket',
                  'Per-page state storage keyed by PageStorageKey — '
                      'most often used to remember scroll offsets.',
                  pageStorageDemo,
                ),
                section(
                  '08',
                  'Behavior vs Physics vs Notification',
                  'They look related but live at different layers. '
                      'Use the right tool for the job.',
                  compareTable,
                ),
                section(
                  '09',
                  'ScrollPhysics reference',
                  'The seven concrete physics you will reach for most '
                      'often, with the feel and the typical home.',
                  physicsTable,
                ),
                section(
                  '10',
                  'Edge cases & footguns',
                  'Quiet failure modes around inherited controllers and '
                      'storage buckets.',
                  edgeCases,
                ),
                section(
                  '11',
                  'ScrollPhysics inheritance ladder',
                  'Where every concrete physics sits below the base class. '
                      'Useful for picking the right composition target.',
                  physicsLadder,
                ),
                section(
                  '12',
                  'KeyboardDismissBehavior',
                  'A small but high-impact toggle for forms inside scrollable '
                      'screens.',
                  kbBehavior,
                ),
                section(
                  '13',
                  'ScrollNotification ladder',
                  'The five built-in notification types that bubble out of '
                      'every Scrollable. Listen, do not control.',
                  notifLadder,
                ),
                section(
                  '14',
                  'Behavior toggle previews',
                  'Three live ScrollConfiguration previews that flip the '
                      'scrollbars / overscroll booleans through copyWith.',
                  toggleRow,
                ),
                section(
                  '15',
                  'Lookup matrix',
                  'Quick reference for the static .of / .maybeOf entry '
                      'points across this whole family.',
                  lookupMatrix,
                ),
                section(
                  '16',
                  'PageStorage state-flow',
                  'Lifecycle of an offset from mount through restore, '
                      'capture, and remount.',
                  storageTimeline,
                ),
                section(
                  '17',
                  'Scroll glossary',
                  'The vocabulary you will see in the framework source.',
                  glossary,
                ),
                section(
                  '18',
                  'MaterialScrollBehavior.copyWith parameters',
                  'Every parameter you can override without subclassing.',
                  paramsTable,
                ),
                section(
                  '19',
                  'API cheat-sheet',
                  'The handful of static lookups and copyWith hooks you '
                      'use every day.',
                  apiCheat,
                ),
                const SizedBox(height: 18),
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 2,
                        color: cBorder,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ScrollBehavior · ScrollConfiguration · '
                        'PrimaryScrollController · PageStorage · '
                        'PageStorageBucket',
                        textAlign: TextAlign.center,
                        style: tFaint,
                      ),
                      const SizedBox(height: 4),
                      Text('built without StatefulWidget — pure build()',
                          style: tFaint),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
