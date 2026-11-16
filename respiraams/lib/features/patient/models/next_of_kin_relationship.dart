import '../../../l10n/l10n.dart';

/// Relationship of a next of kin.
///
/// `AddNextOfKin` / `UpdateNextOfKin` accept a free-text relationship, so the
/// app always persists the canonical Vietnamese value — the record stays
/// consistent no matter which language the doctor is using. [other] lets the
/// doctor type the exact relationship instead.
enum NextOfKinRelationship { spouse, parent, child, sibling, grandparent, other }

extension NextOfKinRelationshipX on NextOfKinRelationship {
  /// Value persisted by the API. `null` for [other]: the caller sends the
  /// free text instead.
  String? get storedValue => switch (this) {
        NextOfKinRelationship.spouse => 'Vợ/Chồng',
        NextOfKinRelationship.parent => 'Cha/Mẹ',
        NextOfKinRelationship.child => 'Con',
        NextOfKinRelationship.sibling => 'Anh/Chị/Em',
        NextOfKinRelationship.grandparent => 'Ông/Bà',
        NextOfKinRelationship.other => null,
      };

  String label(AppLocalizations l10n) => switch (this) {
        NextOfKinRelationship.spouse => l10n.relationshipSpouse,
        NextOfKinRelationship.parent => l10n.relationshipParent,
        NextOfKinRelationship.child => l10n.relationshipChild,
        NextOfKinRelationship.sibling => l10n.relationshipSibling,
        NextOfKinRelationship.grandparent => l10n.relationshipGrandparent,
        NextOfKinRelationship.other => l10n.nextOfKinRelationshipOther,
      };
}

/// The selectable options, in display order.
const nextOfKinRelationships = <NextOfKinRelationship>[
  NextOfKinRelationship.spouse,
  NextOfKinRelationship.parent,
  NextOfKinRelationship.child,
  NextOfKinRelationship.sibling,
  NextOfKinRelationship.grandparent,
  NextOfKinRelationship.other,
];

/// Resolves a stored relationship back to an enum value.
///
/// Anything that is not one of the canonical options is treated as [other],
/// with the stored text kept as-is.
NextOfKinRelationship nextOfKinRelationshipFrom(String value) {
  for (final relationship in nextOfKinRelationships) {
    if (relationship.storedValue == value) return relationship;
  }
  return NextOfKinRelationship.other;
}

/// Localized label for a stored relationship value.
String nextOfKinRelationshipLabel(String value, AppLocalizations l10n) {
  final relationship = nextOfKinRelationshipFrom(value);
  return relationship == NextOfKinRelationship.other
      ? value
      : relationship.label(l10n);
}
