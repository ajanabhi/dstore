class FireStoreSchema {
  const FireStoreSchema();
}

class FireStoreOps {
  const FireStoreOps();
}

class collection {
  final String name;
  final bool sub;
  const collection({required this.name, this.sub = false});
}

class collectionNestedObject {
  const collectionNestedObject();
}

// firestore ref T should be a class with @collection annotation
class FireStoreRef<T> {}
