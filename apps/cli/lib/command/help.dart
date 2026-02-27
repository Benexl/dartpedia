import 'package:arg_parse/arg_parse.dart';

void helpCommand(Command cmd, Context ctx) {
  print(cmd.help);
}
