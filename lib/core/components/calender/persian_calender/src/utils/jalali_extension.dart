import 'package:intl/intl.dart';

import 'constants.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension JalaliExtension on Jalali {
  String monthName() {
    return monthNames[month - 1];
  }

  String toShortShow() {
    return '$year/$month/$day';
  }

  String toShortMiladyShow() {
   final  date= toDateTime();
    return '${date.year}/${date.month}/${date.day}';
  }
}

extension DateTimeExtension on DateTime {


  String toShortShow() {
    return '$year/$month/$day';
  }

  String toShortJalaliShow() {

    final  date= toJalali();

    return '${date.year}/${date.month}/${date.day}';
  }
}

extension StringTimeExtension on String {


  Jalali toJalali() {

    try {
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss", "en_US");

      return format.parse(this).toJalali();
    }
    catch(ex)
    {
      try {
        DateFormat format = DateFormat("yyyy-MM-dd", "en_US");

        return format.parse(this).toJalali();
      }
      catch(ex)
    {
      return Jalali.now();
    }
    }


  }


}
