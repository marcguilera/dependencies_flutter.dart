part of 'package:dependencies_flutter/dependencies_flutter.dart';

/// Utility mixin to easily use the injector in the [InjectorWidget].
/// This can be applied to [State] or to [StatelessWidget] classes.
abstract class InjectorWidgetMixin {
  Widget build(BuildContext context) {
    final injector = InjectorWidget.of(context);
    return buildWithInjector(context, injector);
  }

  /// Build the [Widget] with the existing [Injector].
  Widget buildWithInjector(BuildContext context, Injector injector);
}