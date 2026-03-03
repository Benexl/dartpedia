import 'package:arg_parse/arg_parse.dart';
import 'utils/file.dart';
import 'package:logging/logging.dart';
import 'utils/logging.dart';
import 'dart:io';
import 'package:console/console.dart';
import 'utils/config.dart';

import 'command/cache.dart';
import 'command/search.dart';
import 'utils/themes.dart';

void run(List<String> arguments) {
  Logger.root.level = Level.ALL;
  // Open the file for appending
  final logFile = File(expandHome("~/.dartpedia/dartpedia.log"));
  final logSink = logFile.openWrite(mode: FileMode.append);
  Logger.root.onRecord.listen((record) {
    final logLine =
        '${record.time.toIso8601String()} '
        '[${record.level.name}] '
        '${record.loggerName}: '
        '${record.message}';
    logSink.writeln(logLine); // Write to log file
    if (record.error != null) {
      logSink.writeln('  ERROR: ${record.error}');
    }
    if (record.stackTrace != null) {
      logSink.writeln('  STACKTRACE:\n${record.stackTrace}');
    }
  });

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
          FlagOption logOpt = cmd.options[3] as FlagOption;
          ValueOption logLevelOpt = cmd.options[4] as ValueOption;
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
            print("dartpedia v1.0.0 Copyright © 2024 Benexl projects");
          } else if (help.value) {
            print(cmd.help);
          }

          if (logOpt.value) {
            logger.onRecord.listen((record) {
              final logLine =
                  '${record.time.toIso8601String()} '
                  '[${record.level.name}] '
                  '${record.loggerName}: '
                  '${record.message}';
              print(logLine); // Print to console
              if (record.error != null) {
                print('  ERROR: ${record.error}');
              }
              if (record.stackTrace != null) {
                print('  STACKTRACE:\n${record.stackTrace}');
              }
            });
          }
          if (logOpt.value) {
            switch ((logLevelOpt.value as String).toLowerCase()) {
              case "all":
                Logger.root.level = Level.ALL;
                break;
              case "fine":
                Logger.root.level = Level.FINE;
                break;
              case "debug":
                Logger.root.level = Level.FINE;
                break;
              case "info":
                Logger.root.level = Level.INFO;
                break;
              case "warning":
                Logger.root.level = Level.WARNING;
                break;
              case "error":
                Logger.root.level = Level.SEVERE;
                break;
              default:
                print(
                  "Invalid log level: ${logLevelOpt.value}. Available levels: all, fine, debug, info, warning, error",
                );
                exit(1);
            }
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
          FlagOption("log", "Enable logging"),
          ValueOption(
            "loglevel",
            "Set the logging level (fine,debug, info, warning, error)",
            defaultValue: "info",
            abbr: "l",
          ),
        ],
        subCommands: [
          Command(
            "search",
            "Search for stuff on wikipedia",
            (cmd, ctx) => searchCommand(cmd, ctx, console),
            allowMultiple: true,
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
        ],
      ),
    );
    parser.run();
  } catch (e) {
    console.print(Card([Text("Error: $e")]));
  }
}
