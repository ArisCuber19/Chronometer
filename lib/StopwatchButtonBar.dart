import 'package:flutter/material.dart';
import 'CustomStopwatch.dart';

/* Defining new StatefulWidget class which renders different buttons in the buttonBar according to 
* stopwatch state */
class StopwatchButtonBar extends StatefulWidget {
  final CustomStopwatch stopwatch;

  const StopwatchButtonBar({Key key, this.stopwatch}) : super(key: key);
  @override
  _StopwatchButtonBarState createState() => _StopwatchButtonBarState();
}

class _StopwatchButtonBarState extends State<StopwatchButtonBar> {
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
