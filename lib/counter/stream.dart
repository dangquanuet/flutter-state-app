import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// provider sample
class StreamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamPage(),
    );
  }
}

class StreamPage extends StatelessWidget {
  final StreamModel streamModel = StreamModel();

  @override
  Widget build(BuildContext context) {
    print("Scaffold");
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () => streamModel.decreaseCounter(),
            child: StreamBuilder<int>(
              stream: streamModel.stream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                print("Streambuilder ${snapshot.data.toString()}");
                return Text(
                  snapshot.data.toString(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                );
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => streamModel.increaseCounter(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class StreamModel {
  StreamModel() {
    stream = streamController.stream;
    _getCounter();
  }

  static const COUNTER_KEY = "COUNTER";
  StreamController streamController = StreamController<int>();
  Stream stream;
  int count;

  _getCounter() async {
    SharedPreferences.getInstance().then(
          (value) {
        final countValue = value.getInt(COUNTER_KEY);
        if (countValue != null) {
          count = countValue;
        } else {
          count = 0;
        }
        streamController.add(count);
      },
    );
  }

  increaseCounter() {
    count++;
    streamController.add(count);
    SharedPreferences.getInstance().then(
          (value) {
        value.setInt(COUNTER_KEY, count);
      },
    );
  }

  decreaseCounter() {
    count--;
    streamController.add(count);
    SharedPreferences.getInstance().then(
          (value) {
        value.setInt(COUNTER_KEY, count);
      },
    );
  }
}
