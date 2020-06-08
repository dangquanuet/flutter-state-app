import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterstateapp/timer/bloc.dart';

class UserActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButton(
        timerBLoc: BlocProvider.of<TimerBLoc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionButton({
    TimerBLoc timerBLoc,
  }) {
    final TimerState currentState = timerBLoc.state;
    if (currentState is Ready) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBLoc.add(
            Start(duration: currentState.duration),
          ),
        )
      ];
    }

    if (currentState is Running) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBLoc.add(
            Pause(),
          ),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBLoc.add(
            Reset(),
          ),
        ),
      ];
    }

    if (currentState is Paused) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBLoc.add(
            Resume(),
          ),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBLoc.add(
            Reset(),
          ),
        )
      ];
    }

    if (currentState is Finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBLoc.add(
            Reset(),
          ),
        ),
      ];
    }

    return [];
  }
}
