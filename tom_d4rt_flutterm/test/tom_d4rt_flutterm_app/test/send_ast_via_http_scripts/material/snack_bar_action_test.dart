// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SnackBarAction from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
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

Widget buildSnackBarPreview(
  String label,
  String description,
  SnackBar snackBar,
  BuildContext context,
) {
  print('Building SnackBar preview: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
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
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: Text('Show SnackBar'),
        ),
      ],
    ),
  );
}

Widget buildActionShowcase(
  String title,
  String actionLabel,
  VoidCallback? onPressed,
  Color? textColor,
  Color? disabledTextColor,
  Color? backgroundColor,
) {
  print('Building action showcase: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.grey.shade800,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Action: $actionLabel',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        SnackBarAction(
          label: actionLabel,
          onPressed: onPressed ?? () {},
          textColor: textColor,
          disabledTextColor: disabledTextColor,
        ),
      ],
    ),
  );
}

Widget buildActionButtonDemo(
  String label,
  Color buttonColor,
  Color textColorValue,
  VoidCallback onTap,
) {
  print('Building action button demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            label,
            style: TextStyle(
              color: textColorValue,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildColorSwatch(String name, Color color, Color textOnColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: textOnColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget buildSnackBarActionRow(
  String description,
  SnackBarAction action,
) {
  print('Building action row: $description');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade700),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            description,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
        action,
      ],
    ),
  );
}

Widget buildPaddedContainer(Widget child, EdgeInsets padding) {
  return Padding(
    padding: padding,
    child: child,
  );
}

Widget main() {
  print('SnackBarAction Deep Demo');
  print('========================');
  print('Demonstrating SnackBarAction widget features');

  return MaterialApp(
    title: 'SnackBarAction Deep Demo',
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.grey.shade100,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('SnackBarAction Deep Demo'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: SnackBarAction Basics
                buildSectionHeader('SnackBarAction Basics'),
                buildInfoCard(
                  'Purpose',
                  'SnackBarAction is a button displayed within a SnackBar, allowing users to perform an action related to the snackbar message.',
                ),
                buildInfoCard(
                  'Widget Type',
                  'SnackBarAction extends StatefulWidget and implements the action button interface for SnackBar.',
                ),
                buildInfoCard(
                  'Key Properties',
                  'label (required), onPressed (required), textColor, disabledTextColor, backgroundColor',
                ),
                buildInfoCard(
                  'Typical Use',
                  'Undo operations, retry actions, navigation, or dismissal confirmation.',
                ),
                SizedBox(height: 8),
                buildSnackBarPreview(
                  'Basic SnackBarAction',
                  'Simple action with label and callback',
                  SnackBar(
                    content: Text('Item deleted'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        print('Undo pressed!');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'SnackBarAction with Duration',
                  'Action visible for longer duration',
                  SnackBar(
                    content: Text('Changes saved successfully'),
                    duration: Duration(seconds: 5),
                    action: SnackBarAction(
                      label: 'VIEW',
                      onPressed: () {
                        print('View action pressed!');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'SnackBarAction in Floating SnackBar',
                  'Floating style with rounded corners',
                  SnackBar(
                    content: Text('Message sent'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    action: SnackBarAction(
                      label: 'DISMISS',
                      onPressed: () {
                        print('Dismiss pressed');
                      },
                    ),
                  ),
                  context,
                ),

                // Section 2: Label Property
                buildSectionHeader('Label Property'),
                buildInfoCard(
                  'Description',
                  'The label property defines the text displayed on the action button.',
                ),
                buildInfoCard(
                  'Best Practices',
                  'Use short, action-oriented words. Common labels: UNDO, RETRY, DISMISS, VIEW, OPEN.',
                ),
                buildInfoCard(
                  'Casing',
                  'Uppercase is conventional but not required. Match your app style guide.',
                ),
                SizedBox(height: 8),
                buildSnackBarPreview(
                  'UNDO Label',
                  'Classic undo action for reversible operations',
                  SnackBar(
                    content: Text('Email moved to trash'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        print('Undo action executed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'RETRY Label',
                  'Retry action for failed operations',
                  SnackBar(
                    content: Text('Failed to send message'),
                    action: SnackBarAction(
                      label: 'RETRY',
                      onPressed: () {
                        print('Retry action executed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'SETTINGS Label',
                  'Navigate to settings or configuration',
                  SnackBar(
                    content: Text('Notifications disabled'),
                    action: SnackBarAction(
                      label: 'SETTINGS',
                      onPressed: () {
                        print('Opening settings');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Lowercase Label',
                  'Using lowercase styling for modern look',
                  SnackBar(
                    content: Text('Profile updated'),
                    action: SnackBarAction(
                      label: 'view changes',
                      onPressed: () {
                        print('Viewing changes');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Multi-word Label',
                  'Longer action descriptions when needed',
                  SnackBar(
                    content: Text('Download complete'),
                    action: SnackBarAction(
                      label: 'OPEN FILE',
                      onPressed: () {
                        print('Opening downloaded file');
                      },
                    ),
                  ),
                  context,
                ),

                // Section 3: onPressed Callback
                buildSectionHeader('onPressed Callback'),
                buildInfoCard(
                  'Description',
                  'The onPressed callback is invoked when the user taps the action button.',
                ),
                buildInfoCard(
                  'Behavior',
                  'After onPressed is called, the SnackBar automatically dismisses unless duration is very long.',
                ),
                buildInfoCard(
                  'Use Cases',
                  'Undo operations, navigate routes, show dialogs, trigger API calls, update state.',
                ),
                SizedBox(height: 8),
                buildSnackBarPreview(
                  'Simple Callback',
                  'Basic print statement callback',
                  SnackBar(
                    content: Text('Simple callback demo'),
                    action: SnackBarAction(
                      label: 'TAP ME',
                      onPressed: () {
                        print('Simple callback executed!');
                        print('Action completed at ${DateTime.now()}');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Counter Callback',
                  'Callback that tracks invocations',
                  SnackBar(
                    content: Text('Counter demo - check console'),
                    action: SnackBarAction(
                      label: 'INCREMENT',
                      onPressed: () {
                        int counter = 0;
                        counter++;
                        print('Counter incremented to: $counter');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Navigation Callback',
                  'Callback that could trigger navigation',
                  SnackBar(
                    content: Text('New message received'),
                    action: SnackBarAction(
                      label: 'VIEW',
                      onPressed: () {
                        print('Would navigate to messages screen');
                        print('Navigation action triggered');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Async Action Simulation',
                  'Callback simulating async operation',
                  SnackBar(
                    content: Text('Connection lost'),
                    duration: Duration(seconds: 6),
                    action: SnackBarAction(
                      label: 'RECONNECT',
                      onPressed: () {
                        print('Attempting to reconnect...');
                        print('Reconnection callback started');
                      },
                    ),
                  ),
                  context,
                ),

                // Section 4: textColor Customization
                buildSectionHeader('textColor Customization'),
                buildInfoCard(
                  'Description',
                  'The textColor property sets the color of the action button text.',
                ),
                buildInfoCard(
                  'Default',
                  'If not specified, uses SnackBarThemeData.actionTextColor or defaults to accent color.',
                ),
                buildInfoCard(
                  'Contrast',
                  'Ensure sufficient contrast against the SnackBar background for accessibility.',
                ),
                SizedBox(height: 8),
                buildSnackBarPreview(
                  'Yellow Text Color',
                  'High contrast yellow on dark background',
                  SnackBar(
                    content: Text('Custom yellow action'),
                    backgroundColor: Colors.grey.shade900,
                    action: SnackBarAction(
                      label: 'ACTION',
                      textColor: Colors.yellow,
                      onPressed: () {
                        print('Yellow action pressed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Cyan Text Color',
                  'Bright cyan for modern appearance',
                  SnackBar(
                    content: Text('Cyan styled action'),
                    backgroundColor: Colors.blueGrey.shade900,
                    action: SnackBarAction(
                      label: 'CONFIRM',
                      textColor: Colors.cyanAccent,
                      onPressed: () {
                        print('Cyan action pressed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Orange Text Color',
                  'Warning-style orange action',
                  SnackBar(
                    content: Text('Warning notification'),
                    backgroundColor: Colors.grey.shade800,
                    action: SnackBarAction(
                      label: 'LEARN MORE',
                      textColor: Colors.orange,
                      onPressed: () {
                        print('Orange action pressed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Green Text Color',
                  'Success-style green action',
                  SnackBar(
                    content: Text('Success! Operation complete.'),
                    backgroundColor: Colors.grey.shade800,
                    action: SnackBarAction(
                      label: 'DONE',
                      textColor: Colors.greenAccent,
                      onPressed: () {
                        print('Green action pressed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Pink Text Color',
                  'Accent pink for emphasis',
                  SnackBar(
                    content: Text('New feature available'),
                    backgroundColor: Colors.indigo.shade900,
                    action: SnackBarAction(
                      label: 'EXPLORE',
                      textColor: Colors.pinkAccent,
                      onPressed: () {
                        print('Pink action pressed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'White Text Color',
                  'Clean white action on colored background',
                  SnackBar(
                    content: Text('Information message'),
                    backgroundColor: Colors.deepPurple.shade700,
                    action: SnackBarAction(
                      label: 'GOT IT',
                      textColor: Colors.white,
                      onPressed: () {
                        print('White action pressed');
                      },
                    ),
                  ),
                  context,
                ),

                // Section 5: disabledTextColor
                buildSectionHeader('disabledTextColor'),
                buildInfoCard(
                  'Description',
                  'The disabledTextColor property sets the color when the action is disabled.',
                ),
                buildInfoCard(
                  'Usage',
                  'Shown when the action has already been pressed or is not currently available.',
                ),
                buildInfoCard(
                  'Design',
                  'Typically a muted version of textColor to indicate non-interactive state.',
                ),
                SizedBox(height: 8),
                Container(
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
                        'Disabled Color Examples',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      buildActionShowcase(
                        'Active Action',
                        'ENABLED',
                        () => print('Action is active'),
                        Colors.amber,
                        Colors.grey,
                        null,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          buildColorSwatch('Active', Colors.amber, Colors.black),
                          buildColorSwatch('Disabled', Colors.grey, Colors.white),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Color Combinations',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          buildColorSwatch('Yellow', Colors.yellow, Colors.black),
                          buildColorSwatch('Grey.400', Colors.grey.shade400, Colors.black),
                        ],
                      ),
                      Row(
                        children: [
                          buildColorSwatch('Cyan', Colors.cyan, Colors.black),
                          buildColorSwatch('Grey.500', Colors.grey.shade500, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          buildColorSwatch('Green', Colors.green, Colors.white),
                          buildColorSwatch('Grey.600', Colors.grey.shade600, Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),

                // Section 6: SnackBar with Action Integration
                buildSectionHeader('SnackBar with Action Integration'),
                buildInfoCard(
                  'Integration',
                  'SnackBarAction integrates seamlessly with SnackBar via the action property.',
                ),
                buildInfoCard(
                  'Positioning',
                  'Action appears on the right side of the SnackBar content.',
                ),
                buildInfoCard(
                  'Theming',
                  'Respects SnackBarThemeData for consistent styling across the app.',
                ),
                SizedBox(height: 8),
                buildSnackBarPreview(
                  'Standard Fixed SnackBar',
                  'Fixed position at bottom of screen',
                  SnackBar(
                    content: Text('Fixed position SnackBar'),
                    behavior: SnackBarBehavior.fixed,
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        print('Fixed SnackBar action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Floating SnackBar Integration',
                  'Floating style with margin from edges',
                  SnackBar(
                    content: Text('Floating SnackBar with action'),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(16),
                    action: SnackBarAction(
                      label: 'CLOSE',
                      textColor: Colors.lightBlueAccent,
                      onPressed: () {
                        print('Floating SnackBar action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Rounded Floating SnackBar',
                  'Custom shape with border radius',
                  SnackBar(
                    content: Text('Rounded corners style'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    action: SnackBarAction(
                      label: 'NICE',
                      textColor: Colors.tealAccent,
                      onPressed: () {
                        print('Rounded SnackBar action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Custom Background SnackBar',
                  'Action with custom background color',
                  SnackBar(
                    content: Text(
                      'Error occurred!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red.shade700,
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'RETRY',
                      textColor: Colors.white,
                      onPressed: () {
                        print('Error SnackBar retry action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Success SnackBar',
                  'Green background for success states',
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Operation successful'),
                      ],
                    ),
                    backgroundColor: Colors.green.shade600,
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'DETAILS',
                      textColor: Colors.white,
                      onPressed: () {
                        print('Success SnackBar details action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Warning SnackBar',
                  'Amber background for warnings',
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.black87),
                        SizedBox(width: 8),
                        Text(
                          'Low storage space',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.amber.shade400,
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'FIX',
                      textColor: Colors.black87,
                      onPressed: () {
                        print('Warning SnackBar fix action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Extended Duration',
                  'Longer visibility with action',
                  SnackBar(
                    content: Text('This SnackBar stays visible longer'),
                    duration: Duration(seconds: 10),
                    showCloseIcon: true,
                    action: SnackBarAction(
                      label: 'TAKE ACTION',
                      textColor: Colors.yellowAccent,
                      onPressed: () {
                        print('Extended duration action');
                      },
                    ),
                  ),
                  context,
                ),

                // Section 7: Multiple Action Patterns
                buildSectionHeader('Multiple Action Patterns'),
                buildInfoCard(
                  'Single Action Pattern',
                  'Standard pattern with one action button for primary action.',
                ),
                buildInfoCard(
                  'Action + Close Icon',
                  'Combine action with close icon for dismiss alternative.',
                ),
                buildInfoCard(
                  'Rich Content Actions',
                  'Custom content combined with action button.',
                ),
                SizedBox(height: 8),
                buildSnackBarPreview(
                  'Action with Close Icon',
                  'Both action button and close icon',
                  SnackBar(
                    content: Text('Multiple dismiss options'),
                    showCloseIcon: true,
                    closeIconColor: Colors.white70,
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.lightBlueAccent,
                      onPressed: () {
                        print('Undo with close icon available');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Multi-line with Action',
                  'Longer content with action on separate line',
                  SnackBar(
                    content: Text(
                      'This is a longer message that provides more context about the action that was taken by the user in the application.',
                    ),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'LEARN MORE',
                      onPressed: () {
                        print('Learn more action pressed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Icon + Text + Action',
                  'Leading icon with text content and action',
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.cloud_download, color: Colors.white),
                        SizedBox(width: 12),
                        Expanded(child: Text('Downloading update...')),
                      ],
                    ),
                    duration: Duration(seconds: 8),
                    action: SnackBarAction(
                      label: 'CANCEL',
                      textColor: Colors.redAccent,
                      onPressed: () {
                        print('Download cancelled');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Progress Indicator Pattern',
                  'SnackBar with progress and cancel action',
                  SnackBar(
                    content: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text('Syncing data...'),
                      ],
                    ),
                    duration: Duration(seconds: 15),
                    action: SnackBarAction(
                      label: 'STOP',
                      textColor: Colors.orangeAccent,
                      onPressed: () {
                        print('Sync stopped');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Avatar Pattern',
                  'User avatar with notification and action',
                  SnackBar(
                    content: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue,
                          child: Text('JD', style: TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                        SizedBox(width: 12),
                        Expanded(child: Text('John Doe sent you a message')),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'REPLY',
                      textColor: Colors.lightBlueAccent,
                      onPressed: () {
                        print('Reply action pressed');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Badge Pattern',
                  'Count badge with action',
                  SnackBar(
                    content: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text('New notifications'),
                      ],
                    ),
                    action: SnackBarAction(
                      label: 'VIEW ALL',
                      onPressed: () {
                        print('View all notifications');
                      },
                    ),
                  ),
                  context,
                ),

                // Section 8: Custom Styling
                buildSectionHeader('Custom Styling'),
                buildInfoCard(
                  'SnackBarThemeData',
                  'Define app-wide SnackBarAction styling through theme.',
                ),
                buildInfoCard(
                  'Custom Padding',
                  'Use SnackBar padding to affect action spacing.',
                ),
                buildInfoCard(
                  'Shape Combinations',
                  'Combine shaped SnackBars with styled actions.',
                ),
                SizedBox(height: 8),
                buildSnackBarPreview(
                  'Stadium Shape',
                  'Pill-shaped SnackBar with action',
                  SnackBar(
                    content: Text('Stadium shaped SnackBar'),
                    behavior: SnackBarBehavior.floating,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    action: SnackBarAction(
                      label: 'OK',
                      textColor: Colors.tealAccent,
                      onPressed: () {
                        print('Stadium shape action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Beveled Rectangle',
                  'Unique beveled corners style',
                  SnackBar(
                    content: Text('Beveled rectangle shape'),
                    behavior: SnackBarBehavior.floating,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    action: SnackBarAction(
                      label: 'COOL',
                      textColor: Colors.purpleAccent,
                      onPressed: () {
                        print('Beveled shape action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Bordered SnackBar',
                  'SnackBar with visible border',
                  SnackBar(
                    content: Text('Bordered notification'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.grey.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.tealAccent, width: 2),
                    ),
                    action: SnackBarAction(
                      label: 'NICE',
                      textColor: Colors.tealAccent,
                      onPressed: () {
                        print('Bordered style action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Wide Floating SnackBar',
                  'Full width floating with custom margin',
                  SnackBar(
                    content: Text('Wide floating SnackBar'),
                    behavior: SnackBarBehavior.floating,
                    width: 400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    action: SnackBarAction(
                      label: 'DISMISS',
                      textColor: Colors.amberAccent,
                      onPressed: () {
                        print('Wide SnackBar action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Elevated SnackBar',
                  'SnackBar with prominent elevation',
                  SnackBar(
                    content: Text('Elevated notification'),
                    behavior: SnackBarBehavior.floating,
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    action: SnackBarAction(
                      label: 'GOT IT',
                      textColor: Colors.lightGreenAccent,
                      onPressed: () {
                        print('Elevated SnackBar action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Dark Theme Action',
                  'Dark themed SnackBar with light action',
                  SnackBar(
                    content: Text(
                      'Dark theme notification',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black87,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    action: SnackBarAction(
                      label: 'BRIGHT',
                      textColor: Colors.white,
                      onPressed: () {
                        print('Dark theme action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Gradient-Compatible',
                  'Action styled to match gradient themes',
                  SnackBar(
                    content: Text('Gradient theme compatible'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.deepPurple.shade800,
                    action: SnackBarAction(
                      label: 'GRADIENT',
                      textColor: Colors.pinkAccent.shade100,
                      onPressed: () {
                        print('Gradient compatible action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Minimal Style',
                  'Clean minimal SnackBar design',
                  SnackBar(
                    content: Text(
                      'Minimal design',
                      style: TextStyle(color: Colors.black87),
                    ),
                    backgroundColor: Colors.white,
                    behavior: SnackBarBehavior.floating,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    action: SnackBarAction(
                      label: 'MINIMAL',
                      textColor: Colors.deepPurple,
                      onPressed: () {
                        print('Minimal style action');
                      },
                    ),
                  ),
                  context,
                ),
                buildSnackBarPreview(
                  'Compact Style',
                  'Reduced padding compact SnackBar',
                  SnackBar(
                    content: Text('Compact notification'),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    action: SnackBarAction(
                      label: 'X',
                      textColor: Colors.redAccent,
                      onPressed: () {
                        print('Compact close action');
                      },
                    ),
                  ),
                  context,
                ),

                // Summary Section
                buildSectionHeader('Summary'),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SnackBarAction Key Points',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade800,
                        ),
                      ),
                      SizedBox(height: 12),
                      buildInfoCard('label', 'Required - Text displayed on action button'),
                      buildInfoCard('onPressed', 'Required - Callback executed on tap'),
                      buildInfoCard('textColor', 'Optional - Custom text color for enabled state'),
                      buildInfoCard('disabledTextColor', 'Optional - Color when action is disabled'),
                      buildInfoCard('backgroundColor', 'Optional - Background color of action button'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Best Practices',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('• Use short, action-oriented labels (UNDO, RETRY, VIEW)'),
                      Text('• Ensure sufficient color contrast for accessibility'),
                      Text('• Keep SnackBar duration appropriate for action importance'),
                      Text('• Consider combining with close icon for multiple dismiss options'),
                      Text('• Test action visibility on various SnackBar backgrounds'),
                      Text('• Use consistent styling across your application'),
                    ],
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    ),
  );
}
