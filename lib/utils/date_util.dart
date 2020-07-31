//时间控件
import 'common_strings_helper.dart';
import 'log_util.dart';

class DateUtils {
  //获取几个月前的时间（时间格式：年-月-日）
  static String getMonthAgoDate(int monthAgo) {
    DateTime date = DateTime.now();
    int year = date.year; //当前年份
    int month = date.month; //当前月份
    int day = date.day; //当前日期
    //计算年份、月份
    if (monthAgo >= month) {
      year--; //年份减一
      month = 12 + month - monthAgo; //月份+12再减
    } else {
      month = month - monthAgo; //之间减去
    }
    //计算日期
//    day=1;//之前取1号，方便
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        //闰年
        if (day > 29) {
          day = 29;
        }
      } else {
        //非闰年
        if (day > 28) {
          day = 28;
        }
      }
    } else {
      if (month == 4 || month == 6 || month == 9 || month == 11) {
        if (day > 30) {
          day = 30;
        }
      }
    }
    return "$year-$month-$day";
  }

  //获取相隔时间的天数(yyyy-mm-dd)
  static int getDifferenceDay(String endDate, [String startDate]) {
    DateTime entTime = DateTime.parse(endDate);
    DateTime startTime = startDate == null ? DateTime.now() : DateTime.parse(startDate);
    if (startTime.isAfter(entTime)) {
      return -1;
    } else {
      Duration differenceDate = entTime.difference(startTime);
      return differenceDate.inDays;
    }
  }

  //判断时间是否在另一个时间之后
  static bool isAfterDay(String firstDate, [String secondDate]) {
    try {
      DateTime firstTime = DateTime.parse(firstDate);
      DateTime secondTime = secondDate == null
          ? DateTime.parse(StringsHelper.formatterYMD.format(DateTime.now()))
          : DateTime.parse(secondDate);
      return firstTime.isAfter(secondTime);
    } catch (e) {
      return false;
    }
  }

  //判断时间是否在另一个时间之前
  static bool isBefore(String firstDate, [String secondDate]) {
    try {
      DateTime firstTime = DateTime.parse(firstDate);
      DateTime secondTime = secondDate == null
          ? DateTime.parse(StringsHelper.formatterYMD.format(DateTime.now()))
          : DateTime.parse(secondDate);
      return firstTime.isBefore(secondTime);
    } catch (e) {
      return false;
    }
  }

  static DateTime getDateTimeFromString(String formattedString) {
    return DateTime.parse(formattedString);
  }

  ///2.1评论发表时间、回复时间：
  //
  //①若（当前时间-发表时间）＜60分钟，则展示为“X分钟前”，X=当前时间-发表时间，按分钟向下取整；
  //
  //②若（当前时间-发表时间)∈[1小时，24小时），则展示为“X小时前”，X=当前时间-发表时间，按小时向下取整；
  //
  //③若（当前时间-发表时间)∈[24小时，96小时），则展示为“X天前”，X=当前时间-发表时间，按天向下取整；
  //
  //④若（当前时间-发表时间)≥96小时，则展示具体的时间，年月日时分秒
  static String getTheCommentTime(String timeStr) {
    try {
      DateTime time = DateTime.parse(timeStr.toString());
      DateTime now = DateTime.now();
      var differ = now.difference(time);
      if (differ.inMinutes < 1) {
        return '刚刚';
      } else if (differ.inMinutes < 60) {
        return '${differ.inMinutes}分钟前';
      } else if (differ.inHours < 24) {
        return '${differ.inHours}小时前';
      } else if (differ.inDays < 4) {
        return '${differ.inDays}天前';
      } else {
        return timeStr;
      }
    } catch (e) {
      return timeStr;
    }
  }

  //获取年月日时间（20190808）
  static String getDataText(String date) {
    if (date != null && date.length == 8) {
      return '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}';
    } else {
      return date ?? "";
    }
  }
}
