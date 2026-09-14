// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ResizeImage Deep Demo executing');

  // Theme palette
  final teal = Colors.teal;
  final cyan = Colors.cyan;
  final indigo = Colors.indigo;
  final amber = Colors.amber;
  final red = Colors.redAccent;
  final green = Colors.green;

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          teal.shade700,
          cyan.shade500,
          teal.shade300,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: teal.withValues(alpha: 0.5),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: cyan.withValues(alpha: 0.3),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.photo_size_select_large, size: 42.0, color: Colors.white),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'ResizeImage',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'painting',
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Memory-efficient image decoding via target width/height',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.95),
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'ImageProvider wrapper that resizes during decode, not during paint.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy Diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  Widget anatomyStep(String label, String size, Color color, IconData icon) {
    return Container(
      width: 130.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.35),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.0),
          SizedBox(height: 6.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 12.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            size,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget anatomyArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(Icons.arrow_forward, color: teal.shade700, size: 26.0),
    );
  }

  final anatomySection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, cyan.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: teal.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2 — Pipeline Anatomy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: teal.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Source bytes pass through ResizeImage before they ever reach the GPU.',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              anatomyStep('Source', '4096 x 4096', indigo, Icons.image),
              anatomyArrow(),
              anatomyStep('ResizeImage', 'width: 512', teal, Icons.compress),
              anatomyArrow(),
              anatomyStep('Decoded', '512 x 512', cyan, Icons.memory),
              anatomyArrow(),
              anatomyStep('Painted', '200 x 200', green, Icons.brush),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: amber.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: amber.shade700, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: amber.shade800, size: 18.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'The decoded buffer is what lives in memory. Painting smaller does not free RAM.',
                  style: TextStyle(fontSize: 11.5, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: width / height Variants
  // ============================================================
  print('=== Section 3: Constructor Variants ===');

  // Construct ResizeImage with MemoryImage placeholder.
  // We do not render these — we just inspect descriptors.
  final variantA = ResizeImage(
    AssetImage('hero.png'),
    width: 256,
  );
  final variantB = ResizeImage(
    AssetImage('hero.png'),
    height: 256,
  );
  final variantC = ResizeImage(
    AssetImage('hero.png'),
    width: 256,
    height: 128,
  );
  final variantD = ResizeImage(
    AssetImage('hero.png'),
    width: 64,
    height: 64,
    allowUpscaling: true,
  );
  print('variantA.width=${variantA.width} height=${variantA.height}');
  print('variantB.width=${variantB.width} height=${variantB.height}');
  print('variantC.width=${variantC.width} height=${variantC.height}');
  print('variantD.allowUpscaling=${variantD.allowUpscaling}');

  Widget variantCard(
      String title, String args, String result, Color color, IconData icon) {
    return Container(
      width: 220.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            color.withValues(alpha: 0.18),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20.0),
              SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              args,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.greenAccent,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            result,
            style: TextStyle(fontSize: 11.0, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  final variantsSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [teal.shade50, cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: teal.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3 — Constructor Variants',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: teal.shade900,
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(
          children: [
            variantCard(
              'width only',
              'ResizeImage(p, width: 256)',
              'Decode at 256 wide; height auto-scales to keep aspect ratio.',
              teal,
              Icons.swap_horiz,
            ),
            variantCard(
              'height only',
              'ResizeImage(p, height: 256)',
              'Decode at 256 tall; width auto-scales to keep aspect ratio.',
              cyan,
              Icons.swap_vert,
            ),
            variantCard(
              'width + height',
              'ResizeImage(p, width: 256, height: 128)',
              'Decode constrained on both axes; policy decides exact vs fit.',
              indigo,
              Icons.crop,
            ),
            variantCard(
              'allowUpscaling: true',
              'ResizeImage(p, width: 64, height: 64,\n  allowUpscaling: true)',
              'Permit decode to enlarge a smaller source. Off by default.',
              amber,
              Icons.zoom_out_map,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Policy exact vs fit
  // ============================================================
  print('=== Section 4: Policy ===');

  final policyExact = ResizeImage(
    AssetImage('hero.png'),
    width: 200,
    height: 100,
    policy: ResizeImagePolicy.exact,
  );
  final policyFit = ResizeImage(
    AssetImage('hero.png'),
    width: 200,
    height: 100,
    policy: ResizeImagePolicy.fit,
  );
  print('exact policy: ${policyExact.policy.name}');
  print('fit policy: ${policyFit.policy.name}');

  Widget policyCard(String policyName, String desc, String boxLabel,
      double boxWidth, double boxHeight, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'ResizeImagePolicy.$policyName',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: color, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                boxLabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.0, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  final policySection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, indigo.shade50],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4 — ResizeImagePolicy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: indigo.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How the decoder satisfies a (width, height) request when both are given.',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            policyCard(
              'exact',
              'Decode dimensions match exactly. Aspect ratio may distort.',
              '200 x 100\nexact',
              200.0,
              100.0,
              teal,
            ),
            policyCard(
              'fit',
              'Largest size that fits inside the bounds. Aspect ratio kept.',
              '200 x 100\nfit (kept)',
              160.0,
              80.0,
              cyan,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: allowUpscaling
  // ============================================================
  print('=== Section 5: allowUpscaling ===');

  final upscaleOff = ResizeImage(
    AssetImage('tiny.png'),
    width: 256,
    height: 256,
    allowUpscaling: false,
  );
  final upscaleOn = ResizeImage(
    AssetImage('tiny.png'),
    width: 256,
    height: 256,
    allowUpscaling: true,
  );
  print('upscaleOff: ${upscaleOff.allowUpscaling}');
  print('upscaleOn: ${upscaleOn.allowUpscaling}');

  Widget upscaleColumn(
      bool enabled, String label, String result, Color color, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.30),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30.0),
            SizedBox(height: 6.0),
            Text(
              'allowUpscaling: $enabled',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.5, color: Colors.black87)),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final upscalingSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cyan.shade50, Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: cyan.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5 — allowUpscaling',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: teal.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Source 64x64 requested at 256x256:',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            upscaleColumn(false, 'Decode capped at source size.',
                'decoded: 64x64', teal, Icons.lock),
            upscaleColumn(true, 'Decoder enlarges past source.',
                'decoded: 256x256', amber, Icons.unfold_more),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Memory Savings Table
  // ============================================================
  print('=== Section 6: Memory Savings ===');

  final memoryRows = <List<String>>[
    ['Source pixels', 'Target W', 'Target H', 'Source RAM', 'Decoded RAM', 'Saved'],
    ['4096 x 4096', '—', '—', '67.1 MB', '67.1 MB', '0%'],
    ['4096 x 4096', '1024', '1024', '67.1 MB', '4.2 MB', '93.7%'],
    ['4096 x 4096', '512', '512', '67.1 MB', '1.0 MB', '98.4%'],
    ['4096 x 4096', '256', '256', '67.1 MB', '262 KB', '99.6%'],
    ['4096 x 4096', '128', '128', '67.1 MB', '65 KB', '99.9%'],
    ['2048 x 1536', '320', '240', '12.6 MB', '300 KB', '97.7%'],
  ];

  Widget memoryCell(String text, bool header, bool savings) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: header
              ? teal.shade700
              : (savings ? green.withValues(alpha: 0.15) : Colors.white),
          border: Border.all(color: teal.shade200, width: 0.5),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: header ? FontWeight.bold : FontWeight.normal,
            color: header
                ? Colors.white
                : (savings ? green.shade800 : Colors.black87),
          ),
        ),
      ),
    );
  }

  final memoryTableRows = <Widget>[];
  for (var i = 0; i < memoryRows.length; i++) {
    final row = memoryRows[i];
    final isHeader = i == 0;
    memoryTableRows.add(
      Row(
        children: [
          memoryCell(row[0], isHeader, false),
          memoryCell(row[1], isHeader, false),
          memoryCell(row[2], isHeader, false),
          memoryCell(row[3], isHeader, false),
          memoryCell(row[4], isHeader, false),
          memoryCell(row[5], isHeader, !isHeader),
        ],
      ),
    );
  }

  final memorySection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: teal.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
        BoxShadow(
          color: green.withValues(alpha: 0.1),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6 — Memory Savings',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: teal.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'RGBA8888: 4 bytes per pixel. Numbers assume no mipmaps.',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        SizedBox(height: 10.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(children: memoryTableRows),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: resizeIfNeeded helper
  // ============================================================
  print('=== Section 7: resizeIfNeeded ===');

  final base = AssetImage('photo.png');
  final maybe1 = ResizeImage.resizeIfNeeded(null, null, base);
  final maybe2 = ResizeImage.resizeIfNeeded(256, null, base);
  final maybe3 = ResizeImage.resizeIfNeeded(128, 128, base);
  print('maybe1 type: ${maybe1.runtimeType}');
  print('maybe2 type: ${maybe2.runtimeType}');
  print('maybe3 type: ${maybe3.runtimeType}');

  Widget helperCard(String inputs, String output, String explanation,
      Color color, IconData icon) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.25),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 5.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 26.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inputs,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '→ $output',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  explanation,
                  style: TextStyle(fontSize: 11.0, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final helperSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, amber.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: amber.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amber.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7 — ResizeImage.resizeIfNeeded',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: amber.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Returns the original provider unchanged when no resize is requested.',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        SizedBox(height: 10.0),
        helperCard(
          'resizeIfNeeded(null, null, photo)',
          'photo (AssetImage)',
          'Both dimensions null → unwrapped passthrough.',
          teal,
          Icons.skip_next,
        ),
        helperCard(
          'resizeIfNeeded(256, null, photo)',
          'ResizeImage(photo, width: 256)',
          'One dimension provided → wraps with width only.',
          cyan,
          Icons.aspect_ratio,
        ),
        helperCard(
          'resizeIfNeeded(128, 128, photo)',
          'ResizeImage(photo, width: 128, height: 128)',
          'Both dimensions provided → wraps with both axes.',
          indigo,
          Icons.crop_square,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Real-world Use
  // ============================================================
  print('=== Section 8: Real-world Use ===');

  Widget realCard(String title, String body, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            color.withValues(alpha: 0.18),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 26.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(fontSize: 11.5, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final realSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [teal.shade50, indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: teal.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 8 — Real-world: thumbnails from a 4K asset',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: teal.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            // Source mock
            Container(
              width: 110.0,
              height: 110.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [indigo.shade400, indigo.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: indigo.shade900, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: indigo.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                '4096x4096\nasset',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Icon(Icons.double_arrow, color: teal.shade700, size: 28.0),
            SizedBox(width: 14.0),
            // Thumbnail row
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: teal.shade400,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '64',
                    style: TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
                ),
                Container(
                  width: 60.0,
                  height: 60.0,
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: cyan.shade400,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '128',
                    style: TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
                ),
                Container(
                  width: 60.0,
                  height: 60.0,
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: green.shade400,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '256',
                    style: TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.0),
        realCard(
          'Why ResizeImage beats Image(width:)',
          'Image(width:) only scales at paint time — the full decoded buffer still lives in RAM. ResizeImage shrinks the buffer itself.',
          teal,
          Icons.bolt,
        ),
        realCard(
          'Why ResizeImage beats raw cacheWidth',
          'cacheWidth on Image is the same machinery — it forwards into ResizeImage internally. Use ResizeImage directly when wrapping custom providers.',
          cyan,
          Icons.cached,
        ),
        realCard(
          'When to choose it',
          'Lists, grids, avatars, hero thumbnails — any place where the rendered size is much smaller than the source.',
          indigo,
          Icons.grid_view,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  Widget footgunCard(String title, String body, IconData icon) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            red.withValues(alpha: 0.10),
            red.withValues(alpha: 0.30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: red, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: red.withValues(alpha: 0.25),
            blurRadius: 5.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: red, size: 24.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: red,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(fontSize: 11.5, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final footgunSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, red.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: red.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: red.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: red, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Section 9 — Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: red,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        footgunCard(
          'Provider already cached at full size',
          'If the underlying provider was already loaded full-size elsewhere, the full decode lives in the cache too. ResizeImage only saves RAM if it is the first-and-only path.',
          Icons.storage,
        ),
        footgunCard(
          'Decode happens once per Resize key',
          'Different (width, height, policy, allowUpscaling) tuples = different cache entries. Spamming many sizes blows up the image cache.',
          Icons.layers,
        ),
        footgunCard(
          'Mismatch with cacheWidth on Image widget',
          'Wrapping with ResizeImage AND setting cacheWidth on the Image gives two competing decoders. Pick one strategy.',
          Icons.compare_arrows,
        ),
        footgunCard(
          'Tiny target on tiny source',
          'allowUpscaling: false silently caps the decode at source size — your width: 1024 may yield 64x64 if the source is tiny.',
          Icons.do_not_disturb_alt,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Recap
  // ============================================================
  print('=== Section 10: Recap ===');

  Widget recapBullet(String text, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12.0, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  final recapSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          teal.shade700,
          cyan.shade600,
          indigo.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: teal.withValues(alpha: 0.5),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: indigo.withValues(alpha: 0.35),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Section 10 — Recap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              recapBullet(
                'ResizeImage shrinks the decoded buffer, not just the painted size.',
                Icons.compress,
                teal,
              ),
              recapBullet(
                'Pass width or height (or both) at construction time.',
                Icons.straighten,
                cyan,
              ),
              recapBullet(
                'ResizeImagePolicy.exact distorts; .fit preserves aspect ratio.',
                Icons.crop_free,
                indigo,
              ),
              recapBullet(
                'allowUpscaling: false caps at source size — usually keep it.',
                Icons.lock,
                amber,
              ),
              recapBullet(
                'resizeIfNeeded(w, h, p) skips the wrapper when both are null.',
                Icons.skip_next,
                green,
              ),
              recapBullet(
                'Mind cache key explosions and duplicate-decode interactions.',
                Icons.warning,
                red,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'ResizeImage Deep Demo — width: ${variantA.width}, '
          'policy: ${policyExact.policy.name}, '
          'allowUpscaling: ${upscaleOn.allowUpscaling}',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('ResizeImage Deep Demo done');

  return Scaffold(
    backgroundColor: cyan.shade50,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          anatomySection,
          variantsSection,
          policySection,
          upscalingSection,
          memorySection,
          helperSection,
          realSection,
          footgunSection,
          recapSection,
        ],
      ),
    ),
  );
}
