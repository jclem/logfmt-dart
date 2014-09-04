part of logfmt;


/**
 * Parses a string of logfmt-style key-value pairs into a [Map].
 *
 * The string should be a space-separated list of `'key=value'` pairs, such
 * as:
 *
 *     req.method=GET req.path=/apps req.status=200 req.elapsed=50ms
 *
 * This string would parse into a [Map] that looks like the following:
 *
 *     {
 *       'req.method': 'GET',
 *       'req.path': '/apps',
 *       'req.status': '200',
 *       'req.elapsed': '50ms'
 *     }
 *
 * Keys or values with spaces in them should be quoted, such as in
 * `'"a key"="a value"'`. The only values parsed to something other than a
 * string are `'true'`, `'false'`, and `'null'`, which parse, respectively,
 * to `true`, `false`, and `null`.
 */
Map<String, dynamic> decode(String string) {
  List data = _stripTrailingNewline(string).split('');
  Map<String, dynamic> map = new Map<String, dynamic>();

  String key = '';
  var value = '';
  bool inKey = false;
  bool inValue = false;
  bool inQuote = false;
  bool hadQuote = false;

  for (int i = 0; i <= data.length; i++) {
    String char;

    if (i < data.length) {
      char = data[i];
    }

    if ((char == ' ' && !inQuote) || i == data.length) {
      if (inKey && key.length > 0) {
        map[key] = true;
      } else if (inValue) {
        if (value == 'true') {
          value = true;
        } else if (value == 'false') {
          value = false;
        } else if (value == 'null') {
          value = null;
        } else if (value == '' && !hadQuote) {
          value = null;
        }

        map[key] = value;
        value = '';
      }

      if (i == data.length) {
        break;
      } else {
        inKey = false;
        inValue = false;
        inQuote = false;
        hadQuote = false;
      }
    }

    if (char == '=' && !inQuote) {
      inKey = false;
      inValue = true;
    } else if (char == '"') {
      hadQuote = true;
      inQuote = !inQuote;
    } else if (char != ' ' && !inValue && !inKey) {
      inKey = true;
      key = char;
    } else if (inKey) {
      key += char;
    } else if (inValue) {
      value += char;
    }
  }

  return map;
}

String _stripTrailingNewline(String string) {
  RegExp trailingNewLine = new RegExp('\n\$');
  return string.replaceFirst(trailingNewLine, '');
}