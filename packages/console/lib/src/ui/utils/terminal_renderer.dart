import '../../types/ansi.dart';
import '../../types/colors.dart';

mixin TerminalRenderer {
  String applyForegroundColor(String text, Color color) {
    RGB rgb = color.toRGB();
    return _apply(Ansi.foregroundTrueColor, {
      'r': rgb.r.toString(),
      'g': rgb.g.toString(),
      'b': rgb.b.toString(),
      'text': text,
    });
  }

  String applyBackgroundColor(String text, Color color) {
    RGB rgb = color.toRGB();
    return _apply(Ansi.backgroundTrueColor, {
      'r': rgb.r.toString(),
      'g': rgb.g.toString(),
      'b': rgb.b.toString(),
      'text': text,
    });
  }

  String applyStyle(
    String text, {
    bool bold = false,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
    bool dim = false,
    bool inverse = false,
    bool hidden = false,
    bool blink = false,
  }) {
    final prefix = StringBuffer();
    final suffix = StringBuffer();

    void wrap(Ansi ansi) {
      final parts = ansi.code.split('{text}');
      prefix.write(parts[0]);
      suffix.write(parts[1]);
    }

    if (bold) wrap(Ansi.bold);
    if (italic) wrap(Ansi.italic);
    if (underline) wrap(Ansi.underline);
    if (strikethrough) wrap(Ansi.strikethrough);
    if (dim) wrap(Ansi.dim);
    if (inverse) wrap(Ansi.inverse);
    if (hidden) wrap(Ansi.hidden);
    if (blink) wrap(Ansi.blinking);

    if (prefix.isEmpty) return text;

    return (StringBuffer()
          ..write(prefix)
          ..write(text)
          ..write(suffix))
        .toString();
  }

  String _apply(Ansi ansi, Map<String, String> replacements) {
    return ansi.code.replaceAllMapped(RegExp(r'\{(\w+)\}'), (m) {
      final key = m.group(1);
      return replacements[key] ?? m.group(0)!;
    });
  }
}
