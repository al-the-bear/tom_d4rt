// Fa2 trigger isolation — ternary `hasClients ? position.maxScrollExtent : '—'`
// pattern. The bisect against scroll_deceleration_rate_test landed exactly
// on this expression: removing it dropped FE from 2 to 0.
//
// Hypothesis: the interpreter eagerly evaluates both branches of the
// conditional expression and `controller.position` is null at first build
// (before ListView.builder has attached its scroll position).

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
  final ScrollController _ctl = ScrollController();
  late final VoidCallback _listener;
  double _px = 0.0;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (!_ctl.hasClients) return;
      setState(() => _px = _ctl.position.pixels);
    };
    _ctl.addListener(_listener);
  }

  @override
  void dispose() {
    _ctl.removeListener(_listener);
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Telemetry row built from a state-field ScrollController. The
          // ternary inside _MaxRow guards `controller.position` with
          // `controller.hasClients`. Listener fires setState on every
          // scroll, rebuilding _MaxRow with hasClients=true.
          _MaxRow(controller: _ctl, px: _px),
          Expanded(
            child: ListView.builder(
              controller: _ctl,
              itemCount: 50,
              itemBuilder: (BuildContext c, int i) =>
                  SizedBox(height: 40, child: Center(child: Text('$i'))),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaxRow extends StatelessWidget {
  final ScrollController controller;
  final double px;
  const _MaxRow({required this.controller, required this.px});

  @override
  Widget build(BuildContext context) {
    return Text(
      'px=$px max='
      '${controller.hasClients ? controller.position.maxScrollExtent.toStringAsFixed(0) : '—'}',
    );
  }
}
