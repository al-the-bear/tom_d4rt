// D4rt deep demo - Material Scaffold
// ---------------------------------------------------------------------------
// Hand-authored visual deep dive into Flutter's Scaffold widget. The harness
// hosts a single `dynamic build(BuildContext context)` and renders the
// returned widget. The outermost return is a Scaffold (the page itself), and
// the page hosts many *miniature* Scaffolds inside framed 280x360 boxes so
// every Scaffold knob can be shown in isolation.
//
// Knobs surfaced in the demo:
//   appBar, body, floatingActionButton, floatingActionButtonLocation,
//   floatingActionButtonAnimator, persistentFooterButtons,
//   persistentFooterAlignment, drawer, endDrawer, bottomNavigationBar,
//   bottomSheet, backgroundColor, resizeToAvoidBottomInset, primary,
//   extendBody, extendBodyBehindAppBar, drawerScrimColor, drawerEdgeDragWidth,
//   drawerEnableOpenDragGesture, endDrawerEnableOpenDragGesture,
//   restorationId, onDrawerChanged, onEndDrawerChanged.
//
// Sections:
//   1.  Hero header (gradient, blueprint icon, title)
//   2.  Anatomy diagram (annotated drawing of a Scaffold)
//   3.  Mini-Scaffold catalog (Basic / Tabs / Bottom Nav / Drawer)
//   4.  FAB locations grid (3x3 of FloatingActionButtonLocation constants)
//   5.  extendBody / extendBodyBehindAppBar combinations (4 mini-Scaffolds)
//   6.  persistentFooterButtons and persistentFooterAlignment showcase
//   7.  bottomSheet showcase
//   8.  drawerScrimColor / drawerEdgeDragWidth diagram
//   9.  Real-world examples (dashboard / settings / chat / profile)
//   10. Comparison panel (Scaffold vs CupertinoPageScaffold vs Material)
//   11. Caveats (5 cards)
//   12. Footer takeaways
//
// Authoring rules followed:
//   - Single file, single import: package:flutter/material.dart
//   - No print / await / Future / Timer / setState / StatefulWidget /
//     AnimationController.
//   - `child` / `children` always appear last.
//   - Color.withValues(alpha: ...) is used in place of withOpacity.
//   - No `// ignore:` directives. No leading-underscore *locals*.
//   - `const` is applied wherever possible.
//   - Nested mini-Scaffolds sit inside MediaQuery + Material + ClipRect +
//     SizedBox(width: 280, height: 360) so the harness layout never fights
//     them.
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ---------------------------------------------------------------------------
// Palette - deep blue / cyan blueprint feel.
// ---------------------------------------------------------------------------
const Color kInk = Color(0xFF0A1F44);
const Color kDeepBlue = Color(0xFF103A8E);
const Color kMidBlue = Color(0xFF1E5AA8);
const Color kCyan = Color(0xFF00B8D4);
const Color kSky = Color(0xFFB3E5FC);
const Color kPaper = Color(0xFFF4F8FC);
const Color kPaperAlt = Color(0xFFE7EEF7);
const Color kAccent = Color(0xFFFFB300);
const Color kBorder = Color(0xFFB0BEC5);

// ===========================================================================
// build(BuildContext) - top-level entry point invoked by the test harness.
// ===========================================================================
dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kPaper,
    appBar: AppBar(
      backgroundColor: kInk,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 20,
      title: const Text(
        'Scaffold - Deep Demo',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    ),
    body: const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeroHeader(),
          SizedBox(height: 28),
          AnatomySection(),
          SizedBox(height: 28),
          MiniScaffoldCatalogSection(),
          SizedBox(height: 28),
          FabLocationsSection(),
          SizedBox(height: 28),
          ExtendBodySection(),
          SizedBox(height: 28),
          PersistentFooterSection(),
          SizedBox(height: 28),
          BottomSheetSection(),
          SizedBox(height: 28),
          DrawerScrimSection(),
          SizedBox(height: 28),
          RealWorldSection(),
          SizedBox(height: 28),
          ComparisonSection(),
          SizedBox(height: 28),
          CaveatsSection(),
          SizedBox(height: 28),
          FooterSection(),
          SizedBox(height: 32),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Re-usable section header.
// ===========================================================================
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.accent,
    required this.number,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final Color accent;
  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: Color(0xFF455A64),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Re-usable card frame for a 280x360 mini-Scaffold preview.
// ===========================================================================
class MiniFrame extends StatelessWidget {
  const MiniFrame({
    required this.label,
    required this.note,
    required this.scaffold,
    super.key,
  });

  final String label;
  final String note;
  final Widget scaffold;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: kDeepBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          ClipRect(
            child: SizedBox(
              width: 280,
              height: 360,
              child: MediaQuery(
                data: const MediaQueryData(
                  size: Size(280, 360),
                  padding: EdgeInsets.zero,
                  viewInsets: EdgeInsets.zero,
                  viewPadding: EdgeInsets.zero,
                ),
                child: Material(
                  type: MaterialType.canvas,
                  color: Colors.white,
                  child: scaffold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Text(
              note,
              style: const TextStyle(
                color: Color(0xFF37474F),
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 1 - Hero header.
// ===========================================================================
class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kDeepBlue, kMidBlue, kCyan],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 84,
            height: 84,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.45),
                width: 1.4,
              ),
            ),
            child: const Icon(
              Icons.dashboard_customize_outlined,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 22),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scaffold',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'The blueprint of every Material page.',
                  style: TextStyle(
                    color: Color(0xCCFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'AppBar - Body - FAB - BottomNav - Drawer - Sheet - Footer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2 - Anatomy diagram.
// ===========================================================================
class AnatomySection extends StatelessWidget {
  const AnatomySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: kDeepBlue,
          number: '02',
          title: 'Anatomy of a Scaffold',
          subtitle:
              'Every slot in the Scaffold constructor maps to a region of '
              'the rendered surface. The diagram below labels them.',
        ),
        AnatomyDiagram(),
      ],
    );
  }
}

class AnatomyDiagram extends StatelessWidget {
  const AnatomyDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top row: appBar + endDrawer label
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    color: kDeepBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'appBar  -> AppBar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Middle: drawer | body+bottomSheet | endDrawer
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kSky.withValues(alpha: 0.7),
                    border: Border.all(color: kBorder),
                  ),
                  child: const RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'drawer',
                      style: TextStyle(
                        color: kInk,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: kPaperAlt,
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'body',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: kInk,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Your scrollable content lives here.\n'
                            'Often a CustomScrollView or a ListView.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF455A64),
                              fontSize: 12,
                              height: 1.35,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          bottom: 70,
                          child: Container(
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: kAccent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x44000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Positioned(
                          right: 64,
                          bottom: 78,
                          child: Text(
                            'floatingActionButton',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: kInk,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 8,
                          child: Container(
                            height: 44,
                            decoration: const BoxDecoration(
                              color: kCyan,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'bottomSheet  ->  Container / BottomSheet',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kSky.withValues(alpha: 0.7),
                    border: Border.all(color: kBorder),
                  ),
                  child: const RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      'endDrawer',
                      style: TextStyle(
                        color: kInk,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // persistentFooterButtons row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: kPaper,
              border: Border.all(color: kBorder),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'persistentFooterButtons:',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: kInk,
                  ),
                ),
                SizedBox(width: 8),
                FooterButtonChip(label: 'Cancel'),
                SizedBox(width: 6),
                FooterButtonChip(label: 'OK'),
              ],
            ),
          ),
          // bottomNavigationBar
          Container(
            height: 50,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: const Text(
              'bottomNavigationBar  ->  NavigationBar / BottomNavigationBar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FooterButtonChip extends StatelessWidget {
  const FooterButtonChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: kDeepBlue),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: kDeepBlue,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 3 - Mini-Scaffold catalog.
// ===========================================================================
class MiniScaffoldCatalogSection extends StatelessWidget {
  const MiniScaffoldCatalogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: kMidBlue,
          number: '03',
          title: 'Mini-Scaffold catalog',
          subtitle:
              'Four canonical Scaffold layouts rendered as nested mini-'
              'Scaffolds. Each frame is 280x360 with its own MediaQuery.',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MiniFrame(
                label: 'Basic',
                note: 'appBar + body + floatingActionButton',
                scaffold: BasicMiniScaffold(),
              ),
              SizedBox(width: 16),
              MiniFrame(
                label: 'Tabs',
                note: 'TabBar in appBar.bottom + TabBarView body',
                scaffold: TabsMiniScaffold(),
              ),
              SizedBox(width: 16),
              MiniFrame(
                label: 'Bottom Nav',
                note: 'NavigationBar at bottomNavigationBar',
                scaffold: BottomNavMiniScaffold(),
              ),
              SizedBox(width: 16),
              MiniFrame(
                label: 'Drawer',
                note: 'Drawer attached. Closed in this preview.',
                scaffold: DrawerMiniScaffold(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BasicMiniScaffold extends StatelessWidget {
  const BasicMiniScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      appBar: AppBar(
        backgroundColor: kDeepBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Inbox',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'A body full of plain content. The FAB sits at the default '
            'endFloat position.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: kInk, height: 1.4),
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: kAccent,
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}

class TabsMiniScaffold extends StatelessWidget {
  const TabsMiniScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kPaper,
        appBar: AppBar(
          backgroundColor: kMidBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Mail',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          bottom: const TabBar(
            indicatorColor: kAccent,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xCCFFFFFF),
            tabs: [
              Tab(text: 'Inbox', icon: Icon(Icons.inbox, size: 16)),
              Tab(text: 'Sent', icon: Icon(Icons.send, size: 16)),
              Tab(text: 'Spam', icon: Icon(Icons.warning, size: 16)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Inbox', style: TextStyle(color: kInk))),
            Center(child: Text('Sent', style: TextStyle(color: kInk))),
            Center(child: Text('Spam', style: TextStyle(color: kInk))),
          ],
        ),
      ),
    );
  }
}

class BottomNavMiniScaffold extends StatelessWidget {
  const BottomNavMiniScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      appBar: AppBar(
        backgroundColor: kCyan,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Explore',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Three destinations on a NavigationBar at the bottom.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: kInk, height: 1.4),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 56,
        selectedIndex: 1,
        backgroundColor: Colors.white,
        indicatorColor: kSky,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DrawerMiniScaffold extends StatelessWidget {
  const DrawerMiniScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      appBar: AppBar(
        backgroundColor: kInk,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      drawer: const Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: kInk,
                  ),
                ),
                SizedBox(height: 8),
                Text('Account', style: TextStyle(color: kInk)),
                Text('Privacy', style: TextStyle(color: kInk)),
                Text('About', style: TextStyle(color: kInk)),
              ],
            ),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.menu, color: kInk),
            SizedBox(height: 8),
            Text(
              'Tap the hamburger to open the drawer.\n'
              'A Drawer is *attached* even when not visible.',
              style: TextStyle(fontSize: 12, color: kInk, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 4 - FAB locations grid.
// ===========================================================================
class FabLocationsSection extends StatelessWidget {
  const FabLocationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: kCyan,
          number: '04',
          title: 'FloatingActionButtonLocation grid',
          subtitle:
              'Nine of the most common location constants. Each rendered '
              'as a mini-Scaffold so you can compare offsets directly.',
        ),
        FabLocationsGrid(),
      ],
    );
  }
}

class FabLocationsGrid extends StatelessWidget {
  const FabLocationsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        FabLocationCell(
          name: 'centerFloat',
          location: FloatingActionButtonLocation.centerFloat,
        ),
        FabLocationCell(
          name: 'endFloat',
          location: FloatingActionButtonLocation.endFloat,
        ),
        FabLocationCell(
          name: 'startFloat',
          location: FloatingActionButtonLocation.startFloat,
        ),
        FabLocationCell(
          name: 'centerTop',
          location: FloatingActionButtonLocation.centerTop,
        ),
        FabLocationCell(
          name: 'endTop',
          location: FloatingActionButtonLocation.endTop,
        ),
        FabLocationCell(
          name: 'startTop',
          location: FloatingActionButtonLocation.startTop,
        ),
        FabLocationCell(
          name: 'centerDocked',
          location: FloatingActionButtonLocation.centerDocked,
          docked: true,
        ),
        FabLocationCell(
          name: 'endDocked',
          location: FloatingActionButtonLocation.endDocked,
          docked: true,
        ),
        FabLocationCell(
          name: 'miniCenterFloat',
          location: FloatingActionButtonLocation.miniCenterFloat,
        ),
      ],
    );
  }
}

class FabLocationCell extends StatelessWidget {
  const FabLocationCell({
    required this.name,
    required this.location,
    this.docked = false,
    super.key,
  });

  final String name;
  final FloatingActionButtonLocation location;
  final bool docked;

  @override
  Widget build(BuildContext context) {
    return MiniFrame(
      label: name,
      note: docked
          ? 'Docked on the bottomAppBar notch.'
          : 'Floating in the body region.',
      scaffold: Scaffold(
        backgroundColor: kPaper,
        appBar: AppBar(
          backgroundColor: kDeepBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            name,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'FAB at $name',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: kInk),
            ),
          ),
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          backgroundColor: kAccent,
          child: Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: location,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        bottomNavigationBar: docked
            ? const BottomAppBar(
                color: kInk,
                shape: CircularNotchedRectangle(),
                child: SizedBox(height: 36),
              )
            : null,
      ),
    );
  }
}

// ===========================================================================
// SECTION 5 - extendBody / extendBodyBehindAppBar.
// ===========================================================================
class ExtendBodySection extends StatelessWidget {
  const ExtendBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: Color(0xFF00838F),
          number: '05',
          title: 'extendBody and extendBodyBehindAppBar',
          subtitle:
              'Both flags default to false. Toggling them lets the body '
              'paint *under* the bottom navigation bar and AppBar so '
              'translucent bars look right.',
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ExtendBodyCell(
              extendBody: false,
              extendBodyBehindAppBar: false,
              caption: '(false, false) - default',
            ),
            ExtendBodyCell(
              extendBody: true,
              extendBodyBehindAppBar: false,
              caption: '(true, false) - body under navbar',
            ),
            ExtendBodyCell(
              extendBody: false,
              extendBodyBehindAppBar: true,
              caption: '(false, true) - body under appBar',
            ),
            ExtendBodyCell(
              extendBody: true,
              extendBodyBehindAppBar: true,
              caption: '(true, true) - both extended',
            ),
          ],
        ),
      ],
    );
  }
}

class ExtendBodyCell extends StatelessWidget {
  const ExtendBodyCell({
    required this.extendBody,
    required this.extendBodyBehindAppBar,
    required this.caption,
    super.key,
  });

  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return MiniFrame(
      label: caption,
      note:
          'extendBody=$extendBody  /  extendBodyBehindAppBar='
          '$extendBodyBehindAppBar',
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: AppBar(
          backgroundColor: kDeepBlue.withValues(alpha: 0.6),
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Translucent',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kSky, kAccent],
            ),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Tinted body so we can\nsee whether the bars\nlet color leak.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kInk,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 48,
          color: kInk.withValues(alpha: 0.6),
          alignment: Alignment.center,
          child: const Text(
            'translucent bottom bar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 6 - persistentFooterButtons / persistentFooterAlignment.
// ===========================================================================
class PersistentFooterSection extends StatelessWidget {
  const PersistentFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: Color(0xFF6A1B9A),
          number: '06',
          title: 'persistentFooterButtons + alignment',
          subtitle:
              'Buttons that always stick to the bottom of the body, above '
              'the bottomNavigationBar. Their alignment is configurable '
              'with persistentFooterAlignment.',
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            PersistentFooterCell(
              alignment: AlignmentDirectional.centerEnd,
              caption: 'centerEnd (default)',
            ),
            PersistentFooterCell(
              alignment: AlignmentDirectional.center,
              caption: 'center',
            ),
            PersistentFooterCell(
              alignment: AlignmentDirectional.centerStart,
              caption: 'centerStart',
            ),
          ],
        ),
      ],
    );
  }
}

class PersistentFooterCell extends StatelessWidget {
  const PersistentFooterCell({
    required this.alignment,
    required this.caption,
    super.key,
  });

  final AlignmentDirectional alignment;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return MiniFrame(
      label: caption,
      note:
          'Three OutlinedButtons in persistentFooterButtons with the '
          'given alignment.',
      scaffold: Scaffold(
        backgroundColor: kPaper,
        appBar: AppBar(
          backgroundColor: kDeepBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Wizard step 2 / 3',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirm details',
                style: TextStyle(
                  color: kInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'persistentFooterButtons stay glued to the bottom of the '
                'body so the user always sees the action row.',
                style: TextStyle(
                  color: Color(0xFF455A64),
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        persistentFooterAlignment: alignment,
        persistentFooterButtons: const [
          OutlinedButton(onPressed: null, child: Text('Back')),
          OutlinedButton(onPressed: null, child: Text('Skip')),
          OutlinedButton(onPressed: null, child: Text('Next')),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7 - bottomSheet showcase.
// ===========================================================================
class BottomSheetSection extends StatelessWidget {
  const BottomSheetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: Color(0xFF2E7D32),
          number: '07',
          title: 'bottomSheet (persistent)',
          subtitle:
              'Unlike showModalBottomSheet, the Scaffold.bottomSheet slot '
              'pins a sheet to the bottom of the body permanently.',
        ),
        BottomSheetShowcase(),
      ],
    );
  }
}

class BottomSheetShowcase extends StatelessWidget {
  const BottomSheetShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MiniFrame(
          label: 'persistent bottomSheet',
          note:
              'The sheet is just a Container with rounded top corners '
              'parked in scaffold.bottomSheet.',
          scaffold: BottomSheetMiniScaffold(),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kBorder),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'When to reach for it',
                  style: TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                BulletLine(
                  text: 'Now Playing bars in music apps.',
                ),
                BulletLine(
                  text: 'Persistent disclaimer footers.',
                ),
                BulletLine(
                  text: 'Inline form drafts that should always be '
                      'visible.',
                ),
                SizedBox(height: 8),
                Text(
                  'For one-off, dismissible sheets, prefer '
                  'showModalBottomSheet or showBottomSheet instead.',
                  style: TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BottomSheetMiniScaffold extends StatelessWidget {
  const BottomSheetMiniScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      appBar: AppBar(
        backgroundColor: kDeepBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Now playing',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(14),
        child: Text(
          'Any content in the body. The sheet is anchored below.',
          style: TextStyle(fontSize: 12, color: kInk, height: 1.4),
        ),
      ),
      bottomSheet: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(
          color: kInk,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.album, color: kAccent, size: 32),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Persistent sheet',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Stays here until removed.',
                    style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 11),
                  ),
                ],
              ),
            ),
            Icon(Icons.play_arrow, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class BulletLine extends StatelessWidget {
  const BulletLine({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 6, color: kDeepBlue),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF263238),
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 8 - drawerScrimColor / drawerEdgeDragWidth diagram.
// ===========================================================================
class DrawerScrimSection extends StatelessWidget {
  const DrawerScrimSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: Color(0xFFAD1457),
          number: '08',
          title: 'drawerScrimColor and drawerEdgeDragWidth',
          subtitle:
              'The scrim is the dim layer over the body when a drawer is '
              'open. drawerEdgeDragWidth defines the thickness of the '
              'gesture region at the screen edge that opens the drawer.',
        ),
        DrawerScrimDiagram(),
      ],
    );
  }
}

class DrawerScrimDiagram extends StatelessWidget {
  const DrawerScrimDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 220,
            height: 320,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPaper,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kBorder),
                    ),
                  ),
                ),
                // The drawer (open, half-width).
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 130,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 12,
                          offset: Offset(2, 0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Drawer',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: kInk,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '- Account',
                          style: TextStyle(color: kInk, fontSize: 12),
                        ),
                        Text(
                          '- Privacy',
                          style: TextStyle(color: kInk, fontSize: 12),
                        ),
                        Text(
                          '- About',
                          style: TextStyle(color: kInk, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                // The scrim over the still-visible body.
                Positioned(
                  left: 130,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kInk.withValues(alpha: 0.55),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'scrim\n(drawerScrimColor)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                // Edge drag width band.
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 18,
                  child: Container(
                    color: kAccent.withValues(alpha: 0.4),
                  ),
                ),
                const Positioned(
                  left: 22,
                  top: 6,
                  child: Text(
                    'drag\nedge',
                    style: TextStyle(
                      color: kInk,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'drawerScrimColor',
                  style: TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Color used to dim the body while the drawer is open. '
                  'Defaults to a translucent black; usually fine to leave '
                  'alone.',
                  style: TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'drawerEdgeDragWidth',
                  style: TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Width of the screen-edge gesture region that opens the '
                  'drawer when the user drags from the edge. Set to a '
                  'larger value on devices with system back gestures so '
                  'they coexist.',
                  style: TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'drawerEnableOpenDragGesture',
                  style: TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'If false, the drawer can only be opened programmatically '
                  '(via Scaffold.of(context).openDrawer()). The same flag '
                  'exists for the end drawer.',
                  style: TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 9 - Real-world examples.
// ===========================================================================
class RealWorldSection extends StatelessWidget {
  const RealWorldSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: Color(0xFF455A64),
          number: '09',
          title: 'Real-world Scaffold layouts',
          subtitle:
              'Four product-flavored mini-Scaffolds: dashboard, settings, '
              'chat, profile. Each combines several of the slots covered '
              'above into a coherent surface.',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MiniFrame(
                label: 'Dashboard',
                note: 'AppBar + KPI cards + NavigationBar',
                scaffold: DashboardScaffold(),
              ),
              SizedBox(width: 16),
              MiniFrame(
                label: 'Settings',
                note: 'AppBar + ListView + endDrawer hint',
                scaffold: SettingsScaffold(),
              ),
              SizedBox(width: 16),
              MiniFrame(
                label: 'Chat',
                note: 'AppBar + message list + bottomSheet input',
                scaffold: ChatScaffold(),
              ),
              SizedBox(width: 16),
              MiniFrame(
                label: 'Profile',
                note: 'Translucent AppBar + extendBodyBehindAppBar',
                scaffold: ProfileScaffold(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      appBar: AppBar(
        backgroundColor: kInk,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Overview',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          KpiCard(label: 'Active users', value: '12.4k', delta: '+3.1%'),
          SizedBox(height: 8),
          KpiCard(label: 'Revenue', value: '\$48.2k', delta: '+1.8%'),
          SizedBox(height: 8),
          KpiCard(label: 'Errors', value: '17', delta: '-22%'),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 56,
        backgroundColor: Colors.white,
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class KpiCard extends StatelessWidget {
  const KpiCard({
    required this.label,
    required this.value,
    required this.delta,
    super.key,
  });

  final String label;
  final String value;
  final String delta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: kInk,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Text(
            delta,
            style: const TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScaffold extends StatelessWidget {
  const SettingsScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      appBar: AppBar(
        backgroundColor: kDeepBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      endDrawer: const Drawer(child: Center(child: Text('Filter panel'))),
      body: ListView(
        children: const [
          SettingsTile(icon: Icons.person_outline, label: 'Account'),
          SettingsTile(icon: Icons.notifications_outlined, label: 'Alerts'),
          SettingsTile(icon: Icons.lock_outline, label: 'Privacy'),
          SettingsTile(icon: Icons.color_lens_outlined, label: 'Appearance'),
          SettingsTile(icon: Icons.help_outline, label: 'Help'),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({required this.icon, required this.label, super.key});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kDeepBlue),
      title: Text(
        label,
        style: const TextStyle(fontSize: 13, color: kInk),
      ),
      trailing: const Icon(Icons.chevron_right, color: kBorder),
      dense: true,
    );
  }
}

class ChatScaffold extends StatelessWidget {
  const ChatScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      appBar: AppBar(
        backgroundColor: kCyan,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Eli',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: const [
          ChatBubble(text: 'Hey - did you push the patch?', mine: false),
          ChatBubble(text: 'Yep. Just merged it.', mine: true),
          ChatBubble(text: 'Nice. CI was angry yesterday.', mine: false),
          ChatBubble(text: 'It was the analyzer cache.', mine: true),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: Colors.white,
        child: const Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Message',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.send, color: kDeepBlue),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.text, required this.mine, super.key});

  final String text;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 200),
        decoration: BoxDecoration(
          color: mine ? kDeepBlue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kBorder),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: mine ? Colors.white : kInk,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class ProfileScaffold extends StatelessWidget {
  const ProfileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kDeepBlue, kCyan],
          ),
        ),
        child: const SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: kDeepBlue),
              ),
              SizedBox(height: 8),
              Text(
                'Alex K.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '@alex',
                style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 12),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'extendBodyBehindAppBar=true so the gradient slides under '
                  'the translucent AppBar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 10 - Comparison panel.
// ===========================================================================
class ComparisonSection extends StatelessWidget {
  const ComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: Color(0xFFE65100),
          number: '10',
          title: 'Scaffold vs CupertinoPageScaffold vs Material',
          subtitle:
              'When to choose which surface widget. They overlap a lot but '
              'each has a different contract with the rest of the framework.',
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ComparisonCard(
              title: 'Scaffold (material)',
              tagColor: kDeepBlue,
              points: [
                'Slots for AppBar, FAB, drawer, bottomSheet, nav bar.',
                'Tied to ScaffoldMessenger for SnackBars and Banners.',
                'Default surface for Material Design apps.',
              ],
              demo: ScaffoldDemoChip(),
            ),
            ComparisonCard(
              title: 'CupertinoPageScaffold',
              tagColor: Color(0xFF8E24AA),
              points: [
                'iOS look-and-feel via CupertinoNavigationBar.',
                'No drawer / FAB / bottomSheet slots.',
                'Combines with CupertinoTabScaffold for tabs.',
              ],
              demo: CupertinoDemoChip(),
            ),
            ComparisonCard(
              title: 'Material (raw surface)',
              tagColor: Color(0xFF00897B),
              points: [
                'Just a Material surface; no chrome.',
                'Use for cards, sheets, custom surfaces.',
                'Pair with PreferredSize for custom AppBar slots.',
              ],
              demo: MaterialDemoChip(),
            ),
          ],
        ),
      ],
    );
  }
}

class ComparisonCard extends StatelessWidget {
  const ComparisonCard({
    required this.title,
    required this.tagColor,
    required this.points,
    required this.demo,
    super.key,
  });

  final String title;
  final Color tagColor;
  final List<String> points;
  final Widget demo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final p in points) BulletLine(text: p),
          const SizedBox(height: 10),
          demo,
        ],
      ),
    );
  }
}

class ScaffoldDemoChip extends StatelessWidget {
  const ScaffoldDemoChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 18,
            color: kDeepBlue,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: const Text(
              'AppBar',
              style: TextStyle(color: Colors.white, fontSize: 9),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Body',
                style: TextStyle(color: kInk, fontSize: 10),
              ),
            ),
          ),
          Container(
            height: 14,
            color: kInk,
            alignment: Alignment.center,
            child: const Text(
              'NavBar',
              style: TextStyle(color: Colors.white, fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}

class CupertinoDemoChip extends StatelessWidget {
  const CupertinoDemoChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 22,
            color: const Color(0xFFEDEDED),
            alignment: Alignment.center,
            child: const Text(
              'CupertinoNavigationBar',
              style: TextStyle(
                color: CupertinoColors.activeBlue,
                fontSize: 9,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Body',
                style: TextStyle(color: kInk, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialDemoChip extends StatelessWidget {
  const MaterialDemoChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        'Material(child: ...)',
        style: TextStyle(
          color: kInk,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 11 - Caveats.
// ===========================================================================
class CaveatsSection extends StatelessWidget {
  const CaveatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SectionHeader(
          accent: Color(0xFFC62828),
          number: '11',
          title: 'Caveats and edge cases',
          subtitle:
              'Five things that bite Scaffold users. Each is independent '
              'of the others.',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            CaveatCard(
              icon: Icons.layers_outlined,
              title: 'Nested Scaffolds inherit MediaQuery',
              body:
                  'Wrap an inner Scaffold in MediaQuery if you want it to '
                  'compute its own padding. Otherwise it inherits the '
                  'parent SafeArea twice and over-pads.',
            ),
            CaveatCard(
              icon: Icons.menu_open,
              title: 'Drawer state via Scaffold.of',
              body:
                  'Open a drawer with Scaffold.of(context).openDrawer(). '
                  'The context must be *inside* the Scaffold, not the same '
                  'one that built it - use a Builder if necessary.',
            ),
            CaveatCard(
              icon: Icons.animation,
              title: 'FAB animations',
              body:
                  'floatingActionButtonAnimator drives the in/out and '
                  'reposition motion. The default animator scales; use '
                  'NoScalingAnimation for instant placement.',
            ),
            CaveatCard(
              icon: Icons.keyboard_outlined,
              title: 'resizeToAvoidBottomInset',
              body:
                  'When the keyboard appears, the body shrinks by default. '
                  'Set resizeToAvoidBottomInset=false for full-bleed '
                  'pages (maps, video) where the keyboard should overlap '
                  'instead.',
            ),
            CaveatCard(
              icon: Icons.history,
              title: 'restorationId semantics',
              body:
                  'Setting restorationId enables state restoration of the '
                  'drawer / endDrawer / bottomSheet across process death. '
                  'It does *not* restore the body content - that is your '
                  'job.',
            ),
          ],
        ),
      ],
    );
  }
}

class CaveatCard extends StatelessWidget {
  const CaveatCard({
    required this.icon,
    required this.title,
    required this.body,
    super.key,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kDeepBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: kDeepBlue, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFF455A64),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 12 - Footer takeaways.
// ===========================================================================
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kInk, kDeepBlue],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Takeaways',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          FooterTakeaway(
            text: 'Scaffold is a layout contract: each named slot has '
                'a defined region, padding rule, and z-order.',
          ),
          FooterTakeaway(
            text: 'Use extendBody / extendBodyBehindAppBar for translucent '
                'bars, never to push the body around.',
          ),
          FooterTakeaway(
            text: 'persistentFooterButtons is the right place for wizard '
                'navigation; bottomSheet is for always-on chrome.',
          ),
          FooterTakeaway(
            text: 'Drawer state lives on Scaffold.of(context). Pass a '
                'restorationId if you want it to survive process death.',
          ),
          FooterTakeaway(
            text: 'For non-Material surfaces or full-bleed pages, drop '
                'down to Material or CupertinoPageScaffold instead.',
          ),
        ],
      ),
    );
  }
}

class FooterTakeaway extends StatelessWidget {
  const FooterTakeaway({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.check_circle, color: kCyan, size: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xEEFFFFFF),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
