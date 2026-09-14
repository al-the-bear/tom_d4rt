// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemDataLookUp from services
// Deep Demo: Visual demonstration of the iOS "Look Up" system context menu item
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataLookUp Deep Demo executing');

  // ============================================================
  // Color palette for the demo (iOS slate + dictionary purple)
  // ============================================================
  final Color iosBlue = Color(0xFF007AFF);
  final Color iosSlateDark = Color(0xFF1C1C1E);
  final Color iosSlateMid = Color(0xFF2C2C2E);
  final Color iosSlateLight = Color(0xFF3A3A3C);
  final Color iosSeparator = Color(0xFF38383A);
  final Color dictionaryPurple = Color(0xFF6B4EFF);
  final Color dictionaryDeep = Color(0xFF3D2A99);
  final Color iosRed = Color(0xFFFF3B30);
  final Color iosGreen = Color(0xFF34C759);
  final Color iosOrange = Color(0xFFFF9500);
  final Color iosPink = Color(0xFFFF2D55);
  final Color iosTeal = Color(0xFF30B0C7);
  final Color iosYellow = Color(0xFFFFCC00);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [iosBlue, dictionaryPurple, dictionaryDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.6, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: dictionaryPurple.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.menu_book_rounded,
            size: 60.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'IOSSystemContextMenuItemDataLookUp',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'iOS System Context Menu - "Look Up"',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.85),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            'package:flutter/services.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title banner constructed');

  // ============================================================
  // SECTION 2: Anatomy - Fake iOS context menu mock
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyMockMenu = Container(
    width: 240.0,
    decoration: BoxDecoration(
      color: iosSlateDark,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: iosSlateLight, width: 0.6),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.55),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMenuRow('Cut', Icons.content_cut, false, iosSeparator),
        _buildMenuRow('Copy', Icons.copy, false, iosSeparator),
        _buildMenuRow('Paste', Icons.content_paste, false, iosSeparator),
        _buildMenuRow('Look Up', Icons.menu_book_rounded, true, iosSeparator),
        _buildMenuRow('Translate', Icons.translate, false, iosSeparator),
        _buildMenuRow('Share...', Icons.ios_share, false, null),
      ],
    ),
  );

  final anatomySection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [iosSlateMid, iosSlateDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of an iOS Context Menu',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'The "Look Up" row is highlighted - this is what'
          ' IOSSystemContextMenuItemDataLookUp produces inside'
          ' the native menu rendered by EditableText.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
            height: 1.4,
          ),
        ),
        SizedBox(height: 18.0),
        Center(child: anatomyMockMenu),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: dictionaryPurple.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: dictionaryPurple.withValues(alpha: 0.6),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: dictionaryPurple, size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'The actual rendering is owned by iOS UIKit; '
                  'Flutter only provides metadata describing which '
                  'items to include and an optional title override.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.white,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Anatomy section built');

  // ============================================================
  // SECTION 3: Constructor variants - several titles
  // ============================================================
  print('=== Section 3: Constructor variants ===');

  const itemA = IOSSystemContextMenuItemDataLookUp(title: 'Look Up');
  const itemB = IOSSystemContextMenuItemDataLookUp(title: 'Define');
  const itemC = IOSSystemContextMenuItemDataLookUp(title: 'Nachschlagen');
  const itemD = IOSSystemContextMenuItemDataLookUp(title: 'Rechercher');
  const itemE = IOSSystemContextMenuItemDataLookUp(title: 'Buscar');

  print('itemA.title = ${itemA.title}');
  print('itemB.title = ${itemB.title}');
  print('itemC.title = ${itemC.title}');
  print('itemD.title = ${itemD.title}');
  print('itemE.title = ${itemE.title}');

  final constructorEntries = [
    {
      'label': 'Default English title',
      'item': itemA,
      'note': 'title: "Look Up" - the canonical English label used '
          'by iOS for the dictionary entry.',
      'color': iosBlue,
    },
    {
      'label': 'Custom verb',
      'item': itemB,
      'note': 'title: "Define" - rebrands the row for a dictionary app.',
      'color': dictionaryPurple,
    },
    {
      'label': 'German title',
      'item': itemC,
      'note': 'title: "Nachschlagen" - manual localisation override.',
      'color': iosTeal,
    },
    {
      'label': 'French title',
      'item': itemD,
      'note': 'title: "Rechercher" - useful when locale routing differs.',
      'color': iosOrange,
    },
    {
      'label': 'Spanish title',
      'item': itemE,
      'note': 'title: "Buscar" - explicit Spanish override.',
      'color': iosPink,
    },
  ];

  final constructorCards = <Widget>[];
  for (final entry in constructorEntries) {
    final item = entry['item'] as IOSSystemContextMenuItemDataLookUp;
    final color = entry['color'] as Color;
    constructorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: color.withValues(alpha: 0.55),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
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
                    color: color.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: color,
                    size: 20.0,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    entry['label'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    '"${item.title}"',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                entry['note'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: iosSlateDark,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'IOSSystemContextMenuItemDataLookUp(title: '
                    '"${item.title}")',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.greenAccent.shade100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Constructor cards: ${constructorCards.length}');

  // ============================================================
  // SECTION 4: Default title (null) - locale fallback
  // ============================================================
  print('=== Section 4: Default title fallback ===');

  final localeFallback = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          iosBlue.withValues(alpha: 0.10),
          dictionaryPurple.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: iosBlue.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: iosBlue.withValues(alpha: 0.18),
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
            Icon(Icons.translate, color: iosBlue, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'Locale-aware titles for "Look Up"',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: iosSlateDark,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'The title parameter is what the menu row displays. To match '
          'the user\'s locale, supply the localised string yourself. '
          'Below are common translations used by iOS itself.',
          style: TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 16.0),
        // Locale grid
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildLocaleChip('en-US', 'Look Up', iosBlue),
            _buildLocaleChip('en-GB', 'Look Up', iosBlue),
            _buildLocaleChip('de-DE', 'Nachschlagen', iosOrange),
            _buildLocaleChip('fr-FR', 'Rechercher', iosPink),
            _buildLocaleChip('es-ES', 'Buscar', iosGreen),
            _buildLocaleChip('it-IT', 'Cerca', iosRed),
            _buildLocaleChip('ja-JP', '調べる', dictionaryPurple),
            _buildLocaleChip('zh-CN', '查询', iosTeal),
            _buildLocaleChip('ko-KR', '찾아보기', iosYellow),
            _buildLocaleChip('ar-SA', 'بحث', dictionaryDeep),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: iosSlateDark,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Supply the locale-appropriate label\n'
            'const lookup = IOSSystemContextMenuItemDataLookUp(\n'
            '  title: "Look Up",\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.greenAccent.shade100,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
  print('Locale fallback section built');

  // ============================================================
  // SECTION 5: Use case in EditableText / SystemContextMenu
  // ============================================================
  print('=== Section 5: EditableText use case ===');

  final useCaseSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [iosSlateDark, dictionaryDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: dictionaryDeep.withValues(alpha: 0.5),
          blurRadius: 18.0,
          offset: Offset(0.0, 9.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.edit, color: Colors.white, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'How EditableText produces this item',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Flow diagram
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFlowNode('User long-presses', Icons.touch_app, iosBlue),
            Icon(Icons.arrow_forward, color: Colors.white54, size: 18.0),
            _buildFlowNode(
              'EditableText.contextMenuBuilder',
              Icons.code,
              iosOrange,
            ),
            Icon(Icons.arrow_forward, color: Colors.white54, size: 18.0),
            _buildFlowNode('SystemContextMenu', Icons.menu, dictionaryPurple),
          ],
        ),
        SizedBox(height: 14.0),
        Center(child: Icon(Icons.south, color: Colors.white54, size: 22.0)),
        SizedBox(height: 14.0),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: dictionaryPurple,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: dictionaryPurple.withValues(alpha: 0.7),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 18.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  'IOSSystemContextMenuItemDataLookUp',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'When the platform is iOS and the system context menu is enabled, '
          'EditableText collects the relevant items (Cut, Copy, Paste, '
          'Look Up, ...) into a list of IOSSystemContextMenuItemData and '
          'forwards them to UIKit, which renders the actual menu.',
          style: TextStyle(fontSize: 12.0, color: Colors.white70, height: 1.4),
        ),
      ],
    ),
  );
  print('Use case section built');

  // ============================================================
  // SECTION 6: Comparison with sibling iOS menu items
  // ============================================================
  print('=== Section 6: Sibling comparison ===');

  final siblings = [
    {
      'name': 'Copy',
      'icon': Icons.copy,
      'color': iosBlue,
      'role': 'Copy selection',
    },
    {
      'name': 'Cut',
      'icon': Icons.content_cut,
      'color': iosRed,
      'role': 'Cut selection',
    },
    {
      'name': 'Paste',
      'icon': Icons.content_paste,
      'color': iosGreen,
      'role': 'Insert clipboard',
    },
    {
      'name': 'Look Up',
      'icon': Icons.menu_book_rounded,
      'color': dictionaryPurple,
      'role': 'Dictionary popup',
    },
    {
      'name': 'Translate',
      'icon': Icons.translate,
      'color': iosOrange,
      'role': 'iOS Translate sheet',
    },
    {
      'name': 'Share',
      'icon': Icons.ios_share,
      'color': iosTeal,
      'role': 'Share sheet',
    },
    {
      'name': 'Search Web',
      'icon': Icons.travel_explore,
      'color': iosPink,
      'role': 'Open Safari',
    },
    {
      'name': 'Select All',
      'icon': Icons.select_all,
      'color': iosYellow,
      'role': 'Expand selection',
    },
  ];

  final siblingChips = <Widget>[];
  for (final sib in siblings) {
    final color = sib['color'] as Color;
    final isLookUp = sib['name'] == 'Look Up';
    siblingChips.add(
      Container(
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: isLookUp ? 0.3 : 0.12),
              color.withValues(alpha: isLookUp ? 0.18 : 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: isLookUp ? 1.0 : 0.45),
            width: isLookUp ? 2.0 : 1.0,
          ),
          boxShadow: isLookUp
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(sib['icon'] as IconData, color: color, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              sib['name'] as String,
              style: TextStyle(
                fontWeight: isLookUp ? FontWeight.w800 : FontWeight.w600,
                color: color,
                fontSize: 12.5,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              width: 1.0,
              height: 14.0,
              color: color.withValues(alpha: 0.4),
            ),
            SizedBox(width: 8.0),
            Text(
              sib['role'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.black87,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final siblingSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sibling iOS context-menu items',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: iosSlateDark,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Each sibling is a different IOSSystemContextMenuItemData '
          'subclass; they share the same parent type. Look Up is '
          'highlighted below.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 14.0),
        Wrap(children: siblingChips),
      ],
    ),
  );
  print('Sibling comparison built (${siblings.length} chips)');

  // ============================================================
  // SECTION 7: Real-world iPhone-style mock with Look Up open
  // ============================================================
  print('=== Section 7: iPhone mock ===');

  final phoneMock = Container(
    width: 280.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(36.0),
      border: Border.all(color: Colors.grey.shade800, width: 6.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 24.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFEFF4), Color(0xFFE5E5EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: Column(
        children: [
          // Status bar mock
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '9:41',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.signal_cellular_4_bar,
                        size: 12.0, color: Colors.black),
                    SizedBox(width: 4.0),
                    Icon(Icons.wifi, size: 12.0, color: Colors.black),
                    SizedBox(width: 4.0),
                    Icon(Icons.battery_full, size: 14.0, color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          // Notes-like header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 14.0, color: iosBlue),
                Expanded(
                  child: Text(
                    'Notes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: iosSlateDark,
                    ),
                  ),
                ),
                Icon(Icons.more_horiz, size: 16.0, color: iosBlue),
              ],
            ),
          ),
          SizedBox(height: 14.0),
          // Text with selection
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: iosBlue.withValues(alpha: 0.4)),
            ),
            child: Wrap(
              children: [
                Text(
                  'The quick brown ',
                  style: TextStyle(fontSize: 14.0, color: iosSlateDark),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: iosBlue.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    'serendipity',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: iosSlateDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  ' jumps over the lazy fox.',
                  style: TextStyle(fontSize: 14.0, color: iosSlateDark),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.0),
          // Floating context menu
          Container(
            decoration: BoxDecoration(
              color: iosSlateDark,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuRow('Copy', Icons.copy, false, iosSeparator),
                _buildMenuRow(
                  'Look Up',
                  Icons.menu_book_rounded,
                  true,
                  iosSeparator,
                ),
                _buildMenuRow('Translate', Icons.translate, false, null),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  final phoneSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          dictionaryPurple.withValues(alpha: 0.10),
          iosBlue.withValues(alpha: 0.10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
        color: dictionaryPurple.withValues(alpha: 0.3),
        width: 1.0,
      ),
    ),
    child: Column(
      children: [
        Text(
          'Real-world: selected word + system menu',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: iosSlateDark,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A long-press on "serendipity" opens the iOS system menu '
          'with a Look Up row provided by IOSSystemContextMenuItemDataLookUp.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 16.0),
        phoneMock,
      ],
    ),
  );
  print('iPhone mock built');

  // ============================================================
  // SECTION 8: Customisation - when to override title, accessibility
  // ============================================================
  print('=== Section 8: Customisation ===');

  final customisationSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [iosTeal.withValues(alpha: 0.10), iosBlue.withValues(alpha: 0.10)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: iosTeal.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: iosTeal.withValues(alpha: 0.18),
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
            Icon(Icons.tune, color: iosTeal, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'Customisation guidance',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: iosSlateDark,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildAdviceRow(
          Icons.check_circle,
          iosGreen,
          'Override title only when domain language matters',
          'A reading-app might prefer "Define" over the generic '
              '"Look Up". A medical app might say "Lookup symptom".',
        ),
        SizedBox(height: 10.0),
        _buildAdviceRow(
          Icons.warning_amber_rounded,
          iosOrange,
          'Don\'t hand-localise unless you must',
          'iOS already returns a localised label when title is null. '
              'Manual localisation can drift from system terminology.',
        ),
        SizedBox(height: 10.0),
        _buildAdviceRow(
          Icons.accessibility_new,
          iosBlue,
          'Accessibility hint',
          'VoiceOver reads the title verbatim. Use words a screen-reader '
              'user will recognise. Avoid emojis.',
        ),
        SizedBox(height: 10.0),
        _buildAdviceRow(
          Icons.text_format,
          dictionaryPurple,
          'Keep titles short',
          'iOS truncates long labels. Two short words at most.',
        ),
        SizedBox(height: 10.0),
        _buildAdviceRow(
          Icons.swap_horiz,
          iosPink,
          'RTL languages',
          'iOS handles bidi reordering automatically; do not pre-flip.',
        ),
      ],
    ),
  );
  print('Customisation section built');

  // ============================================================
  // SECTION 9: Code block - registering with SystemContextMenu
  // ============================================================
  print('=== Section 9: Code block ===');

  final codeSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [iosSlateDark, Color(0xFF111114)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyanAccent, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'Wiring it into a SystemContextMenu',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          '// 1. Build a list of items for iOS\n'
          'const items = <IOSSystemContextMenuItemData>[\n'
          '  IOSSystemContextMenuItemDataCopy(),\n'
          '  IOSSystemContextMenuItemDataLookUp(title: "Look Up"),\n'
          '  IOSSystemContextMenuItemDataPaste(),\n'
          '];',
          Colors.cyanAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 2. Override title for a domain dictionary app\n'
          'const item = IOSSystemContextMenuItemDataLookUp(\n'
          '  title: "Define",\n'
          ');',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 3. Use inside EditableText.contextMenuBuilder\n'
          'TextField(\n'
          '  contextMenuBuilder: (ctx, state) {\n'
          '    if (SystemContextMenu.isSupported(ctx)) {\n'
          '      return SystemContextMenu.editableText(\n'
          '        editableTextState: state,\n'
          '      );\n'
          '    }\n'
          '    return AdaptiveTextSelectionToolbar.editableText(\n'
          '      editableTextState: state,\n'
          '    );\n'
          '  },\n'
          ');',
          Colors.amberAccent.shade100,
        ),
      ],
    ),
  );
  print('Code section built');

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = [
    {
      'icon': Icons.error_outline,
      'color': iosRed,
      'title': 'title is the literal label',
      'body': 'Whatever string you pass is what iOS shows. There is no '
          'automatic translation - hand-localise per locale or pick a '
          'neutral English term.',
    },
    {
      'icon': Icons.devices_other,
      'color': iosOrange,
      'title': 'iOS-only feature',
      'body': 'Sending these items on Android is a no-op. Guard with '
          'defaultTargetPlatform == TargetPlatform.iOS or '
          'SystemContextMenu.isSupported(context).',
    },
    {
      'icon': Icons.history,
      'color': iosYellow,
      'title': 'iOS version differences',
      'body': 'The Look Up sheet contents (Wikipedia, App Store, '
          'Siri Suggestions) vary by iOS version and region. Don\'t '
          'depend on a particular layout.',
    },
    {
      'icon': Icons.format_textdirection_r_to_l,
      'color': dictionaryPurple,
      'title': 'RTL languages',
      'body': 'iOS automatically mirrors the menu in RTL locales. '
          'Setting a manual title in an LTR language inside an RTL '
          'app produces a mixed-direction row.',
    },
    {
      'icon': Icons.location_off,
      'color': iosPink,
      'title': 'Dictionary not installed',
      'body': 'Some regions require downloading dictionaries first. '
          'Look Up may show an empty sheet. Cannot be detected from Flutter.',
    },
    {
      'icon': Icons.lock_outline,
      'color': iosTeal,
      'title': 'No callback fired',
      'body': 'The system handles the action; Flutter does not get a '
          'callback. Don\'t rely on it for analytics.',
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    final color = fg['color'] as Color;
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(fg['icon'] as IconData, color: color, size: 20.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['body'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Footgun cards: ${footgunCards.length}');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [dictionaryDeep, dictionaryPurple, iosBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: dictionaryPurple.withValues(alpha: 0.55),
          blurRadius: 22.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                Icons.bookmark_added,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Recap',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildRecapBullet(
          'Subclass of IOSSystemContextMenuItemData modelling the '
          'iOS "Look Up" entry.',
        ),
        _buildRecapBullet(
          'Single field: title. Constructor: '
          'IOSSystemContextMenuItemDataLookUp({this.title}).',
        ),
        _buildRecapBullet(
          'Supply the locale-appropriate string yourself - the value '
          'is what iOS displays in the menu row.',
        ),
        _buildRecapBullet(
          'Used by EditableText\'s contextMenuBuilder when '
          'SystemContextMenu renders the menu.',
        ),
        _buildRecapBullet(
          'iOS-only - other platforms ignore the entry.',
        ),
        _buildRecapBullet(
          'No Flutter callback: tap is fully handled by iOS UIKit.',
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'const IOSSystemContextMenuItemDataLookUp({this.title})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
  print('Recap section built');

  print('IOSSystemContextMenuItemDataLookUp Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF7F7FA),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 16.0),
          _buildSectionHeader(
            '1. Anatomy',
            Icons.layers,
            dictionaryPurple,
          ),
          anatomySection,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '2. Constructor variants',
            Icons.build,
            iosBlue,
          ),
          ...constructorCards,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '3. Default title fallback',
            Icons.translate,
            iosOrange,
          ),
          localeFallback,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '4. EditableText use case',
            Icons.edit,
            dictionaryPurple,
          ),
          useCaseSection,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '5. Sibling iOS menu items',
            Icons.compare_arrows,
            iosTeal,
          ),
          siblingSection,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '6. iPhone mock',
            Icons.phone_iphone,
            iosBlue,
          ),
          phoneSection,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '7. Customisation',
            Icons.tune,
            iosTeal,
          ),
          customisationSection,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '8. Wiring code',
            Icons.code,
            iosGreen,
          ),
          codeSection,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '9. Footguns',
            Icons.warning_amber_rounded,
            iosRed,
          ),
          ...footgunCards,
          SizedBox(height: 8.0),
          _buildSectionHeader(
            '10. Recap',
            Icons.bookmark,
            dictionaryPurple,
          ),
          recapSection,
          SizedBox(height: 28.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _buildSectionHeader(String label, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMenuRow(
  String label,
  IconData icon,
  bool highlighted,
  Color? separatorColor,
) {
  final Color hlColor = Color(0xFF6B4EFF);
  return Container(
    decoration: BoxDecoration(
      color: highlighted ? hlColor.withValues(alpha: 0.22) : null,
      border: separatorColor == null
          ? null
          : Border(bottom: BorderSide(color: separatorColor, width: 0.6)),
    ),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    child: Row(
      children: [
        Icon(
          icon,
          color: highlighted ? hlColor : Colors.white,
          size: 16.0,
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: highlighted ? hlColor : Colors.white,
              fontWeight: highlighted ? FontWeight.w700 : FontWeight.w500,
              fontSize: 13.0,
            ),
          ),
        ),
        if (highlighted)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: hlColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'this',
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _buildLocaleChip(String locale, String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: color.withValues(alpha: 0.55),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            locale,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowNode(String label, IconData icon, Color color) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(height: 4.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.5,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAdviceRow(
  IconData icon,
  Color color,
  String title,
  String body,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(icon, color: color, size: 18.0),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: color,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              body,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF111114),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFF2C2C2E), width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.5,
      ),
    ),
  );
}

Widget _buildRecapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
