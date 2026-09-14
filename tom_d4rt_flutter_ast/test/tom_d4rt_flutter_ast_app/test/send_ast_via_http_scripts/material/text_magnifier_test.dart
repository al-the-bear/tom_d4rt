// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests TextMagnifier from material
// Deep Demo: Visual demonstration of the Material text magnifier widget
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextMagnifier Deep Demo executing');

  // ============================================================
  // SECTION 1: TextMagnifier Fundamentals
  // ============================================================
  print('=== Section 1: TextMagnifier Fundamentals ===');

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
              colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.zoom_in, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'TextMagnifier Fundamentals',
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
                'TextMagnifier provides a Material-style magnifying glass widget that '
                'magnifies the content beneath it. It is used by text selection on '
                'Android to help users precisely position their selection handles.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 20.0),
              
              Text(
                'Default TextMagnifier:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12.0),
              
              // Demo showing the magnifier concept
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    // Simulated text content
                    Text(
                      'Example text for magnification demonstration',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    
                    // Visual representation of magnifier
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(0.0, 4.0),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'text',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        // Arrow indicating magnification
                        Positioned(
                          bottom: -20.0,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.deepPurple,
                            size: 32.0,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.0),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, size: 16.0, color: Colors.grey.shade600),
                        SizedBox(width: 8.0),
                        Text(
                          'Magnifier shows content 1.48x larger',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey.shade600,
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
  print('Created fundamentals card');

  // ============================================================
  // SECTION 2: Magnifier Sizes
  // ============================================================
  print('=== Section 2: Magnifier Sizes ===');

  final sizesCard = Container(
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
              Icon(Icons.aspect_ratio, color: Colors.blue, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Magnifier Sizes',
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
                'TextMagnifier uses a default size of approximately 77.37 x 37.9 pixels. '
                'Here are visual comparisons of different size concepts:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Size comparison grid
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMagnifierSizeDemo('Small', 60.0, 30.0, Colors.green),
                  _buildMagnifierSizeDemo('Default', 77.0, 38.0, Colors.blue),
                  _buildMagnifierSizeDemo('Large', 100.0, 50.0, Colors.orange),
                ],
              ),
              
              SizedBox(height: 16.0),
              
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.note, size: 16.0, color: Colors.blue.shade700),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Default Android magnifier follows Material Design specs',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.blue.shade900,
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
  print('Created sizes card');

  // ============================================================
  // SECTION 3: Magnification Display
  // ============================================================
  print('=== Section 3: Magnification Display ===');

  final magnificationCard = Container(
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
              Icon(Icons.search, color: Colors.purple, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Magnification Display',
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
                'The magnifier typically uses 1.48x magnification scale:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Before/after magnification demo
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Original',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            'Hello',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.arrow_forward, color: Colors.grey),
                  ),
                  
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Magnified (1.48x)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.withValues(alpha: 0.2),
                                blurRadius: 8.0,
                                offset: Offset(0.0, 4.0),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.purple.shade200,
                              width: 2.0,
                            ),
                          ),
                          child: Text(
                            'Hello',
                            style: TextStyle(
                              fontSize: 21.0, // 14 * 1.48
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20.0),
              
              // Different zoom levels visualization
              Text(
                'Zoom Level Comparison:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12.0),
              
              _buildZoomLevelRow('1.0x', 12.0, Colors.grey),
              _buildZoomLevelRow('1.25x', 15.0, Colors.blue),
              _buildZoomLevelRow('1.48x (Default)', 18.0, Colors.purple),
              _buildZoomLevelRow('2.0x', 24.0, Colors.orange),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created magnification card');

  // ============================================================
  // SECTION 4: Magnifier Shadows & Styling
  // ============================================================
  print('=== Section 4: Magnifier Shadows & Styling ===');

  final stylingCard = Container(
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
              Icon(Icons.style, color: Colors.amber.shade700, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Magnifier Shadows & Styling',
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
                'TextMagnifier includes subtle shadow effects for visual depth:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Shadow demonstrations
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildShadowDemo('No Shadow', false, Colors.grey.shade200),
                  _buildShadowDemo('Light Shadow', true, Colors.grey.withValues(alpha: 0.15)),
                  _buildShadowDemo('Strong Shadow', true, Colors.grey.withValues(alpha: 0.4)),
                ],
              ),
              
              SizedBox(height: 24.0),
              
              // Border styles
              Text(
                'Border Styles:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12.0),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBorderDemo('Thin', 1.0, Colors.grey.shade400),
                  _buildBorderDemo('Medium', 2.0, Colors.grey.shade500),
                  _buildBorderDemo('Thick', 3.0, Colors.grey.shade600),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created styling card');

  // ============================================================
  // SECTION 5: Text Selection Context
  // ============================================================
  print('=== Section 5: Text Selection Context ===');

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
              Icon(Icons.text_fields, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Text Selection Context',
                style: TextStyle(
                  fontSize: 16.0,
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
                'TextMagnifier is typically used with text selection handles for precise cursor positioning:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Text selection simulation
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Simulated text with selection
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        children: [
                          TextSpan(text: 'The quick '),
                          TextSpan(
                            text: 'brown fox',
                            style: TextStyle(
                              backgroundColor: Colors.blue.shade200,
                            ),
                          ),
                          TextSpan(text: ' jumps over'),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 8.0),
                    
                    // Magnifier positioned above
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 90.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8.0,
                                  offset: Offset(0.0, 4.0),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'fox',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          // Selection handle
                          Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 12.0),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.touch_app, size: 14.0, color: Colors.teal),
                        SizedBox(width: 4.0),
                        Text(
                          'Magnifier appears when dragging selection handle',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.teal.shade700,
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
        ),
      ],
    ),
  );
  print('Created selection card');

  // ============================================================
  // SECTION 6: Platform Considerations
  // ============================================================
  print('=== Section 6: Platform Considerations ===');

  final platformCard = Container(
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
              Icon(Icons.devices, color: Colors.green, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Platform Considerations',
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
                'TextMagnifier follows Material Design and is primarily used on Android:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Platform comparison
              _buildPlatformRow(Icons.android, 'Android', 'TextMagnifier (Material)', Colors.green),
              _buildPlatformRow(Icons.apple, 'iOS', 'CupertinoMagnifier (Cupertino)', Colors.grey),
              _buildPlatformRow(Icons.desktop_windows, 'Desktop', 'Usually not shown', Colors.blue),
              _buildPlatformRow(Icons.language, 'Web', 'Browser native behavior', Colors.orange),
              
              SizedBox(height: 16.0),
              
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb, size: 16.0, color: Colors.green.shade700),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Flutter automatically chooses the right magnifier style based on the target platform.',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.green.shade900,
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
  print('Created platform card');

  // ============================================================
  // SECTION 7: Magnifier Position
  // ============================================================
  print('=== Section 7: Magnifier Position ===');

  final positionCard = Container(
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
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.open_with, color: Colors.indigo, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Magnifier Position',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
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
                'The magnifier is positioned above the focal point with a vertical offset '
                'to avoid obstructing the text being selected:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Position diagram
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    // Magnifier above
                    Container(
                      width: 90.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withValues(alpha: 0.3),
                            blurRadius: 8.0,
                            offset: Offset(0.0, 4.0),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.indigo.shade200,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Text',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    
                    // Vertical offset indicator
                    Container(
                      height: 30.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 2.0,
                            height: 30.0,
                            color: Colors.indigo.shade300,
                          ),
                          Positioned(
                            right: 0.0,
                            left: 80.0,
                            child: Text(
                              '← vertical offset',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Focal point
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 12.0,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Focal point (finger position)',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16.0),
                    
                    // Text line below
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Sample text content',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey.shade800,
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
  print('Created position card');

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
        
        _buildApiRow('magnifierInfo', 'MagnifierInfo', 'Position and configuration data'),
        
        SizedBox(height: 16.0),
        
        Text(
          'Static Methods:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        
        _buildApiRow('adaptiveMagnifierConfiguration', 'TextMagnifierConfiguration', 'Platform-adaptive builder'),
        
        SizedBox(height: 16.0),
        
        Text(
          'Constants:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        
        _buildConstantRow('magnifierScale', '1.48', 'Default zoom level'),
        _buildConstantRow('kDefaultMagnifierSize', '77.37 × 37.9', 'Default widget size'),
        _buildConstantRow('kVerticalFocalPointOffset', '-22.0', 'Vertical position offset'),
        
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
                  'TextMagnifier is typically used via SelectionArea or TextField\'s '
                  'magnifierConfiguration property rather than directly.',
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
  print('TextMagnifier Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade600, Colors.purple.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.zoom_in, color: Colors.white, size: 48.0),
              SizedBox(height: 16.0),
              Text(
                'TextMagnifier',
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
                'Material-style magnifying glass for text selection',
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
        _buildSectionHeader('Section 2: Sizes', Icons.aspect_ratio),
        sizesCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Magnification', Icons.search),
        magnificationCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Styling', Icons.style),
        stylingCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Selection Context', Icons.text_fields),
        selectionCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Platform', Icons.devices),
        platformCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Position', Icons.open_with),
        positionCard,

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

// Helper: Magnifier size demo
Widget _buildMagnifierSizeDemo(String label, double width, double height, Color color) {
  return Column(
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
          border: Border.all(color: color, width: 2.0),
        ),
        child: Center(
          child: Icon(Icons.zoom_in, color: color, size: height * 0.5),
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      Text(
        '${width.toInt()}×${height.toInt()}',
        style: TextStyle(
          fontSize: 9.0,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

// Helper: Zoom level row
Widget _buildZoomLevelRow(String label, double fontSize, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Sample Text',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: Shadow demo
Widget _buildShadowDemo(String label, bool hasShadow, Color shadowColor) {
  return Column(
    children: [
      Container(
        width: 80.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ]
              : [],
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
        ),
        child: Center(
          child: Text(
            'Abc',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.grey.shade700,
        ),
      ),
    ],
  );
}

// Helper: Border demo
Widget _buildBorderDemo(String label, double width, Color color) {
  return Column(
    children: [
      Container(
        width: 70.0,
        height: 35.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
          border: Border.all(
            color: color,
            width: width,
          ),
        ),
        child: Center(
          child: Text(
            'Xy',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.grey.shade700,
        ),
      ),
      Text(
        '${width}px',
        style: TextStyle(
          fontSize: 9.0,
          color: Colors.grey.shade500,
        ),
      ),
    ],
  );
}

// Helper: Platform row
Widget _buildPlatformRow(IconData icon, String platform, String magnifier, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20.0),
        SizedBox(width: 12.0),
        SizedBox(
          width: 70.0,
          child: Text(
            platform,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            magnifier,
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
          width: 140.0,
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

// Helper: Constant row
Widget _buildConstantRow(String name, String value, String desc) {
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
          width: 140.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
        ),
        SizedBox(
          width: 80.0,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.green.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}
