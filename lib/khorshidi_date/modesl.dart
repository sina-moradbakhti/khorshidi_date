import 'package:shamsi_date/shamsi_date.dart';

class KhorshidiMonthNamesInFarsi {
  static const String farvardin = 'فروردین';
  static const String ordibehesht = 'اردیبهشت';
  static const String khordad = 'خرداد';
  static const String tir = 'تیر';
  static const String mordad = 'مرداد';
  static const String shahrivar = 'شهریور';
  static const String mehr = 'مهر';
  static const String aban = 'آبان';
  static const String azar = 'آذر';
  static const String dey = 'دی';
  static const String bahman = 'بهمن';
  static const String esfand = 'اسفند';
}

class KhorshidiDayNamesInFarsi {
  static const String shanbe = 'شنبه';
  static const String yekshanbe = 'یکشنبه';
  static const String doshanbe = 'دوشنبه';
  static const String seshanbe = 'سه‌شنبه';
  static const String chaharshanbe = 'چهار‌شنبه';
  static const String panjshanbe = 'پنج‌شنبه';
  static const String jome = 'جمعه';
}

class KhorshidiShortDayNamesInFarsi {
  static const String shanbe = 'ش';
  static const String yekshanbe = 'ی';
  static const String doshanbe = 'د';
  static const String seshanbe = 'س';
  static const String chaharshanbe = 'چ';
  static const String panjshanbe = 'پ';
  static const String jome = 'ج';
}

class KDate {
  String? strDate;
  String? dayName;
  int? weekDay;
  int? month;
  int? day;
  int? year;
  String? monthName;
  bool? isLeapYear;
  Jalali? date;
  Gregorian? gregorian;
  bool isEmpty = false;

  KDate(
      {this.date,
      this.strDate,
      this.gregorian,
      this.dayName,
      this.isLeapYear,
      this.month,
      this.day,
      this.year,
      this.monthName,
      this.isEmpty = false,
      this.weekDay});
}
