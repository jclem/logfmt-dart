# logfmt-dart [![Build Status](https://travis-ci.org/jclem/logfmt-dart.svg?branch=master)](https://travis-ci.org/jclem/logfmt-dart)

"logfmt" is the name of a key-value logging convention, where log lines are
formatted as "key=value" pairs.

This package decodes individual log lines or streams of log lines. Individual
log lines are decoded as `Map<String, dynamic>` objects, and streams passing
through the `streamDecoder` transform will emit `Map<String, dynamic>` objects, as well.

## Usage

### #decode

Given a logfmt-style log line, decode it into a `Map<String, dynamic>` using `#decode`:

```dart
import 'package:logfmt/logfmt.dart' as logfmt;
import 'package:unittest/unittest.dart';

void main() {
  test('key=value pairs of non-null and non-boolean strings decode into [Map<String, String>].', () {
    expect(logfmt.decode('key=value'), equals({ 'key': 'value' }));
  });
  
  test('"flag"s are decoded into [Map<String, bool>] where `bool` is `true`.', () {
    expect(logfmt.decode('flag'), equals({ 'flag': true }));
  });
  
  test('Pairs with "true" or "false" as values are decoded into [Map<String, bool>], as appropriate.', () {
    expect(logfmt.decode('key=false'), equals({ 'key': false }));
  });
  
  test('Pairs with "null" values are decoded into [Map<String, Null>].', () {
    expect(logfmt.decode('key=null'), equals({ 'key': null }));
  });
  
  test('Quoted keys and values are preserved.', () {
    expect(logfmt.decode('"quoted key"="quoted value"'), equals({ 'quoted key': 'quoted value' }));
  });
}
```

### #encode

Given a `Map<String, dynamic>`, encode it into a logfmt-style string using `#encode`:

```dart
import 'package:logfmt/logfmt.dart' as logfmt;
import 'package:unittest/unittest.dart';

void main() {
  test('encodes Map<String, String> into plain key=value.', () {
    expect(logfmt.encode({ 'key': 'value' }), equals('key=value'));
  });
  
  test('encodes Map<String, bool> into key=${bool.toString}', () {
    expect(logfmt.encode({ 'key': true }), equals('key=true'));
  });
  
  test('encodes Map<String, Null> into key=${null.toString}', () {
    expect(logfmt.encode({ 'key': null }), equals('key=null'));
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
}
```

### #log

Logs a `Map<String, dynamic>` to either standard out or a given `StringSink`.

```dart
import 'package:logfmt/logfmt.dart' as logfmt;

logfmt.log({ 'key': 'value' }); // "key=value" is logged to standard out.
logfmt.log({ 'key': 'value' }, sink: sink); // The log is written to `sink`.
```

### streamDecoder

A stream of lines can be sent to the `streamDecoder` transformer, which will return a stream emitting `Map<String, dynamic>` objects.

```dart
import 'dart:convert';
import 'dart:io';
import 'package:logfmt/logfmt.dart' as logfmt;

void main() {
  new File('test/log.txt').openRead()
    .transform(new Utf8Decoder())
    .transform(new LineSplitter())
    .transform(logfmt.streamDecoder())
    .listen((Map<String, dynamic> map) {
      print(map);
    });
}
```

## Todo

- Implement a timer.
- Implement an example request logger.
