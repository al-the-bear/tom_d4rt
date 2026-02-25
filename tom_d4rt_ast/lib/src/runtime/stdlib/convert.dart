import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/ascii.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/base64.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/byte_conversion.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/codec.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/converter.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/encoding.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/html_escape.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/json.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/latin1.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/line_splitter.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/utf.dart';
import 'dart:convert';
import 'package:tom_d4rt_ast/src/runtime/callable.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';

export 'package:tom_d4rt_ast/src/runtime/environment.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/ascii.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/base64.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/byte_conversion.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/chunked_conversion.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/codec.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/converter.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/encoding.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/html_escape.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/json.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/latin1.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/line_splitter.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/string_conversion.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/convert/utf.dart';

class ConvertStdlib {
  static void register(Environment environment) {
    // Register bridged classes
    environment.defineBridge(Base64CodecConvert.definition);
    environment.defineBridge(Base64EncoderConvert.definition);
    environment.defineBridge(Base64DecoderConvert.definition);
    environment.defineBridge(AsciiCodecConvert.definition);
    environment.defineBridge(AsciiEncoderConvert.definition);
    environment.defineBridge(AsciiDecoderConvert.definition);
    environment.defineBridge(Utf8CodecConvert.definition);
    environment.defineBridge(Utf8EncoderConvert.definition);
    environment.defineBridge(Utf8DecoderConvert.definition);
    environment.defineBridge(JsonCodecConvert.definition);
    environment.defineBridge(JsonEncoderConvert.definition);
    environment.defineBridge(JsonDecoderConvert.definition);
    environment.defineBridge(CodecConvert.definition);
    environment.defineBridge(ConverterConvert.definition);
    environment.defineBridge(Latin1CodecConvert.definition);
    environment.defineBridge(Latin1EncoderConvert.definition);
    environment.defineBridge(Latin1DecoderConvert.definition);
    environment.defineBridge(LineSplitterConvert.definition);
    environment.defineBridge(EncodingConvert.definition);
    environment.defineBridge(ByteConversionConvert.definition);

    // Register global functions
    environment.define(
        'jsonEncode',
        NativeFunction((visitor, arguments, namedArguments, typeArguments) {
          if (arguments.length != 1) {
            throw RuntimeD4rtException(
                'jsonEncode requires one positional argument (object).');
          }
          final toEncodableArg =
              namedArguments['toEncodable'] as InterpretedFunction?;
          return jsonEncode(
            arguments[0],
            toEncodable: toEncodableArg == null
                ? null
                : (object) => toEncodableArg.call(visitor, [object]),
          );
        }, arity: 1, name: 'jsonEncode'));

    environment.define(
        'jsonDecode',
        NativeFunction((visitor, arguments, namedArguments, typeArguments) {
          if (arguments.length != 1 || arguments[0] is! String) {
            throw RuntimeD4rtException(
                'jsonDecode requires one positional argument (String source).');
          }
          final reviverArg = namedArguments['reviver'] as InterpretedFunction?;
          return jsonDecode(
            arguments[0] as String,
            reviver: reviverArg == null
                ? null
                : (key, value) => reviverArg.call(visitor, [key, value]),
          );
        }, arity: 1, name: 'jsonDecode'));

    // Register global instances
    environment.define('json', json);
    environment.define('base64', base64);
    environment.define('base64Url', base64Url);
    environment.define('ascii', ascii);
    environment.define('utf8', utf8);
    environment.define('latin1', latin1);

    // Register global functions
    environment.define(
        'base64Encode',
        NativeFunction((visitor, arguments, namedArguments, typeArguments) {
          if (arguments.length != 1) {
            throw RuntimeD4rtException(
                'base64Encode requires one positional argument (List<int> bytes).');
          }
          final bytes = arguments[0];
          if (bytes is! List) {
            throw RuntimeD4rtException('base64Encode requires a List<int> argument.');
          }
          return base64Encode(bytes.cast<int>());
        }, arity: 1, name: 'base64Encode'));

    environment.define(
        'base64Decode',
        NativeFunction((visitor, arguments, namedArguments, typeArguments) {
          if (arguments.length != 1 || arguments[0] is! String) {
            throw RuntimeD4rtException(
                'base64Decode requires one positional argument (String source).');
          }
          return base64Decode(arguments[0] as String);
        }, arity: 1, name: 'base64Decode'));

    // Register HtmlEscape classes
    HtmlEscapeConvert.register(environment);
  }
}
