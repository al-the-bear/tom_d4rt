// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AssetBundleImageKey from painting
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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
      crossAxisAlignment: CrossAxisAlignment.start,
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

Widget buildPropertyRow(String property, String type, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 100,
          child: Text(
            property,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.teal.shade800,
            ),
          ),
        ),
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Colors.teal.shade900,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildConstructorSection() {
  print('Building AssetBundleImageKey constructor section');
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
          'AssetBundleImageKey Constructor',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'AssetBundleImageKey({\n'
            '  required AssetBundle bundle,\n'
            '  required String name,\n'
            '  required double scale,\n'
            '})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Colors.greenAccent.shade400,
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Constructor Parameters',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildParamRow(
          'bundle',
          'AssetBundle',
          'The asset bundle from which the image will be loaded',
          Colors.blue,
        ),
        _buildParamRow(
          'name',
          'String',
          'The logical name of the asset (path/filename)',
          Colors.green,
        ),
        _buildParamRow(
          'scale',
          'double',
          'The resolution scale (1.0, 2.0, 3.0, etc.)',
          Colors.orange,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'AssetBundleImageKey is typically created internally by AssetImage.obtainKey() method when resolving images.',
                  style: TextStyle(fontSize: 13, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildParamRow(
  String name,
  String type,
  String desc,
  MaterialColor color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: color.shade900,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: color.shade800,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildBundlePropertySection() {
  print('Building bundle property section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.folder_open, color: Colors.blue.shade700),
            ),
            SizedBox(width: 12),
            Text(
              'bundle Property',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Type', 'AssetBundle'),
        buildInfoCard(
          'Description',
          'The bundle from which to load the asset data',
        ),
        SizedBox(height: 12),
        Text(
          'Common Bundle Types',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildBundleTypeCard(
          'rootBundle',
          'Default asset bundle for the application',
          'Access via: rootBundle (from services.dart)',
          Colors.blue,
          Icons.home,
        ),
        _buildBundleTypeCard(
          'DefaultAssetBundle',
          'InheritedWidget providing contextual bundle',
          'Access via: DefaultAssetBundle.of(context)',
          Colors.indigo,
          Icons.layers,
        ),
        _buildBundleTypeCard(
          'NetworkAssetBundle',
          'Loads assets from network URLs',
          'Used for remote asset loading',
          Colors.purple,
          Icons.cloud_download,
        ),
        _buildBundleTypeCard(
          'PlatformAssetBundle',
          'Platform-specific implementation',
          'Handles platform asset resolution',
          Colors.teal,
          Icons.devices,
        ),
      ],
    ),
  );
}

Widget _buildBundleTypeCard(
  String name,
  String description,
  String access,
  MaterialColor color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color.shade700, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color.shade800,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              SizedBox(height: 2),
              Text(
                access,
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: color.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildNamePropertySection() {
  print('Building name property section');
  List<String> examplePaths = [
    'assets/images/logo.png',
    'assets/icons/home.svg',
    'packages/my_package/images/banner.jpg',
    'assets/2.0x/photo.png',
    'assets/3.0x/photo.png',
  ];
  List<String> pathDescriptions = [
    'Standard asset path',
    'Icon asset path',
    'Package asset path',
    '2x resolution variant',
    '3x resolution variant',
  ];
  List<IconData> pathIcons = [
    Icons.image,
    Icons.widgets,
    Icons.inventory_2,
    Icons.fit_screen,
    Icons.aspect_ratio,
  ];

  List<Widget> pathCards = [];
  int i = 0;
  for (i = 0; i < examplePaths.length; i = i + 1) {
    pathCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Icon(pathIcons[i], color: Colors.green.shade600, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    examplePaths[i],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.green.shade900,
                    ),
                  ),
                  Text(
                    pathDescriptions[i],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.text_fields, color: Colors.green.shade700),
            ),
            SizedBox(width: 12),
            Text(
              'name Property',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Type', 'String'),
        buildInfoCard(
          'Description',
          'The logical key path identifying the asset',
        ),
        SizedBox(height: 12),
        Text(
          'Example Asset Paths',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Column(children: pathCards),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Naming Conventions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.green.shade800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '• Use forward slashes (/) for path separators\n'
                '• Resolution variants use 2.0x/, 3.0x/ prefixes\n'
                '• Package assets: packages/<package_name>/path\n'
                '• Paths must match pubspec.yaml asset declarations',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildScalePropertySection() {
  print('Building scale property section');
  List<double> scales = [1.0, 1.5, 2.0, 3.0, 4.0];
  List<String> scaleLabels = ['1x', '1.5x', '2x', '3x', '4x'];
  List<String> descriptions = [
    'Base resolution (mdpi)',
    'Between 1x and 2x',
    'High resolution (xhdpi)',
    'Extra high (xxhdpi)',
    'Extra extra high (xxxhdpi)',
  ];
  List<Color> scaleColors = [
    Colors.grey.shade500,
    Colors.blue.shade400,
    Colors.orange.shade500,
    Colors.purple.shade500,
    Colors.red.shade500,
  ];

  List<Widget> scaleCards = [];
  int s = 0;
  for (s = 0; s < scales.length; s = s + 1) {
    scaleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: scaleColors[s].withAlpha(150)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: scaleColors[s].withAlpha(40),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  scaleLabels[s],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: scaleColors[s],
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
                    'Scale: ${scales[s]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    descriptions[s],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: scaleColors[s].withAlpha(30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${(100 * scales[s]).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: scaleColors[s],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.zoom_in, color: Colors.orange.shade700),
            ),
            SizedBox(width: 12),
            Text(
              'scale Property',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Type', 'double'),
        buildInfoCard(
          'Description',
          'The scale to apply when decoding the image',
        ),
        SizedBox(height: 12),
        Text(
          'Common Scale Values',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Column(children: scaleCards),
      ],
    ),
  );
}

Widget buildEqualitySection() {
  print('Building equality comparison section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.compare, color: Colors.purple.shade700),
            ),
            SizedBox(width: 12),
            Text(
              'Equality Comparison',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Two AssetBundleImageKey instances are equal when:',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        _buildEqualityCondition(
          'Same bundle',
          'Both keys reference the identical AssetBundle instance',
          Icons.folder,
          Colors.blue,
          true,
        ),
        _buildEqualityCondition(
          'Same name',
          'The asset path strings are identical',
          Icons.text_fields,
          Colors.green,
          true,
        ),
        _buildEqualityCondition(
          'Same scale',
          'The scale values are equal',
          Icons.zoom_in,
          Colors.orange,
          true,
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'bool operator ==(Object other) {\n'
            '  if (other.runtimeType != runtimeType)\n'
            '    return false;\n'
            '  return other is AssetBundleImageKey\n'
            '      && other.bundle == bundle\n'
            '      && other.name == name\n'
            '      && other.scale == scale;\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.greenAccent.shade400,
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildComparisonExampleCard(
          'Equal Keys',
          'key1(bundle: rootBundle, name: "logo.png", scale: 2.0)\n'
          'key2(bundle: rootBundle, name: "logo.png", scale: 2.0)\n'
          'Result: key1 == key2 is TRUE',
          Colors.green,
          Icons.check_circle,
        ),
        _buildComparisonExampleCard(
          'Different Scale',
          'key1(bundle: rootBundle, name: "logo.png", scale: 1.0)\n'
          'key2(bundle: rootBundle, name: "logo.png", scale: 2.0)\n'
          'Result: key1 == key2 is FALSE',
          Colors.red,
          Icons.cancel,
        ),
        _buildComparisonExampleCard(
          'Different Name',
          'key1(bundle: rootBundle, name: "logo.png", scale: 1.0)\n'
          'key2(bundle: rootBundle, name: "icon.png", scale: 1.0)\n'
          'Result: key1 == key2 is FALSE',
          Colors.red,
          Icons.cancel,
        ),
      ],
    ),
  );
}

Widget _buildEqualityCondition(
  String condition,
  String description,
  IconData icon,
  MaterialColor color,
  bool required,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color.shade700, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                condition,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color.shade800,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: required ? Colors.green.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            required ? 'Required' : 'Optional',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: required ? Colors.green.shade700 : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonExampleCard(
  String title,
  String code,
  MaterialColor color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color.shade700, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                code,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildHashCodeSection() {
  print('Building hashCode section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.tag, color: Colors.indigo.shade700),
            ),
            SizedBox(width: 12),
            Text(
              'hashCode Property',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Type', 'int'),
        buildInfoCard(
          'Purpose',
          'Provides hash value for use in hash-based collections',
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
            'int get hashCode => Object.hash(bundle, name, scale);',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Colors.greenAccent.shade400,
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Hash Code Properties',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildHashPropertyRow(
          'Consistency',
          'Same key always produces same hash',
          Icons.sync,
        ),
        _buildHashPropertyRow(
          'Equality',
          'Equal keys have equal hash codes',
          Icons.check,
        ),
        _buildHashPropertyRow(
          'Distribution',
          'Good distribution for hash-based lookups',
          Icons.scatter_plot,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.indigo.shade600),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The hashCode is used by ImageCache to quickly locate cached images in its internal HashMap.',
                  style: TextStyle(fontSize: 13, color: Colors.indigo.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHashPropertyRow(String title, String description, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.indigo.shade600, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.indigo.shade800,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildImageProviderUsageSection() {
  print('Building ImageProvider usage section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.image, color: Colors.cyan.shade700),
            ),
            SizedBox(width: 12),
            Text(
              'Usage with ImageProvider',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'AssetImage Class Relationship',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildProviderFlowStep(
          '1',
          'AssetImage Created',
          'AssetImage("images/logo.png")',
          Colors.cyan.shade100,
        ),
        _buildProviderFlowArrow(),
        _buildProviderFlowStep(
          '2',
          'obtainKey() Called',
          'Resolves configuration for device',
          Colors.cyan.shade200,
        ),
        _buildProviderFlowArrow(),
        _buildProviderFlowStep(
          '3',
          'Key Resolution',
          'Determines bundle, actual path, scale',
          Colors.cyan.shade300,
        ),
        _buildProviderFlowArrow(),
        _buildProviderFlowStep(
          '4',
          'AssetBundleImageKey Created',
          'Contains: bundle + name + scale',
          Colors.cyan.shade400,
        ),
        _buildProviderFlowArrow(),
        _buildProviderFlowStep(
          '5',
          'ImageCache Lookup',
          'Key used to find/store cached image',
          Colors.cyan.shade500,
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '// How AssetImage creates the key\n'
            'Future<AssetBundleImageKey> obtainKey(\n'
            '    ImageConfiguration configuration,\n'
            ') {\n'
            '  return bundle.resolve(assetName)\n'
            '    .then((resolved) => AssetBundleImageKey(\n'
            '      bundle: bundle,\n'
            '      name: resolved.path,\n'
            '      scale: resolved.scale,\n'
            '    ));\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.greenAccent.shade400,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildProviderFlowStep(
  String step,
  String title,
  String description,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(60),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
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
              step,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
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
                  fontSize: 14,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildProviderFlowArrow() {
  return Container(
    height: 20,
    child: Center(
      child: Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 20),
    ),
  );
}

Widget buildCachingBehaviorSection() {
  print('Building caching behavior section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.cached, color: Colors.amber.shade800),
            ),
            SizedBox(width: 12),
            Text(
              'Caching Behavior Visualization',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCacheScenarioCard(
          'Cache Hit',
          'Image found in cache by key lookup',
          [
            'Request: logo.png @ 2x',
            'Key exists in ImageCache',
            'Return cached ImageStreamCompleter',
            'No disk/network I/O needed',
          ],
          Colors.green,
          Icons.check_circle,
        ),
        SizedBox(height: 12),
        _buildCacheScenarioCard(
          'Cache Miss',
          'Image not in cache, must be loaded',
          [
            'Request: logo.png @ 2x',
            'Key NOT in ImageCache',
            'Load from AssetBundle',
            'Decode image bytes',
            'Store in cache with key',
          ],
          Colors.orange,
          Icons.warning,
        ),
        SizedBox(height: 12),
        _buildCacheScenarioCard(
          'Scale Variant Miss',
          'Same image, different scale = different key',
          [
            'Cache has: logo.png @ 1x',
            'Request: logo.png @ 2x',
            'Different key (different scale)',
            'Must load 2x variant separately',
          ],
          Colors.red,
          Icons.cancel,
        ),
        SizedBox(height: 16),
        Text(
          'Cache Key Structure',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildCacheKeyDiagram(),
      ],
    ),
  );
}

Widget _buildCacheScenarioCard(
  String title,
  String description,
  List<String> steps,
  MaterialColor color,
  IconData icon,
) {
  List<Widget> stepWidgets = [];
  int i = 0;
  for (i = 0; i < steps.length; i = i + 1) {
    stepWidgets.add(
      Padding(
        padding: EdgeInsets.only(left: 36, top: 2, bottom: 2),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color.shade400,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                steps[i],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color.shade600, size: 24),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: color.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Padding(
          padding: EdgeInsets.only(left: 32),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
        SizedBox(height: 8),
        Column(children: stepWidgets),
      ],
    ),
  );
}

Widget _buildCacheKeyDiagram() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildKeyPart('bundle', 'AssetBundle', Colors.blue),
            SizedBox(width: 8),
            Text('+', style: TextStyle(fontSize: 20, color: Colors.grey)),
            SizedBox(width: 8),
            _buildKeyPart('name', 'String', Colors.green),
            SizedBox(width: 8),
            Text('+', style: TextStyle(fontSize: 20, color: Colors.grey)),
            SizedBox(width: 8),
            _buildKeyPart('scale', 'double', Colors.orange),
          ],
        ),
        SizedBox(height: 16),
        Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 24),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade400),
          ),
          child: Text(
            'Unique Cache Key',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.teal.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyPart(String name, String type, MaterialColor color) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color.shade800,
          ),
        ),
        Text(
          type,
          style: TextStyle(fontSize: 10, color: color.shade600),
        ),
      ],
    ),
  );
}

Widget buildKeyComparisonDemos() {
  print('Building key comparison demos');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.compare_arrows, color: Colors.deepPurple.shade700),
            ),
            SizedBox(width: 12),
            Text(
              'Key Comparison Demos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildComparisonDemo(
          'Scenario 1: Identical Keys',
          'Both keys have same bundle, name, and scale',
          'AssetBundleImageKey(bundle: rootBundle, name: "a.png", scale: 1.0)',
          'AssetBundleImageKey(bundle: rootBundle, name: "a.png", scale: 1.0)',
          true,
          'Same cache entry used',
        ),
        SizedBox(height: 8),
        _buildComparisonDemo(
          'Scenario 2: Different Names',
          'Same bundle and scale, different asset path',
          'AssetBundleImageKey(bundle: rootBundle, name: "logo.png", scale: 1.0)',
          'AssetBundleImageKey(bundle: rootBundle, name: "icon.png", scale: 1.0)',
          false,
          'Different cache entries',
        ),
        SizedBox(height: 8),
        _buildComparisonDemo(
          'Scenario 3: Different Scales',
          'Same bundle and name, different resolution',
          'AssetBundleImageKey(bundle: rootBundle, name: "bg.png", scale: 1.0)',
          'AssetBundleImageKey(bundle: rootBundle, name: "bg.png", scale: 2.0)',
          false,
          '1x and 2x cached separately',
        ),
        SizedBox(height: 8),
        _buildComparisonDemo(
          'Scenario 4: Resolution Variant Path',
          'Scale affects which file is loaded',
          'AssetBundleImageKey(bundle: rb, name: "2.0x/img.png", scale: 2.0)',
          'AssetBundleImageKey(bundle: rb, name: "3.0x/img.png", scale: 3.0)',
          false,
          'Each variant cached with its path',
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Insight',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'The ImageCache uses these keys to determine if an image is already loaded. '
                'Two images with different scales (even if logically the same asset) '
                'will occupy separate cache entries because they have different AssetBundleImageKey instances.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonDemo(
  String title,
  String description,
  String key1,
  String key2,
  bool equal,
  String result,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: equal ? Colors.green.shade50 : Colors.red.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: equal ? Colors.green.shade300 : Colors.red.shade300,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              equal ? Icons.check_circle : Icons.cancel,
              color: equal ? Colors.green.shade600 : Colors.red.shade600,
              size: 20,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: equal ? Colors.green.shade800 : Colors.red.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key 1: $key1',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Key 2: $key2',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Text(
              'Result: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: equal ? Colors.green.shade200 : Colors.red.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                equal ? 'EQUAL' : 'NOT EQUAL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: equal ? Colors.green.shade900 : Colors.red.shade900,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                result,
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildResolutionAwareSection() {
  print('Building resolution aware section');
  List<String> devices = ['iPhone SE', 'iPhone 14', 'iPhone 14 Pro Max', 'iPad Pro'];
  List<double> pixelRatios = [2.0, 3.0, 3.0, 2.0];
  List<String> selectedVariants = ['2.0x/logo.png', '3.0x/logo.png', '3.0x/logo.png', '2.0x/logo.png'];
  List<IconData> deviceIcons = [Icons.phone_iphone, Icons.phone_iphone, Icons.phone_iphone, Icons.tablet_mac];

  List<Widget> deviceCards = [];
  int d = 0;
  for (d = 0; d < devices.length; d = d + 1) {
    deviceCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueGrey.shade200),
        ),
        child: Row(
          children: [
            Icon(deviceIcons[d], color: Colors.blueGrey.shade600, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    devices[d],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Pixel Ratio: ${pixelRatios[d]}x',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                selectedVariants[d],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.devices, color: Colors.blueGrey.shade700),
            ),
            SizedBox(width: 12),
            Text(
              'Resolution-Aware Key Selection',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Device to Variant Mapping',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Column(children: deviceCards),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blueGrey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How Resolution Selection Works',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.blueGrey.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Device pixel ratio is determined from MediaQuery\n'
                '2. AssetBundle.resolve() finds best matching variant\n'
                '3. AssetBundleImageKey is created with resolved path and scale\n'
                '4. The key uniquely identifies this resolution variant',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSummarySection() {
  print('Building summary section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade600, Colors.teal.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text(
              'AssetBundleImageKey Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildSummaryItem(
          'Purpose',
          'Uniquely identifies an asset image for caching',
        ),
        _buildSummaryItem(
          'Components',
          'bundle (AssetBundle) + name (String) + scale (double)',
        ),
        _buildSummaryItem(
          'Equality',
          'Two keys equal when all three properties match',
        ),
        _buildSummaryItem(
          'Cache Key',
          'Used by ImageCache for efficient image lookup',
        ),
        _buildSummaryItem(
          'Resolution',
          'Different scales create different cache entries',
        ),
        _buildSummaryItem(
          'Creation',
          'Auto-generated by AssetImage.obtainKey()',
        ),
      ],
    ),
  );
}

Widget _buildSummaryItem(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(25),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.tealAccent.shade100,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('AssetBundleImageKey deep demo executing');
  print('AssetBundleImageKey: Unique identifier for cached asset images');

  Widget result = Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      title: Text('AssetBundleImageKey Demo'),
      backgroundColor: Colors.teal.shade700,
      foregroundColor: Colors.white,
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard(
              'Class',
              'AssetBundleImageKey',
            ),
            buildInfoCard(
              'Library',
              'package:flutter/painting.dart',
            ),
            buildInfoCard(
              'Purpose',
              'Key identifying an image in an AssetBundle for caching',
            ),
            buildInfoCard(
              'Used By',
              'ImageCache to store and retrieve decoded images',
            ),

            buildSectionHeader('2. Constructor'),
            buildConstructorSection(),

            buildSectionHeader('3. bundle Property'),
            buildBundlePropertySection(),

            buildSectionHeader('4. name Property'),
            buildNamePropertySection(),

            buildSectionHeader('5. scale Property'),
            buildScalePropertySection(),

            buildSectionHeader('6. Equality Comparison'),
            buildEqualitySection(),

            buildSectionHeader('7. hashCode'),
            buildHashCodeSection(),

            buildSectionHeader('8. Usage with ImageProvider'),
            buildImageProviderUsageSection(),

            buildSectionHeader('9. Caching Behavior'),
            buildCachingBehaviorSection(),

            buildSectionHeader('10. Key Comparison Demos'),
            buildKeyComparisonDemos(),

            buildSectionHeader('11. Resolution-Aware Selection'),
            buildResolutionAwareSection(),

            buildSectionHeader('12. Summary'),
            buildSummarySection(),

            buildSectionHeader('13. Best Practices'),
            buildInfoCard(
              'Tip 1',
              'Let AssetImage handle key creation automatically',
            ),
            buildInfoCard(
              'Tip 2',
              'Provide resolution variants (2.0x, 3.0x) for crisp images',
            ),
            buildInfoCard(
              'Tip 3',
              'Same logical asset with different scales = different cache entries',
            ),
            buildInfoCard(
              'Tip 4',
              'Use ImageCache.clear() sparingly as it invalidates all keys',
            ),
            buildInfoCard(
              'Tip 5',
              'Keys are compared by value, not identity',
            ),
            buildInfoCard(
              'Tip 6',
              'Bundle identity matters - different bundles = different keys',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('AssetBundleImageKey deep demo completed');
  return result;
}
