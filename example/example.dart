import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/dependencies.dart';

class SomeRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder
            ..install(MyModule())
            ..bindSingleton("api123", name: "api_key");
        },
        child: Container(
            child: Container(
              child: SomeWidget(),
            )
        )
    );
  }
}

class MyModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(Object());
  }
}

class SomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final injector = InjectorWidget.of(context);
    final apiKey = injector.get(name: "api_key");
    print(apiKey);
    return Container();
  }
}

class SomeOtherWidget extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final object = injector.get<Object>();
    print(object);
    return Container();
  }
}

class MyBinder extends ModuleWidget {
  MyBinder({Key key, @required Widget child}): super(key: key, child: child);
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(Object());
  }
}

class YetAnotherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyBinder(
      child: Container(),
    );
  }

}