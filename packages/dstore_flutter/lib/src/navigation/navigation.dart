import 'package:flutter/material.dart';
import "configuration/confiure_native.dart"
    if (dart.library.html) "configuration/configure_web.dart";

void configureNav() {
  configurePlatForm();
}
