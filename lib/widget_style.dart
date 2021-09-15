import 'package:flutter/material.dart';

class WidgetStyle extends StatefulWidget{




  @override
  State<StatefulWidget> createState() => WidgetStyleState();
}

class WidgetStyleState extends State<WidgetStyle>{

  bool _switchSelected=true; //维护单选开关状态
  double _y = 0.3;

  @override
  Widget build(BuildContext context) {
    Widget redBox=DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );

    return  Scaffold(
        appBar: AppBar(title: Text("WidgetStyle"),
          actions: <Widget>[
            UnconstrainedBox(
              child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),),
            ),
            UnconstrainedBox(
              child: Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",width: 20,height: 20,),
            )
          ],
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                  minHeight: 50.0 //最小高度为50像素
              ),
              child: Container(
                  height: 5.0,
                  child: redBox
              ),
            ),
            SizedBox(
                width: 80.0,
                height: 80.0,
                child: redBox
            ),
            DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors:[Colors.red,Colors.orange]), //背景渐变
                    borderRadius: BorderRadius.circular(3.0), //3像素圆角
                    boxShadow: [ //阴影
                      BoxShadow(
                          color:Colors.amber,
                          offset: Offset(2.0,2.0),
                          blurRadius: 4.0
                      )
                    ]
                ),
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                  child: Text("Login", style: TextStyle(color: Colors.white),),
                )
            ),
            Container(
              color: Colors.black,
              child: new Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: new Matrix4.skewY(_y), //沿Y轴倾斜0.3弧度
                child: new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('Apartment for rent!'),
                ),
              ),
            ),
            Switch(value: _switchSelected, onChanged: (value){
              setState(() {
                _switchSelected = value;
                if(_switchSelected){
                  _y = 0.3;
                }else{
                  _y=0;
                }
              });
            }),
          ],)
    );
  }

}