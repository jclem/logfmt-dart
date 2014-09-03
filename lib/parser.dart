library logfmt.parser;

class Parser {
  bool debug = false;

  Logfmt({bool debug}) {
    if (debug != null) this.debug = debug;
  }

  Map<String, dynamic> parse(String string) {
    List data = this._stripTrailingNewline(string).split('');
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
        _debug('split');
      } else if (char == '"') {
        hadQuote = true;
        inQuote = !inQuote;
        _debug('in quote: $inQuote');
      } else if (char != ' ' && !inValue && !inKey) {
        inKey = true;
        key = char;
        _debug('start key: $char');
      } else if (inKey) {
        key += char;
        _debug('append key: $char');
      } else if (inValue) {
        value += char;
        _debug('append value: $char');
      }
    }

    return map;
  }

  void _debug(String string) {
    if (this.debug) print(string);
  }

  String _stripTrailingNewline(String string) {
    RegExp trailingNewLine = new RegExp('\n\$');
    return string.replaceFirst(trailingNewLine, '');
  }
}
