part of '../history_attendance_page.dart';

class _SelectedDate extends StatelessWidget {
  const _SelectedDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final historyAttendanceBloc = context.read<HistoryAttendanceBloc>();
        if (historyAttendanceBloc.state.status ==
            HistoryAttendanceStatus.loaded) {
          final newSelectedDate = await showDateRangePicker(
            context: context,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5),
            initialDateRange: DateTimeRange(
              end: historyAttendanceBloc.state.selectedDateEnd!,
              start: historyAttendanceBloc.state.selectedDateStart!,
            ),
            builder: (context, child) {
              return Column(
                children: [
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 400.0, maxHeight: 1.sh - 20),
                    child: child,
                  )
                ],
              );
            },
          );
          if (newSelectedDate != null) {
            historyAttendanceBloc.add(
              HistoryAttendanceEvent.changeDate(
                startDatetime: newSelectedDate.start,
                endDatetime: newSelectedDate.end,
              ),
            );
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.separator),
          ),
        ),
        child: const Row(
          children: [
            _SelectedDateRange(),
            Spacer(),
            Icon(
              Icons.calendar_today,
              size: 21,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedDateRange extends StatelessWidget {
  const _SelectedDateRange({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryAttendanceBloc, HistoryAttendanceState>(
      builder: (context, state) {
        if (state.selectedDateStart == null) {
          return Skeleton(
            width: 148.w,
          );
        } else if (state.selectedDateStart != null) {
          return Text(
            "${state.selectedDateStart!.toFormatDateRange()} - ${state.selectedDateEnd!.toFormatDateRange()}",
          );
        }

        return const SizedBox();
      },
    );
  }
}
