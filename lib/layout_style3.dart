
import 'package:flutter/material.dart';

class LayoutStyle3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text("LayoutStyle"),),
    body: ConstrainedBox(constraints: BoxConstraints.expand(),//通过ConstrainedBox来确保Stack占满屏幕

    child: Stack(
      fit: StackFit.expand, //未定位widget占满Stack整个空间
      alignment: Alignment.center,//指定未定位或部分定位widget的对齐方式
      children: <Widget>[
        Positioned(child: Text("Hehe"),left: 18.0,top: 20,),
        Container(child: Text("1234",style: TextStyle(color: Colors.grey),),color: Colors.red,),

        Positioned(child: Text("1234000"),top: 20.0,right: 20.0,)
      ],
    ),
    )
    );
  }

}