import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../model/holiday_list.dart';

class HolidayCubit extends Cubit<HolidayState> {
  HolidayCubit() : super(const HolidayState());

  Future<void> isThereHoliday() async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    var dateString = formatter.format(DateTime.now());

    final holidayList = await getLoadLocalJson();

    Holidays? todayHoliday = holidayList.holidays?.firstWhere(
      (holiday) => holiday.date == dateString,
      orElse: () => Holidays(date: '', day: '', name: '', states: []),
    );

    emit(state.copyWith(
      todayHoliday: todayHoliday?.date?.isNotEmpty ?? false,
      todayHolidayDetails:
          todayHoliday?.date?.isNotEmpty == true ? todayHoliday : null,
    ));
  }

  Future<HolidayList> getLoadLocalJson() async {
    String response = await rootBundle.loadString('assets/holiday.json');
    final data = json.decode(response);
    final holidayList = HolidayList.fromJson(data);
    return holidayList;
  }

  Future<void> weekHolidays() async {
    final holidayList = await getLoadLocalJson();
    DateTime now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    DateTime sunday = monday.add(const Duration(days: 6));

    List<Holidays> weekHolidays = holidayList.holidays?.where((holiday) {
          DateTime holidayDate = DateTime.parse(holiday.date ?? "");
          return holidayDate
                  .isAfter(monday.subtract(const Duration(days: 1))) &&
              holidayDate.isBefore(sunday.add(const Duration(days: 1)));
        }).toList() ??
        [];

    emit(state.copyWith(thisWeekHoliday: weekHolidays));
  }

  Future<void> monthHolidays() async {
    final holidayList = await getLoadLocalJson();

    DateTime now = DateTime.now();
    String month = DateFormat('yyyy-MM').format(now);

    List<Holidays> monthHolidays = holidayList.holidays?.where((holiday) {
          return holiday.date?.startsWith(month) ?? false;
        }).toList() ??
        [];

    emit(state.copyWith(thisMonthHoliday: monthHolidays));
  }
}

class HolidayState extends Equatable {
  final bool todayHoliday;
  final Holidays? todayHolidayDetails;
  final List<Holidays>? thisWeekHoliday;
  final List<Holidays>? thisMonthHoliday;

  const HolidayState({
    this.todayHoliday = false,
    this.todayHolidayDetails,
    this.thisWeekHoliday,
    this.thisMonthHoliday,
  });

  HolidayState copyWith({
    bool? todayHoliday,
    Holidays? todayHolidayDetails,
    List<Holidays>? thisWeekHoliday,
    List<Holidays>? thisMonthHoliday,
  }) {
    return HolidayState(
      todayHoliday: todayHoliday ?? this.todayHoliday,
      todayHolidayDetails: todayHolidayDetails ?? this.todayHolidayDetails,
      thisWeekHoliday: thisWeekHoliday ?? this.thisWeekHoliday,
      thisMonthHoliday: thisMonthHoliday ?? this.thisMonthHoliday,
    );
  }

  @override
  List<Object?> get props =>
      [todayHoliday, todayHolidayDetails, thisWeekHoliday, thisMonthHoliday];
}
