import 'package:analyzer/dart/element/element.dart';

/// Extension on [ClassElement].
extension ClassElementExtension on ClassElement {
  /// Merges the [ClassElement]'s [FieldElement]s and its parent's [FieldElement]s.
  List<FieldElement> get mergedFields {
    final result = <FieldElement>[...fields];

    ClassElement currentElement = this;
    while (currentElement.supertype?.element != null) {
      final currentSuperElement = currentElement.supertype!.element as ClassElement;
      result.addAll(currentSuperElement.fields);
      currentElement = currentSuperElement;
    }

    return result;
  }

  /// Formats the type parameters of a class.
  String get formattedTypeParameters {
    return typeParameters.isNotEmpty ? '<${typeParameters.map((t) => t.name ?? '').join(', ')}>' : '';
  }

  /// [name] + [formattedTypeParameters].
  String get nameWithTypeParameters {
    return '${name ?? ''}$formattedTypeParameters';
  }
}
