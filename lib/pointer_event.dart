
import 'package:flutter/material.dart';

class PointerEventT extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => PointerEventState();

}

class PointerEventState extends State<PointerEventT>{
  PointerEvent? _event;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text("LayoutStyle"),),
        body:Column(
          children: <Widget>[
            Listener(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 300.0,
                height: 150.0,
                child: Text(_event?.toString()??"",style: TextStyle(color: Colors.white)),
              ),
              onPointerDown: (PointerDownEvent event) => setState(()=>_event=event),
              onPointerMove: (PointerMoveEvent event) => setState(()=>_event=event),
              onPointerUp: (PointerUpEvent event) => setState(()=>_event=event),
            ),
            Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(300.0, 50.0)),
                  child: Center(child: Text("Box A")),
                ),
                //behavior: HitTestBehavior.opaque,
                onPointerDown: (event) => print("down A")//子组件会一个接一个的进行命中测试，如果子组件中有测试通过的，则当前组件通过，这就意味着，如果指针事件作用于子组件上时，其父级组件也肯定可以收到该事件。
            ),
            Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(300.0, 50.0)),
                  child: Center(child: Text("Box A")),
                ),
                behavior: HitTestBehavior.opaque,
                onPointerDown: (event) => print("down All")//在命中测试时，将当前组件当成不透明处理(即使本身是透明的)，最终的效果相当于当前Widget的整个区域都是点击区域。
            ),
    Stack(children: [
      Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(300.0, 200.0)),
          child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue)),
        ),
        onPointerDown: (event) => print("down0"),
      ),
      Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(200.0, 100.0)),
          child: Center(child: Text("左上角200*100范围内非文本区域点击")),
        ),
        onPointerDown: (event) => print("down1"),
        behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
      )
    ],),
            Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 200.0,
                    height: 100.0,
                  ),
                  onPointerDown: (event)=>print("in"),
                ),
              ),
              onPointerDown: (event)=>print("up"),
            ), //点击Container时，由于它在AbsorbPointer的子树上，所以不会响应指针事件，所以日志不会输出"in"，但AbsorbPointer本身是可以接收指针事件的，所以会输出"up"。如果将AbsorbPointer换成IgnorePointer，那么两个都不会输出。
            Listener(
              child: IgnorePointer(
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 200.0,
                    height: 100.0,
                  ),
                  onPointerDown: (event)=>print("in"),
                ),
              ),
              onPointerDown: (event)=>print("up"),
            ),
          ],
        )
    );
  }

}