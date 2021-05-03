import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:flutter/src/widgets/navigator.dart';
part 'nav.ps.dstore.dart';

@PState(nav: true)
class $_NavState extends NavStateI<dynamic> {
  @override
  List<Page> buildPages() {
    return [];
  }

  @Url("/")
  void home() {}
}
