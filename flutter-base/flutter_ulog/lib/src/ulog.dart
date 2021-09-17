import 'dart:math';


import 'i_ulog_adapter.dart';
import 'i_ulog_printer.dart';
import 'ulog_config.dart';
import 'ulog_lib_printer.dart';

enum ULogType{
  verbose,
  debug,
  info,
  warning,
  error
}

class ULog{

  static ULogPrinter printer = ULogLibPrinter();

  static ULogConfig? config;

  static void init(ULogConfig conf){
    config = conf;
  }

  static void addLogAdapter(ULogAdapter adapter) {
    printer.addAdapter(adapter);
  }

  static void clearLogAdapters() {
    printer.clearLogAdapters();
  }

  static void removeLogAdapters(ULogAdapter adapter) {
    printer.removeLogAdapters(adapter);
  }

  /// Log a message at level [ULogType.verbose].
  static void v(dynamic message,{dynamic error, String? tag}){
    _log(ULogType.verbose,message,error :error,tag: tag);
  }

  /// Log a message at level [ULogType.debug].
  static void d(dynamic message,{dynamic error, String? tag}){
    _log(ULogType.debug,message,error :error,tag: tag);
  }

  /// Log a message at level [ULogType.info].
  static void i(dynamic message,{dynamic error, String? tag}){
    _log(ULogType.info,message,error :error,tag: tag);
  }

  /// Log a message at level [ULogType.warning].
  static void w(dynamic message,{dynamic error, String? tag}){
    _log(ULogType.warning,message,error :error,tag: tag);
  }

  /// Log a message at level [ULogType.error].
  static void e(dynamic message,{dynamic error, String? tag}){
    _log(ULogType.error,message,error :error,tag: tag);
  }

  static void json(String json,{String? tag}) {
    printer.json(json,tag: tag);
  }

  // static void xml(String xml,{String? tag}) {
  //   printer.xml(xml,tag:tag);
  // }

  static void o(dynamic obj,{String? tag}) {
    printer.o(obj,tag: tag);
  }


  static void _log(ULogType type,dynamic message,{dynamic error, String? tag}){
    printer.log(type,message,error: error,tag: tag);
  }

}