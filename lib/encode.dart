part of logfmt;

/**
 * Decodes a [Map] into a logfmt-style string.
 *
 * Example:
 *
 *     logfmt.encode({ 'foo': 'bar' }); // 'foo=bar'
 *
 * It ensures that any values with spaces are quoted, and any quotes or new
 * lines are escaped, where necessary.
 */
String encode(Map<String, dynamic> map) {
  String line = '';

  map.forEach((String key, dynamic value) {
    if (line.length > 0) {
      line += ' ';
    }

    line += '${encodeString(key)}=${encodeValue(value)}';
  });

  return line;
}

String encodeValue(dynamic value) {
  Type type = value.runtimeType;

  if (type == DateTime) {
    return value.toUtc().toIso8601String();
  } else if (type == String) {
    return encodeString(value);
  } else {
    return encodeString(value.toString());
  }
}

String encodeString(String string) {
  if (string.contains(' ')) {
    return '"$string"';
  } else if (string.contains('\n')) {
    return string.replaceAll('\n', r'\n');
  } else if (string.contains('"')) {
    return string.replaceAll('"', r'\"');
  } else {
    return string;
  }
}