// D4rt test script: Tests ExpansionPanel, ExpansionPanelList, ExpansionTile from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Expansion widgets test executing');

  // ========== EXPANSIONPANEL ==========
  print('--- ExpansionPanel Tests ---');

  // Note: ExpansionPanel must be used within ExpansionPanelList

  // Test basic ExpansionPanel
  final basicPanels = [
    ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(title: Text('Panel 1'));
      },
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Panel 1 content'),
      ),
    ),
    ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(title: Text('Panel 2'));
      },
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Panel 2 content'),
      ),
    ),
  ];
  print('Basic ExpansionPanels created');

  // Test ExpansionPanel with isExpanded
  final expandedPanels = [
    ExpansionPanel(
      isExpanded: true,
      headerBuilder: (context, isExpanded) {
        return ListTile(title: Text('Expanded Panel'));
      },
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('This panel starts expanded'),
      ),
    ),
    ExpansionPanel(
      isExpanded: false,
      headerBuilder: (context, isExpanded) {
        return ListTile(title: Text('Collapsed Panel'));
      },
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('This panel starts collapsed'),
      ),
    ),
  ];
  print('ExpansionPanels with isExpanded created');

  // Test ExpansionPanel with canTapOnHeader
  final tapHeaderPanels = [
    ExpansionPanel(
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text('Tap Header to Expand'),
          subtitle: Text('canTapOnHeader: true'),
        );
      },
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Header is tappable'),
      ),
    ),
    ExpansionPanel(
      canTapOnHeader: false,
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text('Icon Only'),
          subtitle: Text('canTapOnHeader: false'),
        );
      },
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Only expand icon is tappable'),
      ),
    ),
  ];
  print('ExpansionPanels with canTapOnHeader created');

  // Test ExpansionPanel with backgroundColor
  final bgPanels = [
    ExpansionPanel(
      backgroundColor: Colors.blue.shade50,
      headerBuilder: (context, isExpanded) {
        return ListTile(title: Text('Blue Background'));
      },
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Blue background content'),
      ),
    ),
    ExpansionPanel(
      backgroundColor: Colors.green.shade50,
      headerBuilder: (context, isExpanded) {
        return ListTile(title: Text('Green Background'));
      },
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Green background content'),
      ),
    ),
  ];
  print('ExpansionPanels with backgroundColor created');

  // Test ExpansionPanelRadio
  final radioPanels = [
    ExpansionPanelRadio(
      value: 'panel1',
      headerBuilder: (context, isExpanded) {
        return ListTile(title: Text('Radio Panel 1'));
      },
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Only one can be expanded'),
      ),
    ),
    ExpansionPanelRadio(
      value: 'panel2',
      headerBuilder: (context, isExpanded) {
        return ListTile(title: Text('Radio Panel 2'));
      },
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('When this opens, others close'),
      ),
    ),
    ExpansionPanelRadio(
      value: 'panel3',
      headerBuilder: (context, isExpanded) {
        return ListTile(title: Text('Radio Panel 3'));
      },
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Radio behavior'),
      ),
    ),
  ];
  print('ExpansionPanelRadio created');

  // ========== EXPANSIONPANELLIST ==========
  print('--- ExpansionPanelList Tests ---');

  // Basic ExpansionPanelList is created via children parameter

  // Test ExpansionPanelList.radio
  // Note: This uses ExpansionPanelRadio children
  print('ExpansionPanelList.radio concept created');

  // Test ExpansionPanelList with expansionCallback
  print('ExpansionPanelList with expansionCallback concept created');

  // Test ExpansionPanelList with animationDuration
  print('ExpansionPanelList with animationDuration concept created');

  // Test ExpansionPanelList with elevation
  print('ExpansionPanelList with elevation concept created');

  // Test ExpansionPanelList with dividerColor
  print('ExpansionPanelList with dividerColor concept created');

  // ========== EXPANSIONTILE ==========
  print('--- ExpansionTile Tests ---');

  // Test basic ExpansionTile
  final basicExpansionTile = ExpansionTile(
    title: Text('Basic Expansion Tile'),
    children: [
      ListTile(title: Text('Child 1')),
      ListTile(title: Text('Child 2')),
      ListTile(title: Text('Child 3')),
    ],
  );
  print('Basic ExpansionTile created');

  // Test ExpansionTile with subtitle
  final subtitleExpansionTile = ExpansionTile(
    title: Text('With Subtitle'),
    subtitle: Text('Tap to expand'),
    children: [
      Padding(padding: EdgeInsets.all(16.0), child: Text('Expanded content')),
    ],
  );
  print('ExpansionTile with subtitle created');

  // Test ExpansionTile with leading
  final leadingExpansionTile = ExpansionTile(
    leading: Icon(Icons.folder),
    title: Text('With Leading Icon'),
    children: [
      ListTile(leading: Icon(Icons.insert_drive_file), title: Text('File 1')),
      ListTile(leading: Icon(Icons.insert_drive_file), title: Text('File 2')),
    ],
  );
  print('ExpansionTile with leading created');

  // Test ExpansionTile with trailing
  final trailingExpansionTile = ExpansionTile(
    title: Text('Custom Trailing'),
    trailing: Icon(Icons.arrow_drop_down_circle),
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Custom trailing icon'),
      ),
    ],
  );
  print('ExpansionTile with trailing created');

  // Test ExpansionTile with initiallyExpanded
  final expandedExpansionTile = ExpansionTile(
    title: Text('Initially Expanded'),
    initiallyExpanded: true,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('This tile starts expanded'),
      ),
    ],
  );
  print('ExpansionTile with initiallyExpanded created');

  // Test ExpansionTile with maintainState
  final maintainStateTile = ExpansionTile(
    title: Text('Maintain State'),
    maintainState: true,
    children: [
      TextField(
        decoration: InputDecoration(
          labelText: 'State is preserved',
          border: OutlineInputBorder(),
        ),
      ),
    ],
  );
  print('ExpansionTile with maintainState created');

  // Test ExpansionTile with backgroundColor
  final bgExpansionTile = ExpansionTile(
    title: Text('Background Color'),
    backgroundColor: Colors.amber.shade50,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Colored background when expanded'),
      ),
    ],
  );
  print('ExpansionTile with backgroundColor created');

  // Test ExpansionTile with collapsedBackgroundColor
  final collapsedBgTile = ExpansionTile(
    title: Text('Collapsed Background'),
    collapsedBackgroundColor: Colors.grey.shade200,
    backgroundColor: Colors.blue.shade50,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Different colors for collapsed/expanded'),
      ),
    ],
  );
  print('ExpansionTile with collapsedBackgroundColor created');

  // Test ExpansionTile with textColor
  final textColorTile = ExpansionTile(
    title: Text('Custom Text Color'),
    textColor: Colors.purple,
    collapsedTextColor: Colors.grey,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Purple when expanded, grey when collapsed'),
      ),
    ],
  );
  print('ExpansionTile with textColor created');

  // Test ExpansionTile with iconColor
  final iconColorTile = ExpansionTile(
    title: Text('Custom Icon Color'),
    iconColor: Colors.red,
    collapsedIconColor: Colors.blue,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Red when expanded, blue when collapsed'),
      ),
    ],
  );
  print('ExpansionTile with iconColor created');

  // Test ExpansionTile with shape
  final shapedExpansionTile = ExpansionTile(
    title: Text('Custom Shape'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(color: Colors.blue),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(color: Colors.grey),
    ),
    children: [
      Padding(padding: EdgeInsets.all(16.0), child: Text('Rounded borders')),
    ],
  );
  print('ExpansionTile with shape created');

  // Test ExpansionTile with tilePadding
  final paddedExpansionTile = ExpansionTile(
    title: Text('Custom Padding'),
    tilePadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('More horizontal padding'),
      ),
    ],
  );
  print('ExpansionTile with tilePadding created');

  // Test ExpansionTile with childrenPadding
  final childPaddedTile = ExpansionTile(
    title: Text('Children Padding'),
    childrenPadding: EdgeInsets.all(24.0),
    children: [Text('This content has extra padding')],
  );
  print('ExpansionTile with childrenPadding created');

  // Test ExpansionTile with expandedAlignment
  final alignedExpansionTile = ExpansionTile(
    title: Text('Expanded Alignment'),
    expandedAlignment: Alignment.centerLeft,
    children: [Text('Aligned to left')],
  );
  print('ExpansionTile with expandedAlignment created');

  // Test ExpansionTile with expandedCrossAxisAlignment
  final crossAlignedTile = ExpansionTile(
    title: Text('Cross Axis Alignment'),
    expandedCrossAxisAlignment: CrossAxisAlignment.start,
    children: [Text('Start aligned'), Text('Items')],
  );
  print('ExpansionTile with expandedCrossAxisAlignment created');

  // Test ExpansionTile with onExpansionChanged
  final callbackExpansionTile = ExpansionTile(
    title: Text('With Callback'),
    onExpansionChanged: (bool expanded) {
      print('Expansion changed: $expanded');
    },
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Check console for callback'),
      ),
    ],
  );
  print('ExpansionTile with onExpansionChanged created');

  // Test ExpansionTile with dense
  final denseExpansionTile = ExpansionTile(
    title: Text('Dense'),
    dense: true,
    children: [ListTile(dense: true, title: Text('Dense child'))],
  );
  print('ExpansionTile with dense created');

  // Test ExpansionTile with visualDensity
  final visualDensityTile = ExpansionTile(
    title: Text('Visual Density'),
    visualDensity: VisualDensity.comfortable,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Comfortable density'),
      ),
    ],
  );
  print('ExpansionTile with visualDensity created');

  // Test ExpansionTile with controlAffinity
  final controlAffinityTile = ExpansionTile(
    title: Text('Control at Leading'),
    controlAffinity: ListTileControlAffinity.leading,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Expand icon on left'),
      ),
    ],
  );
  print('ExpansionTile with controlAffinity created');

  // Test ExpansionTile with clipBehavior
  final clippedExpansionTile = ExpansionTile(
    title: Text('Clip Behavior'),
    clipBehavior: Clip.antiAlias,
    children: [
      Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16.0),
        child: Text('Clipped content', style: TextStyle(color: Colors.white)),
      ),
    ],
  );
  print('ExpansionTile with clipBehavior created');

  print('Expansion widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expansion Widgets Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'ExpansionTile Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        basicExpansionTile,
        SizedBox(height: 8.0),

        subtitleExpansionTile,
        SizedBox(height: 8.0),

        leadingExpansionTile,
        SizedBox(height: 8.0),

        expandedExpansionTile,
        SizedBox(height: 8.0),

        bgExpansionTile,
        SizedBox(height: 8.0),

        collapsedBgTile,
        SizedBox(height: 8.0),

        textColorTile,
        SizedBox(height: 8.0),

        iconColorTile,
        SizedBox(height: 8.0),

        shapedExpansionTile,
        SizedBox(height: 8.0),

        controlAffinityTile,
        SizedBox(height: 8.0),

        callbackExpansionTile,

        SizedBox(height: 24.0),
        Text(
          'Nested ExpansionTiles:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        ExpansionTile(
          title: Text('Parent Tile'),
          leading: Icon(Icons.folder),
          children: [
            ExpansionTile(
              title: Text('Child Tile 1'),
              leading: Icon(Icons.folder_open),
              children: [
                ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text('File A'),
                ),
                ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text('File B'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Child Tile 2'),
              leading: Icon(Icons.folder_open),
              children: [
                ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text('File C'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
