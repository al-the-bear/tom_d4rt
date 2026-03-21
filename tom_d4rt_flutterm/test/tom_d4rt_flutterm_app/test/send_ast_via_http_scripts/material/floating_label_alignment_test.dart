// D4rt test script: Tests FloatingLabelAlignment from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4527A0), Color(0xFF7C4DFF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color(0x554527A0),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _buildInfoCard(String label, String description) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFCE93D8), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF6A1B9A),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSubHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 12, bottom: 6),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Color(0xFF7C4DFF),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF311B92),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStartAlignmentSection() {
  print('Building start alignment section...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF81C784), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.align_horizontal_left, color: Color(0xFF2E7D32), size: 22),
            SizedBox(width: 8),
            Text(
              'FloatingLabelAlignment.start',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'The default alignment. The floating label sits at the start (left in LTR) of the input field.',
          style: TextStyle(fontSize: 13, color: Color(0xFF388E3C)),
        ),
        SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
            labelText: 'First Name',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF2E7D32)),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: 'Last Name',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF2E7D32)),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'you@example.com',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF2E7D32)),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Notice the label stays pinned to the left edge.',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF558B2F)),
        ),
      ],
    ),
  );
}

Widget _buildCenterAlignmentSection() {
  print('Building center alignment section...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF64B5F6), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.align_horizontal_center, color: Color(0xFF1565C0), size: 22),
            SizedBox(width: 8),
            Text(
              'FloatingLabelAlignment.center',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'The floating label is centered horizontally above the input field.',
          style: TextStyle(fontSize: 13, color: Color(0xFF1976D2)),
        ),
        SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
            labelText: 'Username',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1565C0), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF1565C0)),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1565C0), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF1565C0)),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: 'Verification Code',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: '000-000',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1565C0), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF1565C0)),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'The label floats to the horizontal center of the field.',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF42A5F5)),
        ),
      ],
    ),
  );
}

Widget _buildSideBySideComparison() {
  print('Building side-by-side comparison...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFB74D), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Direct Comparison',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Both fields have the same label text but different alignments.',
          style: TextStyle(fontSize: 13, color: Color(0xFFF57C00)),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'START',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Country',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
                      ),
                      floatingLabelStyle: TextStyle(color: Color(0xFF4CAF50)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'CENTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Country',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
                      ),
                      floatingLabelStyle: TextStyle(color: Color(0xFF2196F3)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'START',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
                      ),
                      floatingLabelStyle: TextStyle(color: Color(0xFF4CAF50)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'CENTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
                      ),
                      floatingLabelStyle: TextStyle(color: Color(0xFF2196F3)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'START',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'ZIP Code',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
                      ),
                      floatingLabelStyle: TextStyle(color: Color(0xFF4CAF50)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'CENTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'ZIP Code',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
                      ),
                      floatingLabelStyle: TextStyle(color: Color(0xFF2196F3)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildOutlinedVsFilled() {
  print('Building outlined vs filled section...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBA68C8), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Outlined vs Filled with Both Alignments',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Comparing border styles with each alignment mode.',
          style: TextStyle(fontSize: 13, color: Color(0xFF8E24AA)),
        ),
        SizedBox(height: 16),
        _buildSubHeader('Outlined + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Outlined Start',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF9C27B0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF9C27B0), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF9C27B0)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Outlined + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Outlined Center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF7B1FA2), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF7B1FA2), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF7B1FA2)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Filled + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Filled Start',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Color(0xFFEDE7F6),
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB39DDB), width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF673AB7), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF673AB7)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Filled + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Filled Center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Color(0xFFE8EAF6),
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF9FA8DA), width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3F51B5), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF3F51B5)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Rounded Outlined + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Rounded Start',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Color(0xFFAB47BC), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Color(0xFFAB47BC), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFAB47BC)),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Rounded Outlined + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Rounded Center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Color(0xFF7E57C2), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Color(0xFF7E57C2), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF7E57C2)),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPrefixSuffixIcons() {
  print('Building prefix/suffix icon section...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF4DD0E1), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prefix and Suffix Icons with Alignment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'How prefix/suffix icons affect the floating label position for each alignment.',
          style: TextStyle(fontSize: 13, color: Color(0xFF00838F)),
        ),
        SizedBox(height: 16),
        _buildSubHeader('Prefix Icon + Start Alignment'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.search, color: Color(0xFF00ACC1)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00ACC1), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00838F)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Prefix Icon + Center Alignment'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.search, color: Color(0xFF0097A7)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0097A7), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF006064)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Suffix Icon + Start Alignment'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.email, color: Color(0xFF26C6DA)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF26C6DA), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00BCD4)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Suffix Icon + Center Alignment'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.email, color: Color(0xFF00BCD4)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00BCD4), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF0097A7)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Both Icons + Start Alignment'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.lock, color: Color(0xFF00ACC1)),
            suffixIcon: Icon(Icons.visibility, color: Color(0xFF00ACC1)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00ACC1), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00838F)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Both Icons + Center Alignment'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.lock, color: Color(0xFF0097A7)),
            suffixIcon: Icon(Icons.visibility, color: Color(0xFF0097A7)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0097A7), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF006064)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Prefix Text + Start Alignment'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Price',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixText: '\$ ',
            prefixStyle: TextStyle(color: Color(0xFF00838F), fontSize: 16),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00838F), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00838F)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Prefix Text + Center Alignment'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Price',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixText: '\$ ',
            prefixStyle: TextStyle(color: Color(0xFF006064), fontSize: 16),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF006064), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF006064)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHelperAndHintText() {
  print('Building helper and hint text section...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFF48FB1), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Helper Text and Hint Text Interaction',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'How helperText and hintText render alongside each alignment.',
          style: TextStyle(fontSize: 13, color: Color(0xFFC2185B)),
        ),
        SizedBox(height: 16),
        _buildSubHeader('Helper Text + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            helperText: 'Enter your first and last name',
            helperStyle: TextStyle(color: Color(0xFFAD1457)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFAD1457), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFAD1457)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Helper Text + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            helperText: 'Enter your first and last name',
            helperStyle: TextStyle(color: Color(0xFFC2185B)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC2185B), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFC2185B)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Hint Text + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Address',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: '123 Main Street',
            hintStyle: TextStyle(color: Color(0xFFE91E63).withOpacity(0.5)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFE91E63)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Hint Text + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Address',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: '123 Main Street',
            hintStyle: TextStyle(color: Color(0xFFD81B60).withOpacity(0.5)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD81B60), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFD81B60)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Helper + Hint + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'MM/DD/YYYY',
            hintStyle: TextStyle(color: Color(0xFFF06292)),
            helperText: 'Use the format month/day/year',
            helperStyle: TextStyle(color: Color(0xFFEC407A)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEC407A), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFEC407A)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Helper + Hint + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'MM/DD/YYYY',
            hintStyle: TextStyle(color: Color(0xFFE91E63)),
            helperText: 'Use the format month/day/year',
            helperStyle: TextStyle(color: Color(0xFFD81B60)),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD81B60), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFD81B60)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Error Text + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Required Field',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorText: 'This field is required',
            errorStyle: TextStyle(color: Color(0xFFB71C1C)),
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB71C1C), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB71C1C), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFB71C1C)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Error Text + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Required Field',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorText: 'This field is required',
            errorStyle: TextStyle(color: Color(0xFFC62828)),
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC62828), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC62828), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFC62828)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDecorationStylesShowcase() {
  print('Building decoration styles showcase...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFD54F), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'InputDecoration Styles Showcase',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF57F17),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Different InputDecoration configurations with alignment.',
          style: TextStyle(fontSize: 13, color: Color(0xFFF9A825)),
        ),
        SizedBox(height: 16),
        _buildSubHeader('Dense + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Dense Start',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            isDense: true,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFA000), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFA000), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFFF8F00)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Dense + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Dense Center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            isDense: true,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFB300), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFB300), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFFFA000)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Custom Content Padding + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Padded Start',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF6F00), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF6F00), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFE65100)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Custom Content Padding + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Padded Center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEF6C00), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEF6C00), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFFE65100)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Large Label Size + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Big Label',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8F00),
            ),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF8F00), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF8F00), width: 2),
            ),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Large Label Size + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Big Label',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFB300),
            ),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFB300), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFB300), width: 2),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFloatingLabelBehaviorMatrix() {
  print('Building floating label behavior matrix...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF7986CB), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FloatingLabelBehavior x Alignment Matrix',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF283593),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Combining FloatingLabelBehavior with FloatingLabelAlignment.',
          style: TextStyle(fontSize: 13, color: Color(0xFF3949AB)),
        ),
        SizedBox(height: 16),
        _buildSubHeader('Auto + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Auto Start',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF5C6BC0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF5C6BC0), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF3F51B5)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Auto + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Auto Center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3F51B5), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3F51B5), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF303F9F)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Always + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Always Start',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF5C6BC0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF5C6BC0), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF3F51B5)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Always + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Always Center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3F51B5), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3F51B5), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF303F9F)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Never + Start'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Never Start',
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF9FA8DA), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF9FA8DA), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF7986CB)),
          ),
        ),
        SizedBox(height: 14),
        _buildSubHeader('Never + Center'),
        TextField(
          decoration: InputDecoration(
            labelText: 'Never Center',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF7986CB), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF7986CB), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF5C6BC0)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFormExample() {
  print('Building form example...');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Complete Form: Center-Aligned Labels',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004D40),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'A realistic registration form using center-aligned floating labels.',
          style: TextStyle(fontSize: 13, color: Color(0xFF00695C)),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.person, color: Color(0xFF009688)),
            hintText: 'John Doe',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF4DB6AC), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF009688), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00796B)),
          ),
        ),
        SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.email, color: Color(0xFF009688)),
            hintText: 'you@example.com',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF4DB6AC), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF009688), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00796B)),
          ),
        ),
        SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.phone, color: Color(0xFF009688)),
            hintText: '+1 (555) 000-0000',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF4DB6AC), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF009688), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00796B)),
          ),
        ),
        SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.lock, color: Color(0xFF009688)),
            suffixIcon: Icon(Icons.visibility_off, color: Color(0xFF80CBC4)),
            helperText: 'Minimum 8 characters',
            helperStyle: TextStyle(color: Color(0xFF4DB6AC)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF4DB6AC), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF009688), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00796B)),
          ),
        ),
        SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF009688)),
            suffixIcon: Icon(Icons.visibility_off, color: Color(0xFF80CBC4)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF4DB6AC), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF009688), width: 2),
            ),
            floatingLabelStyle: TextStyle(color: Color(0xFF00796B)),
          ),
        ),
        SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF009688)),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: Text('Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertiesReference() {
  print('Building properties reference...');
  List<Map<String, String>> properties = [
    {'name': 'FloatingLabelAlignment.start', 'desc': 'Aligns the floating label to the start edge (default)'},
    {'name': 'FloatingLabelAlignment.center', 'desc': 'Aligns the floating label to the horizontal center'},
    {'name': 'floatingLabelBehavior', 'desc': 'Controls when the label floats: auto, always, never'},
    {'name': 'floatingLabelStyle', 'desc': 'TextStyle applied when the label is floating'},
    {'name': 'labelText', 'desc': 'The text to display as the label'},
    {'name': 'helperText', 'desc': 'Optional text below the input that provides context'},
    {'name': 'hintText', 'desc': 'Placeholder text shown when the field is empty'},
    {'name': 'errorText', 'desc': 'Error message that replaces helper text when present'},
    {'name': 'prefixIcon', 'desc': 'Icon widget at the start of the input field'},
    {'name': 'suffixIcon', 'desc': 'Icon widget at the end of the input field'},
    {'name': 'filled', 'desc': 'Whether the input field has a filled background'},
    {'name': 'contentPadding', 'desc': 'Inner padding of the input content area'},
    {'name': 'isDense', 'desc': 'Whether the input is rendered in a compact layout'},
  ];

  List<Widget> rows = [];
  for (int i = 0; i < properties.length; i = i + 1) {
    Map<String, String> prop = properties[i];
    String name = prop['name'] ?? '';
    String desc = prop['desc'] ?? '';
    Color bgColor = i % 2 == 0 ? Color(0xFFEDE7F6) : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(bottom: BorderSide(color: Color(0xFFD1C4E9), width: 0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 180,
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4527A0),
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                desc,
                style: TextStyle(fontSize: 12, color: Color(0xFF5E35B1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB39DDB), width: 1),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          color: Color(0xFF5E35B1),
          child: Text(
            'Properties Reference',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildSummaryCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF311B92), Color(0xFF6200EA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0x66311B92),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white70, size: 20),
            SizedBox(width: 8),
            Text(
              'FloatingLabelAlignment Summary',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildSummaryRow('Type', 'Class with static instances'),
        SizedBox(height: 6),
        _buildSummaryRow('Package', 'package:flutter/material.dart'),
        SizedBox(height: 6),
        _buildSummaryRow('Values', 'start (default), center'),
        SizedBox(height: 6),
        _buildSummaryRow('Used in', 'InputDecoration.floatingLabelAlignment'),
        SizedBox(height: 6),
        _buildSummaryRow('Purpose', 'Controls horizontal position of the floating label'),
        SizedBox(height: 6),
        _buildSummaryRow('Related', 'FloatingLabelBehavior, InputDecoration'),
      ],
    ),
  );
}

Widget _buildSummaryRow(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 90,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFFB388FF),
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ),
    ],
  );
}

dynamic build(BuildContext context) {
  print('=== FloatingLabelAlignment Visual Demo ===');
  print('Demonstrating FloatingLabelAlignment.start and .center with various TextField configurations');
  print('Package: material');
  print('Class: FloatingLabelAlignment');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FloatingLabelAlignment Demo'),
        backgroundColor: Color(0xFF4527A0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            SizedBox(height: 16),
            _buildInfoCard(
              'What is FloatingLabelAlignment?',
              'FloatingLabelAlignment controls the horizontal positioning of the floating label '
              'text in an InputDecoration when used with a TextField. The two built-in alignments '
              'are .start (default, left-aligned in LTR) and .center (horizontally centered).',
            ),
            _buildInfoCard(
              'When to use center alignment',
              'Center-aligned labels work well for short input fields (like PIN codes or short names), '
              'centered forms, and login screens where visual symmetry is desired.',
            ),
            SizedBox(height: 8),
            _buildSectionHeader('1. Start Alignment (Default)'),
            SizedBox(height: 8),
            _buildStartAlignmentSection(),
            SizedBox(height: 24),
            _buildSectionHeader('2. Center Alignment'),
            SizedBox(height: 8),
            _buildCenterAlignmentSection(),
            SizedBox(height: 24),
            _buildSectionHeader('3. Side-by-Side Comparison'),
            SizedBox(height: 8),
            _buildSideBySideComparison(),
            SizedBox(height: 24),
            _buildSectionHeader('4. Outlined vs Filled Styles'),
            SizedBox(height: 8),
            _buildOutlinedVsFilled(),
            SizedBox(height: 24),
            _buildSectionHeader('5. Prefix and Suffix Icons'),
            SizedBox(height: 8),
            _buildPrefixSuffixIcons(),
            SizedBox(height: 24),
            _buildSectionHeader('6. Helper, Hint, and Error Text'),
            SizedBox(height: 8),
            _buildHelperAndHintText(),
            SizedBox(height: 24),
            _buildSectionHeader('7. InputDecoration Styles'),
            SizedBox(height: 8),
            _buildDecorationStylesShowcase(),
            SizedBox(height: 24),
            _buildSectionHeader('8. Behavior x Alignment Matrix'),
            SizedBox(height: 8),
            _buildFloatingLabelBehaviorMatrix(),
            SizedBox(height: 24),
            _buildSectionHeader('9. Complete Form Example'),
            SizedBox(height: 8),
            _buildFormExample(),
            SizedBox(height: 24),
            _buildSectionHeader('10. Properties Reference'),
            SizedBox(height: 8),
            _buildPropertiesReference(),
            SizedBox(height: 32),
            Center(
              child: Text(
                'FloatingLabelAlignment Demo Complete',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9E9E9E),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}
