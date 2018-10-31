part of 'package:dependencies_flutter/dependencies_flutter.dart';

/// [InheritedWidget] containing an [Injector].
class InjectorWidget extends InheritedWidget {
  final Injector injector;

  const InjectorWidget._internal(
      {@required this.injector, Key key, @required Widget child})
      : super(key: key, child: child);

  /// Creates an [InjectorWidget] based on an [Injector].
  factory InjectorWidget({
    Key key,
    @required Injector injector,
    @required Widget child,
  }) {
    checkNotNull(injector, message: () => "injector can't be null");
    checkNotNull(child, message: () => "child can't be null");

    return InjectorWidget._internal(key: key, injector: injector, child: child);
  }

  /// Creates an [InjectorWidget] based on a [BinderFunc].
  factory InjectorWidget.bind(
      {Key key, @required BindFunc bindFunc, @required Widget child}) {
    checkNotNull(bindFunc, message: () => "binder can't be null");
    checkNotNull(child, message: () => "child can't be null");

    final builder = Injector.builder();
    bindFunc(builder);
    final injector = builder.build();

    return InjectorWidget._internal(key: key, injector: injector, child: child);
  }

  @override
  bool updateShouldNotify(InjectorWidget oldWidget) {
    return oldWidget.injector != injector;
  }

  /// Gets an [Injector] from the [BuildContext].
  static Injector of(BuildContext context) {
    InjectorWidget w = context.inheritFromWidgetOfExactType(InjectorWidget);
    if (w == null) {
      throw InjectorWidgetError._internal(
          "No `InjectorWidget` was found in the context.");
    }
    return w.injector;
  }
}

/// Thrown when the [InjectorWidget] is not present.
class InjectorWidgetError extends StateError {
  InjectorWidgetError._internal(String message) : super(message);
  @override
  String toString() {
    return 'InjectorWidgetError: $message';
  }
}
