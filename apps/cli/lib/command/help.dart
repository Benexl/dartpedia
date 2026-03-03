import 'package:arg_parse/arg_parse.dart';
import 'package:console/console.dart';

Future<void> helpCommand(Command cmd, Context ctx, Console console) async {
  console.print(Card([Text(cmd.help)]));
}
