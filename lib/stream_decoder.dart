part of logfmt;

/**
 * Returns a [StreamTransformer] which [decode]s logfmt-style [String]s and
 * emits [Map]s.
 */
StreamTransformer streamDecoder() {
  return new StreamTransformer.fromHandlers(
    handleData: (String line, EventSink<Map<String, dynamic>> sink) {
      sink.add(decode(line));
    }
  );
}