// D4rt test script: Tests InteractiveInkFeatureFactory from material
import 'package:flutter/material.dart';

// Helper: section header with icon and gradient background
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

// Helper: info card with label and description
Widget buildInfoCard(String label, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: color)),
              SizedBox(height: 2),
              Text(description,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: tappable ink card with configurable splash factory via Theme
Widget buildInkCard(
  BuildContext context,
  String label,
  String subtitle,
  Color cardColor,
  Color splashColor,
  Color highlightColor,
  InteractiveInkFeatureFactory? factory,
) {
  Widget inkContent = Material(
    color: cardColor.withValues(alpha: 0.1),
    borderRadius: BorderRadius.circular(10),
    child: InkWell(
      splashColor: splashColor,
      highlightColor: highlightColor,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        print('Tapped: $label');
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: cardColor)),
            SizedBox(height: 4),
            Text(subtitle,
                style:
                    TextStyle(fontSize: 11, color: Colors.grey.shade700)),
          ],
        ),
      ),
    ),
  );

  if (factory != null) {
    inkContent = Theme(
      data: Theme.of(context).copyWith(splashFactory: factory),
      child: inkContent,
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: inkContent,
  );
}

// Helper: labeled comparison card in a row
Widget buildComparisonCard(
  BuildContext context,
  String label,
  Color color,
  InteractiveInkFeatureFactory factory,
) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Theme(
        data: Theme.of(context).copyWith(splashFactory: factory),
        child: Material(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              print('Comparison tap: $label');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Column(
                children: [
                  Icon(Icons.touch_app, color: color, size: 28),
                  SizedBox(height: 6),
                  Text(label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: color)),
                  SizedBox(height: 2),
                  Text('Tap me',
                      style: TextStyle(
                          fontSize: 10, color: Colors.grey.shade500)),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// Main entry point
dynamic build(BuildContext context) {
  print('InteractiveInkFeatureFactory deep demo: starting build');

  // Section 1: Default Splash Factory
  print('Section 1: Default splash factory on InkWell');
  final Widget defaultSplashSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Default Splash Factory', Icons.water_drop, Colors.blue),
      buildInfoCard(
          'InteractiveInkFeatureFactory',
          'A typedef for a factory that creates ink splash effects. The default factory creates the standard Material splash.',
          Colors.blue),
      buildInfoCard(
          'Default behavior',
          'When no splashFactory is specified in the Theme, Flutter uses the default InkSplash factory.',
          Colors.blue),
      Material(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            print('Default splash tapped');
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.touch_app, color: Colors.blue, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Default Ink Splash',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800)),
                      SizedBox(height: 4),
                      Text(
                          'Tap this card to see the default splash effect provided by the framework.',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.blue.shade300),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 2: InkSplash.splashFactory
  print('Section 2: InkSplash.splashFactory explicitly applied');
  final Widget inkSplashSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'InkSplash.splashFactory', Icons.blur_circular, Colors.indigo),
      buildInfoCard(
          'InkSplash',
          'Creates a circular splash that expands outward from the tap point. This is the classic Material splash.',
          Colors.indigo),
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkSplash.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            color: Colors.indigo.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                print('InkSplash.splashFactory tapped');
              },
              child: Container(
                padding: EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.blur_circular,
                          color: Colors.indigo, size: 24),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('InkSplash Factory',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo)),
                          SizedBox(height: 3),
                          Text(
                              'Circular splash expanding from the tap point.',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkSplash.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            color: Colors.indigo.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.indigo.withValues(alpha: 0.3),
              onTap: () {
                print('InkSplash with custom color tapped');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Text('InkSplash with custom splashColor',
                    style: TextStyle(fontSize: 12, color: Colors.indigo.shade700)),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 3: InkRipple.splashFactory
  print('Section 3: InkRipple.splashFactory');
  final Widget inkRippleSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'InkRipple.splashFactory', Icons.waves, Colors.teal),
      buildInfoCard(
          'InkRipple',
          'Creates a ripple effect that fills the entire widget area. More dramatic than InkSplash.',
          Colors.teal),
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            color: Colors.teal.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                print('InkRipple.splashFactory tapped');
              },
              child: Container(
                padding: EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.teal.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.waves, color: Colors.teal, size: 24),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('InkRipple Factory',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                          SizedBox(height: 3),
                          Text(
                              'Full-area ripple that fills the entire widget bounds.',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            color: Colors.teal.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.teal.withValues(alpha: 0.25),
              highlightColor: Colors.teal.withValues(alpha: 0.1),
              onTap: () {
                print('InkRipple with custom colors tapped');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Text('InkRipple with custom splash and highlight colors',
                    style: TextStyle(fontSize: 12, color: Colors.teal.shade700)),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 4: NoSplash.splashFactory
  print('Section 4: NoSplash.splashFactory (disabling splash)');
  final Widget noSplashSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'NoSplash.splashFactory', Icons.block, Colors.red),
      buildInfoCard(
          'NoSplash',
          'Disables the splash effect entirely. Useful for custom hit feedback or when ink effects are undesired.',
          Colors.red),
      Theme(
        data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            color: Colors.red.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                print('NoSplash tapped - no visual splash');
              },
              child: Container(
                padding: EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.block, color: Colors.red, size: 24),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('No Splash Factory',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          SizedBox(height: 3),
                          Text(
                              'Tap here - no ink splash will appear. Only highlight may show.',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            color: Colors.red.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                print('NoSplash + no highlight tapped');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Text(
                    'NoSplash + transparent highlightColor = fully silent tap',
                    style: TextStyle(fontSize: 12, color: Colors.red.shade700)),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 5: Theme.of(context).splashFactory usage
  print('Section 5: Theme.of(context).splashFactory');
  final InteractiveInkFeatureFactory currentFactory =
      Theme.of(context).splashFactory;
  final String factoryName = currentFactory.toString();
  print('Current theme splash factory: $factoryName');

  final Widget themeFactorySection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Theme splashFactory', Icons.palette, Colors.deepPurple),
      buildInfoCard(
          'Theme.of(context).splashFactory',
          'Retrieves the current InteractiveInkFeatureFactory from the nearest Theme ancestor.',
          Colors.deepPurple),
      Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.deepPurple, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                  'Current factory: $factoryName',
                  style: TextStyle(
                      fontSize: 12, color: Colors.deepPurple.shade700)),
            ),
          ],
        ),
      ),
      SizedBox(height: 4),
      // Wrap in Theme with InkRipple
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
        child: Builder(
          builder: (BuildContext innerContext) {
            final InteractiveInkFeatureFactory innerFactory =
                Theme.of(innerContext).splashFactory;
            print('Inner theme factory: $innerFactory');
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Material(
                color: Colors.deepPurple.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    print('Theme-overridden InkRipple tapped');
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Overridden via Theme',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple)),
                        SizedBox(height: 4),
                        Text(
                            'This InkWell uses InkRipple because its parent Theme sets splashFactory to InkRipple.splashFactory.',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(height: 4),
      // Wrap in Theme with NoSplash
      Theme(
        data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
        child: Builder(
          builder: (BuildContext innerContext) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Material(
                color: Colors.grey.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    print('Theme-overridden NoSplash tapped');
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Theme with NoSplash',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700)),
                        SizedBox(height: 4),
                        Text(
                            'This InkWell has no splash because the parent Theme sets splashFactory to NoSplash.splashFactory.',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade500)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 6: Side-by-side comparison
  print('Section 6: Side-by-side factory comparison');
  final Widget comparisonSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Side-by-Side Comparison', Icons.compare, Colors.orange),
      buildInfoCard(
          'Visual comparison',
          'Tap each card to see the different splash effects produced by each factory.',
          Colors.orange),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            buildComparisonCard(
                context, 'InkSplash', Colors.indigo, InkSplash.splashFactory),
            buildComparisonCard(
                context, 'InkRipple', Colors.teal, InkRipple.splashFactory),
            buildComparisonCard(
                context, 'NoSplash', Colors.red, NoSplash.splashFactory),
          ],
        ),
      ),
      SizedBox(height: 6),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.lightbulb_outline,
                color: Colors.orange.shade700, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                  'InkSplash creates a circular splash from tap point. InkRipple fills the whole area. NoSplash produces nothing.',
                  style: TextStyle(
                      fontSize: 11, color: Colors.orange.shade800)),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 7: InkResponse vs InkWell with factories
  print('Section 7: InkResponse vs InkWell with different factories');
  final Widget inkResponseSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'InkResponse vs InkWell', Icons.compare_arrows, Colors.deepOrange),
      buildInfoCard(
          'InkResponse',
          'A more general version of InkWell with customizable containedInkWell, radius, and highlightShape.',
          Colors.deepOrange),
      buildInfoCard(
          'InkWell difference',
          'InkWell always contains ink within its bounds and uses a rectangular highlight. InkResponse can overflow.',
          Colors.deepOrange),
      // InkResponse with InkSplash - circular highlight
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkSplash.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Material(
            color: Colors.deepOrange.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            child: InkResponse(
              highlightShape: BoxShape.circle,
              radius: 60,
              onTap: () {
                print('InkResponse circle highlight tapped');
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.radio_button_unchecked,
                        color: Colors.deepOrange, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('InkResponse + InkSplash',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange)),
                          Text('Circle highlight, radius: 60, splash can overflow',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // InkResponse with InkRipple - contained
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Material(
            color: Colors.teal.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            child: InkResponse(
              containedInkWell: true,
              highlightShape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                print('InkResponse contained InkRipple tapped');
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.crop_square,
                        color: Colors.teal, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('InkResponse + InkRipple (contained)',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                          Text('Rectangle highlight, containedInkWell: true',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // InkWell with InkRipple for contrast
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Material(
            color: Colors.indigo.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                print('InkWell with InkRipple (always contained)');
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.rectangle_outlined,
                        color: Colors.indigo, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('InkWell + InkRipple',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo)),
                          Text('Always contained, always rectangular',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 8: Custom splashColor and highlightColor
  print('Section 8: Custom splashColor and highlightColor with factories');
  final Widget customColorsSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Custom Splash & Highlight Colors', Icons.color_lens, Colors.purple),
      buildInfoCard(
          'Color customization',
          'splashColor and highlightColor on InkWell interact with the chosen factory to produce different visual results.',
          Colors.purple),
      buildInkCard(
        context,
        'Pink splash + InkSplash',
        'splashColor: pink, highlightColor: pink light',
        Colors.pink,
        Colors.pink.withValues(alpha: 0.4),
        Colors.pink.withValues(alpha: 0.1),
        InkSplash.splashFactory,
      ),
      buildInkCard(
        context,
        'Amber splash + InkRipple',
        'splashColor: amber, highlightColor: amber light',
        Colors.amber.shade800,
        Colors.amber.withValues(alpha: 0.4),
        Colors.amber.withValues(alpha: 0.1),
        InkRipple.splashFactory,
      ),
      buildInkCard(
        context,
        'Green splash + InkSplash',
        'splashColor: green, highlightColor: green light',
        Colors.green,
        Colors.green.withValues(alpha: 0.35),
        Colors.green.withValues(alpha: 0.08),
        InkSplash.splashFactory,
      ),
      buildInkCard(
        context,
        'Cyan splash + InkRipple',
        'splashColor: cyan, highlightColor: cyan light',
        Colors.cyan.shade700,
        Colors.cyan.withValues(alpha: 0.35),
        Colors.cyan.withValues(alpha: 0.1),
        InkRipple.splashFactory,
      ),
      buildInkCard(
        context,
        'Red splash + NoSplash',
        'splashColor set but NoSplash overrides - no splash visible',
        Colors.red,
        Colors.red.withValues(alpha: 0.4),
        Colors.red.withValues(alpha: 0.1),
        NoSplash.splashFactory,
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 9: Material widget with splash factories
  print('Section 9: Material widget with different splash factories');
  final Widget materialSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Material Widget Integration', Icons.layers, Colors.brown),
      buildInfoCard(
          'Material as ink host',
          'Material is required as an ancestor for InkWell/InkResponse. Its type and elevation affect ink rendering.',
          Colors.brown),
      // Card-type material with InkSplash
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkSplash.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Material(
            type: MaterialType.card,
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                print('Material card + InkSplash tapped');
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.brown.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.style,
                          color: Colors.brown, size: 22),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Material(type: card) + InkSplash',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown.shade800)),
                          Text('Elevated card with circular splash',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // Canvas-type material with InkRipple
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Material(
            type: MaterialType.canvas,
            elevation: 0,
            color: Colors.lime.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.lime.withValues(alpha: 0.3),
              onTap: () {
                print('Material canvas + InkRipple tapped');
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lime.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.view_agenda,
                          color: Colors.lime.shade800, size: 22),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Material(type: canvas) + InkRipple',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lime.shade900)),
                          Text('Flat canvas with ripple fill effect',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // Transparent material with InkSplash
      Theme(
        data: Theme.of(context).copyWith(splashFactory: InkSplash.splashFactory),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.blue.withValues(alpha: 0.2),
              highlightColor: Colors.blue.withValues(alpha: 0.05),
              onTap: () {
                print('Transparent material + InkSplash tapped');
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.visibility_off,
                          color: Colors.blue, size: 22),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Material(type: transparency) + InkSplash',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800)),
                          Text('Transparent material, splash still renders on it',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // Multiple InkWells under one Material with different theme overrides
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Material(
          color: Colors.grey.shade50,
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text('Multiple InkWells under one Material',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade700)),
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(splashFactory: InkSplash.splashFactory),
                child: InkWell(
                  onTap: () {
                    print('Multi-ink item 1 tapped');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.looks_one,
                            color: Colors.indigo, size: 20),
                        SizedBox(width: 10),
                        Text('Item 1 - InkSplash factory',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade800)),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(height: 1),
              Theme(
                data: Theme.of(context)
                    .copyWith(splashFactory: InkRipple.splashFactory),
                child: InkWell(
                  onTap: () {
                    print('Multi-ink item 2 tapped');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.looks_two,
                            color: Colors.teal, size: 20),
                        SizedBox(width: 10),
                        Text('Item 2 - InkRipple factory',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade800)),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(height: 1),
              Theme(
                data: Theme.of(context)
                    .copyWith(splashFactory: NoSplash.splashFactory),
                child: InkWell(
                  onTap: () {
                    print('Multi-ink item 3 tapped');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.looks_3,
                            color: Colors.red, size: 20),
                        SizedBox(width: 10),
                        Text('Item 3 - NoSplash factory',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade800)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
      SizedBox(height: 8),
    ],
  );

  // Section 10: Summary
  print('Section 10: Summary');
  final Widget summarySection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
          'Summary', Icons.summarize, Colors.blueGrey),
      buildInfoCard(
          'InteractiveInkFeatureFactory',
          'A typedef for factories that create InteractiveInkFeature instances, used by Material widgets for tap feedback.',
          Colors.blueGrey),
      buildInfoCard(
          'Built-in factories',
          'InkSplash.splashFactory (circle from tap), InkRipple.splashFactory (fills area), NoSplash.splashFactory (none).',
          Colors.blueGrey),
      buildInfoCard(
          'Theme integration',
          'Set via ThemeData.splashFactory. Nearest Theme ancestor determines which factory InkWell/InkResponse uses.',
          Colors.blueGrey),
      buildInfoCard(
          'InkWell vs InkResponse',
          'InkWell always contains ink and uses rectangle. InkResponse allows circle highlights and overflow.',
          Colors.blueGrey),
      buildInfoCard(
          'Color control',
          'splashColor and highlightColor on InkWell customize visual appearance regardless of factory choice.',
          Colors.blueGrey),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey.withValues(alpha: 0.08),
              Colors.blueGrey.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle,
                color: Colors.blueGrey, size: 22),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                  'InteractiveInkFeatureFactory demo complete. All built-in factories demonstrated with Theme integration, color customization, and Material widget hosting.',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey.shade700)),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
    ],
  );

  print('InteractiveInkFeatureFactory deep demo: assembling final layout');

  // Assemble all sections
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultSplashSection,
        inkSplashSection,
        inkRippleSection,
        noSplashSection,
        themeFactorySection,
        comparisonSection,
        inkResponseSection,
        customColorsSection,
        materialSection,
        summarySection,
      ],
    ),
  );
}
