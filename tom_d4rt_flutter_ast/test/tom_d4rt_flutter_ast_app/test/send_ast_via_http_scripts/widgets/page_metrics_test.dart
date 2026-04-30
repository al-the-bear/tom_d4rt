// ignore_for_file: avoid_print
// D4rt deep demo: PageMetrics — immutable scroll snapshot for PageView
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Ocean / Azure ─────────────────────────────────────────
  const deepOcean = Color(0xFF0D47A1);
  const ocean = Color(0xFF1565C0);
  const azure = Color(0xFF1976D2);
  const softOcean = Color(0xFF42A5F5);
  const lightAzure = Color(0xFFBBDEFB);
  const paleOcean = Color(0xFFE3F2FD);
  const whiteAzure = Color(0xFFF2F8FE);
  const darkAbyss = Color(0xFF062456);
  const accentCoral = Color(0xFFE65100);
  const accentMint = Color(0xFF00695C);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget heading(String title, String sub, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.72)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (sub.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(sub,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget note(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkAbyss)),
    );
  }

  Widget kvRow(String key, String val, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 155,
            child: Text(key,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(val,
                style: TextStyle(fontSize: 13, color: darkAbyss)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Create a sample PageMetrics instance ───────────────────────────
  final sampleMetrics = PageMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1200.0,
    pixels: 412.5,
    viewportDimension: 375.0,
    axisDirection: AxisDirection.right,
    viewportFraction: 1.0,
    devicePixelRatio: 3.0,
  );

  final fractionalMetrics = PageMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1200.0,
    pixels: 300.0,
    viewportDimension: 375.0,
    axisDirection: AxisDirection.right,
    viewportFraction: 0.8,
    devicePixelRatio: 3.0,
  );

  // ── Print diagnostics ──────────────────────────────────────────────
  print('PageMetrics deep demo executing');
  print('=' * 60);

  print('\n--- PageMetrics overview ---');
  print('Extends FixedScrollMetrics (with ScrollMetrics mixin)');
  print('Defined in widgets/page_view.dart line 286');
  print('Adds viewportFraction field and page getter');

  print('\n--- Sample metrics (viewportFraction: 1.0) ---');
  print('pixels: ${sampleMetrics.pixels}');
  print('page: ${sampleMetrics.page}');
  print('viewportDimension: ${sampleMetrics.viewportDimension}');
  print('viewportFraction: ${sampleMetrics.viewportFraction}');
  print('minScrollExtent: ${sampleMetrics.minScrollExtent}');
  print('maxScrollExtent: ${sampleMetrics.maxScrollExtent}');
  print('axisDirection: ${sampleMetrics.axisDirection}');
  print('extentBefore: ${sampleMetrics.extentBefore}');
  print('extentInside: ${sampleMetrics.extentInside}');
  print('extentAfter: ${sampleMetrics.extentAfter}');

  print('\n--- Fractional metrics (viewportFraction: 0.8) ---');
  print('pixels: ${fractionalMetrics.pixels}');
  print('page: ${fractionalMetrics.page}');
  print('Effective page width: ${fractionalMetrics.viewportDimension * fractionalMetrics.viewportFraction}');

  print('\n--- copyWith ---');
  final copied = sampleMetrics.copyWith(pixels: 750.0);
  print('Original page: ${sampleMetrics.page}');
  print('Copied (pixels=750) page: ${copied.page}');

  print('\n${'=' * 60}');
  print('PageMetrics deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title ─────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepOcean, ocean, azure],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_stories, size: 28, color: lightAzure),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('PageMetrics',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('An immutable snapshot of a PageView\u0027s scroll '
                  'state that extends FixedScrollMetrics. Adds '
                  'viewportFraction and a computed page getter to '
                  'track fractional page positions during scrolling.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('FixedScrollMetrics', ocean, Colors.white),
                tag('page getter', azure, Colors.white),
                tag('viewportFraction', softOcean, Colors.white),
                tag('immutable', lightAzure, darkAbyss),
              ]),
            ],
          ),
        ),

        // ── 2. Inheritance chain ─────────────────────────────────────
        heading('1 \u00b7 Inheritance Chain',
            'Where PageMetrics sits in the class hierarchy',
            deepOcean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightAzure),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 4; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: [deepOcean, ocean, azure, softOcean][i]
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepOcean, ocean, azure, softOcean][i],
                        width: i == 3 ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: [deepOcean, ocean, azure, softOcean][i],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text([
                              'Object',
                              'ScrollMetrics (mixin)',
                              'FixedScrollMetrics',
                              'PageMetrics',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: [deepOcean, ocean, azure, softOcean][i])),
                            Text([
                              'Dart base class',
                              'Defines scroll position contract: pixels, extents, axis',
                              'Immutable concrete ScrollMetrics with final fields',
                              'Adds viewportFraction and computed page getter',
                            ][i],
                                style: TextStyle(
                                    fontSize: 10, color: darkAbyss)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Icon(Icons.arrow_downward,
                        size: 14, color: softOcean),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. Constructor anatomy ───────────────────────────────────
        heading('2 \u00b7 Constructor Parameters',
            'All required named parameters',
            ocean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final param in [
                ('minScrollExtent', 'double?', 'Start of scrollable range (usually 0)',
                    Icons.first_page, ocean),
                ('maxScrollExtent', 'double?', 'End of scrollable range (total pages \u00d7 page width)',
                    Icons.last_page, azure),
                ('pixels', 'double?', 'Current scroll position in logical pixels',
                    Icons.place, softOcean),
                ('viewportDimension', 'double?', 'Visible area size along scroll axis',
                    Icons.crop_free, deepOcean),
                ('axisDirection', 'AxisDirection', 'Scroll direction: right, left, down, up',
                    Icons.swap_horiz, accentMint),
                ('viewportFraction', 'double', 'Fraction of viewport each page occupies (0.0\u20131.0+)',
                    Icons.view_carousel, accentCoral),
                ('devicePixelRatio', 'double', 'Device pixel density for scroll physics',
                    Icons.devices, ocean),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: param.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: param.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(param.$4, size: 18, color: param.$5),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(param.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: param.$5)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: param.$5.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(param.$2,
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 9,
                                          color: param.$5)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(param.$3,
                                style: TextStyle(
                                    fontSize: 11, color: darkAbyss)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. The page getter ───────────────────────────────────────
        heading('3 \u00b7 The page Getter',
            'Computed fractional page index from scroll position',
            deepOcean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepOcean.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepOcean.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'double? get page {\n'
                    '  return pixels == null\n'
                    '    ? null\n'
                    '    : clampDouble(pixels, min, max) /\n'
                    '      max(1.0,\n'
                    '        viewportDimension * viewportFraction);\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepOcean)),
              ),
              const SizedBox(height: 10),
              // Live computed values
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ocean.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ocean),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Live Computation (sample)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: ocean)),
                    const SizedBox(height: 6),
                    kvRow('pixels', sampleMetrics.pixels.toString(), ocean),
                    kvRow('viewportDimension', sampleMetrics.viewportDimension.toString(), ocean),
                    kvRow('viewportFraction', sampleMetrics.viewportFraction.toString(), ocean),
                    kvRow('effectivePageWidth',
                        '${sampleMetrics.viewportDimension * sampleMetrics.viewportFraction}',
                        azure),
                    const Divider(),
                    kvRow('page', sampleMetrics.page.toString(), deepOcean),
                    Text('= 412.5 / max(1.0, 375.0 \u00d7 1.0) = 1.1',
                        style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: accentCoral)),
                  ],
                ),
              ),
            ],
          ),
        ),
        note(
          'The page getter returns a fractional value. page = 1.0 means '
          'fully on page 1. page = 1.5 means exactly halfway between '
          'page 1 and page 2. page = 0.0 is the first page. The value '
          'is clamped between minScrollExtent and maxScrollExtent.',
          deepOcean,
          paleOcean,
        ),
        const SizedBox(height: 14),

        // ── 5. viewportFraction effect ───────────────────────────────
        heading('4 \u00b7 viewportFraction Effect',
            'How the fraction changes page width and page index',
            azure, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final frac in [
                (1.0, '375.0', 'Full viewport', ocean),
                (0.8, '300.0', 'Card-style peek', azure),
                (0.5, '187.5', 'Half-width carousel', softOcean),
                (0.33, '123.75', 'Triple visible', accentMint),
              ]) ...[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: frac.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: frac.$4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('viewportFraction: ${frac.$1}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: frac.$4)),
                          const Spacer(),
                          Text(frac.$3,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                  color: frac.$4)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Visual bar showing effective page width
                      Container(
                        width: double.infinity,
                        height: 28,
                        decoration: BoxDecoration(
                          color: frac.$4.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: frac.$4.withValues(alpha: 0.3)),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: frac.$1.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: frac.$4.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Text('page = ${frac.$2}px',
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: frac.$4)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        note(
          'viewportFraction controls how wide each page is relative to '
          'the viewport. At 1.0 each page fills the entire viewport. '
          'At 0.8 neighboring pages peek into view. At 0.5 two pages '
          'are visible simultaneously.',
          azure,
          paleOcean,
        ),
        const SizedBox(height: 14),

        // ── 6. Live sample metrics card ──────────────────────────────
        heading('5 \u00b7 Live Sample Metrics',
            'All properties of the sample PageMetrics instance',
            ocean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              kvRow('page', sampleMetrics.page.toString(), deepOcean),
              kvRow('pixels', sampleMetrics.pixels.toString(), ocean),
              kvRow('minScrollExtent',
                  sampleMetrics.minScrollExtent.toString(), ocean),
              kvRow('maxScrollExtent',
                  sampleMetrics.maxScrollExtent.toString(), ocean),
              kvRow('viewportDimension',
                  sampleMetrics.viewportDimension.toString(), azure),
              kvRow('viewportFraction',
                  sampleMetrics.viewportFraction.toString(), azure),
              kvRow('axisDirection',
                  sampleMetrics.axisDirection.toString(), softOcean),
              kvRow('devicePixelRatio',
                  sampleMetrics.devicePixelRatio.toString(), softOcean),
              const Divider(),
              kvRow('extentBefore',
                  sampleMetrics.extentBefore.toString(), accentCoral),
              kvRow('extentInside',
                  sampleMetrics.extentInside.toString(), accentCoral),
              kvRow('extentAfter',
                  sampleMetrics.extentAfter.toString(), accentCoral),
              kvRow('hasContentDimensions',
                  sampleMetrics.hasContentDimensions.toString(), accentMint),
              kvRow('hasPixels',
                  sampleMetrics.hasPixels.toString(), accentMint),
              kvRow('hasViewportDimension',
                  sampleMetrics.hasViewportDimension.toString(), accentMint),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Extents visual ────────────────────────────────────────
        heading('6 \u00b7 Extents: Before, Inside, After',
            'Visual breakdown of the scrollable area',
            deepOcean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightAzure),
          ),
          child: Column(
            children: [
              // Bar representing total scrollable area
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: paleOcean,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ocean),
                ),
                child: Row(
                  children: [
                    // extentBefore
                    Expanded(
                      flex: (sampleMetrics.extentBefore).round().clamp(1, 999),
                      child: Container(
                        decoration: BoxDecoration(
                          color: accentCoral.withValues(alpha: 0.15),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                          ),
                        ),
                        child: Center(
                          child: Text('before\n${sampleMetrics.extentBefore}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: accentCoral)),
                        ),
                      ),
                    ),
                    // extentInside (viewport)
                    Expanded(
                      flex: (sampleMetrics.extentInside).round().clamp(1, 999),
                      child: Container(
                        color: ocean.withValues(alpha: 0.2),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('inside (viewport)',
                                  style: TextStyle(
                                      fontSize: 7,
                                      color: ocean)),
                              Text(sampleMetrics.extentInside.toString(),
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: ocean)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // extentAfter
                    Expanded(
                      flex: (sampleMetrics.extentAfter).round().clamp(1, 999),
                      child: Container(
                        decoration: BoxDecoration(
                          color: accentMint.withValues(alpha: 0.15),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                        ),
                        child: Center(
                          child: Text('after\n${sampleMetrics.extentAfter}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: accentMint)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              // Annotations
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('pixels: 0',
                      style: TextStyle(fontSize: 8, color: softOcean)),
                  Text('\u25bc scroll position: ${sampleMetrics.pixels}',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: accentCoral)),
                  Text('max: ${sampleMetrics.maxScrollExtent}',
                      style: TextStyle(fontSize: 8, color: softOcean)),
                ],
              ),
            ],
          ),
        ),
        note(
          'extentBefore = pixels (how far you\'ve scrolled). '
          'extentInside = viewportDimension (visible area). '
          'extentAfter = maxScrollExtent - pixels (remaining). '
          'These three always sum to maxScrollExtent + viewportDimension.',
          deepOcean,
          paleOcean,
        ),
        const SizedBox(height: 14),

        // ── 8. copyWith ──────────────────────────────────────────────
        heading('7 \u00b7 copyWith Method',
            'Creating modified immutable copies',
            azure, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: azure.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: azure.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'final updated = metrics.copyWith(\n'
                    '  pixels: 750.0,\n'
                    '  viewportFraction: 0.8,\n'
                    ');',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: azure)),
              ),
              const SizedBox(height: 8),
              // Show original vs copied
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ocean.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ocean),
                      ),
                      child: Column(
                        children: [
                          Text('Original',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: ocean)),
                          Text('pixels: ${sampleMetrics.pixels}',
                              style: TextStyle(
                                  fontSize: 9, color: darkAbyss)),
                          Text('page: ${sampleMetrics.page}',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: ocean)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.arrow_forward,
                        size: 16, color: azure),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: azure.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: azure, width: 2),
                      ),
                      child: Column(
                        children: [
                          Text('Copy (pixels: 750)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: azure)),
                          Text('pixels: ${copied.pixels}',
                              style: TextStyle(
                                  fontSize: 9, color: darkAbyss)),
                          Text('page: ${copied.page}',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: azure)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. PageView notification pipeline ────────────────────────
        heading('8 \u00b7 Notification Pipeline',
            'How PageMetrics flows from PageView to your code',
            deepOcean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightAzure),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 5; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: [deepOcean, ocean, azure, softOcean, accentCoral][i]
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepOcean, ocean, azure, softOcean, accentCoral][i]),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: [deepOcean, ocean, azure, softOcean, accentCoral][i],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text([
                              'PageView receives scroll gesture',
                              'PageController updates _PagePosition',
                              '_PagePosition creates PageMetrics',
                              'ScrollNotification dispatched up tree',
                              'Your listener reads notification.metrics',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: [deepOcean, ocean, azure, softOcean, accentCoral][i])),
                            Text([
                              'User swipes or flings the page view',
                              'Pixel position is updated from physics',
                              'Immutable snapshot with page, extents, fraction',
                              'NotificationListener<ScrollNotification> catches it',
                              'Cast to PageMetrics for .page and .viewportFraction',
                            ][i],
                                style: TextStyle(
                                    fontSize: 9, color: darkAbyss)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 4)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Icon(Icons.arrow_downward,
                        size: 12, color: softOcean),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Fractional page visual ───────────────────────────────
        heading('9 \u00b7 Fractional Page Index Visual',
            'What page values look like at different scroll positions',
            ocean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final snap in [
                (0.0, 'Page 0 — fully visible', deepOcean),
                (0.25, 'Swiping... 25% from page 0 to 1', ocean),
                (0.5, 'Exactly between page 0 and page 1', azure),
                (0.75, 'Almost at page 1 — 75% scrolled', softOcean),
                (1.0, 'Page 1 — fully visible', deepOcean),
                (2.3, 'Page 2, scrolled 30% toward page 3', accentCoral),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: snap.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: snap.$3, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: snap.$3.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(snap.$1.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: snap.$3)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(snap.$2,
                            style: TextStyle(
                                fontSize: 11, color: darkAbyss)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Comparison with ScrollMetrics ────────────────────────
        heading('10 \u00b7 PageMetrics vs ScrollMetrics',
            'What PageMetrics adds to the base',
            deepOcean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepOcean),
                children: [
                  for (final h in ['Property', 'ScrollMetrics', 'PageMetrics'])
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(h,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9)),
                    ),
                ],
              ),
              for (final row in [
                ('pixels', '\u2713', '\u2713'),
                ('extentBefore/After', '\u2713', '\u2713'),
                ('viewportDimension', '\u2713', '\u2713'),
                ('axisDirection', '\u2713', '\u2713'),
                ('viewportFraction', '\u2717', '\u2713 (new)'),
                ('page getter', '\u2717', '\u2713 (new)'),
                ('copyWith', 'Basic fields', '+ viewportFraction'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: darkAbyss)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 9,
                              color: row.$2.contains('\u2717')
                                  ? accentCoral
                                  : accentMint)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: row.$3.contains('new')
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: row.$3.contains('new')
                                  ? ocean
                                  : accentMint)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. AxisDirection options ─────────────────────────────────
        heading('11 \u00b7 AxisDirection Options',
            'Four scroll directions supported by PageMetrics',
            azure, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final dir in [
                ('right', Icons.arrow_forward, 'Horizontal LTR (default)', ocean),
                ('left', Icons.arrow_back, 'Horizontal RTL', azure),
                ('down', Icons.arrow_downward, 'Vertical top-to-bottom', softOcean),
                ('up', Icons.arrow_upward, 'Vertical bottom-to-top', deepOcean),
              ])
                Container(
                  width: 140,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: dir.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: dir.$4),
                  ),
                  child: Column(
                    children: [
                      Icon(dir.$2, size: 22, color: dir.$4),
                      const SizedBox(height: 4),
                      Text('AxisDirection.${dir.$1}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: dir.$4)),
                      Text(dir.$3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 9, color: darkAbyss)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Page indicator pattern ───────────────────────────────
        heading('12 \u00b7 Pattern: Page Indicator',
            'Using PageMetrics.page for dot indicators',
            ocean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ocean.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: ocean.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'NotificationListener<ScrollNotification>(\n'
                    '  onNotification: (notification) {\n'
                    '    if (notification.metrics is PageMetrics) {\n'
                    '      final pm = notification.metrics\n'
                    '          as PageMetrics;\n'
                    '      setState(() { currentPage = pm.page; });\n'
                    '    }\n'
                    '    return false;\n'
                    '  },\n'
                    '  child: PageView(...),\n'
                    ')',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: ocean)),
              ),
              const SizedBox(height: 10),
              // Mock page indicator for page 1.1
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 4; i++)
                    Container(
                      width: i == 1 ? 14 : 8,
                      height: i == 1 ? 14 : 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: i == 1 ? ocean : ocean.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Center(
                child: Text('page: 1.1 \u2192 active dot at index 1',
                    style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: ocean)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Snap detection pattern ───────────────────────────────
        heading('13 \u00b7 Pattern: Snap Detection',
            'Detecting when a page has fully snapped',
            deepOcean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepOcean.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepOcean.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// In onNotification callback:\n'
                    'final page = pm.page;\n'
                    'if (page != null) {\n'
                    '  final isSnapped = (page - page.roundToDouble())\n'
                    '      .abs() < 0.001;\n'
                    '  if (isSnapped) {\n'
                    '    print("Snapped to page: \${page.round()}");\n'
                    '  }\n'
                    '}',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: deepOcean)),
              ),
              const SizedBox(height: 8),
              // List of snap states
              for (final snap in [
                (0.003, 'Snapped at 0', true),
                (0.45, 'Scrolling between 0 and 1', false),
                (0.998, 'Snapped at 1', true),
                (1.72, 'Scrolling between 1 and 2', false),
                (3.001, 'Snapped at 3', true),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: snap.$3
                        ? accentMint.withValues(alpha: 0.06)
                        : accentCoral.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(
                            color: snap.$3 ? accentMint : accentCoral,
                            width: 2)),
                  ),
                  child: Row(
                    children: [
                      Text('page: ${snap.$1}',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: snap.$3 ? accentMint : accentCoral)),
                      const SizedBox(width: 10),
                      Icon(snap.$3 ? Icons.check_circle : Icons.motion_photos_on,
                          size: 12,
                          color: snap.$3 ? accentMint : accentCoral),
                      const SizedBox(width: 4),
                      Text(snap.$2,
                          style: TextStyle(
                              fontSize: 10,
                              color: darkAbyss)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Performance ──────────────────────────────────────────
        heading('14 \u00b7 Performance',
            'Lightweight immutable snapshot', ocean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAzure,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Immutable', 'No mutation — safe to store and compare across frames',
                    Icons.lock, ocean),
                ('Computed getter', 'page is computed on access, not stored — zero extra memory',
                    Icons.calculate, azure),
                ('copyWith', 'Creates new instance cheaply — just field copies',
                    Icons.copy, deepOcean),
                ('Notification-based', 'Arrives via existing scroll notification infrastructure — no extra listeners',
                    Icons.notifications_none, softOcean),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: perf.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: perf.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(perf.$3, size: 16, color: perf.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${perf.$1}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: perf.$4)),
                            TextSpan(
                                text: perf.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkAbyss)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        heading('15 \u00b7 Summary',
            'Key takeaways', deepOcean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepOcean, ocean],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends FixedScrollMetrics adding viewportFraction and page getter',
                'page = clampedPixels / (viewportDimension \u00d7 viewportFraction)',
                'Fractional page index: 0.0 = first page, 1.5 = halfway between pages 1\u20132',
                'viewportFraction controls how much of the viewport each page occupies',
                'Immutable — retrieved via ScrollNotification.metrics in notification listeners',
                'Created internally by PageController/_PagePosition during PageView scrolling',
                'copyWith creates modified copies with viewportFraction support',
                'extentBefore/Inside/After inherited from ScrollMetrics for scroll position',
                'Supports all four AxisDirection values for horizontal and vertical paging',
                'Use for page indicators, snap detection, progress tracking, and analytics',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightAzure,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
