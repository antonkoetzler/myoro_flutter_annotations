part of 'extended_model.dart';

sealed class AbstractModel {
  const AbstractModel({required this.foo, this.bar});

  final int foo;
  final String? bar;
}
