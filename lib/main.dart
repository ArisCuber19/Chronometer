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
              Alarm(),
              Chronometer(),
              Clock(),
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

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("Buongiorno all'allarme"),
    );
  }
}

class Chronometer extends StatefulWidget {
  @override
  _ChronometerState createState() => _ChronometerState();
}

class _ChronometerState extends State<Chronometer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("Buongiorno al cronometro"),
    );
  }
}

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("Buongiorno al timer"),
    );
  }
}
