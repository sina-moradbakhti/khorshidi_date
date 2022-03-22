import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khorshidi_calendar/khorshidi_date/enums.dart';
import 'package:khorshidi_calendar/khorshidi_date/khorshidi_date.dart';
import 'package:khorshidi_calendar/khorshidi_date/modesl.dart';
import 'package:khorshidi_calendar/views/calendar_day_widget/view.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarMonth extends StatelessWidget {
  double margin = 2.5;
  TextStyle? weekDayTextStyle;
  TextStyle? titleTextStyle;
  TextStyle? dayTextStyle;
  TextStyle? weekendTextStyle;
  final KhorshidiCalendarType calendarType;
  final int month;
  final int year;
  Function(KDate)? onTappedDate;
  bool multipleSelect = false;
  List<KDate>? selected = [];
  Map<Jalali, Widget>? badges;
  BoxDecoration? dayDecoration;
  BoxDecoration? selectedDayDecoration;
  var controller;

  CalendarMonth(
      {Key? key,
      this.margin = 2.5,
      this.onTappedDate,
      this.calendarType = KhorshidiCalendarType.horizontal,
      this.multipleSelect = false,
      this.weekDayTextStyle,
      this.dayDecoration,
      this.controller,
      this.selectedDayDecoration,
      this.titleTextStyle,
      this.dayTextStyle,
      this.selected,
      this.badges,
      required this.year,
      required this.month,
      this.weekendTextStyle})
      : super(key: key);

  final TextStyle _weekDayDefaultTextStyle =
      PersianFonts.Samim.copyWith(color: Colors.grey, fontSize: 17);
  final TextStyle _titleTextStyle = PersianFonts.Samim.copyWith(
      color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, constraints) {
      return _calendar(constraints.maxWidth);
    });
  }

  Widget _calendar(double maxWidth) {
    final double eachWidgetSize = ((maxWidth - ((margin * 2) * 8)) / 8);

    final _dates = KhorshidiDateCalendar(year: year, month: month).getData();
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          calendarType == KhorshidiCalendarType.horizontal
              ? _topTitle()
              : _topTitle2(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _weekDayWidget(eachWidgetSize, margin,
                          KhorshidiShortDayNamesInFarsi.shanbe),
                      _weekDayWidget(eachWidgetSize, margin,
                          KhorshidiShortDayNamesInFarsi.yekshanbe),
                      _weekDayWidget(eachWidgetSize, margin,
                          KhorshidiShortDayNamesInFarsi.doshanbe),
                      _weekDayWidget(eachWidgetSize, margin,
                          KhorshidiShortDayNamesInFarsi.seshanbe),
                      _weekDayWidget(eachWidgetSize, margin,
                          KhorshidiShortDayNamesInFarsi.chaharshanbe),
                      _weekDayWidget(eachWidgetSize, margin,
                          KhorshidiShortDayNamesInFarsi.panjshanbe),
                      _weekDayWidget(eachWidgetSize, margin,
                          KhorshidiShortDayNamesInFarsi.jome)
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 0,
                    spacing: 0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    textDirection: TextDirection.rtl,
                    children: [
                      for (var item in _dates)
                        InkWell(
                            splashFactory: NoSplash.splashFactory,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: DayWidget(
                              kDate: item,
                              decoration: dayDecoration,
                              selectedDecoration: selectedDayDecoration,
                              badges: _getBadges(item),
                              isSelected: _isSelected(item),
                              parentMaxWidth: maxWidth,
                              size: eachWidgetSize,
                              marginSize: margin,
                              dayTextStyle: dayTextStyle,
                              weekendTextStyle: weekendTextStyle,
                            ),
                            onTap: () => item.isEmpty
                                ? null
                                : (onTappedDate != null)
                                    ? onTappedDate!(item)
                                    : null)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _topTitle() {
    return LayoutBuilder(
        builder: (context, constraints) => Container(
              width: constraints.maxWidth,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CupertinoButton(
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onPressed: _back),
                  Text(
                    KhorshidiDate.monthName(month) + ' ' + year.toString(),
                    style: titleTextStyle ?? _titleTextStyle,
                  ),
                  CupertinoButton(
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onPressed: _next),
                ],
              ),
            ));
  }

  Widget _topTitle2() {
    return LayoutBuilder(
        builder: (context, constraints) => Container(
              width: constraints.maxWidth,
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  KhorshidiDate.monthName(month) + ' ' + year.toString(),
                  style: titleTextStyle ?? _titleTextStyle,
                ),
              ),
            ));
  }

  Widget _weekDayWidget(double size, double margin, String value) {
    return Container(
      margin: EdgeInsets.only(left: margin, right: margin),
      width: size,
      height: size,
      child: Text(
        value.toString(),
        style: weekDayTextStyle ?? _weekDayDefaultTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget? _getBadges(KDate item) {
    if (item.isEmpty) {
      return null;
    } else {
      if (badges != null) {
        return badges?[item.date];
      } else {
        return null;
      }
    }
  }

  bool _isSelected(KDate item) {
    if (item.isEmpty) {
      return false;
    }
    if (multipleSelect) {
      return selected
              ?.indexWhere((element) => element.strDate == item.strDate) !=
          -1;
    } else {
      if (selected!.isNotEmpty) {
        return selected?.last.strDate == item.strDate;
      } else {
        return false;
      }
    }
  }

  void _next() {
    controller?.animateToIndex((controller?.originIndex ?? 1) + 1,
        duration: const Duration(milliseconds: 200));
  }

  void _back() {
    controller?.animateToIndex((controller?.originIndex ?? 1) - 1,
        duration: const Duration(milliseconds: 200));
  }
}
