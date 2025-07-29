// ignore_for_file: avoid_print

import 'dart:io';

void main() async {
  // 🛑 Handle Ctrl+C
  ProcessSignal.sigint.watch().listen((signal) {
    printRed("\n🛑 Process interrupted by user (Ctrl+C). Exiting...");
    exit(130);
  });

  final currentDir = Directory.current.path;
  printBlue("📂 Current directory: $currentDir");

  // Check for changes
  final statusResult = await Process.run('git', ['status', '--porcelain']);
  if ((statusResult.stdout as String).trim().isEmpty) {
    printYellow("⚠ No changes to commit. Working tree clean.");
    exit(0);
  }

  // Prompt: Commit message
  stdout.write("✍️  Enter commit message: ");
  final commitMessage = stdin.readLineSync();
  final sanitized = commitMessage?.replaceAll('"', '\\"');
  if (sanitized == null || sanitized.trim().isEmpty) {
    printRed("❌ Commit message is required.");
    exit(1);
  }

  // Prompt: Branch name
  stdout.write("🌿 Enter branch name to push to (e.g., main): ");
  final branch = stdin.readLineSync();
  if (branch == null || branch.trim().isEmpty) {
    printRed("❌ Branch name is required.");
    exit(1);
  }

  // Confirm before pushing
  stdout.write(
      "🚀 Confirm push to '$branch' with message '$commitMessage'? (y/n): ");
  final confirm = stdin.readLineSync()?.toLowerCase();
  if (confirm != 'y') {
    printYellow("❌ Push cancelled by user.");
    exit(0);
  }

  // Run git commands
  await run("git", ["add", "."]);
  await run("git", ["commit", "-m", sanitized]);
  await run("git", ["push", "origin", branch]);

  printGreen("✅ Pushed to '$branch' successfully.");
}

Future<void> run(String command, [List<String> args = const []]) async {
  print("➡️ $command ${args.join(' ')}");
  final process = await Process.start(
    command,
    args,
    runInShell: true,
  );

  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);

  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    printRed("❌ Command failed: $command ${args.join(' ')}");
    exit(exitCode);
  }
}

// Color print helpers
const _reset = '\x1B[0m';
const _red = '\x1B[31m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _blue = '\x1B[34m';

void printRed(String msg) => print('$_red$msg$_reset');
void printGreen(String msg) => print('$_green$msg$_reset');
void printYellow(String msg) => print('$_yellow$msg$_reset');
void printBlue(String msg) => print('$_blue$msg$_reset');
