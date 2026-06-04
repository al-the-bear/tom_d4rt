// Tab-shell home for the tabbed_dashboard sample.
//
// Owns the TabController so we can listen for tab-switch events and
// emit a deterministic trail line per switch. The three tab pages
// each opt into `AutomaticKeepAliveClientMixin` so their internal
// state (chart data, settings, log stream) survives swiping between
// tabs.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'tab_chart.dart';
import 'tab_log.dart';
import 'tab_settings.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome>
    with SingleTickerProviderStateMixin {
  static const List<String> _labels = <String>['Chart', 'Settings', 'Log'];

  late final TabController _controller;
  int _last = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _labels.length, vsync: this);
    _controller.addListener(_onTab);
    print('tab.init labels=[Chart,Settings,Log]');
  }

  @override
  void dispose() {
    _controller.removeListener(_onTab);
    _controller.dispose();
    super.dispose();
  }

  void _onTab() {
    // Only fire on settle (`indexIsChanging == false`) so we get a
    // single trail line per switch instead of one per animation
    // frame.
    if (_controller.indexIsChanging) return;
    final int now = _controller.index;
    if (now != _last) {
      print('tab.switch from=$_last to=$now');
      _last = now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('tabbed-appbar'),
        title: const Text('Tabbed dashboard'),
        bottom: TabBar(
          key: const Key('tabbed-tabbar'),
          controller: _controller,
          tabs: const <Widget>[
            Tab(key: Key('tabbed-tab-chart'), text: 'Chart'),
            Tab(key: Key('tabbed-tab-settings'), text: 'Settings'),
            Tab(key: Key('tabbed-tab-log'), text: 'Log'),
          ],
        ),
      ),
      body: TabBarView(
        key: const Key('tabbed-tabview'),
        controller: _controller,
        children: const <Widget>[
          ChartTab(key: Key('tabbed-page-chart')),
          SettingsTab(key: Key('tabbed-page-settings')),
          LogTab(key: Key('tabbed-page-log')),
        ],
      ),
    );
  }
}
