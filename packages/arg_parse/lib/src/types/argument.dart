import 'dart:collection';
import '../utils/logging.dart';

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
      logger.fine(
        'No value provided for argument "$name". Using default value: $defaultValue',
      );
      if (defaultValue != null) {
        addValue(defaultValue!);
        return _values.first;
      } else {
        logger.severe(
          'No value provided for argument "$name" and no default value set.',
        );
        throw StateError('No value provided for argument "$name".');
      }
    }
    if (allowMultiple) {
      logger.severe(
        'Multiple values provided for argument "$name". Use values instead.',
      );
      throw StateError(
        'Multiple values are allowed for this argument. Use values instead.',
      );
    }
    return _values.first;
  }

  UnmodifiableListView<Object> get values => UnmodifiableListView(_values);

  void addValue(Object value) {
    if (!allowMultiple && _values.isNotEmpty) {
      logger.severe(
        'Multiple values provided for argument "$name". Only one value is allowed.',
      );
      throw ArgumentError('Multiple values are not allowed for this argument.');
    }
    if (value.runtimeType != valueType) {
      logger.severe(
        'Value type ${value.runtimeType} does not match expected type $valueType for argument "$name".',
      );
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
