import 'argument.dart';

class Option extends Argument {
  Option(
    super.name,
    super.description, {
    super.abbr,
    super.defaultValue,
    super.allowMultiple,
    super.valueType,
  });
}

class ValueOption extends Option {
  ValueOption(
    super.name,
    super.description, {
    super.defaultValue,
    super.abbr,
    super.allowMultiple = false,
    super.valueType = String,
  });
  @override
  String get help =>
      "$name${abbr != null ? ", $abbr" : ""} <$valueType${allowMultiple ? " ..." : ""}>: $description";
}

class FlagOption extends Option {
  FlagOption(super.name, super.description, {super.abbr})
    : super(defaultValue: false, allowMultiple: false, valueType: bool);

  @override
  String get help => "$name${abbr != null ? ", $abbr" : ""}: $description";

  @override
  bool get value => super.value as bool;

  @override
  void setValue(Object value) {
    throw ArgumentError('Flag options can only be set to true. use set');
  }

  void set() {
    addValue(true);
  }
}
