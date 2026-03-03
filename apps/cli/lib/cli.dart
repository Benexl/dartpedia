import 'package:arg_parse/arg_parse.dart';
import 'package:console/console.dart';

import 'command/cache.dart';
import 'command/download.dart';
import 'command/help.dart';
import 'command/history.dart';
import 'command/search.dart';
import 'utils/themes.dart';

void run(List<String> arguments) {
  final console = Console(AppTheme.wikipediaClassic.theme);
  try {
    ArgParse parser = ArgParse(arguments);
    parser.parse(
      Command(
        "dartpedia",
        "Browse wikipedia from your terminal",
        (Command cmd, Context ctx) async {
          FlagOption version = cmd.options[0] as FlagOption;
          FlagOption help = cmd.options[1] as FlagOption;

          if (version.value) {
            console.print(
              Card([Text("Dartpedia v1.0.0 Copyright © 2024 Benexl projects")]),
            );
          } else if (help.value) {
            console.print(Card([Text(cmd.help)]));
          } else {
            console.print(
              Card([
                Text("Dartpedia", bold: true),
                Text("Browse Wikipedia from your terminal"),
                Text("Run dartpedia --help for usage information"),
              ]),
            );
          }
        },
        options: [
          FlagOption("version", "Show version information", abbr: "v"),
          FlagOption("help", "Show help information", abbr: "h"),
        ],
        subCommands: [
          Command(
            "search",
            "Search for stuff on wikipedia",
            (cmd, ctx) => searchCommand(cmd, ctx, console),
            allowValues: true,
            options: [
              ValueOption(
                "lang",
                "Language edition to search in",
                abbr: "l",
                defaultValue: "en",
              ),
              FlagOption("help", "Show help information", abbr: "h"),
            ],
          ),
          Command(
            "help",
            "Get help / usage on any command",
            (cmd, ctx) => helpCommand(cmd, ctx, console),
            allowValues: true,
          ),
          Command(
            "cache",
            "Manage the dartpedia cache",
            (cmd, ctx) => cacheCommand(cmd, ctx, console),
            options: [FlagOption("help", "Show help information", abbr: "h")],
            subCommands: [
              Command("clear", "Clear all cached content", cacheClearCommand),
              Command("list", "List cached articles", cacheListCommand),
            ],
          ),
          Command(
            "download",
            "Download content from wikipedia",
            (cmd, ctx) => downloadCommand(cmd, ctx, console),
            allowValues: true,
            options: [
              ValueOption("output", "Output file path", abbr: "o"),
              ValueOption(
                "format",
                "Output format (text, html, pdf)",
                abbr: "f",
                defaultValue: "text",
              ),
              FlagOption("help", "Show help information", abbr: "h"),
            ],
          ),
          Command(
            "history",
            "Show command history",
            (cmd, ctx) => historyCommand(cmd, ctx, console),
            options: [
              FlagOption("clear", "Clear the history", abbr: "c"),
              ValueOption(
                "limit",
                "Number of entries to show",
                abbr: "n",
                defaultValue: "20",
              ),
              FlagOption("help", "Show help information", abbr: "h"),
            ],
          ),
        ],
      ),
    );
    parser.run();
  } catch (e) {
    console.print(Card([Text("Error: $e")]));
  }
}
