import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/element2.dart';

/// Extension on [ClassElement].
extension ClassElementExtension on ClassElement2 {
  /// Merges the [ClassElement]'s [FieldElement]s and it's parent's [FieldElement]s.
  List<FieldElement2> get mergedFields {
    final fields = <FieldElement2>[...fields2];

    ClassElement2 currentElement = this;
    while (currentElement.supertype?.element != null) {
      final currentSuperElement = currentElement.supertype!.element3 as ClassElement2;
      fields.addAll(currentSuperElement.fields2);
      currentElement = currentSuperElement;
    }

    return fields;
  }

  /// Formats the type parameters of a class.
  String get formattedTypeParameters {
    return typeParameters2.isNotEmpty ? '<${typeParameters2.map((t) => t.name3).join(', ')}>' : '';
  }

  /// [name] + [formattedTypeParameters].
  String get nameWithTypeParameters {
    return '$name3$formattedTypeParameters';
  }
}
