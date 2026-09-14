// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ResizeImageKey from painting
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildKeyPropertyCard(
  String property,
  String value,
  String description,
  IconData icon,
  Color color,
) {
  print('Building key property card: $property = $value');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(100)),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(20),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    property,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDimensionVisualization(
  String label,
  int? width,
  int? height,
  Color color,
) {
  print('Building dimension visualization: $label ($width x $height)');
  double displayW = (width ?? 100).toDouble().clamp(40.0, 150.0);
  double displayH = (height ?? 100).toDouble().clamp(40.0, 100.0);
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Center(
          child: Container(
            width: displayW,
            height: displayH,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 4,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${width ?? "null"}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${height ?? "null"}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.image,
                    color: color.withAlpha(150),
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Target: ${width ?? "auto"} x ${height ?? "auto"}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildPolicyCard(
  String policyName,
  String description,
  bool isSelected,
  Color color,
  IconData icon,
) {
  print('Building policy card: $policyName (selected: $isSelected)');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isSelected ? color.withAlpha(30) : Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isSelected ? color : Colors.grey.shade300,
        width: isSelected ? 2 : 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                policyName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? color : Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        if (isSelected)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'ACTIVE',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget buildAllowUpscalingToggle(bool allowUpscaling, Color color) {
  print('Building allow upscaling toggle: $allowUpscaling');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: allowUpscaling
            ? [Colors.green.shade100, Colors.green.shade50]
            : [Colors.orange.shade100, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: allowUpscaling ? Colors.green.shade300 : Colors.orange.shade300,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: allowUpscaling ? Colors.green.shade600 : Colors.orange.shade600,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            allowUpscaling ? Icons.zoom_out_map : Icons.zoom_in_map,
            color: Colors.white,
            size: 28,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'allowUpscaling: $allowUpscaling',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: allowUpscaling ? Colors.green.shade800 : Colors.orange.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                allowUpscaling
                    ? 'Image can be scaled larger than original dimensions'
                    : 'Image will not exceed original dimensions when resizing',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildKeyEqualityDemo(
  String key1Label,
  String key2Label,
  bool areEqual,
  String reason,
  Map<String, String> key1Props,
  Map<String, String> key2Props,
  Color color,
) {
  print('Building key equality demo: $key1Label vs $key2Label = $areEqual');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: areEqual ? Colors.green.shade300 : Colors.red.shade300,
        width: 2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildMiniKeyBox(key1Label, key1Props, Colors.blue),
            SizedBox(width: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: areEqual ? Colors.green.shade100 : Colors.red.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                areEqual ? Icons.check : Icons.close,
                color: areEqual ? Colors.green.shade700 : Colors.red.shade700,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            buildMiniKeyBox(key2Label, key2Props, Colors.purple),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: areEqual ? Colors.green.shade50 : Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            reason,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: areEqual ? Colors.green.shade800 : Colors.red.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildMiniKeyBox(String label, Map<String, String> props, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 6),
        ...props.entries.map((e) => Padding(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: Text(
            '${e.key}: ${e.value}',
            style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
          ),
        )),
      ],
    ),
  );
}

Widget buildCacheBehaviorCard(
  String scenario,
  String description,
  IconData icon,
  Color color,
  List<String> keyComponents,
  String cacheResult,
) {
  print('Building cache behavior card: $scenario');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100)),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scenario,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Components:',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: keyComponents.map((c) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withAlpha(25),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color.withAlpha(60)),
                  ),
                  child: Text(
                    c,
                    style: TextStyle(
                      fontSize: 10,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cached, color: color, size: 16),
              SizedBox(width: 6),
              Text(
                cacheResult,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCacheFlowVisualization() {
  print('Building cache flow visualization');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ResizeImage Cache Flow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 16),
        buildFlowStep(1, 'ResizeImage requested', 'Provider wraps original ImageProvider', Colors.blue, true),
        buildFlowArrow(),
        buildFlowStep(2, 'ResizeImageKey generated', 'Combines provider, width, height, policy, allowUpscaling', Colors.deepPurple, true),
        buildFlowArrow(),
        buildFlowStep(3, 'Cache lookup', 'ImageCache checks for existing key', Colors.orange, true),
        buildFlowArrow(),
        buildFlowStep(4, 'Hit or Miss', 'Returns cached image or triggers decode', Colors.green, true),
        buildFlowArrow(),
        buildFlowStep(5, 'Store result', 'Decoded image stored with ResizeImageKey', Colors.teal, true),
      ],
    ),
  );
}

Widget buildFlowStep(int step, String title, String description, Color color, bool isActive) {
  return Row(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.grey.shade800,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildFlowArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 14),
    child: Column(
      children: [
        Container(
          width: 2,
          height: 12,
          color: Colors.grey.shade400,
        ),
        Icon(Icons.arrow_downward, size: 14, color: Colors.grey.shade400),
      ],
    ),
  );
}

Widget buildKeyHashCodeDemo(Map<String, int> hashCodes, Color color) {
  print('Building hash code demo with ${hashCodes.length} entries');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tag, color: color, size: 20),
            SizedBox(width: 8),
            Text(
              'Hash Code Distribution',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...hashCodes.entries.map((entry) => Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withAlpha(60)),
                ),
                child: Text(
                  '${entry.value}',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );
}

Widget buildImageResizeScenario(
  String title,
  int originalW,
  int originalH,
  int? targetW,
  int? targetH,
  bool allowUpscaling,
  Color color,
) {
  print('Building resize scenario: $title');
  int finalW = targetW ?? originalW;
  int finalH = targetH ?? originalH;
  
  if (!allowUpscaling) {
    if (targetW != null && targetW > originalW) {
      finalW = originalW;
    }
    if (targetH != null && targetH > originalH) {
      finalH = originalH;
    }
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildSizeBox('Original', originalW, originalH, Colors.grey),
            Icon(Icons.arrow_forward, color: Colors.grey.shade400),
            buildSizeBox('Target', targetW, targetH, Colors.blue),
            Icon(Icons.arrow_forward, color: Colors.grey.shade400),
            buildSizeBox('Result', finalW, finalH, color),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: allowUpscaling ? Colors.green.shade100 : Colors.orange.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'allowUpscaling: $allowUpscaling',
                style: TextStyle(
                  fontSize: 11,
                  color: allowUpscaling ? Colors.green.shade800 : Colors.orange.shade800,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSizeBox(String label, int? w, int? h, Color color) {
  return Column(
    children: [
      Text(
        label,
        style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
      ),
      SizedBox(height: 4),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color),
        ),
        child: Text(
          '${w ?? "null"} x ${h ?? "null"}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Widget buildKeyComponentsBreakdown(Color color) {
  print('Building key components breakdown');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.extension, color: color, size: 20),
            SizedBox(width: 8),
            Text(
              'ResizeImageKey Components',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildComponentRow('_providerCacheKey', 'Object', 'Inner provider cache key for comparison', Colors.blue),
        buildComponentRow('width', 'int?', 'Target width in logical pixels', Colors.green),
        buildComponentRow('height', 'int?', 'Target height in logical pixels', Colors.orange),
        buildComponentRow('policy', 'ImageResizePolicy', 'Resize policy enum value', Colors.purple),
        buildComponentRow('allowUpscaling', 'bool', 'Whether upscaling is permitted', Colors.teal),
      ],
    ),
  );
}

Widget buildComponentRow(String name, String type, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: Colors.grey.shade700,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildPracticalUsageExample(String title, String code, String explanation, Color color) {
  print('Building practical usage example: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: color, size: 18),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          explanation,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ResizeImageKey deep demo executing');
  print('==========================================');
  
  print('\n--- Section: ResizeImageKey Construction ---');
  print('ResizeImageKey is created internally by ResizeImage');
  print('It combines the inner provider key with resize parameters');
  
  print('\n--- Section: Width/Height Parameters ---');
  print('width: Target width for resized image (null for auto)');
  print('height: Target height for resized image (null for auto)');
  print('At least one dimension should be specified');
  
  print('\n--- Section: Policy Parameter ---');
  print('ImageResizePolicy.exact - Exact dimensions, may distort');
  print('ImageResizePolicy.fit - Fit within bounds, preserve aspect ratio');
  
  print('\n--- Section: allowUpscaling Parameter ---');
  print('allowUpscaling: false - Prevents image from exceeding original size');
  print('allowUpscaling: true - Allows scaling beyond original dimensions');
  
  print('\n--- Section: Key Equality ---');
  print('Two ResizeImageKey instances are equal if all components match:');
  print('- Same inner provider key');
  print('- Same width and height');
  print('- Same policy');
  print('- Same allowUpscaling value');
  
  print('\n--- Section: Cache Behavior ---');
  print('ResizeImageKey determines cache hits/misses');
  print('Different resize parameters = different cache entries');
  print('Same parameters = cache hit');
  
  print('\nResizeImageKey deep demo completed');

  MaterialColor primaryColor = Colors.deepPurple;

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor.shade600, primaryColor.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ResizeImageKey',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Cache key for resize image operations',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(220),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Internal key used by ResizeImage for ImageCache lookups',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        buildSectionHeader('ResizeImageKey Construction'),
        buildInfoCard('Purpose', 'Uniquely identifies a resized image variant in the cache'),
        buildInfoCard('Creation', 'Generated internally when ResizeImage resolves its key'),
        buildInfoCard('Immutability', 'Key is immutable once created'),
        
        buildKeyComponentsBreakdown(primaryColor),
        
        buildPracticalUsageExample(
          'Creating ResizeImage',
          'ResizeImage(\n  AssetImage("photo.jpg"),\n  width: 200,\n  height: 150,\n)',
          'ResizeImage wraps an ImageProvider and generates a ResizeImageKey for caching.',
          primaryColor,
        ),
        
        buildSectionHeader('Width / Height Parameters'),
        buildInfoCard('width', 'Target width in logical pixels (int?)'),
        buildInfoCard('height', 'Target height in logical pixels (int?)'),
        buildInfoCard('Behavior', 'At least one should be non-null for meaningful resize'),
        
        buildDimensionVisualization('Width Only (300 x null)', 300, null, Colors.blue),
        buildDimensionVisualization('Height Only (null x 200)', null, 200, Colors.green),
        buildDimensionVisualization('Both Specified (300 x 200)', 300, 200, Colors.orange),
        
        buildKeyPropertyCard(
          'width',
          '300',
          'Constrains the horizontal dimension of the decoded image',
          Icons.swap_horiz,
          Colors.blue,
        ),
        buildKeyPropertyCard(
          'height',
          '200',
          'Constrains the vertical dimension of the decoded image',
          Icons.swap_vert,
          Colors.green,
        ),
        
        buildSectionHeader('Policy Parameter'),
        buildInfoCard('Type', 'ImageResizePolicy enum'),
        buildInfoCard('Options', 'exact, fit'),
        
        buildPolicyCard(
          'ImageResizePolicy.exact',
          'Resize to exact dimensions - may distort aspect ratio',
          true,
          Colors.red,
          Icons.crop_square,
        ),
        buildPolicyCard(
          'ImageResizePolicy.fit',
          'Fit within bounds while preserving aspect ratio',
          false,
          Colors.green,
          Icons.fit_screen,
        ),
        
        buildImageResizeScenario(
          'Policy: exact (original 800x600 -> target 300x200)',
          800, 600, 300, 200, true, Colors.red.shade600,
        ),
        buildImageResizeScenario(
          'Policy: fit (maintains aspect, fits bounds)',
          800, 600, 300, 200, true, Colors.green.shade600,
        ),
        
        buildSectionHeader('allowUpscaling Parameter'),
        buildInfoCard('Type', 'bool'),
        buildInfoCard('Default', 'false'),
        buildInfoCard('Purpose', 'Controls whether image can exceed original dimensions'),
        
        buildAllowUpscalingToggle(false, Colors.orange),
        buildAllowUpscalingToggle(true, Colors.green),
        
        buildImageResizeScenario(
          'Small image with allowUpscaling: false',
          100, 80, 200, 160, false, Colors.orange.shade600,
        ),
        buildImageResizeScenario(
          'Small image with allowUpscaling: true',
          100, 80, 200, 160, true, Colors.green.shade600,
        ),
        
        buildKeyPropertyCard(
          'allowUpscaling',
          'false',
          'Image will not be scaled larger than its original dimensions',
          Icons.zoom_in_map,
          Colors.orange,
        ),
        buildKeyPropertyCard(
          'allowUpscaling',
          'true',
          'Image can be enlarged beyond original size (may reduce quality)',
          Icons.zoom_out_map,
          Colors.green,
        ),
        
        buildSectionHeader('Key Equality'),
        buildInfoCard('Equality Check', 'All five components must match for equality'),
        buildInfoCard('hashCode', 'Computed from all component values'),
        
        buildKeyEqualityDemo(
          'Key A',
          'Key B',
          true,
          'Same provider, same dimensions, same policy, same allowUpscaling = EQUAL',
          {'w': '200', 'h': '150', 'policy': 'fit', 'upscale': 'false'},
          {'w': '200', 'h': '150', 'policy': 'fit', 'upscale': 'false'},
          primaryColor,
        ),
        buildKeyEqualityDemo(
          'Key A',
          'Key C',
          false,
          'Different width = NOT EQUAL (different cache entry)',
          {'w': '200', 'h': '150', 'policy': 'fit', 'upscale': 'false'},
          {'w': '300', 'h': '150', 'policy': 'fit', 'upscale': 'false'},
          primaryColor,
        ),
        buildKeyEqualityDemo(
          'Key A',
          'Key D',
          false,
          'Different policy = NOT EQUAL (different cache entry)',
          {'w': '200', 'h': '150', 'policy': 'fit', 'upscale': 'false'},
          {'w': '200', 'h': '150', 'policy': 'exact', 'upscale': 'false'},
          primaryColor,
        ),
        buildKeyEqualityDemo(
          'Key A',
          'Key E',
          false,
          'Different allowUpscaling = NOT EQUAL (different cache entry)',
          {'w': '200', 'h': '150', 'policy': 'fit', 'upscale': 'false'},
          {'w': '200', 'h': '150', 'policy': 'fit', 'upscale': 'true'},
          primaryColor,
        ),
        
        buildKeyHashCodeDemo({
          'Key(200x150, fit, false)': 847392651,
          'Key(300x150, fit, false)': 239184756,
          'Key(200x200, fit, false)': 561738294,
          'Key(200x150, exact, false)': 102938475,
          'Key(200x150, fit, true)': 738291654,
        }, primaryColor),
        
        buildSectionHeader('Cache Behavior Visualization'),
        buildInfoCard('Cache System', 'ImageCache uses keys to store and retrieve decoded images'),
        buildInfoCard('Key Role', 'ResizeImageKey uniquely identifies each resized variant'),
        
        buildCacheFlowVisualization(),
        
        buildCacheBehaviorCard(
          'Cache Hit Scenario',
          'Same ResizeImage parameters requested again',
          Icons.flash_on,
          Colors.green,
          ['provider: same', 'width: 200', 'height: 150', 'policy: fit', 'allowUpscaling: false'],
          'Instant return from cache',
        ),
        buildCacheBehaviorCard(
          'Cache Miss Scenario',
          'Different parameters create new cache entry',
          Icons.cloud_download,
          Colors.orange,
          ['provider: same', 'width: 300', 'height: 225', 'policy: fit', 'allowUpscaling: false'],
          'Decode and store new entry',
        ),
        buildCacheBehaviorCard(
          'Multiple Variants',
          'Same image at different sizes stored separately',
          Icons.collections,
          Colors.blue,
          ['Thumbnail: 100x75', 'Preview: 400x300', 'Full: 800x600'],
          'Three separate cache entries',
        ),
        
        buildPracticalUsageExample(
          'Cache-Efficient Usage',
          'final thumbnail = ResizeImage(\n  networkImage,\n  width: 100,\n);\nfinal preview = ResizeImage(\n  networkImage,\n  width: 400,\n);',
          'Each size creates a unique key and separate cache entry for efficient memory usage.',
          Colors.teal,
        ),
        
        buildPracticalUsageExample(
          'Policy Impact on Caching',
          '// These create DIFFERENT cache entries\nResizeImage(img, width: 200, policy: ImageResizePolicy.exact)\nResizeImage(img, width: 200, policy: ImageResizePolicy.fit)',
          'Changing policy changes the key, resulting in separate cached images.',
          Colors.purple,
        ),
        
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: primaryColor.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryColor.shade200),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: primaryColor.shade600, size: 40),
              SizedBox(height: 8),
              Text(
                'ResizeImageKey Demo Complete',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'All key components and cache behaviors demonstrated',
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}
