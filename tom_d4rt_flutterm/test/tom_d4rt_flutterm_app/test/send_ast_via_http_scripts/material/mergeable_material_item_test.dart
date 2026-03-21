// D4rt test script: Tests MergeableMaterialItem from material
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

Widget buildDescriptionBox(String description) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Text(
      description,
      style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
    ),
  );
}

Widget buildMergeableDemo(String title, Widget demo) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(12), child: demo),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('MergeableMaterialItem deep demo test executing');

  List<Widget> sections = [];

  // ============================================================
  // SECTION 1: Overview of MergeableMaterialItem concept
  // ============================================================
  print('--- Section 1: Overview of MergeableMaterialItem concept ---');

  sections.add(buildSectionHeader('1. Overview of MergeableMaterialItem'));

  sections.add(
    buildDescriptionBox(
      'MergeableMaterialItem is an abstract interface for items that can be '
      'merged together within a MergeableMaterial widget. The two concrete '
      'implementations are MaterialSlice (for content) and MaterialGap (for '
      'spacing). Items animate smoothly when added, removed, or reordered.',
    ),
  );

  sections.add(buildInfoCard('Abstract Class', 'MergeableMaterialItem'));
  sections.add(buildInfoCard('Implementations', 'MaterialSlice, MaterialGap'));
  sections.add(buildInfoCard('Required Property', 'LocalKey key'));
  sections.add(buildInfoCard('Parent Widget', 'MergeableMaterial'));

  Widget overviewDemo1 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('overview-slice-1'),
        child: ListTile(
          leading: Icon(Icons.layers, color: Colors.teal),
          title: Text('MergeableMaterialItem Concept'),
          subtitle: Text('Abstract base for mergeable items'),
        ),
      ),
    ],
  );
  sections.add(
    buildMergeableDemo('Basic MergeableMaterialItem Usage', overviewDemo1),
  );
  print('Overview section created');

  // ============================================================
  // SECTION 2: MaterialSlice as MergeableMaterialItem
  // ============================================================
  print('--- Section 2: MaterialSlice as MergeableMaterialItem ---');

  sections.add(buildSectionHeader('2. MaterialSlice as MergeableMaterialItem'));

  sections.add(
    buildDescriptionBox(
      'MaterialSlice is the primary content holder in MergeableMaterial. Each '
      'slice wraps a child widget and can have optional color styling. Slices '
      'merge visually when adjacent, creating a unified material surface.',
    ),
  );

  sections.add(buildInfoCard('Class', 'MaterialSlice'));
  sections.add(buildInfoCard('Key Property', 'LocalKey key (required)'));
  sections.add(buildInfoCard('Child Property', 'Widget child (required)'));
  sections.add(buildInfoCard('Color Property', 'Color? color (optional)'));

  Widget sliceDemo1 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('slice-basic-1'),
        child: ListTile(
          leading: Icon(Icons.article, color: Colors.blue),
          title: Text('Basic MaterialSlice'),
          subtitle: Text('Simple content holder'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Single MaterialSlice', sliceDemo1));

  Widget sliceDemo2 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('slice-colored-1'),
        color: Colors.amber.shade100,
        child: ListTile(
          leading: Icon(Icons.palette, color: Colors.amber.shade800),
          title: Text('Colored Slice'),
          subtitle: Text('Using color property'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('MaterialSlice with Color', sliceDemo2));

  Widget sliceDemo3 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('slice-rich-1'),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rich Content Slice',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Complex layout within MaterialSlice',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
      ),
    ],
  );
  sections.add(
    buildMergeableDemo('MaterialSlice with Rich Content', sliceDemo3),
  );
  print('MaterialSlice section created');

  // ============================================================
  // SECTION 3: MaterialGap as MergeableMaterialItem
  // ============================================================
  print('--- Section 3: MaterialGap as MergeableMaterialItem ---');

  sections.add(buildSectionHeader('3. MaterialGap as MergeableMaterialItem'));

  sections.add(
    buildDescriptionBox(
      'MaterialGap creates visual separation between MaterialSlice items. It '
      'breaks the merged material surface, creating distinct groups. The size '
      'property controls the gap height and defaults to 16.0 logical pixels.',
    ),
  );

  sections.add(buildInfoCard('Class', 'MaterialGap'));
  sections.add(buildInfoCard('Key Property', 'LocalKey key (required)'));
  sections.add(buildInfoCard('Size Property', 'double size (default: 16.0)'));
  sections.add(buildInfoCard('Effect', 'Breaks material merge boundary'));

  Widget gapDemo1 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('gap-above-1'),
        child: ListTile(
          leading: Icon(Icons.arrow_upward, color: Colors.green),
          title: Text('Above the Gap'),
        ),
      ),
      MaterialGap(key: ValueKey('gap-default-1')),
      MaterialSlice(
        key: ValueKey('gap-below-1'),
        child: ListTile(
          leading: Icon(Icons.arrow_downward, color: Colors.orange),
          title: Text('Below the Gap'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Default MaterialGap (16px)', gapDemo1));

  Widget gapDemo2 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('gap-small-above'),
        child: ListTile(title: Text('Small Gap Above')),
      ),
      MaterialGap(key: ValueKey('gap-small'), size: 8.0),
      MaterialSlice(
        key: ValueKey('gap-small-below'),
        child: ListTile(title: Text('Small Gap Below')),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Small MaterialGap (8px)', gapDemo2));

  Widget gapDemo3 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('gap-large-above'),
        child: ListTile(title: Text('Large Gap Above')),
      ),
      MaterialGap(key: ValueKey('gap-large'), size: 32.0),
      MaterialSlice(
        key: ValueKey('gap-large-below'),
        child: ListTile(title: Text('Large Gap Below')),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Large MaterialGap (32px)', gapDemo3));
  print('MaterialGap section created');

  // ============================================================
  // SECTION 4: MergeableMaterial with slices
  // ============================================================
  print('--- Section 4: MergeableMaterial with slices ---');

  sections.add(buildSectionHeader('4. MergeableMaterial with Slices'));

  sections.add(
    buildDescriptionBox(
      'MergeableMaterial is the container widget that manages MergeableMaterialItem '
      'children. Adjacent MaterialSlice items merge into a single material surface, '
      'while MaterialGap items create visual breaks between groups.',
    ),
  );

  sections.add(buildInfoCard('Widget', 'MergeableMaterial'));
  sections.add(buildInfoCard('Children Type', 'List<MergeableMaterialItem>'));
  sections.add(buildInfoCard('Elevation', 'double (default: 2)'));
  sections.add(buildInfoCard('Has Dividers', 'bool (default: true)'));

  Widget mergeDemo1 = MergeableMaterial(
    elevation: 2,
    children: [
      MaterialSlice(
        key: ValueKey('merge-1'),
        child: ListTile(
          leading: Icon(Icons.looks_one, color: Colors.red),
          title: Text('First Merged Slice'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('merge-2'),
        child: ListTile(
          leading: Icon(Icons.looks_two, color: Colors.blue),
          title: Text('Second Merged Slice'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('merge-3'),
        child: ListTile(
          leading: Icon(Icons.looks_3, color: Colors.green),
          title: Text('Third Merged Slice'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Three Merged Slices', mergeDemo1));

  Widget mergeDemo2 = MergeableMaterial(
    elevation: 4,
    children: [
      MaterialSlice(
        key: ValueKey('elevated-1'),
        child: ListTile(
          title: Text('Elevated Material'),
          subtitle: Text('elevation: 4'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('elevated-2'),
        child: ListTile(
          title: Text('Higher Shadow'),
          subtitle: Text('More prominent appearance'),
        ),
      ),
    ],
  );
  sections.add(
    buildMergeableDemo('MergeableMaterial with Elevation', mergeDemo2),
  );
  print('MergeableMaterial slices section created');

  // ============================================================
  // SECTION 5: Animated merging/unmerging demonstration
  // ============================================================
  print('--- Section 5: Animated merging/unmerging demonstration ---');

  sections.add(buildSectionHeader('5. Animated Merging/Unmerging'));

  sections.add(
    buildDescriptionBox(
      'MergeableMaterial animates changes to its children. When items are added, '
      'removed, or reordered, the widget smoothly transitions between states. '
      'This creates a polished user experience for dynamic lists.',
    ),
  );

  sections.add(buildInfoCard('Animation', 'Automatic on child changes'));
  sections.add(buildInfoCard('Merge Animation', 'Slices join smoothly'));
  sections.add(buildInfoCard('Gap Animation', 'Gaps appear/disappear'));
  sections.add(buildInfoCard('Curve', 'Material design standard curves'));

  Widget animDemo1 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('anim-header'),
        color: Colors.purple.shade50,
        child: ListTile(
          leading: Icon(Icons.animation, color: Colors.purple),
          title: Text('Animation Header'),
          subtitle: Text('Static header slice'),
        ),
      ),
      MaterialGap(key: ValueKey('anim-gap-1')),
      MaterialSlice(
        key: ValueKey('anim-item-1'),
        child: ListTile(
          leading: Icon(Icons.radio_button_checked, color: Colors.teal),
          title: Text('Animatable Item 1'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('anim-item-2'),
        child: ListTile(
          leading: Icon(Icons.radio_button_checked, color: Colors.teal),
          title: Text('Animatable Item 2'),
        ),
      ),
      MaterialGap(key: ValueKey('anim-gap-2')),
      MaterialSlice(
        key: ValueKey('anim-footer'),
        color: Colors.grey.shade100,
        child: ListTile(
          leading: Icon(Icons.stop, color: Colors.grey),
          title: Text('Animation Footer'),
          subtitle: Text('Static footer slice'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Animated Groups Structure', animDemo1));

  Widget animDemo2 = Column(
    children: [
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.orange.shade700),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'In a live app, adding/removing items triggers smooth animations',
                style: TextStyle(fontSize: 12, color: Colors.orange.shade900),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      MergeableMaterial(
        children: [
          MaterialSlice(
            key: ValueKey('transition-1'),
            child: ListTile(
              leading: Icon(Icons.play_arrow, color: Colors.green),
              title: Text('Item appears with animation'),
            ),
          ),
          MaterialSlice(
            key: ValueKey('transition-2'),
            child: ListTile(
              leading: Icon(Icons.pause, color: Colors.amber),
              title: Text('Item transforms smoothly'),
            ),
          ),
          MaterialSlice(
            key: ValueKey('transition-3'),
            child: ListTile(
              leading: Icon(Icons.stop, color: Colors.red),
              title: Text('Item disappears gracefully'),
            ),
          ),
        ],
      ),
    ],
  );
  sections.add(
    buildMergeableDemo('Animation Concept Visualization', animDemo2),
  );
  print('Animation section created');

  // ============================================================
  // SECTION 6: Grouped items with dividers
  // ============================================================
  print('--- Section 6: Grouped items with dividers ---');

  sections.add(buildSectionHeader('6. Grouped Items with Dividers'));

  sections.add(
    buildDescriptionBox(
      'MergeableMaterial supports automatic dividers between slices. The hasDividers '
      'property enables/disables dividers, while dividerColor customizes their '
      'appearance. Dividers help visually separate items within a merged group.',
    ),
  );

  sections.add(
    buildInfoCard('Has Dividers', 'bool hasDividers (default: true)'),
  );
  sections.add(buildInfoCard('Divider Color', 'Color? dividerColor'));
  sections.add(buildInfoCard('Default Divider', 'Theme divider color'));
  sections.add(buildInfoCard('Divider Position', 'Between adjacent slices'));

  Widget dividerDemo1 = MergeableMaterial(
    hasDividers: true,
    children: [
      MaterialSlice(
        key: ValueKey('div-1'),
        child: ListTile(
          leading: Icon(Icons.bookmark, color: Colors.blue),
          title: Text('Item with Divider Below'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('div-2'),
        child: ListTile(
          leading: Icon(Icons.bookmark, color: Colors.blue),
          title: Text('Item with Divider Above/Below'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('div-3'),
        child: ListTile(
          leading: Icon(Icons.bookmark, color: Colors.blue),
          title: Text('Item with Divider Above'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('With Dividers (default)', dividerDemo1));

  Widget dividerDemo2 = MergeableMaterial(
    hasDividers: false,
    children: [
      MaterialSlice(
        key: ValueKey('nodiv-1'),
        child: ListTile(
          leading: Icon(Icons.label, color: Colors.green),
          title: Text('No Divider Item 1'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('nodiv-2'),
        child: ListTile(
          leading: Icon(Icons.label, color: Colors.green),
          title: Text('No Divider Item 2'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('nodiv-3'),
        child: ListTile(
          leading: Icon(Icons.label, color: Colors.green),
          title: Text('No Divider Item 3'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Without Dividers', dividerDemo2));

  Widget dividerDemo3 = MergeableMaterial(
    hasDividers: true,
    dividerColor: Colors.red.shade300,
    children: [
      MaterialSlice(
        key: ValueKey('colordiv-1'),
        child: ListTile(
          leading: Icon(Icons.circle, color: Colors.red),
          title: Text('Red Divider Item 1'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('colordiv-2'),
        child: ListTile(
          leading: Icon(Icons.circle, color: Colors.red),
          title: Text('Red Divider Item 2'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Custom Divider Color', dividerDemo3));
  print('Dividers section created');

  // ============================================================
  // SECTION 7: Leading/trailing animations concept
  // ============================================================
  print('--- Section 7: Leading/trailing animations concept ---');

  sections.add(buildSectionHeader('7. Leading/Trailing Animations'));

  sections.add(
    buildDescriptionBox(
      'When MergeableMaterialItem instances are added or removed, leading and '
      'trailing edges animate. The first and last items have special treatment '
      'for rounded corners. Middle items have flat edges that merge seamlessly.',
    ),
  );

  sections.add(buildInfoCard('Leading Edge', 'Top-rounded on first slice'));
  sections.add(buildInfoCard('Trailing Edge', 'Bottom-rounded on last slice'));
  sections.add(buildInfoCard('Middle Items', 'Flat edges merge smoothly'));
  sections.add(buildInfoCard('Gap Edges', 'Creates new leading/trailing pair'));

  Widget leadTrailDemo1 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('lead-first'),
        color: Colors.blue.shade50,
        child: ListTile(
          leading: Icon(Icons.first_page, color: Colors.blue),
          title: Text('Leading Item'),
          subtitle: Text('Top-rounded corners'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('lead-mid-1'),
        child: ListTile(
          leading: Icon(Icons.remove, color: Colors.grey),
          title: Text('Middle Item 1'),
          subtitle: Text('Flat edges'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('lead-mid-2'),
        child: ListTile(
          leading: Icon(Icons.remove, color: Colors.grey),
          title: Text('Middle Item 2'),
          subtitle: Text('Flat edges'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('lead-last'),
        color: Colors.orange.shade50,
        child: ListTile(
          leading: Icon(Icons.last_page, color: Colors.orange),
          title: Text('Trailing Item'),
          subtitle: Text('Bottom-rounded corners'),
        ),
      ),
    ],
  );
  sections.add(
    buildMergeableDemo('Leading and Trailing Items', leadTrailDemo1),
  );

  Widget leadTrailDemo2 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('edge-group1-first'),
        color: Colors.green.shade50,
        child: ListTile(
          leading: Icon(Icons.filter_1, color: Colors.green),
          title: Text('Group 1 Start'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('edge-group1-last'),
        color: Colors.green.shade50,
        child: ListTile(
          leading: Icon(Icons.filter_1, color: Colors.green),
          title: Text('Group 1 End'),
        ),
      ),
      MaterialGap(key: ValueKey('edge-gap')),
      MaterialSlice(
        key: ValueKey('edge-group2-first'),
        color: Colors.purple.shade50,
        child: ListTile(
          leading: Icon(Icons.filter_2, color: Colors.purple),
          title: Text('Group 2 Start'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('edge-group2-last'),
        color: Colors.purple.shade50,
        child: ListTile(
          leading: Icon(Icons.filter_2, color: Colors.purple),
          title: Text('Group 2 End'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Gap Creates New Edge Pair', leadTrailDemo2));
  print('Leading/trailing section created');

  // ============================================================
  // SECTION 8: Multiple items in a list
  // ============================================================
  print('--- Section 8: Multiple items in a list ---');

  sections.add(buildSectionHeader('8. Multiple Items in a List'));

  sections.add(
    buildDescriptionBox(
      'MergeableMaterial excels at displaying lists of items that need visual '
      'grouping. Common use cases include settings screens, contact lists, '
      'and expandable panels where items group and separate dynamically.',
    ),
  );

  sections.add(buildInfoCard('Use Case', 'Settings screens'));
  sections.add(buildInfoCard('Use Case', 'Contact lists'));
  sections.add(buildInfoCard('Use Case', 'Expandable panels'));
  sections.add(buildInfoCard('Use Case', 'Grouped actions'));

  Widget listDemo1 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('list-account'),
        child: ListTile(
          leading: Icon(Icons.account_circle, color: Colors.blue),
          title: Text('Account'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      MaterialSlice(
        key: ValueKey('list-notifications'),
        child: ListTile(
          leading: Icon(Icons.notifications, color: Colors.amber),
          title: Text('Notifications'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      MaterialSlice(
        key: ValueKey('list-privacy'),
        child: ListTile(
          leading: Icon(Icons.lock, color: Colors.green),
          title: Text('Privacy'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      MaterialSlice(
        key: ValueKey('list-security'),
        child: ListTile(
          leading: Icon(Icons.security, color: Colors.red),
          title: Text('Security'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Settings List Style', listDemo1));

  Widget listDemo2 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('contact-header'),
        color: Colors.grey.shade100,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'CONTACTS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      MaterialSlice(
        key: ValueKey('contact-alice'),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pink,
            child: Text('A', style: TextStyle(color: Colors.white)),
          ),
          title: Text('Alice Anderson'),
          subtitle: Text('alice@example.com'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('contact-bob'),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('B', style: TextStyle(color: Colors.white)),
          ),
          title: Text('Bob Brown'),
          subtitle: Text('bob@example.com'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('contact-carol'),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('C', style: TextStyle(color: Colors.white)),
          ),
          title: Text('Carol Chen'),
          subtitle: Text('carol@example.com'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Contact List Style', listDemo2));
  print('Multiple items section created');

  // ============================================================
  // SECTION 9: Item key usage
  // ============================================================
  print('--- Section 9: Item key usage ---');

  sections.add(buildSectionHeader('9. Item Key Usage'));

  sections.add(
    buildDescriptionBox(
      'Each MergeableMaterialItem requires a unique LocalKey. Keys enable Flutter '
      'to track items across rebuilds, animate changes correctly, and maintain '
      'state. ValueKey and ObjectKey are commonly used key types.',
    ),
  );

  sections.add(buildInfoCard('Key Type', 'LocalKey (required)'));
  sections.add(buildInfoCard('Common Keys', 'ValueKey, ObjectKey, UniqueKey'));
  sections.add(buildInfoCard('Purpose', 'Identity tracking for animations'));
  sections.add(buildInfoCard('Uniqueness', 'Must be unique among siblings'));

  Widget keyDemo1 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('valuekey-item'),
        child: ListTile(
          leading: Icon(Icons.vpn_key, color: Colors.indigo),
          title: Text('ValueKey Item'),
          subtitle: Text("key: ValueKey('valuekey-item')"),
        ),
      ),
      MaterialSlice(
        key: ObjectKey({'id': 123}),
        child: ListTile(
          leading: Icon(Icons.data_object, color: Colors.teal),
          title: Text('ObjectKey Item'),
          subtitle: Text("key: ObjectKey({'id': 123})"),
        ),
      ),
      MaterialSlice(
        key: ValueKey(42),
        child: ListTile(
          leading: Icon(Icons.numbers, color: Colors.orange),
          title: Text('Integer ValueKey'),
          subtitle: Text('key: ValueKey(42)'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Different Key Types', keyDemo1));

  Widget keyDemo2 = Column(
    children: [
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.red.shade700),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Keys must be unique! Duplicate keys cause undefined behavior.',
                style: TextStyle(fontSize: 12, color: Colors.red.shade900),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      MergeableMaterial(
        children: [
          MaterialSlice(
            key: ValueKey('unique-key-1'),
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Unique Key 1'),
            ),
          ),
          MaterialSlice(
            key: ValueKey('unique-key-2'),
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Unique Key 2'),
            ),
          ),
          MaterialSlice(
            key: ValueKey('unique-key-3'),
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Unique Key 3'),
            ),
          ),
        ],
      ),
    ],
  );
  sections.add(buildMergeableDemo('Unique Keys Required', keyDemo2));
  print('Key usage section created');

  // ============================================================
  // SECTION 10: Slice styling variations
  // ============================================================
  print('--- Section 10: Slice styling variations ---');

  sections.add(buildSectionHeader('10. Slice Styling Variations'));

  sections.add(
    buildDescriptionBox(
      'MaterialSlice supports various styling approaches through its color '
      'property and child widget customization. Combine with MergeableMaterial '
      'properties like elevation and dividerColor for complete control.',
    ),
  );

  sections.add(buildInfoCard('Slice Color', 'Background color per slice'));
  sections.add(buildInfoCard('Child Styling', 'Full widget customization'));
  sections.add(buildInfoCard('Themes', 'Inherits from material theme'));
  sections.add(buildInfoCard('Elevation', 'Shadow depth control'));

  Widget styleDemo1 = MergeableMaterial(
    children: [
      MaterialSlice(
        key: ValueKey('style-default'),
        child: ListTile(
          leading: Icon(Icons.format_color_reset),
          title: Text('Default Style'),
          subtitle: Text('No color override'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('style-light'),
        color: Colors.lightBlue.shade50,
        child: ListTile(
          leading: Icon(Icons.palette, color: Colors.lightBlue),
          title: Text('Light Blue Background'),
          subtitle: Text('color: Colors.lightBlue.shade50'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('style-accent'),
        color: Colors.amber.shade100,
        child: ListTile(
          leading: Icon(Icons.star, color: Colors.amber.shade800),
          title: Text('Accent Color'),
          subtitle: Text('color: Colors.amber.shade100'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Color Variations', styleDemo1));

  Widget styleDemo2 = MergeableMaterial(
    elevation: 6,
    dividerColor: Colors.teal.shade300,
    children: [
      MaterialSlice(
        key: ValueKey('combined-1'),
        color: Colors.teal.shade50,
        child: ListTile(
          leading: Icon(Icons.layers, color: Colors.teal),
          title: Text('Combined Styling 1'),
          subtitle: Text('elevation: 6, dividerColor: teal'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('combined-2'),
        color: Colors.teal.shade50,
        child: ListTile(
          leading: Icon(Icons.layers, color: Colors.teal),
          title: Text('Combined Styling 2'),
          subtitle: Text('Slice color: teal.shade50'),
        ),
      ),
      MaterialSlice(
        key: ValueKey('combined-3'),
        color: Colors.teal.shade50,
        child: ListTile(
          leading: Icon(Icons.layers, color: Colors.teal),
          title: Text('Combined Styling 3'),
          subtitle: Text('Unified theme approach'),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Combined Styling', styleDemo2));

  Widget styleDemo3 = MergeableMaterial(
    hasDividers: false,
    children: [
      MaterialSlice(
        key: ValueKey('gradient-1'),
        color: Colors.purple.shade100,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.gradient, color: Colors.purple.shade700, size: 32),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Custom Container',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Rich child widget styling',
                    style: TextStyle(color: Colors.purple.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      MaterialSlice(
        key: ValueKey('gradient-2'),
        color: Colors.purple.shade200,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.brush, color: Colors.purple.shade800, size: 32),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gradient Effect',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Using progressively darker colors',
                    style: TextStyle(color: Colors.purple.shade700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      MaterialSlice(
        key: ValueKey('gradient-3'),
        color: Colors.purple.shade300,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.purple.shade900, size: 32),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visual Depth',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Creating layered appearance',
                    style: TextStyle(color: Colors.purple.shade100),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
  sections.add(buildMergeableDemo('Progressive Color Styling', styleDemo3));
  print('Slice styling section created');

  // ============================================================
  // FINAL SUMMARY
  // ============================================================
  print('--- Building final layout ---');

  sections.add(SizedBox(height: 24));
  sections.add(
    Container(
      width: double.infinity,
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
        children: [
          Icon(Icons.check_circle, color: Colors.white, size: 48),
          SizedBox(height: 12),
          Text(
            'MergeableMaterialItem Demo Complete',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '10 sections covering MaterialSlice, MaterialGap, and MergeableMaterial',
            style: TextStyle(fontSize: 14, color: Colors.teal.shade100),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );

  print('MergeableMaterialItem deep demo test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections,
    ),
  );
}
