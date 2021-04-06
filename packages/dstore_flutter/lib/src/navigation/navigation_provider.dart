import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart';

class NavigationProvider extends InheritedWidget {
  final History history;

  NavigationProvider({required this.history, Key? key, required Widget child})
      : super(key: key, child: child);
  @override
  bool updateShouldNotify(NavigationProvider oldWidget) {
    return oldWidget.history != history;
  }

  static NavigationProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NavigationProvider>()!;
  }
}

extension BuildContextNavigationProviderExt on BuildContext {
  NavigationProvider get dnavigation => NavigationProvider.of(this);
}
