// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FittedSizes from package:flutter/painting.dart
// Deep Demo: Visual demonstration of FittedSizes - the (source, destination)
// pair returned by applyBoxFit, used by paintImage, BoxDecoration.image,
// FittedBox, and any code that needs to map an input rect into an output rect.
import 'package:flutter/material.dart';

// ============================================================
// Color palette (Indigo / Amber / Teal)
// ============================================================
const Color kIndigoDeep = Color(0xFF1A237E);
const Color kIndigoMid = Color(0xFF3949AB);
const Color kIndigoSoft = Color(0xFF7986CB);
const Color kAmberDeep = Color(0xFFFF8F00);
const Color kAmberMid = Color(0xFFFFB300);
const Color kAmberSoft = Color(0xFFFFE082);
const Color kTealDeep = Color(0xFF00695C);
const Color kTealMid = Color(0xFF00897B);
const Color kTealSoft = Color(0xFF80CBC4);
const Color kSlate = Color(0xFF263238);
const Color kSlateMid = Color(0xFF455A64);
const Color kSlateSoft = Color(0xFFCFD8DC);
const Color kRoseDeep = Color(0xFFC2185B);
const Color kRoseSoft = Color(0xFFF48FB1);

// ============================================================
// Helpers - format and clamp
// ============================================================
String fmtSize(Size s) {
  return '${s.width.toStringAsFixed(1)} x ${s.height.toStringAsFixed(1)}';
}

double clampDim(double v, double maxV) {
  if (v.isNaN) {
    return 0.0;
  }
  if (v.isInfinite) {
    return maxV;
  }
  if (v < 0.0) {
    return 0.0;
  }
  if (v > maxV) {
    return maxV;
  }
  return v;
}

double aspectOf(Size s) {
  if (s.height == 0.0) {
    return 0.0;
  }
  return s.width / s.height;
}

String boxFitName(BoxFit fit) {
  if (fit == BoxFit.fill) {
    return 'fill';
  }
  if (fit == BoxFit.contain) {
    return 'contain';
  }
  if (fit == BoxFit.cover) {
    return 'cover';
  }
  if (fit == BoxFit.fitWidth) {
    return 'fitWidth';
  }
  if (fit == BoxFit.fitHeight) {
    return 'fitHeight';
  }
  if (fit == BoxFit.none) {
    return 'none';
  }
  if (fit == BoxFit.scaleDown) {
    return 'scaleDown';
  }
  return 'unknown';
}

// ============================================================
// Reusable widget builders
// ============================================================
Widget buildSectionHeader(String number, String title, String subtitle,
    Color primary, Color secondary) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24.0, bottom: 16.0),
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: primary.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: secondary.withValues(alpha: 0.25),
          blurRadius: 22.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.55),
              width: 2.0,
            ),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildRectVisual(
    String label, Size size, Color color, double maxW, double maxH) {
  final double w = clampDim(size.width, maxW);
  final double h = clampDim(size.height, maxH);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      const SizedBox(height: 4.0),
      Container(
        width: maxW + 4.0,
        height: maxH + 4.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kSlateSoft.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: kSlateSoft, width: 1.0),
        ),
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.55),
                color.withValues(alpha: 0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 4.0),
      Text(
        fmtSize(size),
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: kSlate,
        ),
      ),
    ],
  );
}

Widget buildKeyValueRow(String key, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 96.0,
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: kSlate,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildMonoChip(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget buildBoxFitCard(BoxFit fit, Size input, Size output, Color accent) {
  final FittedSizes fs = applyBoxFit(fit, input, output);
  final double srcAspect = aspectOf(fs.source);
  final double dstAspect = aspectOf(fs.destination);
  print(
      '  applyBoxFit(${boxFitName(fit)}, $input, $output) -> source=${fs.source} destination=${fs.destination}');
  return Container(
    width: 290.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          accent.withValues(alpha: 0.08),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'BoxFit.${boxFitName(fit)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            const Spacer(),
            Icon(Icons.crop, color: accent, size: 18.0),
          ],
        ),
        const SizedBox(height: 10.0),
        buildKeyValueRow('input', fmtSize(input), kIndigoMid),
        buildKeyValueRow('output', fmtSize(output), kIndigoMid),
        const Divider(height: 14.0),
        buildKeyValueRow('source', fmtSize(fs.source), kAmberDeep),
        buildKeyValueRow('destination', fmtSize(fs.destination), kTealDeep),
        const SizedBox(height: 8.0),
        Row(
          children: [
            buildMonoChip('src AR ${srcAspect.toStringAsFixed(2)}', kAmberDeep),
            const SizedBox(width: 6.0),
            buildMonoChip('dst AR ${dstAspect.toStringAsFixed(2)}', kTealDeep),
          ],
        ),
      ],
    ),
  );
}

Widget buildAnatomyDiagram(Size input, Size output) {
  final FittedSizes fs = applyBoxFit(BoxFit.contain, input, output);
  print('  Anatomy: input=$input output=$output -> $fs');
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFFDE7), Color(0xFFFFF3E0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kAmberSoft, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: kAmberDeep.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Anatomy of FittedSizes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: kSlate,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'class FittedSizes { final Size source; final Size destination; }',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: kSlateMid,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text('inputSize',
                    style: TextStyle(
                        fontSize: 11.0,
                        color: kIndigoDeep,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4.0),
                Container(
                  width: input.width.clamp(40.0, 220.0),
                  height: input.height.clamp(40.0, 140.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kIndigoSoft.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: kIndigoMid, width: 2.0),
                  ),
                  child: Container(
                    width: fs.source.width.clamp(20.0, 200.0),
                    height: fs.source.height.clamp(20.0, 130.0),
                    decoration: BoxDecoration(
                      color: kAmberMid.withValues(alpha: 0.5),
                      border: Border.all(color: kAmberDeep, width: 2.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'source',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: kSlate,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  fmtSize(input),
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: kIndigoDeep),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward, size: 32.0, color: kSlateMid),
            Column(
              children: [
                Text('outputSize',
                    style: TextStyle(
                        fontSize: 11.0,
                        color: kTealDeep,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4.0),
                Container(
                  width: output.width.clamp(40.0, 220.0),
                  height: output.height.clamp(40.0, 140.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kTealSoft.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: kTealMid, width: 2.0),
                  ),
                  child: Container(
                    width: fs.destination.width.clamp(20.0, 200.0),
                    height: fs.destination.height.clamp(20.0, 130.0),
                    decoration: BoxDecoration(
                      color: kAmberMid.withValues(alpha: 0.5),
                      border: Border.all(color: kAmberDeep, width: 2.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'destination',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: kSlate,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  fmtSize(output),
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: kTealDeep),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: kSlateSoft, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildKeyValueRow('source', fmtSize(fs.source), kAmberDeep),
              buildKeyValueRow(
                  'destination', fmtSize(fs.destination), kTealDeep),
              const SizedBox(height: 6.0),
              const Text(
                'source = sub-rect of input that will be sampled.\n'
                'destination = rect inside output where pixels will land.',
                style: TextStyle(
                    fontSize: 11.0,
                    color: kSlateMid,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSourceVsDestinationGrid(BoxFit fit, Size input, Size output) {
  final FittedSizes fs = applyBoxFit(fit, input, output);
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFE0F2F1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kIndigoSoft, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: kIndigoMid.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: kIndigoDeep, size: 18.0),
            const SizedBox(width: 6.0),
            Text(
              'BoxFit.${boxFitName(fit)} side-by-side',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: kIndigoDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildRectVisual('source', fs.source, kAmberDeep, 130.0, 90.0),
            buildRectVisual(
                'destination', fs.destination, kTealDeep, 130.0, 90.0),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            children: [
              buildKeyValueRow('input', fmtSize(input), kIndigoMid),
              buildKeyValueRow('output', fmtSize(output), kIndigoMid),
              buildKeyValueRow('source', fmtSize(fs.source), kAmberDeep),
              buildKeyValueRow(
                  'destination', fmtSize(fs.destination), kTealDeep),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFootgunCard(String title, String body, IconData icon, Color color,
    String snippet) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: kSlate,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: kSlate.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  snippet,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: kSlate,
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

Widget buildPhotoFrame(BoxFit fit, double frameW, double frameH) {
  // Imitates a 16:9 "photo" being placed inside a 4:3 frame.
  final Size photoSize = const Size(160.0, 90.0);
  final Size frameSize = Size(frameW, frameH);
  final FittedSizes fs = applyBoxFit(fit, photoSize, frameSize);
  print(
      '  Carousel BoxFit.${boxFitName(fit)} -> source=${fs.source} destination=${fs.destination}');
  return Container(
    width: frameW + 30.0,
    margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colors.white, Color(0xFFF3E5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kRoseSoft, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: kRoseDeep.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'BoxFit.${boxFitName(fit)}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12.0, color: kRoseDeep),
        ),
        const SizedBox(height: 6.0),
        Container(
          width: frameW,
          height: frameH,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kSlateSoft.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: kSlateMid, width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: SizedBox(
              width: frameW,
              height: frameH,
              child: FittedBox(
                fit: fit,
                child: Container(
                  width: photoSize.width,
                  height: photoSize.height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFF8A65),
                        Color(0xFFBA68C8),
                        Color(0xFF4FC3F7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '16:9',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'src ${fmtSize(fs.source)}',
          style: const TextStyle(
              fontFamily: 'monospace', fontSize: 9.0, color: kAmberDeep),
        ),
        Text(
          'dst ${fmtSize(fs.destination)}',
          style: const TextStyle(
              fontFamily: 'monospace', fontSize: 9.0, color: kTealDeep),
        ),
      ],
    ),
  );
}

// ============================================================
// build()
// ============================================================
dynamic build(BuildContext context) {
  print('FittedSizes Deep Demo executing');

  // ============================================================
  // SECTION 1 - Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');
  final Widget titleBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kIndigoDeep, kIndigoMid, kAmberDeep],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: kIndigoDeep.withValues(alpha: 0.55),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: kAmberDeep.withValues(alpha: 0.35),
          blurRadius: 28.0,
          offset: const Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.55), width: 2.0),
              ),
              child: const Icon(Icons.crop_free,
                  size: 28.0, color: Colors.white),
            ),
            const SizedBox(width: 14.0),
            const Text(
              'FittedSizes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Source-and-destination Sizes returned by applyBoxFit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'package:flutter/painting.dart -- powers FittedBox, paintImage, '
          'and BoxDecoration.image.',
          style: TextStyle(color: Colors.white70, fontSize: 12.0),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 - Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');
  final Widget anatomyHeader = buildSectionHeader(
    '02',
    'Anatomy of FittedSizes',
    'Source rect inside input -> destination rect inside output',
    kIndigoMid,
    kIndigoSoft,
  );
  final Widget anatomy =
      buildAnatomyDiagram(const Size(200.0, 100.0), const Size(100.0, 100.0));

  // ============================================================
  // SECTION 3 - Live applyBoxFit cards (9 entries: all 7 fits + repeats)
  // ============================================================
  print('=== Section 3: applyBoxFit cards ===');
  final Size demoInput = const Size(400.0, 300.0);
  final Size demoOutput = const Size(200.0, 200.0);
  final List<Widget> fitCards = [
    buildBoxFitCard(BoxFit.fill, demoInput, demoOutput, kIndigoMid),
    buildBoxFitCard(BoxFit.contain, demoInput, demoOutput, kAmberDeep),
    buildBoxFitCard(BoxFit.cover, demoInput, demoOutput, kTealDeep),
    buildBoxFitCard(BoxFit.fitWidth, demoInput, demoOutput, kRoseDeep),
    buildBoxFitCard(BoxFit.fitHeight, demoInput, demoOutput, kIndigoDeep),
    buildBoxFitCard(BoxFit.none, demoInput, demoOutput, kSlateMid),
    buildBoxFitCard(BoxFit.scaleDown, demoInput, demoOutput, kAmberMid),
    buildBoxFitCard(BoxFit.fill, demoInput, demoOutput, kIndigoSoft),
    buildBoxFitCard(BoxFit.contain, demoInput, demoOutput, kTealMid),
  ];
  final Widget fitGridHeader = buildSectionHeader(
    '03',
    'applyBoxFit across 9 BoxFit variants',
    'Same input/output, different fitting strategy.',
    kAmberDeep,
    kAmberMid,
  );
  final Widget fitGrid = Wrap(
    alignment: WrapAlignment.center,
    children: fitCards,
  );

  // ============================================================
  // SECTION 4 - Source vs destination grid (per BoxFit)
  // ============================================================
  print('=== Section 4: source-vs-destination grid ===');
  final Widget srcDstHeader = buildSectionHeader(
    '04',
    'Source vs destination - rect comparison',
    'Side-by-side rendering of the two Size fields, clamped for display.',
    kTealDeep,
    kTealMid,
  );
  final Size sdInput = const Size(320.0, 180.0); // 16:9
  final Size sdOutput = const Size(160.0, 160.0); // 1:1
  final List<Widget> srcDstRows = [
    buildSourceVsDestinationGrid(BoxFit.contain, sdInput, sdOutput),
    buildSourceVsDestinationGrid(BoxFit.cover, sdInput, sdOutput),
    buildSourceVsDestinationGrid(BoxFit.fitWidth, sdInput, sdOutput),
    buildSourceVsDestinationGrid(BoxFit.fitHeight, sdInput, sdOutput),
    buildSourceVsDestinationGrid(BoxFit.none, sdInput, sdOutput),
  ];

  // ============================================================
  // SECTION 5 - FittedBox integration card
  // ============================================================
  print('=== Section 5: FittedBox integration ===');
  final Widget fittedBoxHeader = buildSectionHeader(
    '05',
    'FittedBox uses applyBoxFit under the hood',
    'Same FittedSizes math drives FittedBox layout.',
    kIndigoDeep,
    kIndigoMid,
  );

  final List<BoxFit> integFits = const [
    BoxFit.contain,
    BoxFit.cover,
    BoxFit.fill,
    BoxFit.fitWidth,
  ];
  final List<Widget> integCards = [];
  for (int i = 0; i < integFits.length; i = i + 1) {
    final BoxFit f = integFits[i];
    final FittedSizes fs =
        applyBoxFit(f, const Size(200.0, 50.0), const Size(120.0, 120.0));
    integCards.add(
      Container(
        width: 200.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: kIndigoSoft, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: kIndigoMid.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: const Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'FittedBox(fit: BoxFit.${boxFitName(f)})',
              style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: kIndigoDeep,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                color: kIndigoSoft.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: kIndigoMid, width: 1.0),
              ),
              child: FittedBox(
                fit: f,
                child: Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [kAmberDeep, kRoseDeep],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text(
                    'long banner',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text('src ${fmtSize(fs.source)}',
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.5,
                    color: kAmberDeep)),
            Text('dst ${fmtSize(fs.destination)}',
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.5,
                    color: kTealDeep)),
          ],
        ),
      ),
    );
  }
  final Widget integGrid =
      Wrap(alignment: WrapAlignment.center, children: integCards);

  // ============================================================
  // SECTION 6 - BoxFit.cover deep dive (3 input ARs)
  // ============================================================
  print('=== Section 6: cover deep dive ===');
  final Widget coverHeader = buildSectionHeader(
    '06',
    'BoxFit.cover deep dive',
    '3 input aspect ratios -> see how source crops to match output AR.',
    kRoseDeep,
    kRoseSoft,
  );
  final Size coverOutput = const Size(150.0, 150.0); // square output
  final List<Map<String, dynamic>> coverInputs = [
    {'label': 'wide 4:1', 'size': const Size(400.0, 100.0)},
    {'label': 'square 1:1', 'size': const Size(200.0, 200.0)},
    {'label': 'tall 1:4', 'size': const Size(80.0, 320.0)},
  ];
  final List<Widget> coverCards = [];
  for (int i = 0; i < coverInputs.length; i = i + 1) {
    final String label = coverInputs[i]['label'] as String;
    final Size inS = coverInputs[i]['size'] as Size;
    final FittedSizes fs = applyBoxFit(BoxFit.cover, inS, coverOutput);
    print(
        '  cover deep dive label=$label input=$inS -> source=${fs.source} destination=${fs.destination}');
    coverCards.add(
      Container(
        width: 280.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              kRoseSoft.withValues(alpha: 0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: kRoseSoft, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: kRoseDeep.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.aspect_ratio, color: kRoseDeep, size: 18.0),
                const SizedBox(width: 6.0),
                Text(
                  label,
                  style: const TextStyle(
                      color: kRoseDeep,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            buildKeyValueRow('input', fmtSize(inS), kIndigoMid),
            buildKeyValueRow('output', fmtSize(coverOutput), kIndigoMid),
            const Divider(height: 14.0),
            buildKeyValueRow('source', fmtSize(fs.source), kAmberDeep),
            buildKeyValueRow(
                'destination', fmtSize(fs.destination), kTealDeep),
            const SizedBox(height: 8.0),
            Text(
              'cover crops the input so source AR matches output AR.',
              style: TextStyle(
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                  color: kSlateMid),
            ),
          ],
        ),
      ),
    );
  }
  final Widget coverGrid =
      Wrap(alignment: WrapAlignment.center, children: coverCards);

  // ============================================================
  // SECTION 7 - scaleDown vs contain
  // ============================================================
  print('=== Section 7: scaleDown vs contain ===');
  final Widget scaleHeader = buildSectionHeader(
    '07',
    'BoxFit.scaleDown vs BoxFit.contain',
    'scaleDown == contain when input > output, == none when input fits already.',
    kTealMid,
    kTealSoft,
  );

  final List<Map<String, dynamic>> scaleScenarios = [
    {
      'label': 'big input (input > output)',
      'input': const Size(400.0, 400.0),
      'output': const Size(150.0, 150.0),
    },
    {
      'label': 'small input (fits already)',
      'input': const Size(60.0, 60.0),
      'output': const Size(150.0, 150.0),
    },
    {
      'label': 'mixed (input wider only)',
      'input': const Size(400.0, 80.0),
      'output': const Size(150.0, 150.0),
    },
  ];
  final List<Widget> scaleCards = [];
  for (int i = 0; i < scaleScenarios.length; i = i + 1) {
    final String label = scaleScenarios[i]['label'] as String;
    final Size inS = scaleScenarios[i]['input'] as Size;
    final Size outS = scaleScenarios[i]['output'] as Size;
    final FittedSizes fsContain = applyBoxFit(BoxFit.contain, inS, outS);
    final FittedSizes fsScaleDown = applyBoxFit(BoxFit.scaleDown, inS, outS);
    final bool same = fsContain.source == fsScaleDown.source &&
        fsContain.destination == fsScaleDown.destination;
    print(
        '  scaleDown vs contain ($label): same=$same  contain=$fsContain  scaleDown=$fsScaleDown');
    scaleCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFE0F2F1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: kTealMid, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: kTealMid.withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  same ? Icons.check_circle : Icons.compare_arrows,
                  color: same ? kTealDeep : kAmberDeep,
                  size: 18.0,
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: kTealDeep),
                  ),
                ),
                buildMonoChip(same ? 'identical' : 'different',
                    same ? kTealDeep : kAmberDeep),
              ],
            ),
            const SizedBox(height: 10.0),
            buildKeyValueRow('input', fmtSize(inS), kIndigoMid),
            buildKeyValueRow('output', fmtSize(outS), kIndigoMid),
            const Divider(height: 14.0),
            buildKeyValueRow(
                'contain.src', fmtSize(fsContain.source), kAmberDeep),
            buildKeyValueRow(
                'contain.dst', fmtSize(fsContain.destination), kTealDeep),
            const SizedBox(height: 4.0),
            buildKeyValueRow(
                'scaleDown.src', fmtSize(fsScaleDown.source), kAmberDeep),
            buildKeyValueRow(
                'scaleDown.dst', fmtSize(fsScaleDown.destination), kTealDeep),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8 - Real-world mock: photo carousel
  // ============================================================
  print('=== Section 8: photo carousel mock ===');
  final Widget carouselHeader = buildSectionHeader(
    '08',
    'Real-world: 16:9 photo in 4:3 frame',
    'Each card uses FittedBox + the same applyBoxFit math under the hood.',
    kAmberDeep,
    kAmberSoft,
  );
  final List<BoxFit> carouselFits = const [
    BoxFit.fill,
    BoxFit.contain,
    BoxFit.cover,
    BoxFit.fitWidth,
    BoxFit.fitHeight,
    BoxFit.none,
    BoxFit.scaleDown,
  ];
  final List<Widget> carouselCards = [];
  for (int i = 0; i < carouselFits.length; i = i + 1) {
    carouselCards.add(buildPhotoFrame(carouselFits[i], 140.0, 105.0));
  }
  final Widget carouselGrid = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(children: carouselCards),
  );

  // ============================================================
  // SECTION 9 - Footgun cards
  // ============================================================
  print('=== Section 9: footgun cards ===');
  final Widget footgunHeader = buildSectionHeader(
    '09',
    'Footguns and edge-cases',
    '5 things that surprise people about FittedSizes.',
    kRoseDeep,
    kRoseSoft,
  );
  final FittedSizes negFs = applyBoxFit(
      BoxFit.contain, const Size(-100.0, -50.0), const Size(120.0, 120.0));
  final FittedSizes zeroFs = applyBoxFit(
      BoxFit.contain, Size.zero, const Size(120.0, 120.0));
  final FittedSizes nanFs = applyBoxFit(
      BoxFit.contain, Size(double.nan, 100.0), const Size(120.0, 120.0));
  print('  negative input -> $negFs');
  print('  zero input -> $zeroFs');
  print('  nan input -> $nanFs');

  final FittedSizes manualA =
      const FittedSizes(Size(50.0, 50.0), Size(100.0, 100.0));
  final FittedSizes manualB =
      const FittedSizes(Size(50.0, 50.0), Size(100.0, 100.0));
  final bool identical = manualA == manualB;
  print('  identity check (== on equal Sizes): $identical');

  final List<Widget> footguns = [
    buildFootgunCard(
      'Negative sizes do not throw',
      'applyBoxFit happily accepts negative inputSize values. The returned '
          'source/destination are usually Size.zero or undefined-shaped - '
          'always validate Size.width >= 0 first.',
      Icons.report_problem,
      kRoseDeep,
      'applyBoxFit(BoxFit.contain, Size(-100,-50), out) -> ${fmtSize(negFs.source)} / ${fmtSize(negFs.destination)}',
    ),
    buildFootgunCard(
      'Zero-area input collapses',
      'When inputSize is Size.zero (or one dimension is 0), source and '
          'destination both end up Size.zero. Useful as a guard but breaks '
          'shaders that divide by source AR.',
      Icons.crop_square,
      kAmberDeep,
      'applyBoxFit(BoxFit.contain, Size.zero, out) -> ${fmtSize(zeroFs.source)} / ${fmtSize(zeroFs.destination)}',
    ),
    buildFootgunCard(
      'NaN propagates silently',
      'A Size with NaN width/height does NOT crash applyBoxFit; the NaN flows '
          'into source/destination and only blows up later in the painter. '
          'Always sanitise upstream.',
      Icons.warning_amber_rounded,
      kIndigoDeep,
      'applyBoxFit(BoxFit.contain, Size(NaN,100), out) -> ${fmtSize(nanFs.source)} / ${fmtSize(nanFs.destination)}',
    ),
    buildFootgunCard(
      'FittedSizes equality is reference-style',
      'FittedSizes does not override == in older SDKs - two structurally '
          'equal instances may still compare unequal. Compare .source and '
          '.destination directly.',
      Icons.compare,
      kTealDeep,
      'a == b ? $identical (Size has value equality, FittedSizes may not)',
    ),
    buildFootgunCard(
      'Immutable shell, but Size is value-typed too',
      'FittedSizes fields are final, so you cannot mutate them. To "modify" '
          'one, build a new FittedSizes(newSrc, newDst). Sizes themselves are '
          'immutable value objects - safe to share.',
      Icons.lock_outline,
      kSlateMid,
      'final out = FittedSizes(Size(w,h), Size(w2,h2));',
    ),
  ];

  // ============================================================
  // SECTION 10 - Recap card
  // ============================================================
  print('=== Section 10: recap ===');
  final Widget recapHeader = buildSectionHeader(
    '10',
    'Recap - five things to remember',
    'Cheat-sheet for FittedSizes in production code.',
    kIndigoDeep,
    kAmberDeep,
  );

  final List<String> recapBullets = [
    '1. FittedSizes is a tiny value pair (Size source, Size destination) '
        'returned by applyBoxFit.',
    '2. source = sub-rect of the INPUT to read; destination = sub-rect of the '
        'OUTPUT to draw into.',
    '3. BoxFit.cover crops the source; BoxFit.contain shrinks the destination.',
    '4. BoxFit.scaleDown == contain when input is too big, otherwise == none.',
    '5. FittedBox, paintImage, and BoxDecoration.image all delegate to '
        'applyBoxFit -> the same FittedSizes math drives every fit-style API.',
  ];
  final List<Widget> recapRows = [];
  for (int i = 0; i < recapBullets.length; i = i + 1) {
    recapRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kIndigoDeep, kAmberDeep],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                recapBullets[i].substring(3),
                style: const TextStyle(
                    fontSize: 12.5, color: kSlate, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget recapCard = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFFFF8E1), Color(0xFFE0F2F1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kIndigoSoft, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: kIndigoMid.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: kAmberDeep.withValues(alpha: 0.12),
          blurRadius: 22.0,
          offset: const Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(children: recapRows),
  );

  // ============================================================
  // Final assembly
  // ============================================================
  print('=== Final assembly ===');
  return Scaffold(
    backgroundColor: const Color(0xFFF5F5F7),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          anatomyHeader,
          anatomy,
          fitGridHeader,
          fitGrid,
          srcDstHeader,
          Column(children: srcDstRows),
          fittedBoxHeader,
          integGrid,
          coverHeader,
          coverGrid,
          scaleHeader,
          Column(children: scaleCards),
          carouselHeader,
          carouselGrid,
          footgunHeader,
          Column(children: footguns),
          recapHeader,
          recapCard,
          const SizedBox(height: 40.0),
        ],
      ),
    ),
  );
}
