part of logfmt;

/**
 * Returns a [StreamTransformer](dart-async.StreamTransformer) which [decode]s logfmt-style [String]s and
 * emits [Map]s.
 *
 * Example:
 *
 *     import 'dart:convert';
 *     import 'dart:io';
 *     import 'package:logfmt/logfmt.dart' as logfmt;
 *
 *     void main() {
 *       new File('test/log.txt').openRead()
 *         .transform(new Utf8Decoder())
 *         .transform(new LineSplitter())
 *         .transform(logfmt.streamDecoder())
 *         .listen((Map<String, dynamic> map) {
 *           print(map);
 *         });
 *     }
 */
StreamTransformer streamDecoder() {
  return new StreamTransformer.fromHandlers(
    handleData: (String line, EventSink<Map<String, dynamic>> sink) {
      sink.add(decode(line));
    }
  );
}