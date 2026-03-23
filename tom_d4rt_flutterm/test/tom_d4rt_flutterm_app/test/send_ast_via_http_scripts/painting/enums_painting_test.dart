// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests painting enums with visual demonstrations
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.purple.shade700,
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

Widget buildSubHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    margin: EdgeInsets.only(bottom: 6, top: 10),
    decoration: BoxDecoration(
      color: Colors.purple.shade100,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.purple.shade900,
      ),
    ),
  );
}

Widget buildEnumCard(String enumName, String value, String description) {
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.purple.shade600,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildBoxFitDemo(BoxFit fit, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple.shade300, width: 2),
          ),
          child: FittedBox(
            fit: fit,
            child: Container(
              width: 80,
              height: 80,
              color: Colors.purple.shade200,
              child: Center(
                child: Icon(Icons.image, color: Colors.purple.shade700, size: 40),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildImageRepeatDemo(ImageRepeat repeat, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo.shade300, width: 2),
            color: Colors.indigo.shade50,
          ),
          child: Center(
            child: Text(
              repeat.name,
              style: TextStyle(fontSize: 10, color: Colors.indigo.shade700),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildAxisDemo(Axis axis, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 100,
          height: 60,
          child: Flex(
            direction: axis,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: axis == Axis.horizontal ? 25 : 80,
                height: axis == Axis.horizontal ? 40 : 15,
                color: Colors.teal.shade300,
              ),
              Container(
                width: axis == Axis.horizontal ? 25 : 80,
                height: axis == Axis.horizontal ? 40 : 15,
                color: Colors.teal.shade500,
              ),
              Container(
                width: axis == Axis.horizontal ? 25 : 80,
                height: axis == Axis.horizontal ? 40 : 15,
                color: Colors.teal.shade700,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAxisDirectionDemo(AxisDirection direction, String label) {
  IconData arrowIcon;
  switch (direction) {
    case AxisDirection.up:
      arrowIcon = Icons.arrow_upward;
      break;
    case AxisDirection.down:
      arrowIcon = Icons.arrow_downward;
      break;
    case AxisDirection.left:
      arrowIcon = Icons.arrow_back;
      break;
    case AxisDirection.right:
      arrowIcon = Icons.arrow_forward;
      break;
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.orange.shade300),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Icon(arrowIcon, size: 36, color: Colors.orange.shade700),
      ],
    ),
  );
}

Widget buildBorderStyleDemo(BorderStyle style, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue.shade700,
              width: 3,
              style: style,
            ),
          ),
          child: Center(
            child: Text(
              style.name,
              style: TextStyle(fontSize: 10, color: Colors.blue.shade700),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextAlignDemo(TextAlign align, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.green.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Text(
            'Sample text aligned',
            textAlign: align,
            style: TextStyle(fontSize: 12, color: Colors.green.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextDirectionDemo(TextDirection direction, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Directionality(
          textDirection: direction,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('1', style: TextStyle(fontSize: 16, color: Colors.amber.shade900)),
              Icon(Icons.arrow_right_alt, color: Colors.amber.shade700),
              Text('2', style: TextStyle(fontSize: 16, color: Colors.amber.shade900)),
              Icon(Icons.arrow_right_alt, color: Colors.amber.shade700),
              Text('3', style: TextStyle(fontSize: 16, color: Colors.amber.shade900)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTextOverflowDemo(TextOverflow overflow, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.red.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Container(
          width: 150,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Text(
            'This is a very long text that should overflow',
            overflow: overflow,
            maxLines: 1,
            style: TextStyle(fontSize: 12, color: Colors.red.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildFilterQualityDemo(FilterQuality quality, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.cyan.shade300),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.cyan.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              quality.name,
              style: TextStyle(fontSize: 10, color: Colors.cyan.shade800),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildRenderComparisonDemo(RenderComparison comparison, String label, String description) {
  Color badgeColor;
  switch (comparison) {
    case RenderComparison.identical:
      badgeColor = Colors.green.shade600;
      break;
    case RenderComparison.metadata:
      badgeColor = Colors.blue.shade600;
      break;
    case RenderComparison.paint:
      badgeColor = Colors.orange.shade600;
      break;
    case RenderComparison.layout:
      badgeColor = Colors.red.shade600;
      break;
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
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

dynamic build(BuildContext context) {
  print('Painting enums test executing');

  // Log BoxFit values
  print('BoxFit values:');
  for (var value in BoxFit.values) {
    print('  BoxFit.${value.name}: index=${value.index}');
  }

  // Log ImageRepeat values
  print('ImageRepeat values:');
  for (var value in ImageRepeat.values) {
    print('  ImageRepeat.${value.name}: index=${value.index}');
  }

  // Log Axis values
  print('Axis values:');
  for (var value in Axis.values) {
    print('  Axis.${value.name}: index=${value.index}');
  }

  // Log AxisDirection values
  print('AxisDirection values:');
  for (var value in AxisDirection.values) {
    print('  AxisDirection.${value.name}: index=${value.index}');
  }

  // Log BorderStyle values
  print('BorderStyle values:');
  for (var value in BorderStyle.values) {
    print('  BorderStyle.${value.name}: index=${value.index}');
  }

  // Log TextAlign values
  print('TextAlign values:');
  for (var value in TextAlign.values) {
    print('  TextAlign.${value.name}: index=${value.index}');
  }

  // Log TextDirection values
  print('TextDirection values:');
  for (var value in TextDirection.values) {
    print('  TextDirection.${value.name}: index=${value.index}');
  }

  // Log TextOverflow values
  print('TextOverflow values:');
  for (var value in TextOverflow.values) {
    print('  TextOverflow.${value.name}: index=${value.index}');
  }

  // Log FilterQuality values
  print('FilterQuality values:');
  for (var value in FilterQuality.values) {
    print('  FilterQuality.${value.name}: index=${value.index}');
  }

  // Log RenderComparison values
  print('RenderComparison values:');
  for (var value in RenderComparison.values) {
    print('  RenderComparison.${value.name}: index=${value.index}');
  }

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title section
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade800, Colors.indigo.shade800],
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
                  Icon(Icons.palette, color: Colors.white, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Painting Enums Deep Demo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Visual demonstrations of Flutter painting enumerations',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        // Section: BoxFit
        buildSectionHeader('BoxFit Enum'),
        buildEnumCard('BoxFit', 'Overview', 'Controls how an image or content is fitted within a container'),
        buildSubHeader('BoxFit Values Visualized'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            buildBoxFitDemo(BoxFit.fill, 'fill'),
            buildBoxFitDemo(BoxFit.contain, 'contain'),
            buildBoxFitDemo(BoxFit.cover, 'cover'),
            buildBoxFitDemo(BoxFit.fitWidth, 'fitWidth'),
            buildBoxFitDemo(BoxFit.fitHeight, 'fitHeight'),
            buildBoxFitDemo(BoxFit.none, 'none'),
            buildBoxFitDemo(BoxFit.scaleDown, 'scaleDown'),
          ],
        ),
        buildEnumCard('BoxFit', 'fill', 'Stretches to fill entire space, may distort'),
        buildEnumCard('BoxFit', 'contain', 'Scales to fit while maintaining aspect ratio'),
        buildEnumCard('BoxFit', 'cover', 'Covers entire space, may clip'),
        buildEnumCard('BoxFit', 'fitWidth', 'Fits width, may overflow height'),
        buildEnumCard('BoxFit', 'fitHeight', 'Fits height, may overflow width'),
        buildEnumCard('BoxFit', 'none', 'No scaling, centered alignment'),
        buildEnumCard('BoxFit', 'scaleDown', 'Like contain but never scales up'),

        // Section: ImageRepeat
        buildSectionHeader('ImageRepeat Enum'),
        buildEnumCard('ImageRepeat', 'Overview', 'Defines how images repeat to fill available space'),
        buildSubHeader('ImageRepeat Values'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            buildImageRepeatDemo(ImageRepeat.noRepeat, 'noRepeat'),
            buildImageRepeatDemo(ImageRepeat.repeat, 'repeat'),
            buildImageRepeatDemo(ImageRepeat.repeatX, 'repeatX'),
            buildImageRepeatDemo(ImageRepeat.repeatY, 'repeatY'),
          ],
        ),
        buildEnumCard('ImageRepeat', 'noRepeat', 'Image displayed once, no tiling'),
        buildEnumCard('ImageRepeat', 'repeat', 'Image tiles in both directions'),
        buildEnumCard('ImageRepeat', 'repeatX', 'Image tiles horizontally'),
        buildEnumCard('ImageRepeat', 'repeatY', 'Image tiles vertically'),

        // Section: Axis
        buildSectionHeader('Axis Enum'),
        buildEnumCard('Axis', 'Overview', 'Represents the two directions of layout'),
        buildSubHeader('Axis Values Visualized'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildAxisDemo(Axis.horizontal, 'horizontal'),
            buildAxisDemo(Axis.vertical, 'vertical'),
          ],
        ),
        buildEnumCard('Axis', 'horizontal', 'Left-to-right or right-to-left layout'),
        buildEnumCard('Axis', 'vertical', 'Top-to-bottom layout'),

        // Section: AxisDirection
        buildSectionHeader('AxisDirection Enum'),
        buildEnumCard('AxisDirection', 'Overview', 'Indicates direction of travel along an axis'),
        buildSubHeader('AxisDirection Values'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            buildAxisDirectionDemo(AxisDirection.up, 'up'),
            buildAxisDirectionDemo(AxisDirection.down, 'down'),
            buildAxisDirectionDemo(AxisDirection.left, 'left'),
            buildAxisDirectionDemo(AxisDirection.right, 'right'),
          ],
        ),
        buildEnumCard('AxisDirection', 'up', 'From bottom towards top'),
        buildEnumCard('AxisDirection', 'down', 'From top towards bottom'),
        buildEnumCard('AxisDirection', 'left', 'From right towards left'),
        buildEnumCard('AxisDirection', 'right', 'From left towards right'),

        // Section: BorderStyle
        buildSectionHeader('BorderStyle Enum'),
        buildEnumCard('BorderStyle', 'Overview', 'Defines visual style of borders'),
        buildSubHeader('BorderStyle Values'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            buildBorderStyleDemo(BorderStyle.none, 'none'),
            buildBorderStyleDemo(BorderStyle.solid, 'solid'),
          ],
        ),
        buildEnumCard('BorderStyle', 'none', 'No border is drawn'),
        buildEnumCard('BorderStyle', 'solid', 'Solid line border'),

        // Section: TextAlign
        buildSectionHeader('TextAlign Enum'),
        buildEnumCard('TextAlign', 'Overview', 'Controls horizontal text alignment'),
        buildSubHeader('TextAlign Values'),
        buildTextAlignDemo(TextAlign.left, 'TextAlign.left'),
        buildTextAlignDemo(TextAlign.right, 'TextAlign.right'),
        buildTextAlignDemo(TextAlign.center, 'TextAlign.center'),
        buildTextAlignDemo(TextAlign.justify, 'TextAlign.justify'),
        buildTextAlignDemo(TextAlign.start, 'TextAlign.start'),
        buildTextAlignDemo(TextAlign.end, 'TextAlign.end'),
        buildEnumCard('TextAlign', 'left', 'Align text to the left edge'),
        buildEnumCard('TextAlign', 'right', 'Align text to the right edge'),
        buildEnumCard('TextAlign', 'center', 'Center text horizontally'),
        buildEnumCard('TextAlign', 'justify', 'Stretch lines to fill width'),
        buildEnumCard('TextAlign', 'start', 'Align based on text direction start'),
        buildEnumCard('TextAlign', 'end', 'Align based on text direction end'),

        // Section: TextDirection
        buildSectionHeader('TextDirection Enum'),
        buildEnumCard('TextDirection', 'Overview', 'Indicates reading direction of text'),
        buildSubHeader('TextDirection Values'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTextDirectionDemo(TextDirection.ltr, 'ltr'),
            buildTextDirectionDemo(TextDirection.rtl, 'rtl'),
          ],
        ),
        buildEnumCard('TextDirection', 'ltr', 'Left-to-right (English, etc.)'),
        buildEnumCard('TextDirection', 'rtl', 'Right-to-left (Arabic, Hebrew, etc.)'),

        // Section: TextOverflow
        buildSectionHeader('TextOverflow Enum'),
        buildEnumCard('TextOverflow', 'Overview', 'Controls how text handles overflow'),
        buildSubHeader('TextOverflow Values'),
        buildTextOverflowDemo(TextOverflow.clip, 'TextOverflow.clip'),
        buildTextOverflowDemo(TextOverflow.fade, 'TextOverflow.fade'),
        buildTextOverflowDemo(TextOverflow.ellipsis, 'TextOverflow.ellipsis'),
        buildTextOverflowDemo(TextOverflow.visible, 'TextOverflow.visible'),
        buildEnumCard('TextOverflow', 'clip', 'Clips overflow without indication'),
        buildEnumCard('TextOverflow', 'fade', 'Fades out text that overflows'),
        buildEnumCard('TextOverflow', 'ellipsis', 'Shows ... at overflow point'),
        buildEnumCard('TextOverflow', 'visible', 'Renders overflow outside bounds'),

        // Section: FilterQuality
        buildSectionHeader('FilterQuality Enum'),
        buildEnumCard('FilterQuality', 'Overview', 'Quality level for image sampling'),
        buildSubHeader('FilterQuality Values'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            buildFilterQualityDemo(FilterQuality.none, 'none'),
            buildFilterQualityDemo(FilterQuality.low, 'low'),
            buildFilterQualityDemo(FilterQuality.medium, 'medium'),
            buildFilterQualityDemo(FilterQuality.high, 'high'),
          ],
        ),
        buildEnumCard('FilterQuality', 'none', 'Fastest, pixelated scaling'),
        buildEnumCard('FilterQuality', 'low', 'Bilinear interpolation'),
        buildEnumCard('FilterQuality', 'medium', 'Mip-map based filtering'),
        buildEnumCard('FilterQuality', 'high', 'Best quality, slowest'),

        // Section: RenderComparison
        buildSectionHeader('RenderComparison Enum'),
        buildEnumCard('RenderComparison', 'Overview', 'Result of comparing render objects'),
        buildSubHeader('RenderComparison Values'),
        buildRenderComparisonDemo(
          RenderComparison.identical,
          'identical',
          'Objects are semantically identical',
        ),
        buildRenderComparisonDemo(
          RenderComparison.metadata,
          'metadata',
          'Only metadata differs, no visual change',
        ),
        buildRenderComparisonDemo(
          RenderComparison.paint,
          'paint',
          'Requires repaint but not layout',
        ),
        buildRenderComparisonDemo(
          RenderComparison.layout,
          'layout',
          'Requires full layout recalculation',
        ),
        buildEnumCard('RenderComparison', 'identical', 'No difference between objects'),
        buildEnumCard('RenderComparison', 'metadata', 'Differences in semantic info only'),
        buildEnumCard('RenderComparison', 'paint', 'Visual difference requiring repaint'),
        buildEnumCard('RenderComparison', 'layout', 'Size/position changed, needs layout'),

        // Summary section
        buildSectionHeader('Summary'),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enums Covered',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildEnumBadge('BoxFit', BoxFit.values.length, Colors.purple),
                  _buildEnumBadge('ImageRepeat', ImageRepeat.values.length, Colors.indigo),
                  _buildEnumBadge('Axis', Axis.values.length, Colors.teal),
                  _buildEnumBadge('AxisDirection', AxisDirection.values.length, Colors.orange),
                  _buildEnumBadge('BorderStyle', BorderStyle.values.length, Colors.blue),
                  _buildEnumBadge('TextAlign', TextAlign.values.length, Colors.green),
                  _buildEnumBadge('TextDirection', TextDirection.values.length, Colors.amber),
                  _buildEnumBadge('TextOverflow', TextOverflow.values.length, Colors.red),
                  _buildEnumBadge('FilterQuality', FilterQuality.values.length, Colors.cyan),
                  _buildEnumBadge('RenderComparison', RenderComparison.values.length, Colors.pink),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 32),
      ],
    ),
  );
}

Widget _buildEnumBadge(String name, int count, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.shade400),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color.shade800,
          ),
        ),
        SizedBox(width: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.shade600,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
