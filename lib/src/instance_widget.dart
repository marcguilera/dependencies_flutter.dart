part of 'package:dependencies_flutter/dependencies_flutter.dart';

/// Builder to construct a [Widget] for the given [Injector].
typedef Widget InjectorBuilder(Injector injector);

/// Widget able to build it's child from the [Injector] in the
/// current [BuildContext].
class WithInjectorWidget extends StatelessWidget with InjectorWidgetMixin {
  final InjectorBuilder builder;

  const WithInjectorWidget._internal({Key key, this.builder}) : super(key: key);

  factory WithInjectorWidget({Key key, InjectorBuilder builder}) {
    checkNotNull(builder, message: () => "builder can't be null");
    return WithInjectorWidget._internal(
      key: key,
      builder: builder,
    );
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return builder(injector);
  }
}

/// Builder to construct a [Widget] for the given instance of type [T]
typedef Widget InstanceBuilder<T>(T instance);

/// Widget able to build it's child from the instance found in the [Injector]
/// in the current [BuildContext].
class WithInstanceWidget<T> extends StatelessWidget {
  final InstanceBuilder builder;
  final String name;
  final Params params;

  const WithInstanceWidget._internal({
    Key key,
    this.builder,
    this.name,
    this.params,
  }) : super(key: key);

  factory WithInstanceWidget(
      {Key key, InstanceBuilder builder, String name, Params params}) {
    checkNotNull(builder, message: () => "builder can't be null");
    return WithInstanceWidget._internal(
      key: key,
      builder: builder,
      name: name,
      params: params,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WithInjectorWidget(builder: (injector) {
      final instance = injector.get<T>(name: name, params: params);
      return builder(instance);
    });
  }
}
