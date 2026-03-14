// D4rt test script: Tests TextureBox from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextureBox test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic TextureBox Creation ---');

  final textureBox1 = TextureBox(textureId: 1);
  print('Created TextureBox: ${textureBox1.runtimeType}');
  print('textureId: ${textureBox1.textureId}');
  print('Is RenderBox: ${textureBox1 is RenderBox}');
  results.add('Basic creation: textureId=1');

  // ========== Section 2: Various Texture IDs ==========
  print('--- Section 2: Various Texture IDs ---');

  final textureIds = [0, 1, 5, 10, 100, 1000];
  for (final id in textureIds) {
    final tb = TextureBox(textureId: id);
    print('TextureBox with textureId $id: ${tb.textureId}');
  }
  results.add('Tested ${textureIds.length} texture IDs');

  // ========== Section 3: FilterQuality Property ==========
  print('--- Section 3: FilterQuality Property ---');

  // Default filter quality
  final defaultQuality = TextureBox(textureId: 1);
  print('Default filterQuality: ${defaultQuality.filterQuality}');

  // Low filter quality
  final lowQuality = TextureBox(textureId: 1, filterQuality: FilterQuality.low);
  print('Low filterQuality: ${lowQuality.filterQuality}');

  // Medium filter quality
  final mediumQuality = TextureBox(
    textureId: 1,
    filterQuality: FilterQuality.medium,
  );
  print('Medium filterQuality: ${mediumQuality.filterQuality}');

  // High filter quality
  final highQuality = TextureBox(
    textureId: 1,
    filterQuality: FilterQuality.high,
  );
  print('High filterQuality: ${highQuality.filterQuality}');

  // None filter quality
  final noneQuality = TextureBox(
    textureId: 1,
    filterQuality: FilterQuality.none,
  );
  print('None filterQuality: ${noneQuality.filterQuality}');
  results.add('FilterQuality tested: all values');

  // ========== Section 4: All FilterQuality Values ==========
  print('--- Section 4: All FilterQuality Values ---');

  for (final quality in FilterQuality.values) {
    final tb = TextureBox(textureId: 1, filterQuality: quality);
    print('FilterQuality.${quality.name}: ${tb.filterQuality}');
  }
  print('Total FilterQuality values: ${FilterQuality.values.length}');
  results.add('FilterQuality enum: ${FilterQuality.values.length} values');

  // ========== Section 5: Freeze Property ==========
  print('--- Section 5: Freeze Property ---');

  final unfrozen = TextureBox(textureId: 1, freeze: false);
  print('Unfrozen: freeze=${unfrozen.freeze}');

  final frozen = TextureBox(textureId: 1, freeze: true);
  print('Frozen: freeze=${frozen.freeze}');
  results.add('Freeze property tested');

  // ========== Section 6: Changing Texture ID ==========
  print('--- Section 6: Changing Texture ID ---');

  final tb = TextureBox(textureId: 1);
  print('Initial textureId: ${tb.textureId}');

  tb.textureId = 5;
  print('After setting to 5: ${tb.textureId}');

  tb.textureId = 100;
  print('After setting to 100: ${tb.textureId}');
  results.add('Texture ID change tested');

  // ========== Section 7: Changing Filter Quality ==========
  print('--- Section 7: Changing Filter Quality ---');

  final tb2 = TextureBox(textureId: 1, filterQuality: FilterQuality.low);
  print('Initial filterQuality: ${tb2.filterQuality}');

  tb2.filterQuality = FilterQuality.high;
  print('After setting to high: ${tb2.filterQuality}');

  tb2.filterQuality = FilterQuality.medium;
  print('After setting to medium: ${tb2.filterQuality}');
  results.add('Filter quality change tested');

  // ========== Section 8: Changing Freeze ==========
  print('--- Section 8: Changing Freeze ---');

  final tb3 = TextureBox(textureId: 1, freeze: false);
  print('Initial freeze: ${tb3.freeze}');

  tb3.freeze = true;
  print('After setting to true: ${tb3.freeze}');

  tb3.freeze = false;
  print('After setting to false: ${tb3.freeze}');
  results.add('Freeze change tested');

  // ========== Section 9: Multiple Instances ==========
  print('--- Section 9: Multiple Instances ---');

  final instances = <TextureBox>[];
  for (int i = 0; i < 5; i++) {
    final tb = TextureBox(
      textureId: i,
      filterQuality: FilterQuality.values[i % FilterQuality.values.length],
      freeze: i % 2 == 0,
    );
    instances.add(tb);
    print(
      'Instance $i - textureId: ${tb.textureId}, filterQuality: ${tb.filterQuality}, freeze: ${tb.freeze}',
    );
  }
  results.add('Created ${instances.length} instances');

  // ========== Section 10: Inheritance Chain ==========
  print('--- Section 10: Inheritance Chain ---');

  final textureBox2 = TextureBox(textureId: 1);
  print('Is RenderObject: ${textureBox2 is RenderObject}');
  print('Is RenderBox: ${textureBox2 is RenderBox}');
  print('Is TextureBox: ${textureBox2 is TextureBox}');
  print('Runtime type: ${textureBox2.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 11: SizedByParent Property ==========
  print('--- Section 11: SizedByParent Property ---');

  final textureBox3 = TextureBox(textureId: 1);
  print('sizedByParent: ${textureBox3.sizedByParent}');
  results.add('sizedByParent: ${textureBox3.sizedByParent}');

  // ========== Section 12: Large Texture IDs ==========
  print('--- Section 12: Large Texture IDs ---');

  final largeIds = [10000, 100000, 1000000, 999999999];
  for (final id in largeIds) {
    final tb = TextureBox(textureId: id);
    print('Large textureId $id: ${tb.textureId}');
  }
  results.add('Tested ${largeIds.length} large texture IDs');

  print('TextureBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextureBox Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
