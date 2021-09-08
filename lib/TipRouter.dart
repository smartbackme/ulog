

import 'package:flutter/material.dart';

class TipRouter extends StatelessWidget{
  TipRouter({
    Key? key,required this.text  // 接收一个text参数
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("提示 TipRouter"),),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: new Column(children: <Widget>[
            Text(text),
            ElevatedButton(onPressed: ()=> Navigator.pop(context,"我是返回值"), child: Text("返回")),
            ElevatedButton(onPressed: (){
              // Scaffold.of(context).showSnackBar(SnackBar(content: Text("我是SnackBar")));
              // ScaffoldState? _state = context.findAncestorStateOfType<ScaffoldState>();
              // _state?.showSnackBar(SnackBar(content: Text("我是SnackBar")));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("我是SnackBar")));
            },
              child: Text("显示SnackBar"),
            ),
            ElevatedButton(onPressed: () async {
              var result = await Navigator.pushNamed(context, "tipRouter2",arguments: "hi");
              print("返回：$result");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result as String)));

            },
              child: Text("再跳转一个TipRouter"),
            )

          ],),
        ),
      ),
    );
  }

}