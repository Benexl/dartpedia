enum Ansi {
  escape(Ansi._esc),
  foregroundTrueColor("${Ansi._esc}[38;2;{r};{g};{b}m{text}${Ansi._esc}[39m"),
  backgroundTrueColor("${Ansi._esc}[48;2;{r};{g};{b}m{text}${Ansi._esc}[49m"),
  bold("${Ansi._esc}[1m{text}${Ansi._esc}[22m"),
  dim("${Ansi._esc}[2m{text}${Ansi._esc}[22m"),
  italic("${Ansi._esc}[3m{text}${Ansi._esc}[23m"),
  underline("${Ansi._esc}[4m{text}${Ansi._esc}[24m"),
  blinking("${Ansi._esc}[5m{text}${Ansi._esc}[25m"),
  inverse("${Ansi._esc}[7m{text}${Ansi._esc}[27m"),
  hidden("${Ansi._esc}[8m{text}${Ansi._esc}[28m"),
  strikethrough("${Ansi._esc}[9m{text}${Ansi._esc}[29m");

  static const _esc = '\x1B';

  final String code;
  const Ansi(this.code);
}
