// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MergeableMaterial, MaterialGap, MaterialSlice from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MergeableMaterial/MaterialGap/MaterialSlice test executing');

  // ========== MATERIALSLICE ==========
  print('--- MaterialSlice Tests ---');

  // Variation 1: Basic MergeableMaterial with single MaterialSlice
  final widget1 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('slice1'),
          child: ListTile(
            title: Text('Single Slice'),
            subtitle: Text('Just one MaterialSlice'),
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(1 MaterialSlice) created');

  // Variation 2: MergeableMaterial with multiple MaterialSlice
  final widget2 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('top'),
          child: ListTile(
            leading: Icon(Icons.arrow_upward),
            title: Text('Top Slice'),
          ),
        ),
        MaterialSlice(
          key: ValueKey('middle'),
          child: ListTile(
            leading: Icon(Icons.swap_vert),
            title: Text('Middle Slice'),
          ),
        ),
        MaterialSlice(
          key: ValueKey('bottom'),
          child: ListTile(
            leading: Icon(Icons.arrow_downward),
            title: Text('Bottom Slice'),
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(3 MaterialSlice) created');

  // ========== MATERIALGAP ==========
  print('--- MaterialGap Tests ---');

  // Variation 3: MergeableMaterial with MaterialGap between slices
  final widget3 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('above'),
          child: ListTile(
            title: Text('Above Gap'),
            tileColor: Colors.blue.shade50,
          ),
        ),
        MaterialGap(key: ValueKey('gap1')),
        MaterialSlice(
          key: ValueKey('below'),
          child: ListTile(
            title: Text('Below Gap'),
            tileColor: Colors.green.shade50,
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(MaterialGap between 2 slices) created');

  // Variation 4: MergeableMaterial with sized MaterialGap
  final widget4 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('s1'),
          child: ListTile(title: Text('Section 1')),
        ),
        MaterialGap(key: ValueKey('gap-sm'), size: 8.0),
        MaterialSlice(
          key: ValueKey('s2'),
          child: ListTile(title: Text('Section 2')),
        ),
        MaterialGap(key: ValueKey('gap-lg'), size: 24.0),
        MaterialSlice(
          key: ValueKey('s3'),
          child: ListTile(title: Text('Section 3')),
        ),
      ],
    ),
  );
  print('MergeableMaterial(MaterialGap with size 8 and 24) created');

  // Variation 5: MergeableMaterial with multiple gaps and slices
  final widget5 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('header'),
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.indigo.shade50,
            child: Text(
              'Header',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        MaterialGap(key: ValueKey('g1')),
        MaterialSlice(
          key: ValueKey('item1'),
          child: ListTile(leading: Icon(Icons.star), title: Text('Item 1')),
        ),
        MaterialSlice(
          key: ValueKey('item2'),
          child: ListTile(leading: Icon(Icons.star), title: Text('Item 2')),
        ),
        MaterialSlice(
          key: ValueKey('item3'),
          child: ListTile(leading: Icon(Icons.star), title: Text('Item 3')),
        ),
        MaterialGap(key: ValueKey('g2')),
        MaterialSlice(
          key: ValueKey('footer'),
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey.shade100,
            child: Text(
              'Footer',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(header/items/footer with gaps) created');

  // ========== MERGEABLEMATERIAL PROPERTIES ==========
  print('--- MergeableMaterial Properties ---');

  // Variation 6: MergeableMaterial with elevation
  final widget6 = SingleChildScrollView(
    child: MergeableMaterial(
      elevation: 8,
      children: [
        MaterialSlice(
          key: ValueKey('elevated'),
          child: ListTile(title: Text('Elevated MergeableMaterial')),
        ),
      ],
    ),
  );
  print('MergeableMaterial(elevation: 8) created');

  // Variation 7: MergeableMaterial with hasDividers false
  final widget7 = SingleChildScrollView(
    child: MergeableMaterial(
      hasDividers: false,
      children: [
        MaterialSlice(
          key: ValueKey('nd1'),
          child: ListTile(title: Text('No Divider 1')),
        ),
        MaterialSlice(
          key: ValueKey('nd2'),
          child: ListTile(title: Text('No Divider 2')),
        ),
        MaterialSlice(
          key: ValueKey('nd3'),
          child: ListTile(title: Text('No Divider 3')),
        ),
      ],
    ),
  );
  print('MergeableMaterial(hasDividers: false) created');

  // Variation 8: MergeableMaterial with dividerColor
  final widget8 = SingleChildScrollView(
    child: MergeableMaterial(
      dividerColor: Colors.red,
      children: [
        MaterialSlice(
          key: ValueKey('dc1'),
          child: ListTile(title: Text('Red Divider 1')),
        ),
        MaterialSlice(
          key: ValueKey('dc2'),
          child: ListTile(title: Text('Red Divider 2')),
        ),
      ],
    ),
  );
  print('MergeableMaterial(dividerColor: red) created');

  // Variation 9: MergeableMaterial with complex content in slices
  final widget9 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('rich1'),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(child: Text('A')),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alice',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'alice@example.com',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        MaterialGap(key: ValueKey('g-rich')),
        MaterialSlice(
          key: ValueKey('rich2'),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(child: Text('B')),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bob',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'bob@example.com',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('MergeableMaterial(complex content with Row/Column) created');

  // Variation 10: MaterialSlice with color
  final widget10 = SingleChildScrollView(
    child: MergeableMaterial(
      children: [
        MaterialSlice(
          key: ValueKey('color1'),
          color: Colors.amber.shade50,
          child: ListTile(title: Text('Colored Slice 1')),
        ),
        MaterialSlice(
          key: ValueKey('color2'),
          color: Colors.lightBlue.shade50,
          child: ListTile(title: Text('Colored Slice 2')),
        ),
      ],
    ),
  );
  print('MaterialSlice(color) created');

  print('MergeableMaterial/MaterialGap/MaterialSlice test completed');
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
        SizedBox(height: 16),
        widget5,
        SizedBox(height: 16),
        widget6,
        SizedBox(height: 16),
        widget7,
        SizedBox(height: 16),
        widget8,
        SizedBox(height: 16),
        widget9,
        SizedBox(height: 16),
        widget10,
      ],
    ),
  );
}
