class FireStoreSchema {
  final List<Security>? rules; // global rules
  const FireStoreSchema({
    this.rules,
  });
}

class FireStoreOps {
  const FireStoreOps();
}

class collection {
  final String name;
  final bool sub;
  final List<Security>? rules; // collection rules
  const collection({required this.name, this.sub = false, this.rules});
}

class Security {
  final String? read;
  final String? match;
  final String? write;
  final String? update;
  final String? create;
  final String? get;
  final String? list;
  final String? delete;
  final String? functions;

  const Security(
      {this.read,
      this.write,
      this.update,
      this.list,
      this.match,
      this.get,
      this.create,
      this.delete,
      this.functions});
}

class collectionNestedObject {
  const collectionNestedObject();
}

// firestore ref T should be a class with @collection annotation
class FireStoreRef<T> {}
