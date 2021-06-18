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
  late final SimplePersist simplePersist;
  late final SimplePersist2 simplePersist2;
  late final SimplePersist3 simplePersist3;
  late final SimplePersitanceMigrator simplePersitanceMigrator;
  late final SimpleHttp simpleHttp;
  late final SimpleWebsocket simpleWebsocket;
  late final SimpleStreamPS streamPS;
  late final SimpleFlutterSelectors simpleFlutterSelector;
  late final SimpleSelectorPS simpleSelectorPS;
  late final SimpleFormPS simpleFormPS;
  late final SimpleNavPS simpleNavPS;
  late final dynamic booksNav;
  late final dynamic settingsNav;
  late final dynamic tabsNested;
  late final dynamic tabsNested_Nested;
  @override
  AppState copyWithMap(Map<String, dynamic> map) => AppState()
    ..simple = map.containsKey('simple') ? map['simple'] as Simple : this.simple
    ..simpleAsync = map.containsKey('simpleAsync')
        ? map['simpleAsync'] as SimpleAsync
        : this.simpleAsync
    ..simpleHistory = map.containsKey('simpleHistory')
        ? map['simpleHistory'] as SimpleHistory
        : this.simpleHistory
    ..simplePersist = map.containsKey('simplePersist')
        ? map['simplePersist'] as SimplePersist
        : this.simplePersist
    ..simplePersist2 = map.containsKey('simplePersist2')
        ? map['simplePersist2'] as SimplePersist2
        : this.simplePersist2
    ..simplePersist3 = map.containsKey('simplePersist3')
        ? map['simplePersist3'] as SimplePersist3
        : this.simplePersist3
    ..simplePersitanceMigrator = map.containsKey('simplePersitanceMigrator')
        ? map['simplePersitanceMigrator'] as SimplePersitanceMigrator
        : this.simplePersitanceMigrator
    ..simpleHttp = map.containsKey('simpleHttp')
        ? map['simpleHttp'] as SimpleHttp
        : this.simpleHttp
    ..simpleWebsocket = map.containsKey('simpleWebsocket')
        ? map['simpleWebsocket'] as SimpleWebsocket
        : this.simpleWebsocket
    ..streamPS = map.containsKey('streamPS')
        ? map['streamPS'] as SimpleStreamPS
        : this.streamPS
    ..simpleFlutterSelector = map.containsKey('simpleFlutterSelector')
        ? map['simpleFlutterSelector'] as SimpleFlutterSelectors
        : this.simpleFlutterSelector
    ..simpleSelectorPS = map.containsKey('simpleSelectorPS')
        ? map['simpleSelectorPS'] as SimpleSelectorPS
        : this.simpleSelectorPS
    ..simpleFormPS = map.containsKey('simpleFormPS')
        ? map['simpleFormPS'] as SimpleFormPS
        : this.simpleFormPS
    ..simpleNavPS = map.containsKey('simpleNavPS')
        ? map['simpleNavPS'] as SimpleNavPS
        : this.simpleNavPS
    ..booksNav =
        map.containsKey('booksNav') ? map['booksNav'] as dynamic : this.booksNav
    ..settingsNav = map.containsKey('settingsNav')
        ? map['settingsNav'] as dynamic
        : this.settingsNav
    ..tabsNested = map.containsKey('tabsNested')
        ? map['tabsNested'] as dynamic
        : this.tabsNested
    ..tabsNested_Nested = map.containsKey('tabsNested_Nested')
        ? map['tabsNested_Nested'] as dynamic
        : this.tabsNested_Nested;
  @override
  Map<String, PStateModel<dynamic>> toMap() => <String, PStateModel<dynamic>>{
        "simple": this.simple,
        "simpleAsync": this.simpleAsync,
        "simpleHistory": this.simpleHistory,
        "simplePersist": this.simplePersist,
        "simplePersist2": this.simplePersist2,
        "simplePersist3": this.simplePersist3,
        "simplePersitanceMigrator": this.simplePersitanceMigrator,
        "simpleHttp": this.simpleHttp,
        "simpleWebsocket": this.simpleWebsocket,
        "streamPS": this.streamPS,
        "simpleFlutterSelector": this.simpleFlutterSelector,
        "simpleSelectorPS": this.simpleSelectorPS,
        "simpleFormPS": this.simpleFormPS,
        "simpleNavPS": this.simpleNavPS,
        "booksNav": this.booksNav,
        "settingsNav": this.settingsNav,
        "tabsNested": this.tabsNested,
        "tabsNested_Nested": this.tabsNested_Nested
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
        "simpleHistory": SimpleHistoryMeta,
        "simplePersist": SimplePersistMeta,
        "simplePersist2": SimplePersist2Meta,
        "simplePersist3": SimplePersist3Meta,
        "simplePersitanceMigrator": SimplePersitanceMigratorMeta,
        "simpleHttp": SimpleHttpMeta,
        "simpleWebsocket": SimpleWebsocketMeta,
        "streamPS": SimpleStreamPSMeta,
        "simpleFlutterSelector": SimpleFlutterSelectorsMeta,
        "simpleSelectorPS": SimpleSelectorPSMeta,
        "simpleFormPS": SimpleFormPSMeta,
        "simpleNavPS": SimpleNavPSMeta,
        "booksNav": dynamicMeta,
        "settingsNav": dynamicMeta,
        "tabsNested": dynamicMeta,
        "tabsNested_Nested": dynamicMeta
      },
      stateCreator: () => AppState(),
      appVersion: '1.0.0',
      networkOptions: networkOptions,
      middlewares: middlewares,
      handleError: handleError,
      storageOptions: storageOptions,
      useEqualsComparision: useEqualsComparision);
}
