import 'package:build/build.dart';

import 'src/builder/analyzer_builder.dart';
import 'src/builder/reflection_builder.dart';

Builder analyzerBuilder(BuilderOptions options) => AnalyzerBuilder(options);
Builder reflectionBuilder(BuilderOptions options) => ReflectionBuilder(options);
