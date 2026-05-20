// D4rt deep visual demo: the M3 component theme atlas — every component, themed.
// Demonstrates per-component ThemeData slots: AppBarTheme, CardTheme, ChipThemeData,
// CheckboxThemeData, RadioThemeData, SwitchThemeData, SliderThemeData, TabBarTheme,
// IconThemeData, DividerThemeData, FloatingActionButtonThemeData, MaterialBannerThemeData,
// BottomAppBarTheme, BottomSheetThemeData, SnackBarThemeData, ProgressIndicatorThemeData,
// ListTileThemeData, ExpansionTileThemeData, NavigationBarThemeData, NavigationRailThemeData,
// NavigationDrawerThemeData, SearchBarThemeData, SegmentedButtonThemeData, DialogTheme.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Shared palette helpers — keep section-to-section colors varied but coherent.
// ---------------------------------------------------------------------------

const Color _ink = Color(0xFF101820);
const Color _paper = Color(0xFFF6F4EF);
const Color _sunrisePrimary = Color(0xFFFF7043);
const Color _sunriseSurface = Color(0xFFFFF3E0);
const Color _midnightPrimary = Color(0xFF1A237E);
const Color _midnightSurface = Color(0xFF283593);
const Color _sandPrimary = Color(0xFF8D6E63);
const Color _sandSurface = Color(0xFFEFEBE9);
const Color _forestPrimary = Color(0xFF2E7D32);
const Color _forestSurface = Color(0xFFE8F5E9);
const Color _berryPrimary = Color(0xFF8E24AA);
const Color _berrySurface = Color(0xFFF3E5F5);
const Color _oceanPrimary = Color(0xFF006978);
const Color _oceanSurface = Color(0xFFE0F7FA);
const Color _emberPrimary = Color(0xFFD84315);
const Color _emberSurface = Color(0xFFFBE9E7);
const Color _slatePrimary = Color(0xFF455A64);
const Color _slateSurface = Color(0xFFECEFF1);

Widget _heroHeader() {
  return Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1A237E), Color(0xFF512DA8), Color(0xFF8E24AA)],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.palette_outlined, color: Colors.white, size: 36.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'The M3 Component Theme Atlas',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'ThemeData ships dozens of per-component slots (appBarTheme, cardTheme, '
          'chipTheme, switchTheme, ...). Each slot lets you set defaults for one '
          'kind of widget in one place — no per-widget property duplication, no '
          'inconsistencies. This atlas wires each slot to a real widget so you '
          'can see the style propagate.',
          style: TextStyle(
            fontSize: 13.5,
            color: Colors.white,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _sectionTitle(String number, String title, Color accent) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.12),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _narrative(String body) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 10.0),
    child: Text(
      body,
      style: const TextStyle(
        fontSize: 13.0,
        height: 1.5,
        color: _ink,
      ),
    ),
  );
}

Widget _codeSnippetCard(String body) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1B1F23),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.black87, width: 1.0),
    ),
    child: Text(
      body,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: Color(0xFFE6EDF3),
        height: 1.5,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 helper — mini Scaffold rendering shared between many sections.
// ---------------------------------------------------------------------------

Widget _miniScaffold({
  required String label,
  required ThemeData theme,
  required Widget body,
  double height = 220.0,
  Color frameColor = _ink,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: frameColor.withValues(alpha: 0.25), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: frameColor.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: frameColor.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: frameColor,
            ),
          ),
        ),
        SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(14.0),
              bottomRight: Radius.circular(14.0),
            ),
            child: Theme(data: theme, child: body),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3: AppBarTheme — three variants.
// ---------------------------------------------------------------------------

Widget _appBarSunrise(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: _sunrisePrimary,
      foregroundColor: Colors.white,
      elevation: 4.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
  return _miniScaffold(
    label: 'AppBarTheme · sunrise',
    theme: theme,
    body: Scaffold(
      backgroundColor: _sunriseSurface,
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Sunrise'),
        actions: const <Widget>[Icon(Icons.search), SizedBox(width: 12.0)],
      ),
      body: const Center(child: Icon(Icons.wb_sunny, size: 56.0, color: _sunrisePrimary)),
    ),
  );
}

Widget _appBarMidnight(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: _midnightPrimary,
      foregroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
        letterSpacing: 1.5,
        color: Colors.white,
      ),
    ),
  );
  return _miniScaffold(
    label: 'AppBarTheme · midnight',
    theme: theme,
    body: Scaffold(
      backgroundColor: _midnightSurface,
      appBar: AppBar(
        title: const Text('MIDNIGHT'),
        actions: const <Widget>[
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 12.0),
        ],
      ),
      body: const Center(
        child: Icon(Icons.nightlight_round, size: 56.0, color: Colors.white),
      ),
    ),
  );
}

Widget _appBarSand(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: _sandSurface,
      foregroundColor: _sandPrimary,
      elevation: 1.0,
      titleTextStyle: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
        color: _sandPrimary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18.0)),
      ),
    ),
  );
  return _miniScaffold(
    label: 'AppBarTheme · sand',
    theme: theme,
    body: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Sand'),
      ),
      body: const Center(child: Icon(Icons.terrain, size: 56.0, color: _sandPrimary)),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4: CardTheme — three variants.
// ---------------------------------------------------------------------------

Widget _cardVariant({
  required String title,
  required CardThemeData cardTheme,
  required Color accent,
  required BuildContext context,
}) {
  final ThemeData theme = Theme.of(context).copyWith(cardTheme: cardTheme);
  return Expanded(
    child: Theme(
      data: theme,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.style_outlined, color: accent, size: 32.0),
              const SizedBox(height: 8.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: accent,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'elev ${cardTheme.elevation?.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 11.0, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _cardThemeRow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _cardVariant(
          context: context,
          accent: _forestPrimary,
          title: 'flat / square',
          cardTheme: CardThemeData(
            color: _forestSurface,
            elevation: 0.0,
            margin: const EdgeInsets.all(6.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(color: _forestPrimary, width: 1.5),
            ),
          ),
        ),
        _cardVariant(
          context: context,
          accent: _berryPrimary,
          title: 'rounded / lifted',
          cardTheme: CardThemeData(
            color: _berrySurface,
            elevation: 6.0,
            shadowColor: _berryPrimary.withValues(alpha: 0.5),
            margin: const EdgeInsets.all(6.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
        _cardVariant(
          context: context,
          accent: _oceanPrimary,
          title: 'pill / floating',
          cardTheme: CardThemeData(
            color: _oceanSurface,
            elevation: 3.0,
            margin: const EdgeInsets.all(6.0),
            shape: const StadiumBorder(),
            clipBehavior: Clip.antiAlias,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5: ChipTheme — three variants in one Wrap.
// ---------------------------------------------------------------------------

Widget _chipThemeRow(BuildContext context) {
  final ChipThemeData pill = ChipThemeData(
    backgroundColor: _emberSurface,
    labelStyle: const TextStyle(color: _emberPrimary, fontWeight: FontWeight.w700),
    side: const BorderSide(color: _emberPrimary, width: 1.2),
    shape: const StadiumBorder(),
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
  );
  final ChipThemeData flat = ChipThemeData(
    backgroundColor: _slateSurface,
    labelStyle: const TextStyle(color: _slatePrimary, fontWeight: FontWeight.w500),
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  );
  final ChipThemeData outlined = ChipThemeData(
    backgroundColor: Colors.white,
    labelStyle: const TextStyle(color: _berryPrimary, fontWeight: FontWeight.w600),
    side: const BorderSide(color: _berryPrimary, width: 1.4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );

  Widget themed(ChipThemeData data, List<String> labels) {
    return Theme(
      data: Theme.of(context).copyWith(chipTheme: data),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: <Widget>[
          for (final String l in labels) Chip(label: Text(l)),
        ],
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('rounded pill', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4.0),
        themed(pill, const <String>['ember', 'glow', 'pulse']),
        const SizedBox(height: 10.0),
        const Text('flat tag', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4.0),
        themed(flat, const <String>['slate', 'mute', 'soft', 'calm']),
        const SizedBox(height: 10.0),
        const Text('outlined', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4.0),
        themed(outlined, const <String>['berry', 'plum', 'wine']),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6: Checkbox / Radio / Switch themes.
// ---------------------------------------------------------------------------

Widget _selectableControls(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) return _forestPrimary;
        return Colors.white;
      }),
      checkColor: WidgetStateProperty.all<Color>(Colors.white),
      side: const BorderSide(color: _forestPrimary, width: 1.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) return _berryPrimary;
        return Colors.grey;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) return Colors.white;
        return _slateSurface;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) return _oceanPrimary;
        return Colors.grey.shade400;
      }),
    ),
  );

  return Theme(
    data: theme,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: const <Widget>[
              Checkbox(value: true, onChanged: null),
              SizedBox(height: 4.0),
              Text('Checkbox', style: TextStyle(fontSize: 12.0)),
            ],
          ),
          Column(
            children: <Widget>[
              RadioGroup<int>(
                groupValue: 1,
                onChanged: (int? _) {},
                child: const Radio<int>(value: 1),
              ),
              const SizedBox(height: 4.0),
              const Text('Radio', style: TextStyle(fontSize: 12.0)),
            ],
          ),
          Column(
            children: const <Widget>[
              Switch(value: true, onChanged: null),
              SizedBox(height: 4.0),
              Text('Switch', style: TextStyle(fontSize: 12.0)),
            ],
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7: SliderTheme — three variants.
// ---------------------------------------------------------------------------

Widget _slidersRow(BuildContext context) {
  Widget themed({
    required String label,
    required SliderThemeData data,
    required double value,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(sliderTheme: data),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            Slider(value: value, onChanged: null),
          ],
        ),
      ),
    );
  }

  return Column(
    children: <Widget>[
      themed(
        label: 'thin / classic',
        value: 0.30,
        data: const SliderThemeData(
          activeTrackColor: _oceanPrimary,
          inactiveTrackColor: _oceanSurface,
          thumbColor: _oceanPrimary,
          trackHeight: 2.0,
        ),
      ),
      themed(
        label: 'thick / forest',
        value: 0.55,
        data: SliderThemeData(
          activeTrackColor: _forestPrimary,
          inactiveTrackColor: _forestSurface,
          thumbColor: Colors.white,
          overlayColor: _forestPrimary.withValues(alpha: 0.2),
          trackHeight: 6.0,
        ),
      ),
      themed(
        label: 'pill / ember',
        value: 0.80,
        data: const SliderThemeData(
          activeTrackColor: _emberPrimary,
          inactiveTrackColor: _emberSurface,
          thumbColor: _emberPrimary,
          trackHeight: 8.0,
          showValueIndicator: ShowValueIndicator.onDrag,
          valueIndicatorColor: _emberPrimary,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8: TabBarTheme.
// ---------------------------------------------------------------------------

Widget _tabBarDemo(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    tabBarTheme: const TabBarThemeData(
      labelColor: _berryPrimary,
      unselectedLabelColor: Colors.black45,
      labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.0),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: _berryPrimary, width: 3.0),
        insets: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    ),
  );
  return _miniScaffold(
    label: 'TabBarTheme · berry underline',
    theme: theme,
    body: DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: _berrySurface,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Home'),
              Tab(text: 'Trends'),
              Tab(text: 'About'),
            ],
          ),
        ),
        body: const Center(
          child: Icon(Icons.tab, color: _berryPrimary, size: 48.0),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9: IconTheme — three icon strips.
// ---------------------------------------------------------------------------

Widget _iconStripsColumn(BuildContext context) {
  Widget strip(IconThemeData data, String label) {
    return Theme(
      data: Theme.of(context).copyWith(iconTheme: data),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 80.0,
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            const Icon(Icons.cloud),
            const SizedBox(width: 12.0),
            const Icon(Icons.bolt),
            const SizedBox(width: 12.0),
            const Icon(Icons.bug_report),
            const SizedBox(width: 12.0),
            const Icon(Icons.star),
            const SizedBox(width: 12.0),
            const Icon(Icons.favorite),
          ],
        ),
      ),
    );
  }

  return Column(
    children: <Widget>[
      strip(const IconThemeData(color: _midnightPrimary, size: 22.0), 'compact'),
      strip(const IconThemeData(color: _forestPrimary, size: 28.0), 'normal'),
      strip(IconThemeData(color: _emberPrimary, size: 36.0, opacity: 0.85), 'large'),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 10: DividerTheme — column of variants.
// ---------------------------------------------------------------------------

Widget _dividersColumn(BuildContext context) {
  Widget themed(DividerThemeData d, String label) {
    return Theme(
      data: Theme.of(context).copyWith(dividerTheme: d),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: const TextStyle(fontSize: 12.0)),
            const Divider(),
          ],
        ),
      ),
    );
  }

  return Column(
    children: <Widget>[
      themed(const DividerThemeData(color: Colors.black12, thickness: 0.5), 'hairline · 0.5'),
      themed(const DividerThemeData(color: _slatePrimary, thickness: 1.5), 'slate · 1.5'),
      themed(const DividerThemeData(color: _emberPrimary, thickness: 3.0, space: 24.0), 'ember · 3.0'),
      themed(const DividerThemeData(color: _oceanPrimary, thickness: 6.0, space: 30.0), 'ocean · 6.0'),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 11: FloatingActionButtonTheme.
// ---------------------------------------------------------------------------

Widget _fabRow(BuildContext context) {
  Widget fab(FloatingActionButtonThemeData data, IconData icon, String label) {
    return Theme(
      data: Theme.of(context).copyWith(floatingActionButtonTheme: data),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(onPressed: null, child: Icon(icon)),
            const SizedBox(height: 8.0),
            Text(label, style: const TextStyle(fontSize: 11.0)),
          ],
        ),
      ),
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      fab(
        const FloatingActionButtonThemeData(
          backgroundColor: _sandPrimary,
          foregroundColor: Colors.white,
          elevation: 2.0,
        ),
        Icons.add,
        'default',
      ),
      fab(
        const FloatingActionButtonThemeData(
          backgroundColor: _berryPrimary,
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: StadiumBorder(),
        ),
        Icons.edit,
        'accent',
      ),
      fab(
        const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: _ink,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            side: BorderSide(color: _ink, width: 1.4),
          ),
        ),
        Icons.share,
        'contrast',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 12: NavigationBar / NavigationRail / NavigationDrawer.
// ---------------------------------------------------------------------------

Widget _navBarMini(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _oceanSurface,
      indicatorColor: _oceanPrimary.withValues(alpha: 0.25),
      labelTextStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(color: _oceanPrimary, fontSize: 11.0, fontWeight: FontWeight.w600),
      ),
      iconTheme: WidgetStateProperty.all<IconThemeData>(
        const IconThemeData(color: _oceanPrimary, size: 22.0),
      ),
    ),
  );
  return _miniScaffold(
    label: 'NavigationBarTheme · ocean',
    theme: theme,
    body: Scaffold(
      backgroundColor: Colors.white,
      body: const Center(child: Icon(Icons.waves, color: _oceanPrimary, size: 56.0)),
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    ),
  );
}

Widget _navRailMini(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    navigationRailTheme: const NavigationRailThemeData(
      backgroundColor: _midnightPrimary,
      unselectedIconTheme: IconThemeData(color: Colors.white60),
      selectedIconTheme: IconThemeData(color: Colors.white),
      unselectedLabelTextStyle: TextStyle(color: Colors.white60, fontSize: 11.0),
      selectedLabelTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      indicatorColor: Colors.white24,
    ),
  );
  return _miniScaffold(
    label: 'NavigationRailTheme · midnight',
    theme: theme,
    body: Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: 1,
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(icon: Icon(Icons.inbox), label: Text('Inbox')),
              NavigationRailDestination(icon: Icon(Icons.send), label: Text('Sent')),
              NavigationRailDestination(icon: Icon(Icons.archive), label: Text('Archive')),
            ],
          ),
          const Expanded(
            child: Center(child: Icon(Icons.mail, color: _midnightPrimary, size: 56.0)),
          ),
        ],
      ),
    ),
  );
}

Widget _navDrawerMini(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: _forestSurface,
      indicatorColor: _forestPrimary,
      labelTextStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(color: _forestPrimary, fontWeight: FontWeight.w600),
      ),
    ),
  );
  return _miniScaffold(
    label: 'NavigationDrawerTheme · forest',
    theme: theme,
    body: Theme(
      data: theme,
      child: const NavigationDrawer(
        selectedIndex: 0,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 8.0),
            child: Text('Menu', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.dashboard),
            label: Text('Dashboard'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.task),
            label: Text('Tasks'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 13: ListTileTheme + ExpansionTileTheme.
// ---------------------------------------------------------------------------

Widget _listAndExpansion(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    listTileTheme: ListTileThemeData(
      tileColor: _sunriseSurface,
      iconColor: _sunrisePrimary,
      textColor: _ink,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      titleTextStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
      subtitleTextStyle: TextStyle(fontSize: 12.0, color: Colors.black.withValues(alpha: 0.6)),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: _sunriseSurface,
      collapsedBackgroundColor: Colors.white,
      iconColor: _sunrisePrimary,
      collapsedIconColor: _sandPrimary,
      textColor: _sunrisePrimary,
      collapsedTextColor: _ink,
    ),
  );
  return Theme(
    data: theme,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.coffee),
            title: Text('Morning routine'),
            subtitle: Text('7:00 — coffee & news'),
            trailing: Icon(Icons.chevron_right),
          ),
          SizedBox(height: 6.0),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text('Goals'),
            subtitle: Text('Weekly targets'),
            trailing: Icon(Icons.chevron_right),
          ),
          SizedBox(height: 6.0),
          ExpansionTile(
            leading: Icon(Icons.folder),
            title: Text('Projects'),
            subtitle: Text('Tap to expand'),
            children: <Widget>[
              ListTile(title: Text('Atlas Reboot')),
              ListTile(title: Text('Sand Garden')),
              ListTile(title: Text('Ocean Drift')),
            ],
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 14: ProgressIndicatorTheme.
// ---------------------------------------------------------------------------

Widget _progressIndicators(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: _berryPrimary,
      linearTrackColor: _berrySurface,
      circularTrackColor: _berrySurface,
      linearMinHeight: 8.0,
    ),
  );
  return Theme(
    data: theme,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Linear', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 6.0),
                LinearProgressIndicator(value: 0.65),
                SizedBox(height: 12.0),
                LinearProgressIndicator(),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            children: const <Widget>[
              Text('Circular', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 8.0),
              SizedBox(
                width: 48.0,
                height: 48.0,
                child: CircularProgressIndicator(value: 0.6, strokeWidth: 6.0),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 15: SearchBarTheme.
// ---------------------------------------------------------------------------

Widget _searchBarThemed(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all<Color>(_oceanSurface),
      elevation: WidgetStateProperty.all<double>(0.0),
      shape: WidgetStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(color: _oceanPrimary, width: 1.2),
      ),
      hintStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(color: _oceanPrimary, fontStyle: FontStyle.italic),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(color: _ink),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    ),
  );
  return Theme(
    data: theme,
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: SearchBar(
        hintText: 'search the ocean...',
        leading: Icon(Icons.search, color: _oceanPrimary),
        trailing: <Widget>[Icon(Icons.mic, color: _oceanPrimary)],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 16: SegmentedButtonTheme.
// ---------------------------------------------------------------------------

Widget _segmentedButtons(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
          if (s.contains(WidgetState.selected)) return _emberPrimary;
          return _emberSurface;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
          if (s.contains(WidgetState.selected)) return Colors.white;
          return _emberPrimary;
        }),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: _emberPrimary, width: 1.0),
        ),
      ),
    ),
  );
  return Theme(
    data: theme,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: SegmentedButton<int>(
        segments: const <ButtonSegment<int>>[
          ButtonSegment<int>(value: 1, label: Text('Day'), icon: Icon(Icons.wb_sunny)),
          ButtonSegment<int>(value: 2, label: Text('Week'), icon: Icon(Icons.calendar_view_week)),
          ButtonSegment<int>(value: 3, label: Text('Month'), icon: Icon(Icons.calendar_month)),
        ],
        selected: const <int>{2},
        onSelectionChanged: null,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 17: DialogTheme — static mock dialog.
// ---------------------------------------------------------------------------

Widget _mockDialog(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    dialogTheme: DialogThemeData(
      backgroundColor: _sandSurface,
      elevation: 12.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      titleTextStyle: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
        color: _sandPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontSize: 13.5,
        color: _ink,
        height: 1.4,
      ),
    ),
  );
  return Theme(
    data: theme,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: _sandSurface,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 14.0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Discard changes?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: _sandPrimary,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Your draft has unsaved edits. Discarding will return the document '
                'to its last saved state. This action cannot be undone.',
                style: TextStyle(fontSize: 13.5, color: _ink, height: 1.4),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(onPressed: null, child: const Text('CANCEL')),
                  const SizedBox(width: 8.0),
                  FilledButton(
                    onPressed: null,
                    style: FilledButton.styleFrom(backgroundColor: _sandPrimary),
                    child: const Text('DISCARD'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 18: BannerTheme + SnackBarTheme + BottomSheetTheme mock surfaces.
// ---------------------------------------------------------------------------

Widget _bannerMock(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    bannerTheme: const MaterialBannerThemeData(
      backgroundColor: _forestSurface,
      contentTextStyle: TextStyle(color: _forestPrimary, fontWeight: FontWeight.w600),
    ),
  );
  return Theme(
    data: theme,
    child: Container(
      padding: const EdgeInsets.all(14.0),
      color: _forestSurface,
      child: Row(
        children: const <Widget>[
          Icon(Icons.check_circle, color: _forestPrimary),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Saved · synced to cloud',
              style: TextStyle(color: _forestPrimary, fontWeight: FontWeight.w600),
            ),
          ),
          Text('DISMISS', style: TextStyle(color: _forestPrimary, fontWeight: FontWeight.w700)),
        ],
      ),
    ),
  );
}

Widget _snackBarMock(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _ink,
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      actionTextColor: _sunrisePrimary,
    ),
  );
  return Theme(
    data: theme,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: _ink,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: const <Widget>[
            Icon(Icons.info_outline, color: Colors.white, size: 18.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Connection restored',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text('UNDO', style: TextStyle(color: _sunrisePrimary, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    ),
  );
}

Widget _bottomSheetMock(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: _berrySurface,
      modalBackgroundColor: _berrySurface,
      elevation: 8.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.0)),
      ),
    ),
  );
  return Theme(
    data: theme,
    child: Container(
      decoration: const BoxDecoration(
        color: _berrySurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.0)),
      ),
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              width: 36.0,
              height: 4.0,
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                color: _berryPrimary.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const Text(
            'Share via...',
            style: TextStyle(fontWeight: FontWeight.w800, color: _berryPrimary, fontSize: 16.0),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Icon(Icons.mail, color: _berryPrimary, size: 28.0),
              Icon(Icons.chat, color: _berryPrimary, size: 28.0),
              Icon(Icons.link, color: _berryPrimary, size: 28.0),
              Icon(Icons.print, color: _berryPrimary, size: 28.0),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _surfacesRow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _bannerMock(context)),
        const SizedBox(width: 8.0),
        Expanded(child: _snackBarMock(context)),
        const SizedBox(width: 8.0),
        Expanded(child: _bottomSheetMock(context)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 19: "Themed everything" coordinated mini Scaffold.
// ---------------------------------------------------------------------------

Widget _themedEverything(BuildContext context) {
  final ThemeData base = Theme.of(context);
  final ThemeData unified = base.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: _midnightPrimary,
      foregroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1.5,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: _midnightSurface.withValues(alpha: 0.15),
      labelStyle: const TextStyle(color: _midnightPrimary, fontWeight: FontWeight.w600),
      shape: const StadiumBorder(),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) return _midnightPrimary;
        return Colors.grey.shade400;
      }),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: _midnightPrimary,
      thumbColor: _midnightPrimary,
      inactiveTrackColor: Color(0xFFD1D5E0),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: _midnightPrimary,
      textColor: _ink,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: _midnightPrimary.withValues(alpha: 0.18),
      labelTextStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(color: _midnightPrimary, fontSize: 11.0, fontWeight: FontWeight.w600),
      ),
      iconTheme: WidgetStateProperty.all<IconThemeData>(
        const IconThemeData(color: _midnightPrimary),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _midnightPrimary,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
      ),
    ),
  );

  return _miniScaffold(
    label: 'Themed everything · midnight unified',
    height: 360.0,
    theme: unified,
    body: Scaffold(
      backgroundColor: const Color(0xFFF1F2F8),
      appBar: AppBar(title: const Text('Atlas')),
      body: ListView(
        children: <Widget>[
          const Card(
            child: ListTile(
              leading: Icon(Icons.flight_takeoff),
              title: Text('Trip to Lisbon'),
              subtitle: Text('March 12 - 19'),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                spacing: 6.0,
                children: const <Widget>[
                  Chip(label: Text('flight')),
                  Chip(label: Text('hotel')),
                  Chip(label: Text('walk')),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: <Widget>[
                  const Expanded(child: Text('Auto-sync')),
                  Switch(value: true, onChanged: (bool _) {}),
                ],
              ),
            ),
          ),
          const Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Slider(value: 0.5, onChanged: null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('CONFIRM'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 20: BottomAppBar mini.
// ---------------------------------------------------------------------------

Widget _bottomAppBarMini(BuildContext context) {
  final ThemeData theme = Theme.of(context).copyWith(
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: _sunrisePrimary,
      elevation: 6.0,
      shape: CircularNotchedRectangle(),
    ),
  );
  return _miniScaffold(
    label: 'BottomAppBarTheme · sunrise notched',
    theme: theme,
    height: 180.0,
    body: Scaffold(
      backgroundColor: _sunriseSurface,
      body: const Center(child: Icon(Icons.coffee, size: 56.0, color: _sunrisePrimary)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: _sunrisePrimary,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const <Widget>[
            Icon(Icons.menu, color: Colors.white),
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 40.0),
            Icon(Icons.favorite, color: Colors.white),
            Icon(Icons.more_vert, color: Colors.white),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 21: Cheat-sheet.
// ---------------------------------------------------------------------------

class _CheatRow {
  const _CheatRow(this.slot, this.widget, this.fields);
  final String slot;
  final String widget;
  final String fields;
}

Widget _cheatSheet() {
  const List<_CheatRow> rows = <_CheatRow>[
    _CheatRow('appBarTheme', 'AppBar', 'backgroundColor, foregroundColor, elevation, titleTextStyle'),
    _CheatRow('cardTheme', 'Card', 'color, elevation, margin, shape, clipBehavior'),
    _CheatRow('chipTheme', 'Chip, ActionChip, FilterChip', 'backgroundColor, labelStyle, side, shape, padding'),
    _CheatRow('checkboxTheme', 'Checkbox', 'fillColor, checkColor, side, shape'),
    _CheatRow('radioTheme', 'Radio', 'fillColor, overlayColor'),
    _CheatRow('switchTheme', 'Switch', 'thumbColor, trackColor, trackOutlineColor'),
    _CheatRow('sliderTheme', 'Slider', 'activeTrackColor, inactiveTrackColor, thumbColor, trackHeight'),
    _CheatRow('tabBarTheme', 'TabBar', 'labelColor, indicator, labelStyle, unselectedLabelColor'),
    _CheatRow('iconTheme', 'Icon', 'color, size, opacity'),
    _CheatRow('dividerTheme', 'Divider', 'color, thickness, space'),
    _CheatRow('floatingActionButtonTheme', 'FloatingActionButton', 'backgroundColor, foregroundColor, elevation, shape'),
    _CheatRow('bannerTheme', 'MaterialBanner', 'backgroundColor, contentTextStyle'),
    _CheatRow('bottomAppBarTheme', 'BottomAppBar', 'color, elevation, shape'),
    _CheatRow('bottomSheetTheme', 'BottomSheet', 'backgroundColor, elevation, shape'),
    _CheatRow('snackBarTheme', 'SnackBar', 'backgroundColor, contentTextStyle, actionTextColor'),
    _CheatRow('progressIndicatorTheme', 'Linear/CircularProgressIndicator', 'color, linearTrackColor, circularTrackColor'),
    _CheatRow('listTileTheme', 'ListTile', 'tileColor, iconColor, textColor, contentPadding, shape'),
    _CheatRow('expansionTileTheme', 'ExpansionTile', 'backgroundColor, iconColor, textColor (and collapsed*)'),
    _CheatRow('navigationBarTheme', 'NavigationBar', 'backgroundColor, indicatorColor, labelTextStyle, iconTheme'),
    _CheatRow('navigationRailTheme', 'NavigationRail', 'backgroundColor, selected/unselected*, indicatorColor'),
    _CheatRow('navigationDrawerTheme', 'NavigationDrawer', 'backgroundColor, indicatorColor, labelTextStyle'),
    _CheatRow('searchBarTheme', 'SearchBar', 'backgroundColor, shape, side, hintStyle, textStyle'),
    _CheatRow('segmentedButtonTheme', 'SegmentedButton', 'style.backgroundColor, foregroundColor, side'),
    _CheatRow('dialogTheme', 'Dialog, AlertDialog', 'backgroundColor, elevation, shape, titleTextStyle, contentTextStyle'),
  ];

  return Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _ink.withValues(alpha: 0.15)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat sheet: ThemeData slot - widget - typical fields',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.0, color: _ink),
        ),
        const SizedBox(height: 10.0),
        for (final _CheatRow r in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 150.0,
                  child: Text(
                    r.slot,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: _midnightPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  child: Text(
                    r.widget,
                    style: const TextStyle(fontSize: 11.5, color: _ink, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    r.fields,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: _ink.withValues(alpha: 0.7),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// MAIN BUILD
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('ComponentThemeAtlas: building deep visual demo');

  final List<Widget> sections = <Widget>[];

  // SECTION 1: hero header.
  sections.add(_heroHeader());

  // SECTION 2: the pattern.
  sections.add(_sectionTitle('1', 'The pattern: wrap a subtree in Theme(...)', _midnightPrimary));
  sections.add(_narrative(
    'Every per-component slot on ThemeData supplies default styles for one widget type. '
    'You apply a slot locally by wrapping a subtree in Theme(data: ...copyWith(slot: ...)). '
    'The slot then propagates to every matching descendant.',
  ));
  sections.add(_codeSnippetCard(
    'Theme(\n'
    '  data: Theme.of(context).copyWith(\n'
    '    cardTheme: CardThemeData(\n'
    '      color: Colors.indigo.shade50,\n'
    '      elevation: 6,\n'
    '      shape: RoundedRectangleBorder(\n'
    '        borderRadius: BorderRadius.circular(16),\n'
    '      ),\n'
    '    ),\n'
    '  ),\n'
    '  child: Card(child: ...),\n'
    ');',
  ));

  // SECTION 3: AppBarTheme.
  sections.add(_sectionTitle('2', 'AppBarTheme — three palettes', _sunrisePrimary));
  sections.add(_narrative(
    'Each AppBar below lives in its own Theme. The titleTextStyle, backgroundColor, '
    'elevation and shape come from the AppBarTheme, not the AppBar widget.',
  ));
  sections.add(_appBarSunrise(context));
  sections.add(_appBarMidnight(context));
  sections.add(_appBarSand(context));

  // SECTION 4: CardTheme.
  sections.add(_sectionTitle('3', 'CardTheme — flat / lifted / pill', _berryPrimary));
  sections.add(_narrative(
    'CardThemeData controls the surface treatment of every Card in the subtree: '
    'color, elevation, shadowColor, margin, shape and clipBehavior.',
  ));
  sections.add(_cardThemeRow(context));

  // SECTION 5: ChipTheme.
  sections.add(_sectionTitle('4', 'ChipTheme — pill, flat, outlined', _emberPrimary));
  sections.add(_narrative(
    'A Wrap of Chips, each group themed differently. The same Chip widget yields '
    'three very different visual languages depending on the ChipThemeData applied.',
  ));
  sections.add(_chipThemeRow(context));

  // SECTION 6: Selectable controls.
  sections.add(_sectionTitle('5', 'Checkbox / Radio / Switch themes', _forestPrimary));
  sections.add(_narrative(
    'CheckboxThemeData, RadioThemeData and SwitchThemeData each use WidgetState '
    'property objects to resolve colors for selected/disabled/hovered states.',
  ));
  sections.add(_selectableControls(context));

  // SECTION 7: SliderTheme.
  sections.add(_sectionTitle('6', 'SliderTheme — track / thumb', _oceanPrimary));
  sections.add(_narrative(
    'SliderThemeData lets you re-skin the slider entirely without subclassing: '
    'track height, thumb color, value indicator, and active/inactive colors.',
  ));
  sections.add(_slidersRow(context));

  // SECTION 8: TabBarTheme.
  sections.add(_sectionTitle('7', 'TabBarTheme — indicator and label style', _berryPrimary));
  sections.add(_narrative(
    'TabBarThemeData carries labelColor, unselectedLabelColor, labelStyle and indicator. '
    'A single TabBar widget inherits all of this from the closest Theme ancestor.',
  ));
  sections.add(_tabBarDemo(context));

  // SECTION 9: IconTheme.
  sections.add(_sectionTitle('8', 'IconTheme — size and color', _emberPrimary));
  sections.add(_narrative(
    'IconThemeData propagates color, size and opacity to every Icon below. Three '
    'strips below use the same icons but different IconThemeData values.',
  ));
  sections.add(_iconStripsColumn(context));

  // SECTION 10: DividerTheme.
  sections.add(_sectionTitle('9', 'DividerTheme — thickness and color', _slatePrimary));
  sections.add(_narrative(
    'DividerThemeData controls color, thickness and the vertical space the divider '
    'reserves. Stacked together they produce a clear visual hierarchy.',
  ));
  sections.add(_dividersColumn(context));

  // SECTION 11: FAB theme.
  sections.add(_sectionTitle('10', 'FloatingActionButtonTheme — three personalities', _berryPrimary));
  sections.add(_narrative(
    'FloatingActionButtonThemeData provides backgroundColor, foregroundColor, '
    'elevation and shape. Useful when several FABs across the app must agree.',
  ));
  sections.add(_fabRow(context));

  // SECTION 12: Navigation themes.
  sections.add(_sectionTitle('11', 'Navigation themes — Bar, Rail, Drawer', _oceanPrimary));
  sections.add(_narrative(
    'NavigationBarThemeData, NavigationRailThemeData and NavigationDrawerThemeData '
    'each ship label/icon WidgetStateProperty objects, plus backgroundColor and indicatorColor.',
  ));
  sections.add(_navBarMini(context));
  sections.add(_navRailMini(context));
  sections.add(_navDrawerMini(context));

  // SECTION 13: ListTile + ExpansionTile themes.
  sections.add(_sectionTitle('12', 'ListTileTheme + ExpansionTileTheme', _sunrisePrimary));
  sections.add(_narrative(
    'ListTileThemeData and ExpansionTileThemeData together let you give a whole '
    'list section a consistent typography, color and spacing without per-tile props.',
  ));
  sections.add(_listAndExpansion(context));

  // SECTION 14: ProgressIndicatorTheme.
  sections.add(_sectionTitle('13', 'ProgressIndicatorTheme — linear & circular', _berryPrimary));
  sections.add(_narrative(
    'ProgressIndicatorThemeData covers both LinearProgressIndicator and '
    'CircularProgressIndicator: color, track colors and the linear minHeight.',
  ));
  sections.add(_progressIndicators(context));

  // SECTION 15: SearchBarTheme.
  sections.add(_sectionTitle('14', 'SearchBarTheme — stadium shell', _oceanPrimary));
  sections.add(_narrative(
    'SearchBarThemeData uses WidgetStateProperty for every field — backgroundColor, '
    'elevation, shape, side, hintStyle and textStyle resolve per interaction state.',
  ));
  sections.add(_searchBarThemed(context));

  // SECTION 16: SegmentedButtonTheme.
  sections.add(_sectionTitle('15', 'SegmentedButtonTheme — ember segments', _emberPrimary));
  sections.add(_narrative(
    'SegmentedButtonThemeData wraps a ButtonStyle. Selected segments resolve to one '
    'color set; unselected segments resolve to another. One slot, full state machine.',
  ));
  sections.add(_segmentedButtons(context));

  // SECTION 17: DialogTheme.
  sections.add(_sectionTitle('16', 'DialogTheme — mock confirm dialog', _sandPrimary));
  sections.add(_narrative(
    'A static Card mocked up to mirror what showDialog would produce given the '
    'DialogThemeData below: backgroundColor, elevation, shape, titleTextStyle, contentTextStyle.',
  ));
  sections.add(_mockDialog(context));

  // SECTION 18: Banner / SnackBar / BottomSheet.
  sections.add(_sectionTitle('17', 'Banner / SnackBar / BottomSheet themes', _forestPrimary));
  sections.add(_narrative(
    'Three transient surfaces side-by-side, each themed from a single ThemeData '
    'slot. Real dispatch (showSnackBar etc.) is omitted; the visual contract is what matters.',
  ));
  sections.add(_surfacesRow(context));

  // SECTION 19: BottomAppBar theme.
  sections.add(_sectionTitle('18', 'BottomAppBarTheme — notched sunrise', _sunrisePrimary));
  sections.add(_narrative(
    'BottomAppBarThemeData stores color, elevation and shape. Combined with a '
    'centerDocked FAB you get the classic notched dock — all driven by theme data.',
  ));
  sections.add(_bottomAppBarMini(context));

  // SECTION 20: themed everything.
  sections.add(_sectionTitle('19', 'Themed everything — one unified palette', _midnightPrimary));
  sections.add(_narrative(
    'A single ThemeData drives the AppBar, Cards, Chips, Switch, Slider, '
    'ElevatedButton and NavigationBar. Change one base color and the whole '
    'mini app re-skins consistently.',
  ));
  sections.add(_themedEverything(context));

  // SECTION 21: cheat sheet.
  sections.add(_sectionTitle('20', 'Cheat sheet — slot · widget · fields', _ink));
  sections.add(_narrative(
    'A condensed reference: every slot demoed above mapped to its widget and the '
    'fields you will tweak most often when shaping an app theme.',
  ));
  sections.add(_cheatSheet());

  // SECTION 22: closing.
  sections.add(_sectionTitle('21', 'Atlas closing', _slatePrimary));
  sections.add(_narrative(
    'Component theme slots are the lowest-friction way to enforce a design system: '
    'set them once at the app root (or per subtree) and let every widget pick up '
    'the right defaults. No per-widget overrides, no inconsistencies, no copy-paste.',
  ));
  sections.add(const SizedBox(height: 24.0));

  return Scaffold(
    backgroundColor: _paper,
    body: SafeArea(
      child: ListView(children: sections),
    ),
  );
}
