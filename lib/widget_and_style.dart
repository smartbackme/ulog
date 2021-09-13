import 'package:flutter/material.dart';

class WidgetAndStyle extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _WidgetAndStyleState();

}

class _WidgetAndStyleState extends State<WidgetAndStyle>{
  bool _switchSelected=true; //维护单选开关状态
  bool _checkboxSelected=true;//维护复选框状态
  String text="";
  String pass="";

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode ;

  GlobalKey _fromKey = GlobalKey<FormState>();

  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 设置默认值，并从第三个字符开始选中后面的字符
    _editingController.text="hello world!";
    _editingController.addListener(() { 
      print(_editingController.text);
    });
    _editingController.selection = TextSelection(baseOffset: 2, extentOffset: _editingController.text.length);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("控件与样式"),),
      body: SingleChildScrollView(scrollDirection : Axis.vertical,child: Center(
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
          ElevatedButton(onPressed: (){},child: Text(text),),
          TextButton(onPressed: (){},child: Text(pass),),
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
          Builder(builder: (context) {
            return Row(
              children: [
                ElevatedButton(onPressed: (){
                  if(null == focusScopeNode){
                    focusScopeNode = FocusScope.of(context);
                  }
                  focusScopeNode!.requestFocus(focusNode2);
                }, child: Text("移动焦点")),
                ElevatedButton(onPressed: (){
                  focusNode1.unfocus();
                  focusNode2.unfocus();
                }, child: Text("隐藏键盘")),

              ],
            );
          }),
        Form(key :_fromKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: <Widget>[
                Container(child:
                TextField(autofocus: true,
                  decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none
                ),
                  controller: _editingController,
                  focusNode: focusNode1,
                  onChanged: (value){
                    setState(() {
                      text = value;
                    });
                  },
                ),decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1.0))),
                ),
                TextField(decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    prefixIcon: Icon(Icons.lock),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    )
                ),
                  focusNode: focusNode2,
                  obscureText: true,
                  onChanged: (value){
                    setState(() {
                      pass = value;
                    });
                  },
                ),
                TextFormField(decoration: InputDecoration(
                    labelText: "TextFormField密码",
                    hintText: "TextFormField您的登录密码",
                    prefixIcon: Icon(Icons.lock),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    )
                ),
                  obscureText: true,
                  validator: (value){
                    return value!.trim().length>5 ?null:"密码不能少于6位";
                  },
                ),

                Padding(padding: const EdgeInsets.only(top:28.0),
                child: Row(children: <Widget>[
                  Expanded(child: ElevatedButton(child: Text("登录"),
                    onPressed: (){
                      //在这里不能通过此方式获取FormState，context不对
                      //print(Form.of(context));

                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                    if((_fromKey.currentState as FormState).validate()){
                      //验证通过提交数据
                    }
                    },
                  ))
                ],),
                )
              ],
            )),



        ],),
      ),)


    );
  }

}