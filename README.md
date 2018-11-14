[![pub package](https://img.shields.io/pub/v/dependencies_flutter.svg)](https://pub.dartlang.org/packages/dependencies_flutter)


Simple package to ease the use of the [dependencies](https://pub.dartlang.org/packages/dependencies) with Flutter
leveraging the power of `InheritedWidget`. 

## Usage

```dart
class SomeRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder
          ..install(MyModule())
          ..bindSingleton("api123", name: "api_key");
      },
      child: SomeWidget()
    );
  }
}
```

You can also extend `BindingInjectorWidget` to configure your dependencies:

```dart
class MyBinder extends ModuleWidget {
  MyBinder({Key key, @required Widget child}): super(key: key, child: child);
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(Object());
  }
}
```

You can later refer to the injector like any other `InheritedWidget`.

```dart
class SomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final injector = InjectorWidget.of(context);
    final apiKey = injector.get(name: "api_key");
    return SomeContainerNeedingTheKey(apiKey);
  }
}
```

Or using the `InjectorWidgetMixin`:

```dart
class SomeWidget extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final object = injector.get<Object>();
    print(object);
    return Container();
  }
}
```