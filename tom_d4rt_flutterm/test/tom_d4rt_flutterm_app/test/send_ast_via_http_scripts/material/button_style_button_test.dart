// D4rt test script: Tests ButtonStyleButton from material
import 'package:flutter/material.dart';

// Helper to build section title
Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade800,
      ),
    ),
  );
}

// Helper to build description
Widget buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// Helper to build info box
Widget buildInfoBox(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
      ],
    ),
  );
}

// Helper: button showcase card
Widget buildButtonCard({
  required String title,
  required String description,
  required List<Widget> buttons,
  Color? backgroundColor,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 2),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: buttons,
          ),
        ),
        SizedBox(height: 12),
      ],
    ),
  );
}

// Helper: type label
Widget buildTypeLabel(String label, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
    ),
  );
}

// Helper: style property chip
Widget buildStyleChip(String label) {
  return Container(
    margin: EdgeInsets.only(right: 6, bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(label, style: TextStyle(fontSize: 10, color: Colors.blue.shade700)),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== ButtonStyleButton Deep Demo ===');
  debugPrint('Demonstrating ElevatedButton, TextButton, OutlinedButton, FilledButton with ButtonStyle');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ButtonStyleButton Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ElevatedButton, TextButton, OutlinedButton, FilledButton with ButtonStyle',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: All Button Types Default
        buildSectionTitle('1. Button Types Overview'),
        buildDescription('All four button types with default styling'),

        buildButtonCard(
          title: 'Default Button Types',
          description: 'Each type has distinct visual hierarchy',
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Elevated')),
            FilledButton(onPressed: () {}, child: Text('Filled')),
            FilledButton.tonal(onPressed: () {}, child: Text('Filled Tonal')),
            OutlinedButton(onPressed: () {}, child: Text('Outlined')),
            TextButton(onPressed: () {}, child: Text('Text')),
          ],
        ),
        buildButtonCard(
          title: 'Disabled States',
          description: 'Buttons with null onPressed are visually disabled',
          buttons: [
            ElevatedButton(onPressed: null, child: Text('Elevated')),
            FilledButton(onPressed: null, child: Text('Filled')),
            FilledButton.tonal(onPressed: null, child: Text('Filled Tonal')),
            OutlinedButton(onPressed: null, child: Text('Outlined')),
            TextButton(onPressed: null, child: Text('Text')),
          ],
        ),

        // Section 2: ElevatedButton Styles
        buildSectionTitle('2. ElevatedButton Styles'),
        buildDescription('Custom ButtonStyle applied to ElevatedButton'),

        buildButtonCard(
          title: 'Color Variations',
          description: 'Different background and foreground colors',
          buttons: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Red'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text('Green'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
              ),
              child: Text('Orange'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: Text('Purple'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: Text('Black'),
            ),
          ],
        ),
        buildButtonCard(
          title: 'Shape Variations',
          description: 'Different RoundedRectangleBorder radius values',
          buttons: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              ),
              child: Text('Square'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Rounded'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text('Pill'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              child: Text('Stadium'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Beveled'),
            ),
          ],
        ),
        buildButtonCard(
          title: 'Elevation Variations',
          description: 'Different elevation values for shadow depth',
          buttons: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 0),
              child: Text('Flat (0)'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 2),
              child: Text('Subtle (2)'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 6),
              child: Text('Medium (6)'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 12),
              child: Text('High (12)'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(elevation: 20),
              child: Text('Max (20)'),
            ),
          ],
        ),
        buildButtonCard(
          title: 'Size Variations',
          description: 'Custom padding and minimumSize for different button sizes',
          buttons: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(60, 28),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                textStyle: TextStyle(fontSize: 11),
              ),
              child: Text('Small'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(80, 36),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text('Medium'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(120, 48),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Large'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(160, 56),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Extra Large'),
            ),
          ],
        ),

        // Section 3: TextButton Styles
        buildSectionTitle('3. TextButton Styles'),
        buildDescription('Custom styling on TextButton'),

        buildButtonCard(
          title: 'Color Variations',
          description: 'Different foreground colors on text buttons',
          buttons: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Red'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              child: Text('Green'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              child: Text('Blue'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.purple),
              child: Text('Purple'),
            ),
          ],
        ),
        buildButtonCard(
          title: 'With Background Color',
          description: 'TextButton can have a filled background if desired',
          buttons: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
              ),
              child: Text('Red Fill'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade50,
                foregroundColor: Colors.green,
              ),
              child: Text('Green Fill'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
                foregroundColor: Colors.blue,
              ),
              child: Text('Blue Fill'),
            ),
          ],
        ),

        // Section 4: OutlinedButton Styles
        buildSectionTitle('4. OutlinedButton Styles'),
        buildDescription('Custom border and color styling on OutlinedButton'),

        buildButtonCard(
          title: 'Border Color Variations',
          description: 'Different side colors and widths',
          buttons: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red, width: 2),
              ),
              child: Text('Red Border'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                side: BorderSide(color: Colors.green, width: 2),
              ),
              child: Text('Green Border'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: BorderSide(color: Colors.blue, width: 3),
              ),
              child: Text('Thick Blue'),
            ),
          ],
        ),
        buildButtonCard(
          title: 'Shape with Border',
          description: 'Combining shape and side styling',
          buttons: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: Text('Square'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.purple, width: 2),
              ),
              child: Text('Stadium'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                side: BorderSide(color: Colors.orange, width: 2),
              ),
              child: Text('Rounded'),
            ),
          ],
        ),

        // Section 5: FilledButton Styles
        buildSectionTitle('5. FilledButton Styles'),
        buildDescription('FilledButton and FilledButton.tonal with custom styles'),

        buildButtonCard(
          title: 'Filled Color Variations',
          description: 'Custom backgroundColor on FilledButton',
          buttons: [
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Red'),
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text('Green'),
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
              ),
              child: Text('Orange'),
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: Text('Purple'),
            ),
          ],
        ),
        buildButtonCard(
          title: 'Tonal Variations',
          description: 'FilledButton.tonal with lighter fills',
          buttons: [
            FilledButton.tonal(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade800,
              ),
              child: Text('Red Tonal'),
            ),
            FilledButton.tonal(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green.shade100,
                foregroundColor: Colors.green.shade800,
              ),
              child: Text('Green Tonal'),
            ),
            FilledButton.tonal(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.blue.shade800,
              ),
              child: Text('Blue Tonal'),
            ),
          ],
        ),

        // Section 6: Icons with All Types
        buildSectionTitle('6. Icon Buttons'),
        buildDescription('All button types with icon variants'),

        buildButtonCard(
          title: 'Button.icon Constructors',
          description: 'Icon + label combination for each type',
          buttons: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.upload),
              label: Text('Upload'),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text('Create'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.download),
              label: Text('Download'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.delete),
              label: Text('Delete'),
            ),
          ],
        ),
        buildButtonCard(
          title: 'Custom Icon Styling',
          description: 'Buttons with styled icons and colors',
          buttons: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.check_circle, color: Colors.white),
              label: Text('Approve'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.cancel, color: Colors.white),
              label: Text('Reject'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit, color: Colors.white),
              label: Text('Edit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),

        // Section 7: WidgetStateProperty
        buildSectionTitle('7. WidgetStateProperty Usage'),
        buildDescription('Using WidgetStateProperty for state-dependent styling'),

        buildButtonCard(
          title: 'resolveWith for Background',
          description: 'Background color changes based on widget state',
          buttons: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) return Colors.red.shade700;
                  if (states.contains(WidgetState.hovered)) return Colors.red.shade300;
                  return Colors.red;
                }),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: Text('State-aware Red'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) return Colors.blue.shade700;
                  if (states.contains(WidgetState.hovered)) return Colors.blue.shade300;
                  return Colors.blue;
                }),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: Text('State-aware Blue'),
            ),
          ],
        ),
        buildButtonCard(
          title: 'resolveWith for Elevation',
          description: 'Elevation changes on interaction state',
          buttons: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) return 0.0;
                  if (states.contains(WidgetState.hovered)) return 8.0;
                  return 2.0;
                }),
              ),
              child: Text('Dynamic Elevation'),
            ),
          ],
        ),

        // Section 8: Full Style Showcase
        buildSectionTitle('8. Complete Style Comparison'),
        buildDescription('Same action styled with each button type'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Save Action - All Button Types',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Save'),
                      ),
                      SizedBox(height: 4),
                      Text('Elevated', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  Column(
                    children: [
                      FilledButton(
                        onPressed: () {},
                        child: Text('Save'),
                      ),
                      SizedBox(height: 4),
                      Text('Filled', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  Column(
                    children: [
                      FilledButton.tonal(
                        onPressed: () {},
                        child: Text('Save'),
                      ),
                      SizedBox(height: 4),
                      Text('Tonal', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  Column(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: Text('Save'),
                      ),
                      SizedBox(height: 4),
                      Text('Outlined', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Save'),
                      ),
                      SizedBox(height: 4),
                      Text('Text', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Section 9: ButtonStyle Properties Summary
        buildSectionTitle('9. ButtonStyle Properties'),
        buildDescription('Key properties available on ButtonStyle'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: Wrap(
            children: [
              buildStyleChip('backgroundColor'),
              buildStyleChip('foregroundColor'),
              buildStyleChip('overlayColor'),
              buildStyleChip('shadowColor'),
              buildStyleChip('surfaceTintColor'),
              buildStyleChip('elevation'),
              buildStyleChip('padding'),
              buildStyleChip('minimumSize'),
              buildStyleChip('fixedSize'),
              buildStyleChip('maximumSize'),
              buildStyleChip('side'),
              buildStyleChip('shape'),
              buildStyleChip('textStyle'),
              buildStyleChip('alignment'),
              buildStyleChip('tapTargetSize'),
              buildStyleChip('animationDuration'),
              buildStyleChip('iconColor'),
              buildStyleChip('iconSize'),
            ],
          ),
        ),

        // Summary
        buildSectionTitle('10. Summary'),
        buildInfoBox(
          'ButtonStyleButton is the abstract base for ElevatedButton, FilledButton, '
          'OutlinedButton, and TextButton.',
          Colors.blue,
        ),
        buildInfoBox(
          'Each type uses styleFrom() factory for simple styling or ButtonStyle() '
          'constructor with WidgetStateProperty for state-dependent styling.',
          Colors.green,
        ),
        buildInfoBox(
          'Visual hierarchy: FilledButton > ElevatedButton > '
          'FilledButton.tonal > OutlinedButton > TextButton.',
          Colors.purple,
        ),
        buildInfoBox(
          'All button types support .icon() constructor for leading icon plus label layout.',
          Colors.orange,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}
