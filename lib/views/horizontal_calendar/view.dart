import 'package:flutter/material.dart';
import 'package:khorshidi_calendar/khorshidi_date/enums.dart';
import 'package:khorshidi_calendar/khorshidi_date/modesl.dart';
import 'package:khorshidi_calendar/views/calendar_month/view.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:indexed_list_view/indexed_list_view.dart';

class HorizontalCalendar extends StatelessWidget {
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
  IndexedScrollController? controller;

  HorizontalCalendar(
      {Key? key,
      this.margin = 2.5,
      this.weekDayTextStyle,
      this.titleTextStyle,
      this.controller,
      this.dayDecoration,
      this.selectedDayDecoration,
      this.dayTextStyle,
      this.selected,
      this.onTappedDate,
      this.badges,
      this.multipleSelect = false,
      this.weekendTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Jalali now = Jalali.now();
    return LayoutBuilder(
        builder: (ctx, constraints) => IndexedListView.builder(
            controller: controller ?? IndexedScrollController(),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              Jalali current = now.addMonths(-index);
              return SizedBox(
                width: constraints.maxWidth,
                child: CalendarMonth(
                    onTappedDate: onTappedDate,
                    month: current.month,
                    calendarType: KhorshidiCalendarType.horizontal,
                    controller: controller,
                    year: current.year,
                    badges: badges,
                    dayDecoration: dayDecoration,
                    selectedDayDecoration: selectedDayDecoration,
                    multipleSelect: multipleSelect,
                    selected: selected,
                    dayTextStyle: dayTextStyle,
                    margin: margin,
                    titleTextStyle: titleTextStyle,
                    weekDayTextStyle: weekDayTextStyle,
                    weekendTextStyle: weekendTextStyle),
              );
            }));
  }
}
