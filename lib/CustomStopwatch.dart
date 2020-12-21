import 'CustomDuration.dart';

/*Overridden stopwatch class to change return value of elapsed getter as Duration
* subclass */
class CustomStopwatch extends Stopwatch {
  @override
  CustomStopwatch() : super();

  @override
  CustomDuration get elapsed =>
      CustomDuration(microseconds: elapsedMicroseconds);

  CustomDuration _countdown;

  CustomDuration get remaining => CustomDuration.fromDurationToSub(
      _countdown - Duration(microseconds: elapsedMicroseconds));

  CustomStopwatch.timer({CustomDuration countdown}) : super() {
    this._countdown = countdown;
  }
}
