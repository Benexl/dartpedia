import 'widget.dart';
import '../types/colors.dart';
import '../types/style.dart';
import '../types/theme.dart';
import './utils/terminal_renderer.dart';

class Text with TerminalRenderer implements Widget {
  final String text;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool? bold;
  final bool? italic;
  final bool? underline;
  final bool? strikethrough;
  final bool? dim;
  final bool? inverse;
  final bool? hidden;
  final bool? blink;

  @override
  final List<Widget>? children = null;

  const Text(
    this.text, {
    this.foregroundColor,
    this.backgroundColor,
    this.bold,
    this.italic,
    this.underline,
    this.strikethrough,
    this.dim,
    this.inverse,
    this.hidden,
    this.blink,
  });
  @override
  String render(Theme theme, {Style? style}) {
    return applyStyle(
      applyBackgroundColor(
        applyForegroundColor(
          text,
          foregroundColor ?? style?.foreground ?? theme.foreground,
        ),
        backgroundColor ?? style?.background ?? theme.background,
      ),
      bold: bold ?? style?.bold ?? false,
      italic: italic ?? style?.italic ?? false,
      underline: underline ?? style?.underline ?? false,
      strikethrough: strikethrough ?? style?.strikethrough ?? false,
      dim: dim ?? style?.dim ?? false,
      inverse: inverse ?? style?.inverse ?? false,
      hidden: hidden ?? style?.hidden ?? false,
      blink: blink ?? style?.blink ?? false,
    );
  }
}
