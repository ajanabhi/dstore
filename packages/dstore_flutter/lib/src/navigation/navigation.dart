import 'package:flutter/material.dart';
import "configuration/confiure_native.dart"
    if (dart.library.html) "configuration/configure_web.dart";

abstract class NavStateI {
  List<Page> buildPages();
}

void configureNav() {
  configurePlatForm();
}
