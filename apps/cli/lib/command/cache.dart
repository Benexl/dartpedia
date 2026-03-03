import 'package:arg_parse/arg_parse.dart';
import 'dart:io';
import '../utils/cache.dart';
import 'package:console/console.dart';

Future<void> cacheCommand(Command cmd, Context ctx, Console console) async {
  FlagOption help = cmd.options[0] as FlagOption;
  if (help.value) {
    console.print(Card([Text(cmd.help)]));
    return;
  }
}

Future<void> cacheClearCommand(
  Command cmd,
  Context ctx,
  Console console,
) async {
  final cache = Cache();
  final confirm = await console.confirm(
    "Are you sure you want to clear the cache(${cache.dir.path})? This action cannot be undone.",
  );
  if (confirm) {
    print("Clearing cache...");
    await cache.clear();
    print("Cache cleared.");
  } else {
    print("Cache clear cancelled.");
  }
}

Future<void> cacheListCommand(Command cmd, Context ctx, Console console) async {
  final cache = Cache();
  await for (var file in cache.dir.list()) {
    if (file is File) {
      print(file.path.split('/').last);
    }
  }
}
