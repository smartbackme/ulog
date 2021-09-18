
import 'package:flutter_ulog/src/ulog.dart';
///log格式处理
abstract class ULogFormatStrategy{
  ///log 打日志
  void log(ULogType type,String? tag,String? message);
}