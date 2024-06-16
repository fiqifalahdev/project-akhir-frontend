import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/styles.dart';

class CustomDateTimeline extends ConsumerStatefulWidget {
  const CustomDateTimeline({super.key});

  @override
  ConsumerState<CustomDateTimeline> createState() => _CustomDateTimelineState();
}

class _CustomDateTimelineState extends ConsumerState<CustomDateTimeline> {
  int disableDates() {
    // Example date to compare with today
    DateTime givenDate = DateTime(DateTime.now().year, DateTime.now().month, 1);

    // Get the current date
    DateTime today = DateTime.now();

    // Calculate the difference in days
    int daysBeforeToday = today.difference(givenDate).inDays;
    print('Days before today: $daysBeforeToday');

    return daysBeforeToday;
  }

  @override
  Widget build(BuildContext context) {
    disableDates();

    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (d) {
        //`selectedDate` the new date selected.
        ref.read(selectedDateProvider.notifier).state = d;
      },
      activeColor: CustomColors.primary,
      disabledDates: [
        for (int i = 1; i <= disableDates(); i++)
          DateTime.now().subtract(Duration(days: i)),
      ],
      dayProps: EasyDayProps(
          landScapeMode: true,
          dayStructure: DayStructure.dayStrDayNum,
          todayHighlightColor: CustomColors.primary,
          borderColor: Colors.grey.shade300,
          activeDayStyle: const DayStyle(
              dayStrStyle: TextStyle(
                  color: CustomColors.putih,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              dayNumStyle: TextStyle(
                color: CustomColors.putih,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
          todayStyle: const DayStyle(
              dayStrStyle: TextStyle(
                  color: CustomColors.darkBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              dayNumStyle: TextStyle(
                color: CustomColors.darkBlue,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
          inactiveDayStyle: const DayStyle(
              dayStrStyle: TextStyle(
                  color: CustomColors.teksAbu,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              dayNumStyle: TextStyle(
                color: CustomColors.darkBlue,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
          disabledDayStyle: const DayStyle(
              dayStrStyle: TextStyle(
                  color: CustomColors.teksAbu,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              dayNumStyle: TextStyle(
                color: CustomColors.teksAbu,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ))),
      headerProps: const EasyHeaderProps(
        dateFormatter: DateFormatter.fullDateDMonthAsStrY(),
      ),
      locale: 'id_ID',
    );
  }
}
