// D4rt test script: Tests showMenu from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('showMenu test executing');

  // Schedule showMenu via Future.microtask with a fixed position
  Future.microtask(() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100.0, 100.0, 200.0, 200.0),
      items: [
        PopupMenuItem<String>(
          value: 'option_a',
          child: Row(
            children: [
              Icon(Icons.edit, size: 20.0),
              SizedBox(width: 8.0),
              Text('Option A'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'option_b',
          child: Row(
            children: [
              Icon(Icons.delete, size: 20.0),
              SizedBox(width: 8.0),
              Text('Option B'),
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'option_c',
          enabled: false,
          child: Text('Disabled Option C'),
        ),
      ],
      elevation: 8.0,
    ).then((result) {
      print('showMenu result: $result');
    });
    print('showMenu called');
  });

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('showMenu scheduled'),
        SizedBox(height: 8.0),
        Text('Menu should appear at position (100, 100)'),
        SizedBox(height: 16.0),
        // PopupMenuButton for comparison — uses showMenu internally
        PopupMenuButton<String>(
          onSelected: (value) {
            print('PopupMenuButton selected: $value');
          },
          itemBuilder: (ctx) => [
            PopupMenuItem<String>(value: 'cut', child: Text('Cut')),
            PopupMenuItem<String>(value: 'copy', child: Text('Copy')),
            PopupMenuItem<String>(value: 'paste', child: Text('Paste')),
            PopupMenuDivider(),
            PopupMenuItem<String>(value: 'select_all', child: Text('Select All')),
          ],
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.more_vert),
                SizedBox(width: 4.0),
                Text('Show PopupMenu'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        // Manually positioned menu via button
        ElevatedButton(
          onPressed: () {
            // Get button position for the menu
            final renderBox = context.findRenderObject() as RenderBox;
            final offset = renderBox.localToGlobal(Offset.zero);
            final size = renderBox.size;
            showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(
                offset.dx,
                offset.dy + size.height,
                offset.dx + size.width,
                0.0,
              ),
              items: [
                PopupMenuItem<String>(value: '1', child: Text('Menu Item 1')),
                PopupMenuItem<String>(value: '2', child: Text('Menu Item 2')),
                PopupMenuItem<String>(value: '3', child: Text('Menu Item 3')),
              ],
            ).then((value) {
              print('Button menu selected: $value');
            });
            print('showMenu from button position called');
          },
          child: Text('Show Menu At Position'),
        ),
      ],
    ),
  );
}
