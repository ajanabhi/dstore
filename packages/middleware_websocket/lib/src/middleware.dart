import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:dstore/dstore.dart';
import 'package:web_socket_channel_fork/web_socket_channel.dart';

enum GraphqlMessages {
  connection_init,
  connection_ack,
  connection_error,
  start,
  stop,
  ka, //CONNECTION_KEEP_ALIVE
  connection_terminate,
  data,
  error,
  complete
}

const _WebSocket_Global_Group = "_DSTORE_WEBSCOKET_GLOBAL_GROUP";

extension GraphqlMessagesExt on GraphqlMessages {
  String get name => toString().split(".").last;
}

GraphqlMessages _convertStringToGraphlMessage(String name) {
  return GraphqlMessages.values.firstWhere(
      (m) => m.toString().split(".").last == name,
      orElse: () => GraphqlMessages.complete);
}

final _clients = <String, DWebSocket>{};

abstract class WebSocketGlobalActions {
  static Action<dynamic> close(String url) {
    return Action<dynamic>(
        name: "close",
        type: _WebSocket_Global_Group,
        ws: WebSocketPayload<dynamic, dynamic, dynamic>(
            url: url, responseDeserializer: IdentityFn));
  }

  static Action<dynamic> connect(String url) {
    return Action<dynamic>(
        name: "connect",
        type: _WebSocket_Global_Group,
        ws: WebSocketPayload<dynamic, dynamic, dynamic>(
            url: url, responseDeserializer: IdentityFn));
  }
}

class DWebSocketOptions {
  final List<String>? protocols;
  final bool reconnect;
  final int reconnectTimes;
  final dynamic Function()? onOpenMessage;
  final Map<String, dynamic>? headers;
  final dynamic Function(dynamic messagePassedFromAction, String id)?
      createMessage;
  final List<dynamic> Function(dynamic data)? parseMessage;

  DWebSocketOptions(
      {this.protocols,
      this.reconnect = false,
      this.createMessage,
      this.parseMessage,
      this.headers,
      this.reconnectTimes = 0,
      this.onOpenMessage});
}

class DWebSocket {
  late final DWebSocketOptions options;
  late final Store store;
  bool isReady = false;
  var subscriptions = <Action>[];
  final queue = <Action>[];
  bool isForceClose = false;
  late final WebSocketChannel ws;
  late final bool isGraphql;
  late final String url;
  Timer? _onOpenMinitorTimer;
  int delay = 0;
  dynamic? _error;
  Timer? _reconnectedTimer;
  int receconnectedTimes = 1000;
  // DWebsocket();
  DWebSocket(
      {required String url,
      required DWebSocketOptions options,
      required Store store,
      bool isGraphql = false}) {
    // final ctor = DWebsocket();
    this.options = options;
    this.store = store;
    this.url = url;
    this.isGraphql = isGraphql;
    connect();
  }

  void connect() async {
    try {
      var protocols = isGraphql ? ["graphql-ws"] : <String>[];
      if (options.protocols != null) {
        protocols = options.protocols!;
      }
      isReady = false;
      ws = WebSocketChannel.connect(Uri.parse(url), protocols: protocols);
      ws.stream.listen(onMessage, onDone: onDone, onError: onError);
      if (ws.readyState == WebSocket.OPEN) {
        onOpen();
      } else {
        _monitorOnStart();
      }
    } catch (e) {
      cleanup(e);
    }
  }

  void _tryReconnect() {
    if (_reconnectedTimer != null && _reconnectedTimer!.isActive) {
      _reconnectedTimer!.cancel();
    }
    delay = delay * 2; //TODO exponential delay
    final duration = Duration(microseconds: delay);
    _reconnectedTimer = Timer(duration, () {
      connect();
    });
    receconnectedTimes++;
  }

  void onOpen() {
    isForceClose = false;
    receconnectedTimes = 0;
    delay = 1000;
    if (isGraphql) {
      ws.sink.add(jsonEncode({
        "type": GraphqlMessages.connection_init.name,
        "headers": options.headers
      }));
    } else {
      isReady = true;
      if (options.onOpenMessage != null) {
        ws.sink.add(options.onOpenMessage!());
      }
      _processQueue();
    }
  }

  void _processQueue() {
    if (queue.isNotEmpty) {
      queue.forEach((element) {
        handleAction(element);
      });
      queue.clear();
    }
  }

  void cleanup(dynamic error) {
    [...subscriptions, ...queue].forEach((a) {
      _dispatchActionToStore(
          a,
          WebSocketField<dynamic, dynamic, dynamic>(
              error: error, completed: true));
    });
    subscriptions.clear();
    queue.clear();
    isReady = false;
    _error = null;
  }

  void onMessage(dynamic message) {
    if (isGraphql) {
      _handleGraphqlMessage(message);
    } else {
      final dynamic data = message["data"];
      if (options.parseMessage == null) {
        throw Exception(
            "You should provide a parseMessage function which should return unique id that was passed as input to createMessage while sending");
      }
      final list = options.parseMessage!(data);
      final rData = list.first as WebSocketField;
      final id = list.last as String;
      final a = _getActionFromId(id);
      if (a != null) {
        _dispatchActionToStore(a, rData);
      }
    }
  }

  void _handleGraphqlMessage(dynamic message) {
    print("Message runtime type ${message.runtimeType}");
    final data = jsonDecode(message["data"] as String) as Map<String, dynamic>;
    final type = data["type"] as String;
    final gmType = _convertStringToGraphlMessage(type);
    switch (gmType) {
      case GraphqlMessages.connection_init:
        // TODO: Handle this case.
        break;
      case GraphqlMessages.connection_ack:
        isReady = true;
        _processQueue();
        break;
      case GraphqlMessages.connection_error:
        // This may occur:
        // 1. In response to GQL.CONNECTION_INIT
        // 2. In case of parsing errors in the client which will not disconnect.
        //TODO
        break;

      case GraphqlMessages.start:
        // TODO: Handle this case.
        break;
      case GraphqlMessages.stop:
        // TODO: Handle this case.
        break;
      case GraphqlMessages.connection_terminate:
        // TODO: Handle this case.
        break;
      case GraphqlMessages.data:
        // This message is sent after GQL.START to transfer the result of the GraphQL subscription.
        final id = data["id"] as String;
        final a = _getActionFromId(id);

        if (a != null) {
          final pError =
              data["payload"]["errors"] as List<Map<String, dynamic>>?;
          final dynamic pData = data["payload"]["data"];
          dynamic error;
          if (pError != null) {
            error = pError.map((e) => GraphqlError.fromJson(e)).toList();
          }
          dynamic rData;
          if (pData != null) {
            rData = a.ws!.responseDeserializer(pData);
          }
          _dispatchActionToStore(
              a,
              WebSocketField<dynamic, dynamic, dynamic>(
                  error: error, data: rData));
        }
        break;
      case GraphqlMessages.error:
        // This method is sent when a subscription fails. This is usually dues to validation errors
        // as resolver errors are returned in GQL.DATA messages.
        final id = data["id"] as String;
        final a = _getActionFromId(id);
        if (a != null) {
          _dispatchActionToStore(
              a,
              WebSocketField<dynamic, dynamic, dynamic>(
                  error: data["payload"]));
          //TODO do we need remove subscription from here ...
        }
        break;
      case GraphqlMessages.complete:
        // This is sent when the operation is done and no more dta will be sent.
        final ac = _getActionFromId(data["id"] as String);
        if (ac != null) {
          _dispatchActionToStore(
              ac, WebSocketField<dynamic, dynamic, dynamic>(completed: true));
          removeFromSubscriptions(ac);
        }
        break;
      case GraphqlMessages.ka:
        // This may occur:
        // 1. After GQL.CONNECTION_ACK,
        // 2. Periodically to keep the connection alive.
        break;
    }
  }

  void onDone() {
    if (isForceClose ||
        !options.reconnect ||
        (options.reconnect && options.reconnectTimes < receconnectedTimes)) {
      cleanup(_error);
    } else {
      _tryReconnect();
    }
  }

  void onError(dynamic error) {
    // on done is called after onError so do clean up there
    _error = error;
  }

  void _monitorOnStart() {
    if (_onOpenMinitorTimer != null && _onOpenMinitorTimer!.isActive) {
      return;
    }
    const timeout = Duration(milliseconds: 500);
    _onOpenMinitorTimer = Timer.periodic(timeout, (timer) {
      if (ws.readyState == WebSocket.OPEN) {
        timer.cancel();
        _onOpenMinitorTimer = null;
        onOpen();
      } else if (ws.readyState == WebSocket.CLOSING ||
          ws.readyState == WebSocket.CLOSED) {
        timer.cancel();
        _onOpenMinitorTimer = null;
      }
    });
  }

  void _dispatchActionToStore(Action action, WebSocketField data) {
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            data: data.copyWith(
                internalUnsubscribe: Optional(_getUnSunscribeFuntion(action))),
            processed: true,
            type: ActionInternalType.FIELD)));
  }

  bool removeFromSubscriptions(Action action) {
    final prevLength = subscriptions.length;
    subscriptions = subscriptions
        .where((sa) => sa.name != action.name && sa.type != action.type)
        .toList();
    return prevLength != subscriptions.length;
  }

  void handleGlobalAction(Action action) {
    if (action.name == "close") {
      isForceClose = true;
      ws.sink.close();
    } else if (action.name == "connect") {
      connect();
    }
  }

  Action? _getActionFromId(String id) {
    Action? action;
    try {
      action = subscriptions.firstWhere((element) {
        final aid = getId(element);
        return aid == id;
      });
    } catch (e) {
      // state Error , meaning no action in subscriptions list
    }

    return action;
  }

  String getId(Action a) {
    return "${a.type.hashCode}.${a.name}";
  }

  void handleUnsubscribe(Action action) {
    final isRemoved = removeFromSubscriptions(action);
    if (isRemoved) {
      final id = getId(action);
      if (isGraphql) {
        ws.sink.add(jsonEncode({"type": GraphqlMessages.stop.name, "id": id}));
      }
    }
    //TODO check if this sends a complete event.
  }

  void Function() _getUnSunscribeFuntion(Action action) {
    return () => store.dispatch(Action<dynamic>(
        name: action.name,
        type: action.type,
        ws: WebSocketPayload<dynamic, dynamic, dynamic>(
            url: url, responseDeserializer: IdentityFn, unsubscribe: true)));
  }

  void handleAction(Action<dynamic> action) {
    final wsp = action.ws!;
    if (action.type == _WebSocket_Global_Group) {
      return handleGlobalAction(action);
    } else {
      if (wsp.unsubscribe) {
        handleUnsubscribe(action);
        return;
      }
      _dispatchActionToStore(
          action, WebSocketField<dynamic, dynamic, dynamic>(loading: true));
      if (!isReady) {
        queue.add(action);
        return;
      }
      final id = getId(action);
      final sa = _getActionFromId(id);
      dynamic payload = wsp.data;
      if (wsp.inputSerializer != null) {
        payload = wsp.inputSerializer!(payload);
      }
      if (isGraphql) {
        ws.sink.add(jsonEncode(<String, dynamic>{
          "type": GraphqlMessages.start.name,
          "id": id,
          "payload": payload
        }));
      } else {
        if (options.createMessage == null) {
          throw Exception(
              "You should provide a createMessage function which takes an unique id for action and send it back in response from server");
        }

        payload = options.createMessage!(payload, id);
        ws.sink.add(payload);
      }
      if (sa == null) {
        // if already there is a subscription for that id dont add it again
        subscriptions
            .add(Action<dynamic>(name: action.name, type: action.type));
      }
    }
  }
}

// final ds =
//     DWebSocket(url: "", options: null as dynamic, store: null as dynamic);

class WebsocketMiddlewareOptions {
  final Map<String, DWebSocketOptions Function()> urlOptions;

  WebsocketMiddlewareOptions({required this.urlOptions});
}

void _processWebsocketAction(
    {required WebsocketMiddlewareOptions? options,
    required Action action,
    required Store store}) {
  final isGlobal = action.type == _WebSocket_Global_Group;
  final isGraphql = action.ws!.data is GraphqlRequestInput;
  final url = action.ws!.url;
  var client = _clients[url];
  if (client == null &&
      isGlobal &&
      (action.name == "close" || action.name == "connect")) {
    // do nothing or throw error ?
    return;
  }
  if (client == null) {
    var dwOptions = DWebSocketOptions();
    if (options != null) {
      final of = options.urlOptions[url];
      if (of != null) {
        dwOptions = of();
      }
    }
    client = DWebSocket(
        url: url, options: dwOptions, isGraphql: isGraphql, store: store);
    _clients[url] = client;
  }

  client.handleAction(action);
}

Middleware<S> createWebsocketMiddleware<S extends AppStateI<S>>(
    [WebsocketMiddlewareOptions? options]) {
  return (Store<S> store, Dispatch next, Action action) {
    if (action.isProcessed || action.ws == null) {
      return next(action);
    }
    _processWebsocketAction(options: options, store: store, action: action);
  };
}
