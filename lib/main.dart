import 'dart:async';
import 'package:flutter/material.dart';

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
      child: Text("Buongiorno all'allarme"),
    );
  }
}

class ChronometerTab extends StatefulWidget {
  @override
  _ChronometerTabState createState() => _ChronometerTabState();
}

class _ChronometerTabState extends State<ChronometerTab> {
  String _elapsed;
  var stopwatch = new Stopwatch();

  @override
  void initState() {
    super.initState();

    // sets first value
    _elapsed = stopwatch.elapsed.toString();

    // defines a timer
    Timer _everySecond = Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      setState(() {
        _elapsed = stopwatch.elapsed.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    stopwatch.start();
    return Center(
      child: Text(_elapsed),
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
      child: Text("Buongiorno al timer"),
    );
  }
}
