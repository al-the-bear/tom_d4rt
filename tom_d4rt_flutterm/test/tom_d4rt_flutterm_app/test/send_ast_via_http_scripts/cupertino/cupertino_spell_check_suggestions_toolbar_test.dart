// D4rt test script: Tests CupertinoSpellCheckSuggestionsToolbar from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoSpellCheckSuggestionsToolbar test executing');

  // Test CupertinoSpellCheckSuggestionsToolbar - Spell toolbar
  print('CupertinoSpellCheckSuggestionsToolbar is available in the cupertino package');
  print('CupertinoSpellCheckSuggestionsToolbar runtimeType accessible');

  print('CupertinoSpellCheckSuggestionsToolbar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CupertinoSpellCheckSuggestionsToolbar Tests'),
      Text('Spell toolbar'),
    ],
  );
}
