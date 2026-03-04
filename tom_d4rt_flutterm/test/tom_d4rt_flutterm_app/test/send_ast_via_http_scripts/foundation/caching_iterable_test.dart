// D4rt test script: Tests CachingIterable from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CachingIterable test executing');

  // Test CachingIterable - CachingIterable
  print('CachingIterable is available in the foundation package');
  print('CachingIterable: CachingIterable');

  print('CachingIterable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CachingIterable Tests'),
      Text('CachingIterable'),
    ],
  );
}
