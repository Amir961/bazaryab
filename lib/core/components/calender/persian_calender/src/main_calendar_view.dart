import 'package:fare/core/components/calender/persian_calender/src/utils/jalali_extension.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../../../../../features/language/utils/strings.dart';
import '../../../text/text.dart';
import 'grids/days_grid.dart';
import 'grids/months_grid.dart';
import 'grids/years_grid.dart';
import 'utils/constants.dart';
import 'utils/extensions.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MainCalendarView extends StatefulWidget {
  const MainCalendarView({
    required this.viewMode,
    required this.selectedDate,
    this.startingDate,
    this.endingDate,
    this.primaryColor,
    this.textStyle,
    this.onViewChanged,
    this.onDateChanged,
   required this.isSelectedBefore,
    super.key,
  });

  final CalendarViewMode viewMode;
  final Jalali selectedDate;
  final Jalali? startingDate;
  final Jalali? endingDate;
  final Color? primaryColor;
  final TextStyle? textStyle;
  final bool isSelectedBefore;
  final ValueChanged<CalendarViewMode>? onViewChanged;
  final ValueChanged<Jalali>? onDateChanged;

  @override
  State<MainCalendarView> createState() => _MainCalendarViewState();
}

class _MainCalendarViewState extends State<MainCalendarView> {
  late Jalali _selectedDate;
  late Jalali _startDate;
  late Jalali _endDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _startDate = widget.startingDate ?? kStartingDate;
    _endDate = widget.endingDate ?? kEndingDate;
  }

  @override
  Widget build(BuildContext context) {
    final itemColor =
        widget.primaryColor ?? Theme.of(context).colorScheme.primaryContainer;
    final textStyle = _textStyle(context);
    return switch (widget.viewMode) {
      CalendarViewMode.year => YearsGrid(
          selectedYear: _selectedDate.year,
          startingYear: _startDate.year,
          endingYear: _endDate.year,
          itemColor: itemColor,
          textStyle: textStyle,
          onYearChanged: _handleYearChanged,
        ),
      CalendarViewMode.month => MonthsGrid(
          selectedDate: _selectedDate,
          startingDate: _startDate,
          endingDate: _endDate,
          itemColor: itemColor,
          textStyle: textStyle,
          onMonthChanged: _handleMonthChanged,
        ),
      CalendarViewMode.day => DaysGrid(
          selectedDate: _selectedDate,
          startingDate: _startDate,
          endingDate: _endDate,
          itemColor: itemColor,
          textStyle: textStyle,
          onDayChanged: _handleDayChanged,
        ),
    };
  }

  TextStyle? _textStyle(BuildContext context) {
    return widget.textStyle ?? Theme.of(context).textTheme.titleSmall;
  }

  /// When the user picks a year, we update the selectedDate
  /// and switch to month selection mode.
  void _handleYearChanged(int year) {
    setState(() {
      // Make sure month and day are in range or just keep the same month/day
      final fixedMonth = _selectedDate.month;
      final fixedDay = _selectedDate.day;
      _selectedDate = Jalali(year, fixedMonth, fixedDay);
      widget.onDateChanged?.call(_selectedDate);
      widget.onViewChanged?.call(CalendarViewMode.month);
    });
  }

  /// When the user picks a month, switch to day selection mode.
  void _handleMonthChanged(int month) {
    setState(() {
      // Keep the same day, or clamp if day > end of that month
      final maxDaysInMonth = Jalali(_selectedDate.year, month).monthLength;
      final newDay = (_selectedDate.day <= maxDaysInMonth)
          ? _selectedDate.day
          : maxDaysInMonth;

      _selectedDate = Jalali(_selectedDate.year, month, newDay);
      widget.onDateChanged?.call(_selectedDate);
      widget.onViewChanged?.call(CalendarViewMode.day);
    });
  }

  /// When the user picks a day, we have a full date.
  void _handleDayChanged(int day) {
   final selectedDay= Jalali(_selectedDate.year, _selectedDate.month, day);

   final now= Jalali(Jalali.now().year,Jalali.now().month,Jalali.now().day);

   final select = selectedDay.compareTo(now);
   if(!widget.isSelectedBefore &&select<0)
   {
     toastification.show(
         type: ToastificationType.error,
         style: ToastificationStyle.minimal,
         backgroundColor: Colors.grey[100],
         //overlayState: globalNavigatorKey.currentState?.overlay,
         autoCloseDuration: const Duration(seconds: 3),
         title: MyText(text:Strings.of(context).failed_label,color: Colors.black87,fontWeight: FontWeight.bold,),
         description: MyText(text:'روزهای قبل را نمی توانید انتخاب کنید',color: Colors.black87,)
     );

     return;
   }

    if(selectedDay.compareTo(_startDate)<0)
      {
        toastification.show(
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            backgroundColor: Colors.grey[100],
            //overlayState: globalNavigatorKey.currentState?.overlay,
            autoCloseDuration: const Duration(seconds: 3),
            title: MyText(text:Strings.of(context).failed_label,color: Colors.black87,fontWeight: FontWeight.bold,),
            description: MyText(text:'زمان قبل از ${_startDate.toShortShow()} را نمی توانید انتخاب کنید',color: Colors.black87,)
        );
        return;
      }

      setState(() {
        _selectedDate = Jalali(_selectedDate.year, _selectedDate.month, day);
      });

      widget.onDateChanged?.call(_selectedDate);

  }
}
