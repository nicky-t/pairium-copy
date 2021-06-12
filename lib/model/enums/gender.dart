enum Gender {
  man,
  woman,
  other,
}

extension GenderExtension on Gender {
  String get name {
    switch (this) {
      case Gender.man:
        return '男性';

      case Gender.woman:
        return '女性';

      case Gender.other:
        return 'その他';
    }
  }
}
