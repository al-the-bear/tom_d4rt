// ignore_for_file: avoid_print
// D4rt test script: CupertinoMenuAnchor, CupertinoMenuItem,
// CupertinoMenuDivider and CupertinoMenuEntry (cupertino, Flutter 3.47).
//
// CupertinoMenuAnchor shows an iOS-style pull-down menu of CupertinoMenuEntry
// widgets: CupertinoMenuItem rows and CupertinoMenuDivider separators. The
// script builds an anchor whose button opens the menu through the
// MenuController the builder receives, and inspects the entries it holds.
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('=== CupertinoMenuAnchor ===');
  final entries = <Widget>[
    CupertinoMenuItem(
      leading: const Icon(CupertinoIcons.doc_on_doc),
      subtitle: const Text('to the clipboard'),
      onPressed: () {},
      child: const Text('Copy'),
    ),
    CupertinoMenuItem(
      leading: const Icon(CupertinoIcons.share),
      trailing: const Icon(CupertinoIcons.chevron_right),
      onPressed: () {},
      child: const Text('Share'),
    ),
    const CupertinoMenuDivider(),
    CupertinoMenuItem(
      leading: const Icon(CupertinoIcons.delete),
      isDestructiveAction: true,
      onPressed: () {},
      child: const Text('Delete'),
    ),
  ];
  for (final entry in entries) {
    final isEntry = entry is CupertinoMenuEntry;
    final isDivider = entry is CupertinoMenuDivider;
    print('${entry.runtimeType}: entry=$isEntry divider=$isDivider');
  }
  final entryCount = entries.whereType<CupertinoMenuEntry>().length;
  final dividerCount = entries.whereType<CupertinoMenuDivider>().length;
  print('menu entries: $entryCount, dividers: $dividerCount');
  final delete = entries.last as CupertinoMenuItem;
  print('delete isDestructiveAction: ${delete.isDestructiveAction}');
  print('divider default color: ${CupertinoMenuDivider.kDefaultColor}');

  final controller = MenuController();
  final anchor = CupertinoMenuAnchor(
    controller: controller,
    enableSwipe: true,
    overlayPadding: const EdgeInsets.all(12),
    menuChildren: entries,
    builder: (context, menuController, child) {
      return CupertinoButton(
        onPressed: () {
          if (menuController.isOpen) {
            menuController.close();
          } else {
            menuController.open();
          }
        },
        child: const Text('Actions'),
      );
    },
  );
  print('anchor menuChildren: ${anchor.menuChildren.length}');
  print('anchor enableSwipe: ${anchor.enableSwipe}');
  print('anchor consumeOutsideTaps: ${anchor.consumeOutsideTaps}');

  return CupertinoPageScaffold(
    navigationBar: const CupertinoNavigationBar(
      middle: Text('CupertinoMenuAnchor'),
    ),
    child: SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [anchor, Text('${entries.length} entries, one divider')],
        ),
      ),
    ),
  );
}
