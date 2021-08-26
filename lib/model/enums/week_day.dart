enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension WeekDayExtension on WeekDay {
  String get label {
    switch (this) {
      case WeekDay.monday:
        return 'Monday';
      case WeekDay.tuesday:
        return 'Tuesday';
      case WeekDay.wednesday:
        return 'Wednesday';
      case WeekDay.thursday:
        return 'Thursday';
      case WeekDay.friday:
        return 'Friday';
      case WeekDay.saturday:
        return 'Saturday';
      case WeekDay.sunday:
        return 'Sunday';
    }
  }
}

WeekDay getWeekDayFromNumber(int number) {
  switch (number) {
    case 1:
      return WeekDay.monday;
    case 2:
      return WeekDay.tuesday;
    case 3:
      return WeekDay.wednesday;
    case 4:
      return WeekDay.thursday;
    case 5:
      return WeekDay.friday;
    case 6:
      return WeekDay.saturday;
    case 7:
      return WeekDay.saturday;
    default:
      return WeekDay.sunday;
  }
}
