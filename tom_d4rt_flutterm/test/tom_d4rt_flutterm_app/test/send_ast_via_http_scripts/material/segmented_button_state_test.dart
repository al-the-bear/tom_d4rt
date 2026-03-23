// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SegmentedButtonState from material
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

Widget buildDescriptionBox(String description) {
  return Container(
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

Widget buildBasicSegmentedButton() {
  print('Building basic SegmentedButton');
  Set<String> selectedValue = {'day'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
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
              'Basic Single Selection',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Selected: ${selectedValue.join(", ")}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              segments: [
                ButtonSegment<String>(
                  value: 'day',
                  label: Text('Day'),
                ),
                ButtonSegment<String>(
                  value: 'week',
                  label: Text('Week'),
                ),
                ButtonSegment<String>(
                  value: 'month',
                  label: Text('Month'),
                ),
              ],
              selected: selectedValue,
              onSelectionChanged: (Set<String> newSelection) {
                print('Selection changed to: $newSelection');
                setState(() {
                  selectedValue = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildMultiSelectionSegmentedButton() {
  print('Building multi-selection SegmentedButton');
  Set<String> selectedValues = {'bold', 'italic'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
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
              'Multi Selection Enabled',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Selected formatting: ${selectedValues.join(", ")}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              multiSelectionEnabled: true,
              segments: [
                ButtonSegment<String>(
                  value: 'bold',
                  label: Text('B', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ButtonSegment<String>(
                  value: 'italic',
                  label: Text('I', style: TextStyle(fontStyle: FontStyle.italic)),
                ),
                ButtonSegment<String>(
                  value: 'underline',
                  label: Text('U', style: TextStyle(decoration: TextDecoration.underline)),
                ),
              ],
              selected: selectedValues,
              onSelectionChanged: (Set<String> newSelection) {
                print('Multi-selection changed to: $newSelection');
                setState(() {
                  selectedValues = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildEmptySelectionSegmentedButton() {
  print('Building empty selection allowed SegmentedButton');
  Set<int> selectedIndices = {};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
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
              'Empty Selection Allowed',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Selected indices: ${selectedIndices.isEmpty ? "none" : selectedIndices.join(", ")}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<int>(
              emptySelectionAllowed: true,
              multiSelectionEnabled: true,
              segments: [
                ButtonSegment<int>(
                  value: 0,
                  label: Text('Option A'),
                ),
                ButtonSegment<int>(
                  value: 1,
                  label: Text('Option B'),
                ),
                ButtonSegment<int>(
                  value: 2,
                  label: Text('Option C'),
                ),
              ],
              selected: selectedIndices,
              onSelectionChanged: (Set<int> newSelection) {
                print('Empty selection allowed changed to: $newSelection');
                setState(() {
                  selectedIndices = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildSelectedSetDemo() {
  print('Building selected set demo');
  Set<String> prefilledSelection = {'second', 'fourth'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pre-filled Selected Set',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Initial selection was: second, fourth',
              style: TextStyle(fontSize: 12, color: Colors.purple.shade600),
            ),
            Text(
              'Current selection: ${prefilledSelection.join(", ")}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              multiSelectionEnabled: true,
              segments: [
                ButtonSegment<String>(value: 'first', label: Text('1st')),
                ButtonSegment<String>(value: 'second', label: Text('2nd')),
                ButtonSegment<String>(value: 'third', label: Text('3rd')),
                ButtonSegment<String>(value: 'fourth', label: Text('4th')),
              ],
              selected: prefilledSelection,
              onSelectionChanged: (Set<String> newSelection) {
                print('Prefilled selection changed to: $newSelection');
                setState(() {
                  prefilledSelection = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildSegmentsListDemo() {
  print('Building segments list demo');
  Set<String> selectedSize = {'medium'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      List<ButtonSegment<String>> sizeSegments = [
        ButtonSegment<String>(
          value: 'small',
          label: Text('S'),
          tooltip: 'Small size',
        ),
        ButtonSegment<String>(
          value: 'medium',
          label: Text('M'),
          tooltip: 'Medium size',
        ),
        ButtonSegment<String>(
          value: 'large',
          label: Text('L'),
          tooltip: 'Large size',
        ),
        ButtonSegment<String>(
          value: 'xl',
          label: Text('XL'),
          tooltip: 'Extra large size',
        ),
      ];
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dynamic Segments List',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Segment count: ${sizeSegments.length}',
              style: TextStyle(fontSize: 12, color: Colors.teal.shade600),
            ),
            Text(
              'Selected size: ${selectedSize.first}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              segments: sizeSegments,
              selected: selectedSize,
              onSelectionChanged: (Set<String> newSelection) {
                print('Size selection changed to: $newSelection');
                setState(() {
                  selectedSize = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildDisabledSegmentsDemo() {
  print('Building disabled segments demo');
  Set<String> selectedPlan = {'basic'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Segments with Disabled Options',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Enterprise plan is disabled',
              style: TextStyle(fontSize: 12, color: Colors.orange.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              segments: [
                ButtonSegment<String>(
                  value: 'basic',
                  label: Text('Basic'),
                  enabled: true,
                ),
                ButtonSegment<String>(
                  value: 'pro',
                  label: Text('Pro'),
                  enabled: true,
                ),
                ButtonSegment<String>(
                  value: 'enterprise',
                  label: Text('Enterprise'),
                  enabled: false,
                ),
              ],
              selected: selectedPlan,
              onSelectionChanged: (Set<String> newSelection) {
                print('Plan selection changed to: $newSelection');
                setState(() {
                  selectedPlan = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildOnSelectionChangedDemo() {
  print('Building onSelectionChanged demo');
  Set<String> selectedAction = {'view'};
  int changeCount = 0;
  String lastAction = '';
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selection Change Callback',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Change count: $changeCount',
              style: TextStyle(fontSize: 12, color: Colors.green.shade600),
            ),
            Text(
              'Last action: $lastAction',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              segments: [
                ButtonSegment<String>(value: 'view', label: Text('View')),
                ButtonSegment<String>(value: 'edit', label: Text('Edit')),
                ButtonSegment<String>(value: 'delete', label: Text('Delete')),
              ],
              selected: selectedAction,
              onSelectionChanged: (Set<String> newSelection) {
                String action = newSelection.first;
                print('Action selection changed to: $action');
                setState(() {
                  changeCount++;
                  lastAction = 'Selected $action at change #$changeCount';
                  selectedAction = newSelection;
                });
              },
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Callback tracks selection changes and updates UI',
                style: TextStyle(fontSize: 11, color: Colors.green.shade700),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildStyleButtonStyleDemo() {
  print('Building style ButtonStyle demo');
  Set<String> selectedTheme = {'light'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom ButtonStyle',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Purple themed styling with custom padding',
              style: TextStyle(fontSize: 12, color: Colors.deepPurple.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.deepPurple.shade600;
                    }
                    return Colors.deepPurple.shade50;
                  },
                ),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white;
                    }
                    return Colors.deepPurple.shade800;
                  },
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                side: WidgetStateProperty.all(
                  BorderSide(color: Colors.deepPurple.shade400, width: 2),
                ),
              ),
              segments: [
                ButtonSegment<String>(value: 'light', label: Text('Light')),
                ButtonSegment<String>(value: 'dark', label: Text('Dark')),
                ButtonSegment<String>(value: 'auto', label: Text('Auto')),
              ],
              selected: selectedTheme,
              onSelectionChanged: (Set<String> newSelection) {
                print('Theme selection changed to: $newSelection');
                setState(() {
                  selectedTheme = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildElevatedStyleDemo() {
  print('Building elevated style demo');
  Set<String> selectedPriority = {'medium'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Elevated Style with Shape',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Custom elevation and rounded shape',
              style: TextStyle(fontSize: 12, color: Colors.amber.shade700),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.amber.shade500;
                    }
                    return Colors.amber.shade100;
                  },
                ),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.black87;
                    }
                    return Colors.amber.shade900;
                  },
                ),
                elevation: WidgetStateProperty.resolveWith<double?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return 4;
                    }
                    return 0;
                  },
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              segments: [
                ButtonSegment<String>(value: 'low', label: Text('Low')),
                ButtonSegment<String>(value: 'medium', label: Text('Medium')),
                ButtonSegment<String>(value: 'high', label: Text('High')),
              ],
              selected: selectedPriority,
              onSelectionChanged: (Set<String> newSelection) {
                print('Priority selection changed to: $newSelection');
                setState(() {
                  selectedPriority = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildSegmentStylingDemo() {
  print('Building segment styling demo');
  Set<String> selectedStatus = {'active'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.cyan.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Segment Styling with Tooltips',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Each segment has a descriptive tooltip',
              style: TextStyle(fontSize: 12, color: Colors.cyan.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              segments: [
                ButtonSegment<String>(
                  value: 'active',
                  label: Text('Active'),
                  tooltip: 'Show active items only',
                ),
                ButtonSegment<String>(
                  value: 'pending',
                  label: Text('Pending'),
                  tooltip: 'Show pending items waiting for review',
                ),
                ButtonSegment<String>(
                  value: 'archived',
                  label: Text('Archived'),
                  tooltip: 'Show archived items from history',
                ),
              ],
              selected: selectedStatus,
              onSelectionChanged: (Set<String> newSelection) {
                print('Status selection changed to: $newSelection');
                setState(() {
                  selectedStatus = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildIconWithLabelDemo() {
  print('Building icon with label demo');
  Set<String> selectedView = {'list'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Icon with Label',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Segments with both icon and text',
              style: TextStyle(fontSize: 12, color: Colors.blue.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              segments: [
                ButtonSegment<String>(
                  value: 'list',
                  icon: Icon(Icons.list),
                  label: Text('List'),
                ),
                ButtonSegment<String>(
                  value: 'grid',
                  icon: Icon(Icons.grid_view),
                  label: Text('Grid'),
                ),
                ButtonSegment<String>(
                  value: 'cards',
                  icon: Icon(Icons.view_agenda),
                  label: Text('Cards'),
                ),
              ],
              selected: selectedView,
              onSelectionChanged: (Set<String> newSelection) {
                print('View selection changed to: $newSelection');
                setState(() {
                  selectedView = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildIconOnlyDemo() {
  print('Building icon only demo');
  Set<String> selectedAlignment = {'left'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.pink.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Icon Only Segments',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Compact segments with icons only',
              style: TextStyle(fontSize: 12, color: Colors.pink.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment<String>(
                  value: 'left',
                  icon: Icon(Icons.format_align_left),
                  tooltip: 'Align left',
                ),
                ButtonSegment<String>(
                  value: 'center',
                  icon: Icon(Icons.format_align_center),
                  tooltip: 'Align center',
                ),
                ButtonSegment<String>(
                  value: 'right',
                  icon: Icon(Icons.format_align_right),
                  tooltip: 'Align right',
                ),
                ButtonSegment<String>(
                  value: 'justify',
                  icon: Icon(Icons.format_align_justify),
                  tooltip: 'Justify',
                ),
              ],
              selected: selectedAlignment,
              onSelectionChanged: (Set<String> newSelection) {
                print('Alignment selection changed to: $newSelection');
                setState(() {
                  selectedAlignment = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildShowSelectedIconDemo() {
  print('Building show selected icon demo');
  Set<String> selectedSort = {'date'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.lime.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Show Selected Icon Enabled',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Checkmark appears on selected segment',
              style: TextStyle(fontSize: 12, color: Colors.lime.shade700),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              showSelectedIcon: true,
              selectedIcon: Icon(Icons.check_circle, size: 18),
              segments: [
                ButtonSegment<String>(
                  value: 'name',
                  label: Text('Name'),
                ),
                ButtonSegment<String>(
                  value: 'date',
                  label: Text('Date'),
                ),
                ButtonSegment<String>(
                  value: 'size',
                  label: Text('Size'),
                ),
              ],
              selected: selectedSort,
              onSelectionChanged: (Set<String> newSelection) {
                print('Sort selection changed to: $newSelection');
                setState(() {
                  selectedSort = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildCustomSelectedIconDemo() {
  print('Building custom selected icon demo');
  Set<String> selectedMode = {'standard'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Selected Icon',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Star icon indicates selection',
              style: TextStyle(fontSize: 12, color: Colors.red.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              showSelectedIcon: true,
              selectedIcon: Icon(Icons.star, size: 16, color: Colors.red.shade600),
              segments: [
                ButtonSegment<String>(
                  value: 'standard',
                  label: Text('Standard'),
                ),
                ButtonSegment<String>(
                  value: 'premium',
                  label: Text('Premium'),
                ),
                ButtonSegment<String>(
                  value: 'ultimate',
                  label: Text('Ultimate'),
                ),
              ],
              selected: selectedMode,
              onSelectionChanged: (Set<String> newSelection) {
                print('Mode selection changed to: $newSelection');
                setState(() {
                  selectedMode = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildMultiIconLabelDemo() {
  print('Building multi icon label demo');
  Set<String> selectedCategories = {'music', 'photos'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.indigo.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Multi Selection with Icons',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Select multiple categories',
              style: TextStyle(fontSize: 12, color: Colors.indigo.shade600),
            ),
            Text(
              'Current: ${selectedCategories.join(", ")}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              multiSelectionEnabled: true,
              emptySelectionAllowed: true,
              segments: [
                ButtonSegment<String>(
                  value: 'music',
                  icon: Icon(Icons.music_note),
                  label: Text('Music'),
                ),
                ButtonSegment<String>(
                  value: 'photos',
                  icon: Icon(Icons.photo),
                  label: Text('Photos'),
                ),
                ButtonSegment<String>(
                  value: 'videos',
                  icon: Icon(Icons.videocam),
                  label: Text('Videos'),
                ),
                ButtonSegment<String>(
                  value: 'docs',
                  icon: Icon(Icons.description),
                  label: Text('Docs'),
                ),
              ],
              selected: selectedCategories,
              onSelectionChanged: (Set<String> newSelection) {
                print('Categories selection changed to: $newSelection');
                setState(() {
                  selectedCategories = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildSegmentedButtonThemeDemo() {
  print('Building segmented button theme demo');
  Set<String> selectedNav = {'home'};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.brown.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Themed Segmented Button',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Using SegmentedButtonTheme for consistent styling',
              style: TextStyle(fontSize: 12, color: Colors.brown.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButtonTheme(
              data: SegmentedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.brown.shade700;
                      }
                      return Colors.brown.shade100;
                    },
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return Colors.brown.shade800;
                    },
                  ),
                ),
              ),
              child: SegmentedButton<String>(
                segments: [
                  ButtonSegment<String>(
                    value: 'home',
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  ButtonSegment<String>(
                    value: 'explore',
                    icon: Icon(Icons.explore),
                    label: Text('Explore'),
                  ),
                  ButtonSegment<String>(
                    value: 'profile',
                    icon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
                selected: selectedNav,
                onSelectionChanged: (Set<String> newSelection) {
                  print('Navigation selection changed to: $newSelection');
                  setState(() {
                    selectedNav = newSelection;
                  });
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildIntegerValueDemo() {
  print('Building integer value demo');
  Set<int> selectedRating = {3};
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueGrey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Integer Value Segments',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Rating: ${selectedRating.first} stars',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade600),
            ),
            SizedBox(height: 12),
            SegmentedButton<int>(
              segments: [
                ButtonSegment<int>(value: 1, label: Text('1')),
                ButtonSegment<int>(value: 2, label: Text('2')),
                ButtonSegment<int>(value: 3, label: Text('3')),
                ButtonSegment<int>(value: 4, label: Text('4')),
                ButtonSegment<int>(value: 5, label: Text('5')),
              ],
              selected: selectedRating,
              onSelectionChanged: (Set<int> newSelection) {
                print('Rating selection changed to: $newSelection');
                setState(() {
                  selectedRating = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildEnumValueDemo() {
  print('Building enum-like value demo');
  Set<String> selectedColor = {'blue'};
  Map<String, Color> colorMap = {
    'red': Colors.red,
    'green': Colors.green,
    'blue': Colors.blue,
    'purple': Colors.purple,
  };
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorMap[selectedColor.first] ?? Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color Selection Demo',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                color: colorMap[selectedColor.first],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: 12),
            SegmentedButton<String>(
              segments: [
                ButtonSegment<String>(
                  value: 'red',
                  icon: Icon(Icons.circle, color: Colors.red, size: 16),
                  label: Text('Red'),
                ),
                ButtonSegment<String>(
                  value: 'green',
                  icon: Icon(Icons.circle, color: Colors.green, size: 16),
                  label: Text('Green'),
                ),
                ButtonSegment<String>(
                  value: 'blue',
                  icon: Icon(Icons.circle, color: Colors.blue, size: 16),
                  label: Text('Blue'),
                ),
                ButtonSegment<String>(
                  value: 'purple',
                  icon: Icon(Icons.circle, color: Colors.purple, size: 16),
                  label: Text('Purple'),
                ),
              ],
              selected: selectedColor,
              onSelectionChanged: (Set<String> newSelection) {
                print('Color selection changed to: $newSelection');
                setState(() {
                  selectedColor = newSelection;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}

dynamic build(BuildContext context) {
  print('SegmentedButtonState test executing');

  return Scaffold(
    appBar: AppBar(
      title: Text('SegmentedButtonState Deep Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('SegmentedButton Basics'),
          buildDescriptionBox(
            'SegmentedButton is a Material 3 widget that provides a group of selectable '
            'segments. The SegmentedButtonState manages the internal state of the widget, '
            'including selection state, enabled state, and visual properties.',
          ),
          buildInfoCard('Widget Type', 'StatefulWidget with SegmentedButtonState'),
          buildInfoCard('Default Selection', 'Single selection mode'),
          buildInfoCard('Value Type', 'Generic type T for flexible value handling'),
          buildBasicSegmentedButton(),

          buildSectionHeader('multiSelectionEnabled'),
          buildDescriptionBox(
            'When multiSelectionEnabled is true, users can select multiple segments '
            'simultaneously. The selected property becomes a Set with multiple values.',
          ),
          buildInfoCard('Property', 'multiSelectionEnabled: bool'),
          buildInfoCard('Default', 'false (single selection only)'),
          buildMultiSelectionSegmentedButton(),
          buildEmptySelectionSegmentedButton(),

          buildSectionHeader('Selected Set'),
          buildDescriptionBox(
            'The selected property is a Set<T> containing the currently selected values. '
            'For single selection, the set contains exactly one element. '
            'For multi-selection, it can contain zero to all segment values.',
          ),
          buildInfoCard('Property', 'selected: Set<T>'),
          buildInfoCard('Required', 'Yes - must provide initial selection'),
          buildSelectedSetDemo(),

          buildSectionHeader('Segments List'),
          buildDescriptionBox(
            'The segments property takes a List<ButtonSegment<T>> defining each segment. '
            'Each ButtonSegment can have a value, label, icon, tooltip, and enabled state.',
          ),
          buildInfoCard('Property', 'segments: List<ButtonSegment<T>>'),
          buildInfoCard('Minimum', 'At least 2 segments required'),
          buildSegmentsListDemo(),
          buildDisabledSegmentsDemo(),

          buildSectionHeader('onSelectionChanged'),
          buildDescriptionBox(
            'The onSelectionChanged callback is invoked whenever the selection changes. '
            'It receives the new Set<T> of selected values, allowing state updates.',
          ),
          buildInfoCard('Callback', 'onSelectionChanged: void Function(Set<T>)?'),
          buildInfoCard('Behavior', 'Called on each user interaction'),
          buildOnSelectionChangedDemo(),

          buildSectionHeader('Style ButtonStyle'),
          buildDescriptionBox(
            'The style property accepts a ButtonStyle to customize appearance. '
            'Use WidgetStateProperty to handle different states like selected, hovered, pressed.',
          ),
          buildInfoCard('Property', 'style: ButtonStyle?'),
          buildInfoCard('States', 'selected, hovered, focused, pressed, disabled'),
          buildStyleButtonStyleDemo(),
          buildElevatedStyleDemo(),

          buildSectionHeader('Segment Styling'),
          buildDescriptionBox(
            'Individual segments can be styled through ButtonSegment properties and '
            'global theming via SegmentedButtonTheme. Tooltips provide accessibility hints.',
          ),
          buildInfoCard('Theme', 'SegmentedButtonTheme / SegmentedButtonThemeData'),
          buildInfoCard('Per Segment', 'tooltip, enabled properties'),
          buildSegmentStylingDemo(),
          buildSegmentedButtonThemeDemo(),

          buildSectionHeader('Icon with Label'),
          buildDescriptionBox(
            'Segments can display an icon, a label, or both. Use showSelectedIcon '
            'to display a checkmark indicator on selected segments. Custom selectedIcon '
            'can replace the default checkmark.',
          ),
          buildInfoCard('Icon Property', 'ButtonSegment.icon: Widget?'),
          buildInfoCard('Selected Icon', 'showSelectedIcon: bool, selectedIcon: Widget?'),
          buildIconWithLabelDemo(),
          buildIconOnlyDemo(),
          buildShowSelectedIconDemo(),
          buildCustomSelectedIconDemo(),
          buildMultiIconLabelDemo(),

          SizedBox(height: 16),
          buildSectionHeader('Additional Demos'),
          buildIntegerValueDemo(),
          buildEnumValueDemo(),

          SizedBox(height: 32),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SegmentedButtonState Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'SegmentedButtonState is the State class that manages:\n'
                  '- Selection state (single or multiple)\n'
                  '- Visual feedback for interactions\n'
                  '- Segment enabled/disabled states\n'
                  '- Animation for selection changes\n'
                  '- Accessibility and keyboard navigation',
                  style: TextStyle(fontSize: 13, color: Colors.indigo.shade700),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}
