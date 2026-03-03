import 'option.dart';
import '../utils/logging.dart';
import 'context.dart';
import 'argument.dart';

typedef CommandHandler = Future<void> Function(Command cmd, Context context);

class Command extends Argument {
  final bool allowValues;
  final CommandHandler commandHandler;
  final List<Option> options;
  final List<Command> subCommands;

  Command(
    super.name,
    super.description,
    this.commandHandler, {
    super.abbr,
    this.options = const [],
    this.subCommands = const [],
    super.allowMultiple = false,
    super.valueType = String,
    this.allowValues = false,
  });

  @override
  String get help {
    logger.fine("Generating help for command: $name");
    final buffer = StringBuffer();
    buffer.writeln(
      "Usage: $name${options.isNotEmpty ? " [OPTIONS]" : ""}${subCommands.isNotEmpty ? " COMMAND" : ""}${allowValues ? " [Args${allowMultiple ? "..." : ""}]" : ""}",
    );
    if (options.isNotEmpty) {
      buffer.writeln("Options:");
      for (final option in options) {
        buffer.writeln("  ${option.name}: ${option.description}");
      }
    }
    if (subCommands.isNotEmpty) {
      buffer.writeln("Commands:");
      for (final subCommand in subCommands) {
        buffer.writeln("  ${subCommand.name}: ${subCommand.description}");
      }
    }

    return buffer.toString();
  }

  @override
  void addValue(Object value) {
    if (!allowValues) {
      logger.severe(
        'Values are not allowed for command "$name". This command does not accept any values.',
      );
      throw ArgumentError("This command does not accept any values");
    }
    super.addValue(value);
  }
}
