import 'package:dstore/dstore.dart';
import 'collections.dart';
import "package:json_annotation/json_annotation.dart";

part "firestore.dstore.dart";
part "firestore.g.dart";

@FireStoreSchema()
class FSchema {
  late FCollections collections;
}
