// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_full_hex_values_for_flutter_colors
// D4rt test script: Tests TextButton class from package:flutter/material.dart
// Deep Demo: Visual demonstration of TextButton constructors, factory variants,
// ButtonStyle integration, visual states, and theming.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextButton Deep Demo executing');

  // ============================================================
  // SECTION 1: TextButton Overview / Hero Banner
  // ============================================================
  print('=== Section 1: TextButton Overview ===');

  final heroBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1565C0),
          Color(0xFF1976D2),
          Color(0xFF42A5F5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.5, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1565C0).withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
          spreadRadius: 2.0,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, -2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.smart_button,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TextButton',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/material.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(
          'A Material Design "Text Button" - a label child displayed on a '
          'zero-elevation Material widget. Used in toolbars, dialogs, and '
          'inline content. The label uses ButtonStyle.foregroundColor and '
          'reacts to touch via ButtonStyle.backgroundColor.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.95),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildHeroChip('extends ButtonStyleButton', Icons.account_tree),
            _buildHeroChip('Material Design', Icons.design_services),
            _buildHeroChip('Zero elevation', Icons.layers_clear),
            _buildHeroChip('Themable', Icons.palette),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Default Constructor - Primary Use Cases
  // ============================================================
  print('=== Section 2: Default Constructor ===');

  final defaultConstructorCases = <Widget>[
    _buildButtonCase(
      title: 'Simple TextButton',
      description: 'Minimal usage with a Text child and onPressed callback.',
      accent: Color(0xFF1976D2),
      code: 'TextButton(\n  onPressed: () {},\n  child: Text(\'Submit\'),\n)',
      button: TextButton(
        onPressed: () {},
        child: Text('Submit'),
      ),
    ),
    _buildButtonCase(
      title: 'Disabled (onPressed: null)',
      description: 'When onPressed and onLongPress are null the button '
          'is disabled and shows the disabled foreground color.',
      accent: Color(0xFF757575),
      code: 'TextButton(\n  onPressed: null,\n  child: Text(\'Disabled\'),\n)',
      button: TextButton(
        onPressed: null,
        child: Text('Disabled'),
      ),
    ),
    _buildButtonCase(
      title: 'With autofocus',
      description: 'autofocus: true makes this the initial focused widget.',
      accent: Color(0xFFEF6C00),
      code: 'TextButton(\n  autofocus: true,\n  onPressed: () {},\n  child: Text(\'Focus me\'),\n)',
      button: TextButton(
        autofocus: false,
        onPressed: () {},
        child: Text('Focus me'),
      ),
    ),
    _buildButtonCase(
      title: 'With clipBehavior',
      description: 'Clip.antiAlias keeps splash effects inside the shape.',
      accent: Color(0xFF6A1B9A),
      code: 'TextButton(\n  clipBehavior: Clip.antiAlias,\n  onPressed: () {},\n  child: Text(\'Clipped\'),\n)',
      button: TextButton(
        clipBehavior: Clip.antiAlias,
        onPressed: () {},
        child: Text('Clipped'),
      ),
    ),
    _buildButtonCase(
      title: 'With onLongPress',
      description: 'A long-press callback distinct from the tap callback.',
      accent: Color(0xFF00897B),
      code: 'TextButton(\n  onPressed: () {},\n  onLongPress: () {},\n  child: Text(\'Hold me\'),\n)',
      button: TextButton(
        onPressed: () {},
        onLongPress: () {},
        child: Text('Hold me'),
      ),
    ),
    _buildButtonCase(
      title: 'With Icon child',
      description: 'A bare Icon widget can also serve as the child label.',
      accent: Color(0xFFC62828),
      code: 'TextButton(\n  onPressed: () {},\n  child: Icon(Icons.favorite),\n)',
      button: TextButton(
        onPressed: () {},
        child: Icon(Icons.favorite, color: Color(0xFFC62828)),
      ),
    ),
  ];

  // ============================================================
  // SECTION 3: TextButton.icon Factory
  // ============================================================
  print('=== Section 3: TextButton.icon Factory ===');

  final iconFactoryCases = <Widget>[
    _buildButtonCase(
      title: 'TextButton.icon - basic',
      description: 'Convenience factory pairing an icon and a label widget.',
      accent: Color(0xFF1976D2),
      code: 'TextButton.icon(\n  onPressed: () {},\n  icon: Icon(Icons.add),\n  label: Text(\'Add Item\'),\n)',
      button: TextButton.icon(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text('Add Item'),
      ),
    ),
    _buildButtonCase(
      title: 'TextButton.icon - start alignment',
      description: 'iconAlignment: IconAlignment.start places the icon '
          'before the label (default in LTR).',
      accent: Color(0xFF388E3C),
      code: 'TextButton.icon(\n  iconAlignment: IconAlignment.start,\n  ...\n)',
      button: TextButton.icon(
        onPressed: () {},
        iconAlignment: IconAlignment.start,
        icon: Icon(Icons.send),
        label: Text('Send Message'),
      ),
    ),
    _buildButtonCase(
      title: 'TextButton.icon - end alignment',
      description: 'iconAlignment: IconAlignment.end positions the icon '
          'after the label, useful for forward navigation.',
      accent: Color(0xFFEF6C00),
      code: 'TextButton.icon(\n  iconAlignment: IconAlignment.end,\n  ...\n)',
      button: TextButton.icon(
        onPressed: () {},
        iconAlignment: IconAlignment.end,
        icon: Icon(Icons.arrow_forward),
        label: Text('Continue'),
      ),
    ),
    _buildButtonCase(
      title: 'TextButton.icon - null icon',
      description: 'When icon is null the factory degrades gracefully to '
          'a plain TextButton showing only the label.',
      accent: Color(0xFF6A1B9A),
      code: 'TextButton.icon(\n  icon: null,\n  label: Text(\'No Icon\'),\n)',
      button: TextButton.icon(
        onPressed: () {},
        icon: null,
        label: Text('No Icon'),
      ),
    ),
    _buildButtonCase(
      title: 'TextButton.icon - disabled',
      description: 'When onPressed is null the icon and label are both '
          'tinted with the disabled foreground color.',
      accent: Color(0xFF757575),
      code: 'TextButton.icon(\n  onPressed: null,\n  icon: Icon(Icons.lock),\n  label: Text(\'Locked\'),\n)',
      button: TextButton.icon(
        onPressed: null,
        icon: Icon(Icons.lock),
        label: Text('Locked'),
      ),
    ),
    _buildButtonCase(
      title: 'TextButton.icon - Clip.none',
      description: 'TextButton.icon defaults to Clip.none unlike the '
          'default constructor which uses Clip.hardEdge.',
      accent: Color(0xFF00897B),
      code: 'TextButton.icon(\n  clipBehavior: Clip.none,\n  ...\n)',
      button: TextButton.icon(
        onPressed: () {},
        clipBehavior: Clip.none,
        icon: Icon(Icons.bookmark),
        label: Text('Save'),
      ),
    ),
  ];

  // ============================================================
  // SECTION 4: ButtonStyle.styleFrom - Color Configuration
  // ============================================================
  print('=== Section 4: styleFrom Colors ===');

  final styleFromColorCases = <Widget>[
    _buildButtonCase(
      title: 'foregroundColor',
      description: 'Sets the label and icon color when enabled.',
      accent: Color(0xFFD81B60),
      code: 'TextButton.styleFrom(\n  foregroundColor: Colors.pink,\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFFD81B60),
        ),
        onPressed: () {},
        child: Text('Pink Label'),
      ),
    ),
    _buildButtonCase(
      title: 'backgroundColor',
      description: 'Tints the underlying Material with a fill color.',
      accent: Color(0xFF1565C0),
      code: 'TextButton.styleFrom(\n  backgroundColor: Color(0xFFE3F2FD),\n  foregroundColor: Color(0xFF1565C0),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFFE3F2FD),
          foregroundColor: Color(0xFF1565C0),
        ),
        onPressed: () {},
        child: Text('Filled Variant'),
      ),
    ),
    _buildButtonCase(
      title: 'disabledForegroundColor',
      description: 'Override the default 38% opacity disabled label color.',
      accent: Color(0xFF424242),
      code: 'TextButton.styleFrom(\n  disabledForegroundColor: Colors.red.shade200,\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          disabledForegroundColor: Color(0xFFEF9A9A),
        ),
        onPressed: null,
        child: Text('Custom Disabled'),
      ),
    ),
    _buildButtonCase(
      title: 'disabledBackgroundColor',
      description: 'Custom background tint when disabled.',
      accent: Color(0xFF424242),
      code: 'TextButton.styleFrom(\n  disabledBackgroundColor: Color(0xFFEEEEEE),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          disabledBackgroundColor: Color(0xFFEEEEEE),
          backgroundColor: Color(0xFFE3F2FD),
        ),
        onPressed: null,
        child: Text('Disabled BG'),
      ),
    ),
    _buildButtonCase(
      title: 'shadowColor + elevation',
      description: 'Although TextButton defaults to elevation 0, a custom '
          'elevation produces a shadow tinted with shadowColor.',
      accent: Color(0xFF6A1B9A),
      code: 'TextButton.styleFrom(\n  elevation: 4,\n  shadowColor: Colors.purple,\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          elevation: 4.0,
          shadowColor: Color(0xFF6A1B9A),
          backgroundColor: Color(0xFFF3E5F5),
          foregroundColor: Color(0xFF6A1B9A),
        ),
        onPressed: () {},
        child: Text('Elevated Text'),
      ),
    ),
    _buildButtonCase(
      title: 'overlayColor',
      description: 'Color used for pressed/hovered/focused highlight. '
          'Pass Colors.transparent to defeat the highlight entirely.',
      accent: Color(0xFFEF6C00),
      code: 'TextButton.styleFrom(\n  overlayColor: Colors.transparent,\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFFEF6C00),
          overlayColor: Colors.transparent,
        ),
        onPressed: () {},
        child: Text('No Highlight'),
      ),
    ),
    _buildButtonCase(
      title: 'iconColor',
      description: 'iconColor is used independently of foregroundColor.',
      accent: Color(0xFF00897B),
      code: 'TextButton.styleFrom(\n  iconColor: Colors.teal,\n  foregroundColor: Colors.black,\n)',
      button: TextButton.icon(
        style: TextButton.styleFrom(
          iconColor: Color(0xFF00897B),
          foregroundColor: Color(0xFF212121),
        ),
        onPressed: () {},
        icon: Icon(Icons.cloud_upload),
        label: Text('Upload'),
      ),
    ),
    _buildButtonCase(
      title: 'disabledIconColor',
      description: 'Override the icon color when the button is disabled.',
      accent: Color(0xFFC62828),
      code: 'TextButton.styleFrom(\n  disabledIconColor: Colors.red.shade100,\n)',
      button: TextButton.icon(
        style: TextButton.styleFrom(
          disabledIconColor: Color(0xFFFFCDD2),
        ),
        onPressed: null,
        icon: Icon(Icons.warning),
        label: Text('Disabled Icon'),
      ),
    ),
  ];

  // ============================================================
  // SECTION 5: Sizing, Padding, Shape
  // ============================================================
  print('=== Section 5: Sizing, Padding, Shape ===');

  final sizingCases = <Widget>[
    _buildButtonCase(
      title: 'minimumSize',
      description: 'Force a minimum width and height for the tap target.',
      accent: Color(0xFF1976D2),
      code: 'TextButton.styleFrom(\n  minimumSize: Size(180, 48),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(180.0, 48.0),
          backgroundColor: Color(0xFFE3F2FD),
        ),
        onPressed: () {},
        child: Text('Min 180x48'),
      ),
    ),
    _buildButtonCase(
      title: 'fixedSize',
      description: 'Lock the button to a specific size - overrides '
          'intrinsic content sizing.',
      accent: Color(0xFFEF6C00),
      code: 'TextButton.styleFrom(\n  fixedSize: Size(220, 56),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          fixedSize: Size(220.0, 56.0),
          backgroundColor: Color(0xFFFFE0B2),
          foregroundColor: Color(0xFFEF6C00),
        ),
        onPressed: () {},
        child: Text('Fixed 220x56'),
      ),
    ),
    _buildButtonCase(
      title: 'maximumSize',
      description: 'Cap the button at a maximum size - useful when the '
          'label can be very long.',
      accent: Color(0xFF388E3C),
      code: 'TextButton.styleFrom(\n  maximumSize: Size(160, 40),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          maximumSize: Size(160.0, 40.0),
          backgroundColor: Color(0xFFE8F5E9),
          foregroundColor: Color(0xFF388E3C),
        ),
        onPressed: () {},
        child: Text('Max 160x40 long label'),
      ),
    ),
    _buildButtonCase(
      title: 'padding - symmetric',
      description: 'Custom internal padding between content and bounds.',
      accent: Color(0xFF6A1B9A),
      code: 'TextButton.styleFrom(\n  padding: EdgeInsets.symmetric(\n    horizontal: 32, vertical: 16,\n  ),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 16.0,
          ),
          backgroundColor: Color(0xFFF3E5F5),
          foregroundColor: Color(0xFF6A1B9A),
        ),
        onPressed: () {},
        child: Text('Wide padding'),
      ),
    ),
    _buildButtonCase(
      title: 'shape - RoundedRectangle',
      description: 'Default M3 shape is StadiumBorder; M2 uses '
          'RoundedRectangleBorder with radius 4.',
      accent: Color(0xFF1565C0),
      code: 'TextButton.styleFrom(\n  shape: RoundedRectangleBorder(\n    borderRadius: BorderRadius.circular(12),\n  ),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Color(0xFFE3F2FD),
          foregroundColor: Color(0xFF1565C0),
        ),
        onPressed: () {},
        child: Text('Rounded 12'),
      ),
    ),
    _buildButtonCase(
      title: 'shape - StadiumBorder',
      description: 'Pill shape - Material 3 default.',
      accent: Color(0xFFD81B60),
      code: 'TextButton.styleFrom(\n  shape: StadiumBorder(),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Color(0xFFFCE4EC),
          foregroundColor: Color(0xFFD81B60),
        ),
        onPressed: () {},
        child: Text('Stadium'),
      ),
    ),
    _buildButtonCase(
      title: 'shape - BeveledRectangle',
      description: 'Beveled corners give a chiseled appearance.',
      accent: Color(0xFF424242),
      code: 'TextButton.styleFrom(\n  shape: BeveledRectangleBorder(\n    borderRadius: BorderRadius.circular(8),\n  ),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Color(0xFFEEEEEE),
          foregroundColor: Color(0xFF424242),
        ),
        onPressed: () {},
        child: Text('Beveled'),
      ),
    ),
    _buildButtonCase(
      title: 'side - BorderSide',
      description: 'Add an outline - unusual for a TextButton but supported.',
      accent: Color(0xFF00897B),
      code: 'TextButton.styleFrom(\n  side: BorderSide(color: Colors.teal, width: 2),\n)',
      button: TextButton(
        style: TextButton.styleFrom(
          side: BorderSide(color: Color(0xFF00897B), width: 2.0),
          foregroundColor: Color(0xFF00897B),
        ),
        onPressed: () {},
        child: Text('Bordered Text'),
      ),
    ),
  ];

  // ============================================================
  // SECTION 6: Visual States - enabled, disabled, with/without icon
  // ============================================================
  print('=== Section 6: Visual States ===');

  final stateMatrix = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE8EAF6),
          Color(0xFFC5CAE9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF3949AB).withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State Matrix',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        SizedBox(height: 12.0),
        _buildStateRow(
          stateLabel: 'enabled',
          stateColor: Color(0xFF388E3C),
          buttons: [
            TextButton(onPressed: () {}, child: Text('Default')),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit),
              label: Text('Edit'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFE3F2FD),
              ),
              onPressed: () {},
              child: Text('Filled'),
            ),
          ],
        ),
        Divider(),
        _buildStateRow(
          stateLabel: 'disabled',
          stateColor: Color(0xFF757575),
          buttons: [
            TextButton(onPressed: null, child: Text('Default')),
            TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.edit),
              label: Text('Edit'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFE3F2FD),
              ),
              onPressed: null,
              child: Text('Filled'),
            ),
          ],
        ),
        Divider(),
        _buildStateRow(
          stateLabel: 'autofocus',
          stateColor: Color(0xFFEF6C00),
          buttons: [
            TextButton(
              autofocus: false,
              onPressed: () {},
              child: Text('Will-focus'),
            ),
            TextButton.icon(
              autofocus: false,
              onPressed: () {},
              icon: Icon(Icons.star),
              label: Text('Featured'),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: ButtonStyle Property Map
  // ============================================================
  print('=== Section 7: ButtonStyle Property Map ===');

  final propertyMap = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF263238),
          Color(0xFF37474F),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: Color(0xFF80CBC4), size: 24.0),
            SizedBox(width: 12.0),
            Text(
              'styleFrom() Parameter Map',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildPropertyEntry('foregroundColor', 'Color?',
            'Label and icon color when enabled.'),
        _buildPropertyEntry('backgroundColor', 'Color?',
            'Material fill color, default transparent.'),
        _buildPropertyEntry('disabledForegroundColor', 'Color?',
            'Label color when onPressed is null.'),
        _buildPropertyEntry('disabledBackgroundColor', 'Color?',
            'Material color when disabled.'),
        _buildPropertyEntry('shadowColor', 'Color?',
            'Shadow tint when elevation > 0.'),
        _buildPropertyEntry('surfaceTintColor', 'Color?',
            'Surface tint applied per Material 3.'),
        _buildPropertyEntry('iconColor', 'Color?',
            'Icon color independent of foreground.'),
        _buildPropertyEntry('iconSize', 'double?',
            'Override icon size. Default 18 for icon factory.'),
        _buildPropertyEntry('iconAlignment', 'IconAlignment?',
            'Position icon at start or end of label.'),
        _buildPropertyEntry('disabledIconColor', 'Color?',
            'Icon color when disabled.'),
        _buildPropertyEntry('overlayColor', 'Color?',
            'Pressed / hovered / focused highlight color.'),
        _buildPropertyEntry('elevation', 'double?',
            'Resting Material elevation. Default 0.'),
        _buildPropertyEntry('textStyle', 'TextStyle?',
            'TextStyle for the label child.'),
        _buildPropertyEntry('padding', 'EdgeInsetsGeometry?',
            'Internal padding around the child.'),
        _buildPropertyEntry('minimumSize', 'Size?',
            'Minimum tap target size.'),
        _buildPropertyEntry('fixedSize', 'Size?',
            'Locks the button to an exact size.'),
        _buildPropertyEntry('maximumSize', 'Size?',
            'Caps the button to a maximum size.'),
        _buildPropertyEntry('side', 'BorderSide?',
            'Outline of the button border.'),
        _buildPropertyEntry('shape', 'OutlinedBorder?',
            'Shape of the button. Default StadiumBorder in M3.'),
        _buildPropertyEntry('enabledMouseCursor', 'MouseCursor?',
            'Cursor for enabled buttons.'),
        _buildPropertyEntry('disabledMouseCursor', 'MouseCursor?',
            'Cursor for disabled buttons.'),
        _buildPropertyEntry('visualDensity', 'VisualDensity?',
            'Density adjustment from theme.'),
        _buildPropertyEntry('tapTargetSize', 'MaterialTapTargetSize?',
            'shrinkWrap or padded tap target.'),
        _buildPropertyEntry('animationDuration', 'Duration?',
            'Duration of state-change animations.'),
        _buildPropertyEntry('enableFeedback', 'bool?',
            'Haptic and audio feedback toggle.'),
        _buildPropertyEntry('alignment', 'AlignmentGeometry?',
            'Alignment of the child within the button.'),
        _buildPropertyEntry('splashFactory',
            'InteractiveInkFeatureFactory?',
            'Splash factory - default InkRipple.splashFactory.'),
        _buildPropertyEntry('backgroundBuilder', 'ButtonLayerBuilder?',
            'Builder for content behind the button child.'),
        _buildPropertyEntry('foregroundBuilder', 'ButtonLayerBuilder?',
            'Builder for content above the button child.'),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Themed Variants - gradient backgrounds
  // ============================================================
  print('=== Section 8: Themed Variants ===');

  final themedVariants = <Widget>[
    _buildThemedTile(
      label: 'Sunrise',
      gradient: LinearGradient(
        colors: [Color(0xFFFFB74D), Color(0xFFFF7043)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: Color(0xFFFF7043),
      buttonLabel: 'Wake Up',
      icon: Icons.wb_sunny,
    ),
    _buildThemedTile(
      label: 'Ocean',
      gradient: LinearGradient(
        colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      shadowColor: Color(0xFF0288D1),
      buttonLabel: 'Dive In',
      icon: Icons.water,
    ),
    _buildThemedTile(
      label: 'Forest',
      gradient: LinearGradient(
        colors: [Color(0xFF81C784), Color(0xFF2E7D32)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: Color(0xFF2E7D32),
      buttonLabel: 'Explore',
      icon: Icons.forest,
    ),
    _buildThemedTile(
      label: 'Twilight',
      gradient: LinearGradient(
        colors: [Color(0xFF9575CD), Color(0xFF512DA8)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      shadowColor: Color(0xFF512DA8),
      buttonLabel: 'Dream',
      icon: Icons.nights_stay,
    ),
    _buildThemedTile(
      label: 'Crimson',
      gradient: LinearGradient(
        colors: [Color(0xFFE57373), Color(0xFFC62828)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: Color(0xFFC62828),
      buttonLabel: 'Engage',
      icon: Icons.local_fire_department,
    ),
    _buildThemedTile(
      label: 'Mint',
      gradient: LinearGradient(
        colors: [Color(0xFFA7FFEB), Color(0xFF00897B)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      shadowColor: Color(0xFF00897B),
      buttonLabel: 'Refresh',
      icon: Icons.eco,
    ),
  ];

  // ============================================================
  // SECTION 9: Real-world contexts
  // ============================================================
  print('=== Section 9: Real-world contexts ===');

  final dialogContext = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Color(0xFFEF6C00), size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Dialog Action Buttons',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'TextButtons are the canonical choice for dialog actions - '
          'low emphasis, minimal visual weight, grouped at the bottom.',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xFF616161),
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('CANCEL'),
            ),
            SizedBox(width: 8.0),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFFC62828),
              ),
              onPressed: () {},
              child: Text('DELETE'),
            ),
          ],
        ),
      ],
    ),
  );

  final toolbarContext = Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFAFAFA),
          Color(0xFFEEEEEE),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.menu, color: Color(0xFF424242)),
        SizedBox(width: 16.0),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.folder_open),
          label: Text('Open'),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.save),
          label: Text('Save'),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.print),
          label: Text('Print'),
        ),
        Spacer(),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.help_outline),
          label: Text('Help'),
        ),
      ],
    ),
  );

  final cardActionContext = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.image,
              color: Colors.white.withValues(alpha: 0.6),
              size: 48.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card Title',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Cards expose actions as TextButtons in a footer row, '
                'aligned to the start to keep visual weight minimal.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Color(0xFF616161),
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('LEARN MORE'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('SHARE'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Class hierarchy diagram
  // ============================================================
  print('=== Section 10: Class hierarchy ===');

  final hierarchyDiagram = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFEDE7F6),
          Color(0xFFD1C4E9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF512DA8).withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class Hierarchy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
        SizedBox(height: 16.0),
        _buildHierarchyNode(
          'Object',
          0,
          Color(0xFF9E9E9E),
          Icons.circle_outlined,
        ),
        _buildHierarchyArrow(),
        _buildHierarchyNode(
          'DiagnosticableTree',
          1,
          Color(0xFF7E57C2),
          Icons.account_tree,
        ),
        _buildHierarchyArrow(),
        _buildHierarchyNode(
          'Widget',
          2,
          Color(0xFF5E35B1),
          Icons.widgets,
        ),
        _buildHierarchyArrow(),
        _buildHierarchyNode(
          'StatefulWidget',
          3,
          Color(0xFF512DA8),
          Icons.refresh,
        ),
        _buildHierarchyArrow(),
        _buildHierarchyNode(
          'ButtonStyleButton',
          4,
          Color(0xFF4527A0),
          Icons.smart_button,
        ),
        _buildHierarchyArrow(),
        _buildHierarchyNode(
          'TextButton',
          5,
          Color(0xFF311B92),
          Icons.touch_app,
          highlight: true,
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: _buildSiblingNode(
                'ElevatedButton',
                Color(0xFF1976D2),
                Icons.layers,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildSiblingNode(
                'OutlinedButton',
                Color(0xFF388E3C),
                Icons.crop_square,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildSiblingNode(
                'FilledButton',
                Color(0xFFEF6C00),
                Icons.format_color_fill,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE
  // ============================================================
  return MaterialApp(
    title: 'TextButton Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1565C0)),
    ),
    home: Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('TextButton - Deep Demo'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1565C0),
                Color(0xFF1976D2),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroBanner,
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '2. Default Constructor',
              'TextButton({ onPressed, child, ... })',
              Color(0xFF1976D2),
              Icons.smart_button,
            ),
            SizedBox(height: 12.0),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: defaultConstructorCases,
            ),
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '3. TextButton.icon Factory',
              'TextButton.icon({ icon, label, iconAlignment, ... })',
              Color(0xFF388E3C),
              Icons.label_important,
            ),
            SizedBox(height: 12.0),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: iconFactoryCases,
            ),
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '4. ButtonStyle.styleFrom - Color Configuration',
              'foregroundColor, backgroundColor, overlayColor, ...',
              Color(0xFFD81B60),
              Icons.palette,
            ),
            SizedBox(height: 12.0),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: styleFromColorCases,
            ),
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '5. Sizing, Padding & Shape',
              'minimumSize, fixedSize, maximumSize, padding, shape, side',
              Color(0xFF6A1B9A),
              Icons.straighten,
            ),
            SizedBox(height: 12.0),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: sizingCases,
            ),
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '6. Visual States',
              'enabled / disabled / autofocus combinations',
              Color(0xFF3949AB),
              Icons.toggle_on,
            ),
            SizedBox(height: 12.0),
            stateMatrix,
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '7. ButtonStyle Property Map',
              'Every parameter accepted by TextButton.styleFrom()',
              Color(0xFF263238),
              Icons.list_alt,
            ),
            SizedBox(height: 12.0),
            propertyMap,
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '8. Themed Variants',
              'styleFrom() + decorative wrappers',
              Color(0xFFEF6C00),
              Icons.color_lens,
            ),
            SizedBox(height: 12.0),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: themedVariants,
            ),
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '9. Real-world Contexts',
              'Where TextButtons are most idiomatic',
              Color(0xFF00897B),
              Icons.app_settings_alt,
            ),
            SizedBox(height: 12.0),
            dialogContext,
            SizedBox(height: 16.0),
            toolbarContext,
            SizedBox(height: 16.0),
            cardActionContext,
            SizedBox(height: 28.0),
            _buildSectionHeader(
              '10. Class Hierarchy',
              'Where TextButton fits in the Material button family',
              Color(0xFF512DA8),
              Icons.account_tree,
            ),
            SizedBox(height: 12.0),
            hierarchyDiagram,
            SizedBox(height: 28.0),
            _buildFooterCard(),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

Widget _buildHeroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(
  String title,
  String subtitle,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.1),
          color.withValues(alpha: 0.02),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.08),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: color.withValues(alpha: 0.75),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildButtonCase({
  required String title,
  required String description,
  required Color accent,
  required String code,
  required Widget button,
}) {
  return Container(
    width: 320.0,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.25),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF616161),
            height: 1.35,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent.withValues(alpha: 0.04),
                accent.withValues(alpha: 0.10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: accent.withValues(alpha: 0.15),
              width: 1.0,
            ),
          ),
          child: Center(child: button),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF80CBC4),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateRow({
  required String stateLabel,
  required Color stateColor,
  required List<Widget> buttons,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 110.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: stateColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: stateColor.withValues(alpha: 0.5),
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text(
                stateLabel,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: stateColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: buttons,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyEntry(String name, String type, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6.0,
          height: 6.0,
          margin: EdgeInsets.only(top: 6.0, right: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF80CBC4),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFAB91),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF455A64),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: Color(0xFFB2DFDB),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFFCFD8DC),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildThemedTile({
  required String label,
  required LinearGradient gradient,
  required Color shadowColor,
  required String buttonLabel,
  required IconData icon,
}) {
  return Container(
    width: 200.0,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.15),
          blurRadius: 4.0,
          offset: Offset(0.0, -2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.92),
            foregroundColor: shadowColor,
            shape: StadiumBorder(),
            padding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              letterSpacing: 0.5,
            ),
          ),
          onPressed: () {},
          child: Text(buttonLabel.toUpperCase()),
        ),
        SizedBox(height: 8.0),
        Text(
          'styleFrom + gradient parent',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.white.withValues(alpha: 0.85),
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyNode(
  String name,
  int depth,
  Color color,
  IconData icon, {
  bool highlight = false,
}) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 12.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: highlight ? color : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: highlight ? 0.0 : 1.5),
        boxShadow: highlight
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.45),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: highlight ? Colors.white : color,
            size: 18.0,
          ),
          SizedBox(width: 8.0),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.white : color,
            ),
          ),
          if (highlight) ...[
            SizedBox(width: 8.0),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'YOU ARE HERE',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

Widget _buildHierarchyArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
    child: Icon(
      Icons.arrow_downward,
      color: Color(0xFF7E57C2),
      size: 16.0,
    ),
  );
}

Widget _buildSiblingNode(String name, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color.withValues(alpha: 0.4),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24.0),
        SizedBox(height: 6.0),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.0),
        Text(
          'sibling',
          style: TextStyle(
            fontSize: 9.0,
            color: color.withValues(alpha: 0.7),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooterCard() {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF263238),
          Color(0xFF37474F),
          Color(0xFF455A64),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF80CBC4), size: 24.0),
            SizedBox(width: 12.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'TextButton is the lowest-emphasis Material button: zero '
          'elevation, transparent background by default, and intended '
          'for inline actions where visual prominence would be a '
          'distraction. It is constructed either via the default '
          'constructor or the .icon factory, and its appearance is '
          'controlled almost entirely through ButtonStyle, which is '
          'most easily produced via the static styleFrom() helper.',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xFFCFD8DC),
            height: 1.55,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildFooterTag('low emphasis', Color(0xFF80CBC4)),
            _buildFooterTag('zero elevation', Color(0xFFFFAB91)),
            _buildFooterTag('themable', Color(0xFFCE93D8)),
            _buildFooterTag('Material 2/3', Color(0xFF90CAF9)),
            _buildFooterTag('extends ButtonStyleButton', Color(0xFFA5D6A7)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFooterTag(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}
