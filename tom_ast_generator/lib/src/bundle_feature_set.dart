/// The language version and flags the generator parses source with.
library;

import 'package:analyzer/dart/analysis/features.dart';
import 'package:pub_semver/pub_semver.dart';

/// The feature set the bundler and `astgen` parse with: the interpreters'
/// (`D4rt._parseSource` in tom_d4rt and tom_d4rt_exec), so a library a script
/// can run is a library it can bundle.
///
/// Not the analyzer's newest language version, which `parseString` uses when
/// given none: it moves with every analyzer release and rejects code a package
/// written for an older language version is allowed to contain. Measured on
/// analyzer 14.7.0 (GitHub #9): intl 0.20.3's `num parse(final String
/// inputText)` failed with "Can't have modifier 'final' here".
///
/// Keep it identical to the interpreters' feature set.
final FeatureSet bundleFeatureSet = FeatureSet.fromEnableFlags2(
  sdkLanguageVersion: Version(3, 10, 0),
  flags: const [
    'non-nullable',
    'null-aware-elements',
    'triple-shift',
    'spread-collections',
    'control-flow-collections',
    'extension-methods',
    'extension-types',
    'digit-separators',
  ],
);
