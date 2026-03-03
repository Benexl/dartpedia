import 'package:arg_parse/arg_parse.dart';
import '../utils/cache.dart';
import 'package:console/console.dart';
import 'package:wikipedia/wikipedia.dart';

Future<void> searchCommand(Command cmd, Context ctx, Console console) async {
  FlagOption help = cmd.options[1] as FlagOption;
  if (help.value) {
    print(cmd.help);
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
  final cache = Cache();

  print("Searching Wikipedia [${lang.value}] for: $query");
  try {
    final WikipediaResult result;
    if (await cache.get("search_${lang.value}_$query")
        case var wikipediaData?) {
      result = WikipediaResult.fromJson(wikipediaData);
    } else {
      final wikipedia = Wikipedia(
        lang.value as String,
        "Dartpedia/1.0.0 (https://github.com/benexl/dartpedia)",
      );
      result = await wikipedia.getSummary(query);
      await cache.save("search_${lang.value}_$query", result.toJson());
    }
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
  } catch (e) {
    console.print(Card([Text("Error: ${e.toString()}")]));
    return;
  }
}
