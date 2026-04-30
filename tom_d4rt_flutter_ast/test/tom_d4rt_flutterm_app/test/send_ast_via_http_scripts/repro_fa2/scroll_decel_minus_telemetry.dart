// Fa2 prune attempt — copy of scroll_deceleration_rate_test, stripped to
// the dyno track only (no telemetry, no coast curves, no fling controls).
// Aim: see if the 2 FE persist when the helper widgets that consume the
// state-field controllers are removed.

import 'package:flutter/material.dart';

const Color _kTrackBlack = Color(0xFF101319);
const Color _kCardBg = Color(0xFF181C26);
const Color _kCardStroke = Color(0xFF2A3044);
const Color _kNormalNeon = Color(0xFF2EE6D6);
const Color _kFastMagenta = Color(0xFFFF4D8D);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Decel pruned',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kTrackBlack,
    ),
    home: const _DynoHomePage(),
  );
}

class _DynoHomePage extends StatefulWidget {
  const _DynoHomePage();

  @override
  State<_DynoHomePage> createState() => _DynoHomePageState();
}

class _DynoHomePageState extends State<_DynoHomePage>
    with TickerProviderStateMixin {
  final ScrollController _normalCtl = ScrollController();
  final ScrollController _fastCtl = ScrollController();
  late final AnimationController _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _normalCtl.dispose();
    _fastCtl.dispose();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kTrackBlack,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: _DynoTrackPair(
                normalController: _normalCtl,
                fastController: _fastCtl,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }
}

class _DynoTrackPair extends StatelessWidget {
  final ScrollController normalController;
  final ScrollController fastController;

  const _DynoTrackPair({
    required this.normalController,
    required this.fastController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: SizedBox(
        height: 420,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _DynoLane(
                color: _kNormalNeon,
                controller: normalController,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _DynoLane(
                color: _kFastMagenta,
                controller: fastController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DynoLane extends StatelessWidget {
  final Color color;
  final ScrollController controller;

  const _DynoLane({required this.color, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kCardStroke),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 54,
            color: color.withValues(alpha: 0.22),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'lane',
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              itemCount: 50,
              itemBuilder: (BuildContext c, int i) => Container(
                height: 36,
                margin: const EdgeInsets.symmetric(vertical: 3),
                color: color.withValues(alpha: 0.18),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '#$i',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
