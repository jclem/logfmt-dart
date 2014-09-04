part of logfmt;

/**
 * Returns a [StreamTransformer] which [encode]s [Map]s and emits logfmt-style
 * [String]s.
 */
StreamTransformer streamEncoder() {
  return new StreamTransformer.fromHandlers(
    handleData: (Map<String, dynamic> map, EventSink<String> sink) {
      sink.add(encode(map));
    }
  );
}