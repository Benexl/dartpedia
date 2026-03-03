import 'package:arg_parse/arg_parse.dart';
import 'package:console/console.dart';
import 'package:wikipedia/wikipedia.dart';

Future<void> searchCommand(Command cmd, Context ctx, Console console) async {
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

  final wikipedia = Wikipedia(
    lang.value as String,
    "Dartpedia/1.0.0 (https://github.com/benexl/dartpedia)",
  );
  print("Searching Wikipedia [${lang.value}] for: $query");
  final result = await wikipedia.getSummary(query);
  await console.clearScreen();
  console.print(
    Card([
      Text(
        result.title,
        bold: true,
        inverse: true,
        span: true,
        align: Align.centre,
      ),
      if (result.description != null)
        Text(
          result.description!,
          italic: true,
          inverse: true,
          span: true,
          align: Align.centre,
        ),
      Text(
        result.extract,
        paddingRight: 2,
        paddingLeft: 2,
        span: true,
        align: Align.right,
      ),
    ]),
  );
}
