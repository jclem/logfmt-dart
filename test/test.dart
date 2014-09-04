import 'decode_test.dart' as decodeTest;
import 'encode_test.dart' as encodeTest;
import 'log_test.dart' as logTest;
import 'logger_test.dart' as loggerTest;
import 'stream_decoder_test.dart' as streamDecoderTest;
import 'stream_encoder_test.dart' as streamEncoderTest;

void main() {
  decodeTest.main();
  encodeTest.main();
  logTest.main();
  loggerTest.main();
  streamDecoderTest.main();
  streamEncoderTest.main();
}
