import 'dart:io';
import 'ui/widget.dart';
import 'types/theme.dart';

class Console {
  final Theme theme;
  const Console(this.theme);

  void print(Widget widget) {
    stdout.write(widget.render(theme));
    stdout.flush();
  }

  Future<void> clearScreen() async {
    stdout.write('\x1B[2J\x1B[0;0H');
    await stdout.flush();
  }
}
