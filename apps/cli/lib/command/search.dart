import 'package:arg_parse/arg_parse.dart';

void searchCommand(Command cmd, Context ctx) {
  FlagOption help = cmd.options[1] as FlagOption;
  if (help.value) {
    print(cmd.help);
    return;
  }

  ValueOption lang = cmd.options[0] as ValueOption;
  final query = cmd.values.join(" ");

  if (query.isEmpty) {
    print("No search query provided. Use --help for usage information.");
    return;
  }

  print("Searching Wikipedia [${lang.value}] for: $query");
}
