// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class Auth extends PStateModel<Auth> {
  final bool loggedout;

  final StreamField<User?> user;

  final dynamic userDetails;

  final AsyncActionField getUserDetails;

  final AsyncActionField signout;

  _$AuthCopyWith<Auth> get copyWith =>
      __$AuthCopyWithImpl<Auth>(this, IdentityFn);

  Auth(
      {this.loggedout = false,
      this.user = const StreamField(),
      this.userDetails = null,
      this.getUserDetails = const AsyncActionField(),
      this.signout = const AsyncActionField()});

  @override
  Auth copyWithMap(Map<String, dynamic> map) => Auth(
      loggedout: map.containsKey("loggedout")
          ? map["loggedout"] as bool
          : this.loggedout,
      user: map.containsKey("user")
          ? map["user"] as StreamField<User?>
          : this.user,
      userDetails: map.containsKey("userDetails")
          ? map["userDetails"] as dynamic
          : this.userDetails,
      getUserDetails: map.containsKey("getUserDetails")
          ? map["getUserDetails"] as AsyncActionField
          : this.getUserDetails,
      signout: map.containsKey("signout")
          ? map["signout"] as AsyncActionField
          : this.signout);

  Map<String, dynamic> toMap() => <String, dynamic>{
        "loggedout": this.loggedout,
        "user": this.user,
        "userDetails": this.userDetails,
        "getUserDetails": this.getUserDetails,
        "signout": this.signout
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Auth &&
        o.loggedout == loggedout &&
        o.user == user &&
        o.userDetails == userDetails &&
        o.getUserDetails == getUserDetails &&
        o.signout == signout;
  }

  @override
  int get hashCode =>
      loggedout.hashCode ^
      user.hashCode ^
      userDetails.hashCode ^
      getUserDetails.hashCode ^
      signout.hashCode;

  @override
  String toString() =>
      "Auth(loggedout: ${this.loggedout}, user: ${this.user}, userDetails: ${this.userDetails}, getUserDetails: ${this.getUserDetails}, signout: ${this.signout})";
}

abstract class $AuthCopyWith<O> {
  factory $AuthCopyWith(Auth value, O Function(Auth) then) =
      _$AuthCopyWithImpl<O>;
  O call(
      {bool loggedout,
      StreamField<User?> user,
      dynamic userDetails,
      AsyncActionField getUserDetails,
      AsyncActionField signout});
}

class _$AuthCopyWithImpl<O> implements $AuthCopyWith<O> {
  final Auth _value;
  final O Function(Auth) _then;
  _$AuthCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? loggedout = dimmutable,
      Object? user = dimmutable,
      Object? userDetails = dimmutable,
      Object? getUserDetails = dimmutable,
      Object? signout = dimmutable}) {
    return _then(_value.copyWith(
        loggedout:
            loggedout == dimmutable ? _value.loggedout : loggedout as bool,
        user: user == dimmutable ? _value.user : user as StreamField<User?>,
        userDetails: userDetails == dimmutable
            ? _value.userDetails
            : userDetails as dynamic,
        getUserDetails: getUserDetails == dimmutable
            ? _value.getUserDetails
            : getUserDetails as AsyncActionField,
        signout: signout == dimmutable
            ? _value.signout
            : signout as AsyncActionField));
  }
}

abstract class _$AuthCopyWith<O> implements $AuthCopyWith<O> {
  factory _$AuthCopyWith(Auth value, O Function(Auth) then) =
      __$AuthCopyWithImpl<O>;
  O call(
      {bool loggedout,
      StreamField<User?> user,
      dynamic userDetails,
      AsyncActionField getUserDetails,
      AsyncActionField signout});
}

class __$AuthCopyWithImpl<O> extends _$AuthCopyWithImpl<O>
    implements _$AuthCopyWith<O> {
  __$AuthCopyWithImpl(Auth _value, O Function(Auth) _then)
      : super(_value, (v) => _then(v));

  @override
  Auth get _value => super._value;

  @override
  O call(
      {Object? loggedout = dimmutable,
      Object? user = dimmutable,
      Object? userDetails = dimmutable,
      Object? getUserDetails = dimmutable,
      Object? signout = dimmutable}) {
    return _then(Auth(
        loggedout:
            loggedout == dimmutable ? _value.loggedout : loggedout as bool,
        user: user == dimmutable ? _value.user : user as StreamField<User?>,
        userDetails: userDetails == dimmutable
            ? _value.userDetails
            : userDetails as dynamic,
        getUserDetails: getUserDetails == dimmutable
            ? _value.getUserDetails
            : getUserDetails as AsyncActionField,
        signout: signout == dimmutable
            ? _value.signout
            : signout as AsyncActionField));
  }
}

const _Auth_FullPath = "/store/pstates/auth/Auth";

class AuthGetUserDetailsResult implements ToMap {
  final dynamic? userDetails;

  const AuthGetUserDetailsResult({this.userDetails});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (userDetails != null) {
      map["userDetails"] = userDetails;
    }

    return map;
  }
}

class AuthSignoutResult implements ToMap {
  final bool? loggedout;

  const AuthSignoutResult({this.loggedout});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (loggedout != null) {
      map["loggedout"] = loggedout;
    }

    return map;
  }
}

abstract class AuthActions {
  static Action<AuthGetUserDetailsResult> getUserDetails(
      {Duration? debounce, AuthGetUserDetailsResult? mock}) {
    return Action<AuthGetUserDetailsResult>(
        name: "getUserDetails",
        type: _Auth_FullPath,
        mock: mock,
        isAsync: true,
        debounce: debounce);
  }

  static Action<AuthSignoutResult> signout(
      {Duration? debounce, AuthSignoutResult? mock}) {
    return Action<AuthSignoutResult>(
        name: "signout",
        type: _Auth_FullPath,
        mock: mock,
        isAsync: true,
        debounce: debounce);
  }

  static Action<Iterable<User?>> user(
      {required Stream<User?> stream,
      bool cancelOnError = false,
      Iterable<User?>? mock}) {
    return Action<Iterable<User?>>(
        name: "user",
        type: _Auth_FullPath,
        mock: mock,
        stream: StreamPayload(stream: stream, cancelOnError: cancelOnError));
  }
}

Future<dynamic> Auth_AsyncReducer(
    dynamic _DStoreState, Action _DstoreAction) async {
  _DStoreState = _DStoreState as Auth;
  final name = _DstoreAction.name;
  switch (name) {
    case "getUserDetails":
      {
        var _DStore_userDetails = _DStoreState.userDetails;
        final documentSnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(_DStoreState.user.data!.uid)
            .collection("account")
            .doc("details")
            .get();
        _DStore_userDetails = documentSnapshot;
        return _DStoreState.copyWith(userDetails: _DStore_userDetails);
      }

    case "signout":
      {
        var _DStore_loggedout = _DStoreState.loggedout;
        await FirebaseAuth.instance.signOut();
        _DStore_loggedout = true;
        return _DStoreState.copyWith(loggedout: _DStore_loggedout);
      }

    default:
      {
        return _DStoreState;
      }
  }
}

Auth Auth_DS() => Auth(
    loggedout: false,
    user: StreamField(),
    userDetails: null,
    getUserDetails: AsyncActionField(),
    signout: AsyncActionField());

final AuthMeta = PStateMeta<Auth>(
    type: _Auth_FullPath, aReducer: Auth_AsyncReducer, ds: Auth_DS);
