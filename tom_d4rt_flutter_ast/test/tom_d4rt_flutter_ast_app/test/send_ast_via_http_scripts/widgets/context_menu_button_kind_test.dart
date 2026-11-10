// ignore_for_file: avoid_print
// D4rt test script: ContextMenuButtonKind (widgets, Flutter 3.47).
//
// ContextMenuButtonKind names the action of a context-menu button. It is a
// final class with a private constructor; the script reads its static
// constants, their `name`, `values`, and compares them by identity.
import 'package:flutter/material.dart';

Widget kindRow(ContextMenuButtonKind kind) {
  return ListTile(
    dense: true,
    leading: const Icon(Icons.touch_app),
    title: Text(kind.name),
    subtitle: Text(kind.toString()),
  );
}

dynamic build(BuildContext context) {
  print('=== ContextMenuButtonKind ===');
  final kinds = ContextMenuButtonKind.values;
  print('values: ${kinds.length}');
  for (final kind in kinds) {
    print('  ${kind.name}');
  }
  final cut = ContextMenuButtonKind.cut;
  final copy = ContextMenuButtonKind.copy;
  print('cut == cut: ${identical(cut, ContextMenuButtonKind.cut)}');
  print('cut == copy: ${cut == copy}');
  print(
    'values contains paste: ${kinds.contains(ContextMenuButtonKind.paste)}',
  );
  print('custom: ${ContextMenuButtonKind.custom.name}');

  final standard = <ContextMenuButtonKind>[
    ContextMenuButtonKind.cut,
    ContextMenuButtonKind.copy,
    ContextMenuButtonKind.paste,
    ContextMenuButtonKind.selectAll,
    ContextMenuButtonKind.delete,
    ContextMenuButtonKind.lookUp,
    ContextMenuButtonKind.searchWeb,
    ContextMenuButtonKind.share,
    ContextMenuButtonKind.liveTextInput,
    ContextMenuButtonKind.translate,
  ];

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'ContextMenuButtonKind',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('${kinds.length} kinds, ${standard.length} standard'),
        ),
        for (final kind in standard) kindRow(kind),
        kindRow(ContextMenuButtonKind.custom),
      ],
    ),
  );
}
