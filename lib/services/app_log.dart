import 'dart:developer' as dev;

class AppLog {
  final String classname;
  const AppLog({required this.classname});

  void log({required String tag, required String msg}) {
    String message = '''
        ===========   App Log ==============
        
        Tag: $tag
        Classname: $classname
        Error :
        $msg

        ===========   End Log   ==============
        ''';
    dev.log(name: tag, message);
  }

  void logDebug({required String tag, required String msg}) {
    String message = '''
        ===========   App Log ==============
        
        Tag: $tag
        Classname: $classname
        Debug :
        $msg

        ===========   End Log   ==============
        ''';
    dev.log(name: tag, message);
  }

  static void instantLog(
      {required String tag, required String classname, required String msg}) {
    String message = '''
        =========== Instant Log ==============
        
        Tag: $tag
        Classname: $classname
        Error :
        $msg

        ===========   End Log   ==============
        ''';
    dev.log(name: tag, message);
  }
}
