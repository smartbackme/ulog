import 'package:flutter/material.dart';

class LiziDart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LiziDartState();

}

class _LiziDartState extends State<LiziDart>{
  int _selectedIndex = 0;
  bool _switchSelected=true; //维护单选开关状态
  bool _checkboxSelected=true;//维护复选框状态

  DateTime? _lastPressedAt;//上次点击时间

  double _y = 0.3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("LayoutStyle"),
          actions: <Widget>[
            ElevatedButton(onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("123")));
            }, child: Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",width: 20,height: 20,),)
          ],),
        bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.business),label: "Business"),
          BottomNavigationBarItem(icon: Icon(Icons.school),label: "School"),
        ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.amber,
          onTap: _onItemTapped,
        ),
        body: SingleChildScrollView(scrollDirection : Axis.vertical,child:
        Column(
            children: <Widget>[
              WillPopScope(child: Container(alignment: Alignment.center,child: Text("1秒内连续按两次返回键退出"),), onWillPop: () async{
                //两次点击间隔超过1秒则重新计时
                if(_lastPressedAt == null||DateTime.now().difference(_lastPressedAt!)>Duration(seconds: 1)){
                  _lastPressedAt = DateTime.now();
                  return false;
                }else{
                  return true;
                }
              }),
              ConstrainedBox(constraints: BoxConstraints(maxHeight: 200),
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
                        children: <Widget>[
                          Container(
                            color: Colors.red,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,//无效，内层Colum高度为实际高度
                              children: <Widget>[
                                Text("hello world "),
                                Text("I am Jack "),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
                        children: <Widget>[
                          Expanded(child: Container(
                            color: Colors.red,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,//无效，内层Colum高度为实际高度
                              children: <Widget>[
                                Text("hello world "),
                                Text("I am Jack "),
                              ],
                            ),
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),),
              Wrap(
                spacing: 8.0, // 主轴(水平)方向间距
                runSpacing: 4.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.center, //沿主轴方向居中
                children: <Widget>[
                  new Chip(
                    avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
                    label: new Text('Hamilton'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
                    label: new Text('Lafayette'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
                    label: new Text('Mulligan'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
                    label: new Text('Laurens'),
                  ),
                ],
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
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text("123123123123123123123123123123123123123123",style: TextStyle(background: Paint()..color=Colors.red),)
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("123123123123123123123123123123123123123123",style: TextStyle(background: Paint()..color=Colors.grey)),
                  ),
                ],
              ),
              IconButton(onPressed: (){},icon: Icon(Icons.thumb_up),),
              ElevatedButton.icon(icon: Icon(Icons.send), label: Text("发送"), onPressed: (){},),
              Checkbox(value: _checkboxSelected, activeColor: Colors.red ,onChanged: (value){
                setState(() {
                  _checkboxSelected = value!;
                });
              }),
              Image.asset("images/img00.png"),
              Container(padding: EdgeInsets.all(20),
                  color: Colors.blue,
                  margin: EdgeInsets.all(20),
                  child: DecoratedBox(
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
              ),)

            ]
        )
        ),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

}