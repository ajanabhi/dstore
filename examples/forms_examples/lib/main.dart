import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:flutter/material.dart' hide FormState, FormField;
import 'package:forms_examples/store/app_state.dart';
import 'package:forms_examples/store/pstates/form_state.dart';
import 'package:forms_examples/store/selectors/app_selectors.dart';

void main() {
  runApp(FormsExample());
}

class FormsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Forms Example"),
        ),
        body: SelectorBuilder<AppState, FormState>(
          selector: AppSelectors.foromState,
          builder: (context, state) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("Simple Form"),
                SimpleDForm(ff: state.simpleForm)
              ],
            ),
          ),
        ));
  }
}

class SimpleDForm extends StatelessWidget {
  final FormField<SimpleForm> ff;

  const SimpleDForm({Key? key, required this.ff}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DForm(
      ff: ff,
      child: Column(
        children: [
          DTextField<SimpleFormKey>(name: SimpleFormKey.name),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                print("Form Value ${ff.value}");
              },
              child: Text("Submit Form"))
        ],
      ),
    );
  }
}
