// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemDataLiveText and the full
// IOSSystemContextMenuItemData hierarchy from package:flutter/services.dart.
// Deep Demo theme: an iOS brushed-aluminum control panel with a camera
// viewfinder/OCR overlay highlighting the Live Text action.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataLiveText Deep Demo executing');
  print('=' * 60);

  // ============================================================
  // SECTION 1: Construct one of every concrete sibling subclass
  // ============================================================
  print('=== Section 1: Sibling subclasses ===');

  final liveText = IOSSystemContextMenuItemDataLiveText();
  final copy = IOSSystemContextMenuItemDataCopy();
  final cut = IOSSystemContextMenuItemDataCut();
  final paste = IOSSystemContextMenuItemDataPaste();
  final selectAll = IOSSystemContextMenuItemDataSelectAll();
  final lookUp = IOSSystemContextMenuItemDataLookUp(title: 'Look Up');
  final searchWeb = IOSSystemContextMenuItemDataSearchWeb(title: 'Search Web');
  final share = IOSSystemContextMenuItemDataShare(title: 'Share...');
  final custom = IOSSystemContextMenuItemDataCustom(
    title: 'Translate to Korean',
    onPressed: _noop,
  );

  print('liveText.runtimeType  = ${liveText.runtimeType}');
  print('copy.runtimeType      = ${copy.runtimeType}');
  print('cut.runtimeType       = ${cut.runtimeType}');
  print('paste.runtimeType     = ${paste.runtimeType}');
  print('selectAll.runtimeType = ${selectAll.runtimeType}');
  print('lookUp.runtimeType    = ${lookUp.runtimeType}');
  print('searchWeb.runtimeType = ${searchWeb.runtimeType}');
  print('share.runtimeType     = ${share.runtimeType}');
  print('custom.runtimeType    = ${custom.runtimeType}');

  final List<IOSSystemContextMenuItemData> allItems =
      <IOSSystemContextMenuItemData>[
        copy,
        cut,
        paste,
        selectAll,
        lookUp,
        searchWeb,
        share,
        liveText,
        custom,
      ];
  print('Constructed ${allItems.length} catalog items (incl. LiveText)');

  // ============================================================
  // SECTION 2: Equality semantics (title-based)
  // ============================================================
  print('=== Section 2: Equality semantics ===');

  final liveTextA = IOSSystemContextMenuItemDataLiveText();
  final liveTextB = IOSSystemContextMenuItemDataLiveText();
  final copyA = IOSSystemContextMenuItemDataCopy();
  final copyB = IOSSystemContextMenuItemDataCopy();
  final lookUpA = IOSSystemContextMenuItemDataLookUp(title: 'Look Up');
  final lookUpB = IOSSystemContextMenuItemDataLookUp(title: 'Look Up');
  final lookUpC = IOSSystemContextMenuItemDataLookUp(title: 'Define');

  final liveTextEq = liveTextA == liveTextB;
  final copyEq = copyA == copyB;
  final liveTextVsCopy = liveTextA == copyA;
  final lookUpEq = lookUpA == lookUpB;
  final lookUpDiff = lookUpA == lookUpC;

  print('liveTextA == liveTextB        : $liveTextEq');
  print('copyA == copyB                : $copyEq');
  print('liveTextA == copyA            : $liveTextVsCopy');
  print('lookUp(Look Up) == same       : $lookUpEq');
  print('lookUp(Look Up) == lookUp(Define): $lookUpDiff');
  print('liveText.hashCode             : ${liveTextA.hashCode}');
  print('lookUp(Look Up).hashCode      : ${lookUpA.hashCode}');

  // ============================================================
  // SECTION 3: Hero header (iPhone chrome)
  // ============================================================
  print('=== Section 3: Hero header ===');

  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1C1C1E),
          Color(0xFF2C2C2E),
          Color(0xFF1C1C1E),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28.0),
      border: Border.all(color: Color(0xFF3A3A3C), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.55),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0xFF0A84FF).withValues(alpha: 0.18),
          blurRadius: 32.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFFFD60A).withValues(alpha: 0.85),
                    Color(0xFFFF9F0A).withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.document_scanner,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IOSSystemContextMenuItemDataLiveText',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'iOS Live Text · camera-driven OCR action',
                    style: TextStyle(
                      color: Color(0xFF8E8E93),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _chip('iOS 15.0+', Color(0xFF0A84FF)),
            _chip('Neural Engine', Color(0xFFBF5AF2)),
            _chip('OCR / VisionKit', Color(0xFF30D158)),
            _chip('System menu surface', Color(0xFFFF9F0A)),
            _chip('Sealed hierarchy', Color(0xFFFF453A)),
          ],
        ),
      ],
    ),
  );
  print('Built hero header');

  // ============================================================
  // SECTION 4: Class hierarchy tree
  // ============================================================
  print('=== Section 4: Hierarchy tree ===');

  final hierarchy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2C2C2E), Color(0xFF1C1C1E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF3A3A3C), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Color(0xFF0A84FF), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'sealed class hierarchy',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFF0A84FF),
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _treeRow('IOSSystemContextMenuItemData', Color(0xFFFFD60A), 0, true),
        _treeRow('IOSSystemContextMenuItemDataCopy', Color(0xFFFF9F0A), 1, false),
        _treeRow('IOSSystemContextMenuItemDataCut', Color(0xFFFF9F0A), 1, false),
        _treeRow('IOSSystemContextMenuItemDataPaste', Color(0xFFFF9F0A), 1, false),
        _treeRow(
          'IOSSystemContextMenuItemDataSelectAll',
          Color(0xFFFF9F0A),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataLookUp(title)',
          Color(0xFF30D158),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataSearchWeb(title)',
          Color(0xFF30D158),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataShare(title)',
          Color(0xFF30D158),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataLiveText  <-- this script',
          Color(0xFFBF5AF2),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataCustom(title, onPressed)',
          Color(0xFF64D2FF),
          1,
          false,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF0A84FF).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFF0A84FF).withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'Sealed: every IOSSystemContextMenuItemData is one of these nine.\n'
            'Color legend: yellow = abstract base, orange = no-arg built-ins,\n'
            'green = title-only built-ins, purple = LiveText, blue = custom.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11.0,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built hierarchy tree');

  // ============================================================
  // SECTION 5: Subclass catalog cards
  // ============================================================
  print('=== Section 5: Catalog cards ===');

  final catalog = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: [
      _catalogCard(
        label: 'Copy',
        symbol: Icons.content_copy,
        accent: Color(0xFFFF9F0A),
        title: 'platform default',
        kind: 'no-arg built-in',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Cut',
        symbol: Icons.content_cut,
        accent: Color(0xFFFF9F0A),
        title: 'platform default',
        kind: 'no-arg built-in',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Paste',
        symbol: Icons.content_paste,
        accent: Color(0xFFFF9F0A),
        title: 'platform default',
        kind: 'no-arg built-in',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Select All',
        symbol: Icons.select_all,
        accent: Color(0xFFFF9F0A),
        title: 'platform default',
        kind: 'no-arg built-in',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Look Up',
        symbol: Icons.menu_book,
        accent: Color(0xFF30D158),
        title: lookUp.title,
        kind: 'title required',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Search Web',
        symbol: Icons.travel_explore,
        accent: Color(0xFF30D158),
        title: searchWeb.title,
        kind: 'title required',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Share',
        symbol: Icons.ios_share,
        accent: Color(0xFF30D158),
        title: share.title,
        kind: 'title required',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Live Text',
        symbol: Icons.document_scanner,
        accent: Color(0xFFBF5AF2),
        title: 'platform default',
        kind: 'iOS 15+, OCR',
        highlighted: true,
      ),
      _catalogCard(
        label: 'Custom',
        symbol: Icons.tune,
        accent: Color(0xFF64D2FF),
        title: custom.title,
        kind: 'iOS 16+, callback',
        highlighted: false,
      ),
    ],
  );
  print('Built ${allItems.length} catalog cards');

  // ============================================================
  // SECTION 6: Equality semantics matrix
  // ============================================================
  print('=== Section 6: Equality matrix ===');

  final equalityRows = <Map<String, Object>>[
    {'lhs': 'LiveText()', 'rhs': 'LiveText()', 'eq': liveTextEq},
    {'lhs': 'Copy()', 'rhs': 'Copy()', 'eq': copyEq},
    {'lhs': 'LiveText()', 'rhs': 'Copy()', 'eq': liveTextVsCopy},
    {
      'lhs': "LookUp('Look Up')",
      'rhs': "LookUp('Look Up')",
      'eq': lookUpEq,
    },
    {
      'lhs': "LookUp('Look Up')",
      'rhs': "LookUp('Define')",
      'eq': lookUpDiff,
    },
    {
      'lhs': "Share('Share...')",
      'rhs': "Share('Share...')",
      'eq': share == IOSSystemContextMenuItemDataShare(title: 'Share...'),
    },
  ];

  final matrix = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2C2C2E), Color(0xFF1C1C1E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF3A3A3C), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFBF5AF2).withValues(alpha: 0.18),
          blurRadius: 18.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.balance, color: Color(0xFFBF5AF2), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'operator == is title-driven',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFBF5AF2),
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'left-hand side',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  'right-hand side',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              SizedBox(
                width: 80.0,
                child: Text(
                  'a == b',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        for (final row in equalityRows)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            margin: EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF3A3A3C), width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    row['lhs'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    row['rhs'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.0,
                  child: Center(
                    child: _eqBadge(row['eq'] as bool),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF30D158).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFF30D158).withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'Why: the base class implements `operator ==` as\n'
            '  identical(this, other) || (other.runtimeType == runtimeType && other.title == title)\n'
            'and `hashCode` as `title.hashCode`. Two items are equal iff they\n'
            'have the same concrete type AND the same title. LiveText has no\n'
            'public title, so any two LiveText instances are equal.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built equality matrix with ${equalityRows.length} rows');

  // ============================================================
  // SECTION 7: Camera -> OCR pipeline
  // ============================================================
  print('=== Section 7: OCR pipeline ===');

  final pipelineSteps = <Map<String, Object>>[
    {
      'index': '01',
      'icon': Icons.touch_app,
      'title': 'Tap',
      'detail': 'User taps "Scan Text" in the system context menu',
    },
    {
      'index': '02',
      'icon': Icons.camera,
      'title': 'Open camera',
      'detail': 'iOS hands off to VisionKit live capture session',
    },
    {
      'index': '03',
      'icon': Icons.center_focus_strong,
      'title': 'Detect',
      'detail': 'Neural Engine locates text regions in the live frame',
    },
    {
      'index': '04',
      'icon': Icons.font_download,
      'title': 'Recognize',
      'detail': 'OCR converts pixels into Unicode glyph runs',
    },
    {
      'index': '05',
      'icon': Icons.input,
      'title': 'Insert',
      'detail': 'Recognized text drops into the focused text field',
    },
  ];

  final pipeline = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFBF5AF2).withValues(alpha: 0.20),
          Color(0xFF0A84FF).withValues(alpha: 0.20),
          Color(0xFF30D158).withValues(alpha: 0.20),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF3A3A3C), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFBF5AF2).withValues(alpha: 0.25),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Camera -> OCR -> Insertion',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Column(
          children: [
            for (int i = 0; i < pipelineSteps.length; i++)
              _pipelineRow(
                pipelineSteps[i]['index'].toString(),
                pipelineSteps[i]['icon'] as IconData,
                pipelineSteps[i]['title'].toString(),
                pipelineSteps[i]['detail'].toString(),
                isLast: i == pipelineSteps.length - 1,
              ),
          ],
        ),
      ],
    ),
  );
  print('Built ${pipelineSteps.length}-stage pipeline');

  // ============================================================
  // SECTION 8: iOS context menu mockup with LiveText highlighted
  // ============================================================
  print('=== Section 8: System menu mockup ===');

  final mockMenu = _systemMenuMockup(
    title: 'Selected: "Battery 87%"',
    rows: <Map<String, Object>>[
      _menuRow('Cut', Icons.content_cut, false),
      _menuRow('Copy', Icons.content_copy, false),
      _menuRow('Paste', Icons.content_paste, false),
      _menuRow('Select All', Icons.select_all, false),
      _menuRow('Look Up', Icons.menu_book, false),
      _menuRow('Share...', Icons.ios_share, false),
      _menuRow('Scan Text', Icons.document_scanner, true),
    ],
    captionItems: allItems,
  );
  print('Built primary system menu mockup (LiveText highlighted)');

  // ============================================================
  // SECTION 9: Filtering and ordering pattern demos
  // ============================================================
  print('=== Section 9: Filtering / ordering patterns ===');

  // Pattern A: read-only field -> drop Cut and Paste, keep LiveText off.
  final readOnlyMenu = allItems.where((item) {
    if (item is IOSSystemContextMenuItemDataCut) return false;
    if (item is IOSSystemContextMenuItemDataPaste) return false;
    if (item is IOSSystemContextMenuItemDataLiveText) return false;
    if (item is IOSSystemContextMenuItemDataCustom) return false;
    return true;
  }).toList();

  // Pattern B: editable field on iOS 15+ -> include LiveText, drop Custom.
  final editableMenu = allItems.where((item) {
    if (item is IOSSystemContextMenuItemDataCustom) return false;
    return true;
  }).toList();

  // Pattern C: minimal "scan into field" surface -> Paste + LiveText only.
  final scanMenu = allItems.where((item) {
    return item is IOSSystemContextMenuItemDataPaste ||
        item is IOSSystemContextMenuItemDataLiveText;
  }).toList();

  // Pattern D: deduplicated catalog using Set equality (title-driven).
  final dedupSeed = <IOSSystemContextMenuItemData>[
    IOSSystemContextMenuItemDataLiveText(),
    IOSSystemContextMenuItemDataLiveText(),
    IOSSystemContextMenuItemDataCopy(),
    IOSSystemContextMenuItemDataCopy(),
    IOSSystemContextMenuItemDataLookUp(title: 'Look Up'),
    IOSSystemContextMenuItemDataLookUp(title: 'Look Up'),
    IOSSystemContextMenuItemDataLookUp(title: 'Define'),
  ];
  final dedupSet = dedupSeed.toSet();

  print('readOnlyMenu length = ${readOnlyMenu.length}');
  print('editableMenu length = ${editableMenu.length}');
  print('scanMenu length     = ${scanMenu.length}');
  print('dedupSeed length    = ${dedupSeed.length}');
  print('dedupSet  length    = ${dedupSet.length}  (Set collapses by ==)');

  final patternsBlock = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _patternCard(
        title: 'A. Read-only text field',
        body:
            'Strip Cut, Paste, LiveText (no insertion target) and any Custom.\n'
            'Result has ${readOnlyMenu.length} items: '
            '${_describeItems(readOnlyMenu)}',
        accent: Color(0xFFFF453A),
        symbol: Icons.lock_outline,
      ),
      _patternCard(
        title: 'B. Editable field, no per-app extras',
        body:
            'Drop Custom, keep all built-ins including LiveText.\n'
            'Result has ${editableMenu.length} items: '
            '${_describeItems(editableMenu)}',
        accent: Color(0xFF0A84FF),
        symbol: Icons.edit_note,
      ),
      _patternCard(
        title: 'C. "Scan into form" surface',
        body:
            'Surface only Paste and LiveText for a minimal capture flow.\n'
            'Result has ${scanMenu.length} items: '
            '${_describeItems(scanMenu)}',
        accent: Color(0xFF30D158),
        symbol: Icons.document_scanner,
      ),
      _patternCard(
        title: 'D. Deduplicate with Set semantics',
        body:
            'A list of ${dedupSeed.length} candidates collapses to a Set of '
            '${dedupSet.length} unique entries because operator == compares\n'
            '(runtimeType, title). Two LiveText() are the same key, but\n'
            'LookUp("Look Up") and LookUp("Define") are not.',
        accent: Color(0xFFBF5AF2),
        symbol: Icons.filter_alt,
      ),
    ],
  );
  print('Built 4 filtering/ordering pattern cards');

  // ============================================================
  // SECTION 10: Scanner viewfinder mockup
  // ============================================================
  print('=== Section 10: Scanner viewfinder ===');

  final viewfinder = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 240.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF000000), Color(0xFF1C1C1E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF0A84FF), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0A84FF).withValues(alpha: 0.4),
          blurRadius: 20.0,
          offset: Offset(0.0, 0.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Stack(
      children: [
        // Crosshair grid
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFFFD60A).withValues(alpha: 0.7),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16.0,
          left: 16.0,
          child: _corner(true, true),
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: _corner(true, false),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: _corner(false, true),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: _corner(false, false),
        ),
        // Recognized text overlay
        Positioned(
          left: 40.0,
          right: 40.0,
          top: 70.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFD60A).withValues(alpha: 0.20),
              border: Border.all(color: Color(0xFFFFD60A), width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'Battery 87%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        Positioned(
          left: 40.0,
          right: 40.0,
          top: 120.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Color(0xFFBF5AF2).withValues(alpha: 0.20),
              border: Border.all(color: Color(0xFFBF5AF2), width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'serial #A2H7-9F2',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 14.0,
          left: 18.0,
          child: Row(
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFF453A),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFF453A).withValues(alpha: 0.7),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.0),
              Text(
                'LIVE TEXT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  letterSpacing: 1.4,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 14.0,
          right: 18.0,
          child: Text(
            '1080 x 1920 · 30 fps',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
  print('Built camera viewfinder mockup');

  // ============================================================
  // SECTION 11: Device compatibility timeline
  // ============================================================
  print('=== Section 11: Compatibility timeline ===');

  final compatItems = <Map<String, Object>>[
    {
      'year': '2017',
      'label': 'iPhone X / XS family',
      'note': 'First Neural Engine; eligible hardware for Live Text.',
      'on': true,
    },
    {
      'year': '2021',
      'label': 'iOS 15.0',
      'note': 'Live Text public API; system menu surfaces it.',
      'on': true,
    },
    {
      'year': '2022',
      'label': 'iOS 16.0',
      'note': 'Custom action support added (Custom subclass).',
      'on': true,
    },
    {
      'year': '2024',
      'label': 'iOS 17.x',
      'note': 'Per-app menu shaping is now stable across locales.',
      'on': true,
    },
    {
      'year': '----',
      'label': 'Older iPhones / non-iOS',
      'note': 'LiveText silently absent; menu degrades gracefully.',
      'on': false,
    },
  ];

  final timeline = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF3A3A3C), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF30D158).withValues(alpha: 0.20),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.history, color: Color(0xFF30D158), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Where LiveText is actually available',
              style: TextStyle(
                color: Color(0xFF30D158),
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (final item in compatItems)
          _timelineRow(
            item['year'].toString(),
            item['label'].toString(),
            item['note'].toString(),
            item['on'] as bool,
          ),
      ],
    ),
  );
  print('Built ${compatItems.length}-row compatibility timeline');

  // ============================================================
  // SECTION 12: Code examples
  // ============================================================
  print('=== Section 12: Code examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF0D0D0F),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF3A3A3C), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0A84FF).withValues(alpha: 0.20),
          blurRadius: 18.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFF64D2FF), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Real-world snippets',
              style: TextStyle(
                color: Color(0xFF64D2FF),
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// 1. Show the platform menu with LiveText next to Paste\n'
          'SystemContextMenuController.show(\n'
          '  targetRect: cursorRect,\n'
          '  items: const <IOSSystemContextMenuItemData>[\n'
          '    IOSSystemContextMenuItemDataPaste(),\n'
          '    IOSSystemContextMenuItemDataLiveText(),\n'
          '  ],\n'
          ');',
          Color(0xFF64D2FF),
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 2. Drop LiveText if the field is read-only.\n'
          'final menu = baseItems.where((i) =>\n'
          '  !readOnly || i is! IOSSystemContextMenuItemDataLiveText\n'
          ').toList();',
          Color(0xFFFFD60A),
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 3. Equality is title-driven; safe in Sets.\n'
          'final unique = <IOSSystemContextMenuItemData>{\n'
          '  IOSSystemContextMenuItemDataLiveText(),\n'
          '  IOSSystemContextMenuItemDataLiveText(),\n'
          '}; // length == 1',
          Color(0xFFBF5AF2),
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 4. LiveText sits next to Custom for app-specific extras.\n'
          'final menu = <IOSSystemContextMenuItemData>[\n'
          '  IOSSystemContextMenuItemDataCopy(),\n'
          '  IOSSystemContextMenuItemDataLiveText(),\n'
          '  IOSSystemContextMenuItemDataCustom(\n'
          "    title: 'Translate',\n"
          '    onPressed: handleTranslate,\n'
          '  ),\n'
          '];',
          Color(0xFF30D158),
        ),
      ],
    ),
  );
  print('Built code examples block');

  print('Deep Demo for IOSSystemContextMenuItemDataLiveText completed');
  print('=' * 60);

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A0A0C), Color(0xFF1A1A1E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          hero,
          SizedBox(height: 24.0),
          _sectionTitle('1. Sealed class hierarchy'),
          SizedBox(height: 8.0),
          _intro(
            'IOSSystemContextMenuItemData is sealed: every concrete iOS '
            'system context menu item is one of nine types. LiveText is a '
            'no-arg leaf whose action and title are entirely owned by '
            'the platform.',
          ),
          hierarchy,
          SizedBox(height: 24.0),
          _sectionTitle('2. Subclass catalog'),
          SizedBox(height: 8.0),
          _intro(
            'Each card represents one concrete subclass. LiveText is the '
            'highlighted purple tile because it is the focus of this '
            'demo and the only OCR-capable entry in the family.',
          ),
          catalog,
          SizedBox(height: 24.0),
          _sectionTitle('3. Equality semantics'),
          SizedBox(height: 8.0),
          _intro(
            'The base class implements operator == and hashCode in terms '
            'of (runtimeType, title). Items behave correctly inside Sets '
            'and Map keys; LiveText() instances are always interchangeable.',
          ),
          matrix,
          SizedBox(height: 24.0),
          _sectionTitle('4. Camera -> OCR -> insertion pipeline'),
          SizedBox(height: 8.0),
          _intro(
            'Tapping the LiveText menu entry hands control to iOS '
            'VisionKit. The Neural Engine performs real-time OCR; the '
            'engine then feeds recognized characters back into the '
            'currently focused TextEditingController.',
          ),
          pipeline,
          SizedBox(height: 24.0),
          _sectionTitle('5. iOS system menu (LiveText highlighted)'),
          SizedBox(height: 8.0),
          _intro(
            'A faithful mockup of the system context menu surfaced over '
            'a selection. LiveText (labelled "Scan Text" by the platform) '
            'is shown in the highlighted purple row.',
          ),
          mockMenu,
          SizedBox(height: 24.0),
          _sectionTitle('6. Filtering and ordering patterns'),
          SizedBox(height: 8.0),
          _intro(
            'In practice, app code rarely passes the full catalog to '
            'SystemContextMenuController. These four patterns cover the '
            'common shapes: read-only fields, editable fields, scan-only '
            'surfaces, and deduplication via Set semantics.',
          ),
          patternsBlock,
          SizedBox(height: 24.0),
          _sectionTitle('7. Live Text scanner viewfinder'),
          SizedBox(height: 8.0),
          _intro(
            'Once the menu entry fires, iOS opens a VisionKit live '
            'capture session. Recognized text regions are framed in '
            'yellow; anchored substrings (serial numbers, URLs, phone '
            'numbers) get their own colored anchors.',
          ),
          viewfinder,
          SizedBox(height: 24.0),
          _sectionTitle('8. Compatibility timeline'),
          SizedBox(height: 8.0),
          _intro(
            'LiveText only resolves on iOS 15+ devices with a Neural '
            'Engine. On older hardware, on iPad without OCR locales, or '
            'on non-iOS platforms, the menu entry is silently dropped.',
          ),
          timeline,
          SizedBox(height: 24.0),
          _sectionTitle('9. Code examples'),
          SizedBox(height: 8.0),
          _intro(
            'Four representative snippets: composing a menu, dropping '
            'LiveText for read-only fields, deduplicating by equality, '
            'and combining LiveText with Custom for app-specific extras.',
          ),
          codeExamples,
          SizedBox(height: 24.0),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFBF5AF2).withValues(alpha: 0.30),
                  Color(0xFF0A84FF).withValues(alpha: 0.30),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFBF5AF2), width: 1.0),
            ),
            child: Text(
              'IOSSystemContextMenuItemDataLiveText is a single-purpose, '
              'zero-argument leaf of a sealed hierarchy. Its identity is '
              'the type itself; its behavior lives inside iOS VisionKit. '
              'For Flutter code, the only decision is whether to include '
              'it in the items list passed to SystemContextMenuController.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontFamily: 'monospace',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================
// Helpers
// =============================================================

void _noop() {}

String _describeItems(List<IOSSystemContextMenuItemData> items) {
  final names = items.map((it) {
    if (it is IOSSystemContextMenuItemDataCopy) return 'Copy';
    if (it is IOSSystemContextMenuItemDataCut) return 'Cut';
    if (it is IOSSystemContextMenuItemDataPaste) return 'Paste';
    if (it is IOSSystemContextMenuItemDataSelectAll) return 'SelectAll';
    if (it is IOSSystemContextMenuItemDataLookUp) return 'LookUp';
    if (it is IOSSystemContextMenuItemDataSearchWeb) return 'SearchWeb';
    if (it is IOSSystemContextMenuItemDataShare) return 'Share';
    if (it is IOSSystemContextMenuItemDataLiveText) return 'LiveText';
    if (it is IOSSystemContextMenuItemDataCustom) return 'Custom';
    return 'Unknown';
  }).toList();
  return names.join(', ');
}

Widget _sectionTitle(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(12.0, 6.0, 0.0, 6.0),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Color(0xFFBF5AF2), width: 4.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _intro(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFFCFCFD3),
        fontSize: 12.0,
        height: 1.5,
      ),
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11.0,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _treeRow(String label, Color color, int depth, bool isRoot) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 18.0, top: 4.0, bottom: 4.0),
    child: Row(
      children: [
        if (!isRoot)
          Text(
            '\u2514\u2500 ',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 12.0,
              fontFamily: 'monospace',
            ),
          ),
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontFamily: 'monospace',
            fontWeight: isRoot ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget _catalogCard({
  required String label,
  required IconData symbol,
  required Color accent,
  required String title,
  required String kind,
  required bool highlighted,
}) {
  return Container(
    width: 170.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: highlighted
            ? [
                accent.withValues(alpha: 0.30),
                accent.withValues(alpha: 0.10),
              ]
            : [
                Color(0xFF2C2C2E),
                Color(0xFF1C1C1E),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: highlighted ? accent : Color(0xFF3A3A3C),
        width: highlighted ? 2.0 : 1.0,
      ),
      boxShadow: highlighted
          ? <BoxShadow>[
              BoxShadow(
                color: accent.withValues(alpha: 0.5),
                blurRadius: 16.0,
                offset: Offset(0.0, 0.0),
              ),
            ]
          : <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(symbol, color: accent, size: 22.0),
            ),
            SizedBox(width: 10.0),
            if (highlighted)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'FOCUS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'title: $title',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 10.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          kind,
          style: TextStyle(
            color: accent,
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _eqBadge(bool eq) {
  final color = eq ? Color(0xFF30D158) : Color(0xFFFF453A);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      eq ? 'true' : 'false',
      style: TextStyle(
        color: color,
        fontSize: 11.0,
        fontFamily: 'monospace',
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _pipelineRow(
  String index,
  IconData icon,
  String title,
  String detail, {
  required bool isLast,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: isLast ? 0.0 : 12.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.30),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFBF5AF2), Color(0xFF0A84FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              index,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Icon(icon, color: Color(0xFFFFD60A), size: 22.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                detail,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11.0,
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

Map<String, Object> _menuRow(String label, IconData icon, bool focus) {
  return <String, Object>{
    'label': label,
    'icon': icon,
    'focus': focus,
  };
}

Widget _systemMenuMockup({
  required String title,
  required List<Map<String, Object>> rows,
  required List<IOSSystemContextMenuItemData> captionItems,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1C1C1E), Color(0xFF0A0A0C)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF3A3A3C), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: Color(0xFF30D158),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              'iOS · system context menu',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 11.0,
                fontFamily: 'monospace',
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Color(0xFF3A3A3C), width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 16.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < rows.length; i++)
                _menuItemRow(
                  rows[i]['label'].toString(),
                  rows[i]['icon'] as IconData,
                  rows[i]['focus'] as bool,
                  isLast: i == rows.length - 1,
                ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'items list contains: ${captionItems.length} entries '
          '(including LiveText)',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 10.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _menuItemRow(
  String label,
  IconData icon,
  bool focus, {
  required bool isLast,
}) {
  final color = focus ? Color(0xFFBF5AF2) : Colors.white;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: focus
          ? Color(0xFFBF5AF2).withValues(alpha: 0.18)
          : Colors.transparent,
      border: Border(
        bottom: BorderSide(
          color: isLast ? Colors.transparent : Color(0xFF3A3A3C),
          width: 0.5,
        ),
      ),
      borderRadius: focus ? BorderRadius.circular(8.0) : null,
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13.0,
              fontWeight: focus ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        if (focus)
          Icon(Icons.arrow_forward_ios, color: color, size: 12.0),
      ],
    ),
  );
}

Widget _patternCard({
  required String title,
  required String body,
  required Color accent,
  required IconData symbol,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.18),
          accent.withValues(alpha: 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(symbol, color: accent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          body,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            height: 1.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _corner(bool top, bool left) {
  return Container(
    width: 18.0,
    height: 18.0,
    decoration: BoxDecoration(
      border: Border(
        top: top
            ? BorderSide(color: Color(0xFFFFD60A), width: 3.0)
            : BorderSide.none,
        bottom: !top
            ? BorderSide(color: Color(0xFFFFD60A), width: 3.0)
            : BorderSide.none,
        left: left
            ? BorderSide(color: Color(0xFFFFD60A), width: 3.0)
            : BorderSide.none,
        right: !left
            ? BorderSide(color: Color(0xFFFFD60A), width: 3.0)
            : BorderSide.none,
      ),
    ),
  );
}

Widget _timelineRow(String year, String label, String note, bool on) {
  final color = on ? Color(0xFF30D158) : Color(0xFF8E8E93);
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 3.0),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 60.0,
          padding: EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            year,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 11.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                note,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11.0,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        Icon(
          on ? Icons.check_circle : Icons.cancel,
          color: color,
          size: 18.0,
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color accent) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF050507),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: accent, width: 3.0),
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        color: accent,
        fontSize: 11.0,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}
