import 'package:arg_parse/arg_parse.dart';
import 'package:console/console.dart';

Future<void> cacheCommand(Command cmd, Context ctx, Console console) async {
  FlagOption help = cmd.options[0] as FlagOption;
  if (help.value) {
    console.print(Card([Text(cmd.help)]));
    return;
  }
}

Future<void> cacheClearCommand(Command cmd, Context ctx) async {
  print("Clearing cache...");
}

Future<void> cacheListCommand(Command cmd, Context ctx) async {
  print("Listing cached articles...");
}
