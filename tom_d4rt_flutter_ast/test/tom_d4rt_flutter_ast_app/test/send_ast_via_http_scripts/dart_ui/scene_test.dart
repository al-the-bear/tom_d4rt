// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element, deprecated_member_use, unnecessary_import

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// =============================================================================
// scene_test.dart — A deep demonstration of dart:ui's Scene & SceneBuilder.
//
// PURPOSE
// -------
// This file is a single, hand-authored visual essay that explains the
// engine-level rendering primitives that sit BELOW Flutter's widget tree.
// The widget tree (Widget → Element → RenderObject) is the framework view
// of the world. SceneBuilder, Scene, Picture, and Layer are the engine view.
// FlutterView.render(Scene) is the boundary between the two.
//
// We CANNOT actually rasterize a Scene from inside this test environment —
// there is no FlutterView available, and even constructing a SceneBuilder
// may be unstable inside the bridged interpreter. So this file VISUALIZES
// the concept using ordinary widgets: gradient header bars, decorated
// boxes laid out as layer trees, numbered timelines depicting the
// push/pop sequence, and side-by-side cards comparing the framework's
// CustomPainter mental model against the engine's SceneBuilder model.
//
// HARD CONSTRAINTS (bridge / interpreter)
// ---------------------------------------
//  * Exactly one top-level `dynamic build(BuildContext context)` function.
//  * NO top-level classes, mixins, extensions, or StatefulWidget.
//  * Only top-level functions and const data.
//  * NO setState, controllers, streams, Timer, Future.
//  * NO `for-in` over BridgedInstance — we use List.generate or literals.
//  * Any actual SceneBuilder call is wrapped in try/catch; rendering is
//    never attempted because there is no FlutterView to render into.
//
// HOW TO READ THIS FILE
// ---------------------
// The file is organised as follows:
//
//   1. Top-level palette / spacing constants.
//   2. Atomic helper functions (gradient header, prose paragraph, badge,
//      tag chip, arrow glyph, code-style mono text, etc.).
//   3. Section builder functions, one per pedagogical section.
//   4. The single `build` entry point that assembles every section into
//      one scrolling MaterialApp body.
//
// =============================================================================

// -----------------------------------------------------------------------------
// PALETTE
// -----------------------------------------------------------------------------
// The palette is intentionally cool / engine-y. Deep navy backgrounds with
// luminous accent colours suggest "below the surface" — under the widget
// tree, where Pictures and Layers compose into Scenes that the GPU then
// rasterizes via Skia/Impeller.
// -----------------------------------------------------------------------------

const Color kBgDeep = Color(0xFF0E1A2E);
const Color kBgMid = Color(0xFF152A47);
const Color kBgPanel = Color(0xFF1E3559);
const Color kBgPanelSoft = Color(0xFF24416A);
const Color kInkPrimary = Color(0xFFEAF2FF);
const Color kInkMuted = Color(0xFFB7C5DC);
const Color kInkFaint = Color(0xFF8090A8);

const Color kAccentCyan = Color(0xFF38E1FF);
const Color kAccentTeal = Color(0xFF22C7B0);
const Color kAccentLime = Color(0xFFA9E34B);
const Color kAccentAmber = Color(0xFFFFC857);
const Color kAccentRose = Color(0xFFF06A9B);
const Color kAccentViolet = Color(0xFFB48BFF);
const Color kAccentSky = Color(0xFF6FB3FF);
const Color kAccentCoral = Color(0xFFFF8A65);

const Color kLayerWidget = Color(0xFF6FB3FF);
const Color kLayerElement = Color(0xFFA9E34B);
const Color kLayerRender = Color(0xFFFFC857);
const Color kLayerEngine = Color(0xFFF06A9B);
const Color kLayerScene = Color(0xFFB48BFF);
const Color kLayerView = Color(0xFF38E1FF);

const Color kWarn = Color(0xFFFF6E6E);
const Color kOk = Color(0xFF6BE38C);

// -----------------------------------------------------------------------------
// SPACING / GEOMETRY CONSTANTS
// -----------------------------------------------------------------------------
const double kSectionGap = 28.0;
const double kCardRadius = 18.0;
const double kInnerRadius = 12.0;
const double kBoxRadius = 10.0;
const double kPipelineHeight = 96.0;
const double kTimelineHeight = 88.0;
const double kTreeNodeHeight = 64.0;

// =============================================================================
// ATOMIC HELPERS
// =============================================================================

// A gradient header shown at the top of every section. It is a wide bar with
// a luminous left-edge accent stripe, the section number badge, the title,
// and a subtitle. The gradient direction differs per section so that each
// header is visually distinct without changing the structural rhythm.
Widget gradientHeader({
  required String number,
  required String title,
  required String subtitle,
  required List<Color> gradient,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kCardRadius),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withOpacity(0.35),
          blurRadius: 22,
          spreadRadius: 1,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.45),
          blurRadius: 32,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withOpacity(0.65), width: 1.5),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: accent,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: kInkPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: kInkPrimary.withOpacity(0.85),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// A standard panel container with a soft inner gradient and a coloured
// accent border. Used as the body of every section beneath its header.
Widget panel({required Widget child, Color accent = kAccentCyan, EdgeInsets? padding}) {
  return Container(
    margin: const EdgeInsets.only(top: 14),
    padding: padding ?? const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kCardRadius),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kBgPanel, kBgMid],
      ),
      border: Border.all(color: accent.withOpacity(0.28), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.45),
          blurRadius: 22,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: child,
  );
}

// A prose paragraph renderer used inside panels. We deliberately set a
// generous height multiplier so multi-sentence explanations breathe.
Widget prose(String text, {Color color = kInkMuted, double size = 14.0}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: 1.55,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
    ),
  );
}

// A small uppercase label.
Widget label(String text, {Color color = kAccentCyan}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 11,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.4,
    ),
  );
}

// A monospace-looking chip that imitates inline code. We use a subtle
// background and rounded corners so it reads as `inline.code`.
Widget code(String text, {Color color = kAccentLime}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.32),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withOpacity(0.45), width: 0.8),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// A pill badge — useful for status flags (Constructed ✓ / Skipped ✕ etc).
Widget pillBadge(String text, {required Color color, IconData? icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.65), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
        ],
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ],
    ),
  );
}

// A small arrow glyph used to connect pipeline boxes. We draw it as a
// styled Text rather than using an Icon so it harmonises with type.
Widget arrow({Color color = kInkFaint, double size = 18}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Text(
      '▶',
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

// A vertical tick used inside the timeline diagram.
Widget tick({Color color = kInkFaint, double height = 18}) {
  return Container(
    width: 2,
    height: height,
    color: color.withOpacity(0.7),
  );
}

// A row of subtle dotted connectors used inside layer trees.
Widget dottedConnector({Color color = kInkFaint, double width = 22}) {
  return Container(
    width: width,
    height: 2,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withOpacity(0.0), color.withOpacity(0.7), color.withOpacity(0.0)],
      ),
    ),
  );
}

// A pipeline box: a coloured rectangle used in the anatomy diagram. Each
// box represents a stage in the pipeline (Widget, Element, RenderObject,
// Layer, SceneBuilder, Scene, FlutterView).
Widget pipelineBox({
  required String stage,
  required String detail,
  required Color color,
}) {
  return Container(
    width: 132,
    height: kPipelineHeight,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kBoxRadius),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color.withOpacity(0.90), color.withOpacity(0.55)],
      ),
      border: Border.all(color: color, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.45),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          stage,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.3,
          ),
        ),
        Text(
          detail,
          style: TextStyle(
            color: Colors.black.withOpacity(0.78),
            fontSize: 10.5,
            height: 1.25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// A node in the layer tree visualization. It carries a kind label
// ("Transform", "Opacity", "ClipRect", "Picture") and a short hint.
Widget treeNode({
  required String kind,
  required String hint,
  required Color color,
  double width = 168,
}) {
  return Container(
    width: width,
    height: kTreeNodeHeight,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kBoxRadius),
      color: kBgPanelSoft,
      border: Border.all(color: color.withOpacity(0.85), width: 1.3),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.30),
          blurRadius: 14,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              kind,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        Text(
          hint,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
          maxLines: 2,
        ),
      ],
    ),
  );
}

// A timeline step block — used in the push/pop sequence diagram.
Widget timelineStep({
  required String op,
  required String detail,
  required Color color,
  required int index,
}) {
  return Container(
    width: 116,
    height: kTimelineHeight,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kBoxRadius),
      color: color.withOpacity(0.18),
      border: Border.all(color: color.withOpacity(0.75), width: 1.1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withOpacity(0.85),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                op,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Text(
          detail,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            height: 1.25,
          ),
          maxLines: 2,
        ),
      ],
    ),
  );
}

// A vertical key/value row used in tables.
Widget kvRow({
  required String key,
  required String value,
  Color keyColor = kAccentCyan,
  Color valueColor = kInkMuted,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170,
          child: Text(
            key,
            style: TextStyle(
              color: keyColor,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// A divider line that fades from transparent to a colour and back.
Widget fadeDivider({Color color = kInkFaint, double padding = 8}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: padding),
    child: Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.0),
            color.withOpacity(0.45),
            color.withOpacity(0.0),
          ],
        ),
      ),
    ),
  );
}

// A two-column stat pair used inside cards.
Widget statPair({required String big, required String small, Color color = kAccentCyan}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        big,
        style: TextStyle(
          color: color,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        small,
        style: const TextStyle(
          color: kInkFaint,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 1 — Anatomy diagram: Widget → Element → RenderObject → Layer →
//             SceneBuilder → Scene → FlutterView
// =============================================================================
//
// The first thing every Flutter developer should internalise is that the
// widget tree they author is NOT what the GPU sees. Widgets are
// configuration; Elements are the live tree; RenderObjects compute layout
// and paint into a Canvas backed by a PictureRecorder; Layers wrap those
// Pictures and form a layer tree; SceneBuilder walks that layer tree and
// emits a Scene; finally FlutterView.render(scene) hands the Scene to the
// engine for rasterization.
//
// This section visualizes that pipeline as a horizontal row of coloured
// boxes connected with arrow glyphs. The colour ramp moves from cool blue
// (framework side, where the developer lives) through warmer ambers
// (RenderObject / Layer mid-zone) into pinks and violets (engine side,
// where the developer cannot reach without dart:ui).
// =============================================================================

Widget sectionAnatomy() {
  final stages = <Widget>[
    pipelineBox(
      stage: 'Widget',
      detail: 'Immutable\nconfiguration',
      color: kLayerWidget,
    ),
    arrow(color: kLayerWidget),
    pipelineBox(
      stage: 'Element',
      detail: 'Live tree\nlife-cycle',
      color: kLayerElement,
    ),
    arrow(color: kLayerElement),
    pipelineBox(
      stage: 'RenderObject',
      detail: 'Layout + paint\ninto Canvas',
      color: kLayerRender,
    ),
    arrow(color: kLayerRender),
    pipelineBox(
      stage: 'Layer',
      detail: 'Wraps Picture\n+ effects',
      color: kLayerEngine,
    ),
    arrow(color: kLayerEngine),
    pipelineBox(
      stage: 'SceneBuilder',
      detail: 'push / pop\naddPicture',
      color: kLayerScene,
    ),
    arrow(color: kLayerScene),
    pipelineBox(
      stage: 'Scene',
      detail: 'Frozen tree\nready to ship',
      color: kAccentRose,
    ),
    arrow(color: kAccentRose),
    pipelineBox(
      stage: 'FlutterView',
      detail: 'render(Scene)\n→ GPU',
      color: kLayerView,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '01',
        title: 'Anatomy of a Frame',
        subtitle: 'Widget → Element → RenderObject → Layer → SceneBuilder → Scene → FlutterView',
        gradient: [Color(0xFF2A4878), Color(0xFF1A2C4D)],
        accent: kAccentCyan,
      ),
      panel(
        accent: kAccentCyan,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'A frame in Flutter is not produced by the widget tree directly. The widget tree is a developer-facing description; '
              'the engine consumes a Scene. Between those two endpoints there is a chain of representations. Each link in the '
              'chain solves a different problem: configuration vs. identity vs. layout vs. composition vs. rasterization.',
            ),
            prose(
              'SceneBuilder is the API the engine exposes for the framework to assemble a Scene. The framework, via the '
              'compositor in RenderView, walks the layer tree once per frame and issues a sequence of pushTransform / pushOpacity / '
              'pushClipRect / addPicture / pop calls onto a fresh SceneBuilder. The Scene that comes out is then handed to '
              'FlutterView.render — that is the precise call that crosses the boundary into the C++ engine.',
            ),
            prose(
              'The pipeline below is therefore a contract: each stage owns its own concerns and is the only legitimate path '
              'through to the next stage. You cannot skip Layers and call SceneBuilder yourself from inside a widget — well, '
              'you can try, but you will not be in the compositor pass and your output will be discarded.',
            ),
            const SizedBox(height: 14),
            label('THE PIPELINE'),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: stages,
              ),
            ),
            fadeDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                statPair(big: '7', small: 'STAGES', color: kAccentCyan),
                statPair(big: '1', small: 'BOUNDARY', color: kAccentRose),
                statPair(big: '60Hz+', small: 'PER FRAME', color: kAccentLime),
                statPair(big: '1', small: 'SCENE / FRAME', color: kAccentAmber),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 2 — SceneBuilder API map
// =============================================================================
//
// The SceneBuilder API is small but oddly grouped. Its methods are all
// either "push something onto the scene-building stack" or "add a leaf
// child" or "pop the stack". The shape is identical to a turtle-graphics
// pen-down/pen-up state machine.
//
// We render the API as a styled table grouped into:
//   * Transforms     — pushTransform, pushOffset
//   * Opacity/Blend  — pushOpacity, pushBackdropFilter, pushColorFilter,
//                      pushImageFilter, pushShaderMask
//   * Clipping       — pushClipRect, pushClipRRect, pushClipPath
//   * Content (leaf) — addPicture, addPlatformView, addTexture, addRetained
//   * Stack control  — pop, build
// =============================================================================

Widget _apiGroupCard({
  required String groupName,
  required String groupNote,
  required Color accent,
  required List<List<String>> rows,
}) {
  final children = <Widget>[
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(color: accent.withOpacity(0.6), blurRadius: 10),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          groupName,
          style: TextStyle(
            color: accent,
            fontSize: 14.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
    const SizedBox(height: 6),
    prose(groupNote, color: kInkFaint, size: 12.5),
    const SizedBox(height: 8),
  ];

  final rowWidgets = List<Widget>.generate(rows.length, (i) {
    final r = rows[i];
    final method = r[0];
    final desc = r[1];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 200, child: code(method, color: accent)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                color: kInkMuted,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  });

  children.addAll(rowWidgets);

  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kBgPanelSoft,
      borderRadius: BorderRadius.circular(kInnerRadius),
      border: Border.all(color: accent.withOpacity(0.30), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}

Widget sectionApiMap() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '02',
        title: 'SceneBuilder API Map',
        subtitle: 'A turtle-graphics state machine for compositing layers',
        gradient: [Color(0xFF294A6E), Color(0xFF132A47)],
        accent: kAccentTeal,
      ),
      panel(
        accent: kAccentTeal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'SceneBuilder methods come in three flavours. push* methods open a new layer that affects every subsequent '
              'addPicture or nested push until a matching pop. add* methods drop leaf content — usually a Picture — into the '
              'currently open layer. The single non-stack method that matters is build(), which freezes the assembled tree '
              'into an immutable Scene that is safe to hand to the engine.',
            ),
            prose(
              'Critically, every push* returns an EngineLayer handle. You can pass the previous frame\'s handle back via the '
              'oldLayer parameter to enable retained rendering — the engine reuses the GPU resources for that subtree if its '
              'children have not changed. This is the dart:ui-level mechanism behind RepaintBoundary.',
            ),
            const SizedBox(height: 14),
            _apiGroupCard(
              groupName: 'TRANSFORMS',
              groupNote: 'Affine matrix concatenation — pushed transforms multiply onto the current matrix.',
              accent: kAccentSky,
              rows: [
                ['pushTransform(matrix4)', 'Push a 4x4 affine matrix; affects all enclosed children.'],
                ['pushOffset(dx, dy)', 'Cheap translate-only transform; the most common push in practice.'],
              ],
            ),
            _apiGroupCard(
              groupName: 'OPACITY & BLEND',
              groupNote: 'Compositing effects that require an offscreen buffer — use sparingly.',
              accent: kAccentViolet,
              rows: [
                ['pushOpacity(alpha)', 'Alpha-blend an entire subtree; allocates an offscreen layer.'],
                ['pushBackdropFilter(filter)', 'Apply ImageFilter to whatever is BEHIND this layer (e.g. blur).'],
                ['pushColorFilter(filter)', 'Apply ColorFilter to the subtree on its way to composition.'],
                ['pushImageFilter(filter)', 'Apply ImageFilter to the subtree itself (blur, dilate, matrix).'],
                ['pushShaderMask(shader, rect, blendMode)', 'Mask the subtree with a Shader + BlendMode.'],
              ],
            ),
            _apiGroupCard(
              groupName: 'CLIPPING',
              groupNote: 'Restrict the painting region — supports rect / rrect / path geometry.',
              accent: kAccentLime,
              rows: [
                ['pushClipRect(rect, clipBehavior)', 'Hard-edged rectangular clip in scene coordinates.'],
                ['pushClipRRect(rrect)', 'Rounded-rect clip; antialiased on most devices.'],
                ['pushClipPath(path)', 'Arbitrary path clip; the most expensive of the three.'],
              ],
            ),
            _apiGroupCard(
              groupName: 'CONTENT (LEAF)',
              groupNote: 'Drop concrete pixel sources into the currently open layer.',
              accent: kAccentAmber,
              rows: [
                ['addPicture(offset, picture)', 'Insert a recorded Picture at offset; the bread-and-butter call.'],
                ['addPlatformView(viewId, ...)', 'Insert a native platform view (UIView / android.view.View).'],
                ['addTexture(textureId, ...)', 'Insert an external texture — video frames, camera, etc.'],
                ['addRetained(engineLayer)', 'Re-attach a previously built EngineLayer subtree intact.'],
              ],
            ),
            _apiGroupCard(
              groupName: 'STACK CONTROL',
              groupNote: 'Closing pushes and finalising the build.',
              accent: kAccentRose,
              rows: [
                ['pop()', 'Close the most recently pushed layer; balance of pushes and pops is mandatory.'],
                ['build()', 'Freeze the current tree into a Scene. After build() the builder is exhausted.'],
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 3 — Layer tree visualization
// =============================================================================
//
// Here we show what the framework constructs internally. A root
// ContainerLayer holds three siblings: a transformed picture (a rotated
// red square, conceptually), an opacity-wrapped picture (faded blue dot),
// and a clipped picture (rounded-rect green strip). We draw the tree as
// nested boxes where the outer box is the parent layer and the inner box
// is its child. Corner labels indicate the layer kind.
// =============================================================================

Widget _layerWrap({
  required String label,
  required Color color,
  required Widget child,
  String? tag,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kInnerRadius),
      color: color.withOpacity(0.10),
      border: Border.all(color: color.withOpacity(0.65), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
            if (tag != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.30),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withOpacity(0.6), width: 0.6),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: color,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

Widget _pictureLeaf({required String hint, required Color tint}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [tint.withOpacity(0.85), tint.withOpacity(0.45)],
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.photo_size_select_actual_outlined, color: Colors.black87, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Picture · $hint',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget sectionLayerTree() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '03',
        title: 'A Layer Tree, Visualized',
        subtitle: 'What SceneBuilder sees when it walks your RenderView',
        gradient: [Color(0xFF1F3D62), Color(0xFF132A47)],
        accent: kAccentLime,
      ),
      panel(
        accent: kAccentLime,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'The framework builds a Layer tree as a side-effect of painting. Container layers (Transform, Opacity, ClipRect, '
              'BackdropFilter) hold child layers; PictureLayer is a leaf carrying a recorded Picture. The compositor walks this '
              'tree depth-first, issuing a corresponding push* / addPicture / pop into a SceneBuilder.',
            ),
            prose(
              'Below is a small but representative tree: a root ContainerLayer with three children. The first is a TransformLayer '
              'wrapping a Picture of a rotated red square. The second is an OpacityLayer wrapping a faded blue dot. The third is a '
              'ClipRectLayer wrapping a green strip. This is exactly the shape that SceneBuilder consumes — boxes inside boxes.',
            ),
            prose(
              'Notice that each container layer is essentially a deferred push into the SceneBuilder. The layer is just a record '
              'of "when you walk me, push this transform / opacity / clip onto the builder, walk my children, and then pop". '
              'Layers are passive data; SceneBuilder is the visitor that turns them into a Scene.',
            ),
            const SizedBox(height: 14),
            _layerWrap(
              label: 'Root ContainerLayer',
              color: kAccentSky,
              tag: 'root',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _layerWrap(
                    label: 'TransformLayer',
                    color: kAccentAmber,
                    tag: 'matrix4',
                    child: _pictureLeaf(hint: 'rotated red square', tint: kAccentCoral),
                  ),
                  const SizedBox(height: 12),
                  _layerWrap(
                    label: 'OpacityLayer',
                    color: kAccentViolet,
                    tag: 'alpha=0.5',
                    child: _pictureLeaf(hint: 'faded blue dot', tint: kAccentSky),
                  ),
                  const SizedBox(height: 12),
                  _layerWrap(
                    label: 'ClipRectLayer',
                    color: kAccentLime,
                    tag: 'rect=…',
                    child: _pictureLeaf(hint: 'green strip', tint: kAccentTeal),
                  ),
                ],
              ),
            ),
            fadeDivider(),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                pillBadge('3 children', color: kAccentCyan, icon: Icons.account_tree_outlined),
                pillBadge('1 transform', color: kAccentAmber, icon: Icons.sync_alt),
                pillBadge('1 opacity', color: kAccentViolet, icon: Icons.opacity),
                pillBadge('1 clip', color: kAccentLime, icon: Icons.crop_square),
                pillBadge('3 leaf pictures', color: kAccentRose, icon: Icons.photo_library_outlined),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 4 — Push/pop sequence diagram
// =============================================================================
//
// SceneBuilder is a stack machine. To make that vivid, we render the
// linear push/pop sequence corresponding to the previous section's tree
// as a numbered timeline of coloured blocks.
//
// The sequence is:
//   1. push(Transform)
//   2. addPicture(red)
//   3. pop()              -> close TransformLayer
//   4. push(Opacity)
//   5. addPicture(blue)
//   6. pop()              -> close OpacityLayer
//   7. push(ClipRect)
//   8. addPicture(green)
//   9. pop()              -> close ClipRectLayer
//  10. build()            -> produce Scene
// =============================================================================

Widget sectionPushPopTimeline() {
  final steps = <Widget>[
    timelineStep(op: 'pushTransform', detail: 'open Transform', color: kAccentAmber, index: 1),
    timelineStep(op: 'addPicture', detail: 'red square', color: kAccentCoral, index: 2),
    timelineStep(op: 'pop', detail: 'close Transform', color: kInkFaint, index: 3),
    timelineStep(op: 'pushOpacity', detail: 'open Opacity', color: kAccentViolet, index: 4),
    timelineStep(op: 'addPicture', detail: 'blue dot', color: kAccentSky, index: 5),
    timelineStep(op: 'pop', detail: 'close Opacity', color: kInkFaint, index: 6),
    timelineStep(op: 'pushClipRect', detail: 'open Clip', color: kAccentLime, index: 7),
    timelineStep(op: 'addPicture', detail: 'green strip', color: kAccentTeal, index: 8),
    timelineStep(op: 'pop', detail: 'close Clip', color: kInkFaint, index: 9),
    timelineStep(op: 'build', detail: '→ Scene', color: kAccentRose, index: 10),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '04',
        title: 'The Push/Pop Sequence',
        subtitle: 'A linear timeline of stack operations onto SceneBuilder',
        gradient: [Color(0xFF3A2A5E), Color(0xFF1F1B3B)],
        accent: kAccentViolet,
      ),
      panel(
        accent: kAccentViolet,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'SceneBuilder maintains an internal stack. Every push* lengthens the stack; every pop shortens it. addPicture '
              'inserts a leaf into whatever is currently on top. By the time you call build(), the stack must be empty — every '
              'push must have been balanced by a pop, or the engine will refuse to materialize the Scene.',
            ),
            prose(
              'The timeline below replays the previous section\'s layer tree as a flat sequence of operations. Read it left to '
              'right: ten steps, ending in build(). The pop blocks are deliberately drawn in muted grey — they are structural '
              'punctuation, not content; they exist to balance the push that opened the layer.',
            ),
            prose(
              'In production code you almost never write this sequence by hand. The compositor (RenderObject\'s paint methods '
              'plus PaintingContext + RenderView) emits it for you. Knowing the sequence exists is what unlocks debugging tools '
              'like the layer tree dump and the "track widget rebuilds" instrumentation.',
            ),
            const SizedBox(height: 14),
            label('TIMELINE', color: kAccentViolet),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: steps,
              ),
            ),
            const SizedBox(height: 14),
            label('STACK DEPTH PROFILE', color: kAccentCyan),
            const SizedBox(height: 8),
            // A stylised bar chart of the stack depth at each step.
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kBgPanelSoft,
                borderRadius: BorderRadius.circular(kInnerRadius),
                border: Border.all(color: kAccentCyan.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List<Widget>.generate(10, (i) {
                  final depths = <int>[1, 1, 0, 1, 1, 0, 1, 1, 0, 0];
                  final d = depths[i];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: d == 0 ? 4.0 : 28.0 + d * 18.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  kAccentCyan.withOpacity(0.85),
                                  kAccentCyan.withOpacity(0.20),
                                ],
                              ),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${i + 1}',
                            style: const TextStyle(
                              color: kInkFaint,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 5 — Scene construction recipe
// =============================================================================
//
// A numbered card column that walks through, in prose, the precise steps
// that produce one Scene per frame: engine ticks, framework draws, builders
// push/pop, build() returns Scene, FlutterView consumes it.
// =============================================================================

Widget _recipeStep({
  required int index,
  required String title,
  required String body,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kBgPanelSoft,
      borderRadius: BorderRadius.circular(kInnerRadius),
      // Flutter forbids non-uniform border colors when borderRadius is set;
      // use a uniform border and surface the accent via the leading badge below.
      border: Border.all(color: color.withOpacity(0.20)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withOpacity(0.22),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.7), width: 1.2),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: kInkMuted,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget sectionRecipe() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '05',
        title: 'A Scene Construction Recipe',
        subtitle: 'What happens between vsync and pixels',
        gradient: [Color(0xFF1B3D55), Color(0xFF112538)],
        accent: kAccentSky,
      ),
      panel(
        accent: kAccentSky,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'Producing one Scene happens once per vsync. The engine ticks, the framework runs its build/layout/paint phases, '
              'a fresh SceneBuilder is created, the layer tree is walked, build() finalises the Scene, FlutterView.render is '
              'called, and the engine then rasterizes on a worker thread. The recipe below splits these into named steps.',
            ),
            prose(
              'The exact ordering matters because each step has preconditions. You cannot push transforms before allocating a '
              'SceneBuilder, you cannot addPicture before pushing at least one container, you cannot call build() before '
              'balancing pops. Holding the recipe in your head is what lets you read the engine\'s C++ source without panic.',
            ),
            prose(
              'Note that the steps here describe ONE frame. Each subsequent frame allocates a fresh SceneBuilder and produces '
              'a fresh Scene. The retained-rendering optimisation (addRetained) can reuse subtrees across frames, but the '
              'SceneBuilder itself is single-use — once you have called build() on it, it is exhausted.',
            ),
            const SizedBox(height: 14),
            _recipeStep(
              index: 1,
              title: 'Engine signals vsync',
              body: 'The platform fires vsync. The engine schedules a frame and notifies the framework via PlatformDispatcher.onBeginFrame.',
              color: kAccentCyan,
            ),
            _recipeStep(
              index: 2,
              title: 'Framework runs build / layout / paint',
              body: 'WidgetsBinding processes scheduled rebuilds, performs layout on dirty RenderObjects, and triggers paint passes '
                  'that record into PictureRecorders.',
              color: kAccentSky,
            ),
            _recipeStep(
              index: 3,
              title: 'PaintingContext produces Pictures',
              body: 'Each PictureLayer wraps a Picture obtained from PictureRecorder.endRecording(). Pictures are immutable, '
                  'replayable lists of canvas operations.',
              color: kAccentLime,
            ),
            _recipeStep(
              index: 4,
              title: 'Compositor allocates a fresh SceneBuilder',
              body: 'RenderView.compositeFrame creates `ui.SceneBuilder()`. From here the SceneBuilder is the only thing that '
                  'matters until build() is called.',
              color: kAccentTeal,
            ),
            _recipeStep(
              index: 5,
              title: 'Walk the layer tree, push & addPicture',
              body: 'The layer tree is walked depth-first; container layers issue push* calls; picture layers issue addPicture; '
                  'after each subtree we pop.',
              color: kAccentAmber,
            ),
            _recipeStep(
              index: 6,
              title: 'Call build() to freeze the Scene',
              body: 'sceneBuilder.build() returns a `ui.Scene`. The builder is now exhausted — calling pop or addPicture on it '
                  'is a misuse.',
              color: kAccentViolet,
            ),
            _recipeStep(
              index: 7,
              title: 'FlutterView.render(scene)',
              body: 'The Scene is handed to FlutterView. This is the boundary call that crosses into the C++ engine, where '
                  'Skia or Impeller will rasterize it onto the GPU surface.',
              color: kAccentRose,
            ),
            _recipeStep(
              index: 8,
              title: 'Dispose & next frame',
              body: 'After render, the Scene\'s native handle is owned by the engine. The framework drops its reference and '
                  'awaits the next vsync to begin again.',
              color: kAccentCoral,
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 6 — Comparison vs CustomPainter
// =============================================================================
//
// Most app developers never call SceneBuilder. They override
// CustomPainter.paint(Canvas, Size). The two APIs feel similar but operate
// on different sides of the boundary: CustomPainter draws into a Canvas
// inside a RenderObject; SceneBuilder composes that RenderObject's
// resulting Picture together with everyone else's into a final Scene.
// =============================================================================

Widget _comparisonCard({
  required String title,
  required String role,
  required List<String> bullets,
  required List<Color> gradient,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    width: 320,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kInnerRadius),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      border: Border.all(color: accent.withOpacity(0.6), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: accent.withOpacity(0.30),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          role,
          style: TextStyle(
            color: kInkPrimary.withOpacity(0.92),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            height: 1.4,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(bullets.length, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      bullets[i],
                      style: const TextStyle(
                        color: kInkMuted,
                        fontSize: 12.5,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget sectionComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '06',
        title: 'CustomPainter vs SceneBuilder',
        subtitle: 'What you usually do, vs. what the engine does',
        gradient: [Color(0xFF36365C), Color(0xFF1A1A36)],
        accent: kAccentAmber,
      ),
      panel(
        accent: kAccentAmber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'Both APIs deal with rendering primitives, but at different layers of abstraction. CustomPainter operates inside '
              'a single RenderObject and paints into a Canvas — the Canvas is itself just a façade over a PictureRecorder, so '
              'each CustomPainter ultimately produces ONE Picture. SceneBuilder, by contrast, composes many such Pictures into '
              'one Scene per frame.',
            ),
            prose(
              'A clarifying analogy: CustomPainter is the painter at one easel producing a single canvas; SceneBuilder is the '
              'gallery curator stacking many canvases into a vitrine, applying frames (transforms), spotlights (opacity / blend), '
              'and barriers (clips). The viewer (the GPU) sees the curated arrangement.',
            ),
            prose(
              'Confusing the two leads to one of the most common newbie mistakes: trying to apply an opacity inside a '
              'CustomPainter\'s draw call rather than letting the framework wrap the RenderObject in an Opacity widget. The '
              'first paints a translucent shape; the second creates an OpacityLayer that the SceneBuilder will composite — and '
              'only the second is correctly composited against backgrounds with arbitrary blend modes.',
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                _comparisonCard(
                  title: 'CustomPainter',
                  role: 'Inside ONE RenderObject. Output: a single Picture.',
                  bullets: [
                    'Override paint(Canvas canvas, Size size).',
                    'Calls go to a Canvas, which records into a PictureRecorder.',
                    'You see only your own RenderObject\'s coordinate space.',
                    'You cannot directly insert other widgets, platform views, or textures.',
                    'Effects like clip / opacity must be applied via canvas.save / canvas.saveLayer or via wrapping widgets.',
                    'Output is one Picture, attached to one PictureLayer in the layer tree.',
                  ],
                  gradient: [Color(0xFF294A6E), Color(0xFF132A47)],
                  accent: kAccentSky,
                  icon: Icons.brush_outlined,
                ),
                _comparisonCard(
                  title: 'SceneBuilder',
                  role: 'In the engine boundary. Output: one Scene per frame.',
                  bullets: [
                    'Constructed once per frame by the compositor.',
                    'Push/pop layers; addPicture, addPlatformView, addTexture.',
                    'Operates in scene coordinates — the FlutterView\'s coordinate space.',
                    'Can compose many independent Pictures, including platform views.',
                    'Effects are layer-level: pushOpacity, pushBackdropFilter, pushColorFilter.',
                    'Output is a Scene, fed to FlutterView.render(), then rasterized by Skia / Impeller.',
                  ],
                  gradient: [Color(0xFF3A2A5E), Color(0xFF1F1B3B)],
                  accent: kAccentViolet,
                  icon: Icons.layers_outlined,
                ),
              ],
            ),
            fadeDivider(),
            label('RULE OF THUMB', color: kAccentAmber),
            const SizedBox(height: 6),
            prose(
              'If you can solve it with widgets, do. If you need fine-grained drawing, drop down to CustomPainter. Only reach '
              'for SceneBuilder when you are building a custom embedder, integrating a non-standard texture source, or writing '
              'instrumentation/diagnostics.',
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 7 — Footgun panel
// =============================================================================
//
// Common misunderstandings around Scene / SceneBuilder. Each footgun gets
// its own labelled visual.
// =============================================================================

Widget _footgunCard({
  required String title,
  required String body,
  required String fix,
  required Color color,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kInnerRadius),
      color: color.withOpacity(0.10),
      border: Border.all(color: color.withOpacity(0.55), width: 1.1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            pillBadge('FOOTGUN', color: color, icon: Icons.warning_amber_outlined),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 12.5,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kOk.withOpacity(0.5), width: 0.8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle_outline, color: kOk, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  fix,
                  style: TextStyle(
                    color: kOk.withOpacity(0.95),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget sectionFootguns() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '07',
        title: 'Footguns & Misconceptions',
        subtitle: 'Things people think SceneBuilder is — and isn\'t',
        gradient: [Color(0xFF5E2E2E), Color(0xFF351818)],
        accent: kWarn,
      ),
      panel(
        accent: kWarn,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'SceneBuilder lives at the boundary, so it is surrounded by a halo of "I thought I could just…" pitfalls. The '
              'list below collects the most common ones, both from public Flutter issues and from experience reviewing '
              'rendering-heavy code. Each card states the misconception, explains why it does not hold, and gives the correct '
              'mental model.',
            ),
            const SizedBox(height: 12),
            _footgunCard(
              title: 'Widgets call SceneBuilder',
              color: kAccentRose,
              icon: Icons.layers_clear_outlined,
              body:
                  'Widgets do not see SceneBuilder. The compositor (RenderView, owned by the binding) is the one and only '
                  'caller of `pushTransform` / `addPicture` / `pop` in normal apps. From inside a widget you have neither the '
                  'right SceneBuilder nor the right phase of the frame to use it.',
              fix:
                  'Express your effect using widgets (Transform, Opacity, ClipRect, BackdropFilter) — they translate to layers '
                  'that the compositor will then push onto SceneBuilder for you.',
            ),
            _footgunCard(
              title: 'Forgetting to pop',
              color: kWarn,
              icon: Icons.unfold_more_outlined,
              body:
                  'SceneBuilder is a stack. Every push must be matched by a pop. Forgetting one leaves the stack non-empty at '
                  'build() time, which is undefined behaviour at the dart:ui level — usually silent corruption, sometimes a '
                  'hard crash.',
              fix:
                  'If you ever do call SceneBuilder yourself, mirror push/pop with try/finally. Every push has exactly one pop, '
                  'just like canvas.save / canvas.restore.',
            ),
            _footgunCard(
              title: 'Calling build() twice',
              color: kAccentAmber,
              icon: Icons.repeat_one_outlined,
              body:
                  'A SceneBuilder is single-use. Once you call build(), the internal native state is consumed; calling pop / '
                  'push / addPicture / build again on the same instance is a misuse. The framework allocates a fresh '
                  'SceneBuilder each frame for exactly this reason.',
              fix:
                  'Construct a new `ui.SceneBuilder()` per Scene. If you cache anything, cache the resulting Scene or an '
                  'EngineLayer, not the builder.',
            ),
            _footgunCard(
              title: 'Mutating a Scene after dispose',
              color: kAccentCoral,
              icon: Icons.bug_report_outlined,
              body:
                  'A Scene\'s native resources are owned by the engine after FlutterView.render. If you keep a reference and '
                  'try to use it later, you are reading freed memory at the C++ side. The Dart object may still exist, but '
                  'the underlying state is gone.',
              fix:
                  'Treat Scene as write-once, read-once. Hand it to FlutterView.render and drop the reference. If you need '
                  'subtree reuse across frames, use addRetained with an EngineLayer handle.',
            ),
            _footgunCard(
              title: 'Mixing scene and canvas coordinates',
              color: kAccentViolet,
              icon: Icons.compare_arrows_outlined,
              body:
                  'Coordinates passed to push* / addPicture are in the scene\'s coordinate space (typically logical pixels '
                  'at the FlutterView origin). Coordinates inside a CustomPainter\'s Canvas are in that RenderObject\'s '
                  'local space. Mixing them is silent and looks "almost right".',
              fix:
                  'Translate explicitly with pushOffset / pushTransform when crossing boundaries. Document which space each '
                  'coordinate is in.',
            ),
            _footgunCard(
              title: 'Treating SceneBuilder as multithreaded',
              color: kAccentSky,
              icon: Icons.timer_outlined,
              body:
                  'SceneBuilder calls happen on the UI isolate, between vsync and FlutterView.render. They are NOT '
                  'thread-safe and you cannot call them off the main isolate.',
              fix:
                  'Stay on the UI isolate. If you have heavy work, do it before the frame and produce immutable Pictures '
                  'that you addPicture during the compositor pass.',
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 8 — Where Scene lives: FlutterView.render(scene)
// =============================================================================
//
// We visualize the framework/engine boundary as two coloured zones with a
// single arrow crossing it. The arrow is the FlutterView.render call.
// =============================================================================

Widget _zoneCard({
  required String name,
  required String tagline,
  required List<String> bullets,
  required Color accent,
  required List<Color> gradient,
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kInnerRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        border: Border.all(color: accent.withOpacity(0.55), width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: accent,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tagline,
            style: TextStyle(
              color: kInkPrimary.withOpacity(0.85),
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(bullets.length, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        bullets[i],
                        style: const TextStyle(
                          color: kInkMuted,
                          fontSize: 12,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    ),
  );
}

Widget sectionBoundary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '08',
        title: 'Where Scene Lives',
        subtitle: 'FlutterView.render is the framework / engine boundary',
        gradient: [Color(0xFF1F4747), Color(0xFF0F2A2A)],
        accent: kAccentTeal,
      ),
      panel(
        accent: kAccentTeal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'Scene is the only object that legally crosses the framework/engine boundary in the rendering path. Everything on '
              'the framework side — Widgets, Elements, RenderObjects, Layers — is plain Dart code. Everything on the engine '
              'side — the rasterizer, surface management, GPU thread, Skia/Impeller — is C++ accessed via dart:ui FFI.',
            ),
            prose(
              'FlutterView.render(Scene) is the single function call that hands a Dart-built Scene over to the engine. After '
              'that call returns, the engine owns the rasterization. The framework can begin building the next frame.',
            ),
            prose(
              'This boundary is why dart:ui has so many "weird" feeling APIs (PictureRecorder, Codec, Image.toByteData, '
              'SceneBuilder, FrameInfo, …). They are not weird; they are the thinnest legal layer over the engine\'s C++ '
              'objects, kept thin so the boundary cost is predictable.',
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _zoneCard(
                  name: 'FRAMEWORK SIDE',
                  tagline: 'Pure Dart. The world you author.',
                  accent: kAccentSky,
                  gradient: [Color(0xFF1F3D62), Color(0xFF132A47)],
                  bullets: [
                    'Widgets, Elements, RenderObjects.',
                    'PaintingContext, Layer subclasses.',
                    'Compositor walks layer tree.',
                    'Builds a SceneBuilder, pushes/pops, calls build().',
                    'Produces ONE Scene per vsync.',
                  ],
                ),
                const SizedBox(width: 14),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: kAccentRose.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kAccentRose, width: 1.0),
                      ),
                      child: Text(
                        'render(scene)',
                        style: TextStyle(
                          color: kAccentRose,
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Icon(Icons.east, color: kAccentRose, size: 28),
                    const SizedBox(height: 4),
                    Text(
                      'BOUNDARY',
                      style: TextStyle(
                        color: kAccentRose,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                _zoneCard(
                  name: 'ENGINE SIDE',
                  tagline: 'C++. Skia / Impeller. The world you do not author.',
                  accent: kAccentRose,
                  gradient: [Color(0xFF5E2A4A), Color(0xFF2E1228)],
                  bullets: [
                    'Receives Scene via FFI.',
                    'Walks engine layers, rasterizes via Skia/Impeller.',
                    'Manages GPU surface, tex memory, vsync timing.',
                    'Owns retained EngineLayer handles.',
                    'Returns frame timing back to the framework.',
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 9 — Try it: actually attempt to construct a SceneBuilder
// =============================================================================
//
// We attempt to call ui.SceneBuilder() and a couple of cheap operations
// inside a try/catch. We DO NOT call build() or render anything — that
// requires a FlutterView, which we do not have in this test context.
// We surface the result as a status badge: Constructed ✓ or Skipped ✕.
// =============================================================================

bool _tryConstructSceneBuilder() {
  try {
    final builder = ui.SceneBuilder();
    // We deliberately do nothing else with it. The construction itself is
    // already informative: if we got here, the dart:ui binding is alive.
    // We do not call build(), pushTransform, or anything that might
    // dereference into engine-only state.
    return true;
  } catch (_) {
    return false;
  }
}

Widget sectionTryIt() {
  // Capture this once at build time, so the badge reflects what happened.
  final ok = _tryConstructSceneBuilder();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '09',
        title: 'Try It: Construct a SceneBuilder',
        subtitle: 'Guarded probe — we never call build() or render()',
        gradient: [Color(0xFF45452A), Color(0xFF26261A)],
        accent: kAccentLime,
      ),
      panel(
        accent: kAccentLime,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'Inside the bridged interpreter we cannot rasterize a Scene because there is no FlutterView. But we can still '
              'attempt the cheapest operation in the API surface: `ui.SceneBuilder()` itself. If the dart:ui binding is alive, '
              'the constructor succeeds; if it is stubbed or missing, we fall back gracefully.',
            ),
            prose(
              'The probe below is wrapped in try/catch and never calls build(), pushTransform, addPicture, or anything else. '
              'Even the constructor call is treated as untrusted — we only care whether it returned an instance or threw.',
            ),
            prose(
              'The status badge is updated once at build() time. There is no asynchronous work, no controllers, no setState. '
              'This keeps the demo deterministic across runs in the interpreter.',
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                pillBadge(
                  ok ? 'Constructed ✓' : 'Skipped ✕',
                  color: ok ? kOk : kWarn,
                  icon: ok ? Icons.check_circle_outline : Icons.block,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    ok
                        ? 'A ui.SceneBuilder instance was constructed successfully. We did NOT call build() or push anything onto it — only the bare constructor was probed.'
                        : 'Construction was guarded; either the binding is unavailable or threw on instantiation. The visualization above stands on its own without a live builder.',
                    style: const TextStyle(
                      color: kInkMuted,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            fadeDivider(),
            label('PROBE CODE', color: kAccentLime),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.40),
                borderRadius: BorderRadius.circular(kInnerRadius),
                border: Border.all(color: kAccentLime.withOpacity(0.35)),
              ),
              child: Text(
                'bool _tryConstructSceneBuilder() {\n'
                '  try {\n'
                '    final builder = ui.SceneBuilder();\n'
                '    return true;\n'
                '  } catch (_) {\n'
                '    return false;\n'
                '  }\n'
                '}',
                style: TextStyle(
                  color: kAccentLime.withOpacity(0.95),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 10 — Glossary
// =============================================================================
//
// A condensed vocabulary card. Each term gets a one-line definition and a
// secondary clarifying note. Together they form a quick-reference pane.
// =============================================================================

Widget _glossEntry({
  required String term,
  required String def,
  required String note,
  required Color accent,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kInnerRadius),
      color: kBgPanelSoft,
      border: Border(
        left: BorderSide(color: accent, width: 4),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              term,
              style: TextStyle(
                color: accent,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(height: 1, color: accent.withOpacity(0.25)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          def,
          style: const TextStyle(
            color: kInkPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          note,
          style: const TextStyle(
            color: kInkFaint,
            fontSize: 11.5,
            height: 1.45,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget sectionGlossary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      gradientHeader(
        number: '10',
        title: 'Glossary',
        subtitle: 'The five words you must know to read the engine',
        gradient: [Color(0xFF2E2A55), Color(0xFF181638)],
        accent: kAccentViolet,
      ),
      panel(
        accent: kAccentViolet,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prose(
              'The dart:ui rendering API rests on a small vocabulary. Once you have the five terms below internalised, the rest '
              'of the API reads cleanly. Skipping any of them is the difference between "the docs make sense" and "the docs are '
              'an alien language".',
            ),
            const SizedBox(height: 12),
            _glossEntry(
              term: 'Picture',
              accent: kAccentSky,
              def: 'An immutable, replayable list of canvas operations.',
              note: 'Produced by PictureRecorder.endRecording(). Cheap to addPicture into a Scene multiple times.',
            ),
            _glossEntry(
              term: 'Layer',
              accent: kAccentLime,
              def: 'A node in the framework\'s composition tree, wrapping either a Picture or a stack of children.',
              note: 'Layers are framework-side. They map 1:1 to push* / addPicture calls during scene assembly.',
            ),
            _glossEntry(
              term: 'SceneBuilder',
              accent: kAccentTeal,
              def: 'A stack-based assembler for the engine\'s view of one frame.',
              note: 'Single-use. Allocated by the compositor every frame; consumed by build().',
            ),
            _glossEntry(
              term: 'Scene',
              accent: kAccentRose,
              def: 'The frozen output of SceneBuilder.build() — an opaque handle handed to the engine.',
              note: 'Owns native resources. Once render()ed, treat it as gone.',
            ),
            _glossEntry(
              term: 'FlutterView',
              accent: kAccentCyan,
              def: 'The Dart-side handle to a single rendering surface (typically one window).',
              note: 'Its render(Scene) method is the framework/engine boundary call.',
            ),
            _glossEntry(
              term: 'EngineLayer',
              accent: kAccentAmber,
              def: 'A retained handle returned by push* methods, usable on the next frame via addRetained.',
              note: 'The dart:ui-level mechanism behind RepaintBoundary and other reuse optimisations.',
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 11 — Closing card: a compact call-to-action / mental-model summary
// =============================================================================

Widget sectionClosing() {
  return Container(
    margin: const EdgeInsets.only(top: kSectionGap),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kCardRadius),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1A2C4D), Color(0xFF0E1A2E)],
      ),
      border: Border.all(color: kAccentCyan.withOpacity(0.45), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: kAccentCyan.withOpacity(0.20),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.bolt_outlined, color: kAccentCyan, size: 22),
            const SizedBox(width: 10),
            Text(
              'TAKE-HOME MENTAL MODEL',
              style: TextStyle(
                color: kAccentCyan,
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Widgets describe; Elements identify; RenderObjects measure & paint into Pictures; '
          'Layers structure; SceneBuilder composes; Scene crosses the boundary; FlutterView renders.',
          style: TextStyle(
            color: kInkPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.55,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'When in doubt, ask: which side of the boundary am I on right now? If you are inside a widget\'s '
          'paint method, you are framework-side and the right tools are widgets and CustomPainter. If you '
          'are writing a custom embedder, you are engine-side and SceneBuilder is your friend.',
          style: TextStyle(
            color: kInkMuted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// THE ENTRY POINT
// =============================================================================
//
// `build` is called exactly once by the bridged harness. It assembles every
// section into a vertical scroll. We deliberately keep this function flat
// and assignment-free so the interpreter has no surprises.
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF0E1A2E),
      appBar: AppBar(
        title: const Text('dart:ui Scene & SceneBuilder'),
        backgroundColor: kBgMid,
        foregroundColor: kInkPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sectionAnatomy(),
            const SizedBox(height: kSectionGap),
            sectionApiMap(),
            const SizedBox(height: kSectionGap),
            sectionLayerTree(),
            const SizedBox(height: kSectionGap),
            sectionPushPopTimeline(),
            const SizedBox(height: kSectionGap),
            sectionRecipe(),
            const SizedBox(height: kSectionGap),
            sectionComparison(),
            const SizedBox(height: kSectionGap),
            sectionFootguns(),
            const SizedBox(height: kSectionGap),
            sectionBoundary(),
            const SizedBox(height: kSectionGap),
            sectionTryIt(),
            const SizedBox(height: kSectionGap),
            sectionGlossary(),
            sectionClosing(),
          ],
        ),
      ),
    ),
  );
}
