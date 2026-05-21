// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests lesser-known Material theme data classes
// Deep Demo: Visual side-by-side comparison of default vs themed Material widgets

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Misc Material Themes Deep Demo executing');

  // ============================================================
  // Base ThemeData — all themed sections copyWith from this so
  // unrelated theming stays consistent across the demo.
  // ============================================================
  final baseTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.light,
  );
  print('Base ThemeData created (Material 3, indigo seed)');

  // ============================================================
  // SECTION 1: Overview & Concept Cards
  // ============================================================
  print('=== Section 1: Overview of Material Theme Data Classes ===');

  final overviewIntro = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette_outlined, color: Colors.indigo, size: 28.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Lesser-known Material Theme Data classes',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Each section shows the BEFORE (default) and AFTER (themed) variant '
          'of a widget. Themed variants wrap the widget in Theme(data: baseTheme.copyWith(...)).',
          style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
        ),
      ],
    ),
  );

  final overviewCards = <Widget>[];

  overviewCards.add(
    _conceptCard(
      icon: Icons.label_outline,
      title: 'ChipThemeData',
      desc: 'Style Chip, ActionChip, InputChip uniformly',
      color: Colors.teal,
    ),
  );
  overviewCards.add(
    _conceptCard(
      icon: Icons.notifications_active_outlined,
      title: 'BadgeThemeData',
      desc: 'Customise small/large badges & offsets',
      color: Colors.red,
    ),
  );
  overviewCards.add(
    _conceptCard(
      icon: Icons.list_alt,
      title: 'ListTileThemeData',
      desc: 'Color, density and shape for ListTile',
      color: Colors.deepPurple,
    ),
  );
  overviewCards.add(
    _conceptCard(
      icon: Icons.linear_scale,
      title: 'ProgressIndicatorThemeData',
      desc: 'Linear / Circular indicator colours',
      color: Colors.orange,
    ),
  );
  overviewCards.add(
    _conceptCard(
      icon: Icons.info_outline,
      title: 'TooltipThemeData',
      desc: 'Bubble decoration & text style',
      color: Colors.brown,
    ),
  );
  overviewCards.add(
    _conceptCard(
      icon: Icons.search,
      title: 'SearchBarThemeData',
      desc: 'Elevation, shape, padding for SearchBar',
      color: Colors.cyan,
    ),
  );
  overviewCards.add(
    _conceptCard(
      icon: Icons.view_week_outlined,
      title: 'SegmentedButtonThemeData',
      desc: 'Selected / unselected segment style',
      color: Colors.green,
    ),
  );

  print('Created ${overviewCards.length} overview concept cards');

  // ============================================================
  // SECTION 2: ChipThemeData — Chip, ActionChip, InputChip
  // ============================================================
  print('=== Section 2: ChipThemeData (Chip, ActionChip, InputChip) ===');

  final chipThemeData = ChipThemeData(
    backgroundColor: Colors.teal.shade50,
    selectedColor: Colors.teal.shade300,
    disabledColor: Colors.grey.shade200,
    labelStyle: TextStyle(
      color: Colors.teal.shade900,
      fontWeight: FontWeight.w600,
    ),
    secondaryLabelStyle: TextStyle(color: Colors.white),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    side: BorderSide(color: Colors.teal.shade400, width: 1.2),
    shape: StadiumBorder(),
    iconTheme: IconThemeData(color: Colors.teal.shade700, size: 18.0),
    elevation: 1.0,
    pressElevation: 4.0,
    secondarySelectedColor: Colors.teal.shade700,
  );
  print('ChipThemeData built — selectedColor: ${chipThemeData.selectedColor}');

  Widget chipRow() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: <Widget>[
        Chip(
          avatar: Icon(Icons.tag, size: 18.0),
          label: Text('Chip'),
        ),
        ActionChip(
          avatar: Icon(Icons.bolt, size: 18.0),
          label: Text('Action'),
          onPressed: () {},
        ),
        InputChip(
          avatar: Icon(Icons.face, size: 18.0),
          label: Text('Input'),
          selected: true,
          onSelected: (_) {},
        ),
        InputChip(
          label: Text('Disabled'),
          onPressed: null,
        ),
      ],
    );
  }

  final chipSection = _beforeAfter(
    title: '2. ChipThemeData',
    accent: Colors.teal,
    beforeLabel: 'Default chips',
    afterLabel: 'Themed chips (stadium, teal palette)',
    before: chipRow(),
    after: Theme(
      data: baseTheme.copyWith(chipTheme: chipThemeData),
      child: chipRow(),
    ),
  );

  // ============================================================
  // SECTION 3: BadgeThemeData — Badge on icons
  // ============================================================
  print('=== Section 3: BadgeThemeData (Badge on icons) ===');

  final badgeThemeData = BadgeThemeData(
    backgroundColor: Colors.red.shade700,
    textColor: Colors.white,
    smallSize: 8.0,
    largeSize: 18.0,
    textStyle: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    padding: EdgeInsets.symmetric(horizontal: 5.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(2.0, -4.0),
  );
  print(
    'BadgeThemeData built — large: ${badgeThemeData.largeSize}, small: ${badgeThemeData.smallSize}',
  );

  Widget badgeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Badge(
          label: Text('3'),
          child: Icon(Icons.mail, size: 36.0, color: Colors.grey.shade700),
        ),
        Badge(
          label: Text('99+'),
          child: Icon(Icons.notifications, size: 36.0, color: Colors.grey.shade700),
        ),
        Badge.count(
          count: 12,
          child: Icon(Icons.shopping_cart, size: 36.0, color: Colors.grey.shade700),
        ),
        Badge(
          child: Icon(Icons.chat_bubble_outline,
              size: 36.0, color: Colors.grey.shade700),
        ),
      ],
    );
  }

  final badgeSection = _beforeAfter(
    title: '3. BadgeThemeData',
    accent: Colors.red,
    beforeLabel: 'Default badges',
    afterLabel: 'Themed badges (red.700, large 18 px, bold)',
    before: badgeRow(),
    after: Theme(
      data: baseTheme.copyWith(badgeTheme: badgeThemeData),
      child: badgeRow(),
    ),
  );

  // ============================================================
  // SECTION 4: ListTileThemeData — four list tiles
  // ============================================================
  print('=== Section 4: ListTileThemeData (4 list tiles) ===');

  final listTileThemeData = ListTileThemeData(
    tileColor: Colors.deepPurple.shade50,
    selectedTileColor: Colors.deepPurple.shade100,
    iconColor: Colors.deepPurple.shade700,
    selectedColor: Colors.deepPurple.shade900,
    textColor: Colors.deepPurple.shade900,
    titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
    subtitleTextStyle: TextStyle(fontSize: 12.0, color: Colors.deepPurple.shade400),
    contentPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    horizontalTitleGap: 12.0,
    minVerticalPadding: 8.0,
    dense: false,
  );
  print('ListTileThemeData built — tileColor: ${listTileThemeData.tileColor}');

  final tileItems = <Map<String, dynamic>>[
    {'icon': Icons.cloud_outlined, 'title': 'Cloud sync', 'sub': 'Last synced 2m ago'},
    {'icon': Icons.lock_outline, 'title': 'Security', 'sub': 'Passcode enabled'},
    {'icon': Icons.notifications_none, 'title': 'Notifications', 'sub': 'Push & email'},
    {'icon': Icons.language, 'title': 'Language', 'sub': 'English (US)'},
  ];

  Widget tileList({required bool selectIndex2}) {
    final widgets = <Widget>[];
    for (int i = 0; i < tileItems.length; i++) {
      final it = tileItems[i];
      widgets.add(
        ListTile(
          leading: Icon(it['icon'] as IconData),
          title: Text(it['title'] as String),
          subtitle: Text(it['sub'] as String),
          trailing: Icon(Icons.chevron_right),
          selected: selectIndex2 && i == 1,
          onTap: () {},
        ),
      );
      if (i != tileItems.length - 1) {
        widgets.add(Divider(height: 1.0));
      }
    }
    return Column(mainAxisSize: MainAxisSize.min, children: widgets);
  }

  final listTileSection = _beforeAfter(
    title: '4. ListTileThemeData',
    accent: Colors.deepPurple,
    beforeLabel: 'Default ListTiles',
    afterLabel: 'Themed ListTiles (purple wash, rounded)',
    before: tileList(selectIndex2: true),
    after: Theme(
      data: baseTheme.copyWith(listTileTheme: listTileThemeData),
      child: tileList(selectIndex2: true),
    ),
  );

  // ============================================================
  // SECTION 5: ProgressIndicatorThemeData — Linear + Circular
  // ============================================================
  print('=== Section 5: ProgressIndicatorThemeData (Linear + Circular) ===');

  final progressThemeData = ProgressIndicatorThemeData(
    color: Colors.orange.shade700,
    linearTrackColor: Colors.orange.shade100,
    circularTrackColor: Colors.orange.shade100,
    linearMinHeight: 10.0,
    refreshBackgroundColor: Colors.orange.shade50,
  );
  print(
    'ProgressIndicatorThemeData built — color: ${progressThemeData.color}, '
    'linearMinHeight: ${progressThemeData.linearMinHeight}',
  );

  Widget progressBlock({required double value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Linear @ ${(value * 100).toInt()}%',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
          SizedBox(height: 6.0),
          LinearProgressIndicator(value: value),
          SizedBox(height: 12.0),
          Text('Linear indeterminate',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
          SizedBox(height: 6.0),
          LinearProgressIndicator(),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(value: value, strokeWidth: 4.0),
              ),
              SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(strokeWidth: 4.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final progressSection = _beforeAfter(
    title: '5. ProgressIndicatorThemeData',
    accent: Colors.orange,
    beforeLabel: 'Default indicators',
    afterLabel: 'Themed (orange, 10 px linear track)',
    before: progressBlock(value: 0.55),
    after: Theme(
      data: baseTheme.copyWith(progressIndicatorTheme: progressThemeData),
      child: progressBlock(value: 0.55),
    ),
  );

  // ============================================================
  // SECTION 6: TooltipThemeData — themed tooltip bubble
  // ============================================================
  print('=== Section 6: TooltipThemeData (themed tooltip on button) ===');

  final tooltipThemeData = TooltipThemeData(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.brown.shade700, Colors.brown.shade500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    waitDuration: Duration(milliseconds: 200),
    showDuration: Duration(seconds: 3),
    preferBelow: true,
    verticalOffset: 16.0,
  );
  print(
    'TooltipThemeData built — wait: ${tooltipThemeData.waitDuration}, '
    'show: ${tooltipThemeData.showDuration}',
  );

  Widget tooltipBlock({required bool themed}) {
    // A static rendering of the tooltip bubble so the visual
    // demo is visible without hover/long-press.
    final bubbleStyle = themed
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown.shade700, Colors.brown.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8.0,
                offset: Offset(0, 4),
              ),
            ],
          )
        : BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(4.0),
          );
    final bubbleText = themed
        ? TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          )
        : TextStyle(color: Colors.white, fontSize: 11.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Tooltip(
          message: themed ? 'Themed tooltip!' : 'Default tooltip',
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.info_outline),
            label: Text('Hover me'),
          ),
        ),
        SizedBox(height: 12.0),
        // Static preview of the tooltip bubble for visibility
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: bubbleStyle,
          child: Text(
            themed ? 'Themed tooltip!' : 'Default tooltip',
            style: bubbleText,
          ),
        ),
        SizedBox(height: 4.0),
        Icon(Icons.arrow_drop_up,
            color: themed ? Colors.brown.shade600 : Colors.grey.shade800),
      ],
    );
  }

  final tooltipSection = _beforeAfter(
    title: '6. TooltipThemeData',
    accent: Colors.brown,
    beforeLabel: 'Default tooltip',
    afterLabel: 'Themed (gradient bubble, bold text)',
    before: tooltipBlock(themed: false),
    after: Theme(
      data: baseTheme.copyWith(tooltipTheme: tooltipThemeData),
      child: tooltipBlock(themed: true),
    ),
  );

  // ============================================================
  // SECTION 7: SearchBarThemeData
  // ============================================================
  print('=== Section 7: SearchBarThemeData ===');

  final searchBarThemeData = SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(Colors.cyan.shade50),
    elevation: WidgetStateProperty.all(2.0),
    shadowColor: WidgetStateProperty.all(Colors.cyan.shade200),
    surfaceTintColor: WidgetStateProperty.all(Colors.cyan.shade100),
    overlayColor:
        WidgetStateProperty.all(Colors.cyan.withValues(alpha: 0.12)),
    side: WidgetStateProperty.all(
      BorderSide(color: Colors.cyan.shade400, width: 1.0),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 16.0),
    ),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 14.0, color: Colors.cyan.shade900),
    ),
    hintStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 14.0, color: Colors.cyan.shade400),
    ),
    constraints: BoxConstraints(minHeight: 48.0, maxWidth: 360.0),
  );
  print('SearchBarThemeData built');

  Widget searchBarBlock() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: SearchBar(
        hintText: 'Search documents…',
        leading: Icon(Icons.search),
        trailing: <Widget>[
          IconButton(icon: Icon(Icons.mic_none), onPressed: () {}),
        ],
      ),
    );
  }

  final searchSection = _beforeAfter(
    title: '7. SearchBarThemeData',
    accent: Colors.cyan,
    beforeLabel: 'Default SearchBar',
    afterLabel: 'Themed (cyan tint, rounded 14)',
    before: searchBarBlock(),
    after: Theme(
      data: baseTheme.copyWith(searchBarTheme: searchBarThemeData),
      child: searchBarBlock(),
    ),
  );

  // ============================================================
  // SECTION 8: SegmentedButtonThemeData
  // ============================================================
  print('=== Section 8: SegmentedButtonThemeData ===');

  final segmentedButtonThemeData = SegmentedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.green.shade600;
        return Colors.green.shade50;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return Colors.green.shade900;
      }),
      side: WidgetStateProperty.all(BorderSide(color: Colors.green.shade600)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      ),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
      ),
    ),
    selectedIcon: Icon(Icons.check_circle, size: 18.0),
  );
  print('SegmentedButtonThemeData built');

  Widget segmentedBlock() {
    return Center(
      child: SegmentedButton<int>(
        segments: const <ButtonSegment<int>>[
          ButtonSegment(value: 0, label: Text('Day'), icon: Icon(Icons.today)),
          ButtonSegment(value: 1, label: Text('Week'), icon: Icon(Icons.view_week)),
          ButtonSegment(value: 2, label: Text('Month'), icon: Icon(Icons.calendar_month)),
        ],
        selected: const <int>{1},
        onSelectionChanged: (_) {},
        showSelectedIcon: true,
      ),
    );
  }

  final segmentedSection = _beforeAfter(
    title: '8. SegmentedButtonThemeData',
    accent: Colors.green,
    beforeLabel: 'Default segments',
    afterLabel: 'Themed (green fill, rounded 20)',
    before: segmentedBlock(),
    after: Theme(
      data: baseTheme.copyWith(segmentedButtonTheme: segmentedButtonThemeData),
      child: segmentedBlock(),
    ),
  );

  // ============================================================
  // SECTION 9: Code panels — ThemeData construction
  // ============================================================
  print('=== Section 9: Code Examples ===');

  final codePanels = <Widget>[];
  codePanels.add(
    _codeBlock(
      label: 'ChipThemeData',
      accent: Colors.teal,
      code:
          "final chipTheme = ChipThemeData(\n"
          "  backgroundColor: Colors.teal.shade50,\n"
          "  selectedColor: Colors.teal.shade300,\n"
          "  side: BorderSide(color: Colors.teal.shade400),\n"
          "  shape: StadiumBorder(),\n"
          ");\n"
          "Theme(\n"
          "  data: baseTheme.copyWith(chipTheme: chipTheme),\n"
          "  child: Chip(label: Text('Chip')),\n"
          ");",
    ),
  );
  codePanels.add(
    _codeBlock(
      label: 'BadgeThemeData',
      accent: Colors.red,
      code:
          "final badgeTheme = BadgeThemeData(\n"
          "  backgroundColor: Colors.red.shade700,\n"
          "  largeSize: 18.0,\n"
          "  textStyle: TextStyle(\n"
          "    fontWeight: FontWeight.bold,\n"
          "    color: Colors.white,\n"
          "  ),\n"
          ");",
    ),
  );
  codePanels.add(
    _codeBlock(
      label: 'ListTileThemeData',
      accent: Colors.deepPurple,
      code:
          "final listTileTheme = ListTileThemeData(\n"
          "  tileColor: Colors.deepPurple.shade50,\n"
          "  selectedTileColor: Colors.deepPurple.shade100,\n"
          "  shape: RoundedRectangleBorder(\n"
          "    borderRadius: BorderRadius.circular(12.0),\n"
          "  ),\n"
          ");",
    ),
  );
  codePanels.add(
    _codeBlock(
      label: 'TooltipThemeData',
      accent: Colors.brown,
      code:
          "final tooltipTheme = TooltipThemeData(\n"
          "  decoration: BoxDecoration(\n"
          "    gradient: LinearGradient(...),\n"
          "    borderRadius: BorderRadius.circular(8),\n"
          "  ),\n"
          "  textStyle: TextStyle(\n"
          "    color: Colors.white,\n"
          "    fontWeight: FontWeight.w600,\n"
          "  ),\n"
          "  waitDuration: Duration(milliseconds: 200),\n"
          ");",
    ),
  );
  codePanels.add(
    _codeBlock(
      label: 'SearchBarThemeData',
      accent: Colors.cyan,
      code:
          "final searchTheme = SearchBarThemeData(\n"
          "  backgroundColor: WidgetStateProperty.all(\n"
          "    Colors.cyan.shade50,\n"
          "  ),\n"
          "  elevation: WidgetStateProperty.all(2.0),\n"
          "  shape: WidgetStateProperty.all(\n"
          "    RoundedRectangleBorder(\n"
          "      borderRadius: BorderRadius.circular(14),\n"
          "    ),\n"
          "  ),\n"
          ");",
    ),
  );
  codePanels.add(
    _codeBlock(
      label: 'SegmentedButtonThemeData',
      accent: Colors.green,
      code:
          "final segTheme = SegmentedButtonThemeData(\n"
          "  style: ButtonStyle(\n"
          "    backgroundColor:\n"
          "      WidgetStateProperty.resolveWith((s) {\n"
          "        if (s.contains(WidgetState.selected))\n"
          "          return Colors.green.shade600;\n"
          "        return Colors.green.shade50;\n"
          "      }),\n"
          "  ),\n"
          "  selectedIcon: Icon(Icons.check_circle),\n"
          ");",
    ),
  );

  print('Created ${codePanels.length} code panels');

  // ============================================================
  // SECTION 10: Summary takeaways
  // ============================================================
  print('=== Section 10: Summary ===');

  final summary = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Icon(Icons.summarize_outlined, color: Colors.indigo, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Key takeaways',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _summaryItem(Icons.layers_outlined, 'Theme.copyWith preserves rest',
            'Always copy from a base ThemeData so unrelated theming stays consistent.',
            Colors.indigo),
        SizedBox(height: 8.0),
        _summaryItem(Icons.tune, 'Scoped Theme widgets',
            'Wrap a sub-tree in Theme(data: …) to apply only locally.',
            Colors.teal),
        SizedBox(height: 8.0),
        _summaryItem(Icons.brush_outlined, 'WidgetStateProperty for stateful theming',
            'SearchBar / SegmentedButton expose state-resolved properties.',
            Colors.orange),
        SizedBox(height: 8.0),
        _summaryItem(Icons.bug_report_outlined, 'Lesser-known but powerful',
            'Tooltip, Badge, ProgressIndicator themes are easy to overlook.',
            Colors.red),
        SizedBox(height: 8.0),
        _summaryItem(Icons.check_circle_outline, 'Material 3 ready',
            'All theme data classes work seamlessly with useMaterial3: true.',
            Colors.green),
      ],
    ),
  );

  print('Misc Material Themes Deep Demo completed successfully');

  // ============================================================
  // Assemble & return
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Icon(Icons.palette, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'Misc Material Themes',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Default vs Themed — side-by-side',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1 — overview
        Text(
          '1. Overview',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        overviewIntro,
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: overviewCards),
        SizedBox(height: 32.0),

        // Section 2..8 — before/after pairs
        chipSection,
        SizedBox(height: 24.0),
        badgeSection,
        SizedBox(height: 24.0),
        listTileSection,
        SizedBox(height: 24.0),
        progressSection,
        SizedBox(height: 24.0),
        tooltipSection,
        SizedBox(height: 24.0),
        searchSection,
        SizedBox(height: 24.0),
        segmentedSection,
        SizedBox(height: 32.0),

        // Section 9 — code
        Text(
          '9. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...codePanels,
        SizedBox(height: 24.0),

        // Section 10 — summary
        Text(
          '10. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summary,
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Helpers — local to this script
// ----------------------------------------------------------------

Widget _conceptCard({
  required IconData icon,
  required String title,
  required String desc,
  required Color color,
}) {
  return Container(
    width: 170.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          desc,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _beforeAfter({
  required String title,
  required Color accent,
  required String beforeLabel,
  required String afterLabel,
  required Widget before,
  required Widget after,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 12.0),
      LayoutBuilder(
        builder: (ctx, constraints) {
          final isWide = constraints.maxWidth >= 720.0;
          final beforeCard = _comparisonCard(
            label: beforeLabel,
            tagColor: Colors.grey.shade600,
            accent: accent,
            child: before,
            isDefault: true,
          );
          final afterCard = _comparisonCard(
            label: afterLabel,
            tagColor: accent,
            accent: accent,
            child: after,
            isDefault: false,
          );
          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: beforeCard),
                SizedBox(width: 12.0),
                Expanded(child: afterCard),
              ],
            );
          }
          return Column(
            children: <Widget>[
              beforeCard,
              SizedBox(height: 12.0),
              afterCard,
            ],
          );
        },
      ),
    ],
  );
}

Widget _comparisonCard({
  required String label,
  required Color tagColor,
  required Color accent,
  required Widget child,
  required bool isDefault,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: isDefault
            ? Colors.grey.shade300
            : accent.withValues(alpha: 0.6),
        width: 1.5,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Tag bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: tagColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11.0),
              topRight: Radius.circular(11.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                isDefault ? Icons.style_outlined : Icons.auto_awesome,
                color: tagColor,
                size: 16.0,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: tagColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: tagColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  isDefault ? 'DEFAULT' : 'THEMED',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    color: tagColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: child,
        ),
      ],
    ),
  );
}

Widget _codeBlock({
  required String label,
  required Color accent,
  required String code,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.25),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.code, color: Colors.white, size: 16.0),
              SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _summaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
