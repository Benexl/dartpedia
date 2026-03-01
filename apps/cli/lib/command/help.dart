import 'package:arg_parse/arg_parse.dart';
import 'package:console/console.dart';

void helpCommand(Command cmd, Context ctx, Console console) {
  console.print(Card([Text(cmd.help)]));
}
