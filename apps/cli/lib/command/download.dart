import 'package:arg_parse/arg_parse.dart';
import 'package:console/console.dart';

void downloadCommand(Command cmd, Context ctx, Console console) {
  FlagOption help = cmd.options[2] as FlagOption;
  if (help.value) {
    console.print(Card([Text(cmd.help)]));
    return;
  }

  ValueOption output = cmd.options[0] as ValueOption;
  ValueOption format = cmd.options[1] as ValueOption;
  final article = cmd.values.join(" ");

  if (article.isEmpty) {
    console.print(
      Card([Text("No article specified. Use --help for usage information.")]),
    );
    return;
  }

  final outputPath = output.values.isNotEmpty
      ? " → ${output.values.first}"
      : "";
  print("Downloading \"$article\" as ${format.value}$outputPath");
}
