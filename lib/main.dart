import 'package:flutter/material.dart';
import 'dart:async';
import 'StopwatchButtonBar.dart';
import 'CustomDuration.dart';
import 'CustomStopwatch.dart';

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
  var stopwatch = new CustomStopwatch();
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
            child: StopwatchButtonBar(
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
  CustomStopwatch timer;
  String _remaining;

  /* onStart() {
    timer = new SubStopwatch.timer(countdown: Duration(minutes: 25));
  }
 */
  @override
  void initState() {
    super.initState();
    timer = new CustomStopwatch.timer(countdown: CustomDuration(minutes: 25));

    // sets first value
    _remaining = timer.remaining.toStringUntilSeconds();

    /* Every 1 ms, the _elapsed content is refreshed according to 
    * stopwatch value */
    Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          _remaining = timer.remaining.toStringUntilSeconds();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
              child: Center(
                  child: Text(_remaining, style: TextStyle(fontSize: 30)))),
          Center(
              child: StopwatchButtonBar(
            stopwatch: timer,
          ))
        ],
      ),
    );
  }
}
