import 'package:json_annotation/json_annotation.dart';

class RA {
  final String? name;

  const RA({this.name});
}

@RA(name: "hello")
class RType {}
