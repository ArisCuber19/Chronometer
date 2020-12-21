class CustomDuration extends Duration {
  /* Invoking original Duration constructor */
  @override
  CustomDuration(
      {int days = 0,
      int hours = 0,
      int minutes = 0,
      int seconds = 0,
      int milliseconds = 0,
      int microseconds = 0})
      : super(
            days: days,
            hours: hours,
            minutes: minutes,
            seconds: seconds,
            milliseconds: milliseconds,
            microseconds: microseconds);

/*Overriding toString() method of Duration class so it displays 
  * the current elapsed time as 0:00:00.00*/
  @override
  String toString() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (inMicroseconds < 0) {
      return "-${-this}";
    }
    String twoDigitMinutes =
        twoDigits(inMinutes.remainder(Duration.minutesPerHour) as int);
    String twoDigitSeconds =
        twoDigits(inSeconds.remainder(Duration.secondsPerMinute) as int);
    String twoDigitUs = twoDigits(
        inMicroseconds.remainder(Duration.microsecondsPerSecond).remainder(59));

    return "$inHours:$twoDigitMinutes:$twoDigitSeconds.$twoDigitUs";
  }

  String toStringUntilSeconds() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (inMicroseconds < 0) {
      return "-${-this}";
    }
    String twoDigitMinutes =
        twoDigits(inMinutes.remainder(Duration.minutesPerHour) as int);
    String twoDigitSeconds =
        twoDigits(inSeconds.remainder(Duration.secondsPerMinute) as int);

    return "$inHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  static CustomDuration fromDurationToSub(Duration duration) {
    return CustomDuration(microseconds: duration.inMicroseconds);
  }
}
