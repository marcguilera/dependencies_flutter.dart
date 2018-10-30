part of 'package:dependencies_flutter/dependencies_flutter.dart';

/// Utility base [Widget] to set up bindings.
abstract class BindingInjectorWidget extends StatelessWidget {
  final Widget child;
  const BindingInjectorWidget({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      binderFunc: configure,
      child: child,
    );
  }

  /// Create all the [Injector] bindings.
  void configure(Binder binder);
}
