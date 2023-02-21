// ignore_for_file: constant_identifier_names

enum LogLevel {
  Debug,
  Info,
  Error,
}
//  to compare whether one log level is lower or equal to the other.
extension LogLevelExtensions on LogLevel {
  bool operator <=(LogLevel logLevel) {
    return index <= logLevel.index;
  }
}
