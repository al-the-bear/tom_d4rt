// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataShare Deep Demo executing');

  // ==========================================================================
  // Real instances of IOSSystemContextMenuItemDataShare for verification.
  // The `title` parameter is required by the constructor.
  // ==========================================================================
  const shareDefault = IOSSystemContextMenuItemDataShare(title: 'Share');
  const shareCustom = IOSSystemContextMenuItemDataShare(title: 'Share article');
  const shareLong = IOSSystemContextMenuItemDataShare(
    title: 'Share with collaborators',
  );
  const shareEmoji = IOSSystemContextMenuItemDataShare(title: 'Share now');
  print('Default share title: ${shareDefault.title}');
  print('Custom share title: ${shareCustom.title}');
  print('Long share title: ${shareLong.title}');
  print('Emoji share title: ${shareEmoji.title}');
  print('Type: ${shareCustom.runtimeType}');

  // Sibling instances to confirm the surrounding family compiles too.
  const sibCopy = IOSSystemContextMenuItemDataCopy();
  const sibCut = IOSSystemContextMenuItemDataCut();
  const sibPaste = IOSSystemContextMenuItemDataPaste();
  const sibSelectAll = IOSSystemContextMenuItemDataSelectAll();
  const sibLookUp = IOSSystemContextMenuItemDataLookUp(title: 'Look Up');
  const sibSearchWeb = IOSSystemContextMenuItemDataSearchWeb(title: 'Search Web');
  const sibLiveText = IOSSystemContextMenuItemDataLiveText();
  print('Sibling list assembled: ${[
    sibCopy.runtimeType,
    sibCut.runtimeType,
    sibPaste.runtimeType,
    sibSelectAll.runtimeType,
    sibLookUp.title,
    sibSearchWeb.title,
    sibLiveText.runtimeType,
  ]}');

  // Color palette anchors used throughout the demo.
  const Color iosBlue = Color(0xFF007AFF);
  const Color iosGrey1 = Color(0xFFF2F2F7);
  const Color iosGrey2 = Color(0xFFE5E5EA);
  const Color iosGrey3 = Color(0xFFD1D1D6);
  const Color iosGrey4 = Color(0xFFC7C7CC);
  const Color iosLabel = Color(0xFF1C1C1E);
  const Color iosSecondaryLabel = Color(0xFF6E6E73);
  const Color iosGreen = Color(0xFF34C759);
  const Color iosOrange = Color(0xFFFF9500);
  const Color iosRed = Color(0xFFFF3B30);
  const Color iosPurple = Color(0xFFAF52DE);
  const Color iosTeal = Color(0xFF5AC8FA);

  // ==========================================================================
  // SECTION 1 — Title banner (iOS blue/grey gradient)
  // ==========================================================================
  print('=== Section 1: Title banner ===');

  final Widget section1Banner = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [iosBlue, Color(0xFF4DA3FF), iosGrey3],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: iosBlue.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.ios_share,
                color: Colors.white,
                size: 32.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'IOSSystemContextMenuItemDataShare',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'iOS native context-menu Share item',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: const Text(
            'package:flutter/services.dart  •  iOS 16+  •  EditableText only',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2 — Anatomy / hierarchy diagram
  // ==========================================================================
  print('=== Section 2: Anatomy hierarchy ===');

  final List<String> siblingNames = [
    'Share',
    'Copy',
    'Cut',
    'Paste',
    'SelectAll',
    'LookUp',
    'Translate',
    'SearchWeb',
    'CaptureTextFromCamera',
  ];

  final List<Widget> siblingChips = siblingNames.map((name) {
    final bool isShare = name == 'Share';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isShare
              ? [iosBlue, const Color(0xFF4DA3FF)]
              : [iosGrey2, iosGrey1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isShare ? iosBlue : iosGrey3,
          width: isShare ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: (isShare ? iosBlue : Colors.black).withValues(alpha: 0.15),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          fontWeight: isShare ? FontWeight.w700 : FontWeight.w500,
          color: isShare ? Colors.white : iosLabel,
        ),
      ),
    );
  }).toList();

  final Widget section2Anatomy = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colors.white, iosGrey1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: iosGrey3, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Type Hierarchy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: iosLabel,
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: iosGrey1,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: iosGrey3, width: 1.0),
          ),
          child: const Row(
            children: [
              Icon(Icons.account_tree_outlined, size: 18.0, color: iosBlue),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'IOSSystemContextMenuItemData (sealed base)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: iosLabel,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Container(
            width: 1.5,
            height: 18.0,
            color: iosGrey4,
          ),
        ),
        const SizedBox(height: 4.0),
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            'subclasses ↓',
            style: TextStyle(
              fontSize: 11.0,
              color: iosSecondaryLabel,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(children: siblingChips),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 3 — Constructor card
  // ==========================================================================
  print('=== Section 3: Constructor card ===');

  final Widget section3Constructor = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF2C2C2E), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.code, color: iosTeal, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Constructor',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
                color: iosTeal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: iosBlue.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: const Text(
            'const IOSSystemContextMenuItemDataShare({\n'
            '  required this.title,\n'
            '});\n'
            '\n'
            '// Usage\n'
            'final item = IOSSystemContextMenuItemDataShare(\n'
            "  title: 'Share article',\n"
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Color(0xFFE5E5EA),
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: iosBlue.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'title : String',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: iosTeal,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: iosGreen.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'required',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: iosGreen,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 4 — Title default vs custom (side by side)
  // ==========================================================================
  print('=== Section 4: Title default vs custom ===');

  final Widget defaultTitleCard = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [iosGrey1, iosGrey2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: iosGrey3, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.public, size: 16.0, color: iosSecondaryLabel),
            const SizedBox(width: 6.0),
            const Text(
              "title: 'Share'",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: iosLabel,
                fontSize: 13.0,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: iosGreen,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'default',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Pass the platform-localized "Share" string from '
          'WidgetsLocalizations.shareButtonLabel — required by the constructor.',
          style: TextStyle(fontSize: 12.0, color: iosSecondaryLabel),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: iosGrey3),
          ),
          child: Text(
            "IOSSystemContextMenuItemDataShare(title: 'Share')  →  ${shareDefault.title}",
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: iosLabel,
            ),
          ),
        ),
      ],
    ),
  );

  final Widget customTitleCard = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [iosBlue.withValues(alpha: 0.12), iosBlue.withValues(alpha: 0.04)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: iosBlue.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: iosBlue.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.edit_note, size: 16.0, color: iosBlue),
            const SizedBox(width: 6.0),
            const Text(
              "title: 'Share article'",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: iosLabel,
                fontSize: 13.0,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: iosBlue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'custom',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Override the visible label only. The actual share sheet is still '
          'driven by the iOS platform.',
          style: TextStyle(fontSize: 12.0, color: iosSecondaryLabel),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: iosBlue.withValues(alpha: 0.4)),
          ),
          child: Text(
            "Share(title: 'Share article')  →  ${shareCustom.title}",
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: iosLabel,
            ),
          ),
        ),
      ],
    ),
  );

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #89, P1)
  // section4Titles is Row(crossAxisAlignment: stretch, [Expanded(card),
  // SizedBox(12), Expanded(card)]) sitting inside the outer Column inside
  // a SingleChildScrollView. The stretch wants each Expanded child to
  // match the Row's height, but the Row's vertical extent is unbounded
  // (SCV ancestor), so RenderConstrainedBox receives BoxConstraints
  // (h=infinity) on the two cards and asserts. IntrinsicHeight bounds the
  // Row's height to the taller of the two cards while preserving the
  // side-by-side equal-height comparison layout.
  final Widget section4Titles = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: defaultTitleCard),
        const SizedBox(width: 12.0),
        Expanded(child: customTitleCard),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5 — Sibling comparison table
  // ==========================================================================
  print('=== Section 5: Sibling comparison table ===');

  final List<List<String>> siblingRows = [
    ['Share', '􀈂 ios_share', 'Open the iOS share sheet'],
    ['Copy', '􀐅 copy', 'Copy selection to pasteboard'],
    ['Cut', '􀈄 cut', 'Cut selection to pasteboard'],
    ['Paste', '􀉂 paste', 'Insert pasteboard contents'],
    ['SelectAll', '􀋲 select_all', 'Select all editable text'],
    ['LookUp', '􀊫 search', 'Open dictionary / system Look Up'],
    ['Translate', '􀅎 translate', 'Open Translate sheet'],
    ['SearchWeb', '􀆪 web', 'Search selection on the web'],
    ['CaptureTextFromCamera', '􀫊 camera', 'Insert text via OCR'],
  ];

  final List<Widget> tableRows = [];
  tableRows.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: iosBlue.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: const [
          SizedBox(
            width: 150.0,
            child: Text(
              'Item',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: iosBlue,
              ),
            ),
          ),
          SizedBox(
            width: 110.0,
            child: Text(
              'iOS default icon',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: iosBlue,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Typical action',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: iosBlue,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  for (int i = 0; i < siblingRows.length; i++) {
    final row = siblingRows[i];
    final bool isShare = row[0] == 'Share';
    tableRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isShare
              ? iosBlue.withValues(alpha: 0.06)
              : (i.isEven ? Colors.white : iosGrey1),
          border: Border(
            top: BorderSide(color: iosGrey3, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 150.0,
              child: Text(
                row[0],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: isShare ? FontWeight.w700 : FontWeight.w500,
                  color: isShare ? iosBlue : iosLabel,
                ),
              ),
            ),
            SizedBox(
              width: 110.0,
              child: Text(
                row[1],
                style: const TextStyle(
                  fontSize: 11.0,
                  color: iosSecondaryLabel,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[2],
                style: const TextStyle(fontSize: 11.0, color: iosLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section5Table = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: iosGrey3, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(children: tableRows),
  );

  // ==========================================================================
  // SECTION 6 — Mock iOS context menu
  // ==========================================================================
  print('=== Section 6: Mock iOS context menu ===');

  final List<Map<String, dynamic>> menuRows = [
    {'icon': Icons.content_cut, 'label': 'Cut', 'highlight': false},
    {'icon': Icons.copy, 'label': 'Copy', 'highlight': false},
    {'icon': Icons.content_paste, 'label': 'Paste', 'highlight': false},
    {'icon': Icons.menu_book_outlined, 'label': 'Look Up', 'highlight': false},
    {'icon': Icons.ios_share, 'label': 'Share', 'highlight': true},
    {'icon': Icons.translate, 'label': 'Translate', 'highlight': false},
  ];

  final List<Widget> menuItemWidgets = menuRows.map((m) {
    final bool highlight = m['highlight'] as bool;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: highlight ? iosBlue.withValues(alpha: 0.12) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: iosGrey3.withValues(alpha: 0.6),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            m['label'] as String,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
              color: highlight ? iosBlue : iosLabel,
              letterSpacing: -0.2,
            ),
          ),
          const Spacer(),
          Icon(
            m['icon'] as IconData,
            color: highlight ? iosBlue : iosLabel,
            size: 18.0,
          ),
        ],
      ),
    );
  }).toList();

  final Widget section6MockMenu = Center(
    child: Container(
      width: 280.0,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xF2FFFFFF), Color(0xF2F2F2F7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: iosGrey3.withValues(alpha: 0.7),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 24.0,
            offset: const Offset(0.0, 10.0),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Column(children: menuItemWidgets),
      ),
    ),
  );

  // ==========================================================================
  // SECTION 7 — Localization showcase (6 locales for "Share")
  // ==========================================================================
  print('=== Section 7: Localization showcase ===');

  final List<Map<String, String>> localeData = [
    {'lang': 'en', 'flag': 'EN', 'word': 'Share'},
    {'lang': 'es', 'flag': 'ES', 'word': 'Compartir'},
    {'lang': 'de', 'flag': 'DE', 'word': 'Teilen'},
    {'lang': 'fr', 'flag': 'FR', 'word': 'Partager'},
    {'lang': 'ja', 'flag': 'JA', 'word': '共有'},
    {'lang': 'zh', 'flag': 'ZH', 'word': '分享'},
  ];

  final List<Color> localeAccents = [
    iosBlue,
    iosOrange,
    iosRed,
    iosPurple,
    iosTeal,
    iosGreen,
  ];

  final List<Widget> localeCards = [];
  for (int i = 0; i < localeData.length; i++) {
    final l = localeData[i];
    final Color accent = localeAccents[i];
    localeCards.add(
      Container(
        width: 150.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.16),
              accent.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: accent.withValues(alpha: 0.45),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.20),
              blurRadius: 6.0,
              offset: const Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    l['flag']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  l['lang']!,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: iosSecondaryLabel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              l['word']!,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: accent,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 4.0),
            const Text(
              'system localization',
              style: TextStyle(
                fontSize: 10.0,
                color: iosSecondaryLabel,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section7Locales = Wrap(
    alignment: WrapAlignment.center,
    children: localeCards,
  );

  // ==========================================================================
  // SECTION 8 — EditableText integration code-block
  // ==========================================================================
  print('=== Section 8: EditableText integration ===');

  final Widget section8Integration = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF3A3A3C), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.integration_instructions, color: iosTeal, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'EditableText integration',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
                color: iosTeal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: iosBlue.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: const Text(
            'SystemContextMenu(\n'
            '  anchor: anchorRect,\n'
            '  items: const [\n'
            '    IOSSystemContextMenuItemDataCut(),\n'
            '    IOSSystemContextMenuItemDataCopy(),\n'
            '    IOSSystemContextMenuItemDataPaste(),\n'
            "    IOSSystemContextMenuItemDataLookUp(title: 'Look Up'),\n"
            "    IOSSystemContextMenuItemDataShare(title: 'Share'),\n"
            '    IOSSystemContextMenuItemDataLiveText(),\n'
            '  ],\n'
            ')\n'
            '\n'
            '// Or wire it via EditableText.contextMenuBuilder\n'
            '// and let the framework forward the platform message.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFFE5E5EA),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: iosBlue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'iOS only',
                style: TextStyle(
                  fontSize: 10.0,
                  color: iosTeal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: iosOrange.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'requires iOS 16+',
                style: TextStyle(
                  fontSize: 10.0,
                  color: iosOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 9 — Footguns
  // ==========================================================================
  print('=== Section 9: Footguns ===');

  final List<Map<String, dynamic>> footguns = [
    {
      'icon': Icons.phone_iphone,
      'title': 'iOS-only platform',
      'body': 'No-op on Android, web, desktop. Always check Platform.isIOS.',
      'color': iosBlue,
    },
    {
      'icon': Icons.system_update,
      'title': 'iOS 16+ required',
      'body': 'Older iOS versions silently fall back to legacy menu.',
      'color': iosOrange,
    },
    {
      'icon': Icons.block,
      'title': 'Cannot override the share sheet',
      'body': 'You only configure the menu entry; the platform owns the UI.',
      'color': iosRed,
    },
    {
      'icon': Icons.text_fields,
      'title': 'title is purely a label',
      'body': 'Changing it does not change the behaviour or share targets.',
      'color': iosPurple,
    },
  ];

  final List<Widget> footgunCards = footguns.map((f) {
    final Color c = f['color'] as Color;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [c.withValues(alpha: 0.10), c.withValues(alpha: 0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: c.withValues(alpha: 0.45), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: c.withValues(alpha: 0.15),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(f['icon'] as IconData, color: c, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  f['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                    color: c,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  f['body'] as String,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: iosLabel,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  final Widget section9Footguns = Column(children: footgunCards);

  // ==========================================================================
  // SECTION 10 — Recap card
  // ==========================================================================
  print('=== Section 10: Recap card ===');

  final List<String> takeaways = [
    'Subclass of IOSSystemContextMenuItemData representing the iOS Share menu entry.',
    'Constructor requires a `title` string (typically WidgetsLocalizations.shareButtonLabel).',
    'Plug into SystemContextMenu / EditableText.contextMenuBuilder on iOS only.',
    'iOS 16+ — older versions fall back to the legacy text-selection menu.',
    'You configure the label; iOS owns the actual share-sheet behaviour.',
    'Sibling items: Copy, Cut, Paste, SelectAll, LookUp, Translate, SearchWeb, CaptureTextFromCamera.',
  ];

  final List<Widget> takeawayItems = takeaways.map((t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Icon(Icons.check_circle, size: 16.0, color: Colors.white),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              t,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final Widget section10Recap = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [iosBlue, Color(0xFF0051D5), Color(0xFF1C1C1E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: iosBlue.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.summarize, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        ...takeawayItems,
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Verification: ${shareDefault.runtimeType} == IOSSystemContextMenuItemDataShare',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 11.0,
            ),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // Section header helper inlined as small builder via map – we just compose.
  // ==========================================================================

  Widget sectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [iosGrey1, Colors.white],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(color: iosBlue, width: 3.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: iosBlue,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Icon(icon, color: iosBlue, size: 16.0),
          const SizedBox(width: 6.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: iosLabel,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  print('IOSSystemContextMenuItemDataShare Deep Demo composed successfully');

  // ==========================================================================
  // Final Scaffold
  // ==========================================================================
  return Scaffold(
    backgroundColor: iosGrey1,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          section1Banner,
          const SizedBox(height: 28.0),

          sectionHeader('2', 'Anatomy', Icons.account_tree_outlined),
          section2Anatomy,
          const SizedBox(height: 28.0),

          sectionHeader('3', 'Constructor', Icons.code),
          section3Constructor,
          const SizedBox(height: 28.0),

          sectionHeader('4', 'Title default vs custom', Icons.compare_arrows),
          section4Titles,
          const SizedBox(height: 28.0),

          sectionHeader('5', 'Sibling comparison', Icons.table_chart_outlined),
          section5Table,
          const SizedBox(height: 28.0),

          sectionHeader('6', 'Mock iOS context menu', Icons.menu_open),
          const SizedBox(height: 6.0),
          section6MockMenu,
          const SizedBox(height: 28.0),

          sectionHeader('7', 'Localization showcase', Icons.language),
          section7Locales,
          const SizedBox(height: 28.0),

          sectionHeader('8', 'EditableText integration', Icons.integration_instructions),
          section8Integration,
          const SizedBox(height: 28.0),

          sectionHeader('9', 'Footguns', Icons.warning_amber_outlined),
          section9Footguns,
          const SizedBox(height: 28.0),

          sectionHeader('10', 'Recap', Icons.summarize),
          section10Recap,
          const SizedBox(height: 16.0),
        ],
      ),
    ),
  );
}
