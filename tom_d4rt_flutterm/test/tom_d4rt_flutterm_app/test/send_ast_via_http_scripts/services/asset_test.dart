// D4rt test script: Tests AssetImage, NetworkImage, ExactAssetImage from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Asset services test executing');

  // ========== ASSETIMAGE ==========
  print('--- AssetImage Tests ---');

  final assetImage = AssetImage('icon.png');
  print('AssetImage: ${assetImage.runtimeType}');
  print('AssetImage keyName: ${assetImage.keyName}');
  print('AssetImage assetName: ${assetImage.assetName}');

  // AssetImage with package
  final packageAsset = AssetImage('images/logo.png', package: 'my_package');
  print('Package AssetImage: ${packageAsset.runtimeType}');
  print('Package AssetImage keyName: ${packageAsset.keyName}');
  print('Package AssetImage package: ${packageAsset.package}');

  // ExactAssetImage with scale
  final exactAsset = ExactAssetImage('icon@2x.png', scale: 2.0);
  print('ExactAssetImage: ${exactAsset.runtimeType}');
  print('ExactAssetImage keyName: ${exactAsset.keyName}');
  print('ExactAssetImage scale: ${exactAsset.scale}');

  // ========== NETWORKIMAGE ==========
  print('--- NetworkImage Tests ---');

  final networkImage = NetworkImage(
    'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
  );
  print('NetworkImage: ${networkImage.runtimeType}');
  print('NetworkImage url: ${networkImage.url}');
  print('NetworkImage scale: ${networkImage.scale}');

  // NetworkImage with scale
  final scaledNetworkImage = NetworkImage(
    'https://flutter.dev/favicon.ico',
    scale: 2.0,
  );
  print('Scaled NetworkImage url: ${scaledNetworkImage.url}');
  print('Scaled NetworkImage scale: ${scaledNetworkImage.scale}');

  // ========== MEMORYIMAGE ==========
  print('--- MemoryImage Tests ---');

  // Create a minimal 1x1 transparent PNG as bytes
  // (just test constructor, not actual rendering)
  // We can't easily create real image bytes in a D4rt script,
  // but we can verify the class exists and its type

  // ========== FILEIMAGEPROVIDER PROPERTIES ==========
  print('--- Image Provider Properties ---');

  // Test equality
  final asset1 = AssetImage('test.png');
  final asset2 = AssetImage('test.png');
  print('AssetImage equality: ${asset1 == asset2}');
  print('AssetImage hashCode match: ${asset1.hashCode == asset2.hashCode}');

  final net1 = NetworkImage('https://example.com/a.png');
  final net2 = NetworkImage('https://example.com/a.png');
  print('NetworkImage equality: ${net1 == net2}');
  print('NetworkImage hashCode match: ${net1.hashCode == net2.hashCode}');

  final net3 = NetworkImage('https://example.com/b.png');
  print('Different NetworkImage equality: ${net1 == net3}');

  // ========== DECORATIONIMAGE ==========
  print('--- DecorationImage Tests ---');

  final decoImage = DecorationImage(
    image: NetworkImage('https://example.com/bg.png'),
    fit: BoxFit.cover,
    alignment: Alignment.center,
    repeat: ImageRepeat.noRepeat,
  );
  print('DecorationImage: ${decoImage.runtimeType}');
  print('DecorationImage fit: ${decoImage.fit}');
  print('DecorationImage alignment: ${decoImage.alignment}');
  print('DecorationImage repeat: ${decoImage.repeat}');

  // DecorationImage with more options
  final decoImage2 = DecorationImage(
    image: AssetImage('background.png'),
    fit: BoxFit.contain,
    alignment: Alignment.topCenter,
    repeat: ImageRepeat.repeatX,
    opacity: 0.8,
    filterQuality: FilterQuality.high,
  );
  print('DecorationImage2 fit: ${decoImage2.fit}');
  print('DecorationImage2 opacity: ${decoImage2.opacity}');
  print('DecorationImage2 filterQuality: ${decoImage2.filterQuality}');

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Asset services test'),
        SizedBox(height: 8.0),
        Text('AssetImage keyName: ${assetImage.keyName}'),
        Text('NetworkImage url: ${networkImage.url}'),
        SizedBox(height: 8.0),
        Text('ExactAssetImage keyName: ${exactAsset.keyName}'),
        Text('ExactAssetImage scale: ${exactAsset.scale}'),
        SizedBox(height: 8.0),
        Text('Package asset keyName: ${packageAsset.keyName}'),
        SizedBox(height: 8.0),
        // Display a network image widget (may or may not load)
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Image(
            image: networkImage,
            errorBuilder: (ctx, error, stack) {
              print('Image load error: $error');
              return Center(child: Icon(Icons.broken_image, size: 40.0));
            },
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        SizedBox(height: 8.0),
        Text('Asset services test rendered'),
      ],
    ),
  );
}
