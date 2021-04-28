import 'package:dstore/dstore.dart';

import 'local.dart';

@GraphqlOps(api)
class _HelloDSL {
  final todo = Query()
    ..hello(alias: "ho")
    ..hello1
    ..todo(Todo()..text)
    ..todo(Todo())
    ..users(Person(), alias: "users3")
    ..users(Person()
      ..name
      ..tags
      ..hello(HelloU()..unionfrag_Hello1(Hello1()..name)));

  final s = Query()
    ..inputArgsQ(
        nameR: "n222",
        idsN: [],
        count: 3,
        percent: 3.5,
        counts: [4],
        idsN2: [],
        eR: "\$erV" as Enum1,
        input1: Input1(
            name: "input1",
            count: 3,
            counts: [2],
            d$_enum: Enum1.HIGH,
            enums: [Enum1.LOW],
            inputs: [
              Input1(name: "input2", counts: [4])
            ]));
}
