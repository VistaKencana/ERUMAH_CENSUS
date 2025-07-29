// ignore_for_file: avoid_print

import 'dart:io';

void main() async {
  final rootDir = Directory.current.path; // Save the starting directory

  printGreen("Starting the build script...");
  await run("flutter clean", dir: rootDir);
  await run("flutter pub get", dir: rootDir);

  stdout.write("$_yellow Do you want to build APK? (y/N): $_reset");
  final input = stdin.readLineSync();

  if (input?.toLowerCase() == 'y') {
    printBlue("Building APK...");
    await run("flutter build apk", dir: rootDir);
  }
  printGreen("Script completed successfully! 🎉");

  // Just in case: restore working directory (for further logic in script)
  Directory.current = rootDir;
}

Future<void> run(String command, {required String dir}) async {
  print("> Running: $command in $dir");
  final parts = command.split(' ');
  final process = await Process.start(
    parts.first,
    parts.sublist(1),
    workingDirectory: dir,
    runInShell: true,
  );

  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);

  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    throw Exception("Command failed: $command");
  }
}

const _reset = '\x1B[0m';
const _red = '\x1B[31m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _blue = '\x1B[34m';

void printRed(String message) => print('$_red$message$_reset');
void printGreen(String message) => print('$_green$message$_reset');
void printYellow(String message) => print('$_yellow$message$_reset');
void printBlue(String message) => print('$_blue$message$_reset');
