// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: DisplayFeature, DisplayFeatureType,
// DisplayFeatureState, and DisplayFeatureSubScreen — covering Flutter's
// foldable / hinged display abstractions exposed through dart:ui.
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('DisplayFeature visual demo executing');

  // ============================================================
  // PALETTE — slate / amber / teal foldable hardware aesthetic
  // ============================================================
  const Color paletteSurface = Color(0xFF101521);
  const Color paletteCard = Color(0xFF1A2030);
  const Color paletteCardAlt = Color(0xFF202738);
  const Color palettePanel = Color(0xFF2A3346);
  const Color paletteBorder = Color(0xFF3B475F);
  const Color paletteText = Color(0xFFE7ECF4);
  const Color paletteMuted = Color(0xFF8893AB);
  const Color paletteAccent = Color(0xFFF5B642);
  const Color paletteAccentSoft = Color(0xFFFFD37A);
  const Color paletteFold = Color(0xFF4DD0C9);
  const Color paletteHinge = Color(0xFFE05A66);
  const Color paletteCutout = Color(0xFF8C7AE6);
  const Color paletteUnknown = Color(0xFF6B778C);
  const Color paletteScreen = Color(0xFF0A0F19);
  const Color paletteOk = Color(0xFF6FCF97);
  const Color paletteWarn = Color(0xFFF5A623);
  const Color paletteErr = Color(0xFFEB5757);

  // ============================================================
  // TYPE & STATE ENUM ENUMERATION
  // ============================================================
  print('--- DisplayFeatureType.values ---');
  final List<ui.DisplayFeatureType> typeValues = ui.DisplayFeatureType.values;
  for (int i = 0; i < typeValues.length; i++) {
    print('  type[$i] = ${typeValues[i].name}');
  }

  print('--- DisplayFeatureState.values ---');
  final List<ui.DisplayFeatureState> stateValues = ui.DisplayFeatureState.values;
  for (int i = 0; i < stateValues.length; i++) {
    print('  state[$i] = ${stateValues[i].name}');
  }

  // ============================================================
  // SAMPLE DISPLAYFEATURE INSTANCES (wrapped in try/catch)
  // ============================================================
  ui.DisplayFeature? foldFeature;
  ui.DisplayFeature? hingeFeature;
  ui.DisplayFeature? cutoutFeature;
  try {
    foldFeature = ui.DisplayFeature(
      bounds: const Rect.fromLTWH(0, 380, 800, 8),
      type: ui.DisplayFeatureType.fold,
      state: ui.DisplayFeatureState.postureFlat,
    );
    print('Fold feature: ${foldFeature.bounds} type=${foldFeature.type.name}');
  } catch (e) {
    print('Fold construction failed: $e');
  }
  try {
    hingeFeature = ui.DisplayFeature(
      bounds: const Rect.fromLTWH(390, 0, 20, 800),
      type: ui.DisplayFeatureType.hinge,
      state: ui.DisplayFeatureState.postureHalfOpened,
    );
    print('Hinge feature: ${hingeFeature.bounds} type=${hingeFeature.type.name}');
  } catch (e) {
    print('Hinge construction failed: $e');
  }
  try {
    cutoutFeature = ui.DisplayFeature(
      bounds: const Rect.fromLTWH(180, 12, 36, 24),
      type: ui.DisplayFeatureType.cutout,
      state: ui.DisplayFeatureState.unknown,
    );
    print('Cutout feature: ${cutoutFeature.bounds}');
  } catch (e) {
    print('Cutout construction failed: $e');
  }

  // ============================================================
  // SAMPLE SUBSCREEN — wrapped due to runtime bridging quirks
  // ============================================================
  Widget sampleSubScreen;
  try {
    sampleSubScreen = DisplayFeatureSubScreen(
      anchorPoint: const Offset(40, 40),
      child: const Text(
        'Anchored sub-screen',
        style: TextStyle(color: paletteText),
      ),
    );
    print('DisplayFeatureSubScreen built with anchorPoint(40,40)');
  } catch (e) {
    print('DisplayFeatureSubScreen build failed: $e');
    sampleSubScreen = const Text('SubScreen unavailable');
  }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================
  Widget chip(String label, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        border: Border.all(color: color.withValues(alpha: 0.55)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget sectionTitle(String number, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 28, 16, 12),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            paletteCard,
            paletteCardAlt.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: paletteBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: paletteAccent.withValues(alpha: 0.22),
              border: Border.all(color: paletteAccent),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: paletteAccentSoft,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: paletteText,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: paletteMuted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget card(Widget contents) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: paletteCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: paletteBorder),
      ),
      child: contents,
    );
  }

  Widget kv(String key, String value, Color tone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 138,
            child: Text(
              key,
              style: const TextStyle(color: paletteMuted, fontSize: 11),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: tone,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget codeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paletteScreen,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: paletteBorder),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: paletteAccentSoft,
          fontSize: 11,
          fontFamily: 'monospace',
          height: 1.5,
        ),
      ),
    );
  }

  Color colorForType(ui.DisplayFeatureType t) {
    if (t == ui.DisplayFeatureType.fold) return paletteFold;
    if (t == ui.DisplayFeatureType.hinge) return paletteHinge;
    if (t == ui.DisplayFeatureType.cutout) return paletteCutout;
    return paletteUnknown;
  }

  String descriptionForType(ui.DisplayFeatureType t) {
    if (t == ui.DisplayFeatureType.fold) {
      return 'A flexible crease where the screen can bend; both sides remain visible and continuous.';
    }
    if (t == ui.DisplayFeatureType.hinge) {
      return 'A physical hinge separating two distinct displays; content cannot cross it.';
    }
    if (t == ui.DisplayFeatureType.cutout) {
      return 'A small region carved out of the display (camera, sensor); content beneath is occluded.';
    }
    return 'Type not recognised by the framework — treat conservatively, avoid placing key UI here.';
  }

  String descriptionForState(ui.DisplayFeatureState s) {
    if (s == ui.DisplayFeatureState.postureFlat) {
      return 'Device opened flat (≈180°). The two halves form one continuous surface.';
    }
    if (s == ui.DisplayFeatureState.postureHalfOpened) {
      return 'Device half-opened (≈90°). Useful for laptop-style or tabletop modes.';
    }
    return 'State not provided by the platform — assume flat and let the user adjust.';
  }

  // ============================================================
  // HERO HEADER
  // ============================================================
  final Widget hero = Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          paletteAccent.withValues(alpha: 0.35),
          paletteFold.withValues(alpha: 0.18),
          paletteCard,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: paletteAccent.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: paletteAccent.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: paletteAccent),
              ),
              child: const Text(
                'dart:ui · widgets',
                style: TextStyle(
                  color: paletteAccentSoft,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            chip('foldables', paletteFold),
            chip('hinges', paletteHinge),
            chip('cutouts', paletteCutout),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'DisplayFeature & DisplayFeatureSubScreen',
          style: TextStyle(
            color: paletteText,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Foldable and hinged display support: layout helpers that route '
          'content around physical screen discontinuities so apps survive '
          'on Surface Duo, Galaxy Fold, and devices with notches.',
          style: TextStyle(color: paletteMuted, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paletteSurface.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Types',
                      style: TextStyle(color: paletteMuted, fontSize: 10),
                    ),
                    Text(
                      '${typeValues.length}',
                      style: const TextStyle(
                        color: paletteFold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paletteSurface.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'States',
                      style: TextStyle(color: paletteMuted, fontSize: 10),
                    ),
                    Text(
                      '${stateValues.length}',
                      style: const TextStyle(
                        color: paletteHinge,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paletteSurface.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Devices',
                      style: TextStyle(color: paletteMuted, fontSize: 10),
                    ),
                    const Text(
                      '3',
                      style: TextStyle(
                        color: paletteAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // DEVICE GALLERY — flat phone, Surface Duo, Galaxy Fold
  // ============================================================
  Widget deviceMock({
    required String name,
    required String tag,
    required Color tagColor,
    required Widget body,
    required String summary,
  }) {
    return Container(
      width: 230,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paletteCardAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: paletteBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: paletteText,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              chip(tag, tagColor),
            ],
          ),
          const SizedBox(height: 10),
          Center(child: body),
          const SizedBox(height: 10),
          Text(
            summary,
            style: const TextStyle(color: paletteMuted, fontSize: 11, height: 1.4),
          ),
        ],
      ),
    );
  }

  // Flat phone illustration
  final Widget flatPhone = Container(
    width: 110,
    height: 200,
    decoration: BoxDecoration(
      color: paletteScreen,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: paletteBorder, width: 2),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 8,
          left: 38,
          child: Container(
            width: 34,
            height: 8,
            decoration: BoxDecoration(
              color: paletteCutout,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 68,
            height: 100,
            decoration: BoxDecoration(
              color: paletteAccent.withValues(alpha: 0.15),
              border: Border.all(color: paletteAccent.withValues(alpha: 0.4)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Center(
              child: Text(
                'app\nbody',
                textAlign: TextAlign.center,
                style: TextStyle(color: paletteAccentSoft, fontSize: 11),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // Surface Duo style — two screens with hinge
  final Widget surfaceDuo = Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: paletteSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: paletteBorder, width: 2),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: paletteScreen,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'left\nscreen',
                textAlign: TextAlign.center,
                style: TextStyle(color: paletteFold, fontSize: 11),
              ),
            ),
          ),
        ),
        Container(
          width: 12,
          color: paletteHinge,
          child: const Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                'HINGE',
                style: TextStyle(
                  color: paletteText,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: paletteScreen,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'right\nscreen',
                textAlign: TextAlign.center,
                style: TextStyle(color: paletteFold, fontSize: 11),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // Galaxy Fold style — single continuous screen with central fold
  final Widget galaxyFold = Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: paletteScreen,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: paletteBorder, width: 2),
    ),
    child: Stack(
      children: [
        const Center(
          child: Text(
            'continuous\nflexible OLED',
            textAlign: TextAlign.center,
            style: TextStyle(color: paletteAccentSoft, fontSize: 11),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 96,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: paletteFold.withValues(alpha: 0.7),
              border: Border(
                top: BorderSide(color: paletteFold, width: 1),
                bottom: BorderSide(color: paletteFold, width: 1),
              ),
            ),
            child: const Center(
              child: Text(
                'FOLD',
                style: TextStyle(
                  color: paletteScreen,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  final Widget deviceGallery = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Row(
      children: [
        deviceMock(
          name: 'Flat phone',
          tag: 'cutout',
          tagColor: paletteCutout,
          body: flatPhone,
          summary: 'No fold, no hinge. May expose a cutout DisplayFeature for the front camera.',
        ),
        deviceMock(
          name: 'Surface Duo',
          tag: 'hinge',
          tagColor: paletteHinge,
          body: surfaceDuo,
          summary: 'Two distinct displays separated by a physical hinge — content should not span it.',
        ),
        deviceMock(
          name: 'Galaxy Fold',
          tag: 'fold',
          tagColor: paletteFold,
          body: galaxyFold,
          summary: 'One flexible display with a central fold — content can span but is bent at the crease.',
        ),
      ],
    ),
  );

  // ============================================================
  // TYPE TABLE — DisplayFeatureType.values as cards
  // ============================================================
  final List<Widget> typeCards = [];
  for (int i = 0; i < typeValues.length; i++) {
    final ui.DisplayFeatureType t = typeValues[i];
    final Color tone = colorForType(t);
    typeCards.add(Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: paletteCardAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: paletteScreen,
              border: Border.all(color: paletteBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Container(
                width: 40,
                height: 6,
                color: tone,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'DisplayFeatureType.${t.name}',
                      style: TextStyle(
                        color: tone,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 8),
                    chip('#$i', paletteAccent),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  descriptionForType(t),
                  style: const TextStyle(
                    color: paletteText,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // ============================================================
  // STATE TABLE — DisplayFeatureState.values with posture mocks
  // ============================================================
  final List<Widget> stateCards = [];
  for (int i = 0; i < stateValues.length; i++) {
    final ui.DisplayFeatureState s = stateValues[i];
    Widget posture;
    if (s == ui.DisplayFeatureState.postureFlat) {
      posture = Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          color: paletteScreen,
          border: Border.all(color: paletteFold),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Container(width: 90, height: 2, color: paletteFold),
        ),
      );
    } else if (s == ui.DisplayFeatureState.postureHalfOpened) {
      posture = SizedBox(
        width: 100,
        height: 60,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 30,
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  color: paletteScreen,
                  border: Border.all(color: paletteAccent),
                ),
              ),
            ),
            Positioned(
              left: 50,
              top: 0,
              child: Transform.rotate(
                angle: -0.6,
                origin: const Offset(0, 30),
                child: Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: paletteScreen,
                    border: Border.all(color: paletteAccent),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      posture = Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          color: paletteScreen,
          border: Border.all(color: paletteUnknown, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Text(
            '?',
            style: TextStyle(
              color: paletteUnknown,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    stateCards.add(Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: paletteCardAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: paletteBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          posture,
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DisplayFeatureState.${s.name}',
                  style: const TextStyle(
                    color: paletteAccentSoft,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  descriptionForState(s),
                  style: const TextStyle(
                    color: paletteText,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // ============================================================
  // SUBSCREEN MOCK — parent rectangle with central fold band,
  // two left/right routed sub-screens drawn manually with Stack.
  // ============================================================
  final Widget subScreenMock = Container(
    height: 220,
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: paletteScreen,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: paletteBorder),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: paletteFold.withValues(alpha: 0.12),
                    border: Border.all(color: paletteFold),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'left sub-screen\n(anchorPoint = (0, h/2))',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: paletteFold, fontSize: 11),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: paletteAccent.withValues(alpha: 0.14),
                    border: Border.all(color: paletteAccent),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'right sub-screen\n(anchorPoint = (w, h/2))',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: paletteAccentSoft, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: 18,
              decoration: BoxDecoration(
                color: paletteHinge.withValues(alpha: 0.45),
                border: Border.symmetric(
                  vertical: BorderSide(color: paletteHinge, width: 1),
                ),
              ),
              child: const Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'DisplayFeature (hinge)',
                    style: TextStyle(
                      color: paletteText,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // COMPARISON TABLE — DisplayFeature vs SafeArea vs MediaQuery.padding
  // ============================================================
  Widget comparisonRow(String a, String b, String c, {bool header = false}) {
    final TextStyle style = TextStyle(
      color: header ? paletteAccentSoft : paletteText,
      fontSize: header ? 12 : 11,
      fontWeight: header ? FontWeight.bold : FontWeight.normal,
      height: 1.4,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: paletteBorder.withValues(alpha: 0.5)),
        ),
        color: header ? paletteSurface.withValues(alpha: 0.5) : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: Text(a, style: style)),
          Expanded(flex: 3, child: Text(b, style: style)),
          Expanded(flex: 3, child: Text(c, style: style)),
        ],
      ),
    );
  }

  final Widget comparisonTable = Container(
    decoration: BoxDecoration(
      color: paletteCard,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: paletteBorder),
    ),
    child: Column(
      children: [
        comparisonRow('DisplayFeature', 'SafeArea', 'MediaQuery.padding', header: true),
        comparisonRow(
          'Folds, hinges, cutouts',
          'System UI insets only',
          'OS-level insets',
        ),
        comparisonRow(
          'Carries posture state',
          'Stateless wrapper',
          'EdgeInsets values only',
        ),
        comparisonRow(
          'Used by Subscreen layout',
          'Pads child to fit',
          'Read by widgets directly',
        ),
        comparisonRow(
          'List<DisplayFeature>',
          'Single Widget',
          'EdgeInsets',
        ),
      ],
    ),
  );

  // ============================================================
  // FIELD REFERENCE
  // ============================================================
  final Widget fieldReference = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'class DisplayFeature',
        style: TextStyle(
          color: paletteFold,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
      kv('bounds', 'Rect — area of the display in logical pixels', paletteText),
      kv('type', 'DisplayFeatureType — fold / hinge / cutout / unknown', paletteText),
      kv('state', 'DisplayFeatureState — posture flat / half / unknown', paletteText),
      const SizedBox(height: 14),
      const Text(
        'enum DisplayFeatureType',
        style: TextStyle(
          color: paletteHinge,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
      kv('values', '${typeValues.length} entries', paletteAccentSoft),
      kv('names', typeValues.map((e) => e.name).join(', '), paletteText),
      const SizedBox(height: 14),
      const Text(
        'enum DisplayFeatureState',
        style: TextStyle(
          color: paletteCutout,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
      kv('values', '${stateValues.length} entries', paletteAccentSoft),
      kv('names', stateValues.map((e) => e.name).join(', '), paletteText),
      const SizedBox(height: 14),
      const Text(
        'class DisplayFeatureSubScreen',
        style: TextStyle(
          color: paletteAccent,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
      kv('displayFeatures', 'List<DisplayFeature> from MediaQuery', paletteText),
      kv('anchorPoint', 'Offset? — picks which sub-screen receives child', paletteText),
      kv('child', 'Widget — content rendered inside the chosen sub-screen', paletteText),
    ],
  );

  // ============================================================
  // SAMPLE FEATURE STATUS SUMMARY
  // ============================================================
  Widget statusRow(String label, ui.DisplayFeature? f, Color tone) {
    final bool ok = f != null;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: paletteSurface.withValues(alpha: 0.55),
        border: Border.all(color: tone.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: ok ? paletteOk : paletteErr,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: tone, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            ok ? f.bounds.toString() : 'unavailable',
            style: const TextStyle(
              color: paletteText,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EDGE CASES
  // ============================================================
  final Widget edgeCases = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: paletteOk.withValues(alpha: 0.1),
          border: Border.all(color: paletteOk),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Empty list — common case on phones; layout collapses to a single full screen.',
          style: TextStyle(color: paletteOk, fontSize: 11, height: 1.4),
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: paletteWarn.withValues(alpha: 0.1),
          border: Border.all(color: paletteWarn),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Feature larger than screen — clip the bounds to the screen rect '
          'before computing sub-screens to avoid negative regions.',
          style: TextStyle(color: paletteWarn, fontSize: 11, height: 1.4),
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: paletteErr.withValues(alpha: 0.1),
          border: Border.all(color: paletteErr),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Null anchorPoint with multiple sub-screens — the helper will '
          'throw; provide an explicit Offset or fall back to Directionality.',
          style: TextStyle(color: paletteErr, fontSize: 11, height: 1.4),
        ),
      ),
    ],
  );

  // ============================================================
  // BUILD BODY
  // ============================================================
  final Widget body = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        sectionTitle('01', 'Device gallery', 'Three reference shapes that motivate DisplayFeature.'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: deviceGallery,
        ),
        sectionTitle('02', 'DisplayFeatureType', 'Each enum value has a distinct visual treatment.'),
        card(Column(children: typeCards)),
        sectionTitle('03', 'DisplayFeatureState', 'Posture annotations describe how the device is held.'),
        card(Column(children: stateCards)),
        sectionTitle('04', 'DisplayFeatureSubScreen mock', 'Layout helper routing children around hinges.'),
        card(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stack-based illustration (real helper requires a real DisplayFeature list):',
              style: TextStyle(color: paletteMuted, fontSize: 11, height: 1.4),
            ),
            subScreenMock,
            const SizedBox(height: 10),
            const Text(
              'Live attempt (wrapped in try/catch):',
              style: TextStyle(color: paletteMuted, fontSize: 11),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: paletteScreen,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: paletteBorder),
              ),
              child: sampleSubScreen,
            ),
          ],
        )),
        sectionTitle('05', 'Code snippets', 'Common usage patterns for production apps.'),
        card(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Read display features from the current MediaQuery:',
              style: TextStyle(color: paletteText, fontSize: 12),
            ),
            codeBlock(
              'final features = MediaQuery.displayFeaturesOf(context);\n'
              'for (final f in features) {\n'
              '  if (f.type == DisplayFeatureType.hinge) {\n'
              '    // avoid crossing the hinge\n'
              '  }\n'
              '}',
            ),
            const SizedBox(height: 12),
            const Text(
              'Wrap a dialog so it sits in one sub-screen:',
              style: TextStyle(color: paletteText, fontSize: 12),
            ),
            codeBlock(
              'showDialog(\n'
              '  context: context,\n'
              '  builder: (ctx) => DisplayFeatureSubScreen(\n'
              '    anchorPoint: Offset.zero,\n'
              '    child: AlertDialog(title: Text("Hi")),\n'
              '  ),\n'
              ');',
            ),
            const SizedBox(height: 12),
            const Text(
              'Pick a sub-screen via anchorPoint:',
              style: TextStyle(color: paletteText, fontSize: 12),
            ),
            codeBlock(
              '// Top-left sub-screen\n'
              'anchorPoint: Offset.zero;\n'
              '\n'
              '// Bottom-right sub-screen\n'
              'anchorPoint: Offset(double.infinity, double.infinity);',
            ),
          ],
        )),
        sectionTitle('06', 'Comparison', 'How DisplayFeature relates to neighbouring APIs.'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: comparisonTable,
        ),
        sectionTitle('07', 'Field reference', 'Public surface of all four classes.'),
        card(fieldReference),
        sectionTitle('08', 'Sample feature status', 'Constructed in this build call.'),
        card(Column(
          children: [
            statusRow('Fold feature', foldFeature, paletteFold),
            statusRow('Hinge feature', hingeFeature, paletteHinge),
            statusRow('Cutout feature', cutoutFeature, paletteCutout),
          ],
        )),
        sectionTitle('09', 'Edge cases', 'Defensive coding around fragile inputs.'),
        card(edgeCases),
        // ============================================================
        // FOOTER
        // ============================================================
        Container(
          margin: const EdgeInsets.fromLTRB(16, 22, 16, 22),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: palettePanel,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paletteBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Summary',
                style: TextStyle(
                  color: paletteAccentSoft,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'DisplayFeature describes a region of the physical display '
                'with special properties; DisplayFeatureSubScreen consumes a '
                'list of such features to lay children out in one sub-screen '
                'of a foldable. Always read features from MediaQuery, never '
                'cache them across rebuilds, and treat unknown enum values '
                'conservatively.',
                style: TextStyle(color: paletteText, fontSize: 12, height: 1.5),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  chip('${typeValues.length} types', paletteFold),
                  chip('${stateValues.length} states', paletteHinge),
                  chip('1 SubScreen helper', paletteAccent),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('DisplayFeature visual demo built');

  return Scaffold(
    backgroundColor: paletteSurface,
    appBar: AppBar(
      backgroundColor: paletteCard,
      elevation: 0,
      title: const Text(
        'DisplayFeature · DisplayFeatureSubScreen',
        style: TextStyle(color: paletteText, fontSize: 15),
      ),
    ),
    body: body,
  );
}
