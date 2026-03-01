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
}
