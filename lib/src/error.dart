part of 'package:dependencies_flutter/dependencies_flutter.dart';

/// Thrown when the [InjectorWidget] is not present.
class InjectorWidgetError extends StateError {
  InjectorWidgetError._internal(String message) : super(message);
  @override
  String toString() {
    return 'InjectorWidgetError: $message';
  }
}
