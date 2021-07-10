class _VersionConstant {
  static const String versionOne = 'v1';
}

class FirestoreDocumentRoot {
  static const String user = 'user/${_VersionConstant.versionOne}';
  static const String partner = 'partner/${_VersionConstant.versionOne}';
  static const String monthDairy =
      'partner/${_VersionConstant.versionOne}/monthDairy';
}
