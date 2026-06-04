// Reproduces C.2 — proxies are emitted with `<dynamic>` type args.
//
// The generator emits proxies whose type arguments are `<dynamic>`, which fail
// concrete type checks for the long tail of widget bases beyond
// StatelessWidget/StatefulWidget. A script subclass of `LeafRenderObjectWidget`
// exercises one such base.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _FixedBox extends LeafRenderObjectWidget {
  const _FixedBox();
  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderConstrainedBox(
        additionalConstraints: const BoxConstraints.tightFor(
          width: 10,
          height: 10,
        ),
      );
}

dynamic build(BuildContext context) {
  return const Center(child: _FixedBox());
}
