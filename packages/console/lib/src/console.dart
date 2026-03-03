import 'dart:io';
import 'ui/widget.dart';
import 'types/theme.dart';

class Console {
  Theme theme;
  Console(this.theme);

  Future<String> prompt(String message) async {
    stdout.write(message);
    await stdout.flush();
    return stdin.readLineSync() ?? '';
  }

  Future<bool> confirm(String message) async {
    while (true) {
      final response = await prompt('$message (y/n): ');
      if (response.toLowerCase() == 'y') return true;
      if (response.toLowerCase() == 'n') return false;
      stdout.writeln('Please enter "y" or "n".');
      await stdout.flush();
    }
  }

  void print(Widget widget) {
    stdout.write(widget.render(theme));
    stdout.flush();
  }

  Future<void> clearScreen() async {
    stdout.write('\x1B[2J\x1B[0;0H');
    await stdout.flush();
  }
}
