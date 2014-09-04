part of logfmt;

StreamTransformer streamDecoder () {
  Parser parser = new Parser();

  return new StreamTransformer.fromHandlers(
    handleData: (String line, EventSink<Map<String, dynamic>> sink) {
      sink.add(parser.parse(line));
    }
  );
}