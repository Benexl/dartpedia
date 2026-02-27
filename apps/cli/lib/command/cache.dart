import 'package:arg_parse/arg_parse.dart';

void cacheCommand(Command cmd, Context ctx) {
  FlagOption help = cmd.options[0] as FlagOption;
  if (help.value) {
    print(cmd.help);
    return;
  }
}

void cacheClearCommand(Command cmd, Context ctx) {
  print("Clearing cache...");
}

void cacheListCommand(Command cmd, Context ctx) {
  print("Listing cached articles...");
}
