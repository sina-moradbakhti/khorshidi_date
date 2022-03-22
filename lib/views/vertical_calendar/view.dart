import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:khorshidi_calendar/khorshidi_date/enums.dart';
import 'package:khorshidi_calendar/khorshidi_date/modesl.dart';
import 'package:khorshidi_calendar/views/calendar_month/view.dart';
import 'package:shamsi_date/shamsi_date.dart';

class VerticalCalendar extends StatelessWidget {
  double margin = 2.5;
  TextStyle? weekDayTextStyle;
  TextStyle? titleTextStyle;
  TextStyle? dayTextStyle;
  TextStyle? weekendTextStyle;
  Function(KDate)? onTappedDate;
  bool multipleSelect = false;
  List<KDate>? selected = [];
  Map<Jalali, Widget>? badges;
  BoxDecoration? dayDecoration;
  BoxDecoration? selectedDayDecoration;
  InfiniteScrollController? controller;

  VerticalCalendar(
      {Key? key,
      this.margin = 2.5,
      this.weekDayTextStyle,
      this.titleTextStyle,
      this.controller,
      this.dayTextStyle,
      this.multipleSelect = false,
      this.onTappedDate,
      this.dayDecoration,
      this.badges,
      this.selectedDayDecoration,
      this.selected,
      this.weekendTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Jalali now = Jalali.now();
    return InfiniteListView.builder(
        scrollDirection: Axis.vertical,
        controller: controller,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (ctx, index) {
          Jalali current = now.addMonths(-index);
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CalendarMonth(
                onTappedDate: onTappedDate,
                calendarType: KhorshidiCalendarType.vertical,
                month: current.month,
                controller: controller,
                year: current.year,
                selected: selected,
                badges: badges,
                dayTextStyle: dayTextStyle,
                dayDecoration: dayDecoration,
                selectedDayDecoration: selectedDayDecoration,
                multipleSelect: multipleSelect,
                margin: margin,
                titleTextStyle: titleTextStyle,
                weekDayTextStyle: weekDayTextStyle,
                weekendTextStyle: weekendTextStyle),
          );
        });
  }
}
