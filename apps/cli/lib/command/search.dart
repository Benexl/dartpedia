import 'package:arg_parse/arg_parse.dart';
import 'package:console/console.dart';

void searchCommand(Command cmd, Context ctx, Console console) {
  FlagOption help = cmd.options[1] as FlagOption;
  if (help.value) {
    console.print(Card([Text(cmd.help)]));
    return;
  }

  ValueOption lang = cmd.options[0] as ValueOption;
  final query = cmd.values.join(" ");

  if (query.isEmpty) {
    console.print(
      Card([
        Text("No search query provided. Use --help for usage information."),
      ]),
    );
    return;
  }

  print("Searching Wikipedia [${lang.value}] for: $query");
}
