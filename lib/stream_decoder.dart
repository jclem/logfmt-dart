part of logfmt;

StreamTransformer streamDecoder() {
  return new StreamTransformer.fromHandlers(
    handleData: (String line, EventSink<Map<String, dynamic>> sink) {
      sink.add(decode(line));
    }
  );
}