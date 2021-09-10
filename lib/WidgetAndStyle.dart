import 'package:flutter/material.dart';

class WidgetAndStyle extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _WidgetAndStyleState();

}

class _WidgetAndStyleState extends State<WidgetAndStyle>{
  bool _switchSelected=true; //维护单选开关状态
  bool _checkboxSelected=true;//维护复选框状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("控件与样式"),),
      body: Center(
        child: new Column(children: <Widget>[
          Text("Hello world", textAlign: TextAlign.left,),
          Text("Hello world HEHEHEHEHello world HEHEHEHEHello world HEHEHEHEHello world HEHEHEHE", maxLines: 1, overflow: TextOverflow.ellipsis,),
          Text("Hello world", textScaleFactor: 1.5,),
          Text("hhhhh nimeia e",style: TextStyle(color: Colors.blue,
              fontSize: 18.0,
              height: 1.2,
              fontFamily: "Courier",
              background: new Paint()..color = Colors.green,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed
          ),),
          Text.rich(TextSpan(children: [
            TextSpan(text: "Home: "),
            TextSpan(text: "https://flutterchina.club",style: TextStyle(color: Colors.blue))
          ])),
          DefaultTextStyle(style: TextStyle(color: Colors.blue,fontSize: 20.0),textAlign: TextAlign.start, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("hello world"),
              Text("I am Jack"*6),
              Text("I am jjjjj",style: TextStyle(inherit: false,//2.不继承默认样式
                  color: Colors.green),
              )
            ],
          )),
          ElevatedButton(onPressed: (){},child: Text("Button 1"),),
          TextButton(onPressed: (){},child: Text("Button 2"),),
          OutlinedButton(onPressed: (){},child: Text("Button 3"),),
          IconButton(onPressed: (){},icon: Icon(Icons.thumb_up),),
          ElevatedButton.icon(icon: Icon(Icons.send), label: Text("发送"), onPressed: (){},),
          Switch(value: _switchSelected, onChanged: (value){
            setState(() {
              _switchSelected = value;
            });
          }),
          Checkbox(value: _checkboxSelected, activeColor: Colors.red ,onChanged: (value){
            setState(() {
              _checkboxSelected = value!;
            });
          }),
          TextField(autofocus: true, decoration: InputDecoration(
            labelText: "用户名",
            hintText: "用户名或邮箱",
            prefixIcon: Icon(Icons.person)
          ),),
          TextField(decoration: InputDecoration(
            labelText: "密码",
            hintText: "您的登录密码",
            prefixIcon: Icon(Icons.lock)
          ),
          obscureText: true,
          )
        ],),
      ),
    );
  }

}