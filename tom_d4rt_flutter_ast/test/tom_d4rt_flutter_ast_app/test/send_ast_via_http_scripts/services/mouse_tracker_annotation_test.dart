// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MouseTrackerAnnotation, MouseRegion, PointerEnter/Exit/Hover
// events, and the MouseCursor hierarchy from package:flutter/services.dart and
// package:flutter/widgets.dart.
//
// Deep Demo theme: "The Lighthouse Keeper's Optic". The mouse tracker is cast
// as a rotating Fresnel lens whose beam sweeps the chart room. Annotations are
// the lighthouse keeper's logbook entries (cursor sigils + enter/exit
// callbacks); MouseRegion is the brass-rimmed observation window; the pointer
// events are vessels passing through the light cone.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('MouseTrackerAnnotation Deep Demo executing');
  print('Theme: Lighthouse Keeper\'s Optic — annotation is the logbook entry,');
  print('MouseRegion is the brass observation window, pointer events are ships.');

  // ============================================================
  // Brass + sea palette used across the demo.
  // ============================================================
  final brassDark = Color(0xFF6B4A1A);
  final brassMid = Color(0xFFB08542);
  final brassLight = Color(0xFFE9C880);
  final seaDeep = Color(0xFF0E2A3A);
  final seaMid = Color(0xFF1F4E63);
  final beamCore = Color(0xFFFFE9A8);
  final beamHalo = Color(0xFFFFC85A);
  final lacquer = Color(0xFF2B1810);

  // ============================================================
  // SECTION 1: Annotation Contract anatomy
  // ============================================================
  print('=== Section 1: Annotation contract anatomy ===');

  final probeAnnotation = MouseTrackerAnnotation(
    onEnter: (PointerEnterEvent event) {
      print('logbook: vessel sighted at ${event.position}');
    },
    onExit: (PointerExitEvent event) {
      print('logbook: vessel cleared the beam at ${event.position}');
    },
    cursor: SystemMouseCursors.click,
  );
  print('probe annotation runtimeType: ${probeAnnotation.runtimeType}');
  print('probe annotation cursor: ${probeAnnotation.cursor}');
  print('probe annotation validForMouseTracker: '
      '${probeAnnotation.validForMouseTracker}');
  print('probe annotation has onEnter: ${probeAnnotation.onEnter != null}');
  print('probe annotation has onExit: ${probeAnnotation.onExit != null}');

  final contractAnatomy = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [seaDeep, seaMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: brassMid, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: lacquer.withValues(alpha: 0.55),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: brassDark.withValues(alpha: 0.30),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: beamCore, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'MouseTrackerAnnotation — keeper\'s logbook entry',
              style: TextStyle(
                color: beamCore,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _anatomyRow(
          'cursor',
          'MouseCursor',
          'Sigil to display while pointer rests inside the beam.',
          Icons.mouse,
          brassLight,
        ),
        _anatomyRow(
          'onEnter',
          'PointerEnterEventListener?',
          'Fired when a vessel first crosses the rim of the lens.',
          Icons.login,
          Colors.lightGreenAccent,
        ),
        _anatomyRow(
          'onExit',
          'PointerExitEventListener?',
          'Fired the instant the vessel slips beyond the optic.',
          Icons.logout,
          Colors.orangeAccent,
        ),
        _anatomyRow(
          'validForMouseTracker',
          'bool',
          'False during teardown — the keeper has dimmed the lamp.',
          Icons.verified,
          Colors.cyanAccent,
        ),
      ],
    ),
  );
  print('Created annotation contract anatomy panel');

  // ============================================================
  // SECTION 2: Enter / Hover / Exit lifecycle tree
  // ============================================================
  print('=== Section 2: Enter / Hover / Exit lifecycle tree ===');

  final lifecycleTree = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [beamCore.withValues(alpha: 0.35), seaDeep],
        center: Alignment.topCenter,
        radius: 1.2,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: brassMid, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: beamHalo.withValues(alpha: 0.20),
          blurRadius: 24.0,
          offset: Offset(0.0, 0.0),
        ),
        BoxShadow(
          color: lacquer.withValues(alpha: 0.50),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'POINTER LIFECYCLE THROUGH THE BEAM',
          style: TextStyle(
            color: beamCore,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.6,
          ),
        ),
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eventNode(
              'PointerEnterEvent',
              'first contact',
              Icons.flight_land,
              Colors.lightGreenAccent,
              brassDark,
            ),
            _arrowGlyph(Icons.east, beamCore),
            _eventNode(
              'PointerHoverEvent',
              'sweeping inside',
              Icons.radar,
              beamHalo,
              brassDark,
            ),
            _arrowGlyph(Icons.east, beamCore),
            _eventNode(
              'PointerExitEvent',
              'slips the rim',
              Icons.flight_takeoff,
              Colors.orangeAccent,
              brassDark,
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: lacquer.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: brassMid.withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logLine('00:00.000', 'PointerEnterEvent', 'pos (40,80)',
                  Colors.lightGreenAccent),
              _logLine('00:00.016', 'PointerHoverEvent', 'pos (52,80)',
                  beamHalo),
              _logLine('00:00.033', 'PointerHoverEvent', 'pos (64,80)',
                  beamHalo),
              _logLine('00:00.060', 'PointerExitEvent', 'pos (180,80)',
                  Colors.orangeAccent),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created lifecycle tree panel');

  // ============================================================
  // SECTION 3: PointerEnter / Hover / Exit field matrix
  // ============================================================
  print('=== Section 3: Pointer event field matrix ===');

  final pointerFields = <List<String>>[
    <String>['position', 'Offset', 'world coords on the chart'],
    <String>['localPosition', 'Offset', 'coords inside the optic frame'],
    <String>['delta', 'Offset', 'movement since previous beam slice'],
    <String>['kind', 'PointerDeviceKind', 'mouse, stylus, touch...'],
    <String>['device', 'int', 'channel id of the lookout'],
    <String>['buttons', 'int', 'bitmask of pressed levers'],
    <String>['pressure', 'double', 'tincture pressure on the chart'],
    <String>['orientation', 'double', 'azimuth of stylus in radians'],
  ];

  final pointerMatrix = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: brassLight.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brassMid, width: 1.5),
      gradient: LinearGradient(
        colors: [
          brassLight.withValues(alpha: 0.20),
          brassDark.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: brassDark.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pointer event payload (shared by enter / hover / exit)',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: brassDark,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: brassDark.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildHeaderCell('field', 130.0, beamCore),
              _buildHeaderCell('type', 150.0, beamCore),
              _buildHeaderCell('keeper\'s reading', 220.0, beamCore),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (int i = 0; i < pointerFields.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: i.isEven
                  ? brassLight.withValues(alpha: 0.15)
                  : Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: brassMid.withValues(alpha: 0.35),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                _buildDataCell(pointerFields[i][0], 130.0, brassDark, true),
                _buildDataCell(pointerFields[i][1], 150.0, lacquer, false),
                _buildDataCell(pointerFields[i][2], 220.0, lacquer, false),
              ],
            ),
          ),
      ],
    ),
  );
  print('Created pointer field matrix with ${pointerFields.length} rows');

  // ============================================================
  // SECTION 4: Cursor cascade — Defer / SystemMouseCursor / MaterialState
  // ============================================================
  print('=== Section 4: Cursor cascade diagram ===');

  final deferCursor = MouseCursor.defer;
  final clickCursor = SystemMouseCursors.click;
  final basicCursor = SystemMouseCursors.basic;
  print('MouseCursor.defer: $deferCursor');
  print('SystemMouseCursors.click: $clickCursor');
  print('SystemMouseCursors.basic: $basicCursor');

  final cascadeDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [seaMid, seaDeep],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: brassLight, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: lacquer.withValues(alpha: 0.55),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'CURSOR CASCADE — from sigil to system call',
          style: TextStyle(
            color: beamCore,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 18.0),
        _cascadeNode(
          'MouseRegion(cursor: ...)',
          'Top of the beam — declared on the widget',
          Icons.crop_square,
          brassLight,
          beamCore,
        ),
        _arrowDown(beamCore),
        _cascadeNode(
          'MouseTrackerAnnotation.cursor',
          'Compiled into the keeper\'s logbook entry',
          Icons.menu_book,
          brassMid,
          beamCore,
        ),
        _arrowDown(beamCore),
        _cascadeNode(
          'DeferringMouseCursor (MouseCursor.defer)',
          'Skipped — let an ancestor speak instead',
          Icons.skip_next,
          Colors.cyanAccent,
          seaDeep,
        ),
        _arrowDown(beamCore),
        _cascadeNode(
          'MaterialStateMouseCursor.resolve(states)',
          'Stateful sigil — hovered / pressed / disabled',
          Icons.swap_horiz,
          Colors.pinkAccent.shade100,
          seaDeep,
        ),
        _arrowDown(beamCore),
        _cascadeNode(
          'SystemMouseCursor("click")',
          'Native lighthouse signal — OS chooses the bitmap',
          Icons.touch_app,
          Colors.lightGreenAccent,
          seaDeep,
        ),
      ],
    ),
  );
  print('Created cursor cascade diagram');

  // ============================================================
  // SECTION 5: SystemMouseCursors gallery
  // ============================================================
  print('=== Section 5: SystemMouseCursors gallery ===');

  final cursorGallery = <Map<String, dynamic>>[
    <String, dynamic>{
      'cursor': SystemMouseCursors.basic,
      'name': 'basic',
      'icon': Icons.arrow_upward,
      'caption': 'standard arrow',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.click,
      'name': 'click',
      'icon': Icons.touch_app,
      'caption': 'hovering a link',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.text,
      'name': 'text',
      'icon': Icons.text_fields,
      'caption': 'I-beam over text',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.grab,
      'name': 'grab',
      'icon': Icons.pan_tool_outlined,
      'caption': 'draggable handle',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.grabbing,
      'name': 'grabbing',
      'icon': Icons.pan_tool,
      'caption': 'mid-drag clutch',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.forbidden,
      'name': 'forbidden',
      'icon': Icons.block,
      'caption': 'drop disallowed',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.wait,
      'name': 'wait',
      'icon': Icons.hourglass_top,
      'caption': 'system busy',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.progress,
      'name': 'progress',
      'icon': Icons.hourglass_bottom,
      'caption': 'work in flight',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.help,
      'name': 'help',
      'icon': Icons.help_outline,
      'caption': 'context help',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.resizeColumn,
      'name': 'resizeColumn',
      'icon': Icons.swap_horiz,
      'caption': 'column splitter',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.resizeRow,
      'name': 'resizeRow',
      'icon': Icons.swap_vert,
      'caption': 'row splitter',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.copy,
      'name': 'copy',
      'icon': Icons.content_copy,
      'caption': 'copy in progress',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.none,
      'name': 'none',
      'icon': Icons.visibility_off,
      'caption': 'hidden cursor',
    },
    <String, dynamic>{
      'cursor': SystemMouseCursors.cell,
      'name': 'cell',
      'icon': Icons.grid_on,
      'caption': 'spreadsheet cell',
    },
  ];

  final cursorTiles = <Widget>[];
  for (int i = 0; i < cursorGallery.length; i++) {
    final entry = cursorGallery[i];
    final cursor = entry['cursor'] as MouseCursor;
    final name = entry['name'] as String;
    final icon = entry['icon'] as IconData;
    final caption = entry['caption'] as String;
    print('cursor[$i]: SystemMouseCursors.$name → $cursor');

    cursorTiles.add(
      _cursorTile(
        name,
        caption,
        icon,
        cursor.toString(),
        i.isEven ? brassLight : beamHalo,
        brassDark,
        lacquer,
      ),
    );
  }
  print('Built ${cursorTiles.length} cursor tiles');

  // ============================================================
  // SECTION 6: Live MouseRegion configurations (rendered widgets)
  // ============================================================
  print('=== Section 6: Live MouseRegion configurations ===');

  final basicRegion = MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (PointerEnterEvent event) {
      print('basicRegion onEnter at ${event.position}');
    },
    onExit: (PointerExitEvent event) {
      print('basicRegion onExit at ${event.position}');
    },
    child: Container(
      width: 220.0,
      height: 90.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [brassLight, brassMid],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: brassDark, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: brassDark.withValues(alpha: 0.4),
            blurRadius: 8.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Text(
        'BASIC LENS\nclick cursor',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: lacquer,
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
          letterSpacing: 1.0,
        ),
      ),
    ),
  );

  final hoverRegion = MouseRegion(
    cursor: SystemMouseCursors.help,
    onEnter: (PointerEnterEvent event) {
      print('hoverRegion onEnter — vessel sighted');
    },
    onHover: (PointerHoverEvent event) {
      print('hoverRegion onHover at ${event.localPosition}');
    },
    onExit: (PointerExitEvent event) {
      print('hoverRegion onExit — vessel cleared');
    },
    child: Container(
      width: 220.0,
      height: 90.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [beamCore, beamHalo, brassMid],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: brassDark, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: beamHalo.withValues(alpha: 0.55),
            blurRadius: 14.0,
            offset: Offset(0.0, 0.0),
          ),
          BoxShadow(
            color: brassDark.withValues(alpha: 0.4),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Text(
        'HOVER LENS\nhelp cursor + onHover',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: lacquer,
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
          letterSpacing: 1.0,
        ),
      ),
    ),
  );

  final opaqueRegion = MouseRegion(
    cursor: SystemMouseCursors.forbidden,
    opaque: true,
    hitTestBehavior: HitTestBehavior.opaque,
    onEnter: (PointerEnterEvent event) {
      print('opaqueRegion onEnter — beam blocked');
    },
    onExit: (PointerExitEvent event) {
      print('opaqueRegion onExit');
    },
    child: Container(
      width: 220.0,
      height: 90.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [seaDeep, seaMid, lacquer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: brassMid, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: lacquer.withValues(alpha: 0.7),
            blurRadius: 10.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Text(
        'OPAQUE LENS\nforbidden + opaque',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: beamCore,
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
          letterSpacing: 1.0,
        ),
      ),
    ),
  );

  final regionShowcase = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          brassLight.withValues(alpha: 0.20),
          brassDark.withValues(alpha: 0.12),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: brassMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: brassDark.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Three observation windows along the catwalk',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: brassDark,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[basicRegion, hoverRegion, opaqueRegion],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: lacquer.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: brassMid.withValues(alpha: 0.5)),
          ),
          child: Text(
            'Each MouseRegion installs its own MouseTrackerAnnotation. The '
            'tracker sweeps the layer tree on every frame; if the pointer '
            'enters any region, onEnter fires; if it leaves, onExit fires; '
            'while inside, onHover ticks per pointer event.',
            style: TextStyle(
              fontSize: 12.0,
              color: lacquer,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created live region showcase');

  // ============================================================
  // SECTION 7: validForMouseTracker contract
  // ============================================================
  print('=== Section 7: validForMouseTracker contract ===');

  final livingAnnotation = MouseTrackerAnnotation(
    onEnter: (PointerEnterEvent event) {
      print('living: enter ${event.position}');
    },
    onExit: (PointerExitEvent event) {
      print('living: exit ${event.position}');
    },
    cursor: SystemMouseCursors.click,
  );
  print('livingAnnotation.validForMouseTracker = '
      '${livingAnnotation.validForMouseTracker}');

  final validityPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.lightGreenAccent.withValues(alpha: 0.20),
          brassLight.withValues(alpha: 0.30),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: brassMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: brassDark.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'validForMouseTracker — keeper\'s lamp status',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: lacquer,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _validityCard(
                'true',
                'Lamp lit — annotation active',
                'Tracker may invoke onEnter / onExit and apply cursor.',
                Icons.check_circle,
                Colors.lightGreenAccent.shade400,
                lacquer,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _validityCard(
                'false',
                'Lamp doused — annotation defunct',
                'Set during teardown so MouseTracker can purge stale layers.',
                Icons.cancel,
                Colors.redAccent.shade200,
                lacquer,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pillBadge(
          'live probe → ${livingAnnotation.validForMouseTracker}',
          beamCore,
          brassDark,
        ),
      ],
    ),
  );
  print('Created validForMouseTracker contract panel');

  // ============================================================
  // SECTION 8: MaterialStateMouseCursor demonstration
  // ============================================================
  print('=== Section 8: MaterialStateMouseCursor demonstration ===');

  final stateCursorClickable = MaterialStateMouseCursor.clickable;
  final stateCursorTextable = MaterialStateMouseCursor.textable;
  print('clickable runtimeType: ${stateCursorClickable.runtimeType}');
  print('textable runtimeType: ${stateCursorTextable.runtimeType}');

  final hoveredSet = <MaterialState>{MaterialState.hovered};
  final pressedSet = <MaterialState>{
    MaterialState.hovered,
    MaterialState.pressed,
  };
  final disabledSet = <MaterialState>{MaterialState.disabled};
  final emptySet = <MaterialState>{};

  final clickableHovered = stateCursorClickable.resolve(hoveredSet);
  final clickablePressed = stateCursorClickable.resolve(pressedSet);
  final clickableDisabled = stateCursorClickable.resolve(disabledSet);
  final clickableIdle = stateCursorClickable.resolve(emptySet);
  print('clickable.resolve(hovered) = $clickableHovered');
  print('clickable.resolve(pressed) = $clickablePressed');
  print('clickable.resolve(disabled) = $clickableDisabled');
  print('clickable.resolve(idle) = $clickableIdle');

  final textableHovered = stateCursorTextable.resolve(hoveredSet);
  final textableDisabled = stateCursorTextable.resolve(disabledSet);
  print('textable.resolve(hovered) = $textableHovered');
  print('textable.resolve(disabled) = $textableDisabled');

  final stateRows = <List<String>>[
    <String>['idle', '{ }', clickableIdle.toString()],
    <String>['hovered', '{hovered}', clickableHovered.toString()],
    <String>['pressed', '{hovered, pressed}', clickablePressed.toString()],
    <String>['disabled', '{disabled}', clickableDisabled.toString()],
  ];

  final stateMatrix = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [seaDeep, seaMid, brassDark.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: brassLight, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: lacquer.withValues(alpha: 0.55),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialStateMouseCursor.clickable resolution table',
          style: TextStyle(
            color: beamCore,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: brassDark.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              _buildHeaderCell('label', 110.0, beamCore),
              _buildHeaderCell('states', 200.0, beamCore),
              _buildHeaderCell('resolved cursor', 240.0, beamCore),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (int i = 0; i < stateRows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: i.isEven
                  ? beamCore.withValues(alpha: 0.12)
                  : Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: brassMid.withValues(alpha: 0.4),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                _buildDataCell(stateRows[i][0], 110.0, beamCore, true),
                _buildDataCell(stateRows[i][1], 200.0, brassLight, false),
                _buildDataCell(stateRows[i][2], 240.0, beamHalo, false),
              ],
            ),
          ),
        SizedBox(height: 14.0),
        Text(
          'Note: when disabled, both clickable and textable resolve to '
          'SystemMouseCursors.basic — the lamp stays silent.',
          style: TextStyle(
            color: brassLight,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
  print('Created MaterialStateMouseCursor matrix');

  // ============================================================
  // SECTION 9: Code excerpt — putting it together
  // ============================================================
  print('=== Section 9: Code excerpt ===');

  final codeExcerpt = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: lacquer,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brassMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: brassDark.withValues(alpha: 0.55),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: beamHalo, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'putting it together',
              style: TextStyle(
                color: beamHalo,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// Low-level: the keeper\'s logbook entry\n'
          'final ann = MouseTrackerAnnotation(\n'
          '  cursor: SystemMouseCursors.click,\n'
          '  onEnter: (PointerEnterEvent e) => log(\'enter \${e.position}\'),\n'
          '  onExit:  (PointerExitEvent  e) => log(\'exit  \${e.position}\'),\n'
          ');',
          beamCore,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// Widget facade — most apps stop here\n'
          'MouseRegion(\n'
          '  cursor: SystemMouseCursors.click,\n'
          '  onEnter: (e) => focus(),\n'
          '  onHover: (e) => track(e.localPosition),\n'
          '  onExit:  (e) => blur(),\n'
          '  child: child,\n'
          ');',
          Colors.lightGreenAccent,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// Stateful sigil\n'
          'final cursor = MaterialStateMouseCursor.clickable\n'
          '  .resolve(<MaterialState>{MaterialState.hovered});',
          Colors.pinkAccent.shade100,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// Defer to ancestor — let an outer keeper decide\n'
          'MouseRegion(cursor: MouseCursor.defer, child: child);',
          Colors.cyanAccent,
        ),
      ],
    ),
  );
  print('Created code excerpt panel');

  print('MouseTrackerAnnotation Deep Demo completed successfully');

  // ============================================================
  // Final composition
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Lighthouse banner
        Container(
          padding: EdgeInsets.all(26.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [seaDeep, seaMid, brassDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: brassLight, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: beamHalo.withValues(alpha: 0.30),
                blurRadius: 28.0,
                offset: Offset(0.0, 0.0),
              ),
              BoxShadow(
                color: lacquer.withValues(alpha: 0.6),
                blurRadius: 14.0,
                offset: Offset(0.0, 8.0),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Icon(Icons.wb_incandescent, size: 60.0, color: beamCore),
              SizedBox(height: 8.0),
              Text(
                'MouseTrackerAnnotation',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: beamCore,
                  letterSpacing: 1.4,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'The Lighthouse Keeper\'s Optic',
                style: TextStyle(
                  fontSize: 14.0,
                  color: brassLight,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'enter • hover • exit  ·  cursor cascade  ·  validForMouseTracker',
                style: TextStyle(
                  fontSize: 12.0,
                  color: brassLight.withValues(alpha: 0.85),
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        _sectionHeading('1. Annotation Contract Anatomy', brassDark),
        contractAnatomy,
        SizedBox(height: 20.0),

        _sectionHeading('2. Pointer Lifecycle Through the Beam', brassDark),
        lifecycleTree,
        SizedBox(height: 20.0),

        _sectionHeading('3. Pointer Event Field Matrix', brassDark),
        pointerMatrix,
        SizedBox(height: 20.0),

        _sectionHeading('4. Cursor Cascade Diagram', brassDark),
        cascadeDiagram,
        SizedBox(height: 20.0),

        _sectionHeading('5. SystemMouseCursors Gallery', brassDark),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: cursorTiles,
          ),
        ),
        SizedBox(height: 20.0),

        _sectionHeading('6. Live MouseRegion Configurations', brassDark),
        regionShowcase,
        SizedBox(height: 20.0),

        _sectionHeading('7. validForMouseTracker Contract', brassDark),
        validityPanel,
        SizedBox(height: 20.0),

        _sectionHeading('8. MaterialStateMouseCursor Resolution', brassDark),
        stateMatrix,
        SizedBox(height: 20.0),

        _sectionHeading('9. Code Excerpt', brassDark),
        codeExcerpt,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionHeading(String label, Color color) {
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 6.0, top: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 6.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(
  String name,
  String type,
  String description,
  IconData icon,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.55)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: accent, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        color: accent,
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _eventNode(
  String title,
  String tag,
  IconData icon,
  Color glow,
  Color textColor,
) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: <Color>[glow, glow.withValues(alpha: 0.25)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: glow, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: glow.withValues(alpha: 0.55),
          blurRadius: 16.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, color: textColor, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: textColor,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          tag,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.0, color: textColor),
        ),
      ],
    ),
  );
}

Widget _arrowGlyph(IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(icon, color: color, size: 28.0),
  );
}

Widget _arrowDown(Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Icon(Icons.south, color: color, size: 22.0),
  );
}

Widget _logLine(String time, String event, String detail, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 70.0,
          child: Text(
            time,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white60,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            event,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          detail,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white70,
          ),
        ),
      ],
    ),
  );
}

Widget _buildHeaderCell(String text, double width, Color color) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: color,
        letterSpacing: 0.6,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildDataCell(String text, double width, Color color, bool bold) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 11.0,
        color: color,
        fontFamily: 'monospace',
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget _cascadeNode(
  String label,
  String hint,
  IconData icon,
  Color tile,
  Color textColor,
) {
  return Container(
    width: 360.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[tile, tile.withValues(alpha: 0.65)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tile, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tile.withValues(alpha: 0.45),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: textColor, size: 24.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 11.0,
                  color: textColor.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _cursorTile(
  String name,
  String caption,
  IconData icon,
  String resolvedTo,
  Color background,
  Color border,
  Color textColor,
) {
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[background, background.withValues(alpha: 0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: border, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: border.withValues(alpha: 0.35),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: textColor, size: 22.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'monospace',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          caption,
          style: TextStyle(
            fontSize: 11.0,
            color: textColor.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: textColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            resolvedTo,
            style: TextStyle(
              fontSize: 9.0,
              color: textColor,
              fontFamily: 'monospace',
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _validityCard(
  String value,
  String headline,
  String body,
  IconData icon,
  Color accent,
  Color textColor,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: accent,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          headline,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(fontSize: 11.0, color: textColor, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _pillBadge(String text, Color background, Color textColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: textColor, width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF161013),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFF2A1F22)),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}
