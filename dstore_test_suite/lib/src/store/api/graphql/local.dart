import 'package:dstore/dstore.dart';

part "local.api.dstore.dart";
part "local.g.dart";

const localAPi =
    GraphqlApi(apiUrl: "http://localhost:4000/graphql", revison: "0.13.2");

@localAPi
class LocalGraphqlApi {}
