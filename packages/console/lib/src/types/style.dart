import 'colors.dart';

class Style {
  final Color? background;
  final Color? foreground;
  final bool? bold;
  final bool? italic;
  final bool? underline;
  final bool? strikethrough;
  final bool? dim;
  final bool? inverse;
  final bool? hidden;
  final bool? blink;
  Style({
    this.background,
    this.foreground,
    this.bold,
    this.italic,
    this.underline,
    this.strikethrough,
    this.dim,
    this.inverse,
    this.hidden,
    this.blink,
  });
}
