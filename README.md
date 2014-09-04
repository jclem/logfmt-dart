# logfmt-dart [![Build Status](https://travis-ci.org/jclem/logfmt-dart.svg?branch=master)](https://travis-ci.org/jclem/logfmt-dart)

"logfmt" is the name of a key-value logging convention, where log lines are formatted as "key=value" pairs.

This package parses individual log lines or streams of log lines. Individual log lines are parsed as `Map<String, dynamic>` objects, and streams passing through the `streamDecoder` transform will emit `Map<String, dynamic>` objects, as well.

## Usage

### Parser#parse

Given a logfmt-style log line, parse it into a `Map<String, dynamic>` using `Parser#parse`:

```dart
import 'package:logfmt/logfmt.dart';
import 'package:unittest/unittest.dart';

Parser parser = new Parser();

void main() {
  test('key=value pairs of non-null and non-boolean strings parse into [Map<String, String>].', () {
    expect(parser.parse('key=value'), equals({ 'key': 'value' }));
  });
  
  test('"flag"s are parsed into [Map<String, bool>] where `bool` is `true`.', () {
    expect(parser.parse('flag'), equals({ 'flag': true }));
  });
  
  test('Pairs with "true" or "false" as values are parsed into [Map<String, bool>], as appropriate.', () {
    expect(parser.parse('key=false'), equals({ 'key': false }));
  });
  
  test('Pairs with "null" values are parsed into [Map<String, Null>].', () {
    expect(parser.parse('key=null'), equals({ 'key': null }));
  });
  
  test('Quoted keys and values are preserved.', () {
    expect(parser.parse('"quoted key"="quoted value"'), equals({ 'quoted key': 'quoted value' }));
  });
}
```

### streamDecoder

A stream of lines can be sent to the `streamDecoder` transformer, which will return a stream emitting `Map<String, dynamic>` objects.

```dart
import 'dart:convert';
import 'dart:io';
import 'package:logfmt/logfmt.dart';

void main() {
  new File('test/log.txt').openRead()
    .transform(new Utf8Decoder())
    .transform(new LineSplitter())
    .transform(streamDecoder())
    .listen((Map<String, dynamic> map) {
      print(map);
    });
}
```

## Todo

- Implement encoding, move `Parser#parse` to provide `Logfmt#encode` and `Logfmt#decode`.
- Implement printing to a stream.
- Implement timing.
- Implement example request logger.
