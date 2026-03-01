import '../types/theme.dart';
import '../types/style.dart';

abstract class Widget {
  final List<Widget>? children;
  const Widget({this.children});
  String render(Theme theme, {Style? style});
}
