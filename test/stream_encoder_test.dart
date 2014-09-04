library logfmt.stream_encoder_test;

import 'dart:async';
import 'dart:io';
import 'package:logfmt/logfmt.dart' as logfmt;
import 'package:path/path.dart' as path;
import 'package:unittest/unittest.dart';

void main() {
  group('streamEncoder', () {
    test('encodes a stream of Map<String, dynamic>s into a stream of logfmt-style strings', () {
        var lines = new List<String>();

        List<Map<String, String>> maps = [{
          'at': 'info',
          'method': 'GET',
          'path': '/',
          'host': 'jclem-net.herokuapp.com',
          'request_id': '4853b193-0685-470e-b9a2-c348f21c63d2',
          'fwd': '24.184.80.231',
          'dyno': 'web.1',
          'connect': '2ms',
          'service': '1141ms',
          'status': '200',
          'bytes': '725'
        }, {
          'at': 'info',
          'method': 'GET',
          'path': '/assets/application-fa92a0f794e35ceb3ab891e4bf40e8c2.css',
          'host': 'jclem-net.herokuapp.com',
          'request_id': '4fab2f1e-e3bc-4fec-a7af-2251575a2dac',
          'fwd': '199.27.76.24',
          'dyno': 'web.1',
          'connect': '2ms',
          'service': '6ms',
          'status': '200',
          'bytes': '845'
        }, {
          'at': 'info',
          'method': 'GET',
          'path': '/assets/application-ca1f633f10671f8d5b745867f97a5a47.js',
          'host': 'jclem-net.herokuapp.com',
          'request_id': '75b03c04-87cd-449e-8324-8ae73cc4323b',
          'fwd': '199.27.76.24',
          'dyno': 'web.1',
          'connect': '1ms',
          'service': '5ms',
          'status': '200',
          'bytes': '828'
        }, {
          'source': 'web.1',
          'dyno': 'heroku.21556428.d8379cf2-8719-41f8-a9d8-d8170d673f24',
          'sample#memory_total': '100.92MB',
          'sample#memory_rss': '97.46MB',
          'sample#memory_cache': '3.46MB',
          'sample#memory_swap': '0.00MB',
          'sample#memory_pgpgin': '31190pages',
          'sample#memory_pgpgout': '5355pages'
        }];

        Function callback = expectAsync(() {
          expect([
            'at=info method=GET path=/ host=jclem-net.herokuapp.com request_id=4853b193-0685-470e-b9a2-c348f21c63d2 fwd=24.184.80.231 dyno=web.1 connect=2ms service=1141ms status=200 bytes=725',
            'at=info method=GET path=/assets/application-fa92a0f794e35ceb3ab891e4bf40e8c2.css host=jclem-net.herokuapp.com request_id=4fab2f1e-e3bc-4fec-a7af-2251575a2dac fwd=199.27.76.24 dyno=web.1 connect=2ms service=6ms status=200 bytes=845',
            'at=info method=GET path=/assets/application-ca1f633f10671f8d5b745867f97a5a47.js host=jclem-net.herokuapp.com request_id=75b03c04-87cd-449e-8324-8ae73cc4323b fwd=199.27.76.24 dyno=web.1 connect=1ms service=5ms status=200 bytes=828',
            'source=web.1 dyno=heroku.21556428.d8379cf2-8719-41f8-a9d8-d8170d673f24 sample#memory_total=100.92MB sample#memory_rss=97.46MB sample#memory_cache=3.46MB sample#memory_swap=0.00MB sample#memory_pgpgin=31190pages sample#memory_pgpgout=5355pages'
          ], equals(lines));
        });

        new Stream.fromIterable(maps)
          .transform(logfmt.streamEncoder())
          .listen((String line) {
            lines.add(line);
          }, onDone: callback);
      });
  });
}