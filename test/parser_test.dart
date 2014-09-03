import 'package:logfmt/logfmt.dart';
import 'package:unittest/unittest.dart';

Logfmt logfmt = new Logfmt();

void main() {
  test('simple flag parses to true', () {
    expect({ 'test': true }, equals(logfmt.parse('test')));
  });

  test('simple key/value parses to map', () {
    expect({ 'foo': 'bar' },equals(logfmt.parse('foo=bar')));
  });

  test('escape sequences parse', () {
    expect({ 'test': '\'escaped\'' }, equals(logfmt.parse('test=\'escaped\'')));
  });

  test('simple boolean parses', () {
    expect({ 'test': true }, equals(logfmt.parse('test=true')));
  });

  test('numbers parse to strings', () {
    expect({ 'test': '123' }, equals(logfmt.parse('test=123')));
  });

  test('values with equals', () {
    expect({ 'test': 'foo=bar' }, equals(logfmt.parse('test="foo=bar"')));
  });

  test('keys with equals', () {
    expect({ 'test=true': 'value' }, equals(logfmt.parse('"test=true"=value')));
  });

  test('complex string parses', () {
    String string = 'foo=bar a=14 baz="hello \tquotes" '
      'cool%story=bro f %^asdf '
      'code=H12 path=/hello/user@example.com/close';

    Map result = logfmt.parse(string);

    expect({
      'foo': 'bar',
      'a': '14',
      'baz': 'hello \tquotes',
      'cool%story': 'bro',
      'f': true,
      '%^asdf': true,
      'code': 'H12',
      'path': '/hello/user@example.com/close'
    }, equals(result));
  });
}