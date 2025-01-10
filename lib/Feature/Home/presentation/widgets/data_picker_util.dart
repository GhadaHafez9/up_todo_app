import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

Future<DateTime?> showCalendarPopup(BuildContext context) async {
  DateTime focusedDate = DateTime.now();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  return await showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          backgroundColor: const Color(0xff363636),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Calendar Picker
                TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: focusedDate,
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    selectedDate = selectedDay;
                    focusedDate = focusedDay;
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color(0xff8687E7),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xff8687E7),
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(color: Colors.red),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                        color: Colors.white, fontSize: 14.sp, fontFamily: 'Lato'),
                    leftChevronIcon:
                        const Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon:
                        const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  calendarFormat: CalendarFormat.month,
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                    weekdayStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16.h),
                // Time Picker Button
                ElevatedButton(
                  onPressed: () async {
                    selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xff8687E7),
                              onPrimary: Colors.white,
                              surface: Color(0xff363636),
                              onSurface: Colors.white,
                            ),
                            dialogBackgroundColor: const Color(0xff363636),
                          ),
                          child: child!,
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff8687E7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: Text('Pick Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato')),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel',
                          style: TextStyle(
                            color: const Color(0xff8687E7),
                            fontSize: 16.sp,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedDate != null) {
                          final combinedDateTime = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedTime?.hour ?? 0,
                            selectedTime?.minute ?? 0,
                          );
                          Navigator.pop(context, combinedDateTime);
                          print('Selected DateTime: $combinedDateTime');
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8687E7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      child: Text('Confirm',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Lato')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
