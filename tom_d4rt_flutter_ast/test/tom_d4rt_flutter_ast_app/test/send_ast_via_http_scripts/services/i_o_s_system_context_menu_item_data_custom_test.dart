// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemDataCustom and the full
// IOSSystemContextMenuItemData hierarchy from package:flutter/services.dart.
// Deep Demo theme: a master key-cutter's brass-key blank rack -- a workshop
// where built-in iOS menu items are factory-stamped house keys and the
// Custom variant is a blank brass key blank waiting to be engraved with a
// title and paired with a one-of-a-kind cut pattern (the onPressed callback).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataCustom Deep Demo executing');
  print('=' * 60);
  print("Workshop: Master Key-Cutter's Brass Blank Rack");
  print("Today's order: engrave nine bespoke iOS context menu keys");
  print('=' * 60);

  // ============================================================
  // SECTION 1: Construct one of every concrete sibling subclass
  // ============================================================
  print('=== Section 1: Sibling subclasses on the rack ===');

  final copy = IOSSystemContextMenuItemDataCopy();
  final cut = IOSSystemContextMenuItemDataCut();
  final paste = IOSSystemContextMenuItemDataPaste();
  final selectAll = IOSSystemContextMenuItemDataSelectAll();
  final lookUp = IOSSystemContextMenuItemDataLookUp(title: 'Look Up');
  final searchWeb = IOSSystemContextMenuItemDataSearchWeb(title: 'Search Web');
  final share = IOSSystemContextMenuItemDataShare(title: 'Share...');
  final liveText = IOSSystemContextMenuItemDataLiveText();
  final translate = IOSSystemContextMenuItemDataCustom(
    title: 'Translate to Spanish',
    onPressed: _onTranslateSpanish,
  );

  print('copy.runtimeType      = ${copy.runtimeType}');
  print('cut.runtimeType       = ${cut.runtimeType}');
  print('paste.runtimeType     = ${paste.runtimeType}');
  print('selectAll.runtimeType = ${selectAll.runtimeType}');
  print('lookUp.runtimeType    = ${lookUp.runtimeType}');
  print('searchWeb.runtimeType = ${searchWeb.runtimeType}');
  print('share.runtimeType     = ${share.runtimeType}');
  print('liveText.runtimeType  = ${liveText.runtimeType}');
  print('translate.runtimeType = ${translate.runtimeType}');
  print('translate.title       = ${translate.title}');

  // ============================================================
  // SECTION 2: Six engraved Custom blanks (the showcase)
  // ============================================================
  print('=== Section 2: Six engraved Custom blanks ===');

  final defineWord = IOSSystemContextMenuItemDataCustom(
    title: 'Define Word',
    onPressed: _onDefineWord,
  );
  final saveQuote = IOSSystemContextMenuItemDataCustom(
    title: 'Save Quote',
    onPressed: _onSaveQuote,
  );
  final shareTwitter = IOSSystemContextMenuItemDataCustom(
    title: 'Share to Twitter',
    onPressed: _onShareTwitter,
  );
  final copyMarkdown = IOSSystemContextMenuItemDataCustom(
    title: 'Copy as Markdown',
    onPressed: _onCopyMarkdown,
  );
  final summarize = IOSSystemContextMenuItemDataCustom(
    title: 'Summarize',
    onPressed: _onSummarize,
  );

  final List<IOSSystemContextMenuItemDataCustom> engravedKeys =
      <IOSSystemContextMenuItemDataCustom>[
        translate,
        defineWord,
        saveQuote,
        shareTwitter,
        copyMarkdown,
        summarize,
      ];

  for (int i = 0; i < engravedKeys.length; i++) {
    final key = engravedKeys[i];
    print(
      'blank #${i + 1}: title="${key.title}" '
      '(runtime=${key.runtimeType})',
    );
  }
  print('Engraved ${engravedKeys.length} bespoke brass blanks');

  // Combined catalog: builtins + customs.
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
        translate,
        defineWord,
        saveQuote,
        shareTwitter,
        copyMarkdown,
        summarize,
      ];
  print('Total catalog (built-ins + customs): ${allItems.length} items');

  // ============================================================
  // SECTION 3: Equality semantics (title-driven)
  // ============================================================
  print('=== Section 3: Equality semantics ===');

  final translateA = IOSSystemContextMenuItemDataCustom(
    title: 'Translate to Spanish',
    onPressed: _onTranslateSpanish,
  );
  final translateB = IOSSystemContextMenuItemDataCustom(
    title: 'Translate to Spanish',
    onPressed: _onTranslateSpanishAlt,
  );
  final translateC = IOSSystemContextMenuItemDataCustom(
    title: 'Translate to French',
    onPressed: _onTranslateSpanish,
  );

  final sameTitleSameCallback = translate == translateA;
  final sameTitleDifferentCallback = translate == translateB;
  final differentTitle = translate == translateC;
  final customVsCopy = translate == copy;
  final twoCopies =
      IOSSystemContextMenuItemDataCopy() == IOSSystemContextMenuItemDataCopy();
  final twoLookUpsEq =
      IOSSystemContextMenuItemDataLookUp(title: 'Look Up') ==
      IOSSystemContextMenuItemDataLookUp(title: 'Look Up');
  final twoLookUpsDiff =
      IOSSystemContextMenuItemDataLookUp(title: 'Look Up') ==
      IOSSystemContextMenuItemDataLookUp(title: 'Define');

  print('translate == translateA (same title)              : '
      '$sameTitleSameCallback');
  print('translate == translateB (same title, alt callback): '
      '$sameTitleDifferentCallback');
  print('translate == translateC (different title)         : '
      '$differentTitle');
  print('translate == copy                                 : $customVsCopy');
  print('Copy() == Copy()                                  : $twoCopies');
  print('LookUp("Look Up") == LookUp("Look Up")            : $twoLookUpsEq');
  print('LookUp("Look Up") == LookUp("Define")             : $twoLookUpsDiff');
  print('translate.hashCode  = ${translate.hashCode}');
  print('translateA.hashCode = ${translateA.hashCode}');
  print('translateC.hashCode = ${translateC.hashCode}');

  // ============================================================
  // SECTION 4: Hero header (brass workshop banner)
  // ============================================================
  print('=== Section 4: Hero header ===');

  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF3E2A1F),
          Color(0xFF5A3E2A),
          Color(0xFF3E2A1F),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28.0),
      border: Border.all(color: Color(0xFFB5894D), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0xFFB5894D).withValues(alpha: 0.30),
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
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFE6C078),
                    Color(0xFFB5894D),
                    Color(0xFF6B4A2A),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFB5894D).withValues(alpha: 0.6),
                    blurRadius: 16.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Icon(Icons.vpn_key, size: 44.0, color: Color(0xFF2A1A0F)),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IOSSystemContextMenuItemDataCustom',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Color(0xFFE6C078),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'brass blanks · engraved by hand · paired with cuts',
                    style: TextStyle(
                      color: Color(0xFFC9A876),
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
            _chip('iOS 16.0+', Color(0xFFB5894D)),
            _chip('title + onPressed', Color(0xFFA85D2E)),
            _chip('app-defined action', Color(0xFF4A7C5C)),
            _chip('sealed sibling', Color(0xFF7A5C3F)),
            _chip('eq by title', Color(0xFFD4A574)),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF2A1A0F).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFB5894D).withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'WORKSHOP NOTE: every other key on the rack arrives '
            'pre-stamped from the factory. Only the Custom blank '
            'lets the locksmith engrave a title and file a unique '
            'cut. Today we will engrave six.',
            style: TextStyle(
              color: Color(0xFFE6C078),
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              height: 1.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
  print('Built hero header');

  // ============================================================
  // SECTION 5: Class hierarchy tree (Custom highlighted)
  // ============================================================
  print('=== Section 5: Hierarchy tree ===');

  final hierarchy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3E2A1F), Color(0xFF2A1A0F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF6B4A2A), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
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
            Icon(Icons.account_tree, color: Color(0xFFB5894D), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'sealed class hierarchy',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFB5894D),
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _treeRow('IOSSystemContextMenuItemData', Color(0xFFE6C078), 0, true),
        _treeRow('IOSSystemContextMenuItemDataCopy', Color(0xFFA85D2E), 1, false),
        _treeRow('IOSSystemContextMenuItemDataCut', Color(0xFFA85D2E), 1, false),
        _treeRow('IOSSystemContextMenuItemDataPaste', Color(0xFFA85D2E), 1, false),
        _treeRow(
          'IOSSystemContextMenuItemDataSelectAll',
          Color(0xFFA85D2E),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataLookUp(title)',
          Color(0xFF4A7C5C),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataSearchWeb(title)',
          Color(0xFF4A7C5C),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataShare(title)',
          Color(0xFF4A7C5C),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataLiveText',
          Color(0xFF7A5C3F),
          1,
          false,
        ),
        _treeRow(
          'IOSSystemContextMenuItemDataCustom(title, onPressed)  '
              '<-- this script',
          Color(0xFFD4A574),
          1,
          false,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFB5894D).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFB5894D).withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'Sealed: every IOSSystemContextMenuItemData is one of these nine.\n'
            'Color legend: cream = abstract base, copper = no-arg builtins,\n'
            'patina = title-only built-ins, walnut = LiveText, brass = Custom.\n'
            'Custom is the only blank: it carries both a title and a '
            'callback.',
            style: TextStyle(
              color: Color(0xFFE6C078),
              fontSize: 11.0,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built hierarchy tree (Custom highlighted)');

  // ============================================================
  // SECTION 6: Anatomy of the Custom blank (title + onPressed)
  // ============================================================
  print('=== Section 6: Anatomy of the Custom blank ===');

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFB5894D).withValues(alpha: 0.20),
          Color(0xFF6B4A2A).withValues(alpha: 0.20),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFFB5894D), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB5894D).withValues(alpha: 0.25),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: Color(0xFFE6C078), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'anatomy of a Custom item',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFE6C078),
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _anatomyRow(
          'title',
          'String',
          'shown to the user; participates in operator ==',
          'Translate to Spanish',
          Color(0xFFB5894D),
          Icons.text_fields,
        ),
        _anatomyRow(
          'onPressed',
          'VoidCallback',
          'invoked when the row is tapped; not part of equality',
          '() => translateSelected("es")',
          Color(0xFFA85D2E),
          Icons.touch_app,
        ),
        _anatomyRow(
          'runtimeType',
          'Type',
          'fixed Custom; participates in operator ==',
          'IOSSystemContextMenuItemDataCustom',
          Color(0xFF4A7C5C),
          Icons.fingerprint,
        ),
        _anatomyRow(
          'inherited operator ==',
          'bool Function(Object)',
          'identical OR (runtimeType match AND title match)',
          'a == b iff same type AND same title',
          Color(0xFF7A5C3F),
          Icons.balance,
        ),
        _anatomyRow(
          'inherited hashCode',
          'int',
          'derived from title.hashCode',
          'translate.hashCode == other.hashCode iff titles match',
          Color(0xFFD4A574),
          Icons.tag,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF2A1A0F).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border(
              left: BorderSide(color: Color(0xFFE6C078), width: 3.0),
            ),
          ),
          child: Text(
            'Punchline: two Custom items with the same title compare '
            'equal -- even if their onPressed callbacks point to '
            'completely different functions. The brass blank is '
            'identified by its engraving, not by its cut.',
            style: TextStyle(
              color: Color(0xFFE6C078),
              fontSize: 11.5,
              height: 1.5,
              fontFamily: 'monospace',
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built anatomy diagram');

  // ============================================================
  // SECTION 7: Built-ins gallery (factory-stamped keys)
  // ============================================================
  print('=== Section 7: Built-ins gallery ===');

  final builtinsCatalog = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: [
      _catalogCard(
        label: 'Copy',
        symbol: Icons.content_copy,
        accent: Color(0xFFA85D2E),
        title: 'platform default',
        kind: 'no-arg built-in',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Cut',
        symbol: Icons.content_cut,
        accent: Color(0xFFA85D2E),
        title: 'platform default',
        kind: 'no-arg built-in',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Paste',
        symbol: Icons.content_paste,
        accent: Color(0xFFA85D2E),
        title: 'platform default',
        kind: 'no-arg built-in',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Select All',
        symbol: Icons.select_all,
        accent: Color(0xFFA85D2E),
        title: 'platform default',
        kind: 'no-arg built-in',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Look Up',
        symbol: Icons.menu_book,
        accent: Color(0xFF4A7C5C),
        title: lookUp.title,
        kind: 'title required',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Search Web',
        symbol: Icons.travel_explore,
        accent: Color(0xFF4A7C5C),
        title: searchWeb.title,
        kind: 'title required',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Share',
        symbol: Icons.ios_share,
        accent: Color(0xFF4A7C5C),
        title: share.title,
        kind: 'title required',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Live Text',
        symbol: Icons.document_scanner,
        accent: Color(0xFF7A5C3F),
        title: 'platform default',
        kind: 'iOS 15+, OCR',
        highlighted: false,
      ),
      _catalogCard(
        label: 'Custom',
        symbol: Icons.vpn_key,
        accent: Color(0xFFD4A574),
        title: translate.title,
        kind: 'iOS 16+, callback',
        highlighted: true,
      ),
    ],
  );
  print('Built 9 catalog cards (Custom highlighted)');

  // ============================================================
  // SECTION 8: Custom item gallery (six engraved blanks)
  // ============================================================
  print('=== Section 8: Engraved Custom gallery ===');

  final customGallery = Wrap(
    spacing: 14.0,
    runSpacing: 14.0,
    children: [
      _engravedKey(
        title: translate.title,
        cutPattern: 'translate(selection, locale: "es")',
        symbol: Icons.translate,
        accent: Color(0xFFB5894D),
        notch: 'cut #01',
      ),
      _engravedKey(
        title: defineWord.title,
        cutPattern: 'dictionary.lookup(selection)',
        symbol: Icons.menu_book,
        accent: Color(0xFFA85D2E),
        notch: 'cut #02',
      ),
      _engravedKey(
        title: saveQuote.title,
        cutPattern: 'quotesRepo.save(selection, source)',
        symbol: Icons.bookmark_add,
        accent: Color(0xFF4A7C5C),
        notch: 'cut #03',
      ),
      _engravedKey(
        title: shareTwitter.title,
        cutPattern: 'twitter.compose(text: selection)',
        symbol: Icons.alternate_email,
        accent: Color(0xFF7A5C3F),
        notch: 'cut #04',
      ),
      _engravedKey(
        title: copyMarkdown.title,
        cutPattern: 'clipboard.set(toMarkdown(selection))',
        symbol: Icons.code,
        accent: Color(0xFFD4A574),
        notch: 'cut #05',
      ),
      _engravedKey(
        title: summarize.title,
        cutPattern: 'llm.summarize(selection, max: 80)',
        symbol: Icons.short_text,
        accent: Color(0xFFC9A876),
        notch: 'cut #06',
      ),
    ],
  );
  print('Built ${engravedKeys.length} engraved-key cards');

  // ============================================================
  // SECTION 9: Equality matrix (title-driven)
  // ============================================================
  print('=== Section 9: Equality matrix ===');

  final equalityRows = <Map<String, Object>>[
    {
      'lhs': "Custom('Translate to Spanish', cb1)",
      'rhs': "Custom('Translate to Spanish', cb1)",
      'eq': sameTitleSameCallback,
    },
    {
      'lhs': "Custom('Translate to Spanish', cb1)",
      'rhs': "Custom('Translate to Spanish', cb2)",
      'eq': sameTitleDifferentCallback,
    },
    {
      'lhs': "Custom('Translate to Spanish', cb1)",
      'rhs': "Custom('Translate to French', cb1)",
      'eq': differentTitle,
    },
    {
      'lhs': "Custom('Translate to Spanish', cb1)",
      'rhs': 'Copy()',
      'eq': customVsCopy,
    },
    {
      'lhs': "LookUp('Look Up')",
      'rhs': "LookUp('Look Up')",
      'eq': twoLookUpsEq,
    },
    {
      'lhs': "LookUp('Look Up')",
      'rhs': "LookUp('Define')",
      'eq': twoLookUpsDiff,
    },
  ];

  final matrix = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3E2A1F), Color(0xFF2A1A0F)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF6B4A2A), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB5894D).withValues(alpha: 0.18),
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
            Icon(Icons.balance, color: Color(0xFFD4A574), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'operator == is title-driven (callback ignored)',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFD4A574),
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
                    color: Color(0xFFC9A876),
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
                    color: Color(0xFFC9A876),
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
                    color: Color(0xFFC9A876),
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        for (int i = 0; i < equalityRows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            margin: EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF6B4A2A), width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    equalityRows[i]['lhs'].toString(),
                    style: TextStyle(
                      color: Color(0xFFE6C078),
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    equalityRows[i]['rhs'].toString(),
                    style: TextStyle(
                      color: Color(0xFFE6C078),
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.0,
                  child: Center(
                    child: _eqBadge(equalityRows[i]['eq'] as bool),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF4A7C5C).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFF4A7C5C).withValues(alpha: 0.6),
              width: 1.0,
            ),
          ),
          child: Text(
            'Why: the base class implements `operator ==` as\n'
            '  identical(this, other) || (other.runtimeType == runtimeType && other.title == title)\n'
            'and `hashCode` as `title.hashCode`. For Custom items, that\n'
            'means two blanks engraved with the same title are equal,\n'
            'EVEN IF their onPressed callbacks differ. This matches the\n'
            'iOS native menu, where rows are identified by their visible\n'
            'label rather than by their handler closure.',
            style: TextStyle(
              color: Color(0xFFE6C078),
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
  // SECTION 10: Mock iOS system menu (built-ins + customs interleaved)
  // ============================================================
  print('=== Section 10: System menu mockup ===');

  final mockMenu = _systemMenuMockup(
    title: 'Selected: "The unexamined life is not worth living."',
    rows: <Map<String, Object>>[
      _menuRow('Cut', Icons.content_cut, false, false),
      _menuRow('Copy', Icons.content_copy, false, false),
      _menuRow('Paste', Icons.content_paste, false, false),
      _menuRow('Look Up', Icons.menu_book, false, false),
      _menuRow('Translate to Spanish', Icons.translate, true, true),
      _menuRow('Define Word', Icons.menu_book, true, true),
      _menuRow('Save Quote', Icons.bookmark_add, true, true),
      _menuRow('Share to Twitter', Icons.alternate_email, true, true),
      _menuRow('Copy as Markdown', Icons.code, true, true),
      _menuRow('Summarize', Icons.short_text, true, true),
      _menuRow('Share...', Icons.ios_share, false, false),
    ],
    captionItems: allItems,
  );
  print('Built primary system menu mockup (built-ins + customs)');

  // ============================================================
  // SECTION 11: Composition rules
  // ============================================================
  print('=== Section 11: Composition rules ===');

  // Pattern A: editable + reading-app extras.
  final readingAppMenu = <IOSSystemContextMenuItemData>[
    copy,
    lookUp,
    defineWord,
    translate,
    saveQuote,
    share,
  ];

  // Pattern B: editor with markdown extras.
  final editorMenu = <IOSSystemContextMenuItemData>[
    cut,
    copy,
    paste,
    selectAll,
    copyMarkdown,
    summarize,
  ];

  // Pattern C: read-only with social-share.
  final socialReadOnlyMenu = <IOSSystemContextMenuItemData>[
    copy,
    selectAll,
    shareTwitter,
    saveQuote,
  ];

  // Pattern D: dedup catalog by Set semantics.
  final dedupSeed = <IOSSystemContextMenuItemData>[
    IOSSystemContextMenuItemDataCustom(
      title: 'Translate to Spanish',
      onPressed: _onTranslateSpanish,
    ),
    IOSSystemContextMenuItemDataCustom(
      title: 'Translate to Spanish',
      onPressed: _onTranslateSpanishAlt,
    ),
    IOSSystemContextMenuItemDataCustom(
      title: 'Translate to French',
      onPressed: _onTranslateSpanish,
    ),
    IOSSystemContextMenuItemDataCopy(),
    IOSSystemContextMenuItemDataCopy(),
  ];
  final dedupSet = dedupSeed.toSet();

  print('readingAppMenu length    = ${readingAppMenu.length}');
  print('editorMenu length        = ${editorMenu.length}');
  print('socialReadOnlyMenu length= ${socialReadOnlyMenu.length}');
  print('dedupSeed length         = ${dedupSeed.length}');
  print('dedupSet  length         = ${dedupSet.length}  (Set collapses by ==)');

  final patternsBlock = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _patternCard(
        title: 'A. Reading app: built-ins + reading customs',
        body:
            'Copy, Look Up, then four customs (Define Word, Translate, '
            'Save Quote, Share). Length=${readingAppMenu.length}.\n'
            'Items: ${_describeItems(readingAppMenu)}',
        accent: Color(0xFFA85D2E),
        symbol: Icons.menu_book,
      ),
      _patternCard(
        title: 'B. Editor: clipboard built-ins + markdown customs',
        body:
            'Cut, Copy, Paste, Select All, then Copy as Markdown and '
            'Summarize. Length=${editorMenu.length}.\n'
            'Items: ${_describeItems(editorMenu)}',
        accent: Color(0xFF4A7C5C),
        symbol: Icons.edit_note,
      ),
      _patternCard(
        title: 'C. Read-only with social customs',
        body:
            'Drop Cut/Paste, keep Copy + Select All + Share to Twitter '
            '+ Save Quote. Length=${socialReadOnlyMenu.length}.\n'
            'Items: ${_describeItems(socialReadOnlyMenu)}',
        accent: Color(0xFF7A5C3F),
        symbol: Icons.lock_outline,
      ),
      _patternCard(
        title: 'D. Deduplicate by title (Set semantics)',
        body:
            'A list of ${dedupSeed.length} candidates collapses to a Set of '
            '${dedupSet.length} unique entries because operator == compares\n'
            '(runtimeType, title). Two Custom("Translate to Spanish", ...) '
            'are the SAME key even if their callbacks differ.',
        accent: Color(0xFFD4A574),
        symbol: Icons.filter_alt,
      ),
    ],
  );
  print('Built 4 composition pattern cards');

  // ============================================================
  // SECTION 12: Brass blank engraving station (visual)
  // ============================================================
  print('=== Section 12: Engraving station ===');

  final engravingStation = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 240.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A0F08), Color(0xFF3E2A1F)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFFB5894D), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB5894D).withValues(alpha: 0.4),
          blurRadius: 20.0,
          offset: Offset(0.0, 0.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.7),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFE6C078).withValues(alpha: 0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        Positioned(top: 16.0, left: 16.0, child: _corner(true, true)),
        Positioned(top: 16.0, right: 16.0, child: _corner(true, false)),
        Positioned(bottom: 16.0, left: 16.0, child: _corner(false, true)),
        Positioned(bottom: 16.0, right: 16.0, child: _corner(false, false)),
        Positioned(
          left: 36.0,
          right: 36.0,
          top: 50.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE6C078),
                  Color(0xFFB5894D),
                  Color(0xFF6B4A2A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.vpn_key, color: Color(0xFF2A1A0F), size: 24.0),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'TRANSLATE TO SPANISH',
                    style: TextStyle(
                      color: Color(0xFF2A1A0F),
                      fontSize: 14.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF2A1A0F),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    'BLANK 16-CMM',
                    style: TextStyle(
                      color: Color(0xFFE6C078),
                      fontSize: 8.0,
                      letterSpacing: 1.4,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 36.0,
          right: 36.0,
          top: 110.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Color(0xFF4A7C5C).withValues(alpha: 0.25),
              border: Border.all(color: Color(0xFF4A7C5C), width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              "cut #01: () => translate(selection, 'es')",
              style: TextStyle(
                color: Color(0xFFC9D8C5),
                fontSize: 12.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        Positioned(
          left: 36.0,
          right: 36.0,
          top: 150.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Color(0xFFD4A574).withValues(alpha: 0.20),
              border: Border.all(color: Color(0xFFD4A574), width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'engraving depth: 0.6mm  ·  brass alloy: C36000',
              style: TextStyle(
                color: Color(0xFFE6C078),
                fontSize: 11.0,
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
                  color: Color(0xFFB5894D),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFB5894D).withValues(alpha: 0.7),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.0),
              Text(
                'ENGRAVING',
                style: TextStyle(
                  color: Color(0xFFE6C078),
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
            'station #3 · operator A.K.',
            style: TextStyle(
              color: Color(0xFFC9A876),
              fontSize: 10.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
  print('Built engraving station mockup');

  // ============================================================
  // SECTION 13: Code examples
  // ============================================================
  print('=== Section 13: Code examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF110A04),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF6B4A2A), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB5894D).withValues(alpha: 0.20),
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
            Icon(Icons.code, color: Color(0xFFD4A574), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Real-world snippets',
              style: TextStyle(
                color: Color(0xFFD4A574),
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// 1. The simplest engraved key.\n'
          'final translate = IOSSystemContextMenuItemDataCustom(\n'
          "  title: 'Translate to Spanish',\n"
          "  onPressed: () => translateSelected('es'),\n"
          ');',
          Color(0xFFD4A574),
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 2. Built-ins next to customs in one menu.\n'
          'SystemContextMenuController.show(\n'
          '  targetRect: cursorRect,\n'
          '  items: <IOSSystemContextMenuItemData>[\n'
          '    IOSSystemContextMenuItemDataCopy(),\n'
          "    IOSSystemContextMenuItemDataLookUp(title: 'Look Up'),\n"
          '    IOSSystemContextMenuItemDataCustom(\n'
          "      title: 'Define Word',\n"
          '      onPressed: handleDefine,\n'
          '    ),\n'
          '    IOSSystemContextMenuItemDataCustom(\n'
          "      title: 'Save Quote',\n"
          '      onPressed: handleSave,\n'
          '    ),\n'
          '  ],\n'
          ');',
          Color(0xFFB5894D),
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 3. Equality is title-driven; safe in Sets.\n'
          'final unique = <IOSSystemContextMenuItemData>{\n'
          '  IOSSystemContextMenuItemDataCustom(\n'
          "    title: 'Save Quote',\n"
          '    onPressed: handlerA,\n'
          '  ),\n'
          '  IOSSystemContextMenuItemDataCustom(\n'
          "    title: 'Save Quote',\n"
          '    onPressed: handlerB,\n'
          '  ),\n'
          '}; // length == 1 (callbacks differ but title matches)',
          Color(0xFF4A7C5C),
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 4. Building a per-screen menu programmatically.\n'
          'List<IOSSystemContextMenuItemData> buildMenu({\n'
          '  required bool readOnly,\n'
          '  required bool isLoggedIn,\n'
          '}) {\n'
          '  return <IOSSystemContextMenuItemData>[\n'
          '    if (!readOnly) IOSSystemContextMenuItemDataCut(),\n'
          '    IOSSystemContextMenuItemDataCopy(),\n'
          '    if (!readOnly) IOSSystemContextMenuItemDataPaste(),\n'
          '    if (isLoggedIn) IOSSystemContextMenuItemDataCustom(\n'
          "      title: 'Save Quote',\n"
          '      onPressed: saveQuote,\n'
          '    ),\n'
          '    IOSSystemContextMenuItemDataCustom(\n'
          "      title: 'Translate to Spanish',\n"
          "      onPressed: () => translate(\\'es\\'),\n"
          '    ),\n'
          '  ];\n'
          '}',
          Color(0xFFA85D2E),
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 5. Pattern matching on the sealed hierarchy.\n'
          'String describe(IOSSystemContextMenuItemData item) {\n'
          '  if (item is IOSSystemContextMenuItemDataCustom) {\n'
          '    return "custom: \${item.title}";\n'
          '  }\n'
          '  if (item is IOSSystemContextMenuItemDataLookUp) {\n'
          '    return "lookUp: \${item.title}";\n'
          '  }\n'
          "  return 'built-in';\n"
          '}',
          Color(0xFF7A5C3F),
        ),
      ],
    ),
  );
  print('Built code examples block');

  // ============================================================
  // SECTION 14: Engraving rules / best practices
  // ============================================================
  print('=== Section 14: Engraving rules ===');

  final ruleItems = <Map<String, Object>>[
    {
      'rule': 'Title is sacred',
      'detail':
          'Two Custom items with the same title are equal -- give every '
              'engraved key a unique label or you lose it in a Set.',
      'on': true,
    },
    {
      'rule': 'Keep titles short',
      'detail':
          'iOS chops titles at the menu surface; aim for <= 24 characters '
              'so the brass tag fits the rack.',
      'on': true,
    },
    {
      'rule': 'Localize per-app extras',
      'detail':
          'Custom titles are not localized by the platform -- run them '
              'through your own Intl pipeline.',
      'on': true,
    },
    {
      'rule': 'Order matters',
      'detail':
          'Place built-ins first (Copy, Cut, Paste) and customs after; '
              'iOS preserves the order you supply.',
      'on': true,
    },
    {
      'rule': 'No setState inside onPressed for heavy work',
      'detail':
          'The callback may run after the host widget is gone; capture '
              'a stable handler or an injected service.',
      'on': true,
    },
    {
      'rule': 'Do NOT rely on callback identity',
      'detail':
          'operator == ignores the callback; never use Custom items as '
              'keys in callback-deduplication maps.',
      'on': false,
    },
  ];

  final rules = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2A1A0F), Color(0xFF3E2A1F)],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF6B4A2A), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF4A7C5C).withValues(alpha: 0.20),
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
            Icon(Icons.gavel, color: Color(0xFF4A7C5C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              "Workshop rules for Custom blanks",
              style: TextStyle(
                color: Color(0xFF8DB39A),
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (int i = 0; i < ruleItems.length; i++)
          _ruleRow(
            ruleItems[i]['rule'].toString(),
            ruleItems[i]['detail'].toString(),
            ruleItems[i]['on'] as bool,
          ),
      ],
    ),
  );
  print('Built ${ruleItems.length} engraving rules');

  // ============================================================
  // SECTION 15: Closing brass-stamp
  // ============================================================
  print('=== Section 15: Closing stamp ===');

  final closingStamp = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFB5894D).withValues(alpha: 0.40),
          Color(0xFFA85D2E).withValues(alpha: 0.40),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFE6C078), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB5894D).withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.verified, color: Color(0xFFE6C078), size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'WORKSHOP STAMP',
              style: TextStyle(
                color: Color(0xFFE6C078),
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'IOSSystemContextMenuItemDataCustom is a brass blank: a sealed-'
          'family member that carries both the engraved label (title) '
          'and the unique cut pattern (onPressed). It is the only entry '
          'in the hierarchy where the app developer chooses what the '
          'user sees and what happens on tap. Equality is decided by '
          'the engraving alone, so two blanks with the same title '
          'collapse in Sets even when their cuts differ. Use it for '
          'app-specific actions, place it next to built-ins, and keep '
          'titles short, unique, and localized.',
          style: TextStyle(
            color: Color(0xFFFCEAC4),
            fontSize: 12.0,
            fontFamily: 'monospace',
            height: 1.6,
          ),
        ),
      ],
    ),
  );
  print('Built closing stamp');

  print('Deep Demo for IOSSystemContextMenuItemDataCustom completed');
  print('=' * 60);

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A0F08), Color(0xFF2A1A0F)],
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
            'system context menu item is one of nine types. Custom is '
            'the only "engraveable blank" -- it carries both a title '
            'and an onPressed callback supplied by the app.',
          ),
          hierarchy,
          SizedBox(height: 24.0),
          _sectionTitle('2. Anatomy of a Custom blank'),
          SizedBox(height: 8.0),
          _intro(
            'A Custom item is a tiny class with two app-supplied fields. '
            'The title appears on the menu row and participates in '
            'equality. The onPressed callback fires when the row is '
            'tapped but is deliberately ignored by operator ==.',
          ),
          anatomy,
          SizedBox(height: 24.0),
          _sectionTitle('3. Built-ins gallery (factory keys)'),
          SizedBox(height: 8.0),
          _intro(
            'The eight non-Custom siblings ship with platform-defined '
            'behavior. Copy/Cut/Paste/SelectAll need no arguments; '
            'LookUp/SearchWeb/Share require a title; LiveText is a '
            'no-arg OCR action. The Custom card is highlighted as the '
            'focus of this demo.',
          ),
          builtinsCatalog,
          SizedBox(height: 24.0),
          _sectionTitle('4. Six engraved Custom blanks'),
          SizedBox(height: 8.0),
          _intro(
            'These six examples show the breadth of Custom: locale '
            'transformations, lexical lookups, persistence, social '
            'sharing, format conversion, and AI-driven summarization. '
            'Every card is a concrete IOSSystemContextMenuItemDataCustom '
            'with a non-empty closure for onPressed.',
          ),
          customGallery,
          SizedBox(height: 24.0),
          _sectionTitle('5. Equality semantics'),
          SizedBox(height: 8.0),
          _intro(
            'The base class implements operator == and hashCode in '
            'terms of (runtimeType, title). For Custom items this '
            'means the callback is irrelevant: same title => same '
            'identity, different callback or not.',
          ),
          matrix,
          SizedBox(height: 24.0),
          _sectionTitle('6. Mock iOS system menu'),
          SizedBox(height: 8.0),
          _intro(
            'A faithful mockup of the system context menu surfaced over '
            'a selection. Built-ins (Cut, Copy, Paste, Look Up, Share) '
            'are interleaved with six Custom rows highlighted in brass.',
          ),
          mockMenu,
          SizedBox(height: 24.0),
          _sectionTitle('7. Composition rules'),
          SizedBox(height: 8.0),
          _intro(
            'These four patterns cover the common shapes you see in '
            'production: reading apps, editors, read-only-with-social, '
            'and Set-based deduplication. Every shape mixes built-ins '
            'and Customs in some proportion.',
          ),
          patternsBlock,
          SizedBox(height: 24.0),
          _sectionTitle('8. Engraving station'),
          SizedBox(height: 8.0),
          _intro(
            'A brass blank on the engraving bench: title cut into the '
            'flag, onPressed mapped onto the cut pattern, ready to '
            'ship to the SystemContextMenuController.',
          ),
          engravingStation,
          SizedBox(height: 24.0),
          _sectionTitle('9. Code examples'),
          SizedBox(height: 8.0),
          _intro(
            'Five representative snippets: a minimal Custom, a mixed '
            'menu, Set-based deduplication, a programmatic per-screen '
            'menu builder, and pattern matching across the sealed '
            'hierarchy.',
          ),
          codeExamples,
          SizedBox(height: 24.0),
          _sectionTitle('10. Engraving rules'),
          SizedBox(height: 8.0),
          _intro(
            'Six workshop rules distilled from the sections above. '
            'Five are obligations to honor; one is an anti-pattern to '
            'avoid (relying on callback identity for equality).',
          ),
          rules,
          SizedBox(height: 24.0),
          closingStamp,
        ],
      ),
    ),
  );
}

// =============================================================
// Custom-item callbacks (non-empty closures)
// =============================================================

void _onTranslateSpanish() {
  print('callback: Translate to Spanish invoked');
  print('  -> selection forwarded to translation service');
  print('  -> target locale: es');
}

void _onTranslateSpanishAlt() {
  print('callback (alt): Translate to Spanish via offline dictionary');
  print('  -> using local CoreML model bundle');
}

void _onDefineWord() {
  print('callback: Define Word invoked');
  print('  -> dictionary lookup for selected token');
}

void _onSaveQuote() {
  print('callback: Save Quote invoked');
  print('  -> appending selection to quotesRepo');
}

void _onShareTwitter() {
  print('callback: Share to Twitter invoked');
  print('  -> opening compose sheet with quoted selection');
}

void _onCopyMarkdown() {
  print('callback: Copy as Markdown invoked');
  print('  -> selection rendered as Markdown and pushed to clipboard');
}

void _onSummarize() {
  print('callback: Summarize invoked');
  print('  -> sending selection to summarization service (max 80 chars)');
}

// =============================================================
// Helpers
// =============================================================

String _describeItems(List<IOSSystemContextMenuItemData> items) {
  final names = <String>[];
  for (int i = 0; i < items.length; i++) {
    final it = items[i];
    if (it is IOSSystemContextMenuItemDataCopy) {
      names.add('Copy');
    } else if (it is IOSSystemContextMenuItemDataCut) {
      names.add('Cut');
    } else if (it is IOSSystemContextMenuItemDataPaste) {
      names.add('Paste');
    } else if (it is IOSSystemContextMenuItemDataSelectAll) {
      names.add('SelectAll');
    } else if (it is IOSSystemContextMenuItemDataLookUp) {
      names.add('LookUp');
    } else if (it is IOSSystemContextMenuItemDataSearchWeb) {
      names.add('SearchWeb');
    } else if (it is IOSSystemContextMenuItemDataShare) {
      names.add('Share');
    } else if (it is IOSSystemContextMenuItemDataLiveText) {
      names.add('LiveText');
    } else if (it is IOSSystemContextMenuItemDataCustom) {
      names.add('Custom("${it.title}")');
    } else {
      names.add('Unknown');
    }
  }
  return names.join(', ');
}

Widget _sectionTitle(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(12.0, 6.0, 0.0, 6.0),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Color(0xFFB5894D), width: 4.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFFE6C078),
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
        color: Color(0xFFD4B888),
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
      color: color.withValues(alpha: 0.18),
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
              color: Color(0xFF8A6A4A),
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
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFFE6C078),
              fontSize: 12.0,
              fontFamily: 'monospace',
              fontWeight: isRoot ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(
  String fieldName,
  String fieldType,
  String description,
  String example,
  Color color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF2A1A0F).withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 3.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              fieldName,
              style: TextStyle(
                color: color,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                fieldType,
                style: TextStyle(
                  color: color,
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(
            color: Color(0xFFD4B888),
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'e.g. $example',
          style: TextStyle(
            color: Color(0xFFC9A876),
            fontSize: 10.5,
            fontFamily: 'monospace',
            fontStyle: FontStyle.italic,
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
                accent.withValues(alpha: 0.40),
                accent.withValues(alpha: 0.10),
              ]
            : [
                Color(0xFF3E2A1F),
                Color(0xFF2A1A0F),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: highlighted ? accent : Color(0xFF6B4A2A),
        width: highlighted ? 2.0 : 1.0,
      ),
      boxShadow: highlighted
          ? <BoxShadow>[
              BoxShadow(
                color: accent.withValues(alpha: 0.55),
                blurRadius: 16.0,
                offset: Offset(0.0, 0.0),
              ),
            ]
          : <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
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
                color: accent.withValues(alpha: 0.22),
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
                    color: Color(0xFF2A1A0F),
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
            color: Color(0xFFE6C078),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'title: $title',
          style: TextStyle(
            color: Color(0xFFC9A876),
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

Widget _engravedKey({
  required String title,
  required String cutPattern,
  required IconData symbol,
  required Color accent,
  required String notch,
}) {
  return Container(
    width: 230.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.30),
          Color(0xFF3E2A1F),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
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
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFE6C078),
                    accent,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(symbol, color: Color(0xFF2A1A0F), size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Color(0xFFFCEAC4),
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Color(0xFF1A0F08).withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(6.0),
            border: Border(
              left: BorderSide(color: accent, width: 2.0),
            ),
          ),
          child: Text(
            cutPattern,
            style: TextStyle(
              color: Color(0xFFD4B888),
              fontSize: 10.5,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: accent, width: 0.5),
              ),
              child: Text(
                notch,
                style: TextStyle(
                  color: accent,
                  fontSize: 9.0,
                  letterSpacing: 1.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Color(0xFFE6C078).withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'BRASS C36000',
                style: TextStyle(
                  color: Color(0xFFE6C078),
                  fontSize: 8.5,
                  letterSpacing: 1.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _eqBadge(bool eq) {
  final color = eq ? Color(0xFF4A7C5C) : Color(0xFFA85D2E);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
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

Map<String, Object> _menuRow(
  String label,
  IconData icon,
  bool focus,
  bool isCustom,
) {
  return <String, Object>{
    'label': label,
    'icon': icon,
    'focus': focus,
    'isCustom': isCustom,
  };
}

Widget _systemMenuMockup({
  required String title,
  required List<Map<String, Object>> rows,
  required List<IOSSystemContextMenuItemData> captionItems,
}) {
  int customCount = 0;
  for (int i = 0; i < captionItems.length; i++) {
    if (captionItems[i] is IOSSystemContextMenuItemDataCustom) {
      customCount++;
    }
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2A1A0F), Color(0xFF1A0F08)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF6B4A2A), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
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
                color: Color(0xFF4A7C5C),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              'iOS · system context menu',
              style: TextStyle(
                color: Color(0xFFC9A876),
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
            color: Color(0xFFE6C078),
            fontSize: 13.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF3E2A1F),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Color(0xFF6B4A2A), width: 1.0),
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
                  rows[i]['isCustom'] as bool,
                  isLast: i == rows.length - 1,
                ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'items list contains ${captionItems.length} entries '
          '(of which $customCount are Custom blanks)',
          style: TextStyle(
            color: Color(0xFFA88D6A),
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
  bool focus,
  bool isCustom, {
  required bool isLast,
}) {
  final color = focus
      ? Color(0xFFE6C078)
      : (isCustom ? Color(0xFFD4A574) : Color(0xFFFCEAC4));
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: focus
          ? Color(0xFFB5894D).withValues(alpha: 0.22)
          : Colors.transparent,
      border: Border(
        bottom: BorderSide(
          color: isLast ? Colors.transparent : Color(0xFF6B4A2A),
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
        if (isCustom)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Color(0xFFB5894D).withValues(alpha: 0.30),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: Color(0xFFB5894D),
                width: 0.5,
              ),
            ),
            child: Text(
              'CUSTOM',
              style: TextStyle(
                color: Color(0xFFE6C078),
                fontSize: 8.5,
                letterSpacing: 1.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (focus) SizedBox(width: 6.0),
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
          accent.withValues(alpha: 0.22),
          accent.withValues(alpha: 0.05),
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
            color: Color(0xFFFCEAC4),
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
            ? BorderSide(color: Color(0xFFE6C078), width: 3.0)
            : BorderSide.none,
        bottom: !top
            ? BorderSide(color: Color(0xFFE6C078), width: 3.0)
            : BorderSide.none,
        left: left
            ? BorderSide(color: Color(0xFFE6C078), width: 3.0)
            : BorderSide.none,
        right: !left
            ? BorderSide(color: Color(0xFFE6C078), width: 3.0)
            : BorderSide.none,
      ),
    ),
  );
}

Widget _ruleRow(String rule, String detail, bool on) {
  final color = on ? Color(0xFF4A7C5C) : Color(0xFFA85D2E);
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFF1A0F08).withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 3.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          on ? Icons.check_circle : Icons.cancel,
          color: color,
          size: 20.0,
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rule,
                style: TextStyle(
                  color: Color(0xFFE6C078),
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                detail,
                style: TextStyle(
                  color: Color(0xFFD4B888),
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

Widget _codeBlock(String code, Color accent) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF050302),
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
