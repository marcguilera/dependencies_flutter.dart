part of 'package:dependencies_flutter/dependencies_flutter.dart';

/// A function used to add the bindings to an [Injector].
typedef void BindFunc(Binder binder);

/// [InheritedWidget] containing an [Injector].
class InjectorWidget extends InheritedWidget {
  final Injector _injector;

  const InjectorWidget._internal(
      {@required Injector injector, Key key, @required Widget child})
      : this._injector = injector,
        super(key: key, child: child);

  /// Creates an [InjectorWidget] based on an [Injector].
  factory InjectorWidget({
    Key key,
    @required Injector injector,
    @required Widget child,
  }) {
    checkNotNull(injector, message: () => "injector can't be null");
    checkNotNull(child, message: () => "child can't be null");

    return InjectorWidget._internal(injector: injector, key: key, child: child);
  }

  /// Creates an [InjectorWidget] based on a [BinderFunc].
  factory InjectorWidget.bind(
      {Key key,
      @required BindFunc binderFunc,
      String name,
      bool enableOverriding,
      @required Widget child}) {
    checkNotNull(binderFunc, message: () => "binder can't be null");
    checkNotNull(child, message: () => "child can't be null");

    final builder = Injector.builder();
    if (name != null) builder.setName(name);
    if (enableOverriding == true) builder.enableOverriding();
    binderFunc(builder);
    final injector = builder.build();

    return InjectorWidget._internal(injector: injector, key: key, child: child);
  }

  @override
  bool updateShouldNotify(InjectorWidget oldWidget) {
    return oldWidget._injector != _injector;
  }

  /// Gets an [Injector] from the [BuildContext].
  static Injector of(BuildContext context) {
    InjectorWidget w = context.inheritFromWidgetOfExactType(InjectorWidget);
    if (w == null) {
      throw InjectorWidgetError._internal(
          "No `InjectorWidget` was found in the context.");
    }
    return w._injector;
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
