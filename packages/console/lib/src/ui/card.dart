import 'widget.dart';
import '../utils/logging.dart';
import '../types/style.dart';
import '../types/theme.dart';
import './utils/terminal_renderer.dart';

class Card with TerminalRenderer implements Widget {
  final Style? style;
  @override
  final List<Widget> children;

  const Card(this.children, {this.style});

  @override
  String render(Theme theme, {Style? style}) {
    logger.fine('Rendering Card with style: $style and theme: $theme');
    StringBuffer buffer = StringBuffer();
    for (var child in children) {
      buffer.writeln(child.render(theme, style: this.style ?? style));
    }
    return buffer.toString();
  }
}
