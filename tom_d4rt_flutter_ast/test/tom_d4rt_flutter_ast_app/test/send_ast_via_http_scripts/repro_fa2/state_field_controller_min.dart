// Fa2 minimal reproducer — state-field ScrollController passed through a
// StatelessWidget chain to a leaf Scrollable.
//
// Per `interpreter_unfixable.md` (E8): the script-side bisect found that the
// error scales linearly with the number of leaf Scrollables receiving a
// state-field controller propagated through a StatelessWidget chain. This
// reproducer minimises the shape: 1 State, 1 StatelessWidget pass-through,
// 1 ListView. Expected FE before fix: 1.

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 420,
        child: _Pass(controller: _ctl),
      ),
    );
  }
}

class _Pass extends StatelessWidget {
  final ScrollController controller;
  const _Pass({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: 50,
      itemBuilder: (BuildContext c, int i) => SizedBox(
        height: 40,
        child: Center(child: Text('$i')),
      ),
    );
  }
}
