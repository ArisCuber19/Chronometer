import 'dart:async';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clock',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.lightBlue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.lightBlue,
        ),
        themeMode: ThemeMode.system,
        home: Main());
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              AlarmTab(),
              ChronometerTab(),
              TimerTab(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.alarm)),
              Tab(icon: Icon(Icons.timer)),
              Tab(icon: Icon(Icons.access_time_outlined)),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.purple,
          ),
        ),
      ),
    );
  }
}

class AlarmTab extends StatefulWidget {
  @override
  _AlarmTabState createState() => _AlarmTabState();
}

class _AlarmTabState extends State<AlarmTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Alarm placeholder"),
    );
  }
}

class ChronometerTab extends StatefulWidget {
  @override
  _ChronometerTabState createState() => _ChronometerTabState();
}

class _ChronometerTabState extends State<ChronometerTab> {
  String _elapsed;
  var stopwatch = new SubStopwatch();

  @override
  void initState() {
    super.initState();

    // sets first value
    _elapsed = stopwatch.elapsed.toString();

    /* Every 1 ms, the _elapsed content is refreshed according to 
    * stopwatch value */
    Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          _elapsed = stopwatch.elapsed.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child:
                Center(child: Text(_elapsed, style: TextStyle(fontSize: 30)))),
        Center(
            child: StartStopButtonBar(
          stopwatch: stopwatch,
        ))
      ],
    );
  }
}

class TimerTab extends StatefulWidget {
  @override
  _TimerTabState createState() => _TimerTabState();
}

class _TimerTabState extends State<TimerTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Timer placeholder"),
    );
  }
}

class SubDuration extends Duration {
  /* Invoking original Duration constructor */
  @override
  SubDuration(
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
}

/*Overridden stopwatch class to change return value of elapsed getter as Duration
* subclass */
class SubStopwatch extends Stopwatch {
  @override
  SubStopwatch() : super();

  @override
  SubDuration get elapsed => SubDuration(microseconds: elapsedMicroseconds);
}

/* Defining new StatefulWidget class which renders different buttons in the buttonBar according to 
* stopwatch state */
class StartStopButtonBar extends StatefulWidget {
  final SubStopwatch stopwatch;

  const StartStopButtonBar({Key key, this.stopwatch}) : super(key: key);
  @override
  _StartStopButtonBarState createState() => _StartStopButtonBarState();
}

class _StartStopButtonBarState extends State<StartStopButtonBar> {
  List<Widget> _buttonBarList = [];

  @override
  Widget build(BuildContext context) {
    return ButtonBar(mainAxisSize: MainAxisSize.min, children: _buttonBarList);
  }

  @override
  void initState() {
    super.initState();
    onReset();
  }

  onPressingStart() {
    widget.stopwatch.start();
    onRunning();
  }

  onPressingPause() {
    widget.stopwatch.stop();
    onPaused();
  }

  onPressingStop() {
    widget.stopwatch.reset();
    onReset();
  }

  /* When stopwatch is stopped the app must shows only the start button */
  onReset() {
    _buttonBarList = [
      IconButton(
          icon: Icon(Icons.play_circle_filled_rounded),
          onPressed: () => {onPressingStart()}),
    ];
  }

  onRunning() {
    _buttonBarList = [
      IconButton(
          icon: Icon(Icons.pause_circle_filled_rounded),
          onPressed: () => {onPressingPause()})
    ];
  }

  onPaused() {
    _buttonBarList = [
      IconButton(
          icon: Icon(Icons.play_circle_filled_rounded),
          onPressed: () => {onPressingStart()}),
      IconButton(
          icon: Icon(Icons.stop_circle), onPressed: () => {onPressingStop()})
    ];
  }
}
