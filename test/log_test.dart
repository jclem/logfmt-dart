library logfmt.log_test;

import 'dart:io';
import 'package:logfmt/logfmt.dart' as logfmt;
import 'package:mock/mock.dart';
import 'package:unittest/unittest.dart';

void main() {
  group('#log', () {
    test('calls #write on the given stream, and appends a new line', () {
      MockSink sink = new MockSink();
      logfmt.log({ 'key': 'value' }, sink: sink);
      expect(sink.calls('write').first.args, equals(['key=value\n']));
    });
  });
}

class MockSink extends Mock implements Stdout {
  noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}