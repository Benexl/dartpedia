import 'package:arg_parse/arg_parse.dart';

void downloadCommand(Command cmd, Context ctx) {
  FlagOption help = cmd.options[2] as FlagOption;
  if (help.value) {
    print(cmd.help);
    return;
  }

  ValueOption output = cmd.options[0] as ValueOption;
  ValueOption format = cmd.options[1] as ValueOption;
  final article = cmd.values.join(" ");

  if (article.isEmpty) {
    print("No article specified. Use --help for usage information.");
    return;
  }

  final outputPath = output.values.isNotEmpty
      ? " → ${output.values.first}"
      : "";
  print("Downloading \"$article\" as ${format.value}$outputPath");
}
