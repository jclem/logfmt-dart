library logfmt.logger;

import 'package:logfmt/logfmt.dart';
import 'package:unittest/unittest.dart';
import 'mock_sink.dart';

void main() {
  Logger logger;
  MockSink sink;

  group('Logger', () {
    setUp(() {
      sink = new MockSink();
      logger = new Logger(sink: sink, elapsedKey: 'duration');
    });

    group('#log', () {
      test('it logs the map', () {
        logger.log({ 'key': 'value' });
        expect(sink.calls('write').first.args, equals(['key=value\n']));
      });
    });

    group('#logWithElapsed', () {
      test('logs with a default elapsed key', () {
        Logger logger = new Logger(sink: sink);
        logger.logWithElapsed({ 'key': 'value' });
        RegExp lineRegExp = new RegExp(r'^key=value elapsed=\d+ms\n$');
        expect(sink.calls('write').first.args[0],
          matches(lineRegExp));
      });

      test('logs with the given elapsed key', () {
        logger.logWithElapsed({ 'key': 'value' });
        RegExp lineRegExp = new RegExp(r'^key=value duration=\d+ms\n$');
        expect(sink.calls('write').first.args[0],
          matches(lineRegExp));
      });

      test('does not modify its map', () {
        Map map = { 'key': 'value' };
        logger.logWithElapsed(map);
        expect(map, equals({ 'key': 'value' }));
      });
    });
  });
}