// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// EndDrawerButton Deep Demo
// -----------------------------------------------------------------------------
// EndDrawerButton is a Material 3 widget that opens the trailing
// `Scaffold.endDrawer`. It mirrors `DrawerButton`, which opens the leading
// `Scaffold.drawer`. The widget is intentionally small: it's a stateless
// IconButton variant that locates the enclosing ScaffoldState via
// `Scaffold.maybeOf(context)` and calls `openEndDrawer()` on press.
//
// This deep demo walks through every meaningful angle of the API:
//   1. Hero introduction with a small AppBar mockup
//   2. Default usage inside a real mini-Scaffold with an end drawer
//   3. Style sweep: a 2x2 grid showing four ButtonStyle variations
//   4. Theming via EndDrawerButtonTheme + EndDrawerButtonThemeData
//   5. Disabled state: onPressed: null
//   6. Side-by-side DrawerButton vs EndDrawerButton symmetry
//   7. Custom icon override + a stylised badge overlay
//   8. Recipe: a "messages" mini-app with a settings end-drawer
//   9. Reference card with parameters of EndDrawerButton + theme data
//
// Each section has its own colour palette so the eye can find boundaries
// quickly while scrolling. Mini-Scaffolds are wrapped in fixed-height
// SizedBoxes so multiple Scaffolds coexist on a single SingleChildScrollView
// page without infinite-size errors.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== EndDrawerButton Deep Demo ===');
  print('Section count: 9');
  print('All sections embed mini-Scaffolds with fixed-height SizedBoxes.');

  // ---------------------------------------------------------------------------
  // PALETTES
  // Each section gets a distinct palette so the demo reads as a gallery rather
  // than a single sheet. The palette is referenced inside the section header
  // and inside the section body to make boundaries visually obvious.
  // ---------------------------------------------------------------------------
  const heroBg = Color(0xFFEDE7F6);          // section 1 - violet 50
  const heroAccent = Color(0xFF5E35B1);      // section 1 - violet 600

  const defaultBg = Color(0xFFE3F2FD);       // section 2 - blue 50
  const defaultAccent = Color(0xFF1565C0);   // section 2 - blue 800

  const sweepBg = Color(0xFFE0F2F1);         // section 3 - teal 50
  const sweepAccent = Color(0xFF00695C);     // section 3 - teal 800

  const themeBg = Color(0xFFFFF3E0);         // section 4 - orange 50
  const themeAccent = Color(0xFFE65100);     // section 4 - orange 900

  const disabledBg = Color(0xFFECEFF1);      // section 5 - blue grey 50
  const disabledAccent = Color(0xFF455A64);  // section 5 - blue grey 700

  const symmetryBg = Color(0xFFF3E5F5);      // section 6 - purple 50
  const symmetryAccent = Color(0xFF6A1B9A);  // section 6 - purple 800

  const iconBg = Color(0xFFE8F5E9);          // section 7 - green 50
  const iconAccent = Color(0xFF2E7D32);      // section 7 - green 800

  const recipeBg = Color(0xFFFCE4EC);        // section 8 - pink 50
  const recipeAccent = Color(0xFFAD1457);    // section 8 - pink 800

  const refBg = Color(0xFFFFF8E1);           // section 9 - amber 50
  const refAccent = Color(0xFFFF8F00);       // section 9 - amber 800

  // ---------------------------------------------------------------------------
  // SECTION 1: HERO CARD
  // ---------------------------------------------------------------------------
  // The hero introduces the widget. It contains a prose paragraph, a couple of
  // bullet-style notes, and a small static AppBar mockup that places an
  // `EndDrawerButton` in `actions:`. Because the hero is decorative and the
  // hero's AppBar lives inside a tiny inner Scaffold, the EndDrawerButton in
  // the hero has no end drawer to open: that's intentional - the goal here is
  // to show what it looks like, not to demonstrate behaviour. Behaviour is
  // covered in section 2.
  // ---------------------------------------------------------------------------
  final heroSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: heroBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_open, color: heroAccent, size: 32),
            const SizedBox(width: 12),
            Text(
              '1. EndDrawerButton',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: heroAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'EndDrawerButton is a Material 3 helper widget that opens the '
          'enclosing Scaffold\'s endDrawer. It is the trailing-side mirror of '
          'DrawerButton. Internally it is an IconButton with a default icon, '
          'a default tooltip from MaterialLocalizations, and an onPressed '
          'handler that calls Scaffold.maybeOf(context)?.openEndDrawer().',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 12),
        const Text(
          'Use it in AppBar.actions when you want a one-tap entrypoint to a '
          'trailing drawer that holds settings, filters, or a secondary nav.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: heroAccent.withOpacity(0.3)),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AppBar mockup (decorative):',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: heroAccent,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: AppBar(
                  backgroundColor: heroAccent,
                  foregroundColor: Colors.white,
                  title: const Text('Inbox'),
                  actions: const [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    EndDrawerButton(),
                    SizedBox(width: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: heroAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Quick facts',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 6),
              Text('- Default icon: Icons.menu (right-aligned).',
                  style: TextStyle(fontSize: 13)),
              Text('- Themable via EndDrawerButtonTheme.',
                  style: TextStyle(fontSize: 13)),
              Text('- Falls back to Scaffold.maybeOf when onPressed is null.',
                  style: TextStyle(fontSize: 13)),
              Text('- onPressed override replaces the default action.',
                  style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2: DEFAULT USAGE
  // ---------------------------------------------------------------------------
  // A real mini-Scaffold sits inside a 320-tall SizedBox. It has an AppBar with
  // an EndDrawerButton in actions, an endDrawer with a header and a few list
  // tiles, and a body that briefly explains what tapping the button does. The
  // SizedBox keeps the mini-Scaffold finite so it can sit happily inside the
  // outer SingleChildScrollView.
  // ---------------------------------------------------------------------------
  final defaultSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: defaultBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: defaultAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              '2. Default usage',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: defaultAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Tap the trailing button in the AppBar below to open the end '
          'drawer. The mini-Scaffold is bounded to 320 logical pixels of '
          'height so multiple instances can be stacked.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 320,
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: defaultAccent,
                foregroundColor: Colors.white,
                title: const Text('Default'),
                actions: const [
                  EndDrawerButton(),
                ],
              ),
              endDrawer: SizedBox(
                width: 240,
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(color: defaultAccent),
                        child: const Text(
                          'Default end drawer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const ListTile(
                        leading: Icon(Icons.bookmark),
                        title: Text('Saved'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Labels'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.archive),
                        title: Text('Archive'),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Body of the default mini-Scaffold.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: defaultAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'The trailing AppBar button is a default-configuration '
                      'EndDrawerButton(). With no parameters it renders the '
                      'standard Material end-drawer affordance and opens '
                      'the enclosing endDrawer when tapped.',
                      style: TextStyle(fontSize: 13, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 3: STYLE SWEEP - 2x2 GRID
  // ---------------------------------------------------------------------------
  // Four mini-Scaffolds, each with its own ButtonStyle on the EndDrawerButton.
  // Variations:
  //   - Filled background, white foreground, square shape.
  //   - Tonal background with rounded shape and extra padding.
  //   - Transparent background with a coloured outline.
  //   - High-contrast yellow background, navy icon, generous padding.
  // The grid is 2x2 inside a 660-tall container so both rows are visible at
  // once on a typical viewport.
  // ---------------------------------------------------------------------------
  Widget styleSweepCell({
    required String label,
    required Color cellAccent,
    required ButtonStyle style,
    required IconData drawerIcon,
  }) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cellAccent,
          foregroundColor: Colors.white,
          title: Text(label, style: const TextStyle(fontSize: 15)),
          actions: [
            EndDrawerButton(style: style),
          ],
        ),
        endDrawer: SizedBox(
          width: 220,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: cellAccent),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(leading: Icon(drawerIcon), title: const Text('A')),
                ListTile(leading: Icon(drawerIcon), title: const Text('B')),
                ListTile(leading: Icon(drawerIcon), title: const Text('C')),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Variant: $label',
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  final styleA = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.white),
    foregroundColor: WidgetStatePropertyAll(sweepAccent),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );

  final styleB = ButtonStyle(
    backgroundColor:
        WidgetStatePropertyAll(Colors.tealAccent.shade100),
    foregroundColor: const WidgetStatePropertyAll(Colors.black),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  final styleC = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    foregroundColor: const WidgetStatePropertyAll(Colors.white),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
    ),
  );

  final styleD = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(Color(0xFFFFD600)),
    foregroundColor: const WidgetStatePropertyAll(Color(0xFF002171)),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(14)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),
  );

  final sweepSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: sweepBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: sweepAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              '3. Style sweep (2x2)',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: sweepAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Same widget, four ButtonStyle objects. Background, foreground, '
          'padding, and shape are all individually controllable through the '
          'standard ButtonStyle API.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 660,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: styleSweepCell(
                        label: 'Filled square',
                        cellAccent: sweepAccent,
                        style: styleA,
                        drawerIcon: Icons.square,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: styleSweepCell(
                        label: 'Tonal pill',
                        cellAccent: Colors.teal,
                        style: styleB,
                        drawerIcon: Icons.bubble_chart,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: styleSweepCell(
                        label: 'Outline only',
                        cellAccent: Colors.cyan.shade800,
                        style: styleC,
                        drawerIcon: Icons.crop_square,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: styleSweepCell(
                        label: 'High contrast',
                        cellAccent: const Color(0xFF002171),
                        style: styleD,
                        drawerIcon: Icons.bolt,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 4: THEMING VIA IconButtonTheme
  // ---------------------------------------------------------------------------
  // EndDrawerButton extends IconButton (via the framework's internal
  // _ActionButton base), so the canonical way to theme a sub-tree of
  // EndDrawerButton instances is to wrap the sub-tree in IconButtonTheme.
  // Two mini-Scaffolds are placed side by side:
  //   - Left: no theme - default appearance.
  //   - Right: wrapped in IconButtonTheme(data: IconButtonThemeData(style: ...))
  //     so every descendant EndDrawerButton picks up the themed style without
  //     per-instance code.
  // We deliberately put the theme wrapper at a high level so anyone scanning
  // the source learns the standard "wrap a sub-tree" recipe.
  // ---------------------------------------------------------------------------
  final themedStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(themeAccent),
    foregroundColor: const WidgetStatePropertyAll(Colors.white),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    iconSize: const WidgetStatePropertyAll(22),
  );

  Widget themeMiniScaffold({
    required String title,
    required Color accent,
    required bool showThemeBadge,
  }) {
    return SizedBox(
      height: 280,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: accent,
            foregroundColor: Colors.white,
            title: Text(title),
            actions: const [
              EndDrawerButton(),
            ],
          ),
          endDrawer: SizedBox(
            width: 220,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: accent),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const ListTile(title: Text('Item alpha')),
                  const ListTile(title: Text('Item beta')),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showThemeBadge)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Wrapped in IconButtonTheme',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  showThemeBadge
                      ? 'The trailing button inherits its style from the '
                          'ancestor IconButtonTheme.'
                      : 'No theme - default Material 3 appearance.',
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final themeSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: themeBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.style, color: themeAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              '4. Theming via IconButtonTheme',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: themeAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'EndDrawerButton extends IconButton, so wrapping a sub-tree in '
          'IconButtonTheme(data: IconButtonThemeData(style: ...)) applies the '
          'same ButtonStyle to every descendant EndDrawerButton without '
          'mentioning the style at each call site.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: themeMiniScaffold(
                title: 'Unthemed',
                accent: Colors.deepOrange,
                showThemeBadge: false,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: IconButtonTheme(
                data: IconButtonThemeData(style: themedStyle),
                child: themeMiniScaffold(
                  title: 'Themed',
                  accent: themeAccent,
                  showThemeBadge: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: themeAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'IconButtonTheme reads its data from the nearest ancestor in the '
            'widget tree. If you place it at the MaterialApp level (or use '
            'ThemeData.iconButtonTheme) it will style every IconButton-derived '
            'widget in the entire app, including EndDrawerButton.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 5: DISABLED STATE
  // ---------------------------------------------------------------------------
  // Passing onPressed: null disables the button. The visual state matches
  // any other disabled IconButton: greyed-out icon, no ripple, no hover. Two
  // mini-Scaffolds: one enabled, one disabled, with prose between them.
  // ---------------------------------------------------------------------------
  Widget disabledMiniScaffold({
    required String title,
    required VoidCallback? onPressed,
    required String body,
  }) {
    return SizedBox(
      height: 240,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: disabledAccent,
            foregroundColor: Colors.white,
            title: Text(title),
            actions: [
              EndDrawerButton(onPressed: onPressed),
            ],
          ),
          endDrawer: SizedBox(
            width: 200,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  DrawerHeader(child: Text('Disabled section drawer')),
                  ListTile(title: Text('Only opens when enabled')),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              body,
              style: const TextStyle(fontSize: 12, height: 1.4),
            ),
          ),
        ),
      ),
    );
  }

  final disabledSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: disabledBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.block, color: disabledAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              '5. Disabled state',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: disabledAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Setting onPressed: null disables the button entirely. It greys '
          'out and stops responding to taps. Useful when the end drawer is '
          'not currently relevant - for example, while a modal blocks the '
          'screen or while a sync is in progress.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: disabledMiniScaffold(
                title: 'Enabled',
                onPressed: () {},
                body: 'Default behaviour: tap opens the end drawer.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: disabledMiniScaffold(
                title: 'Disabled',
                onPressed: null,
                body: 'onPressed: null - the button is greyed and ignores '
                    'taps. The end drawer remains accessible via swipe gesture.',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 6: DRAWERBUTTON VS ENDDRAWERBUTTON
  // ---------------------------------------------------------------------------
  // Two mini-Scaffolds side by side. The left one has a leading drawer and a
  // DrawerButton (placed in AppBar.leading via leading:). The right one has a
  // trailing endDrawer with EndDrawerButton in actions:. The point is to
  // emphasise the symmetry: the API surface and visual treatment are mirror
  // images of each other; the only differences are which slot they live in
  // and which Scaffold side they target.
  // ---------------------------------------------------------------------------
  Widget leadingDrawerScaffold() {
    return SizedBox(
      height: 280,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: symmetryAccent,
            foregroundColor: Colors.white,
            title: const Text('Leading'),
            leading: const DrawerButton(),
          ),
          drawer: SizedBox(
            width: 220,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: symmetryAccent),
                    child: const Text(
                      'Leading drawer',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.explore),
                    title: Text('Explore'),
                  ),
                ],
              ),
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'DrawerButton sits in AppBar.leading and opens the leading '
              'drawer. Same one-tap API surface as EndDrawerButton.',
              style: TextStyle(fontSize: 12, height: 1.4),
            ),
          ),
        ),
      ),
    );
  }

  Widget trailingDrawerScaffold() {
    return SizedBox(
      height: 280,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: symmetryAccent,
            foregroundColor: Colors.white,
            title: const Text('Trailing'),
            actions: const [EndDrawerButton()],
          ),
          endDrawer: SizedBox(
            width: 220,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: symmetryAccent),
                    child: const Text(
                      'End drawer',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.tune),
                    title: Text('Settings'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.filter_list),
                    title: Text('Filters'),
                  ),
                ],
              ),
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'EndDrawerButton sits in AppBar.actions and opens the trailing '
              'endDrawer. Symmetric to DrawerButton.',
              style: TextStyle(fontSize: 12, height: 1.4),
            ),
          ),
        ),
      ),
    );
  }

  final symmetrySection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: symmetryBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: symmetryAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              '6. DrawerButton vs EndDrawerButton',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: symmetryAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'These two widgets are mirror images. They expose the same '
          'parameters and behave the same way; the only difference is which '
          'side of the Scaffold they target.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: leadingDrawerScaffold()),
            const SizedBox(width: 12),
            Expanded(child: trailingDrawerScaffold()),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: symmetryAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Tip: if you build a layout that opens both a leading drawer and '
            'a trailing drawer, you can use DrawerButton in leading: and '
            'EndDrawerButton in actions: to keep the affordances consistent.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7: CUSTOM ICON / VISUAL OVERRIDES
  // ---------------------------------------------------------------------------
  // EndDrawerButton paints a fixed glyph (Icons.menu, supplied by
  // EndDrawerButtonIcon under the hood). To change the glyph entirely you
  // build a plain IconButton that calls Scaffold.maybeOf(context)?.
  // openEndDrawer() yourself - that is exactly what EndDrawerButton does
  // internally, and is the canonical "swap the glyph" recipe.
  //
  // Two demos:
  //   - Glyph override: an IconButton with Icons.menu_open_rounded that opens
  //     the end drawer manually.
  //   - Badge overlay: a real EndDrawerButton wrapped in a Stack so a small
  //     red dot sits on the top-right corner indicating unread items.
  // ---------------------------------------------------------------------------
  Widget customIconScaffold({
    required String title,
    required Widget actionWidget,
  }) {
    return SizedBox(
      height: 240,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: iconAccent,
            foregroundColor: Colors.white,
            title: Text(title),
            actions: [actionWidget],
          ),
          endDrawer: SizedBox(
            width: 220,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  DrawerHeader(child: Text('Custom icon drawer')),
                  ListTile(title: Text('Custom A')),
                  ListTile(title: Text('Custom B')),
                ],
              ),
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Action widget shown is composed at the call site.',
              style: TextStyle(fontSize: 12, height: 1.4),
            ),
          ),
        ),
      ),
    );
  }

  final iconSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: iconBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.brush, color: iconAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              '7. Custom icon and badge',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: iconAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'To swap the glyph, drop EndDrawerButton and use a plain IconButton '
          'that calls Scaffold.maybeOf(context)?.openEndDrawer() in its '
          'onPressed. Need a notification badge? Wrap the button in a Stack '
          'and paint a small dot at the top-right.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: customIconScaffold(
                title: 'Override icon',
                actionWidget: Builder(
                  builder: (innerContext) {
                    return IconButton(
                      icon: const Icon(Icons.menu_open_rounded),
                      tooltip: 'Open end drawer',
                      onPressed: () {
                        Scaffold.maybeOf(innerContext)?.openEndDrawer();
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: customIconScaffold(
                title: 'With badge',
                actionWidget: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const EndDrawerButton(),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Note: the badge is purely a layout composition, not a property '
            'of EndDrawerButton. Keeping the dot decoupled from the widget '
            'lets you reuse the same recipe for any icon button.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 8: RECIPE - "MESSAGES" MINI-APP
  // ---------------------------------------------------------------------------
  // A more realistic example: a messages list with a settings end-drawer.
  // The AppBar has a title, a search icon, and an EndDrawerButton with a
  // small unread-count indicator. The end drawer holds a few settings tiles.
  // The body is a short list of conversations.
  // ---------------------------------------------------------------------------
  final recipeSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: recipeBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.message, color: recipeAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              '8. Recipe: messages mini-app',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: recipeAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'A small messages screen. The settings end-drawer is opened via '
          'EndDrawerButton in actions. A red badge on the button hints at '
          'pending notification settings.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 480,
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: recipeAccent,
                foregroundColor: Colors.white,
                title: const Text('Messages'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const EndDrawerButton(),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.amberAccent,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                ],
              ),
              endDrawer: SizedBox(
                width: 280,
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(color: recipeAccent),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Messages settings',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '3 pending changes',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const ListTile(
                        leading: Icon(Icons.notifications_active),
                        title: Text('Notifications'),
                        subtitle: Text('All conversations'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.mark_email_unread),
                        title: Text('Read receipts'),
                        subtitle: Text('Enabled'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.color_lens),
                        title: Text('Theme'),
                        subtitle: Text('System default'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.archive),
                        title: Text('Archived chats'),
                      ),
                      const Divider(),
                      const ListTile(
                        leading: Icon(Icons.help_outline),
                        title: Text('Help & feedback'),
                      ),
                    ],
                  ),
                ),
              ),
              body: ListView(
                children: const [
                  ListTile(
                    leading: CircleAvatar(child: Text('A')),
                    title: Text('Alice'),
                    subtitle: Text('Are we still on for tomorrow?'),
                    trailing: Text('09:41'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(child: Text('B')),
                    title: Text('Bob'),
                    subtitle: Text('Sent the contract.'),
                    trailing: Text('Yest'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(child: Text('C')),
                    title: Text('Carol'),
                    subtitle: Text('Coffee on Thursday?'),
                    trailing: Text('Mon'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(child: Text('D')),
                    title: Text('Dan'),
                    subtitle: Text('Re: Q3 report draft.'),
                    trailing: Text('Sun'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(child: Text('E')),
                    title: Text('Eve'),
                    subtitle: Text('See you at the venue.'),
                    trailing: Text('Sat'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 9: REFERENCE CARD
  // ---------------------------------------------------------------------------
  // A textual quick-reference. The intent is to give the reader a single
  // place to scan for parameter names, types, and short descriptions. We
  // cover both EndDrawerButton and EndDrawerButtonThemeData.
  // ---------------------------------------------------------------------------
  Widget refRow(String name, String type, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  final referenceSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    color: refBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: refAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              '9. Reference card',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: refAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: refAccent.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EndDrawerButton',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: refAccent,
                ),
              ),
              const SizedBox(height: 8),
              refRow('key', 'Key?', 'Standard widget key.'),
              refRow('color', 'Color?',
                  'Foreground colour shorthand passed through to the IconButton.'),
              refRow('onPressed', 'VoidCallback?',
                  'Override the press handler. Default opens Scaffold.endDrawer. Pass null to disable.'),
              refRow('style', 'ButtonStyle?',
                  'Per-instance override of background, foreground, padding, shape, etc.'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: refAccent.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IconButtonThemeData (effective theme)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: refAccent,
                ),
              ),
              const SizedBox(height: 8),
              refRow('style', 'ButtonStyle?',
                  'Default ButtonStyle for descendant IconButton widgets, '
                      'including EndDrawerButton.'),
              const SizedBox(height: 8),
              const Text(
                'Provided to a sub-tree via IconButtonTheme(data: ...) or via '
                'ThemeData.iconButtonTheme at MaterialApp level.',
                style: TextStyle(fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: refAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Behaviour summary: when onPressed is omitted, EndDrawerButton '
            'looks up the nearest Scaffold via Scaffold.maybeOf(context) and '
            'calls openEndDrawer() on it. If no Scaffold is found, taps are '
            'no-ops. Setting onPressed: null disables the button. Setting '
            'onPressed to a non-null function replaces the default action.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // ROOT
  // ---------------------------------------------------------------------------
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: heroAccent),
    ),
    home: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroSection,
              defaultSection,
              sweepSection,
              themeSection,
              disabledSection,
              symmetrySection,
              iconSection,
              recipeSection,
              referenceSection,
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Text(
                  'End of EndDrawerButton deep demo.',
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: heroAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
