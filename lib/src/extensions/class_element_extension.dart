import 'package:analyzer/dart/element/element.dart';

/// Extension on [ClassElement].
extension ClassElementExtension on ClassElement {
  /// Returns [ClassElement.fields] and [ClassElement.super
  List<FieldElement> get mergedFields {
    final superElement = supertype?.element != null ? supertype!.element as ClassElement : null;
    return [...?superElement?.fields, ...fields];
  }
}
