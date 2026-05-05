// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_interpolation_to_compose_strings, unnecessary_import
// =====================================================================
// AnimatedBuilder — Deep Demo (Zoetrope / Film-Strip theme)
// =====================================================================
//
// AnimatedBuilder is a widget that listens to a `Listenable` (typically
// an `Animation<double>`) and rebuilds its subtree whenever the
// listenable notifies. Because rebuilding a subtree on every animation
// tick is expensive, AnimatedBuilder offers a `child` parameter — a
// pre-built subtree handed to the builder unchanged each frame, so the
// builder only wraps it instead of rebuilding it.
//
// In the D4rt sandbox we DO NOT have a Ticker, so we cannot use
// AnimationController. Instead we feed AnimatedBuilder with frozen
// snapshots via `AlwaysStoppedAnimation<double>(value)` — each instance
// represents one captured frame on a film strip. The builder runs
// once, reads `.value`, and produces a static frame. This is
// conceptually the same as taking a single still photograph from a
// running animation.
//
// The visual theme is "Zoetrope": film-noir black, sepia, projector
// amber, reel silver, cyan flicker — the palette of a vintage
// projection booth. Each AnimatedBuilder frame is one cell on a
// strip of film.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------
// Color palette — film-strip / zoetrope (>= 10 const Colors)
// ---------------------------------------------------------------------
const Color kFilmBlack = Color(0xFF0A0A0C);
const Color kFilmInk = Color(0xFF18181C);
const Color kSepiaDeep = Color(0xFF3B2A14);
const Color kSepiaWarm = Color(0xFF6E4A20);
const Color kSepiaLight = Color(0xFFB89060);
const Color kProjectorAmber = Color(0xFFFFB44A);
const Color kProjectorGold = Color(0xFFE89030);
const Color kReelSilver = Color(0xFFC8CDD4);
const Color kReelChrome = Color(0xFF8A929E);
const Color kCyanFlicker = Color(0xFF4DD8E6);
const Color kCyanGlow = Color(0xFF1EB7C8);
const Color kMagentaSpot = Color(0xFFE05A9E);
const Color kIvoryFrame = Color(0xFFF5EAD8);
const Color kRustEdge = Color(0xFF7A3520);
const Color kEmberRed = Color(0xFFC44B2A);

// ---------------------------------------------------------------------
// Top-level helpers (no class subclasses allowed in sandbox)
// ---------------------------------------------------------------------

Widget hSpace(double w) => SizedBox(width: w);
Widget vSpace(double h) => SizedBox(height: h);

Widget filmLabel(String text, {Color color = kProjectorAmber, double size = 12}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.4,
    ),
  );
}

Widget bodyLabel(String text, {Color color = kIvoryFrame, double size = 11}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, height: 1.35),
  );
}

Widget mono(String text, {Color color = kCyanFlicker, double size = 10}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'monospace',
      letterSpacing: 0.3,
    ),
  );
}

Widget sectionHeader(int n, String title) {
  return Container(
    margin: const EdgeInsets.only(top: 18, bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [kSepiaDeep, kFilmBlack, kFilmInk],
      ),
      border: const Border(
        left: BorderSide(color: kProjectorAmber, width: 4),
        bottom: BorderSide(color: kSepiaWarm, width: 1),
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: kProjectorAmber,
            borderRadius: BorderRadius.circular(3),
            boxShadow: const [
              BoxShadow(color: Color(0x55FFB44A), blurRadius: 6),
            ],
          ),
          child: Text(
            'REEL ' + n.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: kFilmBlack,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        hSpace(12),
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: kIvoryFrame,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget filmSprocketHole({double size = 8}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: kFilmBlack,
      borderRadius: BorderRadius.circular(2),
      border: Border.all(color: kSepiaDeep, width: 1),
    ),
  );
}

Widget filmStripEdge({double height = 60, int holes = 6}) {
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < holes; i++) {
    kids.add(filmSprocketHole(size: 7));
  }
  return Container(
    height: height,
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [kSepiaDeep, kFilmInk, kSepiaDeep],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: kids,
    ),
  );
}

Widget keyValueRow(String key, String value, {Color valueColor = kCyanFlicker}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            key,
            style: const TextStyle(
              color: kSepiaLight,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget badge(String text, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(3),
      boxShadow: [
        BoxShadow(color: bg.withOpacity(0.45), blurRadius: 4),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 9,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// MAIN BUILD
// ---------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('==========================================================');
  print('AnimatedBuilder Deep Demo — Zoetrope theme');
  print('==========================================================');
  print('Sandbox constraint: no Ticker => no AnimationController.');
  print('Strategy: feed AlwaysStoppedAnimation<double>(t) snapshots.');
  print('Each AnimatedBuilder represents one frozen film frame.');
  print('==========================================================');

  // ===================================================================
  // SECTION 0 — Anchor snapshots at t = 0.0, 0.25, 0.5, 0.75, 1.0
  // ===================================================================
  print('--- Section 0: Anchor snapshots ---');
  final AlwaysStoppedAnimation<double> animT00 =
      const AlwaysStoppedAnimation<double>(0.0);
  final AlwaysStoppedAnimation<double> animT25 =
      const AlwaysStoppedAnimation<double>(0.25);
  final AlwaysStoppedAnimation<double> animT50 =
      const AlwaysStoppedAnimation<double>(0.5);
  final AlwaysStoppedAnimation<double> animT75 =
      const AlwaysStoppedAnimation<double>(0.75);
  final AlwaysStoppedAnimation<double> animT100 =
      const AlwaysStoppedAnimation<double>(1.0);

  print('animT00  -> value=' + animT00.value.toString() +
      ' status=' + animT00.status.toString() +
      ' rt=' + animT00.runtimeType.toString());
  print('animT25  -> value=' + animT25.value.toString() +
      ' status=' + animT25.status.toString());
  print('animT50  -> value=' + animT50.value.toString() +
      ' status=' + animT50.status.toString());
  print('animT75  -> value=' + animT75.value.toString() +
      ' status=' + animT75.status.toString());
  print('animT100 -> value=' + animT100.value.toString() +
      ' status=' + animT100.status.toString() +
      ' rt=' + animT100.runtimeType.toString());

  // Five tiny anchor builders, each with its own snapshot.
  final Widget anchor00 = AnimatedBuilder(
    animation: animT00,
    builder: (BuildContext c, Widget? child) {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: kFilmInk,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kSepiaWarm, width: 1),
        ),
        alignment: Alignment.center,
        child: const Text('0.00',
            style: TextStyle(color: kProjectorAmber, fontSize: 10)),
      );
    },
  );

  final Widget anchor25 = AnimatedBuilder(
    animation: animT25,
    builder: (BuildContext c, Widget? child) {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: kSepiaDeep,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kSepiaWarm, width: 1),
        ),
        alignment: Alignment.center,
        child: const Text('0.25',
            style: TextStyle(color: kProjectorAmber, fontSize: 10)),
      );
    },
  );

  final Widget anchor50 = AnimatedBuilder(
    animation: animT50,
    builder: (BuildContext c, Widget? child) {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: kSepiaWarm,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kProjectorGold, width: 1),
        ),
        alignment: Alignment.center,
        child: const Text('0.50',
            style: TextStyle(color: kIvoryFrame, fontSize: 10)),
      );
    },
  );

  final Widget anchor75 = AnimatedBuilder(
    animation: animT75,
    builder: (BuildContext c, Widget? child) {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: kSepiaLight,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kProjectorGold, width: 1),
        ),
        alignment: Alignment.center,
        child: const Text('0.75',
            style: TextStyle(color: kFilmBlack, fontSize: 10)),
      );
    },
  );

  final Widget anchor100 = AnimatedBuilder(
    animation: animT100,
    builder: (BuildContext c, Widget? child) {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: kProjectorAmber,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kEmberRed, width: 1),
          boxShadow: const [
            BoxShadow(color: Color(0x88FFB44A), blurRadius: 8),
          ],
        ),
        alignment: Alignment.center,
        child: const Text('1.00',
            style: TextStyle(color: kFilmBlack, fontSize: 10)),
      );
    },
  );

  final Widget section0 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: const RadialGradient(
        center: Alignment.topLeft,
        radius: 1.2,
        colors: [kFilmInk, kFilmBlack],
      ),
      border: Border.all(color: kSepiaDeep, width: 1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('SECTION 0  ANCHOR SNAPSHOTS'),
        vSpace(4),
        bodyLabel(
          'Five AlwaysStoppedAnimation<double> instances at the canonical '
          'fractions 0.00 / 0.25 / 0.50 / 0.75 / 1.00. Each one is fed into '
          'its own AnimatedBuilder, which builds a single static frame.',
        ),
        vSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [anchor00, anchor25, anchor50, anchor75, anchor100],
        ),
        vSpace(10),
        keyValueRow('runtimeType', animT50.runtimeType.toString()),
        keyValueRow('status @ t=0', animT00.status.toString()),
        keyValueRow('status @ t=1', animT100.status.toString()),
      ],
    ),
  );

  // ===================================================================
  // SECTION 1 — Title banner
  // ===================================================================
  print('--- Section 1: Title banner ---');
  print('Building zoetrope title banner with projector glow.');
  print('Title color: projector amber over film-noir black.');
  print('Banner has gradient + multi-layer shadow.');

  final Widget section1 = Container(
    margin: const EdgeInsets.only(top: 12),
    height: 110,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kFilmBlack, kSepiaDeep, kFilmInk, kFilmBlack],
        stops: [0.0, 0.35, 0.7, 1.0],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(color: Color(0x88000000), blurRadius: 14, offset: Offset(0, 5)),
        BoxShadow(color: Color(0x33FFB44A), blurRadius: 26),
      ],
      border: Border.all(color: kSepiaWarm, width: 1.2),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: filmStripEdge(height: 110, holes: 7),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: filmStripEdge(height: 110, holes: 7),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    badge('AnimatedBuilder', kProjectorAmber, kFilmBlack),
                    hSpace(8),
                    badge('Listenable', kCyanFlicker, kFilmBlack),
                    hSpace(8),
                    badge('child opt', kSepiaLight, kFilmBlack),
                  ],
                ),
                vSpace(6),
                const Text(
                  'ZOETROPE — A Deep Demo of AnimatedBuilder',
                  style: TextStyle(
                    color: kIvoryFrame,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                vSpace(4),
                const Text(
                  'static snapshots via AlwaysStoppedAnimation<double>',
                  style: TextStyle(
                    color: kSepiaLight,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 2 — Anatomy diagram
  // ===================================================================
  print('--- Section 2: Anatomy diagram ---');
  print('Diagram shows: Listenable -> AnimatedBuilder -> builder(ctx, child).');
  print('Highlights the child optimization arrow.');
  print('Uses three connected boxes laid out in a row.');
  print('Each box has its own gradient + shadow.');

  Widget anatomyBox(String label, String body, List<Color> grad,
      {Color border = kSepiaWarm}) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: grad,
        ),
        border: Border.all(color: border, width: 1.2),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Color(0x55000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          filmLabel(label, color: kProjectorAmber, size: 10),
          vSpace(6),
          bodyLabel(body, size: 10),
        ],
      ),
    );
  }

  Widget arrow(String over) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        mono(over, color: kCyanFlicker, size: 9),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          width: 38,
          height: 2,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kCyanFlicker, kProjectorAmber],
            ),
          ),
        ),
        const Icon(Icons.arrow_right, color: kProjectorAmber, size: 16),
      ],
    );
  }

  final Widget section2 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kFilmInk,
      border: Border.all(color: kSepiaDeep, width: 1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('ANATOMY OF AnimatedBuilder'),
        vSpace(8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            anatomyBox(
              'Listenable',
              'Source of change notifications. Usually an Animation<double>. '
                  'Here: AlwaysStoppedAnimation.',
              const [kSepiaDeep, kFilmInk],
            ),
            arrow('listens'),
            anatomyBox(
              'AnimatedBuilder',
              'Subscribes on mount, unsubscribes on dispose. Calls builder() '
                  'whenever notified.',
              const [kSepiaWarm, kSepiaDeep],
              border: kProjectorAmber,
            ),
            arrow('builder'),
            anatomyBox(
              'builder(ctx, child)',
              'Returns a fresh widget tree wrapping the optional pre-built '
                  '"child" subtree.',
              const [kSepiaDeep, kFilmInk],
            ),
          ],
        ),
        vSpace(10),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kFilmBlack,
            border: Border.all(color: kCyanGlow, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              const Icon(Icons.bolt, color: kCyanFlicker, size: 14),
              hSpace(6),
              Expanded(
                child: bodyLabel(
                  'child optimization: the "child" widget is built ONCE and '
                  'passed to every builder() call as the second argument. '
                  'Animations only re-wrap; they do not rebuild the child.',
                  color: kCyanFlicker,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 3 — Gallery of static-frame animations
  // ===================================================================
  print('--- Section 3: Gallery of static frames ---');
  print('Five AnimatedBuilders, each at a different t.');
  print('Effects: rotation, scale, translation, opacity, color tween.');
  print('Each frame is a card with theme-consistent decoration.');
  print('Snapshots: 0.10, 0.30, 0.50, 0.70, 0.90.');

  final AlwaysStoppedAnimation<double> tRot =
      const AlwaysStoppedAnimation<double>(0.10);
  final AlwaysStoppedAnimation<double> tScale =
      const AlwaysStoppedAnimation<double>(0.30);
  final AlwaysStoppedAnimation<double> tTrans =
      const AlwaysStoppedAnimation<double>(0.50);
  final AlwaysStoppedAnimation<double> tOpa =
      const AlwaysStoppedAnimation<double>(0.70);
  final AlwaysStoppedAnimation<double> tColor =
      const AlwaysStoppedAnimation<double>(0.90);

  // Reusable card widget for the gallery — built ONCE, passed as child.
  final Widget galleryChildCard = Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
      gradient: const RadialGradient(
        center: Alignment.topLeft,
        radius: 1.0,
        colors: [kProjectorAmber, kSepiaWarm, kSepiaDeep],
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kIvoryFrame, width: 1.2),
      boxShadow: const [
        BoxShadow(color: Color(0x99000000), blurRadius: 6, offset: Offset(2, 3)),
      ],
    ),
    alignment: Alignment.center,
    child: const Icon(Icons.theaters, color: kFilmBlack, size: 28),
  );

  // 3a — rotation
  final Widget galleryRot = Column(
    children: [
      filmLabel('rotate t=' + tRot.value.toString(), size: 9),
      vSpace(6),
      Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kFilmBlack,
          border: Border.all(color: kSepiaWarm, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AnimatedBuilder(
          animation: tRot,
          child: galleryChildCard,
          builder: (BuildContext c, Widget? child) {
            // turns: 0.10 -> 36 degrees
            return Transform.rotate(
              angle: 0.10 * 2 * math.pi,
              child: child,
            );
          },
        ),
      ),
    ],
  );

  // 3b — scale
  final Widget galleryScale = Column(
    children: [
      filmLabel('scale t=' + tScale.value.toString(), size: 9),
      vSpace(6),
      Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kFilmBlack,
          border: Border.all(color: kSepiaWarm, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AnimatedBuilder(
          animation: tScale,
          child: galleryChildCard,
          builder: (BuildContext c, Widget? child) {
            return Transform.scale(scale: 0.6 + 0.30 * 1.4, child: child);
          },
        ),
      ),
    ],
  );

  // 3c — translation
  final Widget galleryTrans = Column(
    children: [
      filmLabel('translate t=' + tTrans.value.toString(), size: 9),
      vSpace(6),
      Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kFilmBlack,
          border: Border.all(color: kSepiaWarm, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AnimatedBuilder(
          animation: tTrans,
          child: galleryChildCard,
          builder: (BuildContext c, Widget? child) {
            return Transform.translate(
              offset: Offset((0.50 - 0.5) * 60.0, (0.50 - 0.5) * 30.0),
              child: child,
            );
          },
        ),
      ),
    ],
  );

  // 3d — opacity
  final Widget galleryOpa = Column(
    children: [
      filmLabel('opacity t=' + tOpa.value.toString(), size: 9),
      vSpace(6),
      Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kFilmBlack,
          border: Border.all(color: kSepiaWarm, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AnimatedBuilder(
          animation: tOpa,
          child: galleryChildCard,
          builder: (BuildContext c, Widget? child) {
            return Opacity(opacity: 0.70, child: child);
          },
        ),
      ),
    ],
  );

  // 3e — color tween (we re-build because color flows from t)
  final Widget galleryColor = Column(
    children: [
      filmLabel('color t=' + tColor.value.toString(), size: 9),
      vSpace(6),
      Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kFilmBlack,
          border: Border.all(color: kSepiaWarm, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AnimatedBuilder(
          animation: tColor,
          builder: (BuildContext c, Widget? child) {
            // Manual color lerp at t=0.90 between sepia and amber.
            final Color blended = Color.lerp(kSepiaDeep, kProjectorAmber, 0.90)!;
            return Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: blended,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kIvoryFrame, width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x88FFB44A),
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.local_movies,
                  color: kFilmBlack, size: 28),
            );
          },
        ),
      ),
    ],
  );

  final Widget section3 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kFilmInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kSepiaDeep, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('GALLERY OF STATIC-FRAME ANIMATIONS'),
        vSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            galleryRot,
            galleryScale,
            galleryTrans,
            galleryOpa,
            galleryColor,
          ],
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 4 — Child optimization
  // ===================================================================
  print('--- Section 4: Child optimization ---');
  print('Demonstrate the `child:` parameter pattern.');
  print('The child is built once and reused on every builder call.');
  print('On the right, an "expensive child" badge highlights the saving.');
  print('Snapshot t=0.45 used for the wrapping rotation/scale.');

  final AlwaysStoppedAnimation<double> tChildOpt =
      const AlwaysStoppedAnimation<double>(0.45);

  final Widget expensiveChild = Container(
    width: 130,
    height: 130,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [kSepiaLight, kProjectorAmber, kSepiaWarm, kSepiaDeep],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kIvoryFrame, width: 2),
      boxShadow: const [
        BoxShadow(color: Color(0x88000000), blurRadius: 10, offset: Offset(0, 4)),
        BoxShadow(color: Color(0x33FFB44A), blurRadius: 18),
      ],
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.movie_filter, color: kFilmBlack, size: 38),
        vSpace(4),
        const Text(
          'EXPENSIVE\nCHILD',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kFilmBlack,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
          ),
        ),
      ],
    ),
  );

  final Widget childOptDemo = AnimatedBuilder(
    animation: tChildOpt,
    child: expensiveChild,
    builder: (BuildContext c, Widget? child) {
      return Transform.rotate(
        angle: 0.45 * 0.6,
        child: Transform.scale(
          scale: 0.85 + 0.45 * 0.25,
          child: child,
        ),
      );
    },
  );

  final Widget section4 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kFilmInk, kFilmBlack],
      ),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kSepiaDeep, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('CHILD OPTIMIZATION'),
        vSpace(8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 170,
              height: 170,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kFilmBlack,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kSepiaWarm, width: 1),
              ),
              child: childOptDemo,
            ),
            hSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bodyLabel(
                    'The "EXPENSIVE CHILD" container above was constructed '
                    'exactly once — outside the AnimatedBuilder. The builder '
                    'function only wraps it in Transform.rotate and '
                    'Transform.scale for each animation tick.',
                  ),
                  vSpace(8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kSepiaDeep,
                      border: Border.all(color: kProjectorAmber, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mono('// pseudocode'),
                        mono('AnimatedBuilder('),
                        mono('  animation: tChildOpt,    // value: 0.45'),
                        mono('  child: expensiveChild,   // built ONCE'),
                        mono('  builder: (ctx, child) =>'),
                        mono('    Transform.rotate('),
                        mono('      angle: t * 0.6,'),
                        mono('      child: Transform.scale('),
                        mono('        scale: 0.85 + t * 0.25,'),
                        mono('        child: child,      // reused'),
                        mono('      ),'),
                        mono('    ),'),
                        mono(');'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 5 — Composition: chain three Tween<double>s
  // ===================================================================
  print('--- Section 5: Composition of three Tweens ---');
  print('We evaluate Tween<double>(begin, end).transform(t).');
  print('Three tweens compose: rotation, scale, translation.');
  print('Snapshot t=0.6 drives all three.');
  print('Result is a single composed transform on a frame.');

  final AlwaysStoppedAnimation<double> tCompose =
      const AlwaysStoppedAnimation<double>(0.6);
  final Tween<double> rotTween = Tween<double>(begin: -0.5, end: 0.5);
  final Tween<double> scaleTween = Tween<double>(begin: 0.7, end: 1.25);
  final Tween<double> dxTween = Tween<double>(begin: -30.0, end: 30.0);

  final double rotVal = rotTween.transform(0.6);
  final double scaleVal = scaleTween.transform(0.6);
  final double dxVal = dxTween.transform(0.6);
  print('rotTween.transform(0.6) = ' + rotVal.toString());
  print('scaleTween.transform(0.6) = ' + scaleVal.toString());
  print('dxTween.transform(0.6) = ' + dxVal.toString());

  final Widget composedFrame = AnimatedBuilder(
    animation: tCompose,
    builder: (BuildContext c, Widget? child) {
      return Transform.translate(
        offset: Offset(dxVal, 0),
        child: Transform.rotate(
          angle: rotVal,
          child: Transform.scale(
            scale: scaleVal,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [kCyanFlicker, kCyanGlow, kFilmInk],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kIvoryFrame, width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Color(0x884DD8E6), blurRadius: 14),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.flare,
                  color: kFilmBlack, size: 32),
            ),
          ),
        ),
      );
    },
  );

  final Widget section5 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kFilmInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kSepiaDeep, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('COMPOSED TWEENS'),
        vSpace(8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kFilmBlack,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kCyanGlow, width: 1),
              ),
              child: composedFrame,
            ),
            hSpace(18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bodyLabel(
                    'A single AnimatedBuilder reads three independent '
                    'Tween<double>.transform(t) values from the snapshot '
                    't=0.6 and applies them as nested Transforms.',
                  ),
                  vSpace(8),
                  keyValueRow('rot.transform(0.6)', rotVal.toStringAsFixed(3)),
                  keyValueRow('scale.transform(0.6)', scaleVal.toStringAsFixed(3)),
                  keyValueRow('dx.transform(0.6)', dxVal.toStringAsFixed(3)),
                  keyValueRow('snapshot.value', tCompose.value.toString()),
                  keyValueRow('snapshot.status', tCompose.status.toString()),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 6 — Comparison table
  // ===================================================================
  print('--- Section 6: Comparison table ---');
  print('Compares AnimatedBuilder, AnimatedWidget, ListenableBuilder.');
  print('Three columns; common axis: signature, mutation, child opt.');
  print('Visual: striped sepia rows, projector-amber header.');

  Widget tableHeaderCell(String text, {double width = 130}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: kProjectorAmber,
        border: Border(
          right: BorderSide(color: kSepiaDeep, width: 1),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: kFilmBlack,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget tableCell(String text, {double width = 130, bool stripe = false}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: stripe ? kSepiaDeep : kFilmInk,
        border: const Border(
          right: BorderSide(color: kSepiaWarm, width: 1),
          bottom: BorderSide(color: kSepiaDeep, width: 1),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: kIvoryFrame,
          fontSize: 10,
          height: 1.35,
        ),
      ),
    );
  }

  final Widget section6 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kFilmInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kSepiaDeep, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('COMPARISON'),
        vSpace(8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Column(
            children: [
              Row(
                children: [
                  tableHeaderCell('aspect', width: 140),
                  tableHeaderCell('AnimatedBuilder'),
                  tableHeaderCell('AnimatedWidget'),
                  tableHeaderCell('ListenableBuilder'),
                ],
              ),
              Row(
                children: [
                  tableCell('signature', width: 140, stripe: true),
                  tableCell('builder fn', stripe: true),
                  tableCell('subclass build()', stripe: true),
                  tableCell('builder fn', stripe: true),
                ],
              ),
              Row(
                children: [
                  tableCell('listens to', width: 140),
                  tableCell('Listenable'),
                  tableCell('Listenable'),
                  tableCell('Listenable'),
                ],
              ),
              Row(
                children: [
                  tableCell('child param', width: 140, stripe: true),
                  tableCell('yes — perf hint', stripe: true),
                  tableCell('no', stripe: true),
                  tableCell('yes — perf hint', stripe: true),
                ],
              ),
              Row(
                children: [
                  tableCell('inherits from', width: 140),
                  tableCell('ListenableBuilder'),
                  tableCell('StatefulWidget'),
                  tableCell('StatefulWidget'),
                ],
              ),
              Row(
                children: [
                  tableCell('typical use', width: 140, stripe: true),
                  tableCell('tween-driven UI', stripe: true),
                  tableCell('reusable subclass', stripe: true),
                  tableCell('any Listenable', stripe: true),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 7 — Builder signature
  // ===================================================================
  print('--- Section 7: Builder signature ---');
  print('Signature: Widget Function(BuildContext, Widget? child).');
  print('First arg: BuildContext from the AnimatedBuilder element.');
  print('Second arg: the optional child passed to the constructor.');
  print('Return type: Widget — the wrapped subtree.');

  final Widget signatureBlock = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kFilmBlack,
      border: Border.all(color: kCyanGlow, width: 1),
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(color: Color(0x553D9CCC), blurRadius: 8),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mono('// typedef from package:flutter/widgets.dart',
            color: kSepiaLight, size: 10),
        mono('typedef TransitionBuilder = Widget Function(',
            color: kIvoryFrame, size: 11),
        mono('    BuildContext context,',
            color: kCyanFlicker, size: 11),
        mono('    Widget? child,',
            color: kProjectorAmber, size: 11),
        mono(');', color: kIvoryFrame, size: 11),
        vSpace(8),
        mono('// arguments', color: kSepiaLight, size: 10),
        mono('  context : the AnimatedBuilder element location',
            color: kCyanFlicker, size: 10),
        mono('  child   : the constructor "child:" — built once',
            color: kProjectorAmber, size: 10),
        vSpace(8),
        mono('// return value', color: kSepiaLight, size: 10),
        mono('  Widget  : the new subtree for this rebuild',
            color: kIvoryFrame, size: 10),
      ],
    ),
  );

  final Widget section7 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kFilmInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kSepiaDeep, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('BUILDER SIGNATURE'),
        vSpace(8),
        signatureBlock,
      ],
    ),
  );

  // ===================================================================
  // SECTION 8 — Storyboard film strip
  // ===================================================================
  print('--- Section 8: Storyboard film strip ---');
  print('Six frames at t = 0.0, 0.2, 0.4, 0.6, 0.8, 1.0.');
  print('Each frame: AnimatedBuilder wrapping the same child.');
  print('Effect: rotation = t * pi, scale = 0.6 + t * 0.6.');
  print('Layout: horizontal strip with sprocket holes top + bottom.');

  // Build six AnimatedBuilders with explicit per-frame snapshots.
  final AlwaysStoppedAnimation<double> story0 =
      const AlwaysStoppedAnimation<double>(0.0);
  final AlwaysStoppedAnimation<double> story1 =
      const AlwaysStoppedAnimation<double>(0.2);
  final AlwaysStoppedAnimation<double> story2 =
      const AlwaysStoppedAnimation<double>(0.4);
  final AlwaysStoppedAnimation<double> story3 =
      const AlwaysStoppedAnimation<double>(0.6);
  final AlwaysStoppedAnimation<double> story4 =
      const AlwaysStoppedAnimation<double>(0.8);
  final AlwaysStoppedAnimation<double> story5 =
      const AlwaysStoppedAnimation<double>(1.0);

  // Reusable child for the story strip: a film cell with icon + frame number.
  Widget storyChild(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kProjectorAmber, kProjectorGold, kSepiaWarm],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kIvoryFrame, width: 1),
        boxShadow: const [
          BoxShadow(color: Color(0x77000000), blurRadius: 4, offset: Offset(1, 2)),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.theaters, color: kFilmBlack, size: 18),
          Text(
            'F' + index.toString(),
            style: const TextStyle(
              color: kFilmBlack,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget storyFrame(int idx, AlwaysStoppedAnimation<double> a, double tVal) {
    return Container(
      width: 96,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: kFilmBlack,
        border: Border.all(color: kSepiaWarm, width: 1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kFilmInk,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: kSepiaDeep, width: 1),
            ),
            child: AnimatedBuilder(
              animation: a,
              child: storyChild(idx),
              builder: (BuildContext c, Widget? child) {
                return Transform.rotate(
                  angle: tVal * math.pi,
                  child: Transform.scale(
                    scale: 0.6 + tVal * 0.6,
                    child: Opacity(
                      opacity: 0.4 + tVal * 0.6,
                      child: child,
                    ),
                  ),
                );
              },
            ),
          ),
          vSpace(4),
          Text(
            't=' + tVal.toStringAsFixed(1),
            style: const TextStyle(
              color: kProjectorAmber,
              fontSize: 9,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  final Widget storyboard = Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [kSepiaDeep, kFilmBlack, kSepiaDeep],
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      children: [
        // Top sprocket row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
            ],
          ),
        ),
        vSpace(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            storyFrame(0, story0, 0.0),
            storyFrame(1, story1, 0.2),
            storyFrame(2, story2, 0.4),
            storyFrame(3, story3, 0.6),
            storyFrame(4, story4, 0.8),
            storyFrame(5, story5, 1.0),
          ],
        ),
        vSpace(4),
        // Bottom sprocket row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
              filmSprocketHole(size: 8),
            ],
          ),
        ),
      ],
    ),
  );

  final Widget section8 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kFilmInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kSepiaDeep, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('STORYBOARD — 6 frames captured at fixed snapshots'),
        vSpace(10),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: storyboard,
        ),
        vSpace(8),
        bodyLabel(
          'The same builder formula (rotate by t*pi, scale by 0.6 + t*0.6, '
          'opacity 0.4 + t*0.6) is applied at six discrete snapshot values. '
          'In a live app the same formula would run every frame; here we '
          'observe only the six anchor points.',
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 9 — Cheat-sheet
  // ===================================================================
  print('--- Section 9: Cheat-sheet ---');
  print('Compact reference of AnimatedBuilder essentials.');
  print('Useful for review without re-reading the entire reel.');
  print('Lists pitfalls, recommended idioms, and constructor params.');
  print('Closes the demo with a projector-amber footer banner.');

  Widget cheatRow(IconData ic, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ic, color: kProjectorAmber, size: 14),
          hSpace(8),
          Expanded(
            child: bodyLabel(text, color: kIvoryFrame, size: 11),
          ),
        ],
      ),
    );
  }

  final Widget cheatLeft = Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kFilmBlack,
      border: Border.all(color: kSepiaDeep, width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('CONSTRUCTOR', size: 10),
        vSpace(6),
        mono('AnimatedBuilder({', color: kIvoryFrame, size: 10),
        mono('  required Listenable animation,',
            color: kCyanFlicker, size: 10),
        mono('  required TransitionBuilder builder,',
            color: kProjectorAmber, size: 10),
        mono('  Widget? child,', color: kSepiaLight, size: 10),
        mono('})', color: kIvoryFrame, size: 10),
      ],
    ),
  );

  final Widget cheatMid = Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kFilmBlack,
      border: Border.all(color: kSepiaDeep, width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('IDIOMS', size: 10),
        vSpace(6),
        cheatRow(Icons.check_circle, 'Hoist heavy widgets into the child arg.'),
        cheatRow(Icons.check_circle,
            'Read animation.value once at builder start.'),
        cheatRow(Icons.check_circle,
            'Combine multiple animations via Listenable.merge.'),
        cheatRow(Icons.check_circle,
            'Use Tween.transform(t) for explicit ranges.'),
      ],
    ),
  );

  final Widget cheatRight = Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kFilmBlack,
      border: Border.all(color: kSepiaDeep, width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('PITFALLS', size: 10),
        vSpace(6),
        cheatRow(Icons.warning, 'Building expensive subtrees inside builder.'),
        cheatRow(Icons.warning, 'Forgetting to listen to a new Listenable.'),
        cheatRow(Icons.warning,
            'Returning child unchanged when child is null.'),
        cheatRow(Icons.warning,
            'Closing over mutable state without notifying.'),
      ],
    ),
  );

  final Widget footerBanner = Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [kFilmBlack, kSepiaDeep, kProjectorAmber, kSepiaDeep, kFilmBlack],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
      ),
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(color: Color(0x66FFB44A), blurRadius: 10),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.movie, color: kFilmBlack, size: 18),
        hSpace(8),
        const Text(
          'END OF REEL — AnimatedBuilder is just a Listenable + builder',
          style: TextStyle(
            color: kFilmBlack,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
          ),
        ),
        hSpace(8),
        const Icon(Icons.movie, color: kFilmBlack, size: 18),
      ],
    ),
  );

  final Widget section9 = Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kFilmInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kSepiaDeep, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filmLabel('CHEAT-SHEET'),
        vSpace(8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: cheatLeft),
            hSpace(8),
            Expanded(child: cheatMid),
            hSpace(8),
            Expanded(child: cheatRight),
          ],
        ),
        footerBanner,
      ],
    ),
  );

  // ===================================================================
  // ROOT — assemble all sections
  // ===================================================================
  print('==========================================================');
  print('Assembling final tree: 10 sections (0..9).');
  print('Root background: film-noir gradient with vignette.');
  print('==========================================================');

  final Widget root = Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 1.4,
        colors: [kFilmInk, kFilmBlack, Color(0xFF050507)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        sectionHeader(0, 'Anchor snapshots'),
        section0,
        sectionHeader(1, 'Title banner'),
        section1,
        sectionHeader(2, 'Anatomy diagram'),
        section2,
        sectionHeader(3, 'Gallery of static-frame animations'),
        section3,
        sectionHeader(4, 'Child optimization'),
        section4,
        sectionHeader(5, 'Composed tweens'),
        section5,
        sectionHeader(6, 'Comparison table'),
        section6,
        sectionHeader(7, 'Builder signature'),
        section7,
        sectionHeader(8, 'Storyboard film strip'),
        section8,
        sectionHeader(9, 'Cheat-sheet'),
        section9,
      ],
    ),
  );

  print('AnimatedBuilder deep demo build() complete.');
  return root;
}
