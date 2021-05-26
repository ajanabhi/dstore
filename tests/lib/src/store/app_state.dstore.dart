// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'app_state.dart';

// **************************************************************************
// AppStateGenerator
// **************************************************************************

class AppState implements AppStateI<AppState> {
  late final Simple simple;
  late final SimpleAsync simpleAsync;
  late final SimpleHistory simpleHistory;
  @override
  AppState copyWithMap(Map<String, dynamic> map) => AppState()
    ..simple = map.containsKey('simple') ? map['simple'] as Simple : this.simple
    ..simpleAsync = map.containsKey('simpleAsync')
        ? map['simpleAsync'] as SimpleAsync
        : this.simpleAsync
    ..simpleHistory = map.containsKey('simpleHistory')
        ? map['simpleHistory'] as SimpleHistory
        : this.simpleHistory;
  @override
  Map<String, PStateModel<dynamic>> toMap() => <String, PStateModel<dynamic>>{
        "simple": this.simple,
        "simpleAsync": this.simpleAsync,
        "simpleHistory": this.simpleHistory
      };
}

Store<AppState> createStore(
    {required StoreErrorHandle handleError,
    List<Middleware<AppState>>? middlewares,
    StorageOptions? storageOptions,
    NetworkOptions? networkOptions,
    bool useEqualsComparision = false}) {
  return Store<AppState>(
      internalMeta: <String, PStateMeta>{
        "simple": SimpleMeta,
        "simpleAsync": SimpleAsyncMeta,
        "simpleHistory": SimpleHistoryMeta
      },
      stateCreator: () => AppState(),
      appVersion: '1.0.0',
      networkOptions: networkOptions,
      middlewares: middlewares,
      handleError: handleError,
      storageOptions: storageOptions,
      useEqualsComparision: useEqualsComparision);
}
