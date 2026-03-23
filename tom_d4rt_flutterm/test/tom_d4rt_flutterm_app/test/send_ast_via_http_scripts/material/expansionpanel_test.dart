// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExpansionPanelList and ExpansionPanel from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExpansionPanel/ExpansionPanelList test executing');

  // Variation 1: Basic ExpansionPanelList with ExpansionPanels
  final panels1 = [
    ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(title: Text('Panel 1')),
      body: Container(padding: EdgeInsets.all(16), child: Text('Content 1')),
    ),
    ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(title: Text('Panel 2')),
      body: Text('Content 2'),
    ),
  ];
  final widget1 = ExpansionPanelList(
    expansionCallback: (index, isExpanded) {
      print('panel $index expanded: $isExpanded');
    },
    children: panels1,
  );
  print('ExpansionPanelList(2 panels) created');

  // Variation 2: ExpansionPanelList with initially expanded panel
  final panels2 = [
    ExpansionPanel(
      headerBuilder: (context, isExpanded) =>
          ListTile(title: Text('Initially Expanded')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Text('This panel starts expanded'),
      ),
      isExpanded: true,
    ),
    ExpansionPanel(
      headerBuilder: (context, isExpanded) =>
          ListTile(title: Text('Collapsed')),
      body: Text('Hidden content'),
    ),
  ];
  final widget2 = ExpansionPanelList(
    expansionCallback: (index, isExpanded) {
      print('panel $index toggle: $isExpanded');
    },
    children: panels2,
  );
  print('ExpansionPanelList(isExpanded: true) created');

  // Variation 3: ExpansionPanelList with canTapOnHeader
  final panels3 = [
    ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(
        title: Text('Tap Header'),
        subtitle: Text(isExpanded ? 'Expanded' : 'Collapsed'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.blue.shade50,
        child: Text('Tappable header content'),
      ),
      canTapOnHeader: true,
    ),
    ExpansionPanel(
      headerBuilder: (context, isExpanded) =>
          ListTile(title: Text('Also Tappable')),
      body: Text('More content'),
      canTapOnHeader: true,
    ),
  ];
  final widget3 = ExpansionPanelList(
    expansionCallback: (index, isExpanded) {
      print('tappable panel $index: $isExpanded');
    },
    children: panels3,
  );
  print('ExpansionPanelList(canTapOnHeader: true) created');

  // Variation 4: ExpansionPanelList.radio with ExpansionPanelRadio
  final widget4 = ExpansionPanelList.radio(
    expansionCallback: (index, isExpanded) {
      print('radio panel $index: $isExpanded');
    },
    children: [
      ExpansionPanelRadio(
        value: 'radio1',
        headerBuilder: (context, isExpanded) =>
            ListTile(title: Text('Radio Panel 1')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text('Radio content 1'),
        ),
      ),
      ExpansionPanelRadio(
        value: 'radio2',
        headerBuilder: (context, isExpanded) =>
            ListTile(title: Text('Radio Panel 2')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text('Radio content 2'),
        ),
      ),
      ExpansionPanelRadio(
        value: 'radio3',
        headerBuilder: (context, isExpanded) =>
            ListTile(title: Text('Radio Panel 3')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text('Radio content 3'),
        ),
      ),
    ],
  );
  print('ExpansionPanelList.radio(3 radio panels) created');

  print('ExpansionPanel/ExpansionPanelList test completed');
  return SingleChildScrollView(
    child: Column(
      children: [
        widget1,
        SizedBox(height: 16),
        widget2,
        SizedBox(height: 16),
        widget3,
        SizedBox(height: 16),
        widget4,
      ],
    ),
  );
}
