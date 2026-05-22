// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// Deep Visual Demo: gestures *Details classes from flutter/gestures.dart
// ---------------------------------------------------------------------
// Design plan:
//   This script renders a static "field guide" to the family of *Details
//   value objects that GestureDetector and the gesture-recognizer machinery
//   pass into their callbacks. Each Details type is constructed with
//   synthetic, deterministic sample values (globalPosition, localPosition,
//   velocity, scale, rotation, force, etc.). Every value object is then
//   shown three ways: (1) a "spec card" listing its fields, (2) a small
//   200x200 visual stage diagram that places a dot, vector, or arc to
//   illustrate the gesture, and (3) where useful, an extra annotation
//   tying it back to which GestureDetector callback receives that type.
//
//   Layout (eight numbered sections):
//     1. Hero banner + taxonomy of *Details                    (header)
//     2. Tap details family   (TapDownDetails / TapUpDetails / TapDragDownDetails)
//     3. Drag details family  (DragStartDetails / DragUpdateDetails / DragEndDetails)
//     4. Scale details family (ScaleStartDetails / ScaleUpdateDetails / ScaleEndDetails)
//     5. Long-press details   (LongPressStartDetails / MoveUpdate / End / ForcePressDetails)
//     6. Hover / pointer event details (PointerEnterEvent / PointerHoverEvent)
//     7. GestureDetector callback -> Details type mapping table
//     8. Recipe cookbook + glossary
//
//   Style: Material 3 color scheme (primary / secondary / tertiary /
//   error containers). Gradient header. All widgets are stateless and
//   built inline; no Timer / async / Navigator / showDialog. GestureDetector
//   instances are rendered visually but their callbacks intentionally do
//   nothing because this is a static AST execution context.
//
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Sample fixtures: synthetic Details instances with stable example values.
// Pulling these out of the build tree keeps the layout code readable and lets
// the comparison tables in sections 7 and 8 reference the same instances.
// ---------------------------------------------------------------------------

const Offset _kGlobalA = Offset(120.0, 80.0);
const Offset _kLocalA = Offset(40.0, 30.0);
const Offset _kGlobalB = Offset(180.0, 150.0);
const Offset _kLocalB = Offset(100.0, 100.0);
const Offset _kGlobalC = Offset(60.0, 170.0);
const Offset _kLocalC = Offset(20.0, 120.0);

final TapDownDetails _sampleTapDown = TapDownDetails(
  globalPosition: _kGlobalA,
  localPosition: _kLocalA,
  kind: PointerDeviceKind.touch,
);

final TapUpDetails _sampleTapUp = TapUpDetails(
  globalPosition: _kGlobalA,
  localPosition: _kLocalA,
  kind: PointerDeviceKind.touch,
);

final TapDragDownDetails _sampleTapDragDown = TapDragDownDetails(
  globalPosition: _kGlobalA,
  localPosition: _kLocalA,
  kind: PointerDeviceKind.touch,
  consecutiveTapCount: 2,
);

final DragStartDetails _sampleDragStart = DragStartDetails(
  globalPosition: _kGlobalA,
  localPosition: _kLocalA,
  sourceTimeStamp: const Duration(milliseconds: 100),
  kind: PointerDeviceKind.touch,
);

final DragUpdateDetails _sampleDragUpdate = DragUpdateDetails(
  globalPosition: _kGlobalB,
  localPosition: _kLocalB,
  delta: const Offset(12.0, 7.0),
  primaryDelta: null,
  sourceTimeStamp: const Duration(milliseconds: 200),
);

final DragEndDetails _sampleDragEnd = DragEndDetails(
  velocity: const Velocity(pixelsPerSecond: Offset(240.0, -120.0)),
  primaryVelocity: null,
  globalPosition: _kGlobalB,
  localPosition: _kLocalB,
);

final ScaleStartDetails _sampleScaleStart = ScaleStartDetails(
  focalPoint: _kGlobalB,
  localFocalPoint: _kLocalB,
  pointerCount: 2,
);

final ScaleUpdateDetails _sampleScaleUpdate = ScaleUpdateDetails(
  focalPoint: _kGlobalB,
  localFocalPoint: _kLocalB,
  scale: 1.4,
  horizontalScale: 1.5,
  verticalScale: 1.3,
  rotation: 0.35,
  pointerCount: 2,
);

final ScaleEndDetails _sampleScaleEnd = ScaleEndDetails(
  velocity: const Velocity(pixelsPerSecond: Offset(50.0, 50.0)),
  scaleVelocity: 0.8,
  pointerCount: 2,
);

final LongPressStartDetails _sampleLongPressStart = LongPressStartDetails(
  globalPosition: _kGlobalC,
  localPosition: _kLocalC,
);

final LongPressMoveUpdateDetails _sampleLongPressMove =
    LongPressMoveUpdateDetails(
  globalPosition: _kGlobalC + const Offset(20.0, -10.0),
  localPosition: _kLocalC + const Offset(20.0, -10.0),
  offsetFromOrigin: const Offset(20.0, -10.0),
  localOffsetFromOrigin: const Offset(20.0, -10.0),
);

final LongPressEndDetails _sampleLongPressEnd = LongPressEndDetails(
  globalPosition: _kGlobalC + const Offset(20.0, -10.0),
  localPosition: _kLocalC + const Offset(20.0, -10.0),
  velocity: const Velocity(pixelsPerSecond: Offset(15.0, -5.0)),
);

final ForcePressDetails _sampleForcePress = ForcePressDetails(
  globalPosition: _kGlobalA,
  localPosition: _kLocalA,
  pressure: 0.72,
);

// PointerEnterEvent / PointerHoverEvent only accept `position`. Their
// `localPosition` is computed from the transform at hit-test time; in this
// static demo (no transform), it equals position.
const PointerEnterEvent _sampleEnter = PointerEnterEvent(
  position: Offset(140.0, 90.0),
  kind: PointerDeviceKind.mouse,
);

const PointerHoverEvent _sampleHover = PointerHoverEvent(
  position: Offset(160.0, 110.0),
  delta: Offset(20.0, 20.0),
  kind: PointerDeviceKind.mouse,
);

// ---------------------------------------------------------------------------
// Root widget. Required by the AST runner contract: returns a MaterialApp.
// ---------------------------------------------------------------------------

class GestureDetailsDemoApp extends StatelessWidget {
  const GestureDetailsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('GestureDetails Deep Demo executing');
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F51B5),
      brightness: Brightness.light,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: scheme),
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeaderBanner(scheme),
              const SizedBox(height: 28.0),
              _buildTaxonomyStrip(scheme),
              const SizedBox(height: 32.0),
              _buildSection2TapFamily(scheme),
              const SizedBox(height: 32.0),
              _buildSection3DragFamily(scheme),
              const SizedBox(height: 32.0),
              _buildSection4ScaleFamily(scheme),
              const SizedBox(height: 32.0),
              _buildSection5LongPressAndForce(scheme),
              const SizedBox(height: 32.0),
              _buildSection6HoverFamily(scheme),
              const SizedBox(height: 32.0),
              _buildSection7CallbackMappingTable(scheme),
              const SizedBox(height: 32.0),
              _buildSection8RecipesAndGlossary(scheme),
              const SizedBox(height: 24.0),
              _buildFooter(scheme),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 1: Header banner + small taxonomy strip
// ===========================================================================

Widget _buildHeaderBanner(ColorScheme scheme) {
  print('=== Section 1: Header Banner ===');
  return Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          scheme.primary,
          scheme.secondary,
          scheme.tertiary,
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: scheme.onPrimary.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.touch_app,
                  size: 40.0, color: scheme.onPrimary),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Gesture *Details Field Guide',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: scheme.onPrimary,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'TapDownDetails, DragUpdateDetails, ScaleEndDetails, '
                    'LongPressMoveUpdateDetails, ForcePressDetails, '
                    'PointerHoverEvent, and friends.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onPrimary.withValues(alpha: 0.85),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: scheme.onPrimary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.info_outline,
                  size: 14.0, color: scheme.onPrimary),
              const SizedBox(width: 6.0),
              Text(
                'Every Details object carries positions in BOTH global and '
                'local coordinates. Learn to read both.',
                style: TextStyle(
                  fontSize: 11.0,
                  color: scheme.onPrimary.withValues(alpha: 0.95),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTaxonomyStrip(ColorScheme scheme) {
  final List<_TaxonomyEntry> entries = <_TaxonomyEntry>[
    _TaxonomyEntry('Tap', Icons.touch_app, scheme.primaryContainer,
        scheme.onPrimaryContainer, '3 types'),
    _TaxonomyEntry('Drag', Icons.swipe, scheme.secondaryContainer,
        scheme.onSecondaryContainer, '3 types'),
    _TaxonomyEntry('Scale', Icons.zoom_out_map, scheme.tertiaryContainer,
        scheme.onTertiaryContainer, '3 types'),
    _TaxonomyEntry('LongPress', Icons.timer, scheme.primaryContainer,
        scheme.onPrimaryContainer, '3 types'),
    _TaxonomyEntry('Force', Icons.compress, scheme.errorContainer,
        scheme.onErrorContainer, '1 type'),
    _TaxonomyEntry('Hover', Icons.mouse, scheme.secondaryContainer,
        scheme.onSecondaryContainer, 'pointer'),
  ];
  return Wrap(
    spacing: 10.0,
    runSpacing: 10.0,
    alignment: WrapAlignment.center,
    children: entries
        .map<Widget>(
          (_TaxonomyEntry e) => Container(
            width: 110.0,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: e.bg,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: <Widget>[
                Icon(e.icon, color: e.fg, size: 30.0),
                const SizedBox(height: 6.0),
                Text(
                  e.label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: e.fg,
                      fontSize: 13.0),
                ),
                Text(e.subtitle,
                    style: TextStyle(
                        fontSize: 10.5,
                        color: e.fg.withValues(alpha: 0.75))),
              ],
            ),
          ),
        )
        .toList(),
  );
}

class _TaxonomyEntry {
  _TaxonomyEntry(this.label, this.icon, this.bg, this.fg, this.subtitle);
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;
  final String subtitle;
}

// ===========================================================================
// SECTION 2: Tap details family
// ===========================================================================

Widget _buildSection2TapFamily(ColorScheme scheme) {
  print('=== Section 2: Tap details family ===');
  print('TapDownDetails.globalPosition = ${_sampleTapDown.globalPosition}');
  print('TapDownDetails.localPosition  = ${_sampleTapDown.localPosition}');
  print('TapDownDetails.kind           = ${_sampleTapDown.kind}');
  print('TapUpDetails.kind             = ${_sampleTapUp.kind}');
  print('TapDragDownDetails.consecutiveTapCount '
      '= ${_sampleTapDragDown.consecutiveTapCount}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(scheme, '2', 'Tap details family',
          'Down, Up, and TapDragDown', Icons.touch_app),
      const SizedBox(height: 14.0),
      Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _detailsCard(
            scheme: scheme,
            accent: scheme.primary,
            container: scheme.primaryContainer,
            onContainer: scheme.onPrimaryContainer,
            title: 'TapDownDetails',
            subtitle: 'onTapDown',
            icon: Icons.south,
            rows: <_FieldRow>[
              _FieldRow('globalPosition', _sampleTapDown.globalPosition.toString()),
              _FieldRow('localPosition', _sampleTapDown.localPosition.toString()),
              _FieldRow('kind', _sampleTapDown.kind.toString()),
            ],
            diagram: _pointStage(
              scheme: scheme,
              dotGlobal: _sampleTapDown.globalPosition,
              dotLocal: _sampleTapDown.localPosition,
              accent: scheme.primary,
              caption: 'tap down',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.secondary,
            container: scheme.secondaryContainer,
            onContainer: scheme.onSecondaryContainer,
            title: 'TapUpDetails',
            subtitle: 'onTapUp',
            icon: Icons.north,
            rows: <_FieldRow>[
              _FieldRow('globalPosition', _sampleTapUp.globalPosition.toString()),
              _FieldRow('localPosition', _sampleTapUp.localPosition.toString()),
              _FieldRow('kind', _sampleTapUp.kind.toString()),
            ],
            diagram: _pointStage(
              scheme: scheme,
              dotGlobal: _sampleTapUp.globalPosition,
              dotLocal: _sampleTapUp.localPosition,
              accent: scheme.secondary,
              caption: 'tap up',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.tertiary,
            container: scheme.tertiaryContainer,
            onContainer: scheme.onTertiaryContainer,
            title: 'TapDragDownDetails',
            subtitle: 'onTapDown (drag combo)',
            icon: Icons.repeat,
            rows: <_FieldRow>[
              _FieldRow('globalPosition',
                  _sampleTapDragDown.globalPosition.toString()),
              _FieldRow(
                  'localPosition', _sampleTapDragDown.localPosition.toString()),
              _FieldRow('kind', _sampleTapDragDown.kind.toString()),
              _FieldRow('consecutiveTapCount',
                  _sampleTapDragDown.consecutiveTapCount.toString()),
            ],
            diagram: _pointStage(
              scheme: scheme,
              dotGlobal: _sampleTapDragDown.globalPosition,
              dotLocal: _sampleTapDragDown.localPosition,
              accent: scheme.tertiary,
              caption: 'tap #${_sampleTapDragDown.consecutiveTapCount}',
            ),
          ),
        ],
      ),
      const SizedBox(height: 14.0),
      _staticGestureDetectorPreview(
        scheme: scheme,
        label: 'GestureDetector(onTap: ..., onTapDown: ..., onTapUp: ...)',
        accent: scheme.primary,
      ),
    ],
  );
}

// ===========================================================================
// SECTION 3: Drag details family
// ===========================================================================

Widget _buildSection3DragFamily(ColorScheme scheme) {
  print('=== Section 3: Drag details family ===');
  print('DragStartDetails.globalPosition  = '
      '${_sampleDragStart.globalPosition}');
  print('DragUpdateDetails.delta          = ${_sampleDragUpdate.delta}');
  print('DragEndDetails.velocity          = ${_sampleDragEnd.velocity}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(scheme, '3', 'Drag details family',
          'Start, Update (delta), End (velocity)', Icons.swipe),
      const SizedBox(height: 14.0),
      Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _detailsCard(
            scheme: scheme,
            accent: scheme.primary,
            container: scheme.primaryContainer,
            onContainer: scheme.onPrimaryContainer,
            title: 'DragStartDetails',
            subtitle: 'onPanStart / onHorizontalDragStart',
            icon: Icons.first_page,
            rows: <_FieldRow>[
              _FieldRow('globalPosition',
                  _sampleDragStart.globalPosition.toString()),
              _FieldRow(
                  'localPosition', _sampleDragStart.localPosition.toString()),
              _FieldRow('sourceTimeStamp',
                  _sampleDragStart.sourceTimeStamp.toString()),
              _FieldRow('kind', _sampleDragStart.kind.toString()),
            ],
            diagram: _pointStage(
              scheme: scheme,
              dotGlobal: _sampleDragStart.globalPosition,
              dotLocal: _sampleDragStart.localPosition,
              accent: scheme.primary,
              caption: 'start',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.secondary,
            container: scheme.secondaryContainer,
            onContainer: scheme.onSecondaryContainer,
            title: 'DragUpdateDetails',
            subtitle: 'onPanUpdate',
            icon: Icons.linear_scale,
            rows: <_FieldRow>[
              _FieldRow('globalPosition',
                  _sampleDragUpdate.globalPosition.toString()),
              _FieldRow(
                  'localPosition', _sampleDragUpdate.localPosition.toString()),
              _FieldRow('delta', _sampleDragUpdate.delta.toString()),
              _FieldRow('primaryDelta',
                  _sampleDragUpdate.primaryDelta?.toString() ?? 'null'),
              _FieldRow('sourceTimeStamp',
                  _sampleDragUpdate.sourceTimeStamp.toString()),
            ],
            diagram: _vectorStage(
              scheme: scheme,
              from: _sampleDragStart.localPosition,
              to: _sampleDragUpdate.localPosition,
              accent: scheme.secondary,
              caption:
                  'delta ${_sampleDragUpdate.delta.dx.toStringAsFixed(0)},'
                  '${_sampleDragUpdate.delta.dy.toStringAsFixed(0)}',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.tertiary,
            container: scheme.tertiaryContainer,
            onContainer: scheme.onTertiaryContainer,
            title: 'DragEndDetails',
            subtitle: 'onPanEnd',
            icon: Icons.last_page,
            rows: <_FieldRow>[
              _FieldRow('velocity',
                  '${_sampleDragEnd.velocity.pixelsPerSecond.dx.toStringAsFixed(0)},'
                  '${_sampleDragEnd.velocity.pixelsPerSecond.dy.toStringAsFixed(0)} px/s'),
              _FieldRow('primaryVelocity',
                  _sampleDragEnd.primaryVelocity?.toString() ?? 'null'),
              _FieldRow('globalPosition',
                  _sampleDragEnd.globalPosition.toString()),
              _FieldRow(
                  'localPosition', _sampleDragEnd.localPosition.toString()),
            ],
            diagram: _vectorStage(
              scheme: scheme,
              from: _sampleDragEnd.localPosition,
              to: _sampleDragEnd.localPosition +
                  _sampleDragEnd.velocity.pixelsPerSecond / 6.0,
              accent: scheme.tertiary,
              caption: 'fling',
            ),
          ),
        ],
      ),
      const SizedBox(height: 14.0),
      _staticGestureDetectorPreview(
        scheme: scheme,
        label: 'GestureDetector(onPanStart/onPanUpdate/onPanEnd: ...)',
        accent: scheme.secondary,
      ),
    ],
  );
}

// ===========================================================================
// SECTION 4: Scale details family
// ===========================================================================

Widget _buildSection4ScaleFamily(ColorScheme scheme) {
  print('=== Section 4: Scale details family ===');
  print('ScaleStartDetails.focalPoint   = ${_sampleScaleStart.focalPoint}');
  print('ScaleUpdateDetails.scale       = ${_sampleScaleUpdate.scale}');
  print('ScaleUpdateDetails.rotation    = ${_sampleScaleUpdate.rotation}');
  print('ScaleEndDetails.scaleVelocity  = ${_sampleScaleEnd.scaleVelocity}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(scheme, '4', 'Scale details family',
          'pinch, zoom, rotate (multi-touch)', Icons.zoom_out_map),
      const SizedBox(height: 14.0),
      Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _detailsCard(
            scheme: scheme,
            accent: scheme.primary,
            container: scheme.primaryContainer,
            onContainer: scheme.onPrimaryContainer,
            title: 'ScaleStartDetails',
            subtitle: 'onScaleStart',
            icon: Icons.center_focus_weak,
            rows: <_FieldRow>[
              _FieldRow('focalPoint',
                  _sampleScaleStart.focalPoint.toString()),
              _FieldRow('localFocalPoint',
                  _sampleScaleStart.localFocalPoint.toString()),
              _FieldRow('pointerCount',
                  _sampleScaleStart.pointerCount.toString()),
            ],
            diagram: _focalStage(
              scheme: scheme,
              focal: _sampleScaleStart.localFocalPoint,
              accent: scheme.primary,
              radius: 30.0,
              caption: '2 fingers',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.secondary,
            container: scheme.secondaryContainer,
            onContainer: scheme.onSecondaryContainer,
            title: 'ScaleUpdateDetails',
            subtitle: 'onScaleUpdate',
            icon: Icons.zoom_in,
            rows: <_FieldRow>[
              _FieldRow(
                  'focalPoint', _sampleScaleUpdate.focalPoint.toString()),
              _FieldRow('scale',
                  _sampleScaleUpdate.scale.toStringAsFixed(2)),
              _FieldRow('horizontalScale',
                  _sampleScaleUpdate.horizontalScale.toStringAsFixed(2)),
              _FieldRow('verticalScale',
                  _sampleScaleUpdate.verticalScale.toStringAsFixed(2)),
              _FieldRow('rotation (rad)',
                  _sampleScaleUpdate.rotation.toStringAsFixed(2)),
              _FieldRow('pointerCount',
                  _sampleScaleUpdate.pointerCount.toString()),
            ],
            diagram: _scaleRotateStage(
              scheme: scheme,
              focal: _sampleScaleUpdate.localFocalPoint,
              scale: _sampleScaleUpdate.scale,
              rotation: _sampleScaleUpdate.rotation,
              accent: scheme.secondary,
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.tertiary,
            container: scheme.tertiaryContainer,
            onContainer: scheme.onTertiaryContainer,
            title: 'ScaleEndDetails',
            subtitle: 'onScaleEnd',
            icon: Icons.zoom_out,
            rows: <_FieldRow>[
              _FieldRow(
                  'velocity',
                  '${_sampleScaleEnd.velocity.pixelsPerSecond.dx.toStringAsFixed(0)},'
                  '${_sampleScaleEnd.velocity.pixelsPerSecond.dy.toStringAsFixed(0)} px/s'),
              _FieldRow('scaleVelocity',
                  _sampleScaleEnd.scaleVelocity.toStringAsFixed(2)),
              _FieldRow(
                  'pointerCount', _sampleScaleEnd.pointerCount.toString()),
            ],
            diagram: _focalStage(
              scheme: scheme,
              focal: const Offset(100.0, 100.0),
              accent: scheme.tertiary,
              radius: 18.0,
              caption: 'release',
            ),
          ),
        ],
      ),
    ],
  );
}

// ===========================================================================
// SECTION 5: Long-press + force-press details
// ===========================================================================

Widget _buildSection5LongPressAndForce(ColorScheme scheme) {
  print('=== Section 5: Long-press + force-press details ===');
  print('LongPressStartDetails.globalPosition '
      '= ${_sampleLongPressStart.globalPosition}');
  print('LongPressMoveUpdateDetails.offsetFromOrigin '
      '= ${_sampleLongPressMove.offsetFromOrigin}');
  print('LongPressEndDetails.velocity = '
      '${_sampleLongPressEnd.velocity}');
  print('ForcePressDetails.pressure = ${_sampleForcePress.pressure}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(scheme, '5', 'LongPress and ForcePress',
          'time- and pressure-sensitive details', Icons.timer),
      const SizedBox(height: 14.0),
      Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _detailsCard(
            scheme: scheme,
            accent: scheme.primary,
            container: scheme.primaryContainer,
            onContainer: scheme.onPrimaryContainer,
            title: 'LongPressStartDetails',
            subtitle: 'onLongPressStart',
            icon: Icons.timer,
            rows: <_FieldRow>[
              _FieldRow('globalPosition',
                  _sampleLongPressStart.globalPosition.toString()),
              _FieldRow('localPosition',
                  _sampleLongPressStart.localPosition.toString()),
            ],
            diagram: _pointStage(
              scheme: scheme,
              dotGlobal: _sampleLongPressStart.globalPosition,
              dotLocal: _sampleLongPressStart.localPosition,
              accent: scheme.primary,
              caption: 'origin',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.secondary,
            container: scheme.secondaryContainer,
            onContainer: scheme.onSecondaryContainer,
            title: 'LongPressMoveUpdateDetails',
            subtitle: 'onLongPressMoveUpdate',
            icon: Icons.open_with,
            rows: <_FieldRow>[
              _FieldRow('globalPosition',
                  _sampleLongPressMove.globalPosition.toString()),
              _FieldRow('localPosition',
                  _sampleLongPressMove.localPosition.toString()),
              _FieldRow('offsetFromOrigin',
                  _sampleLongPressMove.offsetFromOrigin.toString()),
              _FieldRow('localOffsetFromOrigin',
                  _sampleLongPressMove.localOffsetFromOrigin.toString()),
            ],
            diagram: _vectorStage(
              scheme: scheme,
              from: _sampleLongPressStart.localPosition,
              to: _sampleLongPressMove.localPosition,
              accent: scheme.secondary,
              caption: 'drift',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.tertiary,
            container: scheme.tertiaryContainer,
            onContainer: scheme.onTertiaryContainer,
            title: 'LongPressEndDetails',
            subtitle: 'onLongPressEnd',
            icon: Icons.timer_off,
            rows: <_FieldRow>[
              _FieldRow('globalPosition',
                  _sampleLongPressEnd.globalPosition.toString()),
              _FieldRow('localPosition',
                  _sampleLongPressEnd.localPosition.toString()),
              _FieldRow('velocity',
                  '${_sampleLongPressEnd.velocity.pixelsPerSecond.dx.toStringAsFixed(0)},'
                  '${_sampleLongPressEnd.velocity.pixelsPerSecond.dy.toStringAsFixed(0)} px/s'),
            ],
            diagram: _pointStage(
              scheme: scheme,
              dotGlobal: _sampleLongPressEnd.globalPosition,
              dotLocal: _sampleLongPressEnd.localPosition,
              accent: scheme.tertiary,
              caption: 'release',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.error,
            container: scheme.errorContainer,
            onContainer: scheme.onErrorContainer,
            title: 'ForcePressDetails',
            subtitle: 'onForcePressStart / Peak / End / Update',
            icon: Icons.compress,
            rows: <_FieldRow>[
              _FieldRow('globalPosition',
                  _sampleForcePress.globalPosition.toString()),
              _FieldRow('localPosition',
                  _sampleForcePress.localPosition.toString()),
              _FieldRow('pressure (0.0..1.0)',
                  _sampleForcePress.pressure.toStringAsFixed(2)),
            ],
            diagram: _pressureStage(
              scheme: scheme,
              local: _sampleForcePress.localPosition,
              pressure: _sampleForcePress.pressure,
              accent: scheme.error,
            ),
          ),
        ],
      ),
    ],
  );
}

// ===========================================================================
// SECTION 6: Hover / pointer event details
// ===========================================================================

Widget _buildSection6HoverFamily(ColorScheme scheme) {
  print('=== Section 6: Hover / pointer event details ===');
  print('PointerEnterEvent.position = ${_sampleEnter.position}');
  print('PointerHoverEvent.delta    = ${_sampleHover.delta}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(scheme, '6', 'Hover and Pointer events',
          'MouseRegion sees these, not GestureDetector', Icons.mouse),
      const SizedBox(height: 14.0),
      Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _detailsCard(
            scheme: scheme,
            accent: scheme.primary,
            container: scheme.primaryContainer,
            onContainer: scheme.onPrimaryContainer,
            title: 'PointerEnterEvent',
            subtitle: 'MouseRegion.onEnter',
            icon: Icons.login,
            rows: <_FieldRow>[
              _FieldRow('position', _sampleEnter.position.toString()),
              _FieldRow('localPosition',
                  _sampleEnter.localPosition.toString()),
              _FieldRow('kind', _sampleEnter.kind.toString()),
            ],
            diagram: _pointStage(
              scheme: scheme,
              dotGlobal: _sampleEnter.position,
              dotLocal: _sampleEnter.localPosition,
              accent: scheme.primary,
              caption: 'enter',
            ),
          ),
          _detailsCard(
            scheme: scheme,
            accent: scheme.secondary,
            container: scheme.secondaryContainer,
            onContainer: scheme.onSecondaryContainer,
            title: 'PointerHoverEvent',
            subtitle: 'MouseRegion.onHover',
            icon: Icons.adjust,
            rows: <_FieldRow>[
              _FieldRow('position', _sampleHover.position.toString()),
              _FieldRow('localPosition',
                  _sampleHover.localPosition.toString()),
              _FieldRow('delta', _sampleHover.delta.toString()),
              _FieldRow('kind', _sampleHover.kind.toString()),
            ],
            diagram: _vectorStage(
              scheme: scheme,
              from: _sampleHover.localPosition - _sampleHover.delta,
              to: _sampleHover.localPosition,
              accent: scheme.secondary,
              caption: 'hover',
            ),
          ),
        ],
      ),
      const SizedBox(height: 14.0),
      Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.lightbulb, color: scheme.tertiary, size: 22.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'Hover events come from MouseRegion. They do NOT flow through '
                'GestureDetector. For pen / stylus hover, also check '
                'PointerHoverEvent.kind == PointerDeviceKind.stylus.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: scheme.onSurface,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 7: Callback -> Details mapping table
// ===========================================================================

Widget _buildSection7CallbackMappingTable(ColorScheme scheme) {
  print('=== Section 7: GestureDetector callback mapping table ===');
  final List<_MappingRow> rows = <_MappingRow>[
    _MappingRow(
        'onTapDown', 'TapDownDetails', 'finger or pointer pressed'),
    _MappingRow('onTapUp', 'TapUpDetails', 'finger or pointer released'),
    _MappingRow(
        'onSecondaryTapDown', 'TapDownDetails', 'right-button press'),
    _MappingRow('onPanStart', 'DragStartDetails', 'free-direction drag begin'),
    _MappingRow(
        'onPanUpdate', 'DragUpdateDetails', 'incremental drag motion'),
    _MappingRow('onPanEnd', 'DragEndDetails', 'drag ended with velocity'),
    _MappingRow('onHorizontalDragStart', 'DragStartDetails',
        'horizontal-only drag begin'),
    _MappingRow('onHorizontalDragUpdate', 'DragUpdateDetails',
        'has primaryDelta (dx)'),
    _MappingRow('onHorizontalDragEnd', 'DragEndDetails',
        'has primaryVelocity (dx)'),
    _MappingRow(
        'onVerticalDragStart', 'DragStartDetails', 'vertical-only begin'),
    _MappingRow('onVerticalDragUpdate', 'DragUpdateDetails',
        'has primaryDelta (dy)'),
    _MappingRow('onVerticalDragEnd', 'DragEndDetails',
        'has primaryVelocity (dy)'),
    _MappingRow('onScaleStart', 'ScaleStartDetails',
        'multi-pointer focal anchored'),
    _MappingRow('onScaleUpdate', 'ScaleUpdateDetails',
        'scale + rotation + focalPoint'),
    _MappingRow(
        'onScaleEnd', 'ScaleEndDetails', 'inertia for scale + pan'),
    _MappingRow('onLongPressStart', 'LongPressStartDetails',
        'after threshold timer fires'),
    _MappingRow('onLongPressMoveUpdate', 'LongPressMoveUpdateDetails',
        'finger moves while pressed'),
    _MappingRow('onLongPressEnd', 'LongPressEndDetails',
        'release after long press'),
    _MappingRow('onForcePressStart', 'ForcePressDetails',
        'pressure crosses startPressure'),
    _MappingRow('onForcePressPeak', 'ForcePressDetails',
        'pressure crosses peakPressure'),
    _MappingRow('onForcePressUpdate', 'ForcePressDetails',
        'pressure continues to change'),
    _MappingRow(
        'onForcePressEnd', 'ForcePressDetails', 'pressure released'),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(scheme, '7', 'Callback -> Details mapping',
          'which callback gets which type', Icons.table_chart),
      const SizedBox(height: 14.0),
      Container(
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text('Callback',
                        style: TextStyle(
                            color: scheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Details type',
                        style: TextStyle(
                            color: scheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text('What happened',
                        style: TextStyle(
                            color: scheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5)),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < rows.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 8.0),
                color: i.isEven
                    ? scheme.surface
                    : scheme.surfaceContainerHighest,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        rows[i].callback,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        rows[i].detailsType,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          color: scheme.tertiary,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        rows[i].description,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: 14.0),
      _comparisonTable(scheme),
    ],
  );
}

class _MappingRow {
  _MappingRow(this.callback, this.detailsType, this.description);
  final String callback;
  final String detailsType;
  final String description;
}

Widget _comparisonTable(ColorScheme scheme) {
  // Cross-cutting comparison: which fields do these Details share?
  final List<List<String>> grid = <List<String>>[
    <String>['Type', 'global', 'local', 'velocity', 'delta', 'extra'],
    <String>['TapDownDetails', 'yes', 'yes', '-', '-', 'kind'],
    <String>['TapUpDetails', 'yes', 'yes', '-', '-', 'kind'],
    <String>['DragStartDetails', 'yes', 'yes', '-', '-', 'sourceTimeStamp'],
    <String>['DragUpdateDetails', 'yes', 'yes', '-', 'yes', 'primaryDelta'],
    <String>['DragEndDetails', 'yes', 'yes', 'yes', '-', 'primaryVelocity'],
    <String>['ScaleUpdateDetails', '-', '-', '-', '-', 'scale/rotation'],
    <String>[
      'LongPressMoveUpdateDetails',
      'yes',
      'yes',
      '-',
      '-',
      'offsetFromOrigin'
    ],
    <String>['ForcePressDetails', 'yes', 'yes', '-', '-', 'pressure'],
  ];
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: scheme.outlineVariant),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Field-coverage comparison',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
                fontSize: 13.0)),
        const SizedBox(height: 8.0),
        for (int r = 0; r < grid.length; r++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: <Widget>[
                for (int c = 0; c < grid[r].length; c++)
                  Expanded(
                    flex: c == 0 ? 4 : 2,
                    child: Text(
                      grid[r][c],
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        fontWeight:
                            r == 0 ? FontWeight.bold : FontWeight.normal,
                        color: r == 0
                            ? scheme.primary
                            : (grid[r][c] == 'yes'
                                ? scheme.tertiary
                                : scheme.onSurface),
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

// ===========================================================================
// SECTION 8: Recipes + glossary
// ===========================================================================

Widget _buildSection8RecipesAndGlossary(ColorScheme scheme) {
  print('=== Section 8: Recipes and glossary ===');
  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      'Get tap position in local coordinates',
      'GestureDetector(\n'
          '  onTapDown: (TapDownDetails d) {\n'
          '    final Offset p = d.localPosition;\n'
          '    // use p for hit-testing inside the child\n'
          '  },\n'
          ')',
    ),
    _Recipe(
      'Track drag delta in a State',
      'GestureDetector(\n'
          '  onPanUpdate: (DragUpdateDetails d) {\n'
          '    setState(() => offset += d.delta);\n'
          '  },\n'
          ')',
    ),
    _Recipe(
      'Read inertia from a fling',
      'onPanEnd: (DragEndDetails d) {\n'
          '  final v = d.velocity.pixelsPerSecond;\n'
          '  // start a SpringSimulation with v\n'
          '}',
    ),
    _Recipe(
      'Pinch + rotate around the focal point',
      'onScaleUpdate: (ScaleUpdateDetails d) {\n'
          '  setState(() {\n'
          '    scale = baseScale * d.scale;\n'
          '    rotation = baseRotation + d.rotation;\n'
          '  });\n'
          '}',
    ),
    _Recipe(
      'Snap a context menu near the long-press origin',
      'onLongPressStart: (LongPressStartDetails d) {\n'
          '  showMenu(position: RelativeRect.fromLTRB(\n'
          '      d.globalPosition.dx, d.globalPosition.dy,\n'
          '      d.globalPosition.dx, d.globalPosition.dy));\n'
          '}',
    ),
    _Recipe(
      'React to 3D Touch pressure',
      'onForcePressUpdate: (ForcePressDetails d) {\n'
          '  // d.pressure is 0.0 .. 1.0 normalized\n'
          '  blur = d.pressure * 20.0;\n'
          '}',
    ),
  ];

  final List<_GlossaryItem> glossary = <_GlossaryItem>[
    _GlossaryItem('globalPosition',
        'Offset relative to the screen origin (top-left of the device).'),
    _GlossaryItem('localPosition',
        'Offset relative to the receiving render object origin.'),
    _GlossaryItem('delta',
        'For DragUpdateDetails: incremental movement since last update.'),
    _GlossaryItem('primaryDelta / primaryVelocity',
        'The dx or dy component for axis-locked drags; null for pan.'),
    _GlossaryItem('Velocity',
        'A wrapper around pixelsPerSecond Offset and a clamp method.'),
    _GlossaryItem(
        'focalPoint', 'Geometric center of all active pointers in a scale.'),
    _GlossaryItem('scale / horizontalScale / verticalScale',
        'Cumulative pinch ratios since the gesture started.'),
    _GlossaryItem('rotation',
        'Angle change in radians around the focal point.'),
    _GlossaryItem('offsetFromOrigin',
        'Movement vector since the long-press started.'),
    _GlossaryItem('pressure',
        'Normalized force from 0.0 to 1.0 on supported hardware.'),
    _GlossaryItem('PointerDeviceKind',
        'touch, mouse, stylus, invertedStylus, trackpad, unknown.'),
    _GlossaryItem('sourceTimeStamp',
        'Origin event timestamp - useful for synchronizing animations.'),
    _GlossaryItem('consecutiveTapCount',
        'On TapDragDownDetails: 1 = single, 2 = double, 3 = triple ...'),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionTitle(scheme, '8', 'Recipes and glossary',
          'common patterns + vocabulary', Icons.menu_book),
      const SizedBox(height: 14.0),
      // Recipes
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.restaurant_menu,
                    size: 18.0, color: scheme.primary),
                const SizedBox(width: 6.0),
                Text('Recipe cookbook',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: scheme.onSurface)),
              ],
            ),
            const SizedBox(height: 12.0),
            for (final _Recipe r in recipes)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(r.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: scheme.primary,
                            fontSize: 13.0)),
                    const SizedBox(height: 4.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Text(
                        r.code,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          color: scheme.onSurface,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: 18.0),
      // Glossary
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: scheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.book,
                    size: 18.0, color: scheme.onTertiaryContainer),
                const SizedBox(width: 6.0),
                Text('Glossary',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: scheme.onTertiaryContainer)),
              ],
            ),
            const SizedBox(height: 10.0),
            for (final _GlossaryItem g in glossary)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: scheme.onTertiaryContainer,
                      height: 1.4,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${g.term}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: g.definition),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class _Recipe {
  _Recipe(this.title, this.code);
  final String title;
  final String code;
}

class _GlossaryItem {
  _GlossaryItem(this.term, this.definition);
  final String term;
  final String definition;
}

// ===========================================================================
// Footer
// ===========================================================================

Widget _buildFooter(ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[scheme.tertiary, scheme.primary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.check_circle,
            color: scheme.onPrimary, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'Gesture *Details Deep Demo complete. '
            'Constructed 14 synthetic Details/Event instances, rendered '
            '8 numbered sections, 22 callback mappings, and a 13-term glossary.',
            style: TextStyle(
              color: scheme.onPrimary,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// Shared visual helpers
// ===========================================================================

class _FieldRow {
  _FieldRow(this.label, this.value);
  final String label;
  final String value;
}

Widget _sectionTitle(ColorScheme scheme, String number, String title,
    String subtitle, IconData icon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: scheme.primary,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: TextStyle(
            color: scheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: scheme.primary, size: 20.0),
                const SizedBox(width: 6.0),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _detailsCard({
  required ColorScheme scheme,
  required Color accent,
  required Color container,
  required Color onContainer,
  required String title,
  required String subtitle,
  required IconData icon,
  required List<_FieldRow> rows,
  required Widget diagram,
}) {
  return Container(
    width: 320.0,
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: scheme.outlineVariant),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // header
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: container,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accent, size: 18.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          color: onContainer,
                          fontSize: 13.5,
                        )),
                    Text(subtitle,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: onContainer.withValues(alpha: 0.75),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        // fields
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final _FieldRow r in rows)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 130.0,
                        child: Text(
                          r.label,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          r.value,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        // diagram
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
          child: diagram,
        ),
      ],
    ),
  );
}

// 200x200 stage with a primary "local" dot at the local position and a
// secondary mini "global" inset showing the screen-space marker.
Widget _pointStage({
  required ColorScheme scheme,
  required Offset dotGlobal,
  required Offset dotLocal,
  required Color accent,
  required String caption,
}) {
  return _stageFrame(
    scheme: scheme,
    child: Stack(
      children: <Widget>[
        Positioned.fill(child: _gridOverlay(scheme)),
        Positioned(
          left: dotLocal.dx.clamp(0.0, 190.0),
          top: dotLocal.dy.clamp(0.0, 190.0),
          child: Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withValues(alpha: 0.4),
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 6.0,
          top: 6.0,
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: (dotGlobal.dx / 360.0 * 56.0).clamp(0.0, 54.0),
                  top: (dotGlobal.dy / 240.0 * 56.0).clamp(0.0, 54.0),
                  child: Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: scheme.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 2.0,
                  bottom: 1.0,
                  child: Text(
                    'global',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 6.0,
          bottom: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              caption,
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _vectorStage({
  required ColorScheme scheme,
  required Offset from,
  required Offset to,
  required Color accent,
  required String caption,
}) {
  return _stageFrame(
    scheme: scheme,
    child: Stack(
      children: <Widget>[
        Positioned.fill(child: _gridOverlay(scheme)),
        Positioned.fill(
          child: CustomPaint(
            painter: _ArrowPainter(
              from: Offset(from.dx.clamp(0.0, 200.0),
                  from.dy.clamp(0.0, 200.0)),
              to: Offset(
                  to.dx.clamp(0.0, 200.0), to.dy.clamp(0.0, 200.0)),
              color: accent,
            ),
          ),
        ),
        Positioned(
          left: 6.0,
          bottom: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              caption,
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _focalStage({
  required ColorScheme scheme,
  required Offset focal,
  required Color accent,
  required double radius,
  required String caption,
}) {
  return _stageFrame(
    scheme: scheme,
    child: Stack(
      children: <Widget>[
        Positioned.fill(child: _gridOverlay(scheme)),
        Positioned(
          left: focal.dx.clamp(0.0, 200.0) - radius,
          top: focal.dy.clamp(0.0, 200.0) - radius,
          child: Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 2.0),
              color: accent.withValues(alpha: 0.12),
            ),
          ),
        ),
        Positioned(
          left: focal.dx.clamp(0.0, 200.0) - radius - 4.0,
          top: focal.dy.clamp(0.0, 200.0) - 4.0,
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration:
                BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          left: focal.dx.clamp(0.0, 200.0) + radius - 6.0,
          top: focal.dy.clamp(0.0, 200.0) - 4.0,
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration:
                BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          left: focal.dx.clamp(0.0, 200.0) - 3.0,
          top: focal.dy.clamp(0.0, 200.0) - 3.0,
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: scheme.onSurface,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: 6.0,
          bottom: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              caption,
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _scaleRotateStage({
  required ColorScheme scheme,
  required Offset focal,
  required double scale,
  required double rotation,
  required Color accent,
}) {
  return _stageFrame(
    scheme: scheme,
    child: Stack(
      children: <Widget>[
        Positioned.fill(child: _gridOverlay(scheme)),
        Positioned.fill(
          child: Center(
            child: Transform.rotate(
              angle: rotation,
              child: Transform.scale(
                scale: scale.clamp(0.4, 2.0),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.25),
                    border: Border.all(color: accent, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Icon(Icons.crop_square,
                        color: accent, size: 24.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: focal.dx.clamp(0.0, 200.0) - 3.0,
          top: focal.dy.clamp(0.0, 200.0) - 3.0,
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: scheme.onSurface,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: 6.0,
          bottom: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'x${scale.toStringAsFixed(2)}  '
              'rot=${rotation.toStringAsFixed(2)}',
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pressureStage({
  required ColorScheme scheme,
  required Offset local,
  required double pressure,
  required Color accent,
}) {
  return _stageFrame(
    scheme: scheme,
    child: Stack(
      children: <Widget>[
        Positioned.fill(child: _gridOverlay(scheme)),
        for (int i = 0; i < 4; i++)
          Positioned(
            left:
                local.dx.clamp(0.0, 200.0) - (10.0 + i * 8.0 * pressure),
            top: local.dy.clamp(0.0, 200.0) -
                (10.0 + i * 8.0 * pressure),
            child: Container(
              width: 20.0 + i * 16.0 * pressure,
              height: 20.0 + i * 16.0 * pressure,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      accent.withValues(alpha: 0.55 - i * 0.12),
                  width: 1.5,
                ),
              ),
            ),
          ),
        Positioned(
          left: local.dx.clamp(0.0, 200.0) - 6.0,
          top: local.dy.clamp(0.0, 200.0) - 6.0,
          child: Container(
            width: 12.0,
            height: 12.0,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: 6.0,
          bottom: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'p=${pressure.toStringAsFixed(2)}',
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _stageFrame({required ColorScheme scheme, required Widget child}) {
  return Container(
    width: 200.0,
    height: 200.0,
    decoration: BoxDecoration(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: scheme.outlineVariant),
    ),
    clipBehavior: Clip.hardEdge,
    child: child,
  );
}

Widget _gridOverlay(ColorScheme scheme) {
  return CustomPaint(
    painter: _GridPainter(scheme.outlineVariant.withValues(alpha: 0.5)),
  );
}

Widget _staticGestureDetectorPreview({
  required ColorScheme scheme,
  required String label,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: scheme.outlineVariant),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.code, color: accent, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: scheme.onSurface,
            ),
          ),
        ),
        // Render a real GestureDetector visually. Its callbacks intentionally
        // do nothing in this static AST execution context.
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'tap me',
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// Painters
// ===========================================================================

class _GridPainter extends CustomPainter {
  _GridPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 0.6;
    const double step = 20.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) => old.color != color;
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter(
      {required this.from, required this.to, required this.color});
  final Offset from;
  final Offset to;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(from, to, p);

    final Paint dot = Paint()..color = color;
    canvas.drawCircle(from, 5.0, dot);

    final double dx = to.dx - from.dx;
    final double dy = to.dy - from.dy;
    final double len2 = dx * dx + dy * dy;
    if (len2 < 0.001) return;
    final double inv = 1.0 / _approxSqrt(len2);
    final double ux = dx * inv;
    final double uy = dy * inv;
    final double px = -uy;
    final double py = ux;
    const double headSize = 10.0;
    final Offset h1 = Offset(
      to.dx - ux * headSize + px * headSize * 0.5,
      to.dy - uy * headSize + py * headSize * 0.5,
    );
    final Offset h2 = Offset(
      to.dx - ux * headSize - px * headSize * 0.5,
      to.dy - uy * headSize - py * headSize * 0.5,
    );
    final Path path = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(h1.dx, h1.dy)
      ..lineTo(h2.dx, h2.dy)
      ..close();
    canvas.drawPath(path, dot);
  }

  // Newton iteration sqrt; avoids pulling in dart:math at the top of the file.
  double _approxSqrt(double v) {
    if (v <= 0) return 0;
    double r = v;
    for (int i = 0; i < 12; i++) {
      r = 0.5 * (r + v / r);
    }
    return r;
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter old) =>
      old.from != from || old.to != to || old.color != color;
}

// ===========================================================================
// Entry point
// ===========================================================================

void main() => runApp(const GestureDetailsDemoApp());
