import 'dart:collection';
import 'utils/logging.dart';
import 'types/context.dart';

import 'types/command.dart';
import 'types/option.dart';

class ArgParse {
  final List<String> _rawArgs;
  final List<Command> _parsedArgs = [];
  final Context _context = Context();

  UnmodifiableListView<String> get rawArgs => UnmodifiableListView(_rawArgs);
  UnmodifiableListView<Command> get parsedArgs =>
      UnmodifiableListView(_parsedArgs);

  ArgParse(List<String> args) : _rawArgs = args;
  UnmodifiableListView<Command> parse(Command rootCommand) {
    _parseCommand(rootCommand, _rawArgs);
    return UnmodifiableListView(_parsedArgs);
  }

  void _parseCommand(Command currentCommand, List<String> args) {
    logger.fine("Parsing command: ${currentCommand.name} with args: $args");
    final Map<String, Command> subCommands = {
      for (var cmd in currentCommand.subCommands) cmd.name: cmd,
    };
    logger.fine("Available subcommands: ${subCommands.keys.join(", ")}");

    final Map<String, Option> options = {
      for (var opt in currentCommand.options) opt.name: opt,
      for (var opt in currentCommand.options)
        if (opt.abbr != null) opt.abbr!: opt,
    };
    logger.fine("Available options: ${options.keys.join(", ")}");

    for (int i = 0; i < args.length; i++) {
      var arg = args[i];
      logger.fine("Processing argument: $arg");
      if (_findOption(options, arg) case var option?) {
        logger.fine("Found option: ${option.name}");
        if (option is ValueOption) {
          logger.fine("Option ${option.name} requires a value");
          i++;
          if (i >= args.length) {
            logger.severe(
              "Option ${option.name} requires a value but none was provided",
            );
            throw ArgumentError("Option $arg requires a value");
          }
          option.addValue(args[i]);
          logger.fine("Set option ${option.name} to value: ${args[i]}");
        } else {
          logger.fine("Option ${option.name} is a flag, setting it to true");
          (option as FlagOption).set();
        }
      } else if (subCommands[arg] case var subCommand?) {
        logger.fine(
          "Found subcommand: ${subCommand.name}, parsing it with remaining args: ${args.sublist(i + 1)}",
        );
        _parseCommand(subCommand, args.sublist(i + 1));
        break;
      } else if (currentCommand.allowValues) {
        currentCommand.addValue(arg);
        logger.fine("Added value '$arg' to command ${currentCommand.name}");
      } else {
        logger.severe("No such command or option: $arg");
        throw ArgumentError("No such command: $arg");
      }
    }
    _parsedArgs.add(currentCommand);
    logger.fine("Finished parsing command: ${currentCommand.name}");
  }

  Future<void> run() async {
    logger.fine("Running commands in context: $_context");
    for (int i = _parsedArgs.length - 1; i >= 0; i--) {
      var cmd = _parsedArgs[i];
      _context.hasSubcommand = (i - 1 > 0);
      logger.fine(
        "Executing command: ${cmd.name} hasSubcommand: ${_context.hasSubcommand}",
      );
      await cmd.commandHandler(cmd, _context);
      logger.fine("Finished running command: ${cmd.name}");
    }
    logger.fine("Finished running all commands");
  }

  Option? _findOption(Map<String, Option> options, String arg) {
    logger.fine("Looking for option matching argument: $arg");
    if (arg.startsWith("--") || arg.startsWith("-")) {
      logger.fine("Argument $arg looks like an option, checking options map");
      if (arg.startsWith("--")) {
        logger.fine("Argument $arg is a long option, stripping '--' prefix");
        arg = arg.substring(2);
      } else {
        logger.fine("Argument $arg is a short option, stripping '-' prefix");
        arg = arg.substring(1);
      }
      var option = options[arg];
      if (option == null) {
        logger.severe("No such option: $arg");
        throw ArgumentError("No such option: $arg");
      } else {
        logger.fine("Found option: ${option.name} for argument: $arg");
        return option;
      }
    } else {
      logger.fine("Argument $arg does not look like an option");
      return null;
    }
  }
}
