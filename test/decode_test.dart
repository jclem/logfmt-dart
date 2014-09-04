library logfmt.parser_test;

import 'package:logfmt/logfmt.dart' as logfmt;
import 'package:unittest/unittest.dart';

void main() {
  group('#decode', () {
    test('decodes simple flags as `true`', () {
      expect(logfmt.decode('test'), equals({ 'test': true }));
    });

    test('decodes simple key/value pairs to a Map<String, String>', () {
      expect(logfmt.decode('foo=bar'), equals({ 'foo': 'bar' }));
    });

    test('decodes values with escape sequences', () {
      expect(logfmt.decode('test=\'escaped\''),
          equals({ 'test': '\'escaped\'' }));
    });

    test('decodes simple booleans', () {
      expect(logfmt.decode('test=true'), equals({ 'test': true }));
    });

    test('decodes numbers to strings', () {
      expect(logfmt.decode('test=123'), equals({ 'test': '123' }));
    });

    test('decodes values containing "="', () {
      expect(logfmt.decode('test="foo=bar"'), equals({ 'test': 'foo=bar' }));
    });

    test('decodes keys containing "="', () {
      expect(logfmt.decode('"test=true"=value'),
          equals({ 'test=true': 'value' }));
    });

    test('decodes "null" to Map<String, Null>', () {
      expect(logfmt.decode('test=null'), equals({ 'test': null }));
    });

    test('decodes a complex string', () {
      String string = 'foo=bar a=14 baz="hello \tquotes" '
        'cool%story=bro f %^asdf '
        'code=H12 path=/hello/user@example.com/close';

      Map result = logfmt.decode(string);

      expect(result, equals({
        'foo': 'bar',
        'a': '14',
        'baz': 'hello \tquotes',
        'cool%story': 'bro',
        'f': true,
        '%^asdf': true,
        'code': 'H12',
        'path': '/hello/user@example.com/close'
      }));
    });
  });
}