import 'package:dstore/dstore.dart';
import 'package:firestore_todos/src/schema/firestore.dart';

@FireStoreOps()
class FOps {
  final mRating = FireStoreQuery().movies_Movie()
    ..orderBy_year(descending: true);
}
