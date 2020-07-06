import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterstateapp/timer/actions.dart';
import 'package:flutterstateapp/timer/background.dart';
import 'package:flutterstateapp/timer/bloc.dart';
import 'package:flutterstateapp/timer/ticker.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(189, 234, 255, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      title: "Flutter Timer",
      home: BlocProvider(
        create: (context) => TimerBLoc(ticker: Ticker()),
        child: Timer(),
      ),
    );
  }
}

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle =
      TextStyle(fontSize: 60, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Timer"),
      ),
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: BlocBuilder<TimerBLoc, TimerState>(
                    builder: (context, state) {
                      final String minuteStr = ((state.duration / 60) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');

                      final String secondStr = (state.duration % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      return Text(
                        "$minuteStr:$secondStr",
                        style: Timer.timerTextStyle,
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<TimerBLoc, TimerState>(
                buildWhen: (previousState, state) =>
                    state.runtimeType != previousState.runtimeType,
                builder: (context, state) => UserActions(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
