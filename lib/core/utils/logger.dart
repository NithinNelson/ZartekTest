
import 'package:flutter/foundation.dart';

void printDebug(dynamic text) {
  if (kDebugMode) {
    print("$text");
  }
}