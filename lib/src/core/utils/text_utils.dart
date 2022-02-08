class TextUtils {
  static const int oneHourMinutes = 60;
  static const int oneDayMinutes = oneHourMinutes * 24;
  static const int oneMonthMinutes = oneDayMinutes * 30;
  static const int oneYearMinutes = oneMonthMinutes * 12;

  static String getCreatedBefore(DateTime time) {
    Duration duration = DateTime.now().difference(time);
    final minuteDiff = duration.inMinutes;
    if (minuteDiff <= 0) {
      return '방금 전';
    } else if (minuteDiff < oneHourMinutes) {
      return '$minuteDiff분 전';
    } else if (minuteDiff < oneDayMinutes) {
      return '${minuteDiff ~/ oneHourMinutes}시간 전';
    } else if (minuteDiff < oneMonthMinutes) {
      return '${minuteDiff ~/ oneDayMinutes}일 전';
    } else if (minuteDiff < oneYearMinutes) {
      return '${minuteDiff ~/ oneMonthMinutes}달 전';
    } else {
      return '${minuteDiff ~/ oneYearMinutes}년 전';
    }
  }
}