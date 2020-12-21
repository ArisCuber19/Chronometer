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
        home: MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Alarm',
      style: optionStyle,
    ),
    ChronometerTab(),
    TimerTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 22,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                label: 'Alarm',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Chronometer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hourglass_bottom),
                label: 'Timer',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFF9544E7),
            onTap: _onItemTapped,
          ),
        ));
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
