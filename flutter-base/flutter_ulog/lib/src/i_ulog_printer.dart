
import 'i_ulog_adapter.dart';
import 'ulog.dart';

abstract class ULogPrinter{


  void clearLogAdapters();
  void addAdapter(ULogAdapter adapter);
  void removeLogAdapters(ULogAdapter  adapter);
  // void xml(String xml,{String? tag});
  void o(dynamic obj,{String? tag});
  void json(String json,{String? tag});
  void log(ULogType type,dynamic message,{dynamic error, String? tag});
}