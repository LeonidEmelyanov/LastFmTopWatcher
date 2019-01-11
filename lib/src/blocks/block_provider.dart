import 'package:flutter/widgets.dart';

abstract class BaseBlock {
  void dispose();
}

class BlockProvider<T extends BaseBlock> extends StatefulWidget {
  final Widget child;
  final T block;

  const BlockProvider({
    Key key,
    @required this.child,
    @required this.block,
  }) : super(key: key);

  @override
  _BlockProviderState createState() => _BlockProviderState();

  static _typeOf<T>() => T;

  static T of<T extends BaseBlock>(BuildContext context) => (context
          .ancestorInheritedElementForWidgetOfExactType(
              _typeOf<BlockProvider<T>>())
          ?.widget as _BlockInheritedWidget)
      ?.block;
}

class _BlockProviderState<T extends BaseBlock> extends State<BlockProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _BlockInheritedWidget(
      child: widget?.child,
      block: widget?.block,
    );
  }
}

class _BlockInheritedWidget<T> extends InheritedWidget {
  final T block;

  _BlockInheritedWidget({
    Key key,
    @required Widget child,
    @required this.block,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
