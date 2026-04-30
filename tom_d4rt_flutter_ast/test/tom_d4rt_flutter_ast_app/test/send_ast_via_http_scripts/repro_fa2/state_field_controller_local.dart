// Fa2 reproducer baseline — locally-constructed ScrollController inside the
// leaf widget. Per `interpreter_unfixable.md` (E8) this variant produces
// FE=0; it controls for the propagation-through-StatelessWidget hypothesis.

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 420,
        child: const _LeafLocal(),
      ),
    );
  }
}

class _LeafLocal extends StatelessWidget {
  const _LeafLocal();

  @override
  Widget build(BuildContext context) {
    final ctl = ScrollController();
    return ListView.builder(
      controller: ctl,
      itemCount: 50,
      itemBuilder: (BuildContext c, int i) => SizedBox(
        height: 40,
        child: Center(child: Text('$i')),
      ),
    );
  }
}
