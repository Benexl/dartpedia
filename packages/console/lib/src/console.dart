import 'dart:io';
import 'ui/widget.dart';
import 'utils/logging.dart';
import 'types/theme.dart';

class Console {
  Theme theme;
  Console(this.theme);

  Future<String> prompt(String message) async {
    logger.fine('Prompting user: $message');
    stdout.write(message);
    await stdout.flush();
    return stdin.readLineSync() ?? '';
  }

  Future<bool> confirm(String message) async {
    logger.fine('Asking for confirmation: $message');
    while (true) {
      final response = await prompt('$message (y/n): ');
      if (response.toLowerCase() == 'y') return true;
      if (response.toLowerCase() == 'n') return false;
      logger.warning('Invalid input: $response');
      stdout.writeln('Please enter "y" or "n".');
      await stdout.flush();
    }
  }

  void print(Widget widget) {
    logger.fine('Rendering widget: ${widget.runtimeType}');
    stdout.write(widget.render(theme));
    stdout.flush();
  }

  Future<void> clearScreen() async {
    logger.fine('Clearing screen');
    stdout.write('\x1B[2J\x1B[0;0H');
    await stdout.flush();
  }
}
