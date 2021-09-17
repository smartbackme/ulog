
import 'package:flutter_ulog/src/ulog.dart';
import 'package:flutter_ulog/src/ulog_lib_console_format_strategy.dart';

import 'i_ulog_adapter.dart';
import 'i_ulog_format_strategy.dart';

abstract class ULogConsoleAdapter implements ULogAdapter {
  final ULogFormatStrategy _formatStrategy;
  ULogConsoleAdapter({ULogFormatStrategy? formatStrategy}):_formatStrategy = formatStrategy?? ULogLibConsoleFormatStrategy();

  @override
  bool isLoggable(ULogType type, String? tag) => true;

  @override
  void log(ULogType type, String? tag, String? message) {
    _formatStrategy.log(type, tag, message);
  }

}