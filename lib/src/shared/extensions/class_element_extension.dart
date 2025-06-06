import 'package:analyzer/dart/element/element.dart';

/// Extension on [ClassElement].
extension ClassElementExtension on ClassElement {
  /// Merges the [ClassElement]'s [FieldElement]s and it's parent's [FieldElement]s.
  List<FieldElement> get mergedFields {
    final fields = <FieldElement>[...this.fields];

    ClassElement currentElement = this;
    while (currentElement.supertype?.element != null) {
      final currentSuperElement = currentElement.supertype!.element as ClassElement;
      fields.addAll(currentSuperElement.fields);
      currentElement = currentSuperElement;
    }

    return fields;
  }

  /// Formats the type parameters of a class.
  String get formattedTypeParameters {
    return typeParameters.isNotEmpty ? '<${typeParameters.map((t) => t.name).join(', ')}>' : '';
  }
}
