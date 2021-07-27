enum IdType {
  None,
  DriversLicense,
  ConferenceBadge,
}

extension IdTypeExtension on IdType {
  String get name {
    switch (this) {
      case IdType.None:
        return 'None';
      case IdType.DriversLicense:
        return 'Driver\'s License';
      case IdType.ConferenceBadge:
        return 'Conference Badge';
      default:
        return 'Name Not Set';
    }
  }
}
