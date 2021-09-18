
import 'ulog.dart';

abstract class ULogAdapter{
  ///是否开启日志
  bool isLoggable(ULogType type,String? tag);
  ///log 打日志
  void log(ULogType type,String? tag,String? message);
}