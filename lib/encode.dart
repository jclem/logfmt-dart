part of logfmt;

String encode(Map<String, dynamic> map) {
  String line = '';

  map.forEach((String key, dynamic value) {
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