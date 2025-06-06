/// Annotation class to generate a model.
///
/// Rules with [MyoroModel]:
/// - Every field of a class must have an argument with the same name of the field in the unnamed constructor of the class
/// ```dart
/// class FooClass {
///   final String bar;
///   final int baz;
///
///   const FooClass({
///     required this.bar,    // GOOD: Field is an argument of the class.
///     required String buzz, // BAD: Field is not an argument of the class.
///   }) : baz = buzz;
/// }
/// ```
final class MyoroModel {
  const MyoroModel();
}

/// Const annotation.
const myoroModel = MyoroModel();
