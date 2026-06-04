// Reproduces A.3 — runtime mixin application is impossible.
//
// A script that mixes `ContainerRenderObjectMixin` into `RenderBox` needs a
// distinct native proxy for that exact mixin-set. Dart cannot apply a mixin at
// runtime, so without a pre-generated proxy the instantiation fails.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _ScriptContainerRenderBox extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>> {}

dynamic build(BuildContext context) {
  final render = _ScriptContainerRenderBox();
  return SizedBox(width: render.childCount.toDouble());
}
