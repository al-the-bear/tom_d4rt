// D4rt test script: Tests CupertinoFormSection, CupertinoFormRow, CupertinoTextFormFieldRow from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino form test executing');

  // ========== CUPERTINOFORMSECTION ==========
  print('--- CupertinoFormSection Tests ---');

  // Test basic CupertinoFormSection
  final basicFormSection = CupertinoFormSection(
    children: [
      CupertinoTextFormFieldRow(placeholder: 'Name'),
      CupertinoTextFormFieldRow(placeholder: 'Email'),
    ],
  );
  print('Basic CupertinoFormSection created');

  // Test CupertinoFormSection with header
  final headerFormSection = CupertinoFormSection(
    header: Text('Personal Information'),
    children: [
      CupertinoTextFormFieldRow(placeholder: 'First Name'),
      CupertinoTextFormFieldRow(placeholder: 'Last Name'),
    ],
  );
  print('CupertinoFormSection with header created');

  // Test CupertinoFormSection with footer
  final footerFormSection = CupertinoFormSection(
    footer: Text('Enter your contact details'),
    children: [CupertinoTextFormFieldRow(placeholder: 'Phone')],
  );
  print('CupertinoFormSection with footer created');

  // Test CupertinoFormSection with margin
  final marginFormSection = CupertinoFormSection(
    margin: EdgeInsets.all(20.0),
    children: [CupertinoTextFormFieldRow(placeholder: 'Address')],
  );
  print('CupertinoFormSection with margin created');

  // Test CupertinoFormSection with backgroundColor
  final bgFormSection = CupertinoFormSection(
    backgroundColor: CupertinoColors.systemGrey6,
    children: [CupertinoTextFormFieldRow(placeholder: 'City')],
  );
  print('CupertinoFormSection with backgroundColor created');

  // Test CupertinoFormSection with decoration
  final decoratedFormSection = CupertinoFormSection(
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    children: [CupertinoTextFormFieldRow(placeholder: 'Country')],
  );
  print('CupertinoFormSection with decoration created');

  // Test CupertinoFormSection with clipBehavior
  final clippedFormSection = CupertinoFormSection(
    clipBehavior: Clip.antiAlias,
    children: [CupertinoTextFormFieldRow(placeholder: 'Zip Code')],
  );
  print('CupertinoFormSection with clipBehavior created');

  // Test CupertinoFormSection.insetGrouped
  final insetGroupedSection = CupertinoFormSection.insetGrouped(
    header: Text('Account'),
    children: [
      CupertinoTextFormFieldRow(
        prefix: Text('Username'),
        placeholder: 'Enter username',
      ),
      CupertinoTextFormFieldRow(
        prefix: Text('Password'),
        placeholder: 'Enter password',
        obscureText: true,
      ),
    ],
  );
  print('CupertinoFormSection.insetGrouped created');

  // ========== CUPERTINOFORMROW ==========
  print('--- CupertinoFormRow Tests ---');

  // Test basic CupertinoFormRow
  final basicFormRow = CupertinoFormRow(
    prefix: Text('Label'),
    child: CupertinoSwitch(value: true, onChanged: (value) {}),
  );
  print('Basic CupertinoFormRow created');

  // Test CupertinoFormRow with helper text
  final helperFormRow = CupertinoFormRow(
    prefix: Text('Setting'),
    helper: Text('This controls something'),
    child: CupertinoSwitch(value: false, onChanged: (value) {}),
  );
  print('CupertinoFormRow with helper created');

  // Test CupertinoFormRow with error
  final errorFormRow = CupertinoFormRow(
    prefix: Text('Required'),
    error: Text(
      'This field is required',
      style: TextStyle(color: CupertinoColors.systemRed),
    ),
    child: CupertinoTextField(placeholder: 'Enter value'),
  );
  print('CupertinoFormRow with error created');

  // Test CupertinoFormRow with padding
  final paddedFormRow = CupertinoFormRow(
    prefix: Text('Padded'),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    child: CupertinoSwitch(value: true, onChanged: (value) {}),
  );
  print('CupertinoFormRow with padding created');

  // ========== CUPERTINOTEXTFORMFIELDROW ==========
  print('--- CupertinoTextFormFieldRow Tests ---');

  // Test basic CupertinoTextFormFieldRow
  final basicTextFormRow = CupertinoTextFormFieldRow(placeholder: 'Enter text');
  print('Basic CupertinoTextFormFieldRow created');

  // Test CupertinoTextFormFieldRow with prefix
  final prefixTextFormRow = CupertinoTextFormFieldRow(
    prefix: Text('Email'),
    placeholder: 'example@email.com',
  );
  print('CupertinoTextFormFieldRow with prefix created');

  // Test CupertinoTextFormFieldRow with controller
  final controllerTextFormRow = CupertinoTextFormFieldRow(
    controller: TextEditingController(text: 'Initial value'),
    placeholder: 'Type here',
  );
  print('CupertinoTextFormFieldRow with controller created');

  // Test CupertinoTextFormFieldRow with initialValue
  final initialTextFormRow = CupertinoTextFormFieldRow(
    initialValue: 'Default text',
    placeholder: 'Initial value',
  );
  print('CupertinoTextFormFieldRow with initialValue created');

  // Test CupertinoTextFormFieldRow with obscureText
  final obscureTextFormRow = CupertinoTextFormFieldRow(
    prefix: Text('Password'),
    placeholder: 'Enter password',
    obscureText: true,
  );
  print('CupertinoTextFormFieldRow with obscureText created');

  // Test CupertinoTextFormFieldRow with keyboardType
  final keyboardTextFormRow = CupertinoTextFormFieldRow(
    prefix: Text('Phone'),
    placeholder: '123-456-7890',
    keyboardType: TextInputType.phone,
  );
  print('CupertinoTextFormFieldRow with keyboardType created');

  // Test CupertinoTextFormFieldRow with textInputAction
  final actionTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Search',
    textInputAction: TextInputAction.search,
  );
  print('CupertinoTextFormFieldRow with textInputAction created');

  // Test CupertinoTextFormFieldRow with textCapitalization
  final capitalTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Name',
    textCapitalization: TextCapitalization.words,
  );
  print('CupertinoTextFormFieldRow with textCapitalization created');

  // Test CupertinoTextFormFieldRow with validator
  final validatorTextFormRow = CupertinoTextFormFieldRow(
    prefix: Text('Email'),
    placeholder: 'Required',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      return null;
    },
  );
  print('CupertinoTextFormFieldRow with validator created');

  // Test CupertinoTextFormFieldRow with onSaved
  final savedTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Saved field',
    onSaved: (value) {
      print('Saved: $value');
    },
  );
  print('CupertinoTextFormFieldRow with onSaved created');

  // Test CupertinoTextFormFieldRow with onChanged
  final changedTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Type to change',
    onChanged: (value) {
      print('Changed: $value');
    },
  );
  print('CupertinoTextFormFieldRow with onChanged created');

  // Test CupertinoTextFormFieldRow with maxLength
  final maxLengthTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Max 10 chars',
    maxLength: 10,
  );
  print('CupertinoTextFormFieldRow with maxLength created');

  // Test CupertinoTextFormFieldRow with maxLines
  final maxLinesTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Multi-line',
    maxLines: 3,
  );
  print('CupertinoTextFormFieldRow with maxLines created');

  // Test CupertinoTextFormFieldRow with minLines
  final minLinesTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Min 2 lines',
    minLines: 2,
    maxLines: 5,
  );
  print('CupertinoTextFormFieldRow with minLines created');

  // Test CupertinoTextFormFieldRow with autocorrect
  final autocorrectTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'No autocorrect',
    autocorrect: false,
  );
  print('CupertinoTextFormFieldRow with autocorrect created');

  // Test CupertinoTextFormFieldRow with autofocus
  final autofocusTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Auto focus',
    autofocus: false,
  );
  print('CupertinoTextFormFieldRow with autofocus created');

  // Test CupertinoTextFormFieldRow with enabled
  final disabledTextFormRow = CupertinoTextFormFieldRow(
    prefix: Text('Disabled'),
    placeholder: 'Cannot edit',
    enabled: false,
  );
  print('CupertinoTextFormFieldRow with enabled=false created');

  // Test CupertinoTextFormFieldRow with readOnly
  final readOnlyTextFormRow = CupertinoTextFormFieldRow(
    prefix: Text('Read Only'),
    initialValue: 'Read only value',
    readOnly: true,
  );
  print('CupertinoTextFormFieldRow with readOnly created');

  // Test CupertinoTextFormFieldRow with textAlign
  final alignedTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Right aligned',
    textAlign: TextAlign.right,
  );
  print('CupertinoTextFormFieldRow with textAlign created');

  // Test CupertinoTextFormFieldRow with style
  final styledTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Styled text',
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: CupertinoColors.systemBlue,
    ),
  );
  print('CupertinoTextFormFieldRow with style created');

  // Test CupertinoTextFormFieldRow with placeholderStyle
  final placeholderStyledTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Custom placeholder',
    placeholderStyle: TextStyle(
      color: CupertinoColors.systemGrey,
      fontStyle: FontStyle.italic,
    ),
  );
  print('CupertinoTextFormFieldRow with placeholderStyle created');

  // Test CupertinoTextFormFieldRow with padding
  final paddedTextFormRow = CupertinoTextFormFieldRow(
    placeholder: 'Padded input',
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
  );
  print('CupertinoTextFormFieldRow with padding created');

  print('Cupertino form test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Standard form section
              CupertinoFormSection(
                header: Text('PERSONAL INFORMATION'),
                footer: Text('Enter your personal details'),
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: Text('Name'),
                    placeholder: 'John Doe',
                    textCapitalization: TextCapitalization.words,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text('Email'),
                    placeholder: 'email@example.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text('Phone'),
                    placeholder: '(555) 555-5555',
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),

              // Inset grouped form section
              CupertinoFormSection.insetGrouped(
                header: Text('ACCOUNT SETTINGS'),
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: Text('Username'),
                    placeholder: 'Enter username',
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text('Password'),
                    placeholder: 'Enter password',
                    obscureText: true,
                  ),
                  CupertinoFormRow(
                    prefix: Text('Notifications'),
                    child: CupertinoSwitch(value: true, onChanged: (value) {}),
                  ),
                ],
              ),

              // Form section with helper and error
              CupertinoFormSection.insetGrouped(
                header: Text('ADDRESS'),
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: Text('Street'),
                    placeholder: '123 Main St',
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text('City'),
                    placeholder: 'Required',
                    validator: (value) =>
                        value?.isEmpty == true ? 'Required' : null,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text('Zip'),
                    placeholder: '12345',
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                  ),
                ],
              ),

              // Custom styled section
              CupertinoFormSection(
                header: Text('PREFERENCES'),
                backgroundColor: CupertinoColors.systemGrey6,
                children: [
                  CupertinoFormRow(
                    prefix: Text('Dark Mode'),
                    helper: Text('Use dark appearance'),
                    child: CupertinoSwitch(value: false, onChanged: (value) {}),
                  ),
                  CupertinoFormRow(
                    prefix: Text('Sound'),
                    child: CupertinoSwitch(value: true, onChanged: (value) {}),
                  ),
                ],
              ),

              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    ),
  );
}
