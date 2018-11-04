part of 'package:dependencies_flutter/dependencies_flutter.dart';

/// A way to get an [Injector] from a context.
abstract class FlutterInjector {
  FlutterInjector._internal();

  /// Gets an [Injector] from a ]BuildContext]
  static Injector of(BuildContext context) {
    final w = context.inheritFromWidgetOfExactType(_InjectorInheritedWidget);
    if (w == null) {
      throw InjectorWidgetError._internal(
          "No `InjectorWidget` was found in the context.");
    }
    final injectorWidget = w as _InjectorInheritedWidget;
    return injectorWidget.injector;
  }
}
