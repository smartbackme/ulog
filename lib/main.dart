import 'package:flutter/material.dart';
import 'package:flutter_app_me/base_dart.dart';
import 'package:flutter_app_me/image_show.dart';
import 'package:flutter_app_me/life_flutter.dart';
import 'package:flutter_app_me/null_router.dart';
import 'package:flutter_app_me/page_state.dart';
import 'package:flutter_app_me/tip_router.dart';
import 'package:flutter_app_me/widget_and_style.dart';

import 'layout_style.dart';
import 'layout_style2.dart';
import 'layout_style3.dart';
import 'layout_style4.dart';
import 'widget_style.dart';

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
            case "imageShow" : return ImageShow();
            case "layoutStyle" : return LayoutStyle();
            case "layoutStyle2" : return LayoutStyle2();
            case "layoutStyle3" : return LayoutStyle3();
            case "layoutStyle4" : return LayoutStyle4();
            case "widgetAndStyle" : return WidgetAndStyle();
            case "widget_style" : return WidgetStyle();
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
          Wrap(spacing: 8.0,// 主轴(水平)方向间距
          runSpacing: 4.0,// 纵轴（垂直）方向间距
            alignment: WrapAlignment.start,
            children: <Widget>[
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "baseDart");
              }, child: Text("dart基本语法"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "tipRouter",arguments: "hi");
              }, child: Text("路由管理"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "LifeFlutter");
              }, child: Text("生命周期分析"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "pageState",arguments: "状态管理");
              }, child: Text("状态管理"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "widgetAndStyle");
              }, child: Text("控件与样式"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "imageShow");
              }, child: Text("图片展示"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "layoutStyle");
              }, child: Text("布局"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "layoutStyle2");

              }, child: Text("布局2"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "layoutStyle3");
              }, child: Text("布局3"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "layoutStyle4");
              }, child: Text("布局4"),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, "widget_style");
              }, child: Text("组件"),),
            ],
          ),
        ],
      ),
    );
  }
}