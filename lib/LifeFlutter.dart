import 'package:flutter/material.dart';

class LifeFlutter extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _LifeFlutterState();

}

class _LifeFlutterState extends State<LifeFlutter>{

  @override
  Widget build(BuildContext context) {
    print("build 构建");
    return new Scaffold(
      appBar: new AppBar(title: new Text("LifeFlutter"),),
      body: new Center(child: new Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("LifeFlutter"),
        ],
      ),),
    );
  }

  @override
  void initState() {
    super.initState();
    //初始化状态
    print("initState  插入到渲染树时调用，只执行一次");
  }

  @override
  void didUpdateWidget(covariant LifeFlutter oldWidget) {
    super.didUpdateWidget(oldWidget);
    //widget树中，若节点调用setState方法，节点本身不会触发didUpdateWidget，此节点的子节点 会 调用didUpdateWidget
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive 在打开新的Widget或回到这个widget时会执行； 可执行多次；");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose 表示组件已销毁");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble 点击闪电会执行，只用于调试时的hot reload。 release版本不会执行该函数。");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //widget树中，若节点的父级结构中的层级 或 父级结构中的任一节点的widget类型有变化，节点会调用didChangeDependencies；若仅仅是父级结构某一节点的widget的某些属性值变化，节点不会调用didChangeDependencies

    print("didChangeDependencies  在初始化initState后执行； 2、显示/关闭其它widget。 3、可执行多次；");
  }
}