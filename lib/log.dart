part of logfmt;

/**
 * Logs a [Map] to [Stdout] as a logfmt-style key=value pair, followed by a new
 * line.
 *
 * Example:
 *
 *     logfmt.log({ 'key': 'value' }); // 'key=value\n' is logged.
 *     logfmt.log({ 'key': 'value' }, sink: sink); // The log is written to `sink`.
 */
void log(Map<String, dynamic> map, {StringSink sink}) {
  if (sink == null) sink = stdout;
  sink.write('${encode(map)}\n');
}