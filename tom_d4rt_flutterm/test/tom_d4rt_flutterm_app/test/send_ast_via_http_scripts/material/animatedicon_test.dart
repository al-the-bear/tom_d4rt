// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AnimatedIcon from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedIcon test executing');

  // Variation 1: menu_arrow at progress 0.0
  final widget1 = AnimatedIcon(
    icon: AnimatedIcons.menu_arrow,
    progress: AlwaysStoppedAnimation(0.0),
  );
  print('AnimatedIcon(menu_arrow, progress: 0.0) created');

  // Variation 2: menu_arrow at progress 0.5
  final widget2 = AnimatedIcon(
    icon: AnimatedIcons.menu_arrow,
    progress: AlwaysStoppedAnimation(0.5),
  );
  print('AnimatedIcon(menu_arrow, progress: 0.5) created');

  // Variation 3: menu_arrow at progress 1.0
  final widget3 = AnimatedIcon(
    icon: AnimatedIcons.menu_arrow,
    progress: AlwaysStoppedAnimation(1.0),
  );
  print('AnimatedIcon(menu_arrow, progress: 1.0) created');

  // Variation 4: play_pause with size and color
  final widget4 = AnimatedIcon(
    icon: AnimatedIcons.play_pause,
    progress: AlwaysStoppedAnimation(0.5),
    size: 48.0,
    color: Colors.blue,
  );
  print(
    'AnimatedIcon(play_pause, progress: 0.5, size: 48, color: blue) created',
  );

  // Variation 5: menu_close at progress 0.0
  final widget5 = AnimatedIcon(
    icon: AnimatedIcons.menu_close,
    progress: AlwaysStoppedAnimation(0.0),
  );
  print('AnimatedIcon(menu_close, progress: 0.0) created');

  // Variation 6: home_menu at progress 1.0
  final widget6 = AnimatedIcon(
    icon: AnimatedIcons.home_menu,
    progress: AlwaysStoppedAnimation(1.0),
  );
  print('AnimatedIcon(home_menu, progress: 1.0) created');

  print('AnimatedIcon test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('menu_arrow 0.0: '), widget1],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('menu_arrow 0.5: '), widget2],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('menu_arrow 1.0: '), widget3],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('play_pause 0.5: '), widget4],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('menu_close 0.0: '), widget5],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('home_menu 1.0: '), widget6],
      ),
    ],
  );
}
