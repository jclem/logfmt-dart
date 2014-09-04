library logfmt.log_test;

import 'package:logfmt/logfmt.dart' as logfmt;
import 'package:unittest/unittest.dart';
import 'mock_sink.dart';

void main() {
  group('#log', () {
    test('calls #write on the given stream, and appends a new line', () {
      MockSink sink = new MockSink();
      logfmt.log({ 'key': 'value' }, sink: sink);
      expect(sink.calls('write').first.args, equals(['key=value\n']));
    });
  });
}