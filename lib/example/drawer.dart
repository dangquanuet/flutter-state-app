import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getInts().listen(
      (event) {
        print('Quan $event');
      },
    );
    return CupertinoPageScaffold(
      child: Container(
        color: Colors.green,
        alignment: Alignment(0.0, -1.0),
        child: Center(
          child: Text('123'),
        ),
      ),
    );
  }

  Stream<int> getInts() async* {
    yield 1;
    await Future.delayed(Duration(seconds: 1));
    yield 2;
    await Future.delayed(Duration(seconds: 2));
    yield 3;
  }

  CupertinoButton buildCupertinoButton(BuildContext context) {
    return CupertinoButton(
      color: Colors.cyan,
      child: Text('Click'),
      onPressed: () {
        showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(
                'Title',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              content: Text('content'),
              actions: [
                CupertinoDialogAction(
                  child: Text('action 1'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

final controller = StreamController<int>();

final stream = controller.stream;

doSomething() {
  controller.sink.add(1);
  controller.add(1);
}

fun() {
  Future.delayed(Duration(seconds: 1));
}

Future<void> fun2() async {
  await Future.delayed(Duration(seconds: 1));
}
