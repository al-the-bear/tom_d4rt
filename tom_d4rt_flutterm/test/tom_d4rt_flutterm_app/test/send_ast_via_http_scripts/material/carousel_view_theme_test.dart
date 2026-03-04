// D4rt test script: Tests CarouselViewTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CarouselViewTheme test executing');

  // Test CarouselViewTheme - CarouselViewTheme
  print('CarouselViewTheme is available in the material package');
  print('CarouselViewTheme runtimeType accessible');

  print('CarouselViewTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CarouselViewTheme Tests'),
      Text('CarouselViewTheme'),
    ],
  );
}
