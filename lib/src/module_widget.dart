part of 'package:dependencies_flutter/dependencies_flutter.dart';

/// Utility base [Widget] to set up bindings.
abstract class ModuleWidget extends StatelessWidget implements Configurer {
  final Widget child;

  const ModuleWidget({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: configure,
      child: child,
    );
  }
}
