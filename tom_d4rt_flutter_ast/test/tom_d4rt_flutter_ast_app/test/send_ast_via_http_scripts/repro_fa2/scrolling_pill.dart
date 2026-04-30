// Fa2 hypothesis reproducer — `ValueListenableBuilder<bool>` listening on
// `controller.position.isScrollingNotifier`. Mirrors the surviving 2 FE
// pattern of `widgets/scroll_deceleration_rate_test.dart` after the
// layout-cascade fix landed in this testlog. If this reproduces 2 FE in
// isolation, the trigger is the ValueListenableBuilder + position.isScrollingNotifier
// pairing, not the state-field controller propagation through StatelessWidget chains.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _Page(),
  );
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  final ScrollController _aCtl = ScrollController();
  final ScrollController _bCtl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Two scrolling-status pills — same pattern as
            // _ScrollingPill in scroll_deceleration_rate_test.
            Row(
              children: <Widget>[
                Expanded(child: _Pill(controller: _aCtl)),
                const SizedBox(width: 14),
                Expanded(child: _Pill(controller: _bCtl)),
              ],
            ),
            // Two ListViews bound to the controllers.
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      controller: _aCtl,
                      itemCount: 50,
                      itemBuilder: (BuildContext c, int i) => SizedBox(
                        height: 40,
                        child: Center(child: Text('a$i')),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ListView.builder(
                      controller: _bCtl,
                      itemCount: 50,
                      itemBuilder: (BuildContext c, int i) => SizedBox(
                        height: 40,
                        child: Center(child: Text('b$i')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final ScrollController controller;
  const _Pill({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.hasClients) {
      return const Text('idle');
    }
    return ValueListenableBuilder<bool>(
      valueListenable: controller.position.isScrollingNotifier,
      builder: (context, isScrolling, _) {
        return Text(isScrolling ? 'scrolling' : 'at rest');
      },
    );
  }
}
