
import 'dart:convert';

import 'package:flutter_ulog/src/i_ulog_adapter.dart';
import 'package:flutter_ulog/src/ulog.dart';

import 'i_ulog_printer.dart';

class ULogLibPrinter implements ULogPrinter{
  static const JSON_INDENT = 1;
  String getDeepSpace(int deep) {
    var tab = StringBuffer();
    for (int i = 0; i < deep; i++) {
      tab.write("\t");
    }
    return tab.toString();
  }
  List<ULogAdapter> _logAdapters = <ULogAdapter>[];

  @override
  void addAdapter(ULogAdapter adapter) {
    if(!_logAdapters.contains(adapter)){
      _logAdapters.add(adapter);
    }
  }

  @override
  void clearLogAdapters() {
    _logAdapters.clear();
  }

  @override
  void json(String json, { String? tag}) {
    if (json.isEmpty) {
      log(ULogType.debug, "Empty/Null json content",tag: tag);
    }else{
      var j = json.trim();
      if (j.startsWith("{")) {
        Map<String, dynamic> decode = JsonCodec().decode(json);
        log(ULogType.debug, _convert(decode, JSON_INDENT));
      }
      if (j.startsWith("[")) {
        List decode = JsonCodec().decode(json);
        log(ULogType.debug, _convert(decode, JSON_INDENT,isObject: true));
      }
    }
  }


  /// [object]  解析的对象
  /// [deep]  递归的深度，用来获取缩进的空白长度
  /// [isObject] 用来区分当前map或list是不是来自某个字段，则不用显示缩进。单纯的map或list需要添加缩进
  String _convert(dynamic object, int deep, {bool isObject = false}) {
    var buffer = StringBuffer();
    var nextDeep = deep + 1;
    if (object is Map) {
      var list = object.keys.toList();
      if (!isObject) {//如果map来自某个字段，则不需要显示缩进
        buffer.write("${getDeepSpace(deep)}");
      }
      buffer.write("{");
      if (list.isEmpty) {//当map为空，直接返回‘}’
        buffer.write("}");
      }else {
        buffer.write("\n");
        for (int i = 0; i < list.length; i++) {
          buffer.write("${getDeepSpace(nextDeep)}\"${list[i]}\":");
          buffer.write(_convert(object[list[i]], nextDeep, isObject: true));
          if (i < list.length - 1) {
            buffer.write(",");
            buffer.write("\n");
          }
        }
        buffer.write("\n");
        buffer.write("${getDeepSpace(deep)}}");
      }
    } else if (object is List) {
      if (!isObject) {//如果list来自某个字段，则不需要显示缩进
        buffer.write("${getDeepSpace(deep)}");
      }
      buffer.write("[");
      if (object.isEmpty) {//当list为空，直接返回‘]’
        buffer.write("]");
      }else {
        buffer.write("\n");
        for (int i = 0; i < object.length; i++) {
          buffer.write(_convert(object[i], nextDeep));
          if (i < object.length - 1) {
            buffer.write(",");
            buffer.write("\n");
          }
        }
        buffer.write("\n");
        buffer.write("${getDeepSpace(deep)}]");
      }
    } else if (object is String) {//为字符串时，需要添加双引号并返回当前内容
      buffer.write("\"$object\"");
    } else if (object is num || object is bool) {//为数字或者布尔值时，返回当前内容
      buffer.write(object);
    }  else {//如果对象为空，则返回null字符串
      buffer.write("null");
    }
    return buffer.toString();
  }

  @override
  void log(ULogType type, message, {error, StackTrace? stackTrace, String? tag}) {
    var msg = stringifyMessage(message);
    var emsg = "";
    if(error!=null){
      emsg = '\n${error.toString()}';
    }
    var stmsg = "";
    if(stackTrace!=null){
      stmsg = '\n${stackTrace.toString()}';
    }
    var str = msg + emsg + stmsg;
    _logAdapters.forEach((element) {
      if(element.isLoggable(type, tag)){
        element.log(type,tag,str.toString());
      }
    });

  }

  // Handles any object that is causing JsonEncoder() problems
  Object toEncodableFallback(dynamic object) {
    return object.toString();
  }

  String stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = JsonEncoder.withIndent('  ', toEncodableFallback);
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }

  @override
  void o(obj, { String? tag}) {
    assert(ULog.tojson != null);
    json(ULog.tojson!(obj)??"",tag: tag);
  }

  @override
  void removeLogAdapters(ULogAdapter adapter) {
    _logAdapters.remove(adapter);
  }

  
}