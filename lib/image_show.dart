import 'package:flutter/material.dart';

class ImageShow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("提示"),),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: new Column(children: <Widget>[
            Image.asset("images/img00.png"),
            Image.asset("images/img01.png"),
            Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",width: 100.0,),
            Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",width: 50.0,height: 100.0,fit: BoxFit.cover,),
            Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",width: 50.0,height: 100.0,fit: BoxFit.cover,color: Colors.blue,colorBlendMode: BlendMode.difference,),
            Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",width: 50.0,height: 100.0,fit: BoxFit.contain,repeat: ImageRepeat.repeatY,),
            Text("\uE914  \uE000  \uE90D",style: TextStyle(fontFamily: "MaterialIcons",fontSize: 24.0,color :Colors.green),)
          ],),
        ),
      ),
    );
  }

}