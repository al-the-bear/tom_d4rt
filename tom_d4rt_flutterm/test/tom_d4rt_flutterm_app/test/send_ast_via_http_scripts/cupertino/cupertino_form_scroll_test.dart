// D4rt test script: Tests CupertinoTextFormFieldRow, CupertinoListTileChevron,
// CupertinoScrollbar, CupertinoPopupSurface, CupertinoContextMenuAction
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino form/scroll test executing');

  // ========== CupertinoTextFormFieldRow ==========
  print('--- CupertinoTextFormFieldRow Tests ---');
  final textRow = CupertinoTextFormFieldRow(
    prefix: Text('Name'),
    placeholder: 'Enter your name',
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
    autocorrect: false,
    maxLines: 1,
  );
  print('CupertinoTextFormFieldRow created');

  // ========== CupertinoListTile ==========
  print('--- CupertinoListTile Tests ---');
  final listTile = CupertinoListTile(
    title: Text('List Item'),
    subtitle: Text('With chevron'),
    leading: Icon(CupertinoIcons.person),
    trailing: CupertinoListTileChevron(),
    onTap: () => print('Tile tapped'),
  );
  print('CupertinoListTile with chevron created');

  // ========== CupertinoListTileChevron ==========
  print('--- CupertinoListTileChevron Tests ---');
  final chevron = CupertinoListTileChevron();
  print('CupertinoListTileChevron created [${chevron.hashCode }]');

  // ========== CupertinoScrollbar ==========
  print('--- CupertinoScrollbar Tests ---');
  final scrollCtrl = ScrollController();
  final cupertinoScrollbar = CupertinoScrollbar(
    controller: scrollCtrl,
    thumbVisibility: true,
    thickness: 6.0,
    thicknessWhileDragging: 10.0,
    radius: Radius.circular(3.0),
    radiusWhileDragging: Radius.circular(5.0),
    child: ListView.builder(
      controller: scrollCtrl,
      itemCount: 30,
      itemBuilder: (ctx, i) => CupertinoListTile(title: Text('Item $i')),
    ),
  );
  print('CupertinoScrollbar created [${cupertinoScrollbar.hashCode }]');
  print('  thickness: 6.0');
  print('  thicknessWhileDragging: 10.0');

  // ========== CupertinoPopupSurface ==========
  print('--- CupertinoPopupSurface Tests ---');
  final popupSurface = CupertinoPopupSurface(
    isSurfacePainted: true,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Popup Surface Content'),
    ),
  );
  print('CupertinoPopupSurface created [${popupSurface.hashCode }]');

  // ========== CupertinoContextMenuAction ==========
  print('--- CupertinoContextMenuAction Tests ---');
  final ctxAction = CupertinoContextMenuAction(
    trailingIcon: CupertinoIcons.doc_on_clipboard,
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () => print('Context action pressed'),
    child: Text('Copy'),
  );
  print('CupertinoContextMenuAction created [${ctxAction.hashCode }]');
  print('  isDefaultAction: true');
  print('  isDestructiveAction: false');

  final destructiveAction = CupertinoContextMenuAction(
    trailingIcon: CupertinoIcons.delete,
    isDestructiveAction: true,
    onPressed: () {},
    child: Text('Delete'),
  );
  print('Destructive CupertinoContextMenuAction created [${destructiveAction.hashCode }]');

  print('All cupertino form/scroll tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Form/Scroll Test')),
      child: SafeArea(
        child: CupertinoListSection.insetGrouped(
          header: Text('Form Fields'),
          children: [
            textRow,
            listTile,
            CupertinoListTile(
              title: Text('Settings'),
              trailing: CupertinoListTileChevron(),
            ),
          ],
        ),
      ),
    ),
  );
}
