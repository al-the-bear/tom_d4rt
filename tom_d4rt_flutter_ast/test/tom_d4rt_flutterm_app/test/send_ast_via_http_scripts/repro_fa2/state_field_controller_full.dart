// Fa2 reproducer (full envelope) — tries to mirror everything in
// scroll_deceleration_rate_test that might trigger the 2 residual FE:
// TickerProviderStateMixin + AnimationController + listeners with setState +
// BouncingScrollPhysics(decelerationRate) + ScrollConfiguration custom
// behavior + the SliverToBoxAdapter / Pair / Lane chain.

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

class _PageState extends State<_Page> with TickerProviderStateMixin {
  final ScrollController _aCtl = ScrollController();
  final ScrollController _bCtl = ScrollController();

  late final VoidCallback _aListener;
  late final VoidCallback _bListener;
  late final AnimationController _ticker;

  double _aPx = 0.0;
  double _bPx = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    )..repeat();
    _aListener = () {
      if (!_aCtl.hasClients) return;
      setState(() => _aPx = _aCtl.position.pixels);
    };
    _bListener = () {
      if (!_bCtl.hasClients) return;
      setState(() => _bPx = _bCtl.position.pixels);
    };
    _aCtl.addListener(_aListener);
    _bCtl.addListener(_bListener);
  }

  @override
  void dispose() {
    _aCtl.removeListener(_aListener);
    _bCtl.removeListener(_bListener);
    _aCtl.dispose();
    _bCtl.dispose();
    _ticker.dispose();
    super.dispose();
  }

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
            SliverToBoxAdapter(
              child: SizedBox(height: 60, child: Text('a=$_aPx b=$_bPx')),
            ),
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
          Expanded(
            child: _Lane(
              controller: aController,
              decel: ScrollDecelerationRate.normal,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _Lane(
              controller: bController,
              decel: ScrollDecelerationRate.fast,
            ),
          ),
        ],
      ),
    );
  }
}

class _Lane extends StatelessWidget {
  final ScrollController controller;
  final ScrollDecelerationRate decel;
  const _Lane({required this.controller, required this.decel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 40, child: Text('header')),
        Expanded(
          child: ListView.builder(
            controller: controller,
            physics: BouncingScrollPhysics(decelerationRate: decel),
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
