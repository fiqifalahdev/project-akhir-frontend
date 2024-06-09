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
  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (d) {
        //`selectedDate` the new date selected.
        ref.read(selectedDateProvider.notifier).state = d;
      },
      activeColor: CustomColors.primary,
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
                  color: CustomColors.darkBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              dayNumStyle: TextStyle(
                color: CustomColors.darkBlue,
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
