import 'package:flutter/material.dart';

class WidgetStyle extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    Widget redBox=DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );

    return  Scaffold(
        appBar: AppBar(title: Text("WidgetStyle"),),
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
          )
        ],)
    );
  }

}