# ULog

<!-- [![pub package](https://img.shields.io/pub/v/logger.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/logger) -->
<!-- [![CI](https://img.shields.io/github/workflow/status/leisim/logger/Dart%20CI/master?logo=github-actions&logoColor=white)](https://github.com/leisim/logger/actions) -->
<!-- [![Last Commits](https://img.shields.io/github/last-commit/leisim/logger?logo=git&logoColor=white)](https://github.com/leisim/logger/commits/master) -->
<!-- [![Pull Requests](https://img.shields.io/github/issues-pr/leisim/logger?logo=github&logoColor=white)](https://github.com/leisim/logger/pulls) -->
<!-- [![Code size](https://img.shields.io/github/languages/code-size/leisim/logger?logo=github&logoColor=white)](https://github.com/leisim/logger) -->
<!-- [![License](https://img.shields.io/github/license/leisim/logger?logo=open-source-initiative&logoColor=green)](https://github.com/leisim/logger/blob/master/LICENSE) -->

Imitate Android logger library  [logger](https://github.com/orhanobut/logger)



## start using



```dart
dependencies:
  flutter_ulog: ^0.0.1
//Initialization
class ConsoleAdapter extends ULogConsoleAdapter{
  @override
  bool isLoggable(ULogType type, String? tag) => true;
}
    ULog.init((value){
      return ""; // your JSON parsing library
    });
//Add a log adapter, which can be inherited to print different contents under different circumstances
    ULog.addLogAdapter(ConsoleAdapter());
```



## Output

Daily printing
![](art/base_image.apk)

![](art/base_image2.apk)

If a line exceeds 4000 characters, it will be automatically folded
![](art/base_image3.apk)

## Log level


```dart
    ULog.v("12321321\ndfafdasfdsa\ndafdasf");
    ULog.d("12321321");
    ULog.i("12321321");
    ULog.w("12321321");
    ULog.e("1321231",error: NullThrownError());
    var map = [];
    map.add("1232");
    map.add("1232");
    map.add("1232");
    map.add("1232");
    ULog.e(map,error: NullThrownError());
    ULog.json('''
     {
      "a1": "value",
    "a2": 42,
    "bs": [
    {
    "b1": "any value",
    "b2": 13
    },
    {
    "b1": "another value",
    "b2": 0
    }
    ]
    }
    ''');

    // ULog.o(User("123","123"));
    ULog.e("1321231",error: NullThrownError(),tag: "12312");
    ULog.e("123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321123213211232132112321321");

```