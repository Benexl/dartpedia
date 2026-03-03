import 'widget.dart';
import '../types/alignment.dart';
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
  final bool? span;
  final Align? align;
  final int? paddingRight;
  final int? paddingLeft;

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
    this.span,
    this.align,
    this.paddingRight,
    this.paddingLeft,
  });
  @override
  String render(Theme theme, {Style? style}) {
    return applyBackgroundColor(
      applyForegroundColor(
        applyStyle(
          text,
          bold: bold ?? style?.bold ?? false,
          italic: italic ?? style?.italic ?? false,
          underline: underline ?? style?.underline ?? false,
          strikethrough: strikethrough ?? style?.strikethrough ?? false,
          dim: dim ?? style?.dim ?? false,
          inverse: inverse ?? style?.inverse ?? false,
          hidden: hidden ?? style?.hidden ?? false,
          blink: blink ?? style?.blink ?? false,
          span: span ?? style?.span ?? false,
          align: align ?? style?.align ?? Align.right,
          paddingLeft: paddingLeft ?? style?.paddingLeft ?? 0,
          paddingRight: paddingRight ?? style?.paddingRight ?? 0,
        ),
        foregroundColor ?? style?.foreground ?? theme.foreground,
      ),
      backgroundColor ?? style?.background ?? theme.background,
    );
  }
}
