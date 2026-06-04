// Home tab — a list whose taps push a `/detail` route inside the
// tab's own `Navigator`. Holds a theme toggle button in the AppBar
// to demonstrate that flipping the theme from one tab propagates to
// every other tab via the shared `ThemeScope`.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'theme_scope.dart';

class TabHome extends StatelessWidget {
  const TabHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeScope scope = ThemeScope.of(context);
    return Scaffold(
      appBar: AppBar(
        key: const Key('home-appbar'),
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('home-theme-toggle'),
            tooltip: 'Toggle theme',
            icon: Icon(
              scope.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              scope.notifier.toggle();
              print('theme.toggle source=Home dark=${scope.notifier.isDark}');
            },
          ),
        ],
      ),
      body: ListView(
        key: const Key('home-list'),
        children: <Widget>[
          for (int i = 1; i <= 5; i = i + 1)
            ListTile(
              key: Key('home-item-$i'),
              leading: const Icon(Icons.label_outline),
              title: Text('Item $i'),
              onTap: () {
                print('home.tap item=$i');
                Navigator.of(context).pushNamed(
                  '/detail',
                  arguments: 'Item $i',
                );
              },
            ),
        ],
      ),
    );
  }
}
