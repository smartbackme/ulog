import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class BaseDart extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => BaseDartState();

}

typedef bool CALLBACK();

class BaseDartState extends State<BaseDart>{

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  //final变量在第一次使用时被初始化
  final str = "hi workd";
  // const 变量是一个编译时常量
  static const str1 = "1231321";

  isNobled(){
    return "kk";
  }

  bool isNoble2() => true;

  void test(CALLBACK cb){
    print(cb);
  }

  bool isNoble(int automicN){
    return true;
  }

  void exect(var ca){
    ca();
  }


  String say121(String from,String msg ,[String? device]){
    var result = '$from says $msg';
    if(device!=null){
      result='$result with a $device';
    }
    return result;
  }

  void enableFlags({bool? bold,bool? hidden}){

  }

  @override
  Widget build(BuildContext context) {
    var t;
    t = "12312";
    dynamic tm ;
    tm = "1231";
    Object tms;
    tms = "12313";
    tms = 1231;

    tm.length;
    var say = (str){
      print(str);
    };
    say("1231");

    exect( () => print("object"));

    say121("13132", "1231321","43214 32");

    enableFlags(bold: true);

    /**
     * 异步
     */
    Future.delayed(new Duration(seconds: 3),(){
      return "hi world";
    }).then((value) => print(value)).whenComplete((){
      //无论成功或失败都会走到这里
      print("whenComplete");

    });


    Future.delayed(new Duration(seconds: 2),(){
      throw AssertionError("Error");
    }).then((value) => print("success"))
        .catchError((e){
      print(e);

    }).whenComplete((){
      //无论成功或失败都会走到这里
      print("whenComplete");

    });

    // task() async {
    //   try{
    //     String id = await login("alice","******");
    //     String userInfo = await getUserInfo(id);
    //     await saveUserInfo(userInfo);
    //     //执行接下来的操作
    //   } catch(e){
    //     //错误处理
    //     print(e);
    //   }
    // }

    Stream.fromFutures([
      Future.delayed(new Duration(seconds: 1),(){
        return "hello 1";
      }),
      Future.delayed(new Duration(seconds: 2),(){
        throw AssertionError("Error");
      }),
      Future.delayed(new Duration(seconds: 3),(){
        return "hello 3";
      })
    ]).listen((event) {
      print(event);
    },onError: (e){
      print(e.message);
    },onDone: (){

    });


    Future.wait([
      Future.delayed(new Duration(seconds: 8),(){return "hello world";}),
      Future.delayed(new Duration(seconds: 4),(){return "heheh";})
    ]).then((value) => print(value[0]+value[1]));
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("startup name Gnerator"),
        actions: <Widget> [
          new IconButton(onPressed: _pushSaved, icon: new Icon(Icons.list))
        ],
      ),
      body: _buildSuggestions(),
    );
  }




  void _pushSaved(){
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context){
          final tiles = _saved.map(
                  (pair){
                return new ListTile(
                  title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              }
          );
          final divided = ListTile.divideTiles(tiles: tiles,context: context).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("save Suggestions rrrr"),
            ),
            body: new ListView(children: divided),
          );
        })
    );
  }

  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
      // 在偶数行，该函数会为单词对添加一个ListTile row.
      // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
      // 注意，在小屏幕上，分割线看起来可能比较吃力。
      itemBuilder: (context,i) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        if(i.isOdd) return new Divider();
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair){
    final alreadySaved = _saved.contains(wordPair);
    return new ListTile(
      title: new Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved){
            _saved.remove(wordPair);
          }else{
            _saved.add(wordPair);
          }
        });
      },
    );
  }

}