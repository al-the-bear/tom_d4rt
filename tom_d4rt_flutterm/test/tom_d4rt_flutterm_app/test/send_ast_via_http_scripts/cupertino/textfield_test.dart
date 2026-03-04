// D4rt test script: Tests CupertinoTextField, CupertinoSearchTextField from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino text field test executing');

  // ========== CUPERTINOTEXTFIELD ==========
  print('--- CupertinoTextField Tests ---');

  // Test basic CupertinoTextField
  final basicField = CupertinoTextField();
  print('Basic CupertinoTextField created');

  // Test CupertinoTextField with placeholder
  final placeholderField = CupertinoTextField(placeholder: 'Enter text here');
  print('CupertinoTextField with placeholder created');

  // Test CupertinoTextField with controller
  final controlledField = CupertinoTextField(
    controller: TextEditingController(text: 'Initial text'),
  );
  print('CupertinoTextField with controller created');

  // Test CupertinoTextField with prefix
  final prefixField = CupertinoTextField(
    prefix: Icon(CupertinoIcons.person),
    placeholder: 'Username',
  );
  print('CupertinoTextField with prefix created');

  // Test CupertinoTextField with suffix
  final suffixField = CupertinoTextField(
    suffix: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.clear_circled_solid, size: 18.0),
      onPressed: () {},
    ),
    placeholder: 'With suffix',
  );
  print('CupertinoTextField with suffix created');

  // Test CupertinoTextField with prefixMode
  final prefixModeField = CupertinoTextField(
    prefix: Padding(padding: EdgeInsets.only(left: 8.0), child: Text('\$')),
    prefixMode: OverlayVisibilityMode.always,
    placeholder: 'Amount',
  );
  print('CupertinoTextField with prefixMode created');

  // Test CupertinoTextField with suffixMode
  final suffixModeField = CupertinoTextField(
    suffix: Icon(CupertinoIcons.check_mark),
    suffixMode: OverlayVisibilityMode.editing,
    placeholder: 'Shows check when editing',
  );
  print('CupertinoTextField with suffixMode created');

  // Test CupertinoTextField with clearButtonMode
  final clearButtonField = CupertinoTextField(
    clearButtonMode: OverlayVisibilityMode.editing,
    placeholder: 'With clear button',
  );
  print('CupertinoTextField with clearButtonMode created');

  // Test CupertinoTextField with decoration
  final decoratedField = CupertinoTextField(
    decoration: BoxDecoration(
      border: Border.all(color: CupertinoColors.systemBlue, width: 2.0),
      borderRadius: BorderRadius.circular(12.0),
    ),
    placeholder: 'Custom decoration',
  );
  print('CupertinoTextField with decoration created');

  // Test CupertinoTextField with padding
  final paddedField = CupertinoTextField(
    padding: EdgeInsets.all(20.0),
    placeholder: 'Custom padding',
  );
  print('CupertinoTextField with padding created');

  // Test CupertinoTextField with style
  final styledField = CupertinoTextField(
    style: TextStyle(fontSize: 18.0, color: CupertinoColors.systemPurple),
    placeholder: 'Styled text',
  );
  print('CupertinoTextField with style created');

  // Test CupertinoTextField with placeholderStyle
  final placeholderStyledField = CupertinoTextField(
    placeholderStyle: TextStyle(
      color: CupertinoColors.systemGrey2,
      fontStyle: FontStyle.italic,
    ),
    placeholder: 'Styled placeholder',
  );
  print('CupertinoTextField with placeholderStyle created');

  // Test CupertinoTextField with keyboardType
  final emailField = CupertinoTextField(
    keyboardType: TextInputType.emailAddress,
    placeholder: 'Email address',
  );
  print('CupertinoTextField with keyboardType created');

  // Test CupertinoTextField with textInputAction
  final nextField = CupertinoTextField(
    textInputAction: TextInputAction.next,
    placeholder: 'Press next',
  );
  print('CupertinoTextField with textInputAction created');

  // Test CupertinoTextField with textCapitalization
  final capitalizedField = CupertinoTextField(
    textCapitalization: TextCapitalization.words,
    placeholder: 'Capitalized words',
  );
  print('CupertinoTextField with textCapitalization created');

  // Test CupertinoTextField with obscureText
  final passwordField = CupertinoTextField(
    obscureText: true,
    placeholder: 'Password',
  );
  print('CupertinoTextField with obscureText created');

  // Test CupertinoTextField with autocorrect
  final noAutocorrectField = CupertinoTextField(
    autocorrect: false,
    placeholder: 'No autocorrect',
  );
  print('CupertinoTextField with autocorrect=false created');

  // Test CupertinoTextField with maxLength
  final maxLengthField = CupertinoTextField(
    maxLength: 20,
    placeholder: 'Max 20 chars',
  );
  print('CupertinoTextField with maxLength created');

  // Test CupertinoTextField with maxLines
  final multilineField = CupertinoTextField(
    maxLines: 3,
    placeholder: 'Multi-line input',
  );
  print('CupertinoTextField with maxLines created');

  // Test CupertinoTextField with minLines
  final minLinesField = CupertinoTextField(
    minLines: 2,
    maxLines: 5,
    placeholder: 'Expandable',
  );
  print('CupertinoTextField with minLines created');

  // Test CupertinoTextField with expands
  final expandField = CupertinoTextField(
    expands: false,
    maxLines: null,
    placeholder: 'Expanding field',
  );
  print('CupertinoTextField with expands created');

  // Test CupertinoTextField with textAlign
  final centeredField = CupertinoTextField(
    textAlign: TextAlign.center,
    placeholder: 'Centered text',
  );
  print('CupertinoTextField with textAlign created');

  // Test CupertinoTextField with textAlignVertical
  final topAlignedField = CupertinoTextField(
    textAlignVertical: TextAlignVertical.top,
    maxLines: 3,
    placeholder: 'Top aligned',
  );
  print('CupertinoTextField with textAlignVertical created');

  // Test CupertinoTextField with readOnly
  final readOnlyField = CupertinoTextField(
    readOnly: true,
    controller: TextEditingController(text: 'Read only text'),
  );
  print('CupertinoTextField with readOnly created');

  // Test CupertinoTextField with enabled
  final disabledField = CupertinoTextField(
    enabled: false,
    placeholder: 'Disabled field',
  );
  print('CupertinoTextField with enabled=false created');

  // Test CupertinoTextField with cursorColor
  final cursorColorField = CupertinoTextField(
    cursorColor: CupertinoColors.systemRed,
    placeholder: 'Red cursor',
  );
  print('CupertinoTextField with cursorColor created');

  // Test CupertinoTextField with cursorWidth
  final cursorWidthField = CupertinoTextField(
    cursorWidth: 4.0,
    placeholder: 'Wide cursor',
  );
  print('CupertinoTextField with cursorWidth created');

  // Test CupertinoTextField with cursorRadius
  final cursorRadiusField = CupertinoTextField(
    cursorRadius: Radius.circular(4.0),
    placeholder: 'Rounded cursor',
  );
  print('CupertinoTextField with cursorRadius created');

  // Test CupertinoTextField with selectionHeightStyle
  final selectionHeightField = CupertinoTextField(
    selectionHeightStyle: BoxHeightStyle.max,
    placeholder: 'Custom selection',
  );
  print('CupertinoTextField with selectionHeightStyle created');

  // Test CupertinoTextField with callbacks
  final callbackField = CupertinoTextField(
    onChanged: (value) {
      print('Changed: $value');
    },
    onSubmitted: (value) {
      print('Submitted: $value');
    },
    onEditingComplete: () {
      print('Editing complete');
    },
    onTap: () {
      print('Tapped');
    },
    placeholder: 'With callbacks',
  );
  print('CupertinoTextField with callbacks created');

  // Test CupertinoTextField.borderless
  final borderlessField = CupertinoTextField.borderless(
    placeholder: 'Borderless field',
  );
  print('CupertinoTextField.borderless created');

  // ========== CUPERTINOSEARCHTEXTFIELD ==========
  print('--- CupertinoSearchTextField Tests ---');

  // Test basic CupertinoSearchTextField
  final basicSearchField = CupertinoSearchTextField();
  print('Basic CupertinoSearchTextField created');

  // Test CupertinoSearchTextField with placeholder
  final placeholderSearchField = CupertinoSearchTextField(
    placeholder: 'Search products...',
  );
  print('CupertinoSearchTextField with placeholder created');

  // Test CupertinoSearchTextField with controller
  final controlledSearchField = CupertinoSearchTextField(
    controller: TextEditingController(text: 'Initial search'),
  );
  print('CupertinoSearchTextField with controller created');

  // Test CupertinoSearchTextField with onChanged
  final changedSearchField = CupertinoSearchTextField(
    onChanged: (value) {
      print('Search changed: $value');
    },
  );
  print('CupertinoSearchTextField with onChanged created');

  // Test CupertinoSearchTextField with onSubmitted
  final submittedSearchField = CupertinoSearchTextField(
    onSubmitted: (value) {
      print('Search submitted: $value');
    },
  );
  print('CupertinoSearchTextField with onSubmitted created');

  // Test CupertinoSearchTextField with onSuffixTap
  final suffixTapSearchField = CupertinoSearchTextField(
    onSuffixTap: () {
      print('Clear tapped');
    },
  );
  print('CupertinoSearchTextField with onSuffixTap created');

  // Test CupertinoSearchTextField with style
  final styledSearchField = CupertinoSearchTextField(
    style: TextStyle(fontSize: 16.0, color: CupertinoColors.systemIndigo),
  );
  print('CupertinoSearchTextField with style created');

  // Test CupertinoSearchTextField with placeholderStyle
  final placeholderStyleSearchField = CupertinoSearchTextField(
    placeholderStyle: TextStyle(
      color: CupertinoColors.systemGrey,
      fontStyle: FontStyle.italic,
    ),
  );
  print('CupertinoSearchTextField with placeholderStyle created');

  // Test CupertinoSearchTextField with decoration
  final decoratedSearchField = CupertinoSearchTextField(
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(12.0),
    ),
  );
  print('CupertinoSearchTextField with decoration created');

  // Test CupertinoSearchTextField with backgroundColor
  final bgSearchField = CupertinoSearchTextField(
    backgroundColor: CupertinoColors.systemYellow.withOpacity(0.3),
  );
  print('CupertinoSearchTextField with backgroundColor created');

  // Test CupertinoSearchTextField with borderRadius
  final roundedSearchField = CupertinoSearchTextField(
    borderRadius: BorderRadius.circular(20.0),
  );
  print('CupertinoSearchTextField with borderRadius created');

  // Test CupertinoSearchTextField with padding
  final paddedSearchField = CupertinoSearchTextField(
    padding: EdgeInsets.all(16.0),
  );
  print('CupertinoSearchTextField with padding created');

  // Test CupertinoSearchTextField with itemColor
  final coloredItemSearchField = CupertinoSearchTextField(
    itemColor: CupertinoColors.systemBlue,
  );
  print('CupertinoSearchTextField with itemColor created');

  // Test CupertinoSearchTextField with itemSize
  final sizedItemSearchField = CupertinoSearchTextField(itemSize: 24.0);
  print('CupertinoSearchTextField with itemSize created');

  // Test CupertinoSearchTextField with prefixIcon
  final prefixIconSearchField = CupertinoSearchTextField(
    prefixIcon: Icon(CupertinoIcons.location),
  );
  print('CupertinoSearchTextField with prefixIcon created');

  // Test CupertinoSearchTextField with prefixInsets
  final prefixInsetsSearchField = CupertinoSearchTextField(
    prefixInsets: EdgeInsets.only(left: 12.0),
  );
  print('CupertinoSearchTextField with prefixInsets created');

  // Test CupertinoSearchTextField with suffixIcon
  final suffixIconSearchField = CupertinoSearchTextField(
    suffixIcon: Icon(CupertinoIcons.mic),
  );
  print('CupertinoSearchTextField with suffixIcon created');

  // Test CupertinoSearchTextField with suffixInsets
  final suffixInsetsSearchField = CupertinoSearchTextField(
    suffixInsets: EdgeInsets.only(right: 12.0),
  );
  print('CupertinoSearchTextField with suffixInsets created');

  // Test CupertinoSearchTextField with suffixMode
  final suffixModeSearchField = CupertinoSearchTextField(
    suffixMode: OverlayVisibilityMode.always,
  );
  print('CupertinoSearchTextField with suffixMode created');

  // Test CupertinoSearchTextField with autocorrect
  final noAutocorrectSearchField = CupertinoSearchTextField(autocorrect: false);
  print('CupertinoSearchTextField with autocorrect=false created');

  // Test CupertinoSearchTextField with autofocus
  final autofocusSearchField = CupertinoSearchTextField(autofocus: false);
  print('CupertinoSearchTextField with autofocus created');

  // Test CupertinoSearchTextField with enabled
  final disabledSearchField = CupertinoSearchTextField(enabled: false);
  print('CupertinoSearchTextField with enabled=false created');

  print('Cupertino text field test completed');

  // Return a visual representation
  return CupertinoTheme(
    data: CupertinoThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Search Field:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              basicSearchField,

              SizedBox(height: 24.0),
              Text(
                'Basic Text Field:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              placeholderField,

              SizedBox(height: 16.0),
              Text(
                'With Prefix:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              prefixField,

              SizedBox(height: 16.0),
              Text(
                'Password Field:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              passwordField,

              SizedBox(height: 16.0),
              Text(
                'Custom Decoration:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              decoratedField,

              SizedBox(height: 16.0),
              Text(
                'Multi-line:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              multilineField,

              SizedBox(height: 16.0),
              Text(
                'Borderless:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              borderlessField,

              SizedBox(height: 16.0),
              Text(
                'Disabled:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              disabledField,

              SizedBox(height: 16.0),
              Text(
                'Custom Search Field:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              roundedSearchField,
            ],
          ),
        ),
      ),
    ),
  );
}
