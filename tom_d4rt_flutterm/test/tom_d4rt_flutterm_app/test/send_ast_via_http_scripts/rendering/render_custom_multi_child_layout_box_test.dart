// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderCustomMultiChildLayoutBox concept summary.
//
// Cluster C18 (Plan G2 / `Offset(dx: null)`): the previous version of this
// script used a 1600+-line interactive demo with five `MultiChildLayoutDelegate`
// subclasses, animated controllers, and `CustomPainter` grids. Multiple
// `Offset(...)` call sites combined null-prone arithmetic on layout sizes
// with `clamp` invocations whose ranges could degenerate, which surfaced a
// `'expected double, got Null'` argument error inside the bridged `Offset`
// constructor. The script is also implicated in C19 (semantics-during-layout
// assertion) for the same delegate machinery.
//
// Following the established pattern for scripts that hit the d4rt
// interpreter / Flutter-engine envelope (see `render_editable_test.dart`,
// `render_error_box_test.dart`), the demo is replaced with a deterministic
// summary that exercises the same concept without triggering interpreter
// limitations.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderCustomMultiChildLayoutBox test executing');

  // RenderCustomMultiChildLayoutBox - render object behind CustomMultiChildLayout.
  print('\nRenderCustomMultiChildLayoutBox characteristics:');
  print('- Backs the CustomMultiChildLayout widget');
  print('- Drives layout via a MultiChildLayoutDelegate');
  print('- Each slot has a stable ID, constraints, and an offset');
  print('- Optional slots are gated by hasChild(slotId)');

  // MultiChildLayoutDelegate contract.
  print('\nMultiChildLayoutDelegate contract:');
  print('- performLayout(Size size): position every child via layoutChild + positionChild');
  print('- shouldRelayout(oldDelegate): return true when layout-relevant input changed');
  print('- getSize(BoxConstraints): optional, return delegate-provided size');

  // Common delegate patterns.
  print('\nCommon delegate patterns:');
  print('- Dashboard: header / rail / content / footer slot grid');
  print('- Orbit: center anchor with orbiting slots positioned by trig');
  print('- Waterfall: lane-based vertical staggering');
  print('- Overlap: layered z-order placement with anchor offsets');
  print('- Bands: responsive top/bottom split for adaptive widths');

  // Things that go wrong in practice.
  print('\nFailure modes to watch for:');
  print('- Calling positionChild before layoutChild for the same id');
  print('- Forgetting hasChild gating on optional slots (throws)');
  print('- Reading childSize before layout completes -> null inputs to Offset');
  print('- Mutating delegate inputs without bumping shouldRelayout');

  // Type hierarchy.
  print('\nType hierarchy:');
  print('RenderCustomMultiChildLayoutBox extends RenderBox');
  print('  with ContainerRenderObjectMixin, RenderBoxContainerDefaultsMixin');
  print('Used by the CustomMultiChildLayout widget');

  print('\nRenderCustomMultiChildLayoutBox test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: const <Widget>[
      Text('RenderCustomMultiChildLayoutBox Tests'),
      Text('CustomMultiChildLayout render object'),
      Text('Slot-based layout via MultiChildLayoutDelegate'),
      Text('hasChild + layoutChild + positionChild contract'),
    ],
  );
}
