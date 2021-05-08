class FireStoreSchema {
  final List<Security>? rules; // global rules
  final String rulesPath;
  const FireStoreSchema({
    this.rules,
    required this.rulesPath,
  });
}

class FireStoreOps {
  const FireStoreOps();
}

class DefautSecurityFunctions {
  final bool addContainsRequiredFieldsFn;
  final bool addHasAllAttributesFn;

  DefautSecurityFunctions(
      {this.addContainsRequiredFieldsFn = false,
      this.addHasAllAttributesFn = false});
}

// Rules Doc : https://firebase.google.com/docs/reference/rules
// functions exist ,
abstract class GlobalSecurityOrValidationFunctions {
  static const _DB_PREFIX = "/databases/\$(database)/documents/";

  static const _incomingData = "request.resource.data";

  static const _auth = "request.auth";
  static const _authToken = "$_auth.token";

  static const hasOnlyProps = "hasOnlyProps";

  // useful when you want to check incoming request constains all props of model
  static const hasOnlyPropsFn = """
    function hasOnlyProps(props) {
      return $_incomingData.keys.hasOnly(props);
    }
  """;

  static const hasAllProps = "hasAllProps";

  // useful when you want to make sure all required fields present in incoming request
  static const hasAllPropsFn = """
    function hasAllProps(props) {
      return $_incomingData.keys.hasAll(props);
    }
  """;

  static const isLoggedIn = "isLoggedIn";

  static const isLoggedInFn = """
    function isLoggedIn() {
      return request.auth != null;
    }
  """;

  static const authEmailVerified = "authEmailVerified";

  static const authEmailVerifiedFn = """
    function authEmailVerified() {
      return $_authToken.email_verified;
    }
  """;

  //TODO test this collection should be escaped or not
  static const userExistsInCollection = """
    function userExistsInCollection(collection) {
      return exists(${_DB_PREFIX}collection/\$(request.auth.uid));
    }
  """;

  // static const
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
