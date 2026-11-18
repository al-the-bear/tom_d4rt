/// Extended bridge tests (file 26): rendering classes no script exercised.
///
/// One script per class or small class group of the Essential and Important
/// rendering classes the testplans showed unexercised (addtests1). Each test
/// checks lines the script prints, every one taken from the same script run
/// natively on Flutter 3.47.9, so a script that runs but computes the wrong
/// value fails. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_26_test.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(suite: _kTestFileName);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Test App Health', () {
    test('app is running', () async {
      final isRunning = await SendTestRunner.isAppRunning();
      expect(
        isRunning,
        isTrue,
        reason: 'Test app should be running (managed by setUpAll).',
      );
    });
  });

  group('Rendering classes (addtests1)', () {
    // RenderFlex, FlexParentData
    test('rendering/render_flex_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_flex_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'direction: Axis.horizontal',
          'child count: 3',
          'flex data: 2 FlexFit.tight',
          'first child is a: true',
          'min dry size: 300.0 x 40.0',
          'min intrinsic width: 60.0',
          'vertical intrinsic height: 55.0',
        ]),
      );
    });
    // RenderStack, StackParentData, RenderPositionedBox
    test('rendering/render_stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_stack_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'positioned before: false',
          'positioned after: true',
          'stack children: 2',
          'stack dry size: 60.0 x 40.0',
          'positioned dry size: 20.0 x 30.0',
          'widthFactor: 2.0',
        ]),
      );
    });
    // RenderClipRect, RenderClipRRect, RenderClipOval, RenderClipPath
    test('rendering/render_clip_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_clip_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'rect: Clip.hardEdge Size(40.0, 30.0)',
          'rrect: Clip.antiAlias BorderRadius.circular(8.0)',
          'oval: Clip.antiAlias 40.0',
          'path: Clip.antiAlias 30.0',
          'rect after: Clip.none',
        ]),
      );
    });
    // RenderAspectRatio, RenderFittedBox, RenderIntrinsicWidth, RenderIntrinsicHeight, RenderLimitedBox, RenderOpacity, RenderTransform, RenderDecoratedBox
    test('rendering/render_proxy_boxes_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_boxes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'aspect: 2.0 Size(200.0, 100.0)',
          'fitted: BoxFit.contain Size(40.0, 20.0)',
          'intrinsic width: 50.0',
          'intrinsic height: 15.0',
          'limited: 50.0 0.0 x 0.0',
          'opacity: 0.5',
          'opacity after: 0.25',
          'transform identity: true',
          'decorated: DecorationPosition.background Size(12.0, 8.0)',
        ]),
      );
    });
    // RenderListBody, RenderWrap
    test('rendering/render_list_body_wrap_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_list_body_wrap_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'list axis: AxisDirection.down',
          'list children: 2',
          'list intrinsic height: 20.0',
          'wrap spacing: 4.0 6.0',
          'wrap dry size: 84.0 x 26.0',
        ]),
      );
    });
    // RenderParagraph, RenderImage, RenderTable
    test('rendering/render_paragraph_image_table_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_paragraph_image_table_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'paragraph text: hello world',
          'paragraph has width: true',
          'paragraph maxLines: 1',
          'image size: 64.0 x 32.0 BoxFit.cover',
          'image has image: false',
          'image dry size: 64.0 x 32.0',
          'table: 2 rows, 2 columns',
          'table min width: 60.0',
        ]),
      );
    });
    // RenderSliver, RenderSliverGrid, RenderSliverList, RenderSliverOpacity, RenderSliverPadding, SliverGridDelegate, SliverGridParentData, RenderViewport
    test('rendering/render_slivers_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_slivers_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'sliver padding: EdgeInsets.all(4.0)',
          'sliver opacity: 0.5',
          'opacity child is padding: true',
          'grid layout min child for 150: 3',
          'grid parent data cross offset: 100.0',
          'viewport axis: AxisDirection.down',
          'viewport has center: true',
          'viewport children: 1',
          'sliver render types: 2',
        ]),
      );
    });
    // RenderView, ViewConfiguration, Layer, RenderFlow
    test('rendering/render_view_layer_flow_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_view_layer_flow_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'dpr: 2.0',
          'logical max: 400.0',
          'render view config dpr: 2.0',
          'layer is offset layer: true',
          'layer attached: false',
          'flow children: 0',
          'flow clip: Clip.hardEdge',
        ]),
      );
    });
  });
}
