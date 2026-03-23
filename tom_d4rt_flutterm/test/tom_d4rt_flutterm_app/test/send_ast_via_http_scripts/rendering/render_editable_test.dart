// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo: RenderEditable via EditableText and TextField
// Demonstrates editable text rendering with layout, selection, cursor,
// text alignment, direction, strut style, obscuring, formatting, and more.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('[render_editable_test] build() called');

  // Controllers for various text fields
  var leftAlignCtrl = TextEditingController(text: 'Left aligned text');
  var centerAlignCtrl = TextEditingController(text: 'Center aligned text');
  var rightAlignCtrl = TextEditingController(text: 'Right aligned text');
  var justifyAlignCtrl = TextEditingController(
    text: 'Justify aligned text that spans multiple words for demonstration',
  );

  var ltrCtrl = TextEditingController(text: 'Left-to-right text direction');
  var rtlCtrl = TextEditingController(text: 'Right-to-left text direction');

  var strutCtrl1 = TextEditingController(
    text: 'Strut with height 1.5 and leading 0.5',
  );
  var strutCtrl2 = TextEditingController(
    text: 'Strut with height 2.0 and leading 1.0',
  );
  var strutCtrl3 = TextEditingController(
    text: 'Strut with forced height enabled',
  );

  var widthBasisParentCtrl = TextEditingController(
    text: 'TextWidthBasis.parent',
  );
  var widthBasisLongestCtrl = TextEditingController(
    text: 'TextWidthBasis.longestLine',
  );

  var capNoneCtrl = TextEditingController(text: 'no capitalization applied');
  var capWordsCtrl = TextEditingController(
    text: 'words capitalization applied',
  );
  var capSentencesCtrl = TextEditingController(
    text: 'sentences capitalization applied',
  );
  var capAllCtrl = TextEditingController(
    text: 'characters capitalization applied',
  );

  var obscureCtrl = TextEditingController(text: 'secret');
  var obscureStarCtrl = TextEditingController(text: 'hidden');
  var obscureHashCtrl = TextEditingController(text: 'masked');

  var editableCtrl = TextEditingController(text: 'Direct EditableText widget');
  var editableFocus = FocusNode();

  var maxLenCtrl = TextEditingController(text: 'Hello');
  var maxLenEnforcedCtrl = TextEditingController(text: 'Enforced');

  var numberCtrl = TextEditingController(text: '12345');
  var emailCtrl = TextEditingController(text: 'user@example.com');
  var phoneCtrl = TextEditingController(text: '+1234567890');
  var urlCtrl = TextEditingController(text: 'https://example.com');
  var multilineCtrl = TextEditingController(
    text: 'Line one\nLine two\nLine three',
  );

  var digitsOnlyCtrl = TextEditingController(text: '9876');
  var upperCaseCtrl = TextEditingController(text: 'lowercase');
  var lengthLimitCtrl = TextEditingController(text: 'Short');
  var denyCtrl = TextEditingController(text: 'Allowed text 123');

  print('[render_editable_test] all controllers created');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        _buildHeader(),
        SizedBox(height: 24.0),

        // Section 1: Text Alignment
        _buildSectionTitle('1. TextField with Different textAlign Values'),
        SizedBox(height: 8.0),
        _buildAlignmentDemo(
          leftAlignCtrl,
          centerAlignCtrl,
          rightAlignCtrl,
          justifyAlignCtrl,
        ),
        SizedBox(height: 24.0),

        // Section 2: Text Direction
        _buildSectionTitle('2. TextField with Different textDirection'),
        SizedBox(height: 8.0),
        _buildDirectionDemo(ltrCtrl, rtlCtrl),
        SizedBox(height: 24.0),

        // Section 3: Strut Style
        _buildSectionTitle('3. TextField with StrutStyle'),
        SizedBox(height: 8.0),
        _buildStrutStyleDemo(strutCtrl1, strutCtrl2, strutCtrl3),
        SizedBox(height: 24.0),

        // Section 4: Text Width Basis
        _buildSectionTitle('4. TextField with textWidthBasis'),
        SizedBox(height: 8.0),
        _buildTextWidthBasisDemo(widthBasisParentCtrl, widthBasisLongestCtrl),
        SizedBox(height: 24.0),

        // Section 5: Text Capitalization
        _buildSectionTitle('5. TextField with textCapitalization Modes'),
        SizedBox(height: 8.0),
        _buildCapitalizationDemo(
          capNoneCtrl,
          capWordsCtrl,
          capSentencesCtrl,
          capAllCtrl,
        ),
        SizedBox(height: 24.0),

        // Section 6: Obscure Text
        _buildSectionTitle(
          '6. TextField with obscureText and obscuringCharacter',
        ),
        SizedBox(height: 8.0),
        _buildObscureDemo(obscureCtrl, obscureStarCtrl, obscureHashCtrl),
        SizedBox(height: 24.0),

        // Section 7: Direct EditableText
        _buildSectionTitle('7. EditableText Directly'),
        SizedBox(height: 8.0),
        _buildEditableTextDemo(editableCtrl, editableFocus),
        SizedBox(height: 24.0),

        // Section 8: Max Length and Counter
        _buildSectionTitle('8. TextField with maxLength and Counter'),
        SizedBox(height: 8.0),
        _buildMaxLengthDemo(maxLenCtrl, maxLenEnforcedCtrl),
        SizedBox(height: 24.0),

        // Section 9: Keyboard Types
        _buildSectionTitle('9. TextField with Different keyboardType Values'),
        SizedBox(height: 8.0),
        _buildKeyboardTypeDemo(
          numberCtrl,
          emailCtrl,
          phoneCtrl,
          urlCtrl,
          multilineCtrl,
        ),
        SizedBox(height: 24.0),

        // Section 10: Input Formatters
        _buildSectionTitle('10. TextField with inputFormatters'),
        SizedBox(height: 8.0),
        _buildInputFormattersDemo(
          digitsOnlyCtrl,
          upperCaseCtrl,
          lengthLimitCtrl,
          denyCtrl,
        ),
        SizedBox(height: 24.0),

        // Footer
        _buildFooter(),
      ],
    ),
  );
}

Widget _buildHeader() {
  print('[render_editable_test] building header');
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF3949AB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x661A237E),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.edit_note, size: 48.0, color: Colors.white),
        SizedBox(height: 12.0),
        Text(
          'RenderEditable Deep Demo',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Editable text rendering: alignment, direction, strut,\nobscuring, formatting, keyboard types, and more',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, color: Color(0xCCFFFFFF)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  print('[render_editable_test] section: $title');
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3949AB), Color(0xFF5C6BC0)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildLabel(String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0, top: 8.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFF5C6BC0),
      ),
    ),
  );
}

Widget _buildAlignmentDemo(
  TextEditingController leftCtrl,
  TextEditingController centerCtrl,
  TextEditingController rightCtrl,
  TextEditingController justifyCtrl,
) {
  print('[render_editable_test] building alignment demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('TextAlign.left'),
        TextField(
          controller: leftCtrl,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.format_align_left),
            hintText: 'Left aligned',
          ),
          onChanged: (val) {
            print('[alignment] left changed: $val');
          },
        ),
        _buildLabel('TextAlign.center'),
        TextField(
          controller: centerCtrl,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.format_align_center),
            hintText: 'Center aligned',
          ),
          onChanged: (val) {
            print('[alignment] center changed: $val');
          },
        ),
        _buildLabel('TextAlign.right'),
        TextField(
          controller: rightCtrl,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.format_align_right),
            hintText: 'Right aligned',
          ),
          onChanged: (val) {
            print('[alignment] right changed: $val');
          },
        ),
        _buildLabel('TextAlign.justify'),
        TextField(
          controller: justifyCtrl,
          textAlign: TextAlign.justify,
          maxLines: 2,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.format_align_justify),
            hintText: 'Justify aligned',
          ),
          onChanged: (val) {
            print('[alignment] justify changed: $val');
          },
        ),
      ],
    ),
  );
}

Widget _buildDirectionDemo(
  TextEditingController ltrCtrl,
  TextEditingController rtlCtrl,
) {
  print('[render_editable_test] building direction demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('TextDirection.ltr (Left-to-Right)'),
        TextField(
          controller: ltrCtrl,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.arrow_forward),
            labelText: 'LTR Direction',
          ),
          onChanged: (val) {
            print('[direction] ltr changed: $val');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('TextDirection.rtl (Right-to-Left)'),
        TextField(
          controller: rtlCtrl,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.arrow_back),
            labelText: 'RTL Direction',
          ),
          onChanged: (val) {
            print('[direction] rtl changed: $val');
          },
        ),
      ],
    ),
  );
}

Widget _buildStrutStyleDemo(
  TextEditingController ctrl1,
  TextEditingController ctrl2,
  TextEditingController ctrl3,
) {
  print('[render_editable_test] building strut style demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('StrutStyle(height: 1.5, leading: 0.5)'),
        TextField(
          controller: ctrl1,
          strutStyle: StrutStyle(
            height: 1.5,
            leading: 0.5,
            forceStrutHeight: false,
          ),
          maxLines: 2,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.height),
            hintText: 'Strut height 1.5',
          ),
          onChanged: (val) {
            print('[strut] ctrl1 changed: $val');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('StrutStyle(height: 2.0, leading: 1.0)'),
        TextField(
          controller: ctrl2,
          strutStyle: StrutStyle(
            height: 2.0,
            leading: 1.0,
            forceStrutHeight: false,
          ),
          maxLines: 2,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.height),
            hintText: 'Strut height 2.0',
          ),
          onChanged: (val) {
            print('[strut] ctrl2 changed: $val');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('StrutStyle(forceStrutHeight: true, fontSize: 20)'),
        TextField(
          controller: ctrl3,
          strutStyle: StrutStyle(
            fontSize: 20.0,
            height: 1.8,
            forceStrutHeight: true,
          ),
          maxLines: 2,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.text_fields),
            hintText: 'Forced strut height',
          ),
          onChanged: (val) {
            print('[strut] ctrl3 forced changed: $val');
          },
        ),
      ],
    ),
  );
}

Widget _buildTextWidthBasisDemo(
  TextEditingController parentCtrl,
  TextEditingController longestCtrl,
) {
  print('[render_editable_test] building text width basis demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('TextWidthBasis.parent'),
        SizedBox(
          width: 250.0,
          child: TextField(
            controller: parentCtrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.width_normal),
              hintText: 'Parent width basis',
            ),
            onChanged: (val) {
              print('[widthBasis] parent changed: $val');
            },
          ),
        ),
        SizedBox(height: 12.0),
        _buildLabel('TextWidthBasis.longestLine'),
        SizedBox(
          width: 250.0,
          child: TextField(
            controller: longestCtrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.width_wide),
              hintText: 'Longest line width basis',
            ),
            onChanged: (val) {
              print('[widthBasis] longestLine changed: $val');
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildCapitalizationDemo(
  TextEditingController noneCtrl,
  TextEditingController wordsCtrl,
  TextEditingController sentencesCtrl,
  TextEditingController allCtrl,
) {
  print('[render_editable_test] building capitalization demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('TextCapitalization.none'),
        TextField(
          controller: noneCtrl,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.text_format),
            hintText: 'No capitalization',
          ),
          onChanged: (val) {
            print('[capitalization] none changed: $val');
          },
        ),
        SizedBox(height: 10.0),
        _buildLabel('TextCapitalization.words'),
        TextField(
          controller: wordsCtrl,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.text_format),
            hintText: 'Words capitalization',
          ),
          onChanged: (val) {
            print('[capitalization] words changed: $val');
          },
        ),
        SizedBox(height: 10.0),
        _buildLabel('TextCapitalization.sentences'),
        TextField(
          controller: sentencesCtrl,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.text_format),
            hintText: 'Sentences capitalization',
          ),
          onChanged: (val) {
            print('[capitalization] sentences changed: $val');
          },
        ),
        SizedBox(height: 10.0),
        _buildLabel('TextCapitalization.characters'),
        TextField(
          controller: allCtrl,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.text_format),
            hintText: 'All characters capitalization',
          ),
          onChanged: (val) {
            print('[capitalization] characters changed: $val');
          },
        ),
      ],
    ),
  );
}

Widget _buildObscureDemo(
  TextEditingController obscureCtrl,
  TextEditingController starCtrl,
  TextEditingController hashCtrl,
) {
  print('[render_editable_test] building obscure text demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('obscureText: true (default bullet character)'),
        TextField(
          controller: obscureCtrl,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.visibility_off),
            labelText: 'Default obscuring',
            hintText: 'Enter secret text',
          ),
          onChanged: (val) {
            print('[obscure] default changed, length: ${val.length}');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('obscureText: true, obscuringCharacter: *'),
        TextField(
          controller: starCtrl,
          obscureText: true,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.star),
            labelText: 'Star obscuring',
            hintText: 'Uses * character',
          ),
          onChanged: (val) {
            print('[obscure] star changed, length: ${val.length}');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('obscureText: true, obscuringCharacter: #'),
        TextField(
          controller: hashCtrl,
          obscureText: true,
          obscuringCharacter: '#',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.tag),
            labelText: 'Hash obscuring',
            hintText: 'Uses # character',
          ),
          onChanged: (val) {
            print('[obscure] hash changed, length: ${val.length}');
          },
        ),
      ],
    ),
  );
}

Widget _buildEditableTextDemo(
  TextEditingController controller,
  FocusNode focusNode,
) {
  print('[render_editable_test] building EditableText demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('EditableText with explicit controller and focusNode'),
        Text(
          'EditableText is the lower-level widget that TextField wraps.\n'
          'It directly uses RenderEditable for text rendering.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFF3949AB), width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: EditableText(
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(fontSize: 16.0, color: Color(0xFF212121)),
            cursorColor: Color(0xFF3949AB),
            backgroundCursorColor: Color(0xFFBBDEFB),
            selectionColor: Color(0x663949AB),
            keyboardType: TextInputType.text,
            textAlign: TextAlign.left,
            maxLines: 3,
            onChanged: (val) {
              print('[editableText] direct changed: $val');
            },
          ),
        ),
        SizedBox(height: 12.0),
        _buildLabel('EditableText with custom cursor and selection'),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            border: Border.all(color: Color(0xFFFF8F00), width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: EditableText(
            controller: TextEditingController(
              text: 'Custom cursor: orange theme',
            ),
            focusNode: FocusNode(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFFE65100),
            ),
            cursorColor: Color(0xFFFF6D00),
            backgroundCursorColor: Color(0xFFFFE0B2),
            selectionColor: Color(0x66FF8F00),
            cursorWidth: 3.0,
            cursorRadius: Radius.circular(2.0),
            showCursor: true,
            maxLines: 2,
            onChanged: (val) {
              print('[editableText] custom cursor changed: $val');
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildMaxLengthDemo(
  TextEditingController maxLenCtrl,
  TextEditingController enforcedCtrl,
) {
  print('[render_editable_test] building max length demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('maxLength: 20 (with counter, not enforced)'),
        TextField(
          controller: maxLenCtrl,
          maxLength: 20,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.short_text),
            labelText: 'Max 20 chars (soft)',
            hintText: 'Can exceed limit',
          ),
          onChanged: (val) {
            print('[maxLength] soft: ${val.length}/20');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('maxLength: 15 (enforced, truncates input)'),
        TextField(
          controller: enforcedCtrl,
          maxLength: 15,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.block),
            labelText: 'Max 15 chars (hard)',
            hintText: 'Cannot exceed limit',
          ),
          onChanged: (val) {
            print('[maxLength] enforced: ${val.length}/15');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('maxLength: 50 with custom counter builder'),
        TextField(
          controller: TextEditingController(text: 'Custom counter'),
          maxLength: 50,
          buildCounter:
              (
                BuildContext context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) {
                print(
                  '[maxLength] counter build: $currentLength/$maxLength focused=$isFocused',
                );
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: currentLength > 40
                        ? Color(0xFFFFCDD2)
                        : Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    '$currentLength / $maxLength',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: currentLength > 40
                          ? Color(0xFFC62828)
                          : Color(0xFF2E7D32),
                    ),
                  ),
                );
              },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.format_list_numbered),
            labelText: 'Custom counter display',
          ),
          onChanged: (val) {
            print('[maxLength] custom counter: ${val.length}/50');
          },
        ),
      ],
    ),
  );
}

Widget _buildKeyboardTypeDemo(
  TextEditingController numberCtrl,
  TextEditingController emailCtrl,
  TextEditingController phoneCtrl,
  TextEditingController urlCtrl,
  TextEditingController multilineCtrl,
) {
  print('[render_editable_test] building keyboard type demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('TextInputType.number'),
        TextField(
          controller: numberCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.pin),
            labelText: 'Number input',
            hintText: 'Numeric keyboard',
          ),
          onChanged: (val) {
            print('[keyboard] number: $val');
          },
        ),
        SizedBox(height: 10.0),
        _buildLabel('TextInputType.emailAddress'),
        TextField(
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
            labelText: 'Email input',
            hintText: 'Email keyboard with @',
          ),
          onChanged: (val) {
            print('[keyboard] email: $val');
          },
        ),
        SizedBox(height: 10.0),
        _buildLabel('TextInputType.phone'),
        TextField(
          controller: phoneCtrl,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
            labelText: 'Phone input',
            hintText: 'Phone dialer keyboard',
          ),
          onChanged: (val) {
            print('[keyboard] phone: $val');
          },
        ),
        SizedBox(height: 10.0),
        _buildLabel('TextInputType.url'),
        TextField(
          controller: urlCtrl,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.link),
            labelText: 'URL input',
            hintText: 'URL keyboard with .com',
          ),
          onChanged: (val) {
            print('[keyboard] url: $val');
          },
        ),
        SizedBox(height: 10.0),
        _buildLabel('TextInputType.multiline (maxLines: 4)'),
        TextField(
          controller: multilineCtrl,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.notes),
            labelText: 'Multiline input',
            hintText: 'Multi-line keyboard with enter',
            alignLabelWithHint: true,
          ),
          onChanged: (val) {
            var lineCount = val.split('\n').length;
            print('[keyboard] multiline changed, lines: $lineCount');
          },
        ),
      ],
    ),
  );
}

Widget _buildInputFormattersDemo(
  TextEditingController digitsCtrl,
  TextEditingController upperCtrl,
  TextEditingController lengthCtrl,
  TextEditingController denyCtrl,
) {
  print('[render_editable_test] building input formatters demo');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('FilteringTextInputFormatter.digitsOnly'),
        TextField(
          controller: digitsCtrl,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.filter_1),
            labelText: 'Digits only',
            hintText: 'Only 0-9 allowed',
          ),
          onChanged: (val) {
            print('[formatters] digits only: $val');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('UpperCaseTextFormatter (custom)'),
        TextField(
          controller: upperCtrl,
          inputFormatters: [UpperCaseTextFormatter()],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.text_rotation_angleup),
            labelText: 'Uppercase formatter',
            hintText: 'Automatically uppercased',
          ),
          onChanged: (val) {
            print('[formatters] uppercase: $val');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('LengthLimitingTextInputFormatter(10)'),
        TextField(
          controller: lengthCtrl,
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.straighten),
            labelText: 'Max 10 characters',
            hintText: 'Formatter limits to 10',
          ),
          onChanged: (val) {
            print('[formatters] length limited: $val (${val.length}/10)');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('FilteringTextInputFormatter.deny(RegExp(r"[0-9]"))'),
        TextField(
          controller: denyCtrl,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]'))],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.block),
            labelText: 'No digits allowed',
            hintText: 'Numbers are filtered out',
          ),
          onChanged: (val) {
            print('[formatters] deny digits: $val');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('Combined: digits only + length limit 6'),
        TextField(
          controller: TextEditingController(text: '123456'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.filter_list),
            labelText: 'PIN code (6 digits)',
            hintText: 'Enter 6-digit PIN',
          ),
          onChanged: (val) {
            print('[formatters] pin code: $val (${val.length}/6)');
          },
        ),
        SizedBox(height: 12.0),
        _buildLabel('Allow only letters: FilteringTextInputFormatter.allow'),
        TextField(
          controller: TextEditingController(text: 'OnlyLetters'),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.abc),
            labelText: 'Letters only',
            hintText: 'Only a-z and A-Z allowed',
          ),
          onChanged: (val) {
            print('[formatters] letters only: $val');
          },
        ),
      ],
    ),
  );
}

Widget _buildFooter() {
  print('[render_editable_test] building footer');
  return Container(
    margin: EdgeInsets.only(top: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF283593), Color(0xFF1A237E)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Icon(Icons.check_circle_outline, size: 32.0, color: Color(0xFF81C784)),
        SizedBox(height: 8.0),
        Text(
          'RenderEditable Demo Complete',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Covered: alignment, direction, strut, width basis,\n'
          'capitalization, obscuring, EditableText, maxLength,\n'
          'keyboard types, and input formatters',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.0, color: Color(0xCCFFFFFF)),
        ),
      ],
    ),
  );
}

// Custom TextInputFormatter that converts all input to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    print('[UpperCaseTextFormatter] formatting: ${newValue.text}');
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
