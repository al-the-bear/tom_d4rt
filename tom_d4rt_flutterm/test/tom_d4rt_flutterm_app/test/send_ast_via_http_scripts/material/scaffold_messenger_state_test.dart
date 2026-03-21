// D4rt test script: Tests ScaffoldMessengerState from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
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

Widget buildSnackBarAreaDisplay(
  String label,
  SnackBarBehavior behavior,
  Color backgroundColor,
  double width,
  EdgeInsets margin,
) {
  print('Building SnackBar area display: $label');
  String behaviorText = behavior == SnackBarBehavior.fixed ? 'fixed' : 'floating';
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
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Behavior: $behaviorText',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: behavior == SnackBarBehavior.floating ? 16 : 0,
                left: behavior == SnackBarBehavior.floating ? margin.left : 0,
                right: behavior == SnackBarBehavior.floating ? margin.right : 0,
                child: Container(
                  height: 48,
                  width: width > 0 ? width : null,
                  margin: EdgeInsets.symmetric(
                    horizontal: behavior == SnackBarBehavior.floating ? 0 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: behavior == SnackBarBehavior.floating
                        ? BorderRadius.circular(4)
                        : BorderRadius.zero,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'SnackBar Message',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'ACTION',
                          style: TextStyle(color: Colors.amber, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Width: ${width > 0 ? width.toStringAsFixed(0) : "full"}',
                style: TextStyle(fontSize: 11, color: Colors.indigo.shade700),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Margin: ${margin.left.toStringAsFixed(0)}/${margin.right.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 11, color: Colors.teal.shade700),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildMaterialBannerAreaDisplay(
  String label,
  Color backgroundColor,
  bool forceActionsBelow,
  int actionCount,
) {
  print('Building MaterialBanner area display: $label');
  List<Widget> actions = [];
  int i = 0;
  for (i = 0; i < actionCount; i = i + 1) {
    actions.add(
      TextButton(
        onPressed: () {},
        child: Text(
          'ACTION ${i + 1}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
    if (i < actionCount - 1) {
      actions.add(SizedBox(width: 8));
    }
  }

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
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Actions below: $forceActionsBelow',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, forceActionsBelow ? 8 : 16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.indigo.shade700),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'This is a MaterialBanner message displayed at the top',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    if (!forceActionsBelow) ...actions,
                  ],
                ),
              ),
              if (forceActionsBelow)
                Padding(
                  padding: EdgeInsets.fromLTRB(56, 0, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions,
                  ),
                ),
              Container(
                height: 1,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$actionCount action(s)',
                style: TextStyle(fontSize: 11, color: Colors.orange.shade700),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                forceActionsBelow ? 'Below layout' : 'Inline layout',
                style: TextStyle(fontSize: 11, color: Colors.purple.shade700),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildShowSnackBarBehaviorCard(
  String label,
  Duration duration,
  bool showCloseIcon,
  SnackBarBehavior behavior,
  Color actionColor,
) {
  print('Building showSnackBar behavior card: $label');
  String durationText = '${duration.inSeconds}s';
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
            Icon(Icons.notifications_active, color: Colors.indigo, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'SnackBar content message',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'UNDO',
                  style: TextStyle(color: actionColor, fontSize: 14),
                ),
              ),
              if (showCloseIcon)
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white70, size: 18),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 36, minHeight: 36),
                ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer, size: 12, color: Colors.blue.shade700),
                  SizedBox(width: 4),
                  Text(
                    'Duration: $durationText',
                    style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    showCloseIcon ? Icons.check_circle : Icons.cancel,
                    size: 12,
                    color: Colors.green.shade700,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Close: $showCloseIcon',
                    style: TextStyle(fontSize: 11, color: Colors.green.shade700),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    behavior == SnackBarBehavior.floating
                        ? Icons.layers
                        : Icons.dock,
                    size: 12,
                    color: Colors.amber.shade700,
                  ),
                  SizedBox(width: 4),
                  Text(
                    behavior == SnackBarBehavior.floating ? 'Floating' : 'Fixed',
                    style: TextStyle(fontSize: 11, color: Colors.amber.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildHideSnackBarVisualization(String reason, Color indicatorColor) {
  print('Building hideCurrentSnackBar visualization: $reason');
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
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: indicatorColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              reason,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    'SnackBar visible',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: indicatorColor),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                ),
                child: Center(
                  child: Text(
                    'SnackBar hidden',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'hideCurrentSnackBar(reason: SnackBarClosedReason.$reason)',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

Widget buildClearSnackBarsVisualization() {
  print('Building clearSnackBars visualization');
  List<Color> snackBarColors = [
    Colors.indigo,
    Colors.teal,
    Colors.orange,
    Colors.pink,
  ];

  List<Widget> stackItems = [];
  int i = 0;
  for (i = 0; i < snackBarColors.length; i = i + 1) {
    stackItems.add(
      Positioned(
        bottom: i * 8.0,
        left: i * 4.0,
        right: i * 4.0,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: snackBarColors[snackBarColors.length - 1 - i],
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'SnackBar ${snackBarColors.length - i}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
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
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'clearSnackBars() - Queue Visualization',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Removes all pending snackbars from the queue',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Before',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Stack(
                      children: stackItems,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Icon(Icons.arrow_forward, color: Colors.red, size: 24),
                  SizedBox(height: 4),
                  Text(
                    'clear',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'After',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 24,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Queue empty',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'ScaffoldMessenger.of(context).clearSnackBars()',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Colors.red.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildShowMaterialBannerBehaviorCard(
  String label,
  Color backgroundColor,
  int elevation,
  OverflowBarAlignment alignment,
) {
  print('Building showMaterialBanner behavior card: $label');
  String alignmentText = alignment == OverflowBarAlignment.start
      ? 'start'
      : alignment == OverflowBarAlignment.center
          ? 'center'
          : 'end';

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
            Icon(Icons.campaign, color: Colors.deepOrange, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: elevation > 0
                ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: elevation.toDouble(),
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.update, color: Colors.blue.shade700),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'New version available for download',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(56, 0, 8, 8),
                child: Row(
                  mainAxisAlignment: alignment == OverflowBarAlignment.start
                      ? MainAxisAlignment.start
                      : alignment == OverflowBarAlignment.center
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('DISMISS'),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      child: Text('UPDATE'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.layers, size: 12, color: Colors.deepOrange.shade700),
                  SizedBox(width: 4),
                  Text(
                    'Elevation: $elevation',
                    style: TextStyle(fontSize: 11, color: Colors.deepOrange.shade700),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.format_align_left, size: 12, color: Colors.cyan.shade700),
                  SizedBox(width: 4),
                  Text(
                    'Align: $alignmentText',
                    style: TextStyle(fontSize: 11, color: Colors.cyan.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildMessengerStateMethodCard(String methodName, String description, IconData icon) {
  print('Building messenger state method card: $methodName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.indigo.shade700, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                methodName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 4),
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

Widget buildClosedReasonCard(String reason, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
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
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SnackBarClosedReason.$reason',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ScaffoldMessengerState test executing');

  print('--- Section: SnackBar Display Areas ---');
  Widget snackBarAreasSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('SnackBar Display Areas'),
      buildInfoCard(
        'Purpose',
        'ScaffoldMessengerState manages the display areas for SnackBars within a Scaffold',
      ),
      buildSnackBarAreaDisplay(
        'Fixed SnackBar at Bottom',
        SnackBarBehavior.fixed,
        Colors.grey.shade800,
        0,
        EdgeInsets.zero,
      ),
      buildSnackBarAreaDisplay(
        'Floating SnackBar with Margin',
        SnackBarBehavior.floating,
        Colors.indigo.shade700,
        0,
        EdgeInsets.symmetric(horizontal: 16),
      ),
      buildSnackBarAreaDisplay(
        'Constrained Width SnackBar',
        SnackBarBehavior.floating,
        Colors.teal.shade700,
        280,
        EdgeInsets.all(8),
      ),
      buildSnackBarAreaDisplay(
        'Wide Floating SnackBar',
        SnackBarBehavior.floating,
        Colors.deepPurple.shade700,
        0,
        EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    ],
  );

  print('--- Section: MaterialBanner Areas ---');
  Widget materialBannerAreasSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('MaterialBanner Areas'),
      buildInfoCard(
        'Purpose',
        'MaterialBanners are displayed at the top of the Scaffold, managed by ScaffoldMessengerState',
      ),
      buildMaterialBannerAreaDisplay(
        'Single Action Banner',
        Colors.amber.shade50,
        false,
        1,
      ),
      buildMaterialBannerAreaDisplay(
        'Multiple Actions Inline',
        Colors.blue.shade50,
        false,
        2,
      ),
      buildMaterialBannerAreaDisplay(
        'Actions Below Content',
        Colors.green.shade50,
        true,
        2,
      ),
      buildMaterialBannerAreaDisplay(
        'Many Actions Below',
        Colors.purple.shade50,
        true,
        3,
      ),
    ],
  );

  print('--- Section: showSnackBar Behavior ---');
  Widget showSnackBarSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('showSnackBar Behavior'),
      buildInfoCard(
        'Method',
        'ScaffoldMessengerState.showSnackBar(SnackBar) displays a snackbar and returns a controller',
      ),
      buildShowSnackBarBehaviorCard(
        'Default Duration (4s)',
        Duration(seconds: 4),
        false,
        SnackBarBehavior.fixed,
        Colors.amber,
      ),
      buildShowSnackBarBehaviorCard(
        'Short Duration (2s)',
        Duration(seconds: 2),
        false,
        SnackBarBehavior.fixed,
        Colors.lightBlue,
      ),
      buildShowSnackBarBehaviorCard(
        'Long Duration (10s) with Close',
        Duration(seconds: 10),
        true,
        SnackBarBehavior.floating,
        Colors.green,
      ),
      buildShowSnackBarBehaviorCard(
        'Floating with Close Icon',
        Duration(seconds: 4),
        true,
        SnackBarBehavior.floating,
        Colors.orange,
      ),
      buildMessengerStateMethodCard(
        'showSnackBar()',
        'Displays a SnackBar at the bottom of the scaffold',
        Icons.add_alert,
      ),
      buildMessengerStateMethodCard(
        'ScaffoldFeatureController',
        'Returned by showSnackBar to control the displayed snackbar',
        Icons.tune,
      ),
    ],
  );

  print('--- Section: hideCurrentSnackBar ---');
  Widget hideSnackBarSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('hideCurrentSnackBar'),
      buildInfoCard(
        'Method',
        'Hides the current SnackBar with an optional reason parameter',
      ),
      buildHideSnackBarVisualization('action', Colors.green),
      buildHideSnackBarVisualization('dismiss', Colors.blue),
      buildHideSnackBarVisualization('swipe', Colors.orange),
      buildHideSnackBarVisualization('timeout', Colors.purple),
      buildHideSnackBarVisualization('hide', Colors.red),
      buildClosedReasonCard(
        'action',
        'User pressed the action button',
        Colors.green,
      ),
      buildClosedReasonCard(
        'dismiss',
        'SnackBar was dismissed programmatically',
        Colors.blue,
      ),
      buildClosedReasonCard(
        'swipe',
        'User swiped the snackbar away',
        Colors.orange,
      ),
      buildClosedReasonCard(
        'timeout',
        'Duration elapsed automatically',
        Colors.purple,
      ),
      buildClosedReasonCard(
        'hide',
        'hideCurrentSnackBar was called',
        Colors.red,
      ),
      buildClosedReasonCard(
        'remove',
        'SnackBar was removed from queue',
        Colors.grey,
      ),
    ],
  );

  print('--- Section: clearSnackBars Visualization ---');
  Widget clearSnackBarsSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('clearSnackBars Visualization'),
      buildInfoCard(
        'Method',
        'Removes all pending SnackBars from the display queue',
      ),
      buildClearSnackBarsVisualization(),
      buildMessengerStateMethodCard(
        'clearSnackBars()',
        'Clears all pending snackbars from the queue immediately',
        Icons.clear_all,
      ),
      buildMessengerStateMethodCard(
        'removeCurrentSnackBar()',
        'Removes current snackbar with optional reason parameter',
        Icons.remove_circle_outline,
      ),
    ],
  );

  print('--- Section: showMaterialBanner Behavior ---');
  Widget showMaterialBannerSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('showMaterialBanner Behavior'),
      buildInfoCard(
        'Method',
        'ScaffoldMessengerState.showMaterialBanner(MaterialBanner) displays a banner at the top',
      ),
      buildShowMaterialBannerBehaviorCard(
        'Default Banner',
        Colors.yellow.shade50,
        0,
        OverflowBarAlignment.end,
      ),
      buildShowMaterialBannerBehaviorCard(
        'Elevated Banner',
        Colors.orange.shade50,
        4,
        OverflowBarAlignment.end,
      ),
      buildShowMaterialBannerBehaviorCard(
        'Actions Start Aligned',
        Colors.green.shade50,
        2,
        OverflowBarAlignment.start,
      ),
      buildShowMaterialBannerBehaviorCard(
        'Actions Center Aligned',
        Colors.blue.shade50,
        2,
        OverflowBarAlignment.center,
      ),
      buildMessengerStateMethodCard(
        'showMaterialBanner()',
        'Displays a MaterialBanner at the top of the scaffold',
        Icons.campaign,
      ),
      buildMessengerStateMethodCard(
        'hideCurrentMaterialBanner()',
        'Hides the currently displayed material banner',
        Icons.visibility_off,
      ),
      buildMessengerStateMethodCard(
        'clearMaterialBanners()',
        'Removes all pending material banners from the queue',
        Icons.clear_all,
      ),
    ],
  );

  print('ScaffoldMessengerState test completed');
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade800, Colors.indigo.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.message, color: Colors.white, size: 32),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ScaffoldMessengerState',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'State for ScaffoldMessenger widget - manages SnackBars and MaterialBanners',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        snackBarAreasSection,
        SizedBox(height: 8),
        materialBannerAreasSection,
        SizedBox(height: 8),
        showSnackBarSection,
        SizedBox(height: 8),
        hideSnackBarSection,
        SizedBox(height: 8),
        clearSnackBarsSection,
        SizedBox(height: 8),
        showMaterialBannerSection,
        SizedBox(height: 32),
      ],
    ),
  );
}
