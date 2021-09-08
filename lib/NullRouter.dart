import 'package:flutter/material.dart';

class NullRouter extends StatelessWidget{
  NullRouter({
    Key? key  // 接收一个text参数
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("空路由"),),
      body: Center(
        child: Text("空路由"),
      ),
    );
  }

}