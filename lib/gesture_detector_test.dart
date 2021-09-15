
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureDetectorTest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GestureDetectorTestState();

}

class _GestureDetectorTestState extends State<GestureDetectorTest>{
  String _operation = "No Gesture detected!"; //保存事件名
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0;//距左边的偏移
  double _top3 = 100.0; //距顶部的偏移
  double _left3 = 100.0;//距左边的偏移
  double _left4 = 200.0;//距左边的偏移
  double _leftB = 100.0;//距左边的偏移
  double _top2 = 20.0; //距顶部的偏移

  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle  = false;

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text("LayoutStyle"),),
    body: ConstrainedBox(
    constraints: BoxConstraints.expand(),
    child: Stack(
      alignment:Alignment.center,
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: GestureDetector(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 200.0,
              height: 100.0,
              child: Text(_operation,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () => updateText("Tap"),//点击
            onDoubleTap: () => updateText("DoubleTap"), //双击
            onLongPress: () => updateText("LongPress"), //长按
          ),
        ),

        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e){
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        ),
        Positioned(
          top: _top2,
          child: GestureDetector(
            child: CircleAvatar(child: Text("B")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //垂直方向拖动事件
    onVerticalDragUpdate:(details){
      setState(() {
        _top2 += details.delta.dy;
      });
    },
            onPanEnd: (DragEndDetails e){
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        ),
        GestureDetector(
          //指定宽度，高度自适应
          child: Image.asset("./images/img00.png", width: _width),
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              //缩放倍数在0.8到10倍之间
              _width=200*details.scale.clamp(.8, 10.0);
            });
          },
        ),

        Positioned(
          left: 0,
          bottom: 0,
          child: Text.rich(
              TextSpan(
                  children: [
                    TextSpan(text: "你好世界"),
                    TextSpan(
                      text: "点我变色",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: _toggle ? Colors.blue : Colors.red
                      ),
                      recognizer: _tapGestureRecognizer
                        ..onTap = () {
                          setState(() {
                            _toggle = !_toggle;
                          });
                        },
                    ),
                    TextSpan(text: "你好世界"),
                  ]
              )
        ),),
        Positioned(
          top: _top3,
          left: _left3,
          child: GestureDetector(
            child: CircleAvatar(child: Text("C")),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top3 += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left3 += details.delta.dx;
              });
            },
          ),
        ),
        Positioned(
          left: _left4,
          child: GestureDetector(
            child: CircleAvatar(child: Text("D")), //要拖动和点击的widget
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left4 += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details){
              print("onHorizontalDragEnd");
            },
            onTapDown: (details){
              print("down");
            },
            onTapUp: (details){
              print("up");
            },
          ),
        ),
        Positioned( //Listener监听原始指针事件 ,来达到监听事件冲突问题
          top:80.0,
          left: _leftB,
          child: Listener(
            onPointerDown: (details) {
              print("down");
            },
            onPointerUp: (details) {
              //会触发
              print("up");
            },
            child: GestureDetector(
              child: CircleAvatar(child: Text("E")),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _leftB += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print("onHorizontalDragEnd");
              },
            ),
          ),
        )
      ])


    ,),);
  }
  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}