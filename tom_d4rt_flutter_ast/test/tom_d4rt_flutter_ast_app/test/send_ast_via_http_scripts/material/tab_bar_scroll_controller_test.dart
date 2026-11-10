// ignore_for_file: avoid_print, unnecessary_type_check
// D4rt test script: TabBarScrollController (material, Flutter 3.47).
//
// TabBarScrollController is the ScrollController a scrollable TabBar takes
// through `scrollController`. The script creates one, reads the members it
// inherits from ScrollController before it is attached, and hands it to a
// scrollable TabBar of twelve tabs.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TabBarScrollController ===');
  final controller = TabBarScrollController();
  print('is ScrollController: ${controller is ScrollController}');
  print('hasClients before attach: ${controller.hasClients}');
  print('initialScrollOffset: ${controller.initialScrollOffset}');
  print('keepScrollOffset: ${controller.keepScrollOffset}');

  final labels = [for (var i = 1; i <= 12; i++) 'Tab $i'];
  return DefaultTabController(
    length: labels.length,
    child: Column(
      children: [
        Material(
          color: Colors.indigo,
          child: TabBar(
            isScrollable: true,
            scrollController: controller,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [for (final label in labels) Tab(text: label)],
          ),
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            children: [
              for (final label in labels) Center(child: Text('$label body')),
            ],
          ),
        ),
      ],
    ),
  );
}
