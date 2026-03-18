// D4rt test script: Tests StandardMessageCodec, StandardMethodCodec, JSONMessageCodec, JSONMethodCodec, BinaryCodec, StringCodec from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services codecs test executing');

  // ========== STRINGCODEC ==========
  print('--- StringCodec Tests ---');

  final stringCodec = StringCodec();
  print('StringCodec created');
  print('  runtimeType: ${stringCodec.runtimeType}');

  final encoded = stringCodec.encodeMessage('Hello, D4rt!');
  print('Encoded "Hello, D4rt!": ${encoded != null ? "has data" : "null"}');

  final decoded = stringCodec.decodeMessage(encoded);
  print('Decoded: "$decoded"');

  // Empty string
  final emptyEncoded = stringCodec.encodeMessage('');
  final emptyDecoded = stringCodec.decodeMessage(emptyEncoded);
  print('Empty string round-trip: "$emptyDecoded"');

  // Null message
  final nullDecoded = stringCodec.decodeMessage(null);
  print('Null decode: $nullDecoded');

  // ========== JSONMESSAGECODEC ==========
  print('--- JSONMessageCodec Tests ---');

  final jsonMsgCodec = JSONMessageCodec();
  print('JSONMessageCodec created');
  print('  runtimeType: ${jsonMsgCodec.runtimeType}');

  // Encode/decode string
  final jsonStrEncoded = jsonMsgCodec.encodeMessage('test string');
  final jsonStrDecoded = jsonMsgCodec.decodeMessage(jsonStrEncoded);
  print('String round-trip: "$jsonStrDecoded"');

  // Encode/decode number
  final jsonNumEncoded = jsonMsgCodec.encodeMessage(42);
  final jsonNumDecoded = jsonMsgCodec.decodeMessage(jsonNumEncoded);
  print('Number round-trip: $jsonNumDecoded');

  // Encode/decode map
  final jsonMapEncoded = jsonMsgCodec.encodeMessage({
    'key': 'value',
    'count': 5,
  });
  final jsonMapDecoded = jsonMsgCodec.decodeMessage(jsonMapEncoded);
  print('Map round-trip: $jsonMapDecoded');

  // Encode/decode list
  final jsonListEncoded = jsonMsgCodec.encodeMessage([1, 'two', 3.0, true]);
  final jsonListDecoded = jsonMsgCodec.decodeMessage(jsonListEncoded);
  print('List round-trip: $jsonListDecoded');

  // ========== JSONMETHODCODEC ==========
  print('--- JSONMethodCodec Tests ---');

  final jsonMethodCodec = JSONMethodCodec();
  print('JSONMethodCodec created');
  print('  runtimeType: ${jsonMethodCodec.runtimeType}');

  // Encode method call
  final methodCall = MethodCall('testMethod', {'arg1': 'hello', 'arg2': 42});
  final encodedCall = jsonMethodCodec.encodeMethodCall(methodCall);
  print('Encoded method call: ${"has data"}');

  // Decode method call
  final decodedCall = jsonMethodCodec.decodeMethodCall(encodedCall);
  print('Decoded method call:');
  print('  method: ${decodedCall.method}');
  print('  arguments: ${decodedCall.arguments}');

  // Encode success envelope
  final successEnv = jsonMethodCodec.encodeSuccessEnvelope('result_value');
  print('Encoded success envelope: ${"has data"}');

  // Decode success envelope
  final decodedSuccess = jsonMethodCodec.decodeEnvelope(successEnv);
  print('Decoded success: $decodedSuccess');

  // ========== STANDARDMESSAGECODEC ==========
  print('--- StandardMessageCodec Tests ---');

  final stdMsgCodec = StandardMessageCodec();
  print('StandardMessageCodec created');
  print('  runtimeType: ${stdMsgCodec.runtimeType}');

  // Encode/decode null
  final nullEncoded = stdMsgCodec.encodeMessage(null);
  final nullDec = stdMsgCodec.decodeMessage(nullEncoded);
  print('Null round-trip: $nullDec');

  // Encode/decode int
  final intEncoded = stdMsgCodec.encodeMessage(12345);
  final intDec = stdMsgCodec.decodeMessage(intEncoded);
  print('Int round-trip: $intDec');

  // Encode/decode double
  final doubleEncoded = stdMsgCodec.encodeMessage(3.14159);
  final doubleDec = stdMsgCodec.decodeMessage(doubleEncoded);
  print('Double round-trip: $doubleDec');

  // Encode/decode string
  final strEncoded = stdMsgCodec.encodeMessage('Standard message');
  final strDec = stdMsgCodec.decodeMessage(strEncoded);
  print('String round-trip: "$strDec"');

  // Encode/decode bool
  final boolEncoded = stdMsgCodec.encodeMessage(true);
  final boolDec = stdMsgCodec.decodeMessage(boolEncoded);
  print('Bool round-trip: $boolDec');

  // Encode/decode list
  final listEncoded = stdMsgCodec.encodeMessage([1, 'two', 3.0]);
  final listDec = stdMsgCodec.decodeMessage(listEncoded);
  print('List round-trip: $listDec');

  // Encode/decode map
  final mapEncoded = stdMsgCodec.encodeMessage({'a': 1, 'b': 'two'});
  final mapDec = stdMsgCodec.decodeMessage(mapEncoded);
  print('Map round-trip: $mapDec');

  // ========== STANDARDMETHODCODEC ==========
  print('--- StandardMethodCodec Tests ---');

  final stdMethodCodec = StandardMethodCodec();
  print('StandardMethodCodec created');
  print('  runtimeType: ${stdMethodCodec.runtimeType}');

  // Encode method call
  final stdCall = MethodCall('getData', [1, 2, 3]);
  final stdEncoded = stdMethodCodec.encodeMethodCall(stdCall);
  print('Encoded standard method call: ${"has data"}');

  final stdDecoded = stdMethodCodec.decodeMethodCall(stdEncoded);
  print('Decoded: method=${stdDecoded.method}, args=${stdDecoded.arguments}');

  // Success envelope
  final stdSuccess = stdMethodCodec.encodeSuccessEnvelope({
    'data': [1, 2, 3],
  });
  final stdSuccessDec = stdMethodCodec.decodeEnvelope(stdSuccess);
  print('Success envelope result: $stdSuccessDec');

  // ========== BINARYCODEC ==========
  print('--- BinaryCodec Tests ---');

  final binaryCodec = BinaryCodec();
  print('BinaryCodec created');
  print('  runtimeType: ${binaryCodec.runtimeType}');

  // Binary passes through unchanged
  final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
  final binaryEncoded = binaryCodec.encodeMessage(bytes.buffer.asByteData());
  print('Binary encoded: ${binaryEncoded != null ? "has data" : "null"}');

  final binaryDecoded = binaryCodec.decodeMessage(binaryEncoded);
  print('Binary decoded: ${binaryDecoded != null ? "has data" : "null"}');

  // ========== RETURN WIDGET ==========
  print('Services codecs test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Codecs Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• StringCodec - string encoding'),
          Text('• JSONMessageCodec - JSON message encoding'),
          Text('• JSONMethodCodec - JSON method call encoding'),
          Text('• StandardMessageCodec - platform message encoding'),
          Text('• StandardMethodCodec - platform method encoding'),
          Text('• BinaryCodec - raw binary pass-through'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE0F2F1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Codec Round-trip Results:'),
                Text('  String: "$decoded"'),
                Text('  JSON string: "$jsonStrDecoded"'),
                Text('  JSON number: $jsonNumDecoded'),
                Text('  Standard int: $intDec'),
                Text('  Standard double: $doubleDec'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
