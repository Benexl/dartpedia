import 'package:arg_parse/arg_parse.dart';

void historyCommand(Command cmd, Context ctx) {
  FlagOption help = cmd.options[2] as FlagOption;
  if (help.value) {
    print(cmd.help);
    return;
  }

  FlagOption clear = cmd.options[0] as FlagOption;
  if (clear.value) {
    print("Clearing history...");
    return;
  }

  ValueOption limit = cmd.options[1] as ValueOption;
  print("Showing last ${limit.value} history entries...");
}
