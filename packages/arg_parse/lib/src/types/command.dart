import 'option.dart';
import 'context.dart';
import 'argument.dart';

typedef CommandHandler = void Function(Command cmd, Context context);

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
    final buffer = StringBuffer();

    buffer.writeln(description);
    if (options.isNotEmpty) {
      buffer.writeln("Options:");
      for (final option in options) {
        buffer.writeln("  ${option.help}");
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
      throw ArgumentError("This command does not accept any values");
    }
    super.addValue(value);
  }
}
