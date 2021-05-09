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

abstract class GlobalSecurityOrValidationFunctionsMeta {
  static const auth = "request.auth";
  static const authToken = "request.auth.token";
  static const incomingData = "request.resource.data";
  static const hasOnlyPropsFunctionName = "hasOnlyProps";
  static const hasAllPropsFunctionName = "hasAllProps";
  static const hasOnlyPropsInline = "$incomingData.keys.hasOnly";
  static const hasAllPropsInline = "$incomingData.keys.hasAllProps";
  static const isLoggedInFunctionName = "isLoggedIn";
  static const isLoggedInInline = "$auth != null";
  static const authEmailVerifiedFunctionName = "authEmailVerified";
  static const authEmailVerfiedInline = "$authToken.email_verified";
}

// Rules Doc : https://firebase.google.com/docs/reference/rules
// functions exist ,
abstract class GlobalSecurityOrValidationFunctions {
  static const _DB_PREFIX = "/databases/\$(database)/documents/";

  static const _incomingData =
      GlobalSecurityOrValidationFunctionsMeta.incomingData;

  static const _auth = GlobalSecurityOrValidationFunctionsMeta.auth;
  static const _authToken = "$_auth.token";

  // useful when you want to check incoming request constains all props of model
  static const hasOnlyProps = """
    function ${GlobalSecurityOrValidationFunctionsMeta.hasOnlyPropsFunctionName}(props) {
      return $_incomingData.keys.hasOnly(props);
    }
  """;

  // useful when you want to make sure all required fields present in incoming request
  static const hasAllProps = """
    function ${GlobalSecurityOrValidationFunctionsMeta.hasAllPropsFunctionName}(props) {
      return $_incomingData.keys.hasAll(props);
    }
  """;

  static const isLoggedIn = """
    function ${GlobalSecurityOrValidationFunctionsMeta.isLoggedInFunctionName}() {
      return request.auth != null;
    }
  """;

  static const authEmailVerified = """
    function ${GlobalSecurityOrValidationFunctionsMeta.authEmailVerifiedFunctionName}() {
      return $_authToken.email_verified;
    }
  """;

  //TODO test this collection should be escaped or not
  static const userExistsInCollection = """
    function userExistsInCollection(collection) {
      return exists(${_DB_PREFIX}collection/\$(request.auth.uid));
    }
  """;
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
