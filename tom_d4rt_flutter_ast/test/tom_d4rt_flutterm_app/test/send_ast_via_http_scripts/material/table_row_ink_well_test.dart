// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests TableRowInkWell from material
// Deep Demo: Visual demonstration of the ink splash widget for table rows
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TableRowInkWell Deep Demo executing');

  // ============================================================
  // SECTION 1: TableRowInkWell Fundamentals
  // ============================================================
  print('=== Section 1: TableRowInkWell Fundamentals ===');

  final fundamentalsCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade400, Colors.teal.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.table_rows, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'TableRowInkWell Fundamentals',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TableRowInkWell is a specialized ink splash widget designed for use within '
                'Table rows. Unlike regular InkWell, it creates splash effects that properly '
                'fill the entire row cell, respecting the table\'s layout constraints.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 20.0),
              
              // Basic table example
              Text(
                'Basic Usage:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12.0),
              
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header row
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    // Data rows with TableRowInkWell
                    TableRow(
                      children: [
                        TableRowInkWell(
                          onTap: () {
                            print('Row 1 tapped');
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Product A'),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('5'),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('\$29.99'),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableRowInkWell(
                          onTap: () {
                            print('Row 2 tapped');
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Product B'),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('3'),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('\$15.50'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 12.0),
              
              Row(
                children: [
                  Icon(Icons.touch_app, size: 16.0, color: Colors.grey),
                  SizedBox(width: 4.0),
                  Text(
                    'Tap any cell to see ink splash effect',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created fundamentals card');

  // ============================================================
  // SECTION 2: Splash & Highlight Colors
  // ============================================================
  print('=== Section 2: Splash & Highlight Colors ===');

  final colorsCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.palette, color: Colors.purple, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Splash & Highlight Colors',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customize splash and highlight colors for different visual effects:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Color Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Tap to Test', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ),
                      ],
                    ),
                    // Blue splash
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Blue Splash', style: TextStyle(fontSize: 12.0)),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Blue splash'),
                          overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.3)),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 16.0,
                                  height: 16.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text('Tap here', style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Pink splash
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Pink Splash', style: TextStyle(fontSize: 12.0)),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Pink splash'),
                          overlayColor: WidgetStateProperty.all(Colors.pink.withValues(alpha: 0.3)),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 16.0,
                                  height: 16.0,
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text('Tap here', style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Green splash
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Green Splash', style: TextStyle(fontSize: 12.0)),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Green splash'),
                          overlayColor: WidgetStateProperty.all(Colors.green.withValues(alpha: 0.3)),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 16.0,
                                  height: 16.0,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text('Tap here', style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Orange splash
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Orange Splash', style: TextStyle(fontSize: 12.0)),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Orange splash'),
                          overlayColor: WidgetStateProperty.all(Colors.orange.withValues(alpha: 0.3)),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 16.0,
                                  height: 16.0,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text('Tap here', style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created colors card');

  // ============================================================
  // SECTION 3: Row Selection Pattern
  // ============================================================
  print('=== Section 3: Row Selection Pattern ===');

  final selectionCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.check_box, color: Colors.blue, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Row Selection Pattern',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Combining TableRowInkWell with selection state for interactive tables:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(50.0),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.check_box_outline_blank, size: 18.0, color: Colors.grey),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ),
                      ],
                    ),
                    // Selected row
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                      ),
                      children: [
                        TableRowInkWell(
                          onTap: () => print('Toggle row 1'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.check_box, size: 18.0, color: Colors.blue),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Select row 1'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Project Alpha', style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Select row 1'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text('Active', style: TextStyle(color: Colors.white, fontSize: 10.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Unselected row
                    TableRow(
                      children: [
                        TableRowInkWell(
                          onTap: () => print('Toggle row 2'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.check_box_outline_blank, size: 18.0, color: Colors.grey),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Select row 2'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Project Beta', style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Select row 2'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text('Pending', style: TextStyle(color: Colors.white, fontSize: 10.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Another unselected row
                    TableRow(
                      children: [
                        TableRowInkWell(
                          onTap: () => print('Toggle row 3'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.check_box_outline_blank, size: 18.0, color: Colors.grey),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Select row 3'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Project Gamma', style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        TableRowInkWell(
                          onTap: () => print('Select row 3'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text('Draft', style: TextStyle(color: Colors.white, fontSize: 10.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 12.0),
              Text(
                'First row shown in selected state',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created selection card');

  // ============================================================
  // SECTION 4: Long Press Actions
  // ============================================================
  print('=== Section 4: Long Press Actions ===');

  final longPressCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.touch_app, color: Colors.amber.shade700, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Long Press Actions',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TableRowInkWell supports onLongPress for context menu actions:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(40.0),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.folder, size: 16.0, color: Colors.grey.shade700),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('File', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ),
                      ],
                    ),
                    _buildFileRow(Icons.description, 'document.pdf', '2.5 MB', Colors.red),
                    _buildFileRow(Icons.image, 'photo.jpg', '1.2 MB', Colors.green),
                    _buildFileRow(Icons.movie, 'video.mp4', '45 MB', Colors.blue),
                    _buildFileRow(Icons.audiotrack, 'song.mp3', '5.7 MB', Colors.purple),
                  ],
                ),
              ),
              
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, size: 16.0, color: Colors.amber.shade700),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Long press any row to see action feedback',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.amber.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created long press card');

  // ============================================================
  // SECTION 5: Data Table Example
  // ============================================================
  print('=== Section 5: Data Table Example ===');

  final dataTableCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.indigo.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.table_chart, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sales Report',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Q4 2024',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.download, color: Colors.white70, size: 20.0),
            ],
          ),
        ),
        
        // Table content
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.grey.shade200),
              right: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              // Header
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Region', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Sales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Growth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Target', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
                  ),
                ],
              ),
              // Data rows
              _buildSalesRow('North America', '\$2.4M', '+12%', true),
              _buildSalesRow('Europe', '\$1.8M', '+8%', true),
              _buildSalesRow('Asia Pacific', '\$1.2M', '+22%', true),
              _buildSalesRow('Latin America', '\$0.6M', '-3%', false),
            ],
          ),
        ),
        
        // Footer
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$6.0M',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '+10.5% YoY',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created data table card');

  // ============================================================
  // SECTION 6: Double Tap Actions
  // ============================================================
  print('=== Section 6: Double Tap Actions ===');

  final doubleTapCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.green, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Double Tap to Edit',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Use onDoubleTap for inline editing scenarios:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableRowInkWell(
                          onDoubleTap: () => print('Edit Username'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(Icons.person, size: 16.0, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('Username', style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                        TableRowInkWell(
                          onDoubleTap: () => print('Edit john_doe'),
                          overlayColor: WidgetStateProperty.all(Colors.green.withValues(alpha: 0.2)),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('john_doe', style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableRowInkWell(
                          onDoubleTap: () => print('Edit Email'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(Icons.email, size: 16.0, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('Email', style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                        TableRowInkWell(
                          onDoubleTap: () => print('Edit email'),
                          overlayColor: WidgetStateProperty.all(Colors.green.withValues(alpha: 0.2)),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('john@example.com', style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableRowInkWell(
                          onDoubleTap: () => print('Edit Phone'),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(Icons.phone, size: 16.0, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('Phone', style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                        TableRowInkWell(
                          onDoubleTap: () => print('Edit phone'),
                          overlayColor: WidgetStateProperty.all(Colors.green.withValues(alpha: 0.2)),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('+1 555-1234', style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 8.0),
              Text(
                'Double-tap value cells to edit',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created double tap card');

  // ============================================================
  // SECTION 7: Alternating Row Colors
  // ============================================================
  print('=== Section 7: Alternating Row Colors ===');

  final zebraCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.view_list, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Zebra Striping',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.grey.shade300),
              right: BorderSide(color: Colors.grey.shade300),
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(40.0),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
              },
              children: List.generate(6, (index) {
                final isEven = index % 2 == 0;
                return TableRow(
                  decoration: BoxDecoration(
                    color: isEven ? Colors.grey.shade50 : Colors.white,
                  ),
                  children: [
                    TableRowInkWell(
                      onTap: () => print('Selected row ${index + 1}'),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                    TableRowInkWell(
                      onTap: () => print('Selected row ${index + 1}'),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Row item ${index + 1}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                    TableRowInkWell(
                      onTap: () => print('Selected row ${index + 1}'),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Value',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    ),
  );
  print('Created zebra card');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.blueGrey.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'API Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        
        _buildApiRow('onTap', 'GestureTapCallback?', 'Single tap callback'),
        _buildApiRow('onDoubleTap', 'GestureTapCallback?', 'Double tap callback'),
        _buildApiRow('onLongPress', 'GestureLongPressCallback?', 'Long press callback'),
        _buildApiRow('onHighlightChanged', 'ValueChanged<bool>?', 'Highlight state change'),
        _buildApiRow('overlayColor', 'WidgetStateProperty<Color?>?', 'State-dependent overlay color'),
        _buildApiRow('child', 'Widget', 'Cell content widget'),
        
        SizedBox(height: 16.0),
        
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info, color: Colors.blue.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'TableRowInkWell is designed specifically for use within Table widgets. '
                  'For other layouts, use InkWell or InkResponse.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created API card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('TableRowInkWell Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade600, Colors.cyan.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.table_rows, color: Colors.white, size: 48.0),
              SizedBox(height: 16.0),
              Text(
                'TableRowInkWell',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Deep Demo',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Ink splash effects for table row cells',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),

        // Sections
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 1: Fundamentals', Icons.school),
        fundamentalsCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 2: Colors', Icons.palette),
        colorsCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Row Selection', Icons.check_box),
        selectionCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Long Press', Icons.touch_app),
        longPressCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Data Table', Icons.table_chart),
        dataTableCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Double Tap', Icons.edit),
        doubleTapCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Zebra Striping', Icons.view_list),
        zebraCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 8: API Reference', Icons.api),
        apiCard,

        SizedBox(height: 32.0),
      ],
    ),
  );
}

// Helper: Section header
Widget _buildSectionHeader(String title, IconData icon) {
  print('Section: $title');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey.shade700),
        SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}

// Helper: File row
TableRow _buildFileRow(IconData icon, String name, String size, Color iconColor) {
  return TableRow(
    children: [
      TableRowInkWell(
        onTap: () => print('Tapped $name'),
        onLongPress: () => print('Context menu for $name'),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(icon, size: 18.0, color: iconColor),
        ),
      ),
      TableRowInkWell(
        onTap: () => print('Tapped $name'),
        onLongPress: () => print('Context menu for $name'),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(name, style: TextStyle(fontSize: 12.0)),
        ),
      ),
      TableRowInkWell(
        onTap: () => print('Tapped $name'),
        onLongPress: () => print('Context menu for $name'),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(size, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600)),
        ),
      ),
    ],
  );
}

// Helper: Sales row
TableRow _buildSalesRow(String region, String sales, String growth, bool positive) {
  return TableRow(
    children: [
      TableRowInkWell(
        onTap: () => print('$region details'),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(region, style: TextStyle(fontSize: 11.0)),
        ),
      ),
      TableRowInkWell(
        onTap: () => print('$region details'),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(sales, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold)),
        ),
      ),
      TableRowInkWell(
        onTap: () => print('$region details'),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            growth,
            style: TextStyle(
              fontSize: 11.0,
              color: positive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      TableRowInkWell(
        onTap: () => print('$region details'),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(
            positive ? Icons.check_circle : Icons.cancel,
            size: 16.0,
            color: positive ? Colors.green : Colors.red,
          ),
        ),
      ),
    ],
  );
}

// Helper: API row
Widget _buildApiRow(String prop, String type, String desc) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.blueGrey.shade100),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
          child: Text(
            prop,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}
