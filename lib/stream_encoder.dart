part of logfmt;

/**
 * Returns a [StreamTransformer](dart-async.StreamTransformer) which [encode]s [Map]s and emits logfmt-style
 * [String]s.
 *
 *
 * Example:
 *
 *     import 'dart:async';
 *     import 'package:logfmt/logfmt.dart' as logfmt;
 *
 *     void main() {
 *       new Stream.fromIterable(myMaps)
 *         .transform(logfmt.streamEncoder())
 *         .listen((String line) {
 *           print(line);
 *         });
 *     }
 */
StreamTransformer streamEncoder() {
  return new StreamTransformer.fromHandlers(
    handleData: (Map<String, dynamic> map, EventSink<String> sink) {
      sink.add(encode(map));
    }
  );
}