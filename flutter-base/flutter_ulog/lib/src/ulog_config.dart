
abstract class ULogConfig {

  DataParser injectParser();

}

abstract class DataParser {
  String toJson(dynamic src);
  // String toMessage(dynamic message);
}