// Profile tab — a static profile card plus a `SwitchListTile` that
// flips the cross-tab dark-mode flag through the shared `ThemeScope`.
// Toggling here updates the `MaterialApp.themeMode` *and* the icon
// on the Home tab's AppBar — proof that the scope works.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'theme_scope.dart';

class TabProfile extends StatelessWidget {
  const TabProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeScope scope = ThemeScope.of(context);
    return Scaffold(
      appBar: AppBar(
        key: const Key('profile-appbar'),
        title: const Text('Profile'),
      ),
      body: ListView(
        key: const Key('profile-list'),
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const Center(
            child: CircleAvatar(
              key: Key('profile-avatar'),
              radius: 36.0,
              child: Icon(Icons.person, size: 36.0),
            ),
          ),
          const SizedBox(height: 12.0),
          const Center(
            child: Text(
              'Alex K.',
              key: Key('profile-name'),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 24.0),
          SwitchListTile(
            key: const Key('profile-dark-switch'),
            title: const Text('Dark mode'),
            value: scope.isDark,
            onChanged: (bool _) {
              scope.notifier.toggle();
              print(
                'theme.toggle source=Profile dark=${scope.notifier.isDark}',
              );
            },
          ),
        ],
      ),
    );
  }
}
