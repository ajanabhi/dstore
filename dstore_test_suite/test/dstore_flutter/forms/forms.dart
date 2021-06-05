import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_test_suite/src/store/app_state.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_form_ps.dart';
import 'package:dstore_test_suite/src/widgets/simple_form_widget.dart';
import 'package:dstore_test_suite/src/widgets/store_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("flutter forms", () {
    testWidgets("should handle forms", (tester) async {
      await tester.pumpWidget(StoreWrapper(child: SimpleFormWidget()));
      await tester.pumpAndSettle();
      expect(find.byKey(SimpleFormWidget.nameKey), findsOneWidget);
      expect(find.text("name"), findsOneWidget);
      await tester.enterText(find.byKey(SimpleFormWidget.nameKey), "name2");
      expect(find.text("name2"), findsOneWidget);
      expect(store.state.simpleFormPS.simpleForm.value.name, "name2");
    });
  });
}
