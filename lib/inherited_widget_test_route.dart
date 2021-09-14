
import 'dart:collection';

import 'package:flutter/material.dart';

class InheritedWidgetTestRoute extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _InheritedWidgetTestRouteState();

}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(bottom: 20),
              child: _TestWidget(),
            ),Padding(padding: const EdgeInsets.only(bottom: 20),
              child: _TestWidget2(),
            ),
            ElevatedButton(onPressed: (){
              setState(() {
                ++count;
              });
            }, child: Text("Increment")),
            ChangeNotifierProvider<CartModel>(
              data: CartModel(),
              child: Builder(builder: (context) {
                return Column(
                  children: <Widget>[
                    Builder(builder: (context){
                      var cart=ChangeNotifierProvider.of<CartModel>(context);
                      return Text("总价: ${cart.totalPrice}");
                    }),
                    Builder(builder: (context){
                      print("ElevatedButton build"); //在后面优化部分会用到
                      return ElevatedButton(
                        child: Text("添加商品"),
                        onPressed: () {
                          //给购物车中添加商品，添加后总价会更新
                          ChangeNotifierProvider.of<CartModel>(context).add(Item(20.0, 1));
                        },
                      );
                    }),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

}


class ShareDataWidget extends InheritedWidget{
  ShareDataWidget({required this.data,required Widget child}) : super(child:child);

  final int data;//需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>()!;
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return oldWidget.data != data;
  }

}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => __TestWidgetState();

}

class __TestWidgetState extends State<_TestWidget>{
  @override
  Widget build(BuildContext context) => Text(ShareDataWidget.of(context).data.toString());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}

class _TestWidget2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => __TestWidgetState2();

}

class __TestWidgetState2 extends State<_TestWidget2> {
  @override
  Widget build(BuildContext context) {
    // 使用InheritedWidget中的共享数据
    //    return Text(ShareDataWidget
    //        .of(context)
    //        .data
    //        .toString());
    return Text("text");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // build方法中没有依赖InheritedWidget，此回调不会被调用。
    print("__TestWidgetState2 Dependencies change ");
  }
}

class InheritedProvider<T> extends InheritedWidget{
  //共享状态使用泛型
  final T data;
  InheritedProvider({required this.data,required Widget child}) : super(child:child);

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    return true;
  }

}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget{
  ChangeNotifierProvider({
    required this.data,
    required this.child,
  });

  final Widget child;
  final T data;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context) {
    final provider =  context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()!;
    return provider.data;
  }

  @override
  State<StatefulWidget> createState() => _ChangeNotifierProviderState<T>();

}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }

}

//购物车示例
class Item {
  Item(this.price, this.count);
  double price; //商品单价
  int count; // 商品份数
//... 省略其它属性
}
// 定义一个保存购物车内商品数据的CartModel类:

class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}