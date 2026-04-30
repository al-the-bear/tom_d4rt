// Fa6 reproducer — three-bridged-mixin shape:
//   class _MyRO extends RenderBox with
//       ContainerRenderObjectMixin<RenderBox, _PD>,
//       RenderBoxContainerDefaultsMixin<RenderBox, _PD>,
//       RelayoutWhenSystemFontsChangeMixin
//
// This is the Option-2 motivator: the existing hand-written
// `_InterpretedRenderBoxContainer` (d4rt_runtime_registrations.dart) mixes in
// only Container + Defaults — adding RelayoutWhenSystemFontsChangeMixin would
// require a new hand-written proxy variant for every additional mixin combo.
//
// The reproducer touches both Container/Defaults paths (hosting children +
// defaultPaint) AND the relayout-mixin path (calling
// `systemFontsDidChange()` directly on the script-side render object). Under
// Option 1 dispatch the proxy class lacks the relayout mixin, so the call
// site either NoSuchMethods or routes through the dynamic interceptor —
// the test fails-loud if the call doesn't take effect.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _PD3 extends ContainerBoxParentData<RenderBox> {}

class _Triple extends MultiChildRenderObjectWidget {
  const _Triple({super.key, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderTriple();
  }
}

class _RenderTriple extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _PD3>,
        RenderBoxContainerDefaultsMixin<RenderBox, _PD3>,
        RelayoutWhenSystemFontsChangeMixin {
  int signalCount = 0;

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _PD3) {
      child.parentData = _PD3();
    }
  }

  @override
  void systemFontsDidChange() {
    signalCount += 1;
    print('[fa6-3mix] systemFontsDidChange tick=$signalCount');
    super.systemFontsDidChange();
  }

  @override
  void performLayout() {
    var width = 0.0;
    var height = 0.0;
    var child = firstChild;
    while (child != null) {
      child.layout(constraints, parentUsesSize: true);
      final pd = child.parentData! as _PD3;
      pd.offset = Offset(0, height);
      width = width < child.size.width ? child.size.width : width;
      height += child.size.height;
      child = pd.nextSibling;
    }
    size = constraints.constrain(Size(width, height));
    print('[fa6-3mix] performLayout childCount=$childCount size=$size');
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

class _SignalDriver extends StatefulWidget {
  const _SignalDriver({required this.targetKey});
  final GlobalKey targetKey;

  @override
  State<_SignalDriver> createState() => _SignalDriverState();
}

class _SignalDriverState extends State<_SignalDriver> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ro = widget.targetKey.currentContext?.findRenderObject();
      print('[fa6-3mix] driver ro=${ro?.runtimeType}');
      if (ro is RelayoutWhenSystemFontsChangeMixin) {
        print('[fa6-3mix] ro is RelayoutWhenSystemFontsChangeMixin: true');
        ro.systemFontsDidChange();
      } else {
        // Fail loud: if Option-1 hardcoded proxy lacks the relayout mixin,
        // the cast above is false and the test reveals the gap.
        throw StateError(
          'fa6-3mix: render object proxy is NOT '
          'RelayoutWhenSystemFontsChangeMixin — got ${ro.runtimeType}',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

dynamic build(BuildContext context) {
  final hostKey = GlobalKey();
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: _Triple(
              key: hostKey,
              children: const <Widget>[
                SizedBox(width: 80, height: 24, child: ColoredBox(color: Colors.indigo)),
                SizedBox(width: 60, height: 24, child: ColoredBox(color: Colors.teal)),
              ],
            ),
          ),
          _SignalDriver(targetKey: hostKey),
        ],
      ),
    ),
  );
}
