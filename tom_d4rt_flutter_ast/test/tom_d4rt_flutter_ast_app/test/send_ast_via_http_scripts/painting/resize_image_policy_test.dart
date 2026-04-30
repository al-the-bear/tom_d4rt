// ignore_for_file: avoid_print
// D4rt deep-demo: ResizeImagePolicy — Marigold / Turmeric theme, prefix rp
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget rpSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFE6A817), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF9E7C0C),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget rpChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget rpInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9E7C0C))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF6D4C0A))),
        ),
      ],
    ),
  );
}

Widget rpResizePreview(String label, double srcW, double srcH,
    double tgtW, double tgtH, bool isExact, Color accent) {
  // Simulates resize behavior: exact stretches, fit preserves ratio
  final displayW = isExact ? tgtW : _rpFitWidth(srcW, srcH, tgtW, tgtH);
  final displayH = isExact ? tgtH : _rpFitHeight(srcW, srcH, tgtW, tgtH);

  return Column(
    children: [
      Container(
        width: tgtW,
        height: tgtH,
        decoration: BoxDecoration(
          color: Color(0xFFFFF8E1),
          border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Container(
            width: displayW,
            height: displayH,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Center(
              child: Text('${displayW.toInt()}×${displayH.toInt()}',
                  style: TextStyle(fontSize: 9.0, color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text(label,
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
              color: Color(0xFF9E7C0C))),
    ],
  );
}

double _rpFitWidth(double srcW, double srcH, double tgtW, double tgtH) {
  final scale = (tgtW / srcW) < (tgtH / srcH) ? (tgtW / srcW) : (tgtH / srcH);
  return srcW * scale;
}

double _rpFitHeight(double srcW, double srcH, double tgtW, double tgtH) {
  final scale = (tgtW / srcW) < (tgtH / srcH) ? (tgtW / srcW) : (tgtH / srcH);
  return srcH * scale;
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('ResizeImagePolicy Deep Demo executing');
  print('=' * 60);

  // ── Section 1: Title ─────────────────────────────────────────
  print('\n[1] ResizeImagePolicy Overview');
  print('  Enum controlling how ResizeImage resizes decoded images');
  print('  2 values: exact, fit');
  print('  Key use: ResizeImage constructor policy parameter');

  final rpTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE6A817), Color(0xFFB8860B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.photo_size_select_large, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('ResizeImagePolicy',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Controls how ResizeImage resizes decoded images for memory optimization',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFFFF3D0))),
        SizedBox(height: 6.0),
        Row(
          children: [
            rpChip('exact', Color(0xFFB8860B)),
            rpChip('fit', Color(0xFF9E7C0C)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Two Values ────────────────────────────────────
  print('\n[2] The Two Policies');
  for (final v in ResizeImagePolicy.values) {
    print('  ${v.name}: index=${v.index}');
  }

  final rpTwoValues = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFFE6A817).withValues(alpha: 0.4)),
            ),
            child: Column(
              children: [
                Icon(Icons.crop, color: Color(0xFFE6A817), size: 32.0),
                SizedBox(height: 8.0),
                Text('exact',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,
                        color: Color(0xFF9E7C0C))),
                SizedBox(height: 4.0),
                Text('Resize to exact dimensions specified',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF6D4C0A))),
                SizedBox(height: 6.0),
                rpChip('index: 0', Color(0xFFE6A817)),
                SizedBox(height: 4.0),
                Text('May distort aspect ratio',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic,
                        color: Color(0xFFB8860B))),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFF9E7C0C).withValues(alpha: 0.4)),
            ),
            child: Column(
              children: [
                Icon(Icons.fit_screen, color: Color(0xFF9E7C0C), size: 32.0),
                SizedBox(height: 8.0),
                Text('fit',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,
                        color: Color(0xFF9E7C0C))),
                SizedBox(height: 4.0),
                Text('Resize to fit within target bounds',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF6D4C0A))),
                SizedBox(height: 6.0),
                rpChip('index: 1', Color(0xFF9E7C0C)),
                SizedBox(height: 4.0),
                Text('Preserves aspect ratio',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic,
                        color: Color(0xFFB8860B))),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ── Section 3: Visual Resize Preview ─────────────────────────
  print('\n[3] Visual Resize Behavior');
  print('  Source 200×100 → Target 80×80');
  print('  exact: 80×80 (stretched)');
  print('  fit: 80×40 (maintain ratio)');

  final rpPreviewSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Source: 200×100 → Target: 80×80',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600,
                color: Color(0xFF9E7C0C))),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            rpResizePreview('exact\n(stretches)', 200, 100, 80, 80, true,
                Color(0xFFE6A817)),
            rpResizePreview('fit\n(preserves)', 200, 100, 80, 80, false,
                Color(0xFF9E7C0C)),
          ],
        ),
        SizedBox(height: 12.0),
        Text('Source: 100×200 → Target: 80×80',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600,
                color: Color(0xFF9E7C0C))),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            rpResizePreview('exact\n(stretches)', 100, 200, 80, 80, true,
                Color(0xFFE6A817)),
            rpResizePreview('fit\n(preserves)', 100, 200, 80, 80, false,
                Color(0xFF9E7C0C)),
          ],
        ),
      ],
    ),
  );

  // ── Section 4: Aspect Ratio Impact ───────────────────────────
  print('\n[4] Aspect Ratio Impact');
  print('  exact: Forces target dimensions, ignoring original ratio');
  print('  fit: Scales uniformly to fit within target bounds');
  print('  fit never exceeds either dimension');

  final ratioExamples = <Map<String, dynamic>>[
    {'src': '400×200', 'tgt': '100×100', 'exact': '100×100', 'fit': '100×50',
     'note': 'Wide image: fit shrinks height'},
    {'src': '200×400', 'tgt': '100×100', 'exact': '100×100', 'fit': '50×100',
     'note': 'Tall image: fit shrinks width'},
    {'src': '300×300', 'tgt': '100×100', 'exact': '100×100', 'fit': '100×100',
     'note': 'Square: both policies identical'},
    {'src': '50×25', 'tgt': '100×100', 'exact': '100×100', 'fit': '100×50',
     'note': 'Upscale: same ratio logic applies'},
  ];

  final rpAspectSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 70.0, child: Text('Source',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
            SizedBox(width: 60.0, child: Text('Target',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
            SizedBox(width: 60.0, child: Text('exact',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFFE6A817)))),
            SizedBox(width: 60.0, child: Text('fit',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
            Expanded(child: Text('Note',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
          ],
        ),
        Divider(color: Color(0xFFFFD54F)),
        ...ratioExamples.map((r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(width: 70.0, child: Text(r['src'] as String,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF6D4C0A)))),
              SizedBox(width: 60.0, child: Text(r['tgt'] as String,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF6D4C0A)))),
              SizedBox(width: 60.0, child: Text(r['exact'] as String,
                  style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                      color: Color(0xFFE6A817)))),
              SizedBox(width: 60.0, child: Text(r['fit'] as String,
                  style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                      color: Color(0xFF9E7C0C)))),
              Expanded(child: Text(r['note'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E00)))),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 5: ResizeImage Constructor ───────────────────────
  print('\n[5] ResizeImage Constructor');
  print('  ResizeImage wraps an ImageProvider');
  print('  Adds width/height/policy parameters');
  print('  Default policy: ResizeImagePolicy.exact');

  final rpConstructorSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ResizeImage Constructor',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                color: Color(0xFF9E7C0C))),
        SizedBox(height: 8.0),
        rpInfoRow('Class:', 'ResizeImage'),
        rpInfoRow('Wraps:', 'ImageProvider'),
        rpInfoRow('Key params:', 'width, height, policy'),
        rpInfoRow('Default policy:', 'ResizeImagePolicy.exact'),
        rpInfoRow('allowUpscaling:', 'false (default)'),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3D0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'ResizeImage(\n'
            '  AssetImage("photo.jpg"),\n'
            '  width: 200,\n'
            '  height: 200,\n'
            '  policy: ResizeImagePolicy.fit,\n'
            '  allowUpscaling: false,\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF6D4C0A)),
          ),
        ),
      ],
    ),
  );

  // ── Section 6: Memory Optimization ───────────────────────────
  print('\n[6] Memory Optimization');
  print('  Both policies reduce decoded image memory');
  print('  A 4000×3000 image = ~48MB decoded');
  print('  Resized to 400×300 = ~0.5MB decoded');
  print('  96% memory savings');

  final memoryData = <Map<String, dynamic>>[
    {'label': 'Original 4000×3000', 'bytes': '~48 MB', 'pct': 1.0,
     'color': Color(0xFFF44336)},
    {'label': 'exact 400×300', 'bytes': '~0.48 MB', 'pct': 0.01,
     'color': Color(0xFFE6A817)},
    {'label': 'fit 400×300', 'bytes': '~0.48 MB', 'pct': 0.01,
     'color': Color(0xFF9E7C0C)},
    {'label': 'exact 100×100', 'bytes': '~0.04 MB', 'pct': 0.001,
     'color': Color(0xFF4CAF50)},
  ];

  final rpMemorySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Decoded image memory comparison',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8D6E00))),
        SizedBox(height: 8.0),
        ...memoryData.map((m) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(m['label'] as String,
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                            color: Color(0xFF6D4C0A))),
                    Text(m['bytes'] as String,
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                            color: m['color'] as Color)),
                  ],
                ),
                SizedBox(height: 4.0),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEE8D5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: (m['pct'] as double).clamp(0.01, 1.0),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: m['color'] as Color,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 7: Comparison Table ──────────────────────────────
  print('\n[7] Policy Comparison Table');
  print('  Property         | exact    | fit');
  print('  Aspect ratio     | Ignored  | Preserved');
  print('  Output size      | w×h      | ≤w×≤h');
  print('  Default          | Yes      | No');
  print('  Distortion       | Possible | Never');

  final rpCompData = <Map<String, String>>[
    {'prop': 'Aspect ratio', 'exact': 'Ignored', 'fit': 'Preserved'},
    {'prop': 'Output size', 'exact': 'Exactly w×h', 'fit': '≤ w × ≤ h'},
    {'prop': 'Default policy', 'exact': 'Yes', 'fit': 'No'},
    {'prop': 'Distortion', 'exact': 'Possible', 'fit': 'Never'},
    {'prop': 'Memory savings', 'exact': 'Maximum', 'fit': 'Near-maximum'},
    {'prop': 'Predictable size', 'exact': 'Always', 'fit': 'Depends on source'},
    {'prop': 'Quality', 'exact': 'May stretch', 'fit': 'Natural look'},
  ];

  final rpCompTable = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 110.0, child: Text('Property',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
            Expanded(child: Text('exact',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFFE6A817)))),
            Expanded(child: Text('fit',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
          ],
        ),
        Divider(color: Color(0xFFFFD54F)),
        ...rpCompData.map((r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(width: 110.0, child: Text(r['prop']!,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF6D4C0A)))),
              Expanded(child: Text(r['exact']!,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFFB8860B)))),
              Expanded(child: Text(r['fit']!,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF6D4C0A)))),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 8: Practical Use Cases ───────────────────────────
  print('\n[8] Practical Use Cases');
  print('  Thumbnails: exact for uniform grid');
  print('  Previews: fit for photo gallery');
  print('  Avatars: exact for circular crop');
  print('  Banners: fit for hero images');

  final rpUseCases = <Map<String, dynamic>>[
    {'title': 'Thumbnail Grid', 'icon': Icons.grid_view,
     'policy': 'exact', 'color': Color(0xFFE6A817),
     'desc': 'Uniform grid cells need identical dimensions'},
    {'title': 'Photo Gallery', 'icon': Icons.photo_library,
     'policy': 'fit', 'color': Color(0xFF9E7C0C),
     'desc': 'Preserve original aspect ratio for natural look'},
    {'title': 'Avatar Circle', 'icon': Icons.account_circle,
     'policy': 'exact', 'color': Color(0xFFE6A817),
     'desc': 'Square output for circular clip, aspect irrelevant'},
    {'title': 'Hero Banner', 'icon': Icons.panorama,
     'policy': 'fit', 'color': Color(0xFF9E7C0C),
     'desc': 'Wide image scaled down preserving content'},
    {'title': 'Icon Badge', 'icon': Icons.badge,
     'policy': 'exact', 'color': Color(0xFFE6A817),
     'desc': 'Small fixed-size output for notification icons'},
    {'title': 'Product Image', 'icon': Icons.shopping_bag,
     'policy': 'fit', 'color': Color(0xFF9E7C0C),
     'desc': 'Various product shapes need natural proportions'},
  ];

  final rpUseCaseSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: rpUseCases.map((uc) {
        return Container(
          width: 155.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFFD54F).withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(uc['icon'] as IconData, color: Color(0xFFE6A817), size: 16.0),
                  SizedBox(width: 4.0),
                  Expanded(child: Text(uc['title'] as String,
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                          color: Color(0xFF9E7C0C)))),
                ],
              ),
              SizedBox(height: 4.0),
              rpChip(uc['policy'] as String, uc['color'] as Color),
              SizedBox(height: 4.0),
              Text(uc['desc'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF6D4C0A))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 9: allowUpscaling Interaction ────────────────────
  print('\n[9] allowUpscaling Interaction');
  print('  allowUpscaling: false (default) — never enlarge');
  print('  allowUpscaling: true — may enlarge to target');
  print('  Interacts with both policies differently');

  final upscaleData = <Map<String, dynamic>>[
    {'scenario': 'Small image, upscale=false', 'exact': 'No resize', 'fit': 'No resize'},
    {'scenario': 'Small image, upscale=true', 'exact': 'Stretch to w×h', 'fit': 'Scale to fit'},
    {'scenario': 'Large image, upscale=false', 'exact': 'Shrink to w×h', 'fit': 'Shrink to fit'},
    {'scenario': 'Large image, upscale=true', 'exact': 'Shrink to w×h', 'fit': 'Shrink to fit'},
  ];

  final rpUpscaleSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How allowUpscaling interacts with each policy',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8D6E00))),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(flex: 3, child: Text('Scenario',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0,
                    color: Color(0xFF9E7C0C)))),
            Expanded(flex: 2, child: Text('exact',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0,
                    color: Color(0xFFE6A817)))),
            Expanded(flex: 2, child: Text('fit',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0,
                    color: Color(0xFF9E7C0C)))),
          ],
        ),
        Divider(color: Color(0xFFFFD54F)),
        ...upscaleData.map((r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              Expanded(flex: 3, child: Text(r['scenario'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF6D4C0A)))),
              Expanded(flex: 2, child: Text(r['exact'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFFB8860B)))),
              Expanded(flex: 2, child: Text(r['fit'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF6D4C0A)))),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 10: Width-Only / Height-Only ─────────────────────
  print('\n[10] Width-Only and Height-Only Resize');
  print('  Can specify only width or only height');
  print('  exact: scales the specified dimension, other unchanged');
  print('  fit: scales to satisfy the specified constraint');

  final dimensionData = <Map<String, dynamic>>[
    {'spec': 'width: 200, height: null', 'exact': 'Width=200, height=original',
     'fit': 'Width≤200, height scaled'},
    {'spec': 'width: null, height: 150', 'exact': 'Width=original, height=150',
     'fit': 'Height≤150, width scaled'},
    {'spec': 'width: 200, height: 150', 'exact': '200×150 exact',
     'fit': 'Fits within 200×150'},
  ];

  final rpDimensionSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Behavior when only one dimension is specified',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8D6E00))),
        SizedBox(height: 8.0),
        ...dimensionData.map((d) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(d['spec'] as String,
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                        fontFamily: 'monospace', color: Color(0xFF9E7C0C))),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    rpChip('exact', Color(0xFFE6A817)),
                    Expanded(child: Text(d['exact'] as String,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF6D4C0A)))),
                  ],
                ),
                SizedBox(height: 2.0),
                Row(
                  children: [
                    rpChip('fit', Color(0xFF9E7C0C)),
                    Expanded(child: Text(d['fit'] as String,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF6D4C0A)))),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 11: Switch Pattern ───────────────────────────────
  print('\n[11] Switch Pattern');
  final testPolicy = ResizeImagePolicy.fit;
  switch (testPolicy) {
    case ResizeImagePolicy.exact:
      print('  → Exact resize to specified dimensions');
    case ResizeImagePolicy.fit:
      print('  → Fit within bounds, preserve ratio');
  }

  final rpSwitchSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dart 3 Switch Expression',
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                color: Color(0xFF9E7C0C))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3D0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'final desc = switch (policy) {\n'
            '  ResizeImagePolicy.exact =>\n'
            '    "Exact w×h, may distort",\n'
            '  ResizeImagePolicy.fit =>\n'
            '    "Fit within bounds, preserve ratio",\n'
            '};',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF6D4C0A)),
          ),
        ),
        SizedBox(height: 8.0),
        ...ResizeImagePolicy.values.map((v) {
          final desc = switch (v) {
            ResizeImagePolicy.exact => 'Exact dimensions',
            ResizeImagePolicy.fit => 'Fit within bounds',
          };
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right, color: Color(0xFFE6A817), size: 16.0),
                Text('${v.name} → $desc',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF6D4C0A))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 12: Side-by-Side Sizes ───────────────────────────
  print('\n[12] Side-by-Side Size Scenarios');
  print('  Various source sizes → how each policy handles them');

  final sizeScenarios = <Map<String, String>>[
    {'src': '1920×1080', 'tgt': '200×200', 'exact': '200×200', 'fit': '200×112'},
    {'src': '800×600', 'tgt': '150×150', 'exact': '150×150', 'fit': '150×112'},
    {'src': '500×500', 'tgt': '300×300', 'exact': '300×300', 'fit': '300×300'},
    {'src': '100×400', 'tgt': '200×200', 'exact': '200×200', 'fit': '50×200'},
    {'src': '3000×2000', 'tgt': '50×50', 'exact': '50×50', 'fit': '50×33'},
  ];

  final rpSizeScenariosSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 85.0, child: Text('Source',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
            SizedBox(width: 60.0, child: Text('Target',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
            SizedBox(width: 60.0, child: Text('exact',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFFE6A817)))),
            Expanded(child: Text('fit',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF9E7C0C)))),
          ],
        ),
        Divider(color: Color(0xFFFFD54F)),
        ...sizeScenarios.map((s) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(width: 85.0, child: Text(s['src']!,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF6D4C0A)))),
              SizedBox(width: 60.0, child: Text(s['tgt']!,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF6D4C0A)))),
              SizedBox(width: 60.0, child: Text(s['exact']!,
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                      color: Color(0xFFE6A817)))),
              Expanded(child: Text(s['fit']!,
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                      color: Color(0xFF9E7C0C)))),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 13: Equality & Hashing ───────────────────────────
  print('\n[13] Equality & Hashing');
  print('  exact == exact: ${ResizeImagePolicy.exact == ResizeImagePolicy.exact}');
  print('  exact == fit: ${ResizeImagePolicy.exact == ResizeImagePolicy.fit}');
  print('  hashCode exact: ${ResizeImagePolicy.exact.hashCode}');
  print('  hashCode fit: ${ResizeImagePolicy.fit.hashCode}');

  final rpEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rpInfoRow('exact == exact:', '${ResizeImagePolicy.exact == ResizeImagePolicy.exact}'),
        rpInfoRow('exact == fit:', '${ResizeImagePolicy.exact == ResizeImagePolicy.fit}'),
        rpInfoRow('hashCode exact:', '${ResizeImagePolicy.exact.hashCode}'),
        rpInfoRow('hashCode fit:', '${ResizeImagePolicy.fit.hashCode}'),
        SizedBox(height: 6.0),
        Divider(color: Color(0xFFFFD54F)),
        SizedBox(height: 4.0),
        Wrap(
          spacing: 6.0,
          children: ResizeImagePolicy.values
              .toSet()
              .map((v) => rpChip(v.name, Color(0xFFB8860B)))
              .toList(),
        ),
      ],
    ),
  );

  // ── Section 14: Common Code Patterns ─────────────────────────
  print('\n[14] Common Code Patterns');
  print('  Pattern 1: ListView thumbnail optimization');
  print('  Pattern 2: Conditional policy selection');
  print('  Pattern 3: Network image with resize');

  final rpPatterns = <Map<String, String>>[
    {'title': 'ListView Thumbnail Optimization',
     'code': 'Image(\n'
         '  image: ResizeImage(\n'
         '    NetworkImage(url),\n'
         '    width: 100,\n'
         '    height: 100,\n'
         '    policy: ResizeImagePolicy.exact,\n'
         '  ),\n'
         ')'},
    {'title': 'Conditional Policy Selection',
     'code': 'final policy = preserveRatio\n'
         '    ? ResizeImagePolicy.fit\n'
         '    : ResizeImagePolicy.exact;\n'
         'ResizeImage(provider,\n'
         '    width: w, height: h,\n'
         '    policy: policy)'},
    {'title': 'Memory-Efficient Gallery',
     'code': 'ResizeImage(\n'
         '  FileImage(file),\n'
         '  width: 300,\n'
         '  policy: ResizeImagePolicy.fit,\n'
         '  // height auto-calculated\n'
         ')'},
  ];

  final rpPatternsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      children: rpPatterns.map((p) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p['title']!,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                      color: Color(0xFFE6A817))),
              SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3D0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(p['code']!,
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                        color: Color(0xFF6D4C0A))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 15: When to Use Each ─────────────────────────────
  print('\n[15] When to Use Each');
  print('  exact: Avatars, thumbnails, icons, fixed-grid');
  print('  fit: Photos, galleries, hero images, previews');

  final rpWhenData = <Map<String, dynamic>>[
    {'policy': 'exact', 'icon': Icons.crop, 'color': Color(0xFFE6A817),
     'when': 'Avatars, thumbnails, notification icons, fixed-size grids, placeholder images'},
    {'policy': 'fit', 'icon': Icons.fit_screen, 'color': Color(0xFF9E7C0C),
     'when': 'Photo galleries, hero banners, product images, content previews, user uploads'},
  ];

  final rpWhenSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFD54F)),
    ),
    child: Column(
      children: rpWhenData.map((w) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border(left: BorderSide(color: w['color'] as Color, width: 4.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(w['icon'] as IconData, color: w['color'] as Color, size: 24.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(w['policy'] as String,
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                            color: w['color'] as Color)),
                    SizedBox(height: 4.0),
                    Text(w['when'] as String,
                        style: TextStyle(fontSize: 11.0, color: Color(0xFF6D4C0A))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  Total values: ${ResizeImagePolicy.values.length}');
  print('  Default: exact');
  print('  Recommended for most: fit');
  print('  Primary benefit: memory savings');

  final rpSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFB8860B), Color(0xFFE6A817)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('ResizeImagePolicy Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('${ResizeImagePolicy.values.length}',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,
                        color: Color(0xFFFFF3D0))),
                Text('Policies', style: TextStyle(fontSize: 11.0,
                    color: Color(0xFFFFD54F))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.crop, color: Color(0xFFFFF3D0), size: 28.0),
                Text('Default: exact',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFFFFD54F))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.memory, color: Color(0xFFFFF3D0), size: 28.0),
                Text('Memory saver',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFFFFD54F))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rpChip('exact', Color(0xFF9E7C0C)),
            rpChip('fit', Color(0xFF6D4C0A)),
          ],
        ),
      ],
    ),
  );

  print('\nResizeImagePolicy Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        rpTitleSection,
        SizedBox(height: 16.0),
        // 2 Two Values
        rpSectionHeader('The Two Policies', Icons.compare_arrows),
        rpTwoValues,
        // 3 Visual Preview
        rpSectionHeader('Visual Resize Behavior', Icons.photo_size_select_large),
        rpPreviewSection,
        // 4 Aspect Ratio
        rpSectionHeader('Aspect Ratio Impact', Icons.aspect_ratio),
        rpAspectSection,
        // 5 Constructor
        rpSectionHeader('ResizeImage Constructor', Icons.build),
        rpConstructorSection,
        // 6 Memory
        rpSectionHeader('Memory Optimization', Icons.memory),
        rpMemorySection,
        // 7 Comparison
        rpSectionHeader('Policy Comparison', Icons.table_chart),
        rpCompTable,
        // 8 Use Cases
        rpSectionHeader('Practical Use Cases', Icons.auto_awesome),
        rpUseCaseSection,
        // 9 Upscaling
        rpSectionHeader('allowUpscaling Interaction', Icons.zoom_in),
        rpUpscaleSection,
        // 10 Dimensions
        rpSectionHeader('Width/Height-Only Resize', Icons.straighten),
        rpDimensionSection,
        // 11 Switch
        rpSectionHeader('Switch Pattern', Icons.alt_route),
        rpSwitchSection,
        // 12 Size Scenarios
        rpSectionHeader('Side-by-Side Sizes', Icons.compare),
        rpSizeScenariosSection,
        // 13 Equality
        rpSectionHeader('Equality & Hashing', Icons.check_circle_outline),
        rpEqualitySection,
        // 14 Patterns
        rpSectionHeader('Common Code Patterns', Icons.code),
        rpPatternsSection,
        // 15 When to Use
        rpSectionHeader('When to Use Each', Icons.lightbulb_outline),
        rpWhenSection,
        // 16 Summary
        SizedBox(height: 8.0),
        rpSummarySection,
      ],
    ),
  );
}
