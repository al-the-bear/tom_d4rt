// Fa2 reproducer (closest) — state-field ScrollControllers passed through
// CustomScrollView > SliverToBoxAdapter > Pair(StatelessWidget) >
// Lane(StatelessWidget) > ListView.builder. Mirrors the precise envelope
// of `widgets/scroll_deceleration_rate_test.dart` after layout-cascade fix.

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
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
            SliverToBoxAdapter(
              child: _Pair(aController: _aCtl, bController: _bCtl),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }
}

class _Pair extends StatelessWidget {
  final ScrollController aController;
  final ScrollController bController;
  const _Pair({required this.aController, required this.bController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Row(
        children: <Widget>[
          Expanded(child: _Lane(controller: aController)),
          const SizedBox(width: 14),
          Expanded(child: _Lane(controller: bController)),
        ],
      ),
    );
  }
}

class _Lane extends StatelessWidget {
  final ScrollController controller;
  const _Lane({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 40, child: Text('header')),
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemCount: 50,
            itemBuilder: (BuildContext c, int i) => SizedBox(
              height: 40,
              child: Center(child: Text('$i')),
            ),
          ),
        ),
      ],
    );
  }
}
