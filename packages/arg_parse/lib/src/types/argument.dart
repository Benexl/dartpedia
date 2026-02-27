import 'dart:collection';

class Argument {
  final String name;
  final String description;
  final String? abbr;
  final bool allowMultiple;
  final Type valueType;
  final Object? defaultValue;

  final List<Object> _values = <Object>[];

  Argument(
    this.name,
    this.description, {
    this.abbr,
    this.defaultValue,
    this.allowMultiple = false,
    this.valueType = String,
  });

  String get help => "$name${abbr != null ? ", $abbr" : ""}: $description";

  Object get value {
    if (_values.isEmpty) {
      if (defaultValue != null) {
        addValue(defaultValue!);
        return _values.first;
      } else {
        throw StateError('No value provided for argument "$name".');
      }
    }
    if (allowMultiple) {
      throw StateError(
        'Multiple values are allowed for this argument. Use values instead.',
      );
    }
    return _values.first;
  }

  UnmodifiableListView<Object> get values => UnmodifiableListView(_values);

  void addValue(Object value) {
    if (!allowMultiple && _values.isNotEmpty) {
      throw ArgumentError('Multiple values are not allowed for this argument.');
    }
    if (value.runtimeType != valueType) {
      throw ArgumentError(
        'Value type ${value.runtimeType} does not match expected type $valueType.',
      );
    }
    _values.add(value);
  }

  void setValue(Object value) {
    if (allowMultiple) {
      throw ArgumentError(
        'Multiple values are allowed for this argument. Use addValue instead.',
      );
    }
    if (value.runtimeType != valueType) {
      throw ArgumentError(
        'Value type ${value.runtimeType} does not match expected type $valueType.',
      );
    }
    _values
      ..clear()
      ..add(value);
  }

  @override
  String toString() {
    return help;
  }
}
