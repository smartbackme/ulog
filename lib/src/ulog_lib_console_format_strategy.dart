
import 'dart:convert';

import 'package:flutter_ulog/src/ulog.dart';
import 'package:flutter_ulog/src/ulog_utils.dart';

import 'ansi_color.dart';
import 'i_ulog_format_strategy.dart';

class ULogLibConfig{
  final int _stackDeep ;
  final String _tag ;
  ULogLibConfig(ULogLibConfigBuilder builder): _stackDeep = builder._stackDeep,_tag = builder._tag;
}

class ULogLibConfigBuilder {
  int _stackDeep = 2;
  String _tag = "LIB-LOG";

  ULogLibConfigBuilder setStackDeep(int stackDeep){
    _stackDeep = stackDeep;
    return this;
  }

  ULogLibConfigBuilder setTag(String tag){
    _tag = tag;
    return this;
  }

  ULogLibConfig build() => ULogLibConfig(this);
}

class ULogLibConsoleFormatStrategy implements ULogFormatStrategy{

  ///绘图工具箱
  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = '────────────────────────────────────────────────────────';
  static const singleDivider = '┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄';
  String _topBorder = '$topLeftCorner$doubleDivider$doubleDivider';
  String _middleBorder = '$middleCorner$singleDivider$singleDivider';
  String _bottomBorder = '$bottomLeftCorner$doubleDivider$doubleDivider';

  static final typeColors = {
    ULogType.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    ULogType.debug: AnsiColor.none(),
    ULogType.info: AnsiColor.fg(12),
    ULogType.warning: AnsiColor.fg(208),
    ULogType.error: AnsiColor.fg(196),
  };

  static final typeEmojis = {
    ULogType.verbose: '',
    ULogType.debug: '🐛',
    ULogType.info: '💡',
    ULogType.warning: '⚠',
    ULogType.error: '⛔',
  };

  ///一行最大字符数4000
  static const chunkSize = 4000;

  ULogLibConfig config = ULogLibConfigBuilder().build();

  @override
  void log(ULogType type, String? onceOnlyTag, String? message) {
    var time = getTime();
    var tag = _formatTag(onceOnlyTag);
    _logTopBorder(type, tag,time);
    _logHeaderContent(type, tag ,time);
    // List<int> bytes = utf8.encode(message!);
    // var length = bytes.length;
    var length = message!.length;
    if (length <= chunkSize) {
      if (config._stackDeep > 0) {
        _logDivider(type, tag,time);
      }
      _logContent(type, tag,time, message);
      _logBottomBorder(type, tag,time);
    }else{
      if (config._stackDeep > 0) {
        _logDivider(type, tag,time);
      }
      for (int i = 0; i < length; i += chunkSize) {
        int count =  (length - i)<chunkSize? (length - i):chunkSize;
        _logContent(type, tag, time, message.substring(i,count+i));
      }
      _logBottomBorder(type, tag ,time);
    }
  }

  String _formatTag(String? tag){
    if(tag!=null&&tag.isNotEmpty){
      return '${config._tag}-$tag';
    }else{
      return '${config._tag}';
    }
  }

  void _logHeaderContent(ULogType type, String tag, String time) {
    if(config._stackDeep>0){
      var stack = ULogUtils.cropStackTrace(StackTrace.current,config._stackDeep);
      var level = "";

      for (var s in stack){
        _logChunk(type, tag, time,'$verticalLine$level$s');
        level += "   ";
      }
    }
  }

  ///绘制顶线
  void _logTopBorder(ULogType type, String tag, String time) {
    _logChunk(type, tag, time,_topBorder);
  }
  
  ///绘制内容
  void _logContent(ULogType type, String tag, String time, String chunk) {
    for (var line in chunk.split('\n')) {
      _logChunk(type, tag, time, "$verticalLine $line");
    }
  }

  ///绘制底线
  void _logBottomBorder(ULogType type, String tag, String time) {
    _logChunk(type, tag, time,_bottomBorder);
  }
  
  ///绘制分割线
  void _logDivider(ULogType type, String tag, String time) {
    _logChunk(type, tag, time,_middleBorder);
  }
  
  ///打印
  void _logChunk(ULogType type, String tag, String time, String message) {
    print(typeColors[type]!.call('${typeEmojis[type]}$time$verticalLine$tag $message'));
  }
  
  String getTime() {
    String _threeDigits(int n) {
      if (n >= 100) return '$n';
      if (n >= 10) return '0$n';
      return '00$n';
    }

    String _twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    var now = DateTime.now();
    var h = _twoDigits(now.hour);
    var min = _twoDigits(now.minute);
    var sec = _twoDigits(now.second);
    var ms = _threeDigits(now.millisecond);
    return '$h:$min:$sec.$ms';
  }

}

