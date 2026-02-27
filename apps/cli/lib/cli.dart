import 'package:arg_parse/arg_parse.dart';

import 'command/cache.dart';
import 'command/download.dart';
import 'command/help.dart';
import 'command/history.dart';
import 'command/search.dart';

void run(List<String> arguments) {
  try {
    ArgParse parser = ArgParse(arguments);
    parser.parse(
      Command(
        "dartpedia",
        "Browse wikipedia from your terminal",
        (Command cmd, Context ctx) {
          FlagOption version = cmd.options[0] as FlagOption;
          FlagOption help = cmd.options[1] as FlagOption;
          if (version.value) {
            print("Dartpedia v1.0.0 Copyright © 2024 Benexl projects");
          } else if (help.value) {
            print(cmd.help);
          } else {
            print("No command provided. Use --help for usage information.");
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
            searchCommand,
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
            helpCommand,
            allowValues: true,
          ),
          Command(
            "cache",
            "Manage the dartpedia cache",
            cacheCommand,
            options: [FlagOption("help", "Show help information", abbr: "h")],
            subCommands: [
              Command("clear", "Clear all cached content", cacheClearCommand),
              Command("list", "List cached articles", cacheListCommand),
            ],
          ),
          Command(
            "download",
            "Download content from wikipedia",
            downloadCommand,
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
            historyCommand,
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
    print("$e");
  }
}
