import 'package:arg_parse/arg_parse.dart';
import 'dart:io';
import 'package:console/console.dart';
import 'utils/config.dart';

import 'command/cache.dart';
import 'command/download.dart';
import 'command/history.dart';
import 'command/search.dart';
import 'utils/themes.dart';

void run(List<String> arguments) {
  final themesAvailable = {
    for (var theme in AppTheme.values) theme.name: theme,
  };
  final console = Console(AppTheme.wikipediaClassic.theme);
  try {
    ArgParse parser = ArgParse(arguments);
    final config = Config().content;
    parser.parse(
      Command(
        "dartpedia",
        "Browse wikipedia from your terminal",
        (Command cmd, Context ctx) async {
          ctx.obj = {"config": config};
          FlagOption version = cmd.options[0] as FlagOption;
          FlagOption help = cmd.options[1] as FlagOption;
          ValueOption themeOpt = cmd.options[2] as ValueOption;
          if (themeOpt.values.isNotEmpty || config["theme"] != null) {
            final theme = themeOpt.values.isNotEmpty
                ? themeOpt.value
                : config["theme"];
            if (themesAvailable.containsKey(theme)) {
              console.theme = themesAvailable[theme]!.theme;
            } else {
              print(
                "Invalid theme: $theme. Available themes: ${themesAvailable.keys.join(", ")}",
              );
              exit(1);
            }
          }

          if (version.value) {
            console.print(
              Card([Text("Dartpedia v1.0.0 Copyright © 2024 Benexl projects")]),
            );
          } else if (help.value) {
            console.print(Card([Text(cmd.help)]));
          }
        },
        options: [
          FlagOption("version", "Show version information", abbr: "v"),
          FlagOption("help", "Show help information", abbr: "h"),
          ValueOption(
            "theme",
            "Choose a theme for the console output",
            abbr: "t",
          ),
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
            "cache",
            "Manage the dartpedia cache",
            (cmd, ctx) => cacheCommand(cmd, ctx, console),
            options: [FlagOption("help", "Show help information", abbr: "h")],
            subCommands: [
              Command(
                "clear",
                "Clear all cached content",
                (cmd, ctx) => cacheClearCommand(cmd, ctx, console),
              ),
              Command(
                "list",
                "List cached articles",
                (cmd, ctx) => cacheListCommand(cmd, ctx, console),
              ),
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
