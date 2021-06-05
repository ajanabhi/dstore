import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_test_suite/src/store/app_state.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_form_ps.dart';
import 'package:dstore_test_suite/src/store/selectors/app_selectors.dart';
import 'package:flutter/material.dart';

class SimpleFormWidget extends StatelessWidget {
  static final nameKey = ValueKey("simpleform_name");
  const SimpleFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectorBuilder<AppState, SimpleFormPS>(
      selector: AppSelectors.simpleForm,
      builder: (context, state) {
        return DForm(
            ff: state.simpleForm,
            child: Builder(
              builder: (context) {
                return ListView(
                  children: [
                    DTextField(key: nameKey, name: SimpleFormKey.name)
                  ],
                );
              },
            ));
      },
    );
  }
}
