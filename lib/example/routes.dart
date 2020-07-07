import 'package:flutter/material.dart';

class User{
  String id;
  String name;
}

void main() {
  runApp(MyApp());
}

class Routes {
  static final String screen1 = "/screen1";
  static final String screen2 = "/screen2";
  static final String screen3 = "/screen3";
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Screen1(),
      ),
      routes: {
        Routes.screen1: (context) => Screen1(),
        Routes.screen2: (context) => Screen2(),
        Routes.screen3: (context) => Screen3(),
      },
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () async {
            Navigator.of(context).pushNamed(Routes.screen2);
          },
          child: Text(
            "screen 1",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
//            Navigator.pop(context);
            Navigator.of(context).pop();
          },
          child: Text(
            "screen 2",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "screen 3",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
