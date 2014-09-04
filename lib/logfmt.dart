/**
 * Functionality for interacting with [logfmt](https://brandur.org/logfmt)-style
 * log lines.
 *
 * logfmt-style log lines are space-separated key/value pairs such as:
 *
 *     method=GET path=/account elapsed=20ms
 *
 * This package provides functionality for encoding [Map]s into this format,
 * decoding [String]s of this format into [Map]s, and interacting with streams,
 * among other convenient things like writing logfmt-style logs to standard out.
 */
library logfmt;

import 'dart:async';
import 'dart:io';

part 'decode.dart';
part 'encode.dart';
part 'log.dart';
part 'stream_decoder.dart';
part 'stream_encoder.dart';

Function _log = log;

/**
 * An object with an internal timer that can be used to log to standard out or a
 * given [StringSink].
 *
 */
class Logger {
  /// The time this logger was created.
  final DateTime startTime = new DateTime.now();

  /// The key used to indicate elapsed time.
  String elapsedKey = 'elapsed';

  /// The [StringSink] to write to.
  StringSink sink = stdout;

  /**
   * Create a new [Logger].
   *
   * Example:
   *
   *     Logger logger = new Logger();
   *
   * It can be passed a [sink] argument to write to somewhere other than
   * standard out, and an [elapsedKey] argument to use a key other than
   * "elapsed" when calling [logWithElapsed].
   */
  Logger({this.sink, this.elapsedKey});

  /**
   * Log the given [Map] to this logger's [sink].
   *
   * Example:
   *
   *     logger.log({ 'key': 'value' }); // Logs "key=value"
   */
  void log(Map<String, dynamic> map) {
    return _log(map, sink: sink);
  }

  /**
   * Logs the given [Map] to this logger's [sink] and adds to the map the
   * duration, in milliseconds, that has elapsed since this logger was created.
   *
   * The key used to indicate elapsed time will be the value of [elapsedKey].
   *
   * Example:
   *
   *     logger.logWithTime({ 'key': 'value' }); // Logs "key=value elapsed=0ms"
   *
   *     // 15ms Later...
   *
   *     logger.logWithTime({ 'key': 'value' }); // Logs "key=value elapsed=15ms"
   */
  void logWithElapsed(Map<String, dynamic> map) {
    Map<String, dynamic> mapCopy = new Map<String, dynamic>();

    map.forEach((String key, dynamic value) {
      mapCopy[key] = value;
    });

    mapCopy[elapsedKey] = '${elapsed.inMilliseconds}ms';
    return log(mapCopy);
  }

  /// The time that has elapsed since this logger was created.
  Duration get elapsed {
    return new DateTime.now().difference(startTime);
  }
}
