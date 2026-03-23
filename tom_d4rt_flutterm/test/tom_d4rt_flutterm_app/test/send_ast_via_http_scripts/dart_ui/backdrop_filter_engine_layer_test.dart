// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt Deep Demo: BackdropFilterEngineLayer - Scene Composition Blur Effects
// This demo comprehensively explores BackdropFilterEngineLayer which provides
// efficient backdrop blur and filter effects in Flutter's scene composition system.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION UI
  // ═══════════════════════════════════════════════════════════════════════════════
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade600, Colors.blue.shade600],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyan.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.blur_on, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'BackdropFilterEngineLayer',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'GPU-Accelerated Backdrop Blur',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Blur Effect Showcase
          Text(
            'Blur Effect Demonstration',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          // Background with blur overlays
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/800/400?blur=0'),
                fit: BoxFit.cover,
                onError: (_, _) {},
              ),
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.orange, Colors.pink],
              ),
            ),
            child: Stack(
              children: [
                // Frosted glass card
                Positioned(
                  left: 16,
                  top: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Frosted Glass',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'sigma: 10.0',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Medium blur circle
                Positioned(
                  right: 60,
                  top: 30,
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'σ=20',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Light blur bar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                        child: Text(
                          'Light blur navigation bar (sigma: 5)',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Blur Sigma Comparison
          Text(
            'Blur Sigma Comparison',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          Row(
            children: [
              _buildBlurCard('No Blur', 0, Colors.grey),
              SizedBox(width: 8),
              _buildBlurCard('σ = 3', 3, Colors.lightBlue),
              SizedBox(width: 8),
              _buildBlurCard('σ = 10', 10, Colors.blue),
              SizedBox(width: 8),
              _buildBlurCard('σ = 25', 25, Colors.indigo),
            ],
          ),

          SizedBox(height: 24),

          // Performance Guide
          Text(
            'Performance Guide',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildPerfRow(
                  'Sigma 1-5',
                  'Subtle',
                  '🟢 Low GPU cost',
                  Colors.green,
                ),
                Divider(),
                _buildPerfRow(
                  'Sigma 5-15',
                  'Medium',
                  '🟡 Moderate cost',
                  Colors.orange,
                ),
                Divider(),
                _buildPerfRow(
                  'Sigma 15-30',
                  'Heavy',
                  '🟠 High cost',
                  Colors.deepOrange,
                ),
                Divider(),
                _buildPerfRow(
                  'Sigma 30+',
                  'Extreme',
                  '🔴 Very high cost',
                  Colors.red,
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Layer Hierarchy
          Text(
            'Scene Layer Hierarchy',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLayerNode('SceneBuilder', Icons.layers, 0),
                _buildLayerNode('TransformEngineLayer', Icons.transform, 1),
                _buildLayerNode('OffsetEngineLayer', Icons.open_with, 2),
                _buildLayerNode('BackdropFilterEngineLayer', Icons.blur_on, 3),
                _buildLayerNode('OpacityEngineLayer', Icons.opacity, 4),
                _buildLayerNode('PictureLayer (content)', Icons.image, 5),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Use Cases
          Text(
            'Common Use Cases',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildUseCaseChip('Frosted Glass UI', Icons.blur_circular),
              _buildUseCaseChip('Modal Dialogs', Icons.web_asset),
              _buildUseCaseChip('Navigation Bars', Icons.navigation),
              _buildUseCaseChip('Image Overlays', Icons.photo_filter),
              _buildUseCaseChip('Privacy Blur', Icons.visibility_off),
              _buildUseCaseChip('Depth Effects', Icons.layers),
            ],
          ),

          SizedBox(height: 32),

          // Footer
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🌫️ BackdropFilterEngineLayer Deep Demo',
                style: TextStyle(
                  color: Colors.cyan.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBlurCard(String label, double sigma, Color color) {
  return Expanded(
    child: Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade300, Colors.purple.shade300],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: sigma > 0
            ? BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.1),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
      ),
    ),
  );
}

Widget _buildPerfRow(String sigma, String quality, String cost, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(sigma, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        Expanded(child: Text(quality)),
        Expanded(child: Text(cost, style: TextStyle(fontSize: 12))),
      ],
    ),
  );
}

Widget _buildLayerNode(String name, IconData icon, int depth) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 20.0, top: 8, bottom: 8),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.cyan.shade600),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 13,
            fontWeight: depth == 3 ? FontWeight.bold : FontWeight.normal,
            color: depth == 3 ? Colors.cyan.shade800 : Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.cyan.shade600),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.cyan.shade800),
        ),
      ],
    ),
  );
}
