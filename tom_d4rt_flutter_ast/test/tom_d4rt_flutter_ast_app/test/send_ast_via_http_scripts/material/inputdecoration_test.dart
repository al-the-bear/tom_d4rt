// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InputDecoration, InputDecorationTheme,
// OutlineInputBorder, UnderlineInputBorder from material
// Deep Demo: Visual showcase of input decoration anatomy, border variants,
// prefix/suffix slots, themed inputs, and real-world form layouts.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InputDecoration Deep Demo executing');

  // ============================================================
  // SECTION 1: Anatomy of an InputDecoration
  // ============================================================
  print('=== Section 1: InputDecoration Anatomy ===');

  final anatomyCards = <Widget>[];

  anatomyCards.add(
    Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.text_fields, size: 44.0, color: Colors.indigo),
          SizedBox(height: 10.0),
          Text(
            'Labels & Hints',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'labelText floats above\nhintText shows when empty\nhelperText sits below',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  anatomyCards.add(
    Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.swap_horiz, size: 44.0, color: Colors.teal),
          SizedBox(height: 10.0),
          Text(
            'Prefix & Suffix',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'prefixIcon, suffixIcon\nprefix/suffix widgets\nprefixText/suffixText',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  anatomyCards.add(
    Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.border_outer, size: 44.0, color: Colors.orange),
          SizedBox(height: 10.0),
          Text(
            'Borders',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'OutlineInputBorder\nUnderlineInputBorder\nfocused/error/disabled',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  anatomyCards.add(
    Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade50, Colors.purple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.palette, size: 44.0, color: Colors.purple),
          SizedBox(height: 10.0),
          Text(
            'Theming',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'InputDecorationTheme\napplied via Theme()\nshared across forms',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.purple.shade700),
          ),
        ],
      ),
    ),
  );

  print('Created ${anatomyCards.length} anatomy cards');

  // ============================================================
  // SECTION 2: Border Variants Gallery
  // ============================================================
  print('=== Section 2: Border Variants Gallery ===');

  final defaultOutline = OutlineInputBorder();
  print('Created default OutlineInputBorder: $defaultOutline');

  final roundedOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide(color: Colors.indigo, width: 1.5),
  );
  print('Created rounded OutlineInputBorder');

  final thickOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide(color: Colors.deepPurple, width: 3.0),
  );
  print('Created thick OutlineInputBorder');

  final gappedOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.teal),
    gapPadding: 12.0,
  );
  print('Created gap-padded OutlineInputBorder');

  final basicUnderline = UnderlineInputBorder();
  print('Created basic UnderlineInputBorder: $basicUnderline');

  final coloredUnderline = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.5),
  );
  print('Created colored UnderlineInputBorder');

  final roundedUnderline = UnderlineInputBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.orange, width: 2.0),
  );
  print('Created rounded UnderlineInputBorder');

  final borderGallery = <Map<String, dynamic>>[
    {
      'title': 'OutlineInputBorder',
      'subtitle': 'default flutter outline',
      'border': defaultOutline,
      'color': Colors.blueGrey,
      'icon': Icons.crop_square,
      'hint': 'standard outline',
    },
    {
      'title': 'Rounded Outline',
      'subtitle': 'borderRadius: 24.0',
      'border': roundedOutline,
      'color': Colors.indigo,
      'icon': Icons.rounded_corner,
      'hint': 'pill-shaped',
    },
    {
      'title': 'Thick Outline',
      'subtitle': 'width: 3.0, deepPurple',
      'border': thickOutline,
      'color': Colors.deepPurple,
      'icon': Icons.border_all,
      'hint': 'emphasized field',
    },
    {
      'title': 'Gap-padded Outline',
      'subtitle': 'gapPadding: 12.0',
      'border': gappedOutline,
      'color': Colors.teal,
      'icon': Icons.space_bar,
      'hint': 'wide label gap',
    },
    {
      'title': 'UnderlineInputBorder',
      'subtitle': 'classic material',
      'border': basicUnderline,
      'color': Colors.blueGrey,
      'icon': Icons.horizontal_rule,
      'hint': 'minimal',
    },
    {
      'title': 'Colored Underline',
      'subtitle': 'red, width: 2.5',
      'border': coloredUnderline,
      'color': Colors.red,
      'icon': Icons.error_outline,
      'hint': 'emphasis',
    },
    {
      'title': 'Rounded Underline',
      'subtitle': 'top radius: 10',
      'border': roundedUnderline,
      'color': Colors.orange,
      'icon': Icons.swipe_up,
      'hint': 'chip-like',
    },
    {
      'title': 'InputBorder.none',
      'subtitle': 'borderless, filled',
      'border': InputBorder.none,
      'color': Colors.grey,
      'icon': Icons.layers_clear,
      'hint': 'no border',
    },
  ];

  final borderWidgets = <Widget>[];
  for (int i = 0; i < borderGallery.length; i++) {
    final entry = borderGallery[i];
    final color = entry['color'] as Color;
    borderWidgets.add(
      Container(
        width: 270.0,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(entry['icon'] as IconData, color: color, size: 22.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        entry['subtitle'] as String,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(
                labelText: entry['title'] as String,
                hintText: entry['hint'] as String,
                border: entry['border'] as InputBorder,
                filled: entry['title'] == 'InputBorder.none',
                fillColor: Colors.grey.shade200,
                isDense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${borderWidgets.length} border variant widgets');

  // ============================================================
  // SECTION 3: Label / Hint / Helper / Error / Counter
  // ============================================================
  print('=== Section 3: Label/Hint/Helper/Error/Counter ===');

  final textVariants = <Map<String, dynamic>>[
    {
      'title': 'labelText only',
      'decoration': InputDecoration(
        labelText: 'Full Name',
        border: OutlineInputBorder(),
      ),
      'color': Colors.blue,
      'icon': Icons.label,
    },
    {
      'title': 'hintText only',
      'decoration': InputDecoration(
        hintText: 'Type something here...',
        border: OutlineInputBorder(),
      ),
      'color': Colors.cyan,
      'icon': Icons.lightbulb_outline,
    },
    {
      'title': 'label + helperText',
      'decoration': InputDecoration(
        labelText: 'Email',
        helperText: 'We will never share your email',
        border: OutlineInputBorder(),
      ),
      'color': Colors.green,
      'icon': Icons.help_outline,
    },
    {
      'title': 'label + errorText',
      'decoration': InputDecoration(
        labelText: 'Password',
        errorText: 'Password is required',
        border: OutlineInputBorder(),
      ),
      'color': Colors.red,
      'icon': Icons.error_outline,
    },
    {
      'title': 'label + counterText',
      'decoration': InputDecoration(
        labelText: 'Bio',
        counterText: '23 / 200 characters',
        border: OutlineInputBorder(),
      ),
      'color': Colors.deepPurple,
      'icon': Icons.format_list_numbered,
    },
    {
      'title': 'multiline errorMaxLines',
      'decoration': InputDecoration(
        labelText: 'Code',
        errorText:
            'This identifier conflicts with another '
            'symbol declared in the same scope',
        errorMaxLines: 3,
        border: OutlineInputBorder(),
      ),
      'color': Colors.orange,
      'icon': Icons.wrap_text,
    },
    {
      'title': 'styled label',
      'decoration': InputDecoration(
        labelText: 'Styled Label',
        labelStyle: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(),
      ),
      'color': Colors.purple,
      'icon': Icons.format_color_text,
    },
    {
      'title': 'floatingLabelBehavior.always',
      'decoration': InputDecoration(
        labelText: 'Always Floating',
        hintText: 'hint stays visible',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
      ),
      'color': Colors.teal,
      'icon': Icons.vertical_align_top,
    },
  ];

  final textVariantWidgets = <Widget>[];
  for (int i = 0; i < textVariants.length; i++) {
    final entry = textVariants[i];
    final color = entry['color'] as Color;
    textVariantWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(entry['icon'] as IconData, color: color, size: 20.0),
                SizedBox(width: 10.0),
                Text(
                  '${i + 1}. ${entry['title']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: entry['decoration'] as InputDecoration,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${textVariantWidgets.length} text variant widgets');

  // ============================================================
  // SECTION 4: Prefix / Suffix Slots
  // ============================================================
  print('=== Section 4: Prefix & Suffix Slots ===');

  final prefixSuffixVariants = <Map<String, dynamic>>[
    {
      'title': 'prefixIcon',
      'decoration': InputDecoration(
        labelText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      'color': Colors.blue,
    },
    {
      'title': 'suffixIcon',
      'decoration': InputDecoration(
        labelText: 'Password',
        suffixIcon: Icon(Icons.visibility),
        border: OutlineInputBorder(),
      ),
      'color': Colors.indigo,
    },
    {
      'title': 'prefixIcon + suffixIcon',
      'decoration': InputDecoration(
        labelText: 'Username',
        prefixIcon: Icon(Icons.person),
        suffixIcon: Icon(Icons.check_circle, color: Colors.green),
        border: OutlineInputBorder(),
      ),
      'color': Colors.green,
    },
    {
      'title': 'prefix Text (\$)',
      'decoration': InputDecoration(
        labelText: 'Amount',
        prefix: Text(
          '\$ ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        border: OutlineInputBorder(),
      ),
      'color': Colors.teal,
    },
    {
      'title': 'suffix Text (kg)',
      'decoration': InputDecoration(
        labelText: 'Weight',
        suffix: Text(
          ' kg',
          style: TextStyle(color: Colors.grey),
        ),
        border: OutlineInputBorder(),
      ),
      'color': Colors.cyan,
    },
    {
      'title': 'prefixText https://',
      'decoration': InputDecoration(
        labelText: 'Website',
        prefixText: 'https://',
        border: OutlineInputBorder(),
      ),
      'color': Colors.deepPurple,
    },
    {
      'title': 'suffixText @example.com',
      'decoration': InputDecoration(
        labelText: 'Email handle',
        suffixText: '@example.com',
        border: OutlineInputBorder(),
      ),
      'color': Colors.pink,
    },
    {
      'title': 'icon (leading external)',
      'decoration': InputDecoration(
        icon: Icon(Icons.alternate_email, color: Colors.orange),
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      'color': Colors.orange,
    },
    {
      'title': 'prefixIconConstraints small',
      'decoration': InputDecoration(
        labelText: 'Tight prefix',
        prefixIcon: Icon(Icons.tag, size: 18.0),
        prefixIconConstraints: BoxConstraints(
          minWidth: 32.0,
          minHeight: 32.0,
        ),
        border: OutlineInputBorder(),
      ),
      'color': Colors.brown,
    },
    {
      'title': 'styled prefix widget',
      'decoration': InputDecoration(
        labelText: 'Country code',
        prefix: Container(
          margin: EdgeInsets.only(right: 8.0),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade200,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '+49',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ),
        border: OutlineInputBorder(),
      ),
      'color': Colors.amber,
    },
  ];

  final prefixSuffixWidgets = <Widget>[];
  for (int i = 0; i < prefixSuffixVariants.length; i++) {
    final entry = prefixSuffixVariants[i];
    final color = entry['color'] as Color;
    prefixSuffixWidgets.add(
      Container(
        width: 320.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '${i + 1}. ${entry['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: entry['decoration'] as InputDecoration,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${prefixSuffixWidgets.length} prefix/suffix widgets');

  // ============================================================
  // SECTION 5: Real-World Themed Forms
  // ============================================================
  print('=== Section 5: Real-World Themed Forms ===');

  // 5a) Login form with a dedicated InputDecorationTheme
  final loginTheme = Theme(
    data: Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.indigo.shade50,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.indigo.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.indigo.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.indigo, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        labelStyle: TextStyle(color: Colors.indigo.shade700),
        floatingLabelStyle: TextStyle(
          color: Colors.indigo.shade900,
          fontWeight: FontWeight.bold,
        ),
        prefixIconColor: Colors.indigo,
        suffixIconColor: Colors.indigo,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'you@example.com',
            prefixIcon: Icon(Icons.alternate_email),
          ),
        ),
        SizedBox(height: 14.0),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: Icon(Icons.visibility_off),
            helperText: 'At least 8 characters',
          ),
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.indigo.shade700],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Text(
              'SIGN IN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // 5b) Signup form with validation states
  final signupTheme = Theme(
    data: Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 12.0,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade300),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade300),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade700, width: 2.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
        ),
        labelStyle: TextStyle(color: Colors.teal.shade800),
        helperStyle: TextStyle(color: Colors.teal.shade600),
        errorStyle: TextStyle(
          color: Colors.red.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            prefixIcon: Icon(Icons.person_outline, color: Colors.teal),
            helperText: 'How others will see you',
          ),
        ),
        SizedBox(height: 12.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Username',
            prefixIcon: Icon(Icons.tag, color: Colors.teal),
            suffixIcon: Icon(Icons.check_circle, color: Colors.green),
            helperText: 'Available!',
          ),
        ),
        SizedBox(height: 12.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined, color: Colors.teal),
            errorText: 'Please enter a valid email',
          ),
        ),
        SizedBox(height: 12.0),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.teal),
            counterText: '8 chars - medium strength',
          ),
        ),
      ],
    ),
  );

  // 5c) Settings panel with filled, dense inputs
  final settingsTheme = Theme(
    data: Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 10.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
        ),
        labelStyle: TextStyle(color: Colors.blueGrey.shade700),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Display Name',
            hintText: 'e.g. Alex',
            prefixIcon: Icon(Icons.badge_outlined),
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'API endpoint',
            prefixText: 'https://',
            suffixText: '/v1',
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Timeout (seconds)',
            suffix: Text(' s'),
            prefixIcon: Icon(Icons.timer_outlined),
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Description',
            alignLabelWithHint: true,
            hintText: 'Tell us a bit about this profile…',
          ),
        ),
      ],
    ),
  );

  // 5d) Search bar with pill outline
  final searchBar = Theme(
    data: Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 12.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: BorderSide(color: Colors.deepPurple.shade100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: BorderSide(color: Colors.deepPurple.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
        ),
        hintStyle: TextStyle(color: Colors.deepPurple.shade300),
        prefixIconColor: Colors.deepPurple,
        suffixIconColor: Colors.deepPurple,
      ),
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Search documents, people, projects…',
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.tune),
      ),
    ),
  );

  print('Created 4 themed real-world form blocks');

  // ============================================================
  // SECTION 6: Default vs Themed Comparison
  // ============================================================
  print('=== Section 6: Default vs Themed Comparison ===');

  final defaultColumn = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          'DEFAULT (no theme)',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
            fontSize: 11.0,
          ),
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Name',
          hintText: 'untyped',
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'mail@x.io',
          prefixIcon: Icon(Icons.email),
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Comment',
          helperText: 'optional',
        ),
      ),
    ],
  );

  final themedColumn = Theme(
    data: Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.deepOrange.shade50,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 12.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.deepOrange.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.deepOrange.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
        ),
        labelStyle: TextStyle(
          color: Colors.deepOrange.shade700,
          fontWeight: FontWeight.bold,
        ),
        prefixIconColor: Colors.deepOrange,
        helperStyle: TextStyle(color: Colors.deepOrange.shade400),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'THEMED (InputDecorationTheme)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange.shade900,
              fontSize: 11.0,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Name',
            hintText: 'typed',
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'mail@x.io',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Comment',
            helperText: 'optional',
          ),
        ),
      ],
    ),
  );

  final paddingAndDensity = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        decoration: InputDecoration(
          labelText: 'Default padding',
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'isDense: true',
          isDense: true,
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Wide contentPadding',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 28.0,
            vertical: 20.0,
          ),
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'alignLabelWithHint',
          alignLabelWithHint: true,
          hintText: 'multi-line area',
          border: OutlineInputBorder(),
        ),
      ),
    ],
  );

  print('Built default vs themed comparison columns');

  // ============================================================
  // SECTION 7: Code Examples Panel
  // ============================================================
  print('=== Section 7: Code Examples ===');

  final codePanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'InputDecoration Recipes',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Basic outline with label and hint\n'
            'TextField(\n'
            '  decoration: InputDecoration(\n'
            '    labelText: "Email",\n'
            '    hintText: "you@example.com",\n'
            '    prefixIcon: Icon(Icons.email),\n'
            '    border: OutlineInputBorder(),\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Custom borders for each state\n'
            'InputDecoration(\n'
            '  labelText: "Password",\n'
            '  enabledBorder: OutlineInputBorder(\n'
            '    borderSide: BorderSide(color: Colors.grey),\n'
            '  ),\n'
            '  focusedBorder: OutlineInputBorder(\n'
            '    borderSide: BorderSide(\n'
            '      color: Colors.indigo, width: 2.0,\n'
            '    ),\n'
            '  ),\n'
            '  errorBorder: OutlineInputBorder(\n'
            '    borderSide: BorderSide(color: Colors.red),\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.orangeAccent.shade100,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Theme-wide InputDecorationTheme\n'
            'Theme(\n'
            '  data: Theme.of(context).copyWith(\n'
            '    inputDecorationTheme: InputDecorationTheme(\n'
            '      filled: true,\n'
            '      fillColor: Colors.indigo.shade50,\n'
            '      border: OutlineInputBorder(\n'
            '        borderRadius: BorderRadius.circular(12),\n'
            '      ),\n'
            '      floatingLabelBehavior:\n'
            '          FloatingLabelBehavior.always,\n'
            '    ),\n'
            '  ),\n'
            '  child: TextField(...),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purpleAccent.shade100,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Prefix widget + suffix text + counter\n'
            'InputDecoration(\n'
            '  labelText: "Bio",\n'
            '  prefix: Text("> "),\n'
            '  suffixText: "/200",\n'
            '  counterText: "23 / 200 characters",\n'
            '  border: OutlineInputBorder(),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyanAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code examples panel');

  // ============================================================
  // SECTION 8: Summary Panel
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.deepPurple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 14.0),
        _summaryRow(
          Icons.label,
          'Text slots',
          'labelText, hintText, helperText, errorText, counterText',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.swap_horiz,
          'Affix slots',
          'prefixIcon/suffixIcon, prefix/suffix widgets, '
              'prefixText/suffixText',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.border_outer,
          'Borders per state',
          'border + enabledBorder + focusedBorder + '
              'errorBorder + disabledBorder',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.aspect_ratio,
          'Sizing',
          'isDense, contentPadding, '
              'prefixIconConstraints, constraints',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.palette,
          'InputDecorationTheme',
          'Centralised styling via Theme(data: ...) wrappers',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.vertical_align_top,
          'Label behaviour',
          'floatingLabelBehavior + alignLabelWithHint for multiline',
          Colors.deepOrange,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('InputDecoration Deep Demo completed successfully');

  // ============================================================
  // Assemble the final visual layout
  // ============================================================
  final body = SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.text_fields, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'InputDecoration & InputDecorationTheme',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Anatomy, borders, slots and theming',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        Text(
          '1. InputDecoration Anatomy',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: anatomyCards),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. Border Variants Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: borderWidgets),
        SizedBox(height: 32.0),

        // Section 3
        Text(
          '3. Labels, Hints, Helper, Error, Counter',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...textVariantWidgets,
        SizedBox(height: 32.0),

        // Section 4
        Text(
          '4. Prefix & Suffix Slots',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: prefixSuffixWidgets),
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. Real-World Themed Forms',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        _formCard(
          'Sign In (filled, rounded outline)',
          Icons.login,
          Colors.indigo,
          loginTheme,
        ),
        _formCard(
          'Create Account (underline, validation states)',
          Icons.person_add_alt,
          Colors.teal,
          signupTheme,
        ),
        _formCard(
          'Profile Settings (dense, filled, no border)',
          Icons.settings_outlined,
          Colors.blueGrey,
          settingsTheme,
        ),
        _formCard(
          'Search Bar (pill outline)',
          Icons.search,
          Colors.deepPurple,
          searchBar,
        ),
        SizedBox(height: 32.0),

        // Section 6
        Text(
          '6. Default vs Themed Comparison',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: defaultColumn),
              SizedBox(width: 16.0),
              Expanded(child: themedColumn),
            ],
          ),
        ),
        SizedBox(height: 18.0),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.straighten, color: Colors.amber.shade800),
                  SizedBox(width: 8.0),
                  Text(
                    'contentPadding / isDense / alignLabelWithHint',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              paddingAndDensity,
            ],
          ),
        ),
        SizedBox(height: 32.0),

        // Section 7
        Text(
          '7. Code Recipes',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codePanel,
        SizedBox(height: 24.0),

        // Section 8
        Text(
          '8. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(child: body),
    ),
  );
}

// Helper: Wrap a themed form block in a labelled card
Widget _formCard(
  String title,
  IconData icon,
  Color color,
  Widget child,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

// Helper: Build a summary row item
Widget _summaryRow(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
