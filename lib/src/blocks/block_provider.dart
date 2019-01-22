import 'package:flutter/widgets.dart';

abstract class BaseBlock {
  void dispose();
}

class BlocProvider<T extends BaseBlock> extends StatefulWidget {
  final Widget child;
  final T block;

  const BlocProvider({
    Key key,
    @required this.child,
    @required this.block,
  }) : super(key: key);

  @override
  _BlocProviderState createState() => _BlocProviderState();

  static _typeOf<T>() => T;

  static T of<T extends BaseBlock>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.block;
  }
}

class _BlocProviderState<T extends BaseBlock> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) => _BlockInheritedWidget(
        child: widget?.child,
        bloc: widget?.block,
      );
}

class _BlockInheritedWidget<T> extends InheritedWidget {
  final T bloc;

  _BlockInheritedWidget({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
