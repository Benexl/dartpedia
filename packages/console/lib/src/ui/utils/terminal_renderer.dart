import '../../types/ansi.dart';
import '../../utils/logging.dart';
import 'dart:io';
import '../../types/colors.dart';
import '../../types/alignment.dart';

mixin TerminalRenderer {
  static final _ansiRegex = RegExp(r'\x1b\[[0-?]*[ -/]*[@-~]');
  String applyForegroundColor(String text, Color color) {
    logger.fine('Applying foreground color: $color to text: "$text"');
    RGB rgb = color.toRGB();
    return _apply(Ansi.foregroundTrueColor, {
      'r': rgb.r.toString(),
      'g': rgb.g.toString(),
      'b': rgb.b.toString(),
      'text': text,
    });
  }

  String applyBackgroundColor(String text, Color color) {
    logger.fine('Applying background color: $color to text: "$text"');
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
    int paddingRight = 0,
    int paddingLeft = 0,
    Align align = Align.right,
    bool span = false,
  }) {
    logger.fine(
      'Applying styles to text: "$text" with bold: $bold, italic: $italic, underline: $underline, strikethrough: $strikethrough, dim: $dim, inverse: $inverse, hidden: $hidden, blink: $blink, paddingRight: $paddingRight, paddingLeft: $paddingLeft, align: $align, span: $span',
    );
    final prefix = StringBuffer();
    final suffix = StringBuffer();

    void wrap(Ansi ansi) {
      final parts = ansi.code.split('{text}');
      prefix.write(parts[0]);
      suffix.write(parts[1]);
      logger.fine('Applying style: $ansi to text: "$text"');
    }

    if (bold) wrap(Ansi.bold);
    if (italic) wrap(Ansi.italic);
    if (underline) wrap(Ansi.underline);
    if (strikethrough) wrap(Ansi.strikethrough);
    if (dim) wrap(Ansi.dim);
    if (inverse) wrap(Ansi.inverse);
    if (hidden) wrap(Ansi.hidden);
    if (blink) wrap(Ansi.blinking);
    final String processedText = _applyPadding(
      _foldText(
        text,
        width: stdout.terminalColumns - paddingLeft * 2 - paddingRight * 2,
      ),
      align,
      span,
      paddingRight: paddingRight,
      paddingLeft: paddingLeft,
    );
    if (prefix.isEmpty) return processedText;

    return (StringBuffer()
          ..write(prefix)
          ..write(processedText)
          ..write(suffix))
        .toString();
  }

  String _foldText(String text, {int width = 80}) {
    final lines = <String>[];
    final words = text.split(' ');
    String currentLine = '';

    for (final word in words) {
      if ((currentLine + word).length <= width) {
        currentLine += (currentLine.isEmpty ? '' : ' ') + word;
      } else {
        logger.fine('Adding line: "$currentLine"');
        currentLine = word;
      }
    }
    if (currentLine.isNotEmpty) {
      logger.fine('Adding final line: "$currentLine"');
      lines.add(currentLine);
    }
    return lines.join('\n');
  }

  String _applyPadding(
    String text,
    Align align,
    bool span, {
    int paddingRight = 0,
    int paddingLeft = 0,
  }) {
    logger.fine(
      'Applying padding to text: "$text" with align: $align, span: $span, paddingRight: $paddingRight, paddingLeft: $paddingLeft',
    );
    if (paddingRight > 0) {
      logger.fine('Applying right padding of $paddingRight spaces');
      text = text
          .split("\n")
          .map((line) => line + (' ' * paddingRight))
          .join('\n');
    }
    if (paddingLeft > 0) {
      logger.fine('Applying left padding of $paddingLeft spaces');
      text = text
          .split("\n")
          .map((line) => (' ' * paddingLeft) + line)
          .join('\n');
    }
    if (!span) return text;
    logger.fine('Applying alignment + span: $align to text: "$text"');
    return text
        .split('\n')
        .map((line) {
          int width = stdout.terminalColumns;
          int visibleLength = line.replaceAll(_ansiRegex, '').length;
          int padding = width - visibleLength;
          switch (align) {
            case Align.right:
              return line + (' ' * padding);
            case Align.centre:
              int leftPadding = padding ~/ 2;
              int rightPadding = padding - leftPadding;
              return (' ' * leftPadding) + line + (' ' * rightPadding);
            case Align.left:
              return (' ' * padding) + line;
          }
        })
        .join('\n');
  }

  String _apply(Ansi ansi, Map<String, String> replacements) {
    logger.fine('Applying ANSI code: $ansi with replacements: $replacements');
    return ansi.code.replaceAllMapped(RegExp(r'\{(\w+)\}'), (m) {
      final key = m.group(1);
      return replacements[key] ?? m.group(0)!;
    });
  }
}
