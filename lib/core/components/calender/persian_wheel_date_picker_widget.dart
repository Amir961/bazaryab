import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../utils/values.dart';
import '../button/border_button_widget.dart';
import '../button/button_widget.dart';
import '../text/text.dart';

class PersianWheelDatePickerWidget extends StatefulWidget {
  final Jalali initialDate;
  final Jalali? firstDate;
  final Jalali? lastDate;


  final Function(Jalali) changeDate;

  const PersianWheelDatePickerWidget({
    super.key,
    required this.initialDate,
    this.firstDate,
    this.lastDate,

   required this.changeDate,
  });

  @override
  State<PersianWheelDatePickerWidget> createState() => _PersianWheelDatePickerWidgetState();
}

class _PersianWheelDatePickerWidgetState extends State<PersianWheelDatePickerWidget> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  Jalali? selectedDate;

  final List<int> years = List.generate(6, (i) => 1400 + i);

  final List<String> months = const [
    "فروردین",
    "اردیبهشت",
    "خرداد",
    "تیر",
    "مرداد",
    "شهریور",
    "مهر",
    "آبان",
    "آذر",
    "دی",
    "بهمن",
    "اسفند"
  ];

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDay = widget.initialDate.day;
    selectedDate= widget.initialDate;
  }

  List<int> get daysOfMonth {
    final daysCount = Jalali(selectedYear, selectedMonth).monthLength;
    return List.generate(daysCount, (i) => i + 1);
  }

  void _updateDate({int? year, int? month, int? day}) {
    final newDate = Jalali(
      year ?? selectedYear,
      month ?? selectedMonth,
      day ?? selectedDay,
    );

    // if (_isOutOfRange(newDate)) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("تاریخ خارج از محدوده مجاز است")),
    //   );
    //   return; // تغییر اعمال نمی‌کنیم
    // }

    widget.changeDate.call(newDate);
    setState(() {
      selectedYear = newDate.year;
      selectedMonth = newDate.month;
      selectedDay = newDate.day;
    });


    // selectedDate=newDate;
  }

  bool _isOutOfRange(Jalali date) {
    if (widget.firstDate != null && date < widget.firstDate!) return true;
    if (widget.lastDate != null && date > widget.lastDate!) return true;
    return false;
  }



  @override
  Widget build(BuildContext context) {
    const itemExtent = 40.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Pickers
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Year Picker
            SizedBox(
              width: 100,
              height: 200,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: years.indexOf(selectedYear)),
                itemExtent: itemExtent,
                selectionOverlay: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue.withOpacity(0.2), // رنگ پس‌زمینه انتخابی

                      color: MyColors.selectedDate.withOpacity(0.6), // رنگ پس‌زمینه انتخابی
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                onSelectedItemChanged: (index) {
                  _updateDate(year: years[index]);
                },
                children: years
                    .map((y) => Center(child: MyText(text:  y.toString(),color: Colors.black,fontSize: 18,)))
                    .toList(),
              ),
            ),
            // Month Picker
            SizedBox(width: 10,),
            SizedBox(
              width: 120,
              height: 200,
              child: CupertinoPicker(
               // backgroundColor: MyColors.selectedDate,
                scrollController: FixedExtentScrollController(
                    initialItem: selectedMonth - 1),
                itemExtent: itemExtent,
                selectionOverlay: Container(
                  decoration: BoxDecoration(
                   // color: Colors.blue.withOpacity(0.2), // رنگ پس‌زمینه انتخابی

                      color: MyColors.selectedDate.withOpacity(0.6), // رنگ پس‌زمینه انتخابی
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                onSelectedItemChanged: (index) {
                  _updateDate(month: index + 1);
                },
                children:
                months.map((m) => Center(child: MyText(text:m ,color: Colors.black,fontSize: 18,))).toList(),
              ),
            ),
            SizedBox(width: 10,),
            // Day Picker
            SizedBox(
              width: 80,
              height: 200,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: selectedDay - 1),
                itemExtent: itemExtent,
                selectionOverlay: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue.withOpacity(0.2), // رنگ پس‌زمینه انتخابی

                      color: MyColors.selectedDate.withOpacity(0.6), // رنگ پس‌زمینه انتخابی
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                onSelectedItemChanged: (index) {
                  _updateDate(day: daysOfMonth[index]);
                },
                children: daysOfMonth
                    .map((d) => Center(child: MyText(text:d.toString(),color: Colors.black,fontSize: 18,)))
                    .toList(),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
