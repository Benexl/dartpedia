import 'package:arg_parse/arg_parse.dart';
import 'package:console/console.dart';

void cacheCommand(Command cmd, Context ctx, Console console) {
  FlagOption help = cmd.options[0] as FlagOption;
  if (help.value) {
    console.print(Card([Text(cmd.help)]));
    return;
  }
}

void cacheClearCommand(Command cmd, Context ctx) {
  print("Clearing cache...");
}

void cacheListCommand(Command cmd, Context ctx) {
  print("Listing cached articles...");
}
