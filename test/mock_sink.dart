import 'dart:io';
import 'package:mock/mock.dart';

class MockSink extends Mock implements Stdout {
  noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}