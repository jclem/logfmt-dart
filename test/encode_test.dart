library logfmt.encode_test;

import 'package:logfmt/logfmt.dart' as logfmt;
import 'package:unittest/unittest.dart';

void main() {
  group('#encode', () {
    test('encodes a Map<String, String> to a simple key/value pair', () {
      expect(logfmt.encode({ 'test': 'bar' }), equals('test=bar'));
    });

    test('encodes a Map<String, bool> with a true value', () {
      expect(logfmt.encode({ 'true': true }), equals('true=true'));
    });

    test('encodes a Map<String, bool> with a false value', () {
      expect(logfmt.encode({ 'false': false }), equals('false=false'));
    });

    test('encodes a Map<String, Null> with a null value', () {
      expect(logfmt.encode({ 'null': null }), equals('null=null'));
    });

    test('encodes a Map<String, double>', () {
      expect(logfmt.encode({ 'double': 0.444444444444 }),
        equals('double=0.444444444444'));
    });

    test('encodes long doubles as truncated', () {
      expect(logfmt.encode({ 'longDouble': 0.44444444444444444444 }),
        equals('longDouble=0.4444444444444444'));
    });

    test('encodes dates as UTC ISO 8601', () {
      DateTime date = new DateTime.now();

      expect(logfmt.encode({ 'date': date }),
        equals('date=${date.toUtc().toIso8601String()}'));
    });

    test('encodes multi-word strings as quoted', () {
      expect(logfmt.encode({ 'key': 'quoted value' }),
        equals('key="quoted value"'));
    });

    test('encodes quotes as escaped quotes', () {
      expect(logfmt.encode({ 'key': '"value' }), equals(r'key=\"value'));
    });

    test('encodes new lines with literal \\n characters', () {
      expect(logfmt.encode({ 'key': '\nvalue' }), equals(r'key=\nvalue'));
    });
  });
}