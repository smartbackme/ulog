import 'package:flutter/material.dart';
import 'package:flutter_app_me/BaseDart.dart';
import 'package:flutter_app_me/LifeFlutter.dart';
import 'package:flutter_app_me/NullRouter.dart';
import 'package:flutter_app_me/PageState.dart';
import 'package:flutter_app_me/TipRouter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "baseDart" : (context) => BaseDart(), //注册路由方式跳转
        "/" : (context) => MyHomePage(title: "flutter Demo Home Page"),//注册首页路由
        "tipRouter2" : (context)  {
          return TipRouter(text : ModalRoute.of(context)?.settings.arguments as String);
        }
      },
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(builder: (context) {
          String? routerName = settings.name;
          print(routerName);
          switch(routerName){
            case "tipRouter" : return TipRouter(text : settings.arguments as String);
            case "pageState" : return PageState(title : settings.arguments as String);
            case "LifeFlutter" : return LifeFlutter();
          }
          return NullRouter();
        });
      },
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute:"/", //名为"/"的路由作为应用的home(首页)
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(2),child:
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "baseDart");
              }, child: Text("dart基本语法"),),),
              Padding(padding: EdgeInsets.all(2),child:
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "tipRouter",arguments: "hi");
              }, child: Text("路由管理"),),),
              Padding(padding: EdgeInsets.all(2),child:
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "LifeFlutter");
              }, child: Text("生命周期分析"),),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(2),child:
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "pageState",arguments: "状态管理");
              }, child: Text("状态管理"),),),
              Padding(padding: EdgeInsets.all(2),child:
              ElevatedButton(onPressed: () {
              }, child: Text("按钮"),),),
              Padding(padding: EdgeInsets.all(2),child:
              ElevatedButton(onPressed: () {
              }, child: Text("空间"),),),
            ],
          )
        ],
      ),
    );
  }
}