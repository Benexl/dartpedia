import 'dart:collection';
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
    final Map<String, Command> subCommands = {
      for (var cmd in currentCommand.subCommands) cmd.name: cmd,
    };

    final Map<String, Option> options = {
      for (var opt in currentCommand.options) opt.name: opt,
      for (var opt in currentCommand.options)
        if (opt.abbr != null) opt.abbr!: opt,
    };
    for (int i = 0; i < args.length; i++) {
      var arg = args[i];
      if (_findOption(options, arg) case var option?) {
        if (option is ValueOption) {
          i++;
          if (i >= args.length) {
            throw ArgumentError("Option $arg requires a value");
          }
          option.addValue(args[i]);
        } else {
          (option as FlagOption).set();
        }
      } else if (subCommands[arg] case var subCommand?) {
        _parseCommand(subCommand, args.sublist(i + 1));
        break;
      } else if (currentCommand.allowValues) {
        currentCommand.addValue(arg);
      } else {
        throw ArgumentError("No such command: $arg");
      }
    }
    _parsedArgs.add(currentCommand);
  }

  void run() {
    for (int i = _parsedArgs.length - 1; i >= 0; i--) {
      var cmd = _parsedArgs[i];
      _context.hasSubcommand = (i - 1 > 0);
      cmd.commandHandler(cmd, _context);
    }
  }

  Option? _findOption(Map<String, Option> options, String arg) {
    if (arg.startsWith("--") || arg.startsWith("-")) {
      if (arg.startsWith("--")) {
        arg = arg.substring(2);
      } else {
        arg = arg.substring(1);
      }
      var option = options[arg];
      if (option == null) {
        throw ArgumentError("No such option: $arg");
      } else {
        return option;
      }
    } else {
      return null;
    }
  }
}
