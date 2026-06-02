// MaterialApp wrapper for the tabbed_dashboard sample.
//
// Kept as a tiny widget so `main.dart` stays as a one-liner and
// the actual surface lives in `home.dart`.
import 'package:flutter/material.dart';

import 'home.dart';

class TabbedDashboardApp extends StatelessWidget {
  const TabbedDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tabbed dashboard',
      home: DashboardHome(),
    );
  }
}
