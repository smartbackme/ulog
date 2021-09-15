import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationTest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NotificationTestState();

}

class _NotificationTestState extends State<NotificationTest>{

  String _msg="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LayoutStyle"),),

      body:NotificationListener<MyNotification>(
        onNotification: (notification){
          print("out:"+notification.msg); //打印通知
          //flase 不阻止冒泡
          return false;
        },
        child: NotificationListener<MyNotification>(
          onNotification: (notification){
            print("in:"+notification.msg); //打印通知
            //true 阻止冒泡
            return true;
          },
          child: NotificationListener<MyNotification>(child: Center(
            child: Column(mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context){
                  // 而NotificationListener是监听的子树，所以我们通过Builder来构建ElevatedButton，来获得按钮位置的context。
                  return ElevatedButton(onPressed: (){
                    MyNotification("Hi").dispatch(context);
                  }, child: Text("Send Notification"));
                }),
                Text(_msg)
              ],),
          ),onNotification: (notifaication) {
            setState(() {
              _msg += notifaication.msg +" ";
            });
            //flase 不阻止冒泡
            return false;
          },),
        ),),);
  }

}

class MyNotification extends Notification{
  MyNotification(this.msg);
  final String msg;
}