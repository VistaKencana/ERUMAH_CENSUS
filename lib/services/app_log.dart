import 'dart:developer' as dev;

class AppLog {
  final String classname;
  const AppLog({required this.classname});
  void logDebug({required String tag, required String msg}) {
    String message = '''
        $greenAnsi===========   App Log ==============$resetAnsi
        
        Tag: $tag
        Classname: $classname
        Debug :
        $msg

        $greenAnsi===========   End Log   ==============$resetAnsi
        ''';
    dev.log(name: tag, message);
  }

  void logError({required String tag, required String msg}) {
    String message = '''
        $redAnsi===========   App Log ==============$resetAnsi
        
        Tag: $tag
        Classname: $classname
        Error :
        $msg

        $redAnsi===========   End Log   ==============$resetAnsi
        ''';
    dev.log(name: tag, message);
  }

  static void instantLog(
      {required String tag, required String classname, required String msg}) {
    String message = '''
        $cyanAnsi=========== Instant Log ==============$resetAnsi
        
        Tag: $tag
        Classname: $classname
        Error :
        $msg

        $cyanAnsi===========   End Log   ==============$resetAnsi
        ''';
    dev.log(name: tag, message);
  }

  // ANSI color codes
  static const String blackAnsi = '\x1B[30m';
  static const String redAnsi = '\x1B[31m';
  static const String greenAnsi = '\x1B[32m';
  static const String yellowAnsi = '\x1B[33m';
  static const String blueAnsi = '\x1B[34m';
  static const String magentaAnsi = '\x1B[35m';
  static const String cyanAnsi = '\x1B[36m';
  static const String whiteAnsi = '\x1B[37m';
  static const String defaultAnsi = '\x1B[39m';
  static const String resetAnsi = '\x1B[0m';
}
