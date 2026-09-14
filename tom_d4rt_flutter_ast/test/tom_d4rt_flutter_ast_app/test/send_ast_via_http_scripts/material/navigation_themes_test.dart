// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Material 3 Nav Surface Atelier
// Theme: "Material 3 Nav Surface Atelier" - a hand-crafted gallery showcasing
// the navigation theming family (NavigationBarTheme, NavigationRailTheme,
// NavigationDrawerTheme, BottomNavigationBarTheme, TabBarTheme, AppBarTheme)
// rendered as a single scroll of recipe cards, palette swatches and side-by-side
// comparison grids.
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE TOKENS
// ============================================================================

const Color _atelierInk = Color(0xFF0F1226);
const Color _atelierSlate = Color(0xFF1B2040);
const Color _atelierMist = Color(0xFFF4F6FF);
const Color _atelierPaper = Color(0xFFFAFBFF);
const Color _atelierLine = Color(0xFFCFD3E8);
const Color _atelierSubtle = Color(0xFF5B6086);

const Color _sec1Primary = Color(0xFF5B4DFF); // NavigationBar - indigo
const Color _sec1Accent = Color(0xFFB7B0FF);
const Color _sec1Surface = Color(0xFFEDEBFF);

const Color _sec2Primary = Color(0xFFE0476A); // NavigationRail - rose
const Color _sec2Accent = Color(0xFFFFB7C5);
const Color _sec2Surface = Color(0xFFFFE7EC);

const Color _sec3Primary = Color(0xFF1E8C7B); // NavigationDrawer - teal
const Color _sec3Accent = Color(0xFF9BD8CD);
const Color _sec3Surface = Color(0xFFDFF3EF);

const Color _sec4Primary = Color(0xFFE07A1F); // BottomNavigationBar - amber
const Color _sec4Accent = Color(0xFFFFD49C);
const Color _sec4Surface = Color(0xFFFFF1DF);

const Color _sec5Primary = Color(0xFF4067C9); // TabBar - cobalt
const Color _sec5Accent = Color(0xFFA9C2F1);
const Color _sec5Surface = Color(0xFFE2ECFE);

const Color _sec6Primary = Color(0xFF7A3CC8); // AppBar - violet
const Color _sec6Accent = Color(0xFFD4B8F2);
const Color _sec6Surface = Color(0xFFEEE3FA);

const Color _sec7Primary = Color(0xFF2A3145); // Light vs dark - graphite
const Color _sec7Accent = Color(0xFF9AA1BD);
const Color _sec7Surface = Color(0xFFE5E8F4);

const Color _sec8Primary = Color(0xFF137287); // Comparison grid - lagoon
const Color _sec8Accent = Color(0xFFA0D8E1);
const Color _sec8Surface = Color(0xFFDDF1F5);

// ============================================================================
// SHARED VISUAL HELPERS
// ============================================================================

Widget _gap(double h) => SizedBox(height: h);
Widget _wgap(double w) => SizedBox(width: w);

Widget _label(String text, {Color color = _atelierInk, double size = 12.0, FontWeight weight = FontWeight.w600, double letter = 0.4}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      letterSpacing: letter,
    ),
  );
}

Widget _heading(String text, {Color color = _atelierInk, double size = 22.0}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.2,
    ),
  );
}

Widget _body(String text, {Color color = _atelierSubtle, double size = 13.0, double height = 1.45}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget _swatch(Color c, String name) {
  return Container(
    margin: const EdgeInsets.only(right: 12.0),
    width: 84.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 44.0,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _atelierLine, width: 1.0),
          ),
        ),
        _gap(6.0),
        _label(name, size: 10.5, weight: FontWeight.w700, letter: 0.6, color: _atelierSlate),
      ],
    ),
  );
}

Widget _palette(List<List<dynamic>> entries) {
  final List<Widget> chips = <Widget>[];
  for (final List<dynamic> row in entries) {
    chips.add(_swatch(row[0] as Color, row[1] as String));
  }
  return Row(children: chips);
}

Widget _sectionBanner({
  required int number,
  required String title,
  required String subtitle,
  required Color primary,
  required Color accent,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 14.0),
    padding: const EdgeInsets.fromLTRB(22.0, 18.0, 22.0, 20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[primary, accent],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: primary.withOpacity(0.25),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Colors.white.withOpacity(0.45), width: 1.2),
          ),
          alignment: Alignment.center,
          child: Text(
            number.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        _wgap(16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              _gap(4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: 12.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String title,
  required List<String> bullets,
  required Color accent,
}) {
  final List<Widget> lines = <Widget>[];
  for (final String b in bullets) {
    lines.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6.0, right: 10.0),
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(child: _body(b, color: _atelierSlate, size: 12.5, height: 1.5)),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.only(top: 14.0),
    padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 14.0),
    decoration: BoxDecoration(
      color: _atelierPaper,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _atelierLine, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.menu_book_rounded, size: 16.0, color: Colors.white),
            ),
            _wgap(10.0),
            _heading('Recipe — $title', size: 14.5, color: _atelierInk),
          ],
        ),
        _gap(10.0),
        ...lines,
      ],
    ),
  );
}

Widget _kvTable(String caption, List<List<String>> rows, Color accent) {
  final List<TableRow> tableRows = <TableRow>[];
  tableRows.add(
    TableRow(
      decoration: BoxDecoration(color: accent.withOpacity(0.18)),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: _label('Property', size: 11.5, weight: FontWeight.w800, color: _atelierInk),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: _label('Value', size: 11.5, weight: FontWeight.w800, color: _atelierInk),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: _label('Effect', size: 11.5, weight: FontWeight.w800, color: _atelierInk),
        ),
      ],
    ),
  );
  for (int i = 0; i < rows.length; i++) {
    final List<String> r = rows[i];
    tableRows.add(
      TableRow(
        decoration: BoxDecoration(
          color: i.isEven ? _atelierPaper : _atelierMist,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            child: Text(r[0], style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: _atelierInk)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            child: Text(r[1], style: const TextStyle(fontSize: 11.5, color: _atelierSlate)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            child: Text(r[2], style: const TextStyle(fontSize: 11.5, color: _atelierSubtle, height: 1.35)),
          ),
        ],
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.only(top: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _atelierLine, width: 1.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          color: _atelierSlate,
          child: _label(caption, color: Colors.white, size: 12.0, weight: FontWeight.w700, letter: 0.6),
        ),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.3),
            1: FlexColumnWidth(1.3),
            2: FlexColumnWidth(2.4),
          },
          children: tableRows,
        ),
      ],
    ),
  );
}

Widget _section({
  required int number,
  required String title,
  required String subtitle,
  required Color primary,
  required Color accent,
  required Color surface,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 22.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionBanner(
          number: number,
          title: title,
          subtitle: subtitle,
          primary: primary,
          accent: accent,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: _atelierLine, width: 1.0),
          ),
          child: child,
        ),
      ],
    ),
  );
}

// ============================================================================
// HERO HEADER
// ============================================================================

Widget _hero() {
  return Container(
    padding: const EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 32.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_atelierInk, _atelierSlate, _sec1Primary],
        stops: <double>[0.0, 0.55, 1.0],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 46.0,
              height: 46.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.dashboard_customize_rounded, size: 22.0, color: Colors.white),
            ),
            _wgap(14.0),
            const Text(
              'MATERIAL 3 — NAV SURFACE ATELIER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                letterSpacing: 2.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        _gap(18.0),
        const Text(
          'Theming the Navigation Family',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.2,
            height: 1.1,
          ),
        ),
        _gap(10.0),
        Text(
          'A hand-curated walkthrough of NavigationBarTheme, NavigationRailTheme, '
          'NavigationDrawerTheme, BottomNavigationBarTheme, TabBarTheme and AppBarTheme. '
          'Every section pairs a real demo, a palette card, a recipe and a property table.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.86),
            fontSize: 14.0,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        _gap(22.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _heroTag('NavigationBarTheme', _sec1Accent),
            _heroTag('NavigationRailTheme', _sec2Accent),
            _heroTag('NavigationDrawerTheme', _sec3Accent),
            _heroTag('BottomNavigationBarTheme', _sec4Accent),
            _heroTag('TabBarTheme', _sec5Accent),
            _heroTag('AppBarTheme', _sec6Accent),
          ],
        ),
      ],
    ),
  );
}

Widget _heroTag(String text, Color tone) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.12),
      borderRadius: BorderRadius.circular(99.0),
      border: Border.all(color: tone, width: 1.2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
        ),
        _wgap(8.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// CONCEPT OVERVIEW
// ============================================================================

Widget _overview() {
  return Container(
    margin: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 0.0),
    padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 18.0),
    decoration: BoxDecoration(
      color: _atelierPaper,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _atelierLine, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _heading('Concept Overview', size: 18.0),
        _gap(8.0),
        _body(
          'Material 3 splits navigation chrome into a small family of widgets — each backed by '
          'a dedicated ThemeData slot. Theming any of them follows the same three-step pattern: '
          'pick the *Data class, hand it to a *Theme widget (or ThemeData), and let the leaf '
          'widget read it via Theme.of(context).',
          size: 13.5,
        ),
        _gap(14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _overviewCard('Resolve', 'Leaf reads Theme.of(context).navigationBarTheme.', _sec1Primary, Icons.search_rounded)),
            _wgap(12.0),
            Expanded(child: _overviewCard('Compose', 'Wrap subtrees with *Theme(data: …) widgets.', _sec3Primary, Icons.layers_rounded)),
            _wgap(12.0),
            Expanded(child: _overviewCard('Override', 'Use copyWith to derive per-section variants.', _sec5Primary, Icons.tune_rounded)),
          ],
        ),
      ],
    ),
  );
}

Widget _overviewCard(String title, String body, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withOpacity(0.35), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 18.0, color: color),
            _wgap(8.0),
            _label(title, color: color, size: 12.5, weight: FontWeight.w800, letter: 0.4),
          ],
        ),
        _gap(6.0),
        _body(body, size: 12.0, height: 1.4),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1: NAVIGATIONBARTHEME DEMO
// ============================================================================

Widget _section1(BuildContext context) {
  final NavigationBarThemeData navBarTheme = NavigationBarThemeData(
    backgroundColor: _sec1Surface,
    elevation: 3.0,
    shadowColor: _atelierInk.withOpacity(0.15),
    surfaceTintColor: _sec1Accent,
    height: 76.0,
    indicatorColor: _sec1Primary.withOpacity(0.22),
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontSize: 11.5, color: _sec1Primary, fontWeight: FontWeight.w700),
    ),
    iconTheme: WidgetStateProperty.all(
      const IconThemeData(size: 22.0, color: _sec1Primary),
    ),
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  );

  final NavigationBarThemeData derived = navBarTheme.copyWith(
    backgroundColor: Colors.white,
    elevation: 6.0,
    indicatorColor: _sec1Primary.withOpacity(0.32),
  );

  final Widget demo = Theme(
    data: Theme.of(context).copyWith(navigationBarTheme: navBarTheme),
    child: NavigationBar(
      selectedIndex: 1,
      onDestinationSelected: (int _) {},
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard_rounded),
          label: 'Studio',
        ),
        NavigationDestination(
          icon: Icon(Icons.palette_outlined),
          selectedIcon: Icon(Icons.palette_rounded),
          label: 'Palettes',
        ),
        NavigationDestination(
          icon: Icon(Icons.architecture_outlined),
          selectedIcon: Icon(Icons.architecture_rounded),
          label: 'Layouts',
        ),
        NavigationDestination(
          icon: Icon(Icons.workspace_premium_outlined),
          selectedIcon: Icon(Icons.workspace_premium_rounded),
          label: 'Awards',
        ),
      ],
    ),
  );

  return _section(
    number: 1,
    title: 'NavigationBarTheme — Bottom Pill Indicator',
    subtitle: 'Indigo M3 navigation bar with a soft pill indicator and conditional labels.',
    primary: _sec1Primary,
    accent: _sec1Accent,
    surface: _sec1Surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _palette(<List<dynamic>>[
          <dynamic>[_sec1Primary, 'Primary'],
          <dynamic>[_sec1Accent, 'Accent'],
          <dynamic>[_sec1Surface, 'Surface'],
          <dynamic>[_atelierInk, 'Ink'],
        ]),
        _gap(18.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: _atelierLine, width: 1.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: demo,
        ),
        _gap(10.0),
        _body(
          'The theme drives indicator shape, label behaviour, height and icon colour. '
          'Wrapping it in a child-scoped Theme keeps the rest of the app on its '
          'default palette.',
        ),
        _kvTable(
          'NavigationBarThemeData — resolved tokens',
          <List<String>>[
            <String>['backgroundColor', '0x${navBarTheme.backgroundColor!.value.toRadixString(16)}', 'Surface tone behind destinations'],
            <String>['elevation', '${navBarTheme.elevation}', 'Z-depth for surface tint blending'],
            <String>['height', '${navBarTheme.height}', 'Overall bar height in logical pixels'],
            <String>['indicatorColor', 'primary @ 22%', 'Pill fill behind selected destination'],
            <String>['labelBehavior', 'onlyShowSelected', 'Hide labels except for the focused tab'],
            <String>['derived.elevation', '${derived.elevation}', 'copyWith preserves untouched tokens'],
          ],
          _sec1Primary,
        ),
        _recipeCard(
          title: 'Indigo Nav Bar',
          accent: _sec1Primary,
          bullets: <String>[
            'Start from NavigationBarThemeData with backgroundColor + indicatorColor.',
            'Wrap NavigationBar in Theme(data: Theme.of(context).copyWith(navigationBarTheme: …)).',
            'Use WidgetStateProperty.all for uniform label / icon styles.',
            'Override via copyWith for per-route or dark-mode variants.',
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2: NAVIGATIONRAILTHEME DEMO
// ============================================================================

Widget _section2(BuildContext context) {
  final NavigationRailThemeData railTheme = NavigationRailThemeData(
    backgroundColor: _sec2Surface,
    elevation: 1.0,
    indicatorColor: _sec2Primary.withOpacity(0.22),
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.0),
    ),
    unselectedLabelTextStyle: const TextStyle(
      fontSize: 12.0,
      color: _atelierSubtle,
      fontWeight: FontWeight.w500,
    ),
    selectedLabelTextStyle: const TextStyle(
      fontSize: 12.0,
      color: _sec2Primary,
      fontWeight: FontWeight.w800,
    ),
    unselectedIconTheme: const IconThemeData(size: 22.0, color: _atelierSubtle),
    selectedIconTheme: const IconThemeData(size: 24.0, color: _sec2Primary),
    groupAlignment: -0.85,
    labelType: NavigationRailLabelType.all,
    useIndicator: true,
    minWidth: 76.0,
    minExtendedWidth: 220.0,
  );

  final NavigationRailThemeData railDense = railTheme.copyWith(
    labelType: NavigationRailLabelType.selected,
    minWidth: 64.0,
  );

  final Widget demo = Theme(
    data: Theme.of(context).copyWith(navigationRailTheme: railTheme),
    child: SizedBox(
      height: 320.0,
      child: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: 1,
            onDestinationSelected: (int _) {},
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.inbox_outlined),
                selectedIcon: Icon(Icons.inbox_rounded),
                label: Text('Inbox'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border_rounded),
                selectedIcon: Icon(Icons.favorite_rounded),
                label: Text('Saved'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.send_outlined),
                selectedIcon: Icon(Icons.send_rounded),
                label: Text('Outbox'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.archive_outlined),
                selectedIcon: Icon(Icons.archive_rounded),
                label: Text('Archive'),
              ),
            ],
          ),
          const VerticalDivider(width: 1.0, color: _atelierLine),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _heading('Saved (12)', size: 16.0, color: _sec2Primary),
                  _gap(10.0),
                  _body('A focused workspace pane that adopts the rail palette without dragging '
                      'global theming into other features.', size: 12.5),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  return _section(
    number: 2,
    title: 'NavigationRailTheme — Rose Side Pillar',
    subtitle: 'Vertical rail with always-visible labels and a soft rose indicator pill.',
    primary: _sec2Primary,
    accent: _sec2Accent,
    surface: _sec2Surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _palette(<List<dynamic>>[
          <dynamic>[_sec2Primary, 'Primary'],
          <dynamic>[_sec2Accent, 'Accent'],
          <dynamic>[_sec2Surface, 'Surface'],
          <dynamic>[_atelierInk, 'Ink'],
        ]),
        _gap(18.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: _atelierLine, width: 1.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: demo,
        ),
        _gap(10.0),
        _body(
          'NavigationRailTheme exposes the selected and unselected variants explicitly, '
          'so it pairs well with split-pane layouts where the rail must feel distinct '
          'from the body.',
        ),
        _kvTable(
          'NavigationRailThemeData — resolved tokens',
          <List<String>>[
            <String>['groupAlignment', '${railTheme.groupAlignment}', 'Vertical anchor for destinations (-1=top, 1=bottom)'],
            <String>['labelType', railTheme.labelType.toString(), 'Visibility policy for destination labels'],
            <String>['useIndicator', '${railTheme.useIndicator}', 'Toggle M3 selection pill'],
            <String>['minWidth', '${railTheme.minWidth}', 'Collapsed rail width'],
            <String>['minExtendedWidth', '${railTheme.minExtendedWidth}', 'Width when extended:true is set'],
            <String>['dense.labelType', railDense.labelType.toString(), 'copyWith variant for narrow viewports'],
          ],
          _sec2Primary,
        ),
        _recipeCard(
          title: 'Rose Side Rail',
          accent: _sec2Primary,
          bullets: <String>[
            'Define selected & unselected styles for label and icon separately.',
            'Use groupAlignment to anchor destinations top, centre or bottom.',
            'Pair labelType.all with minExtendedWidth for tablet layouts.',
            'Derive a dense copyWith variant for phone-width breakpoints.',
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3: NAVIGATIONDRAWERTHEME DEMO
// ============================================================================

Widget _section3(BuildContext context) {
  final DrawerThemeData drawerTheme = DrawerThemeData(
    backgroundColor: Colors.white,
    elevation: 6.0,
    shadowColor: _atelierInk.withOpacity(0.18),
    surfaceTintColor: _sec3Surface,
    width: 296.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(20.0)),
    ),
  );

  final DrawerThemeData drawerWide = drawerTheme.copyWith(
    width: 340.0,
    elevation: 10.0,
  );

  final Widget drawerSurface = Theme(
    data: Theme.of(context).copyWith(drawerTheme: drawerTheme),
    child: Container(
      width: drawerTheme.width,
      height: 340.0,
      decoration: BoxDecoration(
        color: drawerTheme.backgroundColor,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(20.0)),
        border: Border.all(color: _atelierLine, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: drawerTheme.shadowColor!,
            blurRadius: 18.0,
            offset: const Offset(2.0, 4.0),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: _sec3Primary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.eco_rounded, color: Colors.white, size: 20.0),
              ),
              _wgap(10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _heading('Atelier', size: 16.0, color: _sec3Primary),
                  _body('alex@atelier.dev', size: 11.5),
                ],
              ),
            ],
          ),
          _gap(16.0),
          _drawerEntry(Icons.dashboard_rounded, 'Dashboard', selected: false),
          _drawerEntry(Icons.folder_rounded, 'Projects', selected: true),
          _drawerEntry(Icons.history_rounded, 'Activity', selected: false),
          _drawerEntry(Icons.settings_rounded, 'Settings', selected: false),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _sec3Surface,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: _body('Drawer width ${drawerTheme.width}, elevation ${drawerTheme.elevation}.', size: 11.5, color: _sec3Primary),
          ),
        ],
      ),
    ),
  );

  return _section(
    number: 3,
    title: 'NavigationDrawerTheme — Teal Side Sheet',
    subtitle: 'Modal drawer panel themed via DrawerThemeData, with hand-built rows for static preview.',
    primary: _sec3Primary,
    accent: _sec3Accent,
    surface: _sec3Surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _palette(<List<dynamic>>[
          <dynamic>[_sec3Primary, 'Primary'],
          <dynamic>[_sec3Accent, 'Accent'],
          <dynamic>[_sec3Surface, 'Surface'],
          <dynamic>[_atelierInk, 'Ink'],
        ]),
        _gap(18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            drawerSurface,
            _wgap(18.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: _atelierLine, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _heading('Drawer mechanics', size: 14.5),
                    _gap(6.0),
                    _body(
                      'DrawerThemeData drives the surface look for both Drawer (modal) and '
                      'NavigationDrawer (M3). Shape, width and elevation propagate through '
                      'Theme.of(context).drawerTheme.',
                      size: 12.5,
                    ),
                    _gap(12.0),
                    _label('width: ${drawerTheme.width}  •  elevation: ${drawerTheme.elevation}', color: _sec3Primary),
                    _gap(6.0),
                    _label('shape: RoundedRectangleBorder(right: 20)', color: _sec3Primary),
                    _gap(6.0),
                    _label('copyWith.width: ${drawerWide.width}', color: _sec3Primary),
                  ],
                ),
              ),
            ),
          ],
        ),
        _kvTable(
          'DrawerThemeData — resolved tokens',
          <List<String>>[
            <String>['backgroundColor', 'white', 'Surface fill of the drawer panel'],
            <String>['elevation', '${drawerTheme.elevation}', 'Material elevation for shadow + tint'],
            <String>['shadowColor', 'ink @ 18%', 'Cast shadow against page surface'],
            <String>['surfaceTintColor', 'teal mist', 'M3 tonal overlay on elevation'],
            <String>['width', '${drawerTheme.width}', 'Horizontal extent in logical pixels'],
            <String>['wide.width', '${drawerWide.width}', 'Override for desktop breakpoint'],
          ],
          _sec3Primary,
        ),
        _recipeCard(
          title: 'Teal Side Sheet',
          accent: _sec3Primary,
          bullets: <String>[
            'Use DrawerThemeData for both Drawer and NavigationDrawer leaves.',
            'Round only the trailing edge to suggest the page anchor.',
            'Combine surfaceTintColor + elevation for the M3 tonal effect.',
            'Increase width via copyWith for desktop or tablet master layouts.',
          ],
        ),
      ],
    ),
  );
}

Widget _drawerEntry(IconData icon, String label, {required bool selected}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: selected ? _sec3Primary.withOpacity(0.12) : Colors.transparent,
      borderRadius: BorderRadius.circular(28.0),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 18.0, color: selected ? _sec3Primary : _atelierSubtle),
        _wgap(12.0),
        Text(
          label,
          style: TextStyle(
            color: selected ? _sec3Primary : _atelierSlate,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
            fontSize: 13.0,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4: BOTTOMNAVIGATIONBARTHEME DEMO
// ============================================================================

Widget _section4(BuildContext context) {
  final BottomNavigationBarThemeData bottomTheme = BottomNavigationBarThemeData(
    backgroundColor: _sec4Surface,
    elevation: 4.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: _sec4Primary,
    unselectedItemColor: _atelierSubtle,
    selectedIconTheme: const IconThemeData(size: 24.0, color: _sec4Primary),
    unselectedIconTheme: const IconThemeData(size: 22.0, color: _atelierSubtle),
    selectedLabelStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800, color: _sec4Primary),
    unselectedLabelStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500, color: _atelierSubtle),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
  );

  final BottomNavigationBarThemeData shifting = bottomTheme.copyWith(
    type: BottomNavigationBarType.shifting,
    backgroundColor: Colors.white,
    selectedItemColor: _sec4Primary,
  );

  final Widget demo = Theme(
    data: Theme.of(context).copyWith(bottomNavigationBarTheme: bottomTheme),
    child: BottomNavigationBar(
      currentIndex: 2,
      onTap: (int _) {},
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), activeIcon: Icon(Icons.explore_rounded), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), activeIcon: Icon(Icons.add_circle_rounded), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded), activeIcon: Icon(Icons.notifications_rounded), label: 'Alerts'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: 'Profile'),
      ],
    ),
  );

  return _section(
    number: 4,
    title: 'BottomNavigationBarTheme — Amber Fixed Bar',
    subtitle: 'Classic M2 bottom bar with fixed type, labels and selected/unselected token pairs.',
    primary: _sec4Primary,
    accent: _sec4Accent,
    surface: _sec4Surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _palette(<List<dynamic>>[
          <dynamic>[_sec4Primary, 'Primary'],
          <dynamic>[_sec4Accent, 'Accent'],
          <dynamic>[_sec4Surface, 'Surface'],
          <dynamic>[_atelierInk, 'Ink'],
        ]),
        _gap(18.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: _atelierLine, width: 1.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: demo,
        ),
        _gap(10.0),
        _body(
          'BottomNavigationBarTheme keeps two parallel sets of tokens for selected and '
          'unselected items. It is still the easiest way to retro-fit older surfaces.',
        ),
        _kvTable(
          'BottomNavigationBarThemeData — resolved tokens',
          <List<String>>[
            <String>['type', bottomTheme.type.toString(), 'fixed vs shifting affects layout'],
            <String>['selectedItemColor', 'amber primary', 'Foreground for selected icon/label'],
            <String>['unselectedItemColor', 'subtle slate', 'Foreground for inactive entries'],
            <String>['showSelectedLabels', '${bottomTheme.showSelectedLabels}', 'Toggle label rendering for selected'],
            <String>['showUnselectedLabels', '${bottomTheme.showUnselectedLabels}', 'Toggle label rendering for unselected'],
            <String>['landscapeLayout', bottomTheme.landscapeLayout.toString(), 'Centered vs linear layout in landscape'],
            <String>['shifting.type', shifting.type.toString(), 'Derived theme for shifting variant'],
          ],
          _sec4Primary,
        ),
        _recipeCard(
          title: 'Amber Fixed Bar',
          accent: _sec4Primary,
          bullets: <String>[
            'Pair selected and unselected colour + label styles for clarity.',
            'Use type=fixed for ≤5 items; switch to shifting for fewer than 4.',
            'Lock backgroundColor to keep brand intact across nested routes.',
            'Override landscapeLayout to centre items on wide tablets.',
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5: TABBARTHEME DEMO
// ============================================================================

Widget _section5(BuildContext context) {
  final TabBarThemeData tabTheme = TabBarThemeData(
    indicatorColor: _sec5Primary,
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: _sec5Primary,
    unselectedLabelColor: _atelierSubtle,
    labelStyle: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w800, letterSpacing: 0.3),
    unselectedLabelStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
    overlayColor: WidgetStateProperty.all(_sec5Primary.withOpacity(0.08)),
    splashFactory: NoSplash.splashFactory,
    dividerColor: _atelierLine,
  );

  final TabBarThemeData tabFilled = tabTheme.copyWith(
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: _sec5Primary.withOpacity(0.18),
  );

  final Widget demo = Theme(
    data: Theme.of(context).copyWith(tabBarTheme: tabTheme),
    child: DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: SizedBox(
        height: 220.0,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: const TabBar(
                tabs: <Widget>[
                  Tab(text: 'Overview'),
                  Tab(text: 'Surfaces'),
                  Tab(text: 'Motion'),
                  Tab(text: 'Tokens'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: _sec5Surface,
                padding: const EdgeInsets.all(18.0),
                alignment: Alignment.topLeft,
                child: const TabBarView(
                  children: <Widget>[
                    Center(child: Text('Overview pane', style: TextStyle(color: _sec5Primary, fontWeight: FontWeight.w700))),
                    Center(child: Text('Surfaces pane', style: TextStyle(color: _sec5Primary, fontWeight: FontWeight.w700))),
                    Center(child: Text('Motion pane', style: TextStyle(color: _sec5Primary, fontWeight: FontWeight.w700))),
                    Center(child: Text('Tokens pane', style: TextStyle(color: _sec5Primary, fontWeight: FontWeight.w700))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  return _section(
    number: 5,
    title: 'TabBarTheme — Cobalt Label Underline',
    subtitle: 'Underline indicator sized to the label, with deferred splash for cleaner motion snapshots.',
    primary: _sec5Primary,
    accent: _sec5Accent,
    surface: _sec5Surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _palette(<List<dynamic>>[
          <dynamic>[_sec5Primary, 'Primary'],
          <dynamic>[_sec5Accent, 'Accent'],
          <dynamic>[_sec5Surface, 'Surface'],
          <dynamic>[_atelierInk, 'Ink'],
        ]),
        _gap(18.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: _atelierLine, width: 1.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: demo,
        ),
        _gap(10.0),
        _body(
          'TabBarTheme centralises indicator, label and overlay styling so that nested '
          'DefaultTabController surfaces stay consistent across feature panels.',
        ),
        _kvTable(
          'TabBarTheme — resolved tokens',
          <List<String>>[
            <String>['indicatorColor', 'cobalt primary', 'Underline colour beneath active label'],
            <String>['indicatorSize', tabTheme.indicatorSize.toString(), 'label vs tab width'],
            <String>['labelColor', 'cobalt primary', 'Active label foreground'],
            <String>['unselectedLabelColor', 'subtle', 'Inactive label foreground'],
            <String>['dividerColor', 'atelier line', 'Bottom divider beneath tabs'],
            <String>['filled.indicatorSize', tabFilled.indicatorSize.toString(), 'Variant for chip-style tabs'],
          ],
          _sec5Primary,
        ),
        _recipeCard(
          title: 'Cobalt TabBar',
          accent: _sec5Primary,
          bullets: <String>[
            'Centralise tab styling in TabBarTheme rather than per-instance.',
            'Use indicatorSize.label for narrow accents; .tab for chip-style.',
            'Pass overlayColor through WidgetStateProperty to skin the splash.',
            'Switch to splashFactory: NoSplash for static visual snapshots.',
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6: APPBARTHEME DEMO
// ============================================================================

Widget _section6(BuildContext context) {
  final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: _sec6Primary,
    foregroundColor: Colors.white,
    elevation: 0.0,
    scrolledUnderElevation: 2.0,
    shadowColor: _sec6Primary.withOpacity(0.4),
    surfaceTintColor: _sec6Accent,
    centerTitle: false,
    titleSpacing: 16.0,
    toolbarHeight: 64.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.2,
    ),
    iconTheme: const IconThemeData(color: Colors.white, size: 22.0),
    actionsIconTheme: const IconThemeData(color: Colors.white, size: 22.0),
  );

  final AppBarTheme appBarLight = appBarTheme.copyWith(
    backgroundColor: Colors.white,
    foregroundColor: _sec6Primary,
    iconTheme: const IconThemeData(color: _sec6Primary, size: 22.0),
    titleTextStyle: const TextStyle(color: _sec6Primary, fontSize: 18.0, fontWeight: FontWeight.w800),
  );

  final Widget bar1 = Theme(
    data: Theme.of(context).copyWith(appBarTheme: appBarTheme),
    child: AppBar(
      title: const Text('Atelier'),
      actions: const <Widget>[
        Icon(Icons.search_rounded),
        SizedBox(width: 14.0),
        Icon(Icons.notifications_rounded),
        SizedBox(width: 14.0),
      ],
    ),
  );

  final Widget bar2 = Theme(
    data: Theme.of(context).copyWith(appBarTheme: appBarLight),
    child: AppBar(
      title: const Text('Atelier · Light'),
      actions: const <Widget>[
        Icon(Icons.share_rounded),
        SizedBox(width: 14.0),
        Icon(Icons.more_vert_rounded),
        SizedBox(width: 14.0),
      ],
    ),
  );

  return _section(
    number: 6,
    title: 'AppBarTheme — Violet Headers',
    subtitle: 'Solid violet header paired with a derived light-mode header via copyWith.',
    primary: _sec6Primary,
    accent: _sec6Accent,
    surface: _sec6Surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _palette(<List<dynamic>>[
          <dynamic>[_sec6Primary, 'Primary'],
          <dynamic>[_sec6Accent, 'Accent'],
          <dynamic>[_sec6Surface, 'Surface'],
          <dynamic>[_atelierInk, 'Ink'],
        ]),
        _gap(18.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: _atelierLine, width: 1.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: <Widget>[
            SizedBox(height: 64.0, child: bar1),
            const SizedBox(height: 12.0),
            SizedBox(height: 64.0, child: bar2),
          ]),
        ),
        _gap(10.0),
        _body(
          'AppBarTheme controls colour, elevation, title typography and icon themes in one '
          'place. copyWith makes it trivial to derive a light mode bar from a dark one.',
        ),
        _kvTable(
          'AppBarTheme — resolved tokens',
          <List<String>>[
            <String>['backgroundColor', 'violet primary', 'Solid bar surface'],
            <String>['foregroundColor', 'white', 'Title + icon foreground'],
            <String>['elevation', '${appBarTheme.elevation}', 'Resting elevation when not scrolled'],
            <String>['scrolledUnderElevation', '${appBarTheme.scrolledUnderElevation}', 'Elevation once content scrolls underneath'],
            <String>['centerTitle', '${appBarTheme.centerTitle}', 'Title alignment'],
            <String>['toolbarHeight', '${appBarTheme.toolbarHeight}', 'Vertical extent in logical pixels'],
            <String>['light.background', 'white', 'Derived light variant via copyWith'],
          ],
          _sec6Primary,
        ),
        _recipeCard(
          title: 'Violet Headers',
          accent: _sec6Primary,
          bullets: <String>[
            'Always pair backgroundColor + foregroundColor for accessible contrast.',
            'Use scrolledUnderElevation for tonal feedback on scroll.',
            'Define titleTextStyle so titles stay typographically consistent.',
            'Derive light/dark variants with copyWith rather than rebuilding the data.',
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7: LIGHT VS DARK PALETTE THEMING
// ============================================================================

Widget _section7(BuildContext context) {
  final NavigationBarThemeData light = NavigationBarThemeData(
    backgroundColor: _atelierPaper,
    indicatorColor: _sec7Primary.withOpacity(0.16),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _sec7Primary),
    ),
    iconTheme: WidgetStateProperty.all(const IconThemeData(color: _sec7Primary, size: 22.0)),
    height: 70.0,
  );

  final NavigationBarThemeData dark = NavigationBarThemeData(
    backgroundColor: _atelierInk,
    indicatorColor: Colors.white.withOpacity(0.18),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Colors.white),
    ),
    iconTheme: WidgetStateProperty.all(const IconThemeData(color: Colors.white, size: 22.0)),
    height: 70.0,
  );

  Widget barWith(NavigationBarThemeData data) {
    return Theme(
      data: Theme.of(context).copyWith(navigationBarTheme: data),
      child: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (int _) {},
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.bolt_rounded), label: 'Pulse'),
          NavigationDestination(icon: Icon(Icons.show_chart_rounded), label: 'Charts'),
          NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Setup'),
        ],
      ),
    );
  }

  return _section(
    number: 7,
    title: 'Light vs Dark Palette Variants',
    subtitle: 'Same NavigationBar surface adapted to graphite light and ink dark palettes.',
    primary: _sec7Primary,
    accent: _sec7Accent,
    surface: _sec7Surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _palette(<List<dynamic>>[
          <dynamic>[_sec7Primary, 'Graphite'],
          <dynamic>[_sec7Accent, 'Pewter'],
          <dynamic>[_sec7Surface, 'Mist'],
          <dynamic>[_atelierInk, 'Ink'],
        ]),
        _gap(18.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: _atelierLine, width: 1.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                    width: double.infinity,
                    color: _atelierMist,
                    child: _label('LIGHT MODE', color: _sec7Primary, size: 11.0, letter: 1.4),
                  ),
                  SizedBox(height: 76.0, child: barWith(light)),
                ]),
              ),
            ),
            _wgap(14.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _atelierInk,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: _atelierLine, width: 1.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                    width: double.infinity,
                    color: _atelierSlate,
                    child: _label('DARK MODE', color: Colors.white, size: 11.0, letter: 1.4),
                  ),
                  SizedBox(height: 76.0, child: barWith(dark)),
                ]),
              ),
            ),
          ],
        ),
        _kvTable(
          'Light vs Dark — paired tokens',
          <List<String>>[
            <String>['backgroundColor', 'paper / ink', 'Surface fill across mode flip'],
            <String>['indicatorColor', 'primary @ 16% / white @ 18%', 'Pill stays subtle in both modes'],
            <String>['label colour', 'graphite / white', 'Maintains AA contrast against surface'],
            <String>['icon colour', 'graphite / white', 'Foreground for icons follows label'],
            <String>['height', '${light.height} / ${dark.height}', 'Geometry is mode-independent'],
            <String>['copyWith strategy', 'derive dark from light', 'Avoid duplicated property bags'],
          ],
          _sec7Primary,
        ),
        _recipeCard(
          title: 'Mode-aware Nav',
          accent: _sec7Primary,
          bullets: <String>[
            'Define the light variant first, derive dark via copyWith.',
            'Tune indicator opacity so the pill stays subtle in both modes.',
            'Keep geometry tokens (height, shape) identical to avoid layout shifts.',
            'Resolve at runtime via Theme.of(context).brightness.',
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8: COMPARISON GRID — SAME NAV, FOUR THEMES
// ============================================================================

Widget _section8(BuildContext context) {
  NavigationBarThemeData themeFor(Color primary, Color surface) {
    return NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: primary.withOpacity(0.22),
      indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: primary),
      ),
      iconTheme: WidgetStateProperty.all(IconThemeData(color: primary, size: 22.0)),
      height: 70.0,
    );
  }

  Widget tile(String name, Color primary, Color surface) {
    final NavigationBarThemeData data = themeFor(primary, surface);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _atelierLine, width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
            color: primary,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12.0, letterSpacing: 0.4),
            ),
          ),
          SizedBox(
            height: 76.0,
            child: Theme(
              data: Theme.of(context).copyWith(navigationBarTheme: data),
              child: NavigationBar(
                selectedIndex: 1,
                onDestinationSelected: (int _) {},
                destinations: const <Widget>[
                  NavigationDestination(icon: Icon(Icons.home_rounded), label: 'A'),
                  NavigationDestination(icon: Icon(Icons.star_rounded), label: 'B'),
                  NavigationDestination(icon: Icon(Icons.flag_rounded), label: 'C'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  return _section(
    number: 8,
    title: 'Comparison Grid — Same Nav, Four Themes',
    subtitle: 'Identical NavigationBar geometry, four palettes layered side by side.',
    primary: _sec8Primary,
    accent: _sec8Accent,
    surface: _sec8Surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _palette(<List<dynamic>>[
          <dynamic>[_sec8Primary, 'Lagoon'],
          <dynamic>[_sec8Accent, 'Sky'],
          <dynamic>[_sec8Surface, 'Foam'],
          <dynamic>[_atelierInk, 'Ink'],
        ]),
        _gap(18.0),
        Row(
          children: <Widget>[
            Expanded(child: tile('Indigo', _sec1Primary, _sec1Surface)),
            _wgap(12.0),
            Expanded(child: tile('Rose', _sec2Primary, _sec2Surface)),
          ],
        ),
        _gap(12.0),
        Row(
          children: <Widget>[
            Expanded(child: tile('Teal', _sec3Primary, _sec3Surface)),
            _wgap(12.0),
            Expanded(child: tile('Amber', _sec4Primary, _sec4Surface)),
          ],
        ),
        _kvTable(
          'Comparison axes',
          <List<String>>[
            <String>['Geometry', 'identical', 'Same height, indicator radius, destination count'],
            <String>['Surface', 'sec*Surface', 'Pastel fill scoped per palette'],
            <String>['Primary', 'sec*Primary', 'Drives indicator opacity + foreground'],
            <String>['Label style', 'WidgetStateProperty.all', 'Single style across all tabs for snapshot stability'],
            <String>['Icon size', '22.0', 'Held constant to highlight palette deltas'],
            <String>['Indicator shape', 'RR(16)', 'Stable pill radius across variants'],
          ],
          _sec8Primary,
        ),
        _recipeCard(
          title: 'Palette Swap Workflow',
          accent: _sec8Primary,
          bullets: <String>[
            'Lock geometry tokens; only vary colour tokens between palettes.',
            'Use a builder helper (themeFor) to keep tiles compact.',
            'Wrap each NavigationBar in a scoped Theme to avoid leaking colours.',
            'Document the variants in a property table next to the visual grid.',
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// EPILOGUE / GLOSSARY
// ============================================================================

Widget _glossary() {
  final List<List<String>> entries = <List<String>>[
    <String>['NavigationBarTheme', 'Inherited M3 bottom bar styling — pill indicator, labels, icons.'],
    <String>['NavigationRailTheme', 'Inherited vertical rail styling — selected/unselected pairs, extended width.'],
    <String>['NavigationDrawerTheme', 'Inherited modal side sheet styling — backgroundColor, width, shape.'],
    <String>['BottomNavigationBarTheme', 'Legacy M2 bottom bar styling — fixed vs shifting, label visibility.'],
    <String>['TabBarTheme', 'TabBar styling — indicator, label colour, overlay, divider.'],
    <String>['AppBarTheme', 'Top app bar styling — colour, title typography, elevation under scroll.'],
    <String>['WidgetStateProperty', 'Resolves a value per WidgetState set (selected, hovered, …).'],
    <String>['Theme.copyWith', 'Derive a variant theme from a base by overriding selected slots.'],
  ];
  final List<Widget> rows = <Widget>[];
  for (final List<String> e in entries) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: _label(e[0], size: 12.0, color: _atelierInk, weight: FontWeight.w800),
            ),
            Expanded(child: _body(e[1], size: 12.0)),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.fromLTRB(22.0, 32.0, 22.0, 0.0),
    padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 22.0),
    decoration: BoxDecoration(
      color: _atelierPaper,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _atelierLine, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _heading('Glossary', size: 18.0),
        _gap(6.0),
        _body('Quick reference for the navigation theming family used across the atelier.', size: 12.5),
        _gap(10.0),
        ...rows,
      ],
    ),
  );
}

Widget _epilogue() {
  return Container(
    margin: const EdgeInsets.fromLTRB(22.0, 28.0, 22.0, 32.0),
    padding: const EdgeInsets.fromLTRB(24.0, 26.0, 24.0, 26.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_atelierSlate, _atelierInk],
      ),
      borderRadius: BorderRadius.circular(22.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.16),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.0),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20.0),
            ),
            _wgap(12.0),
            const Text(
              'ATELIER COMPLETE',
              style: TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w800, letterSpacing: 2.4),
            ),
          ],
        ),
        _gap(14.0),
        const Text(
          'Eight palettes, six theming surfaces, one consistent recipe.',
          style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w900, height: 1.2),
        ),
        _gap(8.0),
        Text(
          'Every navigation surface in Material follows the same playbook: pick a *Data class, '
          'install it with a *Theme widget (or ThemeData slot), then let the leaf widgets '
          'resolve it through Theme.of. Compose palette and geometry independently to keep '
          'variants cheap and visually consistent.',
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13.0, height: 1.55),
        ),
      ],
    ),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Material 3 — Nav Surface Atelier',
    theme: ThemeData(
      colorScheme: const ColorScheme.light(
        primary: _sec1Primary,
        secondary: _sec2Primary,
        surface: _atelierPaper,
      ),
      scaffoldBackgroundColor: _atelierMist,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: _atelierMist,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _hero(),
            _overview(),
            _section1(context),
            _section2(context),
            _section3(context),
            _section4(context),
            _section5(context),
            _section6(context),
            _section7(context),
            _section8(context),
            _glossary(),
            _epilogue(),
          ],
        ),
      ),
    ),
  );
}
