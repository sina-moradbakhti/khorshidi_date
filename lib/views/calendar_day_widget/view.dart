import 'package:flutter/material.dart';
import 'package:khorshidi_calendar/khorshidi_date/modesl.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DayWidget extends StatelessWidget {
  double marginSize = 0;
  double size = 0;
  final double parentMaxWidth;
  final KDate kDate;
  BoxDecoration? decoration;
  BoxDecoration? selectedDecoration;
  TextStyle? dayTextStyle;
  TextStyle? weekendTextStyle;
  bool isSelected = false;
  Widget? badges;

  DayWidget(
      {Key? key,
      required this.kDate,
      this.badges,
      required this.parentMaxWidth,
      this.size = 50,
      this.decoration,
      this.selectedDecoration,
      this.dayTextStyle,
      this.isSelected = false,
      this.weekendTextStyle,
      this.marginSize = 0})
      : super(key: key);

  final TextStyle _textStyle =
      PersianFonts.Samim.copyWith(color: Colors.grey, fontSize: 17);
  final TextStyle _weekendTextStyle =
      PersianFonts.Samim.copyWith(color: Colors.red, fontSize: 17);

  @override
  Widget build(BuildContext context) {
    bool isToday = _isToday(kDate.date);

    EdgeInsets margin = EdgeInsets.all(marginSize);
    return Container(
        margin: margin,
        padding: EdgeInsets.zero,
        width: size,
        height: size,
        decoration:
            kDate.isEmpty ? const BoxDecoration() : _getDecoration(isToday),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Align(
              child: !kDate.isEmpty
                  ? FittedBox(
                      child: Text(
                        kDate.day.toString(),
                        style: kDate.weekDay == 7
                            ? (weekendTextStyle ?? _weekendTextStyle)
                            : (dayTextStyle ?? _textStyle),
                      ),
                      fit: BoxFit.fitWidth,
                    )
                  : Container(),
              alignment: Alignment.center,
            ),
            badges ?? Container()
          ],
        ));
  }

  BoxDecoration _getDecoration(isToday) {
    if (isSelected) {
      return (selectedDecoration ??
          BoxDecoration(
              color: Colors.blueGrey.shade200,
              borderRadius: BorderRadius.circular(4)));
    } else {
      return (decoration ??
          BoxDecoration(
              color: isToday ? Colors.grey.shade200 : Colors.white,
              borderRadius: BorderRadius.circular(4)));
    }
  }

  bool _isToday(Jalali? kDate) {
    Jalali current = Jalali.now();
    return (kDate?.day == current.day &&
        kDate?.month == current.month &&
        kDate?.year == current.year);
  }
}
