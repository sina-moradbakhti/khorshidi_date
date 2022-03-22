import 'package:khorshidi_calendar/khorshidi_date/modesl.dart';
import 'package:shamsi_date/shamsi_date.dart';

class KhorshidiDate {
  static const int _twentyNineDays = 29;
  static const int _thirtyDays = 30;
  static const int _thirtyOneDays = 31;

  static bool isLeapYear(year) {
    final matches = [1, 5, 9, 13, 17, 22, 26, 30];
    final modulus = year - ((year / 33).floor() * 33);
    bool isLeapYear = false;

    for (int i = 0; i != 8; i++) {
      if (matches[i] == modulus) {
        isLeapYear = true;
      }
    }

    return isLeapYear;
  }

  static int monthDays(int month, int year) {
    switch (month) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
        return _thirtyOneDays;
      case 7:
      case 8:
      case 9:
      case 10:
      case 11:
        return _thirtyDays;
      case 12:
        return isLeapYear(year) ? _thirtyDays : _twentyNineDays;
      default:
        return _thirtyOneDays;
    }
  }

  static String monthName(int month) {
    switch (month) {
      case 1:
        return KhorshidiMonthNamesInFarsi.farvardin;
      case 2:
        return KhorshidiMonthNamesInFarsi.ordibehesht;
      case 3:
        return KhorshidiMonthNamesInFarsi.khordad;
      case 4:
        return KhorshidiMonthNamesInFarsi.tir;
      case 5:
        return KhorshidiMonthNamesInFarsi.mordad;
      case 6:
        return KhorshidiMonthNamesInFarsi.shahrivar;
      case 7:
        return KhorshidiMonthNamesInFarsi.mehr;
      case 8:
        return KhorshidiMonthNamesInFarsi.aban;
      case 9:
        return KhorshidiMonthNamesInFarsi.azar;
      case 10:
        return KhorshidiMonthNamesInFarsi.dey;
      case 11:
        return KhorshidiMonthNamesInFarsi.bahman;
      case 12:
        return KhorshidiMonthNamesInFarsi.esfand;
      default:
        return KhorshidiMonthNamesInFarsi.farvardin;
    }
  }

  static String weekDayName({required int weekDay, bool isShort = false}) {
    switch (weekDay) {
      case 1:
        return !isShort
            ? KhorshidiDayNamesInFarsi.shanbe
            : KhorshidiShortDayNamesInFarsi.shanbe;
      case 2:
        return !isShort
            ? KhorshidiDayNamesInFarsi.yekshanbe
            : KhorshidiShortDayNamesInFarsi.yekshanbe;
      case 3:
        return !isShort
            ? KhorshidiDayNamesInFarsi.doshanbe
            : KhorshidiShortDayNamesInFarsi.doshanbe;
      case 4:
        return !isShort
            ? KhorshidiDayNamesInFarsi.seshanbe
            : KhorshidiShortDayNamesInFarsi.seshanbe;
      case 5:
        return !isShort
            ? KhorshidiDayNamesInFarsi.chaharshanbe
            : KhorshidiShortDayNamesInFarsi.chaharshanbe;
      case 6:
        return !isShort
            ? KhorshidiDayNamesInFarsi.panjshanbe
            : KhorshidiShortDayNamesInFarsi.panjshanbe;
      case 7:
        return !isShort
            ? KhorshidiDayNamesInFarsi.jome
            : KhorshidiShortDayNamesInFarsi.jome;
      default:
        return !isShort
            ? KhorshidiDayNamesInFarsi.shanbe
            : KhorshidiShortDayNamesInFarsi.shanbe;
    }
  }
}

class KhorshidiDateCalendar {
  final int year;
  final int month;
  KhorshidiDateCalendar({required this.year, required this.month});

  List<KDate> getData() {
    List<KDate> data = [];
    final monthDays = KhorshidiDate.monthDays(month, year);
    for (int i = 1; i <= monthDays; i++) {
      Jalali date = Jalali(year, month, i);
      data.add(KDate(
          date: date,
          gregorian: date.toGregorian(),
          strDate: '$year-$month-$i',
          day: i,
          month: month,
          year: year,
          isLeapYear: KhorshidiDate.isLeapYear(year),
          weekDay: date.weekDay,
          dayName: KhorshidiDate.weekDayName(weekDay: date.weekDay),
          monthName: KhorshidiDate.monthName(month)));
    }
    final int emptyLenght = (data.first.weekDay ?? 0);
    data = [
      for (int i = 0; i < emptyLenght - 1; i++) KDate(isEmpty: true),
      ...data
    ];
    return data;
  }
}
